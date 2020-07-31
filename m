Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB31C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D792087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUpNekSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbgGaMvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733289AbgGaMvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:51:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63900C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:51:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v12so1992387ljc.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=802wLPAiJOjYAF20z0XA9+ti0fbeGRnp8uxtEVqZ2cw=;
        b=XUpNekScbM7pVkILHss15SrZ149Lm5AtQfG+6vzsprcdirumI53ZN4t6VgSMIYCR07
         9skaHVlkX7NcNFlcoaIjMIYSSo7VYBaJxeFKKYA+1ThMAmgeCAorx2b8WQDzWH/EGcSL
         ZACMLyTvq9p49NUdDZQJ+C+6q75OV7U/dPqL0HqWZKTCJ09TgWEz8ZiW5LPhvz2Zln7Y
         qLR/h+WuI938pTe27pXqjPod/3HJqe4kl8HPpgANJKQL9Fx2Abd50/Qurj9uH4ULNMGa
         JFm0yWYg0IArPZxrohxFHuEZSdW3ZFfFWjH48CxRSNPSLbf6dahnKvy02/L1oQOkzkQl
         xcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=802wLPAiJOjYAF20z0XA9+ti0fbeGRnp8uxtEVqZ2cw=;
        b=PdZvRjuo+O+gDs1Ifqopkr8Z83Ch8eTxCj2CmAVX0263NH+wRdVYe5r4e6d9NoySlj
         bGHpYhbMEWwVG5/jeHgmNkTQPYd4xW6kfcv+1U4QzE9QJ1J93jb5MsOI8i5RVAA/H5gU
         G29EC1P2caTG0k0s4buDYIyayHkomovQHagiXpSzreUlq3Sp9MZzqine2qFeA047/uXi
         K0IbigexfaBkJpqj+faYLtbJVJ7xP4ionlGQS/hqtXmDJFf9IfdscyQc043snm3792Vn
         7LFTLB5A2ycD+aZvvD3uMW/r4UEy/WR8UNqHuJb4KgcMmTeazndwSgjT3cLPwIlHAXoX
         jjNA==
X-Gm-Message-State: AOAM530kxJNmkF7WBxXo2OrtHVHrXicR7aiUzV837ob0hvohk8XrJMf3
        kYdyKdhAlikHpGl9R2VwR0s=
X-Google-Smtp-Source: ABdhPJxCBCQqGvpy9XgTgM7mttEVb5TQWPTSAYYjB8mKwaVorgp/Gu6H2+I5YwJsHP9dUUFce4OPrw==
X-Received: by 2002:a2e:b610:: with SMTP id r16mr1841475ljn.439.1596199879842;
        Fri, 31 Jul 2020 05:51:19 -0700 (PDT)
Received: from a2klaptop.localdomain ([185.199.97.5])
        by smtp.gmail.com with ESMTPSA id s2sm1923362lfs.4.2020.07.31.05.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:51:19 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sstabellini@kernel.org, dan.carpenter@oracle.com,
        intel-gfx@lists.freedesktop.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 5/6] drm/xen-front: Pass dumb buffer data offset to the backend
Date:   Fri, 31 Jul 2020 15:51:08 +0300
Message-Id: <20200731125109.18666-6-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731125109.18666-1-andr2000@gmail.com>
References: <20200731125109.18666-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

While importing a dmabuf it is possible that the data of the buffer
is put with offset which is indicated by the SGT offset.
Respect the offset value and forward it to the backend.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front.c     | 6 ++++--
 drivers/gpu/drm/xen/xen_drm_front.h     | 2 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index 88db2726e8ce..013c9e0e412c 100644
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

