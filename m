Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE58C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13BC8207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AUp8k3jC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgFELAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:00:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42970 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgFELAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:00:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055AuhAU009940;
        Fri, 5 Jun 2020 11:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=V0ubaUIN8W9lc6XMfm+T9kuHl5SLdA5xza5SBaAtBI0=;
 b=AUp8k3jC/5PRtTKKyrZReG6odvTBwW5ig9t0XdLrUL5hAnVeJgcw3Qbox02bVruKtZWK
 lV9kbAXkCBdUT9tIhJzJC4bLlverzAc9d9Ozo8MfD7WKAkSkd0zgn7se0s/WWJlMHWU7
 bGhkxYaKS7f0nAVKywCIzdul/RVaP8o52XlzNMcn8QemvV5HmRbvfXW58z0l8toJIRQb
 7vdpcvOmK7bEcWE2SUwlvNnxDFV95T8gdQgLRBbaq8Ib7w+dJF9y1i+wOK1ucL80/9F7
 LCyZxAdS5iGNU7lPRstrBKuXjOEU5sh02kNVE2iF/BiixueJHnCllLnl+XoqDCe3yohc rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31f91dtac0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 11:00:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055AxR9V016558;
        Fri, 5 Jun 2020 11:00:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31f92sksmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 11:00:29 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 055B0SBY004168;
        Fri, 5 Jun 2020 11:00:28 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 04:00:27 -0700
Date:   Fri, 5 Jun 2020 14:00:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>
Cc:     Rajan Vaja <rajan.vaja@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] soc: xilinx: Fix error code in zynqmp_pm_probe()
Message-ID: <20200605110020.GA978434@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=879 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 cotscore=-2147483648 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=913 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be returning PTR_ERR() but it returns IS_ERR() instead.

Fixes: ffdbae28d9d1 ("drivers: soc: xilinx: Use mailbox IPI callback")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/soc/xilinx/zynqmp_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index 31ff49fcd078b..c556623dae024 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -205,7 +205,7 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 		rx_chan = mbox_request_channel_byname(client, "rx");
 		if (IS_ERR(rx_chan)) {
 			dev_err(&pdev->dev, "Failed to request rx channel\n");
-			return IS_ERR(rx_chan);
+			return PTR_ERR(rx_chan);
 		}
 	} else if (of_find_property(pdev->dev.of_node, "interrupts", NULL)) {
 		irq = platform_get_irq(pdev, 0);
-- 
2.26.2

