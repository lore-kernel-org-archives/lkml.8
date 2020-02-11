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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA9EC3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B552082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY1euNlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgBKGUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:20:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39944 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgBKGUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 01:20:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id z7so5157787pgk.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 22:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hUsW4h0Q2Yi32kJtCDyUXPnl4z2/9q9YG773fr2bDbk=;
        b=mY1euNlOdCA2C6rfWChJVGDCpurwr/b+T7/UB0h6nIHFYoz71noGGGSGS29ZkpzL2I
         TVP8L96ffUqVW62xSZL0EkG3nN3QucnMY+9uLzlcIgG8qwC1w44yhCm6QzYVo9tcSOKA
         Z2Nt9zie6BA+MiOtky5RKTkOxWjd4/Zka+MzcvKNxpDRNBLvZCBKr6q9uwvjvUtaM7ng
         T1nerxeZjHRGYegeaSdyV9lv/HFnB/mkNU61rAo09yDTsQVbERs9C7ay+mXwtZFMwlcf
         Evjl4AKaTAsu+W6tVrMehcF/8DUc92pQv9nEZODLDMxcLNq8EPPUEpLROvtK0xswy764
         EbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hUsW4h0Q2Yi32kJtCDyUXPnl4z2/9q9YG773fr2bDbk=;
        b=dWJ4WOFmJUCJx63z6uDoMgflGe5Oarr/uWTppLGqXrlamkqWHSdFRBANg3GQeHQamn
         oEVZ7m2Jzy+J/ZeAek9w79MolNjG0XTQYh6gyCMvx/p2Mxvq84CQkUw5hDIrezXKL4l7
         xvdtepPBkMbD4xpLcvcWadQyK0biqopCUjdJYL/75EedGce3ygQRZgNRo9K6hOwW7EaB
         3w1nnb/ia/LycstP7E3bmCoqUOK9aFwRoDYvldO+eE0KMv8HJw5SLlIp98HCJXrSKAlD
         280oB8TcSqdkFFjI+tFsu1uIRiVifdrSghhNz/x2+tVUS1pVX7tcemzbSrU3vw7pXlwp
         jJAA==
X-Gm-Message-State: APjAAAUUriIMhGGBRysdoQWxlGs430v/Oin5NgY6ikcMv7JS56mOEZcT
        RkA+tuOd3bD1CYpi8f/n1N12azuWrtI=
X-Google-Smtp-Source: APXvYqz/EunkFhFAPYs6HlqM6zE2fauxOTg+/R7GBZ29Zoc5coMAbYC6dlLPfOAP3A3lSOEydNGWUA==
X-Received: by 2002:aa7:8b17:: with SMTP id f23mr1737594pfd.197.1581402035048;
        Mon, 10 Feb 2020 22:20:35 -0800 (PST)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id x197sm2578696pfc.1.2020.02.10.22.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Feb 2020 22:20:34 -0800 (PST)
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
Subject: [PATCH 8/9] mm/vmscan: restore active/inactive ratio for anonymous LRU
Date:   Tue, 11 Feb 2020 15:19:52 +0900
Message-Id: <1581401993-20041-9-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com>
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
index a1892e7..81ff725 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2237,7 +2237,7 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
 	active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
 
 	gb = (inactive + active) >> (30 - PAGE_SHIFT);
-	if (gb && is_file_lru(inactive_lru))
+	if (gb)
 		inactive_ratio = int_sqrt(10 * gb);
 	else
 		inactive_ratio = 1;
-- 
2.7.4

