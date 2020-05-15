Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D57BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F9A2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589557031;
	bh=XmfYacoWpckw7SIZkW14MRGHswo6szBUF/OdRKOWU6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=e2vrkApF+WqYHrx9KDo5r8L/IU4Ql3QuN1it95KVhJiM9qQc3sO9oDR6zwEOIhGps
	 UDeeWBIQlc1ZZsz5ex33v5Io5qDutzXXpialXJQry3k/MZo9HNzAsry6CVXmVm89N2
	 js8YVnG/m9fTlruW2vWcsQ5uqEKgy8arrKyzXoR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgEOPhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgEOPhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:37:10 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05DF120758;
        Fri, 15 May 2020 15:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589557029;
        bh=XmfYacoWpckw7SIZkW14MRGHswo6szBUF/OdRKOWU6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oFKwC/DgLyczCZ6gBJvC7+1EHKf1XMn4dlmjjklunbn8bc46Chk7nHpj1LTRqGtEm
         OZLl5u9+isnWLT/Zj0SACT6AFT3sLEPzXW2IQaDdIcYlFPdL9xSpnVfh7GAuAHK9F+
         +oAYckwkn2XVbhPEIZviec2wYQNvcafFJW7MXfoA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jZcOZ-00CcMH-DG; Fri, 15 May 2020 16:37:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 15 May 2020 16:37:07 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        Robin Murphy <robin.murphy@arm.com>,
        luojiaxing <luojiaxing@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 0/2] irqchip/gic-v3-its: Balance LPI affinity across
 CPUs
In-Reply-To: <a22aaa72-4f5f-40d4-33e0-0aff8b65fdc2@huawei.com>
References: <20200316115433.9017-1-maz@kernel.org>
 <9171c554-50d2-142b-96ae-1357952fce52@huawei.com>
 <80b673a7-1097-c5fa-82c0-1056baa5309d@huawei.com>
 <f2971d1c-50f8-bf5a-8b16-8d84a631b0ba@huawei.com>
 <7c05b08b-2edc-7f97-0175-898e9772673e@huawei.com>
 <668f819c8747104814245cd6faebdd9a@kernel.org>
 <a22aaa72-4f5f-40d4-33e0-0aff8b65fdc2@huawei.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <c37d8b15f09c6c933e39b81f39fcb827@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.garry@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jason@lakedaemon.net, chenxiang66@hisilicon.com, robin.murphy@arm.com, luojiaxing@huawei.com, ming.lei@redhat.com, wangzhou1@hisilicon.com, tglx@linutronix.de, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-15 12:50, John Garry wrote:
> Hi Marc,
> 
>> Absolutely. Life has got in the way, so let me page it back in...
> 
> Great
> 
>>> 
>>> [PATCH 2/2] irqchip/gic-v3-its: Handle no overlap of non-managed irq
>>>   affinity mask
>>> 
>>> In selecting the target CPU for a non-managed interrupt, we may 
>>> select
>>> a
>>> target CPU outside the requested affinity mask.
>>> 
>>> This is because there may be no overlap of the ITS node mask and the
>>> requested CPU affinity mask. The requested affinity mask may be 
>>> coming
>>> from userspace or some drivers which try to set irq affinity, see 
>>> [0].
>>> 
>>> In this case, just ignore the ITS node cpumask. This is a deviation
>>> from
>>> what Thomas described. Having said that, I am not sure if the
>>> interrupt is ever bound to a node for us.
>>> 
>>> [0]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/hisilicon/hisi_uncore_pmu.c#n417
>>> 
>>> ---
>>>   drivers/irqchip/irq-gic-v3-its.c | 4 ----
>>>   1 file changed, 4 deletions(-)
>>> 
>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c
>>> b/drivers/irqchip/irq-gic-v3-its.c
>>> index 2b18feb..12d5d4b4 100644
>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>> @@ -1584,10 +1584,6 @@ static int its_select_cpu(struct irq_data *d,
>>>   			cpumask_and(tmpmask, cpumask_of_node(node), aff_mask);
>>>   			cpumask_and(tmpmask, tmpmask, cpu_online_mask);
>>> 
>>> -			/* If that doesn't work, try the nodemask itself */
>>> -			if (cpumask_empty(tmpmask))
>>> -				cpumask_and(tmpmask, cpumask_of_node(node), cpu_online_mask);
>>> -
>>>   			cpu = cpumask_pick_least_loaded(d, tmpmask);
>>>   			if (cpu < nr_cpu_ids)
>>>   				goto out;
>> 
>> I'm really not sure. Shouldn't we then drop the wider search on
>> cpu_inline_mask, because userspace could have given us something
>> that we cannot deal with?
> 
> It's not just userspace. Some drivers call irq_set_affinity{_hint}}()
> also, with a non-overlapping affinity mask.
> 
> We could just error these requests, but some drivers rely on this
> behavior. Consider the uncore driver I mentioned above, which WARNs
> when the affinity setting fails. So it tries to set the affinity with
> the cpumask of the cluster associated with the device, but with D06's
> ITS config, below, there may be no overlap.

Does this PMU use the ITS? That's a pretty odd setup.

So this is a case where the device has an implicit affinity that
isn't that of the ITS. Huhu...

>> 
>> What you are advocating for is a strict adherence to the provided
>> mask, and it doesn't seem to be what other architectures are 
>> providing.
>> I consider the userspace-provided affinity as a hint more that 
>> anything
>> else, as in this case the kernel does know better (routing the 
>> interrupt
>> to a foreign node might be costly, or even impossible, see the TX1
>> erratum).
> 
> Right
> 
>> 
>>   From what I remember of the earlier discussion, you saw an issue on
>> a system with two sockets and a single ITS, with the node mask limited
>> to the first socket. Is that correct?
> 
> A bit more complicated: 2 sockets, 2 NUMA nodes per socket, and ITS
> config as follows:
> D06ES  1x ITS with proximity node #0
> 
> root@(none)$ dmesg | grep ITS
> [ 0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
> 
> 
> D06CS
> 2x ITS with proximity node #0, #2
> 
> estuary:/$ dmesg | grep ITS
> [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
> [    0.000000] SRAT: PXM 2 -> ITS 1 -> Node 2
> 
> It complicates things.
> 
> We could add extra intelligence to record if an node has an ITS
> associated. In the case of that not being true, we would fallback on
> the requested affin only (for case of no overlap). It gets a bit more
> messy then.

It looks like part of the problem is that we can't reliably describe
an ITS affine to multiple NUMA nodes... If we could describe that, then
the above situation wouldn't occur (we'd say that ITS-0 covers both
nodes 0 and 1). But I can't find a way to express this with SRAT and
_PXM. Also, SRAT describes the affinity of the ITS with memory, and not
with the CPUs... It is all a bit fsck'd. :-(

I guess I'll apply your change for now with a comment explaining the
situation.

         M.
-- 
Jazz is not dead. It just smells funny...
