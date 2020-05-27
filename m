Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8916C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FB12088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Lab361bw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K257Z5g/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390268AbgE0PvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:51:10 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:43533 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390180AbgE0Puj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 318E05820A4;
        Wed, 27 May 2020 11:50:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=VKidWh/xRLUFk
        +z0aZ3qSdUJ5qwcVhi/4K7wFX4ohRw=; b=Lab361bwp8weaCdvQ1Vw2hzig+xSy
        3dpMfc31fNL5pzV5n/gH2Ys4CN1YiPklGiVtvsws+N/QUKhAjc1jcMYIRGgYydVH
        Rch9j0M4Fsf0JNVLkBFJ7z/utJdFK4DyMyyc5sVq2pMQlVQGdAWEnJKA3fiFhgkl
        si9HBDY06GYAIcgGW4x0JkpA1JyGK+DXWJ1kpOeg44LTYcWqU/DIYZP9v2YuNOvJ
        wjxSPNQK1RBnZcv72YbBb1/HNnMomD4GrpRahMz4d6THgym4+vq5serQWIt7D/ai
        GrNxeONND4SKkD6LXx/1pcMTpSk29lA3DVUmaF+yHDME2Lssrqui+TsvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=VKidWh/xRLUFk+z0aZ3qSdUJ5qwcVhi/4K7wFX4ohRw=; b=K257Z5g/
        CApKwqzjdOKRmulXPeNFjZi8NZjj5biiX7HC/FzdcgFFIpCyvjSFJZJK0c/YFbxM
        rBby5VyUiJD5i/6LHhajeuiZ08zuzSlwkBoi2YX5ZectZU6I7zvrVuMWia7n7pbh
        dFZfsxrSyc7FvmfEQPZ6D2C6bpFx0FX3cWg1gQlyBauUQql8PwzaLxc1p4Kle+68
        SeJer/sBc+KOhO6sEmiOtdW846mjD5Xofm0ko2r4bRyQAkjFtHFi4+ZFUzffoOtW
        fUEUqhjmr0QD27ufqKVwgZmqbMttLY2YzH3eTnvxXP+1Iqsk0SWGuXt5PrClmacz
        oLS840lOc1r7Yg==
X-ME-Sender: <xms:TozOXvVegG84VuxgC_Az_ZtNewWWL32HiKyShXtJf4Mgq_Ayeniywg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeefne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:TozOXnmoyhYaoz41JMzjytFh-QDk_ICckmqqJybj08wzoniY2vL_ig>
    <xmx:TozOXrbJkvyvuI8AoSrdV2I2yuyyUvU_R5oRvlHCT08rYUEgrxAYsA>
    <xmx:TozOXqXSZHjK9QOUpFxIpXXHZEn-oPs43I0cxkI7nshcBL8KJHiT2A>
    <xmx:TozOXvVCAwjVHFUvJOH10CsI5G-8945LCchadQmgNrQqBjPXnbjcKQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C73F030618B7;
        Wed, 27 May 2020 11:50:37 -0400 (EDT)
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
Subject: [PATCH v3 051/105] drm/vc4: crtc: Add a delay after disabling the PixelValve output
Date:   Wed, 27 May 2020 17:48:21 +0200
Message-Id: <5935e1b778ec330216a0143646746f9d3b18bfd9.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid pixels getting stuck in the (unflushable) FIFO between
the HVS and the PV, we need to add some delay after disabling the PV output
and before disabling the HDMI controller. 20ms seems to be good enough so
let's use that.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index b3721bce7c81..dee8dc7b9409 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -401,6 +401,8 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
 	WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
 
+	mdelay(20);
+
 	if (vc4_encoder->post_crtc_disable)
 		vc4_encoder->post_crtc_disable(encoder);
 
-- 
git-series 0.9.1
