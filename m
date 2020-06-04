Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFCBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A5320738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgFDJUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:20:02 -0400
Received: from 8bytes.org ([81.169.241.247]:46182 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgFDJUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:20:02 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D206E26F; Thu,  4 Jun 2020 11:20:00 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu: Check for deferred attach in iommu_group_do_dma_attach()
Date:   Thu,  4 Jun 2020 11:19:44 +0200
Message-Id: <20200604091944.26402-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The iommu_group_do_dma_attach() must not attach devices which have
deferred_attach set. Otherwise devices could cause IOMMU faults when
re-initialized in a kdump kernel.

Fixes: deac0b3bed26 ("iommu: Split off default domain allocation from group assignment")
Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b5ea203f6c68..5a6d509f72b6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1680,8 +1680,12 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 static int iommu_group_do_dma_attach(struct device *dev, void *data)
 {
 	struct iommu_domain *domain = data;
+	int ret = 0;
 
-	return __iommu_attach_device(domain, dev);
+	if (!iommu_is_attach_deferred(group->domain, dev))
+		ret = __iommu_attach_device(group->domain, dev);
+
+	return ret;
 }
 
 static int __iommu_group_dma_attach(struct iommu_group *group)
-- 
2.26.2

