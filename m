Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E215C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE74F20774
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YudbnRxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgHNR2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgHNR2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:08 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517DAC061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:08 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id b13so3605297wrq.19
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d/u4o8cOL5u+yhGc4q9ktVy7qi4vlYcfWqeNAALsvIE=;
        b=YudbnRxxAfDza9Ob1s5ArnAOz+1EGRaJgYbc+niCE71NKhV6G4JRs1GS/K5w24bNUr
         B/kVJFITB/IGELm7t7feSJ7C/OROLDnd5pbDPJM0gnBEeNbVtdBLK89qQL/2DtpCyScK
         Ffnh6Mr9T4g3DvA51b63NMKHngoLitiYv2ZSrPU/kKzFeINw2oxGqoA14s/NK8wzluvo
         Ja9uXKDBdQU/5/v/axLxt0RhJj+RcISivrguLwVGv606pYPpZwMqLFAhOWSTb/FLqKTj
         5BGeTY40yacOluHenc5Hjmu/R9lASevoq9VCPvldEme65z2xkyAbbv3xa/WJrdxaoP03
         lf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d/u4o8cOL5u+yhGc4q9ktVy7qi4vlYcfWqeNAALsvIE=;
        b=qYE/KlrNH8mRauUjHOgWM3DRskfkqDKyF+r+VKnHb+4dwYKGRl8EctDltKNalDMPMh
         +SHZSG+CMaLj56qqdQDf08olxP9iuhF/1CLD1QL7cf8QRLSbwzSbl0VJgh0wS+1hE7DE
         6BtXr9Vm1mXceqvglFgc/RwPvSaQUD3rnIrLnk9KRh26LEbNr9RBmy999fAgrGnmKefM
         UmdQSp7XyE6N1IuxXC/bYfFD1e5KAahUSmZd4EoiQnm6lfORY/v8dawutWb456UKAtUq
         N1SsyPR94g4VycGeVM8IMbmx1XKUTk/ovv8om4/UEh3FDdj9r3g3qviZI4suQiDh1QTF
         3pxQ==
X-Gm-Message-State: AOAM530sOuM5rU4hB6s5oAqkJwEzHAJxW+hTUP2kW/XDnD3hW8dPid0j
        RqFZvvjQVbLJUgsmqgPaUr4yRysg0NUwevnL
X-Google-Smtp-Source: ABdhPJwUfre5/KF8bB29t8r0emVBi7vqCOHn70LMl1bwcOmb8g5oyISb2BJmiGdVS4t7AgjEr6kxB9yIrtpc0yKR
X-Received: by 2002:a05:600c:c3:: with SMTP id u3mr424029wmm.1.1597426086237;
 Fri, 14 Aug 2020 10:28:06 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:27:00 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <cdcf749c4b78368810885a0ba83b8f3f0328d722.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 18/35] kasan: separate metadata_fetch_row for each mode
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

Rework print_memory_metadata() to make it agnostic with regard to the
way metadata is stored. Allow providing a separate metadata_fetch_row()
implementation for each KASAN mode. Hardware tag-based KASAN will provide
its own implementation that doesn't use shadow memory.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h          |  8 ++++++
 mm/kasan/report.c         | 56 +++++++++++++++++++--------------------
 mm/kasan/report_generic.c |  5 ++++
 mm/kasan/report_tags.c    |  5 ++++
 4 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 38fa4c202e9a..1d3c7c6ce771 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -56,6 +56,13 @@
 #define KASAN_ABI_VERSION 1
 #endif
 
+/* Metadata layout customization. */
+#define META_BYTES_PER_BLOCK 1
+#define META_BLOCKS_PER_ROW 16
+#define META_BYTES_PER_ROW (META_BLOCKS_PER_ROW * META_BYTES_PER_BLOCK)
+#define META_MEM_BYTES_PER_ROW (META_BYTES_PER_ROW * KASAN_GRANULE_SIZE)
+#define META_ROWS_AROUND_ADDR 2
+
 struct kasan_access_info {
 	const void *access_addr;
 	const void *first_bad_addr;
@@ -167,6 +174,7 @@ bool check_invalid_free(void *addr);
 
 void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);
+void metadata_fetch_row(char *buffer, void *row);
 
 #ifdef CONFIG_KASAN_STACK_ENABLE
 void print_address_stack_frame(const void *addr);
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 6306673e7062..c904edab33b8 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -36,12 +36,6 @@
 #include "kasan.h"
 #include "../slab.h"
 
-/* Metadata layout customization. */
-#define META_BYTES_PER_BLOCK 1
-#define META_BLOCKS_PER_ROW 16
-#define META_BYTES_PER_ROW (META_BLOCKS_PER_ROW * META_BYTES_PER_BLOCK)
-#define META_ROWS_AROUND_ADDR 2
-
 static unsigned long kasan_flags;
 
 #define KASAN_BIT_REPORTED	0
