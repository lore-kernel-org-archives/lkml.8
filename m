Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736A6C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D68020776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="hjoZbdM5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="alRPB36B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgDXPjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:39:18 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:36063 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728524AbgDXPgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 1E62A1458;
        Fri, 24 Apr 2020 11:36:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=D8dEwkq3X2WC7
        BWcKxRQwnGqBepwqpcl1orVBKVWao8=; b=hjoZbdM5iJ9p65etstAMDgKox1fxS
        cpuDQA/CkpE2EqKsbdFL3OqSFqnEjw6lQ+sTXY869xvZZhYPXTinWKBrE/+UquoU
        e0a4XP+n+5pIyAyCtbKnRu9DmnzT6leUewls+JiL33XX2qDFL5BZoMVkF6dY48MF
        QD7pvR19ku17n/GTw/mg32anPQFVAF434OL3xzxK0TP8XhPSTjc3M+vIhRGvfI1+
        CCJ3gYP2I5vpVa/rtAfZ6BSUh/l9BLP2p5iWV0iTT31eKypTbj97euhUOR68HslK
        WKazdWaACLxVKPMO31KHSK8G+/IT5CckjX5sjkODCryQfn2KOthI6YrxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=D8dEwkq3X2WC7BWcKxRQwnGqBepwqpcl1orVBKVWao8=; b=alRPB36B
        ZIc4jz8IjnZ//jq7Z4yfWkuaGUl6EgM8HXKFJjbbh+F+L7s/pQnb61rc/4ljuMlx
        X+jPg4iVJNbEoCKTHu79HKw5cfGO3dEfGx9IiFNPBg75VdjJSJ6CJgq9VOrqtJSZ
        6eGR85DsXd4PSrg7yuEWxZlLWBqXnqXckUB08s6Ob14z16iI2cC4MgJ39MoPa+Vh
        1OOMfu1rGWo32FRDe16+yfyAzxuRJBjl4faMokiIRlw9Sh5n8gcr+igjpJh3DAyI
        /u1/fAktdTd430+aoFY+GYgKyVyMUh4eg0Xvp1PbYNBpMx0eCeUfgae4YjoaE+j3
        mneJhfdbc9m9vg==
X-ME-Sender: <xms:gQejXoH60ICcxcvlBs1EFjOrtsuNaF0D17koWYt4IRGnByYBZ0Ducw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeegvdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:gQejXt51wt652v5O4K5TOwJK9stdh56QR3DfLrjkc8xwLNuoHzdWrg>
    <xmx:gQejXmnc_y4tijJOvyDNkQ-BqiDpWlaGqOE2o2wzBRMDX7KrfISKLg>
    <xmx:gQejXg4wOFLvPJlrkK0Dj1JVTGKRjfuA5NjnYXgRVoikN6JLxjG9pg>
    <xmx:gQejXkXr3BDGVyb4K2G4-xZ4fiRaBo6UZlNDx4HKU_Lp9Cr1y6GMYcnXI-w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5E3F33065DA6;
        Fri, 24 Apr 2020 11:36:33 -0400 (EDT)
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
Subject: [PATCH v2 51/91] drm/vc4: crtc: Enable and disable the PV in atomic_enable / disable
Date:   Fri, 24 Apr 2020 17:34:32 +0200
Message-Id: <9256bf0aab60235d3dc0dc34ceacb89df53e9cfa.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VIDEN bit in the pixelvalve currently being used to enable or disable
the pixelvalve seems to not be enough in some situations, which whill end
up with the pixelvalve stalling.

In such a case, even re-enabling VIDEN doesn't bring it back and we need to
clear the FIFO. This can only be done if the pixelvalve is disabled though.

In order to overcome this, we can configure the pixelvalve during
mode_set_no_fb, but only enable it in atomic_enable and flush the FIFO
there, and in atomic_disable disable the pixelvalve again.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 3a15d711ff55..00e6ecf5a6d4 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -374,9 +374,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 		   PV_CONTROL_TRIGGER_UNDERFLOW |
 		   PV_CONTROL_WAIT_HSTART |
 		   VC4_SET_FIELD(vc4_encoder->clock_select,
-				 PV_CONTROL_CLK_SELECT) |
-		   PV_CONTROL_FIFO_CLR |
-		   PV_CONTROL_EN);
+				 PV_CONTROL_CLK_SELECT));
 }
 
 static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
@@ -467,6 +465,8 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
 	WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
 
+	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) & ~PV_CONTROL_EN);
+
 	if (HVS_READ(SCALER_DISPCTRLX(chan)) &
 	    SCALER_DISPCTRLX_ENABLE) {
 		HVS_WRITE(SCALER_DISPCTRLX(chan),
@@ -554,6 +554,10 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	require_hvs_enabled(dev);
 
+	/* Reset the PV fifo. */
+	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) |
+		   PV_CONTROL_FIFO_CLR | PV_CONTROL_EN);
+
 	/* Enable vblank irq handling before crtc is started otherwise
 	 * drm_crtc_get_vblank() fails in vc4_crtc_update_dlist().
 	 */
-- 
git-series 0.9.1
