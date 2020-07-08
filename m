Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B192C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B18F206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="P7woFKhx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n06CJEGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgGHRmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:42:49 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:44789 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726420AbgGHRmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:42:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 6CD9A109A;
        Wed,  8 Jul 2020 13:42:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=f4BJOj1xVlQxM
        cKf+oW7yKIzgA+uFyj+cxi8CQLgJ1E=; b=P7woFKhxxpNNXGACwdEN173Hw4kDN
        bBpqs8zitxZc1CkwQsFfT97GbDUGbjnndsFhjyPx/pbIumKcT+6Zt3XtTACcQXb/
        lG/ccMgegAQdW8ydkoQda73EiJuubuTEdspyRh1oAQTZueg0+pL2DwAdoOFhoT+A
        4kcLUuIm7X/IgwE4K1ELP4mEPlAFZHhkKpnlk9XPsHc209SlRnHMeH8F7YBD7hfh
        DOpouqLo22dTygjy/Ch9PdNxobkaY8bq1LAzMUMtLXCy30i7xq+CnW3xM/mTaWZR
        b0pASVpNKF3Tm0HPCV/Z3Lp0Gmyt0w5l608i1oZu7z+D1mJxdhYRAsv4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=f4BJOj1xVlQxMcKf+oW7yKIzgA+uFyj+cxi8CQLgJ1E=; b=n06CJEGy
        62/8q8FdNUMDoGRvI6Og2Vjh7uMfegImB452ZIxwUiP2aOeD4YwOAwyi3dypXHek
        SEfdE8Gn+8aucg4mnqvqpIubm6rkTz6S7Hx26c5a701cKoqZcsTrP97jnj7vrtg9
        OJzeMC5EKZeoHEuRxx8KnfEBXNA/1MW9eCFu8R3pVHZ/AaSpuudDD9iNlVoOD3IH
        nmG5+oOF2e3cZWbG7mOB48rPnGYfei0MTI3CWk28PqF9bRgnfGnUKFbe21jTXANk
        yn5b9ShuHdE6Oav68myDx0S3kifj4eUm/Emvn/kdLj73z8kezMYhut8ivJAJjUn0
        YMn/TBNXhLmG0Q==
X-ME-Sender: <xms:kgUGXxPqIBxTcDlKX9RWcjtXieQqCivdGr80MGzvCmRfZ958rkK1qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepjeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:kgUGXz_YyhdlcVtxPRApk7zOX4_kV7KhNWPGi6yxcWWbjSu0UPlqAQ>
    <xmx:kgUGXwQFG1MxHrrgl-7YmAjjRfuBXrWz-B9vy7a5S7-itPGVgiCp0Q>
    <xmx:kgUGX9smlgXE9LANm67CTHxf8lNVwJ3pQAEffFXmIgPJlE0Mu2IADQ>
    <xmx:kwUGXzvwJi-f_cEvLXFTWes3_OTPNL2NRtTD3_v4LwiRDdx8RiIx6iRsYRA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A5627328005E;
        Wed,  8 Jul 2020 13:42:42 -0400 (EDT)
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
Subject: [PATCH v4 08/78] drm/vc4: crtc: Use a shared interrupt
Date:   Wed,  8 Jul 2020 19:41:16 +0200
Message-Id: <ad67d418a44497a8f483d148f602d52b902e931f.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pixelvalves in vc5 use the same interrupt line so let's register our
interrupt handler as a shared one.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index e55b2208b4b7..9faae22cb0f8 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -919,7 +919,9 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
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
