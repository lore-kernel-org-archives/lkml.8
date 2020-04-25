Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1D8C55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF332071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cDms1dRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgDYInq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 04:43:46 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:26933 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgDYInk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:43:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 498PhV1JSLz9txp3;
        Sat, 25 Apr 2020 10:43:38 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=cDms1dRQ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ES1suRTsPumc; Sat, 25 Apr 2020 10:43:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 498PhV03WFz9txnX;
        Sat, 25 Apr 2020 10:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587804218; bh=/lgZ5be7C2dgr3D45vmCyTrMsZNvNgzVwY0/UD2Mr1Q=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=cDms1dRQ8k7Kl5vTZBwsSOARqsWEv+jqhX1jnaFXA3RNCxaCIYNMk4u2GQNX43Wc2
         6N8jDzZFoSL7mBu22a8ZrjGvCHndOrGeIthMb59S88BkBU9+jS91HxlGvqe4HwtVdx
         vWq2/B81NehBr3mgBWjz7PdcYabdwPwL03T8z9d8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2E6738B769;
        Sat, 25 Apr 2020 10:43:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6dbaMBXKrtOt; Sat, 25 Apr 2020 10:43:39 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EADAD8B752;
        Sat, 25 Apr 2020 10:43:38 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id AF70865877; Sat, 25 Apr 2020 08:43:38 +0000 (UTC)
Message-Id: <64b3de797ecaa53f5c91e5d76b6fb1fdc906ec86.1587804057.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1587804057.git.christophe.leroy@c-s.fr>
References: <cover.1587804057.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 10/13] powerpc/40x: Remove IBM405 Erratum #51
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, michal.simek@xilinx.com,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 25 Apr 2020 08:43:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This erratum was for IBM 403GCX, 405EP and STB03xxx which are
now gone.

Remove this erratum.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_40x.S     | 6 ------
 arch/powerpc/platforms/40x/Kconfig | 4 ----
 2 files changed, 10 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index b62b6ab769fc..faeea5b56525 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -425,13 +425,7 @@ _ENTRY(saved_ksp_limit)
 	EXCEPTION(0x1400, Trap_14, unknown_exception, EXC_XFER_STD)
 	EXCEPTION(0x1500, Trap_15, unknown_exception, EXC_XFER_STD)
 	EXCEPTION(0x1600, Trap_16, unknown_exception, EXC_XFER_STD)
-#ifdef CONFIG_IBM405_ERR51
-	/* 405GP errata 51 */
-	START_EXCEPTION(0x1700, Trap_17)
-	b DTLBMiss
-#else
 	EXCEPTION(0x1700, Trap_17, unknown_exception, EXC_XFER_STD)
-#endif
 	EXCEPTION(0x1800, Trap_18, unknown_exception, EXC_XFER_STD)
 	EXCEPTION(0x1900, Trap_19, unknown_exception, EXC_XFER_STD)
 	EXCEPTION(0x1A00, Trap_1A, unknown_exception, EXC_XFER_STD)
diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 253c047fe6fe..ebe283476461 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -75,10 +75,6 @@ config PPC4xx_GPIO
 config IBM405_ERR77
 	bool
 
-# All 40x-based cores, up until the 405GPR and 405EP have this errata.
-config IBM405_ERR51
-	bool
-
 config APM8018X
 	bool "APM8018X"
 	depends on 40x
-- 
2.25.0

