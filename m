Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930C4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7377120810
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZvwL/pq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgFPGRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPGRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:17:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D7AC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:17:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g12so7914215pll.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D0g2Zexmxg2oUoAy0qKEpYCw2yFMuRTQ0zuH6SkQeSY=;
        b=EZvwL/pqQUFmftZMJwsT6Nh+iHePfWMkBZZ3jamWdPjuCY0/AtBONRXTvF51Y3lFQj
         TOJyeflmZone8HN/oO1ZPspofS0tayc0TANM+7CDfRPFV53RS0d1hW1dZM85WOr30ONN
         BWgd5jK5TJ2zykOEsOw0Qq0WvSZJH0HuDJQzYpvTeXwJWLtL22Z8qNp61ZDhT7Q5CCSM
         IDZC+2WvcPTeOtgqClMkfl76HW1LCJ2qPGTiTDRtZ58QhmnhkK2fsVL0CTvI61v/M5kN
         0YZLelvQk3PDUNxztZ0OHQwNnTb80Ndyy75oKBLTj0X2fZrmTEnlceVWl5AjQUUyOPIw
         CtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D0g2Zexmxg2oUoAy0qKEpYCw2yFMuRTQ0zuH6SkQeSY=;
        b=UpPDzDDGB5I5n5TFs+8NIyqU93NaVjQWhNNrVPvxxfIhEkjAJ6EoodFfdvaKYm+R/Z
         Pcdg0WeGjTKt3g6wZjW44+PrShqB4G3KcUCb2qa9yp1PVSGQA3VWL+nA/LxOAvmG3dMs
         lhREbyi8U7d233egXlYiaUm+XRPCyn7accZZErBNAQSdsO5clueJ5HokpAw185QA/YjI
         ESIlABzUqrXRP0tIY+xySmGB5BetBTEK5COiMCqe9vHouN9GC3QXrOrLZRTFtnMgqnw/
         PAWdwwV8j3K9PMkREn2GQvB1v5iiKI6Jpcg/obsofUcfhTD0RnYDqbd75dfr04ywlsMR
         RtZQ==
X-Gm-Message-State: AOAM530wWGNSrQMDc6vSEWYxKNAbJCaSEVobZVAk1ismA7ddAhNfn7vq
        mI1EzN86l7kA6E/ksRVovMg=
X-Google-Smtp-Source: ABdhPJxNnZ2/d1gAp5R+TWlPIKv38Wg0ebQAMM/x6H03Y07lJITErW54jVn8l/mm+OtafQ1Y2lzNww==
X-Received: by 2002:a17:90a:9f81:: with SMTP id o1mr1291945pjp.139.1592288231638;
        Mon, 15 Jun 2020 23:17:11 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 207sm15449267pfw.190.2020.06.15.23.17.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 23:17:11 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH for v5.8 3/3] mm/memory: fix IO cost for anonymous page
Date:   Tue, 16 Jun 2020 15:16:44 +0900
Message-Id: <1592288204-27734-4-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592288204-27734-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592288204-27734-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

With synchronous IO swap device, swap-in is directly handled in fault
code. Since IO cost notation isn't added there, with synchronous IO swap
device, LRU balancing could be wrongly biased. Fix it to count it
in fault code.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index bc6a471..3359057 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3143,6 +3143,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				if (err)
 					goto out_page;
 
+				/*
+				 * XXX: Move to lru_cache_add() when it
+				 * supports new vs putback
+				 */
+				spin_lock_irq(&page_pgdat(page)->lru_lock);
+				lru_note_cost_page(page);
+				spin_unlock_irq(&page_pgdat(page)->lru_lock);
+
 				lru_cache_add(page);
 				swap_readpage(page, true);
 			}
-- 
2.7.4

