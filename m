Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12210C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EF7208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KDGM/uPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388433AbgE0LYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:24:08 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:15187 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388414AbgE0LYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590578645; x=1622114645;
  h=from:to:cc:subject:date:message-id:in-reply-to;
  bh=DFocd5jeTsIMiOO4Pa/eJba/mmL/NWJtB06/JmfYgIs=;
  b=KDGM/uPktHPh4dfLsDs9cQbwdzjiNq9UMn9s7cSHQHhO2JM/N0sNAIE9
   obOc16ZOwiv+cHOqU4EiZ/RzoFLGlWhB9dhBPG1z6XwcXuv4fP6XQrHPS
   NTC7++jO/KihG/0r75UTgcdTzWAfI30Nq8//l/Cmpqwv6hxhb6D3Y7QSs
   s=;
IronPort-SDR: 66TYDWmV85+x7TJR4HyvtWzhIn0lN0f7OK9Bvi4H9cEhtAEBJs+ptoyIZOLIT798vIblwD3+A7
 4bXL1rhJIU3g==
X-IronPort-AV: E=Sophos;i="5.73,441,1583193600"; 
   d="scan'208";a="33842663"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 27 May 2020 11:24:05 +0000
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id F3929A05C9;
        Wed, 27 May 2020 11:23:52 +0000 (UTC)
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (localhost [127.0.0.1])
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 04RBNoud027138;
        Wed, 27 May 2020 13:23:50 +0200
Received: (from foersleo@localhost)
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Submit) id 04RBNov2027136;
        Wed, 27 May 2020 13:23:50 +0200
From:   Leonard Foerster <foersleo@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@Huawei.com, aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, dwmw@amazon.com, irogers@google.com,
        jolsa@redhat.com, kirill@shutemov.name, mark.rutland@arm.com,
        mgorman@suse.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, rdunlap@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        sblbir@amazon.com, shakeelb@google.com, shuah@kernel.org,
        sj38.park@gmail.com, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 04/15] mm/damon: Implement region based sampling
Date:   Wed, 27 May 2020 13:23:48 +0200
Message-Id: <1590578628-27088-1-git-send-email-foersleo@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200525091512.30391-5-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-25T11:15:01+02:00 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit implements DAMON's basic access check and region based
> sampling mechanisms.  This change would seems make no sense, mainly
> because it is only a part of the DAMON's logics.  Following two commits
> will make more sense.
> 
> Basic Access Check
> ------------------
> 
> DAMON basically reports what pages are how frequently accessed.  Note
> that the frequency is not an absolute number of accesses, but a relative
> frequency among the pages of the target workloads.
> 
> Users can control the resolution of the reports by setting two time
> intervals, ``sampling interval`` and ``aggregation interval``.  In
> detail, DAMON checks access to each page per ``sampling interval``,
> aggregates the results (counts the number of the accesses to each page),
> and reports the aggregated results per ``aggregation interval``.  For
> the access check of each page, DAMON uses the Accessed bits of PTEs.
> 
> This is thus similar to common periodic access checks based access
> tracking mechanisms, which overhead is increasing as the size of the
> target process grows.
> 
> Region Based Sampling
> ---------------------
> 
> To avoid the unbounded increase of the overhead, DAMON groups a number
> of adjacent pages that assumed to have same access frequencies into a
> region.  As long as the assumption (pages in a region have same access
> frequencies) is kept, only one page in the region is required to be
> checked.  Thus, for each ``sampling interval``, DAMON randomly picks one
> page in each region and clears its Accessed bit.  After one more
> ``sampling interval``, DAMON reads the Accessed bit of the page and
> increases the access frequency of the region if the bit has set
> meanwhile.  Therefore, the monitoring overhead is controllable by
> setting the number of regions.
> 
> Nonetheless, this scheme cannot preserve the quality of the output if
> the assumption is not kept.  Following commit will introduce how we can
> make the guarantee with best effort.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Leonard Foerster <foersleo@amazon.de>
