Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D780CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B805B20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B4flp3AA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgIAVXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 17:23:08 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58922 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgIAVXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 17:23:05 -0400
Received: from [192.168.86.179] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5811920B7178;
        Tue,  1 Sep 2020 14:23:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5811920B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598995384;
        bh=bfod/v4nxldCj94ohUjF0UmmgVqCCbvNmHAj/EpXSfA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B4flp3AALHfXNLtSloy6pREXwzksnj/UfT/YkVBk5kUOEDH+Cm7Y38rODVhvJiYQT
         APZykkN44pi6le3KqW9vEt8Kd1XF+6QZZGDEyfgD+9iJ/CwsAy3+R8ajCVeIdet7L6
         ADNwuTDIBbaCWOQN460jtlO//QTb57BAMDMLyvdI=
Subject: Re: [RFC PATCH v7 08/23] sched: Add core wide task selection and
 scheduling.
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     peterz@infradead.org,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Aaron Lu <aaron.lu@linux.alibaba.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
 <20200828205154.GB29142@worktop.programming.kicks-ass.net>
 <381e6ea5-a48c-9882-4c0d-49cfa92d21cc@linux.microsoft.com>
 <20200829074719.GJ1362448@hirez.programming.kicks-ass.net>
 <20200901051014.GA3993517@google.com>
 <a41dac6f-6864-c215-0f7a-90f2126673a6@linux.microsoft.com>
 <20200901173052.GA1703315@google.com>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <9e165d5e-1c73-4078-f9fc-5df4f655fc28@linux.microsoft.com>
Date:   Tue, 1 Sep 2020 17:23:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901173052.GA1703315@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 9/1/20 1:30 PM, Joel Fernandes wrote:
>> I think we can come here when hotplug thread is scheduled during online, but
>> mask is not yet updated. Probably can add it with this comment as well.
>>
> I don't see how that is possible. Because the cpuhp threads run during the
> CPU onlining process, the boot thread for the CPU coming online would have
> already updated the mask.
Sorry my mistake. I got confused with the online state ordering.

>> Another unrelated, but related note :-)
>> Besides this, I think we need to retain on more change from the previous
>> patch. We would need to make core_pick_seq per sibling instead of per
>> core. Having it per core might lead to unfairness. For eg: When a cpu
>> sees that its sibling's core_pick is the one which is already running, it
>> will not send IPI. but core_pick remains set and core->core_pick_seq is
>> incremented. Now if the sibling is preempted due to a high priority task
> Then don't keep the core_pick set then. If you don't send it IPI and if
> core_pick is already running, then NULL it already. I don't know why we add
> to more corner cases by making assumptions. We have enough open issues that
> are not hotplug related. Here's my suggestion :
>
> 1.  Keep the ideas consistent, forget about the exact code currently written
> and just understand the pick_seq is for siblings knowing that something was
> picked for the whole core.  So if their pick_seq != sched_seq, then they have
> to pick what was selected.
I was trying to keep the ideas consistent. The requirement of core_pick
was to let the scheduled cpu know that a pick has been made. And
initial idea was to have the counter core wide. But I found this gap
that pick is not always core wide and assuming it to be core wide can
cause fairness issues. So I was proposing the idea of changing it from
core wide to per sibling. In other words, I was trying to make sure 
core_pick,
along with task_seq and sched_seq is trying to serve its purpose of letting
a sibling know that a new task pick has been made for it. I cannot think of
a reason, why core_pick should be core wide. I might be missing something.

> 2. If core_pick should be NULL, then NULL it in some path. If you keep some
> core_pick and you increment pick_seq, then you are automatically asking the
> sibling to pick that task up then next time it enters schedule(). See if [1]
> will work?
>
> Note that, we have added logic in this patch that does a full selection if
> rq->core_pick == NULL.

I agree, setting rq->core_pick = NULL is another way to solve this 
issue, but
still I feel its semantically incorrect to think that a pick is core 
wide when it
could actually be to only a subset of siblings in the core. If there is 
a valid
reasoning for having core_pick to be core wide, I completely agree with the
fix of resetting core_pick.

>> or its time slice expired, it enters schedule. But it goes to fast path and
>> selects the running task there by starving the high priority task. Having
>> the core_pick_seq per sibling will avoid this. It might also help in some
>> hotplug corner cases as well.
> That can be a separate patch IMHO. It has nothing to do with
> stability/crashing of concurrent and rather infrequent CPU hotplug
> operations.
Agree. Sorry for the confusion, my intention was to not have the logic in
this patch.

> Also, Peter said pick_seq is for core-wide picking. If you want to add
> another semantic, then maybe add another counter which has a separate
> meaning and justify why you are adding it.
I think just one counter is enough. Unless, there is a need to keep the 
counter
to track core wide pick, I feel it is worth to change the design and 
make the
counter serve its purpose. Will think through this and send it as a separate
patch if needed.

Thanks,
Vineeth

