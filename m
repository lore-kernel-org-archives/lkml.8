Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DEBC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D957C206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbgIARAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732338AbgIARAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:00:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08DAC061244;
        Tue,  1 Sep 2020 10:00:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 30C17296B56
Subject: Re: [PATCH v2 1/4] ARM: exynos: clear L310_AUX_CTRL_NS_LOCKDOWN in
 default l2c_aux_val
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        kernel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <267a81e550a0b5d479c82b5908e2a2caa4c9c874.1597061474.git.guillaume.tucker@collabora.com>
 <c0509b5f-a064-2e73-7e04-51f41a56d222@collabora.com>
 <CAJKOXPczS_RpSFpjGygZ_1MCYxJ_cUDRjriZvrHd6+zhmq=c8Q@mail.gmail.com>
 <CAJKOXPfT7LvHVpTdaQ1voVi=OtC4aV6hbyzcekmrPMkb+5ebNg@mail.gmail.com>
 <fd1a34c4-dcc1-1480-1e96-8bd94ada9846@collabora.com>
 <CAJKOXPdQiXc3zVRK25AsfYPBwL1Rm6y1niFt5wxkC5gH5baiZA@mail.gmail.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <1cf0722a-df3a-33af-3317-c48eeb5a5842@collabora.com>
Date:   Tue, 1 Sep 2020 18:00:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdQiXc3zVRK25AsfYPBwL1Rm6y1niFt5wxkC5gH5baiZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2020 16:25, Krzysztof Kozlowski wrote:
> On Tue, 1 Sep 2020 at 16:42, Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
>>
>> On 01/09/2020 14:51, Krzysztof Kozlowski wrote:
>>> On Tue, 1 Sep 2020 at 15:45, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On Tue, 1 Sep 2020 at 15:34, Guillaume Tucker
>>>> <guillaume.tucker@collabora.com> wrote:
>>>>>
>>>>> Hi Krzysztof, Russell,
>>>>>
>>>>> On 10/08/2020 13:22, Guillaume Tucker wrote:
>>>>>> The L310_AUX_CTRL_NS_LOCKDOWN flag is set during the L2C enable
>>>>>> sequence.  There is no need to set it in the default register value,
>>>>>> this was done before support for it was implemented in the code.  It
>>>>>> is not set in the hardware initial value either.
>>>>>>
>>>>>> Clean this up by removing this flag from the default l2c_aux_val, and
>>>>>> add it to the l2c_aux_mask to print an alert message if it was already
>>>>>> set before the kernel initialisation.
>>>>>>
>>>>>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>>>>>> ---
>>>>>>
>>>>>> Notes:
>>>>>>     v2: fix flag name L310_AUX_CTRL_NS_LOCKDOWN
>>>>>>
>>>>>>  arch/arm/mach-exynos/exynos.c | 4 ++--
>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> I believe this v2 series has addressed all previous comments and
>>>>> you were waiting for the 5.9 merge window to end.  The patches
>>>>> all still apply cleanly on v5.9-rc3.  Do you want me to resend
>>>>> the series anyway or is there anything else needed at this point?
>>>>>
>>>>> Maybe one thing that wasn't completely clear in v1 was whether
>>>>> patch 2/4 was the right approach.  I've explained the reason
>>>>> behind it but didn't get a final reply from Russell[1].
>>>>
>>>> I am sorry, my bad. I already applied this one and 3/4 (dts).
>>>> Apparently I forgot to reply with confirmation and Patchwork did not
>>>> notify you for some reason.
>>
>> No problem, I see them in linux-next now.  Thanks!
>>
>>>> Patch 2/4 does not look like one for me so I would need ack from
>>>> Russell to take. Did you submit it to the ARM patches queue?
>>
>> I've CC-ed linux-arm-kernel@lists.infradead.org on the whole
>> series.  Did you mean anything else by the ARM patches queue?
> 
> Unless anything changed, so far all ARM-core related patches had to be
> submitted to Russell's system. I didn't submit anything for 3 years so
> maybe something changed...
> https://www.arm.linux.org.uk/developer/patches/

Ah yes, thanks.  I hadn't visited that website for ages...  The
patch 2/4 is there now:

  https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=9007/1

Best wishes,
Guillaume
