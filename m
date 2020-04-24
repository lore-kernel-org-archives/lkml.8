Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068C2C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70AD20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Z5dv0nol";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="geRGeffm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgDXPiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:38:02 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:33249 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728835AbgDXPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:37:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id B4F921338;
        Fri, 24 Apr 2020 11:37:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=iApYH2wea2iSQ
        pgO/32FPZnoqFEdByM9qJgEW4rcoQk=; b=Z5dv0nolGCfr0bt6GN6QoMFndyT9c
        ETM25qrBbz3p8ErKkn8ukV2zOQW1sIZukLj+CJAZnkBIHn/4hzAeHoeA6+DpCufL
        NK0SSjEXCi5Q4s/NpnYr6RagEnhsvjYc47vXzSv27QHlILZkdtFxLwNOb7GS8DFc
        d74jsgVFj6/Msx5viQ1RAWQz7XOqhudWo79vrq9nHTZxvqag38GzHlTmVhDy4Ldl
        rYRdsiMRhLXN98Z146NE9X4/4u/LfDCxFrjoKPTuoIg8zVGETGFaXjX9JjM2+h3j
        HU/Y8+ZnatEdYm7wBX5dlw8YaIkKJ6a9MZmbKR3YokHbDxq2f4P+obYWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=iApYH2wea2iSQpgO/32FPZnoqFEdByM9qJgEW4rcoQk=; b=geRGeffm
        x9QWmwB1iOuHNZ8Em3Sayby0fGFv5M4DOtzk/+EIejdil0tC+UPnmHPm5IXuWHST
        8ZuDJkF9QSzuRebE0X31fcUdtrgLBAm5ouACu0sMdlxDMzsnHWoF/z8/xqHnKlLv
        zVZcQ3udRubz+H13tkLOnO+NLSRknNVfsjpvgv9GaT0O00mDToTYKn0f4gbClBZs
        s3tM3NNBLKeEZwfwdLEcRohMk3N9PdXyz7eGcEILKjVQzHWb1B/qi/e5ftjDXD8U
        qNpk0e5aJtLludGWrPhwULs70ZZzXX61jf3qGuQ498EWwVFYyh8hrJmUmGmYoH84
        CcB4S6JK7ICrSQ==
X-ME-Sender: <xms:rgejXkoxmal4JWGhZqSljnQjpI9m5-yhuJ9QBbFFxxFmFE24-OhSxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeejgeenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:rgejXt3VjZGfhtykPA1FJV2TAr_i6i7bBQCKb2CYUF2q4HcwDZ8sDg>
    <xmx:rgejXgCzca5V8YTLoK7JTQ3tokMPMChQI6ii_90jLXgqruCvLsUFXA>
    <xmx:rgejXg9UzA5WS6-q3ztt8oCfgqJ0Air9WURcygenNxVfqV8XHf1Q6w>
    <xmx:rgejXjsWyYDLdkAXsohsuOHnapmIWiZw9-vvmmUJRzU1dz7kVUBLsb4UA80>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 000973065D97;
        Fri, 24 Apr 2020 11:37:17 -0400 (EDT)
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
Subject: [PATCH v2 83/91] drm/vc4: hdmi: Rename drm_encoder pointer in mode_valid
Date:   Fri, 24 Apr 2020 17:35:04 +0200
Message-Id: <2d367f2bb188025e0af7f435fdc909faaf5364ec.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mode_valid hook on the encoder uses a pointer to a drm_encoder called
crtc, which is pretty confusing. Let's rename it to encoder to make it
clear what it is.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 360743187f95..356334eeaf66 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -558,7 +558,7 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 }
 
 static enum drm_mode_status
-vc4_hdmi_encoder_mode_valid(struct drm_encoder *crtc,
+vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode)
 {
 	/*
-- 
git-series 0.9.1
