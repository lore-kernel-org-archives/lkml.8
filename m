Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65605C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4292220657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN5/Jeqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgERTuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgERTuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:50:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869CFC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:50:23 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so4665412plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RTFGezog0FoY0Led7GpUdftvReGrQNJe75seXSSvjsQ=;
        b=aN5/JeqmGf5VFuqGc7Bp3OhmbnvAmgN7kOlSVI7s9M0c3M03M+ciSidQfTvhY6JtYY
         UHkjtoF8hLmordukc8/WQfagYmjsy8KOKGqYW4Cm8GFGNjwXOjvJEsjcSoENzJEK+DzU
         Qp1GagSZSVz5wU83TyyrFIriBTkcq6Ue4xIIAmwBEgq28r5IrJtqhz8Z7CBOPbVpAsoC
         e8HkIIlXMsn+TW0eailqAcelTtx5Z5Sh3hhV9uGSTUc+EgEir2EQTKBQTxn+FZi0jxdz
         rUwC/347ujt/bRRFpN5dsIfIMzo4NdKEWnYJSS5rrQH/Q2EN0++ajkn1+Hhej9tpOtSR
         bx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RTFGezog0FoY0Led7GpUdftvReGrQNJe75seXSSvjsQ=;
        b=rocwatnpmVUZSoHR1X1xXvPDETg0zGnD9GCokVLEtx/GFrGk126sjkRcuYhpDq76+y
         3frTy2xCgh0o6+nCe3rcI8bKywXx4GI2/1/VRznDFd15FIhgswtwqqmxVci0iTycsX3e
         Y1s0H8J2g2bw3SoSzgZ4Yzoj+QlPGG6TAItNiyHLK9o/Josqc60pJoo+H3DXUtMPDIjD
         0l1TvbRmM3rGAmBAYFhYeNvMKWW/sn5h1bTwcFr3gt63EvinmpiELWlyjyRb5+ivcKk5
         ZvSOFS8avvMBAgZH2dg9KMXDo32BE7qkINBcVC/OZi4AE1m+KvLxlT3xWehn4fUO7cRx
         p75A==
X-Gm-Message-State: AOAM530Bkajtuie2kxCFItgFGLIpHq0c2Bu/wEbLotIzYdmhmDHTkAj7
        ZiLmFoE6C5s+rn/ic8YV0NA=
X-Google-Smtp-Source: ABdhPJzxz922YJSj9+b/H/3/FQcz0ec0Cz0IJcFFwC+zg3vg/04+H0hilaUQWV8KSV2DObhbDhLQiA==
X-Received: by 2002:a17:902:bf43:: with SMTP id u3mr2436681pls.240.1589831422763;
        Mon, 18 May 2020 12:50:22 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.164.1])
        by smtp.gmail.com with ESMTPSA id n21sm300181pjo.25.2020.05.18.12.50.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 12:50:21 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [RFC] mm/gup.c: Use gup_flags as parameter instead of passing write flag
Date:   Tue, 19 May 2020 01:28:23 +0530
Message-Id: <1589831903-27800-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea is to get rid of write parameter. Instead caller will pass
FOLL_WRITE to __get_user_pages_fast(). This will not change any
functionality of the API. Once it is upstream all the callers will
be changed to pass FOLL_WRITE.

Updated the documentation of the API.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 include/linux/mm.h |  4 ++--
 mm/gup.c           | 18 +++++++++++-------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a32342..15dd594 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1816,8 +1816,8 @@ extern int mprotect_fixup(struct vm_area_struct *vma,
 /*
  * doesn't attempt to fault and will return short.
  */
-int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
-			  struct page **pages);
+int __get_user_pages_fast(unsigned long start, int nr_pages,
+			unsigned int gup_flags, struct page **pages);
 /*
  * per-process(per-mm_struct) statistics.
  */
diff --git a/mm/gup.c b/mm/gup.c
index 87a6a59..a8f869e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2666,7 +2666,14 @@ static bool gup_fast_permitted(unsigned long start, unsigned long end)
 }
 #endif
 
-/*
+/**
+ * __get_user_pages_fast() - pin user pages in memory
+ * @start:      starting user address
+ * @nr_pages:   number of pages from start to pin
+ * @gup_flags:  flags modifying pin behaviour
+ * @pages:      array that receives pointers to the pages pinned.
+ *              Should be at least nr_pages long.
+ *
  * Like get_user_pages_fast() except it's IRQ-safe in that it won't fall back to
  * the regular GUP.
  * Note a difference with get_user_pages_fast: this always returns the
@@ -2675,8 +2682,8 @@ static bool gup_fast_permitted(unsigned long start, unsigned long end)
  * If the architecture does not support this function, simply return with no
  * pages pinned.
  */
-int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
-			  struct page **pages)
+int __get_user_pages_fast(unsigned long start, int nr_pages,
+			unsigned int gup_flags, struct page **pages)
 {
 	unsigned long len, end;
 	unsigned long flags;
@@ -2685,10 +2692,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	 * Internally (within mm/gup.c), gup fast variants must set FOLL_GET,
 	 * because gup fast is always a "pin with a +1 page refcount" request.
 	 */
-	unsigned int gup_flags = FOLL_GET;
-
-	if (write)
-		gup_flags |= FOLL_WRITE;
+	gup_flags |= FOLL_GET;
 
 	start = untagged_addr(start) & PAGE_MASK;
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
-- 
1.9.1

