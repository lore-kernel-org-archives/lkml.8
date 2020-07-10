Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79131C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548782078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBl7FU/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGJQDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgGJQDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:03:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A2AC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:03:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so6696951wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HU7/byzDdGrFRngwJ2Ihe/2za95z2ZBIDy+mwg/mTHc=;
        b=MBl7FU/yIvBaWy3Kyuc5jYhBPOiReIKPfgPlLvR22C7n7X3DdznB9cjx/N2tusWiTx
         ediyqviCImtW/WnIxtKTDGcj1XtOcoIL3ALjFXoMeqgjfDFPTIkXOXr934Au7jXhrB1J
         swtgAkV/JMlNQG4xrMEKuCpfH1zpJa2bECdWq/ChqdGJ5O6mrgS8LLpmtHJIY8yjnOL3
         H8nEesxLsnSFscOl3I0A/D0WQRPny1dCB9oHXH11hmFfOG4tfjOLpFKaO/7ccswEhKQs
         uwHeE2kcw3xLOFIy1ttEVf56XhirUAddlN68BYFFrzIw97QeC1vQveR6wb25QwXldz+o
         wTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HU7/byzDdGrFRngwJ2Ihe/2za95z2ZBIDy+mwg/mTHc=;
        b=eMM9wMWpJiQl1TWRVTr9XQHqHYW5g/t+Cykcov2jo6hsQ9EzRA8UEzv67D6dj7E9Z1
         EnpMDME2/89U0zNXxAr7YqUj8VfLW+pz8La6UpXiJn94MQBoXO4wRlu+0m7s8vCdrEpx
         l4W41e71q1H0JOxWmoVHW1y9rqqsF+RsIos/N+snRMKXz9nN5BpCq7nMZZ1lApcRK0A/
         aC7ZVYyRPWVc6XhyxYwTiO6smah/c0kQJOYLVpQPVWJWxpuYlzJ5QZCMWW2iTNT4wqsc
         isiNwbpE+EWO4v7ykYiTQCg9cXekjNC/i0mbJFzOFniR4BnUsvGYIPl3lkYiVmSzyud/
         Ghcg==
X-Gm-Message-State: AOAM532IKJ+IquhOXmJsogmyN7xKkFovfDgPY94ELDyrEbweNvZDIEMM
        LBmHqSBW//N1P2WsxtfQixL0ab5X+30=
X-Google-Smtp-Source: ABdhPJxtPtkfAREBaV21XQmaaF9G3mrjKWq0G48lEic7OZzNUaGGwPPqOJe741XamARcYyemgYeykA==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr5741624wmd.86.1594396999997;
        Fri, 10 Jul 2020 09:03:19 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id t4sm10529773wmf.4.2020.07.10.09.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:03:19 -0700 (PDT)
Date:   Fri, 10 Jul 2020 13:03:13 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, twoerner@gmail.com
Subject: [PATCH] drm/vkms: change the max cursor width/height
Message-ID: <20200710160313.xjoz6ereyma5vkc3@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change expands the coverage for the IGT kms_cursor_crc test, where
the size varies between 64 and 512 for a square cursor. With this, in
addition to the cursor 64x64, this patch enables the test of cursors with
sizes: 128x128, 256x256, and 512x512.

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 1e8b2169d834..57a8a397d5e8 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -133,6 +133,8 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	dev->mode_config.min_height = YRES_MIN;
 	dev->mode_config.max_width = XRES_MAX;
 	dev->mode_config.max_height = YRES_MAX;
+	dev->mode_config.cursor_width = 512;
+	dev->mode_config.cursor_height = 512;
 	dev->mode_config.preferred_depth = 24;
 	dev->mode_config.helper_private = &vkms_mode_config_helpers;
 
-- 
2.27.0

