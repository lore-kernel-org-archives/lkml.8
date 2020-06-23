Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C7DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB43B20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWo1Ivst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbgFWGOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbgFWGO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:14:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46832C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:28 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b7so767005pju.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sJhG/EECQU60fMMJwW7ZSgqGSJ0Sa1bGibgzSWunQu4=;
        b=vWo1IvstvoWznzT3ERU5FriztuAmiopI/sb+aB05u1jaMs3PN5oYl4yHyzRG6CJCb8
         FzJfFKI6Llo0xezihbIfX/06+y6IXBAAdNyF9D59mmFqGZZNQUWtrUocg909mXZVDg4t
         ZImR5hNQzQwUdZTlvNz3Juk8WhWsThIKMlz8Fygekl3e1lh5Kf2S4PSJSWCHtj31ARRa
         lxZ+SBxhHUiRstrhg0wcC7E7qmJEFr4ZS9/lwEh+tUus3J5XaGgqB9j1NiOJ4dq6+jNu
         drx814lJrhLFKLRUwXfEPoQxu6F5oarFFZ4euvZEB2a1wNEQIuKVxy53AoOuZLG+Yu7b
         BtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sJhG/EECQU60fMMJwW7ZSgqGSJ0Sa1bGibgzSWunQu4=;
        b=iaBXV9GhtOTUtwHKWWJGHmWjw9o4mUMcPI/RIPkw1JEItUeqUXoGF1hDTBeoHV9tIF
         QGIAdx5iOfPicu63vS1mz5i5uNyUeGno3+6iGhJ4a4eAbPSttlazmaKTdNrZnv30VqQt
         EEvgmEmSFBeeCrpOEMukRHePiHMbvObHhI2S6Dzx47/X4GNxpI/Zirb7gT7sVU63Hrzu
         EFYQzL4/AEEZxZSO67W0mjqQN9LXHC/67bu2DKhbjc9ETleSxXF5fji385r0myxCmR43
         3ZFpO+KvdPyhR06VaMbJmhOjtKrJZt0xy8Y3J/sP1rRPFOgYpuluBHSGGbJByBl1yA6D
         OXxg==
X-Gm-Message-State: AOAM532KnoZq2mSoKmQYmjSRGd72cLP03NKa6JWcUWCYQfyb6ZNU7wB5
        y0TJWKUJnakFeDnaOSkD8l2qpQLkGWs=
X-Google-Smtp-Source: ABdhPJylyWj57oSOyabKM1yxMkK1RxlL58E4vg04DIQfNVXGZdk+uFb/jTvDgkSA1CxgA9+zBkNyig==
X-Received: by 2002:a17:90a:e50b:: with SMTP id t11mr22522184pjy.109.1592892867815;
        Mon, 22 Jun 2020 23:14:27 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id m15sm12801093pgv.45.2020.06.22.23.14.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 23:14:27 -0700 (PDT)
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
Subject: [PATCH v3 1/8] mm/page_isolation: prefer the node of the source page
Date:   Tue, 23 Jun 2020 15:13:41 +0900
Message-Id: <1592892828-1934-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

For locality, it's better to migrate the page to the same node
rather than the node of the current caller's cpu.

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

