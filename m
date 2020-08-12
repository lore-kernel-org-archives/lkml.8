Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C43C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 02:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F5620756
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 02:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgHLCBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 22:01:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:51722 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgHLCBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 22:01:32 -0400
IronPort-SDR: LApbkIvf0Kgw7tw9IplU6ia/aGuqRT6iJe1VGqJXrLN/HkztnuqEY92GdFOJl+k4Bevi8ZHhAK
 B4yQqeBJxwJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="153090462"
X-IronPort-AV: E=Sophos;i="5.76,302,1592895600"; 
   d="scan'208";a="153090462"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 19:01:31 -0700
IronPort-SDR: 9+0Yo726VjceIDmd/KbjT1zLuJbpSql8HEm+HrHKDEKIzaIGQUOrglKhPY5dxbIeUdhDzTBMfj
 WXNTQcj/Ogmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,302,1592895600"; 
   d="scan'208";a="334765790"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by orsmga007.jf.intel.com with ESMTP; 11 Aug 2020 19:01:25 -0700
Subject: Re: [RFC PATCH 00/16] Core scheduling v6
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     viremana@linux.microsoft.com,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Ning, Hongyu" <hongyu.ning@linux.intel.com>,
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <6d0f9fc0-2e34-f559-29bc-4143e6d3f751@linux.intel.com>
 <CAEXW_YS6oW_AAkmOuXNMCj_N5763aG9SXEcWz_onPhQQU2TZ0g@mail.gmail.com>
 <f986f5a9-5c97-10ed-1e44-84bbd929e605@linux.intel.com>
 <20200809164408.GA342447@google.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <162a03cc-66c3-1999-83a2-deaad5aa04c8@linux.intel.com>
Date:   Wed, 12 Aug 2020 10:01:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200809164408.GA342447@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 2020/8/10 0:44, Joel Fernandes wrote:
> Hi Aubrey,
> 
> Apologies for replying late as I was still looking into the details.
> 
> On Wed, Aug 05, 2020 at 11:57:20AM +0800, Li, Aubrey wrote:
> [...]
>> +/*
>> + * Core scheduling policy:
>> + * - CORE_SCHED_DISABLED: core scheduling is disabled.
>> + * - CORE_COOKIE_MATCH: tasks with same cookie can run
>> + *                     on the same core concurrently.
>> + * - CORE_COOKIE_TRUST: trusted task can run with kernel
>> 			thread on the same core concurrently. 
>> + * - CORE_COOKIE_LONELY: tasks with cookie can run only
>> + *                     with idle thread on the same core.
>> + */
>> +enum coresched_policy {
>> +       CORE_SCHED_DISABLED,
>> +       CORE_SCHED_COOKIE_MATCH,
>> +	CORE_SCHED_COOKIE_TRUST,
>> +       CORE_SCHED_COOKIE_LONELY,
>> +};
>>
>> We can set policy to CORE_COOKIE_TRUST of uperf cgroup and fix this kind
>> of performance regression. Not sure if this sounds attractive?
> 
> Instead of this, I think it can be something simpler IMHO:
> 
> 1. Consider all cookie-0 task as trusted. (Even right now, if you apply the
>    core-scheduling patchset, such tasks will share a core and sniff on each
>    other. So let us not pretend that such tasks are not trusted).
> 
> 2. All kernel threads and idle task would have a cookie 0 (so that will cover
>    ksoftirqd reported in your original issue).
> 
> 3. Add a config option (CONFIG_SCHED_CORE_DEFAULT_TASKS_UNTRUSTED). Default
>    enable it. Setting this option would tag all tasks that are forked from a
>    cookie-0 task with their own cookie. Later on, such tasks can be added to
>    a group. This cover's PeterZ's ask about having 'default untrusted').
>    (Users like ChromeOS that don't want to userspace system processes to be
>    tagged can disable this option so such tasks will be cookie-0).
> 
> 4. Allow prctl/cgroup interfaces to create groups of tasks and override the
>    above behaviors.

How does uperf in a cgroup work with ksoftirqd? Are you suggesting I set uperf's
cookie to be cookie-0 via prctl?

Thanks,
-Aubrey
> 
> 5. Document everything clearly so the semantics are clear both to the
>    developers of core scheduling and to system administrators.
> 
> Note that, with the concept of "system trusted cookie", we can also do
> optimizations like:
> 1. Disable STIBP when switching into trusted tasks.
> 2. Disable L1D flushing / verw stuff for L1TF/MDS issues, when switching into
>    trusted tasks.
> 
> At least #1 seems to be biting enabling HT on ChromeOS right now, and one
> other engineer requested I do something like #2 already.
> 
> Once we get full-syscall isolation working, threads belonging to a process
> can also share a core so those can just share a core with the task-group
> leader.
> 
>>> Is the uperf throughput worse with SMT+core-scheduling versus no-SMT ?
>>
>> This is a good question, from the data we measured by uperf,
>> SMT+core-scheduling is 28.2% worse than no-SMT, :(
> 
> This is worrying for sure. :-(. We ought to debug/profile it more to see what
> is causing the overhead. Me/Vineeth added it as a topic for LPC as well.
> 
> Any other thoughts from others on this?
> 
> thanks,
> 
>  - Joel
> 
> 
>>> thanks,
>>>
>>>  - Joel
>>> PS: I am planning to write a patch behind a CONFIG option that tags
>>> all processes (default untrusted) so everything gets a cookie which
>>> some folks said was how they wanted (have a whitelist instead of
>>> blacklist).
>>>
>>

