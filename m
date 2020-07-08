Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440C7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDE9206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="QnD9HeXp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BR6M2hXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgGHRrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:47:31 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:54481 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726774AbgGHRnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id EED85FD0;
        Wed,  8 Jul 2020 13:43:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=PXyOrhteRhuIW
        3gAa3UTeL+v8wa9wTNvkAai0iITr1g=; b=QnD9HeXpBI4112vzPdB+Fcw+vkmZ2
        ToR7uIAdTpegqZ0Ufy8QvbRi0ILu08S5BcbP3hBtWBqoB12zDrwUTasAOHbCWU2f
        s2IkjV58BeWvNoB1NrCnuo7w5QNaEX/dDDs35KApVJ1rrdLT3ry0n2A2d+IMQ0UT
        AZLD3pbc5osrVQvl0YLvObB4xQXs/cmBXv1Fs2cUBhhHCvoul7nn7gNuFxdmDZU8
        3sxvLZAYZSV83qrWGXJrG1mhzOruBiDNDmsWBDdhe9NXbaOMYTahy+nRXcvj+p19
        WGFJyXG53e4BbLfmm1AaYpHWcc/bfQmyFHXob9h2dCVTKILKUL/vbze6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=PXyOrhteRhuIW3gAa3UTeL+v8wa9wTNvkAai0iITr1g=; b=BR6M2hXu
        BEw0yS+B9mXUo2bHdvMcpMacVV2VZjqF6VqXMFTOc+JZc/MubTKUNTFjXPSb2LQA
        xbBVAH/WF9QaY4bpic8/E1en4qtJShcV+SXKcDqp+yloZ9nMxOvhA8jEWICfytn0
        7rjp/tiwKTi+e6/ApMX5QQOyAEPCFo4qWwBOa8Bndx3fKHGCsMkhPr8GqSmqWJtl
        lviu2hx0XV0/UyzuTt/G/y9HW43j7+OBhSA5Nwk6bo2cGCyaa8bOsgi8OynqUEZt
        kIlrEEW5EgjXc7VIoai3ajGVRm+eSuKjjEgrsli3gwsJsXNMAib8cDODe+FnS5IA
        AkrSWff5lGSrFA==
X-ME-Sender: <xms:pQUGXzxlQBAHEaXMtdqROMu1d5ND1im7slR88m5hGwjT68uPdYTKgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudelne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:pQUGX7QepWn4Xu8m4TutUrwXcRa5KWSbpubHdge-ZeqqgaD6Ooiz0A>
    <xmx:pQUGX9UiNLKAc9v2wzgACmxm_mpcMvx3ACfJgNacniFRlojhPpd5yw>
    <xmx:pQUGX9ievc6OxYiIpkD_s8VfOFnnuPJjZcDFQx8GnsQPK-VaoLbQTQ>
    <xmx:pQUGX_C9I3l_EDjcdGogw7tz-dOczlfA9ooiueSx_49yuIk86-kSrCM_K_s>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4859D30600B7;
        Wed,  8 Jul 2020 13:43:01 -0400 (EDT)
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
Subject: [PATCH v4 21/78] drm/vc4: crtc: Move PV dump to config_pv
Date:   Wed,  8 Jul 2020 19:41:29 +0200
Message-Id: <bb369aede3a6d0463805faabeb5f598a369b54bf.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we only configure the PixelValve in vc4_crtc_config_pv, it doesn't
really make much sense to dump its register content in its caller.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index c2ab907611e3..181d3fd57bc7 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -290,6 +290,14 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 		       vc4_encoder->type == VC4_ENCODER_TYPE_DSI1);
 	u32 format = is_dsi ? PV_CONTROL_FORMAT_DSIV_24 : PV_CONTROL_FORMAT_24;
 	u8 ppc = pv_data->pixels_per_clock;
+	bool debug_dump_regs = false;
+
+	if (debug_dump_regs) {
+		struct drm_printer p = drm_info_printer(&vc4_crtc->pdev->dev);
+		dev_info(&vc4_crtc->pdev->dev, "CRTC %d regs before:\n",
+			 drm_crtc_index(crtc));
+		drm_print_regset32(&p, &vc4_crtc->regset);
+	}
 
 	vc4_crtc_pixelvalve_reset(crtc);
 
@@ -359,30 +367,20 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 		   PV_CONTROL_WAIT_HSTART |
 		   VC4_SET_FIELD(vc4_encoder->clock_select,
 				 PV_CONTROL_CLK_SELECT));
-}
-
-static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
-{
-	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
-	bool debug_dump_regs = false;
 
 	if (debug_dump_regs) {
 		struct drm_printer p = drm_info_printer(&vc4_crtc->pdev->dev);
-		dev_info(&vc4_crtc->pdev->dev, "CRTC %d regs before:\n",
+		dev_info(&vc4_crtc->pdev->dev, "CRTC %d regs after:\n",
 			 drm_crtc_index(crtc));
 		drm_print_regset32(&p, &vc4_crtc->regset);
 	}
+}
 
+static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
+{
 	vc4_crtc_config_pv(crtc);
 
 	vc4_hvs_mode_set_nofb(crtc);
-
-	if (debug_dump_regs) {
-		struct drm_printer p = drm_info_printer(&vc4_crtc->pdev->dev);
-		dev_info(&vc4_crtc->pdev->dev, "CRTC %d regs after:\n",
-			 drm_crtc_index(crtc));
-		drm_print_regset32(&p, &vc4_crtc->regset);
-	}
 }
 
 static void require_hvs_enabled(struct drm_device *dev)
-- 
git-series 0.9.1
