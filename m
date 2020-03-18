Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6830CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6CC20724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3/+H/bS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgCRDd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 23:33:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41813 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRDd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:33:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id z65so13103864pfz.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 20:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yC1wCJzwl3YSlap+R09e4u2rGP2ltVp+lt9+WdncnuY=;
        b=i3/+H/bSR7cvSqUI7BTixhiB5EatQK7NrT8bhYZAyZY6MZn9F1sA5bJ06dVou97Mc2
         vvQaS0aNYbjnuIbTXrBpD9+yloduRSNldY5u3V7H6WVy/5KKJ/1cx8pWInvKwmDvl3/i
         deRLLrFQVGk40cdXfqNXhd542NRBro+lmhIxzzGkzJkmMR7han62itcY3JtT/GoOrvJI
         DbeVXF7DWp2u9r42Z0elXWGtrbm7EcvAQUtGOMTfIgNbyyRIEJB2D6lJFR8sxX9zlCDa
         lZ3t3j53koa9elAdW46xwUAbTl8DmMSKNJU0aqnpBd6LjV98XMF/FRNS0ELo0YkwuZWO
         u6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yC1wCJzwl3YSlap+R09e4u2rGP2ltVp+lt9+WdncnuY=;
        b=YF3+IBT1tLldmE8mL33uYbMm+678/XQsC8RXOsg++ESjgM5/xbw1k0pg7BTGzsBPnZ
         OHhjZDZYYYRXUJ0K6LSKJVmzxQlZdVsJAiWq3OeER1mVRmOwmxfSPSmytMkHKkUlZmwX
         O81EQZA//p5XCPmZKlvHc0s2jQnlkRgNTKiaap1oy2KGO5+3SMmH4eW6q/VGqPhqwO8W
         YUdn6pxsjDZDLzP1m6ftYUT3bDuWupU8n9C2IcX/OZDuMojwLLSy5T8Xwsml+ANgbFwh
         dmMJaNsSyJSPST2EKJY+AKue9Lq3cFbe2cfr54VlgjeSXrFCNWjQVFnCI9oed9XE1vYc
         8r1g==
X-Gm-Message-State: ANhLgQ1SOcX8/ILBnmqYZ6slU0pzH1+TduNWoAZhV9ElVAOnq9FLJOiU
        vL+KwDZAbBPB6KPhyGCTdhPL6C2aYxQ=
X-Google-Smtp-Source: ADFU+vuI/exKyjsI17w36vmhLz9OaloCjVe5WiaewefiZ5qMtyoiQJ7bFfAlysNcBzd3ZoHhO60m9g==
X-Received: by 2002:a63:7551:: with SMTP id f17mr2582845pgn.282.1584502406200;
        Tue, 17 Mar 2020 20:33:26 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id ep7sm679641pjb.24.2020.03.17.20.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Mar 2020 20:33:25 -0700 (PDT)
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 0/2] integrate classzone_idx and high_zoneidx
Date:   Wed, 18 Mar 2020 12:32:56 +0900
Message-Id: <1584502378-12609-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Hello,

This patchset is follow-up of the problem reported and discussed
two years ago [1, 2]. The problem this patchset solves is related to
the NUMA system with the populated ZONE_MOVABLE. Please refer
the patch #1 to check the detail of the problem.

This problem is reported two years ago, and, at that time,
the solution got general agreements [2]. But, due to my laziness,
it's not upstreamed. Now, I tried again.

Thanks.

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
 mm/internal.h                     |  10 ++--
 mm/memory_hotplug.c               |   6 +--
 mm/oom_kill.c                     |   4 +-
 mm/page_alloc.c                   |  60 +++++++++++-----------
 mm/slab.c                         |   4 +-
 mm/slub.c                         |   4 +-
 mm/vmscan.c                       | 105 ++++++++++++++++++++------------------
 12 files changed, 165 insertions(+), 149 deletions(-)

-- 
2.7.4

