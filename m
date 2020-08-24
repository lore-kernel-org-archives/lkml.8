Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B7CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 01:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8C1206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 01:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHXBEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 21:04:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10313 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727902AbgHXBEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 21:04:55 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 197FCEC66F3A41648B0C;
        Mon, 24 Aug 2020 09:04:52 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 24 Aug 2020 09:04:44 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <ulf.hansson@linaro.org>, <baolin.wang@linaro.org>,
        <Jisheng.Zhang@synaptics.com>, <pali@kernel.org>,
        <philipl@overt.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] mmc: sd: Use kobj_to_dev() instead of container_of()
Date:   Mon, 24 Aug 2020 09:02:36 +0800
Message-ID: <1598230956-58523-1-git-send-email-tiantao6@hisilicon.com>
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
 drivers/mmc/core/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 5a2210c..a0d2c34 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -735,7 +735,7 @@ static struct attribute *sd_std_attrs[] = {
 static umode_t sd_std_is_visible(struct kobject *kobj, struct attribute *attr,
 				 int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct mmc_card *card = mmc_dev_to_card(dev);
 
 	/* CIS vendor and device ids are available only for Combo cards */
-- 
2.7.4

