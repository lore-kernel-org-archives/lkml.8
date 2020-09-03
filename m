Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6519CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3255B20897
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Zw1k70G9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rMpV/l23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgICIGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:06:40 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:46887 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728483AbgICIDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:03:23 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id DE047C57;
        Thu,  3 Sep 2020 04:03:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=7vN83IkzKqKuL
        B+UmBGANLgXHhL4NTtq4vWWcUUXPgo=; b=Zw1k70G9XzUYpg+iqo6gYGpjwnXfb
        DY3USD/PifaNXn5q1BTTqGZNXL42K67poI8y3m9/Axu0RyxYSkwiWXw/QZSu+8qH
        rStMJGI3kGUbLppOpzCobuLKuI7G/oNjJQ2u5PeG391WrE4W6YUOlH1NTnF/XWdG
        EqIA4JXeApb/h4Vg6w8mO1zQsofa+8HS0g3aNb3hPcVq48fVedVUEDziRgvwNTlX
        8UYAoXyjVnvDCYK+Vap9NiYfTqRpyFW1+0yIE59MTmfBYB8xNOo+n6o98JtZVtym
        FcnaBeLnWZLBwuuSAOVrbwbp2Gu2iCKw79HP8P7G8nyjZaoMuCLFyf53w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=7vN83IkzKqKuLB+UmBGANLgXHhL4NTtq4vWWcUUXPgo=; b=rMpV/l23
        5HkhX3X66xP7YhKVVozsvetPz61hGZnaTr5kr8u+YvV40ianuqECodvFnyk7ngbN
        fXHfp6klN81GlXV0OR9sZXB/ICOYDhpH7p7CgvFxo7m/JXI/UZrbHxhs047moxco
        PckCKBkwhr5t4d51O1w/I55PDRRvBWxswszcNbmhfkHHKtem5DdPPYu50Ej+yEse
        FEd3/wmIkONSZ6Lg4OaxClvHI8iwTqDHbxFmyYSITPPdEw/UCtjjQYZZwLDCI1H3
        H6WvHaMC3g9mlxuHKE6xxmCt3piXYi/XllGtvwtCMQSzOFUvZ9R9QZWy9YVj6ka6
        D5OBh2X3nwAQKw==
X-ME-Sender: <xms:SaNQX02IDKASEPvfaTBM-HlZ2UZZf1RT2u27ua8KTwdoPKCQnP7gSw>
    <xme:SaNQX_FSvRytXLPaPl2xFIJz75NE1sBXXWSGYsBSGkJ7yvd0_yMSIsmPfUas0sXea
    MK7p_2mYHaI7a039xM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeehke
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:SaNQX84urcDBKPboIkr4FNJhlOE8ukyNrSw2PZn65ZA_FQK2_9CU-Q>
    <xmx:SaNQX91tlbCHX6AACYS8DHyKbQhKy_GDY6eXYfe7LD3L8_GmBTemwA>
    <xmx:SaNQX3EZVJrmW7QNQqOzhI5A-E-NvS8ao4peqwaQp-08fLMarigfiQ>
    <xmx:SaNQX-_Dy53nL2ds9gKiGaIFFgKe78lW59t6giAKxEfgJaWRbGbjOf9Ktcw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 171CA328005A;
        Thu,  3 Sep 2020 04:03:21 -0400 (EDT)
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
Subject: [PATCH v5 62/80] drm/vc4: hdmi: Rename drm_encoder pointer in mode_valid
Date:   Thu,  3 Sep 2020 10:01:34 +0200
Message-Id: <7fbabab03992efe4a3a3640ac5ee2bb49b1c7338.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mode_valid hook on the encoder uses a pointer to a drm_encoder called
crtc, which is pretty confusing. Let's rename it to encoder to make it
clear what it is.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index e39c6fcf4c12..1e6c0e26d186 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -556,7 +556,7 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 }
 
 static enum drm_mode_status
-vc4_hdmi_encoder_mode_valid(struct drm_encoder *crtc,
+vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode)
 {
 	/*
-- 
git-series 0.9.1
