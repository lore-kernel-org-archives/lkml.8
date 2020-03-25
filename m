Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B19C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB41F20719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgCYUez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:34:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39182 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgCYUez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:34:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A8C712970B0
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
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <fbd5e95a-59ab-bb51-892e-ddd220b85215@collabora.com>
Date:   Wed, 25 Mar 2020 21:34:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3166e472e0ef5c0db8da3ab7d846b47795e69057.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On 24/3/20 18:20, Srinivas Pandruvada wrote:
> On Tue, 2020-03-24 at 18:08 +0100, Enric Balletbo i Serra wrote:
>> Hi Greg,
>>
>> On 24/3/20 17:49, Greg Kroah-Hartman wrote:
>>> On Tue, Mar 24, 2020 at 05:31:10PM +0100, Enric Balletbo i Serra
>>> wrote:
>>>> Hi Greg,
>>>>
>>>> Many thanks for your quick answer, some comments below.
>>>>
> [...]
> 
>>> Are you sure they aren't already there under
>>> /sys/firmware/acpi/?  I
>>> thought all tables and methods were exported there with no need to
>>> do
>>> anything special.
>>>
>>
>> That's the first I did when I started to forward port this patch from
>> chromeos
>> kernel to mainline.
>>
>> On my system I get:
>>
>> /sys/firmware/acpi/tables#
>> APIC  DSDT  FACP  FACS  HPET  MCFG  SSDT  data  dynamic
>>
>> (data and dynamic are empty directories)
>>
>> I quickly concluded (maybe wrong) that as there is no a MLST entry it
>> was not
>> exported, but maybe one of those already contains the info? Or,
>> should I expect
>> a MLST entry here?
>>
> If the data you are reading doesn't depend on any runtime variable in
> ACPI tables then you can read from firmware tables as is.
> 
> You can download acpica tools and run your method on acpi dump using
> acpiexec tool. Once you can take dump, you can run on any Linux system.
> 
> If you can get what you need from running on the dump, then you can do
> by directly reading from /sys/firmware/acpi/tables/ from user space
> without kernel change. Sometimes it is enough as lots of config data
> tend to be static.
> 

As I said I'm not an ACPI expert, so thanks in advance for your help.

I am trying to look if I can get from userspace the value of the HWID entry
exported from the driver.

$ cat /sys/devices/platform/chromeos_acpi/HWID
SAMUS E25-G7R-W35

Using acpiexec I get the element list of the MLST method, but I don't know how
to get the HWID value.

- evaluate crhw.mlst
Evaluating \CRHW.MLST
Evaluation of \CRHW.MLST returned object 0x55f17a7aed60, external buffer length 158
  [Package] Contains 10 Elements:
    [String] Length 04 = "CHSW"
    [String] Length 04 = "FWID"
    [String] Length 04 = "HWID"
    [String] Length 04 = "FRID"
    [String] Length 04 = "BINF"
    [String] Length 04 = "GPIO"
    [String] Length 04 = "VBNV"
    [String] Length 04 = "VDAT"
    [String] Length 04 = "FMAP"
    [String] Length 04 = "MECK"

Any clue?

Thanks in advance,
Enric


> Thanks,
> Srinivas
> 
> 
> 
> 
> 
> 
>>> What makes these attributes "special" from any other ACPI method?
>>>
>>
>> I can't answer this question right now. I need to investigate more I
>> guess ;-)
>>
>> Thanks again for your answer,
>> Enric
>>
>>>>>> +static int __init chromeos_acpi_init(void)
>>>>>> +{
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	chromeos_acpi.pdev =
>>>>>> platform_device_register_simple("chromeos_acpi",
>>>>>> +						PLATFORM_DEVID_
>>>>>> NONE, NULL, 0);
>>>>>> +	if (IS_ERR(chromeos_acpi.pdev)) {
>>>>>> +		pr_err("unable to register chromeos_acpi
>>>>>> platform device\n");
>>>>>> +		return PTR_ERR(chromeos_acpi.pdev);
>>>>>> +	}
>>>>>
>>>>> Only use platform devices and drivers for things that are
>>>>> actually
>>>>> platform devices and drivers.  That's not what this is, it is
>>>>> an ACPI
>>>>> device and driver.  Don't abuse the platform interface please.
>>>>>
>>>>
>>>> Ok. The purpose was to not break ChromeOS userspace since is
>>>> looking for the
>>>> attributes inside /sys/devices/platform/chromeos_acpi. Not a good
>>>> reason, I
>>>> know, and I assume we will need to change userspace instead, and
>>>> convert this to
>>>> a ACPI device and driver only, right?
>>>
>>> How can any userspace be looking for anything that hasn't been
>>> submitted
>>> before?  That's nothing to worry about, we don't have to support
>>> things
>>> like that :)
>>>
>>>> I'll investigate the different places in userspace where this is
>>>> used and see
>>>> how difficult it is to do the changes.
>>>
>>> Look at /sys/firmware/acpi/ first please.
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
> 
> 
