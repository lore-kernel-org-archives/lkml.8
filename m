Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7884AC2BB85
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 01:24:19 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7A5206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 01:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7A5206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgDMBYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 21:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgDMBYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 21:24:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCEFC0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 18:24:17 -0700 (PDT)
IronPort-SDR: boHGRWVogPUkS5P7sIRXfvqHQosGQgkbKWk3rKXNHuqL+7woYD8vU6w7fz6iuu6w14gmzQpwre
 BnbyPKRoYscw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 18:24:16 -0700
IronPort-SDR: Mrmf+TZ6Ou8CfeylXgSh322PBioKgbMDU/Yyw9sBT9TKPo8AyRVp4kEhEHqeEJaj5zP3nr8Nvj
 iTn0Cn1pSRig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,375,1580803200"; 
   d="scan'208";a="453002077"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2020 18:24:15 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: swap: introduce fixed-size readahead policy
References: <20200412150449.GA740985@xps-13>
Date:   Mon, 13 Apr 2020 09:24:14 +0800
In-Reply-To: <20200412150449.GA740985@xps-13> (Andrea Righi's message of "Sun,
        12 Apr 2020 17:04:49 +0200")
Message-ID: <87d08c89fl.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Righi <andrea.righi@canonical.com> writes:

> Introduce a new fixed-size swap-in readahead policy that can be selected
> at run-time.
>
> The global swap-in readahead policy takes in account the previous access
> patterns, using a scaling heuristic to determine the optimal readahead
> chunk dynamically.
>
> This works pretty well in most cases, but like any heuristic there are
> specific cases when this approach is not ideal, for example the swapoff
> scenario.
>
> During swapoff we just want to load back into memory all the swapped-out
> pages and for this specific use case a fixed-size readahead is more
> efficient.
>
> This patch introduces a new sysfs interface
> (/sys/kernel/mm/swap/swap_ra_policy) that can be set as following:
>
>  - 0: current scaling swap-in readahead policy (default)
>  - 1: fixed-size readahead policy (size is determined by
>       vm.page-cluster)
>
> The specific use case this patch is addressing is to improve swapoff
> performance when a VM has been hibernated, resumed and all memory needs
> to be forced back to RAM by disabling swap (see the test case below).

I don't know whether the use case is important or not.  Usually the
performance of swapoff doesn't matter.  Maybe you can provide some
information on this.

Even if it's important, I don't think we really need to add another ABI.
You can just optimize the swapoff performance inside kernel.  And we may
not even need to add a new policy, just use cluster readahead and
increase swapin_readahead_hits in swapoff if cluster readahead is used.

Best Regards,
Huang, Ying
