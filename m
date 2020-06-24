Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441C1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCBE206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMN95lFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404294AbgFXPCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404189AbgFXPCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:02:04 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB78C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a127so1259343pfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vGo//y2piUItDtCt+d69yjROMahecLhJLYlxuCdPjdw=;
        b=SMN95lFx/w+d9J9q5fXpWkMsl0nkfj3ahdWd28iH1Ej/dL3bnERwMHyy5qBJbdrZf2
         TgTmvvBIpqABHJxq5+W9AbgRwEShymOKxVDS4wnRWAc2DiTu2w06VUWp3C+C/waieroE
         pS/xnD56tSFnRmyV30RS1PF1NjqjwcLUNX8PBQ6A6RFxzTYi47CEunCvUfliYKDmAjAv
         PH5cMk5eD6anBAeNV1OYRdBei0IF3DS11++j797nnqxnuzZiO33wU8t2Yhsgsx7aUwY2
         xOO2H3X7tbqSCdc5x8Imoi4zbnlE10C+FBk3DBxKKUwdtSZqLeBP2zSrAR/iYsOpa9VS
         8Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vGo//y2piUItDtCt+d69yjROMahecLhJLYlxuCdPjdw=;
        b=Nc2VVMb+GP4N5ERjKKcx/L9RuTMAdH/R3KVpD2w4VW0vVRB/9pMjTihBdv2rGEtwL6
         DYMBcMKdndVBy8A3YfCrNWI5/sk8x63RLGz+N15vyUkaNnVjbpB/nfwM0JvBBhC2ezvD
         KVyf9SiuJREklym2HR41bGfhDu0CU7aiS9S46ziZ2IY9ZzawhTrgYIMcN9ffxNxQNrMb
         Ny5UA1Y/5N/OTSFcRMtR53bRYZBkLQ0Le0Qm8c+t2fw1AsN0mMGLVLX2uu9kRo4N3HtF
         INqr7O8T1+KGIZ4Cu9mZZuuf7YLssrSdFtBmhpc6KpCSDOISzAjpBqXE49ql2E7zMNoZ
         O0nw==
X-Gm-Message-State: AOAM531vK27XYuNEGLOZPXwWAKw4gYsqfqELPZkOvjBPx9qtOYbgOiHQ
        4ZpJ5+q11DvF183hpzzN1A==
X-Google-Smtp-Source: ABdhPJyib86xuv+4R1hRolRyZfMpndmPbyGA55cTpUqee4JUp+zFt3OIJAUnQOLHWPzxS4jINtGdFQ==
X-Received: by 2002:a63:fc1f:: with SMTP id j31mr22657214pgi.104.1593010917772;
        Wed, 24 Jun 2020 08:01:57 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:01:57 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/15] mm,hwpoison-inject: don't pin for hwpoison_filter
Date:   Wed, 24 Jun 2020 15:01:27 +0000
Message-Id: <20200624150137.7052-6-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Another memory error injection interface debugfs:hwpoison/corrupt-pfn
also takes bogus refcount for hwpoison_filter(). It's justified
because this does a coarse filter, expecting that memory_failure()
redoes the check for sure.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hwpoison-inject.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/hwpoison-inject.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/hwpoison-inject.c
index e488876b168a..1ae1ebc2b9b1 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/hwpoison-inject.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/hwpoison-inject.c
@@ -26,11 +26,6 @@ static int hwpoison_inject(void *data, u64 val)
 
 	p = pfn_to_page(pfn);
 	hpage = compound_head(p);
-	/*
-	 * This implies unable to support free buddy pages.
-	 */
-	if (!get_hwpoison_page(p))
-		return 0;
 
 	if (!hwpoison_filter_enable)
 		goto inject;
@@ -40,23 +35,20 @@ static int hwpoison_inject(void *data, u64 val)
 	 * This implies unable to support non-LRU pages.
 	 */
 	if (!PageLRU(hpage) && !PageHuge(p))
-		goto put_out;
+		return 0;
 
 	/*
-	 * do a racy check with elevated page count, to make sure PG_hwpoison
-	 * will only be set for the targeted owner (or on a free page).
+	 * do a racy check to make sure PG_hwpoison will only be set for
+	 * the targeted owner (or on a free page).
 	 * memory_failure() will redo the check reliably inside page lock.
 	 */
 	err = hwpoison_filter(hpage);
 	if (err)
-		goto put_out;
+		return 0;
 
 inject:
 	pr_info("Injecting memory failure at pfn %#lx\n", pfn);
-	return memory_failure(pfn, MF_COUNT_INCREASED);
-put_out:
-	put_hwpoison_page(p);
-	return 0;
+	return memory_failure(pfn, 0);
 }
 
 static int hwpoison_unpoison(void *data, u64 val)
-- 
2.17.1

