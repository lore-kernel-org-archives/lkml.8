Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB7EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 20:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27686206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 20:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="E6EtCHK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390392AbgEYUb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 16:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389950AbgEYUbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 16:31:55 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B999C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 13:31:54 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id se13so21577071ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 13:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RdmBZk3wWhWdfLnacS8DUs6RlId0X8/5siZUx0HN8Ng=;
        b=E6EtCHK3HwZjnoHerbcIjxe44Wozrz2D/brrhHJbbAQmbbDh6Q4BxS8hBiMb/MhDcH
         0N9Lqmt+JwQgXPK0hqyZ5S+DmE09cHYF252zw2ynmQV6L9JDZy4kS9Xkmcfc6zj4PeXy
         2uGRpMofC8DWSxwfDrE3xPpukIp5+GScVw471V90b19TjAicLvBOKy2vtveU0x4BfyKl
         0/sS7krOro164PEO/UHiabl24e7NbIy3ehmVoeDLwhyLhPyjVYcRByT4fY/rqtCuzxUD
         QG3rm8Tq+JKIU/5Q7CxMZBgweU8hfSwbpIaSnn2nEKJwqKbjrRk4tVJPJHWKnxJ0GzrH
         Ss6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RdmBZk3wWhWdfLnacS8DUs6RlId0X8/5siZUx0HN8Ng=;
        b=bMieonDwER3+AER9LMRMww0IYvzLFahMnpWvzKqdDYPSmAQFGeRXiOTrEvfVQRrdYl
         w+LuHntj2Yiz/vwcLKT2d9ZOe5H+ya9x+JArVOC4jA1m3UxY7QD0OLpev/mv0aW0oVRl
         2+pyy+GkbVhTwva7eyUa6P/7NzYa9zOb3Q+3Xo5o0wKpb5KELCVBtSc4o8fByqK2ZdIe
         2D/jzOfoLdnbP36uaO3dKZliAxqw2FvZ8XP+5uPCn9T/53dvHJCBjqmROM8+ZU5DAkih
         BuWPs7sFJYwAvZcvsC1E4dh+Z14W8MG6gNz2CVp2i0/6nyE59mOo/5mES8k0M+gmCDbh
         xwyw==
X-Gm-Message-State: AOAM532hx2OpKR/tBvYDBxBgalFkcuimyzSdTO8AaU2wT9HgQmjDLzZu
        4LpjHF7XzVbjUkMGkWdacCH6Rg==
X-Google-Smtp-Source: ABdhPJyWU1kzWG3OXBGnLiZYT9Vi96JvKEJATvbFYfkxB5ca2OLlQ6pldcYkZGl1gmB01Q36RwIhSA==
X-Received: by 2002:a17:906:3597:: with SMTP id o23mr19545286ejb.174.1590438712716;
        Mon, 25 May 2020 13:31:52 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a9f3:8576:8bb4:4392])
        by smtp.gmail.com with ESMTPSA id s1sm17014881ejh.81.2020.05.25.13.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 13:31:52 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] mm_types.h: change set_page_private to inline function
Date:   Mon, 25 May 2020 22:31:49 +0200
Message-Id: <20200525203149.18802-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change it to inline function to make callers use the proper argument.
And no need for it to be macro per Andrew's comment [1].

[1] https://lore.kernel.org/lkml/20200518221235.1fa32c38e5766113f78e3f0d@linux-foundation.org/

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 include/linux/mm_types.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e88dc5c65c01..64ede5f150dc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -240,7 +240,11 @@ static inline atomic_t *compound_pincount_ptr(struct page *page)
 #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
 
 #define page_private(page)		((page)->private)
-#define set_page_private(page, v)	((page)->private = (v))
+
+static inline void set_page_private(struct page *page, unsigned long private)
+{
+	page->private = private;
+}
 
 struct page_frag_cache {
 	void * va;
-- 
2.17.1

