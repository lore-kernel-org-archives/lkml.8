Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7FAC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 23:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AA520838
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 23:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Nq40Lobf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgH1XYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 19:24:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47314 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgH1XYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 19:24:10 -0400
Received: from [192.168.86.25] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id 05F5B20B7178;
        Fri, 28 Aug 2020 16:24:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 05F5B20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598657049;
        bh=crigY9FE2ofzeOz1tW9734Eg4pnIs9fDIQhsBgLWpfU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Nq40LobfRBxb0t44XlhFBy64g16a9hMN38/b5O8vS4jKkFSqmu0ljTJXWxLaROGON
         E3FgdwtETIe7dwAe9k3KHrMXifJBbeTKjyR7SWFC8EEodtY+xGYsEaVujP7Zoi5xjY
         n9PQ5brb98/+rvfhxb/ugQFBYOTBfUGEiHz5cdwI=
Subject: Re: [RFC PATCH v7 09/23] sched/fair: Fix forced idle sibling
 starvation corner case
To:     Peter Zijlstra <peterz@infradead.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Joel Fernandes <joelaf@google.com>,
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
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <7d50f038cef452c78213b7c513a98b3286476701.1598643276.git.jdesfossez@digitalocean.com>
 <20200828212554.GD29142@worktop.programming.kicks-ass.net>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <ea484c79-8606-4817-909c-fe4fd5e085d6@linux.microsoft.com>
Date:   Fri, 28 Aug 2020 19:24:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828212554.GD29142@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/20 5:25 PM, Peter Zijlstra wrote:
> The only pupose of this loop seem to be to find if we have a forceidle;
> surely we can avoid that by storing this during the pick.
The idea was to kick each cpu that was force idle. But now, thinking
about it, we just need to kick one as it will pick for all the siblings.
Will optimize this as you suggested.

>
> static void task_tick_core(struct rq *rq)
> {
> 	if (sched_core_enabled(rq))
> 		resched_forceidle_sibling(rq, &rq->curr->se);
> }
>
> #else
>
> static void task_tick_core(struct rq *rq) { }
>
>> +#endif
>> +
>>   /*
>>    * scheduler tick hitting a task of our scheduling class.
>>    *
>> @@ -10654,6 +10688,11 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>>   
>>   	update_misfit_status(curr, rq);
>>   	update_overutilized_status(task_rq(curr));
>> +
>> +#ifdef CONFIG_SCHED_CORE
>> +	if (sched_core_enabled(rq))
>> +		resched_forceidle_sibling(rq, &curr->se);
>> +#endif
> Then you can ditch the #ifdef here
Makes sense, will do.

Thanks,
Vineeth

