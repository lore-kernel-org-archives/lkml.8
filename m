Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28853C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022F220674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589806147;
	bh=YhXil7G3mbaDMu8tDVkgqWslhG+wcACKZ4FFSNgSFZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cLTQsR83XkngjSo4u+w4dUg2Ze0+z/6KjQYe19zFxaJBIuGthpxXkp9v/Eg6YBWGq
	 cRlDCn/ee7OfvdhpU5bRK0v6RFqScFqfNUlhQV3qOmGYKET5JH0J/nOY0dqfJqQq+q
	 9aIrynKvf1zCgLs1ZwlDCyg6UuFFXkOQD2wxaCQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgERMtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgERMtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:49:05 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C90342065F;
        Mon, 18 May 2020 12:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589806144;
        bh=YhXil7G3mbaDMu8tDVkgqWslhG+wcACKZ4FFSNgSFZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUZLiH47yWEmJ3l+ePMFFL7hveeFQuU6RLFqd73gN7s+dID8Io/PUstiG/NrV4SAu
         RQD/lW/up0UdZ6adMWL10hDRIMh5CA+OzlzjgoEQhN4p8TuVOgcziihqlgW3sSObdi
         ZrBux+rQdI4DlBs9fGGxJGDTC7xEuNcXU+cErlSc=
Received: by pali.im (Postfix)
        id 74EBD89D; Mon, 18 May 2020 14:49:02 +0200 (CEST)
Date:   Mon, 18 May 2020 14:49:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Missing CLOCK_BOOTTIME_RAW?
Message-ID: <20200518124902.yuw2rtmjndi7nbd2@pali>
References: <20200508213122.f7srcd2gnduamtvs@pali>
 <87zhah4evs.fsf@nanos.tec.linutronix.de>
 <20200518111103.sj73h5j3r75zv2wp@pali>
 <87ftbxxz55.fsf@nanos.tec.linutronix.de>
 <20200518113522.y6sj7ypunsu6pi3s@pali>
 <87d071xwxv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d071xwxv.fsf@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 May 2020 14:13:48 Thomas Gleixner wrote:
> Pali Rohár <pali@kernel.org> writes:
> > On Monday 18 May 2020 13:26:14 Thomas Gleixner wrote:
> >> System clock shifted by one hour? You mean DST change?
> >
> > Yes, clock was shifted by one hour.
> >
> >> If chronyd
> >> adjusts that by smoothing the frequency, that's just broken and really
> >> not the kernel's problem.
> >
> > And what other can time synchronization daemon does?
> 
> DST switching is a matter of switching time zones and has absolutely
> nothing to do with frequencies. In fact smearing DST is a blantant
> violation of the timekeeping guarantees.

Problem was that "external source" changed RTC.

But I think this is irrelevant here.

Important was state of machine. Machine was in state that had incorrect
system clock, had running NTP daemon and there was need to somehow make
system clock again correct.

And such situation may happen at any time. Either user unintentionally
change "current time" in his desktop GUI application or call "date"
application with "set" parameter (instead of get), ...

> I've never heard about that before. All I know is that chronyd can be
> configured to smear leap seconds, but that doesn't take 6 hours and does
> not screw with the time accuracy in the range of 20 minutes.
> 
> > Well, I think this is not related to chronyd. Any userspace application
> > may call adjtime(). It is not privilege that only chronyd is allowed to
> > use that syscall.
> 
> Of course not, but the kernel relies on that application behaving
> sanely. If it does not then the time stamps you are complaining about
> are the least of your worries.

I do not thing it is too bad... When I needed to deal in userspace with
time/date/clock I just needed either "current time in UTC" to show it to
user (possible in different timezone and pretty formatted) or I needed
"timestamp since some epoch" suitable for measuring time differences.

For first case I used CLOCK_REALTIME and for second case I used
CLOCK_MONOTONIC_RAW (as it was not affected by adjtime()).

And I would like to know, it is correct to use these two clocks in those
situations?

> > I agree that this is not a kernel problem.
> >
> > But I'm asking, how my userspace application can measure time difference?
> > As I wrote CLOCK_MONITONIC is not suitable as it is affected by those
> > NTP adjustments and that is why I thought that CLOCK_MONITONIC_RAW is
> > better as it is not affected by these NTP problems.
> >
> > But CLOCK_MONITONIC_RAW has a problem that is stopped during system
> > sleep and that is why I thought that CLOCK_BOOTTIME_RAW should be there.
> 
> And how do you make CLOCK_BOOTTIME_RAW accurate? The clock hardware
> can stop accross suspend/resume and the kernel then uses RTC or some
> other hardware to inject the sleep time. That injection is not and
> cannot be correct vs. the raw clock.
> 
> So exposing CLOCK_BOOTTIME_RAW would just provide yet another illusion
> of time.

Now I see. Usage of external source during suspend would just lead to
another problems. So idea about CLOCK_BOOTTIME_RAW is nice but there is
no way how to provide it.

Anyway, what would happen with CLOCK_BOOTTIME when during suspend is
that external RTC source shifted back? Is kernel guarantee that
CLOCK_BOOTTIME is always monotonic even in this case?
