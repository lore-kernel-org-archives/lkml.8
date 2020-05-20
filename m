Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F0EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB89206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSxMo2AJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgETF3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 01:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgETF3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:29:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE0DC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y7so797578ybj.15
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gLHH8qp+cYXwW8jRyKSlJBqB5UMPqJrCDS4qFPCf+dg=;
        b=SSxMo2AJhnlfSf/ZvXnACSRetnbCwbiy1h4mF2wsrAxplpgt5TkT//aTBy2576EFtq
         Zx7hUhmePluZ5nS0TRCdVfnxXvmxjyLWOBWQM6IEmLP5IUlhae/4qLPSqpArS1KEOPH9
         7XtZUaEJXeRjX5B3n/lZfVgQR5PcYh9vdt2LbJkrbNQJGAwv5stEsS7a/A+LYAqwj+7J
         XjtxtkHLzILSLzgkfHw8rBd0/PDA1cHkzl0ZGzHlOuGWbMbIwn5GxrCLX9YWB3kvtCCT
         AUG9GLFti5TxfiYW/pRAKGK1UfFT4aPxmzifKbr1/OYpyKbaQ9FIciF+2A0zXFDyYIZ4
         AUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gLHH8qp+cYXwW8jRyKSlJBqB5UMPqJrCDS4qFPCf+dg=;
        b=RBM57yRku8RwP35DKCNSfLl2uJwe0yynftBdJqiNKv19U0jwHAZ9VnOD3i2MKNdMY3
         oA+WgVzaHxKeXLG2UwNLdkcP1qfjDPWsqZz95RfGJ6rU4HseBVaSx80bljgu1el52C9S
         BwNt4aXmH2rPMPxWjkWQqDYCueF8k/6XpJs3dz6bzmfGhYDl7v0EnUxRTgj2CzsskYs2
         xN8h8Hdg70QDPwZ+hl224efR39NEfDeQ/Qc+hsoLOWxP5VKeebaI7VVJoxJmN6jSo/Ls
         OFsUoD38nmkLLAYunRk/oQSpM8UicfLS6Nlv4yw9D6Lv0G63E88JEj6p5gN8p0Zodf/v
         zGPw==
X-Gm-Message-State: AOAM5314/us5dYOF9B/Ui/zqoV4YHnPSfETtcHh427aAhe4+MRhIboYD
        lx9TSq59NG1y7QNzaDZGr60ezl7efNw=
X-Google-Smtp-Source: ABdhPJw/E1zWNbDSelXgByf12MoInkyaQ/jc/SjICoxh5X/9tXkPORZTTkpcGSzX3CcDokRMAnm9Zs6xoGk=
X-Received: by 2002:a25:dad5:: with SMTP id n204mr4778038ybf.164.1589952558050;
 Tue, 19 May 2020 22:29:18 -0700 (PDT)
Date:   Tue, 19 May 2020 22:28:59 -0700
In-Reply-To: <20200520052908.204642-1-walken@google.com>
Message-Id: <20200520052908.204642-4-walken@google.com>
Mime-Version: 1.0
References: <20200520052908.204642-1-walken@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v6 03/12] DMA  reservations: use the new mmap locking API
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
        John Hubbard <jhubbard@nvidia.com>,
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
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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
2.26.2.761.g0e0b3e54be-goog

