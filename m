Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE340C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAED22071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="YRQAFITz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgDYIoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 04:44:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40419 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgDYInk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:43:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 498PhT3DsMz9txng;
        Sat, 25 Apr 2020 10:43:37 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=YRQAFITz; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NBKbD9UTYA-D; Sat, 25 Apr 2020 10:43:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 498PhT2C94z9txnX;
        Sat, 25 Apr 2020 10:43:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587804217; bh=P5l/XUfUvD4P00st6kgxn9/rml1eRRECj9OWtVUlXpg=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=YRQAFITzY2Xnacn3F7KrQofUe/0DHV5nDR60ibLPKXRLspzxRS/yQsnSkdPdBZPLr
         8K7JgYfwgddKDcpvXMmwFqDCZ/ximB3ciN6ZmjarGWt+o6fChqNYsoDf/gh44zef1S
         UNo7fFpVx/RMhkcHFbdkw6MuIIEyOdNyWiyIgkBc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7BB2E8B769;
        Sat, 25 Apr 2020 10:43:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Iqzie9n1brQE; Sat, 25 Apr 2020 10:43:38 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 345278B752;
        Sat, 25 Apr 2020 10:43:38 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A3B8265877; Sat, 25 Apr 2020 08:43:37 +0000 (UTC)
Message-Id: <2ccc850178ee7723c1b371cfe205713b0115b689.1587804057.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1587804057.git.christophe.leroy@c-s.fr>
References: <cover.1587804057.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 09/13] powerpc/40x: Remove support for IBM 405GP
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, michal.simek@xilinx.com,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 25 Apr 2020 08:43:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All platforms selecting the obsolete processor are gone now.

Remove support for it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/cputable.c     | 13 -------------
 arch/powerpc/platforms/40x/Kconfig |  6 ------
 2 files changed, 19 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index bdc4eab0daaf..8ed553734919 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1232,19 +1232,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 	},
 #endif /* CONFIG_PPC_8xx */
 #ifdef CONFIG_40x
-	{	/* 405GP */
-		.pvr_mask		= 0xffff0000,
-		.pvr_value		= 0x40110000,
-		.cpu_name		= "405GP",
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
index 5d9d96e7223a..253c047fe6fe 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -51,12 +51,6 @@ config PPC40x_SIMPLE
 	help
 	  This option enables the simple PowerPC 40x platform support.
 
-config 405GP
-	bool
-	select IBM405_ERR77
-	select IBM405_ERR51
-	select IBM_EMAC_ZMII if IBM_EMAC
-
 config 405EX
 	bool
 	select IBM_EMAC_EMAC4 if IBM_EMAC
-- 
2.25.0

