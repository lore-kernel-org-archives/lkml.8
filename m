Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16613C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83ED20739
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXAMCwQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgGGLnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGLnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:43:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099F3C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:43:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k5so8849043pjg.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ohadtc0L1YoGCqvh2RHLLL9N195SXhq2FPyHHtyTf6I=;
        b=MXAMCwQC8IL27+0vSF5sDoTYe9kbihNM+TeZqy0WH9RI3hH+SYQ9jVN0g6OCodM1sw
         5r20dsooDL0hkjMZe2WtW5bpA4xoShUQPLoTZU+tSHKHwa/1fTkLYm7vWA+lmd7OL+3d
         oFhJHDS3pUCuV07P3UmfJDcaq6ZZlh2rXJfsF1bFXfH4e1lpGbKFtadcaFa532quvoLj
         McwFQeBEfJ3Iugph62liszwuWDG9lDg6vIDqn0d035p5EoijBbKHkEeUlBqAe0IIy5HM
         2KOR34BeAXfhVOrcydaGIWDMNNu5Rck5SBvqcytLvw70T/Mn2PAVh9o56amAGiX4f5IV
         gofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ohadtc0L1YoGCqvh2RHLLL9N195SXhq2FPyHHtyTf6I=;
        b=hQHZogxYCiGsSDFv+2SuyJ2KDQSvydfHIbKenqkaV9eACDCuifZKhWuMCccvUXxrkG
         PaAdAcXnekXeRVgPVtTrf0xlTVibjKRqV8eH3LkPa4wlsUC2vhrVf222PBhXsb+sJQ/Z
         9qouabU0SzaqRVQl8CpCO+TRnBrb+sVULB9zA4JytQ9NdnbhGXjMc5fMGiY5BUfkYxJO
         rFlAMbf130fqW1P6ug3t4IVfIVNIMq90rEODTcYyW7khZ3I03KoKRLRUwg3pKeZkzll5
         tVtThEEcTU64u3luxNwGPnu36QX/GirpqQBr3UBXUxNnBdUCzzcmfKW8XN8EgAiqEMGd
         Lrbg==
X-Gm-Message-State: AOAM5315MYBzuvFRW0Z3j5m5eamau3pBAjWs4o3QeEU9zSihoPjPPNGa
        I1YF8OR16JnKGDi+aarrrC4=
X-Google-Smtp-Source: ABdhPJyuDHicYHOOouJdoIfw6ImZfpUPNRi11nfS3g9x/1Aq5MFh5yUCacafbwTrf61t0Skjc1cAxQ==
X-Received: by 2002:a17:902:40a:: with SMTP id 10mr23417001ple.260.1594122194607;
        Tue, 07 Jul 2020 04:43:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o2sm57891pfh.160.2020.07.07.04.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 04:43:13 -0700 (PDT)
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Convert EC error codes to
 Linux error codes
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
References: <20200704142607.171400-1-linux@roeck-us.net>
 <7fd5528a-017e-d706-8092-8e1d6b187243@collabora.com>
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
Message-ID: <8f9314a2-bd40-4ce0-ca9d-25722c642107@roeck-us.net>
Date:   Tue, 7 Jul 2020 04:43:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7fd5528a-017e-d706-8092-8e1d6b187243@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 3:10 AM, Enric Balletbo i Serra wrote:
> Hi Prashant and Guenter,
> 
> Thank you to spend your time on look at this.
> 
> On 4/7/20 16:26, Guenter Roeck wrote:
>> The EC reports a variety of error codes. Most of those, with the exception
>> of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
>> error code gets lost. Convert all EC errors to Linux error codes to report
>> a more meaningful error to the caller to aid debugging.
>>
>> Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
>> Cc: Prashant Malani <pmalani@chromium.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
> 
> For me the patch looks good as is. Said that, I'd like to discuss a bit more
> (but not too much) about it :-). My "concerns" are:
> 
> - It is not clear to me if some EC errors match directly to a linux kernel error
> codes, the importance of them, and which action should be taken in that case or
> if just reporting is enough.
> 
> - The EC result can be obtained, either, enabling more debug traces or using the
> linux kernel tracing tools. So, IMO mapping _all_ the errors has very little value.
> 
> Right now, the policy I followed is return -EPROTO for all EC errors and
> introduce/match a new error when someone (another kernel driver or userspace
> needs to know about it, i.e [1], where some EC drivers do different actions if
> -ENOTSUPP is returned). We introduced that error because we had a use case for it.
> 
> The future, I'd like to maintain this policy if it makes sense to you. And
> introduce a new error when we have a use case for it. I.e if at some point a
> kernel driver needs to know when the EC is busy (-EBUSY) because the driver
> waits and retries again, I'll be fine to introduce this new error/match code.
> Otherwise, I feel that has no really value.
> 
> Said that, if you still feel, that this will help you for debugging purposes, I
> am completely fine to pick the patch.
> 
> Thoughts?
> 

Yes, I did feel it was useful, error codes are never perfect, it is rarely
possible to enable tracing in situations in which the error that was observed,
and I think it would have been and would be useful (having it would have saved
hours of analysis and debugging time), but not for the cost of spending hours
of argument about it. Please drop.

Guenter
