Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C5DC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 06:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46E2207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 06:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgBSGCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 01:02:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:45551 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgBSGCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 01:02:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 22:02:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,459,1574150400"; 
   d="scan'208";a="269047072"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.41])
  by fmsmga002.fm.intel.com with ESMTP; 18 Feb 2020 22:02:03 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michal Hocko" <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC -V2 2/8] autonuma, memory tiering: Rate limit NUMA migration throughput
References: <20200218082634.1596727-1-ying.huang@intel.com>
        <20200218082634.1596727-3-ying.huang@intel.com>
        <20200218085721.GC3420@suse.de>
Date:   Wed, 19 Feb 2020 14:01:57 +0800
In-Reply-To: <20200218085721.GC3420@suse.de> (Mel Gorman's message of "Tue, 18
        Feb 2020 08:57:21 +0000")
Message-ID: <87sgj7glnu.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mel,

Thanks a lot for your review!

Mel Gorman <mgorman@suse.de> writes:

> On Tue, Feb 18, 2020 at 04:26:28PM +0800, Huang, Ying wrote:
>> From: Huang Ying <ying.huang@intel.com>
>> 
>> In autonuma memory tiering mode, the hot PMEM (persistent memory)
>> pages could be migrated to DRAM via autonuma.  But this incurs some
>> overhead too.  So that sometimes the workload performance may be hurt.
>> To avoid too much disturbing to the workload, the migration throughput
>> should be rate-limited.
>> 
>> At the other hand, in some situation, for example, some workloads
>> exits, many DRAM pages become free, so that some pages of the other
>> workloads can be migrated to DRAM.  To respond to the workloads
>> changing quickly, it's better to migrate pages faster.
>> 
>> To address the above 2 requirements, a rate limit algorithm as follows
>> is used,
>> 
>> - If there is enough free memory in DRAM node (that is, > high
>>   watermark + 2 * rate limit pages), then NUMA migration throughput will
>>   not be rate-limited to respond to the workload changing quickly.
>> 
>> - Otherwise, counting the number of pages to try to migrate to a DRAM
>>   node via autonuma, if the count exceeds the limit specified by the
>>   users, stop NUMA migration until the next second.
>> 
>> A new sysctl knob kernel.numa_balancing_rate_limit_mbps is added for
>> the users to specify the limit.  If its value is 0, the default
>> value (high watermark) will be used.
>> 
>> TODO: Add ABI document for new sysctl knob.
>> 
>
> I very strongly suggest that this only be done as a last resort and with
> supporting data as to why it is necessary. NUMA balancing did have rate
> limiting at one point and it was removed when balancing was smart enough
> to mostly do the right thing without rate limiting. I posted a series
> that reconciled NUMA balancing with the CPU load balancer recently which
> further reduced spurious and unnecessary migrations. I would not like
> to see rate limiting reintroduced unless there is no other way of fixing
> saturation of memory bandwidth due to NUMA balancing. Even if it's
> needed as a stopgap while the feature is finalised, it should be
> introduced late in the series explaining why it's temporarily necessary.

This adds rate limit to NUMA migration between the different
types of memory nodes only (e.g. from PMEM to DRAM), but not between the
same types of memory nodes (e.g. from DRAM to DRAM).  Sorry for
confusing patch subject.  I will change it in the next version.

And, rate limit is an inherent part of the algorithm used in the
patchset.  Because we just use LRU algorithm to find the cold pages on
the fast memory node (e.g. DRAM), and use NUMA hint page fault latency
to find the hot pages on the slow memory node (e.g. PMEM).  But we don't
compare the temperature between the cold DRAM pages and the hot PMEM
pages.  Instead, we just try to exchange some cold DRAM pages and some
hot PMEM pages, even if the cold DRAM pages is hotter than the hot PMEM
pages.  The rate limit is used to control how many pages to exchange
between DRAM and PMEM per second.  This isn't perfect, but it works well
in our testing.

Best Regards,
Huang, Ying

