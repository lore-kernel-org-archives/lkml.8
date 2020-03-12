Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3DFC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1582073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="L2f+CaL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgCLRdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:33:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33597 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgCLRdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:33:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so8596473wrd.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=urzcg1/zbcSllHCQ82ap2K/ib0OV1jVM8zTOxSBSSFk=;
        b=L2f+CaL9yyAPG75AYGECf5KTcw7S8M4rdsMmRBSZMeGR8jRzPXKEG698E3haidM1SB
         EphvHD/U1lU3Tsfx19T+saKeeS1FVjHvlGAnaixK8Xiuvpf85YAi1FH8cmHHyStdVQ6x
         s3ChNGG7YtV2ejMML1Tln752ExwS8WXNN1Xzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=urzcg1/zbcSllHCQ82ap2K/ib0OV1jVM8zTOxSBSSFk=;
        b=f8aQ0qHDuJGfUdxy/gY34bQVJx1h5KMWnbmqnl7KMZ+79Ojm8mjfi6eZwRMr8zpTxi
         YCtFWFOav/FQSnLPmhLV3II4S61xWNbbDwPIBfX5YSKu+0sxtKjHVQalfa8caZD0EKnC
         5Wy8EPHCRRTTV9BN/Rufh23eAWn7lcdMoVsEgKi0xj3+B1L2Mb2eRDbP6FrbVIfuaNJO
         civ6joKnfx89XiUMdn+YdLCiYEDPZM6Gn5ymO02bA47HqE/tGtofmvH8PqSVR8XZ2zwC
         qg0HcJFKfWphHmtUbGCKCUGifIn5mBNnjDpwGumGaE/z/hjTnbXbJiOZq/gLBQKH7Ylc
         1HDQ==
X-Gm-Message-State: ANhLgQ3msFWYiuKMmzmcbmo0Vxkx44RP9qncxq2SIvhy7In7jFCRu30r
        vlO/r/lfYLlo2N022FgUD1hknUTNsvpCyQ==
X-Google-Smtp-Source: ADFU+vsFeyzbj5Xi2Wyqn57AJA4UE5JVSsw2uGMltfcBbAOKBHZZOyTjRytBGKPSYXhiCWlTxa3BBA==
X-Received: by 2002:a5d:410a:: with SMTP id l10mr11343394wrp.380.1584034392630;
        Thu, 12 Mar 2020 10:33:12 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id s28sm106147wrb.42.2020.03.12.10.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:33:12 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:33:11 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 5/6] mm, memcg: Prevent memory.swap.max load tearing
Message-ID: <bbec2c3d822217334855c8877a9d28b2a6d395fb.1584034301.git.chris@chrisdown.name>
References: <cover.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584034301.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The write side of this is xchg()/smp_mb(), so that's all good. Just a
few sites missing a READ_ONCE.

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
 mm/memcontrol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e0ed790a2a8c..57048a38c75d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1511,7 +1511,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		pr_info("swap: usage %llukB, limit %llukB, failcnt %lu\n",
 			K((u64)page_counter_read(&memcg->swap)),
-			K((u64)memcg->swap.max), memcg->swap.failcnt);
+			K((u64)READ_ONCE(memcg->swap.max)), memcg->swap.failcnt);
 	else {
 		pr_info("memory+swap: usage %llukB, limit %llukB, failcnt %lu\n",
 			K((u64)page_counter_read(&memcg->memsw)),
@@ -1544,7 +1544,7 @@ unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 		unsigned long swap_max;
 
 		memsw_max = memcg->memsw.max;
-		swap_max = memcg->swap.max;
+		swap_max = READ_ONCE(memcg->swap.max);
 		swap_max = min(swap_max, (unsigned long)total_swap_pages);
 		max = min(max + swap_max, memsw_max);
 	}
@@ -7025,7 +7025,8 @@ bool mem_cgroup_swap_full(struct page *page)
 		return false;
 
 	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
-		if (page_counter_read(&memcg->swap) * 2 >= memcg->swap.max)
+		if (page_counter_read(&memcg->swap) * 2 >=
+		    READ_ONCE(memcg->swap.max))
 			return true;
 
 	return false;
-- 
2.25.1

