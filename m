Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74792C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 05:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B27720771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 05:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgHNFSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 01:18:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:65440 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgHNFSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 01:18:10 -0400
IronPort-SDR: 9WPhhedK0i03mCWO2yt/54idOG65O+ScOAXe4X/nJbjYgsB05plAYH9aFGu2yHK+UMxTrvZYty
 uDTIvNd8Ds3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="151773961"
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; 
   d="scan'208";a="151773961"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 22:18:09 -0700
IronPort-SDR: AtRzbQvay8Kd0BLezy/923tIK69BjTo82BJho3OinqGvljQ+y5zpDVbUpD4M6czzA5PN4/0SbK
 Wc9Mp99OAl/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; 
   d="scan'208";a="318773271"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by fmsmga004.fm.intel.com with ESMTP; 13 Aug 2020 22:18:02 -0700
Subject: Re: [RFC PATCH 00/16] Core scheduling v6(Internet mail)
To:     =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
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
        "Ning, Hongyu" <hongyu.ning@linux.intel.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <6d0f9fc0-2e34-f559-29bc-4143e6d3f751@linux.intel.com>
 <CAEXW_YS6oW_AAkmOuXNMCj_N5763aG9SXEcWz_onPhQQU2TZ0g@mail.gmail.com>
 <f986f5a9-5c97-10ed-1e44-84bbd929e605@linux.intel.com>
 <20200809164408.GA342447@google.com>
 <162a03cc-66c3-1999-83a2-deaad5aa04c8@linux.intel.com>
 <20200812230850.GA3511387@google.com>
 <5a39735d-dfd8-bdec-f068-81895799640e@linux.intel.com>
 <FAC73DE7-BAE0-42D3-BE9A-227C12275C34@tencent.com>
 <89d973d1-1302-17a6-c647-ea7c538c2747@linux.intel.com>
 <18263ED7-88B3-4DED-9714-55D9D2EB69D9@tencent.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <97a82444-77ab-dbd2-f765-0d818f94ca0b@linux.intel.com>
Date:   Fri, 14 Aug 2020 13:18:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <18263ED7-88B3-4DED-9714-55D9D2EB69D9@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/14 12:04, benbjiang(蒋彪) wrote:
> 
> 
>> On Aug 14, 2020, at 9:36 AM, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>
>> On 2020/8/14 8:26, benbjiang(蒋彪) wrote:
>>>
>>>
>>>> On Aug 13, 2020, at 12:28 PM, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>>>
>>>> On 2020/8/13 7:08, Joel Fernandes wrote:
>>>>> On Wed, Aug 12, 2020 at 10:01:24AM +0800, Li, Aubrey wrote:
>>>>>> Hi Joel,
>>>>>>
>>>>>> On 2020/8/10 0:44, Joel Fernandes wrote:
>>>>>>> Hi Aubrey,
>>>>>>>
>>>>>>> Apologies for replying late as I was still looking into the details.
>>>>>>>
>>>>>>> On Wed, Aug 05, 2020 at 11:57:20AM +0800, Li, Aubrey wrote:
>>>>>>> [...]
>>>>>>>> +/*
>>>>>>>> + * Core scheduling policy:
>>>>>>>> + * - CORE_SCHED_DISABLED: core scheduling is disabled.
>>>>>>>> + * - CORE_COOKIE_MATCH: tasks with same cookie can run
>>>>>>>> + *                     on the same core concurrently.
>>>>>>>> + * - CORE_COOKIE_TRUST: trusted task can run with kernel
>>>>>>>> 			thread on the same core concurrently. 
>>>>>>>> + * - CORE_COOKIE_LONELY: tasks with cookie can run only
>>>>>>>> + *                     with idle thread on the same core.
>>>>>>>> + */
>>>>>>>> +enum coresched_policy {
>>>>>>>> +       CORE_SCHED_DISABLED,
>>>>>>>> +       CORE_SCHED_COOKIE_MATCH,
>>>>>>>> +	CORE_SCHED_COOKIE_TRUST,
>>>>>>>> +       CORE_SCHED_COOKIE_LONELY,
>>>>>>>> +};
>>>>>>>>
>>>>>>>> We can set policy to CORE_COOKIE_TRUST of uperf cgroup and fix this kind
>>>>>>>> of performance regression. Not sure if this sounds attractive?
>>>>>>>
>>>>>>> Instead of this, I think it can be something simpler IMHO:
>>>>>>>
>>>>>>> 1. Consider all cookie-0 task as trusted. (Even right now, if you apply the
>>>>>>>  core-scheduling patchset, such tasks will share a core and sniff on each
>>>>>>>  other. So let us not pretend that such tasks are not trusted).
>>>>>>>
>>>>>>> 2. All kernel threads and idle task would have a cookie 0 (so that will cover
>>>>>>>  ksoftirqd reported in your original issue).
>>>>>>>
>>>>>>> 3. Add a config option (CONFIG_SCHED_CORE_DEFAULT_TASKS_UNTRUSTED). Default
>>>>>>>  enable it. Setting this option would tag all tasks that are forked from a
>>>>>>>  cookie-0 task with their own cookie. Later on, such tasks can be added to
>>>>>>>  a group. This cover's PeterZ's ask about having 'default untrusted').
>>>>>>>  (Users like ChromeOS that don't want to userspace system processes to be
>>>>>>>  tagged can disable this option so such tasks will be cookie-0).
>>>>>>>
>>>>>>> 4. Allow prctl/cgroup interfaces to create groups of tasks and override the
>>>>>>>  above behaviors.
>>>>>>
>>>>>> How does uperf in a cgroup work with ksoftirqd? Are you suggesting I set uperf's
>>>>>> cookie to be cookie-0 via prctl?
>>>>>
>>>>> Yes, but let me try to understand better. There are 2 problems here I think:
>>>>>
>>>>> 1. ksoftirqd getting idled when HT is turned on, because uperf is sharing a
>>>>> core with it: This should not be any worse than SMT OFF, because even SMT OFF
>>>>> would also reduce ksoftirqd's CPU time just core sched is doing. Sure
>>>>> core-scheduling adds some overhead with IPIs but such a huge drop of perf is
>>>>> strange. Peter any thoughts on that?
>>>>>
>>>>> 2. Interface: To solve the performance problem, you are saying you want uperf
>>>>> to share a core with ksoftirqd so that it is not forced into idle.  Why not
>>>>> just keep uperf out of the cgroup?
>>>>
>>>> I guess this is unacceptable for who runs their apps in container and vm.
>>> IMHO,  just as Joel proposed, 
>>> 1. Consider all cookie-0 task as trusted.
>>> 2. All kernel threads and idle task would have a cookie 0 
>>> In that way, all tasks with cookies(including uperf in a cgroup) could run
>>> concurrently with kernel threads.
>>> That could be a good solution for the issue. :)
>>
>> From uperf point of review, it can trust cookie-0(I assume we still need
>> some modifications to change cookie-match to cookie-compatible to allow
>> ZERO and NONZERO run together).
>>
>> But from kernel thread point of review, it can NOT trust uperf, unless
>> we set uperf's cookie to 0.
> That’s right. :)
> Could we set the cookie of cgroup where uperf lies to 0?
> 
IMHO the disadvantage is that if there are two or more cgroups set cookie-0,
then the user applications in these cgroups could run concurrently on a core,
though all of them are set as trusted, we made a hole of user->user isolation.

Thanks,
-Aubrey
