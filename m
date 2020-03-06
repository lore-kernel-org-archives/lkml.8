Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4FFC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 12:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2962120848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 12:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCFMTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:19:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37974 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgCFMTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 07:19:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9A6CD297044
Subject: Re: [PATCH v2 2/2] drm/bridge: anx7688: Add anx7688 bridge driver
 support
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
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
References: <20200213145416.890080-2-enric.balletbo@collabora.com>
 <CA+E=qVffVzZwRTk9K7=xhWn-AOKExkew0aPcyL_W1nokx-mDdg@mail.gmail.com>
 <CAFqH_53crnC6hLExNgQRjMgtO+TLJjT6uzA4g8WXvy7NkwHcJg@mail.gmail.com>
 <CA+E=qVfGiQseZZVBvmmK6u2Mu=-91ViwLuhNegu96KRZNAHr_w@mail.gmail.com>
 <CAFqH_505eWt9UU7Wj6tCQpQCMZFMfy9e1ETSkiqi7i5Zx6KULQ@mail.gmail.com>
 <CA+E=qVff5_hdPFdaG4Lrg7Uzorea=JbEdPoy+sQd7rUGNTTZ5g@mail.gmail.com>
 <5245a8e4-2320-46bd-04fd-f86ce6b17ce7@collabora.com>
 <CA+E=qVcyRW4LNC5db27d-8x-T_Nk9QAhkBPwu5rwthTc6ewbYA@mail.gmail.com>
 <20200305193505.4km5j7n25ph4b6hn@core.my.home>
 <2a5a4a62-3189-e053-21db-983a4c766d44@collabora.com>
 <20200306120318.oq575imqjh7uolss@core.my.home>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <522fc986-50b3-e4ff-9dc3-93921733d362@collabora.com>
Date:   Fri, 6 Mar 2020 13:18:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306120318.oq575imqjh7uolss@core.my.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/20 13:03, Ondřej Jirman wrote:
> On Fri, Mar 06, 2020 at 09:46:51AM +0100, Enric Balletbo i Serra wrote:
>> Hi Ondrej,
>>
>> On 5/3/20 20:35, Ondřej Jirman wrote:
>>> Hi,
>>>
>>> On Thu, Mar 05, 2020 at 10:29:33AM -0800, Vasily Khoruzhick wrote:
>>>> On Thu, Mar 5, 2020 at 7:28 AM Enric Balletbo i Serra
>>>> <enric.balletbo@collabora.com> wrote:
>>>>>
>>>>> Hi Vasily,
>>>>
>>>> CC: Icenowy and Ondrej
>>>>>
>>>>> Would you mind to check which firmware version is running the anx7688 in
>>>>> PinePhone, I think should be easy to check with i2c-tools.
>>>>
>>>> Icenowy, Ondrej, can you guys please check anx7688 firmware version?
>>>
>>> i2cget 0 0x28 0x00 w
>>> 0xaaaa
>>>
>>> i2cget 0 0x28 0x02 w
>>> 0x7688
>>>
>>> i2cget 0 0x28 0x80 w
>>> 0x0000
>>>
>>
>> Can you check the value for 0x81 too?
> 
> 'w' read checks both values at once, as you can see above.
> 

Oh right, sorry. The thing is that firmware version is at 0x2c, not 0x28, so
we're interested on see register 0x80 and 0x81 for 0x2c address.

Thanks,
 Enric

> regards,
> 	o.
> 
>> Thanks,
>>  Enric
>>
>>
>>> regards,
>>> 	o.
>>>
>>>>> Thanks in advance,
>>>>>  Enric
>>>>>
>>>>> [snip]
