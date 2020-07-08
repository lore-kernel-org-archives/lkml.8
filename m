Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0707BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC474206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="C5fXrxXz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tfzUl2aX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgGHRrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:47:39 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:44571 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbgGHRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 9A166109A;
        Wed,  8 Jul 2020 13:43:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=2DNYT+KW0jTFQ
        R7mioJ1fyOUuTasDluGNig327NCFQ0=; b=C5fXrxXzU+KvuQLZ6Cvm7AhQ0uM+s
        J/xvrTgOmoSEfm+ZtALWn6dMVB1Ub79uY+zh4bqYIxnBMpjA4vVsn52pVN++bIjz
        +VrCPzJlnb3z6mTiZokfHsZ5jkZi+c/4rWNJJiBWpfO+J33W60/fGjPOypDVTRA5
        OQ5RhpKCDGmo/tk8m99lyK0iGYVXAB01xQRXM7Ii4pXieIenV4v/bhmpPOv1EjCh
        XpJmJOnI0cBkpGpJqQTM4b1cOpcOEj+RZ4HUwl43nrTYDN1uQQv/UIIw+lZIHdHv
        WmeEJpmoI2UgSV5ZwdQkByLSv79PFksFVRJh+Yqalj9pCTN3yASI3kQFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=2DNYT+KW0jTFQR7mioJ1fyOUuTasDluGNig327NCFQ0=; b=tfzUl2aX
        5MAdmSleobEM1s32omF7unYtP9O30bOLm9Iv3zcmkeuYt4Y6YqHED55oUS+qyekH
        se25HUznaztnGIxWbFoAWCBiEY+3xPN+muEGUCkelEU7mZDO/cE0/RbViAAvsBHW
        CMRkowAbkfNN+RsZ8tSEG5sZtNPVabhmbngUCh6Ze2c4kU9N9b+cFNAmY3eiDvR9
        MgxC4f+HtdH1VRkkIUR5jXxYSYycbWhvu+JDPH6rOYhaNvy7TCAWD7WvRDCNTh/r
        y0fO4w246A8MU6gICeaDsniyu/H9zr42T1Im5L9Y2fg9PVW4ZLyjwwVLdseZ77I2
        jtIllrK4SJeEAw==
X-ME-Sender: <xms:pAUGXwmnTJI09qrK_4DOagO_MsVrWmeQu8A7jk_nnN8eVM2VG0_Qyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudelne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:pAUGX_1Q9zqvRzq2qj2k7URhg6ceA6w2vEPtJ8MqOmQRp75SAZh8ow>
    <xmx:pAUGX-ohrVQG4xi2LaKWiZWc0WsRGr8NP2IhBLxdAdZO6wVNTemhww>
    <xmx:pAUGX8kYyw4U69TUF_GNAUI4IDJ5uxwti1mzEog3adIPWpRcF3QFZA>
    <xmx:pAUGX3kUe2y8AAbPZh3dQG_YWfBq65WrUyoN-T3up6Tr85u1CzrdsNcqG1k>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CDFC13280063;
        Wed,  8 Jul 2020 13:42:59 -0400 (EDT)
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
Subject: [PATCH v4 20/78] drm/vc4: crtc: Turn pixelvalve reset into a function
Date:   Wed,  8 Jul 2020 19:41:28 +0200
Message-Id: <0c7774f65f428a63d2e615ac823494393e80db71.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver resets the pixelvalve FIFO in a number of occurences without
always using the same sequence.

Since this will be critical for BCM2711, let's move that sequence to a
function so that we are consistent.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 41bc61d5a61f..c2ab907611e3 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -267,6 +267,15 @@ static struct drm_encoder *vc4_get_crtc_encoder(struct drm_crtc *crtc)
 	return NULL;
 }
 
+static void vc4_crtc_pixelvalve_reset(struct drm_crtc *crtc)
+{
+	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+
+	/* The PV needs to be disabled before it can be flushed */
+	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) & ~PV_CONTROL_EN);
+	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_FIFO_CLR);
+}
+
 static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 {
 	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
@@ -282,10 +291,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 	u32 format = is_dsi ? PV_CONTROL_FORMAT_DSIV_24 : PV_CONTROL_FORMAT_24;
 	u8 ppc = pv_data->pixels_per_clock;
 
-	/* Reset the PV fifo. */
-	CRTC_WRITE(PV_CONTROL, 0);
-	CRTC_WRITE(PV_CONTROL, PV_CONTROL_FIFO_CLR | PV_CONTROL_EN);
-	CRTC_WRITE(PV_CONTROL, 0);
+	vc4_crtc_pixelvalve_reset(crtc);
 
 	CRTC_WRITE(PV_HORZA,
 		   VC4_SET_FIELD((mode->htotal - mode->hsync_end) * pixel_rep / ppc,
@@ -430,9 +436,9 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	require_hvs_enabled(dev);
 
-	/* Reset the PV fifo. */
-	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) |
-		   PV_CONTROL_FIFO_CLR | PV_CONTROL_EN);
+	vc4_crtc_pixelvalve_reset(crtc);
+
+	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
 
 	/* Enable vblank irq handling before crtc is started otherwise
 	 * drm_crtc_get_vblank() fails in vc4_crtc_update_dlist().
-- 
git-series 0.9.1
