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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74630C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529F720810
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke+T326W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgFPGRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPGRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:17:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830E4C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:17:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so7904633pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+mAleJzVkSxUosovywb+7ljzVkP2vTSQez3hnVAhNGA=;
        b=ke+T326Wc9k34rBsRaKh3aelvN0w/k+7qe89563ML025wKi5jo7dUaN3cegrsRxCbq
         xnyEa5sZMARRF07GdU5eoLf6yPnF5gpagxkS24FYKtghFn4tm8xyq816tZ0Bgw/Z0WRG
         cixP3J8ae62RxKczWBfP2P8kSOP2wF27tHAQcsc9/NDsUxTFifu43tZLMYhOMAeYAJTM
         02J3g8/9E3MgCMurS+i5qJScyivNml48/e4A7QIPccaHgW++9o9pcF6gxtdyKzmFjE0a
         VoE5NlsQ6mWB4OFPoMjcdFW4flTv7WwTHYgUp6oOK+OHgb+EOB8RSqNRUujlofoFovSx
         6PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+mAleJzVkSxUosovywb+7ljzVkP2vTSQez3hnVAhNGA=;
        b=Ijik7SbwZDIqC3Run7IQqCjU2op+AYNUHd7FV858BruOuoy0I8tAIPfGcgsDl8G0Pd
         gE59HiK+4h642GA8yk+UAMPBDWPTdDBFXsgO35A5B1FD+BPaqWr4vovaSZQ0UY0dI1zi
         wqp8nI7HCUdXWIs+36/bNACmszY2NnrLgIjend1mbbm1YAK2iHu8Aem66lfCWAtwYnxB
         X/0+WFEJA7VXUR1DUNultlXmH86FjGZrB2cyJ8aZF85IfWcTtePxLfe7gt6VoHJ9clas
         wBM4VE31t+k5qisq9JWZBdC0Qpztj41a0ZMXReq8vmTjNGN2n4rxbkrdVOqf5fjNiVBl
         3xiA==
X-Gm-Message-State: AOAM530bl9dzG5twlUKwMn9B5BNM6j79yBxkx51Wfx6OFm91oU/xPuR/
        GrSZ6E8jK31mZORRKy/Xg6g=
X-Google-Smtp-Source: ABdhPJx7l5wUPRIz5BbpAdlrmiWn7Dg89V4w2KP8qRNOpDvNFiJpUPCfk/CGNWGyVjD2pZtSnEq7PQ==
X-Received: by 2002:a17:902:b212:: with SMTP id t18mr738007plr.219.1592288228932;
        Mon, 15 Jun 2020 23:17:08 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 207sm15449267pfw.190.2020.06.15.23.17.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 23:17:08 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH for v5.8 2/3] mm/swap: fix for "mm: workingset: age nonresident information alongside anonymous pages"
Date:   Tue, 16 Jun 2020 15:16:43 +0900
Message-Id: <1592288204-27734-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592288204-27734-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592288204-27734-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Non-file-lru page could also be activated in mark_page_accessed()
and we need to count this activation for nonresident_age.

Note that it's better for this patch to be squashed into the patch
"mm: workingset: age nonresident information alongside anonymous pages".

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/swap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 667133d..c5d5114 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -443,8 +443,7 @@ void mark_page_accessed(struct page *page)
 		else
 			__lru_cache_activate_page(page);
 		ClearPageReferenced(page);
-		if (page_is_file_lru(page))
-			workingset_activation(page);
+		workingset_activation(page);
 	}
 	if (page_is_idle(page))
 		clear_page_idle(page);
-- 
2.7.4

