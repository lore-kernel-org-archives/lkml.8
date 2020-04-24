Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE74BC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E74621473
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Vi+dzVeC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zc0IpeHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgDXPfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:35:45 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:39831 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728119AbgDXPfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:35:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 91E6F136B;
        Fri, 24 Apr 2020 11:35:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=CjNIxcvjbVsXB
        3BBQ3hl6U/fLM7FzBRPy0/KIGvl8dU=; b=Vi+dzVeCDLokp5nihEH6JVtgewSVK
        b4nPdkvaxiPVZcyVJEJkUWHeijb56kQiBzY5JuiMUn3823XHQUl4NTh22qGk5vBI
        onZ8WIMD5JI7HB90F2tJRoPEyN8RKGm+TNNzmdB0agxRNitaOkdvXL/BTwpNngDr
        v7E7gisxjfaOOeKwh4OH9JRWgEIuK0FJS8LKsHfnrY5OldCQ0q6w8zsVTqfcgW8H
        bbKzbd3iqRY7VJKbJMUef2fijwJVuPYSk4KIV/5Bf08XaKUT34kFELF8FlQceMJK
        WM8f5gTNCTrp9lMuCWJPnrItrCYRGCofDKGYt1P0uC/tscZ+lzlkR6AsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=CjNIxcvjbVsXB3BBQ3hl6U/fLM7FzBRPy0/KIGvl8dU=; b=Zc0IpeHy
        ZgXCtDJC8FiRmBMQ369smf5Ai8/WKg4JGHqBmP2e8KB+k6T9KOCS9XuF2MOxPmgA
        ONejYEkR5BKofASLnBvmBT7tu0IoUJPEiHCG5OHYc8vmfX03YjOtGbSOgqzJlokA
        LkW+uKZ6f769aZt2VpqtbBKCp6zs7AvCvJwybw2Ktgf2fCuRiX8+B6TO/ON/Tr6S
        7DjVUUioG3BuKkgIHnPQKhPGzVbGpFB0dTcKzsvVk6u2kApaR3PWbL6vzyYSED2l
        rK8DGwW8+ogTvfwQZA70eJdV9SVau7Bk7L2Hgle0/GHjyhjlWuhef2GJTL0MQrZT
        uw5664RzhpTQbg==
X-ME-Sender: <xms:SgejXh9SCS2PWHIbMlOlxA5CC9c9Sb3wrVTKdYTlAOH94jOfrTZ9XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:SgejXqrHlWsW2WenkxoLrbhudLx9X0yTrTWnBolInf_egZvSWaLBPw>
    <xmx:SgejXpwC2uE7lsm0QHIh9cvEtKFyvb9_0jBZ2l0tZ33KbxpDTR6hYw>
    <xmx:SgejXgIKQWIbA1OMh7FLLKWPhwocdchrBTvblNMIU3viLZ-_x81z8g>
    <xmx:SgejXrMqqh5h_n4NjlJ6ZFTPMIeLPffWGZEvQr3oOK3TX11JJlI6C-sXfZw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CE2DC3065DA8;
        Fri, 24 Apr 2020 11:35:37 -0400 (EDT)
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
Subject: [PATCH v2 11/91] clk: bcm: rpi: Switch to clk_hw_register_clkdev
Date:   Fri, 24 Apr 2020 17:33:52 +0200
Message-Id: <ed3ef94ed15ab5426d269615dac4e670b877ded2.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we don't care about retrieving the clk_lookup structure pointer
returned by clkdev_hw_create, we can just use the clk_hw_register_clkdev
function.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 5bed35483e71..013706816895 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -237,7 +237,6 @@ static struct clk_fixed_factor raspberrypi_clk_pllb_arm = {
 
 static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 {
-	struct clk_lookup *pllb_arm_lookup;
 	int ret;
 
 	ret = devm_clk_hw_register(rpi->dev, &raspberrypi_clk_pllb_arm.hw);
@@ -246,11 +245,11 @@ static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 		return ret;
 	}
 
-	pllb_arm_lookup = clkdev_hw_create(&raspberrypi_clk_pllb_arm.hw,
-					   NULL, "cpu0");
-	if (!pllb_arm_lookup) {
-		dev_err(rpi->dev, "Failed to initialize pllb_arm_lookup\n");
-		return -ENOMEM;
+	ret = clk_hw_register_clkdev(&raspberrypi_clk_pllb_arm.hw,
+				     NULL, "cpu0");
+	if (ret) {
+		dev_err(rpi->dev, "Failed to initialize clkdev\n");
+		return ret;
 	}
 
 	return 0;
-- 
git-series 0.9.1
