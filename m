Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456E3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230D72053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="MWQ/7w8g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tbyC+AiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgFOIld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:41:33 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:34483 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729153AbgFOIlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1284F58014B;
        Mon, 15 Jun 2020 04:41:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=pYyNDSSuURVGq
        uva2iiYPS/hBBwj419TwMZtcWAi3tY=; b=MWQ/7w8gM+1+hIj6XYWFc/qs9YDL4
        5DgT2qF3IiOdf5H8UU0uKAxQwNQ67xeLU388EshR2hGUG8zyrO8Qaz2wpUFyhY7q
        4VdHQrZoTMVEXAtGUyvX/CWPTJANXUXtH45ZxNDBHs4F0PqQj8MFgTq+vyOowo9K
        4ZF76K9GCelIKuv9hdURPTrhPqjEIeLExDcv9j6h1e6Al4zRb9jjGVzZ7/0WUn70
        t3NBfGVpnF6ZpZJQOuN4Jr+oxwoqrEuzdqQ4NDNs2dpoi8ulIV9E3rBXmVw8+dzc
        AluauCARZM2htyj789SCMtfPJME5I3s2v1gLJ1RRJ9HSUkIH4QFaLWyTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=pYyNDSSuURVGquva2iiYPS/hBBwj419TwMZtcWAi3tY=; b=tbyC+AiG
        e4H6ndiVtQ53TRW8j07XyrU3kZ4jc4Lb2FPQxpADpOcj9wgUF3r4LAV12OSDdlwg
        Ez0Uf8upygG/ewt7yms/xjvMqkkrNKrTncYhreqKnju/AWCzx+ZhaWeXA8iDBt1X
        ffbIhJo5aImeMQwqjipc2iHB9aXdzlWgnDqxL26wogJDvMmqs3JnsKYKxt+roFWc
        DDz9hNIe0rjFtKafpbwgSjAL/uEoB3ABgT2ORRG/PoTK7Y8CucCjG36uV9pgcdWt
        U/G7sMrH5a9tdTMkN5dozFwu/i7CuACXIac5rpd/eGIILE045u2DSn58BztmDzDL
        a8Co0MvsrJdxRQ==
X-ME-Sender: <xms:OTTnXkmKkz0p897cBY0KrZ2JPXTBujKmvO-wQKbl2Qq2RJVjoHh2-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:OTTnXj2TUdeMLoTIaFsgGJgGKEx86nNGgLsgjj-v1QnvD3l2ybNBGA>
    <xmx:OTTnXirXoJG1J2AW4u_EE2LXjeQ5qdbVh5rmYew9Wb2hKah_Jqf7sg>
    <xmx:OTTnXgnFZo7fuaupF1B5Ld0XdT--OTpBwmVGUJZ7cYfipU1cvrXceQ>
    <xmx:OjTnXgw6y7o3ZHkOrbApKZxkJoTzjFzHp_dNqn2iU0extqHB8f-XaQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A60573280066;
        Mon, 15 Jun 2020 04:41:29 -0400 (EDT)
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
Subject: [PATCH v5 06/27] clk: bcm: rpi: Use clk_hw_register for pllb_arm
Date:   Mon, 15 Jun 2020 10:40:46 +0200
Message-Id: <1146177664999eeda65856d28ce94025021dd85e.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pllb_arm clock is defined as a fixed factor clock with the pllb
clock as a parent. However, all its configuration is entirely static,
and thus we don't really need to call clk_hw_register_fixed_factor() but
can simply call clk_hw_register() with a static clk_fixed_factor
structure.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index ddc72207212e..5f0d4875e145 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -225,16 +225,28 @@ static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 	return devm_clk_hw_register(rpi->dev, &rpi->pllb);
 }
 
+static struct clk_fixed_factor raspberrypi_clk_pllb_arm = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data) {
+		.name		= "pllb_arm",
+		.parent_names	= (const char *[]){ "pllb" },
+		.num_parents	= 1,
+		.ops		= &clk_fixed_factor_ops,
+		.flags		= CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
 static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 {
-	rpi->pllb_arm = clk_hw_register_fixed_factor(rpi->dev,
-				"pllb_arm", "pllb",
-				CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
-				1, 2);
-	if (IS_ERR(rpi->pllb_arm)) {
+	int ret;
+
+	ret = clk_hw_register(rpi->dev, &raspberrypi_clk_pllb_arm.hw);
+	if (ret) {
 		dev_err(rpi->dev, "Failed to initialize pllb_arm\n");
-		return PTR_ERR(rpi->pllb_arm);
+		return ret;
 	}
+	rpi->pllb_arm = &raspberrypi_clk_pllb_arm.hw;
 
 	rpi->pllb_arm_lookup = clkdev_hw_create(rpi->pllb_arm, NULL, "cpu0");
 	if (!rpi->pllb_arm_lookup) {
-- 
git-series 0.9.1
