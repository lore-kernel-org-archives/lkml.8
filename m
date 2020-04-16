Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F2CC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E91E2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgDPBY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:24:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:55379 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbgDPBYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:24:40 -0400
IronPort-SDR: w9j0dUKdfsEKejz45edleyYO38s8QjFEePL/HDTvmi4Pgb9ozgi1HDEJDXBuIKPQmuIo/kCN8f
 9PKPchy1Mfeg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 18:24:39 -0700
IronPort-SDR: AQnTsEyPjDfJLfBwR7ukTNUMbQA3doOQTB0AHlDuA7/jyWZTsHuqs3lNIONfA+48WF41fzdUgG
 eY/ZdXU7NVuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="253699927"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2020 18:24:36 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: [RFC] autonuma: Support to scan page table asynchronously
References: <20200414081951.297676-1-ying.huang@intel.com>
        <20200414120646.GN3818@techsingularity.net>
        <20200415113226.GE20730@hirez.programming.kicks-ass.net>
Date:   Thu, 16 Apr 2020 09:24:35 +0800
In-Reply-To: <20200415113226.GE20730@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Wed, 15 Apr 2020 13:32:26 +0200")
Message-ID: <87o8rsxlws.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Apr 14, 2020 at 01:06:46PM +0100, Mel Gorman wrote:
>> While it's just an opinion, my preference would be to focus on reducing
>> the cost and amount of scanning done -- particularly for threads.
>
> This; I really don't believe in those back-charging things, esp. since
> not having cgroups or having multiple applications in a single cgroup is
> a valid setup.

Technically, it appears possible to back-charge the CPU time to the
process/thread directly (not the cgroup).

> Another way to reduce latency spikes is to decrease both
> sysctl_numa_balancing_scan_delay and sysctl_numa_balancing_scan_size.
> Then you do more smaller scans. By scanning more often you reduce the
> contrast, by reducing the size you lower the max latency.

Yes.  This can reduce latency spikes.

Best Regards,
Huang, Ying

> And this is all assuming you actually want numa balancing for this
> process.
