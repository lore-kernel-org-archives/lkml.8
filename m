Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40826C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B26720739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3mpNrq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCTIch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 04:32:37 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34948 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgCTIcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 04:32:36 -0400
Received: by mail-pj1-f65.google.com with SMTP id j20so2162237pjz.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y4EXv4j5Ha9va7jIkBAgeEKiDWs7cacB5hfE3z/XjNI=;
        b=W3mpNrq1B8eALqJExPM3rwGmDfRNcD3vC935HFTtGeWReK9DxqQi2vX4fLqrJOjvHD
         VS0cmsnsA9zE5PPCaGCW/dUth1EnYOE9/VdhxjMOpPeNXqwL1sG03duplP5v/Kdrpg/s
         szXtnKxtHAEOh3oLZMYHnLxWW0mbhp7tGyjJNpmz3qYabSqpBtisbfQLMxCPalfN26V7
         JunE1K0m8ey4l/hgAQ9YtJs/GW2zHmup0AY9q8e3uXPpIiWd7L/nehtY1/ETq7ig0qsg
         XMKDZ1W4ybcEVEkwXwoBCf/p7+LHBdy+adHfziv34y1kLnXwtY4YpwXw/O3SR4ClmdDF
         RvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y4EXv4j5Ha9va7jIkBAgeEKiDWs7cacB5hfE3z/XjNI=;
        b=kLG2jMqLTGaHVpklnhVYwvKyZo2QQ1pq6IXsnMPwLhwAFV+pRhLJ4Mxlqgjn5W/by/
         u2uZaQrb9bXxULXhj9AmnA+eo50IaBsAHHd56iS0DwMbpsGMd9B4cgdKYwseZVKcsMI9
         XGuBQkx2q87glEk2k9O1Ys1mWS/GhPtoECT/RyO+DVDQ2WkY0tJG3PS3NoA9hmGbOWrL
         8jHxTC6LQtCwEgft/929/REWQvJLwcXoWc8WT1iDxGnWgRpbSAVwC9HxO7sL+FWmFmfF
         02t1Sk7jCRj5iM7sNOD/TiVQvWfM18zXypgcXwNVz73vSEhpLQ8b/E9IY+K+n3B+ywwF
         YwTQ==
X-Gm-Message-State: ANhLgQ20t5qqAwO+fVCjbRTlwfqDscNusinQkQWi2uo6JT9ejYAr4R23
        9Wu2g2Lo/H5YfAyE3sE2lnA=
X-Google-Smtp-Source: ADFU+vvxzhUqznG+Or05Y8Bj8mN/uU0KJa7ovgxJcjANGImOTzLJWdXEV50j4P1+p/fzHXECTNiqHw==
X-Received: by 2002:a17:90a:8c1:: with SMTP id 1mr8458022pjn.77.1584693154921;
        Fri, 20 Mar 2020 01:32:34 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id y193sm4501986pgd.87.2020.03.20.01.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Mar 2020 01:32:34 -0700 (PDT)
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v3 0/2] integrate classzone_idx and high_zoneidx
Date:   Fri, 20 Mar 2020 17:32:13 +0900
Message-Id: <1584693135-4396-1-git-send-email-iamjoonsoo.kim@lge.com>
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
next-20200317 git tree.

Thanks.

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

