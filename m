Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF116C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 03:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBB8208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 03:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgCEDai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 22:30:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgCEDah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 22:30:37 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 69B3F320F9A24C1D3991;
        Thu,  5 Mar 2020 11:30:36 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.173.228.124) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Mar 2020 11:30:26 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <mike.kravetz@oracle.com>
CC:     <arei.gonglei@huawei.com>, <huangzhichao@huawei.com>,
        Longpeng <longpeng2@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH] mm/hugetlb: avoid weird message in hugetlb_init
Date:   Thu, 5 Mar 2020 11:30:14 +0800
Message-ID: <20200305033014.1152-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.228.124]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longpeng <longpeng2@huawei.com>

Some architectures(e.g. x86,risv) doesn't add 2M-hstate by default,
so if we add 'default_hugepagesz=2M' but without 'hugepagesz=2M' in
cmdline, we'll get a message as follow:
"HugeTLB: unsupported default_hugepagesz 2097152. Reverting to 2097152"

As architecture-specific HPAGE_SIZE hstate should be supported by
default, we can avoid this weird message by add it if we hadn't yet.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Qian Cai <cai@lca.pw>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Longpeng <longpeng2@huawei.com>
---
 mm/hugetlb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dd8737a..21f623b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2829,6 +2829,9 @@ static int __init hugetlb_init(void)
 	if (!hugepages_supported())
 		return 0;
 
+	if (!size_to_hstate(HPAGE_SIZE))
+		hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
+
 	if (!size_to_hstate(default_hstate_size)) {
 		if (default_hstate_size != 0) {
 			pr_err("HugeTLB: unsupported default_hugepagesz %lu. Reverting to %lu\n",
@@ -2836,8 +2839,6 @@ static int __init hugetlb_init(void)
 		}
 
 		default_hstate_size = HPAGE_SIZE;
-		if (!size_to_hstate(default_hstate_size))
-			hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
 	}
 	default_hstate_idx = hstate_index(size_to_hstate(default_hstate_size));
 	if (default_hstate_max_huge_pages) {
-- 
1.8.3.1

