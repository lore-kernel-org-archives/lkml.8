Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EC4C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D627F206B9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgEGJi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:38:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3884 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgEGJi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:38:59 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5BCF144FEA0FAA0A3F7F;
        Thu,  7 May 2020 17:38:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 17:38:49 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] gnss: sirf: fix error return code in sirf_probe()
Date:   Thu, 7 May 2020 09:42:52 +0000
Message-ID: <20200507094252.13914-1-weiyongjun1@huawei.com>
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

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: d2efbbd18b1e ("gnss: add driver for sirfstar-based receivers")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gnss/sirf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index effed3a8d398..2ecb1d3e8eeb 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -439,14 +439,18 @@ static int sirf_probe(struct serdev_device *serdev)
 
 	data->on_off = devm_gpiod_get_optional(dev, "sirf,onoff",
 			GPIOD_OUT_LOW);
-	if (IS_ERR(data->on_off))
+	if (IS_ERR(data->on_off)) {
+		ret = PTR_ERR(data->on_off);
 		goto err_put_device;
+	}
 
 	if (data->on_off) {
 		data->wakeup = devm_gpiod_get_optional(dev, "sirf,wakeup",
 				GPIOD_IN);
-		if (IS_ERR(data->wakeup))
+		if (IS_ERR(data->wakeup)) {
+			ret = PTR_ERR(data->wakeup);
 			goto err_put_device;
+		}
 
 		ret = regulator_enable(data->vcc);
 		if (ret)



