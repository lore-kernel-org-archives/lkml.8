Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22099C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A52520829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgG1W5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:57:54 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40583 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729978AbgG1W5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id h7so20438007qkk.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQMmTnajY5eYCOmwZRBHbur3Flx5GWzOMVTRLQeeOzo=;
        b=nPVBkKWaRy5zDtP8jTcHwn9Fhj/E1MVMuHysbRGrLeeH84WZOIGfSQ8cH6+ZsGaEaK
         1IH0bGk4oXNvykMcp1O5EoFh6Yrw7u4QEFBLNuxhCoEk+Q9OKdxGEbGrwbsn3KxRWmcE
         anpD6ryF/XUhEhPwsHgGf8+14IeItP9kQ6uRg2vW6d2H04bzlx04yhGTmFg/f4UTTk8a
         zvOWgb2dMud/ikH5cdxhIUWIsNapiAXeJwIphub9GSQLNk3+RBICQqe7Ol1gwoax4uvD
         qSp5dC+s/I2A/Lte+Z74BnWAzUvouu+IRg9/1oZ9yrX5udU6i12SA1aFKK4bR6aYrOiH
         yJIw==
X-Gm-Message-State: AOAM530iWDC87qI0goMt59iuiSZyJAdeOJKRpnqMPmAL/UUj94KNAgbt
        bkm6NSYP0Vp7DFUonKfOGPM=
X-Google-Smtp-Source: ABdhPJzebBLc4Wyoxwq42CmMf4N0zgikXdd7/8R0a91orXJMWdI6NQLyDpH3qn75Yd0qRooRt2ZBAw==
X-Received: by 2002:a37:8142:: with SMTP id c63mr28406869qkd.97.1595977053103;
        Tue, 28 Jul 2020 15:57:33 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:32 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/21] x86/kaslr: Simplify process_gb_huge_pages
Date:   Tue, 28 Jul 2020 18:57:13 -0400
Message-Id: <20200728225722.67457-13-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the loop to determine the number of 1Gb pages with arithmetic.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 46 ++++++++++++++------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 3727e9708690..7fb699aae74e 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -547,49 +547,43 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
 static void
 process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
 {
-	unsigned long addr, size = 0;
+	unsigned long pud_start, pud_end, gb_huge_pages;
 	struct mem_vector tmp;
-	int i = 0;
 
 	if (!IS_ENABLED(CONFIG_X86_64) || !max_gb_huge_pages) {
 		store_slot_info(region, image_size);
 		return;
 	}
 
-	addr = ALIGN(region->start, PUD_SIZE);
-	/* Did we raise the address above the passed in memory entry? */
-	if (addr < region->start + region->size)
-		size = region->size - (addr - region->start);
-
-	/* Check how many 1GB huge pages can be filtered out: */
-	while (size >= PUD_SIZE && max_gb_huge_pages) {
-		size -= PUD_SIZE;
-		max_gb_huge_pages--;
-		i++;
-	}
+	/* Are there any 1GB pages in the region? */
+	pud_start = ALIGN(region->start, PUD_SIZE);
+	pud_end = ALIGN_DOWN(region->start + region->size, PUD_SIZE);
 
 	/* No good 1GB huge pages found: */
-	if (!i) {
+	if (pud_start >= pud_end) {
 		store_slot_info(region, image_size);
 		return;
 	}
 
-	/*
-	 * Skip those 'i'*1GB good huge pages, and continue checking and
-	 * processing the remaining head or tail part of the passed region
-	 * if available.
-	 */
-
-	if (addr >= region->start + image_size) {
+	/* Check if the head part of the region is usable. */
+	if (pud_start >= region->start + image_size) {
 		tmp.start = region->start;
-		tmp.size = addr - region->start;
+		tmp.size = pud_start - region->start;
 		store_slot_info(&tmp, image_size);
 	}
 
-	size  = region->size - (addr - region->start) - i * PUD_SIZE;
-	if (size >= image_size) {
-		tmp.start = addr + i * PUD_SIZE;
-		tmp.size = size;
+	/* Skip the good 1GB pages. */
+	gb_huge_pages = (pud_end - pud_start) >> PUD_SHIFT;
+	if (gb_huge_pages > max_gb_huge_pages) {
+		pud_end = pud_start + (max_gb_huge_pages << PUD_SHIFT);
+		max_gb_huge_pages = 0;
+	} else
+		max_gb_huge_pages -= gb_huge_pages;
+
+	/* Check if the tail part of the region is usable. */
+	if (region->start + region->size >= pud_end + image_size) {
+		tmp.start = pud_end;
+		tmp.size = region->start + region->size - pud_end;
 		store_slot_info(&tmp, image_size);
 	}
 }
-- 
2.26.2

