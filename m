Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32343C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0981E246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/JZQ00I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgB1Le6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:34:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44255 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgB1Le6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:34:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id a14so1359345pgb.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 03:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HJEEF+ZoXF3+Nd4diWecS36bLcljIlgCVbyfxnITy0g=;
        b=k/JZQ00IhfViLeK6G0njVXZ+whnThIG8lZANGkpgh80P/Y9DAoOPXtOjwaXFEvZlho
         oz9AlqAiMyxygoKt0ftGvwJtLrK7uIWroi+5Gq5I/wxXz3PzeGj1/EaDjmKcvABvVPcg
         MaBY6borR8Pn/mMueS/cgTmeyhF63ywAsnH963GgDtDlOD3UwHCtkYb6yTCWMbvd+GZg
         h0CPoJTu9VlPuuAVr0IKrhtCX4r5dLBgzUnHWkZRljK4KM+SYf4I55KsyP+iy92yTxcr
         4rbE5aGfhTpQmaVltG2anr8eA8bM40vH4JqnfetYkYVtmCJ3w8+SBU7m6iKhkHqw4iM7
         m1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HJEEF+ZoXF3+Nd4diWecS36bLcljIlgCVbyfxnITy0g=;
        b=jlIewJEmD3/5eozYYCXjHFDoVJw3rMQOPvlT7E5x0s77VckuOo4MmyniqO0fXVn/PY
         S2oOn1tLWP5ECqgT2vnm+w6+tiz529T4WxkAEMWveoDCiHCIvyNcNlE+YTRvm/Z8gqF2
         kRRaNmHMszG9yJdeiJBRpXF8BXFBuMV698VB72bS/X9O9OJ2LFKMAw0E+4Rpx6TikE7O
         9cG/RY8jkzQVStzq+IQYiqWVJ5S4i0tGg6Mu4qUQJgL8sDWcG4YM+lfRxw3VDFVSs3gN
         QF97EhFCxTYGNu2/Cbg/v0G/80KN/WMFoI4bPZ2JFyjNFVMQtHfTttS3Bxidjvd4dBOT
         s0WQ==
X-Gm-Message-State: APjAAAX9jbkZeYEFwMwKtlQGZDJW9X9clONXI9WdjNN1oP+/afgzPisb
        cOskJ+JyZzkLw98l59vxxg==
X-Google-Smtp-Source: APXvYqzjxd/Sq/oiTAGLmX1fGiq0C3UXJLMhVbet4cdnBwIB+rQQLDWwYP/Y2VJjq2wMVZgl16uJlA==
X-Received: by 2002:a05:6a00:2ba:: with SMTP id q26mr2742501pfs.249.1582889696147;
        Fri, 28 Feb 2020 03:34:56 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d14sm11402168pfq.117.2020.02.28.03.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 03:34:55 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCHv5 1/3] mm/gup: rename nr as nr_pinned in internal_get_user_pages_fast()
Date:   Fri, 28 Feb 2020 19:32:28 +0800
Message-Id: <1582889550-9101-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1582889550-9101-1-git-send-email-kernelfans@gmail.com>
References: <1582889550-9101-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To better reflect the held state of pages and make code self-explaining,
rename nr as nr_pinned.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/gup.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1b521e0..cd8075e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2432,7 +2432,7 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
 					struct page **pages)
 {
 	unsigned long addr, len, end;
-	int nr = 0, ret = 0;
+	int nr_pinned = 0, ret = 0;
 
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
 				       FOLL_FORCE | FOLL_PIN)))
@@ -2451,25 +2451,25 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
 	    gup_fast_permitted(start, end)) {
 		local_irq_disable();
-		gup_pgd_range(addr, end, gup_flags, pages, &nr);
+		gup_pgd_range(addr, end, gup_flags, pages, &nr_pinned);
 		local_irq_enable();
-		ret = nr;
+		ret = nr_pinned;
 	}
 
-	if (nr < nr_pages) {
+	if (nr_pinned < nr_pages) {
 		/* Try to get the remaining pages with get_user_pages */
-		start += nr << PAGE_SHIFT;
-		pages += nr;
+		start += nr_pinned << PAGE_SHIFT;
+		pages += nr_pinned;
 
-		ret = __gup_longterm_unlocked(start, nr_pages - nr,
+		ret = __gup_longterm_unlocked(start, nr_pages - nr_pinned,
 					      gup_flags, pages);
 
 		/* Have to be a bit careful with return values */
-		if (nr > 0) {
+		if (nr_pinned > 0) {
 			if (ret < 0)
-				ret = nr;
+				ret = nr_pinned;
 			else
-				ret += nr;
+				ret += nr_pinned;
 		}
 	}
 
-- 
2.7.5

