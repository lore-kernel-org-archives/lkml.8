Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D67CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339A22053B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgFEKMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFEKMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:12:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849E2C08C5C2;
        Fri,  5 Jun 2020 03:12:09 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jh9KT-00021g-M4; Fri, 05 Jun 2020 12:12:01 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 2D2B9101090; Fri,  5 Jun 2020 12:11:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     kvm@vger.kernel.org, Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: system time goes weird in kvm guest after host suspend/resume
In-Reply-To: <1a1c32fe-d124-0e47-c9e4-695be7ea7567@redhat.com>
Date:   Fri, 05 Jun 2020 12:11:59 +0200
Message-ID: <87k10l7rf4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:
> On 04/06/20 21:28, Miklos Szeredi wrote:
>> time(2) returns good time, while clock_gettime(2) returns bad time.
>> Here's an example:
>> 
>> time=1591298725 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
>> time=1591298726 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
>> time=1591298727 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
>> time=1591298728 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
>> time=1591298729 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
>> 
>> As you can see, only time(2) is updated, the others remain the same.
>> date(1) uses clock_gettime(CLOCK_REALTIME) so that shows the bad date.
>> 
>> When the correct time reaches the value returned by CLOCK_REALTIME,
>> the value jumps exactly 2199 seconds.

Which value jumps?

> clockid_to_kclock(CLOCK_REALTIME) is &clock_realtime, so clock_gettime
> calls ktime_get_real_ts64, which is:
>
>
>         do {
>                 seq = read_seqcount_begin(&tk_core.seq);
>
>                 ts->tv_sec = tk->xtime_sec;
>                 nsecs = timekeeping_get_ns(&tk->tkr_mono);
>
>         } while (read_seqcount_retry(&tk_core.seq, seq));
>
>         ts->tv_nsec = 0;
>         timespec64_add_ns(ts, nsecs);
>
> time(2) instead should actually be gettimeofday(2), which just returns
> tk->xtime_sec.

time(2) is either handled in the VDSO or it is handled via syscall and
yes, it's only looking at the xtime_sec value.

gettimeofday(2) returns seconds and microseconds. It's using the same
mechanism as clock_gettime(2) and divides the nanoseconds part by 1000.

> So the problem is the nanosecond part which is off by
> 2199*10^9 nanoseconds, and that is suspiciously close to 2^31...

Not really. It's 2^41.

I can actually now reproduce, but I won't be able to investigate that
before monday.

Thanks,

        tglx
