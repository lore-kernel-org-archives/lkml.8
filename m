Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C37BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D1C82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390637AbgFXLSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:18:55 -0400
Received: from foss.arm.com ([217.140.110.172]:36028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390586AbgFXLSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:18:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44A0B1F1;
        Wed, 24 Jun 2020 04:18:50 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 588F53F6CF;
        Wed, 24 Jun 2020 04:18:48 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] MTE support for KVM guest
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dave P Martin <Dave.Martin@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
References: <20200617123844.29960-1-steven.price@arm.com>
 <CAFEAcA8Myn_QEjfk4Ka604PDAUAWXs6dLUY5bEQ98C__oMsmhA@mail.gmail.com>
 <20200624093846.GA11863@gaia> <20200624103412.GD25945@arm.com>
 <faa68f22-4d8e-0290-b52a-63ae7425b988@arm.com> <20200624110904.GB11863@gaia>
From:   Steven Price <steven.price@arm.com>
Message-ID: <904edac0-3de7-35a6-a9bc-b983ccd3490c@arm.com>
Date:   Wed, 24 Jun 2020 12:18:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624110904.GB11863@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2020 12:09, Catalin Marinas wrote:
> On Wed, Jun 24, 2020 at 12:03:35PM +0100, Steven Price wrote:
>> On 24/06/2020 11:34, Dave Martin wrote:
>>> On Wed, Jun 24, 2020 at 10:38:48AM +0100, Catalin Marinas wrote:
>>>> On Tue, Jun 23, 2020 at 07:05:07PM +0100, Peter Maydell wrote:
>>>>> On Wed, 17 Jun 2020 at 13:39, Steven Price <steven.price@arm.com> wrote:
>>>>>> These patches add support to KVM to enable MTE within a guest. It is
>>>>>> based on Catalin's v4 MTE user space series[1].
>>>>>>
>>>>>> [1] http://lkml.kernel.org/r/20200515171612.1020-1-catalin.marinas%40arm.com
>>>>>>
>>>>>> Posting as an RFC as I'd like feedback on the approach taken.
>>>>>
>>>>> What's your plan for handling tags across VM migration?
>>>>> Will the kernel expose the tag ram to userspace so we
>>>>> can copy it from the source machine to the destination
>>>>> at the same time as we copy the actual ram contents ?
>>>>
>>>> Qemu can map the guest memory with PROT_MTE and access the tags directly
>>>> with LDG/STG instructions. Steven was actually asking in the cover
>>>> letter whether we should require that the VMM maps the guest memory with
>>>> PROT_MTE as a guarantee that it can access the guest tags.
>>>>
>>>> There is no architecturally visible tag ram (tag storage), that's a
>>>> microarchitecture detail.
>>>
>>> If userspace maps the guest memory with PROT_MTE for dump purposes,
>>> isn't it going to get tag check faults when accessing the memory
>>> (i.e., when dumping the regular memory content, not the tags
>>> specifically).
>>>
>>> Does it need to map two aliases, one with PROT_MTE and one without,
>>> and is that architecturally valid?
>>
>> Userspace would either need to have two mappings (I don't believe there are
>> any architectural issues with that - but this could be awkward to arrange in
>> some situations) or be careful to avoid faults. Basically your choices with
>> one mapping are:
>>
>>   1. Disable tag checking (using prctl) when touching the memory. This works
>> but means you lose tag checking for the VMM's own accesses during this code
>> sequence.
>>
>>   2. Read the tag values and ensure you use the correct tag. This suffers
>> from race conditions if the VM is still running.
>>
>>   3. Use one of the exceptions in the architecture that generates a Tag
>> Unchecked access. Sadly the only remotely useful thing I can see in the v8
>> ARM is "A base register plus immediate offset addressing form, with the SP
>> as the base register." - but making sure SP is in range of where you want to
>> access would be a pain.
> 
> Or:
> 
> 4. Set PSTATE.TCO when accessing tagged memory in an unsafe way.
> 

Ah yes, similar to (1) but much lower overhead ;) That's probably the 
best option - it can be hidden in a memcpy_ignoring_tags() function. 
However it still means that the VMM can't directly touch the guest's 
memory which might cause issues for the VMM.

Steve
