Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33005C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E2D2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgHTBnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 21:43:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48509 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHTBnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 21:43:00 -0400
Received: from [111.196.79.150] (helo=[192.168.0.103])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1k8ZbU-0006l0-8l; Thu, 20 Aug 2020 01:42:56 +0000
Subject: Re: [PATCH] ALSA: usb-audio: Add prevent wakeup from s3 state trig by
 Lenovo ThinkCentre TI024Gen3 USB-audio
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     penghao <penghao@uniontech.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Jaroslav Kysela <perex@perex.cz>, alexander@tsoy.me,
        dan.carpenter@oracle.com, crwulff@gmail.com, gustavoars@kernel.org,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        linux-kernel@vger.kernel.org
References: <20200819115757.23168-1-penghao@uniontech.com>
 <s5h364ih7vd.wl-tiwai@suse.de>
 <74B3A9AD-8B49-4E5F-BE9F-BF88865304B7@canonical.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <fdd0d029-d7b5-ff43-5f84-9d73de867bca@canonical.com>
Date:   Thu, 20 Aug 2020 09:42:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <74B3A9AD-8B49-4E5F-BE9F-BF88865304B7@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/20 上午2:10, Kai-Heng Feng wrote:
>
>> On Aug 20, 2020, at 01:18, Takashi Iwai <tiwai@suse.de> wrote:
>>
>> [ Adding a few more relevant people to Cc. ]
>>
>> On Wed, 19 Aug 2020 13:57:57 +0200,
>> penghao wrote:
>>> TI024Gen3 USB-audio is controlled by TI024Gen3,when TI024Gens
>>> enter sleep mode, USB-audio will disconnect from USB bus port,
>>> wakup form s3 state
>>>
>>> Signed-off-by: penghao <penghao@uniontech.com>
>>> ---
>>> sound/usb/card.c | 6 ++++++
>>> 1 file changed, 6 insertions(+)
>>>
>>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>>> index 696e788c5d31..6bdbb34009b3 100644
>>> --- a/sound/usb/card.c
>>> +++ b/sound/usb/card.c
>>> @@ -658,6 +658,12 @@ static int usb_audio_probe(struct usb_interface *intf,
>>> 	}
>>>
>>> 	dev_set_drvdata(&dev->dev, chip);
>>> +	/*
>>> +	 *ALSA: usb-audio: Add prevent wakeup from s3 state trig by Lenovo
>>> +	 *ThinkCentre TI024Gen3 usb-audio
>>> +	 */
>>> +	if ((usb_id->idVendor == 0x17ef) && (usb_id->idProduct == 0xa012))
>>> +		device_set_wakeup_enable(＆dev->dev, 0);
>> Here it's no proper ASCII letter, and this must be broken.
>> Please check the actual patch before submitting.
>>
>> In anyway, before going further, I'd like to hear from other people
>> whether this is really mandatory and appropriate.  And whether it's
>> specific to that device, too (not other Lenovo devices?)
> If USB remote wakeup on this device is broken then we need to fix it in USB core instead of USB audio.
> We need USB and xHCI logs to understand the real problem here, the commit message doesn't contain enough information.
>
> Kai-Heng

I checked with our QA, we didn't enable this machine before.  And I 
tried 2 different usb audio cards, neither of them has wakeup 
capability. it is weird that your usb sound card (maybe a built-in usb 
sound card) has wakeup capability.

You could file a bug to 
https://bugs.launchpad.net/ubuntu/+source/linux/+filebug, then upload 
the needed logs,  Kai-Heng and I will help investigate this issue.

Thanks,

Hui.

>>
>> thanks,
>>
>> Takashi
