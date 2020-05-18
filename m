Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A15C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58782070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589800267;
	bh=pc0Q0tvor9gFCGh0pKNQ4PA6NJ0P8j7/aT458qclBKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cldzRFOw5c6+bx2ysF+OPbgBNKGwP7Cv+xmHsOMu7WanR2yTHbF8JYhsC8+cShY0+
	 egidEZFAzGRs+BHf3sPdlSxJ38DTLUJXcBtM/AU5Zj2r4TudqVSKrMIVSxspeq7tQo
	 V9jtRp02xPljejeK3P2iJZdnZc7Gal4tdPvTAu0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgERLLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgERLLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:11:06 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C48BF20709;
        Mon, 18 May 2020 11:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589800265;
        bh=pc0Q0tvor9gFCGh0pKNQ4PA6NJ0P8j7/aT458qclBKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OTJwjMOiDb3xJOCZglpEvfUPS9WhBUWb187deivO5CM+qbGq1pUdGlconPtFNi+tj
         b9IX0xH+GBqsvibOsNklZRzG89j1Vnf8WHOOsET48o/n9bJ4inrwOAmLD6CFlgafyH
         ke++F32cSqfI1pT8W9Cxm26jIXmBBafue6r7tioI=
Received: by pali.im (Postfix)
        id B59B189D; Mon, 18 May 2020 13:11:03 +0200 (CEST)
Date:   Mon, 18 May 2020 13:11:03 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Missing CLOCK_BOOTTIME_RAW?
Message-ID: <20200518111103.sj73h5j3r75zv2wp@pali>
References: <20200508213122.f7srcd2gnduamtvs@pali>
 <87zhah4evs.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhah4evs.fsf@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 May 2020 11:49:27 Thomas Gleixner wrote:
> Pali,
> 
> Pali Rohár <pali@kernel.org> writes:
> > On Friday 08 May 2020 22:59:57 Thomas Gleixner wrote:
> >> Pali Rohár <pali@kernel.org> writes:
> >> Neither CLOCK_BOOTTIME nor CLOCK_MONOTONIC jump. They are frequency
> >> corrected when NTP, PTP or PPS are in use. The frequency correction is
> >> incremental an smothed. They really don't jump and they give you proper
> >> time in nanoseconds which is as close to the real nanoseconds as it
> >> gets.
> >
> > Hello! I should have been more precise about it. CLOCK_BOOTTIME and
> > CLOCK_MONOTONIC do not jump but I understood that they are affected by
> > adjtime(). So these clocks may tick faster or slower than real time. NTP
> > daemon when see that CLOCK_REALTIME is incorrect, it may speed up or
> > slow down its ticking. And this is affected also by CLOCK_BOOTTIME and
> > CLOCK_MONOTONIC, right?
> 
> Sure, but what's the problem? The adjustemt is done to make the observed
> time as correct as possible.

Yes. But correction may take lot of time, e.g. also more then one day.

So during this period when correction is in progress, measuring time
difference via CLOCK_MONITONIC will have incorrect results.

It already happened for me, system clock was shifted by one hour and
chronyd started adjustment, it slow down system clock. 6 real hours
passed and via system clock was measured time difference only about
5 hours and 20 minutes (correction was still in progress as system
clock at that time was still shifted by about 20 minutes).

So measuring time differences via clock affected by NTP adjustment
resulted in error which was more then 30 minutes.

CLOCK_MONOTONIC_RAW is not affected by this correction progress, so it
should gives better results. Or not?

> > You wrote that this clock is subject to drifts. What exactly may happen
> > with CLOCK_MONOTONIC_RAW?
> 
>   1) As the frequency of the raw clock is an estimate, resulting time
>      is drifting apart vs. the correct frequency.
> 
>   2) Depending on the crystal/oszillator there can be temperatur drift as
>      well.
> 
> Just for clarification. Even with NTP/PTP adjustment the resulting time
> stamps are never going to be precise vs. an atomic clock, but good
> enough for 99.9999% of the problems.

Ok, so it looks like that CLOCK_MONOTONIC_RAW is not the best choice.

> TBH, I have no idea what real world problem you are trying to solve.

Problem is simple: Measure time difference between two events and not to
be affected by the fact that system clock on machine is incorrect or
that time daemon is actually adjusting time.

I need to know if difference between those two events in more then some
period or not.

So if I want to know if time difference is more then 5 hours and 40
minutes then measurement via clock which is affected by NTP adjustment
would give me wrong result. As described above in reality 6 hours
passed but clock measured only 5 hours and 20 minutes.

> Thanks,
> 
>         tglx
