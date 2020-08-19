Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A5EC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B187320658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OABquVbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgHSSA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:00:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60772 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726723AbgHSSAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597860010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CPg1htOBvj1u11Dr/5h+trV9SHXCNEw1kXJM9Y8zX7w=;
        b=OABquVbPQOlTDXQmaj7AFpQuPu02NS34PRQob/gpRvNpsFCuLq6KoLj6/ucJlC0BmlPidF
        unwc85X+HNsmcM+cr1arCts5k9pOrQE/JcL13BD+TT3F65pDcMqNuA3rkUP3xM3EuMFZUN
        3ZmLhS3X0a+vphbzN/iEcHAXnzx6jUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-_y44hPQYOL-tuOoC86aJzw-1; Wed, 19 Aug 2020 14:00:08 -0400
X-MC-Unique: _y44hPQYOL-tuOoC86aJzw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A5C2D1C44;
        Wed, 19 Aug 2020 18:00:06 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-11.ams2.redhat.com [10.36.114.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACBBA100239A;
        Wed, 19 Aug 2020 18:00:04 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 01/10] mm/memory_hotplug: inline __offline_pages() into offline_pages()
Date:   Wed, 19 Aug 2020 19:59:48 +0200
Message-Id: <20200819175957.28465-2-david@redhat.com>
In-Reply-To: <20200819175957.28465-1-david@redhat.com>
References: <20200819175957.28465-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only a single user, offline_pages(). Let's inline, to make
it look more similar to online_pages().

Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7f62d69660e06..c781d386d87f9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1473,11 +1473,10 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 	return 0;
 }
 
-static int __ref __offline_pages(unsigned long start_pfn,
-		  unsigned long end_pfn)
+int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 {
-	unsigned long pfn, nr_pages = 0;
-	unsigned long offlined_pages = 0;
+	const unsigned long end_pfn = start_pfn + nr_pages;
+	unsigned long pfn, system_ram_pages = 0, offlined_pages = 0;
 	int ret, node, nr_isolate_pageblock;
 	unsigned long flags;
 	struct zone *zone;
@@ -1494,9 +1493,9 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	 * memory holes PG_reserved, don't need pfn_valid() checks, and can
 	 * avoid using walk_system_ram_range() later.
 	 */
-	walk_system_ram_range(start_pfn, end_pfn - start_pfn, &nr_pages,
+	walk_system_ram_range(start_pfn, nr_pages, &system_ram_pages,
 			      count_system_ram_pages_cb);
-	if (nr_pages != end_pfn - start_pfn) {
+	if (system_ram_pages != nr_pages) {
 		ret = -EINVAL;
 		reason = "memory holes";
 		goto failed_removal;
@@ -1631,11 +1630,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	return ret;
 }
 
-int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
-{
-	return __offline_pages(start_pfn, start_pfn + nr_pages);
-}
-
 static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
 {
 	int ret = !is_memblock_offlined(mem);
-- 
2.26.2

