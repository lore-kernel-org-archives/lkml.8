Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53571C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C192074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKv1U083"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbgG3Tum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:50:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46824 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726857AbgG3Tui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596138636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WMx7rPC6Q+HnvqrAYe3ZZeavv1fx9j7NHfsvFzSl1ik=;
        b=KKv1U083QraWsYeGNgC7y1kzIH74SRlb3Q7pDB1Pag8NtYRsbkbtzGHCYR+OtCdpq70AdK
        TaFF5kAGEI/hKrqxFJzVRwV6cygoFRnf/3zmxTW5PVwCxP+EEdsrNo8h/XhFgjzscMeHkh
        CVb2v+rArr+WqgXn4FeELjdbk2Znnhc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-zvzfjPoqNTShaojMDsuBZw-1; Thu, 30 Jul 2020 15:50:34 -0400
X-MC-Unique: zvzfjPoqNTShaojMDsuBZw-1
Received: by mail-qt1-f199.google.com with SMTP id n12so1377477qtr.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 12:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMx7rPC6Q+HnvqrAYe3ZZeavv1fx9j7NHfsvFzSl1ik=;
        b=izfetlIh0dxUxFSusKqs796ejOhLLdpa8ypMO5pnGEIivaC4BLkskcy4/WlWy8vJsy
         k1Z/5DMwPmIFZRri5qB2u987QKyvYng6vzXPMzWBkcxLJ+vMFyKIr8z8+GqNd41k+kGL
         A4OPNHJrWSs7NtbkJM825c6tr/T5E4N1fLVTfctEYT3Pb/JM55qt37mw9237elfwE03v
         YjtQLIUY+nT0xcaCD9o1eqaYnQpxFTo9+LvFUZEB23LOABj8Vui1btDU9fsAGE5+K7pD
         USYSzL+6jLzFiUwzwoebM2VQ4gJOUPBCO15St/M6jfolQdoyiYsi2Ey5VFCF5IY+DHHH
         EleQ==
X-Gm-Message-State: AOAM53188t4ylNu4cEc5sgS4kJ+v5gbvmY0KsJYBWS4HKIqY0GoClJcU
        rt8zPskbrZ5etijN1jULjEQd82vqZ32FXH6VzJmz4DUSOgiXUGfq7l+VzLZa0LU5YBoRxomxgf0
        KG/BYXlWBnp2T25/e7UUOg/XD
X-Received: by 2002:a05:620a:573:: with SMTP id p19mr829848qkp.197.1596138634205;
        Thu, 30 Jul 2020 12:50:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyes+QHXjYkXCVg4jtAK40KsI6a3DwfH2MyEjQS3M3oruwBTsCvIRuU+0/MvlglvFpChKuocA==
X-Received: by 2002:a05:620a:573:: with SMTP id p19mr829825qkp.197.1596138633915;
        Thu, 30 Jul 2020 12:50:33 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c8:6f::1f4f])
        by smtp.gmail.com with ESMTPSA id b131sm5024856qkc.121.2020.07.30.12.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 12:50:32 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] mm/hugetlb: Fix calculation of adjust_range_if_pmd_sharing_possible
Date:   Thu, 30 Jul 2020 15:50:30 -0400
Message-Id: <20200730195030.60616-1-peterx@redhat.com>
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
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4645f1441d32..0e5a0512c13c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -43,6 +43,9 @@
 #include <linux/page_owner.h>
 #include "internal.h"
 
+#define MAX(a,b)  (((a)>(b))?(a):(b))
+#define MIN(a,b)  (((a)<(b))?(a):(b))
+
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
 struct hstate hstates[HUGE_MAX_HSTATE];
@@ -5321,25 +5324,21 @@ static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
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
+	*start = MAX(vma->vm_start, a_start);
+	*end = MIN(vma->vm_end, a_end);
 }
 
 /*
-- 
2.26.2

