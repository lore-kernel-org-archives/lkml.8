Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090CDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCBB207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mj10Dg9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgE1Gc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:32:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44672 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725308AbgE1Gc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590647546;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EsuvlfT5LaD0+QJMlQUnPkzKGgI/J37TooIeB6KE0lA=;
        b=Mj10Dg9pQgJSBs4NA27d6TjRB5m7FjFOcOFGW8E1p2UJI9s3et2jJh6XYEDWVcRNrR1h1M
        4f6Me5vxygNOiovXiytVwezIm4md33NOsQIVdRANOi483ub3TeefsrNQrzqr2nSYqx3vrq
        B1sN6bYDQj/GWqdOBzGLGDcGLhqC1zI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-hi3646I5O5GPZp5FhiiXgw-1; Thu, 28 May 2020 02:32:21 -0400
X-MC-Unique: hi3646I5O5GPZp5FhiiXgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 508CB80183C;
        Thu, 28 May 2020 06:32:20 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-130.bne.redhat.com [10.64.54.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0639D1A914;
        Thu, 28 May 2020 06:32:12 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH RFCv2 7/9] kvm/arm64: Support async page fault
To:     Marc Zyngier <maz@kernel.org>, pbonzini@redhat.com
Cc:     Mark Rutland <mark.rutland@arm.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, drjones@redhat.com, eric.auger@redhat.com,
        aarcange@redhat.com, shan.gavin@gmail.com
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-8-gshan@redhat.com>
 <20200526123424.GF1363@C02TD0UTHF1T.local>
 <e1230110-b51f-b8b8-60d9-372660c5c387@redhat.com>
 <28c74819f42306e66370ddaf88f16918@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <924ee966-7412-f9ff-c2b0-598e4abbb05c@redhat.com>
Date:   Thu, 28 May 2020 16:32:09 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <28c74819f42306e66370ddaf88f16918@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 5/27/20 5:37 PM, Marc Zyngier wrote:
> On 2020-05-27 05:05, Gavin Shan wrote:

[...]
  
>>>> +struct kvm_vcpu_pv_apf_data {
>>>> +    __u32    reason;
>>>> +    __u8    pad[60];
>>>> +    __u32    enabled;
>>>> +};
>>>
>>> What's all the padding for?
>>>
>>
>> The padding is ensure the @reason and @enabled in different cache
>> line. @reason is shared by host/guest, while @enabled is almostly
>> owned by guest.
> 
> So you are assuming that a cache line is at most 64 bytes.
> It is actualy implementation defined, and you can probe for it
> by looking at the CTR_EL0 register. There are implementations
> ranging from 32 to 256 bytes in the wild, and let's not mention
> broken big-little implementations here.
> 
> [...]
> 

Ok, Thanks for your comments and hints.

>>>> +bool kvm_arch_can_inject_async_page_not_present(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +    u64 vbar, pc;
>>>> +    u32 val;
>>>> +    int ret;
>>>> +
>>>> +    if (!(vcpu->arch.apf.control_block & KVM_ASYNC_PF_ENABLED))
>>>> +        return false;
>>>> +
>>>> +    if (vcpu->arch.apf.send_user_only && vcpu_mode_priv(vcpu))
>>>> +        return false;
>>>> +
>>>> +    /* Pending page fault, which ins't acknowledged by guest */
>>>> +    ret = kvm_async_pf_read_cache(vcpu, &val);
>>>> +    if (ret || val)
>>>> +        return false;
>>>> +
>>>> +    /*
>>>> +     * Events can't be injected through data abort because it's
>>>> +     * going to clobber ELR_EL1, which might not consued (or saved)
>>>> +     * by guest yet.
>>>> +     */
>>>> +    vbar = vcpu_read_sys_reg(vcpu, VBAR_EL1);
>>>> +    pc = *vcpu_pc(vcpu);
>>>> +    if (pc >= vbar && pc < (vbar + vcpu->arch.apf.no_fault_inst_range))
>>>> +        return false;
>>>
>>> Ah, so that's when this `no_fault_inst_range` is for.
>>>
>>> As-is this is not sufficient, and we'll need t be extremely careful
>>> here.
>>>
>>> The vectors themselves typically only have a small amount of stub code,
>>> and the bulk of the non-reentrant exception entry work happens
>>> elsewhere, in a mixture of assembly and C code that isn't even virtually
>>> contiguous with either the vectors or itself.
>>>
>>> It's possible in theory that code in modules (or perhaps in eBPF JIT'd
>>> code) that isn't safe to take a fault from, so even having a contiguous
>>> range controlled by the kernel isn't ideal.
>>>
>>> How does this work on x86?
>>>
>>
>> Yeah, here we just provide a mechanism to forbid injecting data abort. The
>> range is fed by guest through HVC call. So I think it's guest related issue.
>> You had more comments about this in PATCH[9]. I will explain a bit more there.
>>
>> x86 basically relies on EFLAGS[IF] flag. The async page fault can be injected
>> if it's on. Otherwise, it's forbidden. It's workable because exception is
>> special interrupt to x86 if I'm correct.
>>
>>            return (vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF) &&
>>                   !(vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
>>                         (GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS));
> 
> I really wish this was relying on an architected exception delivery
> mechanism that can be blocked by the guest itself (PSTATE.{I,F,A}).
> Trying to guess based on the PC won't fly. But these signals are
> pretty hard to multiplex with anything else. Like any form of
> non-architected exception injection, I don't see a good path forward
> unless we start considering something like SDEI.
> 
>          M.

As Paolo mentioned in another reply. There are two types of notifications
sent from host to guest: page_not_present and page_ready. The page_not_present
notification should be delivered synchronously while page_ready can be
delivered asynchronously. He also suggested to reserve a ESR (or DFSC) subclass
for page_not_present. For page_ready, it can be delivered by interrupt, like PPI.
x86 is changing the code to deliver page_ready by interrupt, which was done by
exception previously.

when we use interrupt, instead of exception for page_ready. We won't need the
game of guessing PC.

I assume you prefer to use SDEI for page_not_present, correct? In that case,
what's the current status of SDEI? I mean it has been fully or partially
supported, or we need develop it from the scratch :)

Thanks,
Gavin

