Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5E4C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D6320776
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgDQJdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:33:03 -0400
Received: from foss.arm.com ([217.140.110.172]:48818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730131AbgDQJdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:33:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A017F30E;
        Fri, 17 Apr 2020 02:33:02 -0700 (PDT)
Received: from [10.37.12.128] (unknown [10.37.12.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38E6E3F73D;
        Fri, 17 Apr 2020 02:33:00 -0700 (PDT)
Subject: Re: [PATCH 7/8] arm64: cpufeature: Relax checks for AArch32 support
 at EL[0-2]
To:     will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        saiprakash.ranjan@codeaurora.org, dianders@chromium.org,
        kernel-team@android.com
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-8-will@kernel.org>
 <714f124c-7eb7-b750-e98c-63da64ddae75@arm.com>
 <20200415105843.GE12621@willie-the-truck>
 <d1f538ec-e956-c136-d0f8-54e7351a28a9@arm.com>
 <20200415122926.GA17095@willie-the-truck>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <399dee05-9f47-2f91-a4e8-b4c9d3932b40@arm.com>
Date:   Fri, 17 Apr 2020 10:37:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200415122926.GA17095@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15/2020 01:29 PM, Will Deacon wrote:
> On Wed, Apr 15, 2020 at 12:37:31PM +0100, Suzuki K Poulose wrote:
>> On 04/15/2020 11:58 AM, Will Deacon wrote:
>>> On Wed, Apr 15, 2020 at 11:50:58AM +0100, Suzuki K Poulose wrote:
>>>> On 04/14/2020 10:31 PM, Will Deacon wrote:
>>>>> We don't need to be quite as strict about mismatched AArch32 support,
>>>>> which is good because the friendly hardware folks have been busy
>>>>> mismatching this to their hearts' content.
>>>>>
>>>>>      * We don't care about EL2 or EL3 (there are silly comments concerning
>>>>>        the latter, so remove those)
>>>>>
>>>>>      * EL1 support is gated by the ARM64_HAS_32BIT_EL1 capability and handled
>>>>>        gracefully when a mismatch occurs
>>>>>
>>>>>      * EL1 support is gated by the ARM64_HAS_32BIT_EL0 capability and handled
>>>>
>>>> s/EL1/EL0
>>>>
>>>>>        gracefully when a mismatch occurs
>>>>>
>>>>> Relax the AArch32 checks to FTR_NONSTRICT.
>>>>
>>>> Agreed. We should do something similar for the features exposed by the
>>>> ELF_HWCAP, of course in a separate series.
>>>
>>> Hmm, I didn't think we needed to touch the HWCAPs, as they're derived from
>>> the sanitised feature register values. What am I missing?
>>
>> sorry, that was cryptic. I was suggesting to relax the ftr fields to
>> NONSTRICT for the fields covered by ELF HWCAPs (and other CPU hwcaps).
> 
> Ah, gotcha. Given that the HWCAPs usually describe EL0 features, I say we
> can punt this down the road until people give us hardware with mismatched
> AArch32 at EL0.

Btw, this is not just mismatched AArch32, but mismatched AArch64 HWCAPs
too, which I believe exists. Anyways as you said, we can delay this
until we get the reports :-)

Suzuki
