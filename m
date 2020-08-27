Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FB5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD52422CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgH0N5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:57:23 -0400
Received: from foss.arm.com ([217.140.110.172]:58330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgH0Nnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:43:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A38C31B;
        Thu, 27 Aug 2020 06:42:58 -0700 (PDT)
Received: from [192.168.1.190] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9E2B3F68F;
        Thu, 27 Aug 2020 06:42:55 -0700 (PDT)
Subject: Re: [PATCH 26/35] kasan, arm64: Enable TBI EL1
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1597425745.git.andreyknvl@google.com>
 <518da1e5169a4e343caa3c37feed5ad551b77a34.1597425745.git.andreyknvl@google.com>
 <20200827104033.GF29264@gaia> <9c53dfaa-119e-b12e-1a91-1f67f4aef503@arm.com>
 <20200827111344.GK29264@gaia> <d6695105-0484-2013-1012-fa977644e8ad@arm.com>
 <CAAeHK+wGKjYX6eLztiwQA2iObjibHPKt3A4oU0zpXPKk-4qdOw@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <30b90e66-2ac0-82b3-b590-5a2b35fad446@arm.com>
Date:   Thu, 27 Aug 2020 14:45:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+wGKjYX6eLztiwQA2iObjibHPKt3A4oU0zpXPKk-4qdOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 8/27/20 1:43 PM, Andrey Konovalov wrote:
> On Thu, Aug 27, 2020 at 1:15 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>>
>>
>> On 8/27/20 12:13 PM, Catalin Marinas wrote:
>>> On Thu, Aug 27, 2020 at 12:05:55PM +0100, Vincenzo Frascino wrote:
>>>> On 8/27/20 11:40 AM, Catalin Marinas wrote:
>>>>> On Fri, Aug 14, 2020 at 07:27:08PM +0200, Andrey Konovalov wrote:
>>>>>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>>>>>> index 152d74f2cc9c..6880ddaa5144 100644
>>>>>> --- a/arch/arm64/mm/proc.S
>>>>>> +++ b/arch/arm64/mm/proc.S
>>>>>> @@ -38,7 +38,7 @@
>>>>>>  /* PTWs cacheable, inner/outer WBWA */
>>>>>>  #define TCR_CACHE_FLAGS   TCR_IRGN_WBWA | TCR_ORGN_WBWA
>>>>>>
>>>>>> -#ifdef CONFIG_KASAN_SW_TAGS
>>>>>> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>>>>>>  #define TCR_KASAN_FLAGS TCR_TBI1
>>>>>>  #else
>>>>>>  #define TCR_KASAN_FLAGS 0
>>>>>
>>>>> I prefer to turn TBI1 on only if MTE is present. So on top of the v8
>>>>> user series, just do this in __cpu_setup.
>>>>
>>>> Not sure I understand... Enabling TBI1 only if MTE is present would break
>>>> KASAN_SW_TAGS which is based on TBI1 but not on MTE.
>>>
>>> You keep the KASAN_SW_TAGS as above but for HW_TAGS, only set TBI1 later
>>> in __cpu_setup().
>>>
>>
>> Ok, sounds good.
> 
> Sounds good to me too.
> 
> Vincenzo, could you take care of Catalin's comments on your (arm64)
> patches, do the rebase onto user mte v8, and share it with me? I'll
> work on KASAN changes in the meantime, and then integrate everything
> together for v2.
> 

I am happy to do that. I will be on holiday though from this Saturday till the
September, 9. After that I will start the rebasing.

> Perhaps the best way to test only the arm64 part is writing a simple
> module that causes an MTE fault. (At least that's what I did when I
> was testing core in-kernel MTE patches separately.) Or reuse this
> series, all KASAN patches should rebase cleanly on top of the latest
> mainline.
> 

I can reuse the patches as they are, unless they require changes when I start
rebasing. In such a case to not duplicate the work I will scale back to use a
simple module.

-- 
Regards,
Vincenzo
