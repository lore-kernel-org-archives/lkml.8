Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BA3C18E00
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C18F208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qpoc6v6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgBSTc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:32:26 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43935 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgBSTc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:32:26 -0500
Received: by mail-pg1-f201.google.com with SMTP id v14so749080pgo.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 11:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LhQugWcRIJnBiCo5sPUtpmjmiq165+wXiyQpGM1ghvc=;
        b=Qpoc6v6Kkkt/4h6Qp0vNZudJzadERAugv0sReBOvyKTPLj8/0n/qNMlGweInDDuPcN
         87YufxziuCTog8tdGQrAvE6zU1I3NNtenzNEa74eZbIPRkxhK2YXH1U/mymGU4SOnhPS
         DN5wJZ7j10Et5cF3oYIEIMDr+eNA73CgyYKcMGSBPJyq/UQmOWH6N4kgotslh3HDTyzb
         HSZapOVQTCJHmGH1cVZBzXFmdzBET4jV3NKVF61mOmCfUBtPa9VYM+2lXyVgBmRpmVlo
         tOoO/DJzWblWftTicKu7ZixU81/9lM2LZPv8ZpEL4Kl42aDJoh8TIe7PnYEV9WHVP6Wg
         iqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LhQugWcRIJnBiCo5sPUtpmjmiq165+wXiyQpGM1ghvc=;
        b=Y1UdfZTWZDFNXAoXnP4bKMJnbMHquMnbYM62YilUFD22QAvytUDJMkTrOHh03qxV+G
         JuF0y3FYwm8vTQcvCfRJ3rGdEGZum5wx9kmGvffDsgjo+tGKamKXN6V930F5wLOb//Al
         A9MmoKlVjVxtwZ7oNIVBSQJO5wBrV30JI+Q/KrnLNx7MxaF2LEQUeq2VJTawjs2yyspD
         64Nv0c/+XKBdMk2edfGd+uZUs0ws1f5JiN5lQpW/4Glie98GP/cGImSVsqWmRkStp8WC
         TNpLnYMwecz0ToE7Qt/QBCXfpd+h+sgT5JSZgiN57nzQlxrzV14JQFN2jZs6zajsreB/
         4Q2A==
X-Gm-Message-State: APjAAAXBrI8nNydnBP3JSQWMRAWjKjvGV6PRsCh5Kephee0fOYdisLQ7
        JqMEVZWZmuniaSna8804zoY4ypuzG/dy9w==
X-Google-Smtp-Source: APXvYqzM0CPkh/AZyjT3hJ/KHdeBU22XVBp5f7Csclt53C6Uva1qzK4At6CGLvs5am2zgNYxNZoopm+XQYml2w==
X-Received: by 2002:a63:7207:: with SMTP id n7mr10556061pgc.253.1582140744973;
 Wed, 19 Feb 2020 11:32:24 -0800 (PST)
Date:   Wed, 19 Feb 2020 11:32:21 -0800
Message-Id: <20200219193221.19799-1-yonghyun@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys() for huge page
From:   Yonghyun Hwang <yonghyun@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Havard Skinnemoen <hskinnemoen@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        Moritz Fischer <mdf@kernel.org>,
        Yonghyun Hwang <yonghyun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_iommu_iova_to_phys() has a bug when it translates an IOVA for a huge
page onto its corresponding physical address. This commit fixes the bug by
accomodating the level of page entry for the IOVA and adds IOVA's lower
address to the physical address.

Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
---
 drivers/iommu/intel-iommu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0c8d81f56a30..beff7ede41f4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5548,6 +5548,15 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	return size;
 }
 
+static inline unsigned long pfn_level_mask(unsigned long pfn, int level)
+{
+	if (level > 1)
+		return pfn & (BIT_MASK(level_to_offset_bits(level)) - 1)
+			<< VTD_PAGE_SHIFT;
+	else
+		return 0;
+}
+
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 					    dma_addr_t iova)
 {
@@ -5555,13 +5564,15 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	struct dma_pte *pte;
 	int level = 0;
 	u64 phys = 0;
+	const unsigned long pfn = iova >> VTD_PAGE_SHIFT;
 
 	if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
 		return 0;
 
-	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
+	pte = pfn_to_dma_pte(dmar_domain, pfn, &level);
 	if (pte)
-		phys = dma_pte_addr(pte);
+		phys = dma_pte_addr(pte) + pfn_level_mask(pfn, level) +
+			(iova & ~VTD_PAGE_MASK);
 
 	return phys;
 }
-- 
2.25.0.265.gbab2e86ba0-goog

