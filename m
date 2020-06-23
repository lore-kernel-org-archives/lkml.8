Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AEFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB48820E65
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943089;
	bh=J5IhWaPMJFC7r14QlHmQaOchkBGc9LbyWQaCU3X9NnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nAQLa/e85SNgy3UCc94ghjqYhajyfVFjx4jMGuTo392TIeGoGuUSlNID8uDq3FPKt
	 fW9/RDLp11hse1EE9YD2zYOD1mpf1UvZL+t8tJooh5VgTBUDzfvbTbofOtdlFbu8Y7
	 dDzKMJP2jdYN64w9zswRnjQHlCOvSmrxZI+f7aTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbgFWUL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388872AbgFWULG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:11:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8407F20707;
        Tue, 23 Jun 2020 20:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943066;
        bh=J5IhWaPMJFC7r14QlHmQaOchkBGc9LbyWQaCU3X9NnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nv3Vdyw9JhY7sP61TmTpHUDLxiLFTcstHGdJTXiCFubsOnXlZ8pK7U0olxMeepGYu
         g449XUyDESfHiHeTQTscNC0lItQkD/aSf+AP9qX3Jmsp/we/SFUBqyXDVeQZgt76Kl
         S1vXvNxn76EedC/DeZsRPuKqViwcXj/pWXmfxSXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 247/477] powerpc/kasan: Fix error detection on memory allocation
Date:   Tue, 23 Jun 2020 21:54:04 +0200
Message-Id: <20200623195419.245753554@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit d132443a73d7a131775df46f33000f67ed92de1e ]

In case (k_start & PAGE_MASK) doesn't equal (kstart), 'va' will never be
NULL allthough 'block' is NULL

Check the return of memblock_alloc() directly instead of
the resulting address in the loop.

Fixes: 509cd3f2b473 ("powerpc/32: Simplify KASAN init")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/7cb8ca82042bfc45a5cfe726c921cd7e7eeb12a3.1589866984.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/kasan/kasan_init_32.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index 59e49c0e81543..b7c287adfd598 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -76,15 +76,14 @@ static int __init kasan_init_region(void *start, size_t size)
 		return ret;
 
 	block = memblock_alloc(k_end - k_start, PAGE_SIZE);
+	if (!block)
+		return -ENOMEM;
 
 	for (k_cur = k_start & PAGE_MASK; k_cur < k_end; k_cur += PAGE_SIZE) {
 		pmd_t *pmd = pmd_ptr_k(k_cur);
 		void *va = block + k_cur - k_start;
 		pte_t pte = pfn_pte(PHYS_PFN(__pa(va)), PAGE_KERNEL);
 
-		if (!va)
-			return -ENOMEM;
-
 		__set_pte_at(&init_mm, k_cur, pte_offset_kernel(pmd, k_cur), pte, 0);
 	}
 	flush_tlb_kernel_range(k_start, k_end);
-- 
2.25.1



