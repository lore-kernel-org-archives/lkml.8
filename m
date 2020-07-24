Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931E6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775902065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgGXUgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:36:04 -0400
Received: from mailoutvs38.siol.net ([185.57.226.229]:58147 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726397AbgGXUgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:36:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 8E85452329B;
        Fri, 24 Jul 2020 22:36:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1PUt-FPrhzhs; Fri, 24 Jul 2020 22:36:00 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 30B61523864;
        Fri, 24 Jul 2020 22:36:00 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 614D7523591;
        Fri, 24 Jul 2020 22:35:57 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH] drm/sun4i: mixer: Enable register value caching
Date:   Fri, 24 Jul 2020 22:35:49 +0200
Message-Id: <20200724203549.35893-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was discovered in the past by Ondrej Jirman that mixer register read
may occasionally return wrong value, most likely zero. It turns out
that all mixer units are affected by this issue. This becomes especially
obvious with applications like video player. After a few minutes of a
playback visual glitches appeared but not always in the same way. After
register inspection it was clear that some bits are not set even when
they should be.

Best solution would be to shuffle the code a bit to avoid
read-modify-write operations and use only register writes. However,
quicker solution is to enable caching support in regmap which is also
used here. Such fix is also easier to backport in stable kernels.

Fixes: 9d75b8c0b999 ("drm/sun4i: add support for Allwinner DE2 mixers")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
index cc4fb916318f..f8f17c51c96d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -303,11 +303,23 @@ static const struct sunxi_engine_ops sun8i_engine_o=
ps =3D {
 	.layers_init	=3D sun8i_layers_init,
 };
=20
+static bool sun8i_mixer_volatile_reg(struct device *dev, unsigned int re=
g)
+{
+	switch (reg) {
+	case SUN8I_MIXER_GLOBAL_STATUS:
+	case SUN8I_MIXER_GLOBAL_DBUFF:
+		return true;
+	}
+	return false;
+}
+
 static struct regmap_config sun8i_mixer_regmap_config =3D {
+	.cache_type	=3D REGCACHE_FLAT,
 	.reg_bits	=3D 32,
 	.val_bits	=3D 32,
 	.reg_stride	=3D 4,
 	.max_register	=3D 0xbfffc, /* guessed */
+	.volatile_reg	=3D sun8i_mixer_volatile_reg,
 };
=20
 static int sun8i_mixer_of_get_id(struct device_node *node)
--=20
2.27.0

