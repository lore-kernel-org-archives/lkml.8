Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606DFC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDCA206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZ0uQ2KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgBTToo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:44:44 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:46696 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgBTToo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:44:44 -0500
Received: by mail-pl1-f201.google.com with SMTP id t17so2755905plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 11:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=A+oVpb+Lk0C4bnIx0YQSuGzTprOuprdSgDwQ17Ryeq8=;
        b=QZ0uQ2KOiOtz27OTmXVuPdy+gb5tJEgosgIPP20QlpfkVTPle1eV9rnsiQPHgrpD5X
         qbCig5OBHinZv6GG1T/hbfwUB04jCeISf9ONeijcwbDWf5dM4cYHteDIz6CDSqJXe6pz
         qPPQ/aG8Alq5YnJesmPag0mar3R4IwZTbwVBEADKHVxphochRgLSh935uNNpkEbn9PyC
         1P8fOHwhNqXJlZmC6Cepf+cUttboYMo4a91VQoIsba8RVrHWdJZPaW9Kl34lcU+s9LrN
         zl8Ehs5Wzl3LkrO7Frqat+skbWh5DML28CSifsderE2+WBhicJl6Mup+ZJeR+iQDguGt
         VcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=A+oVpb+Lk0C4bnIx0YQSuGzTprOuprdSgDwQ17Ryeq8=;
        b=Y6/BkFwfJJ6fN2mizy3BJ3c3cSjBfKzxMkTwJ55ej413N2/FwK2KOTc5if04dQfQAt
         Nj2XL8JxNSFaUfBp03rXFB18YSpD8yQLeoJv0YKcedLTxfxi01lzLlqMP0DEQFS5koN9
         Ao9HXyZcfh4v4YQPn7TSbW+pSLgqyGm+g9LhaGlY7kZp8swEYoaiHKoDb0SNwgMXWU6F
         CmegcQWbgfv2zFmysJUf4eMOqn0aKc0t0RA/mDxvJ7rrALb5JymjitFBuAJvGi8/8YjD
         CoKH4d+NzoMnLa5DAbjwDWyblIVsOb3e5DdwF6LDNg9iuyVgFqSPW0jn98ATgAWRaQy2
         Uz4A==
X-Gm-Message-State: APjAAAV9FEi8jVexj+rvWyE+QDQMaPPQg9MG1qcysnSUAw0x6SEsiuHU
        lzSgnrvCcdE0jHQvQ/ES+l9icpejc6WyPA==
X-Google-Smtp-Source: APXvYqyDNBAd9llJr9uXqcKnHjQnxyRTE1k3X8Epf4THWj+dS6sSLVAZ4gd2YU4H44IvNCnSBzQLKMTRfm6Q4g==
X-Received: by 2002:a63:790f:: with SMTP id u15mr33406976pgc.172.1582227883584;
 Thu, 20 Feb 2020 11:44:43 -0800 (PST)
Date:   Thu, 20 Feb 2020 11:44:31 -0800
Message-Id: <20200220194431.169629-1-yonghyun@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys() for
 huge page
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

Changes from v1:
- level cannot be 0. So, the condition, "if (level > 1)", is removed, which results in a simple code.
- a macro, BIT_MASK, is used to have a bit mask

---
 drivers/iommu/intel-iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 932267f49f9a..4fd5c6287b6d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5554,7 +5554,9 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 
 	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
 	if (pte)
-		phys = dma_pte_addr(pte);
+		phys = dma_pte_addr(pte) +
+			(iova & (BIT_MASK(level_to_offset_bits(level) +
+						VTD_PAGE_SHIFT) - 1));
 
 	return phys;
 }
-- 
2.25.0.265.gbab2e86ba0-goog

