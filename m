Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3112BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8A024125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjrxzNQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgAWKfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:35:16 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34140 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWKfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:35:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id z22so2742124ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 02:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=OtuF8e2JllKM9YWQyapgL8K2EUjswAN0ixMt0EKsA2w=;
        b=TjrxzNQXPidhnIaowjUiqwaorO9DDXn9zSfk6lwiwZi6l4ALu6IJGBqwfBUBRJrHKK
         opZ3NblzpUAEMeIVN/40D3oLXd00rBwlWSS/6xjkDbOicLpRjidDisLJEfhEXOQKiLRN
         O3sNeTYy2VQw9sa+ZCazk+DVRgPWFRWLoyqSFULmFGKQg+rjY7h0JGmWcEJZjOT96BXN
         tV9srGEa6NRYln2/5nWXOUfeXsomtiHZls0CqBrG/YfZBnYnvhmudYgCOoZnWE4DElJy
         IfwswmwSPvPBbTJOrAIsW87VV87FFIKWiW1I76Rvc526zsG6hJkHSvpZHkdPRiRxlgsz
         xVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=OtuF8e2JllKM9YWQyapgL8K2EUjswAN0ixMt0EKsA2w=;
        b=uZTEf6M/4vTh5Y33bxwuVmCfmrIOKRifvySR3RMvte4QncjUPU8igSdqIC8zod1Net
         4M3LTa0c/APl/W9VFwmGTfFzp2BrdUFBDjhqm5qrCdqAzJcEBv3rZLzLfGnX8scGcRxI
         /2HcUbS3J4QHLHnmN0EWqEGCGs9NzRmkIy+hiiLe55g9weFzJo1rCYW922yr4q6Xa9dX
         gdGxdtHBmVIrmQJI4F1G6baFl6rsWNY183Yunvm95S+XXjWXRgDDI81aF/MqUDTqTtyj
         IUDxHv20hQoBNpUPs/k++MGEo3L3DeqyZFjiY2AGed3qWPlHAmzF4gt0EsC0V/s8gifZ
         Bh+g==
X-Gm-Message-State: APjAAAUIPq+rm78noXHSNZbuU+vkN95S1Ox34rqpsiVdT8aWrvuGpdcd
        0goYNtKue5sVcXqXU/ONOusMPLE6
X-Google-Smtp-Source: APXvYqzc/QYyxWljotNP11BEB6iUs0hqeTdW2jHv/FqBTWob4xIimcd+uMnrHjMZjhRvsnTiELir+A==
X-Received: by 2002:a2e:978d:: with SMTP id y13mr22857523lji.103.1579775712226;
        Thu, 23 Jan 2020 02:35:12 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id o12sm941448ljj.79.2020.01.23.02.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 02:35:11 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v3] firmware_loader: load files from the mount namespace of
 init
Message-ID: <4265c7f3-851d-25ab-414d-aeb3cc37e214@gmail.com>
Date:   Thu, 23 Jan 2020 12:35:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have an experimental setup where almost every possible system
service (even early startup ones) runs in separate namespace, using a
dedicated, minimal file system. In process of minimizing the contents
of the file systems with regards to modules and firmware files, I
noticed that in my system, the firmware files are loaded from three
different mount namespaces, those of systemd-udevd, init and
systemd-networkd. The logic of the source namespace is not very clear,
it seems to depend on the driver, but the namespace of the current
process is used.

So, this patch tries to make things a bit clearer and changes the
loading of firmware files only from the mount namespace of init. This
may also improve security, though I think that using firmware files as
attack vector could be too impractical anyway.

Later, it might make sense to make the mount namespace configurable,
for example with a new file in /proc/sys/kernel/firmware_config/. That
would allow a dedicated file system only for firmware files and those
need not be present anywhere else. This configurability would make
more sense if made also for kernel modules and /sbin/modprobe. Modules
are already loaded from init namespace (usermodehelper uses kthreadd
namespace) except when directly loaded by systemd-udevd.

Instead of using the mount namespace of the current process to load
firmware files, use the mount namespace of init process.

Link:
https://lore.kernel.org/lkml/bb46ebae-4746-90d9-ec5b-fce4c9328c86@gmail.com/
Link: 
https://lore.kernel.org/lkml/0e3f7653-c59d-9341-9db2-c88f5b988c68@gmail.com/
Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
Changelog:
v1->v2: added selfests
v2->v3: added comments, don't assume writable /lib/firmware
---
  drivers/base/firmware_loader/main.c           |   6 +-
  fs/exec.c                                     |  26 +++
  include/linux/fs.h                            |   2 +
  tools/testing/selftests/firmware/Makefile     |   9 +-
  .../testing/selftests/firmware/fw_namespace.c | 151 ++++++++++++++++++
  .../selftests/firmware/fw_run_tests.sh        |   4 +
  6 files changed, 190 insertions(+), 8 deletions(-)
  create mode 100644 tools/testing/selftests/firmware/fw_namespace.c

