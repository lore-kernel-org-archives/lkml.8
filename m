Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7BBC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226A4206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGXPI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:08:26 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:42486 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbgGXPIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:08:24 -0400
X-IronPort-AV: E=Sophos;i="5.75,391,1589209200"; 
   d="scan'208";a="52963390"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Jul 2020 00:08:23 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A16C54005E3C;
        Sat, 25 Jul 2020 00:08:21 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] media: i2c: ov772x: Add support for BT656 mode
Date:   Fri, 24 Jul 2020 16:08:15 +0100
Message-Id: <1595603296-25903-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595603296-25903-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1595603296-25903-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to read the bus-type and enable BT656 mode if needed.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/i2c/ov772x.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov772x.c b/drivers/media/i2c/ov772x.c
index 2cc6a67..3b7dfba 100644
--- a/drivers/media/i2c/ov772x.c
+++ b/drivers/media/i2c/ov772x.c
@@ -31,6 +31,7 @@
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-event.h>
+#include <media/v4l2-fwnode.h>
 #include <media/v4l2-image-sizes.h>
 #include <media/v4l2-subdev.h>
 
@@ -434,6 +435,7 @@ struct ov772x_priv {
 #ifdef CONFIG_MEDIA_CONTROLLER
 	struct media_pad pad;
 #endif
+	struct v4l2_fwnode_endpoint ep;
 };
 
 /*
@@ -585,7 +587,6 @@ static int ov772x_s_stream(struct v4l2_subdev *sd, int enable)
 				 enable ? 0 : SOFT_SLEEP_MODE);
 	if (ret)
 		goto done;
-
 	if (enable) {
 		dev_dbg(&client->dev, "format %d, win %s\n",
 			priv->cfmt->code, priv->win->name);
@@ -1104,7 +1105,10 @@ static int ov772x_set_params(struct ov772x_priv *priv,
 		goto ov772x_set_fmt_error;
 
 	/* COM7: Sensor resolution and output format control. */
-	ret = regmap_write(priv->regmap, COM7, win->com7_bit | cfmt->com7);
+	val = win->com7_bit | cfmt->com7;
+	if (priv->ep.bus_type == V4L2_MBUS_BT656)
+		val |= ITU656_ON_OFF;
+	ret = regmap_write(priv->regmap, COM7, val);
 	if (ret < 0)
 		goto ov772x_set_fmt_error;
 
@@ -1354,6 +1358,7 @@ static const struct v4l2_subdev_ops ov772x_subdev_ops = {
 
 static int ov772x_probe(struct i2c_client *client)
 {
+	struct fwnode_handle *endpoint;
 	struct ov772x_priv	*priv;
 	int			ret;
 	static const struct regmap_config ov772x_regmap_config = {
@@ -1415,6 +1420,20 @@ static int ov772x_probe(struct i2c_client *client)
 		goto error_clk_put;
 	}
 
+	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(&client->dev),
+						  NULL);
+	if (!endpoint) {
+		dev_err(&client->dev, "endpoint node not found\n");
+		goto error_clk_put;
+	}
+
+	ret = v4l2_fwnode_endpoint_parse(endpoint, &priv->ep);
+	fwnode_handle_put(endpoint);
+	if (ret) {
+		dev_err(&client->dev, "Could not parse endpoint\n");
+		goto error_clk_put;
+	}
+
 	ret = ov772x_video_probe(priv);
 	if (ret < 0)
 		goto error_gpio_put;
-- 
2.7.4

