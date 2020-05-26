Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2959BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FE520674
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADDgO1yJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404007AbgEZUv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403963AbgEZUv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:51:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5199DC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:51:57 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 185so2419958pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=84c4yBEfXJR9rBcq5OPzXonTT8+NleW6lQ5k1QA/SLU=;
        b=ADDgO1yJRKDfKrGbkZJ9Xr9tGv3Rlpo6s7dhDWnowov+fTczDmRjlZ8m7luMhkwmEv
         phefTQDM8DcjAtqX+1hjqSLZEFpLEN6zcLXzUGxjhhG1P+QZui7TitfW0z91ggcqO4dm
         xYuQKIzB2ZPYMkYHDnV5GdRLxeKmbJrHncpFTM1MqLsKzsrd4la/sHAOiI0gV3pDgp/I
         QPTAuOxTnBbs5Z4j+EdHy7avfJNZ3GsSSGQKcILDa41Idlnau5+NyIP0iZRkFa6OUdWp
         UAHKpjTDv//bLiUMEM+EYtUsptnVpyeB67qSDBmyF2iY6BS08Xk8OprKXnKCZEP5000A
         PBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=84c4yBEfXJR9rBcq5OPzXonTT8+NleW6lQ5k1QA/SLU=;
        b=WRjWIJuJyh7nBo3W1PRD/UdmuljDqCS2OqXkG879JVaR6sDQNJCkOD6YbYLcwLiiXE
         LSO6VTk3lnYcrwh/oNpNvAhb9HVTqiJwWt6926xzdlfq1SeZbfo0lZOAXWvXIDcEP6qe
         r5dgrqEJl10MU//6ZMp7gdP4uUPfC67xDnRwgTrwvI7QZ5+BjpWdY+uGj9ZX4nwI0GOl
         U+4V3to+PYUgPnqSOfkQWWTwgumrrZDMDEC6RsCuNh8bYQ1b015uo7PtTHIJw2LAPc0T
         901DVW2rPqEYWQtm/lJ9IHxYoDMRApK8rJOKDwmhTDGebcTKTv0jNjzM1BwSZ8bkKu7m
         CXzw==
X-Gm-Message-State: AOAM531Ph9q8YN8+F8nM924omsSUhWxOPiJbCTvNA59GBnZKcD/JTcBC
        rgQaLBko+HbazfI7cfMFyDo=
X-Google-Smtp-Source: ABdhPJzgMbTszipak4xmw5QtemttiLGjdNZ+kzvDA9nvx2w0FqIaoOqfVu1/VzcOknAOPsTgO1cTow==
X-Received: by 2002:a05:6a00:46:: with SMTP id i6mr647621pfk.146.1590526316742;
        Tue, 26 May 2020 13:51:56 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([171.48.17.249])
        by smtp.gmail.com with ESMTPSA id v22sm380239pfu.172.2020.05.26.13.51.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 13:51:56 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] drm/radeon: Convert get_user_pages() --> pin_user_pages()
Date:   Wed, 27 May 2020 02:30:02 +0530
Message-Id: <1590526802-3008-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code was using get_user_pages(), in a "Case 2" scenario
(DMA/RDMA), using the categorization from [1]. That means that it's
time to convert the get_user_pages() + release_pages() calls to
pin_user_pages() + unpin_user_pages() calls.

There is some helpful background in [2]: basically, this is a small
part of fixing a long-standing disconnect between pinning pages, and
file systems' use of those pages.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>

Hi,

I'm compile tested this, but unable to run-time test, so any testing
help is much appriciated.
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 5d50c9e..e927de2 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -506,7 +506,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 		uint64_t userptr = gtt->userptr + pinned * PAGE_SIZE;
 		struct page **pages = ttm->pages + pinned;
 
-		r = get_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
+		r = pin_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
 				   pages, NULL);
 		if (r < 0)
 			goto release_pages;
@@ -535,7 +535,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 	kfree(ttm->sg);
 
 release_pages:
-	release_pages(ttm->pages, pinned);
+	unpin_user_pages(ttm->pages, pinned);
 	return r;
 }
 
@@ -562,7 +562,7 @@ static void radeon_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
 			set_page_dirty(page);
 
 		mark_page_accessed(page);
-		put_page(page);
+		unpin_user_page(page);
 	}
 
 	sg_free_table(ttm->sg);
-- 
1.9.1

