Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193DFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E712E2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9utoaO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgE0CzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 22:55:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40621 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbgE0CzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590548120;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4K9Ld8nvFhhrcUkF46+uYVzHz+spBxIeBhQGnUCsLs=;
        b=A9utoaO4xJ1KlkScQ/p6asaAvyHOcr1eEy8yWJrqj0SlOFf2iGGYdiVk3mvjQIRZRuAy27
        rACSvKxFb+44EeQIXR3UTthEUV7KMTYegfZrFlaC0h8Zs9xSxwnOSPGxRk7QnObFmjailZ
        ZtsA4wNaDOqvYN5IvEctMxB5J99MMt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-vg8k3xqlP2uyYE5pKH1NJA-1; Tue, 26 May 2020 22:55:15 -0400
X-MC-Unique: vg8k3xqlP2uyYE5pKH1NJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B61EC10753FB;
        Wed, 27 May 2020 02:55:13 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-130.bne.redhat.com [10.64.54.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2852E5D9E7;
        Wed, 27 May 2020 02:55:06 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH RFCv2 4/9] kvm/arm64: Detach ESR operator from vCPU struct
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, drjones@redhat.com, eric.auger@redhat.com,
        aarcange@redhat.com, shan.gavin@gmail.com
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-5-gshan@redhat.com>
 <20200526105154.GD1363@C02TD0UTHF1T.local>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <4cda1e43-8f96-4e48-2642-39a5545905c0@redhat.com>
Date:   Wed, 27 May 2020 12:55:04 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200526105154.GD1363@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 5/26/20 8:51 PM, Mark Rutland wrote:
> On Fri, May 08, 2020 at 01:29:14PM +1000, Gavin Shan wrote:
>> There are a set of inline functions defined in kvm_emulate.h. Those
>> functions reads ESR from vCPU fault information struct and then operate
>> on it. So it's tied with vCPU fault information and vCPU struct. It
>> limits their usage scope.
>>
>> This detaches these functions from the vCPU struct. With this, the
>> caller has flexibility on where the ESR is read. It shouldn't cause
>> any functional changes.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/include/asm/kvm_emulate.h     | 83 +++++++++++-------------
>>   arch/arm64/kvm/handle_exit.c             | 20 ++++--
>>   arch/arm64/kvm/hyp/switch.c              | 24 ++++---
>>   arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c |  7 +-
>>   arch/arm64/kvm/inject_fault.c            |  4 +-
>>   arch/arm64/kvm/sys_regs.c                | 12 ++--
>>   virt/kvm/arm/arm.c                       |  4 +-
>>   virt/kvm/arm/hyp/aarch32.c               |  2 +-
>>   virt/kvm/arm/hyp/vgic-v3-sr.c            |  5 +-
>>   virt/kvm/arm/mmio.c                      | 27 ++++----
>>   virt/kvm/arm/mmu.c                       | 22 ++++---
>>   11 files changed, 112 insertions(+), 98 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
>> index bd1a69e7c104..2873bf6dc85e 100644
>> --- a/arch/arm64/include/asm/kvm_emulate.h
>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>> @@ -270,10 +270,8 @@ static __always_inline u32 kvm_vcpu_get_esr(const struct kvm_vcpu *vcpu)
>>   	return vcpu->arch.fault.esr_el2;
>>   }
>>   
>> -static __always_inline int kvm_vcpu_get_condition(const struct kvm_vcpu *vcpu)
>> +static __always_inline int kvm_vcpu_get_condition(u32 esr)
> 
> Given the `vcpu` argument has been removed, it's odd to keep `vcpu` in the
> name, rather than `esr`.
> 
> e.g. this would make more sense as something like esr_get_condition().
> 
> ... and if we did something like that, we could move most of the
> extraction functions into <asm/esr.h>, and share them with non-KVM code.
> 
> Otherwise, do you need to extract all of these for your use-case, or do
> you only need a few of the helpers? If you only need a few, it might be
> better to only factor those out for now, and keep the existing API in
> place with wrappers, e.g. have:
> 
> | esr_get_condition(u32 esr) {
> | 	...
> | }
> |
> | kvm_vcpu_get_condition(const struct kvm_vcpu *vcpu)
> | {
> | 	return esr_get_condition(kvm_vcpu_get_esr(vcpu));
> | }
> 

Sure, I'll follow approach#1, to move these helper functions to asm/esr.h
and with "vcpu" dropped in their names. I don't think it makes sense to
maintain two sets of helper functions for the simple logic. So the helper
function will be called where they should be, as below:

    esr_get_condition(u32 esr) { ... }
    
    bool __hyp_text kvm_condition_valid32(const struct kvm_vcpu *vcpu)
    {
         int cond = esr_get_condition(kvm_vcpu_get_esr(vcpu));
         :
    }

Thanks,
Gavin

