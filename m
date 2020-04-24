Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001C8C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A8E20700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="KxgYxG1V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hd3owlyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgDXPlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:41:24 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:42179 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726849AbgDXPfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:35:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 5412A21A;
        Fri, 24 Apr 2020 11:35:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=rUe63BFpIMvZr
        fI+zHnOUJolkz68c07yBo2Dpng9F1M=; b=KxgYxG1VVQBgw/WMPSGVKx9LRRYyP
        duEpS9mHn7NbXSLEqHT6AoCYTByR91ZWHQA6FISuUK/LtuBhoSIxoqx8uYo7/bg3
        J9DI8HrWO5YLMy/bw65gHeRJwnLhPh2V/d84EXFXs4zsPqynZq0GbXkTuj3VP7rY
        57nCpjGzJKBHtyYbCwj+q9Iz62RMqzZbDKLYNajMrmgJNHx4WtOPrvnkmNSaRfqw
        BGRUowxKK6myR2C4paq4EdFY/Y6gOqJeI86sXUkhXM6EJG/Ybr5yz/kP7qKMa07Y
        kWr6qNaxPl/mg2F/rvV8LMA+U2wv4LElQckLo8MfhWh6eI2FyGBGWqZwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=rUe63BFpIMvZrfI+zHnOUJolkz68c07yBo2Dpng9F1M=; b=Hd3owlyQ
        wRURYq9Uo5s1IiQ1qcmYX7vYDs8AAChJ1m0V37R+B9IgSJSQU83vIm8vsglbt0Dy
        nMnCBK0FkJi6T81iEcLWbLPutoGrMxLd46FPChMiGQWTgN65D7Qf70SjBzLZHKbU
        Dr+E54HrdOrDmj+6hrY7MzA/I3VLAzjr2r4wMtp9yp7zGKE+Kvw9sKwzGHj91h9U
        4rov/4CuDky9wRNWTZop4Cp9PQQ/lSTu4tYvpfnBQV95sM1X+yNGXWM8pHg6NcGw
        7sQdh3in1Su2R4i9yEgFmPF/tRz0JALxMe0foJACWlGOQh0UGN50thl6ZD4rHlqv
        CV3qwrCt0iL7Lw==
X-ME-Sender: <xms:QQejXsen2X4obe0HmRjl_eazikLH1_wQZHAeWOrYFf_0saq44E45Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:QQejXlKJKfHyVWLoXe0BiWCvtzULfFDexVkO33INPfrDtmLD87DjmQ>
    <xmx:QQejXipAbnVDPpFD3g_T6maq7qm_Ppa7PoOTKbpRbEXZUggFb6JOaw>
    <xmx:QQejXmWcZ1UKlGm638mQeDPwcmbEZe3KHtI_ags4XohAzWJ5b7mVZQ>
    <xmx:QQejXnP2-yKPln9oOg-rsLUYMRhXpa3ID7hRaHWlSIFWYLJV5SlgxdVr4MM>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 82F4E3065DA7;
        Fri, 24 Apr 2020 11:35:29 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH v2 05/91] clk: bcm: rpi: Allow the driver to be probed by DT
Date:   Fri, 24 Apr 2020 17:33:46 +0200
Message-Id: <0f5319caa4d1b9ba8a83a094abcb681d4be6eb1c.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
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
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 1654fd0eedc9..aedeaaf2f66b 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -255,15 +255,22 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
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
 	}
 
 	firmware = rpi_firmware_get(firmware_node);
-	of_node_put(firmware_node);
 	if (!firmware)
 		return -EPROBE_DEFER;
 
@@ -300,9 +307,16 @@ static int raspberrypi_clk_remove(struct platform_device *pdev)
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
