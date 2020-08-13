Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E982EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 23:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE923207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 23:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E+mt3Kkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHMXRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 19:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHMXRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 19:17:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B3BC061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 16:17:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d4so3480457pjx.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=je3KSpIjI3wvANb9VcFMRGLZNy0cfgXLnoS5OnXYTBM=;
        b=E+mt3KktBCuCw0CsI9AxdLJT/hulhgjpdJnXypAlW5gFncTk1SvR75YudGwrAml8XU
         +NayG/nqwRGS7lRpZUIl0xKi01/jhBSRPNEaa5pd41voyn1oxGEzz4U/GNUno82VmaXd
         uDyA8w1SCHMLF9JlBorNgMqgr9ILbbpM9eTEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=je3KSpIjI3wvANb9VcFMRGLZNy0cfgXLnoS5OnXYTBM=;
        b=L1MO5cQDpFHv+oGGDQh7kz7ONkxPvYblFSRBntdZXW8K1QpPrYW65ombw6rb2FC7SF
         n4cG+wSBdrmr+JcPOIFmzSSHX06C11mJpLTTy4HG1y7dSYuVR477zyFPIsz2yqEypSxg
         OAFD3R1UIUVhI6rLEF5RqBcYLeGhlHmwJc20+D6CUZylzhBUx+CqpgHegWEkbO7+Y3dU
         DbZ2qaX74jVI36GgsQFQag9xWWuAcyQ5Wm02/VYI9LFM//yKL/zrUSoIJXRZBmjy1g/G
         DwJTOwctXwSRNRSrnDsYBA2joGck4RHGS+ykrfwZuKPcRQIdn2J1kUoOs35PkjoTUPUh
         IqKQ==
X-Gm-Message-State: AOAM531B59bL4mMYVflekRcRSEVkS0lSIohwKe+vBfTTMK5mhycPJAVh
        ZnCMhczL5CR5q9v+qDXzu9jcF2Qt8UA=
X-Google-Smtp-Source: ABdhPJwZ++qumA7ue1MbY4n3tjkb6EbPUT2BCumPlbJqhbAx7/TTn5jEEoLTvAX8bjFpFkPYyLsO1w==
X-Received: by 2002:a17:902:9787:: with SMTP id q7mr100868plp.0.1597360652861;
        Thu, 13 Aug 2020 16:17:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e20sm6259211pjr.28.2020.08.13.16.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 16:17:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/exec: Add file type errno tests
Date:   Thu, 13 Aug 2020 16:17:23 -0700
Message-Id: <20200813231723.2725102-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813231723.2725102-1-keescook@chromium.org>
References: <20200813231723.2725102-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure execve() returns the expected errno values for non-regular
files.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/exec/.gitignore    |   1 +
 tools/testing/selftests/exec/Makefile      |   5 +-
 tools/testing/selftests/exec/non-regular.c | 196 +++++++++++++++++++++
 3 files changed, 200 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/exec/non-regular.c

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index 94b02a18f230..344a99c6da1b 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -10,3 +10,4 @@ execveat.denatured
 /recursion-depth
 xxxxxxxx*
 pipe
+S_I*.test
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 4453b8f8def3..0a13b110c1e6 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -3,7 +3,7 @@ CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
-TEST_PROGS := binfmt_script
+TEST_PROGS := binfmt_script non-regular
 TEST_GEN_PROGS := execveat
 TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir pipe
 # Makefile is a run-time dependency, since it's accessed by the execveat test
@@ -11,7 +11,8 @@ TEST_FILES := Makefile
 
 TEST_GEN_PROGS += recursion-depth
 
-EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*
+EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*	\
+	       $(OUTPUT)/S_I*.test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/exec/non-regular.c b/tools/testing/selftests/exec/non-regular.c
new file mode 100755
index 000000000000..cd3a34aca93e
--- /dev/null
+++ b/tools/testing/selftests/exec/non-regular.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include <sys/types.h>
+
+#include "../kselftest_harness.h"
+
+/* Remove a file, ignoring the result if it didn't exist. */
+void rm(struct __test_metadata *_metadata, const char *pathname,
+	int is_dir)
+{
+	int rc;
+
+	if (is_dir)
+		rc = rmdir(pathname);
+	else
+		rc = unlink(pathname);
+
+	if (rc < 0) {
+		ASSERT_EQ(errno, ENOENT) {
+			TH_LOG("Not ENOENT: %s", pathname);
+		}
+	} else {
+		ASSERT_EQ(rc, 0) {
+			TH_LOG("Failed to remove: %s", pathname);
+		}
+	}
+}
+
+FIXTURE(file) {
+	char *pathname;
+	int is_dir;
+};
+
+FIXTURE_VARIANT(file)
+{
+	const char *name;
+	int expected;
+	int is_dir;
+	void (*setup)(struct __test_metadata *_metadata,
+		      FIXTURE_DATA(file) *self,
+		      const FIXTURE_VARIANT(file) *variant);
+	int major, minor, mode; /* for mknod() */
+};
+
+void setup_link(struct __test_metadata *_metadata,
+		FIXTURE_DATA(file) *self,
+		const FIXTURE_VARIANT(file) *variant)
+{
+	const char * const paths[] = {
+		"/bin/true",
+		"/usr/bin/true",
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(paths); i++) {
+		if (access(paths[i], X_OK) == 0) {
+			ASSERT_EQ(symlink(paths[i], self->pathname), 0);
+			return;
+		}
+	}
+	ASSERT_EQ(1, 0) {
+		TH_LOG("Could not find viable 'true' binary");
+	}
+}
+
+FIXTURE_VARIANT_ADD(file, S_IFLNK)
+{
+	.name = "S_IFLNK",
+	.expected = ELOOP,
+	.setup = setup_link,
+};
+
+void setup_dir(struct __test_metadata *_metadata,
+	       FIXTURE_DATA(file) *self,
+	       const FIXTURE_VARIANT(file) *variant)
+{
+	ASSERT_EQ(mkdir(self->pathname, 0755), 0);
+}
+
+FIXTURE_VARIANT_ADD(file, S_IFDIR)
+{
+	.name = "S_IFDIR",
+	.is_dir = 1,
+	.expected = EACCES,
+	.setup = setup_dir,
+};
+
+void setup_node(struct __test_metadata *_metadata,
+		FIXTURE_DATA(file) *self,
+		const FIXTURE_VARIANT(file) *variant)
+{
+	dev_t dev;
+	int rc;
+
+	dev = makedev(variant->major, variant->minor);
+	rc = mknod(self->pathname, 0755 | variant->mode, dev);
+	ASSERT_EQ(rc, 0) {
+		if (errno == EPERM)
+			SKIP(return, "Please run as root; cannot mknod(%s)",
+				variant->name);
+	}
+}
+
+FIXTURE_VARIANT_ADD(file, S_IFBLK)
+{
+	.name = "S_IFBLK",
+	.expected = EACCES,
+	.setup = setup_node,
+	/* /dev/loop0 */
+	.major = 7,
+	.minor = 0,
+	.mode = S_IFBLK,
+};
+
+FIXTURE_VARIANT_ADD(file, S_IFCHR)
+{
+	.name = "S_IFCHR",
+	.expected = EACCES,
+	.setup = setup_node,
+	/* /dev/zero */
+	.major = 1,
+	.minor = 5,
+	.mode = S_IFCHR,
+};
+
+void setup_fifo(struct __test_metadata *_metadata,
+		FIXTURE_DATA(file) *self,
+		const FIXTURE_VARIANT(file) *variant)
+{
+	ASSERT_EQ(mkfifo(self->pathname, 0755), 0);
+}
+
+FIXTURE_VARIANT_ADD(file, S_IFIFO)
+{
+	.name = "S_IFIFO",
+	.expected = EACCES,
+	.setup = setup_fifo,
+};
+
+FIXTURE_SETUP(file)
+{
+	ASSERT_GT(asprintf(&self->pathname, "%s.test", variant->name), 6);
+	self->is_dir = variant->is_dir;
+
+	rm(_metadata, self->pathname, variant->is_dir);
+	variant->setup(_metadata, self, variant);
+}
+
+FIXTURE_TEARDOWN(file)
+{
+	rm(_metadata, self->pathname, self->is_dir);
+}
+
+TEST_F(file, exec_errno)
+{
+	char * const argv[2] = { (char * const)self->pathname, NULL };
+
+	EXPECT_LT(execv(argv[0], argv), 0);
+	EXPECT_EQ(errno, variant->expected);
+}
+
+/* S_IFSOCK */
+FIXTURE(sock)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(sock)
+{
+	self->fd = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(self->fd, 0);
+}
+
+FIXTURE_TEARDOWN(sock)
+{
+	if (self->fd >= 0)
+		ASSERT_EQ(close(self->fd), 0);
+}
+
+TEST_F(sock, exec_errno)
+{
+	char * const argv[2] = { " magic socket ", NULL };
+	char * const envp[1] = { NULL };
+
+	EXPECT_LT(fexecve(self->fd, argv, envp), 0);
+	EXPECT_EQ(errno, EACCES);
+}
+
+TEST_HARNESS_MAIN
-- 
2.25.1

