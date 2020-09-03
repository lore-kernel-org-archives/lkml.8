Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB47C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCF0206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="TJWMoyWV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R2j1IavA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgICIKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:10:25 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:59641 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728404AbgICIC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 5975CB44;
        Thu,  3 Sep 2020 04:02:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=nf4Nnh/V/qEPA
        cG1Y6/eD3e4S1Pkir0wyrTLONbJPcQ=; b=TJWMoyWVwtLPKWUqL2PAwpurHoTap
        eR6IVc2HGYNYJc14hTPRezoBvLFCTsx135V/XH6a98gaC2hwRhIB5MUnt2Y4o/lP
        SrxVoiB+/ykY4CfxoqhrhkSK2BSJXEf507dWSOAp2a9CzKqwrcnKXs3D+oZILSfo
        NQCSoMrl/odK7lRoboztjeE51pVyd2NjS7c/1b+xDC8ouUCzv/nzmorBje9nqI7U
        PmUgDaemubFjtyrACoXbIPkgcDrNs73YS08qN9UOZ4aUN3upbMAkWb2BdEQBY/+r
        TmJyLkYGi+idxOSyP+g5oFkUTu9FuMgBhPzqvIn0NZ6Jrt7VhztAKC/Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=nf4Nnh/V/qEPAcG1Y6/eD3e4S1Pkir0wyrTLONbJPcQ=; b=R2j1IavA
        0SxHqaG587M1tZfdmz8neKl0RpLkq8pshRFxpJ2N2WLtAToM//cOHWXo1UPG3aO3
        I2BScrc/bh6hfckpsw5W4kDWmbW4A7Zq1deE349dduCSAKEAsPvxwTZ++b72y4QB
        e8REG5m/EZYs55utiacAD6YXUgepbQe/In//2lLJUyb26DCRAqyu5k5hUdeW4l5c
        76YWJfORQbgpGRVZL+viyaXc9EZG6FdlfNhoaIxxLPox0WxweDR9WjCI9K/1x9tD
        CN3BwmNb3FYTc5i7pXFiUOrtrmFLe0MpUvfvbLPQKtM56FsVKZqI9khNhQi+Ufma
        P9idBTey1A0byQ==
X-ME-Sender: <xms:EKNQX1tCj7D83aUbl3nU7ToNAeg3m_wfs07pMVO0OBU0zUCz7-Xv0Q>
    <xme:EKNQX-ced0Ds9_JzJY4xe1HaJHhBqcDEsCFWWgIdFReIJQhn8EL5S0AzeO0wEjt5V
    LABdEJ5UQqxAzu-XCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedule
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:EKNQX4wK0D413Qp1A3LFSzon31AKY3cOlDbw0EmpVSEkm8up3wav1A>
    <xmx:EKNQX8OxAQ6opzALq8tyuY6k05EFTauacF6VfhCdKngF4M3LDoH5LQ>
    <xmx:EKNQX1-mdbLQR_lo7hnNFFSuf88XIppzGNqbidcYV7kDZbqBiqWP7g>
    <xmx:EKNQX8WacnQIFbkSZMpbBFaJOedvWEBapjGZmEL9gcosKS7bgKLtxzTBL7w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A8A35328005D;
        Thu,  3 Sep 2020 04:02:24 -0400 (EDT)
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
Subject: [PATCH v5 22/80] drm/vc4: crtc: Move HVS init and close to a function
Date:   Thu,  3 Sep 2020 10:00:54 +0200
Message-Id: <fb1b5299d1636ddce8340b51a80d51641839f83b.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make further refactoring easier, let's move the HVS channel
setup / teardown to their own function.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 104 +++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index fa61cad3a53d..dde931233d4a 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -196,6 +196,62 @@ static void vc4_hvs_update_gamma_lut(struct drm_crtc *crtc)
 	vc4_hvs_lut_load(crtc);
 }
 
