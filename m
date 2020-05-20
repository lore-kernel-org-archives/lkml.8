Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE9DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C2D2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ztU73FgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgETX0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgETX0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:26:13 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2352C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:11 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dh1so2223907qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1mJyFxqpgpRzCt8CICzuJvDAagkfPR/HMnvDC6JCyY=;
        b=ztU73FgX01oSp/NMDzA3s6wLAWqemke1edTHLBlfwK9d2FVAn7pD+tArAISYdGoz7L
         Ypfr5EHdNe9un0Ie+AMD5IE3dm8h3CGusgw8hsPu9ZUkXVG8A51EaAffxsk5T8iiWFAe
         xtiaaL5aQURwIyCVnz5CyGKiPgfPVsamum8BJ2c5ofoLUyoiXENrOdR+1uWnUSbKXPBg
         Ff0B+cycL5NqIdYQs2aD/eFO88CRg0vYo1gIEcjYRcGHPnKueMcv/yv5jd7nRU09os5u
         t7ma1B4qYkHr6/J8Qjog9NU4MXUf45aePH1niFKtNgTZxnfzY31ZKSQajZ0tIwE3Rbat
         lHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1mJyFxqpgpRzCt8CICzuJvDAagkfPR/HMnvDC6JCyY=;
        b=JDKQfELv9BkO+0h04aA0x4rWI0OaLqjwI/ihc5vMhNqmJVciIsRCpGCCgpn4UWpLqK
         NC6JiIV/42L5LZpSOjqTbMXc0IgPFxVqgVnPgPMEcKFyGXg4ctA+6Q/bv4t1tNVVU0Jv
         3XmvOqxtpIPaAGf4MTXqY9a8LlVHJ2HaIeOEeFpKheSDtw9qdrfB3pS5srSlCr06wt5E
         SDmYBTqc7i4Vqz8FgXbRHMROl98QDUYTdMqsRJYtIh+bOukt0hE0yCQQKt/ZqNayyq5c
         9liD/H6Iz6lmzTjPOqVaqv7yBM0kIMlgkQkZV6SCvm8atKQBKEmhapYqdvnm7HWp9x5V
         qkDg==
X-Gm-Message-State: AOAM532WvcJrTrdKYws+ZVy95Vk57lP8yn8q3QRmUTIY8aXoekRE7kJk
        0IGGs/m6t3nR/IHfF/Uejtkwqw==
X-Google-Smtp-Source: ABdhPJwIoVni4xkak/KSGtFyIkrBv+2cj6B2hO1dZHEdUPHsdcUxiqPFz+TFg6pubttpAcmk8zKYXQ==
X-Received: by 2002:a0c:f407:: with SMTP id h7mr7159580qvl.116.1590017170707;
        Wed, 20 May 2020 16:26:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id j36sm3921691qta.71.2020.05.20.16.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:26:10 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/14] mm: vmscan: drop unnecessary div0 avoidance rounding in get_scan_count()
Date:   Wed, 20 May 2020 19:25:18 -0400
Message-Id: <20200520232525.798933-8-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520232525.798933-1-hannes@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we calculate the relative scan pressure between the anon and file
LRU lists, we have to assume that reclaim_stat can contain zeroes. To
avoid div0 crashes, we add 1 to all denominators like so:

        anon_prio = swappiness;
        file_prio = 200 - anon_prio;

	[...]

        /*
         * The amount of pressure on anon vs file pages is inversely
         * proportional to the fraction of recently scanned pages on
         * each list that were recently referenced and in active use.
         */
        ap = anon_prio * (reclaim_stat->recent_scanned[0] + 1);
        ap /= reclaim_stat->recent_rotated[0] + 1;

        fp = file_prio * (reclaim_stat->recent_scanned[1] + 1);
        fp /= reclaim_stat->recent_rotated[1] + 1;
        spin_unlock_irq(&pgdat->lru_lock);

        fraction[0] = ap;
        fraction[1] = fp;
        denominator = ap + fp + 1;

While reclaim_stat can contain 0, it's not actually possible for ap +
fp to be 0. One of anon_prio or file_prio could be zero, but they must
still add up to 200. And the reclaim_stat fraction, due to the +1 in
there, is always at least 1. So if one of the two numerators is 0, the
other one can't be. ap + fp is always at least 1. Drop the + 1.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 43f88b1a4f14..6cd1029ea9d4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2348,7 +2348,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 
 	fraction[0] = ap;
 	fraction[1] = fp;
-	denominator = ap + fp + 1;
+	denominator = ap + fp;
 out:
 	for_each_evictable_lru(lru) {
 		int file = is_file_lru(lru);
-- 
2.26.2

