Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124EBC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB23E20771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7pm2mTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbgGWDXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:23:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52809 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728902AbgGWDXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595474582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=BTooNJ31kedJqWj3+6eiTB1g4irFJns6s4pfKDa5+oE=;
        b=U7pm2mTO23T6HlRyluaaV7O+42ChAvsq3vLt8EaDu8kROiEi/HJYLJUmZC0BQ3NMTwJw8z
        yDcRGdXkilaXUoqdkKX0utUUKxrf03lyI9DSgs9svbW4JTBg2sXHG+i16drb2Z4Wki8Gby
        5mx1D6oJ8PgdGROI+SaTm5Zaiwux3/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-73hxUGVFM926SAg8fmk1KQ-1; Wed, 22 Jul 2020 23:22:59 -0400
X-MC-Unique: 73hxUGVFM926SAg8fmk1KQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3E578017FB;
        Thu, 23 Jul 2020 03:22:58 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-53.pek2.redhat.com [10.72.13.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8087E69316;
        Thu, 23 Jul 2020 03:22:56 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, bhe@redhat.com
Subject: [PATCH v2 1/4] mm/hugetlb.c: make is_hugetlb_entry_hwpoisoned return bool
Date:   Thu, 23 Jul 2020 11:22:45 +0800
Message-Id: <20200723032248.24772-2-bhe@redhat.com>
In-Reply-To: <20200723032248.24772-1-bhe@redhat.com>
References: <20200723032248.24772-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like its neighbour is_hugetlb_entry_migration() has done.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f24acb3af741..3569e731e66b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3754,17 +3754,17 @@ bool is_hugetlb_entry_migration(pte_t pte)
 		return false;
 }
 
-static int is_hugetlb_entry_hwpoisoned(pte_t pte)
+static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 {
 	swp_entry_t swp;
 
 	if (huge_pte_none(pte) || pte_present(pte))
-		return 0;
+		return false;
 	swp = pte_to_swp_entry(pte);
 	if (non_swap_entry(swp) && is_hwpoison_entry(swp))
-		return 1;
+		return true;
 	else
-		return 0;
+		return false;
 }
 
 int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
-- 
2.17.2

