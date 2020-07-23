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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602EAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E0A2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qD6EyCZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGWHtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgGWHtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:49:42 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376F4C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:49:42 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so2198121pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1UCSqZniNnTE35feVIizYvg4RG2zVK/dCufRYKNlqjU=;
        b=qD6EyCZkACwRJmkSQcmtfH1KJCv+oDbD6kA6ZDtKoid5MwB7ln+eO8xv/pxxVuP6F2
         oEFyTzW+aYiHnS2rItKXGCGE3zSTgGx7D3x4vdzM3uf+UbeGDcCaa7u+yYiYaY88e+wU
         2wCYAAjN8L8ZMqGLuXhjLfk+NR+IpNp6fo5dCnc2rdXBJATUMXDc3LY7xvkcpq8lmUMM
         XNPx2ErBM8mrr7Q2wcovixdL2m/BKimi/8x/32QJQfJfqr00QfaTwnpCihu3nMXHlSVf
         tXNH2WZAS60llBQxSOR8auD2qiUm9o4fytDDM7nThC3cTKsEI9Mig5LDWGyLWlP232I6
         BoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1UCSqZniNnTE35feVIizYvg4RG2zVK/dCufRYKNlqjU=;
        b=dle8Mcc6t4iDaoMCSN4w3JA05yoJs1MdXpuUuL1x7f4sqIjVDcA1wHon5iHI+Bh4Wc
         seslMcFIrf4JwOGtN8atqU5K+bkoZvDoibADKN/PpT8vWlaP7ov+/CqS7xKgsYWiMfDb
         CT0zvN1fkD3OlVw+ss2jZCCb88ER1eYPJaqLfmhUtrViUAiE+xjWgLTeYW1ZKF3J51jP
         2DFrGkoKQaWaLilrYhc5NVZoPJboof70kKCtD33xLyB7f3JCkJ4ioKEHcMHjDCoHTWJQ
         0hIAZlb74hEMgxVNOz6/RNniXCxyzRtU12RfJYxRDd5O2Godd4DOtU8Gj4ctdv5K2znf
         bABw==
X-Gm-Message-State: AOAM530cg2dmJI0C/6kgxYTsvbL8FqLhip7SheNBLXtb2fR7/RMez6js
        RkseJetjRzQDcZ6jOXLdcew=
X-Google-Smtp-Source: ABdhPJw4ffA3MDbbGZ1G5Y9GV5noSdpTDkCNTSfbhFNZutuP4EPnEmzNdF3uLhTknqVaIMAYSgNTKg==
X-Received: by 2002:a17:902:8c86:: with SMTP id t6mr2901356plo.41.1595490581765;
        Thu, 23 Jul 2020 00:49:41 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id f71sm9164879pje.0.2020.07.23.00.49.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 00:49:41 -0700 (PDT)
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
Subject: [PATCH v7 1/6] mm/vmscan: make active/inactive ratio as 1:1 for anon lru
Date:   Thu, 23 Jul 2020 16:49:15 +0900
Message-Id: <1595490560-15117-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595490560-15117-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1595490560-15117-1-git-send-email-iamjoonsoo.kim@lge.com>
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

What following patch does is to implement workingset protection. After
the following patchset, newly created or swap-in pages will start their
lifetime on the inactive list. If inactive list is too small, there is not
enough chance to be referenced and the page cannot become the workingset.

In order to provide the newly anonymous or swap-in pages enough chance to
be referenced again, this patch makes active/inactive LRU ratio as 1:1.

This is just a temporary measure. Later patch in the series introduces
workingset detection for anonymous LRU that will be used to better decide
if pages should start on the active and inactive list. Afterwards this
patch is effectively reverted.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6acc956..d5a19c7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2208,7 +2208,7 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
 	active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
 
 	gb = (inactive + active) >> (30 - PAGE_SHIFT);
-	if (gb)
+	if (gb && is_file_lru(inactive_lru))
 		inactive_ratio = int_sqrt(10 * gb);
 	else
 		inactive_ratio = 1;
-- 
2.7.4

