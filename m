Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1037C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2744205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgFCR0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgFCR0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:26:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770F8C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 10:26:14 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jgX9W-0005Za-S0; Wed, 03 Jun 2020 19:26:11 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D61AA10108D; Wed,  3 Jun 2020 19:26:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] timers/core for v5.8
In-Reply-To: <CAHk-=wiQr=wMrjpDXfvR=g+muNr4ST6=4O_jv6pOuTbtdbE_aw@mail.gmail.com>
References: <159109968973.14228.6780339995273133401.tglx@nanos.tec.linutronix.de> <159109969095.14228.4958990874220284812.tglx@nanos.tec.linutronix.de> <CAHk-=wiQr=wMrjpDXfvR=g+muNr4ST6=4O_jv6pOuTbtdbE_aw@mail.gmail.com>
Date:   Wed, 03 Jun 2020 19:26:09 +0200
Message-ID: <87mu5kf4cu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Tue, Jun 2, 2020 at 5:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> The truly boring timer and clocksource updates for 5.8:
>>
>>  - Not a single new clocksource or clockevent driver!
>
> The diffstat proved that to be a filthy lie:
>
>>  drivers/clocksource/timer-ti-dm-systimer.c         | 727 +++++++++++++++++++++
>
> comes from
>
>> Tony Lindgren (6):
>>       clocksource/drivers/timer-ti-dm: Add clockevent and clocksource support
>
> Ok, ok, it's "based on existing arch/arm/mach-omap2/timer.c". So I
> guess you considered it one of the device tree cleanups.

Hrm.

> But I'm not fooled by your transparent little white lies.  We will
> never ever have a release without new clocksource drivers.
>
> Sob.

Darn, you just killed my illusion that the new clock* driver frenzy
finally subsides.

Thanks,

        tglx
