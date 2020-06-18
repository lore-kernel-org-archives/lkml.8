Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AB3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E344D20885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446991;
	bh=OSy/OGfvGshqjHEGkwGYZClMEVPpuaEOBEcpLWkcDoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XCTue/sRMqs/k0/b/0+ZWDvPFSKg9TILIBrGcIc0kdeKbXkoSuvALuNYazcJAVjCG
	 OHWcJrw4JkGvS3Qxa0tZxNaIiGPNRpnRUyt333vvA2Pkf15Ldx+a/PrOLvzMiNDEfp
	 xgSPzWCU7PzUg9WGQnZ+Pk0EdUC9UDP8ByJzNK/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbgFRCXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:23:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbgFRBSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:18:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53DFC21D90;
        Thu, 18 Jun 2020 01:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443086;
        bh=OSy/OGfvGshqjHEGkwGYZClMEVPpuaEOBEcpLWkcDoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgYqeWNKfpxg3NhhaZYurjv14pjePToWpaT+YsZo3Xgn2hsPa039XE/iwrs6xKamZ
         sUWIQzQpB/u4W6guJ1pidV15gytHOfg1zpOrgOaBnCoWGkGvK5N7UgSarsxnJm5HcN
         7yS1mrz6nVybBX1UN/RaRGd4BONkjdoudaZnUzgI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 070/266] sparc32: mm: Don't try to free page-table pages if ctor() fails
Date:   Wed, 17 Jun 2020 21:13:15 -0400
Message-Id: <20200618011631.604574-70-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

[ Upstream commit 454b0289c6b5f2c66164654b80212d15fbef7a03 ]

The pages backing page-table allocations for SRMMU are allocated via
memblock as part of the "nocache" region initialisation during
srmmu_paging_init() and should not be freed even if a later call to
pgtable_pte_page_ctor() fails.

Remove the broken call to __free_page().

Cc: David S. Miller <davem@davemloft.net>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Fixes: 1ae9ae5f7df7 ("sparc: handle pgtable_page_ctor() fail")
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/mm/srmmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index cc3ad64479ac..9e256d4d1f4c 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -379,7 +379,6 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 		return NULL;
 	page = pfn_to_page(__nocache_pa(pte) >> PAGE_SHIFT);
 	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
 		return NULL;
 	}
 	return page;
-- 
2.25.1

