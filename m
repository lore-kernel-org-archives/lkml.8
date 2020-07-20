Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2864BC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB53022CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gK6pkZdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGTG0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:26:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24817 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725805AbgGTG0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595226397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=PvPXzl5kZc3bZ9UIjpkbA+aZfXqt5toWfAuiLtxvI/Y=;
        b=gK6pkZdqskB4Y7Qf53ooTR2NdJItpTJFhp5t8qum1StumiFEgHQ0qX1l2AGr/j6v45ngcv
        Iyj26rCU24bctlhiPm86mWwOPT4yAMURsL0MuHtxMJk13JAXSASzcEM3ehtWkbXkDQWiRd
        OPQxdnqfQMHHIqnbIU7FjBm6PY1PaYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-ImXG8Ua-Od2kA99iD7syFg-1; Mon, 20 Jul 2020 02:26:35 -0400
X-MC-Unique: ImXG8Ua-Od2kA99iD7syFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CA9C80183C;
        Mon, 20 Jul 2020 06:26:34 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-150.pek2.redhat.com [10.72.12.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8911B7852D;
        Mon, 20 Jul 2020 06:26:32 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, bhe@redhat.com
Subject: [PATCH 3/5] mm/hugetlb.c: Remove the unnecessary non_swap_entry()
Date:   Mon, 20 Jul 2020 14:26:21 +0800
Message-Id: <20200720062623.13135-4-bhe@redhat.com>
In-Reply-To: <20200720062623.13135-1-bhe@redhat.com>
References: <20200720062623.13135-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checking is_migration_entry() and is_hwpoison_entry() are stricter
than non_swap_entry(), means they have covered the conditional check
which non_swap_entry() is doing.

Hence remove the unnecessary non_swap_entry() in is_hugetlb_entry_migration()
and is_hugetlb_entry_hwpoisoned() to simplify code.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a58f976a9dd9..467894d8332a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3748,7 +3748,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
 	if (huge_pte_none(pte) || pte_present(pte))
 		return false;
 	swp = pte_to_swp_entry(pte);
-	if (non_swap_entry(swp) && is_migration_entry(swp))
+	if (is_migration_entry(swp))
 		return true;
 	else
 		return false;
@@ -3761,7 +3761,7 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 	if (huge_pte_none(pte) || pte_present(pte))
 		return false;
 	swp = pte_to_swp_entry(pte);
-	if (non_swap_entry(swp) && is_hwpoison_entry(swp))
+	if (is_hwpoison_entry(swp))
 		return true;
 	else
 		return false;
-- 
2.17.2

