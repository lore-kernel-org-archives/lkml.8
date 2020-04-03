Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095FAC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D172420757
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuVT/Cv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbgDCFlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:41:10 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50562 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgDCFlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:41:10 -0400
Received: by mail-pj1-f65.google.com with SMTP id v13so2534431pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 22:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RN7gf2lJmmbJD4X7vNri1vuhOhZQZ58Qtkt4COVm3Rs=;
        b=YuVT/Cv0HYSJnHhFYVelRiT86tny4w371FRXqoNWOXB0iMTdgj+ns+a9yzlxmlE3kE
         3a/QCiJBNed5RxrsEICzQ3lLaUd5bw0JuPV5AhSvnZuEkzZHC3L94ssgRaiQPtOxCf4o
         mlvTc4W2kCFD6ARGbn+USh46tZpvCQRwKQWozo80EN78lhqXexyCe3azXxCF4aRjKq9Z
         Bv4ftgqvn1HkkBqnrqpeW3+T04vaufXtJc0IVZQKvjjezcFLX/QbwTL2EGh2VhS+i4Gy
         dsUDDRqQv22qgUjk7+9Ln9w7aQFFIsC2Dh9ZI0Cnk9FtsErwSDgNMsmwNAT1kMvDm3Mc
         vmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RN7gf2lJmmbJD4X7vNri1vuhOhZQZ58Qtkt4COVm3Rs=;
        b=jfaGLqe1ow3+LRFBcJcveGAMl1imThh6sSO5PJ78SSyDUG6fZfazTH16hRJ9iK2hK7
         L6jtsd2g1maQ/zK0YmzsxGG91pai8jdh2fpWw2hzs7SGdZg5Cr4l7D8yAIISoXGucT1j
         4EeZ/nuZvmaLDMZT/GSK6qIXPmFdNIYpnNhUfTSHeh7jZlpMCbnYCt9D/JdErbiZTgtX
         Al4SqSSCH58V3Yq1Ub69N3WVlUlI7zG69gPK5LvCP0B4KFonDhJ8f9WwCSqUOkb+/2gf
         r1e3dAdR4kpYNBkel9biQmATCSaKeiF5a33N8XgaCSWNaRhrJIBndeyrM+5YkVPqltti
         GdfA==
X-Gm-Message-State: AGi0Pubo1OkqG3PG95spKhW5r3bBxblryQ55llqjDP+1ijTu6r/67dH/
        CLpiAm2H5+DMPZ6qwd4/M/w=
X-Google-Smtp-Source: APiQypKu4S0SXkza4knI9dCJAIFznblWWNuSMFbeXe+h5rP/ezeeX2uovQ0G8Wi4uqZkIz4wmVk00A==
X-Received: by 2002:a17:90b:19cf:: with SMTP id nm15mr7739445pjb.68.1585892469005;
        Thu, 02 Apr 2020 22:41:09 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id e6sm4568295pgu.44.2020.04.02.22.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 22:41:08 -0700 (PDT)
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
Subject: [PATCH v5 01/10] mm/vmscan: make active/inactive ratio as 1:1 for anon lru
Date:   Fri,  3 Apr 2020 14:40:39 +0900
Message-Id: <1585892447-32059-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
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
index 8763705..df92119 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2203,7 +2203,7 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
 	active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
 
 	gb = (inactive + active) >> (30 - PAGE_SHIFT);
-	if (gb)
+	if (gb && is_file_lru(inactive_lru))
 		inactive_ratio = int_sqrt(10 * gb);
 	else
 		inactive_ratio = 1;
-- 
2.7.4

