Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6B2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B70208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgHZMxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbgHZMxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:53:02 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804ECC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 05:53:01 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id LCt0230024C55Sk01Ct0Tn; Wed, 26 Aug 2020 14:53:00 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kAuvE-00082s-2F; Wed, 26 Aug 2020 14:53:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kAuvE-0006Gw-0N; Wed, 26 Aug 2020 14:53:00 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: Sort selects in main Kconfig
Date:   Wed, 26 Aug 2020 14:52:59 +0200
Message-Id: <20200826125259.24069-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the list of select statements in the main Kconfig file for the m68k
architecture, to avoid conflicts when modifying this list.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 6f2f38d05772ab55..93bbb74ea876d6f2 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -6,32 +6,32 @@ config M68K
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
+	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_PREEMPT if !COLDFIRE
+	select ARCH_WANT_IPC_PARSE_VERSION
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 	select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE
-	select HAVE_IDE
-	select HAVE_AOUT if MMU
-	select HAVE_ASM_MODVERSIONS
-	select HAVE_DEBUG_BUGVERBOSE
-	select GENERIC_IRQ_SHOW
 	select GENERIC_ATOMIC64
-	select NO_DMA if !MMU && !COLDFIRE
-	select HAVE_UID16
-	select VIRT_TO_BUS
-	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IOMAP
+	select GENERIC_IRQ_SHOW
 	select GENERIC_STRNCPY_FROM_USER if MMU
 	select GENERIC_STRNLEN_USER if MMU
-	select ARCH_WANT_IPC_PARSE_VERSION
+	select HAVE_AOUT if MMU
+	select HAVE_ASM_MODVERSIONS
+	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_FUTEX_CMPXCHG if MMU && FUTEX
+	select HAVE_IDE
 	select HAVE_MOD_ARCH_SPECIFIC
+	select HAVE_UID16
+	select MMU_GATHER_NO_RANGE if MMU
 	select MODULES_USE_ELF_REL
 	select MODULES_USE_ELF_RELA
-	select OLD_SIGSUSPEND3
+	select NO_DMA if !MMU && !COLDFIRE
 	select OLD_SIGACTION
-	select MMU_GATHER_NO_RANGE if MMU
+	select OLD_SIGSUSPEND3
+	select VIRT_TO_BUS
 
 config CPU_BIG_ENDIAN
 	def_bool y
-- 
2.17.1

