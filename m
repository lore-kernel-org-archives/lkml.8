Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF865C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 12:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBAA20747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 12:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="JPjtjnfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgFNMjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 08:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNMjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 08:39:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D32C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 05:39:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 64so6574492pfv.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 05:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+068bSrQRTzwliNa3JuLLexz/LOjrev0rMh10PzRkI8=;
        b=JPjtjnfY+gebb1zk2du4tey5HVKYeX+m/+ub8pbP6YeBTMpjROS969iZf3azxemzet
         Z0FjJx1ePbqhmmFbiwcA8Si1ec1mjJfeLHORUEEiuROweMIpQsldZgRTejmdf7uRWdUc
         BRkWHU/806uFqRxmmx1RVd3GVqQOR0GU/qJBvK6pqxdL9CdqnBffj2AsB3T+tRQcmv+7
         f17bqV0jXeYfyhb7uLfFX/sVAXbJ+dDa+KnalDDqFwVgU1G+TrLdZ66XMJrtiDz4XmE0
         PQADGnDM4ODrbtXAmRfPDATcAdcEMtqWJnRK5dqDqLIYWEDj1hgRy9zTLDzMkEPOEJQI
         ZipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+068bSrQRTzwliNa3JuLLexz/LOjrev0rMh10PzRkI8=;
        b=ll0GyKMEm300z8L8PrYcZ7FlF7xjsYaIcvr3n0/BjHzvRtKgkJ0KPwP3KUl3Gfik+f
         KT7H7rVYCE57yAgDfgVz9+2MdD0rQyCrv9dvDBnCKXBIEWqCdiPxQSwS/qA3ir67iVY6
         L9uu0eVtdE8f4Yld/OJaPXBBNotZZb1+9YETqtQqdjNc3asvIzuLQlYc/7FM0TdFR/km
         k6gElGNlf1ljBF/3zLCxUF5yhQheT0H/UIO0pALXqysli5KxJL+bZarhsh3Mag9MBMAT
         YmJpKjrBrIzZR/XOtZvAfd0b1V2/tntIPF9kxsa4jMzIPDeUpvs+F0ubdFvTey8AuT4U
         lSyQ==
X-Gm-Message-State: AOAM531StlAwLLb69G55K0FOi5QT02fC+PfEpbPPZjldrolg27ipGt9i
        MJB9xnHTIZXKLysi3t+uUJvFqA==
X-Google-Smtp-Source: ABdhPJyNXpFiweAi3/sxwpQsIUi7tzjgedJvm+DRs6z/ncE6IJZUIZy9mc5J9v8um/KPxOLLeWhYQQ==
X-Received: by 2002:a05:6a00:1510:: with SMTP id q16mr18443425pfu.164.1592138391321;
        Sun, 14 Jun 2020 05:39:51 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id hi19sm9776606pjb.49.2020.06.14.05.39.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2020 05:39:50 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/3] mm/slub: Fix release all resources used by a slab cache
Date:   Sun, 14 Jun 2020 20:39:23 +0800
Message-Id: <20200614123923.99189-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200614123923.99189-1-songmuchun@bytedance.com>
References: <20200614123923.99189-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function of __kmem_cache_shutdown() is that release all resources
used by the slab cache, while currently it stop release resources when
the preceding node is not empty.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/slub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b73505df3de2..4e477ef0f2b9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3839,6 +3839,7 @@ bool __kmem_cache_empty(struct kmem_cache *s)
  */
 int __kmem_cache_shutdown(struct kmem_cache *s)
 {
+	int ret = 0;
 	int node;
 	struct kmem_cache_node *n;
 
@@ -3846,11 +3847,11 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
 		free_partial(s, n);
-		if (node_nr_slabs(n))
-			return 1;
+		if (!ret && node_nr_slabs(n))
+			ret = 1;
 	}
 	sysfs_slab_remove(s);
-	return 0;
+	return ret;
 }
 
 /********************************************************************
-- 
2.11.0

