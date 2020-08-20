Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECCDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9325F20674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgHTNkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:40:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbgHTJaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:30:22 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5661E68EB82655C34646;
        Thu, 20 Aug 2020 17:30:19 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 17:30:09 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] nvmem: core: Use kobj_to_dev() instead of container_of()
Date:   Thu, 20 Aug 2020 17:28:03 +0800
Message-ID: <1597915683-44794-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() instead of container_of()

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/nvmem/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6cd3edb..7641e56 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -128,7 +128,7 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 	if (attr->private)
 		dev = attr->private;
 	else
-		dev = container_of(kobj, struct device, kobj);
+		dev = kobj_to_dev(kobj);
 	nvmem = to_nvmem_device(dev);
 
 	/* Stop the user from reading */
@@ -168,7 +168,7 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 	if (attr->private)
 		dev = attr->private;
 	else
-		dev = container_of(kobj, struct device, kobj);
+		dev = kobj_to_dev(kobj);
 	nvmem = to_nvmem_device(dev);
 
 	/* Stop the user from writing */
@@ -219,7 +219,7 @@ static umode_t nvmem_bin_attr_get_umode(struct nvmem_device *nvmem)
 static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
 					 struct bin_attribute *attr, int i)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
 
 	return nvmem_bin_attr_get_umode(nvmem);
-- 
2.7.4

