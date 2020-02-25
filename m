Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29165C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7792072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgBYPxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:53:43 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:55262 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730309AbgBYPxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:53:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 32887FB02;
        Tue, 25 Feb 2020 16:53:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rzxrP2PCQqbW; Tue, 25 Feb 2020 16:53:36 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 077B9405AD; Tue, 25 Feb 2020 16:53:34 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1] phy: fsl-imx8-mipi-dphy: Hook into runtime pm
Date:   Tue, 25 Feb 2020 16:53:34 +0100
Message-Id: <ab30161e026bf57846c2803de360983c83840d68.1582645780.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1582645780.git.agx@sigxcpu.org>
References: <cover.1582645780.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to shut down the mipi power domain on the SOC.  The
alternative would be to drop the dphy from the mipi power domain in the
SOCs device tree and only have the DSI host controller visible there
(and rely on the phy layer's built in runtime pm handling) but this
would make the power domain dependency less explicit.

Currently the pm domain can't be shut off when blanking the panel:

pm_genpd_summary
domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
mipi                            on
    /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  unsupported
    /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended

while with this change we can shut down the power domain on panel blank:

mipi                            off-0
    /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  suspended
    /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
index 9f2c1da14f5a..75bfcc49466f 100644
--- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
+++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
@@ -14,6 +14,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 /* DPHY registers */
@@ -93,6 +94,7 @@ struct mixel_dphy_cfg {
 };
 
 struct mixel_dphy_priv {
+	struct device *dev;
 	struct mixel_dphy_cfg cfg;
 	struct regmap *regmap;
 	struct clk *phy_ref_clk;
@@ -382,6 +384,7 @@ static int mixel_dphy_power_on(struct phy *phy)
 	ret = clk_prepare_enable(priv->phy_ref_clk);
 	if (ret < 0)
 		return ret;
+	pm_runtime_get_sync(priv->dev);
 
 	phy_write(phy, PWR_ON, DPHY_PD_PLL);
 	ret = regmap_read_poll_timeout(priv->regmap, DPHY_LOCK, locked,
@@ -395,6 +398,7 @@ static int mixel_dphy_power_on(struct phy *phy)
 
 	return 0;
 clock_disable:
+	pm_runtime_put(priv->dev);
 	clk_disable_unprepare(priv->phy_ref_clk);
 	return ret;
 }
@@ -406,6 +410,7 @@ static int mixel_dphy_power_off(struct phy *phy)
 	phy_write(phy, PWR_OFF, DPHY_PD_PLL);
 	phy_write(phy, PWR_OFF, DPHY_PD_DPHY);
 
+	pm_runtime_put(priv->dev);
 	clk_disable_unprepare(priv->phy_ref_clk);
 
 	return 0;
@@ -469,6 +474,7 @@ static int mixel_dphy_probe(struct platform_device *pdev)
 	dev_dbg(dev, "phy_ref clock rate: %lu\n",
 		clk_get_rate(priv->phy_ref_clk));
 
+	priv->dev = dev;
 	dev_set_drvdata(dev, priv);
 
 	phy = devm_phy_create(dev, np, &mixel_dphy_phy_ops);
@@ -479,12 +485,26 @@ static int mixel_dphy_probe(struct platform_device *pdev)
 	phy_set_drvdata(phy, priv);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
 
-	return PTR_ERR_OR_ZERO(phy_provider);
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
+static int mixel_dphy_remove(struct platform_device *pdev)
+{
+	struct mixel_dphy_priv *priv = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(priv->dev);
+
+	return 0;
 }
 
 static struct platform_driver mixel_dphy_driver = {
 	.probe	= mixel_dphy_probe,
+	.remove = mixel_dphy_remove,
 	.driver = {
 		.name = "mixel-mipi-dphy",
 		.of_match_table	= mixel_dphy_of_match,
-- 
2.23.0

