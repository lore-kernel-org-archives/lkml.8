Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748A6C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4579E2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWdg7Fuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgCQLtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:49:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43920 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgCQLts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:49:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id f206so810675pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 04:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MMK1oa7caM4FxenuRyA9kQAaY+A0jvSFKtsdxSSnm50=;
        b=eWdg7FuuLGf/HHPeZutN/DYRjxENPqg+VeIJz4NbSKSfjLv6CdrPv1RzaD/qLOir2Q
         o+m1Vv+PqzjYMbFY9kaagOU+qtTyfg4RlKmjpWxxLEPRKSntm60Tq+pfugBkVK2eEDys
         mtrpofcDQ4D2Liywttc4FNG5G4izeWiVb8XhS5nyi1kdMOk+e1jPYs2EsMRyDt6E+gYd
         rsj0ADZq9uqh5L0OQf4YtYG2gg/gxwRktAOLGWNGKhSHWs2XEb/noOsL+84foC2leXf9
         PVLStKZBVq3AdMHy3m6wjUUirFfwqhGtT1BICQOcF9oCrYFb4ncRIXiLzy6UbWZ9jZib
         CCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MMK1oa7caM4FxenuRyA9kQAaY+A0jvSFKtsdxSSnm50=;
        b=UXMaXI8yqWnxxK2QM6WpWj1xJXdYtcXVvzsqGP0uSVzNKqnvKM9R/nQcYLm+qJFwI5
         5MrstPMJ7Xpe2TsTaOLSCMGj3yoFZRlGYDiYVH2X+0LXyoyx+MQc1zS9oh0HBxuEhEfR
         t7WNOQsvTDtdCdKY6U7Qe/w3OpD7PbATdqx2Cs7VnumHvulUiebETYnQrRYbNKQiXsJI
         hmm4lx5kA7LY3LktEhTAjPaZBNpG9qxhbECMX+5D0eATTYTNdqodKNRpuvZUfeYhQUet
         abXdpyK00oUBZ0+P9zRpO9VjYpskRTnqcEZxYGiMrAvOpndV17naKPzX4M4pT2tZVgTc
         yahA==
X-Gm-Message-State: ANhLgQ3xOksSaLs1mel99+R21lxdf81KVBTiIuRIi6j++XwPJFBxWS24
        LIG6JBj672BOydTYVKR2Bw==
X-Google-Smtp-Source: ADFU+vs30UmxxLczix5J155deIGMh7kh1xX+QCQHAyX7Z38r2hTSjuVeqqLeG6kvUoSxB6CfWyEfHg==
X-Received: by 2002:a62:3854:: with SMTP id f81mr4823792pfa.81.1584445787852;
        Tue, 17 Mar 2020 04:49:47 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c62sm2214845pfc.136.2020.03.17.04.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 04:49:47 -0700 (PDT)
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
Subject: [PATCHv7 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in gup fast path
Date:   Tue, 17 Mar 2020 19:47:32 +0800
Message-Id: <1584445652-30064-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1584333244-10480-3-git-send-email-kernelfans@gmail.com>
References: <1584333244-10480-3-git-send-email-kernelfans@gmail.com>
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
v6 -> v7: fix coding style issue
 mm/gup.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 9df77b1..0a536d7 100644
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
+				is_migrate_cma_page(page))
+			return NULL;
+
+		/*
 		 * When pinning a compound page of order > 1 (which is what
 		 * hpage_pincount_available() checks for), use an exact count to
 		 * track it, via hpage_pincount_add/_sub().
--
2.7.5

