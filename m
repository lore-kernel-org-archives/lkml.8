Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EBBC352B6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949562074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="c2dnPZDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406935AbgDNH44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406749AbgDNH4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:56:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59217C0A3BDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:56:52 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nu11so4883726pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3PJsIbLnGG+0LNZvpyyPpJKrgmiHJsFy1tLFZ5G7hg=;
        b=c2dnPZDNCBzzLF/SNgoQWxW/orovCCc+Q/60foy/H9tCof4ofS6NSGK24IxzzfHMq8
         vLEVxD1O+wF9gfufRz9gW/l7P0zwkZDzAjvjjLtAecSy+8V6C1dmTz7e/Ztf+yiXfysA
         jbc3C9WOKMF65vZE4IUUx4f0VMSye4Su9wFOHt3NtmEBLhHhl768i8rZMsbM4Rd9vZEU
         BhbmS/FmUemOC0oO5F4WTejs0OUXbEmyc4trzUikxxcFvnzN1TNZ9Bp3PFkKE6uhZwy8
         9nDP/wZ13X4Ve/arW/Puhsm/4jeSsLHX1+iXSGeQOjlmZHDQFH64cEDx8SG3/3igwwVP
         q9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3PJsIbLnGG+0LNZvpyyPpJKrgmiHJsFy1tLFZ5G7hg=;
        b=JXL6Fr0UTQ9RhLpMdFbZ38wyS+BJ5tcPGRODjdiy0O+dD4CKmsuKM4Ayc0KuSC3FKN
         qZEtrT6C9Xjazc6PJqcvicr8bCY9fIlFaedjOzh3JlhxDdznN8fIbgPY1iFpEaTu11aU
         8+5QE93fd0pwVLbaJeXnrgs/iXezNeC3WJ1tNP3p1+NG0VajMV79/nRWqkXNrHQl1WkF
         wRfb/JUk7Iut2kBejBPqNB6W24uHcm7wZVkT6MylUgOCyc9lIX5HhJPbJYlt9+IGQ+iA
         DmaDPeuXJu90tsDCr/5tYLFdihE93lpyWc3YYOZ+pGQn4gq9PxeXKuX0CuHgJ1pseLwi
         9EVg==
X-Gm-Message-State: AGi0PuZO2R4THJVUXzmih+YmAsPifXKGbd4El/WD8lWev9z6kZBDnIaK
        0iPnjQyQd8QKF2oVy3+V82dWQA==
X-Google-Smtp-Source: APiQypKpKG9coUBFC0Wb+ShFX1kW+n7CuUoWRS/IMPrXMqWW92Hl10XH9jEO4rfStFoJfPYhH6HyLg==
X-Received: by 2002:a17:90a:bf8c:: with SMTP id d12mr26893363pjs.11.1586851011729;
        Tue, 14 Apr 2020 00:56:51 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.69])
        by smtp.gmail.com with ESMTPSA id c201sm10568346pfc.73.2020.04.14.00.56.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 00:56:51 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, Markus.Elfring@web.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Subject: [PATCH v2] mm/ksm: Fix NULL pointer dereference when KSM zero page is enabled
Date:   Tue, 14 Apr 2020 15:56:22 +0800
Message-Id: <20200414075622.69822-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The find_mergeable_vma can return NULL. In this case, it leads
to crash when we access vma->vm_mm(its offset is 0x40) later in
write_protect_page. And this case did happen on our server. The
following calltrace is captured in kernel 4.19 with KSM zero page
enabled. So add a vma check to fix it.

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

Fixes: e86c59b1b12d ("mm/ksm: improve deduplication of zero pages with colouring")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Xiongchun Duan <duanxiongchun@bytedance.com>
---
Change in v2:
    Update commit message and patch subject.

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

