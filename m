Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C92C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC0E20678
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599060938;
	bh=rzLiuiSlLOuxKErOauqJfTN+XyIehXm1NzPwskDBWjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dB3xIp/Dakuvsy9Qs3MZQfNQiSzV+G7Y51xzQMfNr+ryi/qYZv+GmwTeitEElWUpz
	 K0FErEXi9ZwlQKj0c14/cLyTeZoxuIhDmih/ibmZ61WM3ZT9K452oS0g/jSB54IFJM
	 LiQtjzhWEKp5AKbMfaN18MGA9WMHtnOKNTXiOxfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgIBPfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:35:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgIBPEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:04:45 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4671020C56;
        Wed,  2 Sep 2020 15:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599059084;
        bh=rzLiuiSlLOuxKErOauqJfTN+XyIehXm1NzPwskDBWjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ykwWEDs6yPvxy55dDnB8JEZyplbILRaN2+rvpu6MelQ/wDaWk6oO042IwEwvSErY6
         4p91tNKEDaIDfkyuLKdXZiUDF8M52k7J+oJAuJFPqmrjSx5/HmVtNFqW0BDx8UfTVy
         ySSis45XicQVLxXRyy+uVFZpRpr4xhi69Y5/7s1o=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 10/10] clk: davinci: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 17:03:48 +0200
Message-Id: <20200902150348.14465-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902150348.14465-1-krzk@kernel.org>
References: <20200902150348.14465-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/davinci/da8xx-cfgchip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
index 77d18276bfe8..4103d605e804 100644
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -510,8 +510,7 @@ da8xx_cfgchip_register_usb0_clk48(struct device *dev,
 
 	fck_clk = devm_clk_get(dev, "fck");
 	if (IS_ERR(fck_clk)) {
-		if (PTR_ERR(fck_clk) != -EPROBE_DEFER)
-			dev_err(dev, "Missing fck clock\n");
+		dev_err_probe(dev, PTR_ERR(fck_clk), "Missing fck clock\n");
 		return ERR_CAST(fck_clk);
 	}
 
-- 
2.17.1

