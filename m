Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E655AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F8420768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgF3Ts5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:48:57 -0400
Received: from foss.arm.com ([217.140.110.172]:32962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbgF3Tsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:48:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91AAB1045;
        Tue, 30 Jun 2020 12:48:52 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 899D43F73C;
        Tue, 30 Jun 2020 12:48:51 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/14] arm64: Import latest optimization of memcpy
Date:   Tue, 30 Jun 2020 19:48:16 +0000
Message-Id: <20200630194822.1082-9-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630194822.1082-1-oli.swede@arm.com>
References: <20200630194822.1082-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Tebbs <sam.tebbs@arm.com>

Import the latest memcpy implementation into memcpy,
copy_{from, to and in}_user.
The implementation of the user routines is separated into two forms:
one for when UAO is enabled and one for when UAO is disabled, with
the two being chosen between with a runtime patch.
This avoids executing the many NOPs emitted when UAO is disabled.

The project containing optimized implementations for various library
functions has now been renamed from 'cortex-strings' to
'optimized-routines', and the new upstream source is
string/aarch64/memcpy.S as of commit 4c175c8be12 in
https://github.com/ARM-software/optimized-routines.

Signed-off-by: Sam Tebbs <sam.tebbs@arm.com>
[ rm: add UAO fixups, streamline copy_exit paths, expand commit message ]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[ os: import newer memcpy algorithm, replace innaccurate fixup routine
  with placeholder, update commit message ]
Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/include/asm/alternative.h |  36 ---
 arch/arm64/lib/copy_from_user.S      | 113 ++++++--
 arch/arm64/lib/copy_in_user.S        | 129 +++++++--
 arch/arm64/lib/copy_template.S       | 375 +++++++++++++++------------
 arch/arm64/lib/copy_template_user.S  |  24 ++
 arch/arm64/lib/copy_to_user.S        | 112 ++++++--
 arch/arm64/lib/copy_user_fixup.S     |   9 +
 arch/arm64/lib/memcpy.S              |  47 ++--
 8 files changed, 552 insertions(+), 293 deletions(-)
 create mode 100644 arch/arm64/lib/copy_template_user.S
 create mode 100644 arch/arm64/lib/copy_user_fixup.S

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 5e5dc05d63a0..7ab752104170 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -230,36 +230,6 @@ alternative_endif
  * unprivileged instructions, and USER() only works for single instructions.
  */
 #ifdef CONFIG_ARM64_UAO
