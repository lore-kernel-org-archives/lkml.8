Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A91C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E8120855
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1Ns8dk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgHFSuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgHFSuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:50:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293C5C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:50:01 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g19so15672497plq.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v5yJHduIFPrJj0jzu2BdJTc4v9IJtvWAc6ztTF7IVcQ=;
        b=W1Ns8dk2j6ciQE7pkh/lSVYKDfh0hFrqZoP3hVtMZZTGlngp/JpLTneCwzZN54yKTI
         7Q5qCFkyMFLHKhl1U/8xFf45prH3fZeQCbOkgVWiIjrMjzIt8lPsUXBLNVQOhoZy5iVp
         JJbwgsEy/8Zb5pBfGNMIKe4/TWGFhwYSF9iqoYu4Zafu8GRMC3rc3qhUBHFbfMN4NtKh
         irkvui7bOYfmuKMdhcn0ggpkX/8kGEevhPOUXtNp+cushrLJDMja6wADSXQD/+WVkOzf
         eG0b44GKxQBC87wLX34S8hXXb4MVKGuj0F7ZTDnZdIvU/hu299bmVGEYTtyX8VTmdBHA
         wH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v5yJHduIFPrJj0jzu2BdJTc4v9IJtvWAc6ztTF7IVcQ=;
        b=Xw9xqi5nS6dgFajPVHfGp9DeivXZyk72raKJuJQ81SnCXxUbl5KqEzzwdMJ/xWnFBm
         IwUy2NR5ZGNKRlGCCLPWSCa8/AF98awT3CfUNLWVgFZyKcR76bz8f+7cj3YtCr5c0OK8
         qMBi80JKAjdldQW6D+BfbEbOe5OeODv6j4Pf8GmAKwZIdGa5oubxLsttOcEPzx+DOrej
         5jTsjITV9XcIt13vnRfpx4BF4pjvpFoPjFACYIVUSgnzyWcrO3ZJCrTkwbNbiPIIGSdj
         J+HDJMBUjWuvMeh0Avbu6TKzf6oziKx/QOnE8sXLE8lthcK0gbpccaCbz8Mxxm0a+w30
         3jjA==
X-Gm-Message-State: AOAM531ldc6owGpSoVjzTed29VpEjD28eqO78KQMe0VKa1GtCJ4+/TlG
        NoRHD0ejTJOViOvgBgR4DA==
X-Google-Smtp-Source: ABdhPJxRi4CrPBcRqCBlogHKcSjI51QQFz3Fod7dvSfzrksrBLVYpPdPfBO9DPZZ0Jp0S+8QsOsuKg==
X-Received: by 2002:a17:902:7d81:: with SMTP id a1mr1368470plm.89.1596739800728;
        Thu, 06 Aug 2020 11:50:00 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id u24sm9096730pfm.20.2020.08.06.11.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 11:50:00 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/12] mm,hwpoison: Return 0 if the page is already poisoned in soft-offline
Date:   Thu,  6 Aug 2020 18:49:21 +0000
Message-Id: <20200806184923.7007-11-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806184923.7007-1-nao.horiguchi@gmail.com>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Currently, there is an inconsistency when calling soft-offline from
different paths on a page that is already poisoned.

1) madvise:

        madvise_inject_error skips any poisoned page and continues
        the loop.
        If that was the only page to madvise, it returns 0.

2) /sys/devices/system/memory/:

        When calling soft_offline_page_store()->soft_offline_page(),
        we return -EBUSY in case the page is already poisoned.
        This is inconsistent with a) the above example and b)
        memory_failure, where we return 0 if the page was poisoned.

Fix this by dropping the PageHWPoison() check in madvise_inject_error,
and let soft_offline_page return 0 if it finds the page already poisoned.

Please, note that this represents a user-api change, since now the
return error when calling soft_offline_page_store()->soft_offline_page()
will be different.

Signed-off-by: Oscar Salvador <osalvador@suse.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/madvise.c        | 5 -----
 mm/memory-failure.c | 4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/madvise.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/madvise.c
index a16dba21cdf6..5fa5f66468b3 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/madvise.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/madvise.c
@@ -910,11 +910,6 @@ static int madvise_inject_error(int behavior,
 		 */
 		size = page_size(compound_head(page));
 
-		if (PageHWPoison(page)) {
-			put_page(page);
-			continue;
-		}
-
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 					pfn, start);
diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index 3a2cd094b77f..61e20b7dd81c 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
@@ -1800,7 +1800,7 @@ static int __soft_offline_page(struct page *page)
 		unlock_page(page);
 		put_page(page);
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-		return -EBUSY;
+		return 0;
 	}
 
 	if (!PageHuge(page))
@@ -1904,7 +1904,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
 		if (flags & MF_COUNT_INCREASED)
 			put_page(page);
-		return -EBUSY;
+		return 0;
 	}
 
 	get_online_mems();
-- 
2.17.1

