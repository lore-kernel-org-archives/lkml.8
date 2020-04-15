Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374F7C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F4220857
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586953180;
	bh=FIPNM7KHXezPRFmRpolI3sdXFbEDJs3ESlzqr8tNr1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IHBSH0zHrwHmkn+jGCbT8pFOIbWH8vc37ybTGdaWss1s7XiCAIsWdch85EM6p6tiU
	 IpelbdkvHW+/sgrn98HPmU+yHi21KIexX0OhrN0MMhjMgTWN/hT2S6zDlTKmEKlyGj
	 IZdHyBFyqVQTbHMvJT+jJ3EPdBg6kWP98u57vhD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368959AbgDOMTh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409253AbgDOLqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:46:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 950212137B;
        Wed, 15 Apr 2020 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951163;
        bh=FIPNM7KHXezPRFmRpolI3sdXFbEDJs3ESlzqr8tNr1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MqDLlu9zPIRqYjgo+wCiatdvJ/ZOe706y/Z6WPXzJktElRB5NA8ziCmVIFnCg/6cS
         kIFLaUUrNBC31t4nyaHAPlY8fZCgCpPBSvSiRpI2pdgvh+qNYDWtlgoDOXvLssTKnj
         CWY1UA7z0Oai0jha9Jax8Iip4qUvytN3kxtpljKU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 68/84] drm/vc4: Fix HDMI mode validation
Date:   Wed, 15 Apr 2020 07:44:25 -0400
Message-Id: <20200415114442.14166-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114442.14166-1-sashal@kernel.org>
References: <20200415114442.14166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

[ Upstream commit b1e7396a1d0e6af6806337fdaaa44098d6b3343c ]

Current mode validation impedes setting up some video modes which should
be supported otherwise. Namely 1920x1200@60Hz.

Fix this by lowering the minimum HDMI state machine clock to pixel clock
ratio allowed.

Fixes: 32e823c63e90 ("drm/vc4: Reject HDMI modes with too high of clocks.")
Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://patchwork.freedesktop.org/patch/msgid/20200326122001.22215-1-nsaenzjulienne@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 0853b980bcb31..d5f5ba4105241 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -681,11 +681,23 @@ static enum drm_mode_status
 vc4_hdmi_encoder_mode_valid(struct drm_encoder *crtc,
 			    const struct drm_display_mode *mode)
 {
-	/* HSM clock must be 108% of the pixel clock.  Additionally,
-	 * the AXI clock needs to be at least 25% of pixel clock, but
-	 * HSM ends up being the limiting factor.
+	/*
+	 * As stated in RPi's vc4 firmware "HDMI state machine (HSM) clock must
+	 * be faster than pixel clock, infinitesimally faster, tested in
+	 * simulation. Otherwise, exact value is unimportant for HDMI
+	 * operation." This conflicts with bcm2835's vc4 documentation, which
+	 * states HSM's clock has to be at least 108% of the pixel clock.
+	 *
+	 * Real life tests reveal that vc4's firmware statement holds up, and
+	 * users are able to use pixel clocks closer to HSM's, namely for
+	 * 1920x1200@60Hz. So it was decided to have leave a 1% margin between
+	 * both clocks. Which, for RPi0-3 implies a maximum pixel clock of
+	 * 162MHz.
+	 *
+	 * Additionally, the AXI clock needs to be at least 25% of
+	 * pixel clock, but HSM ends up being the limiting factor.
 	 */
-	if (mode->clock > HSM_CLOCK_FREQ / (1000 * 108 / 100))
+	if (mode->clock > HSM_CLOCK_FREQ / (1000 * 101 / 100))
 		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
-- 
2.20.1

