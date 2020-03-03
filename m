Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8E8C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C6D20828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgCCO7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:59:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:39776 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729041AbgCCO7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:59:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 06:59:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="351853842"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2020 06:59:26 -0800
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>
Cc:     Aaron Lu <aaron.lwe@gmail.com>,
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
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
 <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
 <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain>
 <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
 <CAERHkrscBs8WoHSGtnH9mVsN3thfkE0CCQYPRE=XFUWWkQooQQ@mail.gmail.com>
 <CANaguZDQZg-Z6aNpeLcjQ-cGm3X8CQOkZ_hnJNUyqDRM=yVDFQ@mail.gmail.com>
 <bcd601e7-3f15-e340-bebe-a6ca3635dacb@linux.intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <a55bb7a5-bb20-d3f3-e634-4dfda1ac6005@linux.intel.com>
Date:   Tue, 3 Mar 2020 22:59:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <bcd601e7-3f15-e340-bebe-a6ca3635dacb@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/29 7:55, Tim Chen wrote:
> On 2/26/20 1:54 PM, Vineeth Remanan Pillai wrote:
> 
>> rq->curr being NULL can mean that the sibling is idle or forced idle.
>> In both the cases, I think it makes sense to migrate a task so that it can
>> compete with the other sibling for a chance to run. This function
>> can_migrate_task actually only says if this task is eligible and
>> later part of the code decides whether it is okay to migrate it
>> based on factors like load and util and capacity. So I think its
>> fine to declare the task as eligible if the dest core is running
>> idle. Does this thinking make sense?
>>
>> On our testing, it did not show much degradation in performance with
>> this change. I am reworking the fix by removing the check for
>> task_est_util. It doesn't seem to be valid to check for util to migrate
>> the task.
>>
> 
> In Aaron's test case, there is a great imbalance in the load on one core
> where all the grp A tasks are vs the other cores where the grp B tasks are
> spread around.  Normally, load balancer will move the tasks for grp A.
> 
> Aubrey's can_migrate_task patch prevented the load balancer to migrate tasks if the core
> cookie on the target queue don't match.  The thought was it will induce
> force idle and reduces cpu utilization if we migrate task to it.
> That kept all the grp A tasks from getting migrated and kept the imbalance
> indefinitely in Aaron's test case.
> 
> Perhaps we should also look at the load imbalance between the src rq and
> target rq.  If the imbalance is big (say two full cpu bound tasks worth
> of load), we should migrate anyway despite the cookie mismatch.  We are willing
> to pay a bit for the force idle by balancing the load out more.
> I think Aubrey's patch on can_migrate_task should be more friendly to
> Aaron's test scenario if such logic is incorporated.
> 
> In Vinnet's fix, we only look at the currently running task's weight in
> src and dst rq.  Perhaps the load on the src and dst rq needs to be considered
> to prevent too great an imbalance between the run queues?

We are trying to migrate a task, can we just use cfs.h_nr_running? This signal
is used to find the busiest run queue as well.

Thanks,
-Aubrey

