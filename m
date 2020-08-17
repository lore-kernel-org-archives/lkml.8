Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433B9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDF72072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597650683;
	bh=mQ3WvTAGWgK2rmSELwujRqp54hJGC60batYeik6p+fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gzW6NUWj759tlX8B2nPhWOw9UaDOSvLq3uaB+0pHg7FtHJFaVlVBic909cdhquewF
	 iRh5f9E2cz3zU2pKUZMofWP01zRK0orS12/BAnB/Q7e3FTiNrMd3sdCIYJ29nafyj4
	 TVDJaAKSWUDxp04e4V0bQmHkKV1dShWSQLyR3UBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgHQHvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgHQHuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:21 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DC632078A;
        Mon, 17 Aug 2020 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597650620;
        bh=mQ3WvTAGWgK2rmSELwujRqp54hJGC60batYeik6p+fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OhyMpbfZ+LZu2GPSMY3c5rAeSH0dDmtRC1sj2lvdGpFh3OLP3+pwfzFJBPp2cwdbB
         XuvcrdLeCf09uaggkOJfj7Dby+DReR1cbVCXw6DOGVc8LC6ymx3Tm+lKQYZOxrLNWD
         d0z2U2LKocgwu3+aV6frqfOcAaFEvwbCb45kbJJo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZuM-00BfcA-6B; Mon, 17 Aug 2020 09:50:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 07/16] iommu: hisi_smmu_lpae: get rid of IOMMU_SEC and IOMMU_DEVICE
Date:   Mon, 17 Aug 2020 09:50:06 +0200
Message-Id: <c077956093a22113ab3d8bd4b74c49d10a9f336d.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those prot bits aren't needed for Hikey970's GPU code, and depends
on some patch not on upstream.

So, get rid of them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisi_smmu_lpae.c | 41 +++++++++--------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi_smmu_lpae.c b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
index 5fdd91a6aa8e..9dae0a3067b6 100644
--- a/drivers/staging/hikey9xx/hisi_smmu_lpae.c
+++ b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
@@ -205,9 +205,6 @@ static int hisi_smmu_alloc_init_pte_lpae(smmu_pmd_t *ppmd,
 	}
 
 pte_ready:
-	if (prot & IOMMU_SEC)
-		*ppmd &= (~SMMU_PMD_NS);
-
 	start = (smmu_pte_t *)smmu_pte_page_vaddr_lpae(ppmd)
 		+ smmu_pte_index(addr);
 	pte = start;
@@ -215,30 +212,24 @@ static int hisi_smmu_alloc_init_pte_lpae(smmu_pmd_t *ppmd,
 		pteval |= SMMU_PROT_NORMAL;
 		pteval |= SMMU_PTE_NS;
 	} else {
-		if (prot & IOMMU_DEVICE) {
-			pteval |= SMMU_PROT_DEVICE_nGnRE;
-		} else {
-			if (prot & IOMMU_CACHE)
-				pteval |= SMMU_PROT_NORMAL_CACHE;
-			else
-				pteval |= SMMU_PROT_NORMAL_NC;
+		if (prot & IOMMU_CACHE)
+			pteval |= SMMU_PROT_NORMAL_CACHE;
+		else
+			pteval |= SMMU_PROT_NORMAL_NC;
 
-			if ((prot & IOMMU_READ) && (prot & IOMMU_WRITE))
-				pteval |= SMMU_PAGE_READWRITE;
-			else if ((prot & IOMMU_READ) && !(prot & IOMMU_WRITE))
-				pteval |= SMMU_PAGE_READONLY;
-			else
-				WARN_ON("you do not set read attribute!");
+		if ((prot & IOMMU_READ) && (prot & IOMMU_WRITE))
+			pteval |= SMMU_PAGE_READWRITE;
+		else if ((prot & IOMMU_READ) && !(prot & IOMMU_WRITE))
+			pteval |= SMMU_PAGE_READONLY;
+		else
+			WARN_ON("you do not set read attribute!");
 
-			if (prot & IOMMU_EXEC) {
-				pteval |= SMMU_PAGE_READONLY_EXEC;
-				pteval &= ~(SMMU_PTE_PXN | SMMU_PTE_UXN);
-			}
+		if (!(prot & IOMMU_NOEXEC)) {
+			pteval |= SMMU_PAGE_READONLY_EXEC;
+			pteval &= ~(SMMU_PTE_PXN | SMMU_PTE_UXN);
 		}
-		if (prot & IOMMU_SEC)
-			pteval &= (~SMMU_PTE_NS);
-		else
-			pteval |= SMMU_PTE_NS;
+
+		pteval |= SMMU_PTE_NS;
 	}
 
 	do {
@@ -287,8 +278,6 @@ static int hisi_smmu_alloc_init_pmd_lpae(smmu_pgd_t *ppgd,
 	}
 
 pmd_ready:
-	if (prot & IOMMU_SEC)
-		*ppgd &= (~SMMU_PGD_NS);
 	start = (smmu_pmd_t *)smmu_pmd_page_vaddr_lpae(ppgd)
 		+ smmu_pmd_index(addr);
 	ppmd = start;
-- 
2.26.2

