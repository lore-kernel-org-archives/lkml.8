Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786A4C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C5A206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgC0Xb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 19:31:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35888 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgC0XbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 19:31:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHyRZ-004KK2-Uk; Fri, 27 Mar 2020 23:31:18 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 01/14] get rid of csum_partial_copy_to_user()
Date:   Fri, 27 Mar 2020 23:31:04 +0000
Message-Id: <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327233006.GW23230@ZenIV.linux.org.uk>
References: <20200327233006.GW23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

For historical reasons some architectures call their csum_and_copy_to_user()
csum_partial_copy_to_user() instead (and supply a macro defining the
former as the latter).  That's the last remnants of old experiment that
went nowhere; time to bury them.  Rename those to csum_and_copy_to_user()
and get rid of the macros.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/include/asm/checksum_32.h | 7 +++----
 arch/x86/include/asm/checksum_64.h   | 4 +---
 arch/x86/lib/csum-wrappers_64.c      | 6 +++---
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/checksum_32.h b/arch/sparc/include/asm/checksum_32.h
index 5fc98d80b03b..450ddfb444c8 100644
--- a/arch/sparc/include/asm/checksum_32.h
+++ b/arch/sparc/include/asm/checksum_32.h
@@ -83,8 +83,10 @@ csum_partial_copy_from_user(const void __user *src, void *dst, int len,
 	return (__force __wsum)ret;
 }
 
+#define HAVE_CSUM_COPY_USER
+
 static inline __wsum
-csum_partial_copy_to_user(const void *src, void __user *dst, int len,
+csum_and_copy_to_user(const void *src, void __user *dst, int len,
 			  __wsum sum, int *err)
 {
 	if (!access_ok(dst, len)) {
@@ -113,9 +115,6 @@ csum_partial_copy_to_user(const void *src, void __user *dst, int len,
 	}
 }
 
-#define HAVE_CSUM_COPY_USER
-#define csum_and_copy_to_user csum_partial_copy_to_user
-
 /* ihl is always 5 or greater, almost always is 5, and iph is word aligned
  * the majority of the time.
  */
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index 3ec6d3267cf9..ac9c06494827 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -141,13 +141,11 @@ extern __visible __wsum csum_partial_copy_generic(const void *src, const void *d
 
 extern __wsum csum_partial_copy_from_user(const void __user *src, void *dst,
 					  int len, __wsum isum, int *errp);
-extern __wsum csum_partial_copy_to_user(const void *src, void __user *dst,
+extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
 					int len, __wsum isum, int *errp);
 extern __wsum csum_partial_copy_nocheck(const void *src, void *dst,
 					int len, __wsum sum);
 
-/* Old names. To be removed. */
-#define csum_and_copy_to_user csum_partial_copy_to_user
 #define csum_and_copy_from_user csum_partial_copy_from_user
 
 /**
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index c66c8b00f236..875c2f5968a0 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -71,7 +71,7 @@ csum_partial_copy_from_user(const void __user *src, void *dst,
 EXPORT_SYMBOL(csum_partial_copy_from_user);
 
 /**
- * csum_partial_copy_to_user - Copy and checksum to user space.
+ * csum_and_copy_to_user - Copy and checksum to user space.
  * @src: source address
  * @dst: destination address (user space)
  * @len: number of bytes to be copied.
@@ -82,7 +82,7 @@ EXPORT_SYMBOL(csum_partial_copy_from_user);
  * src and dst are best aligned to 64bits.
  */
 __wsum
-csum_partial_copy_to_user(const void *src, void __user *dst,
+csum_and_copy_to_user(const void *src, void __user *dst,
 			  int len, __wsum isum, int *errp)
 {
 	__wsum ret;
@@ -116,7 +116,7 @@ csum_partial_copy_to_user(const void *src, void __user *dst,
 	clac();
 	return ret;
 }
-EXPORT_SYMBOL(csum_partial_copy_to_user);
+EXPORT_SYMBOL(csum_and_copy_to_user);
 
 /**
  * csum_partial_copy_nocheck - Copy and checksum.
-- 
2.11.0

