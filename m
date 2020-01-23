Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204C5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D496C24125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSxax0PN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgAWM6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:58:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35869 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgAWM6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:58:54 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so3260135ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 04:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ScTK9nZ3VMQ6sEeTWWBpMP1wxSurlQuuyJk8fMfHfa0=;
        b=KSxax0PN39LL6IMbRDsuIbid4/5OQ03YUDlBkoKjUM7cr3RYmS1ctn1ehqc4olVilm
         mE3a5IFkVKM4F16z+at4SO91+FsUkTMJqpFJcV2n2PZamk4KsyNWyXCha9gz4NRq31PO
         8oV4aV51/iX4hore908/vii1din2GqEBUutlnwXaobakd6QnqTeDJpz1skpYA5e8sDu1
         3e388ZZC5Kwp0Fkdrk8a8TmdM8xB9SDsq6Z8PNgJzHcjK4OmeJttoolzeOijVWZkI99+
         XBoQDNId9iaFVVOJU3G5qzCGlxvGy2ukX6E6jRM/AYpRAFJPl4RAT+Rbzs358EsRF6Bf
         F6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ScTK9nZ3VMQ6sEeTWWBpMP1wxSurlQuuyJk8fMfHfa0=;
        b=O66xQQQJPk1SEFx08iEDaeo7njju4TeRr+Ss0LXHmijjQ0UW5GBFvPO5UZ3BElpCys
         tPheYdx1mNb9MxmK0fvEmLXGFsiBUY09qYMsAISnyug1sIt13lRUVb/mQ01TKdjd/jaO
         mWdB5QraJhstbmiAKOulND9eV+C9z8QJtnAaOKh/MssKIC9v11cnDtfWJvECBZJ5CONl
         dRUUD2Qt3bRuDJXIEddDFSRve3onkU8r2El8rtYBEYmF8arEYfoMHpkgZqiB71thgx0H
         pOcePOwCnPwzvENluCVfG0uYr9vmk5OjmzqWl5eFbAq5+iPplhoRiOpFK2QFftIp3h5H
         Dh1g==
X-Gm-Message-State: APjAAAXsuEwML4nAv/KunYMKPpQJL72EaXW2NcZyI1FoUpVpoOjiJdeQ
        259T5HXQWw4yyF5nJYZ4/8g=
X-Google-Smtp-Source: APXvYqyuabMqlBk2uX/zzm7P3XZ9vyTrsTmuobgkK8swDd2y5I84cz5ZJlAWALP3iNzgS089EzYsPQ==
X-Received: by 2002:a05:651c:1077:: with SMTP id y23mr23222985ljm.79.1579784331353;
        Thu, 23 Jan 2020 04:58:51 -0800 (PST)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id i17sm1208497ljd.34.2020.01.23.04.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 04:58:50 -0800 (PST)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     gregkh@linuxfoundation.org, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v3 RESEND] firmware_loader: load files from the mount namespace of init
Date:   Thu, 23 Jan 2020 14:58:38 +0200
Message-Id: <20200123125839.37168-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Link: https://lore.kernel.org/lkml/0e3f7653-c59d-9341-9db2-c88f5b988c68@gmail.com/
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
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	if (fw_path)
+		unlink(fw_path);
+	umount("/lib/firmware");
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
+	/* Mount tmpfs to /lib/firmware so we don't have to assume
+	   that it is writable for us.*/
+	if (mount("test", "/lib/firmware", "tmpfs", 0, NULL) == -1)
+		die("mounting tmpfs to /lib/firmware failed\n");
+
+	sys_path = argv[1];
+	asprintf(&fw_path, "/lib/firmware/%s", fw_name);
+
+	setup_fw(fw_path);
+
+	setvbuf(stdout, NULL, _IONBF, 0);
+	/* Positive case: firmware in PID1 mount namespace */
+	printf("Testing with firmware in parent namespace (assumed to be same file system as PID1)\n");
+	if (!test_fw_in_ns(fw_name, sys_path, false))
+		die("error: failed to access firmware\n");
+
+	/* Negative case: firmware in child mount namespace, expected to fail */
+	printf("Testing with firmware in child namespace\n");
+	if (test_fw_in_ns(fw_name, sys_path, true))
+		die("error: firmware access did not fail\n");
+
+	unlink(fw_path);
+	free(fw_path);
+	umount("/lib/firmware");
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

