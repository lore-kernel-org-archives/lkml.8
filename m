Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF3CC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D17120809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgG0XIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:08:12 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32843 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgG0XIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:08:09 -0400
Received: by mail-qk1-f193.google.com with SMTP id l23so17031060qkk.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 16:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2nZl/wfZCwqJz0Uq6l8YavpgpAx0NQEkZ1cBoy2s3YA=;
        b=UyBDuUIEo0rt8k+dt2SjPGBI9KafJ9krcXMV73ySL+MEV9jQjprVtWg6gnWyniAo1b
         3gQu3NinyqJNjJyzOtyNmbOAu6XjA1ZR/UKdiH6MJXmvKdeQPLQC7dM1YLjPhC4B77Qz
         oI3sT/0WxVO3wrw4ohwA7zoe62pdznCdTmRyx91bu26MLFEyoiQ0euLp3HqXyGAcHoTM
         Hi98UtEZnvBGqYkU0pGOK0PfvexYRwShb6qWmQ+asv2QRIFElvhdx11RPMvX+37IBhgW
         S9jR6ioUXrpWopRgmP27q8fDnIevdW3L2cFbnltTzDny+GxcPK8/EWqFlpp5dKm87wg2
         3rmA==
X-Gm-Message-State: AOAM533fZ9CUYBFMUTBozLa3fTOqutX7R4V57BoWae4H80gjxZ0kRQr1
        CvnTaqF2MpKZRoExU5UczPU=
X-Google-Smtp-Source: ABdhPJyIaZRuiVVFiAgsE8qrLxFHa3NiQbR2G0Yx05WxRnAgCPmKUxmD8aUqDhnqAFC6AzAov+HDrA==
X-Received: by 2002:a05:620a:553:: with SMTP id o19mr24110744qko.46.1595891288401;
        Mon, 27 Jul 2020 16:08:08 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j61sm8216984qtd.52.2020.07.27.16.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 16:08:07 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] x86/kaslr: Simplify process_gb_huge_pages
Date:   Mon, 27 Jul 2020 19:07:59 -0400
Message-Id: <20200727230801.3468620-7-nivedita@alum.mit.edu>
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
index d3d8f1f6d5d3..91c5f9771f42 100644
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

