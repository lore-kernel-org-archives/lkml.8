Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5106CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21AC520756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgEUAss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:48:48 -0400
Received: from foss.arm.com ([217.140.110.172]:37662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbgEUAss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:48:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 534F6D6E;
        Wed, 20 May 2020 17:48:47 -0700 (PDT)
Received: from [10.163.75.69] (unknown [10.163.75.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 959693F68F;
        Wed, 20 May 2020 17:48:45 -0700 (PDT)
Subject: Re: [PATCH V3] arm64/cpufeature: Validate hypervisor capabilities
 during CPU hotplug
To:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>
References: <1589248647-22925-1-git-send-email-anshuman.khandual@arm.com>
 <158998676494.231372.15074477766045633803.b4-ty@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e2ccbfdd-85ee-f01c-ce02-462d1a76c273@arm.com>
Date:   Thu, 21 May 2020 06:18:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <158998676494.231372.15074477766045633803.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/20/2020 11:24 PM, Will Deacon wrote:
> On Tue, 12 May 2020 07:27:27 +0530, Anshuman Khandual wrote:
>> This validates hypervisor capabilities like VMID width, IPA range for any
>> hot plug CPU against system finalized values. KVM's view of the IPA space
>> is used while allowing a given CPU to come up. While here, it factors out
>> get_vmid_bits() for general use.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: kvmarm@lists.cs.columbia.edu
>> Cc: linux-kernel@vger.kernel.org
> 
> Applied to arm64 (for-next/cpufeature), thanks!
> 
> [1/1] arm64/cpufeature: Validate hypervisor capabilities during CPU hotplug
>       https://git.kernel.org/arm64/c/c73433fc630c
> 
> But please note that I made some changes to verify_hyp_capabilities() so
> that it's (a) static and (b) uses IS_ENABLED to avoid the dummy function
> definition. I also extended the IS_ENABLED_check so that it doesn't
> conflict with the KVM kconfig changes from Fuad. Please shout if you think
> I'm still missing something.

Normally I would have expected get_kvm_ipa_limit() to be unavailable without
CONFIG_KVM_ARM_HOST, causing a build failure. But it does compile correctly.
Probably the compiler does not really look for get_kvm_ipa_limit() definition
after an early check and bailout on !IS_ENABLED(CONFIG_KVM_ARM_HOST).

Nonetheless, changes looks good. Thank you.

- Anshuman
