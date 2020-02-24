Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1704C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E7321739
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="w1xpShNM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qFq9xRnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgBXJJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:09:18 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:43457 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727450AbgBXJJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id E70965ED;
        Mon, 24 Feb 2020 04:09:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=yfyJY9G17qrJj
        XohnDOqJFpG8FxZglZ0yvMVK3Y0mkc=; b=w1xpShNMEm0WP4xbqD59Z7UmcGOv4
        icc5QZ2m3GVw8eE+WjmtuxXK+ro8wetqbUcv020I/qNva0YzK9zkUqQGC8WFrBxv
        jA2/frzieUdpOeDmQVRkgkZkuiNDhmEpfLuN7N9lLRMIm6d2cAGG/O2/lTS4b97X
        BN98hy9DiAwd3ztQEeFITFu9JsOXTvWiFGjWlQ4kj+kh6Wvq6MgTZuP8Ts7fbaG8
        jeXWwT79f/HTtUhoMCILYPJvjPEVMEzuKHpbetKa/UV4LOf9ZK6aeEk1bzKi8bbi
        h8dasIhzm/bFm0n5vMStQpJZbJRyXwKVg7VtBj65NoXAxSDj3hpg517qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=yfyJY9G17qrJjXohnDOqJFpG8FxZglZ0yvMVK3Y0mkc=; b=qFq9xRnz
        9bNYXpjwYpXXbgidYsvVGElx2PQvywqaT4RQOVHcE9vgFG8GwPJ3QTBLHdcQAiq0
        ix6UkVmkd4rijEPgLPJXaCfG3HjG9XAelvTzIT3aJawgQTsCgdwCtGb70arpfcMZ
        Xxu7wuUM6m13kg8tP6ZumCApnI8pQGygxpNXkpchzYbRsYoIdjevD6Xi+nWUlh1z
        puOhUS4ladmdjr/EdeEQ6q/0AFvCC0jzD4uo8xZmGsHEfrOVYxfmdVku7SHY+EKW
        5EDV+kjiSa5JzNsaBjR7+tZcr23ECt/2PDdkEaKITTYOiBqu8fer2OJScHyq9P+q
        tJCeBGN5d5QufA==
X-ME-Sender: <xms:tJJTXvDoW7qOocvwX6hGfYXq8bL4HOdYhS4klV7OoxCp8ocSMuaB3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepleenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:tJJTXgft2VgKiqHTp10tXoY17B-O46UrYVT02JaT3zGqEoLN3M7pOQ>
    <xmx:tJJTXpmsOkL9e0kkVoUCU39c9NOwXq0Lt6Vr8F_xYX5sTPFJhJqTtQ>
    <xmx:tJJTXnH35rNZO5mubA75zCIZwGqsh8YoVLIGmPwfaniL_g8djf65sA>
    <xmx:tJJTXgh-y41J72gfSdeIMy_RppAAMHWSdpcl4rg7z6sMf04YiCqASsvXRwE>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 368143060FE0;
        Mon, 24 Feb 2020 04:09:08 -0500 (EST)
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
Subject: [PATCH 13/89] clk: bcm: rpi: Switch to clk_hw_register_clkdev
Date:   Mon, 24 Feb 2020 10:06:15 +0100
Message-Id: <75dd8f658a253649c176509f0d8d3dd10354ce51.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
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
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 0c1d6c292302..b97c7ec61376 100644
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
