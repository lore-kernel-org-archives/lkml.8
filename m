Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E50C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5BCE2075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i81BrwUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgHGSAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGSAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 14:00:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07C3C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 11:00:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 2so1263008pjx.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hbI1AzBY7IyFmecIHT1EI3LpnTtkGjXG2qqKHrE52jQ=;
        b=i81BrwUqlXyFcM23Z5GckfWRCCSTihc/mOgPgpkBXfKjLLkCf3sXehUWzQaBDsVVwF
         EQGYk1aM0SYUkQpqD08EG/njOYj4T9GQO9dtuGFvNQB1naXCJTd2eA38GDp6r+1zYU2U
         uAEJqUhYs3D/X+vBbIPic11M89d6UqNi0say0V7X8CgG4pg7ZKWWI2Xf/HeNwVdLH86N
         AboLYBm+iCDtOy/IlZVOCTs4faTBBiDMAb18TO4loRkwljmgQoQznp0dyzrJuvTyMW2D
         2Leb+Q2AA5dWPYdMY8Vbu4CMdqy09xkptVgtSlsWFOrkvkkenWoLBHhRXsl7Hd8ugT3A
         5YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hbI1AzBY7IyFmecIHT1EI3LpnTtkGjXG2qqKHrE52jQ=;
        b=pHA2JtFTj3W+5VB3a+k7jEdkwsBifmKokYwmv0kNt2RMGfT6KcsJl8UBH2FHSRm722
         NvJMYwfH3ObgE1bePceVKFOOm1fF7iGetsogmuoLqwXB9ByWNszZo0ARX/W1xGuR4m9R
         3q/+dhZLv36B1+FIzA4Mpk9SH3C4dBVNVWzP+Slh+/oX1DGzY2MM+2DyV6NoqB3psCEM
         yIiMO3RAOKdE+J1y9bU50Lj2vgw+wR/Xw0yOFLcjiQaKlvmI/RzZuVvuSWLaqAsGhs2Q
         zTNgaU5unIzt1HiWGsm20j0m2fTnw3BtQ7Vl3XQoIQa7r38LVowLNsC9DJEwUKAfpfQo
         90dQ==
X-Gm-Message-State: AOAM531PwgT3YTcZpqmERVPdRgbT00iCzXwKPMqT65QLPFOosp8ThrlX
        TZTOvwu/QuqsCZkOTlpLy1M=
X-Google-Smtp-Source: ABdhPJxlHcZ3IgWmrFP1H0SKjFlo+NXKQ2rkzlhqBWDGnIHZ/nJpaDg22kxFfV3mwKPMxSCH3kRaVQ==
X-Received: by 2002:a17:90b:1116:: with SMTP id gi22mr15178835pjb.8.1596823253315;
        Fri, 07 Aug 2020 11:00:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a15sm12591014pfo.185.2020.08.07.11.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 11:00:51 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: kaslr: Use standard early random function
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        tytso@mit.edu, Qian Cai <cai@lca.pw>,
        Mark Brown <broonie@kernel.org>
References: <20200807144521.34732-1-linux@roeck-us.net>
 <20200807173513.GR6750@gaia>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <83936870-0aa7-bc0c-46d3-401479f446ee@roeck-us.net>
Date:   Fri, 7 Aug 2020 11:00:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807173513.GR6750@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/20 10:35 AM, Catalin Marinas wrote:
> On Fri, Aug 07, 2020 at 07:45:21AM -0700, Guenter Roeck wrote:
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
>> to solve the problem.
>>
>> Reported-by: Qian Cai <cai@lca.pw>
>> Fixes: 585524081ecd ("random: random.h should include archrandom.h, not the other way around")
>> Cc: Qian Cai <cai@lca.pw>
>> Cc: Mark Brown <broonie@kernel.org>
>> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> Tested-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Linus, could you please pick this up directly? Otherwise, it will wait
> until we reach -rc1 to avoid basing a branch on a random commit.
> 
> (at the moment I can't build Linus' tree at all, fails early with some
> device tree errors)
> 

You either need to revert the dts changes, or you have to pull in
"dt-bindings: agilex: add NAND_X_CLK and NAND_ECC_CLK" from
linux-next to fix that problem. I did the latter to test this patch.
Hopefully the problem resolves itself after the clock tree has been
merged (though -next itself is in pretty bad shape too, so by then
we may see other problems).

Guenter
