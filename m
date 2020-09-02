Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F071AC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC6A20829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgIBOO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:14:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10799 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbgIBOGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:06:48 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 73C3263CD800FB392089;
        Wed,  2 Sep 2020 22:06:45 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 2 Sep 2020
 22:06:35 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>, <s-anna@ti.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] remoteproc: k3-dsp: Fix return value check in k3_dsp_rproc_of_get_memories()
Date:   Wed, 2 Sep 2020 22:06:14 +0800
Message-ID: <20200902140614.28636-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function devm_ioremap_wc() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: 87218f96c21a ("remoteproc: k3-dsp: Add support for C71x DSPs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index 9011e477290c..f373df35d7d0 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -445,10 +445,10 @@ static int k3_dsp_rproc_of_get_memories(struct platform_device *pdev,
 
 		kproc->mem[i].cpu_addr = devm_ioremap_wc(dev, res->start,
 							 resource_size(res));
-		if (IS_ERR(kproc->mem[i].cpu_addr)) {
+		if (!kproc->mem[i].cpu_addr) {
 			dev_err(dev, "failed to map %s memory\n",
 				data->mems[i].name);
-			return PTR_ERR(kproc->mem[i].cpu_addr);
+			return -EBUSY;
 		}
 		kproc->mem[i].bus_addr = res->start;
 		kproc->mem[i].dev_addr = data->mems[i].dev_addr;
-- 
2.17.1


