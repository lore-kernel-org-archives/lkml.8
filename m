Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376A8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042C9207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEUYT5d3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgERBVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgERBVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:21:40 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7727C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:21:40 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s10so1814990pgm.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EOiAYIbPHXBk/CjBM2wyL2J8T44WPRGVhqC7t2NlRp4=;
        b=iEUYT5d3lsJutyCK8M2Yt9zzJfR8wnxAu6GipHa+ACUQE6DemN1ok4NyjeuIJ0x7vM
         XwBCs9FjakumG1QxuimQcV5AVEQ3FwbuG7Q9A8mEZRdDtTa6VdhtRk7A1NnwdLz63+vY
         khbjrWFUHD61Wcge3L7I8L79pb1f2LruKzzRtEC5eSLleqWmAE9u+WwIQKyB3dB5fFCk
         f/GyxOzQoNhqAVrlCljpx1mKPYO579ijSuZQaUAofARisp0v1wdB8QKgMcVeYgyUdcV0
         fo0NlYqLo8Dvju3IZCnVsOKP/UJ8PjLYgU5DWuoUNkhJZtT4T7iWnLqQ0HhGTfO9iaev
         JIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EOiAYIbPHXBk/CjBM2wyL2J8T44WPRGVhqC7t2NlRp4=;
        b=fv8ll9HdcoLmZADi0jDrtAYDoEf5GYUya4DzBjuCoonF6GgBM/IS2TrUQAGnsPzoea
         8vfM1z75lo4m6r+nPTv0UbTEiRDwWaX8VryPwnEtt0zjxqvAcRcZtHgNBr7J479gLffV
         j/8mU46AorGq9d4QSCax3BHK0TUVayh6DyG6HfDibzdlxCiG3LM6OdDPKY6rgIv9ewMn
         FKoDPV2IB/79BEPzsOn3B1WRPFwijd/dJLqSONwq/jPlt98s5/PnfLgRGFRRa+1DgOEN
         7v4UZFNY0UkEmwjnb6VKiQAWkA8TkVYyCQvOdYg7bDpAnypE14W6NMkRAbYq9ZhiWNew
         dsgA==
X-Gm-Message-State: AOAM530dOyZ4yZr6/K9TIdSqQiFhllrTiCLrkfGnuEhf6rSbEyD6rgXR
        V3Lj5LTSICHGQoENf35V4cQ=
X-Google-Smtp-Source: ABdhPJw3PYsUVGZwikbg09dhIpRtwKWlR+3iYbPBHqIJtYgDNJ8rswWLbyMwxRoEw+JcuXFF6O7E8g==
X-Received: by 2002:a63:f242:: with SMTP id d2mr13423800pgk.212.1589764900114;
        Sun, 17 May 2020 18:21:40 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id fw4sm1544376pjb.31.2020.05.17.18.21.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 18:21:39 -0700 (PDT)
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
Subject: [PATCH 00/11] clean-up the migration target allocation functions
Date:   Mon, 18 May 2020 10:20:46 +0900
Message-Id: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

This patchset clean-up the migration target allocation functions.

Contributions of this patchset are:
1. unify two hugetlb alloc functions. As a result, one is remained.
2. make one external hugetlb alloc function to internal one.
3. unify three functions for migration target allocation.

The patchset is based on next-20200515.
The patchset is available on:

https://github.com/JoonsooKim/linux/tree/cleanup-migration-target-allocation-v1.00-next-20200515

Thanks.

Joonsoo Kim (11):
  mm/page_isolation: prefer the node of the source page
  mm/migrate: move migration helper from .h to .c
  mm/hugetlb: introduce alloc_control structure to simplify migration
    target allocation APIs
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
 mm/internal.h                  | 13 +++++-
 mm/memory-failure.c            | 14 ++++---
 mm/memory_hotplug.c            | 10 +++--
 mm/mempolicy.c                 | 39 ++++++------------
 mm/migrate.c                   | 75 ++++++++++++++++++++++++++--------
 mm/page_alloc.c                |  9 ++++-
 mm/page_isolation.c            |  5 ---
 13 files changed, 196 insertions(+), 216 deletions(-)

-- 
2.7.4

