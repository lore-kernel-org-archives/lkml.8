Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D722C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ABFB206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgF3TtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:49:01 -0400
Received: from foss.arm.com ([217.140.110.172]:32970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbgF3Tsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:48:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4FE911FB;
        Tue, 30 Jun 2020 12:48:53 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6D4B3F73C;
        Tue, 30 Jun 2020 12:48:52 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/14] arm64: Tidy up _asm_extable_faultaddr usage
Date:   Tue, 30 Jun 2020 19:48:17 +0000
Message-Id: <20200630194822.1082-10-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630194822.1082-1-oli.swede@arm.com>
References: <20200630194822.1082-1-oli.swede@arm.com>
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
 arch/arm64/lib/copy_from_user.S    | 37 ++++++---------
 arch/arm64/lib/copy_in_user.S      | 72 ++++++++++--------------------
 arch/arm64/lib/copy_to_user.S      | 33 +++++---------
 4 files changed, 52 insertions(+), 94 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 438382a277c8..84ddf25546eb 100644
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
index 86945e84c009..fa319f27a42b 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -19,8 +19,8 @@
  * Returns:
  *	x0 - bytes not copied
  */
-	8888: ldtrb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	.macro ldrb1 reg, ptr, offset=0
+	USER_F(9998f, ldtrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1 reg, ptr, offset=0
@@ -29,9 +29,8 @@
 
 	.macro ldrb1_reg reg, ptr, offset
 	add \ptr, \ptr, \offset
-	8888: ldtrb \reg, [\ptr]
+	USER_F(9998f, ldtrb \reg, [\ptr])
 	sub \ptr, \ptr, \offset
-	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
 	.macro strb1_reg reg, ptr, offset
@@ -39,8 +38,7 @@
 	.endm
 
 	.macro ldr1 reg, ptr, offset=0
-	8888: ldtr \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldtr \reg, [\ptr, \offset])
 	.endm
 
 	.macro str1 reg, ptr, offset=0
@@ -48,10 +46,8 @@
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
@@ -59,11 +55,9 @@
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
@@ -71,8 +65,7 @@
 	.endm
 
 	.macro ldrb1_nuao reg, ptr, offset=0
-	8888: ldrb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1_nuao reg, ptr, offset=0
@@ -80,8 +73,7 @@
 	.endm
 
 	.macro ldrb1_nuao_reg reg, ptr, offset=0
-	8888: ldrb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro strb1_nuao_reg reg, ptr, offset=0
@@ -89,8 +81,7 @@
 	.endm
 
 	.macro ldr1_nuao reg, ptr, offset=0
-	8888: ldr \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldr \reg, [\ptr, \offset])
 	.endm
 
 	.macro str1_nuao reg, ptr, offset=0
@@ -98,8 +89,7 @@
 	.endm
 
 	.macro ldp1_nuao  regA, regB, ptr, offset=0
-	8888: ldp \regA, \regB, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldp \regA, \regB, [\ptr, \offset])
 	.endm
 
 	.macro stp1_nuao regA, regB, ptr, offset=0
@@ -107,8 +97,7 @@
 	.endm
 
 	.macro ldp1_pre_nuao regA, regB, ptr, offset
-	8888: ldp \regA, \regB, [\ptr, \offset]!
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, ldp \regA, \regB, [\ptr, \offset]!)
 	.endm
 
 	.macro stp1_pre_nuao regA, regB, ptr, offset
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 77dfccc618b6..6b9bb6091dd8 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -22,117 +22,93 @@
  *	x0 - bytes not copied
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
index 6b4742cac083..23af6af254da 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -24,8 +24,7 @@
 	.endm
 
 	.macro strb1 reg, ptr, offset=0
-	8888: sttrb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, sttrb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldrb1_reg reg, ptr, offset
@@ -34,9 +33,8 @@
 
 	.macro strb1_reg reg, ptr, offset
 	add \ptr, \ptr, \offset
-	8888: sttrb \reg, [\ptr]
+	USER_F(9998f, sttrb \reg, [\ptr])
 	sub \ptr, \ptr, \offset
-	_asm_extable_faultaddr	8888b,9998f;
 	.endm
 
 	.macro ldr1 reg, ptr, offset=0
@@ -44,8 +42,7 @@
 	.endm
 
 	.macro str1 reg, ptr, offset=0
-	8888: sttr \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, sttr \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldp1 regA, regB, ptr, offset=0
@@ -53,10 +50,8 @@
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
@@ -64,11 +59,9 @@
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
@@ -76,8 +69,7 @@
 	.endm
 
 	.macro strb1_nuao reg, ptr, offset=0
-	8888: strb \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, strb \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldrb1_nuao_reg reg, ptr, offset=0
@@ -93,8 +85,7 @@
 	.endm
 
 	.macro str1_nuao reg, ptr, offset=0
-	8888: str \reg, [\ptr, \offset]
-	_asm_extable_faultaddr	8888b,9998f;
+	USER_F(9998f, str \reg, [\ptr, \offset])
 	.endm
 
 	.macro ldp1_nuao  regA, regB, ptr, offset=0
@@ -106,13 +97,11 @@
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

