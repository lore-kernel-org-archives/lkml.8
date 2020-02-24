Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19283C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E146F20675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="wQpjPS5o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PxWPwJK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgBXJJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:09:04 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:53175 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727310AbgBXJJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:02 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 639685B1;
        Mon, 24 Feb 2020 04:09:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ni0eeiruakD5t
        A6ey6vkWb0zJTB9V0JwtVa8ytpvb+8=; b=wQpjPS5o64bYXMBU6+EE9Op3/YeIc
        tfo5TtyHY5bq33iZ2YyGFRxz/x8v2X+o8hN7/1I5kuq5oKS5fCkdnYshXVk4DIEH
        Kghhj3Of8Xz7dA5053bJeRsxZhBgzmCivW9g3mwDdbDK10fnLphUIjQzOF0TQhCr
        f1GA5XoJ07fqsWYWcLCNngtkTWi/tGORSqmedAF1hQc+pqvk9ZfE5TL3NmdU/klO
        uNFjo7XpA9KxbOQu+uVYvYiz1uyavriatnja6zTGqw4wt5CGY1eFnRNz5BLoTzzC
        nZLkmSsF3lijIwMmtRrgWmguamGFPrgi2491/T7pQVR+qylKAESFE+Q+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ni0eeiruakD5tA6ey6vkWb0zJTB9V0JwtVa8ytpvb+8=; b=PxWPwJK+
        MTU4ejMmDMqCFiwlZ77+637otX7fMeMhvU4B2C1bJqWU1ABnbczcriaK6KLIfKZF
        jCsHAXSHaUxY0v0dDL8lXdHKVrb9jVK0as9aVN7HfQ3f821XB5U/mC/J/bmb3P+q
        ngzwUdVjyfWmnex3yMGINFIZL5bHBz8tcQ2vA42z332fCp8C4JWw7pF/o++AUl25
        wwKFAPpvuwqhGcmabMaGrGCYNo04PopeKvbZ4Sj+oTMeQW0W9TmLZViZT9x2r1WN
        7aN1zKft+nhjxsL+/nIHgPyqpHwapVMkdGOmI6QtV3ysQMvokm/7G6O3nZqvGldz
        T0jECWYME63pgw==
X-ME-Sender: <xms:q5JTXt0LUFBIad3MUSS6MtwegnkaC4w5NZ8p3Wtnxg-3iZb0zeeWig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:q5JTXqE6DYsvU0c4eNeVbq8QhODz5T1vUinOqGc3qO8gtuRJFUs5CQ>
    <xmx:q5JTXriSA_Z13-Vw0AA2xhyCUaYr63VhB95jOt4D8hQwxWdzVwLGZw>
    <xmx:q5JTXl8R0e57tHLyrwDm5NmOFxdHxd5Ffe5d8ASqLPUTBJcLWvZAFw>
    <xmx:rJJTXmY6wL-HO1X-tlUSg_fY54nSsAJs1ddHxEIapVojfToLcxJvkn2Fijw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9ECE73060F9B;
        Mon, 24 Feb 2020 04:08:59 -0500 (EST)
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
Subject: [PATCH 07/89] clk: bcm: rpi: Allow the driver to be probed by DT
Date:   Mon, 24 Feb 2020 10:06:09 +0100
Message-Id: <c358081207dcf4f320a6b7e2932f0d5365bf3242.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
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
 drivers/clk/bcm/clk-raspberrypi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 1654fd0eedc9..94870234824c 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -255,15 +255,13 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	struct raspberrypi_clk *rpi;
 	int ret;
 
-	firmware_node = of_find_compatible_node(NULL, NULL,
-					"raspberrypi,bcm2835-firmware");
+	firmware_node = of_parse_phandle(dev->of_node, "raspberrypi,firmware", 0);
 	if (!firmware_node) {
 		dev_err(dev, "Missing firmware node\n");
 		return -ENOENT;
 	}
 
 	firmware = rpi_firmware_get(firmware_node);
-	of_node_put(firmware_node);
 	if (!firmware)
 		return -EPROBE_DEFER;
 
@@ -300,9 +298,16 @@ static int raspberrypi_clk_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id raspberrypi_clk_match[] = {
+        { .compatible = "raspberrypi,firmware-clocks" },
+        { },
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
