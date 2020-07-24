Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AFCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E6FC20771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGXKMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:12:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37932 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbgGXKMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:12:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 877E19049CFEDD784033;
        Fri, 24 Jul 2020 18:12:27 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 24 Jul 2020
 18:12:16 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <jdelvare@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
Subject: [PATCH -next] hwmon (pmbus/max20730): Whitespace cleanups in max20730.c
Date:   Fri, 24 Jul 2020 18:11:59 +0800
Message-ID: <20200724101159.48622-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop trailing whitespace.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/hwmon/pmbus/max20730.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
index 3ddc19b81b90..87d936d45d65 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -309,7 +309,7 @@ static int max20730_probe(struct i2c_client *client,
 				     I2C_FUNC_SMBUS_READ_WORD_DATA |
 				     I2C_FUNC_SMBUS_BLOCK_DATA))
 		return -ENODEV;
-	
+
 	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to read Manufacturer ID\n");
@@ -373,7 +373,7 @@ static int max20730_probe(struct i2c_client *client,
 	ret = pmbus_do_probe(client, id, &data->info);
 	if (ret < 0)
 		return ret;
-	
+
 	return 0;
 }
 
-- 
2.17.1

