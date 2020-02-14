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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE434C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA42624689
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCK3dCri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388933AbgBNUtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:49:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36528 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388437AbgBNUsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so12150398wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=by2xd4xQmUHlU9s/C95WpmrUhX2m+ztyFaDW+ePPigQ=;
        b=UCK3dCriT7/8DChoNsIE9klpclhewfP+byj/lcpxFKeokvg47rKoszURR8QihMXMJT
         fgCML7aTZQfzFOPnXhwwrFzTqnGtNKYiNum5LYoYD2M4LnF+F4vJycMs+yHeoQZnRZQO
         HY2Yz2gH3bPVzbTKeydlGkOC27vzJ9sXRevBxXZEP6oPFREWdzFCIkeKDUiQrX7gEgv+
         Xdua7WuafmFFjVi54WBGRaS9rag1Y8qvLNO/a51GeD0AhCasNFmbTgjC0XW993CMQyRZ
         jbYDuE8GmJj6f/MDc4f5L4P+YGv8uF+5eF2FBHwc2TRmW3MF4SuDkFHbtJ4Il04gWrlV
         7RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=by2xd4xQmUHlU9s/C95WpmrUhX2m+ztyFaDW+ePPigQ=;
        b=CaMcBSy8R046BV2qgyz1jC0Dn2qXtET3yH23cbk4WBPgVXmA7NEYWG7NFrM3vzq1y6
         U7jSoxSNd+tB8Ud4TigwqAxxC2XJUJ2LhoQW80XF1fpKroFHGY4mc8qvbepbgQ9wMxZG
         oF0BNsGjlnFPHhgJAEF39G3kn/eNsP/T2um6ryB+rr7Eiti8PUd95IsEbDE+asE0l2YK
         IkSb/8/YX8YCQpJjHMsEpUJbv/AOgQ4+usRxl0nwEcFp1tvekbKXN35n04HdGWfd2QVA
         9GfytzaeJNYh11z+8uCu3un5C/gVqS5tX2BFSDwSA3kZCOgDEKi4YSCp4t0rceLbcZrb
         FrMQ==
X-Gm-Message-State: APjAAAV/fGBIXJPyplOxT3S1pXoHe2pWi3D+QZQK5zrBP/tvzjyVS2Sb
        KOIZ68w1jt3WB13fnsVsZIvxuDBt9lyG
X-Google-Smtp-Source: APXvYqzwAXoPMm6yxZjN1IBJNGbtvAo3jdUpnfTX/lXQ9UtXXmeGE+mbP3YSkWpi9jHpOybW+N36XQ==
X-Received: by 2002:a1c:9e89:: with SMTP id h131mr6379803wme.161.1581713331767;
        Fri, 14 Feb 2020 12:48:51 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:51 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR VIRTUAL
        KERNEL MODESETTING (VKMS))
Subject: [PATCH 16/30] drm/vkms: Add missing annotation for vkms_crtc_atomic_begin()
Date:   Fri, 14 Feb 2020 20:47:27 +0000
Message-Id: <20200214204741.94112-17-jbi.octave@gmail.com>
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

Sparse reports a warning at vkms_crtc_atomic_begin()

warning: context imbalance in vkms_crtc_atomic_begin()
	 - wrong count at exit

The root cause is the missing annotation at vkms_crtc_atomic_begin()
Add the missing __acquires(&vkms_output->lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 74f703b8d22a..7513be6444ae 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -219,6 +219,7 @@ static void vkms_crtc_atomic_disable(struct drm_crtc *crtc,
 
 static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
 				   struct drm_crtc_state *old_crtc_state)
+	__acquires(&vkms_output->lock)
 {
 	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
 
-- 
2.24.1

