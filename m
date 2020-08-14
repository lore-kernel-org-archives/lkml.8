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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE47C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2968E22C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ttJgaF/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgHNR2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgHNR2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:05 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E821C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:05 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e14so7485645qtm.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mCvcC3dYzcxUwc7C0YdRc21YWrhNGjweNe7or4+XlWk=;
        b=ttJgaF/P3U2oSow7UH8ZHinJK2ntN4CM0o6Ekay4TdHMFd56qT409NSuHPVxrA56h5
         SwXrB1xrCWdP52W4WZBRr965mtYnjn35Tq0Gk+EDG2xRUJh7Qkf8IOrv5UwqSrTyRycJ
         yOAI7dF0zkRvPzw7R+QqT3nFkoY6nHFsEvLDjKUWzuQ60iwzyjXpi81rT5mbx+IxoO59
         cw1EVMXw38/5FbII9vnx0nbFNeMtDT6YvbT8UruueGBDnQgnUiTFPgh6nxKfXM+y6VPv
         u4t+f7POCw97KRCE1yAOFsd1oZBYpDjj95G4NO9SE/RMMvbP5+NciohmFzjEY48S68Ut
         lJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mCvcC3dYzcxUwc7C0YdRc21YWrhNGjweNe7or4+XlWk=;
        b=Yv9Jg5+6EscMVtW/kvN4Q/IWUCMfiocCstGNA6n1Fy5faYU6mQzstuhhr5eYqDBzut
         kL0yN9tAnxaC8NlHTo6Ufc0Ci+Qdizl/BsUHkKSunvP+JSY2wMHxcdqzML0wL0MiWB76
         IY8LsmypH0Cu8X6Lcl+DF1SP4rt58ul01R+y6H4ItZqqj1+mfWUn5O9sYPI9oWC4cmPm
         ASzUGe5O8YSyoX3SD5CvnE42aL3nSuFgPXurHG3eHsDZVHlSkN/Hd6bRvWORC9/tBrDS
         iJwFZM0ZEEyYlU+namFWIeah1Lw1zAhNZwjj6vx70SsmeYvQYMRP2FfOPEKElcb+So1R
         yBKA==
X-Gm-Message-State: AOAM530Z6hMWNwRZLtFtKg4C8phlaUQVBVIeWwa32RNJefRdavzgHrXp
        Au4mG+qapAoTUKemAHIRpUglCBGEMILoX/Mv
X-Google-Smtp-Source: ABdhPJwyr1exuUZ/fVZL/EhW5aHt3/m30xzb8gPM63f7667oSE8rNBHS3hr4bCvgKG+YQTcF8zeI8ppWiSbBiHwW
X-Received: by 2002:ad4:4ea7:: with SMTP id ed7mr3716612qvb.8.1597426084066;
 Fri, 14 Aug 2020 10:28:04 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:26:59 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <1142e2ec61dfc863a4ec5b92b60c97120957ec80.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 17/35] kasan: rename SHADOW layout macros to META
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

Hardware tag-based KASAN won't be using shadow memory, but will reuse
these macros. Rename "SHADOW" to implementation-neutral "META".

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 2cce7c9beea3..6306673e7062 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -36,11 +36,11 @@
 #include "kasan.h"
 #include "../slab.h"
 
-/* Shadow layout customization. */
-#define SHADOW_BYTES_PER_BLOCK 1
-#define SHADOW_BLOCKS_PER_ROW 16
-#define SHADOW_BYTES_PER_ROW (SHADOW_BLOCKS_PER_ROW * SHADOW_BYTES_PER_BLOCK)
-#define SHADOW_ROWS_AROUND_ADDR 2
+/* Metadata layout customization. */
+#define META_BYTES_PER_BLOCK 1
+#define META_BLOCKS_PER_ROW 16
+#define META_BYTES_PER_ROW (META_BLOCKS_PER_ROW * META_BYTES_PER_BLOCK)
+#define META_ROWS_AROUND_ADDR 2
 
 static unsigned long kasan_flags;
 
@@ -243,7 +243,7 @@ static void print_address_description(void *addr, u8 tag)
 
 static bool row_is_guilty(const void *row, const void *guilty)
 {
-	return (row <= guilty) && (guilty < row + SHADOW_BYTES_PER_ROW);
+	return (row <= guilty) && (guilty < row + META_BYTES_PER_ROW);
 }
 
 static int shadow_pointer_offset(const void *row, const void *shadow)
@@ -252,7 +252,7 @@ static int shadow_pointer_offset(const void *row, const void *shadow)
 	 *    3 + (BITS_PER_LONG/8)*2 chars.
 	 */
 	return 3 + (BITS_PER_LONG/8)*2 + (shadow - row)*2 +
-		(shadow - row) / SHADOW_BYTES_PER_BLOCK + 1;
+		(shadow - row) / META_BYTES_PER_BLOCK + 1;
 }
 
 static void print_memory_metadata(const void *addr)
@@ -262,15 +262,15 @@ static void print_memory_metadata(const void *addr)
 	const void *shadow_row;
 
 	shadow_row = (void *)round_down((unsigned long)shadow,
-					SHADOW_BYTES_PER_ROW)
-		- SHADOW_ROWS_AROUND_ADDR * SHADOW_BYTES_PER_ROW;
+					META_BYTES_PER_ROW)
+		- META_ROWS_AROUND_ADDR * META_BYTES_PER_ROW;
 
 	pr_err("Memory state around the buggy address:\n");
 
-	for (i = -SHADOW_ROWS_AROUND_ADDR; i <= SHADOW_ROWS_AROUND_ADDR; i++) {
+	for (i = -META_ROWS_AROUND_ADDR; i <= META_ROWS_AROUND_ADDR; i++) {
 		const void *kaddr = kasan_shadow_to_mem(shadow_row);
 		char buffer[4 + (BITS_PER_LONG/8)*2];
-		char shadow_buf[SHADOW_BYTES_PER_ROW];
+		char shadow_buf[META_BYTES_PER_ROW];
 
 		snprintf(buffer, sizeof(buffer),
 			(i == 0) ? ">%px: " : " %px: ", kaddr);
@@ -279,17 +279,17 @@ static void print_memory_metadata(const void *addr)
 		 * function, because generic functions may try to
 		 * access kasan mapping for the passed address.
 		 */
-		memcpy(shadow_buf, shadow_row, SHADOW_BYTES_PER_ROW);
+		memcpy(shadow_buf, shadow_row, META_BYTES_PER_ROW);
 		print_hex_dump(KERN_ERR, buffer,
-			DUMP_PREFIX_NONE, SHADOW_BYTES_PER_ROW, 1,
-			shadow_buf, SHADOW_BYTES_PER_ROW, 0);
+			DUMP_PREFIX_NONE, META_BYTES_PER_ROW, 1,
+			shadow_buf, META_BYTES_PER_ROW, 0);
 
 		if (row_is_guilty(shadow_row, shadow))
 			pr_err("%*c\n",
 				shadow_pointer_offset(shadow_row, shadow),
 				'^');
 
-		shadow_row += SHADOW_BYTES_PER_ROW;
+		shadow_row += META_BYTES_PER_ROW;
 	}
 }
 
-- 
2.28.0.220.ged08abb693-goog

