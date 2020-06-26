Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EEAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E9720707
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgFZRYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:24:44 -0400
Received: from foss.arm.com ([217.140.110.172]:40306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFZRYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:24:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93FDB1FB;
        Fri, 26 Jun 2020 10:24:38 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F35653F71E;
        Fri, 26 Jun 2020 10:24:36 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] MTE support for KVM guest
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Maydell <Peter.Maydell@linaro.org>
References: <20200617123844.29960-1-steven.price@arm.com>
 <20200623174807.GD5180@gaia> <e04696b6-63de-1e25-f6f3-1da63f791754@arm.com>
 <20200624142131.GA27945@gaia> <66ed0732-17ee-8f5a-44af-31ab768d845f@arm.com>
 <20200624161954.GC27945@gaia>
From:   James Morse <james.morse@arm.com>
Message-ID: <bac439b7-c560-7597-8937-4a5bb66aeca4@arm.com>
Date:   Fri, 26 Jun 2020 18:24:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200624161954.GC27945@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 24/06/2020 17:24, Catalin Marinas wrote:
> On Wed, Jun 24, 2020 at 03:59:35PM +0100, Steven Price wrote:
>> On 24/06/2020 15:21, Catalin Marinas wrote:
>>> On Wed, Jun 24, 2020 at 12:16:28PM +0100, Steven Price wrote:
>>>> On 23/06/2020 18:48, Catalin Marinas wrote:
>>>>> This causes potential issues since we can't guarantee that all the
>>>>> Cacheable memory slots allocated by the VMM support MTE. If they do not,
>>>>> the arch behaviour is "unpredictable". We also can't trust the guest to
>>>>> not enable MTE on such Cacheable mappings.
>>>>
>>>> Architecturally it seems dodgy to export any address that isn't "normal
>>>> memory" (i.e. with tag storage) to the guest as Normal Cacheable. Although
>>>> I'm a bit worried this might cause a regression in some existing case.
>>>
>>> What I had in mind is some persistent memory that may be given to the
>>> guest for direct access. This is allowed to be cacheable (write-back)
>>> but may not have tag storage.
>>
>> At the moment we don't have a good idea what would happen if/when the guest
>> (or host) attempts to use that memory as tagged. If we have a relatively
>> safe hardware behaviour (e.g. the tags are silently dropped/read-as-zero)
>> then that's not a big issue. But if the accesses cause some form of abort
>> then we need to understand how that would be handled.
> 
> The architecture is not prescriptive here, the behaviour is
> "unpredictable". It could mean tags read-as-zero/write-ignored or an
> SError.

This surely is the same as treating a VFIO device as memory and performing some
unsupported operation on it.

I thought the DT 'which memory ranges' description for MTE was removed. Wouldn't the rules
for a guest be the same? If you enable MTE, everything described as memory must support
MTE. Something like persistent memory then can't be described as memory, ... we have the
same problem on the host.


>>>>> 1. As in your current patches, assume any Cacheable at Stage 2 can have
>>>>>      MTE enabled at Stage 1. In addition, we need to check whether the
>>>>>      physical memory supports MTE and it could be something simple like
>>>>>      pfn_valid(). Is there a way to reject a memory slot passed by the
>>>>>      VMM?
>>>>
>>>> Yes pfn_valid() should have been in there. At the moment pfn_to_page() is
>>>> called without any checks.
>>>>
>>>> The problem with attempting to reject a memory slot is that the memory
>>>> backing that slot can change. So checking at the time the slot is created
>>>> isn't enough (although it might be a useful error checking feature).
>>>
>>> But isn't the slot changed as a result of another VMM call? So we could
>>> always have such check in place.
>>
>> Once you have created a memslot the guest's view of memory follows the user
>> space's address space. This is the KVM_CAP_SYNC_MMU capability. So there's
>> nothing stopping a VMM adding a memslot backed with perfectly reasonable
>> memory then mmap()ing over the top of it some memory which isn't MTE
>> compatible. KVM gets told the memory is being removed (via mmu notifiers)
>> but I think it waits for the next fault before (re)creating the stage 2
>> entries.

(indeed, stage2 is pretty lazy)


> OK, so that's where we could kill the guest if the VMM doesn't play
> nicely. It means that we need the check when setting up the stage 2
> entry. I guess it's fine if we only have the check at that point and
> ignore it on KVM_SET_USER_MEMORY_REGION. It would be nice if we returned
> on error on slot setup but

> we may not know (yet) whether the VMM intends to enable MTE for the guest.

We don't. Memory slots take the VM-fd, whereas the easy-to-add feature bits are per-vcpu.
Packing features into the 'type' that create-vm takes is a problem once we run out,
although the existing user is the IPA space size, and MTE is a property of the memory system.


The meaning of the flag is then "I described this as memory, only let the guest access
memory through this range that is MTE capable". What do we do when that is violated? Tell
the VMM is the nicest, but its not something we ever expect to happen. I guess an abort is
what real hardware would do, (if firmware magically turned off MTE while it was in use).

This would need to be kvm's inject_abt64(), as otherwise the vcpu may take the stage2
fault again, forever. For kvm_set_spte_hva() we can't inject an abort (which vcpu?), so
not mapping the page and waiting for the guest to access it is the only option...


Thanks,

James
