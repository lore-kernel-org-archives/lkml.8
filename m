Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08360C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4283205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UrFmUvaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbgCPMh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:37:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11865 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731212AbgCPMgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:36:18 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwlH2vYyz9v02g;
        Mon, 16 Mar 2020 13:36:11 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=UrFmUvaa; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Yc4rMkUwDvrf; Mon, 16 Mar 2020 13:36:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwlH1vPnz9v02f;
        Mon, 16 Mar 2020 13:36:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362171; bh=yPomq71t4Ot+iqtcEYk1P3G8sDqUlOKuTjtVtJoIlw0=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=UrFmUvaaSCNSeRNhaemorwC5VEpUUycOxjZLAFZSl1swQa94ssNjiL0gt9UylSjsd
         bFO5Y8wemiHHPRqzxcGvMD/h9j4Y+wAIayGIVqGxxNXApPwqVjyXmo4lXUT9hVjarI
         6c421TZMEjs8SSTWzVbM47inBy2vjCzvgJMD8Yvk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 27A1B8B7D0;
        Mon, 16 Mar 2020 13:36:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id p-g596VD46QN; Mon, 16 Mar 2020 13:36:16 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 040078B7CB;
        Mon, 16 Mar 2020 13:36:16 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id ECBB665595; Mon, 16 Mar 2020 12:36:15 +0000 (UTC)
Message-Id: <71fd1adc9296f2d2e5bd8bf6841a770f361688e2.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 30/46] powerpc/8xx: Move PPC_PIN_TLB options into 8xx
 Kconfig
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:36:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPC_PIN_TLB options are dedicated to the 8xx, move them into
the 8xx Kconfig.

While we are at it, add some text to explain what it does.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig               | 20 ---------------
 arch/powerpc/platforms/8xx/Kconfig | 41 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 497b7d0b2d7e..f3ea52bcbaf8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1222,26 +1222,6 @@ config TASK_SIZE
 	hex "Size of user task space" if TASK_SIZE_BOOL
 	default "0x80000000" if PPC_8xx
 	default "0xc0000000"
-
-config PIN_TLB
-	bool "Pinned Kernel TLBs (860 ONLY)"
-	depends on ADVANCED_OPTIONS && PPC_8xx && \
-		   !DEBUG_PAGEALLOC && !STRICT_KERNEL_RWX
-
-config PIN_TLB_DATA
-	bool "Pinned TLB for DATA"
-	depends on PIN_TLB
-	default y
-
-config PIN_TLB_IMMR
-	bool "Pinned TLB for IMMR"
-	depends on PIN_TLB || PPC_EARLY_DEBUG_CPM
-	default y
-
-config PIN_TLB_TEXT
-	bool "Pinned TLB for TEXT"
-	depends on PIN_TLB
-	default y
 endmenu
 
 if PPC64
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index b37de62d7e7f..0d036cd868ef 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -162,4 +162,45 @@ config UCODE_PATCH
 	default y
 	depends on !NO_UCODE_PATCH
 
+menu "8xx advanced setup"
+	depends on PPC_8xx
+
+config PIN_TLB
+	bool "Pinned Kernel TLBs"
+	depends on ADVANCED_OPTIONS && !DEBUG_PAGEALLOC && !STRICT_KERNEL_RWX
+	help
+	  On the 8xx, we have 32 instruction TLBs and 32 data TLBs. In each
+	  table 4 TLBs can be pinned.
+
+	  It reduces the amount of usable TLBs to 28 (ie by 12%). That's the
+	  reason why we make it selectable.
+
+	  This option does nothing, it just activate the selection of what
+	  to pin.
+
+config PIN_TLB_DATA
+	bool "Pinned TLB for DATA"
+	depends on PIN_TLB
+	default y
+	help
+	  This pins the first 32 Mbytes of memory with 8M pages.
+
+config PIN_TLB_IMMR
+	bool "Pinned TLB for IMMR"
+	depends on PIN_TLB || PPC_EARLY_DEBUG_CPM
+	default y
+	help
+	  This pins the IMMR area with a 512kbytes page. In case
+	  CONFIG_PIN_TLB_DATA is also selected, it will reduce
+	  CONFIG_PIN_TLB_DATA to 24 Mbytes.
+
+config PIN_TLB_TEXT
+	bool "Pinned TLB for TEXT"
+	depends on PIN_TLB
+	default y
+	help
+	  This pins kernel text with 8M pages.
+
+endmenu
+
 endmenu
-- 
2.25.0

