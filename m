Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F7BC5ACC5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4228207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ElaWK+vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgBSXgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:36:19 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56598 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgBSXgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 18:36:19 -0500
Received: by mail-pl1-f201.google.com with SMTP id 91so1101281plf.23
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 15:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=ceCTx418aVihpo6rFpR+wNvTWdymckdQCgW+S+5D+ww=;
        b=ElaWK+vvjlEOTaDI96uhD4FifQudUv5N04GNPFXTKz4pnHeBBMuR5FVqNefTmSeoKL
         q6ud/on58vD3yWdnaZA0L6ny6hgVYQDrMuxVwBbKaxSe/hQGwhNU3VYqY5PoVeeAsHoO
         2fK+CMjVgvXJMRJhFiR1Pu9J53gtOYIBwxNZ20PiXSNCVK1vg3yITTnp5EpMKhUIIay7
         5Hp5PIzqXLuliehS1AIBGHEb5+nG+jXk+8eyyz6SPd0fk6OtaFld3H+Af3DSN+MOaB85
         1C26Q1AFY/pTY5N1NXnEGvLq89tvNgUaYX3YTyo/pC5fa8U2JN8J+Eqfd9L22jBO4u7C
         gMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=ceCTx418aVihpo6rFpR+wNvTWdymckdQCgW+S+5D+ww=;
        b=hTGebh1vza05P8ToDV1fjq4heJ/a1gUc/N5fwpH9MyOsCtR0Ik8AFthRppjsQremCY
         tzBShBXqF3rU+sjkmkBHnIwBv61Li76R5MtSYuQ4tJVmFZQntCHUyhRpiuiqBHvB14Kr
         woLGqk9lq/jtQ/uHZyH0pqyhFeXWHSshura50uK+WW6bE8yyosXlpG1bB7FBpo+GKcrN
         IZddRW302guicYJojHI5UE60OkaHGKwXNP/MuHTRlYjbuCaYLOAZ2hsJ4+bH/vjgUliY
         d0bHrYutehZJq214p4M3/6rFenKudpOJVArl0DKAmWCU3FMNePLvZrNytretjsUTXK9P
         R7mw==
X-Gm-Message-State: APjAAAXTGcsU//t3I0vS41S3pnMXpUErPl8/Hqc7/4rbQDF4Z3JrCNjM
        uIWY6yNg4oeMSn0gOAgtmE4WqkQT6R9QxxVcLA==
X-Google-Smtp-Source: APXvYqyzpCXqcYecDcsReRHjemmx0QG/s7nd43ULuYIdIDb+B3vjF0F8F9JOP1Puk6SS10PJSvGwUosPzYzTCfp5fA==
X-Received: by 2002:a63:48d:: with SMTP id 135mr30192787pge.350.1582155378171;
 Wed, 19 Feb 2020 15:36:18 -0800 (PST)
Date:   Wed, 19 Feb 2020 15:36:10 -0800
In-Reply-To: <cb402ae6-8424-c1f7-35ff-6acc68f9a23b@oracle.com>
Message-Id: <20200219233610.13808-1-almasrymina@google.com>
Mime-Version: 1.0
References: <cb402ae6-8424-c1f7-35ff-6acc68f9a23b@oracle.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] hugetlb: Remove check_coalesce_bug debug code
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b5f16a533ce8a ("hugetlb: support file_region coalescing
again") made changes to the resv_map code which are hard to test, it
so added debug code guarded by CONFIG_DEBUG_VM which conducts an
expensive operation that loops over the resv_map and checks it for
errors.

Unfortunately, some distros have CONFIG_DEBUG_VM on in their default
kernels, and we don't want this debug code behind CONFIG_DEBUG_VM
and called each time a file region is added. This patch removes this
debug code. I may look into making it a test or leave it for my local
testing.

Signed-off-by: Mina Almasry <almasrymina@google.com>

Cc: David Rientjes <rientjes@google.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Fixes: b5f16a533ce8a ("hugetlb: support file_region coalescing again")

---
 mm/hugetlb.c | 43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 94e27dfec0435..3febbbda3dc2b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -289,48 +289,6 @@ static bool has_same_uncharge_info(struct file_region *rg,
 #endif
 }

-#if defined(CONFIG_DEBUG_VM) && defined(CONFIG_CGROUP_HUGETLB)
-static void dump_resv_map(struct resv_map *resv)
-{
-	struct list_head *head = &resv->regions;
-	struct file_region *rg = NULL;
-
-	pr_err("--------- start print resv_map ---------\n");
-	list_for_each_entry(rg, head, link) {
-		pr_err("rg->from=%ld, rg->to=%ld, rg->reservation_counter=%px, rg->css=%px\n",
-		       rg->from, rg->to, rg->reservation_counter, rg->css);
-	}
-	pr_err("--------- end print resv_map ---------\n");
-}
-
-/* Debug function to loop over the resv_map and make sure that coalescing is
- * working.
- */
-static void check_coalesce_bug(struct resv_map *resv)
-{
-	struct list_head *head = &resv->regions;
-	struct file_region *rg = NULL, *nrg = NULL;
-
-	list_for_each_entry(rg, head, link) {
-		nrg = list_next_entry(rg, link);
-
-		if (&nrg->link == head)
-			break;
-
-		if (nrg->reservation_counter && nrg->from == rg->to &&
-		    nrg->reservation_counter == rg->reservation_counter &&
-		    nrg->css == rg->css) {
-			dump_resv_map(resv);
-			VM_BUG_ON(true);
-		}
-	}
-}
-#else
-static void check_coalesce_bug(struct resv_map *resv)
-{
-}
-#endif
-
 static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
 {
 	struct file_region *nrg = NULL, *prg = NULL;
@@ -435,7 +393,6 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 	}

 	VM_BUG_ON(add < 0);
-	check_coalesce_bug(resv);
 	return add;
 }

--
2.25.0.265.gbab2e86ba0-goog