-	.macro uao_ldp l, reg1, reg2, addr, post_inc
-		alternative_if_not ARM64_HAS_UAO
-8888:			ldp	\reg1, \reg2, [\addr], \post_inc;
-8889:			nop;
-			nop;
-		alternative_else
-			ldtr	\reg1, [\addr];
-			ldtr	\reg2, [\addr, #8];
-			add	\addr, \addr, \post_inc;
-		alternative_endif
-
-		_asm_extable	8888b,\l;
-		_asm_extable	8889b,\l;
-	.endm
-
-	.macro uao_stp l, reg1, reg2, addr, post_inc
-		alternative_if_not ARM64_HAS_UAO
-8888:			stp	\reg1, \reg2, [\addr], \post_inc;
-8889:			nop;
-			nop;
-		alternative_else
-			sttr	\reg1, [\addr];
-			sttr	\reg2, [\addr, #8];
-			add	\addr, \addr, \post_inc;
-		alternative_endif
-
-		_asm_extable	8888b,\l;
-		_asm_extable	8889b,\l;
-	.endm
-
 	.macro uao_user_alternative l, inst, alt_inst, reg, addr, post_inc
 		alternative_if_not ARM64_HAS_UAO
 8888:			\inst	\reg, [\addr], \post_inc;
@@ -272,12 +242,6 @@ alternative_endif
 		_asm_extable	8888b,\l;
 	.endm
 #else
-	.macro uao_ldp l, reg1, reg2, addr, post_inc
-		USER(\l, ldp \reg1, \reg2, [\addr], \post_inc)
-	.endm
-	.macro uao_stp l, reg1, reg2, addr, post_inc
-		USER(\l, stp \reg1, \reg2, [\addr], \post_inc)
-	.endm
 	.macro uao_user_alternative l, inst, alt_inst, reg, addr, post_inc
 		USER(\l, \inst \reg, [\addr], \post_inc)
 	.endm
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 0f8a3a9e3795..86945e84c009 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -19,50 +19,111 @@
  * Returns:
  *	x0 - bytes not copied
  */
+	8888: ldtrb \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro strb1 reg, ptr, offset=0
+	strb \reg, [\ptr, \offset]
+	.endm
+
+	.macro ldrb1_reg reg, ptr, offset
+	add \ptr, \ptr, \offset
+	8888: ldtrb \reg, [\ptr]
+	sub \ptr, \ptr, \offset
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro strb1_reg reg, ptr, offset
+	strb \reg, [\ptr, \offset]
+	.endm
 
-	.macro ldrb1 reg, ptr, val
-	uao_user_alternative 9998f, ldrb, ldtrb, \reg, \ptr, \val
+	.macro ldr1 reg, ptr, offset=0
+	8888: ldtr \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
-	.macro strb1 reg, ptr, val
-	strb \reg, [\ptr], \val
+	.macro str1 reg, ptr, offset=0
+	str \reg, [\ptr, \offset]
 	.endm
 
-	.macro ldrh1 reg, ptr, val
-	uao_user_alternative 9998f, ldrh, ldtrh, \reg, \ptr, \val
+	.macro ldp1 regA, regB, ptr, offset=0
+	8888: ldtr \regA, [\ptr, \offset]
+	8889: ldtr \regB, [\ptr, \offset + 8]
+	_asm_extable_faultaddr	8888b,9998f;
+	_asm_extable_faultaddr	8889b,9998f;
 	.endm
 
-	.macro strh1 reg, ptr, val
-	strh \reg, [\ptr], \val
+	.macro stp1 regA, regB, ptr, offset=0
+	stp \regA, \regB, [\ptr, \offset]
 	.endm
 
-	.macro ldr1 reg, ptr, val
-	uao_user_alternative 9998f, ldr, ldtr, \reg, \ptr, \val
+	.macro ldp1_pre regA, regB, ptr, offset
+	8888: ldtr \regA, [\ptr, \offset]
+	8889: ldtr \regB, [\ptr, \offset + 8]
+	add \ptr, \ptr, \offset
+	_asm_extable_faultaddr	8888b,9998f;
+	_asm_extable_faultaddr	8889b,9998f;
 	.endm
 
-	.macro str1 reg, ptr, val
-	str \reg, [\ptr], \val
+	.macro stp1_pre regA, regB, ptr, offset
+	stp \regA, \regB, [\ptr, \offset]!
 	.endm
 
-	.macro ldp1 reg1, reg2, ptr, val
-	uao_ldp 9998f, \reg1, \reg2, \ptr, \val
+	.macro ldrb1_nuao reg, ptr, offset=0
+	8888: ldrb \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
-	.macro stp1 reg1, reg2, ptr, val
-	stp \reg1, \reg2, [\ptr], \val
+	.macro strb1_nuao reg, ptr, offset=0
+	strb \reg, [\ptr, \offset]
+	.endm
+
+	.macro ldrb1_nuao_reg reg, ptr, offset=0
+	8888: ldrb \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro strb1_nuao_reg reg, ptr, offset=0
+	strb \reg, [\ptr, \offset]
+	.endm
+
+	.macro ldr1_nuao reg, ptr, offset=0
+	8888: ldr \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro str1_nuao reg, ptr, offset=0
+	str \reg, [\ptr, \offset]
+	.endm
+
+	.macro ldp1_nuao  regA, regB, ptr, offset=0
+	8888: ldp \regA, \regB, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro stp1_nuao regA, regB, ptr, offset=0
+	stp \regA, \regB, [\ptr, \offset]
+	.endm
+
+	.macro ldp1_pre_nuao regA, regB, ptr, offset
+	8888: ldp \regA, \regB, [\ptr, \offset]!
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro stp1_pre_nuao regA, regB, ptr, offset
+	stp \regA, \regB, [\ptr, \offset]!
+	.endm
+
+	.macro copy_exit
+	b	.Luaccess_finish
 	.endm
 
-end	.req	x5
 SYM_FUNC_START(__arch_copy_from_user)
-	add	end, x0, x2
-#include "copy_template.S"
-	mov	x0, #0				// Nothing to copy
+#include "copy_template_user.S"
+.Luaccess_finish:
+	mov	x0, #0
 	ret
 SYM_FUNC_END(__arch_copy_from_user)
 EXPORT_SYMBOL(__arch_copy_from_user)
-
-	.section .fixup,"ax"
-	.align	2
-9998:	sub	x0, end, dst			// bytes not copied
-	ret
-	.previous
+#include "copy_user_fixup.S"
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 80e37ada0ee1..77dfccc618b6 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -21,50 +21,129 @@
  * Returns:
  *	x0 - bytes not copied
  */
-	.macro ldrb1 reg, ptr, val
-	uao_user_alternative 9998f, ldrb, ldtrb, \reg, \ptr, \val
+	.macro ldrb1 reg, ptr, offset=0
+	8888: ldtrb \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
-	.macro strb1 reg, ptr, val
-	uao_user_alternative 9998f, strb, sttrb, \reg, \ptr, \val
+	.macro strb1 reg, ptr, offset=0
+	8888: sttrb \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
-	.macro ldrh1 reg, ptr, val
-	uao_user_alternative 9998f, ldrh, ldtrh, \reg, \ptr, \val
+	.macro ldrb1_reg reg, ptr, offset
+	add \ptr, \ptr, \offset
+	8888: ldtrb \reg, [\ptr]
+	sub \ptr, \ptr, \offset
+	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
-	.macro strh1 reg, ptr, val
-	uao_user_alternative 9998f, strh, sttrh, \reg, \ptr, \val
+	.macro strb1_reg reg, ptr, offset
+	add \ptr, \ptr, \offset
+	8888: sttrb \reg, [\ptr]
+	sub \ptr, \ptr, \offset
+	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
-	.macro ldr1 reg, ptr, val
-	uao_user_alternative 9998f, ldr, ldtr, \reg, \ptr, \val
+	.macro ldr1 reg, ptr, offset=0
+	8888: ldtr \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
-	.macro str1 reg, ptr, val
-	uao_user_alternative 9998f, str, sttr, \reg, \ptr, \val
+	.macro str1 reg, ptr, offset=0
+	8888: sttr \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
-	.macro ldp1 reg1, reg2, ptr, val
-	uao_ldp 9998f, \reg1, \reg2, \ptr, \val
+	.macro ldp1 regA, regB, ptr, offset=0
+	8888: ldtr \regA, [\ptr, \offset]
+	8889: ldtr \regB, [\ptr, \offset + 8]
+	_asm_extable_faultaddr	8888b,9998f;
+	_asm_extable_faultaddr	8889b,9998f;
 	.endm
 
-	.macro stp1 reg1, reg2, ptr, val
-	uao_stp 9998f, \reg1, \reg2, \ptr, \val
+	.macro stp1 regA, regB, ptr, offset=0
+	8888: sttr \regA, [\ptr, \offset]
+	8889: sttr \regB, [\ptr, \offset + 8]
+	_asm_extable_faultaddr	8888b,9998f;
+	_asm_extable_faultaddr	8889b,9998f;
 	.endm
 
-end	.req	x5
+	.macro ldp1_pre regA, regB, ptr, offset
+	8888: ldtr \regA, [\ptr, \offset]
+	8889: ldtr \regB, [\ptr, \offset + 8]
+	add \ptr, \ptr, \offset
+	_asm_extable_faultaddr	8888b,9998f;
+	_asm_extable_faultaddr	8889b,9998f;
+	.endm
+
+	.macro stp1_pre regA, regB, ptr, offset
+	8888: sttr \regA, [\ptr, \offset]
+	8889: sttr \regB, [\ptr, \offset + 8]
+	add \ptr, \ptr, \offset
+	_asm_extable_faultaddr	8888b,9998f;
+	_asm_extable_faultaddr	8889b,9998f;
+	.endm
+
+	.macro ldrb1_nuao reg, ptr, offset=0
+	8888: ldrb \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro strb1_nuao reg, ptr, offset=0
+	8888: strb \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro ldrb1_nuao_reg reg, ptr, offset=0
+	8888: ldrb \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro strb1_nuao_reg reg, ptr, offset=0
+	8888: strb \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro ldr1_nuao reg, ptr, offset=0
+	8888: ldr \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro str1_nuao reg, ptr, offset=0
+	8888: str \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro ldp1_nuao  regA, regB, ptr, offset=0
+	8888: ldp \regA, \regB, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro stp1_nuao regA, regB, ptr, offset=0
+	8888: stp \regA, \regB, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro ldp1_pre_nuao regA, regB, ptr, offset
+	8888: ldp \regA, \regB, [\ptr, \offset]!
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro stp1_pre_nuao regA, regB, ptr, offset
+	8888: stp \regA, \regB, [\ptr, \offset]!
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro copy_exit
+	b	.Luaccess_finish
+	.endm
 
 SYM_FUNC_START(__arch_copy_in_user)
-	add	end, x0, x2
-#include "copy_template.S"
+#include "copy_template_user.S"
+.Luaccess_finish:
 	mov	x0, #0
 	ret
 SYM_FUNC_END(__arch_copy_in_user)
 EXPORT_SYMBOL(__arch_copy_in_user)
-
-	.section .fixup,"ax"
-	.align	2
-9998:	sub	x0, end, dst			// bytes not copied
-	ret
-	.previous
+#include "copy_user_fixup.S"
diff --git a/arch/arm64/lib/copy_template.S b/arch/arm64/lib/copy_template.S
index 488df234c49a..90b5f63ff227 100644
--- a/arch/arm64/lib/copy_template.S
+++ b/arch/arm64/lib/copy_template.S
@@ -1,13 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2013 ARM Ltd.
- * Copyright (C) 2013 Linaro.
+ * Copyright (c) 2012 Linaro Limited. All rights reserved.
+ * Copyright (c) 2015 ARM Ltd. All rights reserved.
  *
- * This code is based on glibc cortex strings work originally authored by Linaro
- * be found @
+ * This code is based on work originally authored by Linaro,
+ * found at:
  *
- * http://bazaar.launchpad.net/~linaro-toolchain-dev/cortex-strings/trunk/
- * files/head:/src/aarch64/
+ * https://github.com/ARM-software/optimized-routines
  */
 
 
@@ -21,161 +20,209 @@
  * Returns:
  *	x0 - dest
  */
-dstin	.req	x0
-src	.req	x1
-count	.req	x2
-tmp1	.req	x3
-tmp1w	.req	w3
-tmp2	.req	x4
-tmp2w	.req	w4
-dst	.req	x6
-
-A_l	.req	x7
-A_h	.req	x8
-B_l	.req	x9
-B_h	.req	x10
-C_l	.req	x11
-C_h	.req	x12
-D_l	.req	x13
-D_h	.req	x14
-
-	mov	dst, dstin
-	cmp	count, #16
-	/*When memory length is less than 16, the accessed are not aligned.*/
-	b.lo	.Ltiny15
-
-	neg	tmp2, src
-	ands	tmp2, tmp2, #15/* Bytes to reach alignment. */
-	b.eq	.LSrcAligned
-	sub	count, count, tmp2
-	/*
-	* Copy the leading memory data from src to dst in an increasing
-	* address order.By this way,the risk of overwriting the source
-	* memory data is eliminated when the distance between src and
-	* dst is less than 16. The memory accesses here are alignment.
-	*/
-	tbz	tmp2, #0, 1f
-	ldrb1	tmp1w, src, #1
-	strb1	tmp1w, dst, #1
-1:
-	tbz	tmp2, #1, 2f
-	ldrh1	tmp1w, src, #2
-	strh1	tmp1w, dst, #2
-2:
-	tbz	tmp2, #2, 3f
-	ldr1	tmp1w, src, #4
-	str1	tmp1w, dst, #4
-3:
-	tbz	tmp2, #3, .LSrcAligned
-	ldr1	tmp1, src, #8
-	str1	tmp1, dst, #8
-
-.LSrcAligned:
-	cmp	count, #64
-	b.ge	.Lcpy_over64
-	/*
-	* Deal with small copies quickly by dropping straight into the
-	* exit block.
-	*/
-.Ltail63:
-	/*
-	* Copy up to 48 bytes of data. At this point we only need the
-	* bottom 6 bits of count to be accurate.
-	*/
-	ands	tmp1, count, #0x30
-	b.eq	.Ltiny15
-	cmp	tmp1w, #0x20
-	b.eq	1f
-	b.lt	2f
-	ldp1	A_l, A_h, src, #16
-	stp1	A_l, A_h, dst, #16
-1:
-	ldp1	A_l, A_h, src, #16
-	stp1	A_l, A_h, dst, #16
-2:
-	ldp1	A_l, A_h, src, #16
-	stp1	A_l, A_h, dst, #16
-.Ltiny15:
-	/*
-	* Prefer to break one ldp/stp into several load/store to access
-	* memory in an increasing address order,rather than to load/store 16
-	* bytes from (src-16) to (dst-16) and to backward the src to aligned
-	* address,which way is used in original cortex memcpy. If keeping
-	* the original memcpy process here, memmove need to satisfy the
-	* precondition that src address is at least 16 bytes bigger than dst
-	* address,otherwise some source data will be overwritten when memove
-	* call memcpy directly. To make memmove simpler and decouple the
-	* memcpy's dependency on memmove, withdrew the original process.
-	*/
-	tbz	count, #3, 1f
-	ldr1	tmp1, src, #8
-	str1	tmp1, dst, #8
-1:
-	tbz	count, #2, 2f
-	ldr1	tmp1w, src, #4
-	str1	tmp1w, dst, #4
-2:
-	tbz	count, #1, 3f
-	ldrh1	tmp1w, src, #2
-	strh1	tmp1w, dst, #2
-3:
-	tbz	count, #0, .Lexitfunc
-	ldrb1	tmp1w, src, #1
-	strb1	tmp1w, dst, #1
-
-	b	.Lexitfunc
-
-.Lcpy_over64:
-	subs	count, count, #128
-	b.ge	.Lcpy_body_large
-	/*
-	* Less than 128 bytes to copy, so handle 64 here and then jump
-	* to the tail.
-	*/
-	ldp1	A_l, A_h, src, #16
-	stp1	A_l, A_h, dst, #16
-	ldp1	B_l, B_h, src, #16
-	ldp1	C_l, C_h, src, #16
-	stp1	B_l, B_h, dst, #16
-	stp1	C_l, C_h, dst, #16
-	ldp1	D_l, D_h, src, #16
-	stp1	D_l, D_h, dst, #16
-
-	tst	count, #0x3f
-	b.ne	.Ltail63
-	b	.Lexitfunc
-
-	/*
-	* Critical loop.  Start at a new cache line boundary.  Assuming
-	* 64 bytes per line this ensures the entire loop is in one line.
-	*/
-	.p2align	L1_CACHE_SHIFT
-.Lcpy_body_large:
-	/* pre-get 64 bytes data. */
-	ldp1	A_l, A_h, src, #16
-	ldp1	B_l, B_h, src, #16
-	ldp1	C_l, C_h, src, #16
-	ldp1	D_l, D_h, src, #16
-1:
-	/*
-	* interlace the load of next 64 bytes data block with store of the last
-	* loaded 64 bytes data.
-	*/
-	stp1	A_l, A_h, dst, #16
-	ldp1	A_l, A_h, src, #16
-	stp1	B_l, B_h, dst, #16
-	ldp1	B_l, B_h, src, #16
-	stp1	C_l, C_h, dst, #16
-	ldp1	C_l, C_h, src, #16
-	stp1	D_l, D_h, dst, #16
-	ldp1	D_l, D_h, src, #16
-	subs	count, count, #64
-	b.ge	1b
-	stp1	A_l, A_h, dst, #16
-	stp1	B_l, B_h, dst, #16
-	stp1	C_l, C_h, dst, #16
-	stp1	D_l, D_h, dst, #16
-
-	tst	count, #0x3f
-	b.ne	.Ltail63
-.Lexitfunc:
+ #define dstin	x0
+ #define src	x1
+ #define count	x2
+ #define dst	x3
+ #define srcend	x4
+ #define dstend	x5
+ #define A_l	x6
+ #define A_lw	w6
+ #define A_h	x7
+ #define B_l	x8
+ #define B_lw	w8
+ #define B_h	x9
+ #define C_l	x10
+ #define C_lw	w10
+ #define C_h	x11
+ #define D_l	x12
+ #define D_h	x13
+ #define E_l	x14
+ #define E_h	x15
+ #define F_l	x16
+ #define F_h	x17
+ #define G_l	count
+ #define G_h	dst
+ #define H_l	src
+ #define H_h	srcend
+ #define tmp1	x14
+
+	add	srcend, src, count
+	add	dstend, dstin, count
+	cmp	count, 128
+	b.hi	L(copy_long)
+	cmp	count, 32
+	b.hi	L(copy32_128)
+
+	/* Small copies: 0..32 bytes. */
+	cmp	count, 16
+	b.lo	L(copy16)
+	ldp1	A_l, A_h, src
+	ldp1	D_l, D_h, srcend, -16
+	stp1	A_l, A_h, dstin
+	stp1	D_l, D_h, dstend, -16
+	copy_exit
+
+	/* Copy 8-15 bytes. */
+L(copy16):
+	tbz	count, 3, L(copy8)
+	ldr1	A_l, src
+	ldr1	A_h, srcend, -8
+	str1	A_l, dstin
+	str1	A_h, dstend, -8
+	copy_exit
+
+	.p2align 3
+	/* Copy 4-7 bytes. */
+L(copy8):
+	tbz	count, 2, L(copy4)
+	ldr1	A_lw, src
+	ldr1	B_lw, srcend, -4
+	str1	A_lw, dstin
+	str1	B_lw, dstend, -4
+	copy_exit
+
+	/* Copy 0..3 bytes using a branchless sequence. */
+L(copy4):
+	cbz	count, L(copy0)
+	lsr	tmp1, count, 1
+	ldrb1	A_lw, src
+	ldrb1	C_lw, srcend, -1
+	ldrb1_reg	B_lw, src, tmp1
+	strb1	A_lw, dstin
+	strb1_reg	B_lw, dstin, tmp1
+	strb1	C_lw, dstend, -1
+L(copy0):
+	copy_exit
+
+	.p2align 4
+	/* Medium copies: 33..128 bytes. */
+L(copy32_128):
+	ldp1	A_l, A_h, src
+	ldp1	B_l, B_h, src, 16
+	ldp1	C_l, C_h, srcend, -32
+	ldp1	D_l, D_h, srcend, -16
+	cmp	count, 64
+	b.hi	L(copy128)
+	stp1	A_l, A_h, dstin
+	stp1	B_l, B_h, dstin, 16
+	stp1	C_l, C_h, dstend, -32
+	stp1	D_l, D_h, dstend, -16
+	copy_exit
+
+	.p2align 4
+	/* Copy 65..128 bytes. */
+L(copy128):
+	ldp1	E_l, E_h, src, 32
+	ldp1	F_l, F_h, src, 48
+	cmp	count, 96
+	b.ls	L(copy96)
+	ldp1	G_l, G_h, srcend, -64
+	ldp1	H_l, H_h, srcend, -48
+	stp1	G_l, G_h, dstend, -64
+	stp1	H_l, H_h, dstend, -48
+L(copy96):
+	stp1	A_l, A_h, dstin
+	stp1	B_l, B_h, dstin, 16
+	stp1	E_l, E_h, dstin, 32
+	stp1	F_l, F_h, dstin, 48
+	stp1	C_l, C_h, dstend, -32
+	stp1	D_l, D_h, dstend, -16
+	copy_exit
+
+	.p2align 4
+	/* Copy more than 128 bytes. */
+L(copy_long):
+	/* Use backwards copy if there is an overlap. */
+	sub	tmp1, dstin, src
+	cbz	tmp1, L(copy0)
+	cmp	tmp1, count
+	b.lo	L(copy_long_backwards)
+
+	/* Copy 16 bytes and then align dst to 16-byte alignment. */
+
+	ldp1	D_l, D_h, src
+	and	tmp1, dstin, 15
+	bic	dst, dstin, 15
+	sub	src, src, tmp1
+	add	count, count, tmp1	/* Count is now 16 too large. */
+	ldp1	A_l, A_h, src, 16
+	stp1	D_l, D_h, dstin
+	ldp1	B_l, B_h, src, 32
+	ldp1	C_l, C_h, src, 48
+	ldp1_pre	D_l, D_h, src, 64
+	subs	count, count, 128 + 16 /* Test and readjust count. */
+	b.ls	L(copy64_from_end)
+
+L(loop64):
+	stp1	A_l, A_h, dst, 16
+	ldp1	A_l, A_h, src, 16
+	stp1	B_l, B_h, dst, 32
+	ldp1	B_l, B_h, src, 32
+	stp1	C_l, C_h, dst, 48
+	ldp1	C_l, C_h, src, 48
+	stp1_pre	D_l, D_h, dst, 64
+	ldp1_pre	D_l, D_h, src, 64
+	subs	count, count, 64
+	b.hi	L(loop64)
+
+	/* Write the last iteration and copy 64 bytes from the end. */
+L(copy64_from_end):
+	ldp1	E_l, E_h, srcend, -64
+	stp1	A_l, A_h, dst, 16
+	ldp1	A_l, A_h, srcend, -48
+	stp1	B_l, B_h, dst, 32
+	ldp1	B_l, B_h, srcend, -32
+	stp1	C_l, C_h, dst, 48
+	ldp1	C_l, C_h, srcend, -16
+	stp1	D_l, D_h, dst, 64
+	stp1	E_l, E_h, dstend, -64
+	stp1	A_l, A_h, dstend, -48
+	stp1	B_l, B_h, dstend, -32
+	stp1	C_l, C_h, dstend, -16
+	copy_exit
+
+	.p2align 4
+	/* Large backwards copy for overlapping copies.
+	   Copy 16 bytes and then align dst to 16-byte alignment. */
+L(copy_long_backwards):
+	ldp1	D_l, D_h, srcend, -16
+	and	tmp1, dstend, 15
+	sub	srcend, srcend, tmp1
+	sub	count, count, tmp1
+	ldp1	A_l, A_h, srcend, -16
+	stp1	D_l, D_h, dstend, -16
+	ldp1	B_l, B_h, srcend, -32
+	ldp1	C_l, C_h, srcend, -48
+	ldp1_pre	D_l, D_h, srcend, -64
+	sub	dstend, dstend, tmp1
+	subs	count, count, 128
+	b.ls	L(copy64_from_start)
+
+L(loop64_backwards):
+	stp1	A_l, A_h, dstend, -16
+	ldp1	A_l, A_h, srcend, -16
+	stp1	B_l, B_h, dstend, -32
+	ldp1	B_l, B_h, srcend, -32
+	stp1	C_l, C_h, dstend, -48
+	ldp1	C_l, C_h, srcend, -48
+	stp1_pre	D_l, D_h, dstend, -64
+	ldp1_pre	D_l, D_h, srcend, -64
+	subs	count, count, 64
+	b.hi	L(loop64_backwards)
+
+	/* Write the last iteration and copy 64 bytes from the start. */
+L(copy64_from_start):
+	ldp1	G_l, G_h, src, 48
+	stp1	A_l, A_h, dstend, -16
+	ldp1	A_l, A_h, src, 32
+	stp1	B_l, B_h, dstend, -32
+	ldp1	B_l, B_h, src, 16
+	stp1	C_l, C_h, dstend, -48
+	ldp1	C_l, C_h, src
+	stp1	D_l, D_h, dstend, -64
+	stp1	G_l, G_h, dstin, 48
+	stp1	A_l, A_h, dstin, 32
+	stp1	B_l, B_h, dstin, 16
+	stp1	C_l, C_h, dstin
+	copy_exit
diff --git a/arch/arm64/lib/copy_template_user.S b/arch/arm64/lib/copy_template_user.S
new file mode 100644
index 000000000000..3db24dcdab05
--- /dev/null
+++ b/arch/arm64/lib/copy_template_user.S
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#define L(l) .L ## l
+
+	alternative_if_not ARM64_HAS_UAO
+	b	L(copy_non_uao)
+	alternative_else_nop_endif
+#include "copy_template.S"
+
+#define ldp1 ldp1_nuao
+#define ldp1_pre ldp1_pre_nuao
+#define stp1 stp1_nuao
+#define stp1_pre stp1_pre_nuao
+#define ldr1 ldr1_nuao
+#define str1 str1_nuao
+#define ldrb1 ldrb1_nuao
+#define strb1 strb1_nuao
+#define ldrb1_reg ldrb1_nuao_reg
+#define strb1_reg strb1_nuao_reg
+
+L(copy_non_uao):
+#undef L
+#define L(l) .Lnuao ## l
+#include "copy_template.S"
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 4ec59704b8f2..6b4742cac083 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -19,49 +19,111 @@
  * Returns:
  *	x0 - bytes not copied
  */
-	.macro ldrb1 reg, ptr, val
-	ldrb  \reg, [\ptr], \val
+	.macro ldrb1 reg, ptr, offset=0
+	ldrb \reg, [\ptr, \offset]
 	.endm
 
-	.macro strb1 reg, ptr, val
-	uao_user_alternative 9998f, strb, sttrb, \reg, \ptr, \val
+	.macro strb1 reg, ptr, offset=0
+	8888: sttrb \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
-	.macro ldrh1 reg, ptr, val
-	ldrh  \reg, [\ptr], \val
+	.macro ldrb1_reg reg, ptr, offset
+	ldrb \reg, [\ptr, \offset]
 	.endm
 
-	.macro strh1 reg, ptr, val
-	uao_user_alternative 9998f, strh, sttrh, \reg, \ptr, \val
+	.macro strb1_reg reg, ptr, offset
+	add \ptr, \ptr, \offset
+	8888: sttrb \reg, [\ptr]
+	sub \ptr, \ptr, \offset
+	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
-	.macro ldr1 reg, ptr, val
-	ldr \reg, [\ptr], \val
+	.macro ldr1 reg, ptr, offset=0
+	ldr \reg, [\ptr, \offset]
 	.endm
 
-	.macro str1 reg, ptr, val
-	uao_user_alternative 9998f, str, sttr, \reg, \ptr, \val
+	.macro str1 reg, ptr, offset=0
+	8888: sttr \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
-	.macro ldp1 reg1, reg2, ptr, val
-	ldp \reg1, \reg2, [\ptr], \val
+	.macro ldp1 regA, regB, ptr, offset=0
+	ldp \regA, \regB, [\ptr, \offset]
 	.endm
 
-	.macro stp1 reg1, reg2, ptr, val
-	uao_stp 9998f, \reg1, \reg2, \ptr, \val
+	.macro stp1 regA, regB, ptr, offset=0
+	8888: sttr \regA, [\ptr, \offset]
+	8889: sttr \regB, [\ptr, \offset + 8]
+	_asm_extable_faultaddr	8888b,9998f;
+	_asm_extable_faultaddr	8889b,9998f;
+	.endm
+
+	.macro ldp1_pre regA, regB, ptr, offset
+	ldp \regA, \regB, [\ptr, \offset]!
+	.endm
+
+	.macro stp1_pre regA, regB, ptr, offset
+	8888: sttr \regA, [\ptr, \offset]
+	8889: sttr \regB, [\ptr, \offset + 8]
+	add \ptr, \ptr, \offset
+	_asm_extable_faultaddr	8888b,9998f;
+	_asm_extable_faultaddr	8889b,9998f;
+	.endm
+
+	.macro ldrb1_nuao reg, ptr, offset=0
+	ldrb \reg, [\ptr, \offset]
+	.endm
+
+	.macro strb1_nuao reg, ptr, offset=0
+	8888: strb \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro ldrb1_nuao_reg reg, ptr, offset=0
+	ldrb \reg, [\ptr, \offset]
+	.endm
+
+	.macro strb1_nuao_reg reg, ptr, offset=0
+	strb \reg, [\ptr, \offset]
+	.endm
+
+	.macro ldr1_nuao reg, ptr, offset=0
+	ldr \reg, [\ptr, \offset]
+	.endm
+
+	.macro str1_nuao reg, ptr, offset=0
+	8888: str \reg, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro ldp1_nuao  regA, regB, ptr, offset=0
+	ldp \regA, \regB, [\ptr, \offset]
+	.endm
+
+	.macro ldp1_pre_nuao regA, regB, ptr, offset
+	ldp \regA, \regB, [\ptr, \offset]!
+	.endm
+
+	.macro stp1_nuao regA, regB, ptr, offset=0
+	8888: stp \regA, \regB, [\ptr, \offset]
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro stp1_pre_nuao regA, regB, ptr, offset
+	8888: stp \regA, \regB, [\ptr, \offset]!
+	_asm_extable_faultaddr	8888b,9998f;
+	.endm
+
+	.macro copy_exit
+	b	.Luaccess_finish
 	.endm
 
-end	.req	x5
 SYM_FUNC_START(__arch_copy_to_user)
-	add	end, x0, x2
-#include "copy_template.S"
+#include "copy_template_user.S"
+.Luaccess_finish:
 	mov	x0, #0
 	ret
 SYM_FUNC_END(__arch_copy_to_user)
 EXPORT_SYMBOL(__arch_copy_to_user)
-
-	.section .fixup,"ax"
-	.align	2
-9998:	sub	x0, end, dst			// bytes not copied
-	ret
-	.previous
+#include "copy_user_fixup.S"
diff --git a/arch/arm64/lib/copy_user_fixup.S b/arch/arm64/lib/copy_user_fixup.S
new file mode 100644
index 000000000000..117c37598691
--- /dev/null
+++ b/arch/arm64/lib/copy_user_fixup.S
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+addr	.req	x15
+.section .fixup,"ax"
+.align	2
+9998:
+	// TODO: add accurate fixup
+	ret
+
diff --git a/arch/arm64/lib/memcpy.S b/arch/arm64/lib/memcpy.S
index e0bf83d556f2..c24925aef236 100644
--- a/arch/arm64/lib/memcpy.S
+++ b/arch/arm64/lib/memcpy.S
@@ -24,43 +24,56 @@
  * Returns:
  *	x0 - dest
  */
-	.macro ldrb1 reg, ptr, val
-	ldrb  \reg, [\ptr], \val
+ #define L(l) .L ## l
+
+	.macro ldrb1 reg, ptr, offset=0
+	ldrb \reg, [\ptr, \offset]
+	.endm
+
+	.macro strb1 reg, ptr, offset=0
+	strb \reg, [\ptr, \offset]
+	.endm
+
+	.macro ldr1 reg, ptr, offset=0
+	ldr \reg, [\ptr, \offset]
 	.endm
 
-	.macro strb1 reg, ptr, val
-	strb \reg, [\ptr], \val
+	.macro str1 reg, ptr, offset=0
+	str \reg, [\ptr, \offset]
 	.endm
 
-	.macro ldrh1 reg, ptr, val
-	ldrh  \reg, [\ptr], \val
+	.macro ldp1 regA, regB, ptr, offset=0
+	ldp \regA, \regB, [\ptr, \offset]
 	.endm
 
-	.macro strh1 reg, ptr, val
-	strh \reg, [\ptr], \val
+	.macro stp1 regA, regB, ptr, offset=0
+	stp \regA, \regB, [\ptr, \offset]
 	.endm
 
-	.macro ldr1 reg, ptr, val
-	ldr \reg, [\ptr], \val
+	.macro ldrb1_reg reg, ptr, offset
+	ldrb1 \reg, \ptr, \offset
 	.endm
 
-	.macro str1 reg, ptr, val
-	str \reg, [\ptr], \val
+	.macro strb1_reg reg, ptr, offset
+	strb1 \reg, \ptr, \offset
 	.endm
 
-	.macro ldp1 reg1, reg2, ptr, val
-	ldp \reg1, \reg2, [\ptr], \val
+	.macro ldp1_pre regA, regB, ptr, offset
+	ldp \regA, \regB, [\ptr, \offset]!
 	.endm
 
-	.macro stp1 reg1, reg2, ptr, val
-	stp \reg1, \reg2, [\ptr], \val
+	.macro stp1_pre regA, regB, ptr, offset
+	stp \regA, \regB, [\ptr, \offset]!
+	.endm
+
+	.macro copy_exit
+	ret
 	.endm
 
 	.weak memcpy
 SYM_FUNC_START_ALIAS(__memcpy)
 SYM_FUNC_START_PI(memcpy)
 #include "copy_template.S"
-	ret
 SYM_FUNC_END_PI(memcpy)
 EXPORT_SYMBOL(memcpy)
 SYM_FUNC_END_ALIAS(__memcpy)
-- 
2.17.1

