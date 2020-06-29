Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4C9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4989120786
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="il+yGkZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgF2Xwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:52:40 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:49532 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgF2Xwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1593474742; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8Wh99asMaI00AHjqm706gvL6rNORhOoja23j4oKsAo=;
        b=il+yGkZgHNh6rtNCrG4aS+PcNaoRo/xkJmtNUn+YCpzNxwOC4IuLEX3UFhd0VmUMZZOQmd
        cYApnOib/cvCR2OyTXXqMaUabLXLeHPboB+8Boyh7ZaBC28ZB9NUVcesYS23NQaaUAZeTz
        fz/ze0QOmHLUeWvoBWkJn1+EXOiVNTw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 03/10] drm/ingenic: Rename ingenic-drm.c to ingenic-drm-drv.c
Date:   Tue, 30 Jun 2020 01:52:03 +0200
Message-Id: <20200629235210.441709-3-paul@crapouillou.net>
In-Reply-To: <20200629235210.441709-1-paul@crapouillou.net>
References: <20200629235210.441709-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Full rename without any modification, except to the Makefile.

Renaming ingenic-drm.c to ingenic-drm-drv.c allow to decouple the module
name from the source file name in the Makefile. This will be useful
later when more source files are added.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch

 drivers/gpu/drm/ingenic/Makefile                             | 1 +
 drivers/gpu/drm/ingenic/{ingenic-drm.c => ingenic-drm-drv.c} | 0
 2 files changed, 1 insertion(+)
 rename drivers/gpu/drm/ingenic/{ingenic-drm.c => ingenic-drm-drv.c} (100%)

diff --git a/drivers/gpu/drm/ingenic/Makefile b/drivers/gpu/drm/ingenic/Makefile
index 11cac42ce0bb..9875628dd8bc 100644
--- a/drivers/gpu/drm/ingenic/Makefile
+++ b/drivers/gpu/drm/ingenic/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_DRM_INGENIC) += ingenic-drm.o
+ingenic-drm-y += ingenic-drm-drv.o
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
similarity index 100%
rename from drivers/gpu/drm/ingenic/ingenic-drm.c
rename to drivers/gpu/drm/ingenic/ingenic-drm-drv.c
-- 
2.27.0

