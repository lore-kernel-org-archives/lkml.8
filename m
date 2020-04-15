Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EE6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E634B2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+BkzuaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392218AbgDOAG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634559AbgDOAFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:05:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A81C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:05:04 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u9so189945pfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZqTkeiwENaudq21J8vTW1kd2VtXPsvTLGQP3XXO1NHU=;
        b=S+BkzuaFI/ql7zPm2jJufYxYG9LrRhNZMXcnwMDr7r8jFf1R3XOoh24P7ornVUb67I
         YnoIPO/xfD8edhC3LLxFzpaTtlRpgEOytqa8xPXxxqKqorQUvfz0wf8ZHtB5uGv0ZYVz
         qCBlHrTG4aJSE5yGfJsI37wsCiRMfGfxBRT2z9h5kbsqd+JhBFOC8+oF0kRc1t+emm+L
         msn8bCFxkGC6BDW+UG46VXrTXMQb6xMS6pbTr3Ee0LU4xkK3pHGDVgEBxgmItKzP8slj
         NK6YH0jTf2gwTzf64e5XUml8dQBx8sF1TInfy1UzMxRODBDmXLPg3IXznuV4qTtR0aKU
         wt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZqTkeiwENaudq21J8vTW1kd2VtXPsvTLGQP3XXO1NHU=;
        b=HynWN8NaBqsWngf9MrLoJv3Dk3MKOP9yX2MDUdOxnsZDwbcv5qDPeWxq9yShQZhdrh
         WOgnueO4eWEwuHm8z7u3f3xbTGlDkX3Gtv7l1xXdSdFKl27EFJROnt/uypEhMFPhNhrE
         WaUqQ5oOQPGepqNE3rMI9ZcvAjbknCkXHDgTMf4DF34yETpNtstwYLOhHEaDEHCb0Rbo
         hy9WLpM2uwtQ5VFZeeEu5Rn7ag43O0vZqugSTIBlG9vXboVrPjUl11vIluVuG9FP1PeG
         gy77axquVshQ3qXF/JgUdOe7HFqWfB95FUDhon/9Nmw6p0MRDIxl+UbXk0I+QARrN0+8
         XbbA==
X-Gm-Message-State: AGi0PuYFzQFokzIOu3cqR0PSBxkKpBVN7WglPz8WFQmAAAC3MTZtOK8N
        OWcdtn1aRuTXlfTHRq6PIvtRcg==
X-Google-Smtp-Source: APiQypL9+7skSK7zQht9VcXx962nONsEqOmoABTSyGj/fSCQq8rGrYJUyLaBuqdKiaF9VGYSi3ZrQg==
X-Received: by 2002:a63:ff49:: with SMTP id s9mr5626054pgk.46.1586909103760;
        Tue, 14 Apr 2020 17:05:03 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d203sm6772412pfd.79.2020.04.14.17.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:05:03 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:05:02 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Jon Grimm <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [patch 7/7] dma-pool: scale the default DMA coherent pool size with
 memory capacity
In-Reply-To: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2004141704330.68516@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When AMD memory encryption is enabled, some devices may use more than
256KB/sec from the atomic pools.  It would be more appropriate to scale
the default size based on memory capacity unless the coherent_pool
option is used on the kernel command line.

This provides a slight optimization on initial expansion and is deemed
appropriate due to the increased reliance on the atomic pools.  Note that
the default size of 128KB per pool will normally be larger than the
single coherent pool implementation since there are now up to three
coherent pools (DMA, DMA32, and kernel).

Note that even prior to this patch, coherent_pool= for sizes larger than
1 << (PAGE_SHIFT + MAX_ORDER-1) can fail.  With new dynamic expansion
support, this would be trivially extensible to allow even larger initial
sizes.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/pool.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 3e22022c933b..763b687569b0 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -22,8 +22,8 @@ static unsigned long pool_size_dma32;
 static unsigned long pool_size_kernel;
 #endif
 
-#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
-static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;
+/* Size can be defined by the coherent_pool command line */
+static size_t atomic_pool_size;
 
 /* Dynamic background expansion when the atomic pool is near capacity */
 static struct work_struct atomic_pool_work;
@@ -181,6 +181,16 @@ static int __init dma_atomic_pool_init(void)
 {
 	int ret = 0;
 
+	/*
+	 * If coherent_pool was not used on the command line, default the pool
+	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
+	 */
+	if (!atomic_pool_size) {
+		atomic_pool_size = max(totalram_pages() >> PAGE_SHIFT, 1UL) *
+					SZ_128K;
+		atomic_pool_size = min_t(size_t, atomic_pool_size,
+					 1 << (PAGE_SHIFT + MAX_ORDER-1));
+	}
 	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
 
 	atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
