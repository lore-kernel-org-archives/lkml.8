Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A9BC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CE5208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgBSIa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:30:26 -0500
Received: from out28-193.mail.aliyun.com ([115.124.28.193]:34137 "EHLO
        out28-193.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSIaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:30:25 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2899067|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.261504-0.00564562-0.73285;DS=CONTINUE|ham_system_inform|0.00824288-0.00013658-0.991621;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03312;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.Gpe8RV3_1582100997;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Gpe8RV3_1582100997)
          by smtp.aliyun-inc.com(10.147.40.2);
          Wed, 19 Feb 2020 16:30:14 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, tglx@linutronix.de, maz@kernel.org,
        jason@lakedaemon.net, sboyd@kernel.org, mturquette@baylibre.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, paul@crapouillou.net,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com,
        dongsheng.qiu@ingenic.com
Subject: [PATCH 2/4] clk: Ingenic: Add support for TCU of X1000.
Date:   Wed, 19 Feb 2020 16:29:32 +0800
Message-Id: <1582100974-129559-4-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582100974-129559-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1582100974-129559-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X1000 has a different TCU containing OST, since X1000, OST has been
independent of TCU. This patch is prepare for later OST driver.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 drivers/clk/ingenic/tcu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
index ad7daa4..8799907 100644
--- a/drivers/clk/ingenic/tcu.c
+++ b/drivers/clk/ingenic/tcu.c
@@ -317,10 +317,17 @@ static const struct ingenic_soc_info jz4770_soc_info = {
 	.has_tcu_clk = false,
 };
 
+static const struct ingenic_soc_info x1000_soc_info = {
+	.num_channels = 8,
+	.has_ost = false, /* X1000 has OST, but it not belong TCU */
+	.has_tcu_clk = false,
+};
+
 static const struct of_device_id ingenic_tcu_of_match[] __initconst = {
 	{ .compatible = "ingenic,jz4740-tcu", .data = &jz4740_soc_info, },
 	{ .compatible = "ingenic,jz4725b-tcu", .data = &jz4725b_soc_info, },
 	{ .compatible = "ingenic,jz4770-tcu", .data = &jz4770_soc_info, },
+	{ .compatible = "ingenic,x1000-tcu", .data = &x1000_soc_info, },
 	{ /* sentinel */ }
 };
 
@@ -471,3 +478,4 @@ static void __init ingenic_tcu_init(struct device_node *np)
 CLK_OF_DECLARE_DRIVER(jz4740_cgu, "ingenic,jz4740-tcu", ingenic_tcu_init);
 CLK_OF_DECLARE_DRIVER(jz4725b_cgu, "ingenic,jz4725b-tcu", ingenic_tcu_init);
 CLK_OF_DECLARE_DRIVER(jz4770_cgu, "ingenic,jz4770-tcu", ingenic_tcu_init);
+CLK_OF_DECLARE_DRIVER(x1000_cgu, "ingenic,x1000-tcu", ingenic_tcu_init);
-- 
2.7.4

