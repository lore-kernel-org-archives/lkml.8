Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3D7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7D2206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgF3TtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:49:09 -0400
Received: from foss.arm.com ([217.140.110.172]:33008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728543AbgF3Ts7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:48:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B82E13A1;
        Tue, 30 Jun 2020 12:48:58 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59B933F73C;
        Tue, 30 Jun 2020 12:48:57 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/14] arm64: Add fixup routines for usercopy store exceptions
Date:   Tue, 30 Jun 2020 19:48:21 +0000
Message-Id: <20200630194822.1082-14-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630194822.1082-1-oli.swede@arm.com>
References: <20200630194822.1082-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the fixup routines for exceptions that occur on store
operations while copying, by providing the calling code with a more
accurate value for the number of bytes that failed to copy, rather
than returning the full buffer width.

The three routines for store exceptions work together to analyse
the position of the fault relative to the start or the end of the
buffer, and backtrack from the optimized memcpy algorithm to
determine if some number of bytes has already been successfully
copied.

The store operations occur mostly in-order, with the exception of
a few copy size ranges - this is specific to the new copy template,
which uses the latest memcpy implementation.

Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/lib/copy_user_fixup.S | 217 ++++++++++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/lib/copy_user_fixup.S b/arch/arm64/lib/copy_user_fixup.S
index ae94b492129d..37ca3d99a02a 100644
--- a/arch/arm64/lib/copy_user_fixup.S
+++ b/arch/arm64/lib/copy_user_fixup.S
@@ -169,12 +169,225 @@ addr	.req	x15
 	 */
 	b	L(end_fixup)
 	
+/*
+ * The following three routines are directed to from faults
+ * on store instructions.
+ */
 9996:
+	/*
+	 * This routine is reached from faults on store instructions
+	 * where the target address has been specified relative to the
+	 * start of the user space memory buffer, and is also not
+	 * guaranteed to be 16-byte aligned.
+	 *
+	 * For copy sizes <= 128 bytes, the stores occur in-order,
+	 * so it has copied up to (addr-dst)&~15.
+	 * For copy sizes > 128 bytes, this should only be directed
+	 * to from a fault on the first store of the long copy, before
+	 * the algorithm aligns dst to 16B, so no bytes have copied at
+	 * this point.
+	 */
+
+	/* Retrieve original params from stack */
+	ldr	dst, [sp], #16	// dst: x3, src: x1
+	ldr	count, [sp], #16	// count: x2
+	add	srcend, src, count
+	add	dstend, dst, count
+
+	/* count <= 3 -> count - (addr-dst) */
+	cmp	count, 3
+	sub	x0, addr, dst // relative fault offset in buffer
+	sub	x0, count, x0 // bytes yet to copy
+	b.le	L(end_fixup)
+        /* 3 < count <= 32 -> count - (addr-dst) */
+	cmp	count, 32
+	b.le	L(none_copied)
+	/* 32 < count < 128 -> count - ((addr-dst)&15) */
+	cmp	count, 128
+	sub	x0, addr, dst // relative fault offset
+	bic	x0, x0, 15 // bytes already copied (steps of 16B stores)
+	sub	x0, count, x0 // bytes yet to copy
+	b.le	L(end_fixup)
+	/* 128 < count -> count */
+	b	L(none_copied)
+
 9997:
