Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F353DC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 23:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E7320774
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 23:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgH2Xs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 19:48:29 -0400
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:45620 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728448AbgH2XsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 19:48:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 051B818011173;
        Sat, 29 Aug 2020 23:48:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: meat18_150665a27082
X-Filterd-Recvd-Size: 5110
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat, 29 Aug 2020 23:48:22 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] sysfs: Add sysfs_emit and sysfs_emit_at to format sysfs output
Date:   Sat, 29 Aug 2020 16:48:20 -0700
Message-Id: <a9054fb521e65f2809671fa9c18e2453061e9d91.1598744610.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output defects can exist in sysfs content using sprintf and snprintf.

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Add a generic sysfs_emit function that knows that the size of the
temporary buffer and ensures that no overrun is done.

Add a generic sysfs_emit_at function that can be used in multiple
call situations that also ensures that no overrun is done.

Signed-off-by: Joe Perches <joe@perches.com>
---

V2: Simplify sysfs_emit and add sysfs_emit_at
    Include Documentation change

 Documentation/filesystems/sysfs.rst |  8 ++---
 fs/sysfs/file.c                     | 49 +++++++++++++++++++++++++++++
 include/linux/sysfs.h               | 15 +++++++++
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index ab0f7795792b..d44249050f4a 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -242,12 +242,10 @@ Other notes:
   is 4096.
 
 - show() methods should return the number of bytes printed into the
-  buffer. This is the return value of scnprintf().
+  buffer.
 
-- show() must not use snprintf() when formatting the value to be
-  returned to user space. If you can guarantee that an overflow
-  will never happen you can use sprintf() otherwise you must use
-  scnprintf().
+- show() should only use sysfs_emit() or sysfs_emit_at() when formatting
+  the value to be returned to user space.
 
 - store() should return the number of bytes used from the buffer. If the
   entire buffer has been used, just return the count argument.
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index eb6897ab78e7..e8c6d20bab8e 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -707,3 +707,52 @@ int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sysfs_change_owner);
+
+/**
+ *	sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer.
+ *	@buf:	start of PAGE_SIZE buffer.
+ *	@fmt:	format
+ *	@...:	optional arguments to @format
+ *
+ *
+ * Returns number of characters written to @buf.
+ */
+int sysfs_emit(char *buf, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+
+	va_start(args, fmt);
+	len = vscnprintf(buf, PAGE_SIZE, fmt, args);
+	va_end(args);
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(sysfs_emit);
+
+/**
+ *	sysfs_emit_at - scnprintf equivalent, aware of PAGE_SIZE buffer.
+ *	@buf:	start of PAGE_SIZE buffer.
+ *	@at:	offset in @buf to start write in bytes
+ *		@at must be >= 0 && < PAGE_SIZE
+ *	@fmt:	format
+ *	@...:	optional arguments to @fmt
+ *
+ *
+ * Returns number of characters written starting at &@buf[@at].
+ */
+int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+
+	if (WARN(at < 0 || at >= PAGE_SIZE, "invalid sysfs_emit_at: %d\n", at))
+		return 0;
+
+	va_start(args, fmt);
+	len = vscnprintf(buf + at, PAGE_SIZE - at, fmt, args);
+	va_end(args);
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(sysfs_emit_at);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 34e84122f635..2caa34c1ca1a 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -329,6 +329,10 @@ int sysfs_groups_change_owner(struct kobject *kobj,
 int sysfs_group_change_owner(struct kobject *kobj,
 			     const struct attribute_group *groups, kuid_t kuid,
 			     kgid_t kgid);
+__printf(2, 3)
+int sysfs_emit(char *buf, const char *fmt, ...);
+__printf(3, 4)
+int sysfs_emit_at(char *buf, int at, const char *fmt, ...);
 
 #else /* CONFIG_SYSFS */
 
@@ -576,6 +580,17 @@ static inline int sysfs_group_change_owner(struct kobject *kobj,
 	return 0;
 }
 
+__printf(2, 3)
+static inline int sysfs_emit(char *buf, const char *fmt, ...)
+{
+	return 0;
+}
+
+__printf(3, 4)
+static inline int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
+{
+	return 0;
+}
 #endif /* CONFIG_SYSFS */
 
 static inline int __must_check sysfs_create_file(struct kobject *kobj,
-- 
2.26.0

