Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E90C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83ACD208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCEP2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:28:39 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56182 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgCEP2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:28:39 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 10B6A296C1B
Subject: Re: [PATCH v2 2/2] drm/bridge: anx7688: Add anx7688 bridge driver
 support
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>, Torsten Duwe <duwe@suse.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Collabora Kernel ML <kernel@collabora.com>
References: <20200213145416.890080-1-enric.balletbo@collabora.com>
 <20200213145416.890080-2-enric.balletbo@collabora.com>
 <CA+E=qVffVzZwRTk9K7=xhWn-AOKExkew0aPcyL_W1nokx-mDdg@mail.gmail.com>
 <CAFqH_53crnC6hLExNgQRjMgtO+TLJjT6uzA4g8WXvy7NkwHcJg@mail.gmail.com>
 <CA+E=qVfGiQseZZVBvmmK6u2Mu=-91ViwLuhNegu96KRZNAHr_w@mail.gmail.com>
 <CAFqH_505eWt9UU7Wj6tCQpQCMZFMfy9e1ETSkiqi7i5Zx6KULQ@mail.gmail.com>
 <CA+E=qVff5_hdPFdaG4Lrg7Uzorea=JbEdPoy+sQd7rUGNTTZ5g@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <5245a8e4-2320-46bd-04fd-f86ce6b17ce7@collabora.com>
Date:   Thu, 5 Mar 2020 16:28:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CA+E=qVff5_hdPFdaG4Lrg7Uzorea=JbEdPoy+sQd7rUGNTTZ5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasily,

On 14/2/20 23:22, Vasily Khoruzhick wrote:
> On Fri, Feb 14, 2020 at 2:20 PM Enric Balletbo Serra
> <eballetbo@gmail.com> wrote:
>>
>> Hi Vasily,
>>
>> Missatge de Vasily Khoruzhick <anarsoul@gmail.com> del dia dv., 14 de
>> febr. 2020 a les 23:17:
>>>
>>> On Fri, Feb 14, 2020 at 1:53 PM Enric Balletbo Serra
>>> <eballetbo@gmail.com> wrote:
>>>>
>>>> Hi Vasily,
>>>>
>>>> Missatge de Vasily Khoruzhick <anarsoul@gmail.com> del dia dv., 14 de
>>>> febr. 2020 a les 22:36:
>>>>>
>>>>> On Thu, Feb 13, 2020 at 6:54 AM Enric Balletbo i Serra
>>>>> <enric.balletbo@collabora.com> wrote:
>>>>>>
>>>>>> From: Nicolas Boichat <drinkcat@chromium.org>
>>>>>>
>>>>>> ANX7688 is a HDMI to DP converter (as well as USB-C port controller),
>>>>>> that has an internal microcontroller.
>>>>>>
>>>>>> The only reason a Linux kernel driver is necessary is to reject
>>>>>> resolutions that require more bandwidth than what is available on
>>>>>> the DP side. DP bandwidth and lane count are reported by the bridge
>>>>>> via 2 registers on I2C.
>>>>>
>>>>> It is true only for your particular platform where usb-c part is
>>>>> managed by firmware. Pinephone has the same anx7688 but linux will
>>>>> need a driver that manages usb-c in addition to DP.
>>>>>
>>>>> I'd suggest making it MFD driver from the beginning, or at least make
>>>>> proper bindings so we don't have to rework it and introduce binding
>>>>> incompatibilities in future.
>>>>>
>>>>
>>>> Do you have example code on how the ANX7866 is used in pinephone?
>>>> There is a repo somewhere?
>>>
>>> I don't think it's implemented yet. I've CCed Icenowy in case if she
>>> has anything.
>>>
>>
>> It would be good to join the effort. Just because I am curious, there
>> are public schematics for the pinephone that is using that bridge?
> 
> Schematics is available here:
> https://wiki.pine64.org/index.php/PinePhone_v1.1_-_Braveheart#Schematic
> 

Would you mind to check which firmware version is running the anx7688 in
PinePhone, I think should be easy to check with i2c-tools.

Thanks in advance,
 Enric

[snip]
