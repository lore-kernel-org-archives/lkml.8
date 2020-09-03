Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111FCC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D515B206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="bd8CKEZX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jw8L1QSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgICID6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:03:58 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:36085 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728365AbgICICQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id C3862B0C;
        Thu,  3 Sep 2020 04:02:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=2hvjXzd8CFbPx
        5ytRx4X/tmO5bn6lzgqZvU0U3Sznsg=; b=bd8CKEZXF3reaS1lv6djW9V8Zln1A
        oU5MjRr3h/p9owmjdmeoZuugfrntTGwPp3nCvW6g3pV3q3kRSHRJKxXQRaB6t3Ow
        XhVJIycm77F4hYLK7YkTO8XhAiTAu70SZ/MIqSisGI/z9Teei4Lbs0E1yew0ewMD
        RgV/vdXPi6Ai9DqN0ACo/JZB9MWVqRO1pHYRbnUGNzujuTP5X+Np2WCfyhDPUrlm
        F1j7Mh5/+zoYYTyBOdfunJTKGKM4b9GADNulZWKEwS9jpmxzCdJuZAJNfeB7eSx1
        ETK0rcodrBZpKCxDKKRJgh/FxXxgkBXKG6ngbYGaZCgniSqeXy8wW4itQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=2hvjXzd8CFbPx5ytRx4X/tmO5bn6lzgqZvU0U3Sznsg=; b=Jw8L1QSY
        cv3UT+tsa5JQBblvFwO4c6dwAhNYGw2PR9hCR8REjGU0DPnu1oObDH+ho7QRT0WZ
        W3hDBibq/HpwTM8xPJ6Aebb5987rKEsEljLyCidCNIAyW5DgzUWmE3TcxXBM8Dub
        UnMoSTmztst5VN3dJllXSDPwSA8gXb10vmh2KYug66Q0sn7rkh5nDg19BedGBkvl
        3ycX0gJDaIAiHL3QIFFL43QdEMSnVi/zWsa2jUHnyfUgHeWs6Z6ftdp1BQ3sX5Lb
        jsZYZbSm8/RYufSmizkKVXx48ejeRbgNjUKigDinZ+QLEXNiChUZsRh1VXPJ3Gfv
        Znbe+mCUnKAK0w==
X-ME-Sender: <xms:A6NQX4fD2-vkL28QbqaakKXoV7aD89_AIy1w_lB540DdzW8GpqrwEw>
    <xme:A6NQX6Omp3jN_vpgmyb24PJyAd0IZ-0OZnZ1Zhxb4eXSUBzPwNsiovM61I5fAC4lf
    uz1HCOKfGBBp3xmiiI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedutd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:A6NQX5i9vO5sTujzRv2Y5qzsInqkCvC-3iTXfCtmbDd_KazU1BVYlQ>
    <xmx:A6NQX9-1thUkDpID09sqPbh7TRYqOL1NJd0LALp-UA9oGjImxKWCFA>
    <xmx:A6NQX0uOCa4N9K634MM_3oj386Q6nfD7tDzwRllgWx7rRJJ1ntq_vA>
    <xmx:A6NQX0E5CxgqjP55COh7CcDZV2WtdsV19AcpS95qUYA72Ua2wGarTQEBdPM>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0B3DA328005A;
        Thu,  3 Sep 2020 04:02:10 -0400 (EDT)
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
Subject: [PATCH v5 12/80] drm/vc4: crtc: Enable and disable the PV in atomic_enable / disable
Date:   Thu,  3 Sep 2020 10:00:44 +0200
Message-Id: <e97596f62f4df83424d994a23465463ac60f986e.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
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
mode_set_no_fb by calling vc4_crtc_config_pv, but only enable it in
atomic_enable and flush the FIFO there, and in atomic_disable disable the
pixelvalve again.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index cdeaa0cd981f..fe2e5675aed4 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -332,9 +332,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 		   PV_CONTROL_TRIGGER_UNDERFLOW |
 		   PV_CONTROL_WAIT_HSTART |
 		   VC4_SET_FIELD(vc4_encoder->clock_select,
-				 PV_CONTROL_CLK_SELECT) |
-		   PV_CONTROL_FIFO_CLR |
-		   PV_CONTROL_EN);
+				 PV_CONTROL_CLK_SELECT));
 }
 
 static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
@@ -386,6 +384,8 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
 	WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
 
+	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) & ~PV_CONTROL_EN);
+
 	vc4_hvs_atomic_disable(crtc, old_state);
 
 	/*
@@ -410,6 +410,10 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
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
