Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28CBC55196
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9219B20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="b+A9+Ta3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="inpOSl1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgDXPlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:41:11 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:35651 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728085AbgDXPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:35:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 36C75FE1;
        Fri, 24 Apr 2020 11:35:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=JZTQ85nIfmA4C
        atYLZcz0wDEhV7DtHJBMQeC7q6JGEQ=; b=b+A9+Ta34bOdVVK55zfWoWRdJTaq1
        m/SbIWYB2eqfnF8KXOb7GLQsVxuO70j+W51ItxxxiSx02L/6H+e1eSsrlwfQuApw
        qkrmhzOESLTcF38a47b1xYtcRJ8SNO4195LUugyDu97YfW8c+R699gHelAaxKC1i
        LC+XE8RwQiwMMvJjipESxdelz6p5dKkD45qh+eSDK8ucIeZ5j8QipNc6+iWJHs1a
        I73xeTa2YCFHvGgcdEHLlshdZFcaPieoGEKxFQNuPrxBrPX6Ggstt0xMDApI11c3
        Uir/VDbvvfoDNNATKkErUe5H0X2buxofHrpAsHh1Ebl7PbPZrOT1vZhjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=JZTQ85nIfmA4CatYLZcz0wDEhV7DtHJBMQeC7q6JGEQ=; b=inpOSl1K
        VnmH2JKMRMOH+/m+L59M+a1OEi4dFL0Ruyj+za79POl8SdIg5UDCvaYZK8TUcvk4
        o8YQ5v04QDwWAVhlQowXjJgcrsfIcEkqqAsZc61OlEH2GiYabxu66kCxyachMe9K
        X8sPccjD9w0TPPj/nzyz/cDzcMk5D4X1G6bGpAV4wJyXus5eIDOnNnyQFOirHjsj
        HKZzWdRWUwDwJ+lDD8CBDcZxioM1WDA4RsOU+QTluxUD1QCL12JnFTb5dlA3/bYD
        NLuZKBfVWW3b7kU8mco53WxIBmS2yyR6GVzLgnewX9GC/nxGQl3NWAnLzV9pAYz/
        awtFa4WoYG69xw==
X-ME-Sender: <xms:SAejXh0eJ86Y1TVfl01drA8F4Bf6YdcYGvbhX7CtvaRgC5JDSGB53Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:SAejXizVU6lup__ARNgeFrzUxPgjVNCJy5JL8LdEVOIX3xadPSPP6w>
    <xmx:SAejXl7OkbjTmcaJEjuQkJ8162gJIQb8hLpkV2ZDtdYhhvVtGUjuIQ>
    <xmx:SAejXvidwZQO77kgCRshagR0-BPe04g202rx20hu8QokwLJl69IaCQ>
    <xmx:SAejXgUMKT4xKtSQirWacWhfqekJI4o8pJLamOnhiPiaCXZc_80uKJ2H-74>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6795B328005E;
        Fri, 24 Apr 2020 11:35:36 -0400 (EDT)
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
Subject: [PATCH v2 10/91] clk: bcm: rpi: Remove pllb_arm_lookup global pointer
Date:   Fri, 24 Apr 2020 17:33:51 +0200
Message-Id: <7f02e508b0772d155c76bffdaa955cfae8041d18.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pllb_arm_lookup pointer in the struct raspberrypi_clk is not used for
anything but to store the returned pointer to clkdev_hw_create, and is not
used anywhere else in the driver.

Let's remove that global pointer from the structure.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 859eac020122..5bed35483e71 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -40,7 +40,6 @@ struct raspberrypi_clk {
 	unsigned long max_rate;
 
 	struct clk_hw pllb;
-	struct clk_lookup *pllb_arm_lookup;
 };
 
 /*
@@ -238,6 +237,7 @@ static struct clk_fixed_factor raspberrypi_clk_pllb_arm = {
 
 static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 {
+	struct clk_lookup *pllb_arm_lookup;
 	int ret;
 
 	ret = devm_clk_hw_register(rpi->dev, &raspberrypi_clk_pllb_arm.hw);
@@ -246,9 +246,9 @@ static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 		return ret;
 	}
 
-	rpi->pllb_arm_lookup = clkdev_hw_create(&raspberrypi_clk_pllb_arm.hw,
-						NULL, "cpu0");
-	if (!rpi->pllb_arm_lookup) {
+	pllb_arm_lookup = clkdev_hw_create(&raspberrypi_clk_pllb_arm.hw,
+					   NULL, "cpu0");
+	if (!pllb_arm_lookup) {
 		dev_err(rpi->dev, "Failed to initialize pllb_arm_lookup\n");
 		return -ENOMEM;
 	}
-- 
git-series 0.9.1
