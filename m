Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC399C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C354D20812
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ItR4oLac";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s23cuXZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgFKHdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:33:05 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:43103 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbgFKHc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:32:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id F0EE95800D2;
        Thu, 11 Jun 2020 03:32:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=50dNnUGcZ5mn3
        FPiDe0yy/zqxPcf3960haBgPL103hs=; b=ItR4oLacezTkGfIT3ev3BMPcn06Nv
        MavgOPdH7yd7P0ST7WWlSjiB9vNAmdyM6ahQrfWTrKoV5szjba+RAt6rjFPZCk9S
        +o1WcwccLS4F+8gw+QTDZz9CvHGwMtlWnFh14lP+Qxc/j1cj/xr0ZxARlJZg5Zyy
        mF75BfW6t2uLakogKq1SL5ogNjIr8vMF1DD8YE63b/25TlDnCkLMPLEowE6AFTlK
        G2LrJGb2wZWXMoUuYyyTyQSvinnTgsOPLeQii3/8tTfQSNpdydIqWWGJrbjLMXMb
        MyJhaFoEgTASGE5mz7HO12nw9aTXw4WHtfDrk1MaV+Sbg5Kgg77Z439DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=50dNnUGcZ5mn3FPiDe0yy/zqxPcf3960haBgPL103hs=; b=s23cuXZ0
        X2KU4J1QAFq7p+vMv7n3Gs81KwXjKyYM/Xd2CjEbg8OV6Jt+QYZV1svBeVp8lmsh
        MdKCYZIyMsdXSX81VVltmV1FE0mo/wl8bDbMY8k9ysDquUuORb/DvsWVpaRTP1/b
        xYi+7tFyTjntwhYPp75iW0krvYpSRsORUDemTc9ynv8uSbXXLb0cep6A4ixttiZQ
        PjPXwRat6JALg4cIZ0aRMaAiH71bvpoQbYx7IzWOQ3zPXpQt4PneXwctMnymT+ch
        SNimtptBEWy1cl7TaW/qx4MVGxM3ym6rOZdpj5fictNEWQGTnxo6R8ryTDb9t2oS
        Up3tBFP6lsTnKg==
X-ME-Sender: <xms:J97hXkdoH0xUnlS7x2W21F2q0jpV5dItodK3j3D560-OVvBlAVUWaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvtd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:J97hXmNMeZyxZPb2cHVTlSuAOSySMAlJ-0AL2jlUyIkSZ-0ko0UDZg>
    <xmx:J97hXljQ6tbHL4QbPZxFrecQVYePlZz6l67MSqGKUGHYb7i_B0-PRQ>
    <xmx:J97hXp8xLR-k1RXPeVvHBkVytyQV9fF8ixvOykZUmujqHxdLlX3IhA>
    <xmx:J97hXuB-zgbjmMS_SZV_OJIb4E-Ig1WDEeiOGzeUjUmPUjSLAA_MMw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8CBA33280059;
        Thu, 11 Jun 2020 03:32:55 -0400 (EDT)
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
Subject: [PATCH v4 22/27] clk: bcm: rpi: Give firmware clocks a name
Date:   Thu, 11 Jun 2020 09:32:11 +0200
Message-Id: <bdfe97621e5473dbcea3b8402cc5929a7e60565e.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've registered the firmware clocks using their ID as name, but it's much
more convenient to register them using their proper name. Since the
firmware doesn't provide it, we have to duplicate it.

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 11a62bde5203..adc0bb56008a 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -36,6 +36,23 @@ enum rpi_firmware_clk_id {
 	RPI_FIRMWARE_NUM_CLK_ID,
 };
 
+static char *rpi_firmware_clk_names[] = {
+	[RPI_FIRMWARE_EMMC_CLK_ID]	= "emmc",
+	[RPI_FIRMWARE_UART_CLK_ID]	= "uart",
+	[RPI_FIRMWARE_ARM_CLK_ID]	= "arm",
+	[RPI_FIRMWARE_CORE_CLK_ID]	= "core",
+	[RPI_FIRMWARE_V3D_CLK_ID]	= "v3d",
+	[RPI_FIRMWARE_H264_CLK_ID]	= "h264",
+	[RPI_FIRMWARE_ISP_CLK_ID]	= "isp",
+	[RPI_FIRMWARE_SDRAM_CLK_ID]	= "sdram",
+	[RPI_FIRMWARE_PIXEL_CLK_ID]	= "pixel",
+	[RPI_FIRMWARE_PWM_CLK_ID]	= "pwm",
+	[RPI_FIRMWARE_HEVC_CLK_ID]	= "hevc",
+	[RPI_FIRMWARE_EMMC2_CLK_ID]	= "emmc2",
+	[RPI_FIRMWARE_M2MC_CLK_ID]	= "m2mc",
+	[RPI_FIRMWARE_PIXEL_BVB_CLK_ID]	= "pixel-bvb",
+};
+
 #define RPI_FIRMWARE_STATE_ENABLE_BIT	BIT(0)
 #define RPI_FIRMWARE_STATE_WAIT_BIT	BIT(1)
 
@@ -343,7 +360,9 @@ static struct clk_hw *raspberrypi_clk_register(struct raspberrypi_clk *rpi,
 	data->rpi = rpi;
 	data->id = id;
 
-	init.name = devm_kasprintf(rpi->dev, GFP_KERNEL, "fw-clk-%u", id);
+	init.name = devm_kasprintf(rpi->dev, GFP_KERNEL,
+				   "fw-clk-%s",
+				   rpi_firmware_clk_names[id]);
 	init.ops = &raspberrypi_firmware_clk_ops;
 	init.flags = CLK_GET_RATE_NOCACHE;
 
-- 
git-series 0.9.1
