Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9786C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A173520787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390531AbgDCIbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:31:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:32980 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727774AbgDCIbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:31:02 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 16B74FABA60339C7C46C;
        Fri,  3 Apr 2020 16:30:57 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Fri, 3 Apr 2020
 16:30:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@xilinx.com>, <rajan.vaja@xilinx.com>,
        <tejas.patel@xilinx.com>, <m.tretter@pengutronix.de>,
        <yuehaibing@huawei.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] clk: zynqmp: Make zynqmp_clk_get_max_divisor static
Date:   Fri, 3 Apr 2020 16:30:40 +0800
Message-ID: <20200403083040.37748-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/clk/zynqmp/divider.c:259:5: warning:
 symbol 'zynqmp_clk_get_max_divisor' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/zynqmp/divider.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 4be2cc76aa2e..1e93a4d32fa9 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -256,7 +256,7 @@ static const struct clk_ops zynqmp_clk_divider_ops = {
  * Return: Maximum divisor of a clock if query data is successful
  *	   U16_MAX in case of query data is not success
  */
-u32 zynqmp_clk_get_max_divisor(u32 clk_id, u32 type)
+static u32 zynqmp_clk_get_max_divisor(u32 clk_id, u32 type)
 {
 	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 	struct zynqmp_pm_query_data qdata = {0};
-- 
2.17.1


