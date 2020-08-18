Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61540C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40611206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgHRHa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:30:28 -0400
Received: from mail5.windriver.com ([192.103.53.11]:49398 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgHRHa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:30:28 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 07I7TSEd017283
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 18 Aug 2020 00:29:38 -0700
Received: from pek-lpggp1.wrs.com (128.224.153.74) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 00:29:12 -0700
From:   <yanfei.xu@windriver.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH] mm/memory.c: Correct the function name in comment
Date:   Tue, 18 Aug 2020 15:29:10 +0800
Message-ID: <20200818072910.27068-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

Correct the function name which is "pte_alloc_pne" to "pte_alloc_one"

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index c3a83f4ca851..9cc3d0dc816c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3446,7 +3446,7 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	 *				unlock_page(A)
 	 * lock_page(B)
 	 *				lock_page(B)
-	 * pte_alloc_pne
+	 * pte_alloc_one
 	 *   shrink_page_list
 	 *     wait_on_page_writeback(A)
 	 *				SetPageWriteback(B)
-- 
2.18.2

