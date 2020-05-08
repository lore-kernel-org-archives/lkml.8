Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C8AC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6016821473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgEHLzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:55:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4354 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727777AbgEHLzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:55:22 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EF558C8FB18C28E54B87;
        Fri,  8 May 2020 19:55:19 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 19:55:12 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <hch@lst.de>, <sagi@grimberg.me>, <chaitanya.kulkarni@wdc.com>
CC:     <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next] nvmet: replace kstrndup() with kmemdup_nul()
Date:   Fri, 8 May 2020 19:59:06 +0800
Message-ID: <20200508115906.165223-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is more efficient to use kmemdup_nul() if the size is known exactly.

The doc in kernel:
"Note: Use kmemdup_nul() instead if the size is known exactly."

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/nvme/target/configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 58cabd7b6fc5..9894668a40e7 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -327,7 +327,7 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 
 	kfree(ns->device_path);
 	ret = -ENOMEM;
-	ns->device_path = kstrndup(page, len, GFP_KERNEL);
+	ns->device_path = kmemdup_nul(page, len, GFP_KERNEL);
 	if (!ns->device_path)
 		goto out_unlock;
 
@@ -963,7 +963,7 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
 			return -EINVAL;
 	}
 
-	new_model_number = kstrndup(page, len, GFP_KERNEL);
+	new_model_number = kmemdup_nul(page, len, GFP_KERNEL);
 	if (!new_model_number)
 		return -ENOMEM;
 
-- 
2.20.1

