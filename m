Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F6DC54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F44C20735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ug0Afhxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGUtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbgEGUtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:49:22 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AAEC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 13:49:23 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z14so7116552qvv.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=N2ff8TXAhQSelwb8Fo/2whe057WE75uOPyG09EBawpk=;
        b=ug0AfhxkFYxV7gPwZQUiO1TH3mLYMXaH6iQJmRt4l4dAOkKMo1p8glAwchEJSmd48c
         KO6FfYEFXmZWE81BIC9AelKPV7tepn0+Ftyaib5noC4g13aPBsyAyMdxgvKHwAfQGO1v
         /vVJqS1ZifkmreEOPNH/fBb0pIBBQzOBDGmV5r3SYopfhtu8NQep9Zx6wo2i+p6uof5f
         arI5Xy212yrTpsSdUjgBM+SB60lQWQE4Ih4L+qjVG+DoXOQw5TjVQIFXe0UYJMfm83Ej
         Hmmdem0OFwI/EwortJyPaS8KM+VjNt2vbRqfIIYMkolXyGcVgDuhhkk0U2bBr7SJPL4D
         G7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=N2ff8TXAhQSelwb8Fo/2whe057WE75uOPyG09EBawpk=;
        b=sMX5D00O//tuIz6Lc9ISPVoAnki/LBIztNkg20c4u3R0UNI4dZ28MdVxlSS9OcHPab
         PJd3uEw4OJGOY+OsPvCCCS4efuTpsSJMSOgc2xRBpg8iDEjoKEXVPuGRuRKIGvgtaKy5
         9xSfjfWB4u5xT0uXg3FKgHLnlN6y7lILWlADd5xzEhaNYvtImA+RX9aGN01gC15fbAoR
         MjZNdtEbOAobkaW8rk3T1id4D6iO5uq9ZP/vV8w+gNVDYZctENjBhVn1je4A4JhDF2Km
         miOMP/zT7Dblg97CWD11oVe5ANGjNS34L09R34Nf4NzYWKmgoNhfMxwHlYIYDU/BPJ6w
         L7Dw==
X-Gm-Message-State: AGi0PuZbzOmet5ug9GUjNy3Ig9C/lm8tKfxDSvUrFLknlrWEYTzvHMkL
        lpDA5hYhYWSxYjL9eRip0Ar5dakhe9QsHA==
X-Google-Smtp-Source: APiQypLIwmOebFUIMyZG3XpyW3XxAzQzjw/dvg2VWxnQ01/+jF/bRCFmduwTX9Bdk6dvzmjtIRNXl65ogssE3Q==
X-Received: by 2002:a37:aac5:: with SMTP id t188mr16318525qke.393.1588884562180;
 Thu, 07 May 2020 13:49:22 -0700 (PDT)
Date:   Thu,  7 May 2020 13:49:13 -0700
Message-Id: <20200507204913.18661-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH] mm: vmscan: consistent update to pgsteal and pgscan
From:   Shakeel Butt <shakeelb@google.com>
To:     Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One way to measure the efficiency of memory reclaim is to look at the
ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
not updated consistently at the system level and the ratio of these are
not very meaningful. The pgsteal and pgscan are updated for only global
reclaim while pgrefill gets updated for global as well as cgroup
reclaim.

Please note that this difference is only for system level vmstats. The
cgroup stats returned by memory.stat are actually consistent. The
cgroup's pgsteal contains number of reclaimed pages for global as well
as cgroup reclaim. So, one way to get the system level stats is to get
these stats from root's memory.stat but root does not expose that
interface. Also for !CONFIG_MEMCG machines /proc/vmstat is the only way
to get these stats. So, make these stats consistent.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/vmscan.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index cc555903a332..51f7d1efc912 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1943,8 +1943,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	reclaim_stat->recent_scanned[file] += nr_taken;
 
 	item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
-	if (!cgroup_reclaim(sc))
-		__count_vm_events(item, nr_scanned);
+	__count_vm_events(item, nr_scanned);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
 	spin_unlock_irq(&pgdat->lru_lock);
 
@@ -1957,8 +1956,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	spin_lock_irq(&pgdat->lru_lock);
 
 	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
-	if (!cgroup_reclaim(sc))
-		__count_vm_events(item, nr_reclaimed);
+	__count_vm_events(item, nr_reclaimed);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
 	reclaim_stat->recent_rotated[0] += stat.nr_activate[0];
 	reclaim_stat->recent_rotated[1] += stat.nr_activate[1];
-- 
2.26.2.526.g744177e7f7-goog

