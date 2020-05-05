Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9318BC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D61A20757
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgEEUgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:36:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45884 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgEEUgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:36:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DE4D62A1A91
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Handle NULL EC pointer
 during probe.
To:     Daniil Lunev <dlunev@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200428110253.1.I926f6741079cafb04ecb592130aef75b24ad31ae@changeid>
 <c57b0892-d68d-f0f2-3cc1-b8549983227e@collabora.com>
 <CAONX=-dLVBpz+p1si4cWGHEmQ_toO8kW=fCPcdUuX2KLc-o=2A@mail.gmail.com>
 <CAONX=-dDWjMQDGncSgXNf86Bt3C5OUtFqh=Pe2HToGPSv5qa4A@mail.gmail.com>
 <CACeCKacoEjQm0_VfZGYNEZVhKubPyqspNZupQk+7piJOsVzH+Q@mail.gmail.com>
 <fc7901ff-9e67-d6d5-f084-70233fd8344c@collabora.com>
 <CACeCKafnrMk_=Udg-roEbrkDzZe6m3mUk14OOVVROmn-agfpDA@mail.gmail.com>
 <CAONX=-cR0H2zrGEunwq2k3g+d=9asmeu39ssFN31yFs6i-wktQ@mail.gmail.com>
 <20200501005609.GA131713@google.com>
 <CAONX=-fs_4zA4DGxcoRTod+amjVgSdAaQ-CQ4wsC7J9=fnm6Zw@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <d5369956-aca4-2c40-3300-d86151847bbc@collabora.com>
Date:   Tue, 5 May 2020 22:36:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAONX=-fs_4zA4DGxcoRTod+amjVgSdAaQ-CQ4wsC7J9=fnm6Zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 1/5/20 5:22, Daniil Lunev wrote:
> Hi Prashant,
> I do not think it is present. Thinking about it, I do not think it
> shall be an issue on any released device as it will have either a
> firmware which wouldn't even trigger the typec probe or the one after
> the hierarchy fix. Likely I just got a firmware which was somewhere in
> between those two (As I did some unrelated FW testing). So, yes,
> probably putting this upstream is not necessary, though IMO more
> sanity checks - especially on non-critical run-once paths - are always
> better than having a kernel panic lingering around the corner, not
> like I am insisting on pushing the patch though with all the info, up
> to Enric.

I'd prefer to not push the patch. If at some point this is starts of being
possible we will catch soon.

Thank you,
 Enric

