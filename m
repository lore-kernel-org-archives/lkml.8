Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89885C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A362075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Qb0ZCKir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGGG2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgGGG2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:28:15 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821CAC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 23:28:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s26so4363566pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 23:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eGXjfQahGJEMI3dFWEvZHra9f4CPaADa6kwDLG6Sz0U=;
        b=Qb0ZCKirQkg/pyAtVAEC6B9WFBqOte+gOTfm6ZQjdZwhmUBGB2+XiS5S2ddzoczwUz
         XyxiUhgm8JT4NcXfZolw43un2HQayIVDPk+L/muXIogcLMr4A9ttB6jfqvPljjNRosLc
         Fl0BKy3VI0Q/4jkWy3FNJmHepQDgTAMhNnfqQAKs8AfmX0bkPT7BkscOUd9AmnWmSZzN
         Tuvlg5+ViEHU6AVIwABE5VUFi6gLIERWWsPvLRLhbWApi1Tywf7dtixzL885EdC3tWJm
         znrEJfdeKRtauxg1nJhgtVy4gbzjTKge2Mw2c1BjYHWM/NbLq38/5FEPJ7f7PIkth0sJ
         LFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eGXjfQahGJEMI3dFWEvZHra9f4CPaADa6kwDLG6Sz0U=;
        b=HBLrmzQZULdVRA7nLP8+IpsvB83pHR3Tqd3ElikEmvaTcR/DiKKsmXYtzg8tAr6ggE
         LCnjrBPzMqkb43bt1sQVQP7cp87a5huCCFNHtls+RhwA8HjPxe8Y3ncHuYuo9Ik62AtY
         WrNfoHe2qYQytNhoGf0Xk/POHR7mV0FjpL1i3kxD7ZIESsqjusNtM17ArFYS6iN12uW+
         9h+DC3AIdr5XRC9hx9AMghrvvniRuW8V4J89NuBFxDye/HCls3thnbruSCMrf1X0ePaO
         4ODiNw5ODXg4P0rk+pLjX5DXdxk/0Ey+NCrksiPYgSTrPi43MXNKZV/RyNKCv3tW/jc3
         7sPg==
X-Gm-Message-State: AOAM530Un5OY66QmNTn6rUBYGJwEFZMu8/S1sfq0SxUpEw5LLwhKuPTs
        KYRQKk64DlcS606U2VMKI8UM3A==
X-Google-Smtp-Source: ABdhPJzTlPmc4fvi8qfUEFpH90MaEppPYMQ/O0VUx6imHli5jRS7GKutNv3Wd8FBrZ35ppS9bKW62w==
X-Received: by 2002:a63:db57:: with SMTP id x23mr33353040pgi.178.1594103294073;
        Mon, 06 Jul 2020 23:28:14 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id m12sm1362628pjf.17.2020.07.06.23.28.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2020 23:28:13 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shakeelb@google.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5.4.y, v4.19.y] mm: memcg/slab: fix memory leak at non-root kmem_cache destroy
Date:   Tue,  7 Jul 2020 14:27:54 +0800
Message-Id: <20200707062754.8383-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kmem_cache refcount is greater than one, we should not
mark the root kmem_cache as dying. If we mark the root kmem_cache
dying incorrectly, the non-root kmem_cache can never be destroyed.
It resulted in memory leak when memcg was destroyed. We can use the
following steps to reproduce.

  1) Use kmem_cache_create() to create a new kmem_cache named A.
  2) Coincidentally, the kmem_cache A is an alias for kmem_cache B,
     so the refcount of B is just increased.
  3) Use kmem_cache_destroy() to destroy the kmem_cache A, just
     decrease the B's refcount but mark the B as dying.
  4) Create a new memory cgroup and alloc memory from the kmem_cache
     A. It leads to create a non-root kmem_cache for allocating.
  5) When destroy the memory cgroup created in the step 4), the
     non-root kmem_cache can never be destroyed.

If we repeat steps 4) and 5), this will cause a lot of memory leak.
So only when refcount reach zero, we mark the root kmem_cache as dying.

Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/slab_common.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8c1ffbf7de45..83ee6211aec7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -258,6 +258,11 @@ static void memcg_unlink_cache(struct kmem_cache *s)
 		list_del(&s->memcg_params.kmem_caches_node);
 	}
 }
+
+static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
+{
+	return is_root_cache(s) && s->memcg_params.dying;
+}
 #else
 static inline int init_memcg_params(struct kmem_cache *s,
 				    struct kmem_cache *root_cache)
@@ -272,6 +277,11 @@ static inline void destroy_memcg_params(struct kmem_cache *s)
 static inline void memcg_unlink_cache(struct kmem_cache *s)
 {
 }
+
+static inline bool memcg_kmem_cache_dying(struct kmem_cache *s)
+{
+	return false;
+}
 #endif /* CONFIG_MEMCG_KMEM */
 
 /*
@@ -326,6 +336,13 @@ int slab_unmergeable(struct kmem_cache *s)
 	if (s->refcount < 0)
 		return 1;
 
+	/*
+	 * If the kmem_cache is dying. We should also skip this
+	 * kmem_cache.
+	 */
+	if (memcg_kmem_cache_dying(s))
+		return 1;
+
 	return 0;
 }
 
@@ -944,8 +961,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (unlikely(!s))
 		return;
 
-	flush_memcg_workqueue(s);
-
 	get_online_cpus();
 	get_online_mems();
 
@@ -955,6 +970,30 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (s->refcount)
 		goto out_unlock;
 
+#ifdef CONFIG_MEMCG_KMEM
+	mutex_unlock(&slab_mutex);
+
+	put_online_mems();
+	put_online_cpus();
+
+	flush_memcg_workqueue(s);
+
+	get_online_cpus();
+	get_online_mems();
+
+	mutex_lock(&slab_mutex);
+
+	if (WARN(s->refcount,
+		 "kmem_cache_destroy %s: Slab cache is still referenced\n",
+		 s->name)) {
+		/*
+		 * Reset the dying flag setted by flush_memcg_workqueue().
+		 */
+		s->memcg_params.dying = false;
+		goto out_unlock;
+	}
+#endif
+
 	err = shutdown_memcg_caches(s);
 	if (!err)
 		err = shutdown_cache(s);
-- 
2.11.0

