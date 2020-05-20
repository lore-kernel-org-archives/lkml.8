Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016CBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA94B204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgETDSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:18:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4871 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728176AbgETDSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:18:38 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6AC3BD0BA95EB4BBB08E;
        Wed, 20 May 2020 11:18:36 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 20 May 2020 11:18:29 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] bus: arm-integrator-lm: Fix return value check in integrator_ap_lm_probe()
Date:   Wed, 20 May 2020 03:21:50 +0000
Message-ID: <20200520032150.165388-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function of_find_matching_node() returns NULL
pointer not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Fixes: ccea5e8a5918 ("bus: Add driver for Integrator/AP logic modules")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/bus/arm-integrator-lm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/arm-integrator-lm.c b/drivers/bus/arm-integrator-lm.c
index 669ea7e1f92e..845b6c43fef8 100644
--- a/drivers/bus/arm-integrator-lm.c
+++ b/drivers/bus/arm-integrator-lm.c
@@ -78,10 +78,10 @@ static int integrator_ap_lm_probe(struct platform_device *pdev)
 
 	/* Look up the system controller */
 	syscon = of_find_matching_node(NULL, integrator_ap_syscon_match);
-	if (IS_ERR(syscon)) {
+	if (!syscon) {
 		dev_err(dev,
 			"could not find Integrator/AP system controller\n");
-		return PTR_ERR(syscon);
+		return -ENODEV;
 	}
 	map = syscon_node_to_regmap(syscon);
 	if (IS_ERR(map)) {



