Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4B2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D30D20748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xay7Fv9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgEUOqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgEUOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:46:07 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CD5C061A0E;
        Thu, 21 May 2020 07:46:07 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f21so277345pgg.12;
        Thu, 21 May 2020 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IuI0lrqA6XghbekyOiqEc/YXNp+qvYrREMAKxImJOeE=;
        b=Xay7Fv9T8tZKUc3h+lXHrnlVvtVNIuOHcu+NLaivOf62M8a1DPPqa/drYrPjkMLCEC
         7hzocSGikSayHdHrbeMQihX6Dlsa6N8RvPPU35XB1s2uGzsA89fNB0xv4kKq8vYEJ8MF
         1YawEWWcteixfU9qmBGqM96P2HmAGLbcUSW68cUcROBQ2OHVrWWkB741O8VtbUTNQyF9
         ICiY8YnKq3IgLPcR4VXQdlVMbf8y8GGlb8BIfAvh4i5q8w/7L7McP9YfwfWib/2i6RVE
         DsC+UZurdSwbPg8VfpwfFbMWdMmcDsEYonnn2A0v2kbzSD+TW6uYl0dVM3k0LHNgvCeM
         U06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IuI0lrqA6XghbekyOiqEc/YXNp+qvYrREMAKxImJOeE=;
        b=k7fYxD6jW9cU0fAGdqI2wr7pDpCQn6bLRfZfOO7nuUH1zn43eWpQmPriFmMK3JvSbb
         1TjfTt+la7ODsBRPVZ2tpHDeY+ucdCNCqM5NRH/7BaUx0/276Sag3x3NYPNuQTJcLyT/
         XJjZXZO0vNZEL9uiMWkTNaZ+ZK1+IyRJVODo5uNeS0r7i9NvmgjOEupH9OtfrVapfl9S
         vE1GqFOdC0Orm8yQFv888vhTj39914wqz1PTocIBic+ar2gBaYmQotBf2S9wbSxY7J3y
         +akvAXhKyMneneM85zB6+OT3WoFO3IBEIRgnYtvBEzudqc5mPRP46HRtLQS9VpsRmW0K
         A8Fg==
X-Gm-Message-State: AOAM533z0UGJ6NqzpPk/lo323LgTOAm7Bl+7kEEEzoQ1Uwt7S7woKy+c
        JfOsqs7uQPE9/xVrskDvHXz0p0c0
X-Google-Smtp-Source: ABdhPJw77feXumH0bTrpKFYq3048M6A7Ag5pSl1tHnPZ7bhTTFpZUT5P5Cjvq/438uTEHHPd8u7pUg==
X-Received: by 2002:a65:6715:: with SMTP id u21mr9635597pgf.365.1590072366354;
        Thu, 21 May 2020 07:46:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ep10sm2999825pjb.25.2020.05.21.07.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 07:46:05 -0700 (PDT)
Subject: Re: [PATCH] csky: Fixup calltrace panic
To:     Guo Ren <ren_guo@c-sky.com>,
        =?UTF-8?B?556/5LuZ5re8?= <xianmiao_qu@c-sky.com>,
        =?UTF-8?B?5bCa5LqR5rW3?= <yunhai_shang@c-sky.com>
Cc:     Guo Ren <guoren@linux.alibaba.com>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200517175220.GA48379@roeck-us.net>
 <D93AFA5B-3BF1-4E11-B278-22E980C3EE36@c-sky.com>
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
Message-ID: <45e1a784-f8fe-5f17-45ca-3eb5453d4bb4@roeck-us.net>
Date:   Thu, 21 May 2020 07:46:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <D93AFA5B-3BF1-4E11-B278-22E980C3EE36@c-sky.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 12:50 AM, Guo Ren wrote:
> Hi Guenter,
> 
>> 在 2020年5月18日，上午1:52，Guenter Roeck <linux@roeck-us.net> 写道：
>>
>> Hi,
>>
>> On Wed, May 13, 2020 at 03:15:25PM +0800, Guo Ren wrote:
>>> The implementation of show_stack will panic with wrong fp:
>>>
>>> addr    = *fp++;
>>>
>>> because the fp isn't checked properly.
>>>
>>> The current implementations of show_stack, wchan and stack_trace
>>> haven't been designed properly, so just deprecate them.
>>>
>>> This patch is a reference to riscv's way, all codes are modified from
>>> arm's. The patch is passed with:
>>>
>>> - cat /proc/<pid>/stack
>>> - cat /proc/<pid>/wchan
>>> - echo c > /proc/sysrq-trigger
>>>
>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>
>> This patch results in:
>>
>> gcc version: csky-linux-gcc (GCC) 9.3.0
>>
>> Building csky:defconfig ... failed
>> --------------
>> Error log:
>> csky-linux-gcc: error: unrecognized command line option '-mbacktrace'; did you mean '-fbacktrace'?
>> csky-linux-gcc: error: unrecognized command line option '-mbacktrace'; did you mean '-fbacktrace'?
>> make[2]: *** [scripts/mod/devicetable-offsets.s] Error 1
>> make[2]: *** Waiting for unfinished jobs....
>> csky-linux-gcc: error: unrecognized command line option '-mbacktrace'; did you mean '-fbacktrace'?
>> make[2]: *** [scripts/mod/empty.o] Error 1
>> make[1]: *** [prepare0] Error 2
>> make: *** [sub-make] Error 2
>>
>> when trying to build csky images with upstream gcc 9.3.0.
>>
>> What version of gcc is needed to build csky images ? Also, would it be
>> possible to support the upstream version of gcc ?
>>
> 
> We tested it with https://github.com/c-sky/gcc (gcc-6.3)
> 

That won't work for me. You really might want to consider
supporting upstream gcc. I'll try disabling CONFIG_STACKTRACE
for csky build tests. If that doesn't work, I may have to
disable affected csky build tests for the time being.

Guenter
