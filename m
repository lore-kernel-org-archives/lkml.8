Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAA2C35240
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 06:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19442071A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 06:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgAZG7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 01:59:51 -0500
Received: from mailoutvs56.siol.net ([185.57.226.247]:39320 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726313AbgAZG7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 01:59:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 9F43E522717;
        Sun, 26 Jan 2020 07:59:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id L66nzIyDXhLa; Sun, 26 Jan 2020 07:59:48 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 57D7F522718;
        Sun, 26 Jan 2020 07:59:48 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 6298F522717;
        Sun, 26 Jan 2020 07:59:46 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org, paul.kocialkowski@bootlin.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "drm/sun4i: drv: Allow framebuffer modifiers in mode config"
Date:   Sun, 26 Jan 2020 07:59:37 +0100
Message-Id: <20200126065937.9564-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9db9c0cf5895e4ddde2814360cae7bea9282edd2.

Setting mode_config.allow_fb_modifiers manually is completely
unnecessary. It is set automatically by drm_universal_plane_init() based
on the fact if modifier list is provided or not. Even more, it breaks
DE2 and DE3 as they don't support any modifiers beside linear. Modifiers
aware applications can be confused by provided empty modifier list - at
least linear modifier should be included, but it's not for DE2 and DE3.

Fixes: 9db9c0cf5895 ("drm/sun4i: drv: Allow framebuffer modifiers in mode=
 config")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/su=
n4i_drv.c
index 5ae67d526b1d..328272ff77d8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -85,7 +85,6 @@ static int sun4i_drv_bind(struct device *dev)
 	}
=20
 	drm_mode_config_init(drm);
-	drm->mode_config.allow_fb_modifiers =3D true;
=20
 	ret =3D component_bind_all(drm->dev, drm);
 	if (ret) {
--=20
2.25.0

