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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0B8C2BA1B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DEC208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9IKbbWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbgDCFll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:41:41 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34584 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgDCFlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:41:39 -0400
Received: by mail-pj1-f67.google.com with SMTP id q16so594033pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 22:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mG2V4EKWwLpm65cedW0xiBMYuTKohTKduGAcO+0CPJM=;
        b=p9IKbbWmo+8ay7jVcXtAJ6529VfEyJiUqf737Pl6QykFrIYG3kbMKiyH/JfBVGIdEu
         xoS4Ij+yPz0Z7pP/3/xvyLjOPcHSABr7l1J+voalSVUTcRrjdAwWjAiiGP2stspITrL3
         m/sUXF9YBDiqg5CY1wHuOl2v/8vKyEjFgQGzG6LaD/jJtJJy2P+PAOWaWiBcKuzqNGN9
         twj9KQkpDOAti15kOgHbolqV+ZbPli8B0GfHpUdt4uxhDWnXDvMnNuMlJVKy2Yr2csdh
         7Hl+kUMZSX7PGTcmelYMFstVLpjw7AYh5O9HiI/1KtEZLQ1nJEVyPCTVl7Dci09lAT5B
         +oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mG2V4EKWwLpm65cedW0xiBMYuTKohTKduGAcO+0CPJM=;
        b=DBYSYA6yBvQ+yojkSI1rbnGk7scAeaoJ/0Je6Lh31VMwgeF4YTFKlAnZIPLxebgTYx
         5sEF7gvLT5qdnjdm4+6AR2kmRT/DlNhRk2uaiBylgPXmqT6gJJgdh5TS3Sd65dx7yGbg
         l9ROF9N9zlLoiJXRZfN+gmxB/bZnRRM1Fy80iAotOiNlucziq/G/Nrmk9ZRsIfc9fq3J
         D1AkqKeOqzvkv8d2eum8My45uqSGaOJQQAklz9mJVRvhJjcaV7a87CRHuuF4q1DvDDBj
         IggxzGrUrg2ls6sb8SU9kb8VQtxBoa0DtQzLhwFh38l87csvFwqTUb2Ok6nIeyMwedQO
         k1Nw==
X-Gm-Message-State: AGi0PuZEZkytKwDRmtUJ/g6jRZ/lbFEl5vBr+s/BSYrsnpypMObLVIvo
        WL9x75JKy02VtwekSMyzu0g=
X-Google-Smtp-Source: APiQypIBtThaBXq8TI/cXNf01mMd+DoVHNDKsIXJoa871gdbLpCj4JU6yTLpoe94AdFtrBmoC3OItw==
X-Received: by 2002:a17:902:dc83:: with SMTP id n3mr6251826pld.133.1585892497213;
        Thu, 02 Apr 2020 22:41:37 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id e6sm4568295pgu.44.2020.04.02.22.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 22:41:36 -0700 (PDT)
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
Subject: [PATCH v5 09/10] mm/vmscan: restore active/inactive ratio for anonymous LRU
Date:   Fri,  3 Apr 2020 14:40:47 +0900
Message-Id: <1585892447-32059-10-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
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
index d8aa42a..9c5d20c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2204,7 +2204,7 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
 	active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
 
 	gb = (inactive + active) >> (30 - PAGE_SHIFT);
-	if (gb && is_file_lru(inactive_lru))
+	if (gb)
 		inactive_ratio = int_sqrt(10 * gb);
 	else
 		inactive_ratio = 1;
-- 
2.7.4

