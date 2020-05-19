Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2FAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65ADA207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgESN2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgESN2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:28:35 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4320BC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:28:35 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7785F386; Tue, 19 May 2020 15:28:33 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Joerg Roedel <jroedel@suse.de>,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH] iommu: Don't call .probe_finalize() under group->mutex
Date:   Tue, 19 May 2020 15:28:24 +0200
Message-Id: <20200519132824.15163-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The .probe_finalize() call-back of some IOMMU drivers calls into
arm_iommu_attach_device(). This function will call back into the
IOMMU core code, where it tries to take group->mutex again, resulting
in a deadlock.

As there is no reason why .probe_finalize() needs to be called under
that mutex, move it after the lock has been released to fix the
deadlock.

Cc: Yong Wu <yong.wu@mediatek.com>
Reported-by: Yong Wu <yong.wu@mediatek.com>
Fixes: deac0b3bed26 ("iommu: Split off default domain allocation from group assignment")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 629d209b8e88..d5d9fcbc9714 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1683,17 +1683,8 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 static int iommu_group_do_dma_attach(struct device *dev, void *data)
 {
 	struct iommu_domain *domain = data;
-	const struct iommu_ops *ops;
-	int ret;
-
-	ret = __iommu_attach_device(domain, dev);
-
-	ops = domain->ops;
-
-	if (ret == 0 && ops->probe_finalize)
-		ops->probe_finalize(dev);
 
-	return ret;
+	return __iommu_attach_device(domain, dev);
 }
 
 static int __iommu_group_dma_attach(struct iommu_group *group)
@@ -1702,6 +1693,21 @@ static int __iommu_group_dma_attach(struct iommu_group *group)
 					  iommu_group_do_dma_attach);
 }
 
+static int iommu_group_do_probe_finalize(struct device *dev, void *data)
+{
+	struct iommu_domain *domain = data;
+
+	if (domain->ops->probe_finalize)
+		domain->ops->probe_finalize(dev);
+
+	return 0;
+}
+
+static void __iommu_group_dma_finalize(struct iommu_group *group)
+{
+	__iommu_group_for_each_dev(group, group->default_domain,
+				   iommu_group_do_probe_finalize);
+}
 static int iommu_do_create_direct_mappings(struct device *dev, void *data)
 {
 	struct iommu_group *group = data;
@@ -1754,6 +1760,8 @@ int bus_iommu_probe(struct bus_type *bus)
 
 		if (ret)
 			break;
+
+		__iommu_group_dma_finalize(group);
 	}
 
 	return ret;
-- 
2.25.1