+	/*
+	 * This routine is reached from faults on store instructions
+	 * where the target address has been specified relative to
+	 * the end of the user space memory buffer and is also not
+	 * guaranteed to be 16-byte aligned.
+	 *
+	 * In this scenario, the copy is close to completion and
+	 * has occurred in-order, so it is straightforward to
+	 * calculate the remaining bytes.
+	 *
+	 * The algorithm increments dst by 64B for each loop64()
+	 * subroutine, and tmp1 stores its latest value, which
+	 * allows for the calculation of a threshold that it has
+	 * copied up to.
+	 * 
+	 * To account for faults on data that has already been copied
+	 * (which can occur due to the way the algorithm uses
+	 * overlapping copies within a buffer), this threshold can be
+	 * subtracted from the copy size and the result compared
+	 * against the remaining bytes after the fault offset in the
+	 * last 64B; the minimum of the two can then be taken for the
+	 * return value.
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
+	 * For copy size >128 bytes, select max of
+	 * { tmp1-dst+80, ((addr-dstend+64)&15) }
+	 */
+	sub	tmp1, tmp1, dst // relative position of new dst
+	add	tmp1, tmp1, 80 // copied up to here
+	sub	tmp1, count, tmp1 // remaining bytes after non-overlapping section
+	sub	x0, dstend, 64
+	sub	x0, addr, x0
+	bic	x0, x0, 15 // fault offset within dest. buffer
+	add	x0, dstend, x0
+	sub	x0, x0, 64
+	sub	x0, dstend, x0 // remaining bytes in final (overlapping) 64B
+	cmp	x0, tmp1
+	csel	x0, x0, tmp1, lt
+	cmp	count, 128
+	b.gt	L(end_fixup)
+
+	cmp	count, 2
+	b.le	L(none_copied)
+	cmp	count, 3 // one byte left
+	mov	x0, 1
+	b.eq	L(end_fixup)
+	cmp	count, 7 // four bytes left
+	sub	x0, count, 4
+	b.le	L(end_fixup)
+	cmp	count, 15 // eight bytes left
+	sub	x0, count, 8
+	b.le	L(end_fixup)
+	cmp	count, 32 // 16 bytes left
+	sub	x0, count, 16	
+	b.le	L(end_fixup)
+	/*
+	 * For copy size 33..64 select min of
+	 * {(32 - fault_offset), (count-32)}
+	 * as copy may overlap
+	 */
+	sub	tmp1, dstend, 32
+	sub	tmp1, addr, tmp1
+	bic	tmp1, tmp1, 15
+	mov	x0, 32
+	sub	tmp1, x0, tmp1
+	sub	x0, count, 32
+	cmp	x0, tmp1
+	csel	x0, x0, tmp1, lt
+	cmp	count, 64
+	b.le	L(end_fixup)
+	/* For copy size 65..96 select min of
+	 * {(count - fault_offset), (count-64)}
+	 * as copy may overlap
+	 */
+	sub	tmp1, dstend, 32
+	sub	tmp1, addr, tmp1
+	bic	tmp1, tmp1, 15
+	mov	x0, 32
+	sub	tmp1, x0, tmp1
+	sub	x0, count, 64
+	cmp	x0, tmp1
+	csel	x0, x0, tmp1, lt
+	cmp	count, 96
+	b.lt	L(end_fixup)
+	/*
+	 * For copy size 97..128 same as above, but account for
+	 * out-of-order initial stores, where no bytes have been
+	 * copied on those faults
+	 */
+	sub	tmp1, dstend, 64
+	sub	tmp1, addr, tmp1
+	bic	tmp1, tmp1, 15
+	mov	x0, 64
+	sub	tmp1, x0, tmp1
+	cmp	count, 128
+	mov	x0, 32
+	ccmp	tmp1, x0, #0, le
+	b.gt	L(none_copied) // none copied if faults in first or second chunk
+	sub	x0, count, 64
+	cmp	x0, tmp1
+	csel	x0, x0, tmp1, lt
+	cmp	count, 128
+	b.le	L(end_fixup)
+
+	b	L(none_copied)
+
 9998:
-	/* Retrieve info from stack */
+	/*
+	 * This routine is reached from faults on store instructions
+	 * where the target address has been specified relative to the
+	 * start of the user space memory buffer, and is also
+	 * guaranteed to be 16-byte aligned.
+	 *
+	 * These instrucions occur after the algorithm aligns dst
+	 * to 16B, which is after the very first store in a long copy.
+	 * It then continues copying from dst+16 onwards.
+	 *
+	 * This could result in the second store attempting to copy
+	 * data that has already been copied, as there would be an
+	 * overlap in the buffer if the original dst is not 16 bytes
+	 * aligned. In this case we report that 16 bytes has already
+	 * already been copied, so it must take the minimum of the
+	 * two values.
+	 */
+
+	/* Retrieve original params from stack */
+	ldp	dst, src, [sp], #16	// dst: x3, src: x1
 	ldr	count, [sp], #16	// count: x2
-	add	sp, sp, 32
+	add	srcend, src, count
+	add	dstend, dst, count	
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
+	/* Take the min from {16,(fault_addr&15)-(dst&15)}
+	 * and subtract from count to obtain the return value */
+	bic	tmp1, dst, 15 // aligned dst
+	bic	x0, addr, 15
+	sub	x0, x0, tmp1 // relative fault offset
+	cmp	x0, 16
+	bic	x0, addr, 15
+	sub	x0, x0, dst
+	sub	x0, count, x0
+	b.gt	L(end_fixup)
+	sub	x0, count, 16
+	b	L(end_fixup) // initial unaligned chunk copied
+
 L(none_copied):
 	/*
 	 * Return the initial count as the number
-- 
2.17.1

