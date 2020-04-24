Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5190DC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C02D20700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="RwVX+1B9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vzRELBnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgDXPjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:39:41 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:42017 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728542AbgDXPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:26 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 641D11455;
        Fri, 24 Apr 2020 11:36:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=LUAe46DKtlxCq
        U2VS2C+5d/PvMZLtRpuEhcOyjk+c30=; b=RwVX+1B9OA/srJw37QJB3iiXChfuM
        asx8fXht1FiowpngTs6ODwRvpDjIwkaULvBqF/yCGReqo7om3mUOXH7pOrC66AoJ
        45AZP74X9yYTAQNGRLRLs7NSoTc2/cIoFYHNXcRKcsNWj4B9TaZVgoe9AeafL/6D
        Lcr46bKmNwr27/7oGoR2TGo8tgCI4v2sxUDYE4KOSaSrdLQV9sA4A3tUTiSGeT35
        B3idDAAixVeHaVC+HVRAKRKRuM0LPj82vBuEJgOHBDENqg1JaEoYW5WUG6L4N/5b
        tEsabNYeROYQIKDNaFD6kl/+i/Q/7sJQ8aTmUayhwi60C2ldVTkDPcnGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=LUAe46DKtlxCqU2VS2C+5d/PvMZLtRpuEhcOyjk+c30=; b=vzRELBnH
        0G9CZAvV+IOE7HtqvkHvEL1xK9xzfojsxjBFGzkNY/CoNRBy0amSneXM5k363aRs
        75WeGE/HWm52UaH2F0oyBtYADqpozbDuKZUdRVdVol+OxNOsiq7AAvXWRUsoZOWR
        osLecQrFTdnmnl8Ek3mrQ2MZsdI3KW/uhMc/DgCeji/cwPmUUnuk3bKr/d/P2BSE
        q3zkuEPhBfjP8HtaOpPEqjCP1E2wEVS08AfX2jrX3d6nZsQhFELMc0H0B2HIdGtq
        PycoFfY/vde1GzmfUWy3BCQhTZ/K4wHKw4yOtpLMU9+YaFV4XAp079FqjulpRdo+
        J6jmqIGC/QCUBA==
X-ME-Sender: <xms:dwejXqEQPyqJ_Alwe_T5jhc_TbStR12Uk6gA0DrwSDjKv4z8opvjHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeefkeenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:dwejXq6k8XxBiWqlr6_XvwMMH63jyHJtUNnbxXfDxEPzIe_eyXgqmw>
    <xmx:dwejXtj1in1d-mnb1vzMmcqXs1JKbdcuwC4vGyXBCMWDe6ByLklyiA>
    <xmx:dwejXs4kkGwxRrAVklFJ68i9b27IPPGH1qKxQWpXCwHut4kQmAMYFQ>
    <xmx:eAejXu14tXKiIAyLPkOTWpZ3s9pvUgO8QVxVZDwxuAqv2Erzk3UtS-nZvMA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A5005328006D;
        Fri, 24 Apr 2020 11:36:23 -0400 (EDT)
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
Subject: [PATCH v2 44/91] drm/vc4: crtc: Move crtc state to common header
Date:   Fri, 24 Apr 2020 17:34:25 +0200
Message-Id: <f35f7b428667252f35bc4a96e7dc08da3732bcf2.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll need to access the crtc_state from outside of vc4_crtc.c, so let's
move it to vc4_drv.h

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 21 ---------------------
 drivers/gpu/drm/vc4/vc4_drv.h  | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 9fdb0ccc4a28..9718df881fab 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -44,27 +44,6 @@
 #include "vc4_drv.h"
 #include "vc4_regs.h"
 
-struct vc4_crtc_state {
-	struct drm_crtc_state base;
-	/* Dlist area for this CRTC configuration. */
-	struct drm_mm_node mm;
-	bool feed_txp;
-	bool txp_armed;
-
-	struct {
-		unsigned int left;
-		unsigned int right;
-		unsigned int top;
-		unsigned int bottom;
-	} margins;
-};
-
-static inline struct vc4_crtc_state *
-to_vc4_crtc_state(struct drm_crtc_state *crtc_state)
-{
-	return (struct vc4_crtc_state *)crtc_state;
-}
-
 #define CRTC_WRITE(offset, val) writel(val, vc4_crtc->regs + (offset))
 #define CRTC_READ(offset) readl(vc4_crtc->regs + (offset))
 
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 25466aa9dceb..487ad72c284d 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -486,6 +486,27 @@ to_vc4_crtc(struct drm_crtc *crtc)
 	return (struct vc4_crtc *)crtc;
 }
 
+struct vc4_crtc_state {
+	struct drm_crtc_state base;
+	/* Dlist area for this CRTC configuration. */
+	struct drm_mm_node mm;
+	bool feed_txp;
+	bool txp_armed;
+
+	struct {
+		unsigned int left;
+		unsigned int right;
+		unsigned int top;
+		unsigned int bottom;
+	} margins;
+};
+
+static inline struct vc4_crtc_state *
+to_vc4_crtc_state(struct drm_crtc_state *crtc_state)
+{
+	return (struct vc4_crtc_state *)crtc_state;
+}
+
 #define V3D_READ(offset) readl(vc4->v3d->regs + offset)
 #define V3D_WRITE(offset, val) writel(val, vc4->v3d->regs + offset)
 #define HVS_READ(offset) readl(vc4->hvs->regs + offset)
-- 
git-series 0.9.1
