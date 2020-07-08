Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C68C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847C020760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="KBVeSrpA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k9dyQKdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgGHRn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:43:57 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:53213 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727820AbgGHRnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 2B7FAFCC;
        Wed,  8 Jul 2020 13:43:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=2uHFyUwNK/6yf
        bghIh47l4CHUyqe+Ay+rc5YWKDiiP0=; b=KBVeSrpAcLKoyrd25J6k9xhdbn/rE
        3w/7us9W15wAWVmslYDNzLWPwJ9x3DR8779ylf91b5H0vMR12/g5EButdraw+HNe
        64bFbgADRO+BmQl62IMwQutbTOXDQxeJW2Pl6nHSp3rkUZW7L5awf051690wLUPz
        QA0hgcB5asL40sleKZICW9C69kfo2779QekRhhtDRCs36J2Wwwl4AEKD8LZ0Gvo/
        jp56BCJHmiJhnYPsvIqi9OyUEn70E+tDYa/UC6XyICBeS8F3wrHnsL9ptqygO04t
        OL38yf5ABZ+dcj9n2Job1PS4s6sZb2J49PXHkoEJ/opPaujuZ2uzSXBzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=2uHFyUwNK/6yfbghIh47l4CHUyqe+Ay+rc5YWKDiiP0=; b=k9dyQKdP
        LkT//GfaFlHAV+2HQIIkFfjvbv0NVoCTdnb5as+3W963E8dzbyhPGUrFHpHtfYO5
        1UNZbbJHfCXvQFeZCrh6l5wCucSoHNkZQCyHRhneiZNuyzw1AP2gNCjEHGoJfuvf
        8irpbRIvSPD1b7d1TMdKc8OddShlm4aKyYIAUCSWY5HJVNwiE71m+Iqr75AQ8KKs
        2Z8LSMYXdXzo3K9zN937uvbLR2+XRnxo2gJOy8Ml0P5iQKs2X6YVfWcqVLMJujn2
        H0+O83krNGgPsmKNg5KJjOG1s5+pVJYka3uNEmAmxLemuRiV+x5ZcMzu3OD6h9q3
        6hEwOS5Ej0FtXw==
X-ME-Sender: <xms:1wUGX6qWEZ8ZXz0JLNr9taDLzcJ518hoxQ4BwABKKvhq8mkMW85I9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgephedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:1wUGX4r-hyAZ-AmWxNRiaF8pVpu1goGtEzJangKb63WRh-RQuDpJJA>
    <xmx:1wUGX_O0L1OwpDet7bcAUaIRa34Ci0r1JjgiZHi8dfNxHJIOw1U3Hg>
    <xmx:1wUGX57JyRZUeDaxtCqzO9naZdR7o6XFxS-Cig9KgKhob8L5RyA7CA>
    <xmx:1wUGX0Y_dlv6KGns_tPAlrCF0OkzDeTgvHgPaE1CFWRycDd013gqH-56_1Y>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 78BE23280059;
        Wed,  8 Jul 2020 13:43:51 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 56/78] drm/vc4: hdmi: Store the encoder type in the variant structure
Date:   Wed,  8 Jul 2020 19:42:04 +0200
Message-Id: <08b5c574e128bc7c42387867aee11978068c2aa5.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vc4 CRTC will use the encoder type to control its output clock
muxing. However, this will be different from HDMI0 to HDMI1, so let's
store our type in the variant structure so that we can support multiple
controllers later on.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 3 ++-
 drivers/gpu/drm/vc4/vc4_hdmi.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index a50220bfd5dd..c50241170d7e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1268,7 +1268,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 
 	dev_set_drvdata(dev, vc4_hdmi);
 	encoder = &vc4_hdmi->encoder.base.base;
-	vc4_hdmi->encoder.base.type = VC4_ENCODER_TYPE_HDMI0;
+	vc4_hdmi->encoder.base.type = variant->encoder_type;
 	vc4_hdmi->pdev = pdev;
 	vc4_hdmi->variant = variant;
 
@@ -1447,6 +1447,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
 }
 
 static const struct vc4_hdmi_variant bcm2835_variant = {
+	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
 	.registers		= vc4_hdmi_fields,
 	.num_registers		= ARRAY_SIZE(vc4_hdmi_fields),
 
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 0c32dc46d289..0d529db4b3ab 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -27,6 +27,9 @@ struct vc4_hdmi;
 struct vc4_hdmi_register;
 
 struct vc4_hdmi_variant {
+	/* Encoder Type for that controller */
+	enum vc4_encoder_type encoder_type;
+
 	/* List of the registers available on that variant */
 	const struct vc4_hdmi_register *registers;
 
-- 
git-series 0.9.1
