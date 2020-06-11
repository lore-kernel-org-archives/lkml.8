Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16626C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6CF22083B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="nUFoXCqq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5dccl1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFKHd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:33:56 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42855 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726862AbgFKHci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:32:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0C9D15800D3;
        Thu, 11 Jun 2020 03:32:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=n0QSF+s7WNrvA
        CQUMag7Hrl5LkSGFMi3zaAhmTrJUaw=; b=nUFoXCqqR1D6lTHhAjTSN+tV0z+o0
        TpFsQ3bTKQbI1hcxSCFW52AISuTQMLk9X1er8DiK3V6jxF5GANA+2KhxjatsrQMn
        dzrUuUvnRRnvbQF8utpo/RYR4tnv/0EQNt/TbIguwShF9jR1eMpU9uJMivsYw4Kr
        e8ndDN8PmC6I5rb22MvWGlZh0Vm1F4JpA4eW6sp0FruQ+tNoO2TxsD/5zq5jt1YS
        nLGM7y2C1tG3DAv87T8xby9remxlqRPjJsv2cqdQDmH1Ne96PZ5Beg+rallN/BWX
        HHzJao4e5WyMsDMgPGoSgEYm3EbgeWG/d2sLNENaB5GumGOeXfdXUktnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=n0QSF+s7WNrvACQUMag7Hrl5LkSGFMi3zaAhmTrJUaw=; b=W5dccl1G
        e2xxNKAcFMQPHlthSWc0nx7a3+MsqVeiR1EDXbxOG1ABvzdOBR+TVmvaSuwW+/yj
        0lVgGyQY4SdOtai5iQZJoV8v8Y5wdIjrR9C2vwuZy+qRPIbvVKZ13uXm/EJySa2h
        UIMvMe0nGSUr8Ra9edqw0F8dm0Ex9PCaKHjwkGmEVlPPceC9AkTlkqIG8joBm0g+
        ZdXdhZHy67lw+MsCaCnwh2EvNm3F//oqItjWz6am9gE6nhJmIRkrWIa0KOo1kZZo
        JLlJQmb/Leu1Ts/FiHgbwaKtsYgUrO2MVM8XBKyaW9/RhGlGhdH5eEBTapNdcEvj
        kPs7svunQl3J8w==
X-ME-Sender: <xms:FN7hXpSJ7enCUXb73YMN9X7Cgo49piUs3Ds_C2qm8BAbBMAf0QaH3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeehne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:FN7hXiyoJHj8pAr_xFq5_EIc-fM8gFRPDWftU-TyxJQUle_tNqsPcw>
    <xmx:FN7hXu16oz4QpvwIW5dc0Icb9dNizhCPpciYmb9fKWcpbtv4eaFoyQ>
    <xmx:FN7hXhCxa6lcNq6NNL-P0-w1uK7jnBrUpR172WWdLNNtucD3zBhaaA>
    <xmx:Fd7hXrX4ivkbo0pgAt5JTQAN-rhr8ER-51dzn3U52rpEjszufM66FQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 992FB3280059;
        Thu, 11 Jun 2020 03:32:36 -0400 (EDT)
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
Subject: [PATCH v4 10/27] clk: bcm: rpi: Switch to clk_hw_register_clkdev
Date:   Thu, 11 Jun 2020 09:31:59 +0200
Message-Id: <d575374b56fb53c70bc9dbacb290d44a716f7474.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
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
index 5a06c4991c7f..23f06618a356 100644
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
