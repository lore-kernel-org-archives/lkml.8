Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1531C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7294E20656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+fqP6D6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgBZUao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:30:44 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33600 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgBZUan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:30:43 -0500
Received: by mail-pg1-f201.google.com with SMTP id 37so332977pgq.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 12:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9oP9ZiTU1p6lF1U2mfS1bBIXLROAWtwOnKtBSbb21XQ=;
        b=c+fqP6D62YFfsQ+J6OBoM/aeGgTpFFp6n879QHcWNXJ9rZEA3joGLu5Khb/SAjaZwv
         yuSXfO/WvDezMPhKpeVoFdIUBiyrw6CTx1pApaHbssDflsPf1+RC+6DY3+GGhGx1KWJi
         68lBGhbGdFAoGu5K/nKOUhdyJFwYc1TMGRkYFAiIJdged0YFP76LlT38a9DbwBqXK/34
         uqyyBLmJYNXz6tE9+Vxhch09eMpn2UNX2P8D5sVB1B5FfKn4HMfwfAeoDg9p45rz8FfS
         oW+WQOJnUW8nbgJlwUcd7MT8SiMAl5sjpmCP8PUdcc+IJsja6qKXu13jzTYanXCb+8Fv
         f9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9oP9ZiTU1p6lF1U2mfS1bBIXLROAWtwOnKtBSbb21XQ=;
        b=OBqpLi0mDP+DLAyhNFygfmn+/gxVcxdEw+7PH2abIvZpVBMoBloN8mnXeUHgRiJQrX
         9FD7HAORFnYfeOoN1znqrAr4CgdFDa7Q4eKZL1BXBn4XVWMGhYLfIegNZSEDLqRF4Alw
         TSMD0wyRHJewBgsjf/qBKwt09AyIjYBJ4fvKhMHU1InMnOcbxQyv+MinKMnKFGMXmHMw
         4kBDZKCSNmBsZIl21qvTTEZs9I1zJeGF7oVX2J+3TQD1dQOSrFoicRckjLZr8Yse4JRu
         h1qlXQ/Ez0LmCIHXVDw69ILKNIu5fsY4VGbHJksQQrI3uWuLYU8mncZcWPvafU5EuMIU
         iH5g==
X-Gm-Message-State: APjAAAUkIgPMnYnXkU2KhXvacS6xF72LlHjcaMwm0f6cSdzK+jyqv+uH
        2N8KkKl9IHfw7/1bgLPeK/c9u/Uu8bkoVg==
X-Google-Smtp-Source: APXvYqxc3+QtUOXjvCNDTiXAo4RmNzOVk/qFDGek88Tooc1vbUAVhLRDfbsX+YtSCJhE/899DR3rlT69jwQ5PA==
X-Received: by 2002:a63:1e44:: with SMTP id p4mr568086pgm.367.1582749040887;
 Wed, 26 Feb 2020 12:30:40 -0800 (PST)
Date:   Wed, 26 Feb 2020 12:30:06 -0800
Message-Id: <20200226203006.51567-1-yonghyun@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys() for
 huge page
From:   Yonghyun Hwang <yonghyun@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Havard Skinnemoen <hskinnemoen@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        Moritz Fischer <mdf@kernel.org>,
        Yonghyun Hwang <yonghyun@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_iommu_iova_to_phys() has a bug when it translates an IOVA for a huge
page onto its corresponding physical address. This commit fixes the bug by
accomodating the level of page entry for the IOVA and adds IOVA's lower
address to the physical address.

Cc: <stable@vger.kernel.org>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
---

Changes from v2:
- a new condition is added to check whether the pte is present.

Changes from v1:
- level cannot be 0. So, the condition, "if (level > 1)", is removed, which results in a simple code.
- a macro, BIT_MASK, is used to have a bit mask

---
 drivers/iommu/intel-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 932267f49f9a..0837e0063973 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5553,8 +5553,10 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	u64 phys = 0;
 
 	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
-	if (pte)
-		phys = dma_pte_addr(pte);
+	if (pte && dma_pte_present(pte))
+		phys = dma_pte_addr(pte) +
+			(iova & (BIT_MASK(level_to_offset_bits(level) +
+						VTD_PAGE_SHIFT) - 1));
 
 	return phys;
 }
-- 
2.25.0.265.gbab2e86ba0-goog

