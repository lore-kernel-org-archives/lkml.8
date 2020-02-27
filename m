Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196DFC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42892469A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ12is7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgB0MD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:03:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32827 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:03:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id x7so515977wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iLpawHdR33Cmeb66Wb9RCeN8N4vHyeCAeNVuUL7fY+w=;
        b=DJ12is7nziFZhaEhNTzxh/MUtVrKyT+uhRK9FCcvg2bnIVoJcKfzbrMCdEn9aHNBcq
         u2KS5dKnWgsxrVfOGWGY5ZvIpbCudLv4oRJwxrEki/4tWiQ+uZg+nThhboU4H6xdAvLd
         CwNJdO5U146vIGQDxcA3tD10qU9jh9ZzLNyLwL/9AulITTuhlJcd3yENVQ3vJ+gVxvLj
         gytvwF0Ts00fnjsyI+eM+GiKJA/WNsZgrjZjwJEoKYSDf35eic7PZ7NMmkO3k/wwdaKI
         FtlbBtVlFApEilsDT66MFNNnDwF1w1xGp97xgSnjqii+3gOXuZpEvC+O2GokIbIlWOTg
         NR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLpawHdR33Cmeb66Wb9RCeN8N4vHyeCAeNVuUL7fY+w=;
        b=ffhd2H1LpeTvKXJSsLniZ4q9Cwl/xe0TmK2DEV+p2xonqAOsZm2wR32RJkjZrQrOAf
         mTM6olmJbYUIbORgEqsoqI5kirRA65crfhZYs58/0PadfBWKkyyVM04iKssqWWkLetk6
         XyJrIA8n4BPYKwQNnra7j5XrAEhgje+vhycOMqaZpLfgr5KGFqfF4+ndJBT6TBZFCL2F
         fDEnS5fobYSXLcstM9NWrNywMKK/09JSIS6Xc/xlvtEZ7x7iQGcgEPYHYktFvlqWN31i
         mpgvnkG5seb2ehDve+/fO+sAYrUppZ3yUVgepy7RBKA2BpMRHbelz4PwQDlb9PkoJuf4
         hLIg==
X-Gm-Message-State: APjAAAVfNGCRXjLdkfu/0a6yjcWVcILXApvEKpf++0RTalWYiTxiEkUD
        f3xDW2cylxfsGbVGB/7w6g0=
X-Google-Smtp-Source: APXvYqzZP5GszXytVURkcYCrRKKgmojQxMcrPMh4iNIt7d3+P7L7mWVIFbuGKTnL73Xktkg6h6hCuQ==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr4402170wrp.378.1582805032699;
        Thu, 27 Feb 2020 04:03:52 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:03:52 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 18/21] drm/virtio: make virtio_gpu_debugfs() return void.
Date:   Thu, 27 Feb 2020 15:02:29 +0300
Message-Id: <20200227120232.19413-19-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227120232.19413-1-wambui.karugax@gmail.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 987d65d01356 (drm: debugfs: make
drm_debugfs_create_files() never fail), drm_debugfs_create_files()
never fails and should return void. Therefore, remove its use as the
return value of virtio_gpu_debugfs() and have the latter function return
void.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_debugfs.c | 3 +--
 drivers/gpu/drm/virtio/virtgpu_drv.h     | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
index e27120d512b0..3221520f61f0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
+++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
@@ -72,11 +72,10 @@ static struct drm_info_list virtio_gpu_debugfs_list[] = {
 
 #define VIRTIO_GPU_DEBUGFS_ENTRIES ARRAY_SIZE(virtio_gpu_debugfs_list)
 
-int
+void
 virtio_gpu_debugfs_init(struct drm_minor *minor)
 {
 	drm_debugfs_create_files(virtio_gpu_debugfs_list,
 				 VIRTIO_GPU_DEBUGFS_ENTRIES,
 				 minor->debugfs_root, minor);
-	return 0;
 }
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 95a7443baaba..3b843bb72cd1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -371,6 +371,6 @@ struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
 	struct sg_table *sgt);
 
 /* virgl debugfs */
-int virtio_gpu_debugfs_init(struct drm_minor *minor);
+void virtio_gpu_debugfs_init(struct drm_minor *minor);
 
 #endif
-- 
2.25.0

