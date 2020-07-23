Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B67CC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663D520771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXsmYVna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbgGWDXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:23:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40193 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728902AbgGWDXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595474586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Ts3Ck5YAmU7JalAJmJ/D595ycdEdSJmjE5GqTZJjOAQ=;
        b=HXsmYVna0B8Y4s3INsQTncmAJ1aAabgL+CCsbxWucRNH90s3vu/QM8LwvX8HvuRy10+KM1
        j9cbLt8Vyn7HpumGOBSBSA241N2KpB8BphhV47bxalhsvD2KVm9BUmIdtH04F10vptIfTS
        9bKoyHVO0ZLc2MkL96WSXYHmHqLTCuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-_jNFcJilPsGYdDK8wZDmug-1; Wed, 22 Jul 2020 23:23:02 -0400
X-MC-Unique: _jNFcJilPsGYdDK8wZDmug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99F85106B243;
        Thu, 23 Jul 2020 03:23:01 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-53.pek2.redhat.com [10.72.13.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 696F65C1BD;
        Thu, 23 Jul 2020 03:22:59 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, bhe@redhat.com
Subject: [PATCH v2 2/4] mm/hugetlb.c: Remove the unnecessary non_swap_entry()
Date:   Thu, 23 Jul 2020 11:22:46 +0800
Message-Id: <20200723032248.24772-3-bhe@redhat.com>
In-Reply-To: <20200723032248.24772-1-bhe@redhat.com>
References: <20200723032248.24772-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3569e731e66b..c14837854392 100644
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

