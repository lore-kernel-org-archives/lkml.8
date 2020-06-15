Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E1FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB6C20578
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ndiYe/ou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nm/75rO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgFOInJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:43:09 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57591 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729134AbgFOIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id E4A4358014B;
        Mon, 15 Jun 2020 04:41:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=IX0gao1Puvchr
        YEbeUvqw+7GMUKbR2y6MVj5PQ2uSsI=; b=ndiYe/ou8UPWu1R4C4jmnzO1T7idE
        j8eyGFcVk78jW9taqbpJ2cGNkg49qnowHdtx855Qz27CmAT6xeFUl1Rq+HVLm7rZ
        cYhBuOdCvxVDmp1DmNa/ySK9AvLBMBoL2ysXgnQr/gQ1OfICvKXcq0AdZJ3ci/BZ
        pzYC8bskdksgUbb9u2KVEmMRUH6kusp9qfHWnLO3H3oIvvi0w5uD7MsiDsYPrevn
        eGACaBIZTTzXGpTopXwrTTqP/kyOtmUuptBGbjpTDc3aKvYJ9ZNXODmX6ZX5FOEh
        bQBtN3HKaoCaALDgIt95Jhn/ovNlSma1rnfhEbYKE3+rs9zNbc9JFPkDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=IX0gao1PuvchrYEbeUvqw+7GMUKbR2y6MVj5PQ2uSsI=; b=Nm/75rO8
        lOpe2Gun3qrPNFjtT6mu4kUqiFsvcOzo2jB2qve61ImMpWAuYaWBCtidKAHjIrzo
        BfV18mn1kvHhytpM1J/QqwrIrhE1O5TW5GVuggsNnpD9Zvo5muZQnGeOM+3XueiH
        5lIDp2+4Xd3SXi3bmkjzPDizvEHH/YP5bST8AAcRFScNRpe8U/g95ejniUJqe0Xo
        pCYLD9p/31Rh1AQNNYOGcYWo3R9JicirjTnaOQix1f0eEpsOBiYbzkLmJP6rRwHN
        wztHqNzZyM/ZJymw1J+YLOc5GLDbHJ3fwKbsTmTVe5jsqOaBZLDK7GVDrsTP2QeZ
        tEFM4s6NSHnKGA==
X-ME-Sender: <xms:NjTnXiQR1zjZuOJAhGRibQXbQAeWG6n_PyDETJPuuXXjOVsP8PyaKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:NjTnXnzAHrrMkkosn3FaPLcY0EIt1lf9MvLIUWkujRIMUo8KTa-tKA>
    <xmx:NjTnXv20t9G6h6AmbombXHVDAxmD6kuz4CG7yQMamKLUNrkQ39UHDw>
    <xmx:NjTnXuDJ8tv1olUvqg-EPY0PIbasrZI7sHknKT0o-3jfebvE_Eq1AQ>
    <xmx:NjTnXqMizlRhIzbflFDipb83ugdzLSyNBszuiLJlD-kCAn60LO_E6w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 822693280059;
        Mon, 15 Jun 2020 04:41:26 -0400 (EDT)
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
Subject: [PATCH v5 04/27] clk: bcm: rpi: Allow the driver to be probed by DT
Date:   Mon, 15 Jun 2020 10:40:44 +0200
Message-Id: <cb8203b862e386ac6c3df3eff0bb5a238b6ec97a.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current firmware clock driver for the RaspberryPi can only be probed by
manually registering an associated platform_device.

While this works fine for cpufreq where the device gets attached a clkdev
lookup, it would be tedious to maintain a table of all the devices using
one of the clocks exposed by the firmware.

Since the DT on the other hand is the perfect place to store those
associations, make the firmware clocks driver probe-able through the device
tree so that we can represent it as a node.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 1654fd0eedc9..8610355bda47 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -255,8 +255,16 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	struct raspberrypi_clk *rpi;
 	int ret;
 
-	firmware_node = of_find_compatible_node(NULL, NULL,
-					"raspberrypi,bcm2835-firmware");
+	/*
+	 * We can be probed either through the an old-fashioned
+	 * platform device registration or through a DT node that is a
+	 * child of the firmware node. Handle both cases.
+	 */
+	if (dev->of_node)
+		firmware_node = of_get_parent(dev->of_node);
+	else
+		firmware_node = of_find_compatible_node(NULL, NULL,
+							"raspberrypi,bcm2835-firmware");
 	if (!firmware_node) {
 		dev_err(dev, "Missing firmware node\n");
 		return -ENOENT;
@@ -300,9 +308,16 @@ static int raspberrypi_clk_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id raspberrypi_clk_match[] = {
+	{ .compatible = "raspberrypi,firmware-clocks" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, raspberrypi_clk_match);
+
 static struct platform_driver raspberrypi_clk_driver = {
 	.driver = {
 		.name = "raspberrypi-clk",
+		.of_match_table = raspberrypi_clk_match,
 	},
 	.probe          = raspberrypi_clk_probe,
 	.remove		= raspberrypi_clk_remove,
-- 
git-series 0.9.1
