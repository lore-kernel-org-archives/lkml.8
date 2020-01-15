Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C492C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEDF2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgAOTyV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:54:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48732 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbgAOTyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:54:21 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irok3-0007vi-TD; Wed, 15 Jan 2020 20:54:16 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 5D242101228; Wed, 15 Jan 2020 20:54:15 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>,
        Maarten ter Huurne <maarten@treewalker.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, od@zcrc.me,
        linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v3] clocksource: Add driver for the Ingenic JZ47xx OST
In-Reply-To: <1579110897.3.0@crapouillou.net>
Date:   Wed, 15 Jan 2020 20:54:15 +0100
Message-ID: <87y2u8xzq0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Cercueil <paul@crapouillou.net> writes:
> Le mer., janv. 15, 2020 at 18:48, Maarten ter Huurne 
> <maarten@treewalker.org> a écrit :
>> On Wednesday, 15 January 2020 14:57:01 CET Paul Cercueil wrote:
>>>  Le mer., janv. 15, 2020 at 14:44, Daniel Lezcano
>>>  <daniel.lezcano@linaro.org> a écrit :
>>>  > Is the JZ47xx OST really a mfd needing a regmap? (Note regmap_read
>>>  > will take a lock).
>>> 
>>>  Yes, the TCU_REG_OST_TCSR register is shared with the clocks driver.
>> 
>> The TCU_REG_OST_TCSR register is only used in the probe though.
>> 
>> To get the counter value from TCU_REG_OST_CNTL/TCU_REG_OST_CNTH you
>> could technically do it by reading the register directly, if 
>> performance
>> concerns make it necessary to bypass the usual kernel infrastructure 
>> for
>> dealing with shared registers.
>
> In theory yes, in practice there's no easy way to do that (the 
> underlying mmio pointer is not obtainable from the regmap), and 
> besides, the lock is just a spinlock and not a mutex.

That lock still a massive contention point as clock readouts can be pretty
frequent depending on workloads. Just think about tracing ...

So I really would avoid both the lock and that ugly 64bit readout thing.

Thanks,

        tglx


