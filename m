Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA659C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA2B221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA/LXLnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHGOlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgHGOlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:41:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1E4C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 07:41:07 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c10so6288840pjn.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EhRfzJQciJF4ta/QYMi0T/gwunh1t8mfFlYslOANkQQ=;
        b=YA/LXLnqAL9qH1NBrPxCzhWWXCohllyMSWhsAabq84bokl/dKAqV0SK1InhnPii8d/
         Emj629CkTvagSV/yl/bhd3zdlwj41788yBDIFtm5MVhKdFrBG0e/OeThcuzBaZO9JKbl
         JCX0ZNebuRObZxnoAGnTaWGKYmhZR4tRwMV8PDPBkottES49ikrw48ZWXn6Qi6UwGBtc
         F/QAPi2rhhJ6/mPPzkWSpEW7sScpEzdq9kkZWEmbr8iUeetOZZIRIHZgMpkXovL8UM1i
         D5VSxDolaYNxXsmrUNEtmkEtVJq/aOAuDOZYHaJ41NwYEghkFbu3uAXGRb8C9D0CmX+d
         72Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EhRfzJQciJF4ta/QYMi0T/gwunh1t8mfFlYslOANkQQ=;
        b=aDEbu2uZAOLs7Esxf3RrWJZNVBBn1GJyXHbHdGqvacS7w3TnfZf3yftSlFn6IxysqE
         8A0xBJw87EbpAdDWgCKW2gZT7bNCYMMwl0D0BtfCLsoBSyRj1AgQgjP2ym2oUSsOh/em
         csdnCYd0FpJGCIxdmstqS7uOldYaC/5ltsKNJSmCyrlrMOobykOh4S/vjFmt3tfSt2t5
         JteEjTQ8PelH+x6BOpT4+Sq5TSVpNPfRqvYQl/Plg6kggl1Zvs4khULQNtphoAjEr32g
         Mie5kN83IipYZk1sL8Qn1lG4JaVlyQvvfwv3RYu55EB95dz1ZKrMZ2y5qbKxFTFBvfnM
         irRA==
X-Gm-Message-State: AOAM532MABUh5WmRLElHvnWgEP8hkCfNxQF8Q3jyGcvTaisKlxGvETGi
        kDAKBZ5Pjgf89q2gkgNm0S8=
X-Google-Smtp-Source: ABdhPJxwdtLTKMvWBL2uw9v75VNR4/lOo+Vvx2UZJORj9Pqxct7Oip6+YnUoqR1B2Y7he5MBcKgdyg==
X-Received: by 2002:a17:902:bb94:: with SMTP id m20mr12883429pls.190.1596811266400;
        Fri, 07 Aug 2020 07:41:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a26sm10877554pgm.20.2020.08.07.07.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 07:41:05 -0700 (PDT)
Subject: Re: [PATCH] arm64: kaslr: Use standard early random function
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        tytso@mit.edu, Qian Cai <cai@lca.pw>,
        Mark Brown <broonie@kernel.org>
References: <20200807004904.72893-1-linux@roeck-us.net>
 <20200807101723.GB72666@C02TD0UTHF1T.local>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <05d722c8-9de8-9032-7f72-dd4d14f044eb@roeck-us.net>
