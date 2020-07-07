Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD7BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9241206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpvOOssE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGGHpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgGGHpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:45:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E52C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:45:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z5so19619049pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dUYmHO3l6du1f9FFjttJ6TgJ0e7C+7Hg2PXGcNYn718=;
        b=tpvOOssExX/L5tReYEOnayLhzrOqLhiBf21JB+Il0QLrCjYENTxDY71ob23denpAg9
         DeGuaDEAUjf2J2YjArk30Smyu1juNDm8RL2tDJgXp5yBUMPMZ1zk+UegFKhJKnBEu35m
         uMiREppcHMabiRYS1itPwzO0TTE5zmNEC0moeH4XNO3qn/y+c3rU+3AFfwcgXZky+0GT
         wAP4ahXIlor1atKM7LzYuP2a8CxL7zvEJJ9h9Fpi31ncHUAUq02f/pkKsdi1NEM4ht/+
         Yc4Dkh9Y08H3EnkHxFaZ70A4gzEw6zMWCc5IVCnS0Ncw/KF2j4CSajhOzcduaaUnMRTW
         hYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dUYmHO3l6du1f9FFjttJ6TgJ0e7C+7Hg2PXGcNYn718=;
        b=n+zMRnga6WT868vUeVkR9TQS8fWaNKrV76ojHQrOiE68DmEzQBM8V/9S3u2AqDOfVR
         fqJ/xpx+PLLH6tnwtcN0xWWgMv01IzHoDog0XF3oELptKiWi3QsVeWCKagI1cJufF2cv
         a08MPsQ96nC3v6jbH/BrjEwR1Lmpx0eq1VHDzy1HBK4hSGzbBfBCp1ZpPXh54R2FjNyP
         xS29vpZnlGzqJwLC9VIwieXIEal+f2ipqsYNyi4m0qIpWi4ddS0SSdAqYSOTV8SJKFFS
         cpAENerm1LCMbY2kGLn6TymBQO/NpesVamr1uGDuO7kFkZkhNkK4cKizIjqXvbN/NBgh
         ZTxg==
X-Gm-Message-State: AOAM530MyjxLBPjMBORAOV0O79blI9x2FVsNX/5fjepIxHVFeKxcELWe
        Um2HWbMLzZOYB5Z2nBha/UE=
X-Google-Smtp-Source: ABdhPJwAthfZ/KeZY78XuTTHq8T6fqfjkQEvI+eHy9al2QidR5WrNuvxcxE+o7Ce47jmjQupbHC6vg==
X-Received: by 2002:a62:8688:: with SMTP id x130mr48229390pfd.280.1594107910659;
        Tue, 07 Jul 2020 00:45:10 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 191sm21330151pfw.150.2020.07.07.00.45.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 00:45:10 -0700 (PDT)
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
Subject: [PATCH v4 00/11] clean-up the migration target allocation functions
Date:   Tue,  7 Jul 2020 16:44:38 +0900
Message-Id: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

This patchset clean-up the migration target allocation functions.

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
2. make one external hugetlb alloc function to internal one.
3. unify three functions for migration target allocation.

The patchset is based on next-20200703 + revert v3 of this patchset.

git revert ddc017c727e429488cccd401a7794c8152e50a5b~1..583c2617fd3244fff79ba3b445964884c5cd7780

The patchset is available on:

https://github.com/JoonsooKim/linux/tree/cleanup-migration-target-allocation-v4.00-next-20200703

Thanks.

Joonsoo Kim (11):
  mm/page_isolation: prefer the node of the source page
  mm/migrate: move migration helper from .h to .c
  mm/hugetlb: unify migration callbacks
  mm/hugetlb: make hugetlb migration callback CMA aware
  mm/migrate: clear __GFP_RECLAIM for THP allocation for migration
  mm/migrate: make a standard migration target allocation function
  mm/gup: use a standard migration target allocation callback
  mm/mempolicy: use a standard migration target allocation callback
  mm/page_alloc: remove a wrapper for alloc_migration_target()
  mm/memory-failure: remove a wrapper for alloc_migration_target()
  mm/memory_hotplug: remove a wrapper for alloc_migration_target()

 include/linux/hugetlb.h | 28 ++++++++++++-------
 include/linux/migrate.h | 34 +++++------------------
 mm/gup.c                | 60 +++++------------------------------------
 mm/hugetlb.c            | 71 +++++++++++++++++++------------------------------
 mm/internal.h           |  9 ++++++-
 mm/memory-failure.c     | 15 +++++------
 mm/memory_hotplug.c     | 42 +++++++++++++++--------------
 mm/mempolicy.c          | 29 +++++---------------
 mm/migrate.c            | 59 ++++++++++++++++++++++++++++++++++++++--
 mm/page_alloc.c         |  8 ++++--
 mm/page_isolation.c     |  5 ----
 11 files changed, 163 insertions(+), 197 deletions(-)

-- 
2.7.4

