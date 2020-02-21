Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B08C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DB220722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgBUJaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:30:02 -0500
Received: from foss.arm.com ([217.140.110.172]:34970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgBUJaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:30:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ED4B31B;
        Fri, 21 Feb 2020 01:30:01 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88FCD3F68F;
        Fri, 21 Feb 2020 01:29:59 -0800 (PST)
Date:   Fri, 21 Feb 2020 09:29:57 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     chris hyser <chris.hyser@oracle.com>
Cc:     Parth Shah <parth@linux.ibm.com>, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        dhaval.giani@oracle.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, pavel@ucw.cz, qperret@qperret.net,
        David.Laight@ACULAB.COM, pjt@google.com, tj@kernel.org
Subject: Re: [PATCH v3 0/3] Introduce per-task latency_nice for scheduler
 hints
Message-ID: <20200221092956.jpsfps2dgmhiu5vg@e107158-lin.cambridge.arm.com>
References: <8ed0f40c-eeb4-c487-5420-a8eb185b5cdd@linux.ibm.com>
 <c7e5b9da-66a3-3d69-d7aa-0319de3aa736@oracle.com>
 <971909ed-d4e0-6afa-d20b-365ede5a195e@linux.ibm.com>
 <8e984496-e89b-d96c-d84e-2be7f0958ea4@oracle.com>
 <1e216d18-7ec0-4a0d-e124-b730d6e03e6f@oracle.com>
 <de5d8886-6f70-a3fa-8061-5877cd1d98f5@linux.ibm.com>
 <7429e0ae-41ff-e9c4-dd65-3ef1919f5f50@linux.ibm.com>
 <a332d633-7826-b85d-5d9f-5e34f9de084a@oracle.com>
 <20200220150343.dvweamfnk257pg7z@e107158-lin.cambridge.arm.com>
 <9bb1437b-3de0-b0ca-6319-6be903b0758d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9bb1437b-3de0-b0ca-6319-6be903b0758d@oracle.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/20 11:34, chris hyser wrote:
> > > Whether called a hint or not, it is a trade-off to reduce latency of select
> > > tasks at the expense of the throughput of the other tasks in the the system.
> > 
> > Does it actually affect the throughput of the other tasks? I thought this will
> > allow the scheduler to reduce latencies, for instance, when selecting which cpu
> > it should land on. I can't see how this could hurt other tasks.
> 
> This is why it is hard to argue about pure abstractions. The primary idea
> mentioned so far for how these latencies are reduced is by short cutting the
> brute-force search for something idle. If you don't find an idle cpu because
> you didn't spend the time to look, then you pre-empted a task, possibly with
> a large nice warm cache footprint that was cranking away on throughput. It
> is ultimately going to be the usual latency vs throughput trade off. If
> latency reduction were "free" we wouldn't need a per task attribute. We
> would just do the reduction for all tasks, everywhere, all the time.

This could still happen without the latency nice bias. I'm not sure if this
falls under DoS; maybe if you end up spawning a lot of task with high latency
nice value, then you might end up cramming a lot of tasks on a small subset of
CPUs. But then, shouldn't the logic that uses latency_nice try to handle this
case anyway since it could be legit?

Not sure if this can be used by someone to trigger timing based attacks on
another process.

I can't fully see the whole security implications, but regardless. I do agree
it is prudent to not allow tasks to set their own latency_nice. Mainly because
the meaning of this flag will be system dependent and I think Admins are the
better ones to decide how to use this flag for the system they're running on.
I don't think application writers should be able to tweak their tasks
latency_nice value. Not if they can't get the right privilege at least.

> 
> > 
> > Can you expand on the scenario you have in mind please?
> 
> Hopefully, the above helps. It was my original plan to introduce this with a
> data laden RFC on the topic, but I felt the need to respond to Parth
> immediately. I'm not currently pushing any particular change.

Thanks!

--
Qais Yousef
