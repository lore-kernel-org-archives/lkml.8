Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500E6C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3E922314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2uzyv7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389012AbgBNUtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:49:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35706 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388506AbgBNUsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so12168923wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9zl/VqdzmiPXGS2EfIZ6zNuhTKk8iOu4+THisxEUJVg=;
        b=R2uzyv7wdD+UjuGOUJHWfi+Rj8T/w15OgnBnn097gy8xwIH7b5un7irySmGW5jPmJc
         fCIn//Px6DD2mEs3+0GxEMGF8Yy8mYpWsQ2HjL9qTg1hT+2O0qSAN6H49gBIZXh3COw/
         s0bD/pu6f2SGQrhKMqIdlUfpkuMnUugMjQTPHc3iJRDwVUhNiiw0XZKdHH9IVa/3kMaf
         nFjRgsbNy8b69WhwepV5Hll/vS+Rc3e05cvNWY5MwnxsivNKV3bYCCOY/39JqGno46ZM
         ywgLfyUodI35W+uU+NMeJa2kOPfhSU+RfCDAwa6/QsurhhYn/Jv9JgiGjTgQY1bswgGQ
         Ms/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9zl/VqdzmiPXGS2EfIZ6zNuhTKk8iOu4+THisxEUJVg=;
        b=Yw/D3bcffqKGlsb7SZxztesi0yUTafvIGkEMUxw2Y5Slp81XTNaV0lcRAQJLDBdP9L
         c3diPsdvjut+L7fhmX0HBm+n371rM9zTkzFcp+l53Z+4+h8n1WpMkaLgC1t6EJzRAe8c
         2HfKSOUGzeKE6dlAi/dJZSS6EYx30+TdV2+xnnLZqf7aupQdVsZZ3hTweYh5MXbbFs+8
         agVYx42nOYTtiwWoW5uLPT1qbuYod2i15ppWZucNwEQ2MY+ut05WmvfaLL/o652tckXd
         WGxHRFZUiNVgDhl/vWQyQ2h9P6GBApb8puFBQyrFxx1Oj0DEHn84KuG2w493PGXUIbu2
         CWCg==
X-Gm-Message-State: APjAAAUE1qSegL+6L0mMMxI2+RiKA4STSpYLpR4G2+12k/4gUlX6p+XR
        fcq/+e1vG6eAuxs8mGC9SBZyJrlLxeAM
X-Google-Smtp-Source: APXvYqxE4wd3GjldXk/dFA8BrNt8N6M2a/YsR2om9aOlsCst8rFuL+8NlasMBvlW7q3OZWqaoWtwTg==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr6208115wme.125.1581713332763;
        Fri, 14 Feb 2020 12:48:52 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:52 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR VIRTUAL
        KERNEL MODESETTING (VKMS))
Subject: [PATCH 17/30] drm/vkms: Add missing annotation for vkms_crtc_atomic_flush()
Date:   Fri, 14 Feb 2020 20:47:28 +0000
Message-Id: <20200214204741.94112-18-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at vkms_crtc_atomic_flush()

warning: context imbalance in vkms_crtc_atomic_flush()
	 - unexpected unlock

The root cause is the missing annotation at vkms_crtc_atomic_flush()
Add the missing __releases(&vkms_output->lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 7513be6444ae..bc0ac2641220 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -231,6 +231,7 @@ static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
 
 static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
 				   struct drm_crtc_state *old_crtc_state)
+	__releases(&vkms_output->lock)
 {
 	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
 
-- 
2.24.1

