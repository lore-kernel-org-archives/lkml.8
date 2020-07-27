Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FFBC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48F32075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgG0VvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:51:09 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33321 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgG0Vuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:50:55 -0400
Received: by mail-qv1-f65.google.com with SMTP id dd12so3209317qvb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zkYeT/xj57b18y4SHLdVNhmS6ZqT0wXNFWeGZTT/lEI=;
        b=SsYuj4RpeJTR8jlBaV3Fc3iibxaRLtwqmA7annbswoUU5hM8P7bXrOpZXnIcEuecvY
         meQAtB8Uxf/e4FJwadlqH19zlkALVvDCq0Dn5CvSVw8gTd/tgy+pyzWx/n3n8lYIXGxC
         x8PVrk/IPrLWiMsVR2CszsptoD/sGWpaKzolb2N2JXRZ7vZvZH4IZxAQq1JTd9NzPhoy
         E2cMvYtHTBStNF1Si0Qg2p1ZLkhZZ/MYiOMGgC2GCYDN2kObKWecf0WjdpZiCkaG3AlV
         HekELXrWWpYZa3CJjKp2oI95wiNYfpA0NvClctcBk9DwiiL8KZZ3HU+mFzILBeqwKblJ
         ZMSQ==
X-Gm-Message-State: AOAM530sMOQJa9EO5QEB+osesA4J8efrm2LsqBIYgm0cg2QUux/3h9k0
        quT/58LPZckEXDdRFjtBmch1UMt/
X-Google-Smtp-Source: ABdhPJwfjZ+VsmJaOZi+mpcEMknfqyEz4HWM+p6GrsQaCw2I05dG6AjMccPUyzk0apaU1DORYjprAg==
X-Received: by 2002:a05:6214:554:: with SMTP id ci20mr18912912qvb.108.1595886653864;
        Mon, 27 Jul 2020 14:50:53 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n90sm15629338qte.21.2020.07.27.14.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:50:53 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] x86/kaslr: Simplify __process_mem_region
Date:   Mon, 27 Jul 2020 17:50:44 -0400
Message-Id: <20200727215047.3341098-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727215047.3341098-1-nivedita@alum.mit.edu>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of unnecessary temporary variables and redundant tests in
__process_mem_region.

Fix one minor bug: in case of an overlap, the beginning of the region
should be used even if it is exactly image_size, not just strictly
larger.

Change type of minimum/image_size arguments in process_mem_region to
unsigned long. These actually can never be above 4G (even on x86_64),
and they're unsigned long in every other function except this one.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 50 ++++++++------------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 758d78433f94..850e131121f7 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -622,42 +622,24 @@ static void __process_mem_region(struct mem_vector *entry,
 				 unsigned long image_size)
 {
 	struct mem_vector region, overlap;
-	unsigned long start_orig, end;
-	struct mem_vector cur_entry;
+	unsigned long region_end;
 
-	/* Ignore entries entirely below our minimum. */
-	if (entry->start + entry->size < minimum)
-		return;
-
-	/* Ignore entries above memory limit */
-	end = min(entry->size + entry->start, mem_limit);
-	if (entry->start >= end)
-		return;
-	cur_entry.start = entry->start;
-	cur_entry.size = end - entry->start;
-
-	region.start = cur_entry.start;
-	region.size = cur_entry.size;
+	/* Clamp region to minimum and memory limit. */
+	region.start = clamp_val(entry->start, minimum, mem_limit);
+	region_end = clamp_val(entry->start + entry->size, minimum, mem_limit);
 
 	/* Give up if slot area array is full. */
 	while (slot_area_index < MAX_SLOT_AREA) {
-		start_orig = region.start;
-
-		/* Potentially raise address to minimum location. */
-		if (region.start < minimum)
-			region.start = minimum;
-
 		/* Potentially raise address to meet alignment needs. */
 		region.start = ALIGN(region.start, CONFIG_PHYSICAL_ALIGN);
 
 		/* Did we raise the address above the passed in memory entry? */
-		if (region.start > cur_entry.start + cur_entry.size)
+		if (region.start > region_end)
 			return;
 
-		/* Reduce size by any delta from the original address. */
-		region.size -= region.start - start_orig;
+		region.size = region_end - region.start;
 
-		/* Return if region can't contain decompressed kernel */
+		/* Return if region can't contain decompressed kernel. */
 		if (region.size < image_size)
 			return;
 
@@ -668,27 +650,19 @@ static void __process_mem_region(struct mem_vector *entry,
 		}
 
 		/* Store beginning of region if holds at least image_size. */
-		if (overlap.start > region.start + image_size) {
-			struct mem_vector beginning;
-
-			beginning.start = region.start;
-			beginning.size = overlap.start - region.start;
-			process_gb_huge_pages(&beginning, image_size);
+		if (overlap.start - region.start >= image_size) {
+			region.size = overlap.start - region.start;
+			process_gb_huge_pages(&region, image_size);
 		}
 
-		/* Return if overlap extends to or past end of region. */
-		if (overlap.start + overlap.size >= region.start + region.size)
-			return;
-
 		/* Clip off the overlapping region and start over. */
-		region.size -= overlap.start - region.start + overlap.size;
 		region.start = overlap.start + overlap.size;
 	}
 }
 
 static bool process_mem_region(struct mem_vector *region,
-			       unsigned long long minimum,
-			       unsigned long long image_size)
+			       unsigned long minimum,
+			       unsigned long image_size)
 {
 	int i;
 	/*
-- 
2.26.2

