Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9635C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E8020897
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="N2vxPO3v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GIx+nOIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgICIGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:06:52 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:57303 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728514AbgICIDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:03:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 78FA7C26;
        Thu,  3 Sep 2020 04:03:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=VYJZcnm8n2qDk
        ZAdxR7ODSjHKgxZo7hKnnWaOrgEa9k=; b=N2vxPO3vw5Jt6JUp6PkAFUcA3U1j9
        fToR2qtgbvqY1sALE1xs49YUS7bsKGEA/9NJdFd+W8SXHqFa0GaE7t6cozNzgX8Q
        p3PNVnrPQpx11EzUNzQz9ONcd7/nXIeI16pJrIBx1b1ccGEFjBWjv+aLmWxboq6W
        O3SJshQimwXxvAMl2PX+Fu583k8DrJO+H02wkvBjayrLJZSwn7uuo1Y3YojTdFiQ
        wYoD9yzpE38QYnFpvaTvxNHAUtOapH8/oG0sBIvOalu6G4avDnpRAWFm+ZDBdGnk
        3mwpN9mtTgVPqA9nGdXyW20fqtp44knVwA/p8lIkbtHFf8yZF8PWA4gRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=VYJZcnm8n2qDkZAdxR7ODSjHKgxZo7hKnnWaOrgEa9k=; b=GIx+nOIJ
        NNTRGzHU9EE5UqJPmBCFWDPkuG2wNt5ag96u3mnMA44YyPzIsM7kqzCaoLUWLT73
        FwFTI+lDEMWL0xVVfNiglaYJSqAh10OvTUTjaImBNwPS5A+5MpHxiRIjKpI9S+j6
        SAczhBVBxh3E3hIsgVDKVV2/DxhBTKfErAODrVSYmOl2rz6+lTIz9ye21AC3euHv
        IQb5STtX8gn0etd/U3R62HcZN6WuAnwngaAyrJ60ssHp7MM1InUmPtYCzTo8Ef/9
        MEvivUI1aUwlNY9snUTc0b6xgEMCDcDxUPBQpjBtEjnX08FGpf5mH0DvT1vGLN+K
        JuLgETCW9lx6nQ==
X-ME-Sender: <xms:WaNQX2ROdYKNcLc-Yc2JpPteBwn0g07quwsTkyFT0Z_sdAkBnzzcNA>
    <xme:WaNQX7xUhjSLUoYaqFcK60fHzABLA5QcriRKDCiU3tL4irNeKJ5IamwbdJZR-r89P
    xiqbZ3iCuZrpadcgPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeeije
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:WaNQXz1UAyqSkXVXbq56bEEC14-WVnjnWiWcOkSX7Oy78POw_7t_oQ>
    <xmx:WaNQXyAYObTdDe7VDWKD_iy2GtdIGH-eQsRmPKOUqPjJ7QKrd-5GRw>
    <xmx:WaNQX_jJv0HF1KiFZ0e-9ntGVET4zpaEEnOrSPkKd7ImWk1FX05Qwg>
    <xmx:WqNQXyoMM7LL85SswU8gaUJGMD6EMZjTFEGx12gu8fi6q60efLBmP_D5dmY>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A7A673280064;
        Thu,  3 Sep 2020 04:03:37 -0400 (EDT)
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
Subject: [PATCH v5 74/80] drm/vc4: hdmi: Switch to blank pixels when disabled
Date:   Thu,  3 Sep 2020 10:01:46 +0200
Message-Id: <fde3efb1ad79f4476a73d310cbba3ec07dc6dabe.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid pixels getting stuck in an unflushable FIFO, we need when
we disable the HDMI controller to switch away from getting our pixels from
the pixelvalve and instead use blank pixels, and switch back to the
pixelvalve when we enable the HDMI controller.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c |  9 +++++++++
 drivers/gpu/drm/vc4/vc4_regs.h |  3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 8bf69cafdd7e..ab7abb409de2 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -325,6 +325,12 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder)
 	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 
 	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, 0);
+
+	HDMI_WRITE(HDMI_VID_CTL, HDMI_READ(HDMI_VID_CTL) |
+		   VC4_HD_VID_CTL_CLRRGB | VC4_HD_VID_CTL_CLRSYNC);
+
+	HDMI_WRITE(HDMI_VID_CTL,
+		   HDMI_READ(HDMI_VID_CTL) | VC4_HD_VID_CTL_BLANKPIX);
 }
 
 static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder)
@@ -563,6 +569,9 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder)
 		   (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
 		   (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
 
+	HDMI_WRITE(HDMI_VID_CTL,
+		   HDMI_READ(HDMI_VID_CTL) & ~VC4_HD_VID_CTL_BLANKPIX);
+
 	if (vc4_encoder->hdmi_monitor) {
 		HDMI_WRITE(HDMI_SCHEDULER_CONTROL,
 			   HDMI_READ(HDMI_SCHEDULER_CONTROL) |
diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
index d1e8961edaa0..30af52b406f1 100644
--- a/drivers/gpu/drm/vc4/vc4_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_regs.h
@@ -723,6 +723,9 @@
 # define VC4_HD_VID_CTL_FRAME_COUNTER_RESET	BIT(29)
 # define VC4_HD_VID_CTL_VSYNC_LOW		BIT(28)
 # define VC4_HD_VID_CTL_HSYNC_LOW		BIT(27)
+# define VC4_HD_VID_CTL_CLRSYNC			BIT(24)
+# define VC4_HD_VID_CTL_CLRRGB			BIT(23)
+# define VC4_HD_VID_CTL_BLANKPIX		BIT(18)
 
 # define VC4_HD_CSC_CTL_ORDER_MASK		VC4_MASK(7, 5)
 # define VC4_HD_CSC_CTL_ORDER_SHIFT		5
-- 
git-series 0.9.1
