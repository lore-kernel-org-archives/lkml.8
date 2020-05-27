Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14673C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE5920776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="WiIW7Or2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MtF8OMy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390572AbgE0Pyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:54:31 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:60073 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390342AbgE0Pvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:51:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2498F581505;
        Wed, 27 May 2020 11:51:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=3+zDc9lTxZ95D
        Zq2DjYcpdZ0XDPW3I9hVIKy3fpBFXE=; b=WiIW7Or2XQ2o69kz13E2uXS0/1aKZ
        N4+fenXfWiJcboN9PbwtV+4xVq6gDux6b8vMVqgscUDRsSY5Ip23g7MYybDQCFy4
        c/qUMO71sKtXUiDfCI/Wf+TragpHZfB6mculEQtHDk0jZmCenoTWyU8JgERD63FV
        7NPCWeNJmH0fQvn5K4K37wOaS9keWNvJq5t99H+pYetWX2zL3ZHOF253W3zCenJM
        daBeKpGJKA/XDnQo04rA2pabB2bhep4tIQgaXF/hPUj9f41UGXLxmOzXPZIYT6rq
        5rurRg1rpcnPm68ZhfmcILIE5fK23e/rXz+oCCV8j97PKdV84A3Mxc17A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=3+zDc9lTxZ95DZq2DjYcpdZ0XDPW3I9hVIKy3fpBFXE=; b=MtF8OMy6
        03/sCddXj1x7uxh7uLyQsfpsiR//FPiUvzvFT7r+ZFz8PQ4gCQKBvb4Sqi6HTZ7C
        Ez4CnIOCKQYzHYPmddg/JkKMpaN5DxIfcy4XN8R2pUWr7yEqQ3UF0hUUqbqqX0fY
        BynbtPlabrTp4JlgMtP+Pa2mEyXvKq98CyGNYYmIjDHj/3zLnQBhb0/URQC7fiQE
        tU9r2pvckAfYYY+HXmQigNJ4H0uU734geT9SqoYg8LWsQ+W4/wj0LQQQC6Vaz0CL
        IYEA6V+XXv+ek2KWhopgF/sK5y15sFTFPj0K468shMWOKFxcfvdvnl/JbqacXQGB
        6jhMMZEkxps0MQ==
X-ME-Sender: <xms:iozOXpMfr7uhRZFGocsWjEvM3Oxc0H9SKwW-1TxTwdnC7yaEVMhkXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepieejne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:i4zOXr-faB2rga6JTY5H2ZP-CFH9AdguHRYDc5JxKTaHZaZ-pzYjuA>
    <xmx:i4zOXoT2hWKWCvE8s5NtafX8paGkcWVnWRjV8lQ1eDUeUaufDAo8qQ>
    <xmx:i4zOXlv6F006h0xR9YkIsdKQcQweOd5yj5ODrmjdyW8KI4mjw8F_sA>
    <xmx:i4zOXruXxT2DOBjj8timRIR01DHr5LD6dqpvHFzPM8It-DlPtLw1YQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B77A2328005D;
        Wed, 27 May 2020 11:51:38 -0400 (EDT)
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
Subject: [PATCH v3 090/105] drm/vc4: hdmi: Rename drm_encoder pointer in mode_valid
Date:   Wed, 27 May 2020 17:49:00 +0200
Message-Id: <dcd79c893c993715b4bd2bedb664d6a4bd683e01.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mode_valid hook on the encoder uses a pointer to a drm_encoder called
crtc, which is pretty confusing. Let's rename it to encoder to make it
clear what it is.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index f62b488c5bdb..e816e5ab9a51 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -556,7 +556,7 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 }
 
 static enum drm_mode_status
-vc4_hdmi_encoder_mode_valid(struct drm_encoder *crtc,
+vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode)
 {
 	/*
-- 
git-series 0.9.1
