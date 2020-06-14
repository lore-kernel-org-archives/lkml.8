Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82C9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 12:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EE5206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 12:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="UZdFv0Xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgFNM1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 08:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgFNM1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 08:27:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF65CC03E969
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 05:27:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b7so5263975pju.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O3wDQLkjLZhz8HlGMqP3m6FBvc0T90YmqvSvkQbSHmY=;
        b=UZdFv0Xir9MEd893nm2NsmxcmIkqD+9uJfe/NWiB6X4ESmnvYuGlbYeBwqpFlqO9RE
         GEBYJJZFKnYz3RhjfSojLRVr5YVm5AGj/u7OUlKiuBC9pTCpa/UTUp4W0JS62X3RZVlN
         yUkG04sIKOg+sRsa+nZB76FklBpGfLDF2tULWeLOIx3xRMLvhRlyusQ8swY5N6V6FueI
         OgCRl6obnJBQmMr4UfhxeO0voZrS3sJhbQYyQanMRjl6HbdtGdAg8MKQCLIovef0xhA0
         hY8ljJPDg1iToDvZczOb8CPHo34wtShhA11Rm7JQiD3cdRyhygvgKhIxkBp0UuA/gl99
         oQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O3wDQLkjLZhz8HlGMqP3m6FBvc0T90YmqvSvkQbSHmY=;
        b=oWlyFEBiFbKkkBaUNsA+flBL7J7sy62uTkylqWeJ4IO7FbjmIS5hFuS3y5w2qM6S+N
         nLKGgGZ79O96wBJMEyQ86rSLXn9ScIGjCn91B1EGU1ZldlKM62BsJlw5QE9sIGFRsWAj
         xaeAe6SCcQdMJamLqqQgbDywotbTZmC1Yr5rjvUPxHrwtXNLEjvaOSvDfSyIl/KbJPjk
         PI4H3eFG9nedeoKJI7NuxsWonWFSgmJqGzAa+U7SMB2JgD5Yr2Iw0GrKsHTh2O6QKYpQ
         kn3MAoU5JgWEncxn80eNlxkr/6SPI0Ubo4iCTFtYEB2btpt2Gd+qqTDFHLAUua0mSKk+
         w0UA==
X-Gm-Message-State: AOAM53083svT2/r5Dtwn8ufcmr05p6lypaOGDt/4KfUMwlN36mSIaf3m
        kjepRbm3wNKpjLf5ylWUhgiCTQ==
X-Google-Smtp-Source: ABdhPJyKXq2O5tZt9d5Ihr84MF3ntpaY3fEND9aEIzF7aB1JW4W4ZCcKR2/fuQNjE6b9yQhdOpGLeg==
X-Received: by 2002:a17:90a:de1:: with SMTP id 88mr7630576pjv.124.1592137639325;
        Sun, 14 Jun 2020 05:27:19 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id u12sm9688454pjy.37.2020.06.14.05.27.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2020 05:27:18 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     guro@fb.com, cai@lca.pw, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: Fix do not put the css reference
Date:   Sun, 14 Jun 2020 20:26:53 +0800
Message-Id: <20200614122653.98829-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should put the css reference when memory allocation failed.

Fixes: f0a3a24b532d ("mm: memcg/slab: rework non-root kmem_cache lifecycle management")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0b38b6ad547d..2323d811ee8e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2772,8 +2772,10 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
 		return;
 
 	cw = kmalloc(sizeof(*cw), GFP_NOWAIT | __GFP_NOWARN);
-	if (!cw)
+	if (!cw) {
+		css_put(&memcg->css);
 		return;
+	}
 
 	cw->memcg = memcg;
 	cw->cachep = cachep;
-- 
2.11.0

