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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E52C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBAB52177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvGhnctd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbgGaMv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbgGaMvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:51:19 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C45C061575
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:51:18 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h8so16761847lfp.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=in3e/rhynkLwVD5V9PwoaNI3UJD8A73TVa8u/14UsAg=;
        b=dvGhnctdpY5kxFxb0suRBtGNcio8aozQM9kdwS+Lnwi6/6de1sgC6u7OXXgupL3KX2
         CzjQ8fZkjfpjEM8Ct/Rl4YPy3RXEMyiAxnq6w0+TAqibQWiMtXMmRYiVdbWlDCLDExp0
         oRSTR1udpBecZD7hP4CuP4fsW1WUZOXMyRpiX52GsPu8zk/CAJpl0Ozg9mQi94llxQ9A
         YDcTUgBuVLAXdjVPehaqgATExkYwQHpVbPFgQcFFGFYUxffiNQmOCqYF1R34fiJLe/+4
         bu77en9ko2W4Qny1ym2XxbQtdj/47CBtRgk9E5QWu0Vo7/i4SQO/zCHjVP+UYAjeOzTP
         F4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=in3e/rhynkLwVD5V9PwoaNI3UJD8A73TVa8u/14UsAg=;
        b=AJarzwhLmG6EIplp0o+Umq+G8ercZ0+I8ecMGDOcqDvcv34VrTCn1gfzjrePkJ6aQU
         fXJ4NAkGjSHq8dQUxvKrd6c/5bksnYAjwFwxpqyGiOiat6inE7/4djM8w0edvauWOy9W
         NAjdR6MaPgUGYHit6Xgf0uDe5uR/ZaHrBL4jXm9VJqbqFzSY8WJLDsaPYdTONIcglNw9
         0aEB4b0cbN/Hm5fDe7lg2uhg1IJOzTIj+AyKuV+uCAFERIUdzm83KytKEuo/i60s4Mz7
         oIkX3oQ/XW6pzMaYOy9QQjTkDKGyCjhZLi19nIYfpP4lhtTvlAH4kQnq5R7UnpfUvKaB
         uM5g==
X-Gm-Message-State: AOAM530zVRSeTiJbbLE+fqLPgGAEfJ9rNxI2dJ+6h1pXWzjg7e/M5eP1
        e8Q5I0uGF3Uuxd6keWvCNis=
X-Google-Smtp-Source: ABdhPJxYkcBz7mtQ/VNmuWNPBGMmzaqks8S8snreTQ/Yahk5mchXkjcy3WbaQqY4RS/Kt1wg3P3OVw==
X-Received: by 2002:a19:ae06:: with SMTP id f6mr1992770lfc.42.1596199876892;
        Fri, 31 Jul 2020 05:51:16 -0700 (PDT)
Received: from a2klaptop.localdomain ([185.199.97.5])
        by smtp.gmail.com with ESMTPSA id s2sm1923362lfs.4.2020.07.31.05.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:51:16 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sstabellini@kernel.org, dan.carpenter@oracle.com,
        intel-gfx@lists.freedesktop.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 3/6] drm/xen-front: Add YUYV to supported formats
Date:   Fri, 31 Jul 2020 15:51:06 +0300
Message-Id: <20200731125109.18666-4-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731125109.18666-1-andr2000@gmail.com>
References: <20200731125109.18666-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Add YUYV to supported formats, so the frontend can work with the
formats used by cameras and other HW.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front_conn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_conn.c b/drivers/gpu/drm/xen/xen_drm_front_conn.c
index 459702fa990e..44f1f70c0aed 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_conn.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_conn.c
@@ -33,6 +33,7 @@ static const u32 plane_formats[] = {
 	DRM_FORMAT_ARGB4444,
 	DRM_FORMAT_XRGB1555,
 	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_YUYV,
 };
 
 const u32 *xen_drm_front_conn_get_formats(int *format_count)
-- 
2.17.1

