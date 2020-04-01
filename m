Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B69C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2A120719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="nkvhrcmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbgDATcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:32:43 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45644 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732244AbgDATcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 15:32:43 -0400
Received: by mail-qk1-f194.google.com with SMTP id c145so1275565qke.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 12:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id;
        bh=8sYcdfSwvJ7GU27ydMWlYk6GPFp2IEn+qpWqN6lfgv8=;
        b=nkvhrcmUfagpr2oQYYqjbotL3Vw0ugDYVnuHKd1hN6z5UqMf/7JJuzuXJBvhm3IR1w
         cjghLDInZI9fi2X+8gk26/W4tD5pyu5rvsDTZkRpP8fcayYp+LUkIHRXYaKF6+9yxt/U
         6de6nc0uxXpa8PTG8wVKzwPpOJdl/XR5JsyNTyrp6ueVFekd63TCU3lkX3qxzfJ5UaAT
         +maDA1h6rLGgXHZJ0WczttOLiHD6Cb3LZNy10bE1jvwQdxvQjFkkhvJ4IbHGkPvSYWWr
         V8B15YCVgLLydloCG/DjTaQsRI46585Y+gydNkNS3J5V7WkmOXHzCbbChYq78buTdtEQ
         VTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=8sYcdfSwvJ7GU27ydMWlYk6GPFp2IEn+qpWqN6lfgv8=;
        b=RloHn/JShoryiKLMk2aLUUfsb8CDGzpnvYg6nS0KnnKx9AasfIzLLe6g6Xj7zhhmF5
         0Be9b2MWfnUC6ZK8SaBbAB6sS8rdzqMPz2r7hJ1qSmAxOxaEvgKAEYzOeEZdiG8Pe2vJ
         6GYFhLBu3z9hO/5bs7PyRDgYXaJn3DhV6T4dksimwQCr0DBdSZ2fdZ90BGPJaGe8vgY/
         P0G8qXQWb3z3bBmWIjMQR2idrBr7cz/gsmDMKVpXPAlwe8dmeQO/wQPhKJ8+gWboHQSU
         MQFfSBNLq1k6YIQJl4/gre7TYAyuEWbW7ivk97rLVEGW6JVvhFOEEjgocb6yTbxp84l8
         SGgQ==
X-Gm-Message-State: ANhLgQ2X01ztJoYCiqtm3T1W/pKi7cqn8LUS5kaZJmPsZgvbcRPXYLLp
        EsB9R5/rATqvyZoLggBqDUDLGPJ0x9mMuA==
X-Google-Smtp-Source: ADFU+vuPQVF2n6nuyNe96HQIiCQgRwZKROr5AyHweWIc1rG+54male7SxFwauWXmFTfMxzBZGD993Q==
X-Received: by 2002:a37:66cf:: with SMTP id a198mr11805930qkc.203.1585769560393;
        Wed, 01 Apr 2020 12:32:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y132sm2040516qka.19.2020.04.01.12.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 12:32:39 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@soleen.com, ktkhai@virtuozzo.com, david@redhat.com,
        jmorris@namei.org, sashal@kernel.org
Subject: [PATCH] mm: initialize deferred pages with interrupts enabled
Date:   Wed,  1 Apr 2020 15:32:38 -0400
Message-Id: <20200401193238.22544-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing struct pages is a long task and keeping interrupts disabled
for the duration of this operation introduces a number of problems.

1. jiffies are not updated for long period of time, and thus incorrect time
   is reported. See proposed solution and discussion here:
   lkml/20200311123848.118638-1-shile.zhang@linux.alibaba.com
2. It prevents farther improving deferred page initialization by allowing
   inter-node multi-threading.

We are keeping interrupts disabled to solve a rather theoretical problem
that was never observed in real world (See 3a2d7fa8a3d5).

Lets keep interrupts enabled. In case we ever encounter a scenario where
an interrupt thread wants to allocate large amount of memory this early in
boot we can deal with that by growing zone (see deferred_grow_zone()) by
the needed amount before starting deferred_init_memmap() threads.

Before:
[    1.232459] node 0 initialised, 12058412 pages in 1ms

After:
[    1.632580] node 0 initialised, 12051227 pages in 436ms

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/page_alloc.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..4498a13b372d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1792,6 +1792,13 @@ static int __init deferred_init_memmap(void *data)
 	BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
 	pgdat->first_deferred_pfn = ULONG_MAX;
 
+	/*
+	 * Once we unlock here, the zone cannot be grown anymore, thus if an
+	 * interrupt thread must allocate this early in boot, zone must be
+	 * pre-grown prior to start of deferred page initialization.
+	 */
+	pgdat_resize_unlock(pgdat, &flags);
+
 	/* Only the highest zone is deferred so find it */
 	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
 		zone = pgdat->node_zones + zid;
@@ -1812,8 +1819,6 @@ static int __init deferred_init_memmap(void *data)
 	while (spfn < epfn)
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
 zone_empty:
-	pgdat_resize_unlock(pgdat, &flags);
-
 	/* Sanity check that the next zone really is unpopulated */
 	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
 
@@ -1854,18 +1859,6 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
 		return false;
 
 	pgdat_resize_lock(pgdat, &flags);
-
-	/*
-	 * If deferred pages have been initialized while we were waiting for
-	 * the lock, return true, as the zone was grown.  The caller will retry
-	 * this zone.  We won't return to this function since the caller also
-	 * has this static branch.
-	 */
-	if (!static_branch_unlikely(&deferred_pages)) {
-		pgdat_resize_unlock(pgdat, &flags);
-		return true;
-	}
-
 	/*
 	 * If someone grew this zone while we were waiting for spinlock, return
 	 * true, as there might be enough pages already.
-- 
2.17.1

