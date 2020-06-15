Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89E5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A952053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="n8GQBvOu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IvNsKML1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgFOIm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:42:58 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:36943 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728593AbgFOIlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A9CDC58014E;
        Mon, 15 Jun 2020 04:41:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=1e0hxPRXwPN7k
        08vGz5wQeV3+xRS5ugH2XUL6sEmXkk=; b=n8GQBvOu4WPsKj8OrLpeFIN8MG3Ab
        JQfvQs9dm++stBuh/ZeSoExBraOIhB8rNkMRVdV0XCtL4/7mQJkoRkaQeLQ3OPjk
        cm+WKXjd4MI7UXUO+envbUKMmPGZDSjOqM2BBr6U50lNq8gM9TpqTm6l/MytyF4k
        +W7mV4qnU9MfDTnR9zs0HC8don7nQo3X9OhJwhHz1Opold0cZYYrFvKtmyoctOzS
        c4jXx327s+/iX6canS3hcseuYCfqblSIGaUYMzDKfXtGWti7kcgTszny9p5HQMlK
        tHGh9veWmGSKgbuIODHxO1m5xfMqDWOOhAHeMTLx42rHHqnz0M2afHqnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=1e0hxPRXwPN7k08vGz5wQeV3+xRS5ugH2XUL6sEmXkk=; b=IvNsKML1
        kdAYmxvegtpRIbQVbDf9llZSHMGKXSVtrdgGmyXbHjZCaFyHeSFY22LnE3+bNZoC
        Fnhu/3+r6f3qeu8uHGX+0CCrT/xpBwYO8fZKu9ZJCtUHWIVBaWh30pwAVp17vgRG
        f/YfeYe45O59o5XgH+SHqSwotWPk0YV9yGE2h5dUyJN7+D0M+XrrCd/XA7Nslyv4
        sFQtm9HGsY0Y7xH759DTDoOHfa0BwlvUuyyhnhiel9aMoxrRALLm0gcxISgpGD6X
        NdyH99+xiON83Wfc501EdQ2HjRRk6XeMN8P0bSJZzT6AAKgKM3VLKrT9dH1w9gE9
        7fAvdOdzXnIy/g==
X-ME-Sender: <xms:OzTnXsGKuzuYYGaZruRTjmtUeSbY8mb2KuIXovH_wKr9UKYyCWSP5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:OzTnXlWWZX1GsKrn0Ftt7i2BsSS2FM8FL3GjUe0rBM-P7svGNaNdUw>
    <xmx:OzTnXmK4De3i0RH0pR_TD0mju0Kj29BSs82uwNtDkOJdaEMEJbwNvA>
    <xmx:OzTnXuH5un09FQD9xm70VEgjkSIz3yaWpY_qzWjFQNhwZtGSD45JLA>
    <xmx:OzTnXuRUdhkaXQcEyM4cXVpHKw2GNO7Z23aYaJsxg46dx2zkrUn_eg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4439D30618B7;
        Mon, 15 Jun 2020 04:41:31 -0400 (EDT)
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
Subject: [PATCH v5 07/27] clk: bcm: rpi: Remove global pllb_arm clock pointer
Date:   Mon, 15 Jun 2020 10:40:47 +0200
Message-Id: <842859cf1a77478620f45049178a588448202858.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pllb_arm clk_hw pointer in the raspberry_clk structure isn't used
anywhere but in the raspberrypi_register_pllb_arm.

Let's remove it, this will make our lives easier in future patches.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 5f0d4875e145..b21dd6ddc4fe 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -40,7 +40,6 @@ struct raspberrypi_clk {
 	unsigned long max_rate;
 
 	struct clk_hw pllb;
-	struct clk_hw *pllb_arm;
 	struct clk_lookup *pllb_arm_lookup;
 };
 
@@ -246,12 +245,12 @@ static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 		dev_err(rpi->dev, "Failed to initialize pllb_arm\n");
 		return ret;
 	}
-	rpi->pllb_arm = &raspberrypi_clk_pllb_arm.hw;
 
-	rpi->pllb_arm_lookup = clkdev_hw_create(rpi->pllb_arm, NULL, "cpu0");
+	rpi->pllb_arm_lookup = clkdev_hw_create(&raspberrypi_clk_pllb_arm.hw,
+						NULL, "cpu0");
 	if (!rpi->pllb_arm_lookup) {
 		dev_err(rpi->dev, "Failed to initialize pllb_arm_lookup\n");
-		clk_hw_unregister_fixed_factor(rpi->pllb_arm);
+		clk_hw_unregister_fixed_factor(&raspberrypi_clk_pllb_arm.hw);
 		return -ENOMEM;
 	}
 
-- 
git-series 0.9.1
