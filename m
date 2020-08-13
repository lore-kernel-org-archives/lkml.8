Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7B2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0608F20791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHMKMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:12:08 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11586 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgHMKME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:12:04 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BS2Rj48LWz9vD3l;
        Thu, 13 Aug 2020 12:12:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HNU5IkxHiCdk; Thu, 13 Aug 2020 12:12:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BS2Rj2YKPz9vD3q;
        Thu, 13 Aug 2020 12:12:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A3F918B783;
        Thu, 13 Aug 2020 12:12:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3iEaWgAURuFh; Thu, 13 Aug 2020 12:12:02 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5F5658B788;
        Thu, 13 Aug 2020 12:12:02 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 32A9865C54; Thu, 13 Aug 2020 10:12:02 +0000 (UTC)
Message-Id: <13dffd546b11b71ca227c1fe74b2ccdf08c7cfff.1597313510.git.christophe.leroy@csgroup.eu>
In-Reply-To: <11a330af231af22874c006302a945388846f8112.1597313510.git.christophe.leroy@csgroup.eu>
References: <11a330af231af22874c006302a945388846f8112.1597313510.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 3/5] powerpc: Remove flush_instruction_cache() on 8xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 13 Aug 2020 10:12:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_instruction_cache() is never used on 8xx, remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/8xx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index d2b37146ae6c..231ca95f9ffb 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -244,13 +244,6 @@ void set_context(unsigned long id, pgd_t *pgd)
 	mb();
 }
 
-void flush_instruction_cache(void)
-{
-	isync();
-	mtspr(SPRN_IC_CST, IDC_INVALL);
-	isync();
-}
-
 #ifdef CONFIG_PPC_KUEP
 void __init setup_kuep(bool disabled)
 {
-- 
2.25.0

