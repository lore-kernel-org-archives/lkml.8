Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13FBC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 08:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80AC920739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 08:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgGEIBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 04:01:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51816 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725967AbgGEIBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 04:01:48 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8258FC793171E05A2FD4;
        Sun,  5 Jul 2020 16:01:42 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sun, 5 Jul 2020 16:01:31 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mm/mmap: optimize a branch judgment in ksys_mmap_pgoff()
Date:   Sun, 5 Jul 2020 16:01:12 +0800
Message-ID: <20200705080112.1405-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Look at the pseudo code below. It's very clear that, the judgement
"!is_file_hugepages(file)" at 3) is duplicated to the one at 1), we can
use "else if" to avoid it. And the assignment "retval = -EINVAL" at 2)
is only needed by the branch 3), because "retval" will be overwritten
at 4).

No functional change, but it can reduce the code size. Maybe more clearer?
Before:
text    data     bss     dec     hex filename
28733    1590       1   30324    7674 mm/mmap.o

After:
text    data     bss     dec     hex filename
28701    1590       1   30292    7654 mm/mmap.o

====pseudo code====:
	if (!(flags & MAP_ANONYMOUS)) {
		...
1)		if (is_file_hugepages(file))
			len = ALIGN(len, huge_page_size(hstate_file(file)));
2)		retval = -EINVAL;
3)		if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(file)))
			goto out_fput;
	} else if (flags & MAP_HUGETLB) {
		...
	}
	...

4)	retval = vm_mmap_pgoff(file, addr, len, prot, flags, pgoff);
out_fput:
	...
	return retval;

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/mmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 59a4682ebf3faed..a7bb2039738528f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1562,11 +1562,12 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 		file = fget(fd);
 		if (!file)
 			return -EBADF;
-		if (is_file_hugepages(file))
+		if (is_file_hugepages(file)) {
 			len = ALIGN(len, huge_page_size(hstate_file(file)));
-		retval = -EINVAL;
-		if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(file)))
+		} else if (unlikely(flags & MAP_HUGETLB)) {
+			retval = -EINVAL;
 			goto out_fput;
+		}
 	} else if (flags & MAP_HUGETLB) {
 		struct user_struct *user = NULL;
 		struct hstate *hs;
-- 
1.8.3


