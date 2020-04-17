Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05345C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71FF21D93
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1W6xMNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgDQD7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 23:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725294AbgDQD7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:59:11 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69529C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:59:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n16so473202pgb.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=na7JfmnEuFO5lQLzn6c1hCpd9EfR0hcGB7Np3A/iN7s=;
        b=t1W6xMNu0MqsQxIZjhU3onKgCuLnT/u0kC0W09TFHrVkbMvgBtwcgbvDul/gCZrcEb
         +DcVkIM6Wm/zB8kc1o9qRNXxMqOMDSfNmankoOmseFARuXex9HESY5WRrblif7DP+p8z
         vpiXQlN0rTQXefHnbN+Z4k5TWUuhONg5bYp9rFAbtxIrGT8DSddTzcaf5pZY21m+JtwT
         5mXyFUO1rY0bSssg7W7YOrUi64S2rlR3wt47vR7aTLWbknONKKtYhIHvrR4GgFWD11C/
         Nt8palqFe3BG2yHPtTNGkA6Zgg+yDtHtA7yPjcWe5U7/yBKBA3O6bRAV45nTXd+Hc7Yv
         hYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=na7JfmnEuFO5lQLzn6c1hCpd9EfR0hcGB7Np3A/iN7s=;
        b=SbFEjt497MjmzzWCNO+/jNBc5y38YfulJLY/1lCldRhwjUkvhVjM4r9kcUNQs/nDYP
         e4iP1V2tOYpK0rj13oukbR745h5HB+quEj6BnTtybmn5ddCQJz9gR2T2+9Pfqw9b5tOg
         UYzbg+0Snibf25n8EavtvW8agE+zHY85AFj8SLhwBjDldgyDt59yfa4x294jz1oGF6g1
         PaORWKadvuHOF7t7Toxd86xoNcd7BwfRusV/g+yyt0Cca8gS2oXBDNRx38PIqqsrk7jD
         L9gtAit9RJH7nk4mluwWpo0g9ynSsYtlt2seFgNCs1a6PmWVYOqpdLGCyRaB768Uamzf
         oIsw==
X-Gm-Message-State: AGi0PuZjtud0kP4Sej5IBrN+exKkYsDK8GWdGj3Y/5kfEUuf2vfFwzLj
        GNDYeB8nJunLvjFoJbX2HW0=
X-Google-Smtp-Source: APiQypIo7vTkOBXArAcxTLTLkiTz7uKHkHyXjGz5YEKPm2+33YmWIwzOoZ9pzqr2V756J2oAdaj/Jg==
X-Received: by 2002:a63:e54a:: with SMTP id z10mr1055329pgj.346.1587095950656;
        Thu, 16 Apr 2020 20:59:10 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id g12sm3525454pfm.129.2020.04.16.20.59.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 20:59:10 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        David Rientjes <rientjes@google.com>,
        Baoquan He <bhe@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v5 0/2] integrate classzone_idx and high_zoneidx
Date:   Fri, 17 Apr 2020 12:58:41 +0900
Message-Id: <1587095923-7515-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Hello,

This patchset is follow-up of the problem reported and discussed
two years ago [1, 2]. The problem this patchset solves is related to
the classzone_idx on the NUMA system. It causes a problem when
the lowmem reserve protection exists for some zones on a node
that do not exist on other nodes.

This problem is reported two years ago, and, at that time,
the solution got general agreements [2]. But, due to my laziness,
it's not upstreamed. Now, I tried again. This patchset is based on
next-20200416 git tree.

Thanks.

Changes on v5
- rebase onto the next-20200416
- add review tags

Changes on v4
- improve the commit message again

Changes on v3
- improve the commit message
- remove useless accessor, ac_classzone_idx()

[1]: http://lkml.kernel.org/r/20180102063528.GG30397@yexl-desktop
[2]: http://lkml.kernel.org/r/1525408246-14768-1-git-send-email-iamjoonsoo.kim@lge.com

Joonsoo Kim (2):
  mm/page_alloc: use ac->high_zoneidx for classzone_idx
  mm/page_alloc: integrate classzone_idx and high_zoneidx

 include/linux/compaction.h        |   9 ++--
 include/linux/mmzone.h            |  12 ++---
 include/trace/events/compaction.h |  22 ++++----
 include/trace/events/vmscan.h     |  14 +++--
 mm/compaction.c                   |  64 +++++++++++------------
 mm/internal.h                     |  21 +++++---
 mm/memory_hotplug.c               |   6 +--
 mm/oom_kill.c                     |   4 +-
 mm/page_alloc.c                   |  60 +++++++++++-----------
 mm/slab.c                         |   4 +-
 mm/slub.c                         |   4 +-
 mm/vmscan.c                       | 105 ++++++++++++++++++++------------------
 12 files changed, 175 insertions(+), 150 deletions(-)

-- 
2.7.4

