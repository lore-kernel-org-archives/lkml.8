Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B48C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CB12072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pqPZ+KnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgC0RGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:06:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46457 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbgC0RGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:06:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id r7so3324673ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fw/iy6xjbd/Vbu7hIqNLPaVOpy/RK+By1QJ7syGCyKw=;
        b=pqPZ+KnQrKyd6FiKwsInKAWqhn2zXakFKwgrm9nzLBgFus1py3Iu2UO8q6Qx1MQ6+C
         e8Ejg39nuKDg9y06gDkoTBO9VJJ4QW4vH2JXjX9tkq3eYlJN5MzXHZG2HDwpxJaG9oLV
         +1gbfeTURUHlkt1jQlO6qZPrpP5TnwfKGAH1BDJOhJ5qiTlotjonDqsfcZ205isYssHd
         RXb7QKpee++7GHCpH53vyhFQ/Hanp/zRWwJgCSmWLbZy6TW3aAQqvNaZWFb8I4dUEFdF
         PpJCf/z6u1OGEnuXJRcCchYi5/AuZPs+FQk0gQBGH+PnjeWKCzfLhnK7BUUuJkboh7LO
         Ficw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fw/iy6xjbd/Vbu7hIqNLPaVOpy/RK+By1QJ7syGCyKw=;
        b=Sqrx/QwCeGKSniLX9OcNTUfRT2zXA6zHsIWrw1RQK9u0m29/4deNS2G9Z43ALT5CVc
         JpoRffIlmpGj0193PKj5IDslsi3hBF+pgr55et4eicbs99kMjTUnJC9s3h4UPsvy80qw
         YI+F+1+tqL9Uvfyr6tb5cYq2m8hbVpjl5Zbcru8/OtMHgo5qWEHj4hwEOg5jbOZmrXhh
         x22PG8fE4Cxix3e2NGbsZXfpTpsL3md2bu66FCNUT4dYvJwfx9XrE2j8xhTQdLmSnaXR
         jOyGPdgLYmp3gkYrVLWnB8mcO4kBq0100HnLZWQuxeToNfIiCf/y9N8jugORLkPAyDqE
         mN2A==
X-Gm-Message-State: AGi0PubMUhCnYBpn0DtynNqNRqGbXgAo12sHJX4djMVU8e+woDaqSVat
        L/uugrTUcEMjO6KJkp4kK0oLAA==
X-Google-Smtp-Source: ADFU+vvdqlE5S6Ml34ZpWzMm9diRAgh8m5sJC5LUbAaWxqKa8rxqiLVwiLIVGcpzhADb4m0kD666Zg==
X-Received: by 2002:a05:651c:515:: with SMTP id o21mr9232046ljp.91.1585328764152;
        Fri, 27 Mar 2020 10:06:04 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y20sm2967120ljy.100.2020.03.27.10.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 10:06:03 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 62ED8100D27; Fri, 27 Mar 2020 20:06:07 +0300 (+03)
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/7] khugepaged: Do not stop collapse if less than half PTEs are referenced
Date:   Fri, 27 Mar 2020 20:05:56 +0300
Message-Id: <20200327170601.18563-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__collapse_huge_page_swapin() check number of referenced PTE to decide
if the memory range is hot enough to justify swapin.

The problem is that it stops collapse altogether if there's not enough
refereced pages, not only swappingin.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 0db501f7a34c ("mm, thp: convert from optimistic swapin collapsing to conservative")
---
 mm/khugepaged.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 99bab7e4d05b..14d7afc90786 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -905,7 +905,8 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 	/* we only decide to swapin, if there is enough young ptes */
 	if (referenced < HPAGE_PMD_NR/2) {
 		trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
-		return false;
+		/* Do not block collapse, only skip swapping in */
+		return true;
 	}
 	vmf.pte = pte_offset_map(pmd, address);
 	for (; vmf.address < address + HPAGE_PMD_NR*PAGE_SIZE;
-- 
2.26.0

