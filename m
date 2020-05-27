Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9646BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B88320776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="YOmGWhiz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gpp6s1SF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgE0Pyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:54:33 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52331 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730658AbgE0Pvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:51:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 131B2581514;
        Wed, 27 May 2020 11:51:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=G7atmPA7eX8En
        DxiMYNRcBaB/TV7dfsNzYMcQXosr6Q=; b=YOmGWhizQbR3FyRe8QzBGNpNklQS2
        Zqavm22mpR9iN80mzBk6gMI4znsV9Ye9+GGgcu3aFlroxEc1XVAcTAdBHrwXC7qi
        jcknFjzSJmtCbWNBKTkI6e4tXb/ovenpmOsb4NvVPN9A8Q+PiEPFp1qEMZcGIQbk
        R9xXngYFPmGmxBsSU3mG8rcs2fQwUKahffwej5+PjZVFmitqkEQHIcU/S9spSv+k
        wKj9p1PICjmyGHGwhomwNBqVCMcaTGoVJhGwr7MCXdErwf674oH3o7Hvm0uu3/bT
        NVWcNSLvJ+UEaJPMI4VEkgLc54jMxekXr89U9li/UNbLlDf9unKJPM2HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=G7atmPA7eX8EnDxiMYNRcBaB/TV7dfsNzYMcQXosr6Q=; b=Gpp6s1SF
        U58FsU/krF2Fqnx20uqepleXvZW0CSUF4N31fVuihW3Gu2a25xQAJiF5t0uu1WDw
        YWZY1VoDirFSwFXfxTTUErxVMb3PCMcOWHQUNa1d6J4B/2Q1nnEO2M0O4+OXWLLS
        047FNwxIjm1TLuDSu53qwbOjGQ4Tlcs1IVHNc2VhYtTLxmSGF71uWkJYUcM1maCI
        tjCSY+PLZjjGxQSOMhimkCIQSr9Xs10NsvalHQn9n00zby8jQK0L/mSXP3hvCscx
        GOO07UAl+CAUkObpy0qBUivlU3CwB0Y12pyyzcK75LJCfo7ldGULGAz63gj2D1ES
        E9niaMBK0Hk1rw==
X-ME-Sender: <xms:h4zOXr6c9Q-0-O0Bo4yzzJACxJ5azm2BnDXDaQLlZkSyM_ZtdkJ9zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepieefne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:h4zOXg6NhAHYD_Mz0zbMrRLwKuoqS7rWXpfBWRrIxdFmrYSf2Mc76Q>
    <xmx:h4zOXif7cuBNtJ7e012tt7XyR6vyfXLnvODeAAno27EvmECKOzDbdw>
    <xmx:h4zOXsJlcX0hde2dGO6zcwTpJG7pxsqfSlV5AHiB4hixs2KC0uSEdQ>
    <xmx:iIzOXsp2g4gUrgJhKNMbs2SwdT-DT2jp6tARLqs-d5DY-gqM-iTHTw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A76C83280069;
        Wed, 27 May 2020 11:51:35 -0400 (EDT)
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
Subject: [PATCH v3 088/105] drm/vc4: hdmi: Add CEC support flag
Date:   Wed, 27 May 2020 17:48:58 +0200
Message-Id: <954a94de6ea75165ef0c44ef0298bfa960601885.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to the audio support, CEC support is not there yet for the
BCM2711, so let's skip entirely the CEC initialization through a variant
flag.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++++
 drivers/gpu/drm/vc4/vc4_hdmi.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 7eb3cee25001..27cfcf38edb4 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1178,6 +1178,9 @@ static int vc4_hdmi_cec_init(struct vc4_hdmi *vc4_hdmi)
 	u32 value;
 	int ret;
 
+	if (!vc4_hdmi->variant->cec_available)
+		return 0;
+
 	vc4_hdmi->cec_adap = cec_allocate_adapter(&vc4_hdmi_cec_adap_ops,
 						  vc4_hdmi, "vc4",
 						  CEC_CAP_DEFAULTS |
@@ -1457,6 +1460,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
 static const struct vc4_hdmi_variant bcm2835_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
 	.debugfs_name		= "hdmi_regs",
+	.cec_available		= true,
 	.registers		= vc4_hdmi_fields,
 	.num_registers		= ARRAY_SIZE(vc4_hdmi_fields),
 
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 22100820c81b..20e0f5498f1e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -33,6 +33,9 @@ struct vc4_hdmi_variant {
 	/* Filename to expose the registers in debugfs */
 	const char *debugfs_name;
 
+	/* Set to true when the CEC support is available */
+	bool cec_available;
+
 	/* List of the registers available on that variant */
 	const struct vc4_hdmi_register *registers;
 
-- 
git-series 0.9.1
