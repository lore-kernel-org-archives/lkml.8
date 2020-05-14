Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27C6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12DF20727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgENOdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:33:16 -0400
Received: from foss.arm.com ([217.140.110.172]:37730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbgENOc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:32:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69A091FB;
        Thu, 14 May 2020 07:32:57 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73A4C3F71E;
        Thu, 14 May 2020 07:32:56 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/13] arm64: Tidy up _asm_extable_faultaddr usage
Date:   Thu, 14 May 2020 14:32:23 +0000
Message-Id: <20200514143227.605-10-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514143227.605-1-oli.swede@arm.com>
References: <20200514143227.605-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

To match the way the USER() shorthand wraps _asm_extable entries,
introduce USER_F() to wrap _asm_extable_faultaddr and clean up a bit.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/include/asm/assembler.h |  4 ++
 arch/arm64/lib/copy_from_user.S    | 36 +++++----------
 arch/arm64/lib/copy_in_user.S      | 72 ++++++++++--------------------
 arch/arm64/lib/copy_to_user.S      | 33 +++++---------
 4 files changed, 51 insertions(+), 94 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 7017aeb4b29a..384b6584b27f 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -142,6 +142,10 @@ alternative_endif
 9999:	x;					\
 	_asm_extable	9999b, l
 
+#define USER_F(l, x...)				\
+9999:	x;					\
+	_asm_extable_faultaddr	9999b, l
+
 /*
  * Register aliases.
  */
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index dbf768cc7650..9c3805725bea 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -21,8 +21,7 @@
  */
 
 	.macro ldrb1 reg, ptr, offset=0
-	8888: ldtrb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldtrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1 reg, ptr, offset=0
@@ -31,9 +30,8 @@
 
 	.macro ldrb1_reg reg, ptr, offset
 	add \ptr, \ptr, \offset
-	8888: ldtrb \reg, [\ptr]
+	USER_F(9998f, ldtrb \reg, [\ptr])
 	sub \ptr, \ptr, \offset
-	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
 	.macro strb1_reg reg, ptr, offset
@@ -41,8 +39,7 @@
 	.endm
 
 	.macro ldr1 reg, ptr, offset=0
-	8888: ldtr \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldtr \reg, [\ptr, \offset])
 	.endm
 
 	.macro str1 reg, ptr, offset=0
@@ -50,10 +47,8 @@
 	.endm
 
 	.macro ldp1 regA, regB, ptr, offset=0
-	8888: ldtr \regA, [\ptr, \offset]
-	8889: ldtr \regB, [\ptr, \offset + 8]
-	_asm_extable_faultaddr	8888b,9998f;
-	_asm_extable_faultaddr	8889b,9998f;
+	USER_F(9998f, ldtr \regA, [\ptr, \offset])
+	USER_F(9998f, ldtr \regB, [\ptr, \offset + 8])
 	.endm
 
 	.macro stp1 regA, regB, ptr, offset=0
@@ -61,11 +56,9 @@
 	.endm
 
 	.macro ldp1_pre regA, regB, ptr, offset
-	8888: ldtr \regA, [\ptr, \offset]
-	8889: ldtr \regB, [\ptr, \offset + 8]
+	USER_F(9998f, ldtr \regA, [\ptr, \offset])
+	USER_F(9998f, ldtr \regB, [\ptr, \offset + 8])
 	add \ptr, \ptr, \offset
-	_asm_extable_faultaddr	8888b,9998f;
-	_asm_extable_faultaddr	8889b,9998f;
 	.endm
 
 	.macro stp1_pre regA, regB, ptr, offset
@@ -73,8 +66,7 @@
 	.endm
 
 	.macro ldrb1_nuao reg, ptr, offset=0
-	8888: ldrb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1_nuao reg, ptr, offset=0
@@ -82,8 +74,7 @@
 	.endm
 
 	.macro ldrb1_nuao_reg reg, ptr, offset=0
-	8888: ldrb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1_nuao_reg reg, ptr, offset=0
@@ -91,8 +82,7 @@
 	.endm
 
 	.macro ldr1_nuao reg, ptr, offset=0
