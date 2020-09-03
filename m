Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3842C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9592A206EB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgICGck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 02:32:40 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:40334 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgICGck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 02:32:40 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 44257ED62A;
        Thu,  3 Sep 2020 14:32:37 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P29633T140716441319168S1599114756148900_;
        Thu, 03 Sep 2020 14:32:37 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f97d728069991bec97f975f10c0dab4d>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 6/6] clk: rockchip: rk3399: Support module build
Date:   Thu,  3 Sep 2020 14:32:34 +0800
Message-Id: <20200903063234.10639-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903063147.10237-1-zhangqing@rock-chips.com>
References: <20200903063147.10237-1-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

support CLK_OF_DECLARE and builtin_platform_driver_probe
double clk init method.
add module author, description and license to support building
Soc Rk3399 clock driver as module.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3399.c | 55 +++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index ce1d2446f142..40ff17aee5b6 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -5,9 +5,11 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/module.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <dt-bindings/clock/rk3399-cru.h>
@@ -1600,3 +1602,56 @@ static void __init rk3399_pmu_clk_init(struct device_node *np)
 	rockchip_clk_of_add_provider(np, ctx);
 }
 CLK_OF_DECLARE(rk3399_cru_pmu, "rockchip,rk3399-pmucru", rk3399_pmu_clk_init);
+
+struct clk_rk3399_inits {
+		void (*inits)(struct device_node *np);
+};
+
+static const struct clk_rk3399_inits clk_rk3399_pmucru_init = {
+	.inits = rk3399_pmu_clk_init,
+};
+
+static const struct clk_rk3399_inits clk_rk3399_cru_init = {
+	.inits = rk3399_clk_init,
+};
+
+static const struct of_device_id clk_rk3399_match_table[] = {
+	{
+		.compatible = "rockchip,rk3399-cru",
+		.data = &clk_rk3399_cru_init,
+	},  {
+		.compatible = "rockchip,rk3399-pmucru",
+		.data = &clk_rk3399_pmucru_init,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, clk_rk3399_match_table);
+
+static int __init clk_rk3399_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *match;
+	const struct clk_rk3399_inits *init_data;
+
+	match = of_match_device(clk_rk3399_match_table, &pdev->dev);
+	if (!match || !match->data)
+		return -EINVAL;
+
+	init_data = match->data;
+	if (init_data->inits)
+		init_data->inits(np);
+
+	return 0;
+}
+
+static struct platform_driver clk_rk3399_driver = {
+	.driver		= {
+		.name	= "clk-rk3399",
+		.of_match_table = clk_rk3399_match_table,
+	},
+};
+builtin_platform_driver_probe(clk_rk3399_driver, clk_rk3399_probe);
+
+MODULE_DESCRIPTION("Rockchip RK3399 Clock Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:clk-rk3399");
-- 
2.17.1



