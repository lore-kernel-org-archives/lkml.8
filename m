Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8A7C2BBFD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 06:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 293BB206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 06:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="wW8qZX3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405901AbgDNGVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 02:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbgDNGVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 02:21:53 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE89C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 23:21:53 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r20so3956336pfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 23:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AhGsCcJsWxwEFFxEZHrkOLjEp/9h1BEi4GUJh65PtH4=;
        b=wW8qZX3Uelwn7XTniuKRvm+BQQg7fayx1Qw8h2CxqacAQ1p1I90+7Lp17FAjvDv9z1
         qC341SseVZacRkPlv/Da5KdalPz3wP0Zj5KbZIKWCKJXiRrHHFEdh1VdGUssJ8iiI33g
         G/Dhf5Di1CQLga6HRgfBIEhO4SeGEMr1Yti8Gkm2auK+lMmEd3Wrg+tjq29Nslt4lZ9b
         jtzo9RF9qOOItIeoP1R0ook+cd29AqjnQur7QVVVTij5N8HqWAsNSiwyZYCg9At9tuHM
         A4PsPLgYBbiOoA+QEq0gt2VvRRQ2l0DR9PJPDejd2nf95pA2ULMHCHwTHcyx36MsONSU
         NjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AhGsCcJsWxwEFFxEZHrkOLjEp/9h1BEi4GUJh65PtH4=;
        b=gej8jqYTb4RO5Prl0PdPx4gxz5uWtbdgI+a4Gt5n3RJEXczOkjls6gysA7hDa/RbOk
         EsgiMTTXbFe71VH+U1bhEaXVBs8pKGcK2BMg+M6x5Xz1niBsiI6rJ1ZgAdG+ptIJ4h9V
         T98ZByT55m5wnqPhkpOVCRgLpTUOc90rW45Q5Hrm4Mr5E4IGFZSREr72n5ZQK3ytbYdL
         qQFvyjiXn/Uk6FOusQha7BZFDH0TdoHTvOhfrMj5NQPlmFciG5Cv0gZkhdpJmt0wzNuU
         XUPi7pc+NpOBkjMFkDcuxWy1u7+7yu3tEpQtA4et2CbiXYBwWtQQZ19n57VPGaY2Z2Ph
         GHQQ==
X-Gm-Message-State: AGi0PuZvrJtjkD35B7zowOGYIfM1iCUESFccJ2A4UnlOkWnfYZ0wyxyd
        1fqvq3ig10BUG8ZOzCuq0zgurg==
X-Google-Smtp-Source: APiQypJ63b72LYvQX0syssjhVvQdWz8tO1l5fSoJ4sTfv7EI8r/gFKegCWq+/El+20plx32p4Nrzlg==
X-Received: by 2002:a62:e803:: with SMTP id c3mr5962493pfi.228.1586845313150;
        Mon, 13 Apr 2020 23:21:53 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.69])
        by smtp.gmail.com with ESMTPSA id w12sm3211103pfq.133.2020.04.13.23.21.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 23:21:52 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Subject: [PATCH] mm/ksm: Fix kernel NULL pointer dereference at 0000000000000040
Date:   Tue, 14 Apr 2020 14:20:50 +0800
Message-Id: <20200414062050.66644-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The find_mergeable_vma can return NULL. In this case, it leads
to crash when we access vma->vm_mm(which's offset is 0x40) in
write_protect_page. And this case did happen on our server. The
following calltrace is captured in kernel 4.19 with ksm enabled.
So add a vma check to fix it.

--------------------------------------------------------------------------
  BUG: unable to handle kernel NULL pointer dereference at 0000000000000040
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP NOPTI
  CPU: 9 PID: 510 Comm: ksmd Kdump: loaded Tainted: G OE 4.19.36.bsk.9-amd64 #4.19.36.bsk.9
  Hardware name: FOXCONN R-5111/GROOT, BIOS IC1B111F 08/17/2019
  RIP: 0010:try_to_merge_one_page+0xc7/0x760
  Code: 24 58 65 48 33 34 25 28 00 00 00 89 e8 0f 85 a3 06 00 00 48 83 c4
        60 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 46 08 a8 01 75 b8 <49>
        8b 44 24 40 4c 8d 7c 24 20 b9 07 00 00 00 4c 89 e6 4c 89 ff 48
  RSP: 0018:ffffadbdd9fffdb0 EFLAGS: 00010246
  RAX: ffffda83ffd4be08 RBX: ffffda83ffd4be40 RCX: 0000002c6e800000
  RDX: 0000000000000000 RSI: ffffda83ffd4be40 RDI: 0000000000000000
  RBP: ffffa11939f02ec0 R08: 0000000094e1a447 R09: 00000000abe76577
  R10: 0000000000000962 R11: 0000000000004e6a R12: 0000000000000000
  R13: ffffda83b1e06380 R14: ffffa18f31f072c0 R15: ffffda83ffd4be40
  FS: 0000000000000000(0000) GS:ffffa0da43b80000(0000) knlGS:0000000000000000
  CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000040 CR3: 0000002c77c0a003 CR4: 00000000007626e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  PKRU: 55555554
  Call Trace:
    ? follow_page_pte+0x36d/0x5e0
    ksm_scan_thread+0x115e/0x1960
    ? remove_wait_queue+0x60/0x60
    kthread+0xf5/0x130
    ? try_to_merge_with_ksm_page+0x90/0x90
    ? kthread_create_worker_on_cpu+0x70/0x70
    ret_from_fork+0x1f/0x30
--------------------------------------------------------------------------

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Xiongchun duan <duanxiongchun@bytedance.com>
---
 mm/ksm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index a558da9e71770..69b2f85e22d5b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2112,8 +2112,11 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
 
 		down_read(&mm->mmap_sem);
 		vma = find_mergeable_vma(mm, rmap_item->address);
-		err = try_to_merge_one_page(vma, page,
-					    ZERO_PAGE(rmap_item->address));
+		if (vma)
+			err = try_to_merge_one_page(vma, page,
+					ZERO_PAGE(rmap_item->address));
+		else
+			err = -EFAULT;
 		up_read(&mm->mmap_sem);
 		/*
 		 * In case of failure, the page was not really empty, so we
-- 
2.11.0

