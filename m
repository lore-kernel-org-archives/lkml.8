Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607B7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A4B206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgHQJtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:49:18 -0400
Received: from foss.arm.com ([217.140.110.172]:52262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgHQJtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:49:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECBB631B;
        Mon, 17 Aug 2020 02:49:14 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84E493F66B;
        Mon, 17 Aug 2020 02:49:13 -0700 (PDT)
Subject: Re: [PATCH 2/3] KVM: uapi: Remove KVM_DEV_TYPE_ARM_PV_TIME in
 kvm_device_type
To:     zhukeqian <zhukeqian1@huawei.com>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        wanghaibin.wang@huawei.com
References: <20200817033729.10848-1-zhukeqian1@huawei.com>
 <20200817033729.10848-3-zhukeqian1@huawei.com>
 <f97633b4a39c301f916bb76030dcabf0@kernel.org>
 <4cd543a2-4d5b-882c-38d6-f5055512f0dc@huawei.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <72e34f84-5bea-8f69-6699-29e2970c80b4@arm.com>
Date:   Mon, 17 Aug 2020 10:49:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4cd543a2-4d5b-882c-38d6-f5055512f0dc@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2020 09:43, zhukeqian wrote:
> Hi Marc,
> 
> On 2020/8/17 15:39, Marc Zyngier wrote:
>> On 2020-08-17 04:37, Keqian Zhu wrote:
>>> ARM64 PV-time ST is configured by userspace through vCPU attribute,
>>> and KVM_DEV_TYPE_ARM_PV_TIME is unused.
>>>
>>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>> ---
>>>   include/uapi/linux/kvm.h       | 2 --
>>>   tools/include/uapi/linux/kvm.h | 2 --
>>>   2 files changed, 4 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>> index 4fdf303..9a6b97e 100644
>>> --- a/include/uapi/linux/kvm.h
>>> +++ b/include/uapi/linux/kvm.h
>>> @@ -1258,8 +1258,6 @@ enum kvm_device_type {
>>>   #define KVM_DEV_TYPE_ARM_VGIC_ITS    KVM_DEV_TYPE_ARM_VGIC_ITS
>>>       KVM_DEV_TYPE_XIVE,
>>>   #define KVM_DEV_TYPE_XIVE        KVM_DEV_TYPE_XIVE
>>> -    KVM_DEV_TYPE_ARM_PV_TIME,
>>> -#define KVM_DEV_TYPE_ARM_PV_TIME    KVM_DEV_TYPE_ARM_PV_TIME
>>>       KVM_DEV_TYPE_MAX,
>>>   };
>>>
>>> diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
>>> index 4fdf303..9a6b97e 100644
>>> --- a/tools/include/uapi/linux/kvm.h
>>> +++ b/tools/include/uapi/linux/kvm.h
>>> @@ -1258,8 +1258,6 @@ enum kvm_device_type {
>>>   #define KVM_DEV_TYPE_ARM_VGIC_ITS    KVM_DEV_TYPE_ARM_VGIC_ITS
>>>       KVM_DEV_TYPE_XIVE,
>>>   #define KVM_DEV_TYPE_XIVE        KVM_DEV_TYPE_XIVE
>>> -    KVM_DEV_TYPE_ARM_PV_TIME,
>>> -#define KVM_DEV_TYPE_ARM_PV_TIME    KVM_DEV_TYPE_ARM_PV_TIME
>>>       KVM_DEV_TYPE_MAX,
>>>   };
>>
>> No. You can't drop anything from UAPI, used or not. Doing so will
>> break the compilation of any userspace that, for any reason, references
>> this value. We cannot reuse this value in the future either, as it would
>> create a we wouldn't know which device to create.
>>
>> It is pretty unfortunate that PV time has turned into such a train wreck,
>> but that's what we have now, and it has to stay.
> Well, I see. It is a sad thing indeed.

Sorry about that, this got refactored so many times I guess I lost track 
of what was actually needed and this hunk remained when it should have 
been removed.

I would hope that I'm the only one who has any userspace code which uses 
this, but I guess we should still be cautious since this has been in 
several releases now.

Steve
