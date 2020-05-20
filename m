Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525EAC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2029E20899
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="hpPggKJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgETX02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgETX0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:26:22 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC1EC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:22 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id p12so4054011qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y1gbv98UFIo3SZ72LRLIih1+wdVTAGD1gNzI7HeJpHo=;
        b=hpPggKJV3g/zDlX6q+IhjzuaavboPvYaqmrBUzXq9ZuPMM5ClP8Bg1in2XIQ9orriE
         C3/fOi2brri7XodOhZcMTWfdRuq9LwXxZYJxLvZ+Ht5koUY1VFZ3AzkUVKxMwi330Gxv
         mVC7DJPtGzV5OUq+Xq06kmHZBrnWm4DjETEOTBOqK0WFjGIYMvQFk8Ghbw+2G5CELACD
         US/WZx6T8fOw2RdBM2kdBYcP8oaAV1GpYueK7oj7VZz/GEL1gJha+42iQCDigfZX9qPm
         nrC/AXRbipE8QvX3yfiJgY/Ye36g5GgmfjtVLl9gC1u+mb+PMdEBjUd6SFV5M19yghd4
         Cjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1gbv98UFIo3SZ72LRLIih1+wdVTAGD1gNzI7HeJpHo=;
        b=QwI3tTxSRJzns28imV8X6fvSmkq/h6tvXDuVvxVdcwq+IYCKJG7fAlCqv/t3Z68KlT
         bg+Bx8RmKq1+AYY/5+OcL0GmE8rV4RDe9jBELp7OuvAYK0kGyfiXKIdKZ4r/v1aKO7TB
         gkN0rleiceOLquYD6tF0yKKttSjnpRnEHRwuOh6caVUEqVw4+r5CvyaLSiBJECsf8mM/
         K8fciK8V9BSFSVPJn5NLLKgyAETfzb30dggiON+U0pC/uRUL8AbR+ME8tdXLzRMWoN4G
         NSShj07T+TY5xiP+WNRvBxX50toDrBCdNl9GcCh5mdl25m1Rudq2Q3pT7bqg1D7PtnfI
         RWiQ==
X-Gm-Message-State: AOAM532qvRtfhfZc/ZMOZcW22aqQ48CKOjNaGNtdbE7avX+O3DpuKyy6
        n3AzrTjeR/PoWQAI0oWSAxP18w==
X-Google-Smtp-Source: ABdhPJzwApchXPfv+uLAF0ZuP3Mw5WX1lotYMFwoUQTYCPT/AwiqdCElwWXi1OQ68cMyYPQz/b88jQ==
X-Received: by 2002:ac8:2dbc:: with SMTP id p57mr7872466qta.280.1590017181716;
        Wed, 20 May 2020 16:26:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id o3sm3597138qtt.56.2020.05.20.16.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:26:21 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/14] mm: vmscan: limit the range of LRU type balancing
Date:   Wed, 20 May 2020 19:25:25 -0400
Message-Id: <20200520232525.798933-15-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520232525.798933-1-hannes@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When LRU cost only shows up on one list, we abruptly stop scanning
that list altogether. That's an extreme reaction: by the time the
other list starts thrashing and the pendulum swings back, we may have
no recent age information on the first list anymore, and we could have
significant latencies until the scanner has caught up.

Soften this change in the feedback system by ensuring that no list
receives less than a third of overall pressure, and only distribute
the other 66% according to LRU cost. This ensures that we maintain a
minimum rate of aging on the entire workingset while it's being
pressured, while still allowing a generous rate of convergence when
the relative sizes of the lists need to adjust.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5453b4ef2ea1..c628f9ab886b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2237,12 +2237,11 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 			   unsigned long *nr)
 {
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+	unsigned long anon_cost, file_cost, total_cost;
 	int swappiness = mem_cgroup_swappiness(memcg);
 	u64 fraction[2];
 	u64 denominator = 0;	/* gcc */
-	unsigned long anon_prio, file_prio;
 	enum scan_balance scan_balance;
-	unsigned long totalcost;
 	unsigned long ap, fp;
 	enum lru_list lru;
 
@@ -2301,17 +2300,22 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	 * the relative IO cost of bringing back a swapped out
 	 * anonymous page vs reloading a filesystem page (swappiness).
 	 *
+	 * Although we limit that influence to ensure no list gets
+	 * left behind completely: at least a third of the pressure is
+	 * applied, before swappiness.
+	 *
 	 * With swappiness at 100, anon and file have equal IO cost.
 	 */
-	anon_prio = swappiness;
-	file_prio = 200 - anon_prio;
+	total_cost = sc->anon_cost + sc->file_cost;
+	anon_cost = total_cost + sc->anon_cost;
+	file_cost = total_cost + sc->file_cost;
+	total_cost = anon_cost + file_cost;
 
-	totalcost = sc->anon_cost + sc->file_cost;
-	ap = anon_prio * (totalcost + 1);
-	ap /= sc->anon_cost + 1;
+	ap = swappiness * (total_cost + 1);
+	ap /= anon_cost + 1;
 
-	fp = file_prio * (totalcost + 1);
-	fp /= sc->file_cost + 1;
+	fp = (200 - swappiness) * (total_cost + 1);
+	fp /= file_cost + 1;
 
 	fraction[0] = ap;
 	fraction[1] = fp;
-- 
2.26.2

