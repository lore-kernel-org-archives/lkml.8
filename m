Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02301C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452982224D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsPZzU08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgHFSto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbgHFStm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:49:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E67C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:49:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e4so7332840pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CvFlC6ki86jyf2poLn8AnY/Z80LUaeq3pjN3kabbpGI=;
        b=HsPZzU08x/nUjZZL1blwT0m3W0a7waKc5rryRpUTlYyuMNj3Cvpx63kTV6peM+Ux95
         R+3zUu8yMS1wP2EzY5la+PEhDuaVnLf007d7/G4lfpXIxcv/7GKV/1x8/U6wwO27veU8
         lyhoy8kv4SXCmEX7ZBxOPgS3m9jqbVtXKFZ0XXMMV6R1rXj8Kl7W9yMnANgmCJm2H6rS
         LS6BCAQfcfEJj/Vv+UFoCh/zJKwmh3SMP/vz0dJPsfNlG85B1ynwYAPptiQTRMdlE+Yp
         vFBwfAPz+zn0JANdmuWAUPBFL+QhfNP8x1fsgyTWcY5JUOy3792gCQvl8WZVkMncn4h0
         GIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CvFlC6ki86jyf2poLn8AnY/Z80LUaeq3pjN3kabbpGI=;
        b=o33EkwZKedyVyVSlocqoowiIojUVa5edKQI0yzxG3+/lUhaoJVFFOagqnXUDGMAbPF
         PNP1U834gPk6g/nYRIKR6SMJv3OmbWBpdyqzU2XAqgLR6ZBTBvLpK4gFmeGM5ib6x7l8
         Ie31XCjXyQjqoZXT5uE04yZHAiXsfZT2BPBWCIFhf6wPSt1ftqFrkTbvJIVSj5yIqnd1
         83/n65jM/djM0oNsQ26tkgwaVjwLuiHt2ET0naZJdnmGpGhOCRycXxwyWNeNbqdPfiCA
         q+2BcVknc5YP3aKdq1Klcyq1M9RzHN2pEx8Y4fLwydPfWtFgBbc4IE0XW6eKkpqD/uvi
         f3Ng==
X-Gm-Message-State: AOAM530DOFTYbM+F9nM+wvFW3w/Ea+xl0hpWLoSis8/vhG1yZ34cQTzw
        4XeFXSVGuO4cTDtU+GxzOg==
X-Google-Smtp-Source: ABdhPJzEEd/8epb1+654jMmftgxgjAAecU9Qg7OIOIb97zqAagBZmdlsIaDzWjyhw8G/Sf1veJwYqg==
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr9032052plp.313.1596739781540;
        Thu, 06 Aug 2020 11:49:41 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id u24sm9096730pfm.20.2020.08.06.11.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 11:49:41 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/12] mm,hwpoison: Un-export get_hwpoison_page and make it static
Date:   Thu,  6 Aug 2020 18:49:15 +0000
Message-Id: <20200806184923.7007-5-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806184923.7007-1-nao.horiguchi@gmail.com>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Since get_hwpoison_page is only used in memory-failure code now,
let us un-export it and make it private to that code.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/mm.h  | 1 -
 mm/memory-failure.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/include/linux/mm.h v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/linux/mm.h
index 5e76bb4291e6..8f742373a46a 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/include/linux/mm.h
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/linux/mm.h
@@ -2985,7 +2985,6 @@ extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
-extern int get_hwpoison_page(struct page *page);
 #define put_hwpoison_page(page)	put_page(page)
 extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index f8d200417e0f..405c9bef6ffb 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
@@ -925,7 +925,7 @@ static int page_action(struct page_state *ps, struct page *p,
  * Return: return 0 if failed to grab the refcount, otherwise true (some
  * non-zero value.)
  */
-int get_hwpoison_page(struct page *page)
+static int get_hwpoison_page(struct page *page)
 {
 	struct page *head = compound_head(page);
 
@@ -954,7 +954,6 @@ int get_hwpoison_page(struct page *page)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(get_hwpoison_page);
 
 /*
  * Do all that is necessary to remove user space mappings. Unmap
-- 
2.17.1

