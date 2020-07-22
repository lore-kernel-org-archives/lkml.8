Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF82BC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8898207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgGVRom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:44:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46018 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbgGVRol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:44:41 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jyInH-0007OX-Ud
        for linux-kernel@vger.kernel.org; Wed, 22 Jul 2020 17:44:39 +0000
Received: by mail-wr1-f72.google.com with SMTP id v4so860061wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 10:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wIK2o+UarAf7XWWj0TPiEcgHlsE+IXk4111M8CYmrKA=;
        b=g5DKY566cQVjxRJQSZSZVD9HSSFqJLqZue1P9vttrR4HMGNesUXpzC/BryFBBlBGzY
         q7ize93U3308WVz32/hzBGDVhX9SDd7jwwfED0z+42E3H6AUzcUKXwHWaJJ8BNG3HCOj
         8e2ZBjQ0o448hlawJuZ+QmfmcN1791htcU1X138LaDT8idGgvR42TlMP0PuWNEE/Yt52
         DlyLxzUSSjNKiGAKRen6GFRhfLUKH4Jsyaqkhp98cDtBSlzAuerj2spX5desL4GwBHQ2
         tkZcfMAtkHd1Mwqn48KC34RTp6XC9yl0EMC89JxoW/uD08jldCmpBzq7CMHmBBOFytUy
         Fo6g==
X-Gm-Message-State: AOAM533f8SQppTJazfscmv3FdGrHvB3HXryk1ukbVjXmIZzUGNH4bMH8
        PS5KyR51w73MGxgHJtIDXFD6/4nbeFCmfcSBGqnVMpnFfJiuThQXqePCcQ6bocHA3XgdsnrEFm+
        sIKbw8jai0UvD39f3Ia3gQJA5GpAfLjROxn6jErFGjg==
X-Received: by 2002:adf:a11d:: with SMTP id o29mr566752wro.421.1595439879197;
        Wed, 22 Jul 2020 10:44:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0/LB1ytnXv/m4kbvp81Q9qHxXu3ShznEJiuSAv0FpH67DPWIZLP0LDSqSiuObHQl6NsjEPQ==
X-Received: by 2002:adf:a11d:: with SMTP id o29mr566735wro.421.1595439878868;
        Wed, 22 Jul 2020 10:44:38 -0700 (PDT)
Received: from localhost (host-87-11-131-192.retail.telecomitalia.it. [87.11.131.192])
        by smtp.gmail.com with ESMTPSA id 12sm430632wmg.6.2020.07.22.10.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:44:38 -0700 (PDT)
Date:   Wed, 22 Jul 2020 19:44:36 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: swap: do not wait for lock_page() in unuse_pte_range()
Message-ID: <20200722174436.GB841369@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiting for lock_page() with mm->mmap_sem held in unuse_pte_range() can
lead to stalls while running swapoff (i.e., not being able to ssh into
the system, inability to execute simple commands like 'ps', etc.).

Replace lock_page() with trylock_page() and release mm->mmap_sem if we
fail to lock it, giving other tasks a chance to continue and prevent
the stall.

This issue can be easily reproduced running swapoff in systems with a
large amount of RAM (>=100GB) and a lot of pages swapped out to disk. A
specific use case is to run swapoff immediately after resuming from
hibernation.

Under these conditions and without this patch applied the system can be
stalled even for 15min, with this patch applied the system is always
responsive.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 mm/swapfile.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 987276c557d1..794935ecf82a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1977,7 +1977,11 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			return -ENOMEM;
 		}
 
-		lock_page(page);
+		if (!trylock_page(page)) {
+			ret = -EAGAIN;
+			put_page(page);
+			goto out;
+		}
 		wait_on_page_writeback(page);
 		ret = unuse_pte(vma, pmd, addr, entry, page);
 		if (ret < 0) {
@@ -2100,11 +2104,17 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type,
 	struct vm_area_struct *vma;
 	int ret = 0;
 
+retry:
 	mmap_read_lock(mm);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		if (vma->anon_vma) {
 			ret = unuse_vma(vma, type, frontswap,
 					fs_pages_to_unuse);
+			if (ret == -EAGAIN) {
+				mmap_read_unlock(mm);
+				cond_resched();
+				goto retry;
+			}
 			if (ret)
 				break;
 		}
-- 
2.25.1

