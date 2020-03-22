Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56F9C54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7566A20719
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B09uNYE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCVLel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:34:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34128 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgCVLek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 07:34:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id a23so4634682plm.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 04:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xWoNlFcF04oMTTvMbHBq5MIT/9eTXh290wY6htrAIuI=;
        b=B09uNYE3YLv9AUjIpSkhK9RLo1vpui/8HJtBFrQRwJytPlHEfd+gH9dEuhggII+Iew
         FtfkGoevnyc3b/xFGOIfHowiEK/PkSuEylcdNlvBkgjwwpWKnFiP09E/H43f9M0/HmCE
         2E92oKmD/v5FmM+jfbsdvdbDp7d8gTGtpD+oxRHvWBfCS4re2l8TkuDksKLaPz4XelZ8
         zbL00C3XSyROMjSTUPc1c3yzfGzxZCbsuldi58WuwreDsJljc44YZrqCpN2fVqSpKHcV
         8FXS3M7hHYvdqoWec6ZiVyVCULlpZR36AIp4DFnq3++gCRVtu4ALtVbn+enIGEQlUbV2
         XS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xWoNlFcF04oMTTvMbHBq5MIT/9eTXh290wY6htrAIuI=;
        b=C8AdzqZnjaaxvo6PcCWRa6XPJlzX06WHey4FT9FW9Qdek4RgNwFG6QTqhhVMCG+HE5
         fc46ECrWawOZUm2YSG85yH9qkXzXyKGLg83SmLAgPYFpkemqrRbYvP2xbxF0qe1Snf0G
         91Txv0Cmjo8r+QWkcsxzhziDDCuISdYWkH9BkAAx6XFcx83WrWGoWdgUJULASLnhFW2T
         K9Bfq3D/tQlfchdYMxv2wzVSHlEyqugiEi+hDS74VHG6ZANl8R6gtvOH+PGVlVL7BymJ
         j4S1H2PUMq3LsBFRvqRatZi6bQQvRh1F98scy/6RyQ+Y7umCqPbuxL02MUpLCK/6KywK
         yvPg==
X-Gm-Message-State: ANhLgQ1TZ2OUgfIPSOSeq372h2/m/FQbqIp+jyqv9LwrOPnnchOpHx7G
        BC/ZiqdwU5kAIJw4f95bIA==
X-Google-Smtp-Source: ADFU+vuBbHVBMZ9Vibcd72WJpS7tH/vUS4fAO297iYtCc/GotCgFfnIIeUnW/cf7GDw8qlaRmAyAbg==
X-Received: by 2002:a17:902:6acc:: with SMTP id i12mr16839795plt.87.1584876880017;
        Sun, 22 Mar 2020 04:34:40 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i23sm10474445pfq.157.2020.03.22.04.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 04:34:39 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv8 1/2] mm/gup: rename nr as nr_pinned in get_user_pages_fast()
Date:   Sun, 22 Mar 2020 19:32:12 +0800
Message-Id: <1584876733-17405-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1584876733-17405-1-git-send-email-kernelfans@gmail.com>
References: <1584876733-17405-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To better reflect the held state of pages and make code self-explaining,
rename nr as nr_pinned.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/gup.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index e8aaa40..02a95b1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2665,7 +2665,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 {
 	unsigned long len, end;
 	unsigned long flags;
-	int nr = 0;
+	int nr_pinned = 0;
 	/*
 	 * Internally (within mm/gup.c), gup fast variants must set FOLL_GET,
 	 * because gup fast is always a "pin with a +1 page refcount" request.
@@ -2699,11 +2699,11 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
 	    gup_fast_permitted(start, end)) {
 		local_irq_save(flags);
-		gup_pgd_range(start, end, gup_flags, pages, &nr);
+		gup_pgd_range(start, end, gup_flags, pages, &nr_pinned);
 		local_irq_restore(flags);
 	}

-	return nr;
+	return nr_pinned;
 }
 EXPORT_SYMBOL_GPL(__get_user_pages_fast);

@@ -2735,7 +2735,7 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
 					struct page **pages)
 {
 	unsigned long addr, len, end;
-	int nr = 0, ret = 0;
+	int nr_pinned = 0, ret = 0;

 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
 				       FOLL_FORCE | FOLL_PIN | FOLL_GET)))
@@ -2754,25 +2754,25 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
 	    gup_fast_permitted(start, end)) {
 		local_irq_disable();
-		gup_pgd_range(addr, end, gup_flags, pages, &nr);
+		gup_pgd_range(addr, end, gup_flags, pages, &nr_pinned);
 		local_irq_enable();
-		ret = nr;
+		ret = nr_pinned;
 	}

-	if (nr < nr_pages) {
+	if (nr_pinned < nr_pages) {
 		/* Try to get the remaining pages with get_user_pages */
-		start += nr << PAGE_SHIFT;
-		pages += nr;
+		start += nr_pinned << PAGE_SHIFT;
+		pages += nr_pinned;

-		ret = __gup_longterm_unlocked(start, nr_pages - nr,
+		ret = __gup_longterm_unlocked(start, nr_pages - nr_pinned,
 					      gup_flags, pages);

 		/* Have to be a bit careful with return values */
-		if (nr > 0) {
+		if (nr_pinned > 0) {
 			if (ret < 0)
-				ret = nr;
+				ret = nr_pinned;
 			else
-				ret += nr;
+				ret += nr_pinned;
 		}
 	}

--
2.7.5

