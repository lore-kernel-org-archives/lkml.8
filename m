Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0838BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D856820720
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUq0akRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgGMGmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMGmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:42:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FD0C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so5629775pgf.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xZcJpPVurLpF2R6ERLd9Bv0+pjW0oNaNoGLeOeK6As0=;
        b=hUq0akRxK+b1u+RVUmJQqCczhkyfN73GCfrkypfbNaCa4Gk5cTtoEeVhZCesNkboGV
         j432akK6NnI8/tr8zgYn+1eKTb2lrT2fkAFO4y91K1jXKidR2oaDookctgCYz1CyoEvC
         cDo82JqQYerphv21fk1Ph96Ct1LLw0heBrN41PMUI3D6Rc3KfAPY7/YPgaJCQBli77Wm
         BLLnWynd5yebQS8mUsRp7h9MMeCOh1fhmGCFi12gCBpRb30ccEIvaM3PjeIqGS7FYuCp
         JHbFnd4lhBPgftC3ZscphoNV/sWui/zJ18BJYm9xx4q/5lwpl6zW2dn7q0VrbJOuC5ia
         J66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xZcJpPVurLpF2R6ERLd9Bv0+pjW0oNaNoGLeOeK6As0=;
        b=JXazoDA/GzZ+vh9Ea27RKqfUCKCqeZVY4fc5yT17mnzlo/otXAMdl49brmxqWzGxhh
         liBc+GaBose6mdwG5Iq5ynToUQST4mmgRuNPzODOQGTF28O54hr176lz32vu1UKTodf/
         ELemsud9QpMeP/wBL8Kw/rpP2YkZh3nkyVZXJMMUpMt15XXucWX9DcLyQfQa/BgYx8WN
         pq3nzp/ohDuA7+5CGsNgHyyNgLmOwF8qYUVOOB/Y8s5WycQB3mWCJNs6MM62xTiEQ+53
         aAIXHHWRZqBr60/RZRguUfxKIPuSErAgpPRnQWAvMsBAQ9JA3IdUCt8su4q1wNqOqr4R
         QBLA==
X-Gm-Message-State: AOAM532zl2h7iXLSxYDfFYhoqC4LAMPTTVysVbKW5ZYZB/cF2TnnK73k
        /I3DEQMFMure6ysCe3uowFUzCFUv
X-Google-Smtp-Source: ABdhPJx5a0jLPBWyMbEJv7QlTZnVxSYGwAlAhrh1isrTw55i5OaPwY4iGtwoPj9AeSDAa1L+1cAtMQ==
X-Received: by 2002:a63:2b93:: with SMTP id r141mr67293886pgr.171.1594622536338;
        Sun, 12 Jul 2020 23:42:16 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id l134sm12448695pga.50.2020.07.12.23.42.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2020 23:42:15 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v5 0/9] clean-up the migration target allocation functions
Date:   Mon, 13 Jul 2020 15:41:48 +0900
Message-Id: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

This patchset clean-up the migration target allocation functions.

* Changes on v5
- remove new_non_cma_page() related patches
(implementation for memalloc_nocma_{save,restore} has a critical bug that
cannot exclude CMA memory in some cases so cannot use them here. Need to
fix them first.)
- introduce a wrapper to handle gfp_mask for hugetlb use it

* Changes on v4
- use full gfp_mask
- use memalloc_nocma_{save,restore} to exclude CMA memory
- separate __GFP_RECLAIM handling for THP allocation
- remove more wrapper functions

* Changes on v3
- As Vlastimil suggested, do not introduce alloc_control for hugetlb functions
- do not change the signature of migrate_pages()
- rename alloc_control to migration_target_control

* Changes on v2
- add acked-by tags
- fix missing compound_head() call for patch #3
- remove thisnode field on alloc_control and use __GFP_THISNODE directly
- fix missing __gfp_mask setup for patch
"mm/hugetlb: do not modify user provided gfp_mask"

* Cover-letter

Contributions of this patchset are:

1. unify two hugetlb alloc functions. As a result, one is remained.
2. remove one implementation for migration target allocaion
3. remove three wrapper for migration target allocation

The patchset is based on next-20200703 + revert following commits.
ddc017c727e429488cccd401a7794c8152e50a5b~1..583c2617fd3244fff79ba3b445964884c5cd7780

The patchset is available on:

https://github.com/JoonsooKim/linux/tree/cleanup-migration-target-allocation-v5.00-next-20200703

Thanks.
Joonsoo Kim (9):
  mm/page_isolation: prefer the node of the source page
  mm/migrate: move migration helper from .h to .c
  mm/hugetlb: unify migration callbacks
  mm/migrate: clear __GFP_RECLAIM to make the migration callback
    consistent with regular THP allocations
  mm/migrate: make a standard migration target allocation function
  mm/mempolicy: use a standard migration target allocation callback
  mm/page_alloc: remove a wrapper for alloc_migration_target()
  mm/memory-failure: remove a wrapper for alloc_migration_target()
  mm/memory_hotplug: remove a wrapper for alloc_migration_target()

 include/linux/hugetlb.h | 41 +++++++++++++++++++++++++++++++--------
 include/linux/migrate.h | 34 ++++++---------------------------
 mm/hugetlb.c            | 35 ++-------------------------------
 mm/internal.h           |  8 +++++++-
 mm/memory-failure.c     | 15 ++++++---------
 mm/memory_hotplug.c     | 42 +++++++++++++++++++++-------------------
 mm/mempolicy.c          | 29 ++++++----------------------
 mm/migrate.c            | 51 +++++++++++++++++++++++++++++++++++++++++++++++--
 mm/page_alloc.c         |  8 ++++++--
 mm/page_isolation.c     |  5 -----
 10 files changed, 137 insertions(+), 131 deletions(-)

-- 
2.7.4

