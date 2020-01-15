Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CB1C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B5B24679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="dvMTh5Gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgAOU7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:59:15 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44118 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAOU7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1579121953; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4paQuRZq0NUIdHcv3ACilWGUqXPTdvt/21N1Xcd0KR8=;
        b=dvMTh5GuNIvo92DiEWQvaumTSH3LuuU/NsgvlJAOvRud06WBnpXxE9Q9utf7JBINKULob3
        MeQ2Q5kD9dfa3oaV/0/eqyg5IHAg2T460vaKQcNFJ5uaGKeKVCTkYUc3BHPukNXISTuuuH
        l3NKmlN0vvEIHiXieOz6QMy0lQ1MFIA=
Date:   Wed, 15 Jan 2020 17:58:56 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3] clocksource: Add driver for the Ingenic JZ47xx OST
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, od@zcrc.me,
        linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1579121936.3.1@crapouillou.net>
In-Reply-To: <87y2u8xzq0.fsf@nanos.tec.linutronix.de>
References: <1579110897.3.0@crapouillou.net>
        <87y2u8xzq0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mer., janv. 15, 2020 at 20:54, Thomas Gleixner <tglx@linutronix.de>=20
a =E9crit :
> Paul Cercueil <paul@crapouillou.net> writes:
>>  Le mer., janv. 15, 2020 at 18:48, Maarten ter Huurne
>>  <maarten@treewalker.org> a =E9crit :
>>>  On Wednesday, 15 January 2020 14:57:01 CET Paul Cercueil wrote:
>>>>   Le mer., janv. 15, 2020 at 14:44, Daniel Lezcano
>>>>   <daniel.lezcano@linaro.org> a =E9crit :
>>>>   > Is the JZ47xx OST really a mfd needing a regmap? (Note=20
>>>> regmap_read
>>>>   > will take a lock).
>>>>=20
>>>>   Yes, the TCU_REG_OST_TCSR register is shared with the clocks=20
>>>> driver.
>>>=20
>>>  The TCU_REG_OST_TCSR register is only used in the probe though.
>>>=20
>>>  To get the counter value from TCU_REG_OST_CNTL/TCU_REG_OST_CNTH you
>>>  could technically do it by reading the register directly, if
>>>  performance
>>>  concerns make it necessary to bypass the usual kernel=20
>>> infrastructure
>>>  for
>>>  dealing with shared registers.
>>=20
>>  In theory yes, in practice there's no easy way to do that (the
>>  underlying mmio pointer is not obtainable from the regmap), and
>>  besides, the lock is just a spinlock and not a mutex.
>=20
> That lock still a massive contention point as clock readouts can be=20
> pretty
> frequent depending on workloads. Just think about tracing ...
>=20
> So I really would avoid both the lock and that ugly 64bit readout=20
> thing.

The 64bit readout thing is gone in V3.

The lock cannot go away unless we have a way to retrieve the underlying=20
mmio pointer from the regmap, which the regmap maintainers will never=20
accept. So I can't really change that now. Besides,=20
drivers/clocksource/ingenic-timer.c also registers a clocksource that's=20
read with the regmap, and nobody complained.

-Paul

=

