Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9012DC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6532F20771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgDILlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:41:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbgDILli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:41:38 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C4AE6E691DB7A3209D39;
        Thu,  9 Apr 2020 19:41:34 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 19:41:27 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <heiko@sntech.de>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] clk: rockchip: remove defined but not used 'mux_timer_src_p'
Date:   Thu, 9 Apr 2020 19:40:01 +0800
Message-ID: <20200409114001.38122-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/clk/rockchip/clk-rk3308.c:136:7: warning: ‘mux_timer_src_p’
defined but not used [-Wunused-const-variable=]
 PNAME(mux_timer_src_p)  = { "xin24m", "clk_rtc32k" };
       ^

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/clk/rockchip/clk-rk3308.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3308.c b/drivers/clk/rockchip/clk-rk3308.c
index b0baf87a283e..5bf15f2a44b7 100644
--- a/drivers/clk/rockchip/clk-rk3308.c
+++ b/drivers/clk/rockchip/clk-rk3308.c
@@ -133,7 +133,6 @@ PNAME(mux_uart1_p)		= { "clk_uart1_src", "dummy", "clk_uart1_frac" };
 PNAME(mux_uart2_p)		= { "clk_uart2_src", "dummy", "clk_uart2_frac" };
 PNAME(mux_uart3_p)		= { "clk_uart3_src", "dummy", "clk_uart3_frac" };
 PNAME(mux_uart4_p)		= { "clk_uart4_src", "dummy", "clk_uart4_frac" };
-PNAME(mux_timer_src_p)		= { "xin24m", "clk_rtc32k" };
 PNAME(mux_dclk_vop_p)		= { "dclk_vop_src", "dclk_vop_frac", "xin24m" };
 PNAME(mux_nandc_p)		= { "clk_nandc_div", "clk_nandc_div50" };
 PNAME(mux_sdmmc_p)		= { "clk_sdmmc_div", "clk_sdmmc_div50" };
-- 
2.17.2

