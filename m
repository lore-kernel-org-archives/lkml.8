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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEB4C11D41
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CCA2467C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vS9cyEBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgBTFMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:12:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38826 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgBTFMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:12:06 -0500
Received: by mail-pl1-f193.google.com with SMTP id t6so1063535plj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PQRul9eP+ZS9HAAeaH8frtjB2cUDoTj2pwxbGJPwV4M=;
        b=vS9cyEBoFKHWrvPtC8OZbasab9nwtANJEc2h/q7eGSEO/A8dvE/mTKAkuqj+zTDTN9
         Cs4cLsQXcT04UMBCZrQjxhWzMjMgLJAss8G6lFcYlAnbenm2uW9xuU4Zrs0m9q0lVgCh
         uUzoiVJtFMuXMRp8tD1xeFozEpo5KxFkB4eUTnbv+y3eds/b0NarnANwBnxovD0eUl8s
         uMWSBE+u0QJChZ/sjKvRpPk7fAd0mc3yGnRE5sxkZnj9kIf4jR+V8OBTQwng2gebMrO6
         HTWN10EWR1icagTx793SLimADUlVsZireXGhMXKp1RkZ9IdZ4aTf/2G/ZY7iJhtnKCiC
         E7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PQRul9eP+ZS9HAAeaH8frtjB2cUDoTj2pwxbGJPwV4M=;
        b=OdpIgZa55zUVHazD/0ZUorlmvcSboeUKE86m3j3YF9k2ba1yPNvScb784N0XSmCKiY
         aXMzlkBi2Gf5F4co8WPhSNondzH3+ZQLi5qRQVcIEBynw2ooffiFwpJKYfkaCMyS93/m
         Bs1BvUDxSXS+tyMwjDXmKTFPl0B97kCdKzsGtwbbNmoU74WuG/5UlSiQvg2hQwU9UW71
         Tww8lkOwwM9GwtWW0K2Unv77e5GIYZqnX4Q5Od5OfFFF2gUI4bZ7PO/6yat03e2nv3u7
         NYEaRH43RE2NzvQHULV9D6LmBzuEqFVuu9t2+KOEbeAj65CYq+XqEhGLmP63CUqtIK8B
         KFAQ==
X-Gm-Message-State: APjAAAXR6Yqip6SM+Do2n19Eus7gVXWT0j/3TS20Yji9s01jQbgCLKhA
        1DXkH12cqaKKoZcBy7S4HHs=
X-Google-Smtp-Source: APXvYqwlItaUvBIwBji0ySYidzcULBRhxfBK5nO3HiwVvqD6yf5AqAnxqkgIZL+joHyMTp8fVbDC2w==
X-Received: by 2002:a17:90a:234f:: with SMTP id f73mr1457975pje.109.1582175525753;
        Wed, 19 Feb 2020 21:12:05 -0800 (PST)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id t15sm1472599pgr.60.2020.02.19.21.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Feb 2020 21:12:05 -0800 (PST)
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
Subject: [PATCH v2 1/9] mm/vmscan: make active/inactive ratio as 1:1 for anon lru
Date:   Thu, 20 Feb 2020 14:11:45 +0900
Message-Id: <1582175513-22601-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
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

