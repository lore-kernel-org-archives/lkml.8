Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DD3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 00:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA14D20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 00:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVBVrK9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgGAAKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 20:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGAAKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 20:10:24 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35827C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 17:10:24 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q17so10150301pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 17:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=TfaGDCD2g4XwNF2LQM8smD7Ls5igldEPLNPkOLgGOjk=;
        b=UVBVrK9P5cqI6Y1NbKJi7eCmvRQcGX+HOwTYx+unDNaad18DhCyKSiEY2QkDpHHB+U
         rsPuUxQ1RXhabSz2ckiiKaEchpziF/0Oad9jS6I4aaCCj+0wuFHv9dQ5s6oSYNzB/Gbx
         qKL8EBArd5Tyfyhi1Kst1TjByqif6YN1bnxMhMEpbYBAJtmOcTPzpv4uMdcvRc3h1DDf
         7tyuq5J1Q1sThp1GHY52gVN5AkcnyqO/oRZwsogo+gEvXD+uofuxh0GUckjOaaZ1nMHV
         uPLbz6/PF/pz85nw8+hKVJjpC4kvB81ti9DGtbHq65b29uR1FEsG5dZrcs2smZhlW2n5
         bSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=TfaGDCD2g4XwNF2LQM8smD7Ls5igldEPLNPkOLgGOjk=;
        b=qwQ2OK0IBZE+iFhLrBfJajGfEJh3glWoFWPrB0vW2i8aZRnw33kaHK58gI65KeAUaO
         0tH5lVs3THZEofH9RmRZwcACwzYck1HPdO7IqEwREOkWfnftvsv+1hQJdQN6CdXxXj/e
         lERWMDrsvc2nkEFkRLLTunP714YSbkYNcmtsyNpfc7J5yxlHkW5Y4oUArebqu0iGWMFj
         5DahjEJaudW06yngAeaz0pvYlH6uNCFvaa66hXt/lUVrRlKNSRq6kMFHz2AiRjy15TWr
         r+Iy/vmDVWO+2iZm8Ddj3KR6GdqlVNMwap0LZBIC+s+RRHBw4n1m8Q36n2+SldQOZVcy
         pZeQ==
X-Gm-Message-State: AOAM532wvDVT5l51jmXWqXp7AxCMRS4KpHoOc/xrBX00RxD1G2NqtD7S
        qlqzAMBucdE/XXtIGkVDprEabvWJ
X-Google-Smtp-Source: ABdhPJz9r3Qty0PwtsfLIPdD7xfZz/OUNLuAb7CxkrOcvXON+mz/A23qYNl81SiutlSb899vJeHJ9w==
X-Received: by 2002:a63:e045:: with SMTP id n5mr18249330pgj.274.1593562223698;
        Tue, 30 Jun 2020 17:10:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q22sm3763535pgn.91.2020.06.30.17.10.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 17:10:09 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] drm/aspeed: Call drm_fbdev_generic_setup after drm_dev_register
Date:   Tue, 30 Jun 2020 17:10:02 -0700
Message-Id: <20200701001002.74997-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following backtrace is seen when running aspeed G5 kernels.

WARNING: CPU: 0 PID: 1 at drivers/gpu/drm/drm_fb_helper.c:2233 drm_fbdev_generic_setup+0x138/0x198
aspeed_gfx 1e6e6000.display: Device has not been registered.
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3 #1
Hardware name: Generic DT based system
Backtrace:
[<8010d6d0>] (dump_backtrace) from [<8010d9b8>] (show_stack+0x20/0x24)
r7:00000009 r6:60000153 r5:00000000 r4:8119fa94
[<8010d998>] (show_stack) from [<80b8cb98>] (dump_stack+0xcc/0xec)
[<80b8cacc>] (dump_stack) from [<80123ef0>] (__warn+0xd8/0xfc)
r7:00000009 r6:80e62ed0 r5:00000000 r4:974c3ccc
[<80123e18>] (__warn) from [<80123f98>] (warn_slowpath_fmt+0x84/0xc4)
r9:00000009 r8:806a0140 r7:000008b9 r6:80e62ed0 r5:80e631f8 r4:974c2000
[<80123f18>] (warn_slowpath_fmt) from [<806a0140>] (drm_fbdev_generic_setup+0x138/0x198)
r9:00000001 r8:9758fc10 r7:9758fc00 r6:00000000 r5:00000020 r4:9768a000
[<806a0008>] (drm_fbdev_generic_setup) from [<806d4558>] (aspeed_gfx_probe+0x204/0x32c)
r7:9758fc00 r6:00000000 r5:00000000 r4:9768a000
[<806d4354>] (aspeed_gfx_probe) from [<806dfca0>] (platform_drv_probe+0x58/0xa8)

Since commit 1aed9509b29a6 ("drm/fb-helper: Remove return value from
drm_fbdev_generic_setup()"), drm_fbdev_generic_setup() must be called
after drm_dev_register() to avoid the warning. Do that.

Fixes: 1aed9509b29a6 ("drm/fb-helper: Remove return value from drm_fbdev_generic_setup()")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index 6b27242b9ee3..bca3fcff16ec 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -173,8 +173,6 @@ static int aspeed_gfx_load(struct drm_device *drm)
 
 	drm_mode_config_reset(drm);
 
-	drm_fbdev_generic_setup(drm, 32);
-
 	return 0;
 }
 
@@ -225,6 +223,7 @@ static int aspeed_gfx_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unload;
 
+	drm_fbdev_generic_setup(&priv->drm, 32);
 	return 0;
 
 err_unload:
-- 
2.17.1

