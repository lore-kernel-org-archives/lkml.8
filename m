Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4AAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459332088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590696980;
	bh=6Z/HuxKjFewiEiSstCyG+VcmpsxC2BteH/31xQNCgJs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=V8TTFYgIuXeMGGV2w9xo0hE47XO22sM5jzI8c/YLM9Gg5zszomxOGauHLHB2Mx9Q+
	 U2SJjebxL/5iJCKh6Rs2QZC3qTn2eMBIUF7CPqWAfWOZGvtSHRHiq8LOxu43xtLEi6
	 crNkutrnEF/hLK1dkPg8Rqw9U1gb+jc9mcz3djrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407196AbgE1UQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407182AbgE1UQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:16:07 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B35C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:16:07 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a137so383424oii.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G9v5weXtyKc3IseC+Bgo2LPHDLXxu13c4mrDGZBtUCE=;
        b=eBP0mtNvcqAXHNF0oqezhSLg2+R9bsxXj2wGfcc+ZrrnECjL5kT+NTlWHIiaphnLEs
         5ZW+iIPq+L4cKRFphq4YPLqDAYjSMYFJxjGY7/EK7LlPGvTAvLZQ8e3PsScFeRSuqBni
         85hZxAyNviK+7hpeZ0/4JOV8MJHcGYCYrkYDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G9v5weXtyKc3IseC+Bgo2LPHDLXxu13c4mrDGZBtUCE=;
        b=Y94Vlz9jPcE3dedfm3VZ4knrR+W2f2qxtRmHY+cTbOyWZXHCmIzAdXDyGmab4gvBd+
         V9w0kJ0wh8x3fTxK83FsYt31QvmZoL5qQ9XqDvNsw9ogb11ZrakmwPtYhoRNupUzmT/4
         XwoRLUlMZszPRkgJ6aauK9ifykTw6HnAmsG1RDOHLhFZm3F3/q+OPp5tRjVJvQo0+Y7F
         COasknouAfosoILyUilfFmCq3GRO8WVbGBBO8rNuSuFX4ZQ86o1FeBhzrW8AYCdxBiiR
         RkeqQKT56PH4NmN7oj7cbVssLXBvkIasP/g/eIJbqCKSQ9R1oNdnffRyoTpRP64A5HOY
         WcKA==
X-Gm-Message-State: AOAM530br39i6YRbYQiOUBmL7POlryfUJtSXteEh6NLgBsQqkhpojuRZ
        zfFCC/LC4hhAtrAoajFh4BQRKQ==
X-Google-Smtp-Source: ABdhPJyar0ROKJIh65Mms+BI2c6G8U9WoJVjmRuNtKFOtHoLQ/lggDpLkCc+D6/P+K4DF/1+c3KJGQ==
X-Received: by 2002:a54:460a:: with SMTP id p10mr3528564oip.136.1590696966382;
        Thu, 28 May 2020 13:16:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k69sm2109002oib.26.2020.05.28.13.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 13:16:05 -0700 (PDT)
Subject: Re: [PATCH v7 0/5] KUnit-KASAN Integration
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     shuah <shuah@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200424061342.212535-1-davidgow@google.com>
 <alpine.LRH.2.21.2005031101130.20090@localhost>
 <26d96fb9-392b-3b20-b689-7bc2c6819e7b@kernel.org>
 <CABVgOS=MueiJ6AHH6QUSWjipSezi1AvggxBCrh0Q9P_wa55XZQ@mail.gmail.com>
 <CAFd5g46Y-9vSSSke05hNyOoj3=OXcJh8bHGFciDVnwkSrpcjZw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cadaba3e-f679-e275-4196-4e497eb27624@linuxfoundation.org>
