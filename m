Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9077C3B19F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B78246C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697296;
	bh=pMNCXhCm4QmotpzdA3S8UoGF3R5REzG4ykqsUsLmkIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RC1A5Se3eAfAKqajIX6Td3HrcqiD0v1aDcop5NjXEwDqG0mtOtx0Bt2vx+/XmtRp8
	 p/dheWaUe8Gkrcz7z3FVMEA554irrqvQO04KDH2AENmQ1zo8mlsMMH80irl4peVaxl
	 g1axZzM4n9f2XtjaSbGHfRxJQUK/s1piQHWmh1zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393015AbgBNQVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:21:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405164AbgBNQUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:20:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CACD224737;
        Fri, 14 Feb 2020 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697213;
        bh=pMNCXhCm4QmotpzdA3S8UoGF3R5REzG4ykqsUsLmkIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TmNpbc29KCaYn1Cw0kYt9TunypUSnSUcbZm2FRq9T5QBV9G4po7rbRHNKHOeIUINX
         fO/Ky0rkI4XEp8Be4gGE6puh7QoIy/8sBL9Wa35fxuHYTMSExumhhV0F9ZNqzq3fHT
         tKzY7hCwjkPyFsDnGB4llNpffsL01abB/NDgp2YY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 138/186] x86/mm: Fix NX bit clearing issue in kernel_map_pages_in_pgd
Date:   Fri, 14 Feb 2020 11:16:27 -0500
Message-Id: <20200214161715.18113-138-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit 75fbef0a8b6b4bb19b9a91b5214f846c2dc5139e ]

The following commit:

  15f003d20782 ("x86/mm/pat: Don't implicitly allow _PAGE_RW in kernel_map_pages_in_pgd()")

modified kernel_map_pages_in_pgd() to manage writable permissions
of memory mappings in the EFI page table in a different way, but
in the process, it removed the ability to clear NX attributes from
read-only mappings, by clobbering the clear mask if _PAGE_RW is not
being requested.

Failure to remove the NX attribute from read-only mappings is
unlikely to be a security issue, but it does prevent us from
tightening the permissions in the EFI page tables going forward,
so let's fix it now.

Fixes: 15f003d20782 ("x86/mm/pat: Don't implicitly allow _PAGE_RW in kernel_map_pages_in_pgd()
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200113172245.27925-5-ardb@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/pageattr.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 835620ab435fd..eaee1a7ed0b50 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2077,19 +2077,13 @@ int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 		.pgd = pgd,
 		.numpages = numpages,
 		.mask_set = __pgprot(0),
-		.mask_clr = __pgprot(0),
+		.mask_clr = __pgprot(~page_flags & (_PAGE_NX|_PAGE_RW)),
 		.flags = 0,
 	};
 
 	if (!(__supported_pte_mask & _PAGE_NX))
 		goto out;
 
-	if (!(page_flags & _PAGE_NX))
-		cpa.mask_clr = __pgprot(_PAGE_NX);
-
-	if (!(page_flags & _PAGE_RW))
-		cpa.mask_clr = __pgprot(_PAGE_RW);
-
 	if (!(page_flags & _PAGE_ENC))
 		cpa.mask_clr = pgprot_encrypted(cpa.mask_clr);
 
-- 
2.20.1

