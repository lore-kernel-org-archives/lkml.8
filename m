Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA202C3404C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB682173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgBRV0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:26:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36435 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRV0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:26:45 -0500
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1j4AOA-0005MN-Ue
        for linux-kernel@vger.kernel.org; Tue, 18 Feb 2020 21:26:43 +0000
Received: by mail-qt1-f200.google.com with SMTP id p12so14022328qtu.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 13:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sy0OONV+lwoKLJ/Vpr24RewxD28TW9ngrjf5cwwzJIE=;
        b=N51yFJHSWr8xPaY6FL32rwsVYnkzB8VMG2LuupBNP58AovaZLO5AiONAeve+0AoxDB
         uqw8bZu1zH++Jaq0VppM1TTqqvqW08WHfsZGTA3WlqkLEd8h27jmpcqotSXi3C+CNIrW
         5EuS0+X5LbrQLtk3USHnkmuXUFC+C2HFNTHz/iRahIGKairwZsBhV26VH6ckpl1lTrux
         XzVbmMVbfGL3mZuISPDEMiPDmVVF+hw1yGiKt8/+/zMlbjL8yZaDHTW1j1/y3l0nRMJd
         N9ooYiuWZoq70RVO/wWDgQK5ADrGGfFxO+kny/7VmVrpHJlhy7CFfRCGbc0BkuM+0DzL
         Pz5w==
X-Gm-Message-State: APjAAAUR1cnQ1E/6lnSjyWYfqrJIRQmtJnV4XN6nhOp715/vkYfHR1OM
        H+h+evq8nyW7B187V0z+D+RN8OSadbGG1q350aqR5M3pQlss+wBSkwb2uXcei73Ak3g68sfTxZV
        DWsMrreVwqoQfH7myU15puL3mhh5eqmJSWV/2xtM45w==
X-Received: by 2002:ac8:4505:: with SMTP id q5mr18708852qtn.84.1582061201914;
        Tue, 18 Feb 2020 13:26:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+TaT9y6P8ixH2MNfJhuKsalJDR9ST/x8ltT0emlDJcX9QXw6UvzlTIzwxglEbuc2fWwPikw==
X-Received: by 2002:ac8:4505:: with SMTP id q5mr18708838qtn.84.1582061201661;
        Tue, 18 Feb 2020 13:26:41 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:4e7:1017:1c35:828a:99a9:563b])
        by smtp.gmail.com with ESMTPSA id j127sm2162814qkc.36.2020.02.18.13.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 13:26:41 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page-writeback.c: write_cache_pages(): deduplicate identical checks
Date:   Tue, 18 Feb 2020 18:26:37 -0300
Message-Id: <20200218212637.28101-1-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There used to be a 'retry' label in between the two (identical) checks
when first introduced in commit f446daaea9d4 ("mm: implement writeback
livelock avoidance using page tagging"), and later modified/updated in
commit 6e6938b6d313 ("writeback: introduce .tagged_writepages for the
WB_SYNC_NONE sync stage").

The label has been removed in commit 64081362e8ff ("mm/page-writeback.c:
fix range_cyclic writeback vs writepages deadlock"), and the (identical)
checks are now present / performed immediately one after another.

So, remove/deduplicate the latter check, moving tag_pages_for_writeback()
into the former check before the 'tag' variable assignment, so it's clear
that it's not used in this (similarly-named) function call but only later
in pagevec_lookup_range_tag().

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 mm/page-writeback.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2caf780a42e7..86c18112b89b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2183,11 +2183,10 @@ int write_cache_pages(struct address_space *mapping,
 			range_whole = 1;
 	}
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag_pages_for_writeback(mapping, index, end);
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
 		tag = PAGECACHE_TAG_DIRTY;
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag_pages_for_writeback(mapping, index, end);
 	done_index = index;
 	while (!done && (index <= end)) {
 		int i;
-- 
2.20.1

