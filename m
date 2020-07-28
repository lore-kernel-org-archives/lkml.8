Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0CDC433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825AE207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgG1W6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:58:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41604 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbgG1W5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id v22so10317973qtq.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=664q02oA7FO52GOLxPk6sglqmKpmRZ9R6+3YdHJlxFE=;
        b=r1JD6b+McAe6TiK2794lYOK92aoKdlVBFBPHbCrkNSF4FXeysEAWWjt4vHGjhUIyJv
         FzfDT0fabD0F34dbDUkKivbOcZrUWjcfJ2kCjBD8j2F2RO6QOB1WQG5qTvX5gLJ4NYrU
         IxhSanSzOMf8z477/8eZ8dL5ZPTOE5OnD+3Mwe+4Y/P49ihCWfP8cp81nb3LYMxtRFVg
         eu7grE19Ml0jll4HakyNl50InwEXxavmFKSCceKeE6BEdoin7vwABC8BX5cYHzKoef/M
         oMHcACbIOyRnvmaPsvyDEC5gfvzt9Pj11QjwVXmVrCdOlS/FmPJOdwDc9OhAfVhZhSEz
         i99g==
X-Gm-Message-State: AOAM532REuS1Wrk2gXrwCEnjLS3PjZtbqJi5aI55cWgNgvzZB/IQB3Z4
        c3hDrwRL7RRSnf7xwlF3zzY=
X-Google-Smtp-Source: ABdhPJyUxaFV0D4cQqWAj7C0Rd03EH5tmIcsmDhCc0ynydc5m6HEqPR1WhBh10zl7eF/dddZz0ZsoA==
X-Received: by 2002:ac8:152:: with SMTP id f18mr17852257qtg.163.1595977060545;
        Tue, 28 Jul 2020 15:57:40 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:39 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 20/21] x86/kaslr: Make local variables 64-bit
Date:   Tue, 28 Jul 2020 18:57:21 -0400
Message-Id: <20200728225722.67457-21-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of local variables/fields that store mem_vector
addresses to u64 to make it less likely that 32-bit overflow will cause
issues on 32-bit.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index c49d479245d0..38ecbf2e61c5 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -461,7 +461,7 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 {
 	int i;
 	struct setup_data *ptr;
-	unsigned long earliest = img->start + img->size;
+	u64 earliest = img->start + img->size;
 	bool is_overlapping = false;
 
 	for (i = 0; i < MEM_AVOID_MAX; i++) {
@@ -506,7 +506,7 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 }
 
 struct slot_area {
-	unsigned long addr;
+	u64 addr;
 	unsigned long num;
 };
 
@@ -537,7 +537,8 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
 static void
 process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
 {
-	unsigned long pud_start, pud_end, gb_huge_pages;
+	u64 pud_start, pud_end;
+	unsigned long gb_huge_pages;
 	struct mem_vector tmp;
 
 	if (!IS_ENABLED(CONFIG_X86_64) || !max_gb_huge_pages) {
@@ -578,7 +579,7 @@ process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
 	}
 }
 
-static unsigned long slots_fetch_random(void)
+static u64 slots_fetch_random(void)
 {
 	unsigned long slot;
 	unsigned int i;
@@ -594,7 +595,7 @@ static unsigned long slots_fetch_random(void)
 			slot -= slot_areas[i].num;
 			continue;
 		}
-		return slot_areas[i].addr + slot * CONFIG_PHYSICAL_ALIGN;
+		return slot_areas[i].addr + ((u64)slot * CONFIG_PHYSICAL_ALIGN);
 	}
 
 	if (i == slot_area_index)
@@ -607,7 +608,7 @@ static void __process_mem_region(struct mem_vector *entry,
 				 unsigned long image_size)
 {
 	struct mem_vector region, overlap;
-	unsigned long region_end;
+	u64 region_end;
 
 	/* Enforce minimum and memory limit. */
 	region.start = max_t(u64, entry->start, minimum);
-- 
2.26.2

