Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BFBC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A9620737
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCYVzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:55:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40080 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 17:55:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9290229408A
Subject: Re: [PATCH v2] platform: x86: Add ACPI driver for ChromeOS
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, vbendeb@chromium.org,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, andy@infradead.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org
References: <20200322094334.1872663-1-enric.balletbo@collabora.com>
 <20200322111022.GA72939@kroah.com>
 <c480f318-c326-d51c-e757-c65c2526ab4d@collabora.com>
 <20200324164956.GE2518746@kroah.com>
 <3444110c-d6c0-16df-9b5d-12578ed442c5@collabora.com>
 <3166e472e0ef5c0db8da3ab7d846b47795e69057.camel@linux.intel.com>
 <fbd5e95a-59ab-bb51-892e-ddd220b85215@collabora.com>
 <51a98cae11de1529bdaa695a0c1eeb2043191b3f.camel@linux.intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e29d6279-d7e3-8164-3f52-5017bfe79436@collabora.com>
Date:   Wed, 25 Mar 2020 22:54:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <51a98cae11de1529bdaa695a0c1eeb2043191b3f.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On 25/3/20 22:41, Srinivas Pandruvada wrote:
> Hi Enric,
> 
> On Wed, 2020-03-25 at 21:34 +0100, Enric Balletbo i Serra wrote:
>> Hi Srinivas,
>>
>> On 24/3/20 18:20, Srinivas Pandruvada wrote:
>>> On Tue, 2020-03-24 at 18:08 +0100, Enric Balletbo i Serra wrote:
>>>> Hi Greg,
>>>>
>>>> On 24/3/20 17:49, Greg Kroah-Hartman wrote:
>>>>> On Tue, Mar 24, 2020 at 05:31:10PM +0100, Enric Balletbo i
>>>>> Serra
>>>>> wrote:
>>>>>> Hi Greg,
>>>>>>
>>>>>> Many thanks for your quick answer, some comments below.
>>>>>>
>>> [...]
>>>
>>>>> Are you sure they aren't already there under
>>>>> /sys/firmware/acpi/?  I
>>>>> thought all tables and methods were exported there with no need
>>>>> to
>>>>> do
>>>>> anything special.
>>>>>
>>>>
>>>> That's the first I did when I started to forward port this patch
>>>> from
>>>> chromeos
>>>> kernel to mainline.
>>>>
>>>> On my system I get:
>>>>
>>>> /sys/firmware/acpi/tables#
>>>> APIC  DSDT  FACP  FACS  HPET  MCFG  SSDT  data  dynamic
>>>>
>>>> (data and dynamic are empty directories)
>>>>
>>>> I quickly concluded (maybe wrong) that as there is no a MLST
>>>> entry it
>>>> was not
>>>> exported, but maybe one of those already contains the info? Or,
>>>> should I expect
>>>> a MLST entry here?
>>>>
>>> If the data you are reading doesn't depend on any runtime variable
>>> in
>>> ACPI tables then you can read from firmware tables as is.
>>>
>>> You can download acpica tools and run your method on acpi dump
>>> using
>>> acpiexec tool. Once you can take dump, you can run on any Linux
>>> system.
>>>
>>> If you can get what you need from running on the dump, then you can
>>> do
>>> by directly reading from /sys/firmware/acpi/tables/ from user space
>>> without kernel change. Sometimes it is enough as lots of config
>>> data
>>> tend to be static.
>>>
>>
>> As I said I'm not an ACPI expert, so thanks in advance for your help.
>>
>> I am trying to look if I can get from userspace the value of the HWID
>> entry
>> exported from the driver.
>>
>> $ cat /sys/devices/platform/chromeos_acpi/HWID
>> SAMUS E25-G7R-W35
>>
>> Using acpiexec I get the element list of the MLST method, but I don't
>> know how
>> to get the HWID value.
>>
>> - evaluate crhw.mlst
>> Evaluating \CRHW.MLST
>> Evaluation of \CRHW.MLST returned object 0x55f17a7aed60, external
>> buffer length 158
>>   [Package] Contains 10 Elements:
>>     [String] Length 04 = "CHSW"
>>     [String] Length 04 = "FWID"
>>     [String] Length 04 = "HWID"
>>     [String] Length 04 = "FRID"
>>     [String] Length 04 = "BINF"
>>     [String] Length 04 = "GPIO"
>>     [String] Length 04 = "VBNV"
>>     [String] Length 04 = "VDAT"
>>     [String] Length 04 = "FMAP"
>>     [String] Length 04 = "MECK"
>>
>> Any clue?
>>
> So I guess your  mlst method gives list of methods you can call.
> So here your can directly evaluate
> 
> - evaluate crhw.HWID
> 

