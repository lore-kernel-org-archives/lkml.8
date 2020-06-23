Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC48C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17AE20772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il0jMjiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgFWGOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgFWGOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:14:25 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37DFC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:24 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k1so8678887pls.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IBU7GakV7KRqkfqwiqdSFvKU2H1WKHTR8vXxzKdrT7Q=;
        b=il0jMjiWQVcJ46yNitriB3lqnjNqWNGO3PiE5YAEaz13aZpVbDv3iBGr9L5c2SHpjO
         3vsSaXQeQuYMGb6tuO5NRIAfg6kQ0lx9+OF4akxDN6rJIqMmD3lV9vKm2l3Fia/FC2o6
         Smy40NlVngjnUWeBYPy44oBZrQ/m+upr8yKrZ7AOrfT25Xs0RsZPjrqlpKDMALljQBZV
         F4f3i/lZyvW6c8gfHJfzw+S4GTbMLJydVIYjHePfMcWD9OcqI+FLUar5XJPpf7sAGrxB
         BqzmFmKFt1b+qTYTbH5lVHWyZlocQ6Od1hN/gDeqCLljed09IeU/sic1kuKslGToR3XT
         YGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IBU7GakV7KRqkfqwiqdSFvKU2H1WKHTR8vXxzKdrT7Q=;
        b=TGkkE2mycybidhAc/nSMggBuSy3pJbASNbGCn504uRILz59e2IYE2r0vKHaQm2xWoB
         zlcy4IrJJPapctHNk27bA/7Edoc35SVHtbIc4vKQVxO5DlJC896L5/qUDRQHNf93/xtQ
         nOVkmoo3Oa2FoYDk3t6wb81zBK42gxpcgzMiDaj4VEPY+qsqlCevHcfDJeuM1BzqQNBW
         wKHXWcDuMuh6+ZzGe2R+C6SF64d+DssRtBbMRiTfiTLtJuLgwOsFKGlW7WcoV2Ae5+ZH
         QTat59lIdFLX7QLrbHQ8z6eu2thLt/lJQaJyfzJU/ku8ABh1COoNaYn7wNvE9V7dRaoi
         SqLQ==
X-Gm-Message-State: AOAM530v3TYhUUSnJmVgG/Es4n4+no63fBqw9C8eszg5CIl2ygZkwsVs
        KGfQ+bljRD4LnZmO2bwy9lY=
X-Google-Smtp-Source: ABdhPJxiv6itoNWs/rZevZCbwA8K0AqDeQwrF2gMeidMkLX0MUM7DKpcBcGr4YYZWuG8qf7HvH5k+A==
X-Received: by 2002:a17:902:8304:: with SMTP id bd4mr22262045plb.8.1592892864395;
        Mon, 22 Jun 2020 23:14:24 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id m15sm12801093pgv.45.2020.06.22.23.14.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 23:14:23 -0700 (PDT)
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
Subject: [PATCH v3 0/8] clean-up the migration target allocation functions
Date:   Tue, 23 Jun 2020 15:13:40 +0900
Message-Id: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

This patchset clean-up the migration target allocation functions.

* Changes on v3
- do not introduce alloc_control for hugetlb functions
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
2. make one external hugetlb alloc function to internal one.
3. unify three functions for migration target allocation.

The patchset is based on next-20200621.
The patchset is available on:

https://github.com/JoonsooKim/linux/tree/cleanup-migration-target-allocation-v3.00-next-20200621

Thanks.

Joonsoo Kim (8):
  mm/page_isolation: prefer the node of the source page
  mm/migrate: move migration helper from .h to .c
  mm/hugetlb: unify migration callbacks
  mm/hugetlb: make hugetlb migration callback CMA aware
  mm/migrate: make a standard migration target allocation function
  mm/gup: use a standard migration target allocation callback
  mm/mempolicy: use a standard migration target allocation callback
  mm/page_alloc: remove a wrapper for alloc_migration_target()

 include/linux/hugetlb.h | 13 +++---------
 include/linux/migrate.h | 34 ++++++------------------------
 mm/gup.c                | 56 +++++++------------------------------------------
 mm/hugetlb.c            | 53 ++++++++++++++++++++--------------------------
 mm/internal.h           |  9 +++++++-
 mm/memory-failure.c     |  8 +++++--
 mm/memory_hotplug.c     | 14 ++++++++-----
 mm/mempolicy.c          | 29 ++++++-------------------
 mm/migrate.c            | 45 +++++++++++++++++++++++++++++++++++++--
 mm/page_alloc.c         |  9 ++++++--
 mm/page_isolation.c     |  5 -----
 11 files changed, 119 insertions(+), 156 deletions(-)

-- 
2.7.4

