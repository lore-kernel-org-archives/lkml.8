Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C7FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6958206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgF3TtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:49:07 -0400
Received: from foss.arm.com ([217.140.110.172]:32986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbgF3Ts5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:48:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 044ED1396;
        Tue, 30 Jun 2020 12:48:56 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15ED43F73C;
        Tue, 30 Jun 2020 12:48:54 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/14] arm64: Use additional memcpy macros and fixups
Date:   Tue, 30 Jun 2020 19:48:19 +0000
Message-Id: <20200630194822.1082-12-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630194822.1082-1-oli.swede@arm.com>
References: <20200630194822.1082-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Arm-provided memcpy routine has been updated with more recent
optimizations. The kernel's helper functions for copying to/from
user space memory, which import this algorithm and create
exception table entries for instructions that reference user
space, require new recovery code to accurately determine the number
of bytes that successfully copied before a page fault.

This adds new macro instantiations in the copy template, and
corresponding definitions to each of the copy_*_user() functions.
This allows more fixup routines to be added so that an accurate value
for the number of bytes that failed to copy can be returned.

This increases the flexibility of the fixup code, as certain
propertes can be encapsulated by the mapping to implicitly provide
the routines with more information than would otherwise be available.

In the case of the current memcpy, the number of bytes already copied
depends highly on the type of instruction that caused the fault (load
vs. store), so the use of separate fixups enables specific routines
for each case. This is an alternative to (for instance) using a
single fixup for both the loads and stores, as this would be subject
to issues relating to overlapping src and dst buffers in
copy_in_user().
The outcome also depends largely on other factors, such as if the
target address is specified relative to the start or end of the
buffer, and whether or not the store targets are guaranteed to be
16-byte aligned.

These characteristics (obtained from analysing the copy algorithm)
enable fixups to be written that are modular and accurate for each
case. The fixup logic should be straightforward to modify in the
future, e.g. if there are further improvements to the memcpy routine.

Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/lib/copy_from_user.S     | 197 ++++++++++++++++++++++++--
 arch/arm64/lib/copy_in_user.S       | 205 ++++++++++++++++++++++++++--
 arch/arm64/lib/copy_template.S      | 126 ++++++++---------
 arch/arm64/lib/copy_template_user.S |  20 +++
 arch/arm64/lib/copy_to_user.S       | 179 +++++++++++++++++++++++-
 arch/arm64/lib/copy_user_fixup.S    |  13 +-
 arch/arm64/lib/memcpy.S             |  80 +++++++++++
 7 files changed, 728 insertions(+), 92 deletions(-)

diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index cd3042e98394..0056d1fc06eb 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -19,17 +19,46 @@
  * Returns:
  *	x0 - bytes not copied
  */
+
 	.macro ldrb1 reg, ptr, offset=0
