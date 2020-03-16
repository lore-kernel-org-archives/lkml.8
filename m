Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0BAC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 04:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0FC20719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 04:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgMs7KE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgCPEgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 00:36:33 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40623 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgCPEgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 00:36:33 -0400
Received: by mail-pj1-f67.google.com with SMTP id bo3so6489701pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 21:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j66a3s2vP+w20zjNn6qkww1MfEJEICNJLq9xqeevnk8=;
        b=GgMs7KE+x7u8c2D1GUcSwQOaBOyBlSMcZh5+Zn/Cql877d/Xa4BZnVC74rImQcQiza
         Pjnrm00Yp6zqwWC3w2/H1a0x2TlmcFf6UZI5ojLNAK2eP9KZZRMpTOtr5OMS+LI/DD0F
         Fbl+zMVmgP1Xq/QUOsChOQ09GEFcvynpnHOfFBjXpt7Ou38fRLiO6IPtSBF+3R0W2lJG
         KOxjEbXfq8L92hrL0DGarzOrB2FewqwrgURQDjTMF8EIo/L186+MMzbRmWVVF5ShYPT8
         8r+fvm8XYIPuIHf6lrJQnrh/ODW7LBhBISWzabqdzXHnZhnvh37WMl+J1YB9lEGqYheY
         ox+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j66a3s2vP+w20zjNn6qkww1MfEJEICNJLq9xqeevnk8=;
        b=eTLj8xReAFX9XYCpX2nTirefJpoPCkAfvEATRnnM/E91784yHNDMrwg1BdVGJRnwgi
         3kS26TcHkphe860+2Kw6Y1/N8wxBkxRMtggyl+z9/Ydy8BGog4O4OkTByAkrheb27bJO
         JtoSlo7BP9DtxvQ+qNMqeyify2duOPK6B55y65Oyye/kayAj2rCosvorWO100MSZY8if
         67xMq188y5PiDk/OyRlCSj5qLkjV3bTz8v7nuCFHZoNpa8CRX2NfPgmHPk6FHs/yCQe6
         djr4qIG5zd6ItKOZ/c0SRLg0OYRYxaYC+MLxPY1c+O0krhbNP/sA1wI/hUotU/Saej6I
         vM4Q==
X-Gm-Message-State: ANhLgQ2UbGbET/JmTlBaNBtNJDmVvZp0XuTP9cOSb7Ve127WDstZq1Uz
        7KvHRwrBOAHZqERPoYIIDQ==
X-Google-Smtp-Source: ADFU+vvGDBK8fWBoL3X1P0FaYHUxoUZzuCudaoA1ladHgo5FilHiD0ikM2kIDkWllOEGq+RSBlKZ+Q==
X-Received: by 2002:a17:902:ab95:: with SMTP id f21mr22712206plr.188.1584333390348;
        Sun, 15 Mar 2020 21:36:30 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d6sm18544296pjz.39.2020.03.15.21.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 21:36:29 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCHv6 1/3] mm/gup: rename nr as nr_pinned in get_user_pages_fast()
Date:   Mon, 16 Mar 2020 12:34:02 +0800
Message-Id: <1584333244-10480-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1584333244-10480-1-git-send-email-kernelfans@gmail.com>
References: <1584333244-10480-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To better reflect the held state of pages and make code self-explaining,
rename nr as nr_pinned.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/gup.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index e8aaa40..9df77b1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
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

