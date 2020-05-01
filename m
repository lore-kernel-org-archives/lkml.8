Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94CDC4725C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B631C2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7DrWM7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgEAHkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 03:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgEAHkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 03:40:11 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A574CC035495
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 00:40:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id y6so2028595pjc.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 00:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=68MF0mDAuQKXmyv4cM6UCkwuoNI6S07F0Y008UnFGIA=;
        b=d7DrWM7Pg1LzeLY9hTHX3Vu6bzl5opKrCH2QlCTt6Jrx2Kf5gZhk+v6vTLU6f+ULz2
         PTiPKHZARFJ6lrB3W3f9Ywxqo6KsLZQ/vb3d1Tw5dk54Ht4in1nQE5s/8lPxhYRC9x1a
         D6edusf8njClbUpHSkZBebx7PTMR1SOSvH/r7MaZr6myG/iAla1rNjPRCW6OW+XNQIHt
         OmRiF3MrZcOxTbSbEdUqOK7VqTixWGAKbO/x12boCmXJ9u9lBV04xM/B/YgAAbeVKoUN
         UGDdZTWUZA10VOkmyzHXDnEI1gjDagbffVyU61Fe1nwJg3me3bJZ6FbrIMvJuUZ+dixf
         BcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=68MF0mDAuQKXmyv4cM6UCkwuoNI6S07F0Y008UnFGIA=;
        b=mXjVBljaWoaHjEZsF9OW0ithNNs5qvOhiS+zZ6LZYHAxyvSunJdKuzyjzuNpa4uy+N
         9sBWF8dRvXylG6BQ69m4Y8kEiqvNXyUWo2wyuhMtkGKD8JXJgISCOhT5Iwy6M8aeD3bj
         JXWnIj/fpoJjoDEbHjc/qCLvwamHPIBdWwqElu35mtJcxXq8mvnDATthlV4sbInhoLpq
         b6yTDjBWyQDet+zF+6OS4r+ePLRbLBFZCbwqdWKr9IxY5G4Oi8zKIN0VJ4TQg7GH6pVP
         N62xM1PL0Hi6F6sVvXP7hZE5roRYYLlTTrBT2AJjVC0SJH/qMiXbrcHTvAYl6To6/hZp
         6Vhg==
X-Gm-Message-State: AGi0PubcM+4oji1OyTG8VAf7hksn9uj8+a40Mwoof0AGBZ0R6u/Wql/u
        j7pmOOUz+oa3eJN3v73w6QTq6LLfawo=
X-Google-Smtp-Source: APiQypJiEJ4kQAfPAoSZcmNCfZQu1/ZpRWQas3IjFCF2RyIzmyY+jFIehrdb4AljNbKemje+OfRRHA==
X-Received: by 2002:a17:90a:3ace:: with SMTP id b72mr3264947pjc.48.1588318809841;
        Fri, 01 May 2020 00:40:09 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id w12sm1557841pfq.133.2020.05.01.00.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 00:40:09 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: [RFC][PATCH 3/4] dma-buf: cma_heap: Extend logic to export CMA regions tagged with "linux,cma-heap"
Date:   Fri,  1 May 2020 07:39:48 +0000
Message-Id: <20200501073949.120396-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200501073949.120396-1-john.stultz@linaro.org>
References: <20200501073949.120396-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reworks the cma_heap initialization so that
we expose both the default CMA region and any CMA regions
tagged with "linux,cma-heap" in the device-tree.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Andrew F. Davis" <afd@ti.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/dma-buf/heaps/cma_heap.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 626cf7fd033a..dd154e2db101 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -141,6 +141,11 @@ static int __add_cma_heap(struct cma *cma, void *data)
 {
 	struct cma_heap *cma_heap;
 	struct dma_heap_export_info exp_info;
+	struct cma *default_cma = dev_get_cma_area(NULL);
+
+	/* We only add the default heap and explicitly tagged heaps */
+	if (cma != default_cma && !cma_dma_heap_enabled(cma))
+		return 0;
 
 	cma_heap = kzalloc(sizeof(*cma_heap), GFP_KERNEL);
 	if (!cma_heap)
@@ -162,16 +167,11 @@ static int __add_cma_heap(struct cma *cma, void *data)
 	return 0;
 }
 
-static int add_default_cma_heap(void)
+static int cma_heaps_init(void)
 {
-	struct cma *default_cma = dev_get_cma_area(NULL);
-	int ret = 0;
-
-	if (default_cma)
-		ret = __add_cma_heap(default_cma, NULL);
-
-	return ret;
+	cma_for_each_area(__add_cma_heap, NULL);
+	return 0;
 }
-module_init(add_default_cma_heap);
+module_init(cma_heaps_init);
 MODULE_DESCRIPTION("DMA-BUF CMA Heap");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

