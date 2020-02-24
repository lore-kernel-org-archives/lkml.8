Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33798C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACFA2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="pTcRE/I0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gczqBYVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgBXJKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:10:06 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:44179 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbgBXJKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:05 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 542BC640;
        Mon, 24 Feb 2020 04:10:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=6D5T1d7y5fxMd
        S6cnWRcbbrJasqKee8D3owRLLLLrU4=; b=pTcRE/I04R4ix2OVkDLGLJIX0Id6A
        vjodw6TlPQJvnvI9F4NIwqcsN2fkOgBwSGQCSLCmvM6PLsVdRV5OY/6c8SGPpESK
        aavZ9L1AyeJ9qUHeu8SWw03/dxkCAhZ1g2eEHa5wWzBESqa9ssbqX1H7RtbL9GQL
        pQqD+nmzbxsYN2cfUCwo0q7vDvXUJvF2QurTcqaxsppiW/TRSJU/5LP2dTqNLOJS
        0o2VvDe0/vBCTLc4U/xniSPPJqzHARI+OTHW2fFdQRKQcn63AFlB8fYpRu+FeFVz
        mg6/NG/+nhM5AF1AWFeXc8shUy/Uq02fyzwbON8baxnulQXcheftikKPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=6D5T1d7y5fxMdS6cnWRcbbrJasqKee8D3owRLLLLrU4=; b=gczqBYVG
        2BZMIPNzkjV3jFcTYvtUTMobSp8zYoWzhdCDnwEuv4dPNy2TnuSkrTitNAJRZkxQ
        V1TOw7wcv+yVH0m1smtNH/4NqzeiyJdLuNKzknBljyns4WuwVgy7KYwzrEsNgeJ1
        QcQugDTOngYQDVFx/spwQihBuBS6KjhdDhiilkbwfMy6pPsNv1SgZY/NDgcJtAZv
        r9HjS2Mi/RTJGYLJl1dE+62V1UR37aSzbvIJFstofsq78iSshYtmR5CQznzsgFTx
        FV2QSnnjZ/QUpryg5QQHjloRohNQ1+LJIeLbFEEUUB9NIT/K2WRvGwXVfwOLma7W
        C1iLS0fyiB36PQ==
X-ME-Sender: <xms:6pJTXk5jF7nGfGgew3GNt77jywJ3W_GmrZSRa-z8z32fUuq43jQ_sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepgeegnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:6pJTXti373Xo2X-CD8VxhYgpk2HFpzSP_FZKDESCM5SV5aeDhBYotQ>
    <xmx:6pJTXhFSxu9hNs5787_FXBTAfvL8pWGrQS1pG-pQOlW_vp_vxLfU7Q>
    <xmx:6pJTXjT1ZD4yKb1xt8nJddQzPAv--bKP5ctlp4-joggHeXXNiDA83A>
    <xmx:6pJTXtIVBAJ-3LK7qX-1Ce4RzPm1GJhQHDNgq8Taqm6e-8TG7GOObAiIUSs>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8FF1430610E8;
        Mon, 24 Feb 2020 04:10:02 -0500 (EST)
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
Subject: [PATCH 51/89] drm/vc4: crtc: Enable and disable the PV in atomic_enable / disable
Date:   Mon, 24 Feb 2020 10:06:53 +0100
Message-Id: <d225a3959de98632dd5a649c1fb53978adb15f31.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
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
index d3ff32daf60a..25add62080a1 100644
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
