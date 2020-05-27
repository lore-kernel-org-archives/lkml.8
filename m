Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1F9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBA72078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="likIzk5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgE0Gpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgE0Gpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:45:44 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E31C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:45:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y198so11418994pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FhCctwpJtiCtMs9VC+6X+PQl7cxVICigfkuhHn4U+Hk=;
        b=likIzk5AMzU8Bulh0gTFmF5HpfBkKD2R5abeFNSqho7H7rDbLTLcZdPtfCF997rVuc
         S8lXCIQe2Su7YO3qY+7IxscF5IwPYJpL/8KZdV/BrFsnytqXkkleS3ThIiQfO2mUX+9u
         dxIJOSPFEKV8AqHoepE1bGwiC/Z89OC/Wbd6dDVmRPi5JXmt8AeoTJjGL5Rqpd3OHn37
         hUZKrAWjc3GTMt7aRTczYLcLkv9NpaUgDvFShlzXBePHLcOHkaz1oPWfzNVxFWvjJgqP
         zKQHXkNm+FnFyMNRywwiLNbu1vlYna2P564aRJVi7ZXCEp4kNXiITAQ1BXzxcmK7dIOX
         cSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FhCctwpJtiCtMs9VC+6X+PQl7cxVICigfkuhHn4U+Hk=;
        b=MnEd4dZt/BhPDr/w+RgBZjdASPXrxKmLuwBlzCy2B24+jIn0vkX/5wkSziz4ysVuPU
         QFsrl0erzL6BkgFI3vaEa/p++s5aBPDcBNUCTtg3O70fnmqe8IbaLSHi67X/sD1XYCng
         u30Ygd0PAQAIO7fGkzJ00pQ2UFZ0BfgvLklOa/hs70sX3U8W+rV9X7CUlDzLc4HWcyFb
         +G0zekaCKEGztlAQXr+8IdWL2hHnd5Qm5GpJFTVM67hH0J7e1C5FmnwpcWyRVXTjY4vE
         dS4iIrp79Gc36InILSUGnc4tevb6jMuni/bX2O72B+pQdmKpum5neds+Oz6Ik1Z8FNKB
         N5IA==
X-Gm-Message-State: AOAM533QiL1lEtP8uE+CuN9DFxiv+VGAS1QeXdYAN+jUcRoi3eF0AQan
        dj8METy0kxoup9Nt/YvIKR0=
X-Google-Smtp-Source: ABdhPJzPgFwUTJsWZYTys0ipZGYUUj8WsS0H5icQu7S26RMbe/Tan7rSsG59BhDd86i3/q2yW52+bA==
X-Received: by 2002:a63:5015:: with SMTP id e21mr2587886pgb.54.1590561943286;
        Tue, 26 May 2020 23:45:43 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r13sm443883pgv.50.2020.05.26.23.45.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:45:42 -0700 (PDT)
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
Subject: [PATCH v2 00/12] clean-up the migration target allocation functions
Date:   Wed, 27 May 2020 15:44:51 +0900
Message-Id: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

This patchset clean-up the migration target allocation functions.

* Changes on v2
- add acked-by tags
- fix missing compound_head() call for the patch #3
- remove thisnode field on alloc_control and use __GFP_THISNODE directly
- fix missing __gfp_mask setup for the patch
"mm/hugetlb: do not modify user provided gfp_mask"

* Cover-letter

Contributions of this patchset are:
1. unify two hugetlb alloc functions. As a result, one is remained.
2. make one external hugetlb alloc function to internal one.
3. unify three functions for migration target allocation.

The patchset is based on next-20200526.
The patchset is available on:

https://github.com/JoonsooKim/linux/tree/cleanup-migration-target-allocation-v2.00-next-20200526

Thanks.

Joonsoo Kim (12):
  mm/page_isolation: prefer the node of the source page
  mm/migrate: move migration helper from .h to .c
  mm/hugetlb: introduce alloc_control structure to simplify migration
    target allocation APIs
  mm/hugetlb: use provided ac->gfp_mask for allocation
  mm/hugetlb: unify hugetlb migration callback function
  mm/hugetlb: make hugetlb migration target allocation APIs CMA aware
  mm/hugetlb: do not modify user provided gfp_mask
  mm/migrate: change the interface of the migration target alloc/free
    functions
  mm/migrate: make standard migration target allocation functions
  mm/gup: use standard migration target allocation function
  mm/mempolicy: use standard migration target allocation function
  mm/page_alloc: use standard migration target allocation function
    directly

 include/linux/hugetlb.h        | 33 ++++++---------
 include/linux/migrate.h        | 44 +++++---------------
 include/linux/page-isolation.h |  4 +-
 mm/compaction.c                | 15 ++++---
 mm/gup.c                       | 60 +++++-----------------------
 mm/hugetlb.c                   | 91 ++++++++++++++++++++----------------------
 mm/internal.h                  | 12 +++++-
 mm/memory-failure.c            | 14 ++++---
 mm/memory_hotplug.c            | 10 +++--
 mm/mempolicy.c                 | 38 ++++++------------
 mm/migrate.c                   | 72 +++++++++++++++++++++++++--------
 mm/page_alloc.c                |  9 ++++-
 mm/page_isolation.c            |  5 ---
 13 files changed, 191 insertions(+), 216 deletions(-)

-- 
2.7.4

