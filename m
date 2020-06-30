Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D410AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3C6206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgF3Tte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:49:34 -0400
Received: from foss.arm.com ([217.140.110.172]:32948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbgF3Tsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:48:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 546E9113E;
        Tue, 30 Jun 2020 12:48:51 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 682CB3F73C;
        Tue, 30 Jun 2020 12:48:50 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/14] arm64: Import latest version of Cortex Strings' strncmp
Date:   Tue, 30 Jun 2020 19:48:15 +0000
Message-Id: <20200630194822.1082-8-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630194822.1082-1-oli.swede@arm.com>
References: <20200630194822.1082-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Tebbs <sam.tebbs@arm.com>

Import latest version of Cortex Strings' strncmp function.

The upstream source is src/aarch64/strncmp.S as of commit 071fe283b28d
in https://git.linaro.org/toolchain/cortex-strings.git.

Signed-off-by: Sam Tebbs <sam.tebbs@arm.com>
[ rm: update attribution, expand commit message ]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/lib/strncmp.S | 363 ++++++++++++++++++---------------------
 1 file changed, 163 insertions(+), 200 deletions(-)

diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
index 2a7ee949ed47..b954e0fd93be 100644
--- a/arch/arm64/lib/strncmp.S
+++ b/arch/arm64/lib/strncmp.S
@@ -1,13 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2013 ARM Ltd.
- * Copyright (C) 2013 Linaro.
+ * Copyright (c) 2013,2018 Linaro Limited. All rights reserved.
  *
- * This code is based on glibc cortex strings work originally authored by Linaro
- * be found @
+ * This code is based on glibc Cortex Strings work originally authored by
+ * Linaro, found at:
  *
- * http://bazaar.launchpad.net/~linaro-toolchain-dev/cortex-strings/trunk/
- * files/head:/src/aarch64/
+ * https://git.linaro.org/toolchain/cortex-strings.git
  */
 
 #include <linux/linkage.h>
@@ -30,49 +28,49 @@
 #define REP8_80 0x8080808080808080
 
 /* Parameters and result.  */
-src1		.req	x0
-src2		.req	x1
-limit		.req	x2
-result		.req	x0
+#define src1		x0
+#define src2		x1
+#define limit		x2
+#define result		x0
 
 /* Internal variables.  */
-data1		.req	x3
-data1w		.req	w3
-data2		.req	x4
-data2w		.req	w4
-has_nul		.req	x5
-diff		.req	x6
-syndrome	.req	x7
-tmp1		.req	x8
-tmp2		.req	x9
-tmp3		.req	x10
-zeroones	.req	x11
-pos		.req	x12
-limit_wd	.req	x13
-mask		.req	x14
-endloop		.req	x15
+#define data1		x3
+#define data1w		w3
+#define data2		x4
+#define data2w		w4
+#define has_nul		x5
+#define diff		x6
+#define syndrome	x7
+#define tmp1		x8
+#define tmp2		x9
+#define tmp3		x10
+#define zeroones	x11
+#define pos		x12
+#define limit_wd	x13
+#define mask		x14
+#define endloop		x15
+#define count		mask
 
+	.p2align 6
+	.rep 7
+	nop	/* Pad so that the loop below fits a cache line.  */
+	.endr
 SYM_FUNC_START_WEAK_PI(strncmp)
 	cbz	limit, .Lret0
 	eor	tmp1, src1, src2
 	mov	zeroones, #REP8_01
 	tst	tmp1, #7
+	and	count, src1, #7
 	b.ne	.Lmisaligned8
-	ands	tmp1, src1, #7
-	b.ne	.Lmutual_align
+	cbnz	count, .Lmutual_align
 	/* Calculate the number of full and partial words -1.  */
-	/*
-	* when limit is mulitply of 8, if not sub 1,
-	* the judgement of last dword will wrong.
-	*/
-	sub	limit_wd, limit, #1 /* limit != 0, so no underflow.  */
-	lsr	limit_wd, limit_wd, #3  /* Convert to Dwords.  */
+	sub	limit_wd, limit, #1	/* limit != 0, so no underflow.  */
+	lsr	limit_wd, limit_wd, #3	/* Convert to Dwords.  */
 
