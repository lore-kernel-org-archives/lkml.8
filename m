Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB513C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC7C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="XQsou6Ec";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YdSuNB6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbgE0P4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:56:41 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51869 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390186AbgE0Pt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:49:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6C82F58203B;
        Wed, 27 May 2020 11:49:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=NNRyGdulB+GEV
        VHlWzjj38fI50EeD5+L1i1sfpqi4Ew=; b=XQsou6Ec0LVf7hi+Q3BTvqjM2Ok4F
        3qKV+k8tjBBzUjwNDd4tvICTjLwa1Z4R6W0DlNdxm7WylV9WCCBknGJQfHrRk0Ji
        WJAdwBEa6t76sZRJkdQphBH/I0LWp12pdGi/maIxa26KBafhb7ZuxKgUQ1Oz06JA
        II8M4P8mNz8Qmg9zgquXLEmsiWFgal0IiEiI0MjlmiXTcD7z8gEwdjSgNcoRIFWY
        nyz9naBUOtNo8hrmaPbh0md8/HUsJOXS6ZLtRFgMBT6dztoeXnQlrS8jczP42XKr
        MuiTI5s6R4ZNekouAWr/sunvkmTTMu/hG1h5u2N/mAoZm0zz4t1sRAZXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=NNRyGdulB+GEVVHlWzjj38fI50EeD5+L1i1sfpqi4Ew=; b=YdSuNB6s
        IVGtX3fEc0TsyhqUOmPcLs5XF9QViFRI+YETtBjb6XK1i79/9hnJhu9XLpkCjE4c
        0QGoszNK+xNyEGw/Y88/FO5f5rMQlBXF/c5wwi7AN1keZyLFy0J2hcj7i8dp4St8
        f+ons4XBuZ6QNiJ9lkcHOjVKRbWDFp/X/fMGab806pRlrOdwwt3WoZ2/bcYTr2vs
        ew8W6D+x5HtOqSd83B37NaMsvNNnnxJ1xHMItkct3rTltFC9EN5aiwxsC4CdveHJ
        +aleyrHD68D15TDGKmIq/rGUDwmHQURzZrl2JcIupX6rPJemA5yMP+T5JAwPgiuZ
        58zymcHTpX2wiQ==
X-ME-Sender: <xms:JYzOXvo6w6_oAuzV5ziME1pZ-ULmOWaYKlNKbck5W9tKpkUx9zCgEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepjeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:JYzOXprUiq_nepVFRl_plvrR24y8jaEEFZ5PDiaW0rKkOl2d7TYAwQ>
    <xmx:JYzOXsM5d_ql6ZJ8Xg4y0litrZSDpGljG4arHnZVAlAubjmZyDZciw>
    <xmx:JYzOXi42UGG2eJCYN5vwUIcGKTPHqzTD2yKiJz3r-4EKg6NhTNHkDg>
    <xmx:JYzOXla5GrBThQISpr_JAvnb5rjwaPl-Y84mnM4nO5vxQO-pkp8i-w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 108B5328005A;
        Wed, 27 May 2020 11:49:56 -0400 (EDT)
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
Subject: [PATCH v3 026/105] drm/vc4: crtc: Use a shared interrupt
Date:   Wed, 27 May 2020 17:47:56 +0200
Message-Id: <6a2e6a4ba651d5bbdfd2c18c090525e50992e448.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pixelvalves in vc5 use the same interrupt line so let's register our
interrupt handler as a shared one.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index a3fc7dd97446..fd248ee546e8 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -1179,7 +1179,9 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	CRTC_WRITE(PV_INTEN, 0);
 	CRTC_WRITE(PV_INTSTAT, PV_INT_VFP_START);
 	ret = devm_request_irq(dev, platform_get_irq(pdev, 0),
-			       vc4_crtc_irq_handler, 0, "vc4 crtc", vc4_crtc);
+			       vc4_crtc_irq_handler,
+			       IRQF_SHARED,
+			       "vc4 crtc", vc4_crtc);
 	if (ret)
 		goto err_destroy_planes;
 
-- 
git-series 0.9.1
