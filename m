Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0495C3404C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B780D24672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ijsd5XFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgBTFMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:12:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33797 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgBTFM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:12:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so1313618pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hUsW4h0Q2Yi32kJtCDyUXPnl4z2/9q9YG773fr2bDbk=;
        b=Ijsd5XFMlVWt+u3REu2ESkhMH9nwmtcDM+4DK8CMdHohtyBnLDFJ1omEsqUwaJ0eD8
         jK7xTiHGs1vQtvP6MxRGPhxI1TSLcP2sO6RXdcfz+BboZS8VP3hGZYTM3hAZ7HTjAV3H
         JbjzBYGEI3ht7gHuptnIQejt1tWuLt/ZcPZYsJqOcvv0yOvTNTJpp6LXemW+zbYSx2BX
         zV32/BBHyMql7pii+R8MRIQqFzAHZk9F9EDxMFCiK+OV82fYch0Ubc4hC87MQIGnX3BO
         Lc+xlfZDP0h6UWDcVKe5LrKk5MtB1r4By9jfmhJMSaQbBx48gHSFoY4Bx/+H6ET2rnQp
         quAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hUsW4h0Q2Yi32kJtCDyUXPnl4z2/9q9YG773fr2bDbk=;
        b=M6+eTjTiA8mF1ZKHsx+8nYqmn9cQNFj1R0KTtK2g7RFmt7Z/dXVj72tyKIZMrStly9
         xbTxItYNhM4iKJZFl+EJo3xz0IAnMKmW8GMjzdILabMXXjadCZo31UFx1JHJewBdeAgv
         TQjkH7t75zf5VN0nasvrjwqW+MFQ7cQjKDAnFaqoexo6csvp6IIsx4KjzlYhyeKz2XBc
         zNCNtBz5fsJ5VoEQwNvGFM5oYwFxS0Cd+LOWsdRGhrU656Wr+xcC99QBgbq1q+1D1Skw
         ccUjkE+wJTbfCH7BkYD9yLLa97VFjFPIwLk7B9sUbTm5Fgwhxtl9JLrW6QUaBvFQs7oD
         mUrQ==
X-Gm-Message-State: APjAAAX52pptXJMFKq90RGEVitoEOs6+bNe5RgH3Uy7WYq+ag2WNgWMO
        7hlQwXGMe6BI1Z5p+tCSrUY=
X-Google-Smtp-Source: APXvYqxqI48Q3YnoQIq/WkCRjYmRuXTeMYjou1J0gJkuAmMyIT8dm7CYIX7x2Cajh+nVlS7q4vl6fg==
X-Received: by 2002:a62:7c96:: with SMTP id x144mr31443823pfc.7.1582175548395;
        Wed, 19 Feb 2020 21:12:28 -0800 (PST)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id t15sm1472599pgr.60.2020.02.19.21.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Feb 2020 21:12:27 -0800 (PST)
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
Subject: [PATCH v2 8/9] mm/vmscan: restore active/inactive ratio for anonymous LRU
Date:   Thu, 20 Feb 2020 14:11:52 +0900
Message-Id: <1582175513-22601-9-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
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

