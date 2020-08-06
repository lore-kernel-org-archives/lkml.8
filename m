Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C454C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8212224D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOXH41yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgHFSte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgHFStc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:49:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93164C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:49:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ha11so7153976pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pS0WhU6WE8IYcQCnD1IwwP5QRHOYUjKqdATKfccEtHE=;
        b=KOXH41ynmycekcDeMi9gZeiIS5eCKt3SCoMwlCTMHjb0JpMnOqc3vJoLKZfbX8BXQr
         +3PK+ex/1iKo64nx4cSsOP5WPAwB0IyatsYFDCoO+55h81UKK7NZaFiMcBxxzHrqQxBk
         Xs5oyToQ2QSy0+wGe2oHcxlBRe6wC+noBPy0KvzKOif6UfoF/BnNskrZ6PkmxeCtEB0a
         3sNMPnigY0YoWJ749k7h6SGS/vlxyKNNSnoET7InWc8gdyT18CjBAOX5TVmkR3LbRAr0
         Od0zuuJVaeIfNMukviws18DKLGd0vHBywboPjulRboLJswDBKsJbiHDasQ8Ev/SeRSBH
         RuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pS0WhU6WE8IYcQCnD1IwwP5QRHOYUjKqdATKfccEtHE=;
        b=ouBBdd3YMMccjDAFdx9l/Hd284YQ/aCtK3OVwgY/oSH5SD7f/EXa5CE43gM6PWI/t5
         0xzvm4agypi44vstQE2iMc6oH+8+Xd4WoOa5ZTN3DOVZ2s3kDrOxJskZio7XtaT/U6L6
         4XqKnmCK1GuYh9w/OgpU2BaKAreWIgkiTYSL/nVhJ9OOiinsbxsN+pkVBwx2udiact6H
         19bK+NEurTg3LfxUKXCCXN3aCd3WmUxF/W5Gox8RW3wLIeXwA/D25D85N/afO7pOy5hF
         YQ73dFlemmnY1wbjgQN23fdIFD0tNZ+U+7BRmJsdglOii8Oy233sp/qxFdOHINk08gwN
         4ijg==
X-Gm-Message-State: AOAM530x/BNWG0x7ALcPWRIhnDmAN480RbKoEgwgrQZXPS4nebqcFra2
        BvtkS7kJ79s0+UOxm9YDag==
X-Google-Smtp-Source: ABdhPJyxuBozs6QXnWSecAuONMVWxvd4dNJdBV1f4bZFBqG27ANykG47lkr6oIrXUy60PoNvNI93sw==
X-Received: by 2002:a17:902:bb82:: with SMTP id m2mr8992381pls.115.1596739772043;
        Thu, 06 Aug 2020 11:49:32 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id u24sm9096730pfm.20.2020.08.06.11.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 11:49:31 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/12] mm,hwpoison: cleanup unused PageHuge() check
Date:   Thu,  6 Aug 2020 18:49:12 +0000
Message-Id: <20200806184923.7007-2-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806184923.7007-1-nao.horiguchi@gmail.com>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
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

