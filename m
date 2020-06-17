Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABE5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA525208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcY3ORY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgFQF0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 01:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgFQF0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 01:26:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D87AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:26:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h10so689958pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fNm3FGkY7NVgNGky8cgORMXuHncktdvkO+TFSQgkjpI=;
        b=DcY3ORY8xDdagE0AWcEaW+6hhR3H8CwMIoZyO+6Kk6Lc8LJrvv+GUHe0WVxyKRG0NI
         DvzZjBgyyqHQ2FEKaVHuW4mbYh2ZBesedtSubVk3wtmJTXTTf5o6gnDg/Lru3jz5Db/h
         SQfGsNHLBHQPEf+mN4iszszrtSYZRO5ZJEbTziTTpsJ6Fu53ZCyGWB+MoDwB7S4sHn2j
         Xozp4oqsXmfPUm+bUrpJCUPP+qcScSV2uhcKWSVmQDTtAB1JhEyAwAz8u1f9RMdT5KT7
         yPeq+/v9TiqjSuMBk6SBq4pHnduqd+cNGW1Okc5N8odI6knZg/XE080ut7HNimq4lKN1
         +iTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fNm3FGkY7NVgNGky8cgORMXuHncktdvkO+TFSQgkjpI=;
        b=En6aq/ZfHw/HxIT5EDszih1M5sRv2rZS/TntfM/DLRZxZJYPwUfcEacFvgI3d51q/3
         CyMEfHDAJPi5n0ptrxIP4PTcFF9ez2p/ldFuUJa7WbNbxg9YUUE5d2vjsZJKvyZV6lqC
         HJBuIzhkXvmTSbll7NrM9Of9DoG8jCDd4ni2O7NtImAFLxb+RBwQ72WvCH2XrrPhaXDw
         NlFZ89RdmxyEqdYI3NqUS9qVueQ9qfUR6Xh3NVKsnId/IK+HP3RGGFp/pBzwbetiqMKE
         n9fnoMMWUj3b2XGEhZauWM6EuTWIYnO4PVBy5Mfv8hjGiVYHZlxDW+IU2BMBVb8K9H96
         67gg==
X-Gm-Message-State: AOAM533cLnDjWD2JIlwevP7h0QHgtNXMSPs8c1VzrxbKEaVeNVaiEtNf
        /VK2lk1e98D1DtUFLK0r6dA=
X-Google-Smtp-Source: ABdhPJwtfBHaEiJIonwdo1j9yacX62+q/Jp6zKj9q+Q7JfsXgSeE351IKk3vnJ5BLJfOBYBDNclm4Q==
X-Received: by 2002:a63:5b0e:: with SMTP id p14mr5059100pgb.43.1592371602744;
        Tue, 16 Jun 2020 22:26:42 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id d184sm8830068pfd.85.2020.06.16.22.26.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 22:26:42 -0700 (PDT)
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
Subject: [PATCH v6 1/6] mm/vmscan: make active/inactive ratio as 1:1 for anon lru
Date:   Wed, 17 Jun 2020 14:26:18 +0900
Message-Id: <1592371583-30672-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
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
index 749d239..9f940c4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2212,7 +2212,7 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
 	active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
 
 	gb = (inactive + active) >> (30 - PAGE_SHIFT);
-	if (gb)
+	if (gb && is_file_lru(inactive_lru))
 		inactive_ratio = int_sqrt(10 * gb);
 	else
 		inactive_ratio = 1;
-- 
2.7.4

