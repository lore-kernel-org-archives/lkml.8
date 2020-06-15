Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EB5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B742053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="SUg3kHkJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tbFKE7/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgFOIml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:42:41 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:37983 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729237AbgFOIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id E768258014F;
        Mon, 15 Jun 2020 04:41:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=KRqld367kMSHi
        Xes4D71sSmAl9sm713CRvYZUaoStF8=; b=SUg3kHkJxSeo2Jtu1cMKcUwvUAtu8
        hMy+YOoEh2CkRnHuRoEN4gGWFRTjidUMjqXs//0SZXwADLvLRcZ9Ca0XNiUNpWTN
        tW0Jn82LRKT1tKNZcdbyT2DM5+6rxvD8I5xOsyVh2qziK31PKMpJSR5MzpOnyJmZ
        MetTUYemebS/HOSOrZbOwhIcSgHxTahyUplaVHnMKftMEcT1URtoE3GArCgUblVs
        ThF9OAExYPsK+QvA45ze/TRhzsMeom6ZRJ2bJ5u1yqj1smBh/RU4giYs/2MPTe3M
        RM903A2WeIggRSAgxPvVoVVpPppOj0n+ZlU3uYkOUVnIDP8biUD2tZoBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=KRqld367kMSHiXes4D71sSmAl9sm713CRvYZUaoStF8=; b=tbFKE7/Y
        +91xjwE8pwr383H1EpgtAv1POJk3qYCmXW3bHiJJR7G5+whyLMUCxqc86leg4zZX
        kBMfq1YLUpk5h8UkLraxt9+LtRZKUx+DLLSbEbivtok/zB4HS9yuyswV7er0iFMk
        4FoGqIIER28/a+8FHPJzc5LQH2H11PTpu1905rVQKFy3SveB4KbkETZ6zyia6z9y
        SadWbb339MxTPq1wiFF5T2f961YvNHnAOzP9y1Tv+ZXCNtg6BslqG7keSakpIkc3
        4PN0tIZUfM5ls4HWHaH8CSzjNZDT8e49ya3gd+Pw6pNby0iOXLKOqLrfyi7eSpZj
        ZoQlbpICzi3GZg==
X-ME-Sender: <xms:STTnXjiFSmAy_ABDg4NLaz0cZPonN0OCWEzQyojXmZEw7XvNU7iQmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:STTnXgAlAZtKJqlSgOPZWTsPzEy2JQwsTzKRwguvItlmTvZLRXKwHQ>
    <xmx:STTnXjEZGxr_ew0ydmsGaiNk8sR071KAuWRX3li4JgK01sOEUp5uXg>
    <xmx:STTnXgQsO3KBK_YVgq9tC4__TNzx9z1Wqwrv8UYyS3i_Toz7EZ4GnQ>
    <xmx:STTnXsdVQwacgpIa1wvg1_YLa359C2ibhfYyAjUAapoe45eoRiC87Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8943D3280065;
        Mon, 15 Jun 2020 04:41:45 -0400 (EDT)
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
Subject: [PATCH v5 16/27] clk: bcm: rpi: Rename is_prepared function
Date:   Mon, 15 Jun 2020 10:40:56 +0200
Message-Id: <ac93cc4e245316bb7e7426ac5ab0de8f3d919731.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The raspberrypi_fw_pll_is_on function doesn't only apply to PLL
registered in the driver, but any clock exposed by the firmware.

Since we also implement the is_prepared hook, make the function
consistent with the other function names.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 3fce49a65a79..58ac1b104429 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -85,7 +85,7 @@ static int raspberrypi_clock_property(struct rpi_firmware *firmware,
 	return 0;
 }
 
-static int raspberrypi_fw_pll_is_on(struct clk_hw *hw)
+static int raspberrypi_fw_is_prepared(struct clk_hw *hw)
 {
 	struct raspberrypi_clk_data *data =
 		container_of(hw, struct raspberrypi_clk_data, hw);
@@ -166,7 +166,7 @@ static int raspberrypi_pll_determine_rate(struct clk_hw *hw,
 }
 
 static const struct clk_ops raspberrypi_firmware_pll_clk_ops = {
-	.is_prepared = raspberrypi_fw_pll_is_on,
+	.is_prepared = raspberrypi_fw_is_prepared,
 	.recalc_rate = raspberrypi_fw_pll_get_rate,
 	.set_rate = raspberrypi_fw_pll_set_rate,
 	.determine_rate = raspberrypi_pll_determine_rate,
-- 
git-series 0.9.1
