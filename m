Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F1BC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4CA20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCl8qBkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgA2NVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:21:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53125 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726178AbgA2NVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580304105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHGilkpp+hUZzSCfXBMpMSBjmk6ockw/v+19zVgWbgo=;
        b=QCl8qBkYlnElc3r44MxgV6beYC0hDhHhAyXPhSPCGKx7aQxif4pbNRb/sEUiFmj5o9+K39
        zucCvqezpuwe75G0S0DRfTl+hhvmITDKhXd+cCOIhRZ1+gTND557Nem3+rgWp9k663hu7C
        Szu+ozxP2GewsWOjMVf7KqtVPELZyhU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-akkPwz1PNOK8HIbC8ub_CQ-1; Wed, 29 Jan 2020 08:21:43 -0500
X-MC-Unique: akkPwz1PNOK8HIbC8ub_CQ-1
Received: by mail-wm1-f72.google.com with SMTP id b133so2332717wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 05:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WHGilkpp+hUZzSCfXBMpMSBjmk6ockw/v+19zVgWbgo=;
        b=Fxm6OxXtQ7woifRyvkH0tmEhk6Wwbc0KSqmETqqB3roRemDHiAHj0GIhwUtVQbLgIB
         Ax/yqlItDKFSbGEGXtD/UOLgqSWEt0EMiarVO45IIwlmUx44bXBX9gCdt9QerzZfOkr0
         R2gfAE1OjybkI1+5mUP2o4OVtishO4MoCB290BFuUwLYe4mAMozL2jJh3+keG+eCWKBR
         A70hwN6imUfVWa3kuYgh8FTT99njGX9kxTuEcN88T22XoNjBtMP/BjYbtABMhp7bAPCu
         XMeKhzY4mCK1Wa9YJ/RK9YDuDL+wGivstMlnn2MMnx1lVakJ2B+MjLHV4Sw/4psOUOOX
         eR+w==
X-Gm-Message-State: APjAAAW2eTWU+a71OQ/vl/ywkP/Ll9TE6Kg/crvss7wyjYAga98M2AaM
        ST1iF77CXzTb7VcImjKncXEr+TaAYAfAw2gCMLPjvh9EbqtlqziyKXmVibS2wzokKATYZGvHpYk
        5OSZpkaQjYq1d4ZRwdsSFUuj4
X-Received: by 2002:a1c:e28a:: with SMTP id z132mr11301314wmg.157.1580304102600;
        Wed, 29 Jan 2020 05:21:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFZutPjPCzD/xoxb21kD5/5KZhG8jOqQrGmkYgTxfd+wokjo312Z3Y3IfbUkKV3UAJRcguHA==
X-Received: by 2002:a1c:e28a:: with SMTP id z132mr11301291wmg.157.1580304102262;
        Wed, 29 Jan 2020 05:21:42 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id f18sm2803059wrt.75.2020.01.29.05.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 05:21:41 -0800 (PST)
Subject: Re: [v3] x86/tsc: Unset TSC_KNOWN_FREQ and TSC_RELIABLE flags on
 Intel Bay Trail SoC
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     vipul kumar <vipulk0511@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Stable <stable@vger.kernel.org>,
        Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        x86@kernel.org, Len Brown <len.brown@intel.com>,
        Vipul Kumar <vipul_kumar@mentor.com>
References: <CADdC98RJpsvu_zWehNGDDN=W11rD11NSPaodg-zuaXsHuOJYTQ@mail.gmail.com>
 <878slzeeim.fsf@nanos.tec.linutronix.de>
 <CADdC98TE4oNWZyEsqXzr+zJtfdTTOyeeuHqu1u04X_ktLHo-Hg@mail.gmail.com>
 <20200123144108.GU32742@smile.fi.intel.com>
 <df04f43d-8c6d-7602-cb50-535b85cf2aaa@redhat.com>
 <87iml11ccf.fsf@nanos.tec.linutronix.de>
 <c06260e3-bd19-bf3c-89f7-d36bdb9a5b20@redhat.com>
 <87ftg5131x.fsf@nanos.tec.linutronix.de>
 <30d49be8-67ad-6f32-37a8-0cdd26f0852e@redhat.com>
 <87sgjz434v.fsf@nanos.tec.linutronix.de>
 <20200129130350.GD32742@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0d361322-87aa-af48-492c-e8c4983bb35b@redhat.com>
