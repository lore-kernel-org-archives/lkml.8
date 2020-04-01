Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A36C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED090206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UHs9U9k2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbgDAW5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:57:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:47048 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732527AbgDAW5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:57:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id g7so1678613qtj.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 15:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=MMaS53tZSqIL6YJ5x3w2mn/RHgoZkNbuAWUFVsV9ivc=;
        b=UHs9U9k2C1EhgFWvZnAXmT/6XD+OerUrLb5FiM1wNa/UCKga3AAUhi9x1/VnDFAV4B
         r5JqmQf05kfBF9QLq+tSkJ0jIOaYLt5o3YXXR0ifO2n2eY5IYLcK6QU11SF0wmGbAj64
         nOlQGBO7gFdK42Sn1bN3iCyFgLb2ZdHiw4qu2dtIAtVyU50Prmi4dSSmH6+bXqqM8VkA
         DFR5l2B3Ad2mBVuYg6PquH1tM+Ae+pPnb4ZnMDEV0XrRq7+jaZJrk5fSRnO4dozaxqGH
         4K7AxIJyPSNPuxIeEHGYOuIAuy+M5s8xLxYn5twwhxg5mUTQ7yEIeMp0OlTiNCRd3HW5
         7VSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=MMaS53tZSqIL6YJ5x3w2mn/RHgoZkNbuAWUFVsV9ivc=;
        b=RVLjqvHJiC2+txuz5NlOB5+VdQpe43pJ+UQUs36Y4971Xa1xsg4q9BNv8KxXlQh6zv
         dAR6Uz/1+FMZsEAC+d1vxDEGkVaWSuJjq7jttAgQq1adoxIzgYEzumoFd2rUIygp6Q14
         NiwSI0ZS4S6i2BMsyT0uH19mc9c7OFDvGbnBjT/JCuUiRW6nQyCTMGpDcRvF8KJfp+3i
         F7MUdW/trHO8l1lDXCCi28a1/b0VTVEl10vkcZCnCFsEuCj/SM8v0rvWuBwTw0nvC2aa
         AvPoAVdPpsyH4ZrlcecH1apy3EmcLPk/MIloCP8OtByDHRS3dZUnvd472Wutleo57i1S
         zfsQ==
X-Gm-Message-State: AGi0PuZt+aVxWTtrY5PX0yZenNIRA0np8KQzyb5dMGAqtx24asftBHlf
        95CIO6q7GigAnzLkvlVeQUA3gLs25+TkIQ==
X-Google-Smtp-Source: APiQypKzSmKhyZAAE+IZSAM9mZJiLkxUuegftj7pW3YTBQoFXC2ggBROM/k/MPzthL+gvel4PnjukA==
X-Received: by 2002:aed:2c06:: with SMTP id f6mr72178qtd.337.1585781847280;
        Wed, 01 Apr 2020 15:57:27 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q5sm2402635qkq.17.2020.04.01.15.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 15:57:26 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@soleen.com, ktkhai@virtuozzo.com, david@redhat.com,
        jmorris@namei.org, sashal@kernel.org, vbabka@suse.cz
Subject: [PATCH v2 1/2] mm: call touch_nmi_watchdog() on max order boundaries in deferred init
Date:   Wed,  1 Apr 2020 18:57:22 -0400
Message-Id: <20200401225723.14164-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401225723.14164-1-pasha.tatashin@soleen.com>
References: <20200401225723.14164-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Jordan <daniel.m.jordan@oracle.com>

deferred_init_memmap() disables interrupts the entire time, so it calls
touch_nmi_watchdog() periodically to avoid soft lockup splats.  Soon it
will run with interrupts enabled, at which point cond_resched() should
be used instead.

deferred_grow_zone() makes the same watchdog calls through code shared
with deferred init but will continue to run with interrupts disabled, so
it can't call cond_resched().

Pull the watchdog calls up to these two places to allow the first to be
changed later, independently of the second.  The frequency reduces from
twice per pageblock (init and free) to once per max order block.

Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages")
Cc: stable@vger.kernel.org # 4.17+

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/page_alloc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..e8ff6a176164 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1639,7 +1639,6 @@ static void __init deferred_free_pages(unsigned long pfn,
 		} else if (!(pfn & nr_pgmask)) {
 			deferred_free_range(pfn - nr_free, nr_free);
 			nr_free = 1;
-			touch_nmi_watchdog();
 		} else {
 			nr_free++;
 		}
@@ -1669,7 +1668,6 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
 			continue;
 		} else if (!page || !(pfn & nr_pgmask)) {
 			page = pfn_to_page(pfn);
-			touch_nmi_watchdog();
 		} else {
 			page++;
 		}
@@ -1809,8 +1807,10 @@ static int __init deferred_init_memmap(void *data)
 	 * that we can avoid introducing any issues with the buddy
 	 * allocator.
 	 */
-	while (spfn < epfn)
+	while (spfn < epfn) {
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
+		touch_nmi_watchdog();
+	}
 zone_empty:
 	pgdat_resize_unlock(pgdat, &flags);
 
@@ -1894,6 +1894,7 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
 		first_deferred_pfn = spfn;
 
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
+		touch_nmi_watchdog();
 
 		/* We should only stop along section boundaries */
 		if ((first_deferred_pfn ^ spfn) < PAGES_PER_SECTION)
-- 
2.17.1

