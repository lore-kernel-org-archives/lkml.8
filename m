Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C22CC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 083D1206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="d/zvRHSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437070AbgDNIu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:50:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19484 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437048AbgDNIuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:50:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 491dgY5hpDz9tycJ;
        Tue, 14 Apr 2020 10:19:21 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=d/zvRHSf; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ibgGphfFyw-b; Tue, 14 Apr 2020 10:19:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 491dgY1tQCz9ty3F;
        Tue, 14 Apr 2020 10:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586852361; bh=nC9NRfBEIcyt/C5wbGz/eU58sV6bgIGO/DlyXSHQ5oM=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=d/zvRHSfGrGknXnINvZtAbBvhUNhou/gmLffQXWW7YPcepHFCCaQL5j4A7oK/jiVy
         GtZ5URq7zdIjbh9BfgIRpJGRofhGLUKRGMHsBhrD/RiYl3VRyPlvOrowN6wt+uFg6D
         b0sJWfYtuNVzClZOD2q2UJKXFM/n0sp/9b6U94js=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 32E358B797;
        Tue, 14 Apr 2020 10:19:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Sr9Hl-EfPgMR; Tue, 14 Apr 2020 10:19:22 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CB7418B796;
        Tue, 14 Apr 2020 10:19:21 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 9FA7B6578A; Tue, 14 Apr 2020 08:19:21 +0000 (UTC)
Message-Id: <51162586ae526b85b8f7423c8ab889d4523b9629.1586852082.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1586852082.git.christophe.leroy@c-s.fr>
References: <cover.1586852082.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 05/13] powerpc/40x: Remove STB03xxx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, michal.simek@xilinx.com,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 14 Apr 2020 08:19:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_STB03xxx is not user selectable and is not selected
by any config.

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/cputable.c     | 13 -------------
 arch/powerpc/platforms/40x/Kconfig |  5 -----
 2 files changed, 18 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 61bd8fb408b2..bdc4eab0daaf 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1245,19 +1245,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
-	{	/* STB 03xxx */
-		.pvr_mask		= 0xffff0000,
-		.pvr_value		= 0x40130000,
-		.cpu_name		= "STB03xxx",
-		.cpu_features		= CPU_FTRS_40X,
-		.cpu_user_features	= PPC_FEATURE_32 |
-			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
-		.mmu_features		= MMU_FTR_TYPE_40x,
-		.icache_bsize		= 32,
-		.dcache_bsize		= 32,
-		.machine_check		= machine_check_4xx,
-		.platform		= "ppc405",
-	},
 	{	/* STB 04xxx */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x41810000,
diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 8669be59948c..ca8f44650647 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -86,11 +86,6 @@ config 405EZ
 	select IBM_EMAC_MAL_CLR_ICINTSTAT if IBM_EMAC
 	select IBM_EMAC_MAL_COMMON_ERR if IBM_EMAC
 
-config STB03xxx
-	bool
-	select IBM405_ERR77
-	select IBM405_ERR51
-
 config PPC4xx_GPIO
 	bool "PPC4xx GPIO support"
 	depends on 40x
-- 
2.25.0

