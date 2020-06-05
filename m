Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18765C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3D3207DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Lf5zWp9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgFEJ0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:26:06 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:6601 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgFEJ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591349164; x=1622885164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2WYBB4tJ65ci6WfpvKb1NLkX6q8yNQyc7qNwaxapXxQ=;
  b=Lf5zWp9bkIfUII2ojfNzumAXHv30UviKuCVaitTz0k8gsy5vimJRV9Jb
   zA+fEVRqeyQSM0/UzVF8x+sthR4G0iwJNLwvv9LH0+IDCbMeyNY5OuKmI
   a8bCPb7h/pepSmPQAw6hq7iPb1XIcRz4MLNjIHJNjPqriOJYhkul+y73i
   s=;
IronPort-SDR: sLgFbT17zN8xu0PccVFOh0/XP8F5DkdxKEahcNZsXW/JB8HaQfG0DM3P7xaj6T2aEDjzAHO6DN
 VwnBtOhiEpzw==
X-IronPort-AV: E=Sophos;i="5.73,475,1583193600"; 
   d="scan'208";a="34633948"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 05 Jun 2020 09:26:03 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id C503EA1F10;
        Fri,  5 Jun 2020 09:26:01 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 5 Jun 2020 09:25:45 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.200) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 5 Jun 2020 09:25:38 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 1/2] mm/page_idle.c: Skip offline pages
Date:   Fri, 5 Jun 2020 11:25:01 +0200
Message-ID: <20200605092502.18018-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605092502.18018-1-sjpark@amazon.com>
References: <20200605092502.18018-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.200]
X-ClientProxiedBy: EX13D32UWB003.ant.amazon.com (10.43.161.220) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

'Idle page tracking' users can pass random pfn that might be mapped to
an offline page.  To avoid accessing such pages, this commit modifies
the 'page_idle_get_page()' to use 'pfn_to_online_page()' instead of
'pfn_valid()' and 'pfn_to_page()' combination, so that the pfn mapped to
an offline page can be skipped.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reported-by: David Hildenbrand <david@redhat.com>
---
 mm/page_idle.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 295512465065..057c61df12db 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -4,6 +4,7 @@
 #include <linux/fs.h>
 #include <linux/sysfs.h>
 #include <linux/kobject.h>
+#include <linux/memory_hotplug.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/pagemap.h>
@@ -30,13 +31,9 @@
  */
 static struct page *page_idle_get_page(unsigned long pfn)
 {
-	struct page *page;
+	struct page *page = pfn_to_online_page(pfn);
 	pg_data_t *pgdat;
 
-	if (!pfn_valid(pfn))
-		return NULL;
-
-	page = pfn_to_page(pfn);
 	if (!page || !PageLRU(page) ||
 	    !get_page_unless_zero(page))
 		return NULL;
-- 
2.17.1

