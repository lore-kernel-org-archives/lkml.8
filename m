Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD24C433F2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B983020714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeWtf3J/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgGWHuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGWHuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:50:00 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BB7C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:50:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d1so2191148plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3HuTQ/JQezOnQWBclDWinVTSov3cMUHQQKMb60R61nw=;
        b=CeWtf3J/fe5CWpS/C02jYJTX+X0M4mhlH6qtW4J6oXHKNDwFC5AdatQ4KkFv7+qaY5
         WmAvWVmeRiEH/AEv1MdjKDMnnf8CVMHvuDvhgrRhk1cu6FvlDl/Cb5E9+6vUIzDxL3iz
         VlUf21Er7+02Yye9ivzDIFgnTCy5V9kAw656qTOCrPct6H5OzmiUJdQJKzZ2AYmUiVkw
         VqeY5yv/FsxXjNztlGCzOlrG9gFJ4WNLBrx3asqJjIMmRIdJ1nVIDHQXojSgm2WHKohB
         sHa8LAhfLxAbDxLP55J8jRqsnW0RBduvaUA3AXGY7ImmdJte7joxuO+cnHuPHjp2o80U
         I03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3HuTQ/JQezOnQWBclDWinVTSov3cMUHQQKMb60R61nw=;
        b=fNJt8Z3XFBmznvTBoMNRnFAh/X066PjKS13xidg+DXZRFCZobZOke88z1u9QFnOt7S
         O6E0/8g5OCwoDgCggeW/USeHgTp/zCiMsDtk9eDeeG7ERRXSC6ZSKrDWlJjmIezzOPcj
         WwC5kNYSkN8JSjwPqnsBvdNDA8BFc0Syjl5BUEkIdd3ssyWEU9FSgXDKFwUn/FJGQEGQ
         yRR2+vqBRr3dSQHoGA0HNBqQRIlazw/MwGLmoafeiDwO/D5ty2l3j6yQ9Od++dCz86sV
         ypXZacmzlzpAJCXWYNTiyM5574eS+zdMpjnRlVPetGuuL4N9nh6CVXTifvxL13JymvO1
         muxA==
X-Gm-Message-State: AOAM530lX8rRuxk9Z+6b/FIkDrT8o/rQNcwIj8FdNCG1J/vOtsRjrRQP
        LB3ExyNPgDh2pMA6VaO4fwI=
X-Google-Smtp-Source: ABdhPJz3wuro1emp72i5a+d23okpY576BgStha83cOxdM892LTC7weNec9VKSTTLT1fLG4E2MtsN5g==
X-Received: by 2002:a17:902:b786:: with SMTP id e6mr2928794pls.88.1595490599891;
        Thu, 23 Jul 2020 00:49:59 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id f71sm9164879pje.0.2020.07.23.00.49.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 00:49:59 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v7 6/6] mm/vmscan: restore active/inactive ratio for anonymous LRU
Date:   Thu, 23 Jul 2020 16:49:20 +0900
Message-Id: <1595490560-15117-7-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595490560-15117-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1595490560-15117-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Now that workingset detection is implemented for anonymous LRU, we don't
need large inactive list to allow detecting frequently accessed pages
before they are reclaimed, anymore. This effectively reverts the temporary
measure put in by commit "mm/vmscan: make active/inactive ratio as 1:1 for
anon lru".

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9d4e28c..b0de23d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2207,7 +2207,7 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
 	active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
 
 	gb = (inactive + active) >> (30 - PAGE_SHIFT);
-	if (gb && is_file_lru(inactive_lru))
+	if (gb)
 		inactive_ratio = int_sqrt(10 * gb);
 	else
 		inactive_ratio = 1;
-- 
2.7.4

