Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BA0C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 15:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BE62469C
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 15:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL/jHkXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgB2PZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 10:25:38 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39600 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgB2PZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 10:25:38 -0500
Received: by mail-pj1-f67.google.com with SMTP id e9so2543565pjr.4;
        Sat, 29 Feb 2020 07:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oWrAaer+jeLQgcQWbGCQJwuaqeq6OO/I3Zd84T5q56o=;
        b=NL/jHkXG7aUFDXrMgL3Xc6JcIDK1o+YfOsAMMgeIMXEGZp5enuL/8+lVEYl0kO3Uxq
         Ajgyggnv9q06TYOm8kdnQ68ob/nMY060hi4UflkLcQ+TEKTIndcfQgiT1HK1dfd4X6SJ
         qeuBCL0HeRFHv9oXCgKv+P9DEf+XRJCjGeaBkxf9xMHlGPC/SM3wf5qcklJesbVAJycR
         T4+T/kmHJLIUdLeP7gzrOTQ4XlvLAkolro2JnAmRBLGEoRwQit49G4jgc+kT11HQ0zlj
         t7xwYxj92U4BJQ6HzqR9zfKRmMkAZNP+VWDN2ICe4G9ZzNX0nl74sgGyZDMW3TvOD05D
         iuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oWrAaer+jeLQgcQWbGCQJwuaqeq6OO/I3Zd84T5q56o=;
        b=EbEKXkn10TT1rySoM9+A2vGqOrJqY8WctRWj4OAiZEWjNe/8PTPuYDr580j4MC+Gca
         gS8FFCTsDyK7vMPnn69HBgr2TcbcppV7QVCi74r+C0VaE3nOeGQBUkAJr4w7/dEZ+n3s
         xzgkkGAtskhlhq7kWOt1CcF0PnqR3iQmTKbT8Oh4W6b7+kIC3Luz2N6ABdH7jfaEuNMj
         nDyvDSTTy5uRybNE1IAMk0MSx6TQa6e8YFZmzwQqmaOmwTdEWi/xN4eY0EnonBB+wmVw
         i9J3wDJxLYhcPlnav7FBQ4ERApLNDt1FcUAlw5PTyMPDdrNenzUcTIp/8peBZeazj0vd
         2z2Q==
X-Gm-Message-State: APjAAAWypWmO0P4/GyS1hjfH5sj+atDwaDW+zrvAtBd+ELeESHOONwBN
        5D6ZOpHAqRyl7QyO8+GOdW4=
