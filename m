Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B524C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1115E20734
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="rLEXgwkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgGRPpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:45:06 -0400
Received: from crapouillou.net ([89.234.176.41]:51184 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 11:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595087102; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hDheKKcmpfdjfbIps50MI3cBLd9kNxWTaG8cU16XA/E=;
        b=rLEXgwkA/ewPnSOs5RLowuN+UKs1SlM6PCcxR0ZtbVzQgrJiWTmk9wd7whm9w9AR270lIN
        R5wqfoPBEt6do6omNvzSc3qm+slp1SefgUDSu/Z3FKUBMe9+t3c282fSFRs4VkBkaWa7+y
        YSbctq/A90rgOHBkYmFHHQwwAdj3Q1k=
Date:   Sat, 18 Jul 2020 17:44:52 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v6 2/2] clocksource: Ingenic: Add support for the Ingenic
 X1000 OST.
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Message-Id: <S29ODQ.X11A9NSVRIIJ@crapouillou.net>
In-Reply-To: <096c8788-3c50-3eae-1c8e-c0c7487b00af@wanyeetech.com>
References: <20200710170259.29028-1-zhouyanjie@wanyeetech.com>
        <20200710170259.29028-3-zhouyanjie@wanyeetech.com>
        <dd01a117-265a-e64b-5871-22f0f752834a@linaro.org>
        <f0dd2ea5-0627-35cf-5a58-aaff0bcb22cd@wanyeetech.com>
        <9c64bc35-c043-6e4b-cfc3-50f19e4cb315@linaro.org>
        <512ODQ.64YN0BEY1JJG@crapouillou.net>
        <096c8788-3c50-3eae-1c8e-c0c7487b00af@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Le sam. 18 juil. 2020 =C3=A0 21:42, Zhou Yanjie <zhouyanjie@wanyeetech.com>=
=20
a =C3=A9crit :
> Hello Paul and Daniel,
>=20
> =E5=9C=A8 2020/7/18 =E4=B8=8B=E5=8D=889:12, Paul Cercueil =E5=86=99=E9=81=
=93:
>> Hi Daniel,
>>=20
>> Le ven. 17 juil. 2020 =C3=A0 10:02, Daniel Lezcano=20
>> =7F<daniel.lezcano@linaro.org> a =C3=A9crit :
>>> On 17/07/2020 08:13, Zhou Yanjie wrote:
>>>>  Hi Daniel,
>>>>=20
>>>>  =E5=9C=A8 2020/7/17 =E4=B8=8B=E5=8D=8812:20, Daniel Lezcano =E5=86=99=
=E9=81=93:
>>>>>  On 10/07/2020 19:02, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) wrote=
:
>>>>>>  X1000 and SoCs after X1000 (such as X1500 and X1830) had a=20
>>>>>> separate
>>>>>>  OST, it no longer belongs to TCU. This driver will register=20
>>>>>> both a
>>>>>>  clocksource and a sched_clock to the system.
>>>>>>=20
>>>>>>  Tested-by: =E5=91=A8=E6=AD=A3 (Zhou Zheng) <sernia.zhou@foxmail.com=
>
>>>>>>  Co-developed-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pz=
qi@ingenic.com>
>>>>>>  Signed-off-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi=
@ingenic.com>
>>>>>>  Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie)=20
>>>>>> <zhouyanjie@wanyeetech.com>
>>>>>>  Reviewed-by: Paul Cercueil <paul@crapouillou.net>
>>>>>>  ---
>>>>>>=20
>>>>>>  Notes:
>>>>>>       v1->v2:
>>>>>>       Fix compile warnings.
>>>>>>       Reported-by: kernel test robot <lkp@intel.com>
>>>>>>            v2->v3:
>>>>>>       No change.
>>>>>>            v3->v4:
>>>>>>       1.Rename "ost" to "sysost"
>>>>>>       1.Remove unrelated changes.
>>>>>>       2.Remove ost_clock_parent enum.
>>>>>>       3.Remove=20
>>>>>> ost->percpu_timer_channel/ost->global_timer_channel.
>>>>>>       4.Set up independent .recalc_rate/.set_rate for=20
>>>>>> percpu/global
>>>>>>  timer.
>>>>>>       5.No longer call functions in variable declarations.
>>>>>>            v4->v5:
>>>>>>       Use "of_io_request_and_map()" instead "of_iomap()".
>>>>>>       Suggested-by: Paul Cercueil <paul@crapouillou.net>
>>>>>>            v5->v6:
>>>>>>       No change.
>>>>>>=20
>>>>>>    drivers/clocksource/Kconfig          |  11 +
>>>>>>    drivers/clocksource/Makefile         |   1 +
>>>>>>    drivers/clocksource/ingenic-sysost.c | 539
>>>>>>  +++++++++++++++++++++++++++++++++++
>>>>>>    3 files changed, 551 insertions(+)
>>>>>>    create mode 100644 drivers/clocksource/ingenic-sysost.c
>>>>>>=20
>>>>>>  diff --git a/drivers/clocksource/Kconfig=20
>>>>>> =7F=7F=7F=7F=7Fb/drivers/clocksource/Kconfig
>>>>>>  index 91418381fcd4..1bca8b8fb30f 100644
>>>>>>  --- a/drivers/clocksource/Kconfig
>>>>>>  +++ b/drivers/clocksource/Kconfig
>>>>>>  @@ -696,6 +696,17 @@ config INGENIC_TIMER
>>>>>>        help
>>>>>>          Support for the timer/counter unit of the Ingenic JZ=20
>>>>>> SoCs.
>>>>>>    +config INGENIC_SYSOST
>>>>>>  +    bool "Clocksource/timer using the SYSOST in Ingenic X SoCs"
>>>>>  We usually use silent options and let the platform's Kconfig=20
>>>>> =7F=7F=7F=7Fenable it.
>>>>>  We show up the option only when COMPILE_TEST is enabled.
>>>>>=20
>>>>>  Is there a reason to do it differently?
>>>>=20
>>>>=20
>>>>  Do you mean
>>>>=20
>>>>  bool "Clocksource/timer using the SYSOST in Ingenic X SoCs"
>>>>=20
>>>>  or
>>>>=20
>>>>  default MACH_INGENIC ?
>>>=20
>>> Both, no default here.
>>>=20
>>> eg.
>>>=20
>>> bool "Clocksource/timer using the SYSOST in Ingenic X SoCs" if=20
>>> =7F=7FCOMPILE_TEST
>>>=20
>>> and
>>>=20
>>> in arch/mips/Kconfig in the config MACH_INGENIC section :
>>>=20
>>> ...
>>> select INGENIC_SYSOST
>>> ...
>>=20
>> Disagreed. That's not how we do things on MIPS. Selecting=20
>> MACH_INGENIC =7Fmeans "this kernel will support Ingenic SoCs", but not=20
>> that it will =7Fonly support these. Hence the depends on MIPS /=20
>> default MACH_INGENIC.
>>=20
>> As for the select INGENIC_SYSOST, this driver only applies to a few=20
>> =7FSoCs, I certainly don't want it to be force-enabled. I don't even=20
>> wait =7Fit to be force-enabled on X1000, since it is optional there=20
>> too.
>>=20
>> Cheers,
>> -Paul
>=20
>=20
> If we still need to keep the "default MACH_INGENIC", then Daniel can=20
> directly apply the v6 version.
>=20
> If we need to use the silent options, maybe we can enable them=20
> separately according to=20
> MACH_JZ4740/MACH_JZ4770/MACH_JZ4780/MACH_X1000/MACH_X1830.
>=20
> In fact, I think X1000 and X1830 need to enable this driver in most=20
> cases, because the current test has found that use TCU to provide=20
> clocksource and clockevent will cause data loss/error when=20
> transmitting data through spi or ethernet. And these errors no longer=20
> appear after using OST.

