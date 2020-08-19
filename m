Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8215C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E6F20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDPEWl6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgHSSBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:01:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726786AbgHSSAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597860018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZKGgLwnrdaAkJVW/KINBUaSS2x46Iq1d00/GYBaqU0=;
        b=LDPEWl6ajtFolB+h4xUos9vogSaNiF8XIAQq5tPLUs0IH8lt05adq9GmWPdvy6E/7EHC2A
        zRvfjJREbdLQQMkyhOcB9qlXB+KLAjNbCFLSy8/ZgkCIYIPmb+gmkU9aVocIVVtiQB8iAk
        uvtk4QxAAFE/3zWHd5lyR4rCxo9bTPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-9gNmvcgoNUu979CaBVgtQQ-1; Wed, 19 Aug 2020 14:00:16 -0400
X-MC-Unique: 9gNmvcgoNUu979CaBVgtQQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 332528030AB;
        Wed, 19 Aug 2020 18:00:15 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-11.ams2.redhat.com [10.36.114.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C79B100238E;
        Wed, 19 Aug 2020 18:00:13 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 05/10] mm/memory_hotplug: drop nr_isolate_pageblock in offline_pages()
Date:   Wed, 19 Aug 2020 19:59:52 +0200
Message-Id: <20200819175957.28465-6-david@redhat.com>
In-Reply-To: <20200819175957.28465-1-david@redhat.com>
References: <20200819175957.28465-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We make sure that we cannot have any memory holes right at the beginning
of offline_pages() and we only support to online/offline full sections.
Both, sections and pageblocks are a power of two in size, and sections
always span full pageblocks.

We can directly calculate the number of isolated pageblocks from nr_pages.

Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 50aa5df696e9d..098361fcb4504 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1460,10 +1460,10 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
 	unsigned long pfn, system_ram_pages = 0;
-	int ret, node, nr_isolate_pageblock;
 	unsigned long flags;
 	struct zone *zone;
 	struct memory_notify arg;
+	int ret, node;
 	char *reason;
 
 	/* We can only offline full sections (e.g., SECTION_IS_ONLINE) */
@@ -1507,7 +1507,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 		reason = "failure to isolate range";
 		goto failed_removal;
 	}
-	nr_isolate_pageblock = ret;
 
 	arg.start_pfn = start_pfn;
 	arg.nr_pages = nr_pages;
@@ -1569,7 +1568,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	 * pageblocks zone counter here.
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
-	zone->nr_isolate_pageblock -= nr_isolate_pageblock;
+	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	/* removal success */
-- 
2.26.2

