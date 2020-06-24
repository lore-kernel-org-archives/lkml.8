Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0029BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22572082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZJv/2q54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404995AbgFXQ32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404911AbgFXQ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:29:21 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA32DC0613ED;
        Wed, 24 Jun 2020 09:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Dr/cOIncKjeeFU+aDyXMiz0vyGhNWfe5V14YtpSjdI0=; b=ZJv/2q54bEef4yvTAHOtWXCm3x
        J1MBhZQQwtLkIhIkIWo4Ry7P+COIFBkBZzz7ueR56jv16WawR7NkE4cz6fkJICCM+a9k9enMK7fcE
        7rxc08vnMJH11liHYfwI76mPJgW++se+LbdEru/eObiOnMM3GnWp2SA/MkzNixKF0XeohhqM/fSUf
        pIPUkK3K/jyG8xnzz7rcprIeIpFeZxW2PXQioPAi9OmJcW3jILilwDhQ9PYrUiPFxKiJNVG8hb6YZ
        Ue6NhMyEtNxj4IVhvP/hHSEDavqhcPa429xUrTxOmBuyJE3Lg2Pm005kEmSDWCjdbkqYfgQF9RsuQ
        tDldon9g==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo8Gl-0006nk-RK; Wed, 24 Jun 2020 16:29:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/11] uptr: add a new "universal pointer" type
Date:   Wed, 24 Jun 2020 18:28:51 +0200
Message-Id: <20200624162901.1814136-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624162901.1814136-1-hch@lst.de>
References: <20200624162901.1814136-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a uptr_t type that can hold a pointer to either a user or kernel
memory region, and simply helpers to copy to and from it.  For
architectures like x86 that have non-overlapping user and kernel
address space it just is a union and uses a TASK_SIZE check to
select the proper copy routine.  For architectures with overlapping
address spaces a flag to indicate the address space is used instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/uptr.h | 72 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 include/linux/uptr.h

diff --git a/include/linux/uptr.h b/include/linux/uptr.h
new file mode 100644
index 00000000000000..1373511f9897b4
--- /dev/null
+++ b/include/linux/uptr.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020 Christoph Hellwig.
+ *
+ * Support for "universal" pointers that can point to either kernel or userspace
+ * memory.
+ */
+#ifndef _LINUX_UPTR_H
+#define _LINUX_UPTR_H
+
+#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+typedef union {
+	void		*kernel;
+	void __user	*user;
+} uptr_t;
+
+static inline uptr_t USER_UPTR(void __user *p)
+{
+	return (uptr_t) { .user = p };
+}
+
+static inline uptr_t KERNEL_UPTR(void *p)
+{
+	return (uptr_t) { .kernel = p };
+}
+
+static inline bool uptr_is_kernel(uptr_t uptr)
+{
+	return (unsigned long)uptr.kernel >= TASK_SIZE;
+}
+#else /* CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE */
+typedef struct {
+	union {
+		void		*kernel;
+		void __user	*user;
+	};
+	bool		is_kernel : 1;
+} uptr_t;
+
+static inline uptr_t USER_UPTR(void __user *p)
+{
+	return (uptr_t) { .user = p };
+}
+
+static inline uptr_t KERNEL_UPTR(void *p)
+{
+	return (uptr_t) { .kernel = p, .is_kernel = true };
+}
+
+static inline bool uptr_is_kernel(uptr_t uptr)
+{
+	return uptr.is_kernel;
+}
+#endif /* CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE */
+
+static inline int copy_from_uptr(void *dst, uptr_t src, size_t size)
+{
+	if (!uptr_is_kernel(src))
+		return copy_from_user(dst, src.user, size);
+	memcpy(dst, src.kernel, size);
+	return 0;
+}
+
+static inline int copy_to_uptr(uptr_t dst, const void *src, size_t size)
+{
+	if (!uptr_is_kernel(dst))
+		return copy_to_user(dst.user, src, size);
+	memcpy(dst.kernel, src, size);
+	return 0;
+}
+
+#endif /* _LINUX_UPTR_H */
-- 
2.26.2

