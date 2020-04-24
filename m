Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3234C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB36C20700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="wLAisAiy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pOPZ0yzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgDXPkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:40:51 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:41123 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728286AbgDXPfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:35:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 6BD4CFE1;
        Fri, 24 Apr 2020 11:35:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=T8s1l/eHXLqjb
        GsnVx39DFYxMbKPbICndFwvcL7Ds6w=; b=wLAisAiyYbfQvTkXuEAjdrG9KRY3n
        Dx1T0/bwFiTD5syqI21YR3uM17XYdJMNsxVnR71QYAc2Twn8VJ4vZJFRBpTT145Y
        qzOKYXKxYHTF1whDoyM0XKTLUQE3aqexzRJymxlPuyECyPlXWoKfht89TWQA5Vo2
        bm9ZDtUQ8fQ7r2ns2RfGfSlEzdWu8j/2UyhfPygoeFShV8t1K9aGQrmu+EjOFZE6
        gcs8KimMxl6aGF7u0kLDl/MO8j2BHTKIBc7qsBYM7L4gT0x4pLwzG7fuXtPHFeC9
        8DPj7dP5Ijm8YoUXM60vb3fEs+/fmHiN8HiBfF9n/+xIM1oVojj0d9CUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=T8s1l/eHXLqjbGsnVx39DFYxMbKPbICndFwvcL7Ds6w=; b=pOPZ0yzo
        24J+JQgsmWbxS0MVBJP4wG+RjLvju3QGR/XGGvO/D2qOCyLiPIUR21xAqVL2i8zJ
        MaMXrW2txyNdTgtVoJd6+l/pV0uYrUo25x+mrITDf5ldoNsnLNIiKVto3ejXpwPb
        AagXjCYYsEg8ZanUpIPXoMT5BdxGN9IJGzy35EmGgzs3zNnJDuujr7n39wqx+eyM
        IB3Neozp8hamoJ/dZQkFbr+zW3LsI3hJpeFZ3Rl43UZzc2PH1q+VoKmUhxe7b43o
        tW4lz49746NstfSyBz12Mg99tRYSn5X/3VoNuXSrYRds4CBXZtS5kbGRL8UsjEXU
        85dYT35bH27oKg==
X-ME-Sender: <xms:UwejXiDRznlAFI0n_NqNDzexDZqheNszetQYxag71Nk_0z5IM0_58Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeduheenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:UwejXrBS3FV99XBQPVUUTXzmC_2ql3cE1yQy8du3JunjqxsEc1UAnA>
    <xmx:UwejXhGUd_mhZryW0thiV8YDt5DFfn3W76APEq-FVdrqxxuI5gqksQ>
    <xmx:UwejXq7kGMfoBdeZ-E6ZLyjokydUA1JEKIlBA4wut6rjN4lUidfSMg>
    <xmx:VAejXvM4Zu5RzdfeQu5Yl3cnbX7fIsvSzp_l_fsxmW8CaaeSwMNZ_by93aE>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 91E9F3280067;
        Fri, 24 Apr 2020 11:35:47 -0400 (EDT)
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
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 18/91] clk: bcm: rpi: Make the PLLB registration function return a clk_hw
Date:   Fri, 24 Apr 2020 17:33:59 +0200
Message-Id: <853ce991ff4dc9c8991091bff4ec6670bf14f583.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The raspberrypi_register_pllb has been returning an integer so far to
notify whether the functions has exited successfully or not.

However, the OF provider functions in the clock framework require access to
the clk_hw structure so that we can expose those clocks to device tree
consumers.

Since we'll want that for the future clocks, let's return a clk_hw pointer
instead of the return code.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 40 +++++++++++++++++---------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 8c88d2ea1d67..677d7f3e8d2e 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -190,7 +190,7 @@ static const struct clk_ops raspberrypi_firmware_pll_clk_ops = {
 	.determine_rate = raspberrypi_pll_determine_rate,
 };
 
-static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
+static struct clk_hw *raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 {
 	struct raspberrypi_clk_data *data;
 	struct clk_init_data init = {};
@@ -199,7 +199,7 @@ static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 
 	data = devm_kzalloc(rpi->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	data->rpi = rpi;
 	data->id = RPI_FIRMWARE_ARM_CLK_ID;
 
@@ -217,7 +217,7 @@ static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 	if (ret) {
 		dev_err(rpi->dev, "Failed to get %s min freq: %d\n",
 			init.name, ret);
-		return ret;
+		return ERR_PTR(ret);
 	}
 
 	ret = raspberrypi_clock_property(rpi->firmware, data,
@@ -226,13 +226,13 @@ static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 	if (ret) {
 		dev_err(rpi->dev, "Failed to get %s max freq: %d\n",
 			init.name, ret);
-		return ret;
+		return ERR_PTR(ret);
 	}
 
 	if (!min_rate || !max_rate) {
 		dev_err(rpi->dev, "Unexpected frequency range: min %u, max %u\n",
 			min_rate, max_rate);
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	dev_info(rpi->dev, "CPU frequency range: min %u, max %u\n",
@@ -243,7 +243,11 @@ static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 
 	data->hw.init = &init;
 
-	return devm_clk_hw_register(rpi->dev, &data->hw);
+	ret = devm_clk_hw_register(rpi->dev, &data->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &data->hw;
 }
 
 static struct clk_fixed_factor raspberrypi_clk_pllb_arm = {
@@ -258,14 +262,14 @@ static struct clk_fixed_factor raspberrypi_clk_pllb_arm = {
 	},
 };
 
-static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
+static struct clk_hw *raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 {
 	int ret;
 
 	ret = devm_clk_hw_register(rpi->dev, &raspberrypi_clk_pllb_arm.hw);
 	if (ret) {
 		dev_err(rpi->dev, "Failed to initialize pllb_arm\n");
-		return ret;
+		return ERR_PTR(ret);
 	}
 
 	ret = devm_clk_hw_register_clkdev(rpi->dev,
@@ -273,10 +277,10 @@ static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 					  NULL, "cpu0");
 	if (ret) {
 		dev_err(rpi->dev, "Failed to initialize clkdev\n");
-		return ret;
+		return ERR_PTR(ret);
 	}
 
-	return 0;
+	return &raspberrypi_clk_pllb_arm.hw;
 }
 
 static int raspberrypi_clk_probe(struct platform_device *pdev)
@@ -285,7 +289,7 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rpi_firmware *firmware;
 	struct raspberrypi_clk *rpi;
-	int ret;
+	struct clk_hw *hw;
 
 	/*
 	 * We can be probed either through the an old-fashioned
@@ -314,15 +318,15 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	rpi->firmware = firmware;
 	platform_set_drvdata(pdev, rpi);
 
-	ret = raspberrypi_register_pllb(rpi);
-	if (ret) {
-		dev_err(dev, "Failed to initialize pllb, %d\n", ret);
-		return ret;
+	hw = raspberrypi_register_pllb(rpi);
+	if (IS_ERR(hw)) {
+		dev_err(dev, "Failed to initialize pllb, %ld\n", PTR_ERR(hw));
+		return PTR_ERR(hw);
 	}
 
-	ret = raspberrypi_register_pllb_arm(rpi);
-	if (ret)
-		return ret;
+	hw = raspberrypi_register_pllb_arm(rpi);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
 
 	rpi->cpufreq = platform_device_register_data(dev, "raspberrypi-cpufreq",
 						     -1, NULL, 0);
-- 
git-series 0.9.1
