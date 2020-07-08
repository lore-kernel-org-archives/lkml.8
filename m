Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3851C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6028206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="gbGkMpMT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kbiJCOa2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgGHRra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:47:30 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:42229 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726802AbgGHRnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 4C9BE2F9;
        Wed,  8 Jul 2020 13:43:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=ZPy0/NNEgAKUq
        J/84wH0PEdvSxqfAe+S+RLBXbWlIPE=; b=gbGkMpMTUiVAfjruUkQadtp3/Dk55
        9q/TX8BbqhYTUVwjUSsXPi38maZhjnpAjfT+SaWItxrxqtSnGA5nH7I6t4iyASvO
        ndN+PwbrR7TCWpPsvVa62Lom1upld/UDJFQ1AyB22XPA615S1oeS9biaGBEGlHok
        JfD5cQtWgz8NpU2FiCI2XjzATR4huQQiHN6s7LDeMGQqj9YHjGQPqYKnuNl/Jw/6
        GJWUR4tiR95c9fmDulLwfRQWrtLWu0jsmKSUvFd9pjVr7iIUNduVh6wgH6fmbKv1
        ah+SPId1nYQ5m+ZvMqB1tq3yfFRmK9Qh3zIJh8keDlPjZsW/SdpJmJVWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ZPy0/NNEgAKUqJ/84wH0PEdvSxqfAe+S+RLBXbWlIPE=; b=kbiJCOa2
        KViimff1IkzfSiziAZc1OVUmEdfa0eOKYoW6gbNudCZ4R4eR6oGUkHcvNNCJtK3a
        P15HHHvdQbX51/G2GKioS/EPkj59OQScL+NZR/B6p+mQ44nHcir8znzrOGOfHowp
        bD7xSjaeimxNSSF1owg+RpeqJ/sDVBLyyIytjCJIH6qUmAKBEntCQ5wnGxDdzkA8
        4C0qofOG2KX0Gp5nFLHoSFppxbdgoxWP+ID3mLqr4j5koZLkSoq866Gie47wIav/
        wId6l29i0HwvXwLpuMOb7/E9V3M0s1oplO211w50LpQTUgYeguyXeMY4NK9ExzXr
        APSPorZohS4jew==
X-ME-Sender: <xms:qQUGX8Nqw1ISEBQ9bVBVCsbIoQQhHazP5A4ANJQAE4Fq_bQad188cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudelne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:qQUGXy_D2Zy2L9Rm-o2nGR-h0-uCH0lTO9Wu_z2AbD4hbK230zlZrQ>
    <xmx:qQUGXzStyBaP7C3UDOwteHxbaUyWt5AfXzdij1VXAi7Zfp4zYVDNcw>
    <xmx:qQUGX0vj4QfnGBMYgJf0owtc8j4Ux-mbXsRjfNwDDWwIvKGl1h2c2A>
    <xmx:qQUGXyt3hooz0uWr6VyCMcCGNbj3XOiz4mS7aSmRe5RbdL7su1JGqSPjb2o>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8856E3280059;
        Wed,  8 Jul 2020 13:43:05 -0400 (EDT)
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
Subject: [PATCH v4 24/78] drm/vc4: hvs: Make sure our channel is reset
Date:   Wed,  8 Jul 2020 19:41:32 +0200
Message-Id: <1fa32b771828098365162a24654c7bbab805500e.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to clear our intermediate FIFOs that might end up with a stale
pixel, let's make sure our FIFO channel is reset everytime our channel is
setup.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index c7de77afbf0a..64b9d72471ef 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -205,6 +205,10 @@ static int vc4_hvs_init_channel(struct vc4_dev *vc4, struct drm_crtc *crtc,
 	u32 dispbkgndx;
 	u32 dispctrl;
 
+	HVS_WRITE(SCALER_DISPCTRLX(chan), 0);
+	HVS_WRITE(SCALER_DISPCTRLX(chan), SCALER_DISPCTRLX_RESET);
+	HVS_WRITE(SCALER_DISPCTRLX(chan), 0);
+
 	/* Turn on the scaler, which will wait for vstart to start
 	 * compositing.
 	 * When feeding the transposer, we should operate in oneshot
-- 
git-series 0.9.1
