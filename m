Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D9BC11D2A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C402080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="TMBFAPqi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FuuxalAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgBXJJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:09:31 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:40799 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727611AbgBXJJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:19 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 7F539603;
        Mon, 24 Feb 2020 04:09:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ELS0WPf/SOWgR
        mLsSk4Vx+kMgU2ASZug2bi8nH7md6c=; b=TMBFAPqiQDlV01vcC7csL6l6Jblsv
        XplWbTIpQpcKyuLHJwnZZ+DiApNt/fNoOSALHb4nt+Ghfd1MIU6oja0gfKlI5jvr
        +5aAGNhQomjUR+P4P1zxr6Y50LXTLozJpHjvc6WjfgesqSAnlmperdaa6l4nj9cO
        y4GPvDXBZGIhi+UiSWJ0GmRv3MS5r0vk+FiDYD2T6IL2qoysMxXcRlJvJVb2esFd
        PH+IKDvbAsy3yZyvWwjhIPLcWG1CuwIFSjRtzdAlM3EH7XiNBxY7RvFzv2W3/nOy
        xbjFaztlMmiWRZ1mCfp4Q+rAnIWRFrAxJl20ykeTPnS7sJ4HyI3bZwR/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ELS0WPf/SOWgRmLsSk4Vx+kMgU2ASZug2bi8nH7md6c=; b=FuuxalAu
        KOKLyXDU2Ku9QnSoD9UGBID5QMwZyOUxlQCzI+rGXoePHEmgHd5FzpMWaHJ9Gz2p
        yk3mT5h22uiYyO7iZCT+3CW72kQfCJhMTv4+EkjEu11K4gX1SCJi9HzDC9q3A09Z
        g9klkWzLOFyeciDO+8OQUSZCzi0ufUdirInrCzRf3afrW08Tr5oQp4XROdH26Upo
        gH/50hm8TCbe1eujP/pbLoQ1QGtv+wtP+fLbuqAo/HolLgjdeyFoUcpWwJDhxtfM
        j31x/L1k+/uFKwvOl8uFwgr2TTxbHKW0VngrOK1uBJfyb37U5RSKEKK2gzZ0R22+
        jNlz3ngHVmrH6A==
X-ME-Sender: <xms:vZJTXuJ1-jWdW4VXWsFWHY0HK0veN03CWBgfz5yG_d0njBEWfqNg4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepudefnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:vZJTXsFe1SaHn77NtTfc0sqVEfJ-miaNt8M0Km-fdr2L2ufuRXsUmA>
    <xmx:vZJTXr1dVFmmX19BHk2FFa7dfztk34-PNaAiLOrcDImoUJCxtnxHfg>
    <xmx:vZJTXkLCSb75XrMWVLKceFqLMMFT1STJAbyzBJN3TcbQWlAi_EtThg>
    <xmx:vZJTXtjz2B7r7OJMDeDCFTwtThGgYMm81I-WoOHlXlmE6eAoPtQJVlMfqk0>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C00923060BD1;
        Mon, 24 Feb 2020 04:09:16 -0500 (EST)
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
Subject: [PATCH 19/89] clk: bcm: rpi: Split pllb clock hooks
Date:   Mon, 24 Feb 2020 10:06:21 +0100
Message-Id: <5a40506025566ddab97109fc0a66eb9e0c80d9ab.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
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
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 13b7ee148824..6ee2c6639604 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -104,8 +104,8 @@ static int raspberrypi_fw_is_prepared(struct clk_hw *hw)
 }
 
 
-static unsigned long raspberrypi_fw_pll_get_rate(struct clk_hw *hw,
-						 unsigned long parent_rate)
+static unsigned long raspberrypi_fw_get_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
 {
 	struct raspberrypi_clk_data *data =
 		container_of(hw, struct raspberrypi_clk_data, hw);
@@ -118,21 +118,27 @@ static unsigned long raspberrypi_fw_pll_get_rate(struct clk_hw *hw,
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
@@ -140,6 +146,14 @@ static int raspberrypi_fw_pll_set_rate(struct clk_hw *hw, unsigned long rate,
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