-	8888: ldr \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldr \reg, [\ptr, \offset])
 	.endm
 
 	.macro str1_nuao reg, ptr, offset=0
@@ -100,8 +90,7 @@
 	.endm
 
 	.macro ldp1_nuao  regA, regB, ptr, offset=0
-	8888: ldp \regA, \regB, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldp \regA, \regB, [\ptr, \offset])
 	.endm
 
 	.macro stp1_nuao regA, regB, ptr, offset=0
@@ -109,8 +98,7 @@
 	.endm
 
 	.macro ldp1_pre_nuao regA, regB, ptr, offset
-	8888: ldp \regA, \regB, [\ptr, \offset]!
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldp \regA, \regB, [\ptr, \offset]!)
 	.endm
 
 	.macro stp1_pre_nuao regA, regB, ptr, offset
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index f08d4b36a857..bdf9bfecf31f 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -23,117 +23,93 @@
  */
 
 	.macro ldrb1 reg, ptr, offset=0
-	8888: ldtrb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldtrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1 reg, ptr, offset=0
-	8888: sttrb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, sttrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldrb1_reg reg, ptr, offset
 	add \ptr, \ptr, \offset
-	8888: ldtrb \reg, [\ptr]
+	USER_F(9998f, ldtrb \reg, [\ptr])
 	sub \ptr, \ptr, \offset
-	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
 	.macro strb1_reg reg, ptr, offset
 	add \ptr, \ptr, \offset
-	8888: sttrb \reg, [\ptr]
+	USER_F(9998f, sttrb \reg, [\ptr])
 	sub \ptr, \ptr, \offset
-	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
 	.macro ldr1 reg, ptr, offset=0
-	8888: ldtr \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldtr \reg, [\ptr, \offset])
 	.endm
 
 	.macro str1 reg, ptr, offset=0
-	8888: sttr \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, sttr \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldp1 regA, regB, ptr, offset=0
-	8888: ldtr \regA, [\ptr, \offset]
-	8889: ldtr \regB, [\ptr, \offset + 8]
-	_asm_extable_faultaddr	8888b,9998f;
-	_asm_extable_faultaddr	8889b,9998f;
+	USER_F(9998f, ldtr \regA, [\ptr, \offset])
+	USER_F(9998f, ldtr \regB, [\ptr, \offset + 8])
 	.endm
 
 	.macro stp1 regA, regB, ptr, offset=0
-	8888: sttr \regA, [\ptr, \offset]
-	8889: sttr \regB, [\ptr, \offset + 8]
-	_asm_extable_faultaddr	8888b,9998f;
-	_asm_extable_faultaddr	8889b,9998f;
+	USER_F(9998f, sttr \regA, [\ptr, \offset])
+	USER_F(9998f, sttr \regB, [\ptr, \offset + 8])
 	.endm
 
 	.macro ldp1_pre regA, regB, ptr, offset
-	8888: ldtr \regA, [\ptr, \offset]
-	8889: ldtr \regB, [\ptr, \offset + 8]
+	USER_F(9998f, ldtr \regA, [\ptr, \offset])
+	USER_F(9998f, ldtr \regB, [\ptr, \offset + 8])
 	add \ptr, \ptr, \offset
-	_asm_extable_faultaddr	8888b,9998f;
-	_asm_extable_faultaddr	8889b,9998f;
 	.endm
 
 	.macro stp1_pre regA, regB, ptr, offset
-	8888: sttr \regA, [\ptr, \offset]
-	8889: sttr \regB, [\ptr, \offset + 8]
+	USER_F(9998f, sttr \regA, [\ptr, \offset])
+	USER_F(9998f, sttr \regB, [\ptr, \offset + 8])
 	add \ptr, \ptr, \offset
-	_asm_extable_faultaddr	8888b,9998f;
-	_asm_extable_faultaddr	8889b,9998f;
 	.endm
 
 	.macro ldrb1_nuao reg, ptr, offset=0