-	USER_F(9998f, ldtrb \reg, [\ptr, \offset])
+	USER_F(9993f, ldtrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldrb2 reg, ptr, offset=0
+	USER_F(9994f, ldtrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldrb3 reg, ptr, offset=0
+	USER_F(9995f, ldtrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1 reg, ptr, offset=0
 	strb \reg, [\ptr, \offset]
 	.endm
 
+	.macro strb2 reg, ptr, offset=0
+	strb \reg, [\ptr, \offset]
+	.endm
+
+	.macro strb3 reg, ptr, offset=0
+	strb \reg, [\ptr, \offset]
+	.endm
+
 	.macro ldrb1_reg reg, ptr, offset
 	add \ptr, \ptr, \offset
-	USER_F(9998f, ldtrb \reg, [\ptr])
+	USER_F(9993f, ldtrb \reg, [\ptr])
+	sub \ptr, \ptr, \offset
+	.endm
+
+	.macro ldrb2_reg reg, ptr, offset
+	add \ptr, \ptr, \offset
+	USER_F(9994f, ldtrb \reg, [\ptr])
+	sub \ptr, \ptr, \offset
+	.endm
+
+	.macro ldrb3_reg reg, ptr, offset
+	add \ptr, \ptr, \offset
+	USER_F(9995f, ldtrb \reg, [\ptr])
 	sub \ptr, \ptr, \offset
 	.endm
 
@@ -37,26 +66,80 @@
 	strb \reg, [\ptr, \offset]
 	.endm
 
+	.macro strb2_reg reg, ptr, offset
+	strb \reg, [\ptr, \offset]
+	.endm
+
+	.macro strb3_reg reg, ptr, offset
+	strb \reg, [\ptr, \offset]
+	.endm
+
 	.macro ldr1 reg, ptr, offset=0
-	USER_F(9998f, ldtr \reg, [\ptr, \offset])
+	USER_F(9993f, ldtr \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldr2 reg, ptr, offset=0
+	USER_F(9994f, ldtr \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldr3 reg, ptr, offset=0
+	USER_F(9995f, ldtr \reg, [\ptr, \offset])
 	.endm
 
 	.macro str1 reg, ptr, offset=0
 	str \reg, [\ptr, \offset]
 	.endm
 
+	.macro str2 reg, ptr, offset=0
+	str \reg, [\ptr, \offset]
+	.endm
+
+	.macro str3 reg, ptr, offset=0
+	str \reg, [\ptr, \offset]
+	.endm
+
 	.macro ldp1 regA, regB, ptr, offset=0
-	USER_F(9998f, ldtr \regA, [\ptr, \offset])
-	USER_F(9998f, ldtr \regB, [\ptr, \offset + 8])
+	USER_F(9993f, ldtr \regA, [\ptr, \offset])
+	USER_F(9993f, ldtr \regB, [\ptr, \offset + 8])
+	.endm
+
+	.macro ldp2 regA, regB, ptr, offset=0
+	USER_F(9994f, ldtr \regA, [\ptr, \offset])
+	USER_F(9994f, ldtr \regB, [\ptr, \offset + 8])
+	.endm
+
+	.macro ldp3 regA, regB, ptr, offset=0
+	USER_F(9995f, ldtr \regA, [\ptr, \offset])
+	USER_F(9995f, ldtr \regB, [\ptr, \offset + 8])
 	.endm
 
 	.macro stp1 regA, regB, ptr, offset=0
 	stp \regA, \regB, [\ptr, \offset]
 	.endm
 
+	.macro stp2 regA, regB, ptr, offset=0
+	stp \regA, \regB, [\ptr, \offset]
+	.endm
+
+	.macro stp3 regA, regB, ptr, offset=0
+	stp \regA, \regB, [\ptr, \offset]
+	.endm
+
 	.macro ldp1_pre regA, regB, ptr, offset
-	USER_F(9998f, ldtr \regA, [\ptr, \offset])
-	USER_F(9998f, ldtr \regB, [\ptr, \offset + 8])
+	USER_F(9993f, ldtr \regA, [\ptr, \offset])
+	USER_F(9993f, ldtr \regB, [\ptr, \offset + 8])
+	add \ptr, \ptr, \offset
+	.endm
+
+	.macro ldp2_pre regA, regB, ptr, offset
+	USER_F(9994f, ldtr \regA, [\ptr, \offset])
+	USER_F(9994f, ldtr \regB, [\ptr, \offset + 8])
+	add \ptr, \ptr, \offset
+	.endm
+
+	.macro ldp3_pre regA, regB, ptr, offset
+	USER_F(9995f, ldtr \regA, [\ptr, \offset])
+	USER_F(9995f, ldtr \regB, [\ptr, \offset + 8])
 	add \ptr, \ptr, \offset
 	.endm
 
@@ -64,46 +147,134 @@
 	stp \regA, \regB, [\ptr, \offset]!
 	.endm
 
+	.macro stp2_pre regA, regB, ptr, offset
+	stp \regA, \regB, [\ptr, \offset]!
+	.endm
+
+	.macro stp3_pre regA, regB, ptr, offset
+	stp \regA, \regB, [\ptr, \offset]!
+	.endm
+
 	.macro ldrb1_nuao reg, ptr, offset=0
-	USER_F(9998f, ldrb \reg, [\ptr, \offset])
+	USER_F(9993f, ldrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldrb2_nuao reg, ptr, offset=0
+	USER_F(9994f, ldrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldrb3_nuao reg, ptr, offset=0
+	USER_F(9995f, ldrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1_nuao reg, ptr, offset=0
 	strb \reg, [\ptr, \offset]
 	.endm
 
+	.macro strb2_nuao reg, ptr, offset=0
+	strb \reg, [\ptr, \offset]
+	.endm
+
+	.macro strb3_nuao reg, ptr, offset=0
+	strb \reg, [\ptr, \offset]
+	.endm
+
 	.macro ldrb1_nuao_reg reg, ptr, offset=0
-	USER_F(9998f, ldrb \reg, [\ptr, \offset])
+	USER_F(9993f, ldrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldrb2_nuao_reg reg, ptr, offset=0
+	USER_F(9994f, ldrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldrb3_nuao_reg reg, ptr, offset=0
+	USER_F(9995f, ldrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1_nuao_reg reg, ptr, offset=0
 	strb \reg, [\ptr, \offset]
 	.endm
 
+	.macro strb2_nuao_reg reg, ptr, offset=0
+	strb \reg, [\ptr, \offset]
+	.endm
+
+	.macro strb3_nuao_reg reg, ptr, offset=0
+	strb \reg, [\ptr, \offset]
+	.endm
+
 	.macro ldr1_nuao reg, ptr, offset=0
-	USER_F(9998f, ldr \reg, [\ptr, \offset])
+	USER_F(9993f, ldr \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldr2_nuao reg, ptr, offset=0
+	USER_F(9994f, ldr \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldr3_nuao reg, ptr, offset=0
+	USER_F(9995f, ldr \reg, [\ptr, \offset])
 	.endm
 
 	.macro str1_nuao reg, ptr, offset=0
 	str \reg, [\ptr, \offset]
 	.endm
 
-	.macro ldp1_nuao  regA, regB, ptr, offset=0
-	USER_F(9998f, ldp \regA, \regB, [\ptr, \offset])
+	.macro str2_nuao reg, ptr, offset=0
+	str \reg, [\ptr, \offset]
+	.endm
+
+	.macro str3_nuao reg, ptr, offset=0
+	str \reg, [\ptr, \offset]
+	.endm
+
+	.macro ldp1_nuao regA, regB, ptr, offset=0
+	USER_F(9993f, ldp \regA, \regB, [\ptr, \offset])
+	.endm
+
+	.macro ldp2_nuao regA, regB, ptr, offset=0
+	USER_F(9994f, ldp \regA, \regB, [\ptr, \offset])
+	.endm
+
+	.macro ldp3_nuao regA, regB, ptr, offset=0
+	USER_F(9995f, ldp \regA, \regB, [\ptr, \offset])
 	.endm
 
 	.macro stp1_nuao regA, regB, ptr, offset=0
 	stp \regA, \regB, [\ptr, \offset]
 	.endm
 
+	.macro stp2_nuao regA, regB, ptr, offset=0
+	stp \regA, \regB, [\ptr, \offset]
+	.endm
+
+	.macro stp3_nuao regA, regB, ptr, offset=0
+	stp \regA, \regB, [\ptr, \offset]
+	.endm
+
 	.macro ldp1_pre_nuao regA, regB, ptr, offset
-	USER_F(9998f, ldp \regA, \regB, [\ptr, \offset]!)
+	USER_F(9993f, ldp \regA, \regB, [\ptr, \offset]!)
+	.endm
+
+	.macro ldp2_pre_nuao regA, regB, ptr, offset
+	USER_F(9994f, ldp \regA, \regB, [\ptr, \offset]!)
+	.endm
+
+	.macro ldp3_pre_nuao regA, regB, ptr, offset
+	USER_F(9995f, ldp \regA, \regB, [\ptr, \offset]!)
 	.endm
 
 	.macro stp1_pre_nuao regA, regB, ptr, offset
 	stp \regA, \regB, [\ptr, \offset]!
 	.endm
 
+	.macro stp2_pre_nuao regA, regB, ptr, offset
+	stp \regA, \regB, [\ptr, \offset]!
+	.endm
+
+	.macro stp3_pre_nuao regA, regB, ptr, offset
+	stp \regA, \regB, [\ptr, \offset]!
+	.endm
+
 	.macro copy_exit
 	b	.Luaccess_finish
 	.endm
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index fe035e513b34..4511f59dd979 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -21,93 +21,274 @@
  * Returns:
  *	x0 - bytes not copied
  */
+
 	.macro ldrb1 reg, ptr, offset=0
-	USER_F(9998f, ldtrb \reg, [\ptr, \offset])
+	USER_F(9993f, ldtrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldrb2 reg, ptr, offset=0
+	USER_F(9994f, ldtrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldrb3 reg, ptr, offset=0
+	USER_F(9995f, ldtrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1 reg, ptr, offset=0
+	USER_F(9996f, sttrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro strb2 reg, ptr, offset=0
+	USER_F(9997f, sttrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro strb3 reg, ptr, offset=0
 	USER_F(9998f, sttrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldrb1_reg reg, ptr, offset
 	add \ptr, \ptr, \offset
-	USER_F(9998f, ldtrb \reg, [\ptr])
+	USER_F(9993f, ldtrb \reg, [\ptr])
+	sub \ptr, \ptr, \offset
+	.endm
+
+	.macro ldrb2_reg reg, ptr, offset
+	add \ptr, \ptr, \offset
+	USER_F(9994f, ldtrb \reg, [\ptr])
+	sub \ptr, \ptr, \offset
+	.endm
+
+	.macro ldrb3_reg reg, ptr, offset
+	add \ptr, \ptr, \offset
+	USER_F(9995f, ldtrb \reg, [\ptr])
 	sub \ptr, \ptr, \offset
 	.endm
 
 	.macro strb1_reg reg, ptr, offset
 	add \ptr, \ptr, \offset
+	USER_F(9996f, sttrb \reg, [\ptr])
+	sub \ptr, \ptr, \offset
+	.endm
+
+	.macro strb2_reg reg, ptr, offset
+	add \ptr, \ptr, \offset
+	USER_F(9997f, sttrb \reg, [\ptr])
+	sub \ptr, \ptr, \offset
+	.endm
+
+	.macro strb3_reg reg, ptr, offset
+	add \ptr, \ptr, \offset
 	USER_F(9998f, sttrb \reg, [\ptr])
 	sub \ptr, \ptr, \offset
 	.endm
 
 	.macro ldr1 reg, ptr, offset=0
-	USER_F(9998f, ldtr \reg, [\ptr, \offset])
+	USER_F(9993f, ldtr \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldr2 reg, ptr, offset=0
+	USER_F(9994f, ldtr \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldr3 reg, ptr, offset=0
+	USER_F(9995f, ldtr \reg, [\ptr, \offset])
 	.endm
 
 	.macro str1 reg, ptr, offset=0
+	USER_F(9996f, sttr \reg, [\ptr, \offset])
+	.endm
+
+	.macro str2 reg, ptr, offset=0
+	USER_F(9997f, sttr \reg, [\ptr, \offset])
+	.endm
+
+	.macro str3 reg, ptr, offset=0
 	USER_F(9998f, sttr \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldp1 regA, regB, ptr, offset=0
-	USER_F(9998f, ldtr \regA, [\ptr, \offset])
-	USER_F(9998f, ldtr \regB, [\ptr, \offset + 8])
+	USER_F(9993f, ldtr \regA, [\ptr, \offset])
+	USER_F(9993f, ldtr \regB, [\ptr, \offset + 8])
+	.endm
+
+	.macro ldp2 regA, regB, ptr, offset=0
+	USER_F(9994f, ldtr \regA, [\ptr, \offset])
+	USER_F(9994f, ldtr \regB, [\ptr, \offset + 8])
+	.endm
+
+	.macro ldp3 regA, regB, ptr, offset=0
+	USER_F(9995f, ldtr \regA, [\ptr, \offset])
+	USER_F(9995f, ldtr \regB, [\ptr, \offset + 8])
 	.endm
 
 	.macro stp1 regA, regB, ptr, offset=0
+	USER_F(9996f, sttr \regA, [\ptr, \offset])
+	USER_F(9996f, sttr \regB, [\ptr, \offset + 8])
+	.endm
+
+	.macro stp2 regA, regB, ptr, offset=0
+	USER_F(9997f, sttr \regA, [\ptr, \offset])
+	USER_F(9997f, sttr \regB, [\ptr, \offset + 8])
+	.endm
+
+	.macro stp3 regA, regB, ptr, offset=0
 	USER_F(9998f, sttr \regA, [\ptr, \offset])
 	USER_F(9998f, sttr \regB, [\ptr, \offset + 8])
 	.endm
 
 	.macro ldp1_pre regA, regB, ptr, offset
-	USER_F(9998f, ldtr \regA, [\ptr, \offset])
-	USER_F(9998f, ldtr \regB, [\ptr, \offset + 8])
+	USER_F(9993f, ldtr \regA, [\ptr, \offset])
+	USER_F(9993f, ldtr \regB, [\ptr, \offset + 8])
+	add \ptr, \ptr, \offset
+	.endm
+
+	.macro ldp2_pre regA, regB, ptr, offset
+	USER_F(9994f, ldtr \regA, [\ptr, \offset])
+	USER_F(9994f, ldtr \regB, [\ptr, \offset + 8])
+	add \ptr, \ptr, \offset
+	.endm
+
+	.macro ldp3_pre regA, regB, ptr, offset
+	USER_F(9995f, ldtr \regA, [\ptr, \offset])
+	USER_F(9995f, ldtr \regB, [\ptr, \offset + 8])
 	add \ptr, \ptr, \offset
 	.endm
 
 	.macro stp1_pre regA, regB, ptr, offset
+	USER_F(9996f, sttr \regA, [\ptr, \offset])
+	USER_F(9996f, sttr \regB, [\ptr, \offset + 8])
+	add \ptr, \ptr, \offset
+	.endm
+
+	.macro stp2_pre regA, regB, ptr, offset
+	USER_F(9997f, sttr \regA, [\ptr, \offset])
+	USER_F(9997f, sttr \regB, [\ptr, \offset + 8])
+	add \ptr, \ptr, \offset
+	.endm
+
+	.macro stp3_pre regA, regB, ptr, offset
 	USER_F(9998f, sttr \regA, [\ptr, \offset])
 	USER_F(9998f, sttr \regB, [\ptr, \offset + 8])
 	add \ptr, \ptr, \offset
 	.endm
 
 	.macro ldrb1_nuao reg, ptr, offset=0
-	USER_F(9998f, ldrb \reg, [\ptr, \offset])
+	USER_F(9993f, ldrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldrb2_nuao reg, ptr, offset=0
+	USER_F(9994f, ldrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldrb3_nuao reg, ptr, offset=0
+	USER_F(9995f, ldrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1_nuao reg, ptr, offset=0
+	USER_F(9996f, strb \reg, [\ptr, \offset])
+	.endm
+
+	.macro strb2_nuao reg, ptr, offset=0
+	USER_F(9997f, strb \reg, [\ptr, \offset])
+	.endm
+
+	.macro strb3_nuao reg, ptr, offset=0
 	USER_F(9998f, strb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldrb1_nuao_reg reg, ptr, offset=0
-	USER_F(9998f, ldrb \reg, [\ptr, \offset])
+	USER_F(9993f, ldrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldrb2_nuao_reg reg, ptr, offset=0
+	USER_F(9994f, ldrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldrb3_nuao_reg reg, ptr, offset=0
+	USER_F(9995f, ldrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1_nuao_reg reg, ptr, offset=0
+	USER_F(9996f, strb \reg, [\ptr, \offset])
+	.endm
+
+	.macro strb2_nuao_reg reg, ptr, offset=0
+	USER_F(9997f, strb \reg, [\ptr, \offset])
+	.endm
+
+	.macro strb3_nuao_reg reg, ptr, offset=0
 	USER_F(9998f, strb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldr1_nuao reg, ptr, offset=0
-	USER_F(9998f, ldr \reg, [\ptr, \offset])
+	USER_F(9993f, ldr \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldr2_nuao reg, ptr, offset=0
+	USER_F(9994f, ldr \reg, [\ptr, \offset])
+	.endm
+
+	.macro ldr3_nuao reg, ptr, offset=0
+	USER_F(9995f, ldr \reg, [\ptr, \offset])
 	.endm
 
 	.macro str1_nuao reg, ptr, offset=0
+	USER_F(9996f, str \reg, [\ptr, \offset])
+	.endm
+
+	.macro str2_nuao reg, ptr, offset=0
+	USER_F(9997f, str \reg, [\ptr, \offset])
+	.endm
+
+	.macro str3_nuao reg, ptr, offset=0
 	USER_F(9998f, str \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldp1_nuao  regA, regB, ptr, offset=0
-	USER_F(9998f, ldp \regA, \regB, [\ptr, \offset])
+	USER_F(9993f, ldp \regA, \regB, [\ptr, \offset])
+	.endm
+
+	.macro ldp2_nuao  regA, regB, ptr, offset=0
+	USER_F(9994f, ldp \regA, \regB, [\ptr, \offset])
+	.endm
+
+	.macro ldp3_nuao  regA, regB, ptr, offset=0
+	USER_F(9995f, ldp \regA, \regB, [\ptr, \offset])
 	.endm
 
 	.macro stp1_nuao regA, regB, ptr, offset=0
+	USER_F(9996f, stp \regA, \regB, [\ptr, \offset])
+	.endm
+
+	.macro stp2_nuao regA, regB, ptr, offset=0
+	USER_F(9997f, stp \regA, \regB, [\ptr, \offset])
+	.endm
+
+	.macro stp3_nuao regA, regB, ptr, offset=0
 	USER_F(9998f, stp \regA, \regB, [\ptr, \offset])
 	.endm
 
 	.macro ldp1_pre_nuao regA, regB, ptr, offset
-	USER_F(9998f, ldp \regA, \regB, [\ptr, \offset]!)
+	USER_F(9993f, ldp \regA, \regB, [\ptr, \offset]!)
+	.endm
+
+	.macro ldp2_pre_nuao regA, regB, ptr, offset
+	USER_F(9994f, ldp \regA, \regB, [\ptr, \offset]!)
+	.endm
+
+	.macro ldp3_pre_nuao regA, regB, ptr, offset
+	USER_F(9995f, ldp \regA, \regB, [\ptr, \offset]!)
 	.endm
 
 	.macro stp1_pre_nuao regA, regB, ptr, offset
+	USER_F(9996f, stp \regA, \regB, [\ptr, \offset]!)
+	.endm
+
+	.macro stp2_pre_nuao regA, regB, ptr, offset
+	USER_F(9997f, stp \regA, \regB, [\ptr, \offset]!)
+	.endm
+
+	.macro stp3_pre_nuao regA, regB, ptr, offset
 	USER_F(9998f, stp \regA, \regB, [\ptr, \offset]!)
 	.endm
 
diff --git a/arch/arm64/lib/copy_template.S b/arch/arm64/lib/copy_template.S
index 90b5f63ff227..0c3e39ae906d 100644
--- a/arch/arm64/lib/copy_template.S
+++ b/arch/arm64/lib/copy_template.S
@@ -58,18 +58,18 @@
 	cmp	count, 16
 	b.lo	L(copy16)
 	ldp1	A_l, A_h, src
-	ldp1	D_l, D_h, srcend, -16
+	ldp2	D_l, D_h, srcend, -16
 	stp1	A_l, A_h, dstin
-	stp1	D_l, D_h, dstend, -16
+	stp2	D_l, D_h, dstend, -16
 	copy_exit
 
 	/* Copy 8-15 bytes. */
 L(copy16):
 	tbz	count, 3, L(copy8)
 	ldr1	A_l, src
-	ldr1	A_h, srcend, -8
+	ldr2	A_h, srcend, -8
 	str1	A_l, dstin
-	str1	A_h, dstend, -8
+	str2	A_h, dstend, -8
 	copy_exit
 
 	.p2align 3
@@ -77,9 +77,9 @@ L(copy16):
 L(copy8):
 	tbz	count, 2, L(copy4)
 	ldr1	A_lw, src
-	ldr1	B_lw, srcend, -4
+	ldr2	B_lw, srcend, -4
 	str1	A_lw, dstin
-	str1	B_lw, dstend, -4
+	str2	B_lw, dstend, -4
 	copy_exit
 
 	/* Copy 0..3 bytes using a branchless sequence. */
@@ -87,11 +87,11 @@ L(copy4):
 	cbz	count, L(copy0)
 	lsr	tmp1, count, 1
 	ldrb1	A_lw, src
-	ldrb1	C_lw, srcend, -1
+	ldrb2	C_lw, srcend, -1
 	ldrb1_reg	B_lw, src, tmp1
 	strb1	A_lw, dstin
 	strb1_reg	B_lw, dstin, tmp1
-	strb1	C_lw, dstend, -1
+	strb2	C_lw, dstend, -1
 L(copy0):
 	copy_exit
 
@@ -100,14 +100,14 @@ L(copy0):
 L(copy32_128):
 	ldp1	A_l, A_h, src
 	ldp1	B_l, B_h, src, 16
-	ldp1	C_l, C_h, srcend, -32
-	ldp1	D_l, D_h, srcend, -16
+	ldp2	C_l, C_h, srcend, -32
+	ldp2	D_l, D_h, srcend, -16
 	cmp	count, 64
 	b.hi	L(copy128)
 	stp1	A_l, A_h, dstin
 	stp1	B_l, B_h, dstin, 16
-	stp1	C_l, C_h, dstend, -32
-	stp1	D_l, D_h, dstend, -16
+	stp2	C_l, C_h, dstend, -32
+	stp2	D_l, D_h, dstend, -16
 	copy_exit
 
 	.p2align 4
@@ -117,17 +117,17 @@ L(copy128):
 	ldp1	F_l, F_h, src, 48
 	cmp	count, 96
 	b.ls	L(copy96)
-	ldp1	G_l, G_h, srcend, -64
-	ldp1	H_l, H_h, srcend, -48
-	stp1	G_l, G_h, dstend, -64
-	stp1	H_l, H_h, dstend, -48
+	ldp2	G_l, G_h, srcend, -64
+	ldp2	H_l, H_h, srcend, -48
+	stp2	G_l, G_h, dstend, -64
+	stp2	H_l, H_h, dstend, -48
 L(copy96):
 	stp1	A_l, A_h, dstin
 	stp1	B_l, B_h, dstin, 16
 	stp1	E_l, E_h, dstin, 32
 	stp1	F_l, F_h, dstin, 48
-	stp1	C_l, C_h, dstend, -32
-	stp1	D_l, D_h, dstend, -16
+	stp2	C_l, C_h, dstend, -32
+	stp2	D_l, D_h, dstend, -16
 	copy_exit
 
 	.p2align 4
@@ -146,83 +146,85 @@ L(copy_long):
 	bic	dst, dstin, 15
 	sub	src, src, tmp1
 	add	count, count, tmp1	/* Count is now 16 too large. */
-	ldp1	A_l, A_h, src, 16
+	ldp3	A_l, A_h, src, 16
 	stp1	D_l, D_h, dstin
-	ldp1	B_l, B_h, src, 32
-	ldp1	C_l, C_h, src, 48
-	ldp1_pre	D_l, D_h, src, 64
+	ldp3	B_l, B_h, src, 32
+	ldp3	C_l, C_h, src, 48
+	ldp3_pre	D_l, D_h, src, 64
 	subs	count, count, 128 + 16 /* Test and readjust count. */
 	b.ls	L(copy64_from_end)
 
 L(loop64):
-	stp1	A_l, A_h, dst, 16
-	ldp1	A_l, A_h, src, 16
-	stp1	B_l, B_h, dst, 32
-	ldp1	B_l, B_h, src, 32
-	stp1	C_l, C_h, dst, 48
-	ldp1	C_l, C_h, src, 48
-	stp1_pre	D_l, D_h, dst, 64
-	ldp1_pre	D_l, D_h, src, 64
+	stp3	A_l, A_h, dst, 16
+	ldp3	A_l, A_h, src, 16
+	stp3	B_l, B_h, dst, 32
+	ldp3	B_l, B_h, src, 32
+	stp3	C_l, C_h, dst, 48
+	ldp3	C_l, C_h, src, 48
+	stp3_pre	D_l, D_h, dst, 64
+	ldp3_pre	D_l, D_h, src, 64
 	subs	count, count, 64
 	b.hi	L(loop64)
 
 	/* Write the last iteration and copy 64 bytes from the end. */
 L(copy64_from_end):
-	ldp1	E_l, E_h, srcend, -64
-	stp1	A_l, A_h, dst, 16
-	ldp1	A_l, A_h, srcend, -48
-	stp1	B_l, B_h, dst, 32
-	ldp1	B_l, B_h, srcend, -32
-	stp1	C_l, C_h, dst, 48
-	ldp1	C_l, C_h, srcend, -16
-	stp1	D_l, D_h, dst, 64
-	stp1	E_l, E_h, dstend, -64
-	stp1	A_l, A_h, dstend, -48
-	stp1	B_l, B_h, dstend, -32
-	stp1	C_l, C_h, dstend, -16
+	ldp2	E_l, E_h, srcend, -64
+	stp3	A_l, A_h, dst, 16
+	ldp2	A_l, A_h, srcend, -48
+	stp3	B_l, B_h, dst, 32
+	ldp2	B_l, B_h, srcend, -32
+	stp3	C_l, C_h, dst, 48
+	ldp2	C_l, C_h, srcend, -16
+	stp3	D_l, D_h, dst, 64
+	stp2	E_l, E_h, dstend, -64
+	stp2	A_l, A_h, dstend, -48
+	stp2	B_l, B_h, dstend, -32
+	stp2	C_l, C_h, dstend, -16
 	copy_exit
 
 	.p2align 4
+
 	/* Large backwards copy for overlapping copies.
-	   Copy 16 bytes and then align dst to 16-byte alignment. */
+	   Copy 16 bytes and then align dst to 16-byte alignment.  */
 L(copy_long_backwards):
-	ldp1	D_l, D_h, srcend, -16
+	ldp2	D_l, D_h, srcend, -16
 	and	tmp1, dstend, 15
 	sub	srcend, srcend, tmp1
 	sub	count, count, tmp1
-	ldp1	A_l, A_h, srcend, -16
-	stp1	D_l, D_h, dstend, -16
-	ldp1	B_l, B_h, srcend, -32
-	ldp1	C_l, C_h, srcend, -48
-	ldp1_pre	D_l, D_h, srcend, -64
+	ldp2	A_l, A_h, srcend, -16
+	stp2	D_l, D_h, dstend, -16
+	ldp2	B_l, B_h, srcend, -32
+	ldp2	C_l, C_h, srcend, -48
+	ldp2_pre	D_l, D_h, srcend, -64
 	sub	dstend, dstend, tmp1
 	subs	count, count, 128
 	b.ls	L(copy64_from_start)
 
 L(loop64_backwards):
-	stp1	A_l, A_h, dstend, -16
-	ldp1	A_l, A_h, srcend, -16
-	stp1	B_l, B_h, dstend, -32
-	ldp1	B_l, B_h, srcend, -32
-	stp1	C_l, C_h, dstend, -48
-	ldp1	C_l, C_h, srcend, -48
-	stp1_pre	D_l, D_h, dstend, -64
-	ldp1_pre	D_l, D_h, srcend, -64
+	stp2	A_l, A_h, dstend, -16
+	ldp2	A_l, A_h, srcend, -16
+	stp2	B_l, B_h, dstend, -32
+	ldp2	B_l, B_h, srcend, -32
+	stp2	C_l, C_h, dstend, -48
+	ldp2	C_l, C_h, srcend, -48
+	stp2_pre	D_l, D_h, dstend, -64
+	ldp2_pre	D_l, D_h, srcend, -64
 	subs	count, count, 64
 	b.hi	L(loop64_backwards)
 
-	/* Write the last iteration and copy 64 bytes from the start. */
+	/* Write the last iteration and copy 64 bytes from the start.  */
 L(copy64_from_start):
 	ldp1	G_l, G_h, src, 48
-	stp1	A_l, A_h, dstend, -16
+	stp2	A_l, A_h, dstend, -16
 	ldp1	A_l, A_h, src, 32
-	stp1	B_l, B_h, dstend, -32
+	stp2	B_l, B_h, dstend, -32
 	ldp1	B_l, B_h, src, 16
-	stp1	C_l, C_h, dstend, -48
+	stp2	C_l, C_h, dstend, -48
 	ldp1	C_l, C_h, src
-	stp1	D_l, D_h, dstend, -64
+	stp2	D_l, D_h, dstend, -64
 	stp1	G_l, G_h, dstin, 48
 	stp1	A_l, A_h, dstin, 32
 	stp1	B_l, B_h, dstin, 16
 	stp1	C_l, C_h, dstin
 	copy_exit
+
diff --git a/arch/arm64/lib/copy_template_user.S b/arch/arm64/lib/copy_template_user.S
index 1d13daf314b0..f36c77738e42 100644
--- a/arch/arm64/lib/copy_template_user.S
+++ b/arch/arm64/lib/copy_template_user.S
@@ -8,15 +8,35 @@
 #include "copy_template.S"
 
 #define ldp1 ldp1_nuao
+#define ldp2 ldp2_nuao
+#define ldp3 ldp3_nuao
 #define ldp1_pre ldp1_pre_nuao
+#define ldp2_pre ldp2_pre_nuao
+#define ldp3_pre ldp3_pre_nuao
 #define stp1 stp1_nuao
+#define stp2 stp2_nuao
+#define stp3 stp3_nuao
 #define stp1_pre stp1_pre_nuao
+#define stp2_pre stp2_pre_nuao
+#define stp3_pre stp3_pre_nuao
 #define ldr1 ldr1_nuao
+#define ldr2 ldr2_nuao
+#define ldr3 ldr3_nuao
 #define str1 str1_nuao
+#define str2 str2_nuao
+#define str3 str3_nuao
 #define ldrb1 ldrb1_nuao
+#define ldrb2 ldrb2_nuao
+#define ldrb3 ldrb3_nuao
 #define strb1 strb1_nuao
+#define strb2 strb2_nuao
+#define strb3 strb3_nuao
 #define ldrb1_reg ldrb1_nuao_reg
+#define ldrb2_reg ldrb2_nuao_reg
+#define ldrb3_reg ldrb3_nuao_reg
 #define strb1_reg strb1_nuao_reg
+#define strb2_reg strb2_nuao_reg
+#define strb3_reg strb3_nuao_reg
 
 L(copy_non_uao):
 #undef L
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index de0af211b3ba..969e2b4ac3bf 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -19,11 +19,28 @@
  * Returns:
  *	x0 - bytes not copied
  */
+
 	.macro ldrb1 reg, ptr, offset=0
 	ldrb \reg, [\ptr, \offset]
 	.endm
 
+	.macro ldrb2 reg, ptr, offset=0
+	ldrb \reg, [\ptr, \offset]
+	.endm
+
+	.macro ldrb3 reg, ptr, offset=0
+	ldrb \reg, [\ptr, \offset]
+	.endm
+
 	.macro strb1 reg, ptr, offset=0
+	USER_F(9996f, sttrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro strb2 reg, ptr, offset=0
+	USER_F(9997f, sttrb \reg, [\ptr, \offset])
+	.endm
+
+	.macro strb3 reg, ptr, offset=0
 	USER_F(9998f, sttrb \reg, [\ptr, \offset])
 	.endm
 
@@ -31,8 +48,28 @@
 	ldrb \reg, [\ptr, \offset]
 	.endm
 
+	.macro ldrb2_reg reg, ptr, offset
+	ldrb \reg, [\ptr, \offset]
+	.endm
+
+	.macro ldrb3_reg reg, ptr, offset
+	ldrb \reg, [\ptr, \offset]
+	.endm
+
 	.macro strb1_reg reg, ptr, offset
 	add \ptr, \ptr, \offset
+	USER_F(9996f, sttrb \reg, [\ptr])
+	sub \ptr, \ptr, \offset
+	.endm
+
+	.macro strb2_reg reg, ptr, offset
+	add \ptr, \ptr, \offset
+	USER_F(9997f, sttrb \reg, [\ptr])
+	sub \ptr, \ptr, \offset
+	.endm
+
+	.macro strb3_reg reg, ptr, offset
+	add \ptr, \ptr, \offset
 	USER_F(9998f, sttrb \reg, [\ptr])
 	sub \ptr, \ptr, \offset
 	.endm
@@ -41,7 +78,23 @@
 	ldr \reg, [\ptr, \offset]
 	.endm
 
+	.macro ldr2 reg, ptr, offset=0
+	ldr \reg, [\ptr, \offset]
+	.endm
+
+	.macro ldr3 reg, ptr, offset=0
+	ldr \reg, [\ptr, \offset]
+	.endm
+
 	.macro str1 reg, ptr, offset=0
+	USER_F(9996f, sttr \reg, [\ptr, \offset])
+	.endm
+
+	.macro str2 reg, ptr, offset=0
+	USER_F(9997f, sttr \reg, [\ptr, \offset])
+	.endm
+
+	.macro str3 reg, ptr, offset=0
 	USER_F(9998f, sttr \reg, [\ptr, \offset])
 	.endm
 
@@ -49,7 +102,25 @@
 	ldp \regA, \regB, [\ptr, \offset]
 	.endm
 
+	.macro ldp2 regA, regB, ptr, offset=0
+	ldp \regA, \regB, [\ptr, \offset]
+	.endm
+
+	.macro ldp3 regA, regB, ptr, offset=0
+	ldp \regA, \regB, [\ptr, \offset]
+	.endm
+
 	.macro stp1 regA, regB, ptr, offset=0
+	USER_F(9996f, sttr \regA, [\ptr, \offset])
+	USER_F(9996f, sttr \regB, [\ptr, \offset + 8])
+	.endm
+
+	.macro stp2 regA, regB, ptr, offset=0
+	USER_F(9997f, sttr \regA, [\ptr, \offset])
+	USER_F(9997f, sttr \regB, [\ptr, \offset + 8])
+	.endm
+
+	.macro stp3 regA, regB, ptr, offset=0
 	USER_F(9998f, sttr \regA, [\ptr, \offset])
 	USER_F(9998f, sttr \regB, [\ptr, \offset + 8])
 	.endm
@@ -58,7 +129,27 @@
 	ldp \regA, \regB, [\ptr, \offset]!
 	.endm
 
+	.macro ldp2_pre regA, regB, ptr, offset
+	ldp \regA, \regB, [\ptr, \offset]!
+	.endm
+
+	.macro ldp3_pre regA, regB, ptr, offset
+	ldp \regA, \regB, [\ptr, \offset]!
+	.endm
+
 	.macro stp1_pre regA, regB, ptr, offset
+	USER_F(9996f, sttr \regA, [\ptr, \offset])
+	USER_F(9996f, sttr \regB, [\ptr, \offset + 8])
+	add \ptr, \ptr, \offset
+	.endm
+
+	.macro stp2_pre regA, regB, ptr, offset
+	USER_F(9997f, sttr \regA, [\ptr, \offset])
+	USER_F(9997f, sttr \regB, [\ptr, \offset + 8])
+	add \ptr, \ptr, \offset
+	.endm
+
+	.macro stp3_pre regA, regB, ptr, offset
 	USER_F(9998f, sttr \regA, [\ptr, \offset])
 	USER_F(9998f, sttr \regB, [\ptr, \offset + 8])
 	add \ptr, \ptr, \offset
@@ -68,7 +159,23 @@
 	ldrb \reg, [\ptr, \offset]
 	.endm
 
+	.macro ldrb2_nuao reg, ptr, offset=0
+	ldrb \reg, [\ptr, \offset]
+	.endm
+
+	.macro ldrb3_nuao reg, ptr, offset=0
+	ldrb \reg, [\ptr, \offset]
+	.endm
+
 	.macro strb1_nuao reg, ptr, offset=0
+	USER_F(9996f, strb \reg, [\ptr, \offset])
+	.endm
+
+	.macro strb2_nuao reg, ptr, offset=0
+	USER_F(9997f, strb \reg, [\ptr, \offset])
+	.endm
+
+	.macro strb3_nuao reg, ptr, offset=0
 	USER_F(9998f, strb \reg, [\ptr, \offset])
 	.endm
 
@@ -76,31 +183,95 @@
 	ldrb \reg, [\ptr, \offset]
 	.endm
 
+	.macro ldrb2_nuao_reg reg, ptr, offset=0
+	ldrb \reg, [\ptr, \offset]
+	.endm
+
+	.macro ldrb3_nuao_reg reg, ptr, offset=0
+	ldrb \reg, [\ptr, \offset]
+	.endm
+
 	.macro strb1_nuao_reg reg, ptr, offset=0
-	strb \reg, [\ptr, \offset]
+	USER_F(9996f, strb \reg, [\ptr, \offset])
+	.endm
+
+	.macro strb2_nuao_reg reg, ptr, offset=0
+	USER_F(9997f, strb \reg, [\ptr, \offset])
+	.endm
+
+	.macro strb3_nuao_reg reg, ptr, offset=0
+	USER_F(9998f, strb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldr1_nuao reg, ptr, offset=0
 	ldr \reg, [\ptr, \offset]
 	.endm
 
+	.macro ldr2_nuao reg, ptr, offset=0
+	ldr \reg, [\ptr, \offset]
+	.endm
+
+	.macro ldr3_nuao reg, ptr, offset=0
+	ldr \reg, [\ptr, \offset]
+	.endm
+
 	.macro str1_nuao reg, ptr, offset=0
+	USER_F(9996f, str \reg, [\ptr, \offset])
+	.endm
+
+	.macro str2_nuao reg, ptr, offset=0
+	USER_F(9997f, str \reg, [\ptr, \offset])
+	.endm
+
+	.macro str3_nuao reg, ptr, offset=0
 	USER_F(9998f, str \reg, [\ptr, \offset])
 	.endm
 
-	.macro ldp1_nuao  regA, regB, ptr, offset=0
+	.macro ldp1_nuao regA, regB, ptr, offset=0
 	ldp \regA, \regB, [\ptr, \offset]
 	.endm
 
-	.macro ldp1_pre_nuao regA, regB, ptr, offset
-	ldp \regA, \regB, [\ptr, \offset]!
+	.macro ldp2_nuao regA, regB, ptr, offset=0
+	ldp \regA, \regB, [\ptr, \offset]
+	.endm
+
+	.macro ldp3_nuao regA, regB, ptr, offset=0
+	ldp \regA, \regB, [\ptr, \offset]
 	.endm
 
 	.macro stp1_nuao regA, regB, ptr, offset=0
+	USER_F(9996f, stp \regA, \regB, [\ptr, \offset])
+	.endm
+
+	.macro stp2_nuao regA, regB, ptr, offset=0
+	USER_F(9997f, stp \regA, \regB, [\ptr, \offset])
+	.endm
+
+	.macro stp3_nuao regA, regB, ptr, offset=0
 	USER_F(9998f, stp \regA, \regB, [\ptr, \offset])
 	.endm
 
+	.macro ldp1_pre_nuao regA, regB, ptr, offset
+	ldp \regA, \regB, [\ptr, \offset]!
+	.endm
+
+	.macro ldp2_pre_nuao regA, regB, ptr, offset
+	ldp \regA, \regB, [\ptr, \offset]!
+	.endm
+
+	.macro ldp3_pre_nuao regA, regB, ptr, offset
+	ldp \regA, \regB, [\ptr, \offset]!
+	.endm
+
 	.macro stp1_pre_nuao regA, regB, ptr, offset
+	USER_F(9996f, stp \regA, \regB, [\ptr, \offset]!)
+	.endm
+
+	.macro stp2_pre_nuao regA, regB, ptr, offset
+	USER_F(9997f, stp \regA, \regB, [\ptr, \offset]!)
+	.endm
+
+	.macro stp3_pre_nuao regA, regB, ptr, offset
 	USER_F(9998f, stp \regA, \regB, [\ptr, \offset]!)
 	.endm
 
diff --git a/arch/arm64/lib/copy_user_fixup.S b/arch/arm64/lib/copy_user_fixup.S
index fe9f5ac19605..f878c8831b14 100644
--- a/arch/arm64/lib/copy_user_fixup.S
+++ b/arch/arm64/lib/copy_user_fixup.S
@@ -3,8 +3,19 @@
 addr	.req	x15
 .section .fixup,"ax"
 .align	2
+9993:
+9994:
+9995:
+9996:
+9997:
 9998:
-	// TODO: add accurate fixup
+	/* Retrieve useful information & free the stack area */
+	ldr	count, [sp, #16]	// x2
 	add	sp, sp, 32
+	/*
+	 * Return the initial count as the (under-estimated) number
+	 * of bytes that failed to copy
+	 */
+	mov	x0, count
 	ret
 
diff --git a/arch/arm64/lib/memcpy.S b/arch/arm64/lib/memcpy.S
index c24925aef236..e8d9a0e809b8 100644
--- a/arch/arm64/lib/memcpy.S
+++ b/arch/arm64/lib/memcpy.S
@@ -30,42 +30,122 @@
 	ldrb \reg, [\ptr, \offset]
 	.endm
 
+	.macro ldrb2 reg, ptr, offset=0
+	ldrb \reg, [\ptr, \offset]
+	.endm
+
+	.macro ldrb3 reg, ptr, offset=0
+	ldrb \reg, [\ptr, \offset]
+	.endm
+
 	.macro strb1 reg, ptr, offset=0
 	strb \reg, [\ptr, \offset]
 	.endm
 
+	.macro strb2 reg, ptr, offset=0
+	strb \reg, [\ptr, \offset]
+	.endm
+
+	.macro strb3 reg, ptr, offset=0
+	strb \reg, [\ptr, \offset]
+	.endm
+
 	.macro ldr1 reg, ptr, offset=0
 	ldr \reg, [\ptr, \offset]
 	.endm
 
+	.macro ldr2 reg, ptr, offset=0
+	ldr \reg, [\ptr, \offset]
+	.endm
+
+	.macro ldr3 reg, ptr, offset=0
+	ldr \reg, [\ptr, \offset]
+	.endm
+
 	.macro str1 reg, ptr, offset=0
 	str \reg, [\ptr, \offset]
 	.endm
 
+	.macro str2 reg, ptr, offset=0
+	str \reg, [\ptr, \offset]
+	.endm
+
+	.macro str3 reg, ptr, offset=0
+	str \reg, [\ptr, \offset]
+	.endm
+
 	.macro ldp1 regA, regB, ptr, offset=0
 	ldp \regA, \regB, [\ptr, \offset]
 	.endm
 
+	.macro ldp2 regA, regB, ptr, offset=0
+	ldp \regA, \regB, [\ptr, \offset]
+	.endm
+
+	.macro ldp3 regA, regB, ptr, offset=0
+	ldp \regA, \regB, [\ptr, \offset]
+	.endm
+
 	.macro stp1 regA, regB, ptr, offset=0
 	stp \regA, \regB, [\ptr, \offset]
 	.endm
 
+	.macro stp2 regA, regB, ptr, offset=0
+	stp \regA, \regB, [\ptr, \offset]
+	.endm
+
+	.macro stp3 regA, regB, ptr, offset=0
+	stp \regA, \regB, [\ptr, \offset]
+	.endm
+
 	.macro ldrb1_reg reg, ptr, offset
 	ldrb1 \reg, \ptr, \offset
 	.endm
 
+	.macro ldrb2_reg reg, ptr, offset
+	ldrb2 \reg, \ptr, \offset
+	.endm
+
+	.macro ldrb3_reg reg, ptr, offset
+	ldrb3 \reg, \ptr, \offset
+	.endm
+
 	.macro strb1_reg reg, ptr, offset
 	strb1 \reg, \ptr, \offset
 	.endm
 
+	.macro strb2_reg reg, ptr, offset
+	strb2 \reg, \ptr, \offset
+	.endm
+
+	.macro strb3_reg reg, ptr, offset
+	strb3 \reg, \ptr, \offset
+	.endm
+
 	.macro ldp1_pre regA, regB, ptr, offset
 	ldp \regA, \regB, [\ptr, \offset]!
 	.endm
 
+	.macro ldp2_pre regA, regB, ptr, offset
+	ldp \regA, \regB, [\ptr, \offset]!
+	.endm
+
+	.macro ldp3_pre regA, regB, ptr, offset
+	ldp \regA, \regB, [\ptr, \offset]!
+	.endm
+
 	.macro stp1_pre regA, regB, ptr, offset
 	stp \regA, \regB, [\ptr, \offset]!
 	.endm
 
+	.macro stp2_pre regA, regB, ptr, offset
+	stp \regA, \regB, [\ptr, \offset]!
+	.endm
+
+	.macro stp3_pre regA, regB, ptr, offset
+	stp \regA, \regB, [\ptr, \offset]!
+	.endm
+
 	.macro copy_exit
 	ret
 	.endm
-- 
2.17.1

