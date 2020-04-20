Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ECBC55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9F020B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="hioVkfM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgDTWMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgDTWLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:11:54 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BE5C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:11:53 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id fb4so5583790qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DOOm476uJeMGLcBhM+Nnzpj1no5zTibX8MlOScPTZP8=;
        b=hioVkfM6+J8WLoqNgQvJex645fWjZjvT2/DsLybW7sYgjf412MeETUZ9sROh0R1aWj
         +PT6+SXjVnqxxmEOTA9tvabznzLoBPcJBFq4YE8hoEuzbzF40WKlwKaqtbAqUJo+/bas
         im+UJ8ycoNz8d4jRpIMsB++DBz0dnGnuMqlCB4hmyggGOAgndpABwHd17mrndefiJRwz
         Z2qXu1h9XDQmhj97BrOl/rj7HMgRojZXQSyqf2BDfruwfndNUIWs+LD73ZabCqzmMaCn
         cehSIavgIGYGeqhJF+aMCBuk7+NX/1IMdnuJyPVCfgAkX8NmPsXmgrRjB/kNROuj/5bz
         UYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DOOm476uJeMGLcBhM+Nnzpj1no5zTibX8MlOScPTZP8=;
        b=jGtAtEKBdWBU7vdWmpvGFOUDvWJma/ic6BbnhS6lVXl68o3qLB3V6E164GH3bcAYAL
         xmNarIOvmUYvcAQJQxhD0O3lWq+JEClQ/IwiUEBBTLYsCKau3/JO1C7QKRTUjBghsZCG
         91/o6WplQH7mZMejq4FoN6Ly2kTXroyvdQTfMqd6gJtYXdqPk+Uam8he4pgdR3qY9gCO
         JnwXI60ov2Z8iSe49uTGExO1a8pPyyKhw3oslw2nrkBcFfSOEroYwEg4goos8tNodmTo
         BtmYzDA+7jMd6lvJ5njbjIzk11BBslfxl2Id7XQhcxGmLi7yEjlUi6WWdbypDn1KAtce
         WJ3g==
X-Gm-Message-State: AGi0PuZFlSJL+D6xPvuxtcjaYNFcNvhO8aDPvpmdpyM1suICz9U24aUN
        /z1/sqzWH8NqhtydWgL85di6VA==
X-Google-Smtp-Source: APiQypJrBUdXsOlvUJ5mC/Iy8jECNqCt058AfYOAro9oUqe7TXlWv/H13lObMqwJkQLwqDlREImx5Q==
X-Received: by 2002:a0c:f70c:: with SMTP id w12mr17509081qvn.28.1587420713156;
        Mon, 20 Apr 2020 15:11:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id h3sm565816qkf.15.2020.04.20.15.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:11:52 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 07/18] mm: memcontrol: prepare move_account for removal of private page type counters
Date:   Mon, 20 Apr 2020 18:11:15 -0400
Message-Id: <20200420221126.341272-8-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When memcg uses the generic vmstat counters, it doesn't need to do
anything at charging and uncharging time. It does, however, need to
migrate counts when pages move to a different cgroup in move_account.

Prepare the move_account function for the arrival of NR_FILE_PAGES,
NR_ANON_MAPPED, NR_ANON_THPS etc. by having a branch for files and a
branch for anon, which can then divided into sub-branches.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e3e8913a5b28..ac6f2b073a5a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5374,7 +5374,6 @@ static int mem_cgroup_move_account(struct page *page,
 	struct pglist_data *pgdat;
 	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
 	int ret;
-	bool anon;
 
 	VM_BUG_ON(from == to);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
@@ -5392,25 +5391,27 @@ static int mem_cgroup_move_account(struct page *page,
 	if (page->mem_cgroup != from)
 		goto out_unlock;
 
-	anon = PageAnon(page);
-
 	pgdat = page_pgdat(page);
 	from_vec = mem_cgroup_lruvec(from, pgdat);
 	to_vec = mem_cgroup_lruvec(to, pgdat);
 
 	lock_page_memcg(page);
 
-	if (!anon && page_mapped(page)) {
-		__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
-		__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
-	}
+	if (!PageAnon(page)) {
+		if (page_mapped(page)) {
+			__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
+			__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
+		}
 
-	if (!anon && PageDirty(page)) {
-		struct address_space *mapping = page_mapping(page);
+		if (PageDirty(page)) {
+			struct address_space *mapping = page_mapping(page);
 
-		if (mapping_cap_account_dirty(mapping)) {
-			__mod_lruvec_state(from_vec, NR_FILE_DIRTY, -nr_pages);
-			__mod_lruvec_state(to_vec, NR_FILE_DIRTY, nr_pages);
+			if (mapping_cap_account_dirty(mapping)) {
+				__mod_lruvec_state(from_vec, NR_FILE_DIRTY,
+						   -nr_pages);
+				__mod_lruvec_state(to_vec, NR_FILE_DIRTY,
+						   nr_pages);
+			}
 		}
 	}
 
-- 
2.26.0

