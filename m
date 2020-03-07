Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B6EC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B01B2073D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VA8mEknU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgCGKJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 05:09:24 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:29426 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgCGKJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 05:09:23 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48ZKw04l91z9tyJV;
        Sat,  7 Mar 2020 11:09:20 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VA8mEknU; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 32DtUaR_qY3G; Sat,  7 Mar 2020 11:09:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48ZKw03V1zz9tyJT;
        Sat,  7 Mar 2020 11:09:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1583575760; bh=QF5moGMgYbnR8ZU8yFqiJqUSMgosscuIMeqnvY3R3MA=;
        h=From:Subject:To:Cc:Date:From;
        b=VA8mEknU+jpXH6BiQrTOc8wox0jcH31NzFYTXDaCnZ6ny3nweAZS6E6S6D/N3zmBy
         M9A9AWT58xSzxji9J7FKFCk/K2cDJnXJvkJsqCdubq+yK7erUZDPHnW4j5iCEL6sgI
         r474TiPxz9rPb5IxEtFxAUaR2OYx9DePZg+UfEfY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 995CC8B785;
        Sat,  7 Mar 2020 11:09:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DwWifxh8Ip9Y; Sat,  7 Mar 2020 11:09:16 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5CD438B776;
        Sat,  7 Mar 2020 11:09:16 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1682365494; Sat,  7 Mar 2020 10:09:15 +0000 (UTC)
Message-Id: <b1177cdfc6af74a3e277bba5d9e708c4b3315ebe.1583575707.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: Fix missing NULL pmd check in virt_to_kpte()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat,  7 Mar 2020 10:09:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2efc7c085f05 ("powerpc/32: drop get_pteptr()"),
replaced get_pteptr() by virt_to_kpte(). But virt_to_kpte() lacks a
NULL pmd check and returns an invalid non NULL pointer when there
is no page table.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Fixes: 2efc7c085f05 ("powerpc/32: drop get_pteptr()")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/pgtable.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index b80bfd41828d..b1f1d5339735 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -54,7 +54,9 @@ static inline pmd_t *pmd_ptr_k(unsigned long va)
 
 static inline pte_t *virt_to_kpte(unsigned long vaddr)
 {
-	return pte_offset_kernel(pmd_ptr_k(vaddr), vaddr);
+	pmd_t *pmd = pmd_ptr_k(vaddr);
+
+	return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
 }
 #endif
 
-- 
2.25.0

