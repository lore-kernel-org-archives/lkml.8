Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7523DC54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 03:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61238214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 03:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDTD0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 23:26:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:6246 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgDTD0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 23:26:49 -0400
IronPort-SDR: 98Rb07V6QK9PPrQ0WqEam7u24KdCdJDl4CVkVMWEMOiLOPnmhsVxbLhsgCyRDQsDW8uiHMLzG4
 S/cKV03Pe/MQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 20:26:46 -0700
IronPort-SDR: 3ivqihb11g1hPSROSw4eMzCqTmuhzzMlOVw2DRnhT5NpR2CQeh2GG5FmuRe6jyDnydFbaMACPt
 loMEBUQ7JLnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; 
   d="scan'208";a="245236913"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga007.fm.intel.com with ESMTP; 19 Apr 2020 20:26:41 -0700
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
        <87o8rsxlws.fsf@yhuang-dev.intel.com>
        <20200417100633.GU20730@hirez.programming.kicks-ass.net>
Date:   Mon, 20 Apr 2020 11:26:40 +0800
In-Reply-To: <20200417100633.GU20730@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Fri, 17 Apr 2020 12:06:33 +0200")
Message-ID: <87368yu9an.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Apr 16, 2020 at 09:24:35AM +0800, Huang, Ying wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>> 
>> > On Tue, Apr 14, 2020 at 01:06:46PM +0100, Mel Gorman wrote:
>> >> While it's just an opinion, my preference would be to focus on reducing
>> >> the cost and amount of scanning done -- particularly for threads.
>> >
>> > This; I really don't believe in those back-charging things, esp. since
>> > not having cgroups or having multiple applications in a single cgroup is
>> > a valid setup.
>> 
>> Technically, it appears possible to back-charge the CPU time to the
>> process/thread directly (not the cgroup).
>
> I've yet to see a sane proposal there. What we're not going to do is
> make regular task accounting more expensive than it already is.

Yes.  There's overhead to back-charge.  To reduce the overhead, instead
of back-charge immediately, we can

- Add one field to task_struct, say backcharge_time, to track the
  delayed back-charged CPU time.

- When the work item completes its work, add the CPU time it spends to
  task_struct->backcharge_time atomically

- When the task account CPU regularly, e.g. in scheduler_tick(),
  task_struct->backcharge is considered too.

Although this cannot eliminate the overhead, it can reduce it.  Do you
think this is acceptable or not?

Best Regards,
Huang, Ying