@@ -241,55 +235,59 @@ static void print_address_description(void *addr, u8 tag)
 	print_address_stack_frame(addr);
 }
 
-static bool row_is_guilty(const void *row, const void *guilty)
+static bool meta_row_is_guilty(const void *row, const void *addr)
 {
-	return (row <= guilty) && (guilty < row + META_BYTES_PER_ROW);
+	return (row <= addr) && (addr < row + META_MEM_BYTES_PER_ROW);
 }
 
-static int shadow_pointer_offset(const void *row, const void *shadow)
+static int meta_pointer_offset(const void *row, const void *addr)
 {
-	/* The length of ">ff00ff00ff00ff00: " is
-	 *    3 + (BITS_PER_LONG/8)*2 chars.
+	/*
+	 * Memory state around the buggy address:
+	 *  ff00ff00ff00ff00: 00 00 00 05 fe fe fe fe fe fe fe fe fe fe fe fe
+	 *  ...
+	 *
+	 * The length of ">ff00ff00ff00ff00: " is
+	 *    3 + (BITS_PER_LONG / 8) * 2 chars.
+	 * The length of each granule metadata is 2 bytes
+	 *    plus 1 byte for space.
 	 */
-	return 3 + (BITS_PER_LONG/8)*2 + (shadow - row)*2 +
-		(shadow - row) / META_BYTES_PER_BLOCK + 1;
+	return 3 + (BITS_PER_LONG / 8) * 2 +
+		(addr - row) / KASAN_GRANULE_SIZE * 3 + 1;
 }
 
 static void print_memory_metadata(const void *addr)
 {
 	int i;
-	const void *shadow = kasan_mem_to_shadow(addr);
-	const void *shadow_row;
+	void *row;
 
-	shadow_row = (void *)round_down((unsigned long)shadow,
-					META_BYTES_PER_ROW)
-		- META_ROWS_AROUND_ADDR * META_BYTES_PER_ROW;
+	row = (void *)round_down((unsigned long)addr, META_MEM_BYTES_PER_ROW)
+			- META_ROWS_AROUND_ADDR * META_MEM_BYTES_PER_ROW;
 
 	pr_err("Memory state around the buggy address:\n");
 
 	for (i = -META_ROWS_AROUND_ADDR; i <= META_ROWS_AROUND_ADDR; i++) {
-		const void *kaddr = kasan_shadow_to_mem(shadow_row);
-		char buffer[4 + (BITS_PER_LONG/8)*2];
-		char shadow_buf[META_BYTES_PER_ROW];
+		char buffer[4 + (BITS_PER_LONG / 8) * 2];
+		char metadata[META_BYTES_PER_ROW];
 
 		snprintf(buffer, sizeof(buffer),
-			(i == 0) ? ">%px: " : " %px: ", kaddr);
+				(i == 0) ? ">%px: " : " %px: ", row);
+
 		/*
 		 * We should not pass a shadow pointer to generic
 		 * function, because generic functions may try to
 		 * access kasan mapping for the passed address.
 		 */
-		memcpy(shadow_buf, shadow_row, META_BYTES_PER_ROW);
+		metadata_fetch_row(&metadata[0], row);
+
 		print_hex_dump(KERN_ERR, buffer,
 			DUMP_PREFIX_NONE, META_BYTES_PER_ROW, 1,
-			shadow_buf, META_BYTES_PER_ROW, 0);
+			metadata, META_BYTES_PER_ROW, 0);
 
-		if (row_is_guilty(shadow_row, shadow))
-			pr_err("%*c\n",
-				shadow_pointer_offset(shadow_row, shadow),
-				'^');
+		if (meta_row_is_guilty(row, addr))
+			pr_err("%*c\n", meta_pointer_offset(row, addr), '^');
 
-		shadow_row += META_BYTES_PER_ROW;
+		row += META_MEM_BYTES_PER_ROW;
 	}
 }
 
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 29d30fae9421..6524651b5d2e 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -127,6 +127,11 @@ const char *get_bug_type(struct kasan_access_info *info)
 	return get_wild_bug_type(info);
 }
 
+void metadata_fetch_row(char *buffer, void *row)
+{
+	memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
+}
+
 #ifdef CONFIG_KASAN_STACK_ENABLE
 static bool __must_check tokenize_frame_descr(const char **frame_descr,
 					      char *token, size_t max_tok_len,
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 6ddb55676a7c..4060d0503462 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -85,6 +85,11 @@ void *find_first_bad_addr(void *addr, size_t size)
 	return p;
 }
 
+void metadata_fetch_row(char *buffer, void *row)
+{
+	memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
+}
+
 void print_tags(u8 addr_tag, const void *addr)
 {
 	u8 *shadow = (u8 *)kasan_mem_to_shadow(addr);
-- 
2.28.0.220.ged08abb693-goog

