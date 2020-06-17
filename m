Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615AEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A1F21532
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgFQUPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:15:07 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:57492 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbgFQUPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:15:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U.uEVD-_1592424896;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0U.uEVD-_1592424896)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Jun 2020 04:15:03 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: THP CoW fault no longer allocate THP
Date:   Thu, 18 Jun 2020 04:14:55 +0800
Message-Id: <1592424895-5421-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 3917c80280c93a7123f ("thp: change CoW semantics for
anon-THP"), THP CoW page fault is rewritten. Now it just splits pmd then
fallback to base page fault, it doesn't try to allocate THP anymore.  So
it is no longer counted in THP_FAULT_ALLOC.

Remove the obsolete statement in documentation about THP CoW allocation to
avoid confusion.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 Documentation/admin-guide/cgroup-v2.rst    | 4 ++--
 Documentation/admin-guide/mm/transhuge.rst | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index ce3e05e..d09471a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1356,8 +1356,8 @@ PAGE_SIZE multiple when read back.
 
 	  thp_fault_alloc
 		Number of transparent hugepages which were allocated to satisfy
-		a page fault, including COW faults. This counter is not present
-		when CONFIG_TRANSPARENT_HUGEPAGE is not set.
+		a page fault. This counter is not present when CONFIG_TRANSPARENT_HUGEPAGE
+                is not set.
 
 	  thp_collapse_alloc
 		Number of transparent hugepages which were allocated to allow
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 6a233e4..b2acd0d 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -305,8 +305,7 @@ monitor how successfully the system is providing huge pages for use.
 
 thp_fault_alloc
 	is incremented every time a huge page is successfully
-	allocated to handle a page fault. This applies to both the
-	first time a page is faulted and for COW faults.
+	allocated to handle a page fault.
 
 thp_collapse_alloc
 	is incremented by khugepaged when it has found
-- 
1.8.3.1

