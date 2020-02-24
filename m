Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32246C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB56820658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="LC5gQlz+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VUFlRVrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgBXJOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:14:18 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:48453 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727513AbgBXJJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:16 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id A50355FD;
        Mon, 24 Feb 2020 04:09:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=pZhkG4Uc6t8qd
        t3TS+BT0JV+lktvl594HkuES8xD4WA=; b=LC5gQlz+tTheHQFVZGldCasGEADZD
        W2h2Kcdg3D62tRSW3fcy8X6dacTxnG4BL1bsOpd8tt9dUSfcrj1VlOIm2SvfCbLR
        QDkMPDA/dPeBxrRoQ2hC6W6mH1AErt61LI4HlrSOQ+FGXZ/tlBagH6WbNwwp9aS0
        vnoJlNdXk4RdU6wzwbWp0zCMgNBFf5D0BTqLtJ7pbw2GE48dIQHv7cRWRu0ZApoe
        PG+q8DroiqehoJhWCu48NHDFTnkhrmmepmMfK3pYsBE6epDQyeX+4jl+GdaBhJ6J
        WBWyowuelsLTVSaUDUZdnP0lkC9AxRN8xVHIDuwMzlBQIa5bq4Jlwa2JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=pZhkG4Uc6t8qdt3TS+BT0JV+lktvl594HkuES8xD4WA=; b=VUFlRVrL
        Id2W/2ZKIGzmsn64Whwy9jLS6ha55U8b3ohB5naCOShj0XwsbeR5XJm7/LTzm13y
        CKPmcNUV/TyXhMw99rBJWrzuPMqJzpCH7DejaXIIYPjXndCsZh+TjVfRkUpvMgPS
        FNtBnJSbAT6LkcdCxC627Csd9IV+a+LODuH2u83F4T1MmEUncPGq6/4rZWArs+6a
        QFPPd/RzFT6gZNMyyPnf4ZSjLRcU6pNjo1eIOWam0vvFZI5qq1x4C8uhoYsqvGLv
        mNA/IrBCKy7TE/TccsjlQSIR150nQJK/BLc3Z4uMh0GABktN838idT8g2q1PiOKE
        GgmyTW//eDLo8g==
X-ME-Sender: <xms:upJTXmwHbsioEpTYE8SKzSMgdKsO9t67nQETRSBbIEInSu6MjQtwHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepudefnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:upJTXgi3jBNAEJ0vqGptV-Hrachql56vgrV7OJVm8RCB5EbHMGpPgQ>
    <xmx:upJTXhpiCWKbuza6Lwz7SLvmYBJ_4Wfi6lMSeNi__DGkC5RaHEKzFw>
    <xmx:upJTXvjz_h7_wOa_HSHLsh93b7BqMvgdTgporiaM4rCQ730bxSw5sw>
    <xmx:upJTXt9yF909fPG_PkInF00ynL80q9_e9KM-Q7mb3bcydcnWuUbEA35KO9I>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E2EDD3060F9B;
        Mon, 24 Feb 2020 04:09:13 -0500 (EST)
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
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH 17/89] clk: bcm: rpi: Pass the clocks data to the firmware function
Date:   Mon, 24 Feb 2020 10:06:19 +0100
Message-Id: <5a02a46e899abfca7257a725678f1131490e6b11.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
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
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index e796dabbc641..3b2da62a72f5 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -67,11 +67,12 @@ struct raspberrypi_firmware_prop {
 	__le32 disable_turbo;
 } __packed;
 
-static int raspberrypi_clock_property(struct rpi_firmware *firmware, u32 tag,
-				      u32 clk, u32 *val)
+static int raspberrypi_clock_property(struct rpi_firmware *firmware,
+				      struct raspberrypi_clk_data *data,
+				      u32 tag, u32 *val)
 {
 	struct raspberrypi_firmware_prop msg = {
-		.id = cpu_to_le32(clk),
+		.id = cpu_to_le32(data->id),
 		.val = cpu_to_le32(*val),
 		.disable_turbo = cpu_to_le32(1),
 	};
@@ -94,9 +95,8 @@ static int raspberrypi_fw_pll_is_on(struct clk_hw *hw)
 	u32 val = 0;
 	int ret;
 
-	ret = raspberrypi_clock_property(rpi->firmware,
-					 RPI_FIRMWARE_GET_CLOCK_STATE,
-					 data->id, &val);
+	ret = raspberrypi_clock_property(rpi->firmware, data,
+					 RPI_FIRMWARE_GET_CLOCK_STATE, &val);
 	if (ret)
 		return 0;
 
@@ -113,9 +113,8 @@ static unsigned long raspberrypi_fw_pll_get_rate(struct clk_hw *hw,
 	u32 val = 0;
 	int ret;
 
-	ret = raspberrypi_clock_property(rpi->firmware,
-					 RPI_FIRMWARE_GET_CLOCK_RATE,
-					 data->id, &val);
+	ret = raspberrypi_clock_property(rpi->firmware, data,
+					 RPI_FIRMWARE_GET_CLOCK_RATE, &val);
 	if (ret)
 		return ret;
 
@@ -131,9 +130,9 @@ static int raspberrypi_fw_pll_set_rate(struct clk_hw *hw, unsigned long rate,
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
@@ -198,18 +197,18 @@ static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
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
