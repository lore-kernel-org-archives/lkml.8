Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09267C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9892053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Zw3eTI07";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d7SsIwvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgFOIms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:42:48 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:44021 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729207AbgFOIlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 12C6858014E;
        Mon, 15 Jun 2020 04:41:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Rr8VBcEhTzp8Z
        ny0soGodKkBo2/LmSW15ymF+jaUito=; b=Zw3eTI07RZmLQH0qKPCMZbG68ZPRW
        H8yIIiY3oGxS+RNeuq03aiMoCHaxfi7WQcXwVQHpDxXlmIAdwAytUEQmxeXp+DSP
        QYVPvjFhksheArWJduyt0lVpbtqmEb8g759XQEVVdoDSIk12+j69f3IYGFqaFzuy
        WaeNfHFpGblcVvnxFJAjuuQtej2NIzPnw7JSRooEdIKe0XEev2ARNPiuQEEKl40k
        AYfz8nGQ0zmIaHkKLynlyIDj0UFI/1wHOz3eKlyjclxbyULXsb7TRvJdHM0+FoGC
        gidEAVADZgDAtkKkJHrOkl1n0z8FC62rFK1HOLbNp2LhODKvMK62CY2Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Rr8VBcEhTzp8Zny0soGodKkBo2/LmSW15ymF+jaUito=; b=d7SsIwvZ
        Y/pUvKwW5gPRtwgSVBv8+Gbz855DkLfdMRH16p8UlXCJtBTiYajcgc16MInftYGD
        QWXrsUsvf7rCzEHnzedfA7rVs42DWx7oyxSCLjCx5ddWVbAIZffWAkkqpIbIaU2t
        s4klvWid4vR0asAAz9KRH9LUPOwp0mX9e3NMTdFo89X+0Ymt8ex2h8hkW7JihvMU
        n16FNIL6TKOhPyh5kpAP1ABBrwJdQunQvKFexiu+GTfKVScYevoXGdF4ntKtat3T
        ZvmsgthQ6khOLuxd6lt+FU49xjrWPsA48H1zqK/vkpIpKxhewyCdSy0mw+jaZiN4
        jqyZPupkHIuOVw==
X-ME-Sender: <xms:QTTnXsYNKu_tySkIlgwc4fFicfJK8sL18j3VaQaTHrzN2YMSuYJNMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepieenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:QTTnXnbdxUtoi9JvwfRVRctbFkyjssNIk0YsjHCqLXQ6zbKOQz734g>
    <xmx:QTTnXm-nX3xLePweSek9aaAa4Q1BAL7kjJn3qWY-eqeTXswfk4L00g>
    <xmx:QTTnXmpwX8bhYQh6XLJpwN2CnhnX5S9zjDjIu6h_BMldoh7d2OOIyA>
    <xmx:QjTnXq1_Oeq9hp-KC2LHkiiSm9qg7gFi1k-4Z-KyOLHL6h0Q1EyTcA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A04EA30614FA;
        Mon, 15 Jun 2020 04:41:37 -0400 (EDT)
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
Subject: [PATCH v5 11/27] clk: bcm: rpi: Make sure the clkdev lookup is removed
Date:   Mon, 15 Jun 2020 10:40:51 +0200
Message-Id: <075e2c6d315eccdaf8fb72b320712b86e6c25b22.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clkdev lookup created for the cpufreq device is never removed if
there's an issue later in probe or at module removal time.

Let's convert to the managed variant of the clk_hw_register_clkdev function
to make sure it happens.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 23f06618a356..a20492fade6a 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -245,8 +245,9 @@ static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 		return ret;
 	}
 
-	ret = clk_hw_register_clkdev(&raspberrypi_clk_pllb_arm.hw,
-				     NULL, "cpu0");
+	ret = devm_clk_hw_register_clkdev(rpi->dev,
+					  &raspberrypi_clk_pllb_arm.hw,
+					  NULL, "cpu0");
 	if (ret) {
 		dev_err(rpi->dev, "Failed to initialize clkdev\n");
 		return ret;
-- 
git-series 0.9.1
