Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A889FC35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 13:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523172082E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 13:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="I1uDs8SO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgBHNYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 08:24:03 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:39326 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgBHNYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 08:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581168240; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ShigGUaHirA4HhEKv20JUgdHeAa3/ttY71batoO6c7E=;
        b=I1uDs8SO0S+2R/+EnDS8OEPjtCmqnGECurH7MQy+yleDrehl3RC6+MD9LjnrqE5mzICYtt
        XrykLRmfA7q6nOWJuSol25C9grzVPQ8R6tlFOBlHTnyyamUFmjaXJbfmFv+CvHZUCi1D2F
        FV05CgBWAuAB+i+X596ZZUZpRdcvFWI=
Date:   Sat, 08 Feb 2020 10:23:44 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3] clocksource: Add driver for the Ingenic JZ47xx OST
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maarten ter Huurne <maarten@treewalker.org>, od@zcrc.me,
        linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1581168224.3.0@crapouillou.net>
In-Reply-To: <eef21d5f-334c-81b4-19b1-6498df4fca30@linaro.org>
References: <1579110897.3.0@crapouillou.net>
        <87y2u8xzq0.fsf@nanos.tec.linutronix.de> <1579121936.3.1@crapouillou.net>
        <eef21d5f-334c-81b4-19b1-6498df4fca30@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Le sam., f=E9vr. 8, 2020 at 08:09, Daniel Lezcano=20
<daniel.lezcano@linaro.org> a =E9crit :
> Hi Paul,
>=20
> On 15/01/2020 21:58, Paul Cercueil wrote:
>>=20
>>=20
>>  Le mer., janv. 15, 2020 at 20:54, Thomas Gleixner=20
>> <tglx@linutronix.de> a
>>  =E9crit :
>>>  Paul Cercueil <paul@crapouillou.net> writes:
>>>>   Le mer., janv. 15, 2020 at 18:48, Maarten ter Huurne
>>>>   <maarten@treewalker.org> a =E9crit :
>>>>>   On Wednesday, 15 January 2020 14:57:01 CET Paul Cercueil wrote:
>>>>>>    Le mer., janv. 15, 2020 at 14:44, Daniel Lezcano
>>>>>>    <daniel.lezcano@linaro.org> a =E9crit :
>>>>>>    > Is the JZ47xx OST really a mfd needing a regmap? (Note=20
>>>>>> regmap_read
>>>>>>    > will take a lock).
>>>>>>=20
>>>>>>    Yes, the TCU_REG_OST_TCSR register is shared with the clocks=20
>>>>>> driver.
>>>>>=20
>>>>>   The TCU_REG_OST_TCSR register is only used in the probe though.
>>>>>=20
>>>>>   To get the counter value from TCU_REG_OST_CNTL/TCU_REG_OST_CNTH=20
>>>>> you
>>>>>   could technically do it by reading the register directly, if
>>>>>   performance
>>>>>   concerns make it necessary to bypass the usual kernel=20
>>>>> infrastructure
>>>>>   for
>>>>>   dealing with shared registers.
>>>>=20
>>>>   In theory yes, in practice there's no easy way to do that (the
>>>>   underlying mmio pointer is not obtainable from the regmap), and
>>>>   besides, the lock is just a spinlock and not a mutex.
>>>=20
>>>  That lock still a massive contention point as clock readouts can be
>>>  pretty
>>>  frequent depending on workloads. Just think about tracing ...
>>>=20
>>>  So I really would avoid both the lock and that ugly 64bit readout=20
>>> thing.
>>=20
>>  The 64bit readout thing is gone in V3.
>>=20
>>  The lock cannot go away unless we have a way to retrieve the=20
>> underlying
>>  mmio pointer from the regmap, which the regmap maintainers will=20
>> never
>>  accept. So I can't really change that now. Besides,
>>  drivers/clocksource/ingenic-timer.c also registers a clocksource=20
>> that's
>>  read with the regmap, and nobody complained.
>=20
> Is there any progress on this? Having a lock in this code path is very
> impacting.

I have a v4 ready, I'm just waiting for 5.6-rc1 to start to rebase on=20
top and send it.

-Paul

=

