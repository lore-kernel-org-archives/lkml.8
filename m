Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60F5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D42206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgF3Tt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:49:29 -0400
Received: from foss.arm.com ([217.140.110.172]:33002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbgF3Ts5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:48:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 247DD139F;
        Tue, 30 Jun 2020 12:48:57 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39D813F73C;
        Tue, 30 Jun 2020 12:48:56 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/14] arm64: Add fixup routines for usercopy load exceptions
Date:   Tue, 30 Jun 2020 19:48:20 +0000
Message-Id: <20200630194822.1082-13-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630194822.1082-1-oli.swede@arm.com>
References: <20200630194822.1082-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the fixup routines for exceptions that occur on load
operations while copying, by providing the calling code with a more
accurate value for the number of bytes that failed to copy.

The three routines for load exceptions work together to analyse
the position of the fault relative to the start or the end of the
buffer, and backtrack from the optimized memcpy algorithm to
determine if some number of bytes has already been successfully
copied.

The new template uses out-of-order copying, and this fixup routine is
specific to the latest memcpy implementation. It is assumed there is
no requirement to follow through with the copying of data that may
reside in temporary registers on a fault, as this would greatly
increase the fixup's complexity.

Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/lib/copy_user_fixup.S | 172 ++++++++++++++++++++++++++++++-
 1 file changed, 168 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/lib/copy_user_fixup.S b/arch/arm64/lib/copy_user_fixup.S
index f878c8831b14..ae94b492129d 100644
--- a/arch/arm64/lib/copy_user_fixup.S
+++ b/arch/arm64/lib/copy_user_fixup.S
@@ -3,19 +3,183 @@
 addr	.req	x15
 .section .fixup,"ax"
 .align	2
+
+/*
+ * These fixup routines assume no requirements to follow through
+ * with copying any intermediate data in registers.
+ *
+ * The fixup subroutine that is directed to depends on the
+ * characteristics of the target address in the faulting instruction:
+ * if it is an address specified relative to the start or end of the
+ * buffer, and (in the case of copy sizes >128B) if the target address
+ * is 16-byte aligned.
+ */
+
+/*
+ * The following three routines are directed to from faults on load
+ * instructions. For 9993, 9994 and 9995, in each case nothing has
+ * been copied if either:
+ *	a) the copy size is less than 128 bytes - the algorithm does
+ *	   not interleave load/store instructions and starts with the
+ *	   load instructions, so for these sizes nothing has been
+ *	   copied on a load fault and the full buffer width srcend-src
+ *	   can be returned, or
+ *	b) the copy size is greater than or equal to 128 bytes and the
+ *	   src and dst buffers overlap - this would result in a
+ *	   backwards copy, however the calling code expects the return
+ *	   value, the numbwe of bytes not copied, to be from an in-order
+ *	   perspective.
+ */
 9993:
+	/*
+	 * This is reached from load instructions that are specified
+	 * relative to the start of a user space memory buffer, and
+	 * provide target addresses that are 16-byte aligned.
+	 */
+
+	/* Retrieve original params from stack */
+	ldp	dst, src, [sp], #16	// dst: x3, src: x1
+	ldr	count, [sp], #16	// count: x2
+	add	srcend, src, count
+	add	dstend, dst, count
+
+	/*
+	 * If the fault occurred with a copy size larger than 128 bytes,
+	 * and if the buffers do not overlap (where it would start copying
+	 * from the end), it still has not copied anything at this point
+	 * as the fault occurred at the start of the algorithm's subroutine
+	 * for long forward copies, and no bytes have been stored at this
+	 * point.
+	 */
+	b	L(none_copied)
 9994:
