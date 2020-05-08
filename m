Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD89C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C9BD24953
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Es4bHoTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgEHScN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbgEHScN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:32:13 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2F5C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:32:12 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id b1so1355666qtt.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tzWVqUZtLwqxtxfWgFUyBr2nPkF3oxF3sVG4yWWQyv0=;
        b=Es4bHoTBFJW5deY/BPRm1w9FSHwlvLmnWbWr+JMeXV7lwHag/PJFMjSaaSHRkttda9
         ZBGMCqHHpexqozMp7joxpOR/FUBqY4fzUJeehlqLgHU0RSat1rj9Q+Xtcmcvp/Xucdmv
         EnHLzezIGvS2TdqxgQDzPqk6rWL/2RluSz8ZmEOU+wRKHuUmU8j/94jtvQvm3nrbytof
         CdDhhdVB5sBwTOP033+p/Ezivg7PnuZbXkMxxaA96tDTehDT8E1FkIS2v56S5APkj/yu
         qL5aCzZbbv0Y8ZY71fsPZmTIfK34i9XIhBcwDrRYYPwGqqTYiLOaoXXXHrj+OeSpZIhe
         IWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tzWVqUZtLwqxtxfWgFUyBr2nPkF3oxF3sVG4yWWQyv0=;
        b=Pq1v2FBiY0MGlhIqicuL/shLvjYVUm9RvEMp0wQt2DN/5ehZfyLfMquqIPgnty5iPN
         KEdiGT5xDyiBAVhx2TBVedibvurAkLa3KKHthtxjPlpZBWnB2IaZ5l48S7ReAXdSzpt9
         OJUqc1AYpTUliy97CO0KNCHUFYdeGzPO7Q69IfMyBrQsHUGEteSQ0lSS8sz+mNWibJlM
         TsFEx9WLIGf1fVepclq/ldI9yt7GaixuHcU+1gMCfYUxGmZJjqSIjQwfKR71HmYXtZhf
         jXkyY6VnDT7gpDmoc4X2MqVHx4oW5L3PYdvjrJJR1oeSjBpNViIcb6JTBxgrBeLCUhA2
         hLyA==
X-Gm-Message-State: AGi0PuZHHY/nkjVzx8sl4donl6au6j+GrZKXwlq9G9sKbGwoYuOIVwOD
        glUTVyBu4FFuKa35JTvlSGnkUw==
X-Google-Smtp-Source: APiQypK7dhstJxBjZrfbvoGmymSVIQmOETHJ+bsToYQ1IK0kyvr9w+WXx+4CHsQzZKydtugQ2QbLDg==
X-Received: by 2002:ac8:2a70:: with SMTP id l45mr4578616qtl.232.1588962731840;
        Fri, 08 May 2020 11:32:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id g6sm2118974qtc.52.2020.05.08.11.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:11 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 00/19 V2] mm: memcontrol: charge swapin pages on instantiation
Date:   Fri,  8 May 2020 14:30:47 -0400
Message-Id: <20200508183105.225460-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series reworks memcg to charge swapin pages directly at
swapin time, rather than at fault time, which may be much later, or
not happen at all.

Changes in version 2:
- prevent double charges on pre-allocated hugepages in khugepaged
- leave shmem swapcache when charging fails to avoid double IO (Joonsoo)
- fix temporary accounting bug by switching rmap<->commit (Joonsoo)
- fix double swap charge bug in cgroup1/cgroup2 code gating
- simplify swapin error checking (Joonsoo)
- mm: memcontrol: document the new swap control behavior (Alex)
- review tags

The delayed swapin charging scheme we have right now causes problems:

- Alex's per-cgroup lru_lock patches rely on pages that have been
  isolated from the LRU to have a stable page->mem_cgroup; otherwise
  the lock may change underneath him. Swapcache pages are charged only
  after they are added to the LRU, and charging doesn't follow the LRU
  isolation protocol.

- Joonsoo's anon workingset patches need a suitable LRU at the time
  the page enters the swap cache and displaces the non-resident
  info. But the correct LRU is only available after charging.

- It's a containment hole / DoS vector. Users can trigger arbitrarily
  large swap readahead using MADV_WILLNEED. The memory is never
  charged unless somebody actually touches it.

- It complicates the page->mem_cgroup stabilization rules

In order to charge pages directly at swapin time, the memcg code base
needs to be prepared, and several overdue cleanups become a necessity:

To charge pages at swapin time, we need to always have cgroup
ownership tracking of swap records. We also cannot rely on
page->mapping to tell apart page types at charge time, because that's
only set up during a page fault.

To eliminate the page->mapping dependency, memcg needs to ditch its
private page type counters (MEMCG_CACHE, MEMCG_RSS, NR_SHMEM) in favor
of the generic vmstat counters and accounting sites, such as
NR_FILE_PAGES, NR_ANON_MAPPED etc.

To switch to generic vmstat counters, the charge sequence must be
adjusted such that page->mem_cgroup is set up by the time these
counters are modified.

The series is structured as follows:

1. Bug fixes
2. Decoupling charging from rmap
3. Swap controller integration into memcg
4. Direct swapin charging

Based on v5.7-rc3-mmots-2020-05-01-20-14.

 Documentation/admin-guide/cgroup-v1/memory.rst |  19 +-
 include/linux/memcontrol.h                     |  53 +--
 include/linux/mm.h                             |   4 +-
 include/linux/swap.h                           |   6 +-
 init/Kconfig                                   |  17 +-
 kernel/events/uprobes.c                        |  10 +-
 mm/filemap.c                                   |  43 +--
 mm/huge_memory.c                               |  13 +-
 mm/khugepaged.c                                |  29 +-
 mm/memcontrol.c                                | 449 +++++++----------------
 mm/memory.c                                    |  51 +--
 mm/migrate.c                                   |  20 +-
 mm/rmap.c                                      |  53 +--
 mm/shmem.c                                     | 108 +++---
 mm/swap_cgroup.c                               |   6 -
 mm/swap_state.c                                |  89 ++---
 mm/swapfile.c                                  |  25 +-
 mm/userfaultfd.c                               |   5 +-
 18 files changed, 367 insertions(+), 633 deletions(-)