X-Google-Smtp-Source: APXvYqyI0j609n1qJwlCR7aoffYhC1HJNqbNQnbMSWAEXC0uXYAUvi8H4veoSHZYEgiaEqKHI+CTdg==
X-Received: by 2002:a17:90b:30c9:: with SMTP id hi9mr10476474pjb.81.1582989936204;
        Sat, 29 Feb 2020 07:25:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y193sm12293860pgd.87.2020.02.29.07.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 07:25:35 -0800 (PST)
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
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <62d81632-4a6f-b2d8-e420-b58fb6c9d044@roeck-us.net>
Date:   Sat, 29 Feb 2020 07:25:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKv9HNbugeO0E5w8PsN-EpgHBtAjOYZppkUz1u0a5Ue6k20GwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/20 11:46 PM, Antti Seppälä wrote:
> On Fri, 28 Feb 2020 at 19:59, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Fri, Feb 28, 2020 at 08:14:35AM -0800, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Thu, Feb 27, 2020 at 8:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 2/27/20 2:27 PM, Guenter Roeck wrote:
>>>>> On 2/27/20 2:06 PM, Doug Anderson wrote:
>>>> [ ... ]
>>>>>>> -       if (urb->num_sgs || urb->sg ||
>>>>>>> -           urb->transfer_buffer_length == 0 ||
>>>>>>> +       if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0 ||
>>>>>>> +           (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP) ||
>>>>>>>             !((uintptr_t)urb->transfer_buffer & (DWC2_USB_DMA_ALIGN - 1)))
>>>>>>
>>>>>> Maybe I'm misunderstanding things, but it feels like we need something
>>>>>> more here.  Specifically I'm worried about the fact when the transfer
>>>>>> buffer is already aligned but the length is not a multiple of the
>>>>>> endpoint's maximum transfer size.  You need to handle that, right?
>>>>>> AKA something like this (untested):
>>>>>>
>>>>>> /* Simple case of not having to allocate a bounce buffer */
>>>>>> if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0 ||
>>>>>>     (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP))
>>>>>>   return 0;
>>>>>>
>>>>>> /* Can also avoid bounce buffer if alignment and size are good */
>>>>>> maxp = usb_endpoint_maxp(&ep->desc);
>>>>>> if (maxp == urb->transfer_buffer_length &&
>>>>>
>>>>> No, transfer_buffer_length would have to be a multiple of maxp. There
>>>>> are many situations where roundup(transfer_buffer_length, maxp) !=
>>>>> transfer_buffer_length. I agree, this would be the prudent approach
>>>>> (and it was my original implementation), but then it didn't seem to
>>>>> cause trouble so far, and I was hesitant to add it in because it results
>>>>> in creating temporary buffers for almost every receive operation.
>>>>> I'd like to get some test feedback from Boris - if the current code
>>>>> causes crashes with his use case, we'll know that it is needed.
>>>>> Otherwise, we'll have to decide if the current approach (with fewer
>>>>> copies) is worth the risk, or if we want to play save and always
>>>>> copy if roundup(transfer_buffer_length, maxp) != transfer_buffer_length.
>>>>>
>>>>
>>>> Thinking more about this, the situation is actually much worse:
>>>> In Boris' testing, he found inbound transactions requested by usb
>>>> storage code with a requested transfer size of 13 bytes ... with
>>>> URB_NO_TRANSFER_DMA_MAP set. This means the requesting code has
>>>> provided a DMA ready buffer, transfer_buffer isn't even used,
>>>> and we can not reallocate it. In this situation we can just hope
>>>> that the chip (and the connected USB device) don't send more data
>>>> than requested.
>>>>
>>>> With that in mind, I think we should stick with the current
>>>> scheme (ie only allocate a new buffer if the provided buffer is
>>>> unaligned) unless Boris comes back and tells us that it doesn't
>>>> work.
>>>
>>> I dunno.  I'd rather see correctness over performance.  Certainly we'd
>>> only need to do the extra bounce buffer for input buffers at least.
>>>
>>> Although I don't love the idea, is this something where we want to
>>> introduce a config option (either runtime or through KConfig),
>>> something like:
>>>
>>> CONFIG_DWC2_FAST_AND_LOOSE - Avoid bounce buffers and thus run faster
>>> at the risk of a bad USB device being able to clobber some of your
>>> memory.  Only do this if you really care about speed and have some
>>> trust in the USB devices connected to your system.
>>>
>>
>> I understand your point. Unfortunately that would only work if the driver
>> doesn't set URB_NO_TRANSFER_DMA_MAP.
>>
>> $ git grep "=.*URB_NO_TRANSFER_DMA_MAP" | wc
>>     115     498   10104
>>
>> isn't exactly reassuring - a quick checks suggests that almost 50%
>> of USB drivers set this flag.
>>
>> So all we'd really accomplish is to give people a false sense of
>> security.
>>
>> In this context, I did play around with configuring the real receive
>> buffer size (ie in my reproducer 1522 instead of 1536). If I do that,
>> reading the HCTSIZ register after the transfer reports 0x7fff2
>> (or -14 = 1522-1536 if I treat the value as signed) as actual transfer
>> size. Maybe that would be an option, if properly handled, but who knows
>> what the IP actually does in this case, and what it does on other
>> implementations (not rk3288).
>>
>> Guenter
> 
> Hi Guenter.
> 
> I decided to give your patch-set a spin on my Lantiq device and I'm
> sorry to report that I'm now experiencing a complete crash of the
> kernel due to unaligned access if I try to do usb transfers:
> 
> Unhandled kernel unaligned access[#1]:
> CPU: 1 PID: 3149 Comm: sh Not tainted 5.6-rc3 #0
> task: 87db2580 task.stack: 868c6000
> $ 0   : 00000000 00000001 00000000 81125088
> $ 4   : 8064ffc4 00000001 00000001 2a624a29
> $ 8   : 00000c43 00000c42 80010770 00000000
> $12   : 7f801be8 77fac2a0 00000022 00000000
> $16   : 87c02300 014000c0 87d1ddc0 00000000
> $20   : 87db2580 00000000 00000000 00000000
> $24   : 00000000 77f5fbcc
> $28   : 868c6000 868c7e00 00000000 800347b0
> Hi    : 0000001b
> Lo    : 0000005b
> epc   : 8012d278 kmem_cache_alloc+0x128/0x17c
> ra    : 800347b0 copy_process.part.94+0xd8/0x1690
> Status: 1100c303 KERNEL EXL IE
> Cause : 00800010 (ExcCode 04)
> BadVA : 2a624a29
> PrId  : 00019556 (MIPS 34Kc)
> Modules linked in: ath9k ath9k_common option ath9k_hw ath10k_pci
> ath10k_core ath usb_wwan qmi_wwan pppoe nf_conntrack_ipv6 mac80211
> iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp
> xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack
> xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD usbserial
> usbnet ums_usbat ums_sddr55 ums_sddr09 ums_karma ums_jumpshot
> ums_isd200 ums_freecom ums_datafab ums_cypress ums_alauda pppox
> ppp_async owl_loader nf_reject_ipv4 nf_nat_redirect
> nf_nat_masquerade_ipv4 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat
> nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6
> nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack ltq_deu_vr9
> iptable_mangle iptable_filter ip_tables crc_ccitt compat cdc_wdm
> drv_dsl_cpe_api drv_mei_cpe nf_log_ipv6 nf_log_common
>  ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables
> nf_reject_ipv6 pppoatm ppp_generic slhc br2684 atm drv_ifxos
> usb_storage dwc2 sd_mod scsi_mod gpio_button_hotplug mii
> Process sh (pid: 3149, threadinfo=868c6000, task=87db2580, tls=77fadefc)
> Stack : 80657098 00000100 77fa6db0 00000000 00000012 00000012 ffffffff 800347b0
>         80650000 8013906c 87c02c00 8012d9fc 00000000 00000000 00000020 807b0000
>         879f1148 00000001 868c7e98 804f6018 00000000 801391a8 868c7ef0 80153258
>         00000000 00000001 864f62a0 00000020 864f62b8 80044818 00000400 8015fe94
>         00000003 00000005 00000012 00000000 7f801be0 00430871 00000000 77fac000
>         ...
> Call Trace:
> [<8012d278>] kmem_cache_alloc+0x128/0x17c
> [<800347b0>] copy_process.part.94+0xd8/0x1690
> [<80035f00>] _do_fork+0xe4/0x3bc
> [<80036238>] sys_fork+0x24/0x30
> [<8001c438>] syscall_common+0x34/0x58
> Code: 00000000  8e020014  00e23821 <8ce20000> 10000009  cc400000
> 1040ffbd  00000000  8e060010
> 
> ---[ end trace 3d8df00f1a0d123c ]---
> 
> 
> Don't be fooled by the Call Trace, the stack unwinder is most likely
> totally confused due to memory corruption.
> 
> The culprit is the first patch in the series that does not align DMA
> carefully enough. Apparently these big endian MIPS devices are very
> picky on how that is supposed to be handled.
> 

Sigh. It would have been too simple. Too bad I can't test myself.
I'd like to know if this is because URB_NO_TRANSFER_DMA_MAP is set on a
transfer, or because the beginning of the buffer indeed needs to be aligned
to the DMA cache line size on that system. In the latter case, the question
is why the alignment to DWC2_USB_DMA_ALIGN (=4) works. In the former case,
question would be why the realignment does any good in the first place.

Any chance you can add some test code to help figuring out what exactly
goes wrong ?

Thanks,
Guenter

> Couple of years ago mips people even contemplated on adding warn_on to
> kernel to yell at driver authors who do not align their DMA properly.
> [1.]
> That patch explanation actually served as an inspiration for commit
> 56406e017a88 in the first place.
> 
> [1.] https://www.linux-mips.org/archives/linux-mips/2016-11/msg00267.html
> 