-	/*
-	* NUL detection works on the principle that (X - 1) & (~X) & 0x80
-	* (=> (X - 1) & ~(X | 0x7f)) is non-zero iff a byte is zero, and
-	* can be done in parallel across the entire word.
-	*/
+	/* NUL detection works on the principle that (X - 1) & (~X) & 0x80
+	   (=> (X - 1) & ~(X | 0x7f)) is non-zero iff a byte is zero, and
+	   can be done in parallel across the entire word.  */
+	/* Start of performance-critical section  -- one 64B cache line.  */
 .Lloop_aligned:
 	ldr	data1, [src1], #8
 	ldr	data2, [src2], #8
@@ -80,23 +78,24 @@ SYM_FUNC_START_WEAK_PI(strncmp)
 	subs	limit_wd, limit_wd, #1
 	sub	tmp1, data1, zeroones
 	orr	tmp2, data1, #REP8_7f
-	eor	diff, data1, data2  /* Non-zero if differences found.  */
-	csinv	endloop, diff, xzr, pl  /* Last Dword or differences.*/
-	bics	has_nul, tmp1, tmp2 /* Non-zero if NUL terminator.  */
+	eor	diff, data1, data2	/* Non-zero if differences found.  */
+	csinv	endloop, diff, xzr, pl	/* Last Dword or differences.  */
+	bics	has_nul, tmp1, tmp2	/* Non-zero if NUL terminator.  */
 	ccmp	endloop, #0, #0, eq
 	b.eq	.Lloop_aligned
+	/* End of performance-critical section  -- one 64B cache line.  */
 
-	/*Not reached the limit, must have found the end or a diff.  */
+	/* Not reached the limit, must have found the end or a diff.  */
 	tbz	limit_wd, #63, .Lnot_limit
 
 	/* Limit % 8 == 0 => all bytes significant.  */
 	ands	limit, limit, #7
 	b.eq	.Lnot_limit
 
-	lsl	limit, limit, #3    /* Bits -> bytes.  */
+	lsl	limit, limit, #3	/* Bits -> bytes.  */
 	mov	mask, #~0
-CPU_BE( lsr	mask, mask, limit )
-CPU_LE( lsl	mask, mask, limit )
+CPU_BE(lsr	mask, mask, limit)
+CPU_LE(lsl	mask, mask, limit)
 	bic	data1, data1, mask
 	bic	data2, data2, mask
 
@@ -105,192 +104,156 @@ CPU_LE( lsl	mask, mask, limit )
 
 .Lnot_limit:
 	orr	syndrome, diff, has_nul
