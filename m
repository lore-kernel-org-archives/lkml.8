Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53599C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3024C2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgCEGKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 01:10:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:54268 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgCEGKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:10:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 22:10:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,516,1574150400"; 
   d="scan'208";a="352289689"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2020 22:10:37 -0800
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Aaron Lu <aaron.lwe@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain>
 <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
 <CAERHkrscBs8WoHSGtnH9mVsN3thfkE0CCQYPRE=XFUWWkQooQQ@mail.gmail.com>
 <CANaguZDQZg-Z6aNpeLcjQ-cGm3X8CQOkZ_hnJNUyqDRM=yVDFQ@mail.gmail.com>
 <bcd601e7-3f15-e340-bebe-a6ca3635dacb@linux.intel.com>
 <a55bb7a5-bb20-d3f3-e634-4dfda1ac6005@linux.intel.com>
 <67e46f79-51c2-5b69-71c6-133ec10b68c4@linux.intel.com>
 <20200305043330.GA8755@ziqianlu-desktop.localdomain>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <b386bd08-112d-df30-256c-dee85780abbc@linux.intel.com>
Date:   Thu, 5 Mar 2020 14:10:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200305043330.GA8755@ziqianlu-desktop.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/5 12:33, Aaron Lu wrote:
> On Wed, Mar 04, 2020 at 07:54:39AM +0800, Li, Aubrey wrote:
>> On 2020/3/3 22:59, Li, Aubrey wrote:
>>> On 2020/2/29 7:55, Tim Chen wrote:
> ...
>>>> In Vinnet's fix, we only look at the currently running task's weight in
>>>> src and dst rq.  Perhaps the load on the src and dst rq needs to be considered
>>>> to prevent too great an imbalance between the run queues?
>>>
>>> We are trying to migrate a task, can we just use cfs.h_nr_running? This signal
>>> is used to find the busiest run queue as well.
>>
>> How about this one? the cgroup weight issue seems fixed on my side.
> 
> It doesn't apply on top of your coresched_v4-v5.5.2 branch, so I
> manually allied it. Not sure if I missed something.

Here is a rebase version on coresched_v5 Vineeth released this morning:
https://github.com/aubreyli/linux/tree/coresched_V5-v5.5.y-rc1

> 
> It's now getting 4 cpus in 2 cores. Better, but not back to normal yet..

I always saw higher weight tasks getting 8 cpus in 4 cores on my side.
Are you still running 8+16 sysbench cpu threads? 

I replicated your setup, the cpuset with 8cores 16threads, cpu mode 8 sysbench
threads with cpu.shares=10240, 16 sysbench threads with cpu.shares=2, and here
is the data on my side.

				weight(10240)		weight(2)
coresched disabled		324.23(eps)		356.43(eps)
coresched enabled		340.74(eps)		311.62(eps)

It seems higher weight tasks win this time and lower weight tasks have ~15%
regression(not big deal?), did you see anything worse?

Thanks,
-Aubrey
