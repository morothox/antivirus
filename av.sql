CREATE TABLE IF NOT EXISTS hashes (
  hash_id INTEGER PRIMARY KEY AUTOINCREMENT,
  hash TEXT NOT NULL,
  document TEXT NOT NULL
);

INSERT INTO hashes (hash,document) VALUES
('75f48c9b50d38eec34db0a8cc1684dbc1671941acc3ee53be9e3d4eafa779a22','Docxvirus'),
('3966b6767d369286e32f51d05ad9279fc746ea001afc42309b2e0767751ab837','Emailvirus');


CREATE TABLE IF NOT EXISTS groups (
  group_id INTEGER PRIMARY KEY AUTOINCREMENT,
  name     TEXT NOT NULL UNIQUE,
  danger   TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS apis (
  api_id   INTEGER PRIMARY KEY AUTOINCREMENT,
  group_id INTEGER NOT NULL,
  api_name TEXT NOT NULL,
  FOREIGN KEY (group_id) REFERENCES groups(group_id)
);

INSERT OR IGNORE INTO groups (name, danger) VALUES
  ('gui',                 'low'),
  ('registry',            'moderate'),
  ('file_ops',            'low'),
  ('process_ops',         'moderate'),
  ('thread_ops',          'moderate'),
  ('network',             'moderate'),
  ('persistence_registry','high'),
  ('memory',              'moderate'),
  ('remote_thread',       'high'),
  ('process_hollowing',   'high'),
  ('services',            'high'),
  ('privileges',          'high'),
  ('anti_analysis',       'high'),
  ('beaconing',           'high');

INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'MessageBoxW' FROM groups WHERE name = 'gui';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'ShowWindow' FROM groups WHERE name = 'gui';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'GetMessageW' FROM groups WHERE name = 'gui';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'DispatchMessageW' FROM groups WHERE name = 'gui';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'CreateDialogParamW' FROM groups WHERE name = 'gui';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'SendMessageW' FROM groups WHERE name = 'gui';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'CoInitialize' FROM groups WHERE name = 'gui';

INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'RegCreateKeyExW' FROM groups WHERE name = 'registry';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'RegSetValueExW' FROM groups WHERE name = 'registry';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'RegOpenKeyExW' FROM groups WHERE name = 'registry';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'RegCloseKey' FROM groups WHERE name = 'registry';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'RegQueryValueExW' FROM groups WHERE name = 'registry';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'RegDeleteKeyW' FROM groups WHERE name = 'registry';

INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'CreateFileW' FROM groups WHERE name = 'file_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'ReadFile' FROM groups WHERE name = 'file_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'WriteFile' FROM groups WHERE name = 'file_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'DeleteFileW' FROM groups WHERE name = 'file_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'MoveFileExW' FROM groups WHERE name = 'file_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'CopyFileW' FROM groups WHERE name = 'file_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'GetFileSize' FROM groups WHERE name = 'file_ops';

INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'CreateProcessW' FROM groups WHERE name = 'process_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'OpenProcess' FROM groups WHERE name = 'process_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'TerminateProcess' FROM groups WHERE name = 'process_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'GetCurrentProcess' FROM groups WHERE name = 'process_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'GetExitCodeProcess' FROM groups WHERE name = 'process_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'WaitForSingleObject' FROM groups WHERE name = 'process_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'CloseHandle' FROM groups WHERE name = 'process_ops';

INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'CreateThread' FROM groups WHERE name = 'thread_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'OpenThread' FROM groups WHERE name = 'thread_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'SuspendThread' FROM groups WHERE name = 'thread_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'ResumeThread' FROM groups WHERE name = 'thread_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'GetThreadContext' FROM groups WHERE name = 'thread_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'SetThreadContext' FROM groups WHERE name = 'thread_ops';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'TerminateThread' FROM groups WHERE name = 'thread_ops';

INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'InternetOpenW' FROM groups WHERE name = 'network';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'InternetConnectW' FROM groups WHERE name = 'network';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'HttpOpenRequestW' FROM groups WHERE name = 'network';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'HttpSendRequestW' FROM groups WHERE name = 'network';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'InternetReadFile' FROM groups WHERE name = 'network';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'recv' FROM groups WHERE name = 'network';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'send' FROM groups WHERE name = 'network';

INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'RegCreateKeyExW' FROM groups WHERE name = 'persistence_registry';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'RegSetValueExW' FROM groups WHERE name = 'persistence_registry';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'RegOpenKeyExW' FROM groups WHERE name = 'persistence_registry';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'RegDeleteKeyW' FROM groups WHERE name = 'persistence_registry';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'SHGetFolderPathW' FROM groups WHERE name = 'persistence_registry';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'GetStartupInfoW' FROM groups WHERE name = 'persistence_registry';

INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'VirtualAlloc' FROM groups WHERE name = 'memory';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'VirtualProtect' FROM groups WHERE name = 'memory';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'VirtualFree' FROM groups WHERE name = 'memory';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'HeapAlloc' FROM groups WHERE name = 'memory';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'HeapFree' FROM groups WHERE name = 'memory';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'ReadProcessMemory' FROM groups WHERE name = 'memory';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'WriteProcessMemory' FROM groups WHERE name = 'memory';

INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'OpenProcess' FROM groups WHERE name = 'remote_thread';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'VirtualAllocEx' FROM groups WHERE name = 'remote_thread';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'WriteProcessMemory' FROM groups WHERE name = 'remote_thread';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'CreateRemoteThread' FROM groups WHERE name = 'remote_thread';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'NtCreateThreadEx' FROM groups WHERE name = 'remote_thread';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'QueueUserAPC' FROM groups WHERE name = 'remote_thread';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'SetThreadContext' FROM groups WHERE name = 'remote_thread';

INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'CreateProcessW' FROM groups WHERE name = 'process_hollowing';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'NtUnmapViewOfSection' FROM groups WHERE name = 'process_hollowing';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'VirtualAllocEx' FROM groups WHERE name = 'process_hollowing';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'WriteProcessMemory' FROM groups WHERE name = 'process_hollowing';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'SetThreadContext' FROM groups WHERE name = 'process_hollowing';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'ResumeThread' FROM groups WHERE name = 'process_hollowing';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'GetThreadContext' FROM groups WHERE name = 'process_hollowing';

INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'OpenSCManagerW' FROM groups WHERE name = 'services';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'CreateServiceW' FROM groups WHERE name = 'services';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'OpenServiceW' FROM groups WHERE name = 'services';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'StartServiceW' FROM groups WHERE name = 'services';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'ChangeServiceConfigW' FROM groups WHERE name = 'services';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'DeleteService' FROM groups WHERE name = 'services';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'ControlService' FROM groups WHERE name = 'services';

INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'OpenProcessToken' FROM groups WHERE name = 'privileges';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'LookupPrivilegeValueW' FROM groups WHERE name = 'privileges';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'AdjustTokenPrivileges' FROM groups WHERE name = 'privileges';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'DuplicateTokenEx' FROM groups WHERE name = 'privileges';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'ImpersonateLoggedOnUser' FROM groups WHERE name = 'privileges';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'SetTokenInformation' FROM groups WHERE name = 'privileges';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'GetTokenInformation' FROM groups WHERE name = 'privileges';

INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'IsDebuggerPresent' FROM groups WHERE name = 'anti_analysis';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'CheckRemoteDebuggerPresent' FROM groups WHERE name = 'anti_analysis';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'OutputDebugStringA' FROM groups WHERE name = 'anti_analysis';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'QueryPerformanceCounter' FROM groups WHERE name = 'anti_analysis';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'GetTickCount' FROM groups WHERE name = 'anti_analysis';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'Sleep' FROM groups WHERE name = 'anti_analysis';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'NtQueryInformationProcess' FROM groups WHERE name = 'anti_analysis';

INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'InternetOpenW' FROM groups WHERE name = 'beaconing';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'InternetConnectW' FROM groups WHERE name = 'beaconing';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'HttpOpenRequestW' FROM groups WHERE name = 'beaconing';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'HttpSendRequestW' FROM groups WHERE name = 'beaconing';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'InternetReadFile' FROM groups WHERE name = 'beaconing';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'connect' FROM groups WHERE name = 'beaconing';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'recv' FROM groups WHERE name = 'beaconing';
INSERT OR IGNORE INTO apis (group_id, api_name)
SELECT group_id, 'send' FROM groups WHERE name = 'beaconing';
