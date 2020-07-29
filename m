Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29266C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1244C20829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgG2MtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:49:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbgG2MtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:49:01 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E8ADCA9AF417740682EA;
        Wed, 29 Jul 2020 20:48:56 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Jul 2020
 20:48:47 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>,
        <anup.patel@broadcom.com>, <ray.jui@broadcom.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH V2] dmaengine: bcm-sba-raid: add missing put_device() call in sba_probe()
Date:   Wed, 29 Jul 2020 20:49:04 +0800
Message-ID: <20200729124904.2541801-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if of_find_device_by_node() succeed, sba_probe() doesn't have a
corresponding put_device(). Thus add a jump target to fix the
exception handling for this function implementation.

Fixes: 743e1c8ffe4e ("dmaengine: Add Broadcom SBA RAID driver")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
changes from V1:
-forgot to add params in put_device(), sorry about that.

 drivers/dma/bcm-sba-raid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 64239da02e74..322d48b397e7 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -1707,7 +1707,7 @@ static int sba_probe(struct platform_device *pdev)
 	/* Prealloc channel resource */
 	ret = sba_prealloc_channel_resources(sba);
 	if (ret)
-		goto fail_free_mchan;
+		goto put_device;
 
 	/* Check availability of debugfs */
 	if (!debugfs_initialized())
@@ -1737,6 +1737,8 @@ static int sba_probe(struct platform_device *pdev)
 fail_free_resources:
 	debugfs_remove_recursive(sba->root);
 	sba_freeup_channel_resources(sba);
+put_device:
+	put_device(&mbox_pdev->dev);
 fail_free_mchan:
 	mbox_free_channel(sba->mchan);
 	return ret;
-- 
2.25.4

