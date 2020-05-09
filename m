Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A27C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C427E214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEIJtc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 05:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726012AbgEIJtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 05:49:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F39C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 02:49:31 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jXM6p-00059X-S6; Sat, 09 May 2020 11:49:28 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 48117100C8A; Sat,  9 May 2020 11:49:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Missing CLOCK_BOOTTIME_RAW?
In-Reply-To: <20200508213122.f7srcd2gnduamtvs@pali>
Date:   Sat, 09 May 2020 11:49:27 +0200
Message-ID: <87zhah4evs.fsf@nanos.tec.linutronix.de>
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

Pali,

Pali Rohár <pali@kernel.org> writes:
> On Friday 08 May 2020 22:59:57 Thomas Gleixner wrote:
>> Pali Rohár <pali@kernel.org> writes:
>> Neither CLOCK_BOOTTIME nor CLOCK_MONOTONIC jump. They are frequency
>> corrected when NTP, PTP or PPS are in use. The frequency correction is
>> incremental an smothed. They really don't jump and they give you proper
>> time in nanoseconds which is as close to the real nanoseconds as it
>> gets.
>
> Hello! I should have been more precise about it. CLOCK_BOOTTIME and
> CLOCK_MONOTONIC do not jump but I understood that they are affected by
> adjtime(). So these clocks may tick faster or slower than real time. NTP
> daemon when see that CLOCK_REALTIME is incorrect, it may speed up or
> slow down its ticking. And this is affected also by CLOCK_BOOTTIME and
> CLOCK_MONOTONIC, right?

Sure, but what's the problem? The adjustemt is done to make the observed
time as correct as possible.

> You wrote that this clock is subject to drifts. What exactly may happen
> with CLOCK_MONOTONIC_RAW?

  1) As the frequency of the raw clock is an estimate, resulting time
     is drifting apart vs. the correct frequency.

  2) Depending on the crystal/oszillator there can be temperatur drift as
     well.

Just for clarification. Even with NTP/PTP adjustment the resulting time
stamps are never going to be precise vs. an atomic clock, but good
enough for 99.9999% of the problems.

TBH, I have no idea what real world problem you are trying to solve.

Thanks,

        tglx
