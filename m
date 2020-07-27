Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6968C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC77620809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgG0XIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:08:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44768 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgG0XIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:08:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id j187so16961895qke.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 16:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKDvHMgirTfGFPxMcAqMp+8UvNThgvdbysGLoxQ1j6s=;
        b=QdMNZu/hFMdRNj74Nu+Fbt30ZDsKIK7FT3AUnrpH8tp7f52TEbuo8QUrNrpG97zpE1
         0cQxOD4Gd0raBzxOim2jkp5F7MeylrW+8qKvRcTaSnz0Kbwzc8w/PnYUD7IiWxJ0V1z9
         Wmqo2GHigJF0h4HLwMjhihTG62l4ZFjHj7MpzKWTY0rb9lKXEPOStIw03fZZT6uY2122
         RWoo3Fj27kCdFD3ihtFCRob8dHKwBM6op+bEisBApX2CXLzDVa9VbiWs7UGP9MJpy3no
         6O8Ehq5K4QDrGb6+utSSqCnL91nHpCus5lAjjjm3Qh2OqsLusmZAAzrYjXttQeq/QBUq
         aKrw==
X-Gm-Message-State: AOAM533EUyL4aBQkoU0t+W3TGCVRuQHZnCPHQbI0Mzo5joYkZwXA7Dw4
        1vYx90Qr2nkAAnO5W0fg/xk=
X-Google-Smtp-Source: ABdhPJwCvR3LoArxRJ4v3q6LdtssvjY/rFvkk1ZCZ4c04G4rfs+sAbP2xj7hu6BkZPN8hyN/Jj3DKw==
X-Received: by 2002:a37:62d4:: with SMTP id w203mr24551249qkb.463.1595891287398;
        Mon, 27 Jul 2020 16:08:07 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j61sm8216984qtd.52.2020.07.27.16.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 16:08:06 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] x86/kaslr: Simplify __process_mem_region
Date:   Mon, 27 Jul 2020 19:07:58 -0400
Message-Id: <20200727230801.3468620-6-nivedita@alum.mit.edu>
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
index 758d78433f94..d3d8f1f6d5d3 100644
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
+		if (overlap.start >= region.start + image_size) {
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

