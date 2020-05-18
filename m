Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FC7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5066420643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgERMNy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgERMNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:13:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD63C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 05:13:51 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jaeeT-000112-1Z; Mon, 18 May 2020 14:13:49 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 215E4100606; Mon, 18 May 2020 14:13:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Missing CLOCK_BOOTTIME_RAW?
In-Reply-To: <20200518113522.y6sj7ypunsu6pi3s@pali>
References: <20200508213122.f7srcd2gnduamtvs@pali> <87zhah4evs.fsf@nanos.tec.linutronix.de> <20200518111103.sj73h5j3r75zv2wp@pali> <87ftbxxz55.fsf@nanos.tec.linutronix.de> <20200518113522.y6sj7ypunsu6pi3s@pali>
Date:   Mon, 18 May 2020 14:13:48 +0200
Message-ID: <87d071xwxv.fsf@nanos.tec.linutronix.de>
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

Pali Rohár <pali@kernel.org> writes:
> On Monday 18 May 2020 13:26:14 Thomas Gleixner wrote:
>> System clock shifted by one hour? You mean DST change?
>
> Yes, clock was shifted by one hour.
>
>> If chronyd
>> adjusts that by smoothing the frequency, that's just broken and really
>> not the kernel's problem.
>
> And what other can time synchronization daemon does?

DST switching is a matter of switching time zones and has absolutely
nothing to do with frequencies. In fact smearing DST is a blantant
violation of the timekeeping guarantees.

I've never heard about that before. All I know is that chronyd can be
configured to smear leap seconds, but that doesn't take 6 hours and does
not screw with the time accuracy in the range of 20 minutes.

> Well, I think this is not related to chronyd. Any userspace application
> may call adjtime(). It is not privilege that only chronyd is allowed to
> use that syscall.

Of course not, but the kernel relies on that application behaving
sanely. If it does not then the time stamps you are complaining about
are the least of your worries.

> I agree that this is not a kernel problem.
>
> But I'm asking, how my userspace application can measure time difference?
> As I wrote CLOCK_MONITONIC is not suitable as it is affected by those
> NTP adjustments and that is why I thought that CLOCK_MONITONIC_RAW is
> better as it is not affected by these NTP problems.
>
> But CLOCK_MONITONIC_RAW has a problem that is stopped during system
> sleep and that is why I thought that CLOCK_BOOTTIME_RAW should be there.

And how do you make CLOCK_BOOTTIME_RAW accurate? The clock hardware
can stop accross suspend/resume and the kernel then uses RTC or some
other hardware to inject the sleep time. That injection is not and
cannot be correct vs. the raw clock.

So exposing CLOCK_BOOTTIME_RAW would just provide yet another illusion
of time.

Thanks,

        tglx