+	/*
+	 * This is reached from load instructions that are specified
+	 * relative to the end of a user space memory buffer, and
+	 * where the store targets are not guaranteed to be 16-byte
+	 * aligned.
+	 */
+
+	/* Save the current (adjusted) dst for later restoration */
+	mov	tmp1, dst
+
+	/* Retrieve original params from stack */
+	ldp	dst, src, [sp], #16	// dst: x3, src: x1
+	ldr	count, [sp], #16	// count: x2
+	add	srcend, src, count
+	add	dstend, dst, count
+
+	/* Copy size <= 128 bytes */
+	cmp	count, 128
+	b.le	L(none_copied)
+
+	/*
+	 * Overlapping buffers:
+	 * (src <= dst && dst < srcend) || (dst <= src && src < dstend)
+	 */
+	cmp	src, dst
+	ccmp	dst, srcend, #0, le
+	b.lt	L(none_copied)
+	cmp	dst, src
+	ccmp	src, dstend, #0, le
+	b.lt	L(none_copied)
+
+	/*
+	 * In a long copy over 128B, in the case of a fault at an
+	 * address relative to the end of the buffer, this will
+	 * occur in copy64_from_end() and thus the last 64 bytes.
+	 *
+	 * The algorithm first copies 16 bytes, and then aligns dst
+	 * to 16 bytes for the rest of the copy.
+	 * At the end of each loop64(), dst is incremented by 64.
+	 *
+	 * This takes the minimum of (16, max((current_dst + 16 - original_dst), 16) 
+	 */
+
+	/* already copied max((tmp1 + 16 - dst), 16) */
+	add	tmp1, tmp1, 16
+	sub	tmp1, tmp1, dst
+	mov	x0, 16
+	cmp	x0, tmp1
+	csel	tmp1, x0, tmp1, ge // threshold it has copied up to
+	sub	x0, srcend, 64 // base of final 64 bytes
+	sub	x0, addr, x0 // fault offset in final 64 bytes
+	bic	x0, x0, 15 // discard bytes between target and fault addr)
+	add	x0, x0, tmp1 // copied up to here
+	sub	x0, count, x0
+	b	L(end_fixup)
+
 9995:
+	/*
+	 * This is reached from load instructions that are specified
+	 * relative to the start of a user space memory buffer, and
+	 * where the store targets are guaranteed to be 16-byte aligned.
+	 */
+	
+	/* Save the current (adjusted) dst for later restoration */
+	mov	tmp1, dst
+
+	/* Retrieve original params from stack */
+	ldp	dst, src, [sp], #16	// dst: x3, src: x1
+	ldr	count, [sp], #16	// count: x2
+	add	srcend, src, count
+	add	dstend, dst, count
+
+	/* Copy size <= 128 bytes */
+	cmp	count, 128
+	b.le	L(none_copied)
+
+	/*
+	 * Overlapping buffers:
+	 * (src <= dst && dst < srcend) || (dst <= src && src < dstend)
+	 */
+	cmp	src, dst
+	ccmp	dst, srcend, #0, le
+	b.lt	L(none_copied)
+	cmp	dst, src
+	ccmp	src, dstend, #0, le
+	b.lt	L(none_copied)
+
+	/*
+	 * These stores provide target addresses that are 16-byte
+	 * aligned, and this allows for a mapping:
+	 */
+	and	x0, dst, 15
+	sub	x0, src, x0 // aligned src: (src - (dst & 15))
+	sub	x0, addr, src // offset of fault relative to aligned src
+	bic	x0, x0, 15 // round down to base of faulting 16B chunk
+	mov	tmp1, 16
+	cmp	x0, tmp1
+	/* fault_offset < 32 -> count */
+	b.le	L(none_copied)
+	mov	tmp1, 64
+	cmp	x0, tmp1
+	mov	tmp1, x0
+	sub	x0, count, 16
+	/* 32 <= fault_offset < 80 -> count-16 */
+	b.le	L(end_fixup)
+	mov	x0, tmp1
+	sub	x0, x0, 48 /* faulted in a loop64 subroutine */
+	and	tmp1, dst, 15
+	sub	x0, x0, tmp1
+	sub	x0, count, x0
+	/*
+	 * fault_offset >= 80 ->
+	 * count-((fault_offset&~15)-48)-(dst & 15))
+	 */
+	b	L(end_fixup)
+	
 9996:
 9997:
 9998:
-	/* Retrieve useful information & free the stack area */
-	ldr	count, [sp, #16]	// x2
+	/* Retrieve info from stack */
+	ldr	count, [sp], #16	// count: x2
 	add	sp, sp, 32
+L(none_copied):
 	/*
-	 * Return the initial count as the (under-estimated) number
+	 * Return the initial count as the number
 	 * of bytes that failed to copy
 	 */
 	mov	x0, count
+L(end_fixup):
 	ret
-
-- 
2.17.1

