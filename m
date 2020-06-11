Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF92C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F6020812
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="f9N2HBKn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lwhQ8q58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgFKHc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:32:58 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:37557 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbgFKHcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:32:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 386535800D1;
        Thu, 11 Jun 2020 03:32:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=vOye5Ojf6Pz67
        EFbXOJLbRGjP3SfY7Wh3y7/T5vyRcE=; b=f9N2HBKnw9CcnFgQNC/xQ1WEFtI7N
        n+8B2H0zvWP1W0nWB2shcv6FWyAJLeSK+BzhX3hshT+WzSdoM/9phY6Vm34dms1r
        oYcTk/HsW08+lUG0Als9E9MNeRxWp81+tYv7JfdFr6DSoyvLpCxcd4HAIhs1Txnz
        iBoiV/VfEJr8cyQCNj8NOu3Pl3v7HH3wGlFwkoFfhTprYCu1c8AjBFwoX8EghW9V
        syNY1IS5LRG06sFvHNLetiX0hzX/SDCvtAYzETzsQxEhLEiLJR1RUrqzEzJuejtf
        zCmiSbejjCDxgKVDg6jZCMLDD+JTkqrbeGuFAikXfxViIdsFDCtOsu7vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=vOye5Ojf6Pz67EFbXOJLbRGjP3SfY7Wh3y7/T5vyRcE=; b=lwhQ8q58
        151Z1ryWaJwYuJ4vy4oSSyhuWxJ/RS5Zn5z2Qg2JLoUKreTFDTIf69k/A+MIJWEF
        z6T4GTLsf0as2OpfMg5fC3snBFxrgyKVQrEKBAaPCmrrPj6Ope8X+I60gQ8zeoz9
        41H9RVhR4ttQUMSgNOtPpuxVtxJ13AnaSUkFEJUP2LMtQvuZ4bOluSXgQqexCg+V
        0nggf+5cdti/jV4v1czleCPrvwo5F+dCEcJqdMQvsetnP+/mFP2xYInA3NcwpU5F
        f/LJfOzTicOcRMe5JxaS7rEPI9F9URyULxCwYEHyg5gyXYEFSZoqFgzPQKl0+6ce
        zMavTbrZPIMIoA==
X-ME-Sender: <xms:I97hXs1I7jopoRS7XKQvpjuq-TBaEbJZU_y09tJcAvr1MYGt8ilyMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeduie
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:I97hXnFJz1dUPaXd-iZmN0LZJw-CDMRqVyOxKUgii2Wy0qcmJFbpVg>
    <xmx:I97hXk4jykiTtl_6jFCQlinsLczl7y2_lhpxI8Y6snhxwLLK3g4YVQ>
    <xmx:I97hXl2IlA5M6WYBRbRRS7qCdCVAAvPJn1SraN7mFHDd3nTgNNLthw>
    <xmx:I97hXlZ7oIbHiR0s_cVFxUMLrmgvyVmSLRKlM1_ZRNOSMGxqCdUhww>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CC0003061856;
        Thu, 11 Jun 2020 03:32:50 -0400 (EDT)
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
Subject: [PATCH v4 19/27] clk: bcm: rpi: Add DT provider for the clocks
Date:   Thu, 11 Jun 2020 09:32:08 +0200
Message-Id: <e6e80151926f9d1dfa9b29971efa7dc816e32b4a.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the upcoming registration of the clocks provided by the firmware, make
sure it's exposed to the device tree providers.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index d2cb90c086a7..5f4e2d49432f 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -31,6 +31,8 @@
 
 #define A2W_PLL_FRAC_BITS		20
 
+#define NUM_FW_CLKS			16
+
 struct raspberrypi_clk {
 	struct device *dev;
 	struct rpi_firmware *firmware;
@@ -282,11 +284,13 @@ static struct clk_hw *raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 
 static int raspberrypi_clk_probe(struct platform_device *pdev)
 {
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *firmware_node;
 	struct device *dev = &pdev->dev;
 	struct rpi_firmware *firmware;
 	struct raspberrypi_clk *rpi;
 	struct clk_hw *hw;
+	int ret;
 
 	/*
 	 * We can be probed either through the an old-fashioned
@@ -316,6 +320,11 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	rpi->firmware = firmware;
 	platform_set_drvdata(pdev, rpi);
 
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, NUM_FW_CLKS),
+				GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
 	hw = raspberrypi_register_pllb(rpi);
 	if (IS_ERR(hw)) {
 		dev_err(dev, "Failed to initialize pllb, %ld\n", PTR_ERR(hw));
@@ -325,6 +334,13 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	hw = raspberrypi_register_pllb_arm(rpi);
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
+	clk_data->hws[RPI_FIRMWARE_ARM_CLK_ID] = hw;
+	clk_data->num = RPI_FIRMWARE_ARM_CLK_ID + 1;
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  clk_data);
+	if (ret)
+		return ret;
 
 	rpi->cpufreq = platform_device_register_data(dev, "raspberrypi-cpufreq",
 						     -1, NULL, 0);
-- 
git-series 0.9.1
