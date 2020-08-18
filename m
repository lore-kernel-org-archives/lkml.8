Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2715AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0903A2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgHRIqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:46:40 -0400
Received: from mail.windriver.com ([147.11.1.11]:35639 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRIqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:46:39 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 07I8kSaT020265
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 18 Aug 2020 01:46:28 -0700 (PDT)
Received: from pek-lpggp1.wrs.com (128.224.153.74) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 01:46:09 -0700
From:   <yanfei.xu@windriver.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH] mm/memory.c: Replace vmf->vma with variable vma
Date:   Tue, 18 Aug 2020 16:46:07 +0800
Message-ID: <20200818084607.37616-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

The code has declared a vma_struct named vma which is assigned a
value of vmf->vma. Thus, use variable vma directly here.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 9cc3d0dc816c..88f61b4f9638 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3454,7 +3454,7 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	 *				# flush A, B to clear the writeback
 	 */
 	if (pmd_none(*vmf->pmd) && !vmf->prealloc_pte) {
-		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm);
+		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
 		smp_wmb(); /* See comment in __pte_alloc() */
-- 
2.18.2

