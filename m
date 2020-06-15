Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11583C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E514920578
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Ppi0/zd5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B5PfD++u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgFOImZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:42:25 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:53291 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729276AbgFOIl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id ADAA358014B;
        Mon, 15 Jun 2020 04:41:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Gu5pGox+Bnj5v
        k3taw7Hr0yvcuDhLrvmOZ5vLp2mebY=; b=Ppi0/zd5PWBPJKcgH6ycqINbw+qmG
        bEvIxaVAD7MOKb6XGTW4TNx0L9Bgtae79OZCqI4UT+2KG7RL2xfDciYaJJ8QFWsh
        R2EaX3VoZSX9l/3IGmabACwkkUvwtCpoAq4D/2xA+1s/X5GUPvVYlQCyc4DAzDI2
        PEezGgaLkjrDv5NvyF8SDU1EgTHqm+xqDqhPxlodyPSnJzEG4ErVW7y9TEJXyxgv
        Mq4qvztoe+4CLfU6vDLPn1fPfddgbrv492wTZo4AMgSNkPSTE0D6ptjMl7fUePCW
        nOVLjO+OZUTHNdJHtfiPF0NGbpuzOAFqumcuXP8K/rO35B7T2soolxU5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Gu5pGox+Bnj5vk3taw7Hr0yvcuDhLrvmOZ5vLp2mebY=; b=B5PfD++u
        y77Rwk4zCnMR+YllGvYQttV0x4DU8QTJdiW2hzwfgCwha6RAZGiincOOnA3Jp5Do
        kqZUHaDvFfOFF8WKlpVdQZ+RRjxfOoxoT8mXmRgLd/Ui3Wo0ue2GCU9Y82rGGa3T
        Bl2LFmEgepb3IiSduyYeX1wmzbqC6iVAYzSGm9Mj5DjAi7C/vJ9irHXa2/i7ZBWd
        CrB3qEPoaCtiIUmIn4T6r22erU+bYBuHrpP5KdBFRw7HjU+u8o7g7OCxvMbTqcXN
        og/C36Ze1dmylIkI98vx7j4gP4XfvLfvEpCNBtbOUatE/SElivJmflicq9SMFsR1
        JXVDxVXpUkIVtg==
X-ME-Sender: <xms:UzTnXktxeOwXqzxXM-aWrg6uQj4kOqCcHdkR8tpqzD4KJS5bz2wo0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:UzTnXhe7K6jOAdPoNBH3HBf8qzjI61FJLiAqd2rUK7vHeMf2dBBD8A>
    <xmx:UzTnXvyqSUf2TKBsEF7IXwq74SrS9hqbN5S7vXZa0Do09lyA6De0kQ>
    <xmx:UzTnXnOhL_eeWA8YObMjpSp871uTM9YSx9dO422axVhJZ38d9jcaXg>
    <xmx:UzTnXvYEjIeYudyrX03-doSChXmXY21SHIC1JocMqD3RTZV_o42ghQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3E8823280064;
        Mon, 15 Jun 2020 04:41:55 -0400 (EDT)
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
Subject: [PATCH v5 22/27] clk: bcm: rpi: Give firmware clocks a name
Date:   Mon, 15 Jun 2020 10:41:02 +0200
Message-Id: <a52a5f5768cd33716cdd35237c6613f26ad75013.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
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
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
