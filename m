Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDC7C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8822E20829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgG1W6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:58:12 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34563 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730071AbgG1W5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:40 -0400
Received: by mail-qv1-f65.google.com with SMTP id t6so5058771qvw.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qgSJi4bkt+A/WrHOOKufXW7aJ0RRAww+tyiz0OA0xks=;
        b=WXGDA1ECpE32hmiTV5H4qmb7ar0C1FIbst8sX5FHSCtmnDHxY1pPXE4ALkWnZ2l9MG
         wosDUqUBPhhXRphRlRWxOaMZZmbxYM7bZYhfAmQe+vx3iF5ENI9WXt469u3IjPutMZyH
         E8oYURAdIHZ6pFFXhO3xH3iFjJnGcUOyXQTBfppba26/Ii2sRniA4pX/wzLHGjdhrXxp
         OydSla/GyP/Zm6VwhgC1IhMKhK6ETRO/uHj1t87Ai4AR0FQPObm8jL5ioM3VqI37hBB5
         AVQ+LgsnSmVIgBF2AGoI9qBL/q+8CrcfS8DPM7NyVB2ukMca3rxL8rrN/CnJxfjOYYgx
         1yew==
X-Gm-Message-State: AOAM532HC3/+V33Wo6BW+QBxXjmn6jYTb8HoZw9sKmrQPaRv3cAUQVqd
        Ii9qmDSom1iwIMU62oIV2jHQic+t
X-Google-Smtp-Source: ABdhPJwcLi7x3UKMPNZhShhjERgnDEPaWUTwoyRwyX7oEj9/EPjn18f5YBo9B05RJ3U8aB7tPAuyTQ==
X-Received: by 2002:a0c:9b94:: with SMTP id o20mr30579998qve.177.1595977059545;
        Tue, 28 Jul 2020 15:57:39 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:38 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/21] x86/kaslr: Replace unsigned long long with u64
Date:   Tue, 28 Jul 2020 18:57:20 -0400
Message-Id: <20200728225722.67457-20-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 13 ++++++-------
 arch/x86/boot/compressed/misc.h  |  4 ++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b6ef77b644bd..c49d479245d0 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -98,7 +98,7 @@ static bool memmap_too_large;
  * Store memory limit: MAXMEM on 64-bit and KERNEL_IMAGE_SIZE on 32-bit.
  * It may be reduced by "mem=nn[KMG]" or "memmap=nn[KMG]" command line options.
  */
-static unsigned long long mem_limit;
+static u64 mem_limit;
 
 /* Number of immovable memory regions */
 static int num_immovable_mem;
@@ -141,8 +141,7 @@ enum parse_mode {
 };
 
 static int
-parse_memmap(char *p, unsigned long long *start, unsigned long long *size,
-		enum parse_mode mode)
+parse_memmap(char *p, u64 *start, u64 *size, enum parse_mode mode)
 {
 	char *oldp;
 
@@ -172,7 +171,7 @@ parse_memmap(char *p, unsigned long long *start, unsigned long long *size,
 			 */
 			*size = 0;
 		} else {
-			unsigned long long flags;
+			u64 flags;
 
 			/*
 			 * efi_fake_mem=nn@ss:attr the attr specifies
@@ -211,7 +210,7 @@ static void mem_avoid_memmap(enum parse_mode mode, char *str)
 
 	while (str && (i < MAX_MEMMAP_REGIONS)) {
 		int rc;
-		unsigned long long start, size;
+		u64 start, size;
 		char *k = strchr(str, ',');
 
 		if (k)
@@ -611,7 +610,7 @@ static void __process_mem_region(struct mem_vector *entry,
 	unsigned long region_end;
 
 	/* Enforce minimum and memory limit. */
-	region.start = max_t(unsigned long long, entry->start, minimum);
+	region.start = max_t(u64, entry->start, minimum);
 	region_end = min(entry->start + entry->size, mem_limit);
 
 	/* Give up if slot area array is full. */
@@ -672,7 +671,7 @@ static bool process_mem_region(struct mem_vector *region,
 	 * immovable memory and @region.
 	 */
 	for (i = 0; i < num_immovable_mem; i++) {
-		unsigned long long start, end, entry_end, region_end;
+		u64 start, end, entry_end, region_end;
 		struct mem_vector entry;
 
 		if (!mem_overlaps(region, &immovable_mem[i]))
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 726e264410ff..3efce27ba35c 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -70,8 +70,8 @@ int cmdline_find_option(const char *option, char *buffer, int bufsize);
 int cmdline_find_option_bool(const char *option);
 
 struct mem_vector {
-	unsigned long long start;
-	unsigned long long size;
+	u64 start;
+	u64 size;
 };
 
 #if CONFIG_RANDOMIZE_BASE
-- 
2.26.2

