Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245D4C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E374A24672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCOwlCJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgBGIcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:32:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53379 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgBGIcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581064323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5PxoGF4lW28Wv4+q/wL0t8wnMQQso1jdOdEBv/C2U8=;
        b=DCOwlCJ6KQhTMY6SALHwV7gEGM6qjDDMM+S1ITsRNxNWT5RSRLGriacLHJ6Q/1IQwBA9N7
        VuO3a4mX7Nh9RX4hbX5eRHIinPuFO9+zV/loaroVg2pxXoTYK08F4NVlvnrIYENv5L2vsi
        iWvPe4NAbACTPFqro3T4awjAUGUxFTE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-7TlktVEEMFCj7hMm-O04BA-1; Fri, 07 Feb 2020 03:32:02 -0500
X-MC-Unique: 7TlktVEEMFCj7hMm-O04BA-1
Received: by mail-wm1-f72.google.com with SMTP id b133so441226wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 00:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h5PxoGF4lW28Wv4+q/wL0t8wnMQQso1jdOdEBv/C2U8=;
        b=DS1dAuibp3XEFB6FJf2OuMMy6ifyvS8P2igPuCnrdvhydFWSW90fstLTITH8ummiU7
         rKBw4nUYT8s9TprUokN/WsYbaz0NUTKOKj2B8hcXq4IDVrHFInksSgSGU9V4mC/U1/ky
         7kfvApRHueDo+zRGeZehYlLo2vL2A9THwO7qL0VAuCS2wmrhNvMrEn4D+sKUBPMo/l8Z
         s5QfOwNOnm/qOGCHKbP/03A9fC3fB50IqKuCU8PYB8iOgHVWQzGEIAU5q7TSH4sWHOAz
         zdPFkuFAPwqtCVGQnpTjEM5xktGTZBuQaWMhTrOrKt0byvO/T9IEApetggq5uaqdqToj
         UG/A==
X-Gm-Message-State: APjAAAVLQ5rn4J3SnMoPnaLtBUVp2ou+QgJSZkoF0uM94LxLYWmS+jwQ
        GRvyVzS8t3r2Bw6fMNZ27iwG5MibuVDUh1AEi/9nVSOf965GM2gkRj+Rf0nRq+8G0XGUSJjMFUt
        YLk5sY6Mh5CGpwlEXQb1EenD3
X-Received: by 2002:a5d:5283:: with SMTP id c3mr3434108wrv.148.1581064321176;
        Fri, 07 Feb 2020 00:32:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvVIpbfaRt4igrDmgOFpT6SET1fiC7v1wNzmTDIH5FVWwod2izKvg3ymP0O9zwHuWYdtuxQA==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr3434065wrv.148.1581064320898;
        Fri, 07 Feb 2020 00:32:00 -0800 (PST)
Received: from x1.localdomain ([109.36.130.245])
        by smtp.gmail.com with ESMTPSA id q1sm2513114wrw.5.2020.02.07.00.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 00:32:00 -0800 (PST)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 3/3] x86/tsc_msr: Make MSR derived TSC frequency more
 accurate
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Vipul Kumar <vipulk0511@gmail.com>,
        Vipul Kumar <vipul_kumar@mentor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        Len Brown <len.brown@intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>
References: <20200205153428.437087-1-hdegoede@redhat.com>
 <20200205153428.437087-4-hdegoede@redhat.com>
 <CAHp75Vfc=LN+_iDLDZ2s-i-q6tZ-K_FV7hqAcH6fhwBA9-AHUQ@mail.gmail.com>
