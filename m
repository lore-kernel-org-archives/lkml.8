Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997F6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8C72078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390650AbgEYNBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 09:01:32 -0400
Received: from 8bytes.org ([81.169.241.247]:44532 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388763AbgEYNBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 09:01:32 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4D934327; Mon, 25 May 2020 15:01:29 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] iommu: Don't take group reference in iommu_alloc_default_domain()
Date:   Mon, 25 May 2020 15:01:22 +0200
Message-Id: <20200525130122.380-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The iommu_alloc_default_domain() function takes a reference to an IOMMU
group without releasing it. This causes the group to never be released,
with undefined side effects.

The function has only one call-site, which takes a group reference on
its own, so to fix this leak, do not take another reference in
iommu_alloc_default_domain() and pass the group as a function parameter
instead.

Reference: https://lore.kernel.org/lkml/20200522130145.30067-1-saiprakash.ranjan@codeaurora.org/
Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Fixes: 6e1aa2049154 ("iommu: Move default domain allocation to iommu_probe_device()")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 374b34fd6fac..bf20674769e0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -80,7 +80,8 @@ static bool iommu_cmd_line_dma_api(void)
 	return !!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API);
 }
 
-static int iommu_alloc_default_domain(struct device *dev);
+static int iommu_alloc_default_domain(struct iommu_group *group,
+				      struct device *dev);
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
@@ -251,17 +252,17 @@ int iommu_probe_device(struct device *dev)
 	if (ret)
 		goto err_out;
 
+	group = iommu_group_get(dev);
+	if (!group)
+		goto err_release;
+
 	/*
 	 * Try to allocate a default domain - needs support from the
 	 * IOMMU driver. There are still some drivers which don't
 	 * support default domains, so the return value is not yet
 	 * checked.
 	 */
-	iommu_alloc_default_domain(dev);
-
-	group = iommu_group_get(dev);
-	if (!group)
-		goto err_release;
+	iommu_alloc_default_domain(group, dev);
 
 	if (group->default_domain)
 		ret = __iommu_attach_device(group->default_domain, dev);
@@ -1478,15 +1479,11 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
 	return 0;
 }
 
-static int iommu_alloc_default_domain(struct device *dev)
+static int iommu_alloc_default_domain(struct iommu_group *group,
+				      struct device *dev)
 {
-	struct iommu_group *group;
 	unsigned int type;
 
-	group = iommu_group_get(dev);
-	if (!group)
-		return -ENODEV;
-
 	if (group->default_domain)
 		return 0;
 
-- 
2.26.2

