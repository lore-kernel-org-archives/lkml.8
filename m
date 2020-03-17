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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7004FC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 05:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CC820719
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 05:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/1WFbMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgCQFmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 01:42:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33448 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgCQFmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 01:42:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id n7so11320581pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 22:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PQRul9eP+ZS9HAAeaH8frtjB2cUDoTj2pwxbGJPwV4M=;
        b=Q/1WFbMu/icSL+Ap36D0aa4UwgXfof+yGn1T1JqL8WsyjwNH6Zzd2UBVYMloA4Q+ZV
         glzBsUXTo15Euf11RWj1HwtZrdjEaNjs/FGMUP5AI+DsnY57IpuSgVMS00Ch8JS2Avuf
         2+imd/BJK+NzoZXRZDY9osKyxFsfQWUV7N1KWA+aulkEbJpibZdPxOxB5cIgmkrqS9WT
         pQSC8Up0a5Gdwy+ybnyFYN7FFOSQJtxxInTBGv6cGgfGKq6mm8JiL/getIboxAs+KYer
         hbp5+MPJ9ZMF957nRbMOiJ7ZqgocMgDW1RDP4rSosZ6x2hUMk66DpY6yq/EOLh6hC2oP
         0BtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PQRul9eP+ZS9HAAeaH8frtjB2cUDoTj2pwxbGJPwV4M=;
        b=GXg/Z6wuWehoVaNJyXAhj1W5U7gKu2i14cPiL3v+/7Slmm0fJjfgH76rR6YZ8GdMt+
         NwzvUpaiqFk2LzUUs3wR2a9x5r0mTh44oVNIO2oQPtqzluNBJXMnWY8q2+zTNbnDPP1x
         OHLelXHY/xOFwSo8Ngy9pxtEhTVHPXwtrwMkyxkS7mDKXG5rPM0T8LQUv4wMUlJHzuR7
         nsJBOqHEYBsPgl0YjcskC2+yRHgSRVbCGrGnxtmy9o8qnJh7Uk44Z54t5q9GsBJ3iYrR
         +LYGnTB7u3+wcfjdkU8yE3XmrPKK7x5c4aM5p1vWuXLPQKHI45+tz/vAg+SiqEpdYOeJ
         00OQ==
X-Gm-Message-State: ANhLgQ2U2jhuke2erSRE9NWGbMGXTDKW7wcTTKuB8CvzVBEsW2r3VBb6
        NgwyHQhn4rJhUZm6DYDNHVk=
X-Google-Smtp-Source: ADFU+vv0q7qpwhdkztwUEw/q6jy7XGPGBI2IJSRInrYuXm82iDmLLWAgyZ1n8qeW2bNLeok+KptNOw==
X-Received: by 2002:aa7:96f8:: with SMTP id i24mr3344885pfq.321.1584423729232;
        Mon, 16 Mar 2020 22:42:09 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id i21sm1141757pgn.5.2020.03.16.22.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 22:42:08 -0700 (PDT)
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
Subject: [PATCH v3 1/9] mm/vmscan: make active/inactive ratio as 1:1 for anon lru
Date:   Tue, 17 Mar 2020 14:41:49 +0900
Message-Id: <1584423717-3440-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
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