Right, I tried, but that doesn't gives the result I want, for example:

Evaluating \CRHW.HWID
0x1 Outstanding allocations after evaluation of \CRHW.HWID
Evaluation of \CRHW.HWID returned object 0x55b9e373fd60, external buffer length 38
  [Package] Contains 1 Elements:
    [String] Length 00 = ""


I found that the VBTx are addresses setup in the following file.

src/vendorcode/google/chromeos/acpi/gnvs.asl:

VBT0,   32,     // 0x000 - Boot Reason
VBT1,   32,     // 0x004 - Active Main Firmware
VBT2,   32,     // 0x008 - Active EC Firmware
VBT3,   16,     // 0x00c - CHSW
VBT4, 2048,     // 0x00e - HWID
VBT5,  512,     // 0x10e - FWID
VBT6,  512,     // 0x14e - FRID
VBT7,   32,     // 0x18e - active main firmware type
VBT8,   32,     // 0x192 - Recovery Reason
VBT9,   32,     // 0x196 - FMAP base address
CHVD, 24576,    // 0x19a - VDAT space filled by verified boot
VBTA,   32,     // 0xd9a - pointer to smbios FWID
MEHH,  256,     // 0xd9e - Management Engine Hash
RMOB,   32,     // 0xdbe - RAM oops base address
RMOL,   32,     // 0xdc2 - RAM oops length
ROVP,   32,     // 0xdc6 - pointer to RO_VPD
ROVL,   32,     // 0xdca - size of RO_VPD
RWVP,   32,     // 0xdce - pointer to RW_VPD
RWVL,   32,     // 0xdd2 - size of RW_VPD
                // 0xdd6

Can I assume that the info I want is only accessible in runtime and is not
exported via the static tables?

Thanks,
 Enric


> 
> Thanks,
> Srinivas
> 
> 
> 
>> Thanks in advance,
>> Enric
>>
>>
>>> Thanks,
>>> Srinivas
>>>
>>>
>>>
>>>
>>>
>>>
>>>>> What makes these attributes "special" from any other ACPI
>>>>> method?
>>>>>
>>>>
>>>> I can't answer this question right now. I need to investigate
>>>> more I
>>>> guess ;-)
>>>>
>>>> Thanks again for your answer,
>>>> Enric
>>>>
>>>>>>>> +static int __init chromeos_acpi_init(void)
>>>>>>>> +{
>>>>>>>> +	int ret;
>>>>>>>> +
>>>>>>>> +	chromeos_acpi.pdev =
>>>>>>>> platform_device_register_simple("chromeos_acpi",
>>>>>>>> +						PLATFORM_DEVID_
>>>>>>>> NONE, NULL, 0);
>>>>>>>> +	if (IS_ERR(chromeos_acpi.pdev)) {
>>>>>>>> +		pr_err("unable to register chromeos_acpi
>>>>>>>> platform device\n");
>>>>>>>> +		return PTR_ERR(chromeos_acpi.pdev);
>>>>>>>> +	}
>>>>>>>
>>>>>>> Only use platform devices and drivers for things that are
>>>>>>> actually
>>>>>>> platform devices and drivers.  That's not what this is, it
>>>>>>> is
>>>>>>> an ACPI
>>>>>>> device and driver.  Don't abuse the platform interface
>>>>>>> please.
>>>>>>>
>>>>>>
>>>>>> Ok. The purpose was to not break ChromeOS userspace since is
>>>>>> looking for the
>>>>>> attributes inside /sys/devices/platform/chromeos_acpi. Not a
>>>>>> good
>>>>>> reason, I
>>>>>> know, and I assume we will need to change userspace instead,
>>>>>> and
>>>>>> convert this to
>>>>>> a ACPI device and driver only, right?
>>>>>
>>>>> How can any userspace be looking for anything that hasn't been
>>>>> submitted
>>>>> before?  That's nothing to worry about, we don't have to
>>>>> support
>>>>> things
>>>>> like that :)
>>>>>
>>>>>> I'll investigate the different places in userspace where this
>>>>>> is
>>>>>> used and see
>>>>>> how difficult it is to do the changes.
>>>>>
>>>>> Look at /sys/firmware/acpi/ first please.
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>>>
> 
