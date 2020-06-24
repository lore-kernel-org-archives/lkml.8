Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CBEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14889206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl9izeas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404288AbgFXPCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404241AbgFXPC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:02:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB85C061795
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so1158118plq.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JWnneQzXfI0UCqfkUaeoAs3ig549rm/MnU8+no9mpQ8=;
        b=Rl9izeasMTckdt53HqfGTVXn8hAB7zTLsVPwhL7+DoOPgmHJ1jZcR0+vO+ug/jMR8p
         25vwgeyf8U4dsLT36Ix4duFc4Xdof7G2CRr2xeT6SLQ1oW7b3xgbKjJjK7xoJ3qDsRa1
         7adwN/K8ocUYxYMT4i34qZew5jTojr2t2rUUEaIEoWhNQwbDjENmYFLC0iOTJH4cz2Au
         YQHtwNAqlbccLU3Q//01FIhA8ZaSS8xKarSyfsautTo8m90ExIUerNO1evzIH70Da7Bu
         nXjpAuFY81AEyUX+MZ9NgJg/EE5HUVE3UYUSi1XMQFXN6jgozXTKUO4QpslpVQoXoKzc
         8Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JWnneQzXfI0UCqfkUaeoAs3ig549rm/MnU8+no9mpQ8=;
        b=Z1NwpLUsG2lCuxVA3wBIIpEr4tHKy/o9X1L5ghNuSJr4/dhxmediIJc6u4XWgZYxqi
         re45Lm/1WTtGSRDAkkRNDA5uad+ThTqX5HB5uZGx3uXyhZT/8V0TQ1ivjqnTCSA/tEAi
         Aw3FsYXQbX4vcFSwkgY5SXznh16ZQUhRIqpQzoMM5Gl6CEcYAkHgzGEan87FRRV2MXSv
         CffVDf1thOPD04ao+4sqSOevdRM0YEyHPjXJCaArTP7/8E/6xc5W9NDtzE8qnuCUmrJ+
         fTFNcUVAq6lM5QaWlVzRWa79VZkqaTnl/ZRY8xwqMwqnvFYBxuQbSWuB3P70EHak+tjW
         wfjQ==
X-Gm-Message-State: AOAM532Kzv7BCiNWwIEeZWiLd24xyqvIzTHQtSmh30kZ7dDwh+zlfcCB
        XTmaa/YTsV7SOdejJu3PaQ==
X-Google-Smtp-Source: ABdhPJxl1PHw4LkPk6lT5aYG/XIcClNITVvyBSM5EkGGToos6HlxyHE06skpVZArpn/F/RPE11cC0A==
X-Received: by 2002:a17:90a:3608:: with SMTP id s8mr29753490pjb.86.1593010948525;
        Wed, 24 Jun 2020 08:02:28 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:02:28 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/15] mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
Date:   Wed, 24 Jun 2020 15:01:37 +0000
Message-Id: <20200624150137.7052-16-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

memory_failure() is supposed to call action_result() when it handles
a memory error event, but there's one missing case. So let's add it.

I find that include/ras/ras_event.h has some other MF_MSG_* undefined,
so this patch also adds them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/mm.h      | 1 +
 include/ras/ras_event.h | 3 +++
 mm/memory-failure.c     | 5 ++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git v5.8-rc1-mmots-2020-06-20-21-44/include/linux/mm.h v5.8-rc1-mmots-2020-06-20-21-44_patched/include/linux/mm.h
index d708033c50c0..10ee48f05f68 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/include/linux/mm.h
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/include/linux/mm.h
@@ -3033,6 +3033,7 @@ enum mf_action_page_type {
 	MF_MSG_BUDDY,
 	MF_MSG_BUDDY_2ND,
 	MF_MSG_DAX,
+	MF_MSG_UNSPLIT_THP,
 	MF_MSG_UNKNOWN,
 };
 
diff --git v5.8-rc1-mmots-2020-06-20-21-44/include/ras/ras_event.h v5.8-rc1-mmots-2020-06-20-21-44_patched/include/ras/ras_event.h
index 36c5c5e38c1d..0bdbc0d17d2f 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/include/ras/ras_event.h
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/include/ras/ras_event.h
@@ -361,6 +361,7 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_POISONED_HUGE, "huge page already hardware poisoned" )	\
 	EM ( MF_MSG_HUGE, "huge page" )					\
 	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
+	EM ( MF_MSG_NON_PMD_HUGE, "non-pmd-sized huge page" )		\
 	EM ( MF_MSG_UNMAP_FAILED, "unmapping failed page" )		\
 	EM ( MF_MSG_DIRTY_SWAPCACHE, "dirty swapcache page" )		\
 	EM ( MF_MSG_CLEAN_SWAPCACHE, "clean swapcache page" )		\
@@ -373,6 +374,8 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_TRUNCATED_LRU, "already truncated LRU page" )	\
 	EM ( MF_MSG_BUDDY, "free buddy page" )				\
 	EM ( MF_MSG_BUDDY_2ND, "free buddy page (2nd try)" )		\
+	EM ( MF_MSG_DAX, "dax page" )					\
+	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
 	EMe ( MF_MSG_UNKNOWN, "unknown page" )
 
 /*
diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
index 9ad3198a3954..e57cfe0606f5 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
@@ -586,6 +586,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_BUDDY]			= "free buddy page",
 	[MF_MSG_BUDDY_2ND]		= "free buddy page (2nd try)",
 	[MF_MSG_DAX]			= "dax page",
+	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
 	[MF_MSG_UNKNOWN]		= "unknown page",
 };
 
@@ -1376,8 +1377,10 @@ int memory_failure(unsigned long pfn, int flags)
 	}
 
 	if (PageTransHuge(hpage)) {
-		if (try_to_split_thp_page(p, "Memory Failure") < 0)
+		if (try_to_split_thp_page(p, "Memory Failure") < 0) {
+			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
 			return -EBUSY;
+		}
 		VM_BUG_ON_PAGE(!page_count(p), p);
 	}
 
-- 
2.17.1

