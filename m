Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CC0C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58CBD20706
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sB5nY0d7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgDVAOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDVAOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:14:33 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605ACC061BD3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:32 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o6so184367pjl.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UAEzdyMiRrOhtZuLD3lTnP68UOKOqMWTsjPHTtGkwuw=;
        b=sB5nY0d7HNEnyNFQPIPL6m6Kh611Etd/DoVT5T/Ph2JZ26H9Uai54sw+NpDER2K3+Z
         uAcWLNM6sC7d4ksjWP04IheEn1gl1lIuaQpUeTX67Ter97MvnpNdx2JgAyZRoVu2CI8q
         5jUWe8+/IY8Y4SYzSb3WnkFZ1BAJ74RQyOP64xHD+wGPfCHpFWLPgpjKtJYNe3VaTcMU
         /hCPUzgUaLsq/GzyRC+AsOHNg/k9PxAGC++F6VyesAA3GKQR8C2CpJC4TtT98+6or4UB
         vsCVgmmXVSz85/t+1COyQkROYEKfFaXYIOIAKVOAHFeV1peDKHB7uQrfzFLVsobJGT4a
         Z8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UAEzdyMiRrOhtZuLD3lTnP68UOKOqMWTsjPHTtGkwuw=;
        b=jOK7msXI6ixNJf8C7IzrUApqWkw//40jO6XdTxtxX923PnlBfRuNzzD51QeLAlLbQP
         Lbmr13rtjS8bVwTezO6Hpwdu1qTgut2QK9BKwr5xzJhbrhFQ5/wPkls7kXQ5sTD/ydpT
         7SKf7mORZ/9UrVCjiWNLeF8pgGgi74I+xwhmvw2BOX2ViScR4wzHyD5r0LfeOWyf8lKH
         vptGpvLRfIFGJZLMLlkYCHbJJg22RvFkGWCLcmex2c9mlI75vlfbR9efe9xPo6V0rImr
         w8s/VfzfZLE5tYA03N2wv0GANWzLSKaVy1Z664i1CEr3pQtdpXG8Rm2H03yJg66rhjNa
         bhWw==
X-Gm-Message-State: AGi0PuaiF1rmf/V9fh53jxX+3nxh4EzjqBJ0ETEN041zl9BJWttxkOEM
        ziMwB4OKPRAJ9yKYhLKzv9KCWAsP3Sg=
X-Google-Smtp-Source: APiQypI1owOp4WSl5zVc2FPL1GdOwdwZSropHZlQ8q5Y97qp1WP+lcSDQax4Y0xqyAUDuqyU+hmG2EDRCMU=
X-Received: by 2002:a63:8948:: with SMTP id v69mr16501197pgd.351.1587514471822;
 Tue, 21 Apr 2020 17:14:31 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:14:15 -0700
In-Reply-To: <20200422001422.232330-1-walken@google.com>
Message-Id: <20200422001422.232330-4-walken@google.com>
Mime-Version: 1.0
References: <20200422001422.232330-1-walken@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v5 03/10] DMA  reservations: use the new mmap locking API
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This use is converted manually ahead of the next patch in the series,
as it requires including a new header which the automated conversion
would miss.

Signed-off-by: Michel Lespinasse <walken@google.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 drivers/dma-buf/dma-resv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 4264e64788c4..b45f8514dc82 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -34,6 +34,7 @@
 
 #include <linux/dma-resv.h>
 #include <linux/export.h>
+#include <linux/mm.h>
 #include <linux/sched/mm.h>
 
 /**
@@ -109,7 +110,7 @@ static int __init dma_resv_lockdep(void)
 
 	dma_resv_init(&obj);
 
-	down_read(&mm->mmap_sem);
+	mmap_read_lock(mm);
 	ww_acquire_init(&ctx, &reservation_ww_class);
 	ret = dma_resv_lock(&obj, &ctx);
 	if (ret == -EDEADLK)
@@ -118,7 +119,7 @@ static int __init dma_resv_lockdep(void)
 	fs_reclaim_release(GFP_KERNEL);
 	ww_mutex_unlock(&obj.lock);
 	ww_acquire_fini(&ctx);
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 	
 	mmput(mm);
 
-- 
2.26.1.301.g55bc3eb7cb9-goog

