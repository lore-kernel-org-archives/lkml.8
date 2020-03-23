Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64277C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D08020732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sT2oaupD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCWFwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:52:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36699 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgCWFwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:52:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id z72so6658465pgz.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 22:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U7jG+Redj2n/Yx20QRQJyqa8ihVuhx36qawgSQPthFA=;
        b=sT2oaupDw/Yl/87fmDzroo8tDxr2qptcfNoatb3rT/4/Upulp99BL6swyzEqXhNEM6
         poIZbN0EMmY2lPh1NM+GeaLO3kXQGAsAmM1wAYlCuKBRXGpOzfgRbhCBilZhoKgZljzD
         XjGqt0A/fAixNeIFKqooAkjFaHtI9MA0MEqW6OK8nkGC/zRDCV6A2eXbwDqQz4IIO8OP
         gXRZFTp4w9Qel84PdQHiVKH8oGwOLTneeTMyhKk4WlJbMU9u/ne+7oaRheHxgdEFv1uk
         FGEWI4kIoGp9A1Ozz4qQd2tR3qjjvhlJ7b2WHDg6+7y9w4VDLKAUxpDUNYZs0f7RzeRP
         oWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U7jG+Redj2n/Yx20QRQJyqa8ihVuhx36qawgSQPthFA=;
        b=dXCiyheubh5NNYh9y9mW3uEUogFk5KuFaF0Uh4V3HxkrbgtaeyYpf8FsJum4BZr2mX
         uYCGLlPV9axyZuHYF7Cxw46PVtS37UR3lhGfQ7zYnxMfvGkmlnJG833TvCY5n4ljicnu
         M8i3VvlJKlvMa+gTWF4lYAyq+86Z3YquEWRewWAbD3Wxi0p2EfNiaSi4f1PgUuL/xpnE
         9qQhU+v7EcDjj2Y8kexhL1F6lOt8TGCKD0dL+B5Snz3PNPorb5jUupxNt92Ho7nuaMqo
         mJZCWJ8HhsDkqJEXN+sDL+A9VIRQGksz/Dj8Wqid2fkx0wkCr84GwfguXbLuWjpD8G+Y
         GHkw==
X-Gm-Message-State: ANhLgQ0XV6HkHTW4dB+rwkpMf2YV8OTVpukmO205BjI6YkCHwiW6dJys
        DOsN4RSh/Ze4eRBC4USR0JU=
X-Google-Smtp-Source: ADFU+vt1x3FC3Hfo9KtpzYUNKyBS+UzrdYFDy9SSv0OxjI7uCe0zK9H0XWhKsIEJtGjgDTIOGtK5yg==
X-Received: by 2002:a63:1404:: with SMTP id u4mr20171266pgl.172.1584942751981;
        Sun, 22 Mar 2020 22:52:31 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id y30sm12563058pff.67.2020.03.22.22.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 22:52:31 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v4 1/8] mm/vmscan: make active/inactive ratio as 1:1 for anon lru
Date:   Mon, 23 Mar 2020 14:52:05 +0900
Message-Id: <1584942732-2184-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Current implementation of LRU management for anonymous page has some
problems. Most important one is that it doesn't protect the workingset,
that is, pages on the active LRU list. Although, this problem will be
fixed in the following patchset, the preparation is required and
this patch does it.

What following patchset does is to restore workingset protection. In this
case, newly created or swap-in pages are started their lifetime on the
inactive list. If inactive list is too small, there is not enough chance
to be referenced and the page cannot become the workingset.

In order to provide enough chance to the newly anonymous pages, this patch
makes active/inactive LRU ratio as 1:1.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 572fb17..e772f3f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2217,7 +2217,7 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
 	active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
 
 	gb = (inactive + active) >> (30 - PAGE_SHIFT);
-	if (gb)
+	if (gb && is_file_lru(inactive_lru))
 		inactive_ratio = int_sqrt(10 * gb);
 	else
 		inactive_ratio = 1;
-- 
2.7.4

