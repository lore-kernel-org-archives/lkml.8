Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A394C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3EDF21775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiaS4jbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGTG0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:26:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54395 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726998AbgGTG0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595226397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=HZVpm4zvUxz3yqhYdW0O0x6jO3M2RU27CaJXZlinWJc=;
        b=IiaS4jbXnw8BVLdmDjz+zLckI+B1we2J5bST7sWmv/Z/eqWMtHcqZEC4gWZEOsRtOAQBni
        P8okm72T7pYctBIczhY8yCUy49M1UBVGT/Ixc9ojXK/i0ZcaP3imy8fjaWcxrd2vumlycG
        PzBASeJyT2f3cSXaOoGEAkt9Fyn3+y4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-pmyWS8elN5qfgagnssZLaA-1; Mon, 20 Jul 2020 02:26:33 -0400
X-MC-Unique: pmyWS8elN5qfgagnssZLaA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A7EE1080;
        Mon, 20 Jul 2020 06:26:32 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-150.pek2.redhat.com [10.72.12.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D46678526;
        Mon, 20 Jul 2020 06:26:29 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, bhe@redhat.com
Subject: [PATCH 2/5] mm/hugetlb.c: make is_hugetlb_entry_hwpoisoned return bool
Date:   Mon, 20 Jul 2020 14:26:20 +0800
Message-Id: <20200720062623.13135-3-bhe@redhat.com>
In-Reply-To: <20200720062623.13135-1-bhe@redhat.com>
References: <20200720062623.13135-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like his neighbour is_hugetlb_entry_migration() has done.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/hugetlb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 191a585bb315..a58f976a9dd9 100644
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

