Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A101C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A062074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="gyZ8/Bvn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YNTcU3q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgFKHdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:33:35 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:37573 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726993AbgFKHcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:32:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C8F5F5800D2;
        Thu, 11 Jun 2020 03:32:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=+0j3O88jXCUCB
        0HT6pH0V+oipaoo+YucEFiEz5rag2U=; b=gyZ8/BvnHyMNHYbFgKWDlHgm1pTug
        DRimNZ30hG/jJgVgbr8GnAtAbf5GWhiDMCeDcWG8KvcCJtiRZfpfUqU9xxULDPIV
        UzjtSOa+RbEWQ8yECNyluM8fp7l3AEy/QMmrfQTsNjusqmf9JNKkYl9NApsvpTLj
        GNXllMr30OC5kJGzcb31uZYWTFq2sOPSzSGh4xC4qmJbyXrpvKvgY6aOY3ed4MwL
        lmfUfcoNu0xjtK1C11jdWoa3SLr+5WlWt5kHo/MA1aN7owRyYwpTRGrly6UkBQ2X
        jfS9C51aAvs6srI6NkDkKvkhsLXkRsTCmscaqKyJtVvTM4RYd8kkXlArQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+0j3O88jXCUCB0HT6pH0V+oipaoo+YucEFiEz5rag2U=; b=YNTcU3q8
        4EvPca6S1rGWNfDbgatzafOuWnRx82ZgrQMdi27ErQXikYl8HgrRAmwlY3AeuVYb
        AwQnPxbAD7YIOqJLeKX1NOVJBVjlHx66GEuD3awyrV6/SE92xDJliyEFmTq40Qvu
        zR5AW0f4N4jB9i/E/3hk7mz/vGrfy4nL7En/9Jw1RH59N5hSVKjB2fAQ50b5RjI7
        +kx5LrO6xCEz9NbLSARhwHgWS/i3IW+0vPGqHNlPRkLMm/s8YugUK2N9VNGlW9N4
        9fQkHk53lDuPHY8bAI3YiCe9HpCanRBFknKmENuIIZFr+IKiUN5dz0SULCDOavQy
        sny+RwFPOfFl8w==
X-ME-Sender: <xms:JN7hXsUIb71TWQFdGyNTx4L_kQCp3lDeRFOnSAWYMZXoM0tr5kEPBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeduie
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:JN7hXgnWuZ25nh72zt7N_oqAqCCnAeFR9g0g4jOLloADbO2vskIxyA>
    <xmx:JN7hXgaQGDRP7vtDEVPd9dDREIOZFCD7sg0Be4Vqs1XteXG4fh5FPg>
    <xmx:JN7hXrUiRn6R-Vewnxxuhehbk-D5u_9aurO8DigATh--6OYLvZjTgg>
    <xmx:JN7hXg6GwyW6qTW6u21PEGzjlnnX10A-IhjD5co46-fU1T0a9DlLeg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 659A13280059;
        Thu, 11 Jun 2020 03:32:52 -0400 (EDT)
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
Subject: [PATCH v4 20/27] clk: bcm: rpi: Add an enum for the firmware clocks
Date:   Thu, 11 Jun 2020 09:32:09 +0200
Message-Id: <889248ea19b3578b7e13f4df2a37edcc1fa4ed08.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the firmware allows us to discover the available clocks, we need to
discriminate those clocks to only register the ones meaningful to Linux.
The firmware also doesn't provide a clock name, so having a list of the ID
will help us to give clocks a proper name later on.

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 5f4e2d49432f..eebd16040f8a 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -18,7 +18,23 @@
 
 #include <soc/bcm2835/raspberrypi-firmware.h>
 
-#define RPI_FIRMWARE_ARM_CLK_ID		0x00000003
+enum rpi_firmware_clk_id {
+	RPI_FIRMWARE_EMMC_CLK_ID = 1,
+	RPI_FIRMWARE_UART_CLK_ID,
+	RPI_FIRMWARE_ARM_CLK_ID,
+	RPI_FIRMWARE_CORE_CLK_ID,
+	RPI_FIRMWARE_V3D_CLK_ID,
+	RPI_FIRMWARE_H264_CLK_ID,
+	RPI_FIRMWARE_ISP_CLK_ID,
+	RPI_FIRMWARE_SDRAM_CLK_ID,
+	RPI_FIRMWARE_PIXEL_CLK_ID,
+	RPI_FIRMWARE_PWM_CLK_ID,
+	RPI_FIRMWARE_HEVC_CLK_ID,
+	RPI_FIRMWARE_EMMC2_CLK_ID,
+	RPI_FIRMWARE_M2MC_CLK_ID,
+	RPI_FIRMWARE_PIXEL_BVB_CLK_ID,
+	RPI_FIRMWARE_NUM_CLK_ID,
+};
 
 #define RPI_FIRMWARE_STATE_ENABLE_BIT	BIT(0)
 #define RPI_FIRMWARE_STATE_WAIT_BIT	BIT(1)
@@ -31,8 +47,6 @@
 
 #define A2W_PLL_FRAC_BITS		20
 
-#define NUM_FW_CLKS			16
-
 struct raspberrypi_clk {
 	struct device *dev;
 	struct rpi_firmware *firmware;
@@ -320,7 +334,8 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	rpi->firmware = firmware;
 	platform_set_drvdata(pdev, rpi);
 
-	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, NUM_FW_CLKS),
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws,
+						 RPI_FIRMWARE_NUM_CLK_ID),
 				GFP_KERNEL);
 	if (!clk_data)
 		return -ENOMEM;
-- 
git-series 0.9.1