This is likely because the clock is too fast, try to reduce it by a=20
factor 2 or 4, it should behave better.

If it turns out OST is really needed, then it should be selected from=20
MACH_X1000/X1830, not MACH_INGENIC.

Cheers,
-Paul

> Thanks and best regards!
>=20
>=20
>>=20
>>>=20
>>>>  This driver has some origins from "INGENIC_TIMER" driver and
>>>>  "INGENIC_OST" driver.
>>>>  Early Ingenic processors used TCU (timer/counter unit, has 6 or 8
>>>>  generic timer channels) to provide clocksource and clockevent=20
>>>> (both =7F=7F=7Fwith
>>>>  only 16bit precision). This part of the processor can only use
>>>>  "INGENIC_TIMER" driver.
>>>>=20
>>>>  Later processors provide an independent 32bit or 64bit timer=20
>>>> channel
>>>>  (still under TCU, known as ost channel, this channel can not=20
>>>> generate
>>>>  interrupt) to provid higher precision clocksource. The=20
>>>> "INGENIC_OST"
>>>>  driver is for this channel. These processors can use=20
>>>> "INGENIC_TIMER"
>>>>  driver, but using "INGENIC_OST" driver to provide higher precision
>>>>  clocksource would be a better choice (clockevent still needs to be
>>>>  provided by generic timer channel of TCU, and still 16bit=20
>>>> precision).
>>>>=20
>>>>  And the recent processors provide a SYSOST components, it is=20
>>>> =7F=7F=7Findependent
>>>>  from TCU, including a 64bit timer channel for clocksource and a=20
>>>> 32bit
>>>>  timer channel for clockevent. Although these processors can also=20
>>>> use
>>>>  "INGENIC_TIMER" driver, but the better choice is completely=20
>>>> =7F=7F=7Findependent
>>>>  use of "INGENIC_SYSOST" driver to provide higher precision=20
>>>> clocksource
>>>>  and clockevent.
>>>=20
>>> Ok, the rating should do the job then.
>>>=20
>>> Thanks for the explanation.
>>>=20
>>>>  You may have already noticed that this independent SYSOST=20
>>>> component is
>>>>  like an upgraded and streamlined TCU, which only retains one=20
>>>> generic
>>>>  timer channel that can generate interrupts, upgrade it from 16bit=20
>>>> to
>>>>  32bit, and then retain the 64bit ost channel. so the driver code=20
>>>> and
>>>>  Kconfig code of this patch is largely referenced
>>>>  "INGENIC_TIMER" driver and "INGENIC_OST" driver.
>>>>=20
>>>>  Thanks and best regards!
>>>>=20
>>>>>>  +    default MACH_INGENIC
>>>>>>  +    depends on MIPS || COMPILE_TEST
>>>>>>  +    depends on COMMON_CLK
>>>>>>  +    select MFD_SYSCON
>>>>>>  +    select TIMER_OF
>>>>>>  +    select IRQ_DOMAIN
>>>>>>  +    help
>>>>>>  +      Support for the SYSOST of the Ingenic X Series SoCs.
>>>>>>  +
>>>>>  [ ... ]
>>>>>=20
>>>>>=20
>>>=20
>>>=20
>>> --
>>> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=20
>>> ARM SoCs
>>>=20
>>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>>> <http://twitter.com/#!/linaroorg> Twitter |
>>> <http://www.linaro.org/linaro-blog/> Blog
>>=20


