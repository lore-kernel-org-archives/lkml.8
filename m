Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5696C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9570221775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlUvEiOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGTG0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:26:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31673 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727049AbgGTG0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595226402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ErQnGDyC+brwu9pgt6aMqEG7pR0PIXFNaAVP0pSF45w=;
        b=QlUvEiOnsGmyUzp4Q08QEgVig8o+sTjCOpFaA7hhU2Iy9pGO3pKB74/W2gr2cfWqyrgGQh
        4/8P4KPuPDMPUhW8X1yaVb4J/fi7qO5CZDM27z3lIl6OsN0l/xqbiSUa7imxvs+guTxCLi
        c5RYvqo8kunSzMznnZ50rqBr/Oza6yU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-XuO9sbkuOwKkbXDBpXW7-Q-1; Mon, 20 Jul 2020 02:26:40 -0400
X-MC-Unique: XuO9sbkuOwKkbXDBpXW7-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 407BD800469;
        Mon, 20 Jul 2020 06:26:39 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-150.pek2.redhat.com [10.72.12.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58D877852B;
        Mon, 20 Jul 2020 06:26:37 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, bhe@redhat.com
Subject: [PATCH 5/5] mm/hugetl.c: warn out if expected count of huge pages adjustment is not achieved
Date:   Mon, 20 Jul 2020 14:26:23 +0800
Message-Id: <20200720062623.13135-6-bhe@redhat.com>
In-Reply-To: <20200720062623.13135-1-bhe@redhat.com>
References: <20200720062623.13135-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A customer complained that no any message is printed out when failed to
allocate explicitly specified number of persistent huge pages. That
specifying can be done by writing into /proc/sys/vm/nr_hugepages to
increase the persisten huge pages.

In the current code, it takes the best effort way to allocate the expected
number of huge pages. If only succeeding to get part of them, no any
information is printed out.

Here try to send out warning message if the expected number of huge pages
adjustment is not achieved, including increasing and decreasing the count
of persistent huge pages.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/hugetlb.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 467894d8332a..1dfb5d9e4e06 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2661,7 +2661,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
-	unsigned long min_count, ret;
+	unsigned long min_count, ret, old_max;
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
@@ -2779,6 +2780,16 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	}
 out:
 	h->max_huge_pages = persistent_huge_pages(h);
+	if (count != h->max_huge_pages) {
+		char buf[32];
+
+		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
+		pr_warn("HugeTLB: %s %lu of page size %s failed. Only %s %lu hugepages.\n",
+			count > old_max ? "increasing" : "decreasing",
+			abs(count - old_max), buf,
+			count > old_max ? "increased" : "decreased",
+			abs(old_max - h->max_huge_pages));
+	}
 	spin_unlock(&hugetlb_lock);
 
 	NODEMASK_FREE(node_alloc_noretry);
-- 
2.17.2

