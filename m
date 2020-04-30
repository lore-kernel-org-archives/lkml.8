Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF53BC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 18:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A98222073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 18:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k942Q6I6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgD3Sx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 14:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3Sx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 14:53:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAD1C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:53:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so266539pfv.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tCdxst5tczlIzqff4W9H4F8TmPvPw2gnTPXXKU2ofDs=;
        b=k942Q6I67iXZpEDFUoY2vP1Z0MQr4CFIWM41c8k6HZI0NszRzd6CMjjvwyTEV6spMf
         eZpRvIhTtI66G3uAlRd/OS3SJxrkGODFyqCokrKBWZxnInabbAejkY+Z3UuvtIwNHM/3
         TAoeSX8dogOXWvCVG5g5roNH9ZaGGVmvwi7K+5e7oLEzrSyRu98d2hJMa9h5Nx9Af+Yy
         ezUv0L/4M0cwPJBAGJmRVLVwjDJ1w3lH/Sy5dCfTSF6QMDMybvJm37W/1u6zTG3oBjbP
         vNTjcUNIJbLhJsySvKF+BUJWEJomMXcQPWVkjQVlz+I98YvYLovpe2oM1eDJHlmcmmSh
         MXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tCdxst5tczlIzqff4W9H4F8TmPvPw2gnTPXXKU2ofDs=;
        b=CshTRHm2dlF+CvtZn97+fmKdjoxw+M2A8QcdKAe8Gv/09En4r2+olJ3iwrb1+UWcD0
         eik892FXnGcY8mw53GR6JE67FlLLmXw6r8nIRV44/IsF2pGcDFtSso6tEC3w3C9/3nWJ
         BW/q95QVIgqlO3gpjUHPABE+FFGbacMAkha6OkUdil1RBArvzrmyuchPA0BIXzWF1VMn
         YjBzPhsRqt0KBQudUsws0cjh3aLnMKZlEvpJ5TuZTUPQjNExKDkg777Zm6DHt/79lnsb
         5b/OCwQshCUxtGSS45BUhmH1mIQhsjQ+kVa5bfLuf5xOuOuTuWayXkMrSGt45L3CYmrg
         BZqA==
X-Gm-Message-State: AGi0Puauh0/PZ7ACe+iLLcYni4Tsfhzopj/pJDgGsZ2bPDajsZg0sjU6
        7Ue+iQkfcZEJBgePQ6s7suw=
X-Google-Smtp-Source: APiQypJER8e+1f4K+e2eafBOds4s7QWdgQ8n+CkJbZ7ST7hs/yoSGxN2U2EYAeOCM1ljLV1AFCuy2Q==
X-Received: by 2002:a63:f960:: with SMTP id q32mr295612pgk.357.1588272836781;
        Thu, 30 Apr 2020 11:53:56 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.167.43.171])
        by smtp.gmail.com with ESMTPSA id g25sm427775pfo.150.2020.04.30.11.53.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2020 11:53:56 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] mm/gup.c: Corrected document reference path
Date:   Fri,  1 May 2020 00:31:54 +0530
Message-Id: <1588273314-3790-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document path Documentation/vm/pin_user_pages.rst is not a correct
reference and it should be Documentation/core-api/pin_user_pages.rst.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 mm/gup.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 7ce796c..4952f12 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2864,10 +2864,10 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
  * the arguments here are identical.
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
- * see Documentation/vm/pin_user_pages.rst for further details.
+ * see Documentation/core-api/pin_user_pages.rst for further details.
  *
- * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
- * is NOT intended for Case 2 (RDMA: long-term pins).
+ * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pages.rst.
+ * It is NOT intended for Case 2 (RDMA: long-term pins).
  */
 int pin_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages)
@@ -2904,10 +2904,10 @@ int pin_user_pages_fast(unsigned long start, int nr_pages,
  * the arguments here are identical.
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
- * see Documentation/vm/pin_user_pages.rst for details.
+ * see Documentation/core-api/pin_user_pages.rst for details.
  *
- * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
- * is NOT intended for Case 2 (RDMA: long-term pins).
+ * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pages.rst.
+ * It is NOT intended for Case 2 (RDMA: long-term pins).
  */
 long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
@@ -2940,10 +2940,10 @@ long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
  * FOLL_PIN is set.
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
- * see Documentation/vm/pin_user_pages.rst for details.
+ * see Documentation/core-api/pin_user_pages.rst for details.
  *
- * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
- * is NOT intended for Case 2 (RDMA: long-term pins).
+ * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pages.rst.
+ * It is NOT intended for Case 2 (RDMA: long-term pins).
  */
 long pin_user_pages(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages,
-- 
1.9.1

