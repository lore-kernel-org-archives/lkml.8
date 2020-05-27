Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9DEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09DD20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="vJADURQt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2uIUBetx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389973AbgE0PqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:46:12 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45545 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389929AbgE0PqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:46:02 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 192695C0229;
        Wed, 27 May 2020 11:46:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Br1uyNI7ITy6T
        7Cb01ktGmvtq22WgQAeHm0e1UAZ/lA=; b=vJADURQtqkaS6ntR542Xt0Idob2hP
        8pTNVNCdxCNtfEu9iwbh/CjQcZMY77qIV1msIf2YGLw0yQnRDdtIXB4mh0iv602T
        m+hjjXtgu5RqHg4MwyCy0iTnb25J7nYmuIyu2JgFGGVSlvx31lEQ26ACjwdzSiMM
        UwcwO1CZXvELYR7hNKALEXW5K7TfZ6nXhmJnGCZiuhuFQHswRVM49PyHM4ITK6R0
        CvUYMxisnf7/V7z1bzQtNGYLToZymVUAv749MFNxXqRuwoIrJ8rn9sgQZsFHrpT2
        xdfTG1hvNCHtDqixKdkWVaNCo4RHEfijACIX/85coL0/JobJPwX5i34XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Br1uyNI7ITy6T7Cb01ktGmvtq22WgQAeHm0e1UAZ/lA=; b=2uIUBetx
        Qou6spF7Vqkn4AlLfdvVJzJlyH7PVFbYZqCBC8sAqXLDMsgDNk9628lr2YtllZJZ
        UQcxixGAj5ccT6xc7mqC8jY7RmW2kntn1p+HuwqHxZVHEnjYqwQv8mj8IdWtag3H
        tFwB0Yo7Hlc97+W3zFeSajnyr37qCYoqiPCS1NOZVyhb73UMguO2xLkV5lwHSiEa
        CJR6Kxq9XXYXg8Grx9tAdyl8UJBWc2kTAsIwEzba7vmRQYA4lz3WYWz7Ht4UQsZx
        muUDh2ukj7A3anWIhMmUW8BAcMo2xVcNV8vNYcq0XjMaaBuyIWATBn9WQNiCoEW3
        L0s24vulPr5bGw==
X-ME-Sender: <xms:OYvOXoURO_hi4e7H8SKaBgmQxmnzmw06xU5uGbCuN50yGp4oTTQLJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:OYvOXskPdofykykOYXqmwRP94J4HMbqvudLeJn-IT6Wa9T6HsGGgRw>
    <xmx:OYvOXsamH5Lmt1b7O7yaoD1HU7jfkR8Ww8g3VjjUtDkh0WUAa3W50Q>
    <xmx:OYvOXnVSu172DI9nb67jjVn1DnqleWwzlZKtES9yHcryssg_gym8IQ>
    <xmx:OYvOXptJCfDoFi2-pi_2XfgggRMxEyZ96IqjqZWe_x-BqpQ9ok5Umg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C095A328005D;
        Wed, 27 May 2020 11:46:00 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 22/25] clk: bcm: rpi: Give firmware clocks a name
Date:   Wed, 27 May 2020 17:45:18 +0200
Message-Id: <135a5d32e42d9a117e264f1f52ac9fb6b9dc20e6.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've registered the firmware clocks using their ID as name, but it's much
more convenient to register them using their proper name. Since the
firmware doesn't provide it, we have to duplicate it.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 8d3acf3ee053..cee634cb5323 100644
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
 
@@ -367,8 +386,8 @@ static struct clk_hw *raspberrypi_clk_register(struct raspberrypi_clk *rpi,
 		return ERR_PTR(ret);
 	}
 
-	dev_info(rpi->dev, "Clock %d frequency range: min %u, max %u\n",
-		 id, min_rate, max_rate);
+	dev_info(rpi->dev, "Clock %s frequency range: min %u, max %u\n",
+		 rpi_firmware_clk_names[id], min_rate, max_rate);
 
 	ret = devm_clk_hw_register(rpi->dev, &data->hw);
 	if (ret)
-- 
git-series 0.9.1
