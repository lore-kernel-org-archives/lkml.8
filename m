Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8782C433E5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A8A206DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgHCOc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:32:26 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:8624 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728258AbgHCOcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:32:22 -0400
X-IronPort-AV: E=Sophos;i="5.75,430,1589209200"; 
   d="scan'208";a="53537270"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Aug 2020 23:32:20 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6A59B42ACBDC;
        Mon,  3 Aug 2020 23:32:17 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 3/4] media: i2c: ov5640: Add support for BT656 mode
Date:   Mon,  3 Aug 2020 15:31:46 +0100
Message-Id: <1596465107-14251-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596465107-14251-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1596465107-14251-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for BT656 mode.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/i2c/ov5640.c | 40 +++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index ec444bee2ce9..08c67250042f 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -82,6 +82,7 @@
 #define OV5640_REG_VFIFO_HSIZE		0x4602
 #define OV5640_REG_VFIFO_VSIZE		0x4604
 #define OV5640_REG_JPG_MODE_SELECT	0x4713
+#define OV5640_REG_CCIR656_CTRL00	0x4730
 #define OV5640_REG_POLARITY_CTRL00	0x4740
 #define OV5640_REG_MIPI_CTRL00		0x4800
 #define OV5640_REG_DEBUG_MODE		0x4814
@@ -1216,6 +1217,18 @@ static int ov5640_set_autogain(struct ov5640_dev *sensor, bool on)
 			      BIT(1), on ? 0 : BIT(1));
 }
 
+static int ov5640_set_stream_bt656(struct ov5640_dev *sensor, bool on)
+{
+	int ret;
+
+	ret = ov5640_write_reg(sensor, OV5640_REG_CCIR656_CTRL00, on ? 0x1 : 0x00);
+	if (ret)
+		return ret;
+
+	return ov5640_write_reg(sensor, OV5640_REG_SYS_CTRL0, on ?
+				OV5640_SOFTWARE_WAKEUP : OV5640_SOFTWARE_PWDN);
+}
+
 static int ov5640_set_stream_dvp(struct ov5640_dev *sensor, bool on)
 {
 	return ov5640_write_reg(sensor, OV5640_REG_SYS_CTRL0, on ?
@@ -2022,18 +2035,20 @@ static int ov5640_set_dvp(struct ov5640_dev *sensor, bool on)
 	 *		datasheet and hardware, 0 is active high
 	 *		and 1 is active low...)
 	 */
-	if (flags & V4L2_MBUS_PCLK_SAMPLE_RISING)
-		pclk_pol = 1;
-	if (flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH)
-		hsync_pol = 1;
-	if (flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
-		vsync_pol = 1;
+	if (sensor->ep.bus_type == V4L2_MBUS_PARALLEL) {
+		if (flags & V4L2_MBUS_PCLK_SAMPLE_RISING)
+			pclk_pol = 1;
+		if (flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH)
+			hsync_pol = 1;
+		if (flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
+			vsync_pol = 1;
 
-	ret = ov5640_write_reg(sensor, OV5640_REG_POLARITY_CTRL00,
-			       (pclk_pol << 5) | (hsync_pol << 1) | vsync_pol);
+		ret = ov5640_write_reg(sensor, OV5640_REG_POLARITY_CTRL00,
+				       (pclk_pol << 5) | (hsync_pol << 1) | vsync_pol);
 
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * powerdown MIPI TX/RX PHY & disable MIPI
@@ -2057,7 +2072,8 @@ static int ov5640_set_dvp(struct ov5640_dev *sensor, bool on)
 	 * - 4:		PCLK output enable
 	 * - [3:0]:	D[9:6] output enable
 	 */
-	ret = ov5640_write_reg(sensor, OV5640_REG_PAD_OUTPUT_ENABLE01, 0x7f);
+	ret = ov5640_write_reg(sensor, OV5640_REG_PAD_OUTPUT_ENABLE01,
+			       sensor->ep.bus_type == V4L2_MBUS_PARALLEL ? 0x7f : 0x1f);
 	if (ret)
 		return ret;
 
@@ -2911,6 +2927,8 @@ static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
 
 		if (sensor->ep.bus_type == V4L2_MBUS_CSI2_DPHY)
 			ret = ov5640_set_stream_mipi(sensor, enable);
+		else if (sensor->ep.bus_type == V4L2_MBUS_BT656)
+			ret = ov5640_set_stream_bt656(sensor, enable);
 		else
 			ret = ov5640_set_stream_dvp(sensor, enable);
 
-- 
2.17.1

