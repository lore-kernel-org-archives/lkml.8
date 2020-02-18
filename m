Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0F9C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B08A206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVyogOaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgBRWXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:23:42 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:55404 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBRWXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:23:41 -0500
Received: by mail-pg1-f202.google.com with SMTP id v30so14694442pga.22
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 14:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RyZPX88UXixXr6H+WqBfpH3SQUGpsCPs7MPeJ9gGfYY=;
        b=pVyogOaqDXZG+0aObtSSxEv3N4Z35s4fnvMjG/CquQTsvQCvgEYnfbR67aKoRK7c9S
         mIaifbvoG8QUPDODUruZYD3hg5Tms/Dcr9mzM4TCW8Gg6szDRIij8ZRfPxLgnIL9nTWD
         2wQmp1/hYe2zdQJJf98jgGa55ZmykDe1x40pOGXNh2iVZRVsQsYEa3Z2VOh2AhZ5zYW1
         AUbvFjn3eSZ94bl5ndy+oflhS0n7QrRtsRM2t78Y4LHRp/7pwp/F26KhIHFEOxON8vYW
         u0iPhHb0zypkJHQRxyua5cM3kQG4TKB6gpwMzMSUBZ6gG8GLio/kuNnku6vPiXYeXphA
         ZN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RyZPX88UXixXr6H+WqBfpH3SQUGpsCPs7MPeJ9gGfYY=;
        b=rPGus90XsocUZ/BDHFE8StO1UGK4fYGbjcUWBeulGEPNVg29rcyQvwwUPp7/u7L6ql
         ReBr68DCVyRSgWHHbUpoJz7Wany34CNBKKXM5I4q4rbRV/6MqXg9il7CTLv/csHuvOro
         FDq7V0YLl76yZACKvcx8TwjuqWt6ERzMObap8FfEbejE2PgTnNTxOYb4mDYTFkMy9QR5
         w6Fz4+uCBA8TzbGJGr06EqJY8jVRBeH5hyimTe6tJmlIBhzUfGqJ6+dScLzbnFumJfHk
         1Qgk/kAZtHdx7NIMLi89AkOevdJKDud5EMuZEvS12jT0vuV9//qvUJX/MdcBuzlhdhc6
         WWEg==
X-Gm-Message-State: APjAAAUxlkflaKajM+3tdLn1e1uPfeI11Giw2bWnlOghHH9W75w5eYmz
        AQfZNovdP+d1Ljk+uB8ZKeNjcw43C8l8CQ==
X-Google-Smtp-Source: APXvYqxFeN4+14AS007M5FRxjbhYgD+l1468e9DzCnW7RrBxltZnkzaw2IXT1+HJEzajLQxGPSLzL+Hqs/UCmg==
X-Received: by 2002:a63:e942:: with SMTP id q2mr22530346pgj.323.1582064620955;
 Tue, 18 Feb 2020 14:23:40 -0800 (PST)
Date:   Tue, 18 Feb 2020 14:23:24 -0800
Message-Id: <20200218222324.231915-1-yonghyun@google.com>
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
        Moritz Fischer <moritzf@google.com>,
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
 drivers/iommu/intel-iommu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0c8d81f56a30..ed6e69adb578 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5555,13 +5555,20 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	struct dma_pte *pte;
 	int level = 0;
 	u64 phys = 0;
+	const unsigned long pfn = iova >> VTD_PAGE_SHIFT;
 
 	if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
 		return 0;
 
-	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
-	if (pte)
+	pte = pfn_to_dma_pte(dmar_domain, pfn, &level);
+	if (pte) {
 		phys = dma_pte_addr(pte);
+		if (level > 1)
+			phys += (pfn &
+				((1UL << level_to_offset_bits(level)) - 1))
+				<< VTD_PAGE_SHIFT;
+		phys += iova & (VTD_PAGE_SIZE - 1);
+	}
 
 	return phys;
 }
-- 
2.25.0.265.gbab2e86ba0-goog