diff --git a/drivers/base/firmware_loader/main.c 
b/drivers/base/firmware_loader/main.c
index 249add8c5e05..01f5315fae53 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -493,8 +493,10 @@ fw_get_filesystem_firmware(struct device *device, 
struct fw_priv *fw_priv,
                 }

                 fw_priv->size = 0;
-               rc = kernel_read_file_from_path(path, &buffer, &size,
-                                               msize, id);
+
+               /* load firmware files from the mount namespace of init */
+               rc = kernel_read_file_from_path_initns(path, &buffer,
+                                                      &size, msize, id);
                 if (rc) {
                         if (rc != -ENOENT)
                                 dev_warn(device, "loading %s failed 
with error %d\n",
diff --git a/fs/exec.c b/fs/exec.c
index 74d88dab98dd..d6558a5c1ea3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -981,6 +981,32 @@ int kernel_read_file_from_path(const char *path, 
void **buf, loff_t *size,
  }
  EXPORT_SYMBOL_GPL(kernel_read_file_from_path);

+int kernel_read_file_from_path_initns(const char *path, void **buf,
+                                     loff_t *size, loff_t max_size,
+                                     enum kernel_read_file_id id)
+{
+       struct file *file;
+       struct path root;
+       int ret;
+
+       if (!path || !*path)
+               return -EINVAL;
+
+       task_lock(&init_task);
+       get_fs_root(init_task.fs, &root);
+       task_unlock(&init_task);
+
+       file = file_open_root(root.dentry, root.mnt, path, O_RDONLY, 0);
+       path_put(&root);
+       if (IS_ERR(file))
+               return PTR_ERR(file);
+
+       ret = kernel_read_file(file, buf, size, max_size, id);
+       fput(file);
+       return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
+
  int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t 
max_size,
                              enum kernel_read_file_id id)
  {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..616a64871b2e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2994,6 +2994,8 @@ extern int kernel_read_file(struct file *, void 
**, loff_t *, loff_t,
                             enum kernel_read_file_id);
  extern int kernel_read_file_from_path(const char *, void **, loff_t *, 
loff_t,
                                       enum kernel_read_file_id);
+extern int kernel_read_file_from_path_initns(const char *, void **, 
loff_t *, loff_t,
+                                            enum kernel_read_file_id);
  extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
                                     enum kernel_read_file_id);
  extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
diff --git a/tools/testing/selftests/firmware/Makefile 
b/tools/testing/selftests/firmware/Makefile
index 012b2cf69c11..40211cd8f0e6 100644
--- a/tools/testing/selftests/firmware/Makefile
+++ b/tools/testing/selftests/firmware/Makefile
@@ -1,13 +1,10 @@
  # SPDX-License-Identifier: GPL-2.0-only
  # Makefile for firmware loading selftests
-
-# No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
-all:
+CFLAGS = -Wall \
+         -O2

  TEST_PROGS := fw_run_tests.sh
  TEST_FILES := fw_fallback.sh fw_filesystem.sh fw_lib.sh
+TEST_GEN_FILES := fw_namespace

  include ../lib.mk
-
-# Nothing to clean up.
-clean:
diff --git a/tools/testing/selftests/firmware/fw_namespace.c 
b/tools/testing/selftests/firmware/fw_namespace.c
new file mode 100644
index 000000000000..5ebc1aec7923
--- /dev/null
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Test triggering of loading of firmware from different mount
+ * namespaces. Expect firmware to be always loaded from the mount
+ * namespace of PID 1. */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#ifndef CLONE_NEWNS
+# define CLONE_NEWNS 0x00020000
+#endif
+
+static char *fw_path = NULL;
+
+static void die(char *fmt, ...)
+{
+       va_list ap;
+
+       va_start(ap, fmt);
+       vfprintf(stderr, fmt, ap);
+       va_end(ap);
+       if (fw_path)
+               unlink(fw_path);
+       umount("/lib/firmware");
+       exit(EXIT_FAILURE);
+}
+
+static void trigger_fw(const char *fw_name, const char *sys_path)
+{
+       int fd;
+
+       fd = open(sys_path, O_WRONLY);
+       if (fd < 0)
+               die("open failed: %s\n",
+                   strerror(errno));
+       if (write(fd, fw_name, strlen(fw_name)) != strlen(fw_name))
+               exit(EXIT_FAILURE);
+       close(fd);
+}
+
+static void setup_fw(const char *fw_path)
+{
+       int fd;
+       const char fw[] = "ABCD0123";
+
+       fd = open(fw_path, O_WRONLY | O_CREAT, 0600);
+       if (fd < 0)
+               die("open failed: %s\n",
+                   strerror(errno));
+       if (write(fd, fw, sizeof(fw) -1) != sizeof(fw) -1)
+               die("write failed: %s\n",
+                   strerror(errno));
+       close(fd);
+}
+
+static bool test_fw_in_ns(const char *fw_name, const char *sys_path, 
bool block_fw_in_parent_ns)
+{
+       pid_t child;
+
+       if (block_fw_in_parent_ns)
+               if (mount("test", "/lib/firmware", "tmpfs", MS_RDONLY, 
NULL) == -1)
+                       die("blocking firmware in parent ns failed\n");
+
+       child = fork();
+       if (child == -1) {
+               die("fork failed: %s\n",
+                       strerror(errno));
+       }
+       if (child != 0) { /* parent */
+               pid_t pid;
+               int status;
+
+               pid = waitpid(child, &status, 0);
+               if (pid == -1) {
+                       die("waitpid failed: %s\n",
+                               strerror(errno));
+               }
+               if (pid != child) {
+                       die("waited for %d got %d\n",
+                               child, pid);
+               }
+               if (!WIFEXITED(status)) {
+                       die("child did not terminate cleanly\n");
+               }
+               if (block_fw_in_parent_ns)
+                       umount("/lib/firmware");
+               return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
+       }
+
+       if (unshare(CLONE_NEWNS) != 0) {
+               die("unshare(CLONE_NEWNS) failed: %s\n",
+                       strerror(errno));
+       }
+       if (mount(NULL, "/", NULL, MS_SLAVE|MS_REC, NULL) == -1)
+               die("remount root in child ns failed\n");
+
+       if (!block_fw_in_parent_ns) {
+               if (mount("test", "/lib/firmware", "tmpfs", MS_RDONLY, 
NULL) == -1)
+                       die("blocking firmware in child ns failed\n");
+       } else
+               umount("/lib/firmware");
+
+       trigger_fw(fw_name, sys_path);
+
+       exit(EXIT_SUCCESS);
+}
+
+int main(int argc, char **argv)
+{
+       const char *fw_name = "test-firmware.bin";
+       char *sys_path;
+       if (argc != 2)
+               die("usage: %s sys_path\n", argv[0]);
+
+       /* Mount tmpfs to /lib/firmware so we don't have to assume
+          that it is writable for us.*/
+       if (mount("test", "/lib/firmware", "tmpfs", 0, NULL) == -1)
+               die("mounting tmpfs to /lib/firmware failed\n");
+
+       sys_path = argv[1];
+       asprintf(&fw_path, "/lib/firmware/%s", fw_name);
+
+       setup_fw(fw_path);
+
+       setvbuf(stdout, NULL, _IONBF, 0);
+       /* Positive case: firmware in PID1 mount namespace */
+       printf("Testing with firmware in parent namespace (assumed to be 
same file system as PID1)\n");
+       if (!test_fw_in_ns(fw_name, sys_path, false))
+               die("error: failed to access firmware\n");
+
+       /* Negative case: firmware in child mount namespace, expected to 
fail */
+       printf("Testing with firmware in child namespace\n");
+       if (test_fw_in_ns(fw_name, sys_path, true))
+               die("error: firmware access did not fail\n");
+
+       unlink(fw_path);
+       free(fw_path);
+       umount("/lib/firmware");
+       exit(EXIT_SUCCESS);
+}
diff --git a/tools/testing/selftests/firmware/fw_run_tests.sh 
b/tools/testing/selftests/firmware/fw_run_tests.sh
index 8e14d555c197..777377078d5e 100755
--- a/tools/testing/selftests/firmware/fw_run_tests.sh
+++ b/tools/testing/selftests/firmware/fw_run_tests.sh
@@ -61,6 +61,10 @@ run_test_config_0003()
  check_mods
  check_setup

+echo "Running namespace test: "
+$TEST_DIR/fw_namespace $DIR/trigger_request
+echo "OK"
+
  if [ -f $FW_FORCE_SYSFS_FALLBACK ]; then
         run_test_config_0001
         run_test_config_0002
-- 
2.24.1
