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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FE9C54FCF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F54320732
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCgbAm/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgCVLer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:34:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43656 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgCVLer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 07:34:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id u12so5632932pgb.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 04:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/1SM3867y5SxnAk5W+nCWfh5uFmnZCup8fknvMevl8I=;
        b=ZCgbAm/iPixhzfGPOch7scTLnnbNH0Ce/QnnMs3JENoqXF8vBILnIV1dIn7EILxnTk
         /WOGRkxPYmqz+eb7gUU0jx0g3JN8FGy49bJdoGQBqCSMcXdfjO3i04D/V9LGkeJCqUZo
         HR4ISjeBbOCKuX9PYVLMInFsw7kMt4iiHEy/MMyi5n3uOlYSsTlnEhnhkI2p6iyLpeD1
         k6zkgSjySq8VK3DAd2P7+Q+HwhzrhwqE1eDX1Unf32kwsA++x/a9IizdDHpyMBje1kc1
         cv5Xhub/coe6nHFJOa7R2yacoJlYTd3Ac/BbvT7UZbPZ/FSPEUEZv3nxM0ZffXwy6APt
         UeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/1SM3867y5SxnAk5W+nCWfh5uFmnZCup8fknvMevl8I=;
        b=SfSaxhk5OBheCFb/UundaeCgK/2zm2icJZjjaPxglT5pTk26cVM224aZSo7AI4nLfm
         swKWSC5nOZfV5EZMLRFwIX9VInPSzcJd+hVvvZtpWExsVkuDlcknYNJX5hi+Yi6XPOhD
         HDthV8SEO3Zsrp7y5+HEcGvRljus7qq3Th4JudNvuPHtWIVRrCXOiM2Uu3+jTa4n/tnv
         C+j30dtFnTRK15C+BhKBLOorbaze/xRCkuQdJOZY0Nhi3Knt6sjmoO9mHhuqr4LFYeNW
         3FV3xcGKr+c4DH/x8LovyVzIoksSgoCGWDi2NFK23gzSP6smNwkaIv5ZokndK0vKGvlw
         qhtg==
X-Gm-Message-State: ANhLgQ2wHcdAMhLgpARzv91OleJYhQPAEFhJopUjB6fVg0rDG0jiSmAV
        YUpL2VSnpXqN+W+FngEWjw==
X-Google-Smtp-Source: ADFU+vt2Orqn/hOvqJdCrhDZmh7HfFtpy6+z9jOFDkLUvT9xMsriKqGJktpP2gjGP7sprCZLp7doWQ==
X-Received: by 2002:aa7:8bda:: with SMTP id s26mr18467747pfd.142.1584876886209;
        Sun, 22 Mar 2020 04:34:46 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i23sm10474445pfq.157.2020.03.22.04.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 04:34:45 -0700 (PDT)
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
        Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv8 2/2] mm/gup: fix omission of check on FOLL_LONGTERM in gup fast path
Date:   Sun, 22 Mar 2020 19:32:13 +0800
Message-Id: <1584876733-17405-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1584876733-17405-1-git-send-email-kernelfans@gmail.com>
References: <1584876733-17405-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FOLL_LONGTERM is a special case of FOLL_PIN. It suggests a pin which is
going to be given to hardware and can't move. It would truncate CMA
permanently and should be excluded.

In gup slow path, where
__gup_longterm_locked->check_and_migrate_cma_pages() handles FOLL_LONGTERM,
but in fast path, there lacks such a check, which means a possible leak of
CMA page to longterm pinned.

Place a check in try_grab_compound_head() in the fast path to fix the leak,
and if FOLL_LONGTERM happens on CMA, it will fall back to slow path to
migrate the page.

Some note about the check:
Huge page's subpages have the same migrate type due to either
allocation from a free_list[] or alloc_contig_range() with param
MIGRATE_MOVABLE. So it is enough to check on a single subpage
by is_migrate_cma_page(subpage)

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/gup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 02a95b1..3fe75c4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -89,6 +89,14 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
 		int orig_refs = refs;

 		/*
+		 * Can't do FOLL_LONGTERM + FOLL_PIN with CMA in the gup fast
+		 * path, so fail and let the caller fall back to the slow path.
+		 */
+		if (unlikely(flags & FOLL_LONGTERM) &&
+				is_migrate_cma_page(page))
+			return NULL;
+
+		/*
 		 * When pinning a compound page of order > 1 (which is what
 		 * hpage_pincount_available() checks for), use an exact count to
 		 * track it, via hpage_pincount_add/_sub().
--
2.7.5

