Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78048C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE2E207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eluZa4rQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgH1WCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:02:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37460 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1WCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:02:31 -0400
Received: from [192.168.86.25] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id BE0D620B7178;
        Fri, 28 Aug 2020 15:02:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE0D620B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598652150;
        bh=fmlfphrxEaz88Wtdy10ngwd/RmkK3CCZVGqn+1wcomY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eluZa4rQNXRPAinYoz92+bB+lT0D03HFoaTF7WV8XC8xYinaFvM7ncgYefHKjBWqt
         WXo+v+F6RnH5K/f2EZxtvPPbrxMfdWbluGXsCb4D1F/ddIqSkiwOeU2ZTeJIecIa8J
         0M7qVPaFwWYOnnhrplMfbR0lU20RPP+moJFu6K1A=
Subject: Re: [RFC PATCH v7 08/23] sched: Add core wide task selection and
 scheduling.
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
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
 <20200828205154.GB29142@worktop.programming.kicks-ass.net>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <381e6ea5-a48c-9882-4c0d-49cfa92d21cc@linux.microsoft.com>
Date:   Fri, 28 Aug 2020 18:02:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828205154.GB29142@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/20 4:51 PM, Peter Zijlstra wrote:
> cpumask_weigt() is fairly expensive, esp. for something that should
> 'never' happen.
>
> What exactly is the race here?
>
> We'll update the cpu_smt_mask() fairly early in secondary bringup, but
> where does it become a problem?
>
> The moment the new thread starts scheduling it'll block on the common
> rq->lock and then it'll cycle task_seq and do a new pick.
>
> So where do things go side-ways?
During hotplug stress test, we have noticed that while a sibling is in
pick_next_task, another sibling can go offline or come online. What
we have observed is smt_mask get updated underneath us even if
we hold the lock. From reading the code, looks like we don't hold the
rq lock when the mask is updated. This extra logic was to take care of that.

> Can we please split out this hotplug 'fix' into a separate patch with a
> coherent changelog.
Sorry about this. I had posted this as separate patches in v6 list,
but merged it for v7. Will split it and have details about the fix in
next iteration.

Thanks,
Vineeth
