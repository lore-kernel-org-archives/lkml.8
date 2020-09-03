Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F6CC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50DA208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="JEhvG2WO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EBDgqzBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgICIKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:10:20 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:47753 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726855AbgICIC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 1C96E71C;
        Thu,  3 Sep 2020 04:02:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=aEsQ08fyVOqPR
        xtaaHbqqvuWfFNPcJ0b+TEtARhaZ6o=; b=JEhvG2WOj60Br1O5krvRDZHBtWWCR
        Mw0PWB1rxv/oYA0bRmzwg+RIOhYxcgS0XGmVpbEfuMO2BiMhIvboBrWjtpUHoMCw
        3QwjKUxNmtHiUD74R1IbLitasUpdGFblBVprsk+dDgtCs0dnRhk2j57KYUpzFArg
        hV1awzsfpxTG2Ee+6oa6a3sF0HxepKMJbnUCCvbLOWl2+mL7KQcXokEkqbimKRiu
        1LtxoSQt4xHSveZK5aguYfwPoeboa0CQDavQo+igDzAzVv8s19x1BrpMUV6FjATx
        ZHeEmsaxTvXhWsw+vluQ3WsR5pPjAObbic7b3cO9BZZuX3nLG44V/KimA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=aEsQ08fyVOqPRxtaaHbqqvuWfFNPcJ0b+TEtARhaZ6o=; b=EBDgqzBC
        DiQAuM2sU8WnKTQxdRWvpAnu3FD5yYmca44v45WalAXOZbiR7IOwQiSKhH0i6seR
        +3NmDj/HJmziCBnnJSiCc2TAsBY+1bM/P223BCUffoFvP7c1jppx0dYh44nyPfbe
        /xGmnQdfknhy09rejgJmkMfM4fs8px+gqRLYyZefAiB+tnLcYzFrxl8bef1O1Yj0
        zxFM1Sza9oZKnlHKkrt/EmQT6qrS0v65S47VHeMB54qBKvPk97x2e+xwxdY4eI+X
        HizYqknzTkmPPwvtPfAP4EGzK5XQ+a5gl7RFFuKFOkE+q4DB6azV6/CBDK20NDCl
        OhYnw3xClf5l7g==
X-ME-Sender: <xms:D6NQX1R6jRFa5kcNWUVbKETnH9sMlKF-APDziuowqaY3XPCG8DT2xQ>
    <xme:D6NQX-ypinpvb3WNW9fnJmMw4I5sBaI_vRyk6Ermx62-MzcxwenmMIb1ineyCubzP
    Z1t5Smezeu4ql0Z3K8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedule
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:D6NQX625pAb-rb5s_eFw0kozbKhJeBZEtjr5E4gvc5rGc2s54bDNYQ>
    <xmx:D6NQX9DoU0mTSih6WDybhlcB0tp7ghbiEW1AUIP_iRmfKoUKHcGxJw>
    <xmx:D6NQX-jE6NfT3pwaWimWGVH5ljs5yyAOOhw5F5NOiyUPxx_ja41VMg>
    <xmx:D6NQX1rwpzRzV00rUNdylSFXHsEJOkWbHZZU9XKdPJXIcK1Mm3Ql7ZUszt0>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 55556306005E;
        Thu,  3 Sep 2020 04:02:23 -0400 (EDT)
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
Subject: [PATCH v5 21/80] drm/vc4: crtc: Move PV dump to config_pv
Date:   Thu,  3 Sep 2020 10:00:53 +0200
Message-Id: <c195af7d9e140a2a6db32992ee7e54071c6f94ba.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we only configure the PixelValve in vc4_crtc_config_pv, it doesn't
really make much sense to dump its register content in its caller.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
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
