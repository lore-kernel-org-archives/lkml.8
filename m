Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB40FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F1A20747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvjkPMYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgFNHPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgFNHPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 03:15:01 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100ACC03E96F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 00:15:01 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id w18so14535077iom.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bPrRUczvkdPS9j38kNwtmalLCt8ruDVnHkocb9mxFHU=;
        b=LvjkPMYp0DVSzS3YMbpqoU7oTebx1T+1RRpn0cDeLz8GYxeOzbsQPv4yTijr+HO9Ef
         oGRH6bZqsCegNxSDH96TK0uuQg5QkmQZksGFC2GpZaACU+/mjsddQbkGxtpNOtTKSGC5
         3J9GoyD1Q8IrRpiNupB1vn5Fznozt63ys4tzwEPtkBI/PafCva05SPfVjx1YeDUkDtgR
         FDG5xD2CkkBGE/Dr4sgvLgJ5UhvzOOomwx9tO485dySz9SHO4JsqzC9V1Yes2yd1904G
         rHwhsTSm4nohBhkLOW/n2bEzF29COGaW5xFnlghubcNPpicflv0gRAanPx1SX3AwPz8b
         Actg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bPrRUczvkdPS9j38kNwtmalLCt8ruDVnHkocb9mxFHU=;
        b=KA1gvmPpYMvanzWZJCbYjx/OjHPE9YYqj/ZZCReoWk+NGWprTZBmnP41IsbqW1LtxE
         /LiUbfc+oeeAS4RYf7e8LNqS2DGY46RcLdvRU24uYiufBU2xFf/5onrwCmuaeR5aGWzY
         AxFStB6vTLBOMpv35Lmt+I0Afe9R+cC+6pNcxLQH4vuvZI/D4d2jVHF1XUZLTPUzZ1qt
         IKC3mcJRC+mXBdAonRIoYqRpsCJrCWeE4btlxabJXo0v1usdy7jyJVILA5DnFKLxKxFN
         MqPj/wtLNou2dNhpLTclpqlo4s+c1F2MiinZACI2AmBHsUrKSPQZOWmLyh6gys8zg7z4
         iUHQ==
X-Gm-Message-State: AOAM53369VptIWO8kwDfQNmg2gn8l43tgXU5Ys3bNbjUwzoEsMy5GKVc
        TIFU65HkHZ6i5pJHeuxu2QxtVNUmW5k=
X-Google-Smtp-Source: ABdhPJxB/Y3+PO1wPrIY0bPCtprfZW2/CxEvuclqlyjz50AWhC1AXVUYjAmICBjWS54HTLPqlJSglw==
X-Received: by 2002:a05:6602:224a:: with SMTP id o10mr20838681ioo.90.1592118900436;
        Sun, 14 Jun 2020 00:15:00 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id v18sm6097285ilk.6.2020.06.14.00.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 00:14:59 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Evan Quan <evan.quan@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
        "Tianci.Yin" <tianci.yin@amd.com>,
        =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] drm/amd/display: fix ref count leak in amdgpu_drm_ioctl
Date:   Sun, 14 Jun 2020 02:14:50 -0500
Message-Id: <20200614071452.83725-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in amdgpu_drm_ioctl the call to pm_runtime_get_sync increments the
counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 126e74758a34..d73924e35a57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1373,11 +1373,12 @@ long amdgpu_drm_ioctl(struct file *filp,
 	dev = file_priv->minor->dev;
 	ret = pm_runtime_get_sync(dev->dev);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = drm_ioctl(filp, cmd, arg);
 
 	pm_runtime_mark_last_busy(dev->dev);
+out:
 	pm_runtime_put_autosuspend(dev->dev);
 	return ret;
 }
-- 
2.17.1