> Cheers,
> Daniil
> 
> On Fri, May 1, 2020 at 10:56 AM Prashant Malani <pmalani@chromium.org> wrote:
>>
>> Hi Daniil,
>>
>> On Fri, May 01, 2020 at 10:15:18AM +1000, Daniil Lunev wrote:
>>> On the official revision of coreboot for hatch it doesn't even try to
>>> load Type C. However it gives some warning messages from
>>> cros-usbpd-notify-acpi about EC, So I wonder why the check of the same
>>> type is not appropriate in the typec driver?
>>
>> I think the difference is that GOOG0003 is already present on shipped /
>> official versions of coreboot (so not having that check can cause
>> existing release images/devices to crash), whereas for GOOG0014 that is / isn't the case.
>>
>> Is GOOG0014 present on the official release coreboot image for this
>> device? If so, what's its path (/sys/bus/acpi/devices/<HID>/path) ?
>>
>> Best regards,
>>
>> -Prashant
>>>
>>> ../chrome/cros_usbpd_notify.c
>>>
>>> /* Get the EC device pointer needed to talk to the EC. */
>>> ec_dev = dev_get_drvdata(dev->parent);
>>> if (!ec_dev) {
>>> /*
>>> * We continue even for older devices which don't have the
>>> * correct device heirarchy, namely, GOOG0003 is a child
>>> * of GOOG0004.
>>> */
>>> dev_warn(dev, "Couldn't get Chrome EC device pointer.\n");
>>> }
>>>
>>>
>>> # dmesg
>>> ...
>>> [    8.513351] cros-ec-spi spi-PRP0001:02: EC failed to respond in time
>>> [    8.722072] cros-ec-spi spi-PRP0001:02: EC failed to respond in time
>>> [    8.729271] cros-ec-spi spi-PRP0001:02: Cannot identify the EC: error -110
>>> [    8.736966] cros-ec-spi spi-PRP0001:02: cannot register EC,
>>> fallback to spidev
>>> [    8.767017] cros_ec_lpcs GOOG0004:00: Chrome EC device registered
>>> [    8.807537] cros-usbpd-notify-acpi GOOG0003:00: Couldn't get Chrome
>>> EC device pointer.
>>> ...
>>>
>>> On Fri, May 1, 2020 at 2:17 AM Prashant Malani <pmalani@chromium.org> wrote:
>>>>
>>>> Hi Enric,
>>>>
>>>> On Thu, Apr 30, 2020 at 8:26 AM Enric Balletbo i Serra
>>>> <enric.balletbo@collabora.com> wrote:
>>>>>
>>>>> Hi Prashant,
>>>>>
>>>>> On 30/4/20 2:43, Prashant Malani wrote:
>>>>>> On Wed, Apr 29, 2020 at 5:38 PM Daniil Lunev <dlunev@chromium.org> wrote:
>>>>>>>
>>>>>>> [to make it appear on the mailing list as I didn't realize I was in
>>>>>>> hypertext sending mode]
>>>>>>>
>>>>>>> On Thu, Apr 30, 2020 at 10:11 AM Daniil Lunev <dlunev@chromium.org> wrote:
>>>>>>>>
>>>>>>>> Hi Enric.
>>>>>>>> I encountered the issue on a Hatch device when trying running 5.4 kernel on that. After talking to Prashant it seems that any device with coreboot built before a certain point (a particular fix for device hierarchy in ACPI tables of Chrome devices which happened in mid-April) will not be able to correctly initialize the driver and will get a kernel panic trying to do so.
>>>>>>
>>>>>> A clarifying detail here: This should not be seen in any current
>>>>>> *production* device. No prod device firmware will carry the erroneous
>>>>>> ACPI device entry.
>>>>>>
>>>>>
>>>>> Thanks for the clarification. Then, I don't think we need to upstream this. This
>>>>> kind of "defensive-programming" it's not something that should matter to upstream.
>>>>
>>>> Actually, on second thought, I am not 100% sure about this:
>>>> Daniil, is the erroneous ACPI device on a *production* firmware for
>>>> this device (I'm not sure about the vintage of that device's BIOS)?
>>>>
>>>> My apologies for the confusion, Enric and Daniil; but would be good to
>>>> get clarification from Daniil.
>>>>
>>>> Best regards,
>>>>>
>>>>> Thanks,
>>>>>  Enric
>>>>>
>>>>>
>>>>>>>> Thanks,
>>>>>>>> Daniil
>>>>>>>>
>>>>>>>> On Thu, Apr 30, 2020 at 7:58 AM Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi Daniil,
>>>>>>>>>
>>>>>>>>> Thank you for the patch.
>>>>>>>>>
>>>>>>>>> On 28/4/20 3:02, Daniil Lunev wrote:
>>>>>>>>>> Missing EC in device hierarchy causes NULL pointer to be returned to the
>>>>>>>>>> probe function which leads to NULL pointer dereference when trying to
>>>>>>>>>> send a command to the EC. This can be the case if the device is missing
>>>>>>>>>> or incorrectly configured in the firmware blob. Even if the situation
>>>>>>>>>
>>>>>>>>> There is any production device with a buggy firmware outside? Or this is just
>>>>>>>>> for defensive programming while developing the firmware? Which device is
>>>>>>>>> affected for this issue?
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>  Enric
>>>>>>>>>
>>>>>>>>>> occures, the driver shall not cause a kernel panic as the condition is
>>>>>>>>>> not critical for the system functions.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>>  drivers/platform/chrome/cros_ec_typec.c | 5 +++++
>>>>>>>>>>  1 file changed, 5 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
>>>>>>>>>> index 874269c07073..30d99c930445 100644
>>>>>>>>>> --- a/drivers/platform/chrome/cros_ec_typec.c
>>>>>>>>>> +++ b/drivers/platform/chrome/cros_ec_typec.c
>>>>>>>>>> @@ -301,6 +301,11 @@ static int cros_typec_probe(struct platform_device *pdev)
>>>>>>>>>>
>>>>>>>>>>       typec->dev = dev;
>>>>>>>>>>       typec->ec = dev_get_drvdata(pdev->dev.parent);
>>>>>>>>>> +     if (!typec->ec) {
>>>>>>>>>> +             dev_err(dev, "Failed to get Cros EC data\n");
>>>>>>>>>> +             return -EINVAL;
>>>>>>>>>> +     }
>>>>>>>>>> +
>>>>>>>>>>       platform_set_drvdata(pdev, typec);
>>>>>>>>>>
>>>>>>>>>>       ret = cros_typec_get_cmd_version(typec);
>>>>>>>>>>
