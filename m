Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB648C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A1020853
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnsDu/n7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgFQF1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 01:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgFQF1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 01:27:00 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28366C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:27:00 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k2so452588pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1xjkUNXRrltW0v367905hcdOUoCgRbDmUvJ+4nENETw=;
        b=EnsDu/n7ObTOMuNzMgWv+/zLljv5adhFJhPwWDW0B+zK20kJONNEtDVAGtRUm+eNdN
         yFiJ7UJqUa51Gynnn8GlKK14oTD4h7g0VEOiEsXn2rVeLyUdbvJbCjaJHCsiRKFsTlXz
         1FWIAGZYRNj/Z7jwW8YM6sqyPkrV5ca3trdH2iAJbi7J0wvX5sMLVP0N9BoXjbqWLLpu
         jJ9VIOgjoL562ZRdzLEL2bRA8dhfzZqrvecZYMLi/1ifbxpmalhtwJHo9Gjp/MeZN23v
         b5lHMeEy9GcGCNTfkeF4AyFDOqmn70EIg3NorqBg2xZCPU8uUZXxqjcC4kDK6WzqoMMg
         6rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1xjkUNXRrltW0v367905hcdOUoCgRbDmUvJ+4nENETw=;
        b=SDOVrGHOLFd6d+TTSvMwf3PTaHIzgIq/4inEFRQLNypDJFbFMJ3ykhAM2B7iUoL+Bk
         RanYs7pL4z1JVcBhC0StsYaUBOX7co5zEcYWztsbjSOknaipzmeXEaViQQiCSjhuJm9c
         WXqtmiw+hqApj+P9paoyzfaPYkRbaOY4tzgqzagRP7FWDx+ZXCA8FyBkk2Kl7lzEMi/I
         m7jCmy8KgNlwGYYj4rwZEU55ALz/uYP4sD+mwDY8x06+LIMx91ioep8mqQgAW/JomWCF
         xbXWSpkY+X8YMB7dhlV2u2/hoQXu35ViHShZHiRSud8yBLoSzcN/4OL5C20z9kpnIZoh
         vCjw==
X-Gm-Message-State: AOAM533krJZ4mh3CjLii4X0LCVYSn0JT2Z2QywWGhMckhDGyfd2J6RXX
        VL3aZAADJEGJnVokYv/zb90=
X-Google-Smtp-Source: ABdhPJyXLZtdfd5w3dIrNxpAD+EcH91c6nLcyKwApnjCfWiCWHpzt+5xo/Beb011cKcVfXvfO09q3g==
X-Received: by 2002:a17:902:6947:: with SMTP id k7mr5232713plt.258.1592371619698;
        Tue, 16 Jun 2020 22:26:59 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id d184sm8830068pfd.85.2020.06.16.22.26.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 22:26:58 -0700 (PDT)
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
Subject: [PATCH v6 6/6] mm/vmscan: restore active/inactive ratio for anonymous LRU
Date:   Wed, 17 Jun 2020 14:26:23 +0900
Message-Id: <1592371583-30672-7-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Now, workingset detection is implemented for anonymous LRU.
We don't have to worry about the misfound for workingset due to
the ratio of active/inactive. Let's restore the ratio.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index eb02d18..ec77691 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2211,7 +2211,7 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
 	active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
 
 	gb = (inactive + active) >> (30 - PAGE_SHIFT);
-	if (gb && is_file_lru(inactive_lru))
+	if (gb)
 		inactive_ratio = int_sqrt(10 * gb);
 	else
 		inactive_ratio = 1;
-- 
2.7.4

