Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C492C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF8C21744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLRvIBPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbgGaMVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732980AbgGaMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:21:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D924C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh1so4124818plb.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pS0WhU6WE8IYcQCnD1IwwP5QRHOYUjKqdATKfccEtHE=;
        b=MLRvIBPy5vqHYOrJlKbuO+hv+7xtTvwRappzGjqJukqCM0eBVWt6DsxRLnwWNYS5GL
         5l3SSvwdz0LgMaCUAnjg0HOQl2EbBMFmBqPs9VD4JhVaTcCpyUu6SWbyfMW8aBKwIjYe
         v+b0EZVomIUg7AsgLIBernDe2VaddoZoE1KSwBautGPyYU6Eio8RVl8oRLk6Wtm3F5Al
         pv8zQRFG78hNGhNre4/0LDEP1L8XUlHvPh9xaCOcQ7NQ2T1oOFvf00XoE5bljF50yW86
         vYj5A4tYt4RYzkhRPFdDj7mzY5crKu9AqqqFmTeK9hUhyxB6SOubKzz7kNsvgRznFFBQ
         HxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pS0WhU6WE8IYcQCnD1IwwP5QRHOYUjKqdATKfccEtHE=;
        b=RHE2se4E9vfta5fJMKzdRVIXFGh8yuaQT49HEFX1t1W9hhJCJ5fvWeww21udcNIm6M
         WzV93FcT6RBXQM902LERSK7SfEQwOaBPMi5sSOsrSjuHxvTJUnFdipmTe1Q3w+yz4ryJ
         EZ1RN4CWz5iEGgzf+y3ktks3dxgdeg330Uk78HWoy4/KByMyGjOuAVlnQO1ij8G3Kl5q
         VC++cohNdQx/e+l8ZRpqlc9TvM9eVNm2K6wWR3SvXWHdM/fMrNysUVo/S27f10Cft+3X
         1oZ2R+EFLjJqSt4PO9vggLvjKOehdXBj1RHVLcEXCFWcCO8JPNisCi8PO9beoWu54KMK
         EUZA==
X-Gm-Message-State: AOAM530eew2bm9zEp3OJ7hx0tp44Fiya75GD413yarRfglSP5muTkkyy
        dfRCA1JOpUvqDRprAefSaSPdwUulCw==
X-Google-Smtp-Source: ABdhPJyexxScAh6tJturIlM6+21A1G4mPGy9rhb+3ZLAMULac3Oa3rj79jfqnQ4zsDb+GEJ4UvcFaw==
X-Received: by 2002:a17:90a:9f84:: with SMTP id o4mr3700149pjp.200.1596198081054;
        Fri, 31 Jul 2020 05:21:21 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id m19sm3675692pjv.34.2020.07.31.05.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:21:20 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/16] mm,hwpoison: cleanup unused PageHuge() check
Date:   Fri, 31 Jul 2020 12:20:57 +0000
Message-Id: <20200731122112.11263-2-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731122112.11263-1-nao.horiguchi@gmail.com>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Drop the PageHuge check, which is dead code since memory_failure() forks
into memory_failure_hugetlb() for hugetlb pages.

memory_failure() and memory_failure_hugetlb() shares some functions like
hwpoison_user_mappings() and identify_page_state(), so they should properly
handle 4kB page, thp, and hugetlb.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/memory-failure.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index fe53768e0793..3d2d61f1c6e9 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
@@ -1382,10 +1382,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * page_remove_rmap() in try_to_unmap_one(). So to determine page status
 	 * correctly, we save a copy of the page flags at this time.
 	 */
-	if (PageHuge(p))
-		page_flags = hpage->flags;
-	else
-		page_flags = p->flags;
+	page_flags = p->flags;
 
 	/*
 	 * unpoison always clear PG_hwpoison inside page lock
-- 
2.17.1

