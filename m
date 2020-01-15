Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F08C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418172084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579095152;
	bh=LBZuicrn/IEkOok7VeiPR4swe2oChXBB6C4r6cUoGRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KI4XQ2wr2rhQf0NqqYJBIi9CUwlIwlqCHGdBtGGfjU8YkfO+sXHYkRfY8sm7xUqZ6
	 AYfkr3msMYWPSsjkaBPo/SIDgZUhtgUFKDI3G1yN+MpNHNy1dJIpNzEClGwHObV7yS
	 Tpb0aG5dN5X0ZNpxmWu9Ck9cM+vS34QzW1grBH88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgAONcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:32:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:41194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729340AbgAONc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:32:28 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8662187F;
        Wed, 15 Jan 2020 13:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579095147;
        bh=LBZuicrn/IEkOok7VeiPR4swe2oChXBB6C4r6cUoGRA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O/hsVzSWBJjzjSiGpoAyGFB7AiG+palU0ZwEhonoG35ekYOpNbQX/1TZ5KXos9mrV
         eN1/EuF6rqVn+GDOzBrYD1VJUG980V9dzEylrJAd+0VIaXHqqSL0CEBLRVn1pdQ1WS
         6j2CTCNiEuMlNv6mOuUXd6HwAqyB2dgyIantp0yo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1irimX-0008K4-Nd; Wed, 15 Jan 2020 13:32:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 15 Jan 2020 13:32:25 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "Tangnianyao (ICT)" <tangnianyao@huawei.com>
Subject: Re: [PATCH v3 29/32] KVM: arm64: GICv4.1: Allow SGIs to switch
 between HW and SW interrupts
In-Reply-To: <6e24d53e-64d9-a682-6753-9e16155c7fde@huawei.com>
References: <20191224111055.11836-1-maz@kernel.org>
 <20191224111055.11836-30-maz@kernel.org>
 <cc5fe20c-7a0c-c266-e78a-2a85963ab20f@hisilicon.com>
 <6e24d53e-64d9-a682-6753-9e16155c7fde@huawei.com>
Message-ID: <c30b23cf220a4b2965a42ea87b27285f@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, zhangshaokun@hisilicon.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, rrichter@marvell.com, tangnianyao@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-15 03:49, Zenghui Yu wrote:
> Hi,
> 
> On 2020/1/15 10:49, Shaokun Zhang wrote:
>> Hi Marc, [This is from Nianyao]
>> 
>> On 2019/12/24 19:10, Marc Zyngier wrote:
>>> In order to let a guest buy in the new, active-less SGIs, we
>>> need to be able to switch between the two modes.
>>> 
>>> Handle this by stopping all guest activity, transfer the state
>>> from one mode to the other, and resume the guest.
>>> 
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> ---
> 
> [...]
> 
>>> diff --git a/virt/kvm/arm/vgic/vgic-v4.c 
>>> b/virt/kvm/arm/vgic/vgic-v4.c
>>> index c2fcde104ea2..063785fd2dc7 100644
>>> --- a/virt/kvm/arm/vgic/vgic-v4.c
>>> +++ b/virt/kvm/arm/vgic/vgic-v4.c
>>> @@ -97,6 +97,102 @@ static irqreturn_t vgic_v4_doorbell_handler(int 
>>> irq, void *info)
>>>   	return IRQ_HANDLED;
>>>   }
>>>   +static void vgic_v4_sync_sgi_config(struct its_vpe *vpe, struct 
>>> vgic_irq *irq)
>>> +{
>>> +	vpe->sgi_config[irq->intid].enabled	= irq->enabled;
>>> +	vpe->sgi_config[irq->intid].group 	= irq->group;
>>> +	vpe->sgi_config[irq->intid].priority	= irq->priority;
>>> +}
>>> +
>>> +static void vgic_v4_enable_vsgis(struct kvm_vcpu *vcpu)
>>> +{
>>> +	struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
>>> +	int i;
>>> +
>>> +	/*
>>> +	 * With GICv4.1, every virtual SGI can be directly injected. So
>>> +	 * let's pretend that they are HW interrupts, tied to a host
>>> +	 * IRQ. The SGI code will do its magic.
>>> +	 */
>>> +	for (i = 0; i < VGIC_NR_SGIS; i++) {
>>> +		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, i);
>>> +		struct irq_desc *desc;
>>> +		int ret;
>>> +
>>> +		if (irq->hw) {
>>> +			vgic_put_irq(vcpu->kvm, irq);
>>> +			continue;
>>> +		}
>>> +
>>> +		irq->hw = true;
>>> +		irq->host_irq = irq_find_mapping(vpe->sgi_domain, i);
>> 
>> I think we need to check whether irq_find_mapping returns 0.
>> 
>>> +		vgic_v4_sync_sgi_config(vpe, irq);
>>> +		/*
>>> +		 * SGIs are initialised as disabled. Enable them if
>>> +		 * required by the rest of the VGIC init code.
>>> +		 */
>>> +		desc = irq_to_desc(irq->host_irq);
>>> +		ret = irq_domain_activate_irq(irq_desc_get_irq_data(desc),
>>> +					      false);
>> 
>> If irq->host_irq is not valid , in irq_domain_activate_irq, it will 
>> trigger NULL pointer
>> dereference in host kernel.
>> I meet a problem here. When hw support GIC4.1, and host kernel is 
>> started with
>> kvm-arm.vgic_v4_enable=0, starting a virtual machine will trigger NULL 
>> pointer
>> dereference in host.
> 
> I think the thing is that we should _not_ try to configure vSGIs at all
> if kvm-arm.vgic_v4_enable=0 (which indicates we don't allow use of the
> GICv4 of direct injection).
> 
> We currently set kvm_vgic_global_state.has_gicv4_1 to true if HW 
> support
> GICv4.1, regardless whatever the gicv4_enable is (see patch#23 -
> vgic_v3_probe).  I think this is what actually needs fixing.

Yes, my point exactly. I've pushed out a potential fix [1], and I'd be
grateful if you could let me know whether that fixes it for you.

Thanks,

         M.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/gic-v4.1-devel&id=b82c2ee1d3fef66fb85793965c344260f618219d
-- 
Jazz is not dead. It just smells funny...
