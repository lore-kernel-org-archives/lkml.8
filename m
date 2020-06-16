Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7A6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B060D2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqxSSVhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgFPGRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPGRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:17:04 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6484C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:17:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n2so7904548pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9YqQzMhBT4/SqLqwXxw8ijULOp4qNw4LR0gnhh/zm4Y=;
        b=lqxSSVhYbEjS5CFw0LXMpLenPEvpANDGpfqZy6QWRNx8kmvBTT2oQafWjhCseDbKgi
         DssXMI+8WOp0RrjFkEkGEhs0fR/72IjcM3j1k3IChOC0YMMkoNuYGJJrPajDhYqyMIQz
         nCy3LjUpLaIu+2P8GanMYoc+gkbnUV+/mUzg2+Fj+ZZqpmhhNnUB30QLpZo+ysF0LYLR
         H7ZOsPip8lqL/w4Vdd+vSUyPQ8F/2ymrqBNnMfq1tpr98dTkGnUIy3pMqe4SSraHBUIG
         JiFKjtYO7oyWCaynDByBEk2cyv9BmV1PJ8XIqeeoeQexCa6Z5A41caICRoZJDO71ncDr
         3R0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9YqQzMhBT4/SqLqwXxw8ijULOp4qNw4LR0gnhh/zm4Y=;
        b=fVHjo1r3bkgcnTV4nqDutM/lzb2mp/+Po6i4D7WWLnqrG0IieDttrRkRi+e9/vUQni
         zRVsM/cvd+THDGmS2z5k1BRbtolNwUhSJVPbQkCWmwXfH7GNbgj1fcW6bwjrbP7z04ra
         87gDQ7dK3g8shXCy78/PUPBXPTvl+EIc5CpPli1s5ZkoD8A8tpDL47Z+ZmEhCyo7nK20
         iZff1ZJPIRzfufuafhZNEsalnGY/p4rsYnvro7PYAcJV4kI5C2LC6ls4Zz9/T/sASdFG
         GgeFdIO9irEuTXTqB8g7ZK3rLRkdxXahPeo6+kNyUv3vujvwplyqoEUZ/iyEuo77ZInY
         XNMw==
X-Gm-Message-State: AOAM532viY7OoM7lWS/GO8MqwGjJfTrekOOow9BdD5E2UIxFPoLLGPGH
        qScgPYR1ONUz2vBzxqysVGg=
X-Google-Smtp-Source: ABdhPJwbRJOVKbjE9suwZpxorgkp6N5CYspomAMZvo5lbyB2pVnaqiKcgXyqro1GRr2tUPKNK/nwgg==
X-Received: by 2002:a17:90a:bf92:: with SMTP id d18mr1309048pjs.120.1592288223435;
        Mon, 15 Jun 2020 23:17:03 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 207sm15449267pfw.190.2020.06.15.23.17.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 23:17:02 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH for v5.8 0/3] fix for "mm: balance LRU lists based on relative thrashing" patchset
Date:   Tue, 16 Jun 2020 15:16:41 +0900
Message-Id: <1592288204-27734-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

This patchset fixes some problems of the patchset,
"mm: balance LRU lists based on relative thrashing", which is now merged
on the mainline.

Patch "mm: workingset: let cache workingset challenge anon fix" is
the result of discussion with Johannes. See following link.

http://lkml.kernel.org/r/20200520232525.798933-6-hannes@cmpxchg.org

And, the other two are minor things which are found when I try
to rebase my patchset.

Johannes Weiner (1):
  mm: workingset: age nonresident information alongside anonymous pages

Joonsoo Kim (2):
  mm/swap: fix for "mm: workingset: age nonresident information
    alongside anonymous pages"
  mm/memory: fix IO cost for anonymous page

 include/linux/mmzone.h |  4 ++--
 include/linux/swap.h   |  1 +
 mm/memory.c            |  8 ++++++++
 mm/swap.c              |  3 +--
 mm/vmscan.c            |  3 +++
 mm/workingset.c        | 46 +++++++++++++++++++++++++++-------------------
 6 files changed, 42 insertions(+), 23 deletions(-)

-- 
2.7.4

