Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676E3C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D28A206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HpXovz4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390971AbgDCOJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:09:59 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42275 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCOJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:09:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id 139so8020109qkd.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=W9m99TDQLeV99+GCRdJBO+aIjPkNrUp3PY68/9xSZMw=;
        b=HpXovz4ZsBVfNcJM8Huhy4y+11+eUDOZ9KZA1gVuKjNX+47IkisawrgYg0JZq62uNc
         HoPclkVx0CGpDY+dYSju9U5SRJeJDGjLF4whCljM0I8a0oAZyzjp5/KlakMZeYTsHYrW
         eGK9htc5d5zU8rI13VPh+oCtFxNlfbEjr0ooCeYmstD10MtQ9dz4LT2lc/O9rH+Y+hf5
         mxwNnZy2ITWY+AuunJn+bt0q2HJJFy2e5QgIOgwrMSzpjcyz2HnLIVDxCGBFjDYFDCYg
         MVXE6SwTnxFK853qKheN4CpGJHjjRqMQI+D6ammU+nAf3Y2Ooor+il0aYLsMTmft7/TX
         ZjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=W9m99TDQLeV99+GCRdJBO+aIjPkNrUp3PY68/9xSZMw=;
        b=UFQkYGNgPQQrZCmvKzOSLaZIR9Z1CZO98WzTvWAooPbaOrbpBkqdB6vut9GSWvhtDD
         9jHeQKccrZxLw5QGXJR0+4sJldzMFsz1P8qdVnKCjF9aDCHEaJakDFj1O3jUvqhzDkXW
         8QpQIqa5fqUztfMernJpKX4WZbCqgH3rNcIx+x7zjxtS0IfAgcQu0eV09eZcbU2nuAc5
         lI3DZZ6p770HP7uarAiReogS48IlxaCZWFqFqP3qxm7belFy/AEC2tOwl8a0EJUmRwP0
         peyLXIkgGPPqb0hP4GKt6jPMrOcyhOp0emDyggcg3igtw4xe0CXLBVtpsIdLakRDFuOu
         G+ng==
X-Gm-Message-State: AGi0PuY9QwFFW2kKqFgJU9TRb66UpgHotV4GArNgIlhCUUd8VoMkxbMU
        Y6x+1FT6X+SzxRl98A+lyuH2NURfW94=
X-Google-Smtp-Source: APiQypLUS0gnfceDdAcOKLZDc0EqhYDRYzr6A+EIIDB2Vk60l0JH0T9kkeyznkI3MNOTkuodsi/zBQ==
X-Received: by 2002:a37:4fc5:: with SMTP id d188mr8488831qkb.220.1585922996152;
        Fri, 03 Apr 2020 07:09:56 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s56sm6917392qtk.9.2020.04.03.07.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:09:55 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@soleen.com, ktkhai@virtuozzo.com, david@redhat.com,
        jmorris@namei.org, sashal@kernel.org, vbabka@suse.cz
Subject: [PATCH v4 1/3] mm: call touch_nmi_watchdog() on max order boundaries in deferred init
Date:   Fri,  3 Apr 2020 10:09:50 -0400
Message-Id: <20200403140952.17177-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200403140952.17177-1-pasha.tatashin@soleen.com>
References: <20200403140952.17177-1-pasha.tatashin@soleen.com>
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
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e5f76da8cd4e..d95bfd328107 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1633,7 +1633,6 @@ static void __init deferred_free_pages(unsigned long pfn,
 		} else if (!(pfn & nr_pgmask)) {
 			deferred_free_range(pfn - nr_free, nr_free);
 			nr_free = 1;
-			touch_nmi_watchdog();
 		} else {
 			nr_free++;
 		}
@@ -1663,7 +1662,6 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
 			continue;
 		} else if (!page || !(pfn & nr_pgmask)) {
 			page = pfn_to_page(pfn);
-			touch_nmi_watchdog();
 		} else {
 			page++;
 		}
@@ -1803,8 +1801,10 @@ static int __init deferred_init_memmap(void *data)
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
 
@@ -1888,6 +1888,7 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
 		first_deferred_pfn = spfn;
 
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
+		touch_nmi_watchdog();
 
 		/* We should only stop along section boundaries */
 		if ((first_deferred_pfn ^ spfn) < PAGES_PER_SECTION)
-- 
2.17.1

