Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D10C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 12:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8742068E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 12:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="h95l6fmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgFNMjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 08:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNMjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 08:39:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50415C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 05:39:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s23so6583599pfh.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c75aG2jcBkW1YvTjsD3CcRFk1jXL3rUV/LlkBUI559A=;
        b=h95l6fmdF6PB08EzEVVE4kGqkNRpZ/L7cyHelT7JSCcCdG0z3dD73agIKIx3vDeTNA
         zs8HbhczjXPsqfp7FRkzyEOYfTOPSOSKoVpCZNppOen8av+u+y2b+VIVGBzmmi78TkPy
         ToXz8xtpvhiC/QNB5QQvBAezBGXnXPCMt3NpwYvOpKnB+IkaMieiK93zAawvQjrSmFM5
         Db6ir2WQNsprOJis1GEYp92pH6d1ze7p3TPR1oE/RVxan5TRY2pa5YwtNdKpcTRq7epl
         YVd6wKZLOLSa0I9QAPSOwAnSofBQfwjQXqqJNrpQU3KLSWwXMfW9W7flb5veTctnNVWX
         ZfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c75aG2jcBkW1YvTjsD3CcRFk1jXL3rUV/LlkBUI559A=;
        b=UgRvFvs/Y5ZUEzoBmB5cNFZHlgyveba5Kz/4NWI292wYaKdgx9tDJ7WEw8kjPwfKLn
         89nZeIi6S/ePzW5qX1AfvT+NIblnnJjWLRA2maCg1CoMO/E4vjRoUvW80jgprCR3eItC
         Rpfe+VPcHd9Etz30cHCcKnR/7ZfBbA/cVKvh3oeDfwQpBLC7vVKBJoM+RIwUjVYMOog8
         /uQyP9STnJizoHMQpNr9sVGU6V4CCludLkRilaEjEVt6g6TjWqszySrZLbBWNQCgoEll
         sxSiPBO+Mae5LhjW2hIQnQrKTptQdvHfttmVon9tWnPiCXPKc5/FdY3dZWhO9BG5c41v
         Q0Uw==
X-Gm-Message-State: AOAM530uTOW12eUooMGsG1lMQQGjFdacuzbaZJ0FHMLBIyL+O1U+pgKO
        c9dQg5jFBKMOIcMoag+4Hf/BhA==
X-Google-Smtp-Source: ABdhPJxQZ8oVwTk5ypuZDHl7oYCUphPfbB/M3h2HtMM5X79z8UpBm/aqHNasl1ppxxKSeNjgb9X8fQ==
X-Received: by 2002:a63:2a8a:: with SMTP id q132mr17250492pgq.279.1592138386924;
        Sun, 14 Jun 2020 05:39:46 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id hi19sm9776606pjb.49.2020.06.14.05.39.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2020 05:39:46 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/3] mm/slub: Use node_nr_slabs() instead of slabs_node()
Date:   Sun, 14 Jun 2020 20:39:22 +0800
Message-Id: <20200614123923.99189-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200614123923.99189-1-songmuchun@bytedance.com>
References: <20200614123923.99189-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the some code, we already get the kmem_cache_node, so we can
use node_nr_slabs() directly instead of slabs_node(). Check the
condition of n->nr_partial can also be removed because we can get
the correct result via node_nr_slabs().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/slub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1a3e6a5b7287..b73505df3de2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3829,7 +3829,7 @@ bool __kmem_cache_empty(struct kmem_cache *s)
 	struct kmem_cache_node *n;
 
 	for_each_kmem_cache_node(s, node, n)
-		if (n->nr_partial || slabs_node(s, node))
+		if (node_nr_slabs(n))
 			return false;
 	return true;
 }
@@ -3846,7 +3846,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
 		free_partial(s, n);
-		if (n->nr_partial || slabs_node(s, node))
+		if (node_nr_slabs(n))
 			return 1;
 	}
 	sysfs_slab_remove(s);
@@ -4126,7 +4126,7 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 		list_for_each_entry_safe(page, t, &discard, slab_list)
 			discard_slab(s, page);
 
-		if (slabs_node(s, node))
+		if (node_nr_slabs(n))
 			ret = 1;
 	}
 
@@ -4201,7 +4201,7 @@ static void slab_mem_offline_callback(void *arg)
 			 * and offline_pages() function shouldn't call this
 			 * callback. So, we must fail.
 			 */
-			BUG_ON(slabs_node(s, offline_node));
+			BUG_ON(node_nr_slabs(n));
 
 			s->node[offline_node] = NULL;
 			kmem_cache_free(kmem_cache_node, n);
-- 
2.11.0

