Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA322C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA0D207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgG1W5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:57:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36443 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729948AbgG1W5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id t23so13116118qto.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frlZNzKjxBW53TThhYCvkj05m4KvzWU3R8lBzdsAfZs=;
        b=TTxie5HzLiCVSwzdlb1BVZLO4d0nU3p2lMQjfkqiYqKGTmtPitU/cO7o+LwdyXtuLJ
         gpiXTdurjzWHtm6oK8o59L2K3K5k8zK5/H3oA68zo0+YCRGlafyZGRIANbSljOVWGeze
         txXtWFNSxNq2IKOjIFnvtT6FIIdIrOMGUR3+clRB20f1I24XaMpUQZij/P9FLJDFuGSM
         ijcm9mY1MqbL02kM8RVgd2m04BeWxwL36kmivX8i/abpy4BY4NF65Sp6iJuoLGe7v0Fm
         DbINY4c1Ox1I7SPu6n3bsoZQHqTk2ihVaYFT6utNj70agpLLoF6+BnkVPdNMXoEnJaoZ
         d9Dw==
X-Gm-Message-State: AOAM531pZo8l85hBjG6D5OGK/5RKFl9Xuo3PSltrijIUZ9G1RaLqTLVE
        Gr64SCJLdNYGtuCNBlJy59ItHDrl
X-Google-Smtp-Source: ABdhPJyaxXLklXHbqIKj2z3KUNlzIf44oVK2txRvpXscZkYRkuTnzCRh7pna3BlZoVQzPaGk5x7iew==
X-Received: by 2002:ac8:78d:: with SMTP id l13mr10293908qth.188.1595977050786;
        Tue, 28 Jul 2020 15:57:30 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:30 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/21] x86/kaslr: Drop some redundant checks from __process_mem_region
Date:   Tue, 28 Jul 2020 18:57:10 -0400
Message-Id: <20200728225722.67457-10-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clip the start and end of the region to minimum and mem_limit prior to
the loop. region.start can only increase during the loop, so raising it
to minimum before the loop is enough.

A region that becomes empty due to this will get checked in
the first iteration of the loop.

Drop the check for overlap extending beyond the end of the region. This
will get checked in the next loop iteration anyway.

Rename end to region_end for symmetry with region.start.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 8cc47faea56d..d074986e8061 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -623,34 +623,23 @@ static void __process_mem_region(struct mem_vector *entry,
 				 unsigned long image_size)
 {
 	struct mem_vector region, overlap;
-	unsigned long end;
+	unsigned long region_end;
 
-	/* Ignore entries entirely below our minimum. */
-	if (entry->start + entry->size < minimum)
-		return;
-
-	/* Ignore entries above memory limit */
-	end = min(entry->size + entry->start, mem_limit);
-	if (entry->start >= end)
-		return;
-
-	region.start = entry->start;
+	/* Enforce minimum and memory limit. */
+	region.start = max_t(unsigned long long, entry->start, minimum);
+	region_end = min(entry->start + entry->size, mem_limit);
 
 	/* Give up if slot area array is full. */
 	while (slot_area_index < MAX_SLOT_AREA) {
-		/* Potentially raise address to minimum location. */
-		if (region.start < minimum)
-			region.start = minimum;
-
 		/* Potentially raise address to meet alignment needs. */
 		region.start = ALIGN(region.start, CONFIG_PHYSICAL_ALIGN);
 
 		/* Did we raise the address above the passed in memory entry? */
-		if (region.start > end)
+		if (region.start > region_end)
 			return;
 
 		/* Reduce size by any delta from the original address. */
-		region.size = end - region.start;
+		region.size = region_end - region.start;
 
 		/* Return if region can't contain decompressed kernel */
 		if (region.size < image_size)
@@ -668,10 +657,6 @@ static void __process_mem_region(struct mem_vector *entry,
 			process_gb_huge_pages(&region, image_size);
 		}
 
-		/* Return if overlap extends to or past end of region. */
-		if (overlap.start + overlap.size >= region.start + region.size)
-			return;
-
 		/* Clip off the overlapping region and start over. */
 		region.start = overlap.start + overlap.size;
 	}
-- 
2.26.2

