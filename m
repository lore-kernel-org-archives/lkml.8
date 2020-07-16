Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2D8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C8720739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="YSxWDKID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgGPQvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgGPQvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:51:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41399C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 09:51:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ch3so5102766pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 09:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cF35zEvlnFpJY3nfpx97DjW7Gk4E2o0HW6YJ/cWLW0E=;
        b=YSxWDKIDfcBSYuOyxNod6mj4RwZI2A5Ll5tUvgkulF0i1xibjfZWN8vmrzek+38ikU
         8gsuL3tBZfDCVkKWU8lx2Hwz1z4o2YZUoI8KnsmItXNHGEiEs6b4nS+QaJ84OFKURdtY
         c+ihceQOt7HZu5sC8dXqp7NOLN4Jbhcc+pmKCT9r5WDSCqMPq30iBCSbag32ALY9h045
         kFqPQrEWbGiSxL8Z42U79YBcUe7A3ZAjPsiguhs34L9SeOtl/16hog2659hq+WoQtuhP
         3HKzavr3m2z3T8DFH8FIBdxJlCYCZu4/5u1MJZRKM6X2wp8PLTLB3p7WlA0vRugtc3Qr
         kk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cF35zEvlnFpJY3nfpx97DjW7Gk4E2o0HW6YJ/cWLW0E=;
        b=D5iLlAo8RcgNqQP3x78N+PmKwk+5KE7qGOXBgAe5YnyM9YytnrPdXC7Z41dnPNslTP
         pMAQTNWyzZ9uzeylJs5JuqSXWvmWU3yAEwi3josI+C5di46qUFg5hlJvz4ZmnPixFifz
         OhT4dtmg6Z2QI1kNPOLfuzxl3z7UiRfOHsjck35a6VhJsvGXmBx9msIfIWQErGhjU6QN
         ZOYePrxkYdpmpn1XJ+muWnyvvDNr8muETWhT+nDLdtEa/lUcVmr5VJuwvYuLRqLGhF8j
         8yz5pzuCMZQnOsk778PiiW440vQKwb+P3K87Tyx5JKEixlY3cYqGWKvj+b3jxZWkyRXM
         sTnQ==
X-Gm-Message-State: AOAM532H1STcIuTIQ8ULsdqFL6ybdKNAx9RqYeZbEpJ7hBSuOgbO2YiG
        9yFtQ1qJTgsXSnb4d4gNevP6SA==
X-Google-Smtp-Source: ABdhPJwdevQTM4sdK9fP5vns0qbYVTO0UmGpDT1jIwWKwkkQ0EzGWmVgIbLDkPYvgbG+ezdTfBOBXQ==
X-Received: by 2002:a17:90a:6281:: with SMTP id d1mr37699pjj.231.1594918271685;
        Thu, 16 Jul 2020 09:51:11 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.68])
        by smtp.gmail.com with ESMTPSA id z11sm5628013pfg.169.2020.07.16.09.51.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jul 2020 09:51:11 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, shakeelb@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3] mm: memcg/slab: fix memory leak at non-root kmem_cache destroy
Date:   Fri, 17 Jul 2020 00:51:03 +0800
Message-Id: <20200716165103.83462-1-songmuchun@bytedance.com>
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
Acked-by: Roman Gushchin <guro@fb.com>
---

changelog in v3:
 1) Simplify the code suggested by Roman.

changelog in v2:
 1) Fix a confusing typo in the commit log.
 2) Remove flush_memcg_workqueue() for !CONFIG_MEMCG_KMEM.
 3) Introduce a new helper memcg_set_kmem_cache_dying() to fix a race
    condition between flush_memcg_workqueue() and slab_unmergeable().

 mm/slab_common.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 37d48a56431d..fe8b68482670 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -326,6 +326,14 @@ int slab_unmergeable(struct kmem_cache *s)
 	if (s->refcount < 0)
 		return 1;
 
+#ifdef CONFIG_MEMCG_KMEM
+	/*
+	 * Skip the dying kmem_cache.
+	 */
+	if (s->memcg_params.dying)
+		return 1;
+#endif
+
 	return 0;
 }
 
@@ -886,12 +894,15 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
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
@@ -923,10 +934,6 @@ static inline int shutdown_memcg_caches(struct kmem_cache *s)
 {
 	return 0;
 }
-
-static inline void flush_memcg_workqueue(struct kmem_cache *s)
-{
-}
 #endif /* CONFIG_MEMCG_KMEM */
 
 void slab_kmem_cache_release(struct kmem_cache *s)
@@ -944,8 +951,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (unlikely(!s))
 		return;
 
-	flush_memcg_workqueue(s);
-
 	get_online_cpus();
 	get_online_mems();
 
@@ -955,6 +960,22 @@ void kmem_cache_destroy(struct kmem_cache *s)
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
+#endif
+
 	err = shutdown_memcg_caches(s);
 	if (!err)
 		err = shutdown_cache(s);
-- 
2.11.0

