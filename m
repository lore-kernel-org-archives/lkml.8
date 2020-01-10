Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D93C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 02:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99CB2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 02:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkilQI0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbgAJCkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 21:40:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45014 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730764AbgAJCkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 21:40:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id w127so572087qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 18:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gMOkNt0vJimzzzMgeT7qen11eRZ+jCW/fpAjWtkibTQ=;
        b=HkilQI0kFg6ySq2t4TeaEa45vrSHzdlMy0ybzBEjzlnEAyWPXVNcr2xmz49L4emkoL
         dH5K+qArrbHfPpoBNWGNdGkU/JYitedobyGHDsVP7tIhAZx41iiMIBhvW+FTVr71tc8M
         2NHRCwxrlPeHTaLEiyEFs4MA1sxp9if0+FR2Nd0ud1Vh5h/ZZeJekVlL26It00QmfJ9S
         F9IYt/HRK1rNkpl8acBxvLxGMR/wyQk8lx2QDcOWxq2tlfYnSn7DOGGswaOjOM/HMoge
         NzLvPu+R9tACq6Lbk3Pz4th1WL9xijPn8khbb5y48A6t/vCYW85M8qmweiHOJ0vGeTOQ
         0t7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gMOkNt0vJimzzzMgeT7qen11eRZ+jCW/fpAjWtkibTQ=;
        b=Cm0dP67LQ7cJ7XBf8Y5BVNGRS2J2ReRerfktwzZQU1PYik4WbQxM8YfptYt4KsrzTh
         bvPW01nTt9+iAzCIL2fHVJGe4Ykl31Wi2eiTSlGoPnCRCHgor/nmlOYkuCIYYVQMHN+7
         lNNoejSfhcfvwcTRJZycIAzGFsNRRZcf9oQv6ikzeoeoN/6e6XX3dA5bkclikmiCfAwX
         4a770yQziXbY/xdPXkXw6YBNuXvAtRUfLLppTVzuE5EzViOpyBYIj2qYoQ3t8spRC6kL
         PrQPeSYoy3Glc4HtfuJRS3m5XIVc1lDdwTGivRQcTwwVXVPjeqhuH8x2qDKq5UXpfFnT
         kD6w==
X-Gm-Message-State: APjAAAXXIevNNvrA4cjDQOIPz5APNvKwoRB6ZaOxeRv3oowkU3+8Wynu
        cXM5NJgKGQ/D9605w/QamA==
X-Google-Smtp-Source: APXvYqwZ6dp9PAx8htATOFuetG2+KPIPqwe2qy8vRzBTVuQJrZKJXFc5UDyAXUydBDCXIUnW7IThqA==
X-Received: by 2002:a05:620a:138d:: with SMTP id k13mr949604qki.239.1578624051907;
        Thu, 09 Jan 2020 18:40:51 -0800 (PST)
Received: from [120.7.1.38] ([184.175.21.212])
        by smtp.gmail.com with ESMTPSA id l49sm315887qtk.7.2020.01.09.18.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2020 18:40:51 -0800 (PST)
Subject: Re: Regression in 5.4 kernel on 32-bit Radeon IBM T40
From:   Woody Suwalski <terraluna977@gmail.com>
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     DRI mailing list <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Pavel Machek <pavel@ucw.cz>
References: <400f6ce9-e360-0860-ca2a-fb8bccdcdc9b@gmail.com>
 <20200109141436.GA22111@lst.de>
 <9ad75215-3ff1-ee76-9985-12fd78d6aa5f@amd.com>
 <67f60d13-a245-5561-1372-7d68f35969f3@gmail.com>
Message-ID: <66a6b0ea-4ee8-1a0d-b259-568059d54e09@gmail.com>
Date:   Thu, 9 Jan 2020 21:40:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101 Firefox/52.0
 SeaMonkey/2.49.5
MIME-Version: 1.0
In-Reply-To: <67f60d13-a245-5561-1372-7d68f35969f3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Woody Suwalski wrote:
> Christian König wrote:
>> Hi Christoph,
>>
>> Am 09.01.20 um 15:14 schrieb Christoph Hellwig:
>>> Hi Woody,
>>>
>>> sorry for the late reply, I've been off to a vacation over the 
>>> holidays.
>>>
>>> On Sat, Dec 14, 2019 at 10:17:15PM -0500, Woody Suwalski wrote:
>>>> Regression in 5.4 kernel on 32-bit Radeon IBM T40
>>>> triggered by
>>>> commit 33b3ad3788aba846fc8b9a065fe2685a0b64f713
>>>> Author: Christoph Hellwig <hch@lst.de>
>>>> Date:   Thu Aug 15 09:27:00 2019 +0200
>>>>
>>>> Howdy,
>>>> The above patch has triggered a display problem on IBM Thinkpad 
>>>> T40, where
>>>> the screen is covered with a lots of random short black horizontal 
>>>> lines,
>>>> or distorted letters in X terms.
>>>>
>>>> The culprit seems to be that the dma_get_required_mask() is 
>>>> returning a
>>>> value 0x3fffffff
>>>> which is smaller than dma_get_mask()0xffffffff.That results in
>>>> dma_addressing_limited()==0 in ttm_bo_device(), and using 40-bits dma
>>>> instead of 32-bits.
>>> Which is the intended behavior assuming your system has 1GB of memory.
>>> Does it?
>>
>> Assuming the system doesn't have the 1GB split up somehow crazy over 
>> the address space that should indeed work as intended.
>>
>>>
>>>> If I hardcode "1" as the last parameter to ttm_bo_device_init() in 
>>>> place of
>>>> a call to dma_addressing_limited(),the problem goes away.
>>> I'll need some help from the drm / radeon / TTM maintainers if there 
>>> are
>>> any other side effects from not passing the need_dma32 paramters.
>>> Obviously if the device doesn't have more than 32-bits worth of dram 
>>> and
>>> no DMA offset we can't feed unaddressable memory to the device.
>>> Unfortunately I have a very hard time following the implementation of
>>> the TTM pool if it does anything else in this case.
>>
>> The only other thing which comes to mind is using huge pages. Can you 
>> try a kernel with CONFIG_TRANSPARENT_HUGEPAGE disabled?
>>
>> Thanks,
>> Christian.
>
> Happy New Year :-)
>
> Yes, the box has 1G of RAM, and unfortunately nope, 
> TRANSPARENT_HUGEPAGE is not on. I am attaching the .config, maybe you 
> can find some insanity there... Also - for reference - a minimalistic 
> patch fixing symptoms (but not addressing the root cause  :-( )
>
> I can try to rebuild the kernel with HIGHMEM off, although I am not 
> optimistic it will change anything. But at least it should simplify 
> the 1G split...
>
> So if you have any other ideas - pls let me know..
>
> Thanks, Woody
>
Interesting. Rebuilding the kernel with HIMEM disabled actually solves 
the display problem. The debug lines show exactly same values for 
dma_get_required_mask() and dma_get_mask(), yet now it works OK... So 
what has solved it???

Woody

