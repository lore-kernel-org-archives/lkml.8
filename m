Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2A9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334B723119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbgHFRQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:16:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30827 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730131AbgHFRPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:15:32 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BMw9V59Zgz9vCqq;
        Thu,  6 Aug 2020 19:15:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vamTd93RcqFz; Thu,  6 Aug 2020 19:15:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BMw9V3Gcjz9vCql;
        Thu,  6 Aug 2020 19:15:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C0BCB8B816;
        Thu,  6 Aug 2020 19:15:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MlhVkdSLcO5I; Thu,  6 Aug 2020 19:15:28 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 865D98B7FC;
        Thu,  6 Aug 2020 19:15:28 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5124665A68; Thu,  6 Aug 2020 17:15:28 +0000 (UTC)
Message-Id: <7baae4086cbb9ffb08c933b065ff7d29dbc03dd6.1596734104.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 1/5] powerpc/mm: sanity_check_fault() should work for all,
 not only BOOK3S
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  6 Aug 2020 17:15:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The verification and message introduced by commit 374f3f5979f9
("powerpc/mm/hash: Handle user access of kernel address gracefully")
applies to all platforms, it should not be limited to BOOK3S.

Make the BOOK3S version of sanity_check_fault() the one for all,
and bail out earlier if not BOOK3S.

Fixes: 374f3f5979f9 ("powerpc/mm/hash: Handle user access of kernel address gracefully")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/fault.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 925a7231abb3..2efa34d7e644 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -303,7 +303,6 @@ static inline void cmo_account_page_fault(void)
 static inline void cmo_account_page_fault(void) { }
 #endif /* CONFIG_PPC_SMLPAR */
 
-#ifdef CONFIG_PPC_BOOK3S
 static void sanity_check_fault(bool is_write, bool is_user,
 			       unsigned long error_code, unsigned long address)
 {
@@ -320,6 +319,9 @@ static void sanity_check_fault(bool is_write, bool is_user,
 		return;
 	}
 
+	if (!IS_ENABLED(CONFIG_PPC_BOOK3S))
+		return;
+
 	/*
 	 * For hash translation mode, we should never get a
 	 * PROTFAULT. Any update to pte to reduce access will result in us
@@ -354,10 +356,6 @@ static void sanity_check_fault(bool is_write, bool is_user,
 
 	WARN_ON_ONCE(error_code & DSISR_PROTFAULT);
 }
-#else
-static void sanity_check_fault(bool is_write, bool is_user,
-			       unsigned long error_code, unsigned long address) { }
-#endif /* CONFIG_PPC_BOOK3S */
 
 /*
  * Define the correct "is_write" bit in error_code based
-- 
2.25.0

