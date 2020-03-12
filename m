Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C3EC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5890720716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="LB2Rpnhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCLRc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:32:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36512 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCLRcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:32:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id s5so8601767wrg.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 10:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CcUuUlC43ZZSpfh7MoEkxpHRz/YQaDQ0sa4yKp/08VA=;
        b=LB2RpnhyFSTH3hVgjWSNFLifh6wVwkygWTfWLNDnxQPIIBKr4BpapuRzF1lJYa0M15
         UbSB1s+QSe7P8Bx+GLZMQ+cV7gO4cfbRWGjeLOLvLCaijAjS6Lpr8ZOYSHWG8HOqN/hu
         kT1oLw9Sjvc/qjL4Kh04/aFvpCsvKUXlmqg/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CcUuUlC43ZZSpfh7MoEkxpHRz/YQaDQ0sa4yKp/08VA=;
        b=G1RXE6MZnFaw16q51wDcZWJTC7tepKJgZW9mqtvxuAi+8/LRguer4UraURgotWRz+8
         Cq0fIMmasJM/+OAKZSt7voYagWToqEpwn1v8fAaaOwQHoWAJJ2+0vXgcz/8WpqT1szkN
         FdP+MGXLwka3bADSzKLeS2xt/jMJpMkbh3xw39h7Cuiu35S59PUXulxWoaCx1JJuJ6M6
         Lhp5jQRbgXHnRe8NxXH3dbLYOE/Uc/IuB4x1lRfrdWj3hgn4uZ2mg35oS9Lza6yCDqyB
         QE6suW6L5KW5bI9PQ+2htuFz3fi7SBU+67xIdaEDtvQbenmo7DJfYS12yc9G1KJHWQKZ
         pjdg==
X-Gm-Message-State: ANhLgQ2wknOs/9wuvwzV7mLy01pWySBCDp6iIPF2T+p+5jpa8wIZTeMG
        JP4SDGA+9sglgirG4ujkDminjA==
X-Google-Smtp-Source: ADFU+vtgf9rQPYcJ7fNM8yiJe0orpohUFakZwlPq0AegakMNuqTr8+u5nhAj4dJIgtmv3wka95/7/g==
X-Received: by 2002:a05:6000:1008:: with SMTP id a8mr6809577wrx.8.1584034372767;
        Thu, 12 Mar 2020 10:32:52 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id z6sm20259371wru.15.2020.03.12.10.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:32:52 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:32:51 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/6] mm, memcg: Prevent memory.high load/store tearing
Message-ID: <2f66f7038ed1d4688e59de72b627ae0ea52efa83.1584034301.git.chris@chrisdown.name>
References: <cover.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584034301.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A mem_cgroup's high attribute can be concurrently set at the same time
as we are trying to read it -- for example, if we are in
memory_high_write at the same time as we are trying to do high reclaim.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 mm/memcontrol.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 63bb6a2aab81..d32d3c0a16d4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2228,7 +2228,7 @@ static void reclaim_high(struct mem_cgroup *memcg,
 			 gfp_t gfp_mask)
 {
 	do {
-		if (page_counter_read(&memcg->memory) <= memcg->high)
+		if (page_counter_read(&memcg->memory) <= READ_ONCE(memcg->high))
 			continue;
 		memcg_memory_event(memcg, MEMCG_HIGH);
 		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
@@ -2545,7 +2545,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * reclaim, the cost of mismatch is negligible.
 	 */
 	do {
-		if (page_counter_read(&memcg->memory) > memcg->high) {
+		if (page_counter_read(&memcg->memory) > READ_ONCE(memcg->high)) {
 			/* Don't bother a random interrupted task */
 			if (in_interrupt()) {
 				schedule_work(&memcg->high_work);
@@ -4257,7 +4257,8 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	*pheadroom = PAGE_COUNTER_MAX;
 
 	while ((parent = parent_mem_cgroup(memcg))) {
-		unsigned long ceiling = min(memcg->memory.max, memcg->high);
+		unsigned long ceiling = min(memcg->memory.max,
+					    READ_ONCE(memcg->high));
 		unsigned long used = page_counter_read(&memcg->memory);
 
 		*pheadroom = min(*pheadroom, ceiling - min(ceiling, used));
@@ -4978,7 +4979,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (!memcg)
 		return ERR_PTR(error);
 
-	memcg->high = PAGE_COUNTER_MAX;
+	WRITE_ONCE(memcg->high, PAGE_COUNTER_MAX);
 	memcg->soft_limit = PAGE_COUNTER_MAX;
 	if (parent) {
 		memcg->swappiness = mem_cgroup_swappiness(parent);
@@ -5131,7 +5132,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
 	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
-	memcg->high = PAGE_COUNTER_MAX;
+	WRITE_ONCE(memcg->high, PAGE_COUNTER_MAX);
 	memcg->soft_limit = PAGE_COUNTER_MAX;
 	memcg_wb_domain_size_changed(memcg);
 }
@@ -5947,7 +5948,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	memcg->high = high;
+	WRITE_ONCE(memcg->high, high);
 
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
-- 
2.25.1