Date:   Wed, 29 Jan 2020 14:21:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129130350.GD32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29-01-2020 14:03, Andy Shevchenko wrote:
> On Tue, Jan 28, 2020 at 11:39:28PM +0100, Thomas Gleixner wrote:
>> Hans de Goede <hdegoede@redhat.com> writes:
>>> Ok, I have been testing this on various devices and I'm pretty sure now
>>> that my initial hunch is correct. The problem is that the accuracy of
>>> the FSB frequency as listed in the Intel docs is not so great:
>>
>> Thanks for doing that.
> 
> +1!
> 
>>> The "Intel 64 and IA-32 Architectures Software Developer’s Manual Volume 4:
>>> Model-Specific Registers" has the following table for the values from
>>> freq_desc_byt:
>>>
>>>      000B: 083.3 MHz
>>>      001B: 100.0 MHz
>>>      010B: 133.3 MHz
>>>      011B: 116.7 MHz
>>>      100B: 080.0 MHz
>>>
>>> Notice how for e.g the 83.3 MHz value there are 3 significant digits,
>>> which translates to an accuracy of a 1000 ppm, where as your typical
>>> crystal oscillator is 20 - 100 ppm, so the accuracy of the frequency
>>> format used in the Software Developer’s Manual is not really helpful.
>>
>> The SDM is not always helpful :)
>>
>>> So the 00 part of 83300 which I'm suggesting to replace with 33 in
>>> essence is not specified and when the tsc_msr.c code was written /
>>> Bay Trail support was added the value from the datasheet was simply
>>> padded with zeros.
>>>
>>> There is already a hint that that likely is not correct in the values
>>> from the Software Developer’s Manual, we have values ending at 3.3,
>>> but also at 6.7, which to me feels like it is 6.66666666666667 rounded
>>> up and thus the 3.3 likely is 3.33333333333333.
>>>
>>> Test 1: Intel(R) Celeron(R) CPU  N2840  @ 2.16GHz"
>>> --------------------------------------------------
>>>
>>> As said I've also ran some tests. The first device I have tested is
>>> a HP stream 11 x360 with an "Intel(R) Celeron(R) CPU  N2840  @ 2.16GHz"
>>> (from /proc/cpuinfo) this is the "laptop' version of Bay Trail rather
>>> then the tablet version, so like Vipul's case I can comment out the 2
>>> lines setting the TSC_KNOWN_FREQ and TSC_RELIABLE flags and get
>>> "Refined TSC clocksource calibration". I've also added the changes with
>>> the extra pr_info calls which you requested. Here is the relevant output
>>> from a kernel with the 2 flags commented out + your pr_info changes,
>>> note I changed the REF_CLOCK format from %x to %d as that seems easier
>>> to interpret to me.
>>>
>>> [    0.000000] MSR_PINFO: 0000060000001a00 -> 26
>>> [    0.000000] MSR_FSBF: 0000000000000000
>>> [    0.000000] REF_CLOCK: 83000
>>> [    0.000000] tsc: Detected 2165.800 MHz processor
>>> [    3.586805] tsc: Refined TSC clocksource calibration: 2166.666 MHz
>>>
>>> And with my suggested change:
>>>
>>> [    0.000000] MSR_PINFO: 0000060000001a00 -> 26
>>> [    0.000000] MSR_FSBF: 0000000000000000
>>> [    0.000000] REF_CLOCK: 83333
>>> [    0.000000] tsc: Detected 2166.658 MHz processor
>>> [    3.587326] tsc: Refined TSC clocksource calibration: 2166.667 MHz
>>>
>>> Note we are still 0.009 MHz of from the refined calibration, so my
>>> suggestion to really fix this would be to change the freqs part
>>> of struct freq_desc to be in Hz rather then KHz and then calculate
>>> res as:
>>>
>>> res = DIV_ROUND_CLOSEST(freq * ratio, 1000); /* res is in KHz */
>>
>> That makes a log of sense.
> 
> ...
> 
>> Looking at the table again:
>>
>>>      000B: 083.3 MHz
>>>      001B: 100.0 MHz
>>>      010B: 133.3 MHz
>>>      011B: 116.7 MHz
>>>      100B: 080.0 MHz
>>
>> I don't know what the crystal frequency of this CPU is, but usually the
>> frequencies are the same accross a SoC family. The E3800 baytrail
>> definitely runs with a 25Mhz crystal.
>>
>> So using 25MHz as crystal frequency;
>>
>> 000:   25 * 20 / 6  =  83.3333
>> 001:   25 *  4 / 1  = 100.0000
>> 010:   25 * 16 / 3  = 133.3333
>> 011:   25 * 28 / 6  = 116.6666
>> 100:   25 * 16 / 5  =  80.0000
>>
>> So the tables for the various SoCs should have the crystal frequency and
>> the multiplier / divider pairs for each step. That makes the math simple
>> and accurate.
> 
> Completely agree here. I used to fix magic tables [1] when product engineers
> considers data in the documentation like carved in stone. So, I'm not surprised
> we have one here.
> 
>> Typical crystal frequencies are 19.2, 24 and 25Mhz.
> 
> Hans, I think Cherrytrail may be affected by this as the others.
> CHT AFAIK uses 19.2MHz xtal.

Are you sure?

The first 5 entries of the CHT MSR_FSB_FREQ documentation exactly
match those of the BYT documentation (which has only 5 entries),
which suggests to me that CHT is also using a 25 MHz crystal.

I can also make the other CHT only frequencies when assuming a 25
MHz crystal, here is a bit from the patch I'm working on for this:

/*
  * Cherry Trail SDM MSR_FSB_FREQ frequencies to PLL settings map:
  * 0000:   25 * 20 /  6  =  83.3333 MHz
  * 0001:   25 *  4 /  1  = 100.0000 MHz
  * 0010:   25 * 16 /  3  = 133.3333 MHz
  * 0011:   25 * 28 /  6  = 116.6667 MHz
  * 0100:   25 * 16 /  5  =  80.0000 MHz
  * 0101:   25 * 56 / 15  =  93.3333 MHz
  * 0110:   25 * 18 /  5  =  90.0000 MHz
  * 0111:   25 * 32 /  9  =  88.8889 MHz
  * 1000:   25 *  7 /  2  =  87.5000 MHz
  */

The only one which is possibly suspicious here is this line:

  * 0111:   25 * 32 /  9  =  88.8889 MHz

The SDM says 88.9 MHz for this one.

Regards,

Hans

