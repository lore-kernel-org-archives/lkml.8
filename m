Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C054C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3DB2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845264;
	bh=uUmpij+9W1OTILI+xOFyBliAfKE59rmj0bsOZV9Bvy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZuO7VDF160SCNdl4Q96uDSAsVcaVFss9RluU+JnOBT/1x5bNk3V/nPlpQJa/m1djx
	 8k+o6kWHfJ1+pCYVX+1HHTV90tinQVxu6jwVmvPOLpgoGNHCR1bLzypJ01kt7Qkop6
	 +9Yp4IdgY3HS96d5KWVMV3wNw+oGxpYdiT4O5yWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbgCJNBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbgCJNA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:00:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2D3024694;
        Tue, 10 Mar 2020 13:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845257;
        bh=uUmpij+9W1OTILI+xOFyBliAfKE59rmj0bsOZV9Bvy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhWpApp9s/TjdmaZwTHBwjTqpGBXDcHzUFwmVGUy0a2S65HJmeO2zvwXIKE+0WQSp
         EIo3GHnB6yNxHiVOw00U1srMYIc/Q3FX+Kh724IYtDgLEcG9Zutyej9znWnx9534pw
         Xm7/r9/AbU90nlBuYjL0y0UXwLRgWFQzVZ9CZzdk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.5 080/189] mm: fix possible PMD dirty bit lost in set_pmd_migration_entry()
Date:   Tue, 10 Mar 2020 13:38:37 +0100
Message-Id: <20200310123647.724793912@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

commit 8a8683ad9ba48b4b52a57f013513d1635c1ca5c4 upstream.

In set_pmd_migration_entry(), pmdp_invalidate() is used to change PMD
atomically.  But the PMD is read before that with an ordinary memory
reading.  If the THP (transparent huge page) is written between the PMD
reading and pmdp_invalidate(), the PMD dirty bit may be lost, and cause
data corruption.  The race window is quite small, but still possible in
theory, so need to be fixed.

The race is fixed via using the return value of pmdp_invalidate() to get
the original content of PMD, which is a read/modify/write atomic
operation.  So no THP writing can occur in between.

The race has been introduced when the THP migration support is added in
the commit 616b8371539a ("mm: thp: enable thp migration in generic path").
But this fix depends on the commit d52605d7cb30 ("mm: do not lose dirty
and accessed bits in pmdp_invalidate()").  So it's easy to be backported
after v4.16.  But the race window is really small, so it may be fine not
to backport the fix at all.

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: <stable@vger.kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Link: http://lkml.kernel.org/r/20200220075220.2327056-1-ying.huang@intel.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/huge_memory.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3032,8 +3032,7 @@ void set_pmd_migration_entry(struct page
 		return;
 
 	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
-	pmdval = *pvmw->pmd;
-	pmdp_invalidate(vma, address, pvmw->pmd);
+	pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
 	if (pmd_dirty(pmdval))
 		set_page_dirty(page);
 	entry = make_migration_entry(page, pmd_write(pmdval));


