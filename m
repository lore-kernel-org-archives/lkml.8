Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BD3C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC7C246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQY5q0xM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbgB1E2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:28:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40154 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730802AbgB1E2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:28:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id t24so824084pgj.7;
        Thu, 27 Feb 2020 20:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:references:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xB59DL08w8Srn0sPbs6mHd2xqJxzIRIo8yXpOuZzGy0=;
        b=XQY5q0xMc2Sfjt8wYX1Ku7gaANoX7cLqSv65XNIbjaBc+KmDfoIJvXQTmx9XXYAo4Z
         dJ6JjfaYOZLxap/o+S/yEjeYLnnO53OfS32QYyHfAUl4ui/QNTjqa7DZfJuc9jfzOtsu
         PWmT5Wf85fCC80RCHn1w9ynJUhYWyUY7wbByYIaxrYtDtRxUQOwKQd0gNRyxS7wOb4r8
         gBeIFDlmt7M1XfWgV9iSZ2ruyktuWnEaQvBfwy1/TlbjeEJkkKQ5kvMySbt13cjjQg93
         AtXISitkbN/hfc07tSCMmoIwcrAr4Q9lgc4yuU8DTJv6vQTu+UwgCMFVR7HKF78+Ka7X
         N/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xB59DL08w8Srn0sPbs6mHd2xqJxzIRIo8yXpOuZzGy0=;
        b=cIV9ovPfT8HAMxOHDQvT/uij8v9AG83gDZ8CceoPSG5haPQE9CUBpvkI7FFU16mFG1
         cYtK8eBWZJmf6MXtcmm4Vms2256rwK1Kl32YCsdFFBFyGO8asvuSDAlTA/oLWbZdQwkj
         IfmZyvOeFJbOxrGAtXJ5sA0a1t1/RE/4JpQB6Cl3+LN5595hfkGWUkbnDohU/jkHZhkP
         MX+3zvMqtT8bJZxY1EfFC8SUyK2IvS3r+/OI34ygVViUsPPNKkRm7ZrxuVk/B1Ayjca6
         lrV8RziHv0fmQaIvngI6eq3+DMqIkpEV+DKSv0t7LgYT2YbSjJT1UdV1HvSsaFcT87KQ
         SEyA==
X-Gm-Message-State: APjAAAXuJNHzRo+VTcRFOVAqkdLh6ME9ubabSXP43zg8bRcPTlrrg/Z0
        H5WcLDznggIPCOlSR81q7tw=
X-Google-Smtp-Source: APXvYqyfYJl6Jf7HLaZBM8qTUVktZBiHPyDu28vL+NyPs+KrKwmctHDC43tKZzAoF2+8VIl1VDdBIQ==
X-Received: by 2002:a62:1883:: with SMTP id 125mr2476481pfy.166.1582864099588;
        Thu, 27 Feb 2020 20:28:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x6sm8756284pfi.83.2020.02.27.20.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 20:28:18 -0800 (PST)
Subject: Re: [RFT PATCH 1/4] usb: dwc2: Simplify and fix DMA alignment code
From:   Guenter Roeck <linux@roeck-us.net>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QW50dGkgU2VwcMOkbMOk?= <a.seppala@gmail.com>,
        Boris ARZUR <boris@konbu.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Schiller <ms@dev.tdt.de>
References: <20200226210414.28133-1-linux@roeck-us.net>
 <20200226210414.28133-2-linux@roeck-us.net>
 <CAD=FV=WDd4E-zDW73kb-qHo1QYQrD3BTgVpE70rzowpgeXVy7w@mail.gmail.com>
 <ce3357a1-467f-1241-ae0d-2e113116ca8d@roeck-us.net>
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
Message-ID: <f94fc372-d81b-e8e4-e7ef-780fe7db1237@roeck-us.net>
Date:   Thu, 27 Feb 2020 20:28:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ce3357a1-467f-1241-ae0d-2e113116ca8d@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 2:27 PM, Guenter Roeck wrote:
> On 2/27/20 2:06 PM, Doug Anderson wrote:
[ ... ]
>>> -       if (urb->num_sgs || urb->sg ||
>>> -           urb->transfer_buffer_length == 0 ||
>>> +       if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0 ||
>>> +           (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP) ||
>>>             !((uintptr_t)urb->transfer_buffer & (DWC2_USB_DMA_ALIGN - 1)))
>>
>> Maybe I'm misunderstanding things, but it feels like we need something
>> more here.  Specifically I'm worried about the fact when the transfer
>> buffer is already aligned but the length is not a multiple of the
>> endpoint's maximum transfer size.  You need to handle that, right?
>> AKA something like this (untested):
>>
>> /* Simple case of not having to allocate a bounce buffer */
>> if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0 ||
>>     (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP))
>>   return 0;
>>
>> /* Can also avoid bounce buffer if alignment and size are good */
>> maxp = usb_endpoint_maxp(&ep->desc);
>> if (maxp == urb->transfer_buffer_length &&
> 
> No, transfer_buffer_length would have to be a multiple of maxp. There
> are many situations where roundup(transfer_buffer_length, maxp) !=
> transfer_buffer_length. I agree, this would be the prudent approach
> (and it was my original implementation), but then it didn't seem to
> cause trouble so far, and I was hesitant to add it in because it results
> in creating temporary buffers for almost every receive operation.
> I'd like to get some test feedback from Boris - if the current code
> causes crashes with his use case, we'll know that it is needed.
> Otherwise, we'll have to decide if the current approach (with fewer
> copies) is worth the risk, or if we want to play save and always
> copy if roundup(transfer_buffer_length, maxp) != transfer_buffer_length.
> 

Thinking more about this, the situation is actually much worse:
In Boris' testing, he found inbound transactions requested by usb
storage code with a requested transfer size of 13 bytes ... with
URB_NO_TRANSFER_DMA_MAP set. This means the requesting code has
provided a DMA ready buffer, transfer_buffer isn't even used,
and we can not reallocate it. In this situation we can just hope
that the chip (and the connected USB device) don't send more data
than requested.

With that in mind, I think we should stick with the current
scheme (ie only allocate a new buffer if the provided buffer is
unaligned) unless Boris comes back and tells us that it doesn't
work.

Thanks,
Guenter
