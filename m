Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E328C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67CCE2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrT5598o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbgGaMVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732980AbgGaMVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:21:18 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93501C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:18 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i92so5149403pje.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mttZ04kQ/v9J1QJybdv51iwj40ObGuI3MVmwqoDkiZ0=;
        b=LrT5598o9VMdu0X5XOlouFmr5Qw67qfstVfTrCPorImKB6M7XkgUavzYJF62lN+GG/
         uIjlarspQ8mC2RBYPhUCzFbZhlLiodENrimruxiJfc2XlTYMKGqKfM5xf95pMKsPgkWc
         W73m733DRLqOnENC/+6ARXL4bzNsYq+TcysWzA/ZeLwr+kN9qdvw70oDkpBL6GlAC4hn
         v3zWize75e3phA/BlKc4knVPmmoF/LNHj1PhY2QNyZ/nA8mKHs+S9bjO5WvpRkKLMsaH
         ixw2oAUYWbKBCtxam0vxfWZ7m8Y+EVaMMQ6cLMl4nBW7OzQxL3gqmMbuGG7pmE4xdeyt
         hzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mttZ04kQ/v9J1QJybdv51iwj40ObGuI3MVmwqoDkiZ0=;
        b=F48gtIxbyX2Z2jdTlchi4A+KVJNf3U/IfBRcfxpwjEDfhrbqB9sEq3P8OXpDyOdvZF
         trHxqNlWA9a/SheErpSzEDtZZ8KgERdLLjWyaVh8XCkgNVP0y71RUVKgKNHIX69+unvT
         xVPBE8RMVXoWylNZkly+Vpg1d91T1NrwBTDPYZ7x+NLL00/cHAv6ukFAagOGm7mIlJ8E
         OyCuMQct33lY7XPoIFW7Uu770bs5KBPgsY8KS8EYLJ3ftx0KtmEwRf9P5/ZhOEKxolLq
         5j2vPZWqbrH0MYYftB6vRYxTxQZg/cc+BKIw9nzgX9+5eTkGHjjR+Lg5Gd1/Dd7qEiQC
         U4Og==
X-Gm-Message-State: AOAM5324VErs88tVRHT1tIjOEuXozvZp7HHjGU1YlRatc3cU3RGuflE5
        WtS7xkYO3toD5tQLoCR2+g==
X-Google-Smtp-Source: ABdhPJxTAedKVLPMS2eYF9B6N6kzCNJtA9resgP55mdS2aH4MGOecGSxPrGTvFmJGZBrM3W1fq8LXw==
X-Received: by 2002:a63:1208:: with SMTP id h8mr3546268pgl.128.1596198077926;
        Fri, 31 Jul 2020 05:21:17 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id m19sm3675692pjv.34.2020.07.31.05.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:21:17 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/16] HWPOISON: soft offline rework
Date:   Fri, 31 Jul 2020 12:20:56 +0000
Message-Id: <20200731122112.11263-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is the latest version of soft offline rework patchset
targetted for v5.9.

Main focus of this series is to stabilize soft offline.  Historically soft
offlined pages have suffered from racy conditions because PageHWPoison is
used to a little too aggressively, which (directly or indirectly) invades
other mm code which cares little about hwpoison.  This results in unexpected
behavior or kernel panic, which is very far from soft offline's "do not
disturb userspace or other kernel component" policy.

Main point of this change set is to contain target page "via buddy allocator",
where we first free the target page as we do for normal pages, and remove
from buddy only when we confirm that it reaches free list. There is surely
race window of page allocation, but that's fine because someone really want
that page and the page is still working, so soft offline can happily give up.

v4 from Oscar tries to handle the race around reallocation, but that part
seems still work in progress, so I decide to separate it for changes into
v5.9.  Thank you for your contribution, Oscar.

The issue reported by Qian Cai is fixed by patch 16/16.

This patchset is based on v5.8-rc7-mmotm-2020-07-27-18-18, but I applied
this series after reverting previous version.
Maybe https://github.com/Naoya-Horiguchi/linux/commits/soft-offline-rework.v5
shows what I did more precisely.

Any other comment/suggestion/help would be appreciated.

Thanks,
Naoya Horiguchi
---
Previous versions:
  v1: https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
  v2: https://lore.kernel.org/linux-mm/20191017142123.24245-1-osalvador@suse.de/
  v3: https://lore.kernel.org/linux-mm/20200624150137.7052-1-nao.horiguchi@gmail.com/
  v4: https://lore.kernel.org/linux-mm/20200716123810.25292-1-osalvador@suse.de/
---
Summary:

Naoya Horiguchi (8):
      mm,hwpoison: cleanup unused PageHuge() check
      mm, hwpoison: remove recalculating hpage
      mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
      mm,hwpoison-inject: don't pin for hwpoison_filter
      mm,hwpoison: remove MF_COUNT_INCREASED
      mm,hwpoison: remove flag argument from soft offline functions
      mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
      mm,hwpoison: double-check page count in __get_any_page()

Oscar Salvador (8):
      mm,madvise: Refactor madvise_inject_error
      mm,hwpoison: Un-export get_hwpoison_page and make it static
      mm,hwpoison: Kill put_hwpoison_page
      mm,hwpoison: Unify THP handling for hard and soft offline
      mm,hwpoison: Rework soft offline for free pages
      mm,hwpoison: Rework soft offline for in-use pages
      mm,hwpoison: Refactor soft_offline_huge_page and __soft_offline_page
      mm,hwpoison: Return 0 if the page is already poisoned in soft-offline

 drivers/base/memory.c      |   2 +-
 include/linux/mm.h         |  12 +-
 include/linux/page-flags.h |   6 +-
 include/ras/ras_event.h    |   3 +
 mm/hwpoison-inject.c       |  18 +--
 mm/madvise.c               |  39 +++---
 mm/memory-failure.c        | 334 ++++++++++++++++++++-------------------------
 mm/migrate.c               |  11 +-
 mm/page_alloc.c            |  60 ++++++--
 9 files changed, 233 insertions(+), 252 deletions(-)
