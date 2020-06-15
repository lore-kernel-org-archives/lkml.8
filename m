Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1292C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5DB2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="rIXLUMWD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bzkaJTRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgFOIl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:41:57 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:44709 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729267AbgFOIlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 416EE58014B;
        Mon, 15 Jun 2020 04:41:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=m+8UXj42uJPx8
        qcIPMY655n62FA5Z4MYx5m2JMXlm1A=; b=rIXLUMWD3MPDaR1vA5hpqVegmgcMZ
        05389yDh/1lCJQMYRjuF4TX11U8bNA5kwjSESUbf7ibbEmOlH5m2dokp8Wui6YiM
        uUJuFkdzDd6KDzHl682kTeVKfsm+RpDoar4+Q7+/wsvjQiWjvgQ+6mzOwxf8tqyJ
        fGyrRYhTpKSQSPC61nfyLsyaKXfSfKkxdZEUhuIZSuKT0d63uh3lCBmj3J9owiK8
        8RNNmYw9IfAh3rZF1Rh148SgYjJK3B0PbER6ykkCeUJEONCDU6a1AZ7bKBZ5RvQ/
        syr8lZLAMimG59G2sdNTLK4wh9MoaFEgxh0Y4pj5hKgMhN41M9Fv1KFLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=m+8UXj42uJPx8qcIPMY655n62FA5Z4MYx5m2JMXlm1A=; b=bzkaJTRi
        mUI59c44hYRfP+W3sTp0CQyP3YWKdX1LkokZnEyFQ1wi1s1pfthu27yqJDYXu4c1
        4wqYC+lFTC86atVWfM5vv9U6KFrmmhcY541jrHnzv2mqJUN0YCU/w3ZVOd6kIDFQ
        HnwYHq28/ijTz3H+i1Qw3fZ5SPGEQXzQPH3VNP/Mb58uWg+1vSM9E3Qp+R25KUFX
        +r/vaGZmordfnWfhXgaea7KFkegBXrk/L/aE7ip1qkJJ9mqPh0lZCr3YCH1TYcuE
        TtqYiJoacFk48d5reldDfuPmIadb72rIlPOpgIuORAerdV6tPAuBesEsSsAwOXDd
        t7oBK3tFKXKF7A==
X-ME-Sender: <xms:UDTnXlbeQgGOvRFWDUCQhsi5bt20WEiadMLZEPalWlyNKsBIKwn3Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:UDTnXsYKeHD-1yO6-yxdjg51E47nyFmLNBBoJI7BAmogwi2fmaQsXA>
    <xmx:UDTnXn_SslZAAXAO2dn5riLLQoC7RM5k_5dTHW3gxYuES_hzJ8C0KQ>
    <xmx:UDTnXjomOQcuNWYTFsDEtEz_PTZzII-6YRdRqZGbULm3pICbzNdJ3A>
    <xmx:UDTnXn1JLHeEcu7vDX_mkQG7zmcA9Nd45RIFkRruzdQNcSN95e3XCA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D49AD3280066;
        Mon, 15 Jun 2020 04:41:51 -0400 (EDT)
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
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v5 20/27] clk: bcm: rpi: Add an enum for the firmware clocks
Date:   Mon, 15 Jun 2020 10:41:00 +0200
Message-Id: <4738f77ee7de9b48a3bb1c558ead958d0cc064d9.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
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
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