Message-ID: <b6c1e57e-8001-19f1-7f37-7a5975e565d6@redhat.com>
Date:   Fri, 7 Feb 2020 09:31:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfc=LN+_iDLDZ2s-i-q6tZ-K_FV7hqAcH6fhwBA9-AHUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 2/5/20 5:59 PM, Andy Shevchenko wrote:
> On Wed, Feb 5, 2020 at 5:34 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> The "Intel 64 and IA-32 Architectures Software Developer’s Manual
>> Volume 4: Model-Specific Registers" has the following table for the
>> values from freq_desc_byt:
>>
>>     000B: 083.3 MHz
>>     001B: 100.0 MHz
>>     010B: 133.3 MHz
>>     011B: 116.7 MHz
>>     100B: 080.0 MHz
>>
>> Notice how for e.g the 83.3 MHz value there are 3 significant digits,
>> which translates to an accuracy of a 1000 ppm, where as your typical
>> crystal oscillator is 20 - 100 ppm, so the accuracy of the frequency
>> format used in the Software Developer’s Manual is not really helpful.
>>
>> As far as we know Bay Trail SoCs use a 25 MHz crystal and Cherry Trail
>> uses a 19.2 MHz crystal, the crystal is the source clk for a root PLL
>> which outputs 1600 and 100 MHz. It is unclear if the root PLL outputs are
>> used directly by the CPU clock PLL or if there is another PLL in between.
>>
>> This does not matter though, we can model the chain of PLLs as a single
>> PLL with a quotient equal to the quotients of all PLLs in the chain
>> multiplied.
>>
>> So we can create a simplified model of the CPU clock setup using a
>> reference clock of 100 MHz plus a quotient which gets us as close to the
>> frequency from the SDM as possible.
>>
>> For the 83.3 MHz example from above this would give us 100 MHz * 5 / 6 =
>> 83 and 1/3 MHz, which matches exactly what has been measured on actual hw.
>>
>> This commit makes the tsc_msr.c code use a simplified PLL model with a
>> reference clock of 100 MHz for all Bay and Cherry Trail models.
>>
>> This has been tested on the following models:
>>
>>                CPU freq before:        CPU freq after this commit:
>> Intel N2840   2165.800 MHz            2166.667 MHz
>> Intel Z3736   1332.800 MHz            1333.333 MHz
>> Intel Z3775   1466.300 MHz            1466.667 MHz
>> Intel Z8350   1440.000 MHz            1440.000 MHz
>> Intel Z8750   1600.000 MHz            1600.000 MHz
>>
>> This fixes the time drifting by about 1 second per hour (20 - 30 seconds
>> per day) on (some) devices which rely on the tsc_msr.c code to determine
>> the TSC frequency.
> 
> Thanks for this effort!
> 
> ...
> 
>> +#define REFERENCE_KHZ 100000
> 
> Perhaps TSC_REFERENCE_KHZ ?

Ok, changed to TSC_REFERENCE_KHZ for v3

> 
> ...
> 
>> +       struct {
>> +               u32 multiplier;
>> +               u32 divider;
>> +       } pairs[MAX_NUM_FREQS];
> 
> Perhaps pairs -> muldiv ?

Ok, changed to muldiv for v3

> 
> ...
> 
>> +       .pairs = { {  5,  6 }, { 1,  1 }, { 4, 3 }, { 7, 6 }, { 4, 5 },
>> +                  { 14, 15 }, { 9, 10 }, { 8, 9 }, { 7, 8 } },
> 
> Maybe 4 per line or alike (8 per line) for better understanding which
> muldiv maps to which value?

Ok, changed for v3.

> 
> ...
> 
>> +       .pairs = { { 0, 0 }, { 1, 1 }, { 4, 3 } },
> 
> And maybe list all of them always? (I'm fine with either approach).

I prefer to just list the valid ones.

> 
> ...
> 
>> +/* 24 MHz crystal? : 24 * 13 / 4 = 78 MHz */
> 
> Perhaps Cc to LGM SoC developers team (they did it recently, so, they
> have to know).

Ok, I've added the following people to the Cc for v3 based on the Sob-s and Cc-s of:
0cc5359d8fd45bc("x86/cpu: Update init data for new Airmont CPU model"):

Cc: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Gayatri Kammela <gayatri.kammela@intel.com>


> ...
> 
>> +       if (freq_desc->pairs[index].divider) {
> 
>> +               freq = DIV_ROUND_CLOSEST(REFERENCE_KHZ *
>> +                                           freq_desc->pairs[index].multiplier,
>> +                                        freq_desc->pairs[index].divider);
> 
> Maybe helper?
> 
>> +               /* Multiply by ratio before the divide for better accuracy */
>> +               res = DIV_ROUND_CLOSEST(REFERENCE_KHZ *
>> +                                           freq_desc->pairs[index].multiplier *
>> +                                           ratio,
>> +                                       freq_desc->pairs[index].divider);
> 
> ...which may be used here as well.

Nah, I would prefer to keep this as is. I'm never a fan of single line
helpers they just make it harder to see what the code is actually doing.

Regards,

Hans

