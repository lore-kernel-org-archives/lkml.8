Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB241C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 17:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A60A2468A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 17:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWdVHETP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCARNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 12:13:36 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51694 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgCARNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 12:13:35 -0500
Received: by mail-pj1-f67.google.com with SMTP id fa20so3395068pjb.1;
        Sun, 01 Mar 2020 09:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QF8QmRyf6dwW5QCdyss9EsW25WHFrHI0jJ5KlIw2iDY=;
        b=KWdVHETPWB4+DY5T5jIS1A2T5KjQELIoAlQSrtH21Logzw6+vLNOjPsLiaL4qNwInJ
         Rs79Xv0cgpSLDlYOiGkStL6nFeWXqutJ3tpWAwCiCZCQ62+UVAbqfgbrNvnVOUxTjDTW
         tW8FylBczeEmQ2oVuB0lBU5qbRvWWlSE7CQjf347ZmB5Cwosdj47svbgEayLmjIKDu1N
         4jjMZr4WfYuJnH13q+4joUZD/ZVYUEZSkKIGor6myjkUwA4npAY2Pdg6hUdmQu8fS8/U
         SNeCZq+8TPf2quzy2de9lAyOaouuFbIdCQLzsJbbGqvzXGWaV6yRMBiqoKEl8IHpLR/z
         dSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QF8QmRyf6dwW5QCdyss9EsW25WHFrHI0jJ5KlIw2iDY=;
        b=JyV1afNHVIA8o9aZ2XN/W8N2yv0ehFiftZd+TElHyUuuEhTswyR+/TD/k3Xsob6xAg
         3S6WnoPeWjazA4ZaAz/1ootIG26BpoNURJdN6sDPq6J0SlAdhBdl8rnUCdWosi/vhUQS
         OkNiqQJxx5FAdEU4QBz7LBcaXrTOIqOoOV3xL4NaL/wi3Tt8gMQYju3bipDUK3iW41ge
         Mmc/zZeP/xLs3tbIZ1yClxQCzjG7c4u9WTljKkVjfAlvFMiMKtKC7JZx+rSFeKEBs4zu
         vbus4o5WRm2P5hk7dqfXWd14R//jV7y3edIU4bGcBfRIji5UFeW56RF2vvljcZDj++TC
         UZgA==
X-Gm-Message-State: APjAAAUFIgUWmHkaAcl93mCuOvciGEzEP4yKddcNN+Xjp5tUBGypV70y
        nBVL7Ju6IRq89nxmUffsOCY=
X-Google-Smtp-Source: APXvYqxwgFWJBi2HK3joj08gKj7O0LBU5NkDsxLUKL4fSqpReTb0lpcKPMKLSYpe7163abBV9GFwcQ==
X-Received: by 2002:a17:902:8ec9:: with SMTP id x9mr14010520plo.182.1583082814141;
        Sun, 01 Mar 2020 09:13:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v9sm8966937pja.26.2020.03.01.09.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 09:13:33 -0800 (PST)
