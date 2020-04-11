Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF17C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 22:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E5E20708
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 22:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX7MafkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgDKWEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 18:04:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50556 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgDKWEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 18:04:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id x25so5902460wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 15:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KKsXg0f3NdD1RgFQXGmR3Fbu1r4vifzR97uuZQ5qjxM=;
        b=KX7MafkC1W+C1oiAguRgAmmQ/8zUrKPK8XaJYVtkuGY17lbmlcE4iAmUjCzZDT4n/o
         2bGqKBG4tHWUW1Sa0yU7by6nwTLUANieKuSHg2cGwaK3IQtfGIJ+Bpp0+abAMVrnJV5N
         idBxWJjRzEtxFcah/mq72O5dOLy++kAoLkKQeLfLYmSk/1bNhu+yJ/arzcob8PU63M6u
         6TquNrmu0HmB5RNuuBfe+jUnfin8pZHZ6vWX7BqCMqEvSWDd7xjtyHQrEq/l28tZAl4q
         m+rxIBjcvVHZV7t/eGvRoCbD603Gz7+baSnBdQu5q3FdcYqrgkxwFfV83KZSozY+btW5
         zVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KKsXg0f3NdD1RgFQXGmR3Fbu1r4vifzR97uuZQ5qjxM=;
        b=q2rGOaU/ZMHFyl2pHWHmn2OI5mhhkkiKdhhvLr8H96ezYqhL6MO9fYf65X8JYVKQ2t
         1jz/8U51+WsixCWELC/CIoAx1f6Fw2K3Uz2Jg5tbkq166k8uXhNBIeE+9cuGsDtVNkK2
         IfFYyDyNtSAkI7Ehf3SVXmoNOhiffCMsQNm7obt93K8MGD5qFYoOgBaiTqMICyto1E5E
         nw9tEkHqUcoEwm29CK5DL417QQJVgsz4jjv95Z5IoBAEwmPYvfElAuo7gD6rttV3DBb8
         VC0omiIH5gyUE6MlMtdwojQ5zmSfYlfWvey4n3luYJbGl9G7TNjl+0b0bauGDjTix9Ot
         yn/g==
X-Gm-Message-State: AGi0PuZpxZ32URu+fHWZK0HK5t36N83p5Glaze4aAdBhM3Q31hUSf64Z
        cEN8lC1nfdnz9xBu47ArQ1M=
X-Google-Smtp-Source: APiQypKDq4zw21MwouB45kwsXuN8oJITstl2Ai6k0dSWqFCNwuWm6Q/U39+UCda6DFzIsZlamMpr7Q==
X-Received: by 2002:a1c:2b06:: with SMTP id r6mr12167201wmr.25.1586642665117;
        Sat, 11 Apr 2020 15:04:25 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a15sm7944996wme.17.2020.04.11.15.04.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Apr 2020 15:04:24 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rientjes@google.com, anshuman.khandual@arm.com, david@redhat.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v3 2/5] mm/page_alloc.c: bad_flags is not necessary for bad_page()
Date:   Sat, 11 Apr 2020 22:03:54 +0000
Message-Id: <20200411220357.9636-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200411220357.9636-1-richard.weiyang@gmail.com>
References: <20200411220357.9636-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 5b57b8f22709 ("mm/debug.c: always print flags in
dump_page()"), page->flags is always printed for a bad page. It is not
necessary to have bad_flags any more.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/page_alloc.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7327dc039069..0648127af872 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -602,8 +602,7 @@ static inline int __maybe_unused bad_range(struct zone *zone, struct page *page)
 }
 #endif
 
-static void bad_page(struct page *page, const char *reason,
-		unsigned long bad_flags)
+static void bad_page(struct page *page, const char *reason)
 {
 	static unsigned long resume;
 	static unsigned long nr_shown;
@@ -632,10 +631,6 @@ static void bad_page(struct page *page, const char *reason,
 	pr_alert("BUG: Bad page state in process %s  pfn:%05lx\n",
 		current->comm, page_to_pfn(page));
 	__dump_page(page, reason);
-	bad_flags &= page->flags;
-	if (bad_flags)
-		pr_alert("bad because of flags: %#lx(%pGp)\n",
-						bad_flags, &bad_flags);
 	dump_page_owner(page);
 
 	print_modules();
@@ -1020,11 +1015,7 @@ static inline bool page_expected_state(struct page *page,
 
 static void free_pages_check_bad(struct page *page)
 {
-	const char *bad_reason;
-	unsigned long bad_flags;
-
-	bad_reason = NULL;
-	bad_flags = 0;
+	const char *bad_reason = NULL;
 
 	if (unlikely(atomic_read(&page->_mapcount) != -1))
 		bad_reason = "nonzero mapcount";
@@ -1032,15 +1023,13 @@ static void free_pages_check_bad(struct page *page)
 		bad_reason = "non-NULL mapping";
 	if (unlikely(page_ref_count(page) != 0))
 		bad_reason = "nonzero _refcount";
-	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_FREE)) {
+	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_FREE))
 		bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
-		bad_flags = PAGE_FLAGS_CHECK_AT_FREE;
-	}
 #ifdef CONFIG_MEMCG
 	if (unlikely(page->mem_cgroup))
 		bad_reason = "page still charged to cgroup";
 #endif
-	bad_page(page, bad_reason, bad_flags);
+	bad_page(page, bad_reason);
 }
 
 static inline int free_pages_check(struct page *page)
@@ -1071,7 +1060,7 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
 	case 1:
 		/* the first tail page: ->mapping may be compound_mapcount() */
 		if (unlikely(compound_mapcount(page))) {
-			bad_page(page, "nonzero compound_mapcount", 0);
+			bad_page(page, "nonzero compound_mapcount");
 			goto out;
 		}
 		break;
@@ -1083,17 +1072,17 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
 		break;
 	default:
 		if (page->mapping != TAIL_MAPPING) {
-			bad_page(page, "corrupted mapping in tail page", 0);
+			bad_page(page, "corrupted mapping in tail page");
 			goto out;
 		}
 		break;
 	}
 	if (unlikely(!PageTail(page))) {
-		bad_page(page, "PageTail not set", 0);
+		bad_page(page, "PageTail not set");
 		goto out;
 	}
 	if (unlikely(compound_head(page) != head_page)) {
-		bad_page(page, "compound_head not consistent", 0);
+		bad_page(page, "compound_head not consistent");
 		goto out;
 	}
 	ret = 0;
@@ -2035,7 +2024,6 @@ static inline void expand(struct zone *zone, struct page *page,
 static void check_new_page_bad(struct page *page)
 {
 	const char *bad_reason = NULL;
-	unsigned long bad_flags = 0;
 
 	if (unlikely(page->flags & __PG_HWPOISON)) {
 		/* Don't complain about hwpoisoned pages */
@@ -2048,15 +2036,13 @@ static void check_new_page_bad(struct page *page)
 		bad_reason = "non-NULL mapping";
 	if (unlikely(page_ref_count(page) != 0))
 		bad_reason = "nonzero _refcount";
-	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_PREP)) {
+	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_PREP))
 		bad_reason = "PAGE_FLAGS_CHECK_AT_PREP flag set";
-		bad_flags = PAGE_FLAGS_CHECK_AT_PREP;
-	}
 #ifdef CONFIG_MEMCG
 	if (unlikely(page->mem_cgroup))
 		bad_reason = "page still charged to cgroup";
 #endif
-	bad_page(page, bad_reason, bad_flags);
+	bad_page(page, bad_reason);
 }
 
 /*
-- 
2.23.0

