Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BE2C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA8B206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hsbzerpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgAaSfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:35:05 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52109 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgAaSfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:35:04 -0500
Received: by mail-pj1-f66.google.com with SMTP id fa20so3211002pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 10:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FNldGpprrIjAxOHYn2QBdh/3vnfJwPKJIrrflsH8ktk=;
        b=hsbzerptORvwH0vpSsI3aT6WnhSyW8eB5UvTOaunMXUeuAp4A1xIR9LkZ1+7Ff7gOX
         607Whk+GQ7HxkakQbJkadYinX9feSnm1U+WUG/mRx0TXTfqaPw5Pq7CUyU77WOxZAyiI
         giISpPx79c3tD9tCHcycdtEPH8vWiHIe4mCXi1nvwoG9PZlC4aOKEsZ6eSRX/rgpALA1
         m+6gCkDgb98dw4tJyGGs6Lg2Q7oWI2bxCrzwhPyd3kqyuR5p1FygStRosbAnzNCgvBq7
         iDDUFwsokfSAC8WHurV7KDZcmRrYsDR0eln7nqnDtQ9THJSyHndGlCuQWYlIytQc1cIp
         annA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FNldGpprrIjAxOHYn2QBdh/3vnfJwPKJIrrflsH8ktk=;
        b=AOFjQlSHUsjXbFQ/MUQbmO8lLWj8tK0QW0Q/ZtU0W5HwTqmDPxSmivGNrNTnADn2ni
         XisCpdg0h9x0+/k+hC8yOf/UIuPnwxRxaQtFnZ5nRlRO7q+LwuT8Z3+iv/p9w3hnzNKK
         bC3P4x+vzbbowNA/l07Nis5OpC+0qtx7qSMzSkClV2KsXf1A1nalyugUH/ZF2ml+c2hh
         ujCgSbtvXDGvFLJ0yaQKzzn/c1Stt6XXORkqxVwrup2XRTKJhB5fuNQRsKRkFdF0+k9Z
         wVXDscN/0goNDHcNDM4qrioaC9Af0GKxn7RbzAcifAo9bAb6qWLdzfDc5wRLZ+/teMhz
         CUvw==
X-Gm-Message-State: APjAAAXVv1GVlhMYBnBKE3Q91rRlgDx+n0cWSh5EgmvJOgjDT/HFwSwV
        R2OaXc66sD9dadTb8ZNj1FFyPg==
X-Google-Smtp-Source: APXvYqwdPLF365VxzERHRMC1i3RDJSmVpWgBA4ceh3RyvNjCl6YYI7K25p/FD6eAG4B1uvL5w0OKlA==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14mr11480948plo.28.1580495703649;
        Fri, 31 Jan 2020 10:35:03 -0800 (PST)
Received: from smuckle.san.corp.google.com ([2620:15c:2d:3:8fbe:ee3b:c81d:238d])
        by smtp.gmail.com with ESMTPSA id t65sm10882061pgb.17.2020.01.31.10.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 10:35:03 -0800 (PST)
Subject: Re: [PATCH] rtc: class: support hctosys from modular RTC drivers
From:   Steve Muckle <smuckle@google.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        kernel-team@android.com
References: <20191106194625.116692-1-smuckle@google.com>
 <20191106231923.GK8309@piout.net>
 <b96f085b-8a0c-7c71-4fde-8af83d49823a@google.com>
 <20191115133627.GT3572@piout.net>
 <e43fd369-f0ad-f8bb-be8a-1a3ca038af44@google.com>
Message-ID: <6c4296e2-b3ab-1aad-6708-78833d24df58@google.com>
Date:   Fri, 31 Jan 2020 10:35:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <e43fd369-f0ad-f8bb-be8a-1a3ca038af44@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/19 12:26 PM, Steve Muckle wrote:
> On 11/15/19 5:36 AM, Alexandre Belloni wrote:
>> On 06/11/2019 15:37:49-0800, Steve Muckle wrote:
>>> On 11/6/19 3:19 PM, Alexandre Belloni wrote:
>>>> On 06/11/2019 11:46:25-0800, Steve Muckle wrote:
>>>>> Due to distribution constraints it may not be possible to statically
>>>>> compile the required RTC driver into the kernel.
>>>>>
>>>>> Expand RTC_HCTOSYS support to cover all RTC devices (statically compiled
>>>>> or not) by checking at the end of RTC device registration whether the
>>>>> time should be synced.
>>>>>
>>>>
>>>> This does not really help distributions because most of them will still
>>>> have "rtc0" hardcoded and rtc0 is often the rtc that shouldn't be used.
>>>
>>> Just for my own edification, why is that? Is rtc0 normally useless on PC for
>>> some reason?
>>>
>>
>> On PC, rtc0 is probably fine which is not the case for other
>> architectures where rtc0 is the SoC RTC and is often not battery backed.
>>
>>> On the platforms I'm working with I believe it can be assured that rtc0 will
>>> be the correct rtc. That doesn't help typical distributions though.
>>>
>>> What about a kernel parameter to optionally override the rtc hctosys device
>>> at runtime?
>>>
>>
>> What about keeping that in userspace instead which is way easier than
>> messing with kernel parameters?
> 
> This should ideally happen before file systems are mounted so I don't
> see many alternatives for communicating which RTC should be used.
> Android uses the kernel command line for userspace parameters as well
> and that's an option but that defeats part of the value of doing it in
> userspace IMO. There's also device tree but I'm not sure this belongs there.
> 
> Hctosys is also saving and restoring the system time on suspend/resume.
> It seems more efficient to me to do this (which happens very frequently
> on an Android device) in the kernel as opposed to in userspace.
> 
> If I set the initial system time from the rtc in userspace but continue
> to rely on the hctosys suspend/resume code, as it stands there will be a
> window after the rtc driver is loaded but before the system time is set
> where if suspend is entered, the correct time in the rtc will be lost.
 >
>>>> Can't you move away from HCTOSYS and do the correct thing in userspace
>>>> instead of the crap hctosys is doing?
>>>
>>> Yes, I just figured it's a small change, and if hctosys can be made to work
>>> might as well use that.
>>
>> The fact is that hctosys is more related to time keeping than it is to
>> the RTC subsytem. It also does a very poor job setting the system time
>> because adding 0.5s is not the smartest thing to do. The rtc granularity
>> is indeed 1 second but is can be very precisely set.
 >
> No argument with that, but millions of devices successfully rely on it
> today. AFAICT this simple patch doesn't make anything worse. Together
> with a change to support a kernel parameter for runtime rtc selection,
> it should allow RTC drivers to be modularized on many systems. Can it be
> adopted as a stopgap measure?

Hi Alexandre, ping...
