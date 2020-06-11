Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D218C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14BB120812
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="WL8P/0J3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zq9zTQlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgFKHct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:32:49 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:45491 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726938AbgFKHcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:32:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id E0E735800D3;
        Thu, 11 Jun 2020 03:32:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=hYYvKNn61hkR1
        JaTxN13XukerEhkGWt2ObwhLB37wic=; b=WL8P/0J3j2mCMqnJA9ctl5iECxDha
        jYVsb5W8V/ZB+LbLdT5Go5fITtTjxWH/Adp6eBG6ibvVAWATDps6ZeyuaA9BUAVs
        lTYoF2Xa+rn0RBVBJ5ZXVz0CHPpPSocvsKuz/OTSRcEGS/HrH9/1w7OMRirp2tUu
        /gLE2I9Z58NEEiU6p8jSW0bBld30eTF4avw8xk8kSwv7FE8g1l4ZfiEaE/qxXIap
        su9V6YrohiqsCensk761mw4L5+vVU+MnKnz6HYNjyVcl8LgT62oe6G2dUMdN4UN8
        PICxbcCgMFoxVKwEDiboyQrTtpupX8mboJ+lx/K19Yo2qCBCKFvGZDICg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=hYYvKNn61hkR1JaTxN13XukerEhkGWt2ObwhLB37wic=; b=Zq9zTQlQ
        z/8sGmS5bRxqSFFQfmH8vj4txEe92ZyU0vpl69aZ+Z91/wM7+T5jLhjqtXp1Iz6M
        ft1nG0HCh9jFbOvjQjEB6SmP6TphgvCoUcyvA8e6NG8YORGcYOlFxSGu61JS1jDG
        XOCJ5Ji230nSJQrjVFlt5D8Tze0BP40UfuLD4nJKKeMYHg8nKWgViONywTbVJ6F7
        I8Jn3BWqQUiznc+XXh+W8iKwTc24JB2MxXTlOxnvNhr3dYq6sYot44GPoF2rVsjy
        81a47vIVdn3p3/MGxiu40YLKep5XldeljSAxVmSj9JssgljutAZxi4f/h384z48V
        U5BzDKl1/GYQ3w==
X-ME-Sender: <xms:HN7hXjEBjsGm2igCp_Hos7eVbr7WqTn88QI-7tIUOesu53yCCGOp7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeduvd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:HN7hXgWkqt2dm1ypmkgnObDi44lNL5Awo5j-IeFQjAlDHN4UNv-QyA>
    <xmx:HN7hXlKsADNc8qkTtQt2tGR_tnz3WShUoMM40Y36RTyLtiac6QU39Q>
    <xmx:HN7hXhF3lo65ALIHceEvuV2f_nA2k3l5zwDQ5F4sc2ihMuJfHrJ7fg>
    <xmx:HN7hXlpNWwFqcyKZFlwOdjdUZ3xcpnrzgz-QCtSzeYz5C5J821u5vA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7F90A30618B7;
        Thu, 11 Jun 2020 03:32:44 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 15/27] clk: bcm: rpi: Pass the clocks data to the firmware function
Date:   Thu, 11 Jun 2020 09:32:04 +0200
Message-Id: <f2993e1e441ab23ab6ad29ca620565cf7c6b557d.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The raspberry_clock_property only takes the clock ID as an argument, but
now that we have a clock data structure it makes more sense to just pass
that structure instead.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 97ac04604b0a..3fce49a65a79 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -65,11 +65,12 @@ struct raspberrypi_firmware_prop {
 	__le32 disable_turbo;
 } __packed;
 
-static int raspberrypi_clock_property(struct rpi_firmware *firmware, u32 tag,
-				      u32 clk, u32 *val)
+static int raspberrypi_clock_property(struct rpi_firmware *firmware,
+				      const struct raspberrypi_clk_data *data,
+				      u32 tag, u32 *val)
 {
 	struct raspberrypi_firmware_prop msg = {
-		.id = cpu_to_le32(clk),
+		.id = cpu_to_le32(data->id),
 		.val = cpu_to_le32(*val),
 		.disable_turbo = cpu_to_le32(1),
 	};
@@ -92,9 +93,8 @@ static int raspberrypi_fw_pll_is_on(struct clk_hw *hw)
 	u32 val = 0;
 	int ret;
 
-	ret = raspberrypi_clock_property(rpi->firmware,
-					 RPI_FIRMWARE_GET_CLOCK_STATE,
-					 data->id, &val);
+	ret = raspberrypi_clock_property(rpi->firmware, data,
+					 RPI_FIRMWARE_GET_CLOCK_STATE, &val);
 	if (ret)
 		return 0;
 
@@ -111,9 +111,8 @@ static unsigned long raspberrypi_fw_pll_get_rate(struct clk_hw *hw,
 	u32 val = 0;
 	int ret;
 
-	ret = raspberrypi_clock_property(rpi->firmware,
-					 RPI_FIRMWARE_GET_CLOCK_RATE,
-					 data->id, &val);
+	ret = raspberrypi_clock_property(rpi->firmware, data,
+					 RPI_FIRMWARE_GET_CLOCK_RATE, &val);
 	if (ret)
 		return ret;
 
@@ -129,9 +128,9 @@ static int raspberrypi_fw_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	u32 new_rate = rate / RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
 	int ret;
 
-	ret = raspberrypi_clock_property(rpi->firmware,
+	ret = raspberrypi_clock_property(rpi->firmware, data,
 					 RPI_FIRMWARE_SET_CLOCK_RATE,
-					 data->id, &new_rate);
+					 &new_rate);
 	if (ret)
 		dev_err_ratelimited(rpi->dev, "Failed to change %s frequency: %d",
 				    clk_hw_get_name(hw), ret);
@@ -194,18 +193,18 @@ static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 	init.flags = CLK_GET_RATE_NOCACHE | CLK_IGNORE_UNUSED;
 
 	/* Get min & max rates set by the firmware */
-	ret = raspberrypi_clock_property(rpi->firmware,
+	ret = raspberrypi_clock_property(rpi->firmware, data,
 					 RPI_FIRMWARE_GET_MIN_CLOCK_RATE,
-					 data->id, &min_rate);
+					 &min_rate);
 	if (ret) {
 		dev_err(rpi->dev, "Failed to get %s min freq: %d\n",
 			init.name, ret);
 		return ret;
 	}
 
-	ret = raspberrypi_clock_property(rpi->firmware,
+	ret = raspberrypi_clock_property(rpi->firmware, data,
 					 RPI_FIRMWARE_GET_MAX_CLOCK_RATE,
-					 data->id, &max_rate);
+					 &max_rate);
 	if (ret) {
 		dev_err(rpi->dev, "Failed to get %s max freq: %d\n",
 			init.name, ret);
-- 
git-series 0.9.1