-	b	.Lcal_cmpresult
+
+	CPU_LE(rev	syndrome, syndrome)
+	CPU_LE(rev	data1, data1)
+	/* The MS-non-zero bit of the syndrome marks either the first bit
+	   that is different, or the top bit of the first zero byte.
+	   Shifting left now will bring the critical information into the
+	   top bits.  */
+	CPU_LE(clz	pos, syndrome)
+	CPU_LE(rev	data2, data2)
+	CPU_LE(lsl	data1, data1, pos)
+	CPU_LE(lsl	data2, data2, pos)
+	/* But we need to zero-extend (char is unsigned) the value and then
+	   perform a signed 32-bit subtraction.  */
+	CPU_LE(lsr	data1, data1, #56)
+	CPU_LE(sub	result, data1, data2, lsr #56)
+	CPU_LE(ret)
+	/* For big-endian we cannot use the trick with the syndrome value
+	   as carry-propagation can corrupt the upper bits if the trailing
+	   bytes in the string contain 0x01.  */
+	/* However, if there is no NUL byte in the dword, we can generate
+	   the result directly.  We can't just subtract the bytes as the
+	   MSB might be significant.  */
+	CPU_BE(cbnz	has_nul, 1f)
+	CPU_BE(cmp	data1, data2)
+	CPU_BE(cset	result, ne)
+	CPU_BE(cneg	result, result, lo)
+	CPU_BE(ret)
+1:
+	/* Re-compute the NUL-byte detection, using a byte-reversed value.  */
+	CPU_BE(rev	tmp3, data1)
+	CPU_BE(sub	tmp1, tmp3, zeroones)
+	CPU_BE(orr	tmp2, tmp3, #REP8_7f)
+	CPU_BE(bic	has_nul, tmp1, tmp2)
+	CPU_BE(rev	has_nul, has_nul)
+	CPU_BE(orr	syndrome, diff, has_nul)
+	CPU_BE(clz	pos, syndrome)
+	/* The MS-non-zero bit of the syndrome marks either the first bit
+	   that is different, or the top bit of the first zero byte.
+	   Shifting left now will bring the critical information into the
+	   top bits.  */
+	CPU_BE(lsl	data1, data1, pos)
+	CPU_BE(lsl	data2, data2, pos)
+	/* But we need to zero-extend (char is unsigned) the value and then
+	   perform a signed 32-bit subtraction.  */
+	CPU_BE(lsr	data1, data1, #56)
+	CPU_BE(sub	result, data1, data2, lsr #56)
+	CPU_BE(ret)
 
 .Lmutual_align:
-	/*
-	* Sources are mutually aligned, but are not currently at an
-	* alignment boundary.  Round down the addresses and then mask off
-	* the bytes that precede the start point.
-	* We also need to adjust the limit calculations, but without
-	* overflowing if the limit is near ULONG_MAX.
-	*/
+	/* Sources are mutually aligned, but are not currently at an
+	   alignment boundary.  Round down the addresses and then mask off
+	   the bytes that precede the start point.
+	   We also need to adjust the limit calculations, but without
+	   overflowing if the limit is near ULONG_MAX.  */
 	bic	src1, src1, #7
 	bic	src2, src2, #7
 	ldr	data1, [src1], #8
-	neg	tmp3, tmp1, lsl #3  /* 64 - bits(bytes beyond align). */
+	neg	tmp3, count, lsl #3	/* 64 - bits(bytes beyond align). */
 	ldr	data2, [src2], #8
 	mov	tmp2, #~0
-	sub	limit_wd, limit, #1 /* limit != 0, so no underflow.  */
+	sub	limit_wd, limit, #1	/* limit != 0, so no underflow.  */
 	/* Big-endian.  Early bytes are at MSB.  */
-CPU_BE( lsl	tmp2, tmp2, tmp3 )	/* Shift (tmp1 & 63).  */
+	CPU_BE(lsl	tmp2, tmp2, tmp3)	/* Shift (count & 63).  */
 	/* Little-endian.  Early bytes are at LSB.  */
-CPU_LE( lsr	tmp2, tmp2, tmp3 )	/* Shift (tmp1 & 63).  */
-
+	CPU_LE(lsr	tmp2, tmp2, tmp3)	/* Shift (count & 63).  */
 	and	tmp3, limit_wd, #7
 	lsr	limit_wd, limit_wd, #3
-	/* Adjust the limit. Only low 3 bits used, so overflow irrelevant.*/
-	add	limit, limit, tmp1
-	add	tmp3, tmp3, tmp1
+	/* Adjust the limit. Only low 3 bits used, so overflow irrelevant.  */
+	add	limit, limit, count
+	add	tmp3, tmp3, count
 	orr	data1, data1, tmp2
 	orr	data2, data2, tmp2
 	add	limit_wd, limit_wd, tmp3, lsr #3
 	b	.Lstart_realigned
 
-/*when src1 offset is not equal to src2 offset...*/
+	.p2align 6
+	/* Don't bother with dwords for up to 16 bytes.  */
 .Lmisaligned8:
-	cmp	limit, #8
-	b.lo	.Ltiny8proc /*limit < 8... */
-	/*
-	* Get the align offset length to compare per byte first.
-	* After this process, one string's address will be aligned.*/
-	and	tmp1, src1, #7
-	neg	tmp1, tmp1
-	add	tmp1, tmp1, #8
-	and	tmp2, src2, #7
-	neg	tmp2, tmp2
-	add	tmp2, tmp2, #8
-	subs	tmp3, tmp1, tmp2
-	csel	pos, tmp1, tmp2, hi /*Choose the maximum. */
-	/*
-	* Here, limit is not less than 8, so directly run .Ltinycmp
-	* without checking the limit.*/
-	sub	limit, limit, pos
-.Ltinycmp:
+	cmp	limit, #16
+	b.hs	.Ltry_misaligned_words
+
+.Lbyte_loop:
+	/* Perhaps we can do better than this.  */
 	ldrb	data1w, [src1], #1
 	ldrb	data2w, [src2], #1
-	subs	pos, pos, #1
-	ccmp	data1w, #1, #0, ne  /* NZCV = 0b0000.  */
-	ccmp	data1w, data2w, #0, cs  /* NZCV = 0b0000.  */
-	b.eq	.Ltinycmp
-	cbnz	pos, 1f /*find the null or unequal...*/
-	cmp	data1w, #1
-	ccmp	data1w, data2w, #0, cs
-	b.eq	.Lstart_align /*the last bytes are equal....*/
-1:
+	subs	limit, limit, #1
+	ccmp	data1w, #1, #0, hi	/* NZCV = 0b0000.  */
+	ccmp	data1w, data2w, #0, cs	/* NZCV = 0b0000.  */
+	b.eq	.Lbyte_loop
+.Ldone:
 	sub	result, data1, data2
 	ret
-
-.Lstart_align:
+	/* Align the SRC1 to a dword by doing a bytewise compare and then do
+	   the dword loop.  */
+.Ltry_misaligned_words:
 	lsr	limit_wd, limit, #3
-	cbz	limit_wd, .Lremain8
-	/*process more leading bytes to make str1 aligned...*/
-	ands	xzr, src1, #7
-	b.eq	.Lrecal_offset
-	add	src1, src1, tmp3	/*tmp3 is positive in this branch.*/
-	add	src2, src2, tmp3
-	ldr	data1, [src1], #8
-	ldr	data2, [src2], #8
+	cbz	count, .Ldo_misaligned
 
-	sub	limit, limit, tmp3
+	neg	count, count
+	and	count, count, #7
+	sub	limit, limit, count
 	lsr	limit_wd, limit, #3
-	subs	limit_wd, limit_wd, #1
 
-	sub	tmp1, data1, zeroones
-	orr	tmp2, data1, #REP8_7f
-	eor	diff, data1, data2  /* Non-zero if differences found.  */
-	csinv	endloop, diff, xzr, ne/*if limit_wd is 0,will finish the cmp*/
-	bics	has_nul, tmp1, tmp2
-	ccmp	endloop, #0, #0, eq /*has_null is ZERO: no null byte*/
-	b.ne	.Lunequal_proc
-	/*How far is the current str2 from the alignment boundary...*/
-	and	tmp3, tmp3, #7
-.Lrecal_offset:
-	neg	pos, tmp3
-.Lloopcmp_proc:
-	/*
-	* Divide the eight bytes into two parts. First,backwards the src2
-	* to an alignment boundary,load eight bytes from the SRC2 alignment
-	* boundary,then compare with the relative bytes from SRC1.
-	* If all 8 bytes are equal,then start the second part's comparison.
-	* Otherwise finish the comparison.
-	* This special handle can garantee all the accesses are in the
-	* thread/task space in avoid to overrange access.
-	*/
-	ldr	data1, [src1,pos]
-	ldr	data2, [src2,pos]
-	sub	tmp1, data1, zeroones
-	orr	tmp2, data1, #REP8_7f
-	bics	has_nul, tmp1, tmp2 /* Non-zero if NUL terminator.  */
-	eor	diff, data1, data2  /* Non-zero if differences found.  */
-	csinv	endloop, diff, xzr, eq
-	cbnz	endloop, .Lunequal_proc
+.Lpage_end_loop:
+	ldrb	data1w, [src1], #1
+	ldrb	data2w, [src2], #1
+	cmp	data1w, #1
+	ccmp	data1w, data2w, #0, cs	/* NZCV = 0b0000.  */
+	b.ne	.Ldone
+	subs	count, count, #1
+	b.hi	.Lpage_end_loop
+
+.Ldo_misaligned:
+	/* Prepare ourselves for the next page crossing.  Unlike the aligned
+	   loop, we fetch 1 less dword because we risk crossing bounds on
+	   SRC2.  */
+	mov	count, #8
+	subs	limit_wd, limit_wd, #1
+	b.lo	.Ldone_loop
+.Lloop_misaligned:
+	and	tmp2, src2, #0xff8
+	eor	tmp2, tmp2, #0xff8
+	cbz	tmp2, .Lpage_end_loop
 
-	/*The second part process*/
 	ldr	data1, [src1], #8
 	ldr	data2, [src2], #8
-	subs	limit_wd, limit_wd, #1
 	sub	tmp1, data1, zeroones
 	orr	tmp2, data1, #REP8_7f
-	eor	diff, data1, data2  /* Non-zero if differences found.  */
-	csinv	endloop, diff, xzr, ne/*if limit_wd is 0,will finish the cmp*/
-	bics	has_nul, tmp1, tmp2
-	ccmp	endloop, #0, #0, eq /*has_null is ZERO: no null byte*/
-	b.eq	.Lloopcmp_proc
-
-.Lunequal_proc:
-	orr	syndrome, diff, has_nul
-	cbz	syndrome, .Lremain8
-.Lcal_cmpresult:
-	/*
-	* reversed the byte-order as big-endian,then CLZ can find the most
-	* significant zero bits.
-	*/
-CPU_LE( rev	syndrome, syndrome )
-CPU_LE( rev	data1, data1 )
-CPU_LE( rev	data2, data2 )
-	/*
-	* For big-endian we cannot use the trick with the syndrome value
-	* as carry-propagation can corrupt the upper bits if the trailing
-	* bytes in the string contain 0x01.
-	* However, if there is no NUL byte in the dword, we can generate
-	* the result directly.  We can't just subtract the bytes as the
-	* MSB might be significant.
-	*/
-CPU_BE( cbnz	has_nul, 1f )
-CPU_BE( cmp	data1, data2 )
-CPU_BE( cset	result, ne )
-CPU_BE( cneg	result, result, lo )
-CPU_BE( ret )
-CPU_BE( 1: )
-	/* Re-compute the NUL-byte detection, using a byte-reversed value.*/
-CPU_BE( rev	tmp3, data1 )
-CPU_BE( sub	tmp1, tmp3, zeroones )
-CPU_BE( orr	tmp2, tmp3, #REP8_7f )
-CPU_BE( bic	has_nul, tmp1, tmp2 )
-CPU_BE( rev	has_nul, has_nul )
-CPU_BE( orr	syndrome, diff, has_nul )
-	/*
-	* The MS-non-zero bit of the syndrome marks either the first bit
-	* that is different, or the top bit of the first zero byte.
-	* Shifting left now will bring the critical information into the
-	* top bits.
-	*/
-	clz	pos, syndrome
-	lsl	data1, data1, pos
-	lsl	data2, data2, pos
-	/*
-	* But we need to zero-extend (char is unsigned) the value and then
-	* perform a signed 32-bit subtraction.
-	*/
-	lsr	data1, data1, #56
-	sub	result, data1, data2, lsr #56
-	ret
-
-.Lremain8:
-	/* Limit % 8 == 0 => all bytes significant.  */
-	ands	limit, limit, #7
-	b.eq	.Lret0
-.Ltiny8proc:
-	ldrb	data1w, [src1], #1
-	ldrb	data2w, [src2], #1
-	subs	limit, limit, #1
+	eor	diff, data1, data2	/* Non-zero if differences found.  */
+	bics	has_nul, tmp1, tmp2	/* Non-zero if NUL terminator.  */
+	ccmp	diff, #0, #0, eq
+	b.ne	.Lnot_limit
+	subs	limit_wd, limit_wd, #1
+	b.pl	.Lloop_misaligned
 
-	ccmp	data1w, #1, #0, ne  /* NZCV = 0b0000.  */
-	ccmp	data1w, data2w, #0, cs  /* NZCV = 0b0000.  */
-	b.eq	.Ltiny8proc
-	sub	result, data1, data2
-	ret
+.Ldone_loop:
+	/* We found a difference or a NULL before the limit was reached.  */
+	and	limit, limit, #7
+	cbz	limit, .Lnot_limit
+	/* Read the last word.  */
+	sub	src1, src1, 8
+	sub	src2, src2, 8
+	ldr	data1, [src1, limit]
+	ldr	data2, [src2, limit]
+	sub	tmp1, data1, zeroones
+	orr	tmp2, data1, #REP8_7f
+	eor	diff, data1, data2	/* Non-zero if differences found.  */
+	bics	has_nul, tmp1, tmp2	/* Non-zero if NUL terminator.  */
+	ccmp	diff, #0, #0, eq
+	b.ne	.Lnot_limit
 
 .Lret0:
 	mov	result, #0
-- 
2.17.1

