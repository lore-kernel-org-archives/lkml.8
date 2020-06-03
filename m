Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AB0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 058372077D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="l4Bg5PpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgFCIW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:22:29 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:3688 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCIW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591172548; x=1622708548;
  h=from:to:cc:subject:date:message-id:in-reply-to;
  bh=ltepDip8GYGH7s3qWkk+SVUPzdNz3z4BCaQ5UJOGsY4=;
  b=l4Bg5PpOBsmTGqVUAxguiOUchaPHDyJALO52b0MpEcZ0fAI4lTtRquRm
   OHiira0PmQD4bQ6MrmWT0C/plaLFw39GSx2oR6gwgKudWDyZy3OFSva5j
   z7DpxoLLx2Jk3UwDvNLKL0mzsE5Lds+KwHjDxBwrmYkBIeEgoTkik+4wF
   c=;
IronPort-SDR: EElwHaomUF4hKHGT9UT0OPvO30M5R1ERpO/Gy4Ud0OsEFwjpNQxd7g4OoONO0VbMKA/dYoGzoE
 ACZozbNH6gtQ==
X-IronPort-AV: E=Sophos;i="5.73,467,1583193600"; 
   d="scan'208";a="35503456"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 03 Jun 2020 08:22:12 +0000
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id B32C7A2897;
        Wed,  3 Jun 2020 08:22:08 +0000 (UTC)
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (localhost [127.0.0.1])
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 0538M6vl025816;
        Wed, 3 Jun 2020 10:22:06 +0200
Received: (from foersleo@localhost)
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Submit) id 0538M27b025751;
        Wed, 3 Jun 2020 10:22:02 +0200
From:   Leonard Foerster <foersleo@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@Huawei.com, aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, dwmw@amazon.com, foersleo@amazon.de,
        irogers@google.com, jolsa@redhat.com, kirill@shutemov.name,
        mark.rutland@arm.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, sblbir@amazon.com, shakeelb@google.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 04/15] mm/damon: Adaptively adjust regions
Date:   Wed,  3 Jun 2020 10:21:58 +0200
Message-Id: <1591172518-25575-1-git-send-email-foersleo@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200602130125.20467-5-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-02T15:01:14+02:00 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> At the beginning of the monitoring, DAMON constructs the initial regions
> by evenly splitting the memory mapped address space of the process into
> the user-specified minimal number of regions.  In this initial state,
> the assumption of the regions (pages in same region have similar access
> frequencies) is normally not kept and thus the monitoring quality could
> be low.  To keep the assumption as much as possible, DAMON adaptively
> merges and splits each region.
> 
> For each ``aggregation interval``, it compares the access frequencies of
> adjacent regions and merges those if the frequency difference is small.
> Then, after it reports and clears the aggregated access frequency of
> each region, it splits each region into two regions if the total number
> of regions is smaller than the half of the user-specified maximum number
> of regions.
> 
> In this way, DAMON provides its best-effort quality and minimal overhead
> while keeping the bounds users set for their trade-off.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Leonard Foerster <foersleo@amazon.de>
