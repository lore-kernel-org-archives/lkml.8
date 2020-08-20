Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA875C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F8720885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZprFyVMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHTA3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHTA3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:29:33 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36754C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 17:29:33 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m20so294280eds.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 17:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mYzA5fg5vLsbWiukQbExv7xlsQe0VTmH6cpyjVNlU0U=;
        b=ZprFyVMzXfxeJ3pUuCnzlj9BBhr2RRUYNrtuwyg3qcLreQiW1I9YuCeqJsr3FuOX+n
         sTZ7eB6EKBCfTbUZDFE6xu7vkn3W9dm2xrbF+2c9AjSIeYjUiY4h2LvakHAEosLB0AwF
         8A6Cr+l2DN6+qCpA7wiV3TqwQ1ddWFpkn4H86ejH2Ejo+7fo9S2Nd+rRHHRRFg8ZmOkU
         fy/buLv4o+zG4kUqml4UA4vovD0kIxRvznwT4ZzYuTFtNBopOf5HiKaMZsLWKTGBCEXi
         WRFUH8vyIqQoHId5v0wcCEd+Po9AvSylE2AgYmh7kz8sRaT5dvlfTctIJtDvZ7L0H6jE
         uJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mYzA5fg5vLsbWiukQbExv7xlsQe0VTmH6cpyjVNlU0U=;
        b=gb/Jksl1v8zPahW0lpKfak7pinLxGsDKUs20RTNVEQJgnpSIONjmp75FzLJ1HXJ3tZ
         tDCmNtES4Tsoqq55HSsHjQ0iMYgHsWnL5p2AmUf35/elQXJb13UJ78Ac1BLRuFmfHZ4I
         ehnysQIlAZANx//fM1oAcyRvOJaL/py3AW2avdYy5ehORn0+hm1vWKcIRN8erzgXTywc
         zBPs/BCI0HsOp/rVOixg2pW5PbHVCOc8hNh0GRhKfh7pHRgvN4tOuENLlRezkasYQjWE
         x0YGEqgXlzp3kd0KmvRF66e1jrB4HDCoke1sguKg5bbfl5nn5zHNl2c9nNr0wEkoXbuF
         UVIg==
X-Gm-Message-State: AOAM532oOo/ZIWDOverdFs5vWenF/CldGA+V04XHphSGiTICt4/xCvMj
        i+YYgPtB9t0OePe1tRoQzpPHQQYMGCY=
X-Google-Smtp-Source: ABdhPJwdVBDh5qkPDJmyRmFhEqhN2F2EyIBUkeNcNddncrrCGy2DNAwJTg8cQ8GarxottVOKjlOLjQ==
X-Received: by 2002:a05:6402:b32:: with SMTP id bo18mr547039edb.201.1597883371553;
        Wed, 19 Aug 2020 17:29:31 -0700 (PDT)
Received: from [10.69.56.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id le20sm286759ejb.96.2020.08.19.17.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 17:29:30 -0700 (PDT)
Subject: Re: [PATCH v2] mm: include CMA pages in lowmem_reserve at boot
To:     Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1597423766-27849-1-git-send-email-opendmb@gmail.com>
 <20200818201817.351499e75cba2a84e8bf33e6@linux-foundation.org>
 <e22cbcdc-e9ce-50b7-aa88-6a3579ffd509@gmail.com>
 <20200819102214.32238093b116ab6f1c5c7b73@linux-foundation.org>
 <50ad53dc-faf2-3014-bac3-be370b972f59@gmail.com>
 <20200819104057.4b91898b76302b7b1c3e8e56@linux-foundation.org>
From:   Doug Berger <opendmb@gmail.com>
Message-ID: <65909c25-71b2-0116-1ac7-a56118bca86e@gmail.com>
Date:   Wed, 19 Aug 2020 17:32:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819104057.4b91898b76302b7b1c3e8e56@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/2020 10:40 AM, Andrew Morton wrote:
> On Wed, 19 Aug 2020 10:30:25 -0700 Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>> On 8/19/20 10:22 AM, Andrew Morton wrote:
>>> On Wed, 19 Aug 2020 10:15:53 -0700 Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>
>>>>>> In many cases the difference is not significant, but for example
>>>>>> an ARM platform with 1GB of memory and the following memory layout
>>>>>> [    0.000000] cma: Reserved 256 MiB at 0x0000000030000000
>>>>>> [    0.000000] Zone ranges:
>>>>>> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
>>>>>> [    0.000000]   Normal   empty
>>>>>> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000003fffffff]
>>>>>>
>>>>>> would result in 0 lowmem_reserve for the DMA zone. This would allow
>>>>>> userspace to deplete the DMA zone easily.
>>>>>
>>>>> Sounds fairly serious for thos machines.  Was a cc:stable considered?
>>>>
>>>> Since there is a Fixes: tag, it may have been assumed that the patch
>>>> would be picked up and as soon as it reaches Linus' tree it would be
>>>> picked up by the stable selection.
>>>
>>> It doesn't work that way - sometimes a fix isn't considered important
>>> enough to backport.  It could just fix a typo in a comment!
>>
>> Then can this be applied ASAP and back ported?
> 
> Sure.
> 
As Florian guessed, I assumed the Fixes: tag was a sufficient clue since
I wouldn't normally apply a Fixes tag to a typo correction in a comment.
I suspect I have been spoiled by David Miller :).

Thanks for the quick turn-around and applying the cc:stable to the mmotm,
    Doug
