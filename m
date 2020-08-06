Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8558CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9789F221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHFTvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:51:19 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64798 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgHFTvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:51:07 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BMndG3llCzB09ZR;
        Thu,  6 Aug 2020 14:20:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id TuxF9pezDG3S; Thu,  6 Aug 2020 14:20:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BMndG2lCLzB09ZL;
        Thu,  6 Aug 2020 14:20:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 135DA8B80D;
        Thu,  6 Aug 2020 14:20:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id avjRKZaeuOha; Thu,  6 Aug 2020 14:20:36 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DB7398B7FC;
        Thu,  6 Aug 2020 14:20:35 +0200 (CEST)
Received: by po16052vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C67A765BEB; Thu,  6 Aug 2020 12:20:35 +0000 (UTC)
Message-Id: <edcdd72a36495d25213c0256c8022367458e0d19.1596716418.git.christophe.leroy@csgroup.eu>
In-Reply-To: <d5641ada199b8dd2af16ad00a66084cf974f2704.1596716418.git.christophe.leroy@csgroup.eu>
References: <d5641ada199b8dd2af16ad00a66084cf974f2704.1596716418.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/2] powerpc: drop hard_reset_now() and poweroff_now()
 declaration
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  6 Aug 2020 12:20:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those function have never existed. Drop their declaration.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/processor.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 9ebcb2f095db..2b4dc10230da 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -422,8 +422,6 @@ extern void power9_idle_type(unsigned long stop_psscr_val,
 			      unsigned long stop_psscr_mask);
 
 extern void flush_instruction_cache(void);
-extern void hard_reset_now(void);
-extern void poweroff_now(void);
 extern int fix_alignment(struct pt_regs *);
 extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
 
-- 
2.25.0