Date:   Thu, 28 May 2020 14:16:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g46Y-9vSSSke05hNyOoj3=OXcJh8bHGFciDVnwkSrpcjZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 1:52 PM, Brendan Higgins wrote:
> On Tue, May 26, 2020 at 7:51 PM David Gow <davidgow@google.com> wrote:
>>
>> On Sat, May 23, 2020 at 6:30 AM shuah <shuah@kernel.org> wrote:
>>>
>>> On 5/3/20 4:09 AM, Alan Maguire wrote:
>>>> On Thu, 23 Apr 2020, David Gow wrote:
>>>>
>>>>> This patchset contains everything needed to integrate KASAN and KUnit.
>>>>>
>>>>> KUnit will be able to:
>>>>> (1) Fail tests when an unexpected KASAN error occurs
>>>>> (2) Pass tests when an expected KASAN error occurs
>>>>>
>>>>> Convert KASAN tests to KUnit with the exception of copy_user_test
>>>>> because KUnit is unable to test those.
>>>>>
>>>>> Add documentation on how to run the KASAN tests with KUnit and what to
>>>>> expect when running these tests.
>>>>>
>>>>> This patchset depends on:
>>>>> - "[PATCH v3 kunit-next 0/2] kunit: extend kunit resources API" [1]
>>>>> - "[PATCH v3 0/3] Fix some incompatibilites between KASAN and
>>>>>     FORTIFY_SOURCE" [2]
>>>>>
>>>>> Changes from v6:
>>>>>    - Rebased on top of kselftest/kunit
>>>>>    - Rebased on top of Daniel Axtens' fix for FORTIFY_SOURCE
>>>>>      incompatibilites [2]
>>>>>    - Removed a redundant report_enabled() check.
>>>>>    - Fixed some places with out of date Kconfig names in the
>>>>>      documentation.
>>>>>
>>>>
>>>> Sorry for the delay in getting to this; I retested the
>>>> series with the above patchsets pre-applied; all looks
>>>> good now, thanks!  Looks like Daniel's patchset has a v4
>>>> so I'm not sure if that will have implications for applying
>>>> your changes on top of it (haven't tested it yet myself).
>>>>
>>>> For the series feel free to add
>>>>
>>>> Tested-by: Alan Maguire <alan.maguire@oracle.com>
>>>>
>>>> I'll try and take some time to review v7 shortly, but I wanted
>>>> to confirm the issues I saw went away first in case you're
>>>> blocked.  The only remaining issue I see is that we'd need the
>>>> named resource patchset to land first; it would be good
>>>> to ensure the API it provides is solid so you won't need to
>>>> respin.
>>>>
>>>> Thanks!
>>>>
>>>> Alan
>>>>
>>>>> Changes from v5:
>>>>>    - Split out the panic_on_warn changes to a separate patch.
>>>>>    - Fix documentation to fewer to the new Kconfig names.
>>>>>    - Fix some changes which were in the wrong patch.
>>>>>    - Rebase on top of kselftest/kunit (currently identical to 5.7-rc1)
>>>>>
>>>>
>>>
>>> Hi Brendan,
>>>
>>> Is this series ready to go inot Linux 5.8-rc1? Let me know.
>>> Probably needs rebase on top of kselftest/kunit. I applied
>>> patches from David and Vitor
>>>
>>> thanks,
>>> -- Shuah
>>>
>>
>> Hi Shuah,
>>
>> I think the only things holding this up are the missing dependencies:
>> the "extend kunit resources API" patches[1] for KUnit (which look
>> ready to me), and the "Fix some incompatibilities between KASAN and
>> FORTIFY_SOURCE" changes[2] on the KASAN side (which also seem ready).
>>
>> This patchset may need a (likely rather trivial) rebase on top of
>> whatever versions of those end up merged: I'm happy to do that if
>> necessary.
>>
>> Cheers,
>> -- David
>>
>> [1]: https://lore.kernel.org/linux-kselftest/1585313122-26441-1-git-send-email-alan.maguire@oracle.com/T/#t
>> [2]: http://lkml.iu.edu/hypermail/linux/kernel/2004.3/00735.html
> 
> As David pointed out, this series is waiting on its dependencies.
> Sorry, I thought the "extend KUnit resources API" patchset was ready
> to go, but I realized I only gave a reviewed-by to one of the patches.
> Both have been reviewed now, but one patch needs a minor fix.
> 

Yes. Thanks David.

> As for other patches, the patches from David, Vitor, and Anders should
> cover everything. Thanks!
>
I pulled David's and Vitor's patches. I am waiting for patch from
Vitor to fix a problem that was introduced when I was resolving merge
conflicts between Vitor's and David's patches.

I will pull Anders patches.

thanks,
-- Shuah


