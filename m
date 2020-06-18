Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0268DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8DE206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447887;
	bh=nQLIXHFy6ake7k+yX9m+vOFXRc9dhYoKUYv4HmF4pFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FX823crAIduKSqmV/dE3vWWRxsPJHBZAM95H1fdjRUaLeeXrV7vZXNvP5yAhCCBay
	 tsBKOdYvKHVpDasHvLBxWU/zJYq3EG5sldxynjFYW1LbSKL4RCuSK+ErslpoRyYysg
	 3lgBH3oxvoiK5npjFcBRudmMYHSBwtc/MFu5bejM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbgFRCiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgFRBNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:13:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19BC321924;
        Thu, 18 Jun 2020 01:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442812;
        bh=nQLIXHFy6ake7k+yX9m+vOFXRc9dhYoKUYv4HmF4pFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VdSm98HMvwqR4b8/karK2y4etu5+W/9Y+UpEraamly7CCPpozEWy4fChMAo7i/vZc
         2gYq+Hjvsbsv9eirlGC7+mW0TsKM6lnXaZZZcMp2tQtkMmknFsxReoJHGrHYq2No9q
         IUITXw7LgX7Z+VctuAHMLbeXZLOBlOhIKjL/cvRc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.7 251/388] powerpc/kasan: Fix error detection on memory allocation
Date:   Wed, 17 Jun 2020 21:05:48 -0400
Message-Id: <20200618010805.600873-251-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index cbcad369fcb2..8b15fe09b967 100644
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

