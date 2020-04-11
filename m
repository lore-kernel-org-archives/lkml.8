Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E06FC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 22:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7B920769
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 22:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdudLdLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgDKWE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 18:04:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43415 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgDKWE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 18:04:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id i10so6161963wrv.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 15:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zI3tJmo+o+GXkNWorcFoXLz8vYcrcpDEFf4n0oB8dNo=;
        b=rdudLdLt+Nawf50OHLaGEZbuSLmsPXhfz7lk7AKWyU+MhDQEl+Y34nrbTY91Xft7O7
         huTPmx4+3g4uAr1AZdQCTU6SAc3HlxQYB6/wuyehgG7lg59f2me4HHh/kMcNo8HZmWFh
         7+wtHc9/sjpH9wPhXW80/8CVbvj+spUhdNnjLDDUtpAJ1t3IDWaRiWXYbaI165tE2aYt
         9xT4we8RjKhbxzq5yNXiVAgGctE1AjiHpa+Dgo46he3PWO/te3c9+OSjoCLjSeObcgTe
         +LVKowsccr2I6H95b+3EnG5w7+7s1Ot5MPMnNqeEWAfDGx/7uRucaksMVGK+qkOcrEPw
         UDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zI3tJmo+o+GXkNWorcFoXLz8vYcrcpDEFf4n0oB8dNo=;
        b=hp5eWlHvwEEJ/rzheEaZmGD9SAy9Se5s39CaJyIgAYrquxfpEKeZiw+zmzL25MD2Dz
         juMmwZNFprbrf8XjrvP3MJtAqOmp8zlhnK/E0eOd9pD32BoRd2ieEzagr5V2fRrzucPV
         rt/RAakM2LSwO4VTLGUIPYD/dm2t9gCSXgKvMHg/D4PGZDDdJ3utvYLhNhU2hQXpWJ2U
         7mYkon7Gf1ViPenRSuBJjhjK6mfDTSivz+EtuSOdulXF1ela/nBo7IIW/ELgaWiqceJz
         rP12+rrHlAv91uqxA12+SGb3v3pZv4ERhEELeaD18z3pw1S00R9I95i+0+RxyXWmzBSE
         zYtA==
X-Gm-Message-State: AGi0PuYKuD4iq/mBMcP36Z3lpk66RcDHdmU8VzLUP+YUA//B4GJPflGw
        YpJ9JdNxXHjkro0oIGw3eIScget6vUQ=
X-Google-Smtp-Source: APiQypJzdDa9QVHQo9kjB6Ga1pafDzWMGvrAsY+GfYzFLV0mb7eFmzRw19RNwSps0T8fxOPOM+LKMA==
X-Received: by 2002:a5d:66c4:: with SMTP id k4mr12151090wrw.53.1586642667016;
        Sat, 11 Apr 2020 15:04:27 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id z18sm2342424wrw.41.2020.04.11.15.04.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Apr 2020 15:04:26 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rientjes@google.com, anshuman.khandual@arm.com, david@redhat.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v3 4/5] mm/page_alloc.c: rename free_pages_check() to check_free_page()
Date:   Sat, 11 Apr 2020 22:03:56 +0000
Message-Id: <20200411220357.9636-5-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200411220357.9636-1-richard.weiyang@gmail.com>
References: <20200411220357.9636-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function free_pages_check() is the counterpart of check_new_page().
Rename it to use the same name convention.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/page_alloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 85d7aec5fb45..dfcf2682ed40 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1032,7 +1032,7 @@ static void check_free_page_bad(struct page *page)
 	bad_page(page, bad_reason);
 }
 
-static inline int free_pages_check(struct page *page)
+static inline int check_free_page(struct page *page)
 {
 	if (likely(page_expected_state(page, PAGE_FLAGS_CHECK_AT_FREE)))
 		return 0;
@@ -1124,7 +1124,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		for (i = 1; i < (1 << order); i++) {
 			if (compound)
 				bad += free_tail_pages_check(page, page + i);
-			if (unlikely(free_pages_check(page + i))) {
+			if (unlikely(check_free_page(page + i))) {
 				bad++;
 				continue;
 			}
@@ -1136,7 +1136,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	if (memcg_kmem_enabled() && PageKmemcg(page))
 		__memcg_kmem_uncharge(page, order);
 	if (check_free)
-		bad += free_pages_check(page);
+		bad += check_free_page(page);
 	if (bad)
 		return false;
 
@@ -1183,7 +1183,7 @@ static bool free_pcp_prepare(struct page *page)
 static bool bulkfree_pcp_prepare(struct page *page)
 {
 	if (debug_pagealloc_enabled_static())
-		return free_pages_check(page);
+		return check_free_page(page);
 	else
 		return false;
 }
@@ -1204,7 +1204,7 @@ static bool free_pcp_prepare(struct page *page)
 
 static bool bulkfree_pcp_prepare(struct page *page)
 {
-	return free_pages_check(page);
+	return check_free_page(page);
 }
 #endif /* CONFIG_DEBUG_VM */
 
-- 
2.23.0

