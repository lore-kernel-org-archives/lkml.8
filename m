Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD123C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67DD218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgEHVAA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHVAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:00:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579F6C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 14:00:00 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jXA6A-0003Pr-8E; Fri, 08 May 2020 22:59:58 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A2C5B101175; Fri,  8 May 2020 22:59:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Missing CLOCK_BOOTTIME_RAW?
In-Reply-To: <20200508201859.vlffp4fomw2fr4qc@pali>
References: <20200508201859.vlffp4fomw2fr4qc@pali>
Date:   Fri, 08 May 2020 22:59:57 +0200
Message-ID: <878si2jg6q.fsf@nanos.tec.linutronix.de>
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

> I'm looking at clocks which are provided by kernel for userspace
> applications via clock_gettime() syscall and I think that there is
> missing clock variant CLOCK_BOOTTIME_RAW.
>
> If userspace application wants to measure time difference between two
> events then I think all of available clocks CLOCK_REALTIME,
> CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW and CLOCK_BOOTTIME have some issues
> for such task.
...
> CLOCK_BOOTTIME is affected by NTP jumps but provides correct time
> difference when system was suspended during measurement.

What do you mean with NTP jumps?

Neither CLOCK_BOOTTIME nor CLOCK_MONOTONIC jump. They are frequency
corrected when NTP, PTP or PPS are in use. The frequency correction is
incremental an smothed. They really don't jump and they give you proper
time in nanoseconds which is as close to the real nanoseconds as it
gets.

CLOCK_MONOTONIC_RAW converts some assumed clock frequency into something
which looks like time. But it's raw and subject to drift. The only
reason why it's exposed is because NTP/PTP need it to calculate the
frequency difference between the hardware counter and the master clock.

> So for me it looks like that there is missing CLOCK_BOOTTIME_RAW clock
> which would not be affected by NTP jumps (like CLOCK_MONOTONIC_RAW) and
> also would not be affected by system suspend (like CLOCK_BOOTTIME).
>
> Please correct me if I'm wrong in some of my above assumptions. It is
> how I understood documentation for clock_gettime() function from Linux
> manpage.

I don't know how you read jumps into this:

  CLOCK_MONOTONIC

   Clock that cannot be set and represents monotonic time since some
   unspecified starting point.  This clock is not affected by
   discontinuous jumps in the system time (e.g., if the system
   administrator manually changes the clock), but is affected by the
   incremental adjustments performed by adjtime(3) and NTP.

And CLOCK_BOOTTIME is the same except that it accounts time in suspend
while MONOTONIC stops in suspend.

> Is there any reason why kernel does not provide such CLOCK_BOOTTIME_RAW
> clock for userspace applications which would be interested in measuring
> time difference which occurred between two events?

Nobody needs it and there is even no guarantee that it can be
reconstructed on resume.

If you want accurate time deltas then use either CLOCK_MONOTONIC or
CLOCK_BOOTTIME depending on your interest in suspend time.

Thanks,

        tglx