Date:   Fri, 7 Aug 2020 07:41:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807101723.GB72666@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/20 3:17 AM, Mark Rutland wrote:
> Hi Guenter,
> 
> On Thu, Aug 06, 2020 at 05:49:04PM -0700, Guenter Roeck wrote:
>> Commit 585524081ecd ("random: random.h should include archrandom.h, not
>> the other way around") tries to fix a problem with recursive inclusion
>> of linux/random.h and arch/archrandom.h for arm64. Unfortunately, this
>> results in the following compile error if ARCH_RANDOM is disabled.
>>
>> arch/arm64/kernel/kaslr.c: In function 'kaslr_early_init':
>> arch/arm64/kernel/kaslr.c:128:6: error: implicit declaration of function
>> '__early_cpu_has_rndr'; did you mean '__early_pfn_to_nid'?
>> [-Werror=implicit-function-declaration]
>>   if (__early_cpu_has_rndr()) {
>>       ^~~~~~~~~~~~~~~~~~~~
>>       __early_pfn_to_nid
>> arch/arm64/kernel/kaslr.c:131:7: error: implicit declaration of function
>> '__arm64_rndr' [-Werror=implicit-function-declaration]
>>    if (__arm64_rndr(&raw))
>>        ^~~~~~~~~~~~
>>
>> Problem is that arch/archrandom.h is only included from linux/random.h if
>> ARCH_RANDOM is enabled. If not, __arm64_rndr() and __early_cpu_has_rndr()
>> are undeclared, causing the problem.
>>
>> Use arch_get_random_seed_long_early() instead of arm64 specific functions
>> to solve the problem. As a side effect of this change, the code no longer
>> bypasses ARCH_RANDOM, which I consider desirable (after all, ARCH_RANDOM
>> was disabled for a reason).
> 
> There's no bypass of ARCH_RANDOM; the bits KASLR depends on are empty
> stubs when ARCH_RANDOM is not selected. I added the common early
> functions after this code was written.
> 
>> Reported-by: Qian Cai <cai@lca.pw>
>> Fixes: 585524081ecd ("random: random.h should include archrandom.h, not the other way around")
> 
> This is where things broke; there was no need to change kaslr.c's
> include of <asm/archrandom.h>, since kaslr.c only depends on the RNDR
> bits defined there./
> 

Problem is that, prior to the above patch, asm/archrandom.h used to include
linux/random.h, which resulted in a recursion. That only worked because
some other include file had already included linux/random.h in kaslr.c.
In v5.7.y, with gcc 7.x and older, that include did not happen, causing
a compile failure.

In file included from ./arch/arm64/include/asm/archrandom.h:9:0,
                 from arch/arm64/kernel/kaslr.c:14:
./include/linux/random.h: In function ‘arch_get_random_seed_long_early’:
./include/linux/random.h:149:9: error: implicit declaration of function ‘arch_get_random_seed_long’

>> Fixes: 2e8e1ea88cbc ("arm64: Use v8.5-RNG entropy for KASLR seed")
> 
> I don't think this tag is necessary; this commit built and worked fine,
> and there wasn't any ARCH_RANDOM bypass to speak of.
> 
>> Cc: Qian Cai <cai@lca.pw>
>> Cc: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> This patch itself looks fine, but as above I think the commit message is
> misleading w.r.t. bypassing ARCH_RANDOM, and the second fixes tag isn't
> necessary.
> 

You are correct. I'll change that and resubmit.

Thanks,
Guenter

> With those bits gone:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.
> 
>> ---
>>  arch/arm64/kernel/kaslr.c | 12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
>> index 9ded4237e1c1..b181e0544b79 100644
>> --- a/arch/arm64/kernel/kaslr.c
>> +++ b/arch/arm64/kernel/kaslr.c
>> @@ -84,6 +84,7 @@ u64 __init kaslr_early_init(u64 dt_phys)
>>  	void *fdt;
>>  	u64 seed, offset, mask, module_range;
>>  	const u8 *cmdline, *str;
>> +	unsigned long raw;
>>  	int size;
>>  
>>  	/*
>> @@ -122,15 +123,12 @@ u64 __init kaslr_early_init(u64 dt_phys)
>>  	}
>>  
>>  	/*
>> -	 * Mix in any entropy obtainable architecturally, open coded
>> -	 * since this runs extremely early.
>> +	 * Mix in any entropy obtainable architecturally if enabled
>> +	 * and supported.
>>  	 */
>> -	if (__early_cpu_has_rndr()) {
>> -		unsigned long raw;
>>  
>> -		if (__arm64_rndr(&raw))
>> -			seed ^= raw;
>> -	}
>> +	if (arch_get_random_seed_long_early(&raw))
>> +		seed ^= raw;
>>  
>>  	if (!seed) {
>>  		kaslr_status = KASLR_DISABLED_NO_SEED;
>> -- 
>> 2.17.1
>>

