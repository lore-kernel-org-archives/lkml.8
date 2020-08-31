Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2727C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C121F20767
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HW8I1YgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgHaRu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgHaRux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:50:53 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6B4C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:50:53 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id h8so4612207ioa.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=WJ86J1Rh/9a+OExkI0rJlOFHOUeu/5tIWacuz+P7JAc=;
        b=HW8I1YgZCnmOLwNMaMPR8Sc9pNUApCmj+dz2XsrVb+X/SNyph/zuGantqb4pgta39U
         KQGbOfOjQGNePPnYLR/r429Li0FzwweyZvT5M1Sa1B+9AbEtJB5h5ZgK2Rxw+tDUs811
         LRSEOdNQyFkBN0CFGhpsfHaFZvif/OtBteR3Zn8ydBzMdEWLEZMvMk/Mm9bu9Om3s6LC
         k08kYtCBseeOND4PalCgqnwuU3h36DkgbnC6GK7p7jLKda1YL1EkO3iWVnQoUoA4Fl2r
         PNzBxiLUIfpFOyLhfFyDZQFX17fBelHRHsTiPW0TBMxp3Ge3zXPAbNLMiA2rNLA8Nylv
         UWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WJ86J1Rh/9a+OExkI0rJlOFHOUeu/5tIWacuz+P7JAc=;
        b=JieDZIHDmlfzfUvuuACE3zi0BXqh4nfVtlDVs2ptu9ZFvmHZPdMwS8nXRm3121W3X5
         ubLvg6lK4ZqOUIpWyxeekpLXKTZEURuji4r87K59TAW2k5qiMtG5rFyUnO8tfc0bjBv6
         A+fvehJD1Uz7IPakqClYDXK8rwjQOCNvzlUf621P8I1Sdkhg4bE/N7k2rext3kr5PSwf
         duhfX1UWdUipO68PX1HgxEr/wBvSHEICZ5nzu1RP37ZLonkWr9R/BrssPbf0GZlUYoMk
         PzT2T5n6j+jdn6Y95wg6PHImDaRJ24WUU37h0SNV6jb7IYgein11xYaRst350bob6CMP
         t9Nw==
X-Gm-Message-State: AOAM5323hiixKIwBRtlxVQLDWJEpB2+XJYY38q0hfU4tPgKRE3AcZU8E
        kiK45DK3w7Cb2BB2b8mty8349hO+VY0=
X-Google-Smtp-Source: ABdhPJyEmB54MPwn+rzZUmhXVP5xIYQCPFUTfjuW/TXcdPEGT6mWsUn1s2ENBY0cwGSp4EbLtkPuNTkDlXQ=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a92:7a0a:: with SMTP id v10mr2027625ilc.99.1598896251830;
 Mon, 31 Aug 2020 10:50:51 -0700 (PDT)
Date:   Mon, 31 Aug 2020 11:50:42 -0600
In-Reply-To: <20200831175042.3527153-1-yuzhao@google.com>
Message-Id: <20200831175042.3527153-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20200831175042.3527153-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v2 2/2] mm: use self-explanatory macros rather than "2"
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a trivial clean-up patch. Take it or leave it.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mmzone.h | 12 ++++++++----
 include/linux/vmstat.h |  2 +-
 mm/vmscan.c            |  2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8379432f4f2f..be1cdbf8317f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -266,6 +266,8 @@ static inline bool is_active_lru(enum lru_list lru)
 	return (lru == LRU_ACTIVE_ANON || lru == LRU_ACTIVE_FILE);
 }
 
+#define ANON_AND_FILE 2
+
 enum lruvec_flags {
 	LRUVEC_CONGESTED,		/* lruvec has many dirty pages
 					 * backed by a congested BDI
@@ -283,8 +285,8 @@ struct lruvec {
 	unsigned long			file_cost;
 	/* Non-resident age, driven by LRU movement */
 	atomic_long_t			nonresident_age;
-	/* Refaults at the time of last reclaim cycle, anon=0, file=1 */
-	unsigned long			refaults[2];
+	/* Refaults at the time of last reclaim cycle */
+	unsigned long			refaults[ANON_AND_FILE];
 	/* Various lruvec state flags (enum lruvec_flags) */
 	unsigned long			flags;
 #ifdef CONFIG_MEMCG
@@ -406,6 +408,8 @@ enum zone_type {
 
 #ifndef __GENERATING_BOUNDS_H
 
+#define ASYNC_AND_SYNC 2
+
 struct zone {
 	/* Read-mostly fields */
 
@@ -525,8 +529,8 @@ struct zone {
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 	/* pfn where compaction free scanner should start */
 	unsigned long		compact_cached_free_pfn;
-	/* pfn where async and sync compaction migration scanner should start */
-	unsigned long		compact_cached_migrate_pfn[2];
+	/* pfn where compaction migration scanner should start */
+	unsigned long		compact_cached_migrate_pfn[ASYNC_AND_SYNC];
 	unsigned long		compact_init_migrate_pfn;
 	unsigned long		compact_init_free_pfn;
 #endif
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 91220ace31da..d5431c1bf6e5 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -28,7 +28,7 @@ struct reclaim_stat {
 	unsigned nr_writeback;
 	unsigned nr_immediate;
 	unsigned nr_pageout;
-	unsigned nr_activate[2];
+	unsigned nr_activate[ANON_AND_FILE];
 	unsigned nr_ref_keep;
 	unsigned nr_unmap_fail;
 	unsigned nr_lazyfree_fail;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1b871c3987e7..b454cc17e5a3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2232,7 +2232,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	unsigned long anon_cost, file_cost, total_cost;
 	int swappiness = mem_cgroup_swappiness(memcg);
-	u64 fraction[2];
+	u64 fraction[ANON_AND_FILE];
 	u64 denominator = 0;	/* gcc */
 	enum scan_balance scan_balance;
 	unsigned long ap, fp;
-- 
2.28.0.402.g5ffc5be6b7-goog

