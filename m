Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AF9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A29206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgFBNIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:08:34 -0400
Received: from foss.arm.com ([217.140.110.172]:50730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgFBNI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:08:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A1991FB;
        Tue,  2 Jun 2020 06:08:26 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C373F3F305;
        Tue,  2 Jun 2020 06:08:25 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Prakash Gupta <guptap@codeaurora.org>
Subject: [PATCH] iommu/iova: Don't BUG on invalid PFNs
Date:   Tue,  2 Jun 2020 14:08:18 +0100
Message-Id: <acbd2d092b42738a03a21b417ce64e27f8c91c86.1591103298.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.23.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike the other instances which represent a complete loss of
consistency within the rcache mechanism itself, or a fundamental
and obvious misconfiguration by an IOMMU driver, the BUG_ON() in
iova_magazine_free_pfns() can be provoked at more or less any time
in a "spooky action-at-a-distance" manner by any old device driver
passing nonsense to dma_unmap_*() which then propagates through to
queue_iova().

Not only is this well outside the IOVA layer's control, it's also
nowhere near fatal enough to justify panicking anyway - all that
really achieves is to make debugging the offending driver more
difficult. Let's simply WARN and otherwise ignore bogus PFNs.

Reported-by: Prakash Gupta <guptap@codeaurora.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iova.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0e6a9536eca6..612cbf668adf 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -811,7 +811,9 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 	for (i = 0 ; i < mag->size; ++i) {
 		struct iova *iova = private_find_iova(iovad, mag->pfns[i]);
 
-		BUG_ON(!iova);
+		if (WARN_ON(!iova))
+			continue;
+
 		private_free_iova(iovad, iova);
 	}
 
-- 
2.23.0.dirty

