Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3045FC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F194E206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="HfZajquN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QJTJkKWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgICIIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:08:39 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:59641 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728473AbgICIDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:03:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 1A702C29;
        Thu,  3 Sep 2020 04:03:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=RQL2p0XNTFOVc
        zFS1RiCOdkrFsHPgmafoyYC4B9enjU=; b=HfZajquNfgYrf88rR81bIYG++P5Ub
        naSqUgUW6Uo+ENC7aJO5XfeRXyIXPEFvxJdD6/fYCefemhase7DR38UsvGUQwr4b
        bVnO9QFyfqQ1tMT4h+o5zhcKaRXa4/keTQIhkMFqeJp9mNsc4NNSuLym/26qtJK7
        uQSS5byjSwulhUyUN94gSF/w1zayalWfP6bzKqmBE8bCYlu8YrlUk3MHI68pP124
        MA/s20Sh7Qs2YQeXA026F188D0HGZRh7MdH7lM3gSIoYG8Xf9P3AZ8XX0FH9lCiu
        wD0mTFWvWXvmQ1RelJY7NIcDTaveT7nT3DqHsXRckxESbbYLwyXj9nT9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=RQL2p0XNTFOVczFS1RiCOdkrFsHPgmafoyYC4B9enjU=; b=QJTJkKWO
        d/fZzPhV57bt5bj69jnyXUrepWCB9+auDCZ4Z+V/vU4g6ZhdG3ITtPenW4Ad53Zi
        O/NE5SAHQiJIZliY8FjcCtHV9r9uiknntIPUwxqi5VlYQbqBc+wCyq3W3MAuux9P
        YA1cVtLSgQCotjIqBfhz6Pejz71QEZ/FvkAgKAotA3y2GCa2TZeGERbaccQQ9KFE
        rkFnEGsuCDAoUEhat5qYfxcON3KIt1Hbc7WecoObiuWG0t/rlv+JvtDLMhC0YRrV
        eArgcnG/ktZJYm0M8a1fJIRW91sd/v6SOSW4TAoW47489MLcVu11wCVyu9UErvTa
        sfXWqjX4mrX+rQ==
X-ME-Sender: <xms:QqNQX8LNWbZNyGUsBX6QuD24rmK46s05ugNfMJhXqTqEvw-LhNHpEw>
    <xme:QqNQX8ID54Xkkvjy_x-klHLXD1JaaRuTqcVAWDaL8GHf6zOVKXUJa_h2_ZX1uwF4A
    OhMbM_d7xcezaw1DV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeegle
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:QqNQX8s99Trwh2qADNvDMtNNI_AFFS-vmg7hrI5pZpS5Svd_foYdiw>
    <xmx:QqNQX5Yd97VQn1MrciGBHMS1C2DpQtNgRNINcmlizG-VnS3oRdHOUQ>
    <xmx:QqNQXzYhWBVL6DfvF1JWfSsrJAfOldBkgBDZmHcFhi-76w_KZZrWfw>
    <xmx:QqNQXxALO0MHO1yL-c_9xTctwmeG6A_ZoEPQE7pExzuCTn3B0-KAn52G-xc>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 56CC2306005B;
        Thu,  3 Sep 2020 04:03:14 -0400 (EDT)
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
Subject: [PATCH v5 57/80] drm/vc4: hdmi: Store the encoder type in the variant structure
Date:   Thu,  3 Sep 2020 10:01:29 +0200
Message-Id: <2736a86b498551ba9dbc5803c5bb910627a2550c.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
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
index 9e2bc6cb690e..f6d18bdbd1bb 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1267,7 +1267,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 
 	dev_set_drvdata(dev, vc4_hdmi);
 	encoder = &vc4_hdmi->encoder.base.base;
-	vc4_hdmi->encoder.base.type = VC4_ENCODER_TYPE_HDMI0;
+	vc4_hdmi->encoder.base.type = variant->encoder_type;
 	vc4_hdmi->pdev = pdev;
 	vc4_hdmi->variant = variant;
 
@@ -1446,6 +1446,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
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
