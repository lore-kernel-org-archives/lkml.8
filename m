Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A53DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BE4206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgENOdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:33:09 -0400
Received: from foss.arm.com ([217.140.110.172]:37762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgENOdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:33:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFC1111B3;
        Thu, 14 May 2020 07:33:00 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F21E33F71E;
        Thu, 14 May 2020 07:32:59 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/13] arm64: Add fixup routines for usercopy load exceptions
Date:   Thu, 14 May 2020 14:32:26 +0000
Message-Id: <20200514143227.605-13-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514143227.605-1-oli.swede@arm.com>
References: <20200514143227.605-1-oli.swede@arm.com>
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
 arch/arm64/lib/copy_user_fixup.S | 170 ++++++++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/lib/copy_user_fixup.S b/arch/arm64/lib/copy_user_fixup.S
index f878c8831b14..256a33522749 100644
--- a/arch/arm64/lib/copy_user_fixup.S
+++ b/arch/arm64/lib/copy_user_fixup.S
@@ -3,19 +3,179 @@
 addr	.req	x15
 .section .fixup,"ax"
 .align	2
+
+	/*
+	 * These fixup routines assume that it is not a requirement
+	 * to follow through with the copying of any intermediate
+	 * data in registers: this would be highly dependent on the
+	 * procedure in the copy template, which utilizes out-of-order
+	 * copying and is subject to change by future optimizations.
+	 *
+	 * The subroutine that is excuted depends on the properties of
+	 * the target address in the instruction: if it is an address
+	 * relative to the start or the end of the buffer, and (in the
+	 * case of copy sizes larger than 128 bytes) whether it is
+	 * aligned or unaligned with 16 bytes.
+	 */
+
+	/*
+	 * The following three routines are directed to from faults on load
+	 * instructions. In each case, nothing has been copied if either:
+	 *	a) the copy size is less than 128 bytes, as the algorithm does
+	 * 	   not interleave load/store instruction, so nothing has been
+	 *	   copied and the full width (srcend-src) can be returned
+	 *	b) the copy size is greater than or equal to 128 bytes and the
+	 *	   src and dst buffers overlap, as this would result in a
+	 *	   backwards copy, but the calling code expects the return
+	 *	   value (no. bytes not copied) to be from an in-order
+	 *	   perspective.
+	 */
 9993:
+	/*
+	 * This is reached from load instructions that are specified
+	 * relative to the start of a user space memory buffer, and
+	 * are not guaranteed to be aligned to 16B.
+	 */
+
+	/* Retrieve useful information & free the stack area */
+	ldp	dst, src, [sp], #16	// dst: x3, src: x1
+	ldr	count, [sp], #16	// count: x2
+	add	srcend, src, count
+	add	dstend, dst, count
+
+	/* Copy size < 128 bytes */
+	cmp	count, 128
+	b.ls	L(none_copied)
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
+	 * The fault occurred in a load instruction at the start of the
+	 * algorithm's subroutine for long copies, and no bytes have
+	 * been stored at this point.
+	 */
+	b	L(none_copied)
 9994:
+	/*
+	 * This is reached from load instructions that are specified
+	 * relative to the end of a user space memory buffer, and
+	 * are not guaranteed to be aligned to 16B.
+	 */
+
+	/* Store the current dst before the original is
+	 * restored */
+	mov	tmp1, dst
+
+	/* Retrieve useful information & free the stack area */
+	ldp	dst, src, [sp], #16	// dst: x3, src: x1
+	ldr	count, [sp], #16	// count: x2
+	add	srcend, src, count
+	add	dstend, dst, count
+
+	/* Copy size < 128 bytes */
+	cmp	count, 128
+	b.ls	L(none_copied)
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
+	 * In the case of an access relative to the end of
+	 * the buffer, the long copy has reached the final
+	 * 64B chunk in copy64_from_end().
+	 *
+	 * The fault address should fall in 1-of-4 16B blocks,
+	 * each of which indicates how many bytes have been
+	 * stored from the in-order perspective.
+	 *
+	 * A number of iterations of the loop to copy 64B
+	 * chunks may have completed; tmp1 stores the
+	 * latest position of the dst pointer and this can
+	 * be used to deduce how many 16B copies have taken
+	 * place.
+	 */
+
+	/* Calculate the index of the 16B block containing
+	 * containing the fault address */
+	sub	x0, srcend, 64
+	cmp	addr, x0
+	b.lt	L(none_copied) // unexpected fault address
+	sub	x0, addr, x0 // relative offset of fault in buffer
+	bic	x0, x0, 15 // assume no data copied between addr and the target
+	sub	tmp1, dst, tmp1 // already copied up to dst
+	add	x0, x0, tmp1 // plus the difference between addr and srcend-64
+	sub	x0, count, x0 // no. bytes not copied
+	b	L(end_fixup)
+
 9995:
+	/*
+	 * This is reached from load instructions that are specified
+	 * relative to the start of a user space memory buffer, and
+	 * are guaranteed to be aligned to 16B.
+	 */
+
+	/* Retrieve useful information & free the stack area */
+	ldp	dst, src, [sp], #16	// dst: x3, src: x1
+	ldr	count, [sp], #16	// count: x2
+	add	srcend, src, count
+	add	dstend, dst, count
+
+	/* Copy size <= 128 bytes */
+	cmp	count, 128
+	b.ls	L(none_copied)
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
+	sub	x0, addr, src
+	lsr	x0, addr, 4 // calculate the index of faulting 16B block
+	/* Map the index in x0 to the no. bytes already copied */
+	cmp	x0, 1
+	b.le	L(none_copied) // no stores for i=0,1
+	cmp	x0, 4
+	mov	tmp1, x0
+	sub	x0, count, 16
+	b.le	L(end_fixup) // one store (16B) for i=2,3,4
+	/* Faulted in a loop: stored up to ((i-3) * 16) - (dst % 16) */
+	mov	x0, tmp1
+	sub	x0, x0, 3
+	lsl	x0, x0, 4
+	mov	tmp1, dst
+	and	tmp1, tmp1, 15
+	sub	x0, x0, tmp1
+	b	L(end_fixup)
+
 9996:
 9997:
 9998:
-	/* Retrieve useful information & free the stack area */
-	ldr	count, [sp, #16]	// x2
-	add	sp, sp, 32
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

