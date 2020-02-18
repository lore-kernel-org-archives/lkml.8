Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5ADC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D9620722
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgBRI51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:57:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:53018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgBRI50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:57:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A92AEADE3;
        Tue, 18 Feb 2020 08:57:24 +0000 (UTC)
Date:   Tue, 18 Feb 2020 08:57:21 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC -V2 2/8] autonuma, memory tiering: Rate limit NUMA
 migration throughput
Message-ID: <20200218085721.GC3420@suse.de>
References: <20200218082634.1596727-1-ying.huang@intel.com>
 <20200218082634.1596727-3-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200218082634.1596727-3-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:26:28PM +0800, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> In autonuma memory tiering mode, the hot PMEM (persistent memory)
> pages could be migrated to DRAM via autonuma.  But this incurs some
> overhead too.  So that sometimes the workload performance may be hurt.
> To avoid too much disturbing to the workload, the migration throughput
> should be rate-limited.
> 
> At the other hand, in some situation, for example, some workloads
> exits, many DRAM pages become free, so that some pages of the other
> workloads can be migrated to DRAM.  To respond to the workloads
> changing quickly, it's better to migrate pages faster.
> 
> To address the above 2 requirements, a rate limit algorithm as follows
> is used,
> 
> - If there is enough free memory in DRAM node (that is, > high
>   watermark + 2 * rate limit pages), then NUMA migration throughput will
>   not be rate-limited to respond to the workload changing quickly.
> 
> - Otherwise, counting the number of pages to try to migrate to a DRAM
>   node via autonuma, if the count exceeds the limit specified by the
>   users, stop NUMA migration until the next second.
> 
> A new sysctl knob kernel.numa_balancing_rate_limit_mbps is added for
> the users to specify the limit.  If its value is 0, the default
> value (high watermark) will be used.
> 
> TODO: Add ABI document for new sysctl knob.
> 

I very strongly suggest that this only be done as a last resort and with
supporting data as to why it is necessary. NUMA balancing did have rate
limiting at one point and it was removed when balancing was smart enough
to mostly do the right thing without rate limiting. I posted a series
that reconciled NUMA balancing with the CPU load balancer recently which
further reduced spurious and unnecessary migrations. I would not like
to see rate limiting reintroduced unless there is no other way of fixing
saturation of memory bandwidth due to NUMA balancing. Even if it's
needed as a stopgap while the feature is finalised, it should be
introduced late in the series explaining why it's temporarily necessary.

-- 
Mel Gorman
SUSE Labs
