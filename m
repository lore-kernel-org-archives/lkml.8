Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31548C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 03:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF21207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 03:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lAKSCIQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbgGaDSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 23:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730820AbgGaDSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 23:18:06 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975D7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 20:18:06 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b79so27595749qkg.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 20:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=SR7+yosq1xp0zigF9l1fWsxuDY4XPAok3oMTFmLnUZc=;
        b=lAKSCIQ2Rm1+s3DGdgW2sY0SDCmsMzaowSi7+qudL2dAuv8GkPJze1HW+crvQ6Bhfa
         bkM2/M1ClQC6+0080PfNkgGwgB0AbZq1JsoB8c9CImd523NXd9fNcPWF/5YNjMQICD+Y
         kpXpwM+1wPiFvPABKKPQUbIdDPsEOsUfphQLlmbyxkGOBWAQLsXXp9GEM5eDp82hPbZa
         EOQ+UK60Akrhw6dGGA7YbsemwJu5TM6rh1aIzwbI1wpgfC3+fSULumcTUeCrc0DAOzpZ
         TL+Y5mNy6ctfeP06zq+RB2wSm63t5aiEvC4e2SEf0ZVyRmmnHq+taF6/YOWS4xqjrBAf
         gmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=SR7+yosq1xp0zigF9l1fWsxuDY4XPAok3oMTFmLnUZc=;
        b=Ox6l1lcj03gLazP73N7hfeKcJvMi8uSQuOSZE/N/xMsBQF55Inn+4aoJ8qdAnwNfzj
         m5AEE4SmQt6ShwayjXbkQshaYWFB65ivJa2yKNQj2VG54p6eaCwTygYiT0bx4pyzqe7P
         q4C+qdFYYq09OdkarzltwfDTAkKbv0J0wv2OhRpdiJOmT8mKCkrzkxdUskuB+P0YOryg
         MP4Lbj6pSixyfhw08yvO4MjO/OQ4gi6yClo/A2jDjp6WuUTxQlFS9NehAsBRsBjM4xWx
         8U/0kcMobgW/NYU6oKFigXpWzCE0pZt2iJhE8gu7cuFDPGAqTDlZx/TZy3T+0EXL+BRO
         lE3g==
X-Gm-Message-State: AOAM530AW96nY6p3JUZbw1dZ8+JqehQLKOaBOGcbJL82W1x70R16PCRV
        CLdfrjJgaHzYysosLDxFDkdbWg==
X-Google-Smtp-Source: ABdhPJwDwQt3K/iTgMokrKbRI7xWY04eq/mt5E9rmbuM1E79HWT25mrsITLMlCNlT8E1q0fjShonhQ==
X-Received: by 2002:a05:620a:1424:: with SMTP id k4mr2210742qkj.2.1596165485326;
        Thu, 30 Jul 2020 20:18:05 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s38sm7256566qts.78.2020.07.30.20.18.03
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2020 20:18:04 -0700 (PDT)
Date:   Thu, 30 Jul 2020 20:17:50 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH mmotm] mm: memcontrol: decouple reference counting from page
 accounting fix
Message-ID: <alpine.LSU.2.11.2007302011450.2347@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving tasks between mem cgroups with memory.move_charge_at_immigrate 3,
while swapping, crashes soon on mmotm (and so presumably on linux-next):
for example, spinlock found corrupted when lock_page_memcg() is called.
It's as if the mem cgroup structures have been freed too early.

Stab in the dark: what if all the accounting is right, except that the
css_put_many() in __mem_cgroup_clear_mc() is now (worse than) redundant?
Removing it fixes the crashes, but that's hardly surprising; and stats
temporarily hacked into mem_cgroup_css_alloc() and mem_cgroup_css_free()
showed that mem cgroups were not being leaked with this change.

Note: this removes the last call to css_put_many() from the tree; and
mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-accounted-allocations.patch
removes the last call to css_get_many(): now that their last references
have gone, I expect them soon to be freed from include/linux/cgroup.h.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Fixes mm-memcontrol-decouple-reference-counting-from-page-accounting.patch

 mm/memcontrol.c |    2 --
 1 file changed, 2 deletions(-)

--- mmotm/mm/memcontrol.c	2020-07-27 18:55:00.700554752 -0700
+++ linux/mm/memcontrol.c	2020-07-30 12:05:00.640091618 -0700
@@ -5887,8 +5887,6 @@ static void __mem_cgroup_clear_mc(void)
 		if (!mem_cgroup_is_root(mc.to))
 			page_counter_uncharge(&mc.to->memory, mc.moved_swap);
 
-		css_put_many(&mc.to->css, mc.moved_swap);
-
 		mc.moved_swap = 0;
 	}
 	memcg_oom_recover(from);
