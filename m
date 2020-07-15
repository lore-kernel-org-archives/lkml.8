Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F06C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7AE20672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Eq7YBqvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGOQui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGOQuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:50:37 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3CAC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 09:50:37 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so3349968pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMqIy3T6Ix+Em0b+36gk3NtDJw0Mhrphx3pfNV9mw6g=;
        b=Eq7YBqvG1cx6mJBewkrWbQhs3iYhLyGyNq+EIEkepazXpIGK8JmduABRFSDOHBeg1T
         YAhY9L1CVBf/rIPgZSVxtaB6fSWgYAphkK59NtF05wTLYg6nzGOoz8unajE/EdEPY7Hw
         PLygagx34WGPYdL1+fIE65S487Khhx1ASVM3TOmF983JAHpmXyuhvggr33iKMRaZYr+f
         TmOXyxxVx/DuzA0OxCa3WvkWQcYn8yrf6mPIUqHuAEMLUPcRkg20QT33L5n2J1zS8aTl
         DZP0t8uEtWDGpTNxcjVIQG0aQVPmosq1/vcfYq90b9sPQ+rb+be/mK12wqslTfsMJelo
         0UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMqIy3T6Ix+Em0b+36gk3NtDJw0Mhrphx3pfNV9mw6g=;
        b=QwdC7zZnoVelByKy1Ckbj+MzYg573g8LWTkxgjz/xa8L3FOscQLhTQq/itPqU442dd
         4a8V0FKMCm89zkthk8lbOCathLbxtfEcti9Loo1WQ5M0naE7ELWEFlD/1xFvlYuNKS6s
         xyWEC+rK955jwII4dmeyfgCmEK8987N29xzaKZW+XsGlnVPVqNVmGgfvxmkor7gsugGD
         t5PQmrJs6v1iwvATq2haIQVmUcUnwhQ70uiGc0EXibi8V7wYh0OgSo8WOCkU7qX1kb1v
         4O/VuTgcKXnrvcz/zsWlqWkBNNvfFfhAr9kqkxufSfIob6Yi+WO2UWmwJOPvJWmP/Gyr
         JtdQ==
X-Gm-Message-State: AOAM530Li8qCjjvhzQ0kW2xkMFe0hxDS5qmPfQnj19bLAZ91DKTaQXSQ
        VlMcS+Wdl5qqScB+haxuMwqqSg==
X-Google-Smtp-Source: ABdhPJwHAiEC5QJTaasRq724Ql/4PZyQHjjGHY9KrBd2KjUUv48sqlnZjbs65SNtrvAgoEXaRSwa3w==
X-Received: by 2002:a17:90a:12c7:: with SMTP id b7mr540254pjg.137.1594831836920;
        Wed, 15 Jul 2020 09:50:36 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.67])
        by smtp.gmail.com with ESMTPSA id b21sm2648979pfp.172.2020.07.15.09.50.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 09:50:36 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, shakeelb@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm: memcg/slab: fix memory leak at non-root kmem_cache destroy
Date:   Thu, 16 Jul 2020 00:50:22 +0800
Message-Id: <20200715165023.29919-1-songmuchun@bytedance.com>
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
     B. It leads to create a non-root kmem_cache for allocating memory.
  5) When destroy the memory cgroup created in the step 4), the
     non-root kmem_cache can never be destroyed.

If we repeat steps 4) and 5), this will cause a lot of memory leak.
So only when refcount reach zero, we mark the root kmem_cache as dying.

Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---

changelog in v2:
 1) Fix a confusing typo in the commit log.
 2) Remove flush_memcg_workqueue() for !CONFIG_MEMCG_KMEM.
 3) Introduce a new helper memcg_set_kmem_cache_dying() to fix a race
    condition between flush_memcg_workqueue() and slab_unmergeable(). 

 mm/slab_common.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8c1ffbf7de45..c4958116e3fd 100644
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
 
@@ -886,12 +903,15 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
 	return 0;
 }
 
-static void flush_memcg_workqueue(struct kmem_cache *s)
+static void memcg_set_kmem_cache_dying(struct kmem_cache *s)
 {
 	spin_lock_irq(&memcg_kmem_wq_lock);
 	s->memcg_params.dying = true;
 	spin_unlock_irq(&memcg_kmem_wq_lock);
+}
 
+static void flush_memcg_workqueue(struct kmem_cache *s)
+{
 	/*
 	 * SLAB and SLUB deactivate the kmem_caches through call_rcu. Make
 	 * sure all registered rcu callbacks have been invoked.
@@ -923,10 +943,6 @@ static inline int shutdown_memcg_caches(struct kmem_cache *s)
 {
 	return 0;
 }
-
-static inline void flush_memcg_workqueue(struct kmem_cache *s)
-{
-}
 #endif /* CONFIG_MEMCG_KMEM */
 
 void slab_kmem_cache_release(struct kmem_cache *s)
@@ -944,8 +960,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (unlikely(!s))
 		return;
 
-	flush_memcg_workqueue(s);
-
 	get_online_cpus();
 	get_online_mems();
 
@@ -955,6 +969,32 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (s->refcount)
 		goto out_unlock;
 
+#ifdef CONFIG_MEMCG_KMEM
+	memcg_set_kmem_cache_dying(s);
+
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
+		 * Reset the dying flag setted by memcg_set_kmem_cache_dying().
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

