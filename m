Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88415C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E7D20737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBirwTud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgGWKqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:46:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34168 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725911AbgGWKqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595501205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OIGRu3pWmIoZ+Nju0ceqixWGAqRIjOJir+KRyyVKDd0=;
        b=jBirwTuddkudXbutQgB0h9rQnKeEzeioMYAtYrXC2l2WWImWpZP4Acu0ns0TJf1+2apKCJ
        atZFaZCsEiOW9tf78u+TbR6Y+Cbla3k3M0Jt0Y59frGdV2f1axWzleSpOie2TACM/ymT7S
        n5gqNgOCnCyGGsk1JN45RI/tMb4AGyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-cAo-hXbjN5qL7KcBsCJy_A-1; Thu, 23 Jul 2020 06:46:43 -0400
X-MC-Unique: cAo-hXbjN5qL7KcBsCJy_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88703189CEF3;
        Thu, 23 Jul 2020 10:46:42 +0000 (UTC)
Received: from localhost (ovpn-13-53.pek2.redhat.com [10.72.13.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32FBC1A8F7;
        Thu, 23 Jul 2020 10:46:38 +0000 (UTC)
Date:   Thu, 23 Jul 2020 18:46:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, david@redhat.com,
        anshuman.khandual@arm.com, akpm@linux-foundation.org
Subject: [PATCH v3 2/4] mm/hugetlb.c: Remove the unnecessary non_swap_entry()
Message-ID: <20200723104636.GS32539@MiWiFi-R3L-srv>
References: <20200723032248.24772-1-bhe@redhat.com>
 <20200723032248.24772-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723032248.24772-3-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a swap entry tests positive for either is_[migration|hwpoison]_entry(),
then its swap_type() is among SWP_MIGRATION_READ, SWP_MIGRATION_WRITE and
SWP_HWPOISON. All these types >= MAX_SWAPFILES, exactly what is asserted
with non_swap_entry().

So the checking non_swap_entry() in is_hugetlb_entry_migration() and
is_hugetlb_entry_hwpoisoned() is redundant.

Let's remove it to optimize code.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
v2->v3:
  Updated patch log according to Anshuman's comment.

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