-	8888: ldrb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1_nuao reg, ptr, offset=0
-	8888: strb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, strb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldrb1_nuao_reg reg, ptr, offset=0
-	8888: ldrb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1_nuao_reg reg, ptr, offset=0
-	8888: strb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, strb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldr1_nuao reg, ptr, offset=0
-	8888: ldr \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldr \reg, [\ptr, \offset])
 	.endm
 
 	.macro str1_nuao reg, ptr, offset=0
-	8888: str \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, str \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldp1_nuao  regA, regB, ptr, offset=0
-	8888: ldp \regA, \regB, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldp \regA, \regB, [\ptr, \offset])
 	.endm
 
 	.macro stp1_nuao regA, regB, ptr, offset=0
-	8888: stp \regA, \regB, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, stp \regA, \regB, [\ptr, \offset])
 	.endm
 
 	.macro ldp1_pre_nuao regA, regB, ptr, offset
-	8888: ldp \regA, \regB, [\ptr, \offset]!
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldp \regA, \regB, [\ptr, \offset]!)
 	.endm
 
 	.macro stp1_pre_nuao regA, regB, ptr, offset
-	8888: stp \regA, \regB, [\ptr, \offset]!
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, stp \regA, \regB, [\ptr, \offset]!)
 	.endm
 
 	.macro copy_exit
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index e4629c83abb4..b936bc10594e 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -25,8 +25,7 @@
 	.endm
 
 	.macro strb1 reg, ptr, offset=0
-	8888: sttrb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, sttrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldrb1_reg reg, ptr, offset
@@ -35,9 +34,8 @@
 
 	.macro strb1_reg reg, ptr, offset
 	add \ptr, \ptr, \offset
-	8888: sttrb \reg, [\ptr]
+	USER_F(9998f, sttrb \reg, [\ptr])
 	sub \ptr, \ptr, \offset
-	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
 	.macro ldr1 reg, ptr, offset=0
@@ -45,8 +43,7 @@
 	.endm
 
 	.macro str1 reg, ptr, offset=0
-	8888: sttr \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, sttr \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldp1 regA, regB, ptr, offset=0
@@ -54,10 +51,8 @@
 	.endm
 
 	.macro stp1 regA, regB, ptr, offset=0
-	8888: sttr \regA, [\ptr, \offset]
-	8889: sttr \regB, [\ptr, \offset + 8]
-	_asm_extable_faultaddr	8888b,9998f;
-	_asm_extable_faultaddr	8889b,9998f;
+	USER_F(9998f, sttr \regA, [\ptr, \offset])
+	USER_F(9998f, sttr \regB, [\ptr, \offset + 8])
 	.endm
 
 	.macro ldp1_pre regA, regB, ptr, offset
@@ -65,11 +60,9 @@
 	.endm
 
 	.macro stp1_pre regA, regB, ptr, offset
-	8888: sttr \regA, [\ptr, \offset]
-	8889: sttr \regB, [\ptr, \offset + 8]
+	USER_F(9998f, sttr \regA, [\ptr, \offset])
+	USER_F(9998f, sttr \regB, [\ptr, \offset + 8])
 	add \ptr, \ptr, \offset
-	_asm_extable_faultaddr	8888b,9998f;
-	_asm_extable_faultaddr	8889b,9998f;
 	.endm
 
 	.macro ldrb1_nuao reg, ptr, offset=0
@@ -77,8 +70,7 @@
 	.endm
 
 	.macro strb1_nuao reg, ptr, offset=0
-	8888: strb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, strb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldrb1_nuao_reg reg, ptr, offset=0
@@ -94,8 +86,7 @@
 	.endm
 
 	.macro str1_nuao reg, ptr, offset=0
-	8888: str \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, str \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldp1_nuao  regA, regB, ptr, offset=0
@@ -107,13 +98,11 @@
 	.endm
 
 	.macro stp1_nuao regA, regB, ptr, offset=0
-	8888: stp \regA, \regB, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, stp \regA, \regB, [\ptr, \offset])
 	.endm
 
 	.macro stp1_pre_nuao regA, regB, ptr, offset
-	8888: stp \regA, \regB, [\ptr, \offset]!
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, stp \regA, \regB, [\ptr, \offset]!)
 	.endm
 
 	.macro copy_exit
-- 
2.17.1

