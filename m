Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0BEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E806020578
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="RRWiaW1O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qiUHuBVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgFOIls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:41:48 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:43965 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729233AbgFOIlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 938BE58014E;
        Mon, 15 Jun 2020 04:41:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=w8QUZYtCSdAR+
        LxyqXYQ4O94ea3sBQR+Zz7F3OVztns=; b=RRWiaW1OrTe2OizcAGSNDgPAabxNF
        DYkI7ud7+1zlKBejOjJQcflOlUFnmyIXzxlkLQAOdWT2mK3pojOicZiWa227bcbG
        rdf9stet6hBKhTUHV98zqdSQn+pZdTBo7RRNllpEl6Hb9a8a/F4LdzEF/Ut3NHcc
        cXK9fiFBu2g7CIyW3k9oGGRoNf73vHFWVYmnc/7ABlnEYQvJRQ2E67AHTZPdNsAr
        AZWZFbYNLe3TRNvM9765Ph7BAeU9OACVlnNzOM5Cv+0aoA2JH2wem34ItQceep3T
        DjYpNDxNcvD46E90TPugMxjHjUNuJRqkiPImPxVbyRJvIAys30J2R68NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=w8QUZYtCSdAR+LxyqXYQ4O94ea3sBQR+Zz7F3OVztns=; b=qiUHuBVG
        HNPipeofRNAiwBqKWdYPAxdRk/zo3nEVotoKdBlo/usJTh+q9Ccaknv6eUlIc+l2
        ZXeWWJE5J6gK57keCI4qqmr6Udj+5j0NH9IfOq8worRLumOyPoavXXuhmApkJ08y
        iLpidn209r3WRdOpjHK7UcKwA8a9AHXsxWqw9cqih4ytNd761te6dARXWG1a4BiI
        cWHJFUlnpihY9Vy3vy71w2UoM2p1N7oZ95Jxg8szsepY9JGBo1O2cW+AaBnDlhlv
        3H/JvpMZY75x4Scn0T+SN7SYkP0XWbJrNuwgtTmih6kXcdA7TiMqtjXTiH5vGsJq
        VeQQrr2993VsaA==
X-ME-Sender: <xms:SDTnXmuo8no_Xj4VaWTfo6X59Dvj5JGi0v5BX_SjUJeZIgeO3V0WsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepuddtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:SDTnXrfzO7EQ-eiV8a3P_9KORDUfgQdHsZSewAV3o9xvkZI5hOZL-Q>
    <xmx:SDTnXhyHkakgUYf_pTe3rHSeT_CrRruq75KMhfq59URTTbayx3J3vA>
    <xmx:SDTnXhMbDQ0IaSfUnYYaIlqqHG6ZCr9vZpE0zTOnUcxRHSbsh_Jqkw>
    <xmx:SDTnXpYmO-z885SyywYSkTBpI97xEZ5xnm3SOwnrsmEEZ24dqzEMtg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id EDF3A3061856;
        Mon, 15 Jun 2020 04:41:43 -0400 (EDT)
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
Subject: [PATCH v5 15/27] clk: bcm: rpi: Pass the clocks data to the firmware function
Date:   Mon, 15 Jun 2020 10:40:55 +0200
Message-Id: <d7a3b4df3ca23feb6e0d9c7ae2d232bfb913f926.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The raspberry_clock_property only takes the clock ID as an argument, but
now that we have a clock data structure it makes more sense to just pass
that structure instead.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 97ac04604b0a..3fce49a65a79 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -65,11 +65,12 @@ struct raspberrypi_firmware_prop {
 	__le32 disable_turbo;
 } __packed;
 
-static int raspberrypi_clock_property(struct rpi_firmware *firmware, u32 tag,
-				      u32 clk, u32 *val)
+static int raspberrypi_clock_property(struct rpi_firmware *firmware,
+				      const struct raspberrypi_clk_data *data,
+				      u32 tag, u32 *val)
 {
 	struct raspberrypi_firmware_prop msg = {
-		.id = cpu_to_le32(clk),
+		.id = cpu_to_le32(data->id),
 		.val = cpu_to_le32(*val),
 		.disable_turbo = cpu_to_le32(1),
 	};
@@ -92,9 +93,8 @@ static int raspberrypi_fw_pll_is_on(struct clk_hw *hw)
 	u32 val = 0;
 	int ret;
 
-	ret = raspberrypi_clock_property(rpi->firmware,
-					 RPI_FIRMWARE_GET_CLOCK_STATE,
-					 data->id, &val);
+	ret = raspberrypi_clock_property(rpi->firmware, data,
+					 RPI_FIRMWARE_GET_CLOCK_STATE, &val);
 	if (ret)
 		return 0;
 
@@ -111,9 +111,8 @@ static unsigned long raspberrypi_fw_pll_get_rate(struct clk_hw *hw,
 	u32 val = 0;
 	int ret;
 
-	ret = raspberrypi_clock_property(rpi->firmware,
-					 RPI_FIRMWARE_GET_CLOCK_RATE,
-					 data->id, &val);
+	ret = raspberrypi_clock_property(rpi->firmware, data,
+					 RPI_FIRMWARE_GET_CLOCK_RATE, &val);
 	if (ret)
 		return ret;
 
@@ -129,9 +128,9 @@ static int raspberrypi_fw_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	u32 new_rate = rate / RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
 	int ret;
 
-	ret = raspberrypi_clock_property(rpi->firmware,
+	ret = raspberrypi_clock_property(rpi->firmware, data,
 					 RPI_FIRMWARE_SET_CLOCK_RATE,
-					 data->id, &new_rate);
+					 &new_rate);
 	if (ret)
 		dev_err_ratelimited(rpi->dev, "Failed to change %s frequency: %d",
 				    clk_hw_get_name(hw), ret);
@@ -194,18 +193,18 @@ static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
 	init.flags = CLK_GET_RATE_NOCACHE | CLK_IGNORE_UNUSED;
 
 	/* Get min & max rates set by the firmware */
-	ret = raspberrypi_clock_property(rpi->firmware,
+	ret = raspberrypi_clock_property(rpi->firmware, data,
 					 RPI_FIRMWARE_GET_MIN_CLOCK_RATE,
-					 data->id, &min_rate);
+					 &min_rate);
 	if (ret) {
 		dev_err(rpi->dev, "Failed to get %s min freq: %d\n",
 			init.name, ret);
 		return ret;
 	}
 
-	ret = raspberrypi_clock_property(rpi->firmware,
+	ret = raspberrypi_clock_property(rpi->firmware, data,
 					 RPI_FIRMWARE_GET_MAX_CLOCK_RATE,
-					 data->id, &max_rate);
+					 &max_rate);
 	if (ret) {
 		dev_err(rpi->dev, "Failed to get %s max freq: %d\n",
 			init.name, ret);
-- 
git-series 0.9.1
