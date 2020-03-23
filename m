Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1226EC54FD4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D637E20774
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qir9PLF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgCWFw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:52:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45308 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgCWFw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:52:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id b9so5455752pls.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 22:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bs9uueH0blNyu1UBuP0fQK6SW+2/EajcrnZfP/uZxx8=;
        b=Qir9PLF33Ng5Lj3XADyW+LntTiZ6vnLYv3JMHBnICF+CG575H5klswKFi+hfrJgzUy
         1CKWjMYT8s51Lpjf4jJAGWnOldtEI8PuhtzUBlTMN1O7EZxAC0vPRg5FwlfsjwvNXrx8
         ui+pAznSrunnWGov60060Trope/AWLBKMnENsYPAALAli1WgpLD/JPVai8NukSUyVnKl
         6b253t2EUj/ONBIaghC6QXmhGIqinCPEsVnOK7eKvOvN9HYxj5MPvLNb5p+/VNJz0FIc
         stReR6Qdu7c5CXaj207Qfvqxta8p3dQe4zDZiS9ldZOYgsoqpSCG2GixPSUdFHMN3/pV
         780A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bs9uueH0blNyu1UBuP0fQK6SW+2/EajcrnZfP/uZxx8=;
        b=rjU2tb3EuaHpTOlmyqSe6mUIj+Q0BybhDAf7YCCVnK1Vka89YqoUGMr4o+X8yMe+at
         yYhYE/NIWMWHTp9MQbv9qmNSwH81hkskraV41ipbelh+Au6+t1tCktOAm5Gsnm8hzteM
         14GSFKQ3FTmfnuX65jNhCPYJvA895TcQLSTLFo33MJ3GI8amAOFWjWDK7DHPEwRaf2hQ
         ydmtKDcdbrhX6i33xB86rI3//L7zk7crVP38EPlH29ZJHCUuU6iCy0GGl3wHzHag9vbi
         Dj5fLrckXeB6RvQqxygkkxeByYqH/nlfNQQ5Km/iaosoCiUGsVwVjgdmtQowryrIJc29
         XA6g==
X-Gm-Message-State: ANhLgQ1rkygLYKmJESwNB1Dwv0VdfrXGs/anWlGNm9qcecwXR31KVMHO
        9gCv0xw7S1ieAEM24w8rgg4=
X-Google-Smtp-Source: ADFU+vuzird/5rQcdmAFYzXID8FO2PLNyrazWn68ripd9cs2SNTAxvfsmjDyYomHo93k1G/GZgrxbg==
X-Received: by 2002:a17:90a:a40e:: with SMTP id y14mr14654850pjp.63.1584942773645;
        Sun, 22 Mar 2020 22:52:53 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id y30sm12563058pff.67.2020.03.22.22.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 22:52:52 -0700 (PDT)
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
Subject: [PATCH v4 7/8] mm/vmscan: restore active/inactive ratio for anonymous LRU
Date:   Mon, 23 Mar 2020 14:52:11 +0900
Message-Id: <1584942732-2184-8-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
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
index b37cc26..3d44e32 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2218,7 +2218,7 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
 	active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
 
 	gb = (inactive + active) >> (30 - PAGE_SHIFT);
-	if (gb && is_file_lru(inactive_lru))
+	if (gb)
 		inactive_ratio = int_sqrt(10 * gb);
 	else
 		inactive_ratio = 1;
-- 
2.7.4

