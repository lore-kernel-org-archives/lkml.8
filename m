Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9A0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59450206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbad23Al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgGGHpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgGGHpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:45:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A27CC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:45:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u5so18079814pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=noldTA6TKGUO86OIVB7oA9T0/eymsgYb8B93ohzbuus=;
        b=Vbad23AlnQOk0GUC76j8CTK+/qKNN9hFL3i4/MhHD281K/tlIVzkVrKX4ZMncJqnqk
         4XNfwEBuQgaHmn0Wl31LFSUeMY8sa0dLH3bKra/rBA0Qa1Qts+90pFXiFKK2ZLdsEDA7
         k5+eacop/fCCryMmD+Qb8/3DA26WUItWVZVfjT8HKOoBwVuoYcb4YA+2TVsN2IrnZdkl
         P0I15QZfDAR1YhCB2DI4ZP1cwR1eXVgAJ4dX3cyIXs898jdTff6o0D8NGUQD2igFTqTR
         gpcn0NwM2KrjkJ8NrAhACysJ496YTc48AZgzHlAtVTePQXnO0TC4i3RifyjxCK4+GD9F
         O2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=noldTA6TKGUO86OIVB7oA9T0/eymsgYb8B93ohzbuus=;
        b=IJdc38BMIULpS6InuWTjJanTm7lzB9jcPkorNDeAcUJlYyslXHSvMRi0vaJCEBF/mY
         nGENqi/8y3kvhjNoE9hpR3brnWMf0fMLFP5CNv/b9ZgjuegOFqZBMsA78tu+oiagsfG0
         RK7yaUIF24ae+4CHbXE9ywl0n1FAoPl6uizdZMksrU/qBDhCfvMewttFv96ncPmGkBWJ
         VHxoLvdETpWxFdzwbzGUWmrkp2ZjjVTy/ai78ohdnF2Jqg6M3XpuUqwvMCxtMcviEVCB
         Ntir3/k2kdQhwoKyoAJJztJU1LrE/LhuWnRUUeZBxyU4n0/Xj5XTY3J57uzmtF4tG0KG
         45rA==
X-Gm-Message-State: AOAM532zbhVbs8uWCR0XY+y2yFRVt6bWcYMpYjb2zCgeSZVFQmeyB7fF
        UjeoEG9DRT4c2tFtWZB8Btg=
X-Google-Smtp-Source: ABdhPJyBY9P14Z7TZVWcW0g/XRnUzMq8W6ZRVVwEUlQa4xk2icW0pqQPXYlWDGNgoBpOUqe6nGfOPg==
X-Received: by 2002:a63:d40d:: with SMTP id a13mr43580473pgh.225.1594107914104;
        Tue, 07 Jul 2020 00:45:14 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 191sm21330151pfw.150.2020.07.07.00.45.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 00:45:13 -0700 (PDT)
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
Subject: [PATCH v4 01/11] mm/page_isolation: prefer the node of the source page
Date:   Tue,  7 Jul 2020 16:44:39 +0900
Message-Id: <1594107889-32228-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

For locality, it's better to migrate the page to the same node rather than
the node of the current caller's cpu.

Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/page_isolation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index f6d07c5..aec26d9 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -309,5 +309,7 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 
 struct page *alloc_migrate_target(struct page *page, unsigned long private)
 {
-	return new_page_nodemask(page, numa_node_id(), &node_states[N_MEMORY]);
+	int nid = page_to_nid(page);
+
+	return new_page_nodemask(page, nid, &node_states[N_MEMORY]);
 }
-- 
2.7.4

