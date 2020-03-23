Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB83C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8971720719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgCWVuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:50:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40796 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCWVux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:50:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 7471A295C7A
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH] iommu: Lower severity of add/remove device messages
Date:   Mon, 23 Mar 2020 18:49:56 -0300
Message-Id: <20200323214956.30165-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These user messages are not really informational,
but mostly of debug nature. Lower their severity.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/iommu/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3e3528436e0b..1ebd17033714 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -758,7 +758,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	trace_add_device_to_group(group->id, dev);
 
-	dev_info(dev, "Adding to iommu group %d\n", group->id);
+	dev_dbg(dev, "Adding to iommu group %d\n", group->id);
 
 	return 0;
 
@@ -792,7 +792,7 @@ void iommu_group_remove_device(struct device *dev)
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *tmp_device, *device = NULL;
 
-	dev_info(dev, "Removing from iommu group %d\n", group->id);
+	dev_dbg(dev, "Removing from iommu group %d\n", group->id);
 
 	/* Pre-notify listeners that a device is being removed. */
 	blocking_notifier_call_chain(&group->notifier,
@@ -2337,8 +2337,8 @@ request_default_domain_for_dev(struct device *dev, unsigned long type)
 
 	iommu_group_create_direct_mappings(group, dev);
 
-	dev_info(dev, "Using iommu %s mapping\n",
-		 type == IOMMU_DOMAIN_DMA ? "dma" : "direct");
+	dev_dbg(dev, "Using iommu %s mapping\n",
+		type == IOMMU_DOMAIN_DMA ? "dma" : "direct");
 
 	ret = 0;
 out:
-- 
2.26.0.rc2