+static int vc4_hvs_init_channel(struct vc4_dev *vc4, struct drm_crtc *crtc,
+				struct drm_display_mode *mode, bool oneshot)
+{
+	struct vc4_crtc_state *vc4_crtc_state = to_vc4_crtc_state(crtc->state);
+	unsigned int chan = vc4_crtc_state->assigned_channel;
+	u32 dispctrl;
+
+	/* Turn on the scaler, which will wait for vstart to start
+	 * compositing.
+	 * When feeding the transposer, we should operate in oneshot
+	 * mode.
+	 */
+	dispctrl = SCALER_DISPCTRLX_ENABLE;
+
+	if (!vc4->hvs->hvs5)
+		dispctrl |= VC4_SET_FIELD(mode->hdisplay,
+					  SCALER_DISPCTRLX_WIDTH) |
+			    VC4_SET_FIELD(mode->vdisplay,
+					  SCALER_DISPCTRLX_HEIGHT) |
+			    (oneshot ? SCALER_DISPCTRLX_ONESHOT : 0);
+	else
+		dispctrl |= VC4_SET_FIELD(mode->hdisplay,
+					  SCALER5_DISPCTRLX_WIDTH) |
+			    VC4_SET_FIELD(mode->vdisplay,
+					  SCALER5_DISPCTRLX_HEIGHT) |
+			    (oneshot ? SCALER5_DISPCTRLX_ONESHOT : 0);
+
+	HVS_WRITE(SCALER_DISPCTRLX(chan), dispctrl);
+
+	return 0;
+}
+
+static void vc4_hvs_stop_channel(struct drm_device *dev, unsigned int chan)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+
+	if (HVS_READ(SCALER_DISPCTRLX(chan)) & SCALER_DISPCTRLX_ENABLE)
+		return;
+
+	HVS_WRITE(SCALER_DISPCTRLX(chan),
+		  HVS_READ(SCALER_DISPCTRLX(chan)) | SCALER_DISPCTRLX_RESET);
+	HVS_WRITE(SCALER_DISPCTRLX(chan),
+		  HVS_READ(SCALER_DISPCTRLX(chan)) & ~SCALER_DISPCTRLX_ENABLE);
+
+	/* Once we leave, the scaler should be disabled and its fifo empty. */
+	WARN_ON_ONCE(HVS_READ(SCALER_DISPCTRLX(chan)) & SCALER_DISPCTRLX_RESET);
+
+	WARN_ON_ONCE(VC4_GET_FIELD(HVS_READ(SCALER_DISPSTATX(chan)),
+				   SCALER_DISPSTATX_MODE) !=
+		     SCALER_DISPSTATX_MODE_DISABLED);
+
+	WARN_ON_ONCE((HVS_READ(SCALER_DISPSTATX(chan)) &
+		      (SCALER_DISPSTATX_FULL | SCALER_DISPSTATX_EMPTY)) !=
+		     SCALER_DISPSTATX_EMPTY);
+}
+
 int vc4_hvs_atomic_check(struct drm_crtc *crtc,
 			 struct drm_crtc_state *state)
 {
@@ -268,63 +324,19 @@ void vc4_hvs_atomic_enable(struct drm_crtc *crtc,
 	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
 	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
 	bool oneshot = vc4_state->feed_txp;
-	u32 dispctrl;
 
 	vc4_hvs_update_dlist(crtc);
-
-	/* Turn on the scaler, which will wait for vstart to start
-	 * compositing.
-	 * When feeding the transposer, we should operate in oneshot
-	 * mode.
-	 */
-	dispctrl = SCALER_DISPCTRLX_ENABLE;
-
-	if (!vc4->hvs->hvs5)
-		dispctrl |= VC4_SET_FIELD(mode->hdisplay,
-					  SCALER_DISPCTRLX_WIDTH) |
-			    VC4_SET_FIELD(mode->vdisplay,
-					  SCALER_DISPCTRLX_HEIGHT) |
-			    (oneshot ? SCALER_DISPCTRLX_ONESHOT : 0);
-	else
-		dispctrl |= VC4_SET_FIELD(mode->hdisplay,
-					  SCALER5_DISPCTRLX_WIDTH) |
-			    VC4_SET_FIELD(mode->vdisplay,
-					  SCALER5_DISPCTRLX_HEIGHT) |
-			    (oneshot ? SCALER5_DISPCTRLX_ONESHOT : 0);
-
-	HVS_WRITE(SCALER_DISPCTRLX(vc4_state->assigned_channel), dispctrl);
+	vc4_hvs_init_channel(vc4, crtc, mode, oneshot);
 }
 
 void vc4_hvs_atomic_disable(struct drm_crtc *crtc,
 			    struct drm_crtc_state *old_state)
 {
 	struct drm_device *dev = crtc->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(old_state);
 	unsigned int chan = vc4_state->assigned_channel;
 
-	if (HVS_READ(SCALER_DISPCTRLX(chan)) &
-	    SCALER_DISPCTRLX_ENABLE) {
-		HVS_WRITE(SCALER_DISPCTRLX(chan),
-			  SCALER_DISPCTRLX_RESET);
-
-		/* While the docs say that reset is self-clearing, it
-		 * seems it doesn't actually.
-		 */
-		HVS_WRITE(SCALER_DISPCTRLX(chan), 0);
-	}
-
-	/* Once we leave, the scaler should be disabled and its fifo empty. */
-
-	WARN_ON_ONCE(HVS_READ(SCALER_DISPCTRLX(chan)) & SCALER_DISPCTRLX_RESET);
-
-	WARN_ON_ONCE(VC4_GET_FIELD(HVS_READ(SCALER_DISPSTATX(chan)),
-				   SCALER_DISPSTATX_MODE) !=
-		     SCALER_DISPSTATX_MODE_DISABLED);
-
-	WARN_ON_ONCE((HVS_READ(SCALER_DISPSTATX(chan)) &
-		      (SCALER_DISPSTATX_FULL | SCALER_DISPSTATX_EMPTY)) !=
-		     SCALER_DISPSTATX_EMPTY);
+	vc4_hvs_stop_channel(dev, chan);
 }
 
 void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
-- 
git-series 0.9.1
