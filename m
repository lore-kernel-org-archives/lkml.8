Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485C3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5082053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Baz2FF76";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FDV6gBv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgFOIla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:41:30 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:52447 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728593AbgFOIl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:26 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 56AE658015A;
        Mon, 15 Jun 2020 04:41:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=iwX/khD8FWvPO
        xGGR0GQsUImRwtN+u0WBdQoQmvGapw=; b=Baz2FF76S/KeM8JG5AEBSyQcqrs8y
        ZS5eell9y4Q+PqzSGGKbuEgCZEysP/jSTyTP78xaP6kXP6A8rUccDckAt+ceL4zq
        LcOFTrb4vwpWEDsjDbg2mWIU2xTQEvBna2nO2lKs8HI9rPGKi0OUyM6SOc86tw99
        UKk0yB3s0tH55yX9bbDM1rf8rLrbJGMjyhXaTHFK9jEO74zkb4ZRdxsW/u+sUB9A
        /OtuV+C8zBkYTJOUFJT8qISHuZkGiNq6PemSKXbzvVbamY0E0IAYOR29ivib31m/
        IhKM8mQb04x6AKCcQ0d9hUHAhcGrTBG2CzTzqlMna56wNbICBdiKDqDfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=iwX/khD8FWvPOxGGR0GQsUImRwtN+u0WBdQoQmvGapw=; b=FDV6gBv0
        1aNDhpi0Mz3G1EZ/xVPuE/m4NrUelJaj5bYk4BxO3pIR1LuGLycxNB/QcI8Cx2VG
        k2SioZFJPHyKLUC10a9FVhoTsyxw3rY8HCaCLCmqgqKvZQauVvtZf/dzyheAozBn
        wF4zSy6XdwMb3czRR8VBjKON/SvlghO90RqsDkjCBPzKDgP9Zro4CJiNJ9RToN2I
        vZVrvY54A2dtMBdWW/nckdkMhUxXk73EuCaKsSiNNsqmQUJmhkzYBSegLBoj8436
        nmYC+Y2t0vK0erW9+yTDeWZBNLxglIiTdXuvvXn5x+dAormNXa3+XNJds2RuXNrd
        jo2v7AMTEog31g==
X-ME-Sender: <xms:NTTnXv34ciGCDa6ZtNNxeKLBAPey-nIT8MPRrubtQW-jsnP-yfLxfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:NTTnXuFt2cBSL9XX_pFNBMXlc8a9p9-dGcOaRXp8ZWYGL2J_gCIuvQ>
    <xmx:NTTnXv5GGNa382GiFJ8Zc-Oez4EQUlSir8snOHkgVGsZq2FVQ3bY8Q>
    <xmx:NTTnXk3aKfPEh8KREHvy-l4qjnnB3am6ZQXjKuXpqD11tWqcmKLIMA>
    <xmx:NTTnXlAoTvkUfVtYc52-FHjr-tyN17AphArgDYgrJW_0S-ZYdIeQow>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E90C930614FA;
        Mon, 15 Jun 2020 04:41:24 -0400 (EDT)
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
Subject: [PATCH v5 03/27] firmware: rpi: Only create clocks device if we don't have a node for it
Date:   Mon, 15 Jun 2020 10:40:43 +0200
Message-Id: <72114c4287ebda2dbd952ea238d4489d359897e5.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
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
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
