Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71152C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 05:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412F220736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 05:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Epg5kfm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgCQFmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 01:42:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33479 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgCQFmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 01:42:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id n7so11321326pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 22:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bs9uueH0blNyu1UBuP0fQK6SW+2/EajcrnZfP/uZxx8=;
        b=Epg5kfm3vsnkL5NY4VcE5Www5oTkkErgJNkHAVcm2ej39BWsfwW9nUespyJ4auOArc
         kbptxhy9JzTOgVFQM2Gp2zOWrzoipDa2+nrx7JTRHsDSUXd245Ev71piraeS/AWj4Cl0
         VMvHWVc3cVoyDI92T++Ue2adH3kyB34uRUKIYSk/MAQg1ZXuVTz6VC6z2U6eDXCCvDtx
         4G0wdNrH9Tv04j1JllvnFmnR235GhAAOIgnBUeOALKHwI5w1j+hUDFIAQGlOFJdp8VBe
         6UDbVegPHLs3vBk1sXyluJBosjvBnSG5xoj+EVLHTDh1fUn5OtUd/+yazeoNrvaiY4Ro
         n6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bs9uueH0blNyu1UBuP0fQK6SW+2/EajcrnZfP/uZxx8=;
        b=iQyVcWkI5PswrFeRubq320itVIaW2Xyv4Aq84THZLf33ncFkh/TnxX5o1xswSth2BT
         fmx1dt/fE7+n6M6/jnv4Lnv2ZD0QLQTHfiAB94NXGXvDgttHFAuXO4C8IyEAI+NbfAUn
         OTHc9QZLsaxiKM7NF+ayDYo56CWZu6t8+qaxDMWDPpcCgDPfo5OG4s4shKH/CkA2C+Mg
         I6uMCtHBfo9m40TWHTIzECejguKGGbfOouzikee3dXV3/Xl84KogD0Xltyd5efKUXLMU
         Va3nqzvD3ELKQyYvegLWoSw8EGhmtLomkmvYU+QZHg5RXLlz7H6LpW+l2FneXNHRl2Qf
         nsEw==
X-Gm-Message-State: ANhLgQ1kx1tZ5xbuY+FYup34sIaEn8lDcJ3ZlNzSYf8GhbfLkmkRNzMl
        wYztNJwRSoSBXbbTgi0yERY=
X-Google-Smtp-Source: ADFU+vviZZCI9RUvZv52A6IowvHU4wA4UgbuP1ihq+u22+rBmlmIR0OSdCovuu3njvRvwadXGC085A==
X-Received: by 2002:a62:778d:: with SMTP id s135mr3550673pfc.21.1584423752601;
        Mon, 16 Mar 2020 22:42:32 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id i21sm1141757pgn.5.2020.03.16.22.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 22:42:31 -0700 (PDT)
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
Subject: [PATCH v3 8/9] mm/vmscan: restore active/inactive ratio for anonymous LRU
Date:   Tue, 17 Mar 2020 14:41:56 +0900
Message-Id: <1584423717-3440-9-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Now, workingset detection is implemented for anonymous LRU.
We don't have to worry about the misfound for workingset due to
the ratio of active/inactive. Let's restore the ratio.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b37cc26..3d44e32 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2218,7 +2218,7 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
 	active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
 
 	gb = (inactive + active) >> (30 - PAGE_SHIFT);
-	if (gb && is_file_lru(inactive_lru))
+	if (gb)
 		inactive_ratio = int_sqrt(10 * gb);
 	else
 		inactive_ratio = 1;
-- 
2.7.4

