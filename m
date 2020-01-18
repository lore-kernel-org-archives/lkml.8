Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F9DC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 16:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963682469A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 16:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF2sLeF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgARQDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 11:03:36 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:37745 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgARQDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 11:03:36 -0500
Received: by mail-lj1-f181.google.com with SMTP id o13so29542723ljg.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 08:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version;
        bh=yKAsLALgTBbcD9fieqFQowKYzPpEBhT8bhUPGeOo5pY=;
        b=dF2sLeF/S+CSeCB9huQjPk++CXmFS9E3HtaZk0+Z+vT6HihuniDJU+xL2JVqdRpH82
         nAvtWl5XHRcZNG4aZLbjQPnub5are4wbLmHp+07mzuJxOaLsHci9Ts8k812Aevuy+YVL
         1Ney0zjAyEqcqEJHzre7zfpZYEtoeQJRqMjc6IWqq+bp9JlrpQpZkSdnm30o9oes4mWn
         879iluhpXzciPLCTxMuiMbjJ66dKPZay8rf9gdS/phO5vzCHhK0T0jf+DstTm8YCIIYK
         HPeOaoCT9I57gmdwntWyAE/0HDyqxng7094cGz2oP3OqptXfA1ClcrVz6CEzXXbUEp54
         bqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version;
        bh=yKAsLALgTBbcD9fieqFQowKYzPpEBhT8bhUPGeOo5pY=;
        b=e1flB7jk6vMb7XJTfJDZQeQLDYjI+WqJKX7zsRt+G9KwgAnB9rxjkaFXiKoM0lgIEi
         rTsuDHGfS3D2RgiH/PvLHXxLps16tJkweVuLzkBh3uXUPFkXxLeE7NCKRFKAHxlK4/R4
         dIYbg8NSt5HZeSBMG+LLlbEvO/n14cd/mubLXOijfcxokunDfo41z5tB+i16J7o6u5gm
         vOWBJ9B68HHjCL0GLND03drc9+qcQ93VmhUIOy0zpYhb5NAGxsi0baReEhF5fWbD/wNE
         YhStVklyLjSRWVC5ExCSKfb1Yr0snyBCfEdWUbWB5WqAMUFfaROxHioWe+Bk6zHkXm5O
         LU5g==
X-Gm-Message-State: APjAAAVBniQQiPq//gHWcvtP0AoRijD2N4Y7JkeiChUeoXmNVuxNvNeA
        CqtC63lWfx/k7jcpB7JlNyy9gngL
X-Google-Smtp-Source: APXvYqzZ8bqa4JjsUFlbeg8sTjQ8fOli67hmHELO6L8pzPTt7YgpZ9GgsvFuh8G6a1k/9VQW8E5nVg==
X-Received: by 2002:a05:651c:2c7:: with SMTP id f7mr8351857ljo.125.1579363413273;
        Sat, 18 Jan 2020 08:03:33 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id q13sm13870452ljm.68.2020.01.18.08.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 08:03:32 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v2] firmware_loader: load files from the mount namespace of
 init
Message-ID: <0e3f7653-c59d-9341-9db2-c88f5b988c68@gmail.com>
Date:   Sat, 18 Jan 2020 18:03:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------8191A8A9FA1F714DBCD82C57"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8191A8A9FA1F714DBCD82C57
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


--------------8191A8A9FA1F714DBCD82C57
Content-Type: text/x-diff;
 name="0001-firmware_loader-load-files-from-the-mount-namespace-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-firmware_loader-load-files-from-the-mount-namespace-.pa";
 filename*1="tch"

From 0b88ff99acccaefbe9b86b6a1ceebf5b075f388f Mon Sep 17 00:00:00 2001
From: Topi Miettinen <toiwoton@gmail.com>
Date: Fri, 17 Jan 2020 19:56:45 +0200
Subject: [PATCH] firmware_loader: load files from the mount namespace of init

Instead of using the mount namespace of the current process to load
firmware files, use the mount namespace of init process.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 drivers/base/firmware_loader/main.c           |   6 +-
 fs/exec.c                                     |  26 ++++
 include/linux/fs.h                            |   2 +
 tools/testing/selftests/firmware/Makefile     |   9 +-
 .../testing/selftests/firmware/fw_namespace.c | 138 ++++++++++++++++++
 .../selftests/firmware/fw_run_tests.sh        |   4 +
 6 files changed, 177 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/firmware/fw_namespace.c

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 249add8c5e05..01f5315fae53 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -493,8 +493,10 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		}
 
 		fw_priv->size = 0;
