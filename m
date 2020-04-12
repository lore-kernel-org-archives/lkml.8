Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C2CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135A520739
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6V+wkIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgDLJN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 05:13:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35816 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgDLJN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 05:13:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id y12so2038444pll.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 02:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=RuB1CaDpM0woLJXutDrQTOUUotmzhwc0OsCFpbFNptA=;
        b=H6V+wkIRDejLir6iRbxVY7CX2fia/E09n9eexfrXPrbXSwPB7iYZSqJIMSDwa+w9Z7
         3j1u23NQvBvNsKsq/r+qCdUim8VsGxkUpXC80iNFjD28ASiuzwT0ViCnPsUuDzKO/9au
         WlSD8vkDoFIajB9XtSwyIvuyu70EsfMh7xgLvcH2gEQXf+4MdOBXiwraC0/qxwLU84T3
         4FApS/7RK58A0rgXMcgAaA/oVkTY58KwDEbg7VQJdmxbhQdLVrx2xDQWU8gKlK0IU1gG
         gAZsGlJ0OWf/2QeRUC4h3ol6hBF6CK4VdUAw7bOti56H/siMGzMOk+euNtiujucc96W3
         cjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=RuB1CaDpM0woLJXutDrQTOUUotmzhwc0OsCFpbFNptA=;
        b=lm/siBxi1LOAW3w/wRtm9mb+/2mcBF9Ju00o5tvVwt60SDYs6G9eGXQzasQV1sz/hS
         0bsNoQ9KkVB3fhqklYFHquqbksgNf2adh230VbA5JGvLLVvvwTlqF7CBBj/IGkxBIkpc
         yZwasTIRB1/tZwu1qzQ+3MSiJiqxCHZAi/hHnAQCvibQEzk1KgCqwBss/xiaQI98HIyv
         Bf57gN8U4vHfMQMfcHm+jcoBg9HpxOUkeQTwgNt7DCXEF1g66MuYY8/5vnRejdYw2JnK
         rFNZZvQTpJkSW27vmEZaVbBwF8W1L0E8sZYniTCK0RzZ/qUWisKrDdxP8d7GqKc5DFqp
         dX0Q==
X-Gm-Message-State: AGi0PuaVh7l3PBj+5t0RxEOkDHz+m/qOAJsSRV0r/EN5o8l1KmA9YjQ/
        z3dL9jhIVLEqyXVDaP6Oju4=
X-Google-Smtp-Source: APiQypJuLi6FpbQOASVt3bnvLG7scASlrJ5x7KwCWifh3zbzoiuzuJkj8eG+Sx+zIbBUBby62zO42g==
X-Received: by 2002:a17:902:8a8f:: with SMTP id p15mr12549686plo.45.1586682808174;
        Sun, 12 Apr 2020 02:13:28 -0700 (PDT)
Received: from open-light-1.localdomain ([66.98.113.28])
        by smtp.gmail.com with ESMTPSA id p12sm6057594pfq.153.2020.04.12.02.13.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 02:13:27 -0700 (PDT)
From:   liliangleo <liliang.opensource@gmail.com>
X-Google-Original-From: liliangleo <liliangleo@didiglobal.com>
Date:   Sun, 12 Apr 2020 05:08:00 -0400
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [RFC PATCH 1/4] mm: reduce the impaction of page reporing worker
Message-ID: <20200412090756.GA19574@open-light-1.localdomain>
Mail-Followup-To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When scaning the free list, 'page_reporting_cycle' may hold the
zone->lock for a long time when there are no reported page in the
free list. Setting PAGE_REPORTING_MIN_ORDER to a lower oder will
make this issue worse.

Two ways were used to reduce the impact:
   1. Release zone lock periodicly
   2. Yield cpu voluntarily if needed.

Signed-off-by: liliangleo <liliangleo@didiglobal.com>
---
 mm/page_reporting.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 3bbd471cfc81..3a7084e508e1 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -6,11 +6,14 @@
 #include <linux/export.h>
 #include <linux/delay.h>
 #include <linux/scatterlist.h>
+#include <linux/sched.h>
 
 #include "page_reporting.h"
 #include "internal.h"
 
 #define PAGE_REPORTING_DELAY	(2 * HZ)
+#define MAX_SCAN_NUM 1024
+
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
 
 enum {
@@ -115,7 +118,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	unsigned int page_len = PAGE_SIZE << order;
 	struct page *page, *next;
 	long budget;
-	int err = 0;
+	int err = 0, scan_cnt = 0;
 
 	/*
 	 * Perform early check, if free area is empty there is
@@ -145,8 +148,14 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	/* loop through free list adding unreported pages to sg list */
 	list_for_each_entry_safe(page, next, list, lru) {
 		/* We are going to skip over the reported pages. */
-		if (PageReported(page))
+		if (PageReported(page)) {
+			if (++scan_cnt >= MAX_SCAN_NUM) {
+				err = scan_cnt;
+				break;
+			}
 			continue;
+		}
+
 
 		/*
 		 * If we fully consumed our budget then update our
@@ -219,6 +228,26 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	return err;
 }
 
+static int
+reporting_order_type(struct page_reporting_dev_info *prdev, struct zone *zone,
+		     unsigned int order, unsigned int mt,
+		     struct scatterlist *sgl, unsigned int *offset)
+{
+	int ret = 0;
+	unsigned long total = 0;
+
+	might_sleep();
+	do {
+		cond_resched();
+		ret = page_reporting_cycle(prdev, zone, order, mt,
+					   sgl, offset);
+		if (ret > 0)
+			total += ret;
+	} while (ret > 0 && total < zone->free_area[order].nr_free);
+
+	return ret;
+}
+
 static int
 page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 			    struct scatterlist *sgl, struct zone *zone)
@@ -245,7 +274,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 			if (is_migrate_isolate(mt))
 				continue;
 
-			err = page_reporting_cycle(prdev, zone, order, mt,
+			err = reporting_order_type(prdev, zone, order, mt,
 						   sgl, &offset);
 			if (err)
 				return err;
-- 
2.14.1

