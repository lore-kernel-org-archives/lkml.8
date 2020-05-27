Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2503C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C904420776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="pnj2XnLV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WyG1EDus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390278AbgE0PvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:51:12 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:54231 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390224AbgE0Puk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id B22DF5820A9;
        Wed, 27 May 2020 11:50:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=wpVt7MhIxZsbZ
        JMkpP4mIlyTyjudls9LyuYdKN3Ljp4=; b=pnj2XnLV96vUGilZPa4JnZ59m5qvs
        vfEmbfg53mUOazvOm7q8TT8HKUeOIACR7CUp86wOuSUWvmS5hWn9xPdmKSk2f5Lz
        zheK/SZpKXrDNThMXn4v0MPYxpnrKQtPFJbmSFMWzEj5juNz8YCqMHmuYD4KhUEq
        1tIGAeGo2Sn3uNIv8tULGuRs93MPiMry34jrrhCfQAJRJzJc0VHg7eADkAGS3dHr
        vadOW6LmH8Z5uK7Q92ZzEgMt+l44uHNrb4MzCFRwJpWmjQ3dwUVPOPyyPqiSxpEN
        mfNiN3MFQTsLFXixOrFqEe3h8j8Z6yl+rZtTXRJJuMGgkY7tlmUWT8BTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=wpVt7MhIxZsbZJMkpP4mIlyTyjudls9LyuYdKN3Ljp4=; b=WyG1EDus
        g6P+LEd/6ZqvkOfmoS1+tf42JZdYw4c/9iYCaCfcbqMMGxZYHFHp8bker3VN+uqy
        kgA2bR25bUPwGisCcnbvkZG0EucZ2i75TjS25SJ2o+3ppbdb63796omM3Cn8HL8u
        Ms4nsZ+oybj5o9g+8VeHRISHyLWRceUHLbh8pi52vxRdg+84CRqWpMBVrA6j+PsQ
        GLQR0LdXb5fUuR7AxEgXqhn38zdo1jgCweXBmgLEA9rU3oxbodtXBV81cCRf2gKM
        PaXma7LvVrC+IKv7GsX+aHofu/BYC0py2YnVh+lI/FPp+eNnl6eq1JqxZjnnHmrV
        8PYZufwO9PVqlw==
X-ME-Sender: <xms:T4zOXjv6_gfKCs-FHi_8abZfC8vEhx5VPPxT2s4q7X8cEbCGM66fhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeefne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:T4zOXkepu5zGh28UOokfTghtI9Ii2sHm3Riyb1S4rJVNxZQeo54sVg>
    <xmx:T4zOXmw10ewjiPpBds_kNOxDvJsQz3IKyYS9wcoguGMkeDo-7-_M5A>
    <xmx:T4zOXiMzhvfSmIaQjgDuPmXv1aFApUwLaQJZEdm6zG9_jm9OzqnSCg>
    <xmx:T4zOXkMTjolr2Wl7PXWFBOJfGlS_JqTjQVZVf0zFMPjcPy5lPwkglg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 54DC93280059;
        Wed, 27 May 2020 11:50:39 -0400 (EDT)
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
Subject: [PATCH v3 052/105] drm/vc4: crtc: Clear the PixelValve FIFO on disable
Date:   Wed, 27 May 2020 17:48:22 +0200
Message-Id: <9153ce3f0281d57de817a3c8ea0f12530212808b.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid a stale pixel getting stuck on mode change or a disable
/ enable cycle, we need to make sure to flush the PV FIFO on disable.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index dee8dc7b9409..61e0945a8697 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -406,8 +406,7 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (vc4_encoder->post_crtc_disable)
 		vc4_encoder->post_crtc_disable(encoder);
 
-	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) & ~PV_CONTROL_EN);
-
+	vc4_crtc_pixelvalve_reset(crtc);
 	vc4_hvs_atomic_disable(crtc, old_state);
 
 	if (vc4_encoder->post_crtc_powerdown)
-- 
git-series 0.9.1
