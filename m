Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21033C433EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC83207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpMrZEix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbgGWDXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:23:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37184 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728902AbgGWDXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595474593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=vZfw7dyC3KMlWpgvlscO0Ovg3J13CbQcaPM0NJVPAbM=;
        b=YpMrZEixgJJzdUl2jnEW7duNn+UX2wFimqwAOM7miWNYTjFBvWWyYIxtdamVfGIsoONajl
        Er2d6GMr0FdDtkIqwQ3NAv2w6AatBb7ZOrh9afS4JnZ0rxfrBEiYYgAFYC5lWHvzUN0xBq
        Q+GbYp+tqco2BMyGB+0g9J8My6O3ICI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-5xsT3EbkOIGbJy9TKANloQ-1; Wed, 22 Jul 2020 23:23:09 -0400
X-MC-Unique: 5xsT3EbkOIGbJy9TKANloQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F6E518A1DED;
        Thu, 23 Jul 2020 03:23:08 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-53.pek2.redhat.com [10.72.13.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D51825C1BD;
        Thu, 23 Jul 2020 03:23:04 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, bhe@redhat.com
Subject: [PATCH v2 4/4] mm/hugetl.c: warn out if expected count of huge pages adjustment is not achieved
Date:   Thu, 23 Jul 2020 11:22:48 +0800
Message-Id: <20200723032248.24772-5-bhe@redhat.com>
In-Reply-To: <20200723032248.24772-1-bhe@redhat.com>
References: <20200723032248.24772-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A customer complained that no message is logged when the number of
persistent huge pages is not changed to the exact value written to
the sysfs or proc nr_hugepages file.

In the current code, a best effort is made to satisfy requests made
via the nr_hugepages file.  However, requests may be only partially
satisfied.

Log a message if the code was unsuccessful in fully satisfying a
request. This includes both increasing and decreasing the number
of persistent huge pages.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/hugetlb.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c14837854392..b5aa32a13569 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2661,7 +2661,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
-	unsigned long min_count, ret;
+	unsigned long min_count, ret, old_max, new_max;
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
 	/*
@@ -2723,6 +2723,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * pool might be one hugepage larger than it needs to be, but
 	 * within all the constraints specified by the sysctls.
 	 */
+	old_max = persistent_huge_pages(h);
 	while (h->surplus_huge_pages && count > persistent_huge_pages(h)) {
 		if (!adjust_pool_surplus(h, nodes_allowed, -1))
 			break;
@@ -2779,8 +2780,20 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	}
 out:
 	h->max_huge_pages = persistent_huge_pages(h);
+	new_max = h->max_huge_pages;
 	spin_unlock(&hugetlb_lock);
 
+	if (count != new_max) {
+		char buf[32];
+
+		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
+		pr_warn("HugeTLB: %s %lu of page size %s failed. Only %s %lu hugepages.\n",
+			count > old_max ? "increasing" : "decreasing",
+			abs(count - old_max), buf,
+			count > old_max ? "increased" : "decreased",
+			abs(old_max - new_max));
+	}
+
 	NODEMASK_FREE(node_alloc_noretry);
 
 	return 0;
-- 
2.17.2

