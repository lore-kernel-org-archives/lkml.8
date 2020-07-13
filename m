Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCE4C433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA339207BC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgBe3t8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgGMGmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbgGMGm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:42:28 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7619C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:28 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x8so5083464plm.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DYvbIUGr1klvf1KuM5X3vtjsbtYe5Ed8VKuo0vY8aNs=;
        b=CgBe3t8n7VNso1NPJiLgJXeLW3cIBJizUgkVaI8dO5owHBrbFC4uG+U4un4Kgm6Hyv
         LiiwhzvpRqGbzWmLMdTelDCH+srgcqedru314ibXq61m3uTaO5hXbPSTxRpO1i1kmntP
         ExKG+iPC+sYXYNhqFeXc0cPb9Ls/83S7YUmSg+0htTsneBykEZOBiAu5Livcf5m7qsQV
         HOOdS0qo2GOdbKZxzBBq/8DuKxts+c9dAc/r8lAnO0Iq1pzjRh1CulVrFtb/n7EMo69m
         vzeRmYEJgpczLoBjmaatUyoy2CrcZoupto848VUZPY2y3Y41X5LrQ7s1GEHVR1WLh/Ju
         Rkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DYvbIUGr1klvf1KuM5X3vtjsbtYe5Ed8VKuo0vY8aNs=;
        b=S6ysOJzYlgis6XxVKvRv4t1MeDzhKChcJr7p5U20N32F/b7yHZ7R/I6T08N9+gpJud
         KQiPdg1pgU9z7hbOY8ZFE2r0gvmxfYGz2RE7dwYVpLxaOs7zHgtfMEFhV+qLmrmk3xsx
         8Q1/229F/dh5olTCKz4xfF9zPwMdtVSNVp8sxo2qAgorHpUGgoSSKzCwlRgP7/tFz7p/
         J74tTFLT8MrIKfvgW1P4WgaG/a3nXtjsKIC8FoMqZW1dESWbPtn9Z3rgCjKZP4KH7hev
         vBrt5FTx553jm7nm516E0m6DOZl8Zd3TrXM6+tC6OutSMHZwuX54rm6sLXssYKgPMbOk
         cFNw==
X-Gm-Message-State: AOAM532Q8gcGMGVqZuxMRZSggoHOg31XkNw2co8SnB7yxxzGQJBVDVhW
        0SV//C0l9/n7bhzkKEjxISY=
X-Google-Smtp-Source: ABdhPJzL56WSCGGGVz7bKQJxux8fS+oGRvXZYz6+Ns6WcAgpVYHewqzoEMpn8OExmd8A6ffq4maGiQ==
X-Received: by 2002:a17:90a:de8d:: with SMTP id n13mr17681375pjv.95.1594622548490;
        Sun, 12 Jul 2020 23:42:28 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id l134sm12448695pga.50.2020.07.12.23.42.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2020 23:42:28 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v5 4/9] mm/migrate: clear __GFP_RECLAIM to make the migration callback consistent with regular THP allocations
Date:   Mon, 13 Jul 2020 15:41:52 +0900
Message-Id: <1594622517-20681-5-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

new_page_nodemask is a migration callback and it tries to use a common
gfp flags for the target page allocation whether it is a base page or a
THP. The later only adds GFP_TRANSHUGE to the given mask. This results
in the allocation being slightly more aggressive than necessary because
the resulting gfp mask will contain also __GFP_RECLAIM_KSWAPD. THP
allocations usually exclude this flag to reduce over eager background
reclaim during a high THP allocation load which has been seen during
large mmaps initialization. There is no indication that this is a
problem for migration as well but theoretically the same might happen
when migrating large mappings to a different node. Make the migration
callback consistent with regular THP allocations.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/migrate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 3b3d918..1cfc965 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1547,6 +1547,11 @@ struct page *new_page_nodemask(struct page *page,
 	}
 
 	if (PageTransHuge(page)) {
+		/*
+		 * clear __GFP_RECALIM to make the migration callback
+		 * consistent with regular THP allocations.
+		 */
+		gfp_mask &= ~__GFP_RECLAIM;
 		gfp_mask |= GFP_TRANSHUGE;
 		order = HPAGE_PMD_ORDER;
 	}
-- 
2.7.4

