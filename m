Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88649C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614B92075F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="gLIrHnyi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BaV5yz9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgFKHcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:32:31 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:36445 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726771AbgFKHc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:32:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id F240C5800D5;
        Thu, 11 Jun 2020 03:32:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=rnYATPXjkjOEO
        6HerwImW1bSp3HthGMZl9MTQlU3s0s=; b=gLIrHnyiFvxPtFk/9wIT1PwF9GFv1
        wKejZgl0OCReQT/oPde3YzbxUviQRB81U3gI4z5yabN6N4fmzMVdJh7kIqiA8hN5
        DhJ1qtTCCWF8qwWVutK3zaHRkBwmDI7QBPxfNRYN8C0CSgOXetqQzQ3KPNyQEhTq
        A2oM1Gvanb7oyXh2eYPchPWHnnYsYO+uZAefJLHKemP2BToBJgkE379tzIs/N0DC
        i9mOfhEvEpiI05p8Tf0GBpqTTWXbMIryo3XClwCZru67NFBNVe11pOuzeGXkZqeT
        zub8vIxL35615SUTqooKI/YxlAUQv8u5o8cBqJ8vShfaxl3f1XQjrKj9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=rnYATPXjkjOEO6HerwImW1bSp3HthGMZl9MTQlU3s0s=; b=BaV5yz9a
        heSagLExOhjzz5i/OKOfGuRnsB9sKnN0d2CicGdg8DMZ2vpb097UHvmrTxYY0fOz
        RSSoX9V29J+B9oVyNCp0xxQSXawZJWrLfQaJT2Sl2eqZsu6aD11ziJPHB8eVkLZz
        wWJpCb0rog/gGvx+xkXLLWv4OZ19u5cX3l9O/I/0atTMD6KfV9hxXfBPPGT6Cf3o
        KbOz0QNwEPu9rrsf8SI4zGQOFwiKE7AjGGxS/wwlkTh88r59fj7+jYFNtXNlMqdA
        +Z0AejVR6Fx/IR95g1DDo3ttnu6BXtadk1qyfbTUwIvwNOOnr5KRgS6Ou99s+Ezo
        05NtwPFuNFUN1A==
X-ME-Sender: <xms:Cd7hXvqhAzr0AvUhQRAYvXot-i2ptb_R2K059mcPSIniGFrcybibWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Cd7hXpqvgF0Db7_95NZOGgCjOdyI0Zm9vbkR5YJQEAZQxKbrDKqLkA>
    <xmx:Cd7hXsN459KAtwxdHfnh7uly3vJfe1mu5OZaGHNgtJZCGDGkC1KFQQ>
    <xmx:Cd7hXi4JtXXiaLnLi-bpv-ElqiK5HvEV4Yqnt_S1-6_k-P_CPO2OYQ>
    <xmx:Cd7hXgsYwmvSv5JcpH_Cx_R0U8fRO_i37Dtq6Ith3vXtPlIp9HhQBw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F2D23061CB6;
        Thu, 11 Jun 2020 03:32:25 -0400 (EDT)
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
Subject: [PATCH v4 03/27] firmware: rpi: Only create clocks device if we don't have a node for it
Date:   Thu, 11 Jun 2020 09:31:52 +0200
Message-Id: <c853e53cdf1f98a3e63741f5bdb0631dbba3031e.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware clocks driver was previously probed through a platform_device
created by the firmware driver.

Since we will now have a node for that clocks driver, we need to create the
device only in the case where there's no node for it already.

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/firmware/raspberrypi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index ef8098856a47..b25901a77c09 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -208,6 +208,20 @@ rpi_register_hwmon_driver(struct device *dev, struct rpi_firmware *fw)
 
 static void rpi_register_clk_driver(struct device *dev)
 {
+	struct device_node *firmware;
+
+	/*
+	 * Earlier DTs don't have a node for the firmware clocks but
+	 * rely on us creating a platform device by hand. If we do
+	 * have a node for the firmware clocks, just bail out here.
+	 */
+	firmware = of_get_compatible_child(dev->of_node,
+					   "raspberrypi,firmware-clocks");
+	if (firmware) {
+		of_node_put(firmware);
+		return;
+	}
+
 	rpi_clk = platform_device_register_data(dev, "raspberrypi-clk",
 						-1, NULL, 0);
 }
-- 
git-series 0.9.1
