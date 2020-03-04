Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A32C3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA6A20866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbgCDXZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 18:25:39 -0500
Received: from mailoutvs14.siol.net ([185.57.226.205]:47915 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388598AbgCDXZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 18:25:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 67A58523EAA;
        Thu,  5 Mar 2020 00:25:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 060BCbAtvDSr; Thu,  5 Mar 2020 00:25:37 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 1EA5F52273A;
        Thu,  5 Mar 2020 00:25:37 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id C9809523EAA;
        Thu,  5 Mar 2020 00:25:34 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     a.hajda@samsung.com, narmstrong@baylibre.com
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 2/4] drm/bridge: dw-hdmi: do not force "none" scan mode
Date:   Thu,  5 Mar 2020 00:25:10 +0100
Message-Id: <20200304232512.51616-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200304232512.51616-1-jernej.skrabec@siol.net>
References: <20200304232512.51616-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

Setting scan mode to "none" confuses some TVs like LG B8, which randomly
change overscan percentage over time. Digital outputs like HDMI and DVI,
handled by this controller, don't really need overscan, so we can always
set scan mode to underscan. Actually, this is exactly what
drm_hdmi_avi_infoframe_from_display_mode() already does, so we can just
remove offending line.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
[updated commit message]
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/=
bridge/synopsys/dw-hdmi.c
index 24965e53d351..de2c7ec887c8 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1654,8 +1654,6 @@ static void hdmi_config_AVI(struct dw_hdmi *hdmi, s=
truct drm_display_mode *mode)
 			HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
 	}
=20
-	frame.scan_mode =3D HDMI_SCAN_MODE_NONE;
-
 	/*
 	 * The Designware IP uses a different byte format from standard
 	 * AVI info frames, though generally the bits are in the correct
--=20
2.25.1

