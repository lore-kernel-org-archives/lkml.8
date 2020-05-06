Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21268C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F004E2073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgEFNEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:04:47 -0400
Received: from foss.arm.com ([217.140.110.172]:36264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbgEFNEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:04:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63B95D6E;
        Wed,  6 May 2020 06:04:46 -0700 (PDT)
Received: from [10.57.31.214] (unknown [10.57.31.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64E833F68F;
        Wed,  6 May 2020 06:04:43 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] arm64/crash_core: Export KERNELPACMASK in
 vmcoreinfo
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <1587968702-19996-1-git-send-email-amit.kachhap@arm.com>
 <20200504171741.GD1833@willie-the-truck>
 <bc5e6fc5-15f4-40bb-4466-816de5912893@arm.com>
 <20200506123112.GF8043@willie-the-truck>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <590176f0-802b-f71a-0c1e-00283808e1d8@arm.com>
Date:   Wed, 6 May 2020 18:34:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200506123112.GF8043@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/6/20 6:01 PM, Will Deacon wrote:
> On Wed, May 06, 2020 at 05:32:56PM +0530, Amit Kachhap wrote:
>> On 5/4/20 10:47 PM, Will Deacon wrote:
>>> On Mon, Apr 27, 2020 at 11:55:01AM +0530, Amit Daniel Kachhap wrote:
>>>> diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
>>>> index eece20d..32d5900 100644
>>>> --- a/arch/arm64/include/asm/compiler.h
>>>> +++ b/arch/arm64/include/asm/compiler.h
>>>> @@ -19,6 +19,9 @@
>>>>    #define __builtin_return_address(val)					\
>>>>    	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
>>>> +#else  /* !CONFIG_ARM64_PTR_AUTH */
>>>> +#define	ptrauth_user_pac_mask()		0ULL
>>>> +#define	ptrauth_kernel_pac_mask()	0ULL
>>>
>>> This doesn't look quite right to me, since you still have to take into
>>> account the case where CONFIG_ARM64_PTR_AUTH=y but the feature is not
>>> available at runtime:
>>
>> Yes agree with you here. However the config gaurd is saving some extra
>> computation for __builtin_return_address. There are some compiler
>> support being added in __builtin_extract_return_address to mask the PAC.
>> Hopefully that will improve this code. In the meantime let it be like this.
> 
> Does the extra computation matter? Isn't it just a couple of instructions?

ok sure. I will push v3 as you suggested.

Thanks,
Amit

> 
> Will
> 
