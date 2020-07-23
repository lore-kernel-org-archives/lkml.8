Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD258C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996542084D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dp4NOUJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgGWJGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgGWJF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:05:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E599C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 02:05:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 88so4404440wrh.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 02:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LreLnnZrmwYYHqpYhGckfxJZdjPdivebpamaHVtnHss=;
        b=dp4NOUJqQL/scm6GUYDjAXuLDt4cgSIbswqtZ6cIJfZCxfzC1NpMAwaIZ+2dvElcj9
         SDC0T7IQ44exhyDpzJ9m7bbXA8SelqJO/TmmnZPQfFDK63km9fcYn7YvPWQPd4zttNZm
         DgWrxRl6zwWKV+SF2Dezay6uB7J+zAzzIPC7iRSeLSi9hP4VzjDj2CYgg7Y9mSk1PDhz
         A52xl0Ki7OzQ5at/zyyUJtmVloPz8Vqhq2ZgYD6xs3fo1wUAWRJNN6adh8xK05051VJA
         f8qrpe2alI3fnTVS4Nrfn641a/3JssxJhg5jEeT8FUwJs2HZAvWCnrUvgjhoOUId9/CY
         j47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LreLnnZrmwYYHqpYhGckfxJZdjPdivebpamaHVtnHss=;
        b=OcC+fMLBllQehGC9Y3bAJCxK6zYBLpcihgM+Nzfq2qPaWceW/JIgWYxSBtwAdYvK/t
         /SuQPlCvEmLkgYnD6VVyJRdZoYxM3Pl9P7XTnuWzJc/sRTLOaAj5xpbYz2c012m4XsAN
         V4xtez0QhR3ns/mJzR1kD7ZDJOyzqOIo8y1Y5frXNbquVysWCtqct7w5ah/tM510YXiN
         /VjdTYuDjvvJXYhwiRd/NNSdjjco0uRvi2N115DOTaq47fDrR3H7LkHVzGfanwC1zXPu
         BNd6u6pQfnj0BuJ2TV0/YMZI0cvDecxObJTWBLjgvriJJgqwYaDkHj1Kmy1X1smlX+fe
         JhfA==
X-Gm-Message-State: AOAM5330rXrXnx0PfcA4b5KJSwc84e8CRGeCnXskLXnW9XVEePYypSdR
        fLI4wSawYo1ReVJQagWyjE14ug==
X-Google-Smtp-Source: ABdhPJzqffe9YMOSst9S78aI/iVWmungmYo/9CY48wTFHegSvIqIB1PAqtLGwVADRl5r9zYcZipJCA==
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr3032026wrn.51.1595495156669;
        Thu, 23 Jul 2020 02:05:56 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5ce9:901f:7444:d44d])
        by smtp.gmail.com with ESMTPSA id 62sm2947397wrq.31.2020.07.23.02.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 02:05:56 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] drm/meson: overlay: fix Amlogic Compressed Framebuffer modifier layout extract
Date:   Thu, 23 Jul 2020 11:05:51 +0200
Message-Id: <20200723090551.27529-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200723090551.27529-1-narmstrong@baylibre.com>
References: <20200723090551.27529-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bitwise operation worked because the result is casted in a lower bits
integer, and was not changed after the modifier defines rework.

Use the correct operation as already used in meson_overlay_atomic_update().

Fixes: e860785d5730 ("drm/meson: overlay: setup overlay for Amlogic FBC")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_overlay.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
index a8bcc70644df..83ec613bbfb6 100644
--- a/drivers/gpu/drm/meson/meson_overlay.c
+++ b/drivers/gpu/drm/meson/meson_overlay.c
@@ -756,8 +756,7 @@ static bool meson_overlay_format_mod_supported(struct drm_plane *plane,
 	if ((modifier & DRM_FORMAT_MOD_AMLOGIC_FBC(0, 0)) ==
 			DRM_FORMAT_MOD_AMLOGIC_FBC(0, 0)) {
 		unsigned int layout = modifier &
-			DRM_FORMAT_MOD_AMLOGIC_FBC(
-				__fourcc_mod_amlogic_layout_mask, 0);
+			__fourcc_mod_amlogic_layout_mask;
 		unsigned int options =
 			(modifier >> __fourcc_mod_amlogic_options_shift) &
 			__fourcc_mod_amlogic_options_mask;
-- 
2.22.0

