Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9EAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 641662065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="wjvKNZur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390811AbgEMUKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:10:23 -0400
Received: from www.zeus03.de ([194.117.254.33]:37392 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388033AbgEMUKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=W7q9fn4XN2n9/68cf5tS2Enuv46
        NvEawyvtgZa/O2lo=; b=wjvKNZur93eS31N2SCzLQcGDpAajcZrzhkOsQTz1TxN
        VT95ilzXmFdbcUmFNrATRibu4tm32X2emLv3nIqzlNBbFho6hWuOmZLc6G07guK5
        JFT3fQdOJYkP9xm4KYnHyA3SRth8wjyvqnPbCP+QlCtR1YYEnJ7/AMxV5iZFQrdg
        =
Received: (qmail 3475788 invoked from network); 13 May 2020 22:10:19 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 May 2020 22:10:19 +0200
X-UD-Smtp-Session: l3s3148p1@i5BQK42lNN0gAwDPXwcWAIZZjypw6UMc
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vblank: remove outdated and noisy output
Date:   Wed, 13 May 2020 22:10:16 +0200
Message-Id: <20200513201016.23047-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R-Car DU driver calls drm_vblank_init via some helper functions in
probe(). From what I checked, most drivers do this as well. I have a
config now where DU always stays in deferred_probe state because of a
missing dependency. This means that every time I rebind another driver
like MMC, the vblank init message is displayed again when the DU driver
is retried. Because the message doesn't really carry a useful
information, I suggest to simply drop it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/gpu/drm/drm_vblank.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index da7b0b0c1090..ce9bed24c2da 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -483,8 +483,6 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 		seqlock_init(&vblank->seqlock);
 	}
 
-	DRM_INFO("Supports vblank timestamp caching Rev 2 (21.10.2013).\n");
-
 	return 0;
 
 err:
-- 
2.20.1

