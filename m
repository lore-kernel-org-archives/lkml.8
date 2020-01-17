Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B027CC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90ACD2464B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgAQWsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:48:52 -0500
Received: from smtp1.savana.cz ([217.16.187.42]:29538 "EHLO icewarp.savana.cz"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728852AbgAQWsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:48:51 -0500
Received: from [192.168.0.106] ([212.37.87.11])
        by icewarp.savana.cz (IceWarp 11.2.1.1 RHEL6 x64) with ASMTP (SSL) id 202001172348481734;
        Fri, 17 Jan 2020 23:48:48 +0100
Subject: Re: [RFT PATCH 0/4] hwmon: k10temp driver improvements
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
References: <20200116141800.9828-1-linux@roeck-us.net>
 <e452614a-5425-e77c-4e2f-2a17ca733b7f@sda1.eu>
 <20200117184617.GD13396@roeck-us.net>
From:   =?UTF-8?Q?Ondrej_=c4=8cerman?= <ocerman@sda1.eu>
Message-ID: <5b4f8b92-d2ad-4eba-cd4f-4d0fddf92a52@sda1.eu>
Date:   Fri, 17 Jan 2020 23:48:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200117184617.GD13396@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dňa 17. 1. 2020 o 19:46 Guenter Roeck napísal(a):
> On Fri, Jan 17, 2020 at 10:46:25AM +0100, Ondrej Čerman wrote:
>> Dňa 16. 1. 2020 o 15:17 Guenter Roeck napísal(a):
>>> This patch series implements various improvements for the k10temp driver.
>>>
>>> Patch 1/4 introduces the use of bit operations.
>>>
>>> Patch 2/4 converts the driver to use the devm_hwmon_device_register_with_info
>>> API. This not only simplifies the code and reduces its size, it also
>>> makes the code easier to maintain and enhance.
>>>
>>> Patch 3/4 adds support for reporting Core Complex Die (CCD) temperatures
>>> on Ryzen 3 (Zen2) CPUs.
>>>
>>> Patch 4/4 adds support for reporting core and SoC current and voltage
>>> information on Ryzen CPUs.
>>>
>>> With all patches in place, output on Ryzen 3900 CPUs looks as follows
>>> (with the system under load).
>>>
>>> k10temp-pci-00c3
>>> Adapter: PCI adapter
>>> Vcore:        +1.36 V
>>> Vsoc:         +1.18 V
>>> Tdie:         +86.8°C  (high = +70.0°C)
>>> Tctl:         +86.8°C
>>> Tccd1:        +80.0°C
>>> Tccd2:        +81.8°C
>>> Icore:       +44.14 A
>>> Isoc:        +13.83 A
>>>
>>> The patch series has only been tested with Ryzen 3900 CPUs. Further test
>>> coverage will be necessary before the changes can be applied to the Linux
>>> kernel.
>>>
>> Hello everyone, I am the author of https://github.com/ocerman/zenpower/ .
>>
>> It is nice to see this merged.
>>
>> I just want to warn you that there have been reported issues with
>> Threadripper CPUs to zenpower issue tracker. Also I think that no-one tested
>> EPYC CPUs.
>>
>> Most of the stuff I was able to figure out by trial-and-error approach and
>> unfortunately because I do not own any Threadripper CPU I was not able to
>> test and fix reported problems.
>>
> Thanks a lot for the note. The key problem seems to be that Threadripper
> doesn't report SoC current and voltage. Is that correct ? If so, that
> should be easy to solve.

Hello,

I thought that initially, but I was wrong. It seems like that these 
multi-node CPUs are reporting SOC and Core voltage/current data at 
particular node. Look at this HWiNFO64 screenshot of 2990WX for 
reference: https://i.imgur.com/yM9X5nd.jpg . They also may be using 
different addresses and/or factors.

> On a side note, drivers/gpu/drm/amd/include/asic_reg/thm/thm_10_0_offset.h
> suggests that two more temperature sensors might be available at 0x0005995C
> and 0x00059960 (DIE3_TEMP and SW_TEMP). Have you ever tried that ?
>
> Thanks,
> Guenter

I was aware of 0005995c and I thought that it could be Tdie3 (that's why 
I have included it in debug output, someone already shared that 3960X is 
reporting data on that address). I think this one can be safely included.

I was not aware of the other address, I will try it.

Ondrej.

