Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09775C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD60920776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="djKq1M1U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DWFv5QxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390541AbgE0PyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:54:18 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:41523 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730697AbgE0Pvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:51:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D0D24582114;
        Wed, 27 May 2020 11:51:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=WSzFLC35owJBB
        cysknwl1DH4vQ3qwxXRUrFNvyhjUX0=; b=djKq1M1UuNvBOFAb5HxGbQkU9wb8p
        w1BYLi18bPbk8VfhGN1nUeJ8yiVy8xnseaGs3cBBUIUcReNd418IaTp0nFp7cifP
        ovIxdR1901yZp1nH9YTCOpPUmHEvAjxWf6j9JJsqIIBLkWAouuBodIuN2DMyC9v2
        W8FRkH8pi5CRBOFs+Cgy6J+mVYJJZSzPiF9VfecTObmUdlU02YuHkLRDPNAerl6n
        N6P0Z++1gKSw3RVtYoBQa9XhK+veHuOuS7MMOWYEKGr/5Y+VPUGppMiuNnCVaqU4
        VyesNxRyJNIp54Orm1maQxTCFy7tyyMN9ORrlLnNJTTg5ovz64Wd70Nlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=WSzFLC35owJBBcysknwl1DH4vQ3qwxXRUrFNvyhjUX0=; b=DWFv5QxL
        nYzR8zT2invOKVdAV7oTpGRUQguIlLQ5Q2i0Ms8Bk6rfte3Q6BLWVtKpIR5mfZto
        +rzNkYtY60ScJY3JYARgno0XGi0iXgyBySjvTuVk34CAPPyNYR1isOgPam9yZvEw
        GEPrHtpZSNdG0VlD3efXxIiOS6/p0lS23O/G5MVHS75kwkqN0xnQANd2YFEQiSMf
        v4Z2+77s2Z0nl760bRnIO+xgtRjWdBE0znxt8BhfwLbJBqgeo15it+MUeSH6fZfQ
        1zUzZQbnuNtCr6N72qF8Wr+j1MKFwsj6NQfFdIqdAdnvFyleu3yl+RIdtXDzM+xI
        WLK857/HrOwb4A==
X-ME-Sender: <xms:lYzOXkBpzdbZbdhJwnqLJNAoS9ETsmdyTN8pcHRK8R_pnDzXa9PhiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepjeehne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:lYzOXmhs-9BFQuJ1p3ZmiZOHDCzdsfvhDD-zvp8XNUZH3ukjxBhkyw>
    <xmx:lYzOXnnwsvVrR1hr0XkvaMiQZ2NzVZ8iwY2mq-Vbju8nsiV4wTLvdQ>
    <xmx:lYzOXqyFrEOtfkzRTBPVmLRliOM7Mhvvf3qKBGUJyfw04TvgNi8yAg>
    <xmx:lYzOXqTgOBgwVVPOy1CSeIa8jgdHmj5Q9aq6Zw9ER8sve9m9I0Llqg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 740B030624CC;
        Wed, 27 May 2020 11:51:49 -0400 (EDT)
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
Subject: [PATCH v3 097/105] drm/vc4: hdmi: Deal with multiple ALSA cards
Date:   Wed, 27 May 2020 17:49:07 +0200
Message-Id: <c2a2c4967d75f6606174c037b7bff5aa68fd8ec8.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDMI driver was registering a single ALSA card so far with the name
vc4-hdmi.

Obviously, this is not going to work anymore when will have multiple HDMI
controllers since we will end up trying to register two files with the same
name.

Let's use the variant to avoid that name conflict.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 3 ++-
 drivers/gpu/drm/vc4/vc4_hdmi.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 7f98c1bbda73..5ad983ce87d1 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1043,7 +1043,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 
 	card->dai_link = dai_link;
 	card->num_links = 1;
-	card->name = "vc4-hdmi";
+	card->name = vc4_hdmi->variant->card_name;
 	card->dev = dev;
 
 	/*
@@ -1483,6 +1483,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
 static const struct vc4_hdmi_variant bcm2835_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
 	.debugfs_name		= "hdmi_regs",
+	.card_name		= "vc4-hdmi",
 	.max_pixel_clock	= 162000000,
 	.cec_available		= true,
 	.registers		= vc4_hdmi_fields,
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 30eac891dc74..6e570e89509e 100644
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
