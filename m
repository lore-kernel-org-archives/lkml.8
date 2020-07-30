Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C53DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13EAC2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1OmAyY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgG3USw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:18:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50740 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730292AbgG3USv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 16:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596140329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ttU5uAAhY3HGRL5B63vP+4WTx40yg58X5zhf6Gj27MI=;
        b=M1OmAyY7+bwkJyVWl3sCca9wxSQm+exLv/OCyeie46gHdRd88E26acfF8pRPkwdgFM7c2w
        T9gKxKMvLmg+97/Md7ozGRWEvPx3rRutwpQXhs6tir4rvROSbNDoA07EosDIFAE2wIJLJM
        uEMEV8/VvkBr8m3+dsHZQ8KFXTM81LY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-gxi_RBGIN0OB-fYr-82d9g-1; Thu, 30 Jul 2020 16:16:45 -0400
X-MC-Unique: gxi_RBGIN0OB-fYr-82d9g-1
Received: by mail-qv1-f72.google.com with SMTP id em19so18861048qvb.14
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ttU5uAAhY3HGRL5B63vP+4WTx40yg58X5zhf6Gj27MI=;
        b=dZK+XQC5ZrdTvA9mj6JzfTnVKTDalB49jzBeH2ebj5ggwywDm58RiG7BmHRjcEao1p
         Tc1EWa87lLa6BLJQzhWLNTbn4qoeiMulvS4isJWzeQQYaLeKleMAwFsvg6Okq3MTbAwH
         MAOJkidu2SdKCw3t5kdofhR1A2QSjTTFWIyj0KCllrRUmAmU/Nv+tveyUGfBEQzHrx8f
         N8TrN2Vr0E5eQGmIUa6fZBU27/ttaRJnwVOXkzGCUD0Ab1+GxmKhvyBvvxOJA8beJNqH
         8Yi6YqvKF14lXezUu8evEYBt9AGe5ijd9iOnch30Gplk91o6PBWlKfmemIg50U0xEQiT
         lZNw==
X-Gm-Message-State: AOAM5321msWn3cNZ7M9yR3cQu5OZqtp4V9V8+rblVJJF2xJIpcnvHVU/
        Ed57YjsulKcfNgL5IpDn4N643OlzVAFPLg9hIbVcFelHSz82kR9C1ayPiXBH9XQznNa/xI0iInU
        5TO8y5DAhVGZY6WWQqfQhsDC2
X-Received: by 2002:a05:620a:a0b:: with SMTP id i11mr953409qka.65.1596140204983;
        Thu, 30 Jul 2020 13:16:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwS5S1YYqldENDBc9IEA0TEWQRt2YRRMBYg+XfTBgMZ9gO74s9sb273Po3hSKL1hwALDfOwA==
X-Received: by 2002:a05:620a:a0b:: with SMTP id i11mr953392qka.65.1596140204749;
        Thu, 30 Jul 2020 13:16:44 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c8:6f::1f4f])
        by smtp.gmail.com with ESMTPSA id t93sm5425890qtd.97.2020.07.30.13.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 13:16:43 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] mm/hugetlb: Fix calculation of adjust_range_if_pmd_sharing_possible
Date:   Thu, 30 Jul 2020 16:16:36 -0400
Message-Id: <20200730201636.74778-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is found by code observation only.

Firstly, the worst case scenario should assume the whole range was covered by
pmd sharing.  The old algorithm might not work as expected for ranges
like (1g-2m, 1g+2m), where the adjusted range should be (0, 1g+2m) but the
expected range should be (0, 2g).

Since at it, remove the loop since it should not be required.  With that, the
new code should be faster too when the invalidating range is huge.

CC: Andrea Arcangeli <aarcange@redhat.com>
CC: Mike Kravetz <mike.kravetz@oracle.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Matthew Wilcox <willy@infradead.org>
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- use min/max instead of custom MIN/MAX [Matthew]
---
 mm/hugetlb.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4645f1441d32..7332f3c4b8ec 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5321,25 +5321,21 @@ static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end)
 {
-	unsigned long check_addr;
+	unsigned long a_start, a_end;
 
 	if (!(vma->vm_flags & VM_MAYSHARE))
 		return;
 
-	for (check_addr = *start; check_addr < *end; check_addr += PUD_SIZE) {
-		unsigned long a_start = check_addr & PUD_MASK;
-		unsigned long a_end = a_start + PUD_SIZE;
+	/* Extend the range to be PUD aligned for a worst case scenario */
+	a_start = ALIGN_DOWN(*start, PUD_SIZE);
+	a_end = ALIGN(*end, PUD_SIZE);
 
-		/*
-		 * If sharing is possible, adjust start/end if necessary.
-		 */
-		if (range_in_vma(vma, a_start, a_end)) {
-			if (a_start < *start)
-				*start = a_start;
-			if (a_end > *end)
-				*end = a_end;
-		}
-	}
+	/*
+	 * Intersect the range with the vma range, since pmd sharing won't be
+	 * across vma after all
+	 */
+	*start = max(vma->vm_start, a_start);
+	*end = min(vma->vm_end, a_end);
 }
 
 /*
-- 
2.26.2

