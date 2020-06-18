Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907A2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB1021974
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TUG/9Nqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgFRJXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:23:22 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:47492 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbgFRJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592472201; x=1624008201;
  h=from:to:cc:subject:date:message-id:in-reply-to;
  bh=FrQFWi/xY34CO1aXWXmdnkW19MrSY+JhOMiMHLm7T+s=;
  b=TUG/9NqbRMFwKlSmGeqQVp3K2F9ohQgW4U9TbzQI/uL6l1Q/NWuxKRad
   J9MVEH7PTzQM3gHKPQrhMSBl4YLifqsyjJIcUPCn2txmLWKhneCciuRQw
   Qvpt+jc/ex+ByDvd9GRAPefc4LNgWt22q64itkCBMoZqPTMtoPhZe7gGQ
   Y=;
IronPort-SDR: 3luC+foP3FAHkqHBVGpAbflh+Fhxy3xXWOoEx/AnfvPeb0zPbKm0C8zlJBhWMTia+K8OdqjEuM
 QmiwPjg/YZCA==
X-IronPort-AV: E=Sophos;i="5.73,526,1583193600"; 
   d="scan'208";a="38333624"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 18 Jun 2020 09:23:17 +0000
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 57FDB1A09AC;
        Thu, 18 Jun 2020 09:23:13 +0000 (UTC)
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (localhost [127.0.0.1])
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 05I9NAhx022461;
        Thu, 18 Jun 2020 11:23:10 +0200
Received: (from foersleo@localhost)
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Submit) id 05I9N6KK022447;
        Thu, 18 Jun 2020 11:23:06 +0200
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
        ying.huang@intel.com, david@redhat.com, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 03/14] mm/damon: Implement region based sampling
Date:   Thu, 18 Jun 2020 11:23:03 +0200
Message-Id: <1592472183-22394-1-git-send-email-foersleo@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200615161927.12637-4-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-15T18:19:16+02:00 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit implements DAMON's target address space independent high
> level logics for basic access check and region based sampling.  The
> target address space specific logics for the monitoring target address
> regions construction and the access check are required, though.  The
> following commits will provide reference implementations of those for
> the general virtual address spaces and the physical address space.
> Users can implement and use their own versions for their specific use
> cases, though.
> 
> Basic Access Check
> ------------------
> 
> DAMON basically reports what pages are how frequently accessed.  The
> frequency is not an absolute number of accesses, but a ratio.
> 
> For this, DAMON first calls target monitoring construction callback
> (``init_target_regions``), and then the access check callbacks, which is
> assumed to check the access to each page and aggregates the number of
> observed accesses of each page, for every ``sampling interval``.
> Finally, DAMON resets the aggregated count per ``aggregation interval``.
> 
> This is thus similar to the common periodic access checks based
> monitoring mechanisms but provides the access frequency.  The overhead
> will increase as the size of the target process grows.
> 
> Region Based Sampling
> ---------------------
> 
> To avoid the unbounded increase of the overhead, DAMON groups a number
> of adjacent pages that assumed to have same access frequencies into a
> region.  As long as the assumption (pages in a region have same access
> frequencies) is kept, only one page in the region is required to be
> checked.  Therefore, the monitoring overhead is controllable by setting
> the number of regions.
> 
> Nonetheless, this scheme cannot preserve the quality of the output if
> the assumption is not kept.  Following commit will introduce how we can
> make the guarantee with some sort of best effort.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---

Reviewed-by: Leonard Foerster <foersleo@amazon.de>
