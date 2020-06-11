Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A59CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D292074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="H+X61dtN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lr8N3yRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgFKHdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:33:19 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:45925 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727037AbgFKHdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:33:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 49FBD5800D3;
        Thu, 11 Jun 2020 03:33:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=pruSBGKy1aIYN
        RS8+kryGjri7n1iWSNf01jIudDkaSA=; b=H+X61dtN5eCd6WNXwzH82cGESdHP4
        UQfxKYK9JMltJ9TA8jNJepx+k84ZiHptW947n3cas3LlTaE4NtaA2QOKePMK4fI6
        wNOC9in/xyZj6vgp3IZUBxe04UpYJ6fUHhLRoVVbFQ4JIk9UN9BjFRygBqOI2mD9
        ZYVylQNIv3xfNrztgXQXdd7ON0E9L5LnMG4QdfQI0kbba86Ks9Pzqo1CTc2HBjOb
        Udmk0v2XgUw7GTDqApqDf3M/5pQRwal3cgwqLvVoj0tvV1KTr3sUO0vW+ka21BMw
        VxdG0YxBymwrebnKWJToyndNHnr7adw3vl4i/aO9tHQzyJS5TWnZrK4TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=pruSBGKy1aIYNRS8+kryGjri7n1iWSNf01jIudDkaSA=; b=lr8N3yRG
        gIT86Q9JdZEFj2VwYJnR+hzBEUsSTFAUKFZ2vlhAapkNfvVngw9TNIibXu3P/B9U
        06NhB66MSfU4dXBzNOcU4zgA/5hPuo/4h+AXo21SN8IaXvuwTQOAAslH4DycVOXq
        EWXgv3/ntlEnfuB+i//Pf9jFzzvWhUITvrlwQbhzhUJ3laQ5vfvEZ7STkPCF9aLa
        lLwI2A4+6jy6UoQ9r2zc2Lb/P745hqvWUZNKWPWezoNtVPpun0Ki+HIVRV2V7Bqt
        4z9m6QnRppFUAQ3OuzSCUrg5TJq6VSSTGr/FevDmajJswAOm7J0xmedIYpiArLcx
        ZzwPHHsb9yNwrA==
X-ME-Sender: <xms:Lt7hXi0SCauSb1lDypmiRqSRFz1V34mAthKVCZTTA_HzOi2mp4XqvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvge
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Lt7hXlFHowhZ5EcPpi5AjfJClpmaAtLBsJmwX7OD919VjvRHsERUOg>
    <xmx:Lt7hXq57pFOCuVNNwUkZe7Z6oAaHZDA8YKUrSDjiHpaQJYQ8H0S_kw>
    <xmx:Lt7hXj1pcpHWOeWt2HO3EsNQa6AxBf16Vtcx3x3aKogXRjOqfrAcVw>
    <xmx:Lt7hXrarQQgbnEwAC7VYaDRYDXSVHhVD3K1RtJly1ObU23-EM7rMGA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D91F23280059;
        Thu, 11 Jun 2020 03:33:01 -0400 (EDT)
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
Subject: [PATCH v4 26/27] clk: bcm2835: Don't cache the PLLB rate
Date:   Thu, 11 Jun 2020 09:32:15 +0200
Message-Id: <264ad21afaae4a7098c3da59970d6cb9da1a8b0e.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLLB rate will be changed through the firmware clocks drivers and will
change behind this drivers' back, so we don't want to cache the rate.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-bcm2835.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 846ea68b2c73..64e23733e6b7 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1700,7 +1700,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 
 		.min_rate = 600000000u,
 		.max_rate = 3000000000u,
-		.max_fb_rate = BCM2835_MAX_FB_RATE),
+		.max_fb_rate = BCM2835_MAX_FB_RATE,
+		.flags = CLK_GET_RATE_NOCACHE),
 	[BCM2835_PLLB_ARM]	= REGISTER_PLL_DIV(
 		SOC_ALL,
 		.name = "pllb_arm",
@@ -1710,7 +1711,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.load_mask = CM_PLLB_LOADARM,
 		.hold_mask = CM_PLLB_HOLDARM,
 		.fixed_divider = 1,
-		.flags = CLK_SET_RATE_PARENT),
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE),
 
 	/*
 	 * PLLC is the core PLL, used to drive the core VPU clock.
-- 
git-series 0.9.1
