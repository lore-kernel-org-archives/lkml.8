Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64B6C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823E1206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgIAV6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 17:58:38 -0400
Received: from mailoutvs49.siol.net ([185.57.226.240]:45292 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728254AbgIAV6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 17:58:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id F0B71526784;
        Tue,  1 Sep 2020 23:58:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vxLCUTGcJHyJ; Tue,  1 Sep 2020 23:58:34 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id A06835267B9;
        Tue,  1 Sep 2020 23:58:34 +0200 (CEST)
Received: from kista.localdomain (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id C97F0526784;
        Tue,  1 Sep 2020 23:58:33 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     jernej.skrabec@siol.net, irlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: [PATCH] drm/sun4i: Fix DE2 YVU handling
Date:   Wed,  2 Sep 2020 00:03:05 +0200
Message-Id: <20200901220305.6809-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function sun8i_vi_layer_get_csc_mode() is supposed to return CSC mode
but due to inproper return type (bool instead of u32) it returns just 0
or 1. Colors are wrong for YVU formats because of that.

Fixes: daab3d0e8e2b ("drm/sun4i: de2: csc_mode in de2 format struct is mo=
stly redundant")
Reported-by: Roman Stratiienko <r.stratiienko@gmail.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index 22c8c5375d0d..c0147af6a840 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -211,7 +211,7 @@ static int sun8i_vi_layer_update_coord(struct sun8i_m=
ixer *mixer, int channel,
 	return 0;
 }
=20
-static bool sun8i_vi_layer_get_csc_mode(const struct drm_format_info *fo=
rmat)
+static u32 sun8i_vi_layer_get_csc_mode(const struct drm_format_info *for=
mat)
 {
 	if (!format->is_yuv)
 		return SUN8I_CSC_MODE_OFF;
--=20
2.28.0

