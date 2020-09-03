Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17746C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D186D206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="DxKlLvhD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O52egfUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgICIGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:06:25 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:39273 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728500AbgICIDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:03:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id B624BCC2;
        Thu,  3 Sep 2020 04:03:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=7rnBr1+HBTR6I
        D0qO9UoDa4eFgTUzpRiQzquC7LzyC4=; b=DxKlLvhD3eILzK86KElE+GXRaOzzE
        9rsUjawR8ovNWZtgdCzXcIE/8VgFarr9vjkeSIobuR/bQG8Mutk9kIwU8VPAwHZZ
        EsHxjWaTSnhmMJECMGk7vKloGEO76wQ+KfQmAatTvWmTREO5xbu1vr7ZfjUt72db
        nkA3HYP/BLJ9c6pucOmm81QC93QD8xALIyTNfmO2UaKvXPSG28Ra0Lm25zwWIfD3
        BFvg66+8zRUUv71Rpcblry/hatZeZJRVGxSbr4IkMGpC9tDCO0xkJenU6cahtmkX
        fUK4wlLDX8sumAF1EWr06hro0/PqStQYGHhkzdPDian254o229FZ/NWNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=7rnBr1+HBTR6ID0qO9UoDa4eFgTUzpRiQzquC7LzyC4=; b=O52egfUU
        OBLVtdPpHT9g7DwSTsrszWHONBVB2ortOxVhE18ycMhCPCrCucpBKvvTDEpttDfs
        XX9ZutP0C0Hm+cCoWBmNYw6hYmn9oUcPvDpQY9KVufM7x2xY2kY1zyC0gtOlINYu
        ChE5gtqgutzsmqYjehMyRjGKnDF8HxhqTrsPsmnx9RpuL9AFLqYGjAX/FwGxuvV3
        cq4xFJ/Ng9/IVyvfLP7rDGo15idQ+lNP1NGe2SfAy+VpwLx5VPl7x1xDHagjk5sO
        MCuH+eSeOSGDs6pkOnjnd3r53sGFLly85NwmQRNbOUciTxA5ZXJBqSpQYv8OffDf
        4xrm9+l5NG/b5g==
X-ME-Sender: <xms:U6NQXzHZHkB9kvF4FJdB5SP6UF3HqUeEUYZZ9R6ueZudZ8DzIdr4ww>
    <xme:U6NQXwWcZgMvBO9zynnI45LL8TLXGoAQzTg3JsO_WAkAwYsqTbpuZO60RPmm5OE5S
    aTJzAlnV1VIsYku6MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeeivd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:U6NQX1JE2cR9snU_6TICaocLspNUmvNkXwNLlqNze_yzzXk6hg3L9g>
    <xmx:U6NQXxEvX2Bosboh9t7ZoBGE3oxdZVDYYANgubjQdMSyAB03_HW6Tw>
    <xmx:U6NQX5UUwOqzIQqzIb7itKlvBFb_wL4endJJeizvu2jzpIAY6PWJfw>
    <xmx:U6NQX0NHRkZyUxU6bGDNHoFkB6o7r5FRKPOKpAV818P099GhvpBDs6xxm5g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E5910306005E;
        Thu,  3 Sep 2020 04:03:30 -0400 (EDT)
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
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v5 69/80] drm/vc4: hdmi: Deal with multiple ALSA cards
Date:   Thu,  3 Sep 2020 10:01:41 +0200
Message-Id: <e60a37444e848a384a45707a21d6df8883115f86.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDMI driver was registering a single ALSA card so far with the name
vc4-hdmi.

Obviously, this is not going to work anymore when we will have multiple
HDMI controllers since we will end up trying to register two files with the
same name.

Let's use the variant to avoid that name conflict.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 3 ++-
 drivers/gpu/drm/vc4/vc4_hdmi.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 20cfc85449ca..5e479647559f 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1043,7 +1043,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 
 	card->dai_link = dai_link;
 	card->num_links = 1;
-	card->name = "vc4-hdmi";
+	card->name = vc4_hdmi->variant->card_name;
 	card->dev = dev;
 
 	/*
@@ -1502,6 +1502,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
 static const struct vc4_hdmi_variant bcm2835_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
 	.debugfs_name		= "hdmi_regs",
+	.card_name		= "vc4-hdmi",
 	.max_pixel_clock	= 162000000,
 	.cec_available		= true,
 	.registers		= vc4_hdmi_fields,
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 4aea5ee8a91d..34138e0dd4a6 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -30,6 +30,9 @@ struct vc4_hdmi_variant {
 	/* Encoder Type for that controller */
 	enum vc4_encoder_type encoder_type;
 
+	/* ALSA card name */
+	const char *card_name;
+
 	/* Filename to expose the registers in debugfs */
 	const char *debugfs_name;
 
-- 
git-series 0.9.1
