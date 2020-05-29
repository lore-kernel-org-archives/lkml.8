Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C49FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553A52074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgE2JnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgE2JnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:43:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62613C03E969;
        Fri, 29 May 2020 02:43:10 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jebXe-0000OK-6G; Fri, 29 May 2020 11:43:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B5FBA1C0084;
        Fri, 29 May 2020 11:43:05 +0200 (CEST)
Date:   Fri, 29 May 2020 09:43:05 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] copy_xstate_to_kernel(): don't leave parts of
 destination uninitialized
Cc:     stable@kernel.org, Alexander Potapenko <glider@google.com>,
        Borislav Petkov <bp@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159074538552.17951.8439883662849608914.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9e4636545933131de15e1ecd06733538ae939b2f
Gitweb:        https://git.kernel.org/tip/9e4636545933131de15e1ecd06733538ae939b2f
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Tue, 26 May 2020 18:39:49 -04:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Wed, 27 May 2020 17:06:31 -04:00

copy_xstate_to_kernel(): don't leave parts of destination uninitialized

copy the corresponding pieces of init_fpstate into the gaps instead.

Cc: stable@kernel.org
Tested-by: Alexander Potapenko <glider@google.com>
Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/fpu/xstate.c | 86 +++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 32b153d..6a54e83 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -957,18 +957,31 @@ static inline bool xfeatures_mxcsr_quirk(u64 xfeatures)
 	return true;
 }
 
-/*
- * This is similar to user_regset_copyout(), but will not add offset to
- * the source data pointer or increment pos, count, kbuf, and ubuf.
- */
-static inline void
-__copy_xstate_to_kernel(void *kbuf, const void *data,
-			unsigned int offset, unsigned int size, unsigned int size_total)
+static void fill_gap(unsigned to, void **kbuf, unsigned *pos, unsigned *count)
 {
-	if (offset < size_total) {
-		unsigned int copy = min(size, size_total - offset);
+	if (*pos < to) {
+		unsigned size = to - *pos;
+
+		if (size > *count)
+			size = *count;
+		memcpy(*kbuf, (void *)&init_fpstate.xsave + *pos, size);
+		*kbuf += size;
+		*pos += size;
+		*count -= size;
+	}
+}
 
-		memcpy(kbuf + offset, data, copy);
+static void copy_part(unsigned offset, unsigned size, void *from,
+			void **kbuf, unsigned *pos, unsigned *count)
+{
+	fill_gap(offset, kbuf, pos, count);
+	if (size > *count)
+		size = *count;
+	if (size) {
+		memcpy(*kbuf, from, size);
+		*kbuf += size;
+		*pos += size;
+		*count -= size;
 	}
 }
 
@@ -981,8 +994,9 @@ __copy_xstate_to_kernel(void *kbuf, const void *data,
  */
 int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int offset_start, unsigned int size_total)
 {
-	unsigned int offset, size;
 	struct xstate_header header;
+	const unsigned off_mxcsr = offsetof(struct fxregs_state, mxcsr);
+	unsigned count = size_total;
 	int i;
 
 	/*
@@ -998,46 +1012,42 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 	header.xfeatures = xsave->header.xfeatures;
 	header.xfeatures &= ~XFEATURE_MASK_SUPERVISOR;
 
+	if (header.xfeatures & XFEATURE_MASK_FP)
+		copy_part(0, off_mxcsr,
+			  &xsave->i387, &kbuf, &offset_start, &count);
+	if (header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM))
+		copy_part(off_mxcsr, MXCSR_AND_FLAGS_SIZE,
+			  &xsave->i387.mxcsr, &kbuf, &offset_start, &count);
+	if (header.xfeatures & XFEATURE_MASK_FP)
+		copy_part(offsetof(struct fxregs_state, st_space), 128,
+			  &xsave->i387.st_space, &kbuf, &offset_start, &count);
+	if (header.xfeatures & XFEATURE_MASK_SSE)
+		copy_part(xstate_offsets[XFEATURE_MASK_SSE], 256,
+			  &xsave->i387.xmm_space, &kbuf, &offset_start, &count);
+	/*
+	 * Fill xsave->i387.sw_reserved value for ptrace frame:
+	 */
+	copy_part(offsetof(struct fxregs_state, sw_reserved), 48,
+		  xstate_fx_sw_bytes, &kbuf, &offset_start, &count);
 	/*
 	 * Copy xregs_state->header:
 	 */
-	offset = offsetof(struct xregs_state, header);
-	size = sizeof(header);
-
-	__copy_xstate_to_kernel(kbuf, &header, offset, size, size_total);
+	copy_part(offsetof(struct xregs_state, header), sizeof(header),
+		  &header, &kbuf, &offset_start, &count);
 
-	for (i = 0; i < XFEATURE_MAX; i++) {
+	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
 		/*
 		 * Copy only in-use xstates:
 		 */
 		if ((header.xfeatures >> i) & 1) {
 			void *src = __raw_xsave_addr(xsave, i);
 
-			offset = xstate_offsets[i];
-			size = xstate_sizes[i];
-
-			/* The next component has to fit fully into the output buffer: */
-			if (offset + size > size_total)
-				break;
-
-			__copy_xstate_to_kernel(kbuf, src, offset, size, size_total);
+			copy_part(xstate_offsets[i], xstate_sizes[i],
+				  src, &kbuf, &offset_start, &count);
 		}
 
 	}
-
-	if (xfeatures_mxcsr_quirk(header.xfeatures)) {
-		offset = offsetof(struct fxregs_state, mxcsr);
-		size = MXCSR_AND_FLAGS_SIZE;
-		__copy_xstate_to_kernel(kbuf, &xsave->i387.mxcsr, offset, size, size_total);
-	}
-
-	/*
-	 * Fill xsave->i387.sw_reserved value for ptrace frame:
-	 */
-	offset = offsetof(struct fxregs_state, sw_reserved);
-	size = sizeof(xstate_fx_sw_bytes);
-
-	__copy_xstate_to_kernel(kbuf, xstate_fx_sw_bytes, offset, size, size_total);
+	fill_gap(size_total, &kbuf, &offset_start, &count);
 
 	return 0;
 }
