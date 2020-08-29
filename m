Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20F9C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 15:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 990B5207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 15:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et2Ojn4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgH2PIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 11:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH2PIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 11:08:05 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2D3C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:08:05 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id b9so3326238oiy.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GCqjJubpkghT2AIyQi40Y+N63zR6SKaq4T3Qhf3e3Hg=;
        b=Et2Ojn4hDPJz+Ub9XhEO4HFW1vjyQ+Entu9m1SS54fdlKdgUGT1gTHx7Bbckz09AJK
         lxgP0AXLc4+uLys/0Ejt4IHoR2ZKA/EIa6vMOVILuYmr9csgOUi/ljb69Emy0js7dp6o
         zZ6GSFLyn2b/79IBtNTjGibC5opxDYs+JHYFQZeKWnWPaf4VTRL9quzqZjoYiK7bQlov
         D/w/WVbD0PPdNZ5PfRt9q7KpxaYtBTB9UG4EqwLUfwZF6rUvpCO9ZcHIkhHrrLxa3ZFs
         1KiFT4kXPP8tiofbp5KnwdhucNl4v4HgxlLyS6GIzHEMVr0zJaX9DIe8+RHct/Zaf2Wv
         +uEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GCqjJubpkghT2AIyQi40Y+N63zR6SKaq4T3Qhf3e3Hg=;
        b=WspIH84PTmrYn/nMTNi9+myczcQjmqLNC4kGCV+ebImiGmUbmqUM+EZ1C+cWNyO6cn
         Kv0ElEEzt9xvFCN+i44YAAh5siACDRE1a4K81rQMvGfljheRcTxacO3UEhc2tcbGCGJW
         THk4iDfFfFvvty/rnbIjqagI43Bf55UR99yEFDApvIIK9WwSBtaaZtofW7RMdNqetq8I
         0Zzy3U3mdhGflHMKd5mt+fCAGIi9wib9YUtZUe2YVNkVORmMmPE9KHkkNsCxwn0UMqT1
         tmfUIGTa0qHVeIG1XUugWs1QO9FqdX5Dq6BSlHl+WptVrglrRKT6FsK9kDZBtr23M26p
         wilg==
X-Gm-Message-State: AOAM530gXEFhN7ltv9/8sbf5SzWIrBM0XP1WfwsYCOTV7Acl+eLy27z4
        HilbkE8rm/J2ilMNMaBiwUc=
X-Google-Smtp-Source: ABdhPJzsgMJai4thGJZVrJVmjJ9QnV7cDDthImvEkiC0yAp0yoLuujwr8z7TplVFxX7o/ukS/84PZA==
X-Received: by 2002:a05:6808:204:: with SMTP id l4mr2131952oie.62.1598713684526;
        Sat, 29 Aug 2020 08:08:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x11sm524069oic.57.2020.08.29.08.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 08:08:04 -0700 (PDT)
Subject: Re: [PATCH] dmaengine: fsldma: Do not pass pointers to lower_32_bits
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Wen He <wen.he_1@nxp.com>, Peng Ma <peng.ma@nxp.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20200828071125.GA18772@gondor.apana.org.au>
 <20200829105116.GA246533@roeck-us.net>
 <20200829124535.GA11751@gondor.apana.org.au>
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
Message-ID: <5614461b-02ae-5cb5-cca8-0525ffaacc13@roeck-us.net>
Date:   Sat, 29 Aug 2020 08:08:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200829124535.GA11751@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/20 5:45 AM, Herbert Xu wrote:
> On Sat, Aug 29, 2020 at 03:51:16AM -0700, Guenter Roeck wrote:
>>
>> This patch results in the following compile error when compiling 
>> ppc:mpc85xx_defconfig.
>>
>> Error log:
>> In file included from ./include/linux/list.h:9,
>>                  from ./include/linux/module.h:12,
>>                  from drivers/dma/fsldma.c:23:
>> drivers/dma/fsldma.h: In function 'fsl_ioread64':
>> ./include/linux/kernel.h:189:37: error: invalid operands to binary & (have 'const u64 *' {aka 'const long long unsigned int *'} and 'unsigned int')
>>   189 | #define lower_32_bits(n) ((u32)((n) & 0xffffffff))
>>       |                                     ^
>> drivers/dma/fsldma.h:208:17: note: in expansion of macro 'lower_32_bits'
>>   208 |  u32 fsl_addr = lower_32_bits(addr);
>>       |                 ^~~~~~~~~~~~~
>> drivers/dma/fsldma.h: In function 'fsl_ioread64be':
>> ./include/linux/kernel.h:189:37: error: invalid operands to binary & (have 'const u64 *' {aka 'const long long unsigned int *'} and 'unsigned int')
>>   189 | #define lower_32_bits(n) ((u32)((n) & 0xffffffff))
>>       |                                     ^
>> drivers/dma/fsldma.h:222:17: note: in expansion of macro 'lower_32_bits'
>>   222 |  u32 fsl_addr = lower_32_bits(addr);
>>       |                 ^~~~~~~~~~~~~
>> make[2]: *** [drivers/dma/fsldma.o] Error 1
> 
> Thanks for the report.  Passing a pointer to lower_32_bits is just
> bad.
> 
> ---8<---
> The functions fsl_ioread64* were passing a pointer to lower_32_bits
> which just happened to work because it was a macro that simply did
> a cast on the argument.
> 
> However, now that lower_32_bits does a mask on the argument it no
> longer works.  Passing a pointer to lower_32_bits doesn't look
> right anyway.
> 
> This patch adds explicit casts so that an integer is passed along
> as the argument to lower_32_bits.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Works as well as the other patch.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> 
> diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
> index 56f18ae99233..da5816b1706e 100644
> --- a/drivers/dma/fsldma.h
> +++ b/drivers/dma/fsldma.h
> @@ -205,7 +205,7 @@ struct fsldma_chan {
>  #else
>  static u64 fsl_ioread64(const u64 __iomem *addr)
>  {
> -	u32 fsl_addr = lower_32_bits(addr);
> +	u32 fsl_addr = lower_32_bits((unsigned long)addr);
>  	u64 fsl_addr_hi = (u64)in_le32((u32 *)(fsl_addr + 1)) << 32;
>  
>  	return fsl_addr_hi | in_le32((u32 *)fsl_addr);
> @@ -219,7 +219,7 @@ static void fsl_iowrite64(u64 val, u64 __iomem *addr)
>  
>  static u64 fsl_ioread64be(const u64 __iomem *addr)
>  {
> -	u32 fsl_addr = lower_32_bits(addr);
> +	u32 fsl_addr = lower_32_bits((unsigned long)addr);
>  	u64 fsl_addr_hi = (u64)in_be32((u32 *)fsl_addr) << 32;
>  
>  	return fsl_addr_hi | in_be32((u32 *)(fsl_addr + 1));
> 

