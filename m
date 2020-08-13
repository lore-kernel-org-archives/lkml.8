Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25756C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0517A20838
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9T+cO7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgHMGV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 02:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgHMGVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:21:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F48C061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:21:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so4940906ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ic1tOm+qheUq6zWKsHFH8/lisv9bz4c0DNj333ORfFc=;
        b=O9T+cO7yS6RByinXxGlmLnMuw8UB7Uq04JQ4MQH8ZaRBOREswU+LwInwis5NeFpWMP
         6b4afB4V0u8+vl74/ktAUqv/5NLckdOirqGtDWy0DnfLDzw0F9uS9oFATKIZak9LD0cR
         EIe1i7j7ul/9h7WHFujo40DWgSI49tHQOpChP2CPy1NIu2Q0p4IeMhjKIPe7GW9sQJzq
         d5c/3lf54qiYjopAmeFXxgIvsdX3ue0RCxavzsT6hs7ZHte2Ni4c0+gpVNyxj8MAJSIz
         jWGfGy0Vt9wMXRy75BmyDOX3dfHEFPWVj3RohotOBYiovpXcbaa+zZho0FsfhquQPZ8v
         IpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ic1tOm+qheUq6zWKsHFH8/lisv9bz4c0DNj333ORfFc=;
        b=r1b4RTRgFBCHabBhNXXJ94W6igyx16/dBfNjosaZgZ4ofy5xjS53cfB+gAI647bXKP
         ++AasfWPLYgyktv7i5OxTj4pHkvCuqJ1U8dhmGtjIiDEHr91LEfyzXRK/5GlCJi66hGX
         xdvj2lrg8kJ719lAj7Mnt42wyeWYT+Q2W+rLqK9Z64md5C1IvTh+l8gIqlyTY27kkD7r
         TsPpI0727X7A9ApNcrGy/3Ggdjz0lKRpJgXIk78JKlT1Hy0aDRz75YvxJ3Me/fP6SezU
         pI2rzuUyUPWhevNj4bvM+e1c3BGUmSJDxebN1ta056HytKb7MZJhuHFx8PsnO39+OEBv
         Q1nw==
X-Gm-Message-State: AOAM530PkqWLVsL4G3LFm3FMq9fI5D4vJE93nyDVu4g5yck/9F9gjlLg
        g+jO+8xAwno4ZaoUb+fE778=
X-Google-Smtp-Source: ABdhPJyX+MvFXLa7uDXAhUUkCxsqv4e8xQyC/os7RXs2QYFFoTANe4fzaGRUHzioE6sQe5EkReoukQ==
X-Received: by 2002:a2e:8144:: with SMTP id t4mr1368074ljg.100.1597299682024;
        Wed, 12 Aug 2020 23:21:22 -0700 (PDT)
Received: from a2klaptop.localdomain ([185.199.97.5])
        by smtp.gmail.com with ESMTPSA id f14sm964060lfd.2.2020.08.12.23.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 23:21:21 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sstabellini@kernel.org, dan.carpenter@oracle.com,
        intel-gfx@lists.freedesktop.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v2 5/5] drm/xen-front: Pass dumb buffer data offset to the backend
Date:   Thu, 13 Aug 2020 09:21:13 +0300
Message-Id: <20200813062113.11030-6-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200813062113.11030-1-andr2000@gmail.com>
References: <20200813062113.11030-1-andr2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

While importing a dmabuf it is possible that the data of the buffer
is put with offset which is indicated by the SGT offset.
Respect the offset value and forward it to the backend.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/gpu/drm/xen/xen_drm_front.c     | 6 ++++--
 drivers/gpu/drm/xen/xen_drm_front.h     | 2 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index 51818e76facd..3dd56794593a 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -157,7 +157,8 @@ int xen_drm_front_mode_set(struct xen_drm_front_drm_pipeline *pipeline,
 
 int xen_drm_front_dbuf_create(struct xen_drm_front_info *front_info,
 			      u64 dbuf_cookie, u32 width, u32 height,
-			      u32 bpp, u64 size, struct page **pages)
+			      u32 bpp, u64 size, u32 offset,
+			      struct page **pages)
 {
 	struct xen_drm_front_evtchnl *evtchnl;
 	struct xen_drm_front_dbuf *dbuf;
@@ -194,6 +195,7 @@ int xen_drm_front_dbuf_create(struct xen_drm_front_info *front_info,
 	req->op.dbuf_create.gref_directory =
 			xen_front_pgdir_shbuf_get_dir_start(&dbuf->shbuf);
 	req->op.dbuf_create.buffer_sz = size;
+	req->op.dbuf_create.data_ofs = offset;
 	req->op.dbuf_create.dbuf_cookie = dbuf_cookie;
 	req->op.dbuf_create.width = width;
 	req->op.dbuf_create.height = height;
@@ -408,7 +410,7 @@ static int xen_drm_drv_dumb_create(struct drm_file *filp,
 	ret = xen_drm_front_dbuf_create(drm_info->front_info,
 					xen_drm_front_dbuf_to_cookie(obj),
 					args->width, args->height, args->bpp,
-					args->size,
+					args->size, 0,
 					xen_drm_front_gem_get_pages(obj));
 	if (ret)
 		goto fail_backend;
diff --git a/drivers/gpu/drm/xen/xen_drm_front.h b/drivers/gpu/drm/xen/xen_drm_front.h
index f92c258350ca..54486d89650e 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.h
+++ b/drivers/gpu/drm/xen/xen_drm_front.h
@@ -145,7 +145,7 @@ int xen_drm_front_mode_set(struct xen_drm_front_drm_pipeline *pipeline,
 
 int xen_drm_front_dbuf_create(struct xen_drm_front_info *front_info,
 			      u64 dbuf_cookie, u32 width, u32 height,
-			      u32 bpp, u64 size, struct page **pages);
+			      u32 bpp, u64 size, u32 offset, struct page **pages);
 
 int xen_drm_front_fb_attach(struct xen_drm_front_info *front_info,
 			    u64 dbuf_cookie, u64 fb_cookie, u32 width,
diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index 4ec8a49241e1..39ff95b75357 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -210,7 +210,8 @@ xen_drm_front_gem_import_sg_table(struct drm_device *dev,
 
 	ret = xen_drm_front_dbuf_create(drm_info->front_info,
 					xen_drm_front_dbuf_to_cookie(&xen_obj->base),
-					0, 0, 0, size, xen_obj->pages);
+					0, 0, 0, size, sgt->sgl->offset,
+					xen_obj->pages);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-- 
2.17.1

