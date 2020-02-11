Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46287C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200732082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhfqMBoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgBKGUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:20:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42172 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgBKGUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 01:20:13 -0500
Received: by mail-pl1-f196.google.com with SMTP id e8so3828904plt.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 22:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PQRul9eP+ZS9HAAeaH8frtjB2cUDoTj2pwxbGJPwV4M=;
        b=WhfqMBoTUlYB/HyZ+Nhd4PmIdY1pn2SPX1Gy0W/IKW80dzDui0tPjuRHOQ2DTIDRJZ
         6aV4r1RABqEYQm7BtBQKNBGPEv4aprSda3V6UEjL12xo8MKxiJmPy13jsJ6OlJ7883Lf
         MjaaWe5zDuhyLjiaoKeZwNwJ4PHrVOzydaiXTIO39I+7URfHAj6u5C0BugnaNI8wr1k2
         cc9K5AB1ZUNFxwdNjNcAGL9Nv2b3fRpJ6gaYa5SnkvhST34Ab0WgpbZuNkbAISP79r5k
         Z5Yp19ytLB3WxaEW8h3LL9bZwOXJKu51XJMzGxmwJYrJwB1t+pBztME4yeCU5uJr2R7o
         Kw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PQRul9eP+ZS9HAAeaH8frtjB2cUDoTj2pwxbGJPwV4M=;
        b=OrR8TIx7i09mFWrbNWC66D4Rd3L8o3mE3UUdaUsna7VbPvo78e/b27aFFShpaYpr/X
         kjzbc5OdU8E/X+h/ZaAx92BrpueZ+m/cDnEd4dxPVcB2/OjZKSrwsyDjYpQzCScFivjg
         I9oUZLopVYTDEmIj4yE9Jss0eOjf5q6lcMSYjCNzEsT6nx+oCCeGde0Bm6CRjgJ3nUPk
         zgHVtz6cLc/kYm4WTilYFrj9ha8hXfKnF8KjfWB5K8DucC+ph0c25f7UwoWVZKvkalMz
         JXDTzUIZ99064QnTck/hforSuijp++ZEakx/SvnmyaxvEbicbqKmwZYm6hCGTDe18f6y
         /JfQ==
X-Gm-Message-State: APjAAAWUXsS8inYbSLkSYRH5jQ6/OuYkxkRWZAg52diXgaKW9s2MDYwF
        RTJQ2uQWQDJdlPNwbo5C6AU=
X-Google-Smtp-Source: APXvYqzCG4W6Wny2VO03PW0GnJRMgu4X9J6iTBt5Ta02//1FH+AW5Tbp0YbAEhdgZcS8fiECwRR0Uw==
X-Received: by 2002:a17:902:524:: with SMTP id 33mr17015509plf.241.1581402012575;
        Mon, 10 Feb 2020 22:20:12 -0800 (PST)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id x197sm2578696pfc.1.2020.02.10.22.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Feb 2020 22:20:12 -0800 (PST)
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
Subject: [PATCH 1/9] mm/vmscan: make active/inactive ratio as 1:1 for anon lru
Date:   Tue, 11 Feb 2020 15:19:45 +0900
Message-Id: <1581401993-20041-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com>
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

