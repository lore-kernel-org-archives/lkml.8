Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F56C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 04:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696112071C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 04:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY78JmHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgCPEgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 00:36:38 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:32777 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgCPEgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 00:36:37 -0400
Received: by mail-pj1-f66.google.com with SMTP id dw20so3577090pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 21:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fsI1XEPfE/anfkLEVKGW8+YR1eBwmOuLro1LuQ5D+DY=;
        b=lY78JmHvz9cs070waBtw18dVt/JAt1JesCwcF86+QyxzR24E+YBrxUXkR/AK2qLJvP
         Gly4wGAIMmEX/DPr0ss4mghlm9pEQY8aQ7XLR3FpBNBXTvMk9LEh82wdwpP60IezSkiQ
         ozO2Z3LJzup6BX1xKCI70IFlsuQvq9xPgppJT6iSjQ0nAiFiVSwYzYTJBw/9gZvxLu/a
         C4HKd3s/riXihuFhxygEj2EIvgheh8XnlIVEDpDp3AbucwuOkJAJGfrPft0hUdqcHWHc
         nT07koP4VVT3QRn85cIOLvVQiAyUkrF4rb2LNMeTXeksIQSA4N8AqXkbD0wRXseQWYXn
         kddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fsI1XEPfE/anfkLEVKGW8+YR1eBwmOuLro1LuQ5D+DY=;
        b=i9lSaKdURhYpfCTDMA67TzBf8HOn5EWO1yr82qORcoLFUSvZc8tg6afxbtUCJD6Zef
         8YwaW2x3pA2BCAHvsBTUNxwaXla1eHoBzaF/L+4Y9dQFFXIHkCaFcr+/aD6hD63RnEtL
         dAzXOAxsGgvkmpz2ILCgMTwwY8UxXW74DeKA4auYG7mgfPo97B3wDmtUBLXaOnuUq6XN
         v3xJDhs3ysybMb2tY2ea5HINbYB1hhQQI8FTThCWBw/LUUHNdzEJ7BBEYaZ9kuzBqjxM
         /zaAtxBfeOLBfNlTVcEWuzQSQleW1VpfA9qqYhhV/jNF5i4SHB6J0m+qB5/Ks1VtdFCx
         Zp9A==
X-Gm-Message-State: ANhLgQ2u9JR9rjS9dXv7Da76fIFlbp7Vzul4fg1lrH8q7lQNGu3zbjoY
        0KRR5c6ChsD6OZcmMchJYA==
X-Google-Smtp-Source: ADFU+vulhz01sa+o+LgPj7GJ2sEvA2tjhDbL8mGwGMZalaeaW7dwYM8zUJLj3g0jTqZYwlIjEohU0Q==
X-Received: by 2002:a17:90a:2:: with SMTP id 2mr23785492pja.16.1584333396201;
        Sun, 15 Mar 2020 21:36:36 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d6sm18544296pjz.39.2020.03.15.21.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 21:36:35 -0700 (PDT)
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
Subject: [PATCHv6 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in gup fast path
Date:   Mon, 16 Mar 2020 12:34:03 +0800
Message-Id: <1584333244-10480-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1584333244-10480-1-git-send-email-kernelfans@gmail.com>
References: <1584333244-10480-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FOLL_LONGTERM is a special case of FOLL_PIN. It suggests a pin which is
going to be given to hardware and can't move. It would truncate CMA
permanently and should be excluded.

In gup slow path, slow path, where
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
 mm/gup.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 9df77b1..78132cf 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -89,6 +89,15 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
 		int orig_refs = refs;

 		/*
+		 * Huge page's subpages have the same migrate type due to either
+		 * allocation from a free_list[] or alloc_contig_range() with
+		 * param MIGRATE_MOVABLE. So it is enough to check on a subpage.
+		 */
+		if (unlikely(flags & FOLL_LONGTERM) &&
+			is_migrate_cma_page(page))
+			return NULL;
+
+		/*
 		 * When pinning a compound page of order > 1 (which is what
 		 * hpage_pincount_available() checks for), use an exact count to
 		 * track it, via hpage_pincount_add/_sub().
--
2.7.5

