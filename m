Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAA3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A7123119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgHFRRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:17:35 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45268 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730507AbgHFRPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:15:32 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BMw9W4sZnz9vCqr;
        Thu,  6 Aug 2020 19:15:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id H_nvpsgtjyHA; Thu,  6 Aug 2020 19:15:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BMw9W3wTNz9vCql;
        Thu,  6 Aug 2020 19:15:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AA7C28B816;
        Thu,  6 Aug 2020 19:15:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fmr54tJM5McS; Thu,  6 Aug 2020 19:15:29 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7734E8B7FC;
        Thu,  6 Aug 2020 19:15:29 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4FB0165A68; Thu,  6 Aug 2020 17:15:29 +0000 (UTC)
Message-Id: <4cd127f8988b7b5d3a9b24b67dbad81fef3aee7f.1596734104.git.christophe.leroy@csgroup.eu>
In-Reply-To: <7baae4086cbb9ffb08c933b065ff7d29dbc03dd6.1596734104.git.christophe.leroy@csgroup.eu>
References: <7baae4086cbb9ffb08c933b065ff7d29dbc03dd6.1596734104.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 2/5] powerpc/fault: Unnest definition of
 page_fault_is_write() and page_fault_is_bad()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  6 Aug 2020 17:15:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it more readable, separate page_fault_is_write() and page_fault_is_bad()
to avoir several levels of #ifdefs

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/fault.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 2efa34d7e644..9ef9ee244f72 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -363,17 +363,19 @@ static void sanity_check_fault(bool is_write, bool is_user,
  */
 #if (defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 #define page_fault_is_write(__err)	((__err) & ESR_DST)
-#define page_fault_is_bad(__err)	(0)
 #else
 #define page_fault_is_write(__err)	((__err) & DSISR_ISSTORE)
-#if defined(CONFIG_PPC_8xx)
+#endif
+
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#define page_fault_is_bad(__err)	(0)
+#elif defined(CONFIG_PPC_8xx)
 #define page_fault_is_bad(__err)	((__err) & DSISR_NOEXEC_OR_G)
 #elif defined(CONFIG_PPC64)
 #define page_fault_is_bad(__err)	((__err) & DSISR_BAD_FAULT_64S)
 #else
 #define page_fault_is_bad(__err)	((__err) & DSISR_BAD_FAULT_32S)
 #endif
-#endif
 
 /*
  * For 600- and 800-family processors, the error_code parameter is DSISR
-- 
2.25.0

