Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C74C34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9AA20659
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgBRJJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:09:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:59072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgBRJJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:09:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9DA2CAF48;
        Tue, 18 Feb 2020 09:09:35 +0000 (UTC)
Date:   Tue, 18 Feb 2020 09:09:32 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC -V2 3/8] autonuma, memory tiering: Use kswapd to demote
 cold pages to PMEM
Message-ID: <20200218090932.GD3420@suse.de>
References: <20200218082634.1596727-1-ying.huang@intel.com>
 <20200218082634.1596727-4-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200218082634.1596727-4-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:26:29PM +0800, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> In a memory tiering system, if the memory size of the workloads is
> smaller than that of the faster memory (e.g. DRAM) nodes, all pages of
> the workloads should be put in the faster memory nodes.  But this
> makes it unnecessary to use slower memory (e.g. PMEM) at all.
> 
> So in common cases, the memory size of the workload should be larger
> than that of the faster memory nodes.  And to optimize the
> performance, the hot pages should be promoted to the faster memory
> nodes while the cold pages should be demoted to the slower memory
> nodes.  To achieve that, we have two choices,
> 
> a. Promote the hot pages from the slower memory node to the faster
>    memory node.  This will create some memory pressure in the faster
>    memory node, thus trigger the memory reclaiming, where the cold
>    pages will be demoted to the slower memory node.
> 
> b. Demote the cold pages from faster memory node to the slower memory
>    node.  This will create some free memory space in the faster memory
>    node, and the hot pages in the slower memory node could be promoted
>    to the faster memory node.
> 
> The choice "a" will create the memory pressure in the faster memory
> node.  If the memory pressure of the workload is high too, the memory
> pressure may become so high that the memory allocation latency of the
> workload is influenced, e.g. the direct reclaiming may be triggered.
> 
> The choice "b" works much better at this aspect.  If the memory
> pressure of the workload is high, it will consume the free memory and
> the hot pages promotion will stop earlier if its allocation watermark
> is higher than that of the normal memory allocation.
> 
> In this patch, choice "b" is implemented.  If memory tiering NUMA
> balancing mode is enabled, the node isn't the slowest node, and the
> free memory size of the node is below the high watermark, the kswapd
> of the node will be waken up to free some memory until the free memory
> size is above the high watermark + autonuma promotion rate limit.  If
> the free memory size is below the high watermark, autonuma promotion
> will stop working.  This avoids to create too much memory pressure to
> the system.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

Unfortunately I stopped reading at this point. It depends on another series
entirely and they really need to be presented together instead of relying
on searching mail archives to find other patches to try assemble the full
picture :(. Ideally each stage would have supporting data showing roughly
how it behaves at each major stage. I know this will be a pain but the
original NUMA balancing had the same problem and ultimately started with
one large series that got the basics right followed by other series that
improved it in stages. That process is *still* ongoing today.

-- 
Mel Gorman
SUSE Labs
