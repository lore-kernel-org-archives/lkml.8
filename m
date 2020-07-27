Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA1BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B4E2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgG0VvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:51:08 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:47045 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgG0Vuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:50:55 -0400
Received: by mail-qk1-f195.google.com with SMTP id d14so16779503qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8/1Hf8iU28AAeCNJ39bOpU5D7IlHEtSkRRaWVr2wKs=;
        b=E5APldgfAVUtL7OOwwmlP+HpaYul0hDY3ADgPgoR/ak8sk0ho10KI9L4GT2JUEAgp4
         gr+sI2t/MG8JBKPfR3PUJXydqGZrecqyRwT0btqtpMxVezVj2mNdTtkKXEHk+QxuG6cA
         PjAmPTelAzwChjWw9z9xNdTJHgT5CnQwq/Mxm/X1NUMfZ7sx8Upgawad4cWh8FM9k039
         RHDxGhOvKSbTAjrtQJupexE7eR2rnqcs+n6y4Ogp5KLoAcD8r+BazOyCGIoUyOzLIRJO
         vp3lpPx3crD1YoOaE18GwfEX0yvAvCdeFKogIje7BnuULRbTz5q+MvlH+e5j0YWqtXab
         L96w==
X-Gm-Message-State: AOAM5316wYz0x22kyEUpPEzHGwWyUoCi1PQS2M1YfM+ZaMCbn61IzxME
        28W+iWV7hV5V9tT6HdNYlzY=
X-Google-Smtp-Source: ABdhPJynQj5CwhRpOhm8vAU/yxngtQ8INCO3SxFjmEQt7f3NDvXfMShVS2X58kOVaJVYg6Wj7a9Dfw==
X-Received: by 2002:a05:620a:20ca:: with SMTP id f10mr24651100qka.0.1595886654472;
        Mon, 27 Jul 2020 14:50:54 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n90sm15629338qte.21.2020.07.27.14.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:50:54 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] x86/kaslr: Simplify process_gb_huge_pages
Date:   Mon, 27 Jul 2020 17:50:45 -0400
Message-Id: <20200727215047.3341098-7-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727215047.3341098-1-nivedita@alum.mit.edu>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Short-circuit the whole function on 32-bit.

Replace the loop to determine the number of 1Gb pages with arithmetic.

Fix one minor bug: if the end of the region is aligned on a 1Gb
boundary, the current code will not use the last available 1Gb page due
to an off-by-one error.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 48 ++++++++++++++------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 850e131121f7..29ec964b1330 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -546,49 +546,43 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
 static void
 process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
 {
-	unsigned long addr, size = 0;
+	unsigned long pud_start, pud_end, gb_huge_pages;
 	struct mem_vector tmp;
-	int i = 0;
 
-	if (!max_gb_huge_pages) {
+	if (IS_ENABLED(CONFIG_X86_32) || !max_gb_huge_pages) {
 		store_slot_info(region, image_size);
 		return;
 	}
 
-	addr = ALIGN(region->start, PUD_SIZE);
-	/* Did we raise the address above the passed in memory entry? */
-	if (addr < region->start + region->size)
-		size = region->size - (addr - region->start);
-
-	/* Check how many 1GB huge pages can be filtered out: */
-	while (size > PUD_SIZE && max_gb_huge_pages) {
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
+	if (pud_start - region->start >= image_size) {
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
+	if (region->start + region->size - pud_end >= image_size) {
+		tmp.start = pud_end;
+		tmp.size = region->start + region->size - pud_end;
 		store_slot_info(&tmp, image_size);
 	}
 }
-- 
2.26.2

