Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF09C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7E624677
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgCJHvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:51:03 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:14071 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgCJHvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:51:03 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Mar 2020 03:51:01 EDT
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 909DA260F0C;
        Tue, 10 Mar 2020 15:41:05 +0800 (CST)
From:   WANG Wenhu <wenhu.wang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     wenhu.pku@gmail.com, WANG Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH] mm: clarify a confusing comment of remap_pfn_range
Date:   Tue, 10 Mar 2020 00:39:54 -0700
Message-Id: <20200310073955.43415-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VCQ0lCQkJDS0pNSE5MT1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pio6Pjo6Szg4PDwCNU9RGisK
        NCwKFD5VSlVKTkNIQ0lNS01MQkhIVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUpNT0o3Bg++
X-HM-Tid: 0a70c363d9669375kuws909da260f0c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It really made me scratching my head. Replace the comment
with an accurate and consistent description.

The parameter pfn actually referes to the page frame number
which is right-shifted by PAGE_SHIFT from the physical address.

Signed-off-by: WANG Wenhu <wenhu.wang@vivo.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index e8bfdf0d9d1d..583f84519870 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1939,7 +1939,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
  * remap_pfn_range - remap kernel memory to userspace
  * @vma: user vma to map to
  * @addr: target user address to start at
- * @pfn: physical address of kernel memory
+ * @pfn: page frame number of kernel physical memory address
  * @size: size of map area
  * @prot: page protection flags for this mapping
  *
-- 
2.17.1

