Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F785C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ABF620727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgENOdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:33:07 -0400
Received: from foss.arm.com ([217.140.110.172]:37764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbgENOdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:33:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 121FD1FB;
        Thu, 14 May 2020 07:33:02 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 222C43F71E;
        Thu, 14 May 2020 07:33:01 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/13] arm64: Add fixup routines for usercopy store exceptions
Date:   Thu, 14 May 2020 14:32:27 +0000
Message-Id: <20200514143227.605-14-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514143227.605-1-oli.swede@arm.com>
References: <20200514143227.605-1-oli.swede@arm.com>
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
 arch/arm64/lib/copy_user_fixup.S | 96 ++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/lib/copy_user_fixup.S b/arch/arm64/lib/copy_user_fixup.S
index 256a33522749..d836fa6cc333 100644
--- a/arch/arm64/lib/copy_user_fixup.S
+++ b/arch/arm64/lib/copy_user_fixup.S
@@ -168,9 +168,105 @@ addr	.req	x15
 	sub	x0, x0, tmp1
 	b	L(end_fixup)
 
+	/*
+	 * The following three routines are directed to from faults
+	 * on store instructions.
+	 */
 9996:
+	/*
+	 * This routine is reached from faults on store instructions
+	 * where the target address has been specified relative to the
+	 * start of the user space memory buffer, and is also not
+	 * guaranteed to be aligned to 16B.
+	 *
+	 * For copy sizes <= 128 bytes, the stores occur in-order,
+	 * so it has copied up to (addr-dst)&~15.
+	 * For copy sizes > 128 bytes, this should only be directed
+	 * to from a fault on the first store of the long copy, before
+	 * the algorithm aligns dst to 16B, so no bytes have copied at
+	 * this point.
+	 */
+
+	/* Retrieve useful information & free the stack area */
+	ldr	dst, [sp], #16		// dst: x3
+	ldr	count, [sp], #16	// count: x2
+
+	cmp	count, 0
+	b.eq	L(none_copied)
+	cmp	count, 3
+	sub	x0, addr, dst // relative fault offset in buffer
+	bic	x0, x0, 7 // bytes already copied (steps of 8B stores)
+	sub	x0, count, x0 // bytes yet to copy
+	b.le	L(end_fixup)
+	cmp	count, 32
+	b.le	L(none_copied)
+	cmp	count, 128
+	sub	x0, addr, dst // relative fault offset in buffer
+	bic	x0, x0, 15 // bytes already copied (steps of 16B stores)
+	sub	x0, count, x0 // bytes yet to copy
+	b.le	L(end_fixup)
+	b	L(none_copied)
+
 9997:
+	/*
+	 * This routine is reached from faults on store instructions
+	 * where the target address has been specified relative to the
+	 * end of the user space memory buffer and is also not
+	 * guaranteed to be aligned with 16B.
+	 *
+	 * In this scenario, the the copy is close to completion and
+	 * has occurred in-order, so the last few bytes to copy can
+	 * easily be calculated.
+	 *
+	 * This caters for the overlapping stage, as it could
+	 * potentially fault on data that has already been copied.
+	 */
+
+	/* Retrieve useful information & free the stack area */
+	ldr	dst, [sp], #16		// dst: x3
+	ldr	count, [sp], #16	// count: x2
+	add	dstend, dst, count
+
+	sub	x0, dstend, addr
+	bic	x0, x0, 15 // remaining bytes to copy
+	b	L(end_fixup)
+
 9998:
+	/*
+	 * This routine is reached from faults on store instructions
+	 * where the target address has been specified relative to the
+	 * start of the user space memory buffer, and is also guaranteed
+	 * to be aligned to 16B.
+	 *
+	 * These instrucions occur after the algorithm aligns dst to 16B,
+	 * after the very first store in a long copy. It then continues
+	 * copying from dst+16 onwards.
+	 *
+	 * This could result in an overlapping copy if the original dst
+	 * is unaligned with 16B. However, this implies that it could
+	 * potentially fault on data that has already been copied, if
+	 * the fault occurs in the first aligned access.
+	 *
+	 * We want to report that 16 bytes has already successfully copied in this case.
+	*/
+
+	/* Retrieve useful information & free the stack area */
+	ldr	dst, [sp], #16		// dst: x3
+	ldr	count, [sp], #16	// count: x2
+
+	bic	tmp1, dst, 15 // aligned dst
+	bic	x0, addr, 15
+	sub	x0, x0, tmp1 // relative fault offset
+	cmp	x0, 0 // unexpected range for this fixup
+	b.eq	L(none_copied)
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

