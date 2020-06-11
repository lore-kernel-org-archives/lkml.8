Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E784C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7438F20820
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="RSNUXe6Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uZhjdtJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgFKHdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:33:53 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39791 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726886AbgFKHcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:32:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 937E15800D2;
        Thu, 11 Jun 2020 03:32:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=6iQKMxJg9h0BJ
        TznOS0hTu6hgQnCXnqNYbjoQGsXtMs=; b=RSNUXe6Z5hXdoG7ozgDPevY4uUueH
        j9V7d2X95My7PRpXSAv148LoNCXmlVRubb/275JWi2109uPfwrU6NwzjZ/mLc1Ug
        7ve/LOsoohRIcQzD1bAH8DGOjQg+yYMRonl25HmQwO5vMJNuX+vJnXAQpW4+qZ0g
        5VM4iKL//Eec4yuXxLcc28PzJWgRBF+1guXEh0uuqKiWh00WmECOyeIz+C15Vyxd
        Sr+FY23gY0Sg79cS8XJY5cpi7tmAftftNibKRCmFg1Cpvf6ghEANGd9WriTKZOng
        yUvhalpJKH7+vlSTUbEm2h3rfUVDPO3QsY4oYdIiVB8Uo+EunTPWwMfDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=6iQKMxJg9h0BJTznOS0hTu6hgQnCXnqNYbjoQGsXtMs=; b=uZhjdtJ4
        rmXo0qfgXVaqM5YEH5qofXlyZZGCta6VJFWICi+ZkaUBrKU6+RbqTOoZunZFZyRz
        F4vEkpcbECZmzVZlejJ+JDi8lgPSWOenrc9phEV8Azon00nt/ZB3PfuxX/R0JoNG
        giilLlVyTr428OPc9tTGBReKg6rmSO/v+71fFrblCPWO3byglutRpqIVcN9Q2Stf
        z8agfX6b+MMZuvw+Obvsdlz162xR2ESs3uEWDPdBzQ0kj5uGcRTFtlW/GrwCZRMi
        tu5Wg4xHJy8hpZ4fMU6cDoshSQ8YWrvU3BCN+1+Fre6R0Bs267QJyd3tIxp23Gr5
        xsFRWLWUJQhYfQ==
X-ME-Sender: <xms:Ft7hXk84i5aLq4J0EklFQNznsrgiqHxKbBBeMndTWhaGgUKH-eyEVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeelne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Ft7hXssPqOBToQf_nZVZ2XqCTBb7muU-NSI-crUXMqqk57qZ0tAYOA>
    <xmx:Ft7hXqBzQzZP8YF-H9ZWYGYzkis1q1okzP4eUbQceOjDtbFw4BaqSQ>
    <xmx:Ft7hXkdn_VAud1tygQQNWGJhx9cajhPi5N0alqKBSZhvVpMtqFoaLw>
    <xmx:Ft7hXiiENurgw0kPfs-w1ZOGzRjue9gfrg9Q2LOz6O2v6DfGZ_LGZw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 32DDD3061856;
        Thu, 11 Jun 2020 03:32:38 -0400 (EDT)
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
Subject: [PATCH v4 11/27] clk: bcm: rpi: Make sure the clkdev lookup is removed
Date:   Thu, 11 Jun 2020 09:32:00 +0200
Message-Id: <8952eb653583c4c944a753837d2a5cdffe399667.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
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
