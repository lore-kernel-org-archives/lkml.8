Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD3CC33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A768C20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgBEJGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:06:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50466 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgBEJGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:06:22 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DF1EB2756E6
Subject: Re: [PATCH v6] platform/chrome: cros_ec: Query EC protocol version if
 EC transitions between RO/RW
To:     Gwendal Grignou <gwendal@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Yicheng Li <yichengli@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Evan Green <evgreen@chromium.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <CGME20200204073034eucas1p1592fa2436b5567c2d15cf2935c3a8804@eucas1p1.samsung.com>
 <20200203225356.203946-1-yichengli@chromium.org>
 <54cbade6-c552-4877-a8d7-d2be9930cefd@samsung.com>
 <CAPUE2uvYc2MMW+QMNCqaMT897-_OSf=Ho4g42jKdKBT++6i+KA@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <bf68ebe7-15df-392c-3796-8ef8ad86d13a@collabora.com>
Date:   Wed, 5 Feb 2020 10:06:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAPUE2uvYc2MMW+QMNCqaMT897-_OSf=Ho4g42jKdKBT++6i+KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/2/20 21:40, Gwendal Grignou wrote:
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> 
> On Mon, Feb 3, 2020 at 11:30 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>>
>> Hi
>>
>> On 03.02.2020 23:53, Yicheng Li wrote:
>>> RO and RW of EC may have different EC protocol version. If EC transitions
>>> between RO and RW, but AP does not reboot (this is true for fingerprint
>>> microcontroller / cros_fp, but not true for main ec / cros_ec), the AP
>>> still uses the protocol version queried before transition, which can
>>> cause problems. In the case of fingerprint microcontroller, this causes
>>> AP to send the wrong version of EC_CMD_GET_NEXT_EVENT to RO in the
>>> interrupt handler, which in turn prevents RO to clear the interrupt
>>> line to AP, in an infinite loop.
>>>
>>> Once an EC_HOST_EVENT_INTERFACE_READY is received, we know that there
>>> might have been a transition between RO and RW, so re-query the protocol.
>>>
>>> Signed-off-by: Yicheng Li <yichengli@chromium.org>
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>> Works fine on Samsung Exynos-based Chromebooks: Snow, Peach-Pit and
>> Peach-Pi.
>>

Thanks, we will pick this patch once 5.6-rc1 is out. For my own reference:

Acked-for-chrome-platform: Enric Balletbo i Serra <enric.balletbo@collabora.com>


>>> ---
>>> Hi Enric and Marek,
>>>
>>>> This patch landed recently in linux-next as commit
>>>> 241a69ae8ea8e2defec751fe55dac1287aa044b8. Sadly, it causes following
>>>> kernel oops on any key press on Samsung Exynos-based Chromebooks (Snow,
>>>> Peach-Pit and Peach-Pi):
>>>
>>>> Many thanks for report the issue, we will take a look ASAP and revert
>>>> this commit meanwhile.
>>>
>>>> Simply removing the BUG_ON() from cros_ec_get_host_event() function
>>>> fixes the issue, but I don't know the protocol details to judge if this
>>>> is the correct way of fixing it.
>>> The issue was those Samsung Chromebooks (Snow, Peach-Pit and Peach-Pi)
>>> do not support mkbp events, yet we applied the same thing to them, which
>>> we shouldn't. This v6 should fix it: I Just added a check
>>>
>>>       if (ec_dev->mkbp_event_supported)
>>>
>>> in cros_ec_register().
>>>
>>>
>>>
>>> drivers/platform/chrome/cros_ec.c           | 29 +++++++++++++++++++++
>>>   include/linux/platform_data/cros_ec_proto.h |  3 +++
>>>   2 files changed, 32 insertions(+)
>>>
>>> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
>>> index 9b2d07422e17..f16804db805b 100644
>>> --- a/drivers/platform/chrome/cros_ec.c
>>> +++ b/drivers/platform/chrome/cros_ec.c
>>> @@ -104,6 +104,23 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>>>       return ret;
>>>   }
>>>
>>> +static int cros_ec_ready_event(struct notifier_block *nb,
>>> +     unsigned long queued_during_suspend, void *_notify)
>>> +{
>>> +     struct cros_ec_device *ec_dev = container_of(nb, struct cros_ec_device,
>>> +                                                  notifier_ready);
>>> +     u32 host_event = cros_ec_get_host_event(ec_dev);
>>> +
>>> +     if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_INTERFACE_READY)) {
>>> +             mutex_lock(&ec_dev->lock);
>>> +             cros_ec_query_all(ec_dev);
>>> +             mutex_unlock(&ec_dev->lock);
>>> +             return NOTIFY_OK;
>>> +     }
>>> +
>>> +     return NOTIFY_DONE;
>>> +}
>>> +
>>>   /**
>>>    * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
>>>    * @ec_dev: Device to register.
>>> @@ -201,6 +218,18 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>>               dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
>>>                       err);
>>>
>>> +     if (ec_dev->mkbp_event_supported) {
>>> +             /*
>>> +              * Register the notifier for EC_HOST_EVENT_INTERFACE_READY
>>> +              * event.
>>> +              */
>>> +             ec_dev->notifier_ready.notifier_call = cros_ec_ready_event;
>>> +             err = blocking_notifier_chain_register(
>>> +                     &ec_dev->event_notifier, &ec_dev->notifier_ready);
>>> +             if (err)
>>> +                     return err;
>>> +     }
>>> +
>>>       dev_info(dev, "Chrome EC device registered\n");
>>>
>>>       return 0;
>>> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
>>> index 0d4e4aaed37a..a1c545c464e7 100644
>>> --- a/include/linux/platform_data/cros_ec_proto.h
>>> +++ b/include/linux/platform_data/cros_ec_proto.h
>>> @@ -121,6 +121,8 @@ struct cros_ec_command {
>>>    * @event_data: Raw payload transferred with the MKBP event.
>>>    * @event_size: Size in bytes of the event data.
>>>    * @host_event_wake_mask: Mask of host events that cause wake from suspend.
>>> + * @notifier_ready: The notifier_block to let the kernel re-query EC
>>> + *      communication protocol when the EC sends EC_HOST_EVENT_INTERFACE_READY.
>>>    * @ec: The platform_device used by the mfd driver to interface with the
>>>    *      main EC.
>>>    * @pd: The platform_device used by the mfd driver to interface with the
>>> @@ -161,6 +163,7 @@ struct cros_ec_device {
>>>       int event_size;
>>>       u32 host_event_wake_mask;
>>>       u32 last_resume_result;
>>> +     struct notifier_block notifier_ready;
>>>
>>>       /* The platform devices used by the mfd driver */
>>>       struct platform_device *ec;
>>
>> Best regards
>> --
>> Marek Szyprowski, PhD
>> Samsung R&D Institute Poland
>>
