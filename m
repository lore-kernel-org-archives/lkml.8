Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7197C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AD92086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bNkzHJqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbgBKTyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:54:44 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42400 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgBKTyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:54:44 -0500
Received: by mail-qv1-f67.google.com with SMTP id dc14so5593462qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 11:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YBwt2MVU6nNAOe4QsbbS2Wq8hC+X3+hnvO1hd669kyE=;
        b=bNkzHJqcIbI9AGRseJS/hpar5VZUMk3hF0nwURpQlNFRYDlq0eOz3zvUNIt+7G6fv9
         cct8I1VFykeWKa/q+TDiXCPtUEPaYZaUJmx3ewF0TOdLhX5769K2GOnYbWXJ6m2VPawB
         t0d8RLV0cxjsvSlBoOapyco4bWtS2ZkeCH7pMU2ewnt9stGtAvbn/3yTL+kJ8oqG6e5N
         Jp7K9rt7IZzGrrIUYnW5ZxlAi13HnRKu79XQadDcekY+0Tj8hbRBDzGGbGr8gcZ6fVTd
         T/1Mks2cdNz548n75JhdhryCxm56LPZuuNQcfkTKaNbYqrDmB36FOxmYDAuQByV2PPmP
         ri0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YBwt2MVU6nNAOe4QsbbS2Wq8hC+X3+hnvO1hd669kyE=;
        b=DwS8kvIy7mLFTRY9hhSpjUOMmdfC4AXnNR5gaWyebdq4iiy+3zgQI1715mHYSO7zMq
         u9kY4MExeVou1CK0DbCnL8S6b7d/atPccFQBNKzzH0CWjkAf4NUoVqushuW98U8YY+RZ
         23yffT0/50Jd0uIcC7w6mWqXSGh8UMe3JjQlrc+mkTk2fF4zuCU6sHWp8bUgCnUWzRsi
         T6QOiZwmPQUZKxxn2eqPBW6ctpCBFii77LWKOCXVmzIKIKzQn42AuuabH6u1rCyeKENq
         bQTXq1ScSIN2XXt2GxXPaZ3O3dypjto3cXcPKnPumlzZHAGDni56Vq9L6W4A2m3ia/+A
         IjJQ==
X-Gm-Message-State: APjAAAWDSl4UlJ0q9qCHKQW8FhV5GfOr8BLFquVIx+xClG9HWvAFS/du
        Zrm4epWfVZ8tW95DtJ2t8UZLgLmPUC+AjQ==
X-Google-Smtp-Source: APXvYqxG4o0AqrcL5cNxPIj5MSCzJZzrIg1LV+xpXY+PlPSxzrGJUnqHcW13cNE3gP04Zi5ACEFIjQ==
X-Received: by 2002:a05:6214:923:: with SMTP id dk3mr4282819qvb.96.1581450882350;
        Tue, 11 Feb 2020 11:54:42 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w16sm2454811qkj.135.2020.02.11.11.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 11:54:41 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/rmap: annotate a data race at tlb_flush_batched
Date:   Tue, 11 Feb 2020 14:53:03 -0500
Message-Id: <1581450783-8262-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm->tlb_flush_batched could be accessed concurrently as noticed by
KCSAN,

 BUG: KCSAN: data-race in flush_tlb_batched_pending / try_to_unmap_one

 write to 0xffff93f754880bd0 of 1 bytes by task 822 on cpu 6:
  try_to_unmap_one+0x59a/0x1ab0
  set_tlb_ubc_flush_pending at mm/rmap.c:635
  (inlined by) try_to_unmap_one at mm/rmap.c:1538
  rmap_walk_anon+0x296/0x650
  rmap_walk+0xdf/0x100
  try_to_unmap+0x18a/0x2f0
  shrink_page_list+0xef6/0x2870
  shrink_inactive_list+0x316/0x880
  shrink_lruvec+0x8dc/0x1380
  shrink_node+0x317/0xd80
  balance_pgdat+0x652/0xd90
  kswapd+0x396/0x8d0
  kthread+0x1e0/0x200
  ret_from_fork+0x27/0x50

 read to 0xffff93f754880bd0 of 1 bytes by task 6364 on cpu 4:
  flush_tlb_batched_pending+0x29/0x90
  flush_tlb_batched_pending at mm/rmap.c:682
  change_p4d_range+0x5dd/0x1030
  change_pte_range at mm/mprotect.c:44
  (inlined by) change_pmd_range at mm/mprotect.c:212
  (inlined by) change_pud_range at mm/mprotect.c:240
  (inlined by) change_p4d_range at mm/mprotect.c:260
  change_protection+0x222/0x310
  change_prot_numa+0x3e/0x60
  task_numa_work+0x219/0x350
  task_work_run+0xed/0x140
  prepare_exit_to_usermode+0x2cc/0x2e0
  ret_from_intr+0x32/0x42

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 4 PID: 6364 Comm: mtest01 Tainted: G        W    L 5.5.0-next-20200210+ #5
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019

flush_tlb_batched_pending() is under PTL but the write is not, but
mm->tlb_flush_batched is only a bool type, so the value is unlikely to
be shattered. Thus, mark it as an intentional data race by using the
data race macro.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index b3e381919835..6983f5d5b114 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -679,7 +679,7 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
  */
 void flush_tlb_batched_pending(struct mm_struct *mm)
 {
-	if (mm->tlb_flush_batched) {
+	if (data_race(mm->tlb_flush_batched)) {
 		flush_tlb_mm(mm);
 
 		/*
-- 
1.8.3.1

