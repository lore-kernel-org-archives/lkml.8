Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B45BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3CA206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O1o8GaHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgFZUH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgFZUHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:07:55 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A83C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:07:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g67so4503181pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rHOsQnFow9W840xshXf2xfNnPEJVNN56X5OCKvatOzc=;
        b=O1o8GaHMP5dsVMNrT+KaSdj+Cb9ib0h6L+CH70DoWS18/VdJXbuH3MqWxoarxbltgf
         9hqSJ7UZ0CHVc+r7XcLBCbzl4RMaKaTYV2GzT8d7aP5yg1A2C4iPLgzgAx6iszB9UWWq
         7bLvYkt1y57I9p+8bV+wJcxmRsOeoHMBs0tZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rHOsQnFow9W840xshXf2xfNnPEJVNN56X5OCKvatOzc=;
        b=FkecVs4gBIdU/rN46c1eMbem1B8BLdHDRNRfvDo7nUV0qovDpf0AwIxbg7fI/ZDsci
         tk0mRToSLUGkbQZMbqDDOydRDAG5AqnGG6cWXAaUzSrEA06/CLXuNg0oWDhFm8esom7U
         B4JZGTGhEU2Pijd8wHvWfg5IGhtgAuNk3zx0CXGa6C9SA6L/S2lr+8kg+zNaj5xYmeVG
         fEpirst8yVYJ+RKLEZAHQaIMLgBvKzvjMHvXKDOD1jt4WiYN80yi96FlTSv9R32CWXsg
         O8weCSZAAMoFMSfbSIFOjvJvhnYeB9h2/2RIOzCFQnOe/nqjrCXvrR64mNnGBa4fOqYI
         5pUw==
X-Gm-Message-State: AOAM533FPaiwfjvW38Hosrm0sGwD/WQb0nZ7zOJ3NBRWiQl8XcMNZEzw
        bXLPH5DuxUep6bpRl5N70f8YzA==
X-Google-Smtp-Source: ABdhPJzhZjWKtrGEMaI8byUSdrVEOM1KRfW4lUX66uoeR6p2vSSKp4YijRN8kDnSI5dkSRP37/P6Cw==
X-Received: by 2002:aa7:8c03:: with SMTP id c3mr4048300pfd.77.1593202075575;
        Fri, 26 Jun 2020 13:07:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n1sm12409458pjn.24.2020.06.26.13.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:07:54 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:07:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     akpm@linux-foundation.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Subject: [PATCH] slab: Fix misplaced __free_one()
Message-ID: <202006261306.0D82A2B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation of __free_one() was accidentally placed inside a
CONFIG_NUMA #ifdef. Move it above.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/lkml/7ff248c7-d447-340c-a8e2-8c02972aca70@infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This a fix for slab-add-naive-detection-of-double-free.patch
---
 mm/slab.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index bbff6705ab2b..5ccb151a6e8f 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -588,6 +588,16 @@ static int transfer_objects(struct array_cache *to,
 	return nr;
 }
 
+/* &alien->lock must be held by alien callers. */
+static __always_inline void __free_one(struct array_cache *ac, void *objp)
+{
+	/* Avoid trivial double-free. */
+	if (IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
+	    WARN_ON_ONCE(ac->avail > 0 && ac->entry[ac->avail - 1] == objp))
+		return;
+	ac->entry[ac->avail++] = objp;
+}
+
 #ifndef CONFIG_NUMA
 
 #define drain_alien_cache(cachep, alien) do { } while (0)
@@ -749,16 +759,6 @@ static void drain_alien_cache(struct kmem_cache *cachep,
 	}
 }
 
-/* &alien->lock must be held by alien callers. */
-static __always_inline void __free_one(struct array_cache *ac, void *objp)
-{
-	/* Avoid trivial double-free. */
-	if (IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
-	    WARN_ON_ONCE(ac->avail > 0 && ac->entry[ac->avail - 1] == objp))
-		return;
-	ac->entry[ac->avail++] = objp;
-}
-
 static int __cache_free_alien(struct kmem_cache *cachep, void *objp,
 				int node, int page_node)
 {
-- 
2.25.1


-- 
Kees Cook
