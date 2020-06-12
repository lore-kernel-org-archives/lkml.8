Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9E4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74372207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgFLOXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:23:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35550 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgFLOXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:23:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 2BCEC2A55B2
Subject: Re: [PATCH] ARM: exynos: update l2c_aux_mask to fix alert message
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org
References: <b29f34870380093e6268c11d3033033d6def61b7.1585756648.git.guillaume.tucker@collabora.com>
 <20200401163101.GV25745@shell.armlinux.org.uk>
 <35c7cf4b-e6b8-43aa-d934-4a1c2e738372@collabora.com>
 <20200402130352.GY25745@shell.armlinux.org.uk>
 <20200402131143.GZ25745@shell.armlinux.org.uk>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <f2d05128-5188-d9b6-d8f9-8d56fd9d1d5d@collabora.com>
Date:   Fri, 12 Jun 2020 15:23:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200402131143.GZ25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2020 14:11, Russell King - ARM Linux admin wrote:
> On Thu, Apr 02, 2020 at 02:03:52PM +0100, Russell King - ARM Linux admin wrote:
>> On Thu, Apr 02, 2020 at 01:13:24PM +0100, Guillaume Tucker wrote:
>>> On 01/04/2020 17:31, Russell King - ARM Linux admin wrote:
>>>> On Wed, Apr 01, 2020 at 05:08:03PM +0100, Guillaume Tucker wrote:
>>>>> Allow setting the number of cycles for RAM reads in the pl310 cache
>>>>> controller L2 auxiliary control register mask (bits 0-2) since it
>>>>> needs to be changed in software.  This only affects exynos4210 and
>>>>> exynos4412 as they use the pl310 cache controller.
>>>>>
>>>>> With the mask used until now, the following warnings were generated,
>>>>> the 2nd one being a pr_alert():
>>>>>
>>>>>   L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
>>>>>   L2C: platform provided aux values permit register corruption.
>>>>>
>>>>> This latency cycles value has always been set in software in spite of
>>>>> the warnings.  Keep it this way but clear the alert message about
>>>>> register corruption to acknowledge it is a valid thing to do.
>>>>
>>>> This is telling you that you are doing something you should not be
>>>> doing.  The L2C controller should be configured by board firmware
>>>> first and foremost, because if, for example, u-boot makes use of the
>>>> L2 cache, or any other pre-main kernel code (in other words,
>>>> decompressor) the setup of the L2 controller will be wrong.
>>>>
>>>> So, NAK.
>>>
>>> OK thanks, I guess I misinterpreted the meaning of the error
>>> message.  It's really saying that the register value was not the
>>> right one before the kernel tried to change it.  Next step for me
>>> is to look into U-Boot.
>>
>> The message "L2C: platform provided aux values permit register
>> corruption." means that bits are set in both the mask and the value
>> fields.  Since the new value is calculated as:
>>
>> 	old = register value;
>> 	new = old & mask;
>> 	new |= val;
>>
>> If bits are set in both "mask" and "val" for a multi-bit field, the
>> value ending up in the field may not be what is intended.  Consider
>> a 5-bit field set initially to 10101, and the requested value is
>> 01000 with a mask of 11111.  What you end up with is not 01000, but
>> 11101.  Hence, register corruption.  It is not possible to easily
>> tell whether the mask and values refer to a multi-bit field or not,
>> so the mere fact that bits are set in both issues the alert.
>>
>> The message "L2C: platform modifies aux control register ..." means
>> that you're trying to modify the value of the auxiliary control
>> register, which brings with it the problems I stated in my previous
>> email; platform configuration of the L2C must be done by firmware and
>> not the kernel for the reasons I've set out.
> 
> Actually, looking at the values there:
> 
>         .l2c_aux_val    = 0x3c400001,
> -       .l2c_aux_mask   = 0xc20fffff,
> +       .l2c_aux_mask   = 0xc20ffff8,
> 
> Bit 0 is L310_AUX_CTRL_FULL_LINE_ZERO feature bit, which platforms have
> no business fiddling with - it is a Cortex-A9/L2C310 specific feature
> that needs both ends to be configured correctly to work.  The L2C code
> knows this and will deal with it.  So, .l2c_aux_val should drop setting
> bit 0.

Ack, I've just sent a patch to fix that:

  ARM: exynos: clear L310_AUX_CTRL_FULL_LINE_ZERO in default l2c_aux_val

Sorry about the confusion in my first patch, I got mislead with
the TRM of an earlier revision of the L2C-310 when these bits
were used to set the RAM data read latency.  So this all makes
sense to me now with the matching documentation for the hardware.

> It's also setting L310_AUX_CTRL_NS_LOCKDOWN, which the kernel already
> deals with - this bit should be dropped as well.

OK I'll take a look at that and send a separate patch.

Presumably this bit should also be added to the mask to report an
error if the kernel is changing it?

> It's clearing L310_AUX_CTRL_CACHE_REPLACE_RR - this should be setup by
> firmware.

As far as I can tell, L310_AUX_CTRL_CACHE_REPLACE_RR is bit 25
i.e. 0x02000000, which is set in hardware by default and is not
changed by the kernel:

    L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001

Also this bit is already in the mask, and there is no error about
register corruption any more with the patch I sent today.

> For the prefetching, I thought there were DT properties for that.
> Please look at that, and see whether you can eliminate most of the
> .l2c_aux_val field set bits, and the .l2c_aux_mask clear bits.

Ack, it's handled by l2c310_of_parse().  I'll take a look and see
if I can make another patch for that.

Thanks,
Guillaume
