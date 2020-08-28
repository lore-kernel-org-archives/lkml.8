Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16E3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8880F208A9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgH1WwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:52:19 -0400
Received: from smtprelay0173.hostedemail.com ([216.40.44.173]:45790 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726550AbgH1WwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:52:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E7F71837F24A;
        Fri, 28 Aug 2020 22:52:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shock81_260b9bc27079
X-Filterd-Recvd-Size: 3243
Received: from joe-laptop.perches.com (cpe-72-134-242-36.natsow.res.rr.com [72.134.242.36])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2020 22:52:15 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sysfs: Add sysfs_emit to replace sprintf to PAGE_SIZE buffers.
Date:   Fri, 28 Aug 2020 15:52:13 -0700
Message-Id: <a96cdf07cd136d06c3cc1e10eb884caa7498ba72.1598654887.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content requests and it's possible to
overrun the buffer length.

Add a generic sysfs_emit mechanism that knows that the size of the
temporary buffer and ensures that no overrun is done.

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/sysfs/file.c       | 30 ++++++++++++++++++++++++++++++
 include/linux/sysfs.h |  8 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index eb6897ab78e7..06a13bbd7080 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -707,3 +707,33 @@ int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sysfs_change_owner);
+
+/**
+ *	sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer.
+ *	@buf:	start of PAGE_SIZE buffer.
+ *	@pos:	current position in buffer
+ *              (pos - buf) must always be < PAGE_SIZE
+ *	@fmt:	format
+ *	@...:	arguments to format
+ *
+ *
+ * Returns number of characters written at pos.
+ */
+int sysfs_emit(char *buf, char *pos, const char *fmt, ...)
+{
+	va_list args;
+	bool bad_pos = pos < buf;
+	bool bad_len = (pos - buf) >= PAGE_SIZE;
+	int len;
+
+	if (WARN(bad_pos || bad_len, "(pos < buf):%d (pos >= PAGE_SIZE):%d\n",
+		 bad_pos, bad_len))
+		return 0;
+
+	va_start(args, fmt);
+	len = vscnprintf(pos, PAGE_SIZE - (pos - buf), fmt, args);
+	va_end(args);
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(sysfs_emit);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 34e84122f635..5a21d3d30016 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -329,6 +329,8 @@ int sysfs_groups_change_owner(struct kobject *kobj,
 int sysfs_group_change_owner(struct kobject *kobj,
 			     const struct attribute_group *groups, kuid_t kuid,
 			     kgid_t kgid);
+__printf(3, 4)
+int sysfs_emit(char *buf, char *pos, const char *fmt, ...);
 
 #else /* CONFIG_SYSFS */
 
@@ -576,6 +578,12 @@ static inline int sysfs_group_change_owner(struct kobject *kobj,
 	return 0;
 }
 
+__printf(3, 4)
+static inline int sysfs_emit(char *buf, char *pos, const char *fmt, ...)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SYSFS */
 
 static inline int __must_check sysfs_create_file(struct kobject *kobj,
-- 
2.26.0

