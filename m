Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FDCC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 04:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80AB2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 04:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVlWs/nV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgCWEtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 00:49:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41796 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgCWEtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 00:49:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id b1so6572734pgm.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 21:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y/459EwXnBvPbqygYeTsHrFpUlzAedqw1w+1NWhovRY=;
        b=tVlWs/nVHFjAm8J2CE1FECmJZQGp7Xh2vmJNNgf5wUWk4Ms7NQGd5CT7TDXZEZxHAc
         W+FgzMmlWK2HJODlIahQPm705O6/dwpJldotkNCrC9f61tr8b+ulnd1Omsgua0U84D0R
         qiOd4Beoc6wNDZWhcryPgDDhpDLB78x+tDKT3S9g9cpD49MX40TTDATB14Y765KKElIE
         rARADHvIFvY1h2c/TbtSmUn3Oa+T0Oz5gfPc2B8837IazW5YxhoNFnOoKq0bJmFWhrLv
         D/Hqk7cJO7J+rntkMZNl0XAHIANABpl5IXxrd7vQ5kWMbI/X5/GSWaIaY+0eNSKnlPJv
         xbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y/459EwXnBvPbqygYeTsHrFpUlzAedqw1w+1NWhovRY=;
        b=jU7oQnIcV3skEV0C+J/G+uQhY3+1cpnbg7VBYQQpKVSC/u0X0nG6UwjkW1j5mIbwjB
         evBhjNvhsas7Csi20bhNCoWjGvrZczqXei15NkOgSvJyzMtMXvCSF5FczxAOZo5ZB0TB
         JT9hpyAgQC921TRCL5G8Qc083IZ/LwQHu/+8Q8kq8z68KJGntevBIqgmQtbgfkOiT/Im
         TYPWNB+qqNULF3GreaPrZ3px5dokkNWx2PVcOiHbbtovQa4wSf72TlFdT9tZ0w8X33fU
         W4VntZpIFVb+7Cl28NLAskBtcLqoYRZcoRKQxuXkMqojuaHXJGGIzQaLbfkOSoMfo/dr
         hV0w==
X-Gm-Message-State: ANhLgQ3c/FGQNqByYeSIacLT27VVGPjBuXDImqFcfkgDJT8YiJhsK0Bm
        UNkZfql2ZVyEZfUHYaOEoSrDzD3FY1g=
X-Google-Smtp-Source: ADFU+vt8AuMOhKYy9v2rI1faQWtv5bK9i2Mw1yOFDdzUUdg6mVNVlfr4bS0/2fhxoJKJ+lusk8Gd7g==
X-Received: by 2002:a62:2b8a:: with SMTP id r132mr23767799pfr.56.1584938989309;
        Sun, 22 Mar 2020 21:49:49 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id c207sm11903982pfb.47.2020.03.22.21.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 21:49:48 -0700 (PDT)
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
Subject: [PATCH v4 0/2] integrate classzone_idx and high_zoneidx
Date:   Mon, 23 Mar 2020 13:49:30 +0900
Message-Id: <1584938972-7430-1-git-send-email-iamjoonsoo.kim@lge.com>
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

