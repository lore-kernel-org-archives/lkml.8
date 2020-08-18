Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBE0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9316020658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgHRRVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:21:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52670 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbgHRRTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:19:21 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWHhN6tVJz9vCxv;
        Tue, 18 Aug 2020 19:19:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id I2Vn_tjqvJPA; Tue, 18 Aug 2020 19:19:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWHhN66T6z9vCxg;
        Tue, 18 Aug 2020 19:19:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A4C5C8B7EE;
        Tue, 18 Aug 2020 19:19:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QgcoIcraXlLy; Tue, 18 Aug 2020 19:19:18 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 62BC08B7D7;
        Tue, 18 Aug 2020 19:19:18 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4492D65CF4; Tue, 18 Aug 2020 17:19:18 +0000 (UTC)
Message-Id: <fcdc60d85baf80eaa0a7f3261d9d889282068216.1597770847.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 06/25] powerpc/32s: Allow deselecting CONFIG_PPC_FPU on
 mpc832x
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Aug 2020 17:19:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The e300c2 core which is embedded in mpc832x CPU doesn't have
an FPU.

Make it possible to not select CONFIG_PPC_FPU when building a
kernel dedicated to that target.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_32.S          |  4 ++++
 arch/powerpc/platforms/Kconfig.cputype | 11 +++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index f3ab94d73936..588fe8644df6 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -413,6 +413,7 @@ Alignment:
 	. = 0x800
 	DO_KVM  0x800
 FPUnavailable:
+#ifdef CONFIG_PPC_FPU
 BEGIN_FTR_SECTION
 /*
  * Certain Freescale cores don't have a FPU and treat fp instructions
@@ -426,6 +427,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_FPU_UNAVAILABLE)
 	b	fast_exception_return
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_LITE(0x800, kernel_fp_unavailable_exception)
+#else
+	b 	ProgramCheck
+#endif
 
 /* Decrementer */
 	EXCEPTION(0x900, Decrementer, timer_interrupt, EXC_XFER_LITE)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 40ffcdba42b8..d4fd109f177e 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -32,7 +32,7 @@ choice
 config PPC_BOOK3S_6xx
 	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx except 601"
 	select PPC_BOOK3S_32
-	select PPC_FPU
+	imply PPC_FPU
 	select PPC_HAVE_PMU_SUPPORT
 	select PPC_HAVE_KUEP
 	select PPC_HAVE_KUAP
@@ -229,9 +229,16 @@ config PPC_FPU_REGS
 	bool
 
 config PPC_FPU
-	bool
+	bool "Support for Floating Point Unit (FPU)" if PPC_MPC832x
 	default y if PPC64
 	select PPC_FPU_REGS
+	help
+	  This must be enabled to support the Floating Point Unit
+	  Most 6xx have an FPU but e300c2 core (mpc832x) don't have
+	  an FPU, so when building an embedded kernel for that target
+	  you can disable FPU support.
+
+	  If unsure say Y.
 
 config FSL_EMB_PERFMON
 	bool "Freescale Embedded Perfmon"
-- 
2.25.0

