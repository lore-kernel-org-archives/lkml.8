Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59907C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4AE207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZRl2zMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgHSRQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHSRQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:16:04 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0C9C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:16:03 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f24so27243537ejx.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XRqa7rD+3TPE1bG2h+MbFmHitdNtLwxzxGM/+CI+Rdk=;
        b=ZZRl2zMJAdWdkotK88EQbw8bXL3Fqo22rxMyJDQljJubgOmdGX2UQn+ksXEQyE29SL
         WLPdcDA3fZSO4TIt2A3JBbwJ0ON3Q6raRZ3Zaw9FStagZoXRtdXSNnC7hMXYIP+qIwGj
         T1J0gjQaUjcS+fbSnTLkBiP9Ycni9t+IKg3ki72wmMRLL16hLMMhqlTI2dByQLM5OcET
         M5ZJgiUzLNUnZrImtVOStVKIfQJoFbjnULzqCMnaoirIawisorTh1J4tM93QsjV1AuEw
         FdC2VA900h53fi4FqWO0O70EkJrkYgg8DyBcO47g6O2L0fv3GIe6znk33rAvQs9Emlvz
         LcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XRqa7rD+3TPE1bG2h+MbFmHitdNtLwxzxGM/+CI+Rdk=;
        b=k5zOOTfUkQ4fQssBU8IGi2VUo9QtZJNlaKP0sJKKI9sM8Rh1yy5Y67GMFAE+WYeXpT
         Viq0ZJZnVCXwTbl3COOGlrfo8R5dbB3fN33+RqhU+7V4IWjgAa8bX73rH3MD8ETErvph
         thgzfsQHyH/z/IUCjapSl9I9sIAQ33UNKYkYmli6lrIrsOKFBcmtGLOZaGaIQEJZL0Nl
         t9pjtiEa36Zx7cIwuIdkABBRJoUL/8ARf31HM4xiw+ufy96LCGS3G34a1BbWKbPRInRl
         GABKTVZrjKJB8NwRLmBwiLHXvGO2zo8wnhpsT4kjRkpC7wxtXfZi5Cx5lff6fH3hlXyk
         R1fg==
X-Gm-Message-State: AOAM530ANmod9iKEtDclu2CxVaPgaAiDgxIfGIY3Bqvde94YJ2XndXW7
        DIyy3LrVay0taFJZx8DCJ1/F0XdQAec=
X-Google-Smtp-Source: ABdhPJzg6yn2d3YhjlksWnytCWJiCl/tQ1npRji9uuyfS6hX1VW18Yx1aPGrJuVUhfuPb1bAJHqBuA==
X-Received: by 2002:a17:907:10d9:: with SMTP id rv25mr24666958ejb.264.1597857362180;
        Wed, 19 Aug 2020 10:16:02 -0700 (PDT)
Received: from [10.67.50.75] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s9sm20373831edt.36.2020.08.19.10.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 10:16:01 -0700 (PDT)
Subject: Re: [PATCH v2] mm: include CMA pages in lowmem_reserve at boot
To:     Andrew Morton <akpm@linux-foundation.org>,
        Doug Berger <opendmb@gmail.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1597423766-27849-1-git-send-email-opendmb@gmail.com>
 <20200818201817.351499e75cba2a84e8bf33e6@linux-foundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <e22cbcdc-e9ce-50b7-aa88-6a3579ffd509@gmail.com>
Date:   Wed, 19 Aug 2020 10:15:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818201817.351499e75cba2a84e8bf33e6@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/20 8:18 PM, Andrew Morton wrote:
> On Fri, 14 Aug 2020 09:49:26 -0700 Doug Berger <opendmb@gmail.com> wrote:
> 
>> The lowmem_reserve arrays provide a means of applying pressure
>> against allocations from lower zones that were targeted at
>> higher zones. Its values are a function of the number of pages
>> managed by higher zones and are assigned by a call to the
>> setup_per_zone_lowmem_reserve() function.
>>
>> The function is initially called at boot time by the function
>> init_per_zone_wmark_min() and may be called later by accesses
>> of the /proc/sys/vm/lowmem_reserve_ratio sysctl file.
>>
>> The function init_per_zone_wmark_min() was moved up from a
>> module_init to a core_initcall to resolve a sequencing issue
>> with khugepaged. Unfortunately this created a sequencing issue
>> with CMA page accounting.
>>
>> The CMA pages are added to the managed page count of a zone
>> when cma_init_reserved_areas() is called at boot also as a
>> core_initcall. This makes it uncertain whether the CMA pages
>> will be added to the managed page counts of their zones before
>> or after the call to init_per_zone_wmark_min() as it becomes
>> dependent on link order. With the current link order the pages
>> are added to the managed count after the lowmem_reserve arrays
>> are initialized at boot.
>>
>> This means the lowmem_reserve values at boot may be lower than
>> the values used later if /proc/sys/vm/lowmem_reserve_ratio is
>> accessed even if the ratio values are unchanged.
>>
>> In many cases the difference is not significant, but for example
>> an ARM platform with 1GB of memory and the following memory layout
>> [    0.000000] cma: Reserved 256 MiB at 0x0000000030000000
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
>> [    0.000000]   Normal   empty
>> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000003fffffff]
>>
>> would result in 0 lowmem_reserve for the DMA zone. This would allow
>> userspace to deplete the DMA zone easily.
> 
> Sounds fairly serious for thos machines.  Was a cc:stable considered?

Since there is a Fixes: tag, it may have been assumed that the patch
would be picked up and as soon as it reaches Linus' tree it would be
picked up by the stable selection.
-- 
Florian
