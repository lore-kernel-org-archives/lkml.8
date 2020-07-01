Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19161C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E170820870
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="j1mExsuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgGASrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:47:05 -0400
Received: from vps.xff.cz ([195.181.215.36]:55134 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgGASrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593629223; bh=olxKvxDhRaCmmrGY7TxJGTOXjcVe01VG/mIzGEUxdxk=;
        h=From:To:Cc:Subject:Date:From;
        b=j1mExsuSSTGrcBm+BUVzeRR5ES3JW/9qJd2AdBBupgtU0/a3Cb3sxFdNrf61HrFwD
         Hhgsy96tJN9enhdH4a1YVNW12ReGaN325WGKbggSOlHwDaYaAAYS/BkO6tGln/oJZ8
         HQZt44UGeByoC7JdevQjvIpY4ACkcFqtNLtPyjPs=
From:   Ondrej Jirman <megous@megous.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Ondrej Jirman <megous@megous.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] MAINTAINERS: Update entry for st7703 driver after the rename
Date:   Wed,  1 Jul 2020 20:46:40 +0200
Message-Id: <20200701184640.1674969-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was renamed, change the path in the MAINTAINERS file.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 MAINTAINERS | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f186a661a9b..f5183eae08df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5487,12 +5487,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
 F:	drivers/gpu/drm/panel/panel-raydium-rm67191.c
 
-DRM DRIVER FOR ROCKTECH JH057N00900 PANELS
+DRM DRIVER FOR SITRONIX ST7703 PANELS
 M:	Guido Günther <agx@sigxcpu.org>
 R:	Purism Kernel Team <kernel@puri.sm>
+R:	Ondrej Jirman <megous@megous.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
-F:	drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
+F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
+F:	drivers/gpu/drm/panel/panel-sitronix-st7703.c
 
 DRM DRIVER FOR SAVAGE VIDEO CARDS
 S:	Orphan / Obsolete
-- 
2.27.0