-		rc = kernel_read_file_from_path(path, &buffer, &size,
-						msize, id);
+
+		/* load firmware files from the mount namespace of init */
+		rc = kernel_read_file_from_path_initns(path, &buffer,
+						       &size, msize, id);
 		if (rc) {
 			if (rc != -ENOENT)
 				dev_warn(device, "loading %s failed with error %d\n",
diff --git a/fs/exec.c b/fs/exec.c
index 74d88dab98dd..d6558a5c1ea3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -981,6 +981,32 @@ int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
+int kernel_read_file_from_path_initns(const char *path, void **buf,
+				      loff_t *size, loff_t max_size,
+				      enum kernel_read_file_id id)
+{
+	struct file *file;
+	struct path root;
+	int ret;
+
+	if (!path || !*path)
+		return -EINVAL;
+
+	task_lock(&init_task);
+	get_fs_root(init_task.fs, &root);
+	task_unlock(&init_task);
+
+	file = file_open_root(root.dentry, root.mnt, path, O_RDONLY, 0);
+	path_put(&root);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	ret = kernel_read_file(file, buf, size, max_size, id);
+	fput(file);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
+
 int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 			     enum kernel_read_file_id id)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..616a64871b2e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2994,6 +2994,8 @@ extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
 			    enum kernel_read_file_id);
 extern int kernel_read_file_from_path(const char *, void **, loff_t *, loff_t,
 				      enum kernel_read_file_id);
+extern int kernel_read_file_from_path_initns(const char *, void **, loff_t *, loff_t,
+					     enum kernel_read_file_id);
 extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
 				    enum kernel_read_file_id);
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
diff --git a/tools/testing/selftests/firmware/Makefile b/tools/testing/selftests/firmware/Makefile
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
diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
new file mode 100644
index 000000000000..24c368aa2797
--- /dev/null
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
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
+static char *fw_path;
+
+static void die(char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	if (fw_path)
+		unlink(fw_path);
+	exit(EXIT_FAILURE);
+}
+
+static void trigger_fw(const char *fw_name, const char *sys_path)
+{
+	int fd;
+
+	fd = open(sys_path, O_WRONLY);
+	if (fd < 0)
+		die("open failed: %s\n",
+		    strerror(errno));
+	if (write(fd, fw_name, strlen(fw_name)) != strlen(fw_name))
+		exit(EXIT_FAILURE);
+	close(fd);
+}
+
+static void setup_fw(const char *fw_path)
+{
+	int fd;
+	const char fw[] = "ABCD0123";
+
+	fd = open(fw_path, O_WRONLY | O_CREAT, 0600);
+	if (fd < 0)
+		die("open failed: %s\n",
+		    strerror(errno));
+	if (write(fd, fw, sizeof(fw) -1) != sizeof(fw) -1)
+		die("write failed: %s\n",
+		    strerror(errno));
+	close(fd);
+}
+
+static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_fw_in_parent_ns)
+{
+	pid_t child;
+
+	if (block_fw_in_parent_ns)
+		if (mount("test", "/lib/firmware", "tmpfs", MS_RDONLY, NULL) == -1)
+			die("blocking firmware in parent ns failed\n");
+
+	child = fork();
+	if (child == -1) {
+		die("fork failed: %s\n",
+			strerror(errno));
+	}
+	if (child != 0) { /* parent */
+		pid_t pid;
+		int status;
+
+		pid = waitpid(child, &status, 0);
+		if (pid == -1) {
+			die("waitpid failed: %s\n",
+				strerror(errno));
+		}
+		if (pid != child) {
+			die("waited for %d got %d\n",
+				child, pid);
+		}
+		if (!WIFEXITED(status)) {
+			die("child did not terminate cleanly\n");
+		}
+		if (block_fw_in_parent_ns)
+			umount("/lib/firmware");
+		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
+	}
+
+	if (unshare(CLONE_NEWNS) != 0) {
+		die("unshare(CLONE_NEWNS) failed: %s\n",
+			strerror(errno));
+	}
+	if (mount(NULL, "/", NULL, MS_SLAVE|MS_REC, NULL) == -1)
+		die("remount root in child ns failed\n");
+
+	if (!block_fw_in_parent_ns) {
+		if (mount("test", "/lib/firmware", "tmpfs", MS_RDONLY, NULL) == -1)
+			die("blocking firmware in child ns failed\n");
+	} else
+		umount("/lib/firmware");
+
+	trigger_fw(fw_name, sys_path);
+
+	exit(EXIT_SUCCESS);
+}
+
+int main(int argc, char **argv)
+{
+	const char *fw_name = "test-firmware.bin";
+	char *sys_path;
+	if (argc != 2)
+		die("usage: %s sys_path\n", argv[0]);
+
+	sys_path = argv[1];
+	asprintf(&fw_path, "/lib/firmware/%s", fw_name);
+
+	setup_fw(fw_path);
+
+	setvbuf(stdout, NULL, _IONBF, 0);
+	printf("Testing with firmware in parent namespace (assumed to be same file system as PID1)\n");
+	if (!test_fw_in_ns(fw_name, sys_path, false))
+		die("error: failed to access firmware\n");
+
+	printf("Testing with firmware in child namespace\n");
+	if (test_fw_in_ns(fw_name, sys_path, true))
+		die("error: firmware access did not fail\n");
+
+	unlink(fw_path);
+	exit(EXIT_SUCCESS);
+}
diff --git a/tools/testing/selftests/firmware/fw_run_tests.sh b/tools/testing/selftests/firmware/fw_run_tests.sh
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


--------------8191A8A9FA1F714DBCD82C57--
