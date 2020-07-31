Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179D8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA68D21744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7X53pQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733202AbgGaMVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733181AbgGaMVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:21:37 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012D0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u10so7732216plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CvFlC6ki86jyf2poLn8AnY/Z80LUaeq3pjN3kabbpGI=;
        b=W7X53pQQJeP+6wvSubGRknoAypUl4N+UBVvqYOwEY/No3tWTdwK68xvzzznrwy40+R
         YP1znazdj8HvaEpORWsDzOGZdjb7NsYU3uW7BSVD+KLnCxoIoVmzc7FQVxbg72IC4SKZ
         2asMt27Y1lCGp/DtK6DECa4hGbzFXPOH+IODUQvXeZ8o6Ag/HFuNR0L21vfVRC8SNzbt
         OwHN40RmmaEaAjoR5q80yyO/Ye+k7k8ZIc93F9WYa8GaVpyUhIOodl8y6EPVFpfErhNu
         301HErm59bsa0RoC7Wt1ns1hsZt4+i+goZz9CagUAASI1IPiVtGsPRVwwjn2ZtChDx+U
         9MlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CvFlC6ki86jyf2poLn8AnY/Z80LUaeq3pjN3kabbpGI=;
        b=EGkmnz9r6odnB1tP/IdEWSm6Dsp41FhvgNURniGkwRaZaqTA1kD+juD5XGDLvg8tay
         bvUpCv+RSgpfEpZ8whQt57diPLPgBvy64R/Gt6eHnqHEXOMVBovBnW8LKLZMqzea1zsq
         0CmFIvoVSa6N3KKOZCNFYmoiqzyw9IKNAwbTGCx1joCxCkmf7Qb5Dsobb8aDs6jKLJr0
         /VFlpfBOKicWZTop57YgmbtklWPcsTCt9QTEPYMArtEMEwR+0kCGIz3O9XoChs8t7p5f
         WXr4mvJ/plTb4SuW8TVw/2aU+h4hGkv6rNRavIzYflSXnxkgMm/akjJcizWDaUtJCxGM
         OPXA==
X-Gm-Message-State: AOAM531RK9nI51KeQJQ/zRdBw8dNlFSky9uXFWvW/UrI4atDMoNxGCqv
        HN6uHhik4NLT1t8PykhIEg==
X-Google-Smtp-Source: ABdhPJywCCqceUPTuP1ChhjOjP9TuahX20BeNq3JsgzEUbx9EzjmcCEVHLLgUbOmChs8uDpXLd49Gg==
X-Received: by 2002:a17:902:7c10:: with SMTP id x16mr3556236pll.122.1596198096570;
        Fri, 31 Jul 2020 05:21:36 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id m19sm3675692pjv.34.2020.07.31.05.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:21:36 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/16] mm,hwpoison: Un-export get_hwpoison_page and make it static
Date:   Fri, 31 Jul 2020 12:21:02 +0000
Message-Id: <20200731122112.11263-7-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731122112.11263-1-nao.horiguchi@gmail.com>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
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

