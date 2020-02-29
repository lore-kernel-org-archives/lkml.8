Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D8FC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4934A24697
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgB2QbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:31:13 -0500
Received: from mailoutvs19.siol.net ([185.57.226.210]:46111 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727209AbgB2QbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:31:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id DFF3D5235EC;
        Sat, 29 Feb 2020 17:31:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SV9myldJ_oFv; Sat, 29 Feb 2020 17:31:08 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 96502523546;
        Sat, 29 Feb 2020 17:31:08 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 4608A5235F3;
        Sat, 29 Feb 2020 17:31:06 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     a.hajda@samsung.com, narmstrong@baylibre.com
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/bridge: dw-hdmi: do not force "none" scan mode
Date:   Sat, 29 Feb 2020 17:30:42 +0100
Message-Id: <20200229163043.158262-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200229163043.158262-1-jernej.skrabec@siol.net>
References: <20200229163043.158262-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

Setting scan mode to "none" confuses some TVs like LG B8, which randomly
change overscan procentage over time. Digital outputs like HDMI and DVI,
handled by this controller, don't really need overscan, so we can always
set scan mode to underscan. Actually, this is exactly what
drm_hdmi_avi_infoframe_from_display_mode() already does, so we can just
remove offending line.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
[updated commit message]
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/=
bridge/synopsys/dw-hdmi.c
index 9d7bfb1cb213..3d6021119942 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1655,8 +1655,6 @@ static void hdmi_config_AVI(struct dw_hdmi *hdmi, s=
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

