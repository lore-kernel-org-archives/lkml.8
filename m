Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F6EC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480B22070A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="miDOA1zH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgBKNbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:31:36 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:56156 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgBKNbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581427893; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YFd1WqWUfqjVwYd943I7JoTwmQPb1o38AUdJkGGRoSY=;
        b=miDOA1zHZdFX22gWUzfJizafdcA0sVeZf8W7XGe9zHW/L9Hnx1ix5yGZUUGFuXxodqDb6J
        YMMDw4QRB1pu9Pqy6D0b0aqA1VoxSY0SzRsLyl083phmjGL/Qpl4l0G0RUcDzbDMJyco9N
        w3oxY364POzfrXy2JPIBmIbQpbZ30Hc=
Date:   Tue, 11 Feb 2020 10:31:13 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 1/2] sched: Add sched_clock_register_new()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>, od@zcrc.me,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Message-Id: <1581427873.3.0@crapouillou.net>
In-Reply-To: <87lfp94duq.fsf@nanos.tec.linutronix.de>
References: <20200210134213.8324-1-paul@crapouillou.net>
        <87lfp94duq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,


Le mar., f=E9vr. 11, 2020 at 11:28, Thomas Gleixner <tglx@linutronix.de>=20
a =E9crit :
> Paul!
>=20
> Paul Cercueil <paul@crapouillou.net> writes:
>=20
>>  The sched_clock_register_new() behaves like sched_clock_register()=20
>> but
>=20
> This function name does not make any sense. Two years from now you are
> going to provide sched_clock_register_new_2_dot_0() ?

I'm open to suggestions :)
The point of using a different function was to avoid a huge patchset to=20
fix the 50+ drivers that use sched_clock_register().

>>  takes an extra parameter which is passed to the read callback.
>=20
> This lacks any form of justification why this function and the data
> pointer is required.
>=20
>>    * @sched_clock_mask:   Bitmask for two's complement subtraction=20
>> of non 64bit
>>    *			clocks.
>>    * @read_sched_clock:	Current clock source (or dummy source when=20
>> suspended).
>>  + * @data:		Callback data for the current clock source.
>>    * @mult:		Multipler for scaled math conversion.
>>    * @shift:		Shift value for scaled math conversion.
>>    *
>>  @@ -39,7 +40,8 @@ struct clock_read_data {
>>   	u64 epoch_ns;
>>   	u64 epoch_cyc;
>>   	u64 sched_clock_mask;
>>  -	u64 (*read_sched_clock)(void);
>>  +	u64 (*read_sched_clock)(void *);
>=20
> How is that supposed to work without fixing up _all_ sched clock
> instances? So the below typecast
>=20
>>  +void __init
>>  +sched_clock_register(u64 (*read)(void), int bits, unsigned long=20
>> rate)
>>  +{
>>  +	sched_clock_register_new((u64 (*)(void *))read, bits, rate, NULL);
>=20
> makes it compile.
>=20
> By pure luck this does not explode in your face at runtime when the
> existing read(void) functions are called with an argument. Any stack
> based argument passing calling convention would fall flat on it's=20
> nose.
>=20
> While clever this is really an ugly hack.

Alright, I really didn't think it was that bad. Next time I'll use a=20
wrapper.

> As the clocksource for which you are doing this is a single instance,
> what's wrong with having some static storage for the information you
> need as any other driver which has the same problem does as well?

The fact that every other driver with the same problem decides to add a=20
workaround instead of a proper fix does not mean that the problem does=20
not exist.

> If there is really a point in avoiding a few bytes of static storage,
> then this needs to be cleaned up treewide and not hacked around.

My allergy of static storage is not worth the trouble of a treewide=20
pathset so I'll just drop this patch and send a v5.

Thanks,
-Paul


=

