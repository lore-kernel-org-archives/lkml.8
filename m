Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52451C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F9B72067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="jF7zPkgc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u1Dv+9NV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgFOIme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:42:34 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:36647 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729242AbgFOIls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8934258014B;
        Mon, 15 Jun 2020 04:41:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=L85KBKmlPd+Sz
        BqnLOStPYQNJZvE0NaYsqZW2oHyoVM=; b=jF7zPkgcx5rOxk0BfUC+IMjksLWEJ
        IGdWVggKFPPKxKvegQjQoWw0oS8qAdUzt+GYlc5hf44r8zZAJHlm+/2qkbeTx9uO
        Tv6AaPrxJn5ZhPm7owrUEbPfIh9s1nkwFeEGf5RPr81r5uYaYJrUvskergZa6ESd
        22GFaq4fSsHJyiEo/YJwlhyKuxN4Kz8PjLCJNtfV2Cj+T2gKxID+ZMHcK2inEdPo
        DV+PAhbDPMcJ7PBsH8Ha+MMoSUM3vwaFFgp5tqHZQR9lG/8ZAqkPxDUBwAxc14u3
        BS1IYfNk2JtQ0VLSzVTHRXE+HzEJEH5GbIM5BlgIzuRIucceUJhz9lLOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=L85KBKmlPd+SzBqnLOStPYQNJZvE0NaYsqZW2oHyoVM=; b=u1Dv+9NV
        qClVjZZwdnPJht86DJZY80hHHKb9cvsEr2+Q8GPmT4VHzEt/Lvti3Z1hPrS2Ug1U
        ajeGJvJCcZjZXrvrPfduDanNlwJLqUvfxez6GwZN+/Mj5EQYppyW8xtCnB3glA7d
        canA4KJQzkKI8RpNACvCCW0UIIypCeZaMpIwC3S2K5wajAqZD5WoScnZ2fqfpOaF
        1+iJooxJ3fHxig5aj0OyvUqQDwKS0aOIm515iCAHxuTfJsj/ekeVaXHY7P34jHCW
        IL0TrqomGOEugfLeKePD4aXgTIN+j+jK59EWELJLkV0usHuR6Rw5EKWwZHRSYLS8
        ykyHSmlK1MZM0g==
X-ME-Sender: <xms:SzTnXutISzh-JcqdxPgjioRSpvXjDpgEy7igVR0hno_Uep_gnC7kqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:SzTnXjdKK-b_4ECtyKO5w5fo3tbmE4a2tw9zn9BLaSGOcdZtKhnSiA>
    <xmx:SzTnXpxbMPm8Bs9H7XYDixf5JlGBRjeqHdORVtfXyxEHSD32rFa2MQ>
    <xmx:SzTnXpOVmIyjBX-oposVO1IC_GrYx2wQV4dbWCRdwNwgGSK6niR2aw>
    <xmx:SzTnXhZBmucjMAofjjASeu9JQ9m86Zo4qw-t9gRqQ1jiUPW-je57tg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2339930614FA;
        Mon, 15 Jun 2020 04:41:47 -0400 (EDT)
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
Subject: [PATCH v5 17/27] clk: bcm: rpi: Split pllb clock hooks
Date:   Mon, 15 Jun 2020 10:40:57 +0200
Message-Id: <fdc21962fdc7de5c46232f198672d5d5c868ec74.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver only supports the pllb for now and all the clock framework hooks
are a mix of the generic firmware interface and the specifics of the pllb.
Since we will support more clocks in the future let's split the generic and
specific hooks

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 58ac1b104429..19571602ba64 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -102,8 +102,8 @@ static int raspberrypi_fw_is_prepared(struct clk_hw *hw)
 }
 
 
-static unsigned long raspberrypi_fw_pll_get_rate(struct clk_hw *hw,
-						 unsigned long parent_rate)
+static unsigned long raspberrypi_fw_get_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
 {
 	struct raspberrypi_clk_data *data =
 		container_of(hw, struct raspberrypi_clk_data, hw);
@@ -116,21 +116,27 @@ static unsigned long raspberrypi_fw_pll_get_rate(struct clk_hw *hw,
 	if (ret)
 		return ret;
 
-	return val * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
+	return val;
 }
 
-static int raspberrypi_fw_pll_set_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long parent_rate)
+static unsigned long raspberrypi_fw_pll_get_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	return raspberrypi_fw_get_rate(hw, parent_rate) *
+		RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
+}
+
+static int raspberrypi_fw_set_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long parent_rate)
 {
 	struct raspberrypi_clk_data *data =
 		container_of(hw, struct raspberrypi_clk_data, hw);
 	struct raspberrypi_clk *rpi = data->rpi;
-	u32 new_rate = rate / RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
+	u32 _rate = rate;
 	int ret;
 
 	ret = raspberrypi_clock_property(rpi->firmware, data,
-					 RPI_FIRMWARE_SET_CLOCK_RATE,
-					 &new_rate);
+					 RPI_FIRMWARE_SET_CLOCK_RATE, &_rate);
 	if (ret)
 		dev_err_ratelimited(rpi->dev, "Failed to change %s frequency: %d",
 				    clk_hw_get_name(hw), ret);
@@ -138,6 +144,14 @@ static int raspberrypi_fw_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return ret;
 }
 
+static int raspberrypi_fw_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long parent_rate)
+{
+	u32 new_rate = rate / RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
+
+	return raspberrypi_fw_set_rate(hw, new_rate, parent_rate);
+}
+
 /*
  * Sadly there is no firmware rate rounding interface. We borrowed it from
  * clk-bcm2835.
-- 
git-series 0.9.1
