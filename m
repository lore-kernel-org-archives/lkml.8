Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97DDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956E92082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390588AbgFXLQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:16:40 -0400
Received: from foss.arm.com ([217.140.110.172]:35780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388706AbgFXLQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:16:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4544A1F1;
        Wed, 24 Jun 2020 04:16:37 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D43C3F6CF;
        Wed, 24 Jun 2020 04:16:34 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] MTE support for KVM guest
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Maydell <Peter.Maydell@linaro.org>
References: <20200617123844.29960-1-steven.price@arm.com>
 <20200623174807.GD5180@gaia>
From:   Steven Price <steven.price@arm.com>
Message-ID: <e04696b6-63de-1e25-f6f3-1da63f791754@arm.com>
Date:   Wed, 24 Jun 2020 12:16:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623174807.GD5180@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2020 18:48, Catalin Marinas wrote:
> Hi Steven,
> 
> On Wed, Jun 17, 2020 at 01:38:42PM +0100, Steven Price wrote:
>> These patches add support to KVM to enable MTE within a guest. It is
>> based on Catalin's v4 MTE user space series[1].
>>
>> [1] http://lkml.kernel.org/r/20200515171612.1020-1-catalin.marinas%40arm.com
>>
>> Posting as an RFC as I'd like feedback on the approach taken. First a
>> little background on how MTE fits within the architecture:
>>
>> The stage 2 page tables have limited scope for controlling the
>> availability of MTE. If a page is mapped as Normal and cached in stage 2
>> then it's the stage 1 tables that get to choose whether the memory is
>> tagged or not. So the only way of forbidding tags on a page from the
>> hypervisor is to change the cacheability (or make it device memory)
>> which would cause other problems.  Note this restriction fits the
>> intention that a system should have all (general purpose) memory
>> supporting tags if it support MTE, so it's not too surprising.
>>
>> However, the upshot of this is that to enable MTE within a guest all
>> pages of memory mapped into the guest as normal cached pages in stage 2
>> *must* support MTE (i.e. we must ensure the tags are appropriately
>> sanitised and save/restore the tags during swap etc).
>>
>> My current approach is that KVM transparently upgrades any pages
>> provided by the VMM to be tag-enabled when they are faulted in (i.e.
>> sets the PG_mte_tagged flag on the page) which has the benefit of
>> requiring fewer changes in the VMM. However, save/restore of the VM
>> state still requires the VMM to have a PROT_MTE enabled mapping so that
>> it can access the tag values. A VMM which 'forgets' to enable PROT_MTE
>> would lose the tag values when saving/restoring (tags are RAZ/WI when
>> PROT_MTE isn't set).
>>
>> An alternative approach would be to enforce the VMM provides PROT_MTE
>> memory in the first place. This seems appealing to prevent the above
>> potentially unexpected gotchas with save/restore, however this would
>> also extend to memory that you might not expect to have PROT_MTE (e.g. a
>> shared frame buffer for an emulated graphics card).
> 
> As you mentioned above, if memory is mapped as Normal Cacheable at Stage
> 2 (whether we use FWB or not), the guest is allowed to turn MTE on via
> Stage 1. There is no way for KVM to prevent a guest from using MTE other
> than the big HCR_EL2.ATA knob.
> 
> This causes potential issues since we can't guarantee that all the
> Cacheable memory slots allocated by the VMM support MTE. If they do not,
> the arch behaviour is "unpredictable". We also can't trust the guest to
> not enable MTE on such Cacheable mappings.

Architecturally it seems dodgy to export any address that isn't "normal 
memory" (i.e. with tag storage) to the guest as Normal Cacheable. 
Although I'm a bit worried this might cause a regression in some 
existing case.

> On the host kernel, mmap'ing with PROT_MTE is only allowed for anonymous
> mappings and shmem. So requiring the VMM to always pass PROT_MTE mapped
> ranges to KVM, irrespective of whether it's guest RAM, emulated device,
> virtio etc. (as long as they are Cacheable), filters unsafe ranges that
> may be mapped into guest.

That would be an easy way of doing the filtering, but it's not clear 
whether PROT_MTE is actually what the VMM wants (it most likely doesn't 
want to have tag checking enabled on the memory in user space).

> Note that in the next revision of the MTE patches I'll drop the DT
> memory nodes checking and rely only on the CPUID information (arch
> updated promised by the architects).
> 
> I see two possible ways to handle this (there may be more):
> 
> 1. As in your current patches, assume any Cacheable at Stage 2 can have
>     MTE enabled at Stage 1. In addition, we need to check whether the
>     physical memory supports MTE and it could be something simple like
>     pfn_valid(). Is there a way to reject a memory slot passed by the
>     VMM?

Yes pfn_valid() should have been in there. At the moment pfn_to_page() 
is called without any checks.

The problem with attempting to reject a memory slot is that the memory 
backing that slot can change. So checking at the time the slot is 
created isn't enough (although it might be a useful error checking feature).

It's not clear to me what we can do at fault time when we discover the 
memory isn't tag-capable and would have been mapped cacheable other than 
kill the VM.

> 2. Similar to 1 but instead of checking whether the pfn supports MTE, we
>     require the VMM to only pass PROT_MTE ranges (filtering already done
>     by the host kernel). We need a way to reject the slot and return an
>     error to the VMM.
> 
> I think rejecting a slot at the Stage 2 fault time is very late. You
> probably won't be able to do much other than killing the guest.

As above, we will struggle to catch all cases during slot creation, so I 
think we're going to have to deal with this late detection as well.

> Both 1 and 2 above risk breaking existing VMMs just because they happen
> to start on an MTE-capable machine. So, can we also require the VMM to
> explicitly opt in to MTE support in guests via some ioctl()? This in
> turn would enable the additional checks in KVM for the MTE capability of
> the memory slots (1 or 2 above).

Patch 2 introduces a VCPU feature which must be explicitly enabled for 
the guest to have MTE. So it won't break existing VMMs. However clearly 
simply setting that bit will likely break some configurations where not 
all memory is MTE capable.

> An alternative to an MTE enable ioctl(), if all the memory slots are set
> up prior to the VM starting, KVM could check 1 or 2 above and decide
> whether to expose MTE to guests (HCR_EL2.ATA).

The VMM needs to be fully aware of MTE before it's enabled by KVM 
otherwise it could lose the tags (e.g. during migration). So my 
preference is to make it an explicit opt-in.

> More questions than solutions above, mostly for the KVM and Qemu
> maintainers.

Indeed it would be useful to have input from those familiar with VMMs as 
to what a good interface looks like.

Thanks,

Steve
