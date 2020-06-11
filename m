Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1938C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A034920823
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="OvrbZUnr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MVI4FWee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgFKNiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:38:51 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:46777 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728196AbgFKNip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:38:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 412E15801E1;
        Thu, 11 Jun 2020 09:38:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 09:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=HRV+MiemGs5P9
        punwbKUb1BmroV4uFiYrY/M08ZBttw=; b=OvrbZUnrN1XMPl+NYr0G56xMCvkUA
        yR62rMDV4X3sx+kTggdcKzq7ftOfX/AP399qKgVN+YLuro3DX19/Wm5rj0096kbD
        vyYH4aiCetl+VnKdBoQC6J4BjnAO+d1sOfbEJqAnvkt2eRtd0CVD9ffIGIu9eE6K
        oLjU2hbLUtjM6Yq/B57oB7gw6a+OKYJjPMCaUbNc3wAvpZCd3rKihfxTeaUkb2Mi
        WkAjw37j49Cd5Knp0+EbcU5paJFeTf0/AS0AAYgkG1vTtlyQcFerT0BgRdtvIk/8
        QWn+D+/Cb/lOOMHp/Mhe0Umn/GfpCOOyvXcoSTa5mZsy0QmZbP2Trw/7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=HRV+MiemGs5P9punwbKUb1BmroV4uFiYrY/M08ZBttw=; b=MVI4FWee
        Lu/UqIIaMDlqJvNoy1LxaHa79NntQv2TL8lPMCXNM5KjEqRpEmeU7bzynnAljL3k
        klftYBku1byMHqmvIOmgAAi5yPUNlYe09mvriT74C42g4GB0KUPPIyoOKwEPY+rG
        AjR908YZXRSTutc17qEVmtFvJeLjwz4c+vdeidYlnhuSD6hQckMNTWoESj5C+YIx
        aWD6y3m/R+MdGwhjOCs82MAXZfHraKC0zDPbQ4ze70CciQnIROjZIleSVdM4Q/lU
        dwlKx3mwXEvQi6NoJJqFmNhgUeAXAmPz7FE7hfkol/yS/lknlCZMyHwRDLQQdWmF
        oMwum5klH5juzA==
X-ME-Sender: <xms:4zPiXmvdOB_rZ9P8vtM-47FwUnCw37kzkxul2egglBa3_FQCLgSnjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehledggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:5DPiXreEvpLw_BAXCoqNa8XcKq34YjijyuWJJx-njKIb3Na3NqfuQw>
    <xmx:5DPiXhxEb6jifXir-a2OMrMWBC1hpe0cnjtRUXV3u_A_n-RWfDk76A>
    <xmx:5DPiXhOURAXpcf_b_WOZg40iJpbpE2_aMfbbW9C3zK2GtCZ9bzTIhw>
    <xmx:5DPiXrOqvnTP2QtBa7Kzg9ppzKvC_qHsYxk4EybcbeBq_8lx9uuD_g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C3D0532801C7;
        Thu, 11 Jun 2020 09:37:13 -0400 (EDT)
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
Subject: [PATCH v4 9/9] drm/vc4: crtc: Remove the feed_txp tests
Date:   Thu, 11 Jun 2020 15:36:54 +0200
Message-Id: <c044daba470fcb1cb57e3d34d88f75325b2ebbab.1591882579.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.c33f5fd8b1b2703081f25398eb879937c9f7ce0b.1591882579.git-series.maxime@cerno.tech>
References: <cover.c33f5fd8b1b2703081f25398eb879937c9f7ce0b.1591882579.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the code in vc4_crtc accessing registers is only meant for the
pixelvalve, it doesn't make sense anymore to test whether we're accessing
the TXP or not and we can safely remove those checks.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 0c9d14c70485..bc417e081f07 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -323,7 +323,6 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
 {
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
-	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
 	bool debug_dump_regs = false;
 
 	if (debug_dump_regs) {
@@ -333,8 +332,7 @@ static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
 		drm_print_regset32(&p, &vc4_crtc->regset);
 	}
 
-	if (!vc4_state->feed_txp)
-		vc4_crtc_config_pv(crtc);
+	vc4_crtc_config_pv(crtc);
 
 	vc4_hvs_mode_set_nofb(crtc);
 
@@ -357,7 +355,6 @@ static void require_hvs_enabled(struct drm_device *dev)
 static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 				    struct drm_crtc_state *old_state)
 {
-	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
 	struct drm_device *dev = crtc->dev;
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
 	int ret;
@@ -367,12 +364,10 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	/* Disable vblank irq handling before crtc is disabled. */
 	drm_crtc_vblank_off(crtc);
 
-	if (!vc4_state->feed_txp) {
-		CRTC_WRITE(PV_V_CONTROL,
-			   CRTC_READ(PV_V_CONTROL) & ~PV_VCONTROL_VIDEN);
-		ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
-		WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
-	}
+	CRTC_WRITE(PV_V_CONTROL,
+		   CRTC_READ(PV_V_CONTROL) & ~PV_VCONTROL_VIDEN);
+	ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
+	WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
 
 	vc4_hvs_atomic_disable(crtc, old_state);
 
@@ -395,7 +390,6 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 {
 	struct drm_device *dev = crtc->dev;
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
-	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
 	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
 
 	require_hvs_enabled(dev);
@@ -410,9 +404,8 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 	/* When feeding the transposer block the pixelvalve is unneeded and
 	 * should not be enabled.
 	 */
-	if (!vc4_state->feed_txp)
-		CRTC_WRITE(PV_V_CONTROL,
-			   CRTC_READ(PV_V_CONTROL) | PV_VCONTROL_VIDEN);
+	CRTC_WRITE(PV_V_CONTROL,
+		   CRTC_READ(PV_V_CONTROL) | PV_VCONTROL_VIDEN);
 }
 
 static enum drm_mode_status vc4_crtc_mode_valid(struct drm_crtc *crtc,
@@ -488,10 +481,6 @@ static int vc4_crtc_atomic_check(struct drm_crtc *crtc,
 static int vc4_enable_vblank(struct drm_crtc *crtc)
 {
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
-	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
-
-	if (vc4_state->feed_txp)
-		return 0;
 
 	CRTC_WRITE(PV_INTEN, PV_INT_VFP_START);
 
@@ -501,10 +490,6 @@ static int vc4_enable_vblank(struct drm_crtc *crtc)
 static void vc4_disable_vblank(struct drm_crtc *crtc)
 {
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
-	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
-
-	if (vc4_state->feed_txp)
-		return;
 
 	CRTC_WRITE(PV_INTEN, 0);
 }
-- 
git-series 0.9.1
