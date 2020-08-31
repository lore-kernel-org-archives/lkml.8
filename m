Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22935C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE905206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cJmyMcYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHaNCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:02:03 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34280 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgHaNBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:01:25 -0400
Received: from [192.168.86.25] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id B0E8420B7178;
        Mon, 31 Aug 2020 06:01:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0E8420B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598878876;
        bh=82LtjhN5/d8zA/bah1Xd5Gq7LKso+a4Fr6DKdpp4Jsw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cJmyMcYNOIWM34hQRWPbwulPTrLB0paD5yqtCotmQCIxb4Qt9ukLG+Of4MDjVgEhI
         kwKF7S4a7aHdXMvbhanZ48b2bhGp/2ySRDSordHsbKfGsHun2M505JD0Pbql2ZO3YN
         /5kogbJNw9UzrDjva9OxfySDTz1vM/hr6ip2sej0=
Subject: Re: [RFC PATCH v7 08/23] sched: Add core wide task selection and
 scheduling.
To:     peterz@infradead.org
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Joel Fernandes <joelaf@google.com>,
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
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
 <20200828205154.GB29142@worktop.programming.kicks-ass.net>
 <381e6ea5-a48c-9882-4c0d-49cfa92d21cc@linux.microsoft.com>
 <20200829074719.GJ1362448@hirez.programming.kicks-ass.net>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <c251dcde-6c01-65a7-5745-c16a10d5fe1f@linux.microsoft.com>
Date:   Mon, 31 Aug 2020 09:01:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200829074719.GJ1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/20 3:47 AM, peterz@infradead.org wrote:
>> During hotplug stress test, we have noticed that while a sibling is in
>> pick_next_task, another sibling can go offline or come online. What
>> we have observed is smt_mask get updated underneath us even if
>> we hold the lock. From reading the code, looks like we don't hold the
>> rq lock when the mask is updated. This extra logic was to take care of that.
> Sure, the mask is updated async, but _where_ is the actual problem with
> that?
One issue that we observed was with the inconsistent view of smt_mask
in the three loops in pick_next_task can lead to corner cases. The first 
loop
resets all coresched fields, second loop picks the task for each 
siblings and
then if the sibling came online in the third loop, we IPI it and it 
crashes for a
NULL core_pick. Similarly I think we might have issues if the sibling goes
offline in the last loop or sibling is offline/online in the pick loop.

It might be possible to do specific checks for core_pick in the loops to 
fix the
corner cases above. But I was not sure if there were more and hence took 
this
approach. I understand that cpumask_weight is expensive and will try to 
fix it
using core_pick to fix the corner cases.

>
> On Fri, Aug 28, 2020 at 06:23:55PM -0400, Joel Fernandes wrote:
>> Thanks Vineeth. Peter, also the "v6+" series (which were some addons on v6)
>> detail the individual hotplug changes squashed into this patch:
>> https://lore.kernel.org/lkml/20200815031908.1015049-9-joel@joelfernandes.org/
>> https://lore.kernel.org/lkml/20200815031908.1015049-11-joel@joelfernandes.org/
> That one looks fishy, the pick is core wide, making that pick_seq per rq
> just doesn't make sense.
I think there are couple of scenarios where pick_seq per sibling will be
useful. One is this hotplug case, where you need to pick only for the online
siblings and the offline siblings can come online async. Second case that
we have seen is, we don't need to mark pick for siblings when we pick a task
which is currently running. Marking the pick core wide will make the sibling
take the fast path and re-select the same task during a schedule event
due to preemption or its time slice expiry.

>> https://lore.kernel.org/lkml/20200815031908.1015049-12-joel@joelfernandes.org/
> This one reads like tinkering, there is no description of the actual
> problem just some code that makes a symptom go away.
>
> Sure, on hotplug the smt mask can change, but only for a CPU that isn't
> actually scheduling, so who cares.
>
> /me re-reads the hotplug code...
>
> ..ooOO is the problem that we clear the cpumasks on take_cpu_down()
> instead of play_dead() ?! That should be fixable.
Yes, we get called into schedule(for going idle) for an offline cpu and 
it gets
confused. Also I think there could be problems while it comes online as 
well,
like I mentioned above. We might IPI a sibling which just came online 
with a
NULL core_pick. But I think we can fix it with specific checks for 
core_pick.

I shall look into the smt mask update side of the hotplug again and see
if corner cases could be better handled there.

Thanks,
Vineeth

