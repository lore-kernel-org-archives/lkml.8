Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48557C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246F920708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594139555;
	bh=BUB86f4VqcYA1jo30T5wmdSlQD5O7Xdjk8OuWnZl/hk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bRobWZAiAH8WxncYoUZbamKAvgqhMWd83Hb7Tb9a/3AM7jWuh9/YxufNgWNHIKk0Y
	 0O/ly4UCNw4wFtrstbdFb3GJlzEV6m3LV0M27gYRf7ztcEmJir2Xd3IHbOBEU4Oqit
	 CeBtww/b8c2RG2v236062sI7uoAyjEVnB7idnsTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgGGQcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:32:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgGGQcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:32:33 -0400
Received: from hump.s81c.com (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E87206CD;
        Tue,  7 Jul 2020 16:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594139553;
        bh=BUB86f4VqcYA1jo30T5wmdSlQD5O7Xdjk8OuWnZl/hk=;
        h=From:To:Cc:Subject:Date:From;
        b=bZkSnZ9T/rqTTcyzWkf7bbHO/JevdiSmUWdBhlfhKJvWezsiJLUk3dq9WlkHyHHzv
         +jF8YRhgiACk9qyhDkJMOBOE9PSkQmgUuMvJeYg7BzbiKU0TRHJGM3E2kaQVoY/Nzj
         kOYaXJgZInJtNugDVLEv+A46S+bCx2zSIYpE6rjk=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joerg Roedel <jroedel@suse.de>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] mm: vmalloc: remove redundant asignmnet in unmap_kernel_range_noflush()
Date:   Tue,  7 Jul 2020 19:32:26 +0300
Message-Id: <20200707163226.374685-1-rppt@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

'addr' is set to 'start' and then a few lines afterwards 'start' is
set to 'addr'.
Remove the second asignment.

Fixes: 2ba3e6947aed ("mm/vmalloc: track which page-table levels were modified")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/vmalloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5a2b55c8dd9a..68ebbafc9c9b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -171,11 +171,10 @@ void unmap_kernel_range_noflush(unsigned long start, unsigned long size)
 	pgd_t *pgd;
 	unsigned long addr = start;
 	pgtbl_mod_mask mask = 0;
 
 	BUG_ON(addr >= end);
-	start = addr;
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_bad(*pgd))
 			mask |= PGTBL_PGD_MODIFIED;
-- 
2.25.4

