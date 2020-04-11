Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC48C2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 22:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A4920708
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 22:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4MHe/3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgDKWEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 18:04:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54443 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgDKWEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 18:04:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id h2so5879044wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 15:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6gEeOq1PpVccr4Ato7Vi1Z7FE4EOOe1QHjHjHnCaqcc=;
        b=c4MHe/3VZ7ToP2vIz7fdoLygs+mLdgRlTe9FV0TZUrGDmeZSSh1eBse+LrunRPTkln
         5U4FTU3E7CRl8hU6Rdj53McU49Jo0NeTBmKaySQ+x3bKxMOQzciz7rsBIm9kBIp3yWOb
         6CgCv/WRdo0sTnT7/NEcHNc6EQE9zxpPawBXSqjoLOmE/2vnuyjLgomsm2VF6Pc3AXfx
         0FwDpAGl0/CzflsTE9JmN6aRrDyylcbbWTe76Nszk2RVBk2pz4Vpd5UKKtw4bRp+PuMa
         CTs+bo99R/SwsNu4XGOvmgg790dEzsuD+vPr8Vj5joBjiLDSmvyDSFMoRVYf8MiidnGP
         UeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6gEeOq1PpVccr4Ato7Vi1Z7FE4EOOe1QHjHjHnCaqcc=;
        b=YDRkiQz4VmYJyHUY5q1R92Kcb/xB5Tt8AA1O8tEtVd9pqxkUfOFEUHnMuixvSouRuM
         dnMcVOuwneXNvw/9sL/OHSS1iDpSIXemyP4XO1wpKRYGQxJ+bCyhkoGosRlP7a+TWLXG
         g/ba80iarKM82aZgc8cEcPwnsb3VPujeB/E8k/FRp90M+DRP/LUMqgsjJ5vmkaRcibNG
         7BgAT5623w+DRCKgIAlsqG3plxqNTISxxgf9DjcctkIDkF85JXF7CfwdSu6qczS8HMLm
         7/nwivmevJ5w3gjuJ12/iNCYUSXemrDmuKEvC1BFCYZTdLarQLAD7XfrsTSYUOJ7xkYz
         m1Dw==
X-Gm-Message-State: AGi0PuaPEX6Z9BCE51zxYGAp5f01T+JZaicIA27C4VxBzR70XFuhR0M4
        0aEqOvkXRiUIzHOY9O0Ynrw=
X-Google-Smtp-Source: APiQypI222TDc/7riljzEcTyOWrUzl0NTTCsUhqcsSQ2EykVwBQyMmHvavDx9bauT0zEG/6MNvtgYA==
X-Received: by 2002:a1c:1b58:: with SMTP id b85mr10962459wmb.112.1586642667887;
        Sat, 11 Apr 2020 15:04:27 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id l26sm305258wrb.7.2020.04.11.15.04.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Apr 2020 15:04:27 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rientjes@google.com, anshuman.khandual@arm.com, david@redhat.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v3 5/5] mm/page_alloc.c: extract check_[new|free]_page_bad() common part to page_bad_reason()
Date:   Sat, 11 Apr 2020 22:03:57 +0000
Message-Id: <20200411220357.9636-6-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200411220357.9636-1-richard.weiyang@gmail.com>
References: <20200411220357.9636-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We share the similar code in check_[new|free]_page_bad() to get the
page's bad reason.

Let's extract it and reduce code duplication.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/page_alloc.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dfcf2682ed40..c12a5a9b79c8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1013,7 +1013,7 @@ static inline bool page_expected_state(struct page *page,
 	return true;
 }
 
-static void check_free_page_bad(struct page *page)
+static const char *page_bad_reason(struct page *page, unsigned long flags)
 {
 	const char *bad_reason = NULL;
 
@@ -1023,13 +1023,23 @@ static void check_free_page_bad(struct page *page)
 		bad_reason = "non-NULL mapping";
 	if (unlikely(page_ref_count(page) != 0))
 		bad_reason = "nonzero _refcount";
-	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_FREE))
-		bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
+	if (unlikely(page->flags & flags)) {
+		if (flags == PAGE_FLAGS_CHECK_AT_PREP)
+			bad_reason = "PAGE_FLAGS_CHECK_AT_PREP flag(s) set";
+		else
+			bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
+	}
 #ifdef CONFIG_MEMCG
 	if (unlikely(page->mem_cgroup))
 		bad_reason = "page still charged to cgroup";
 #endif
-	bad_page(page, bad_reason);
+	return bad_reason;
+}
+
+static void check_free_page_bad(struct page *page)
+{
+	bad_page(page,
+		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_FREE));
 }
 
 static inline int check_free_page(struct page *page)
@@ -2023,26 +2033,14 @@ static inline void expand(struct zone *zone, struct page *page,
 
 static void check_new_page_bad(struct page *page)
 {
-	const char *bad_reason = NULL;
-
 	if (unlikely(page->flags & __PG_HWPOISON)) {
 		/* Don't complain about hwpoisoned pages */
 		page_mapcount_reset(page); /* remove PageBuddy */
 		return;
 	}
-	if (unlikely(atomic_read(&page->_mapcount) != -1))
-		bad_reason = "nonzero mapcount";
-	if (unlikely(page->mapping != NULL))
-		bad_reason = "non-NULL mapping";
-	if (unlikely(page_ref_count(page) != 0))
-		bad_reason = "nonzero _refcount";
-	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_PREP))
-		bad_reason = "PAGE_FLAGS_CHECK_AT_PREP flag set";
-#ifdef CONFIG_MEMCG
-	if (unlikely(page->mem_cgroup))
-		bad_reason = "page still charged to cgroup";
-#endif
-	bad_page(page, bad_reason);
+
+	bad_page(page,
+		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_PREP));
 }
 
 /*
-- 
2.23.0

