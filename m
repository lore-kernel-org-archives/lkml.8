Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED59C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DAF8206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgIAMLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:11:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727944AbgIAMBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:01:06 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A5FEB41847D5DC89B8F1;
        Tue,  1 Sep 2020 20:00:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Sep 2020 20:00:50 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <jk@ozlabs.org>, <joel@jms.id.au>, <eajames@linux.ibm.com>
CC:     <alistair@popple.id.au>, <linux-fsi@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] fsi: Fix an IS_ERR() vs NULL check in occ_probe()
Date:   Tue, 1 Sep 2020 20:01:56 +0800
Message-ID: <20200901120156.140522-1-jingxiangfeng@huawei.com>
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

The platform_device_register_full() function returns error pointers,
it never returns NULL.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/fsi/fsi-occ.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index 7da9c81759ac..9eeb856c8905 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -555,7 +555,7 @@ static int occ_probe(struct platform_device *pdev)
 
 	hwmon_dev_info.id = occ->idx;
 	hwmon_dev = platform_device_register_full(&hwmon_dev_info);
-	if (!hwmon_dev)
+	if (IS_ERR(hwmon_dev))
 		dev_warn(dev, "failed to create hwmon device\n");
 
 	return 0;
-- 
2.17.1

