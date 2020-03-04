Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E9EC3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31B02072D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="M16492gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbgCDKlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:41:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38438 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgCDKlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:41:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id t11so1762935wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fPj5TgC2jUYLfz4Vs3gbXgfh3ZeKyckJI3P6/EwL1o=;
        b=M16492gcFm1M/b93ik55wP4X2xibbNHk+7ZvwTrQvBh4f/tG8ga7h4RR+mwYaZPAlG
         SF8rQ7AbB1ZJLmvpkZfzQgWYGBKoh9WRS2mVEy3U4SGo/pf1xfuvcM6Alj2Hc8c25yZ6
         QkwahiC1bEh+ObLBx8WL3h/YFjvLDgZowt9fVLVLHhGD9DOw10Mz6neFPFJy5GPcWYqh
         t18UuoPLqfOD0r+edKcH7R3IeRh7KPhkp8AaKKYS4IWHm9HPXm31AGCBEAuYAmHfp+9J
         uuc7S8XJf0qdtd43gcVrhhr7CEVuYdHiLXOcZ4spz+OgWpwPk6ihPqia18y4V4ouP6A3
         8mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fPj5TgC2jUYLfz4Vs3gbXgfh3ZeKyckJI3P6/EwL1o=;
        b=IF4UQyEeobRm49pe8rBGqMXau/g+ssPshjf6h54oIYGbU1q0Xy4l18Hz5K2pPSV3ns
         lTl7hscq4Bg+bFeBPXUXNb/+1JrrRwMS6aYan6oknXGkiJKmKDvoWLFKXYLsdWm8VxIG
         mYBe+CMqhNh0GSk8PcBllLwuSawgD65Qjmo2CcpBRXHPO6JQNfFKPylk8bCL3TKZlz0l
         mM2VOvDbfuP9FTtoxzfwuWBLu3glIpvyUnQsWhdS3J4BWu8JtoWfMhTCNSuQG1qC6kcL
         8UAtj+ELzMgQukE1L/qVYPGlNBA0SIhSu2RoW95xebRP1V4V0a4NNLo7Fd237BZyhGNr
         Z32g==
X-Gm-Message-State: ANhLgQ2JAep1VErP61/80C+rZ0bn8fwS8qrI2tdKhUkNke/H2gsIkPPk
        OedBdjj78mZ0uxm+WsZ+ixDvqg==
X-Google-Smtp-Source: ADFU+vsLT+l1ePDs5v3r0T9iY83Llt3kWCUJwmA48pBvBjPuVueZH/TNfPGj/dvaQYJSc5KIiiLFbQ==
X-Received: by 2002:a5d:4a10:: with SMTP id m16mr3339405wrq.333.1583318461487;
        Wed, 04 Mar 2020 02:41:01 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm24006398wro.36.2020.03.04.02.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:41:01 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     p.zabel@pengutronix.de, heiko@sntech.de, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v5 03/11] drm/bridge: dw-hdmi: Plug atomic state hooks to the default implementation
Date:   Wed,  4 Mar 2020 11:40:44 +0100
Message-Id: <20200304104052.17196-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200304104052.17196-1-narmstrong@baylibre.com>
References: <20200304104052.17196-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add atomic_duplicate_state/atomic_destroy_state/atomic_reset bridge
funcs to allow setup of atomic bridge state.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Jernej Škrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index e097f60e6431..9f2918898f60 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2506,6 +2506,9 @@ static void dw_hdmi_bridge_enable(struct drm_bridge *bridge)
 }
 
 static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.attach = dw_hdmi_bridge_attach,
 	.detach = dw_hdmi_bridge_detach,
 	.enable = dw_hdmi_bridge_enable,
-- 
2.22.0