Subject: Re: [RFT PATCH 1/4] usb: dwc2: Simplify and fix DMA alignment code
To:     =?UTF-8?B?QW50dGkgU2VwcMOkbMOk?= <a.seppala@gmail.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Boris ARZUR <boris@konbu.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Schiller <ms@dev.tdt.de>
References: <20200226210414.28133-1-linux@roeck-us.net>
 <20200226210414.28133-2-linux@roeck-us.net>
 <CAD=FV=WDd4E-zDW73kb-qHo1QYQrD3BTgVpE70rzowpgeXVy7w@mail.gmail.com>
 <ce3357a1-467f-1241-ae0d-2e113116ca8d@roeck-us.net>
 <f94fc372-d81b-e8e4-e7ef-780fe7db1237@roeck-us.net>
 <CAD=FV=VNsOo--1x+pkwhWOWSGAQyVB6g6CE+o4q7phPSXaDXRw@mail.gmail.com>
 <20200228175905.GB3188@roeck-us.net>
 <CAKv9HNbugeO0E5w8PsN-EpgHBtAjOYZppkUz1u0a5Ue6k20GwQ@mail.gmail.com>
 <62d81632-4a6f-b2d8-e420-b58fb6c9d044@roeck-us.net>
 <CAKv9HNax9bK-60Gkv3ovZDAS_xVEQa95-J_9WKoEkifqa0u9+A@mail.gmail.com>
 <CAKv9HNaPJFE5if2th5gqAu+_ncPrfGHVS-sJ67Zy8jao1tJZvg@mail.gmail.com>
 <28e29bb7-b536-dd0f-d410-f4add6b2a9ab@roeck-us.net>
 <CAKv9HNZjWKS1thKZ84FwYabHr-o2Q-T9xc4V2Oz6NtiuogQfRQ@mail.gmail.com>
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
Message-ID: <e5c43e32-98b9-df49-5208-66f5440185dc@roeck-us.net>
Date:   Sun, 1 Mar 2020 09:13:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKv9HNZjWKS1thKZ84FwYabHr-o2Q-T9xc4V2Oz6NtiuogQfRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/20 8:51 AM, Antti Seppälä wrote:
> On Sun, 1 Mar 2020 at 18:24, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi Antti,
>>
>> On 3/1/20 7:51 AM, Antti Seppälä wrote:
>>> On Sat, 29 Feb 2020 at 18:33, Antti Seppälä <a.seppala@gmail.com> wrote:
>>>>
>>>> On Sat, 29 Feb 2020 at 17:25, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>
>>>>> Sigh. It would have been too simple. Too bad I can't test myself.
>>>>> I'd like to know if this is because URB_NO_TRANSFER_DMA_MAP is set on a
>>>>> transfer, or because the beginning of the buffer indeed needs to be aligned
>>>>> to the DMA cache line size on that system. In the latter case, the question
>>>>> is why the alignment to DWC2_USB_DMA_ALIGN (=4) works. In the former case,
>>>>> question would be why the realignment does any good in the first place.
>>>>>
>>>>> Any chance you can add some test code to help figuring out what exactly
>>>>> goes wrong ?
>>>>>
>>>>
>>>> Sure, I can try to help. Just let me know what code you would like to
>>>> insert and where and I'll see what I can do.
>>>>
>>>
>>> So I did some further research on this and it turns out that:
>>>  - URB_NO_TRANSFER_DMA_MAP is not set on the offending transfers so
>>> the issue really is buffer alignment
>>>  - DWC2_USB_DMA_ALIGN=4 "works" because in my limited testcase (usb
>>> 4g-dongle utilized via qmi-wwan) all transfers are unaligned. That is,
>>> every urb->transfer_buffer is misaligned by 2 bytes == unaligned
>>>  - I can fix both issues and thus make the patch work on MIPS by
>>> modifying it like this:
>>>
>>> -#define DWC2_USB_DMA_ALIGN 4
>>> +#define DWC2_USB_DMA_ALIGN dma_get_cache_alignment()
>>>
>>>  struct dma_aligned_buffer {
>>>         void *old_xfer_buffer;
>>> -       u8 data[0];
>>> +       u8 data[0] ____cacheline_aligned;
>>>  };
>>>
>>
>> Thanks for the additional testing. That means that the existing code
>> is already broken, or am I missing something ?
>>
> 
> Yes, I believe the existing code is broken if 4 byte aligned transfers
> occur. I seem to have no easy way to prove that though as none of my
> devices generate those.
> 

I did see this a lot when connecting USB drives. I'll re-test next week
and provide more details. I do have some concern because I also saw
transfers with URB_NO_TRANSFER_DMA_MAP set but transfer_buffer was
not DMA aligned. However, it may well be that the provided DMA buffer
_was_ aligned in that situation. I'll re-test that and let you know.

Thanks,
Guenter
