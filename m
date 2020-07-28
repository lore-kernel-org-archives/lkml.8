Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55784C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A54D20838
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgG1Icc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:32:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:47724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbgG1Icb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:32:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C31BDB1EF;
        Tue, 28 Jul 2020 08:32:40 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH] /proc/PID/smaps: Consistent whitespace output format
Date:   Tue, 28 Jul 2020 10:32:07 +0200
Message-Id: <20200728083207.17531-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The keys in smaps output are padded to fixed width with spaces.
All except for THPeligible that uses tabs (only since
commit c06306696f83 ("mm: thp: fix false negative of shmem vma's THP
eligibility")).
Unify the output formatting to save time debugging some naïve parsers.
(Part of the unification is also aligning FilePmdMapped with others.)

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 fs/proc/task_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index dbda4499a859..5066b0251ed8 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -786,7 +786,7 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
 	SEQ_PUT_DEC(" kB\nLazyFree:       ", mss->lazyfree);
 	SEQ_PUT_DEC(" kB\nAnonHugePages:  ", mss->anonymous_thp);
 	SEQ_PUT_DEC(" kB\nShmemPmdMapped: ", mss->shmem_thp);
-	SEQ_PUT_DEC(" kB\nFilePmdMapped: ", mss->file_thp);
+	SEQ_PUT_DEC(" kB\nFilePmdMapped:  ", mss->file_thp);
 	SEQ_PUT_DEC(" kB\nShared_Hugetlb: ", mss->shared_hugetlb);
 	seq_put_decimal_ull_width(m, " kB\nPrivate_Hugetlb: ",
 				  mss->private_hugetlb >> 10, 7);
@@ -816,7 +816,7 @@ static int show_smap(struct seq_file *m, void *v)
 
 	__show_smap(m, &mss, false);
 
-	seq_printf(m, "THPeligible:		%d\n",
+	seq_printf(m, "THPeligible:    %d\n",
 		   transparent_hugepage_enabled(vma));
 
 	if (arch_pkeys_enabled())
-- 
2.27.0

