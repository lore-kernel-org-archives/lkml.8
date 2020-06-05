Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A26C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D3F02075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GrDjQ6zP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgFEHfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 03:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgFEHfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 03:35:54 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B853C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 00:35:54 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t21so3982097edr.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 00:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1VjCE6/abJfOjLL4MnyYsiz/bdxeCMpDRWtyEIY5Fyw=;
        b=GrDjQ6zPgb16rLW77/79xBB9WwKwYgNQW0eQ4bbNWbMyOhQ8j7jNHuUga/T8Y/O5+o
         LEV8M9mKQY9uN+Q13VCK1oXtLwp8Qw6kEn4y91vPG/8jRoPNoblgbdO92pL0bXcLNzwS
         89t2zun8h0tJIN9iGV7yFhvNW27g88kRjymm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1VjCE6/abJfOjLL4MnyYsiz/bdxeCMpDRWtyEIY5Fyw=;
        b=IRPujfRQe86E/q6A5p9NGdYWrKz0HLn+4HrAalYlqyWdmto047Zin9iJIEngj3k83O
         SBs1JuQVJVNPRtSa+AChlZX/1uXMI/BfFQ/G/oYUshPftZBnF/EwjNQU9KY1OuqernHW
         M3C19pIiSLfAhg6UKAfOIbwGmfIcOlQiWZRKcGKoOVHO/2pXGObKxsdJV2ln2A5Mzmns
         50XkeOaeQOUTy/yB+nJw/p3F15wg3Zhvwr71qH+W/Sf5Xk3kAVQzfAw0j8z8qiX/dccN
         lcA61MRs5YIgaB9q26pauA6J66lDqPDA6R15GznoNUHJIqDxzWTrDUazLn8KEx/xE1s+
         ancQ==
X-Gm-Message-State: AOAM530R7FKS3diGvNbaueuP0dSRUmItG37n+MWxlgdx/LhHW4SIRXNx
        JK9hMszFhU+gEa6gqnBzw5HLj7A0AoJp4IA6HMwlXQ==
X-Google-Smtp-Source: ABdhPJzF3V4dXMFZl2VWWJFZ3s9Hxf+Fd4rb1Plh76REgsxPIq/XrVM8nWrdZKSeJwZMp0q1uOT7SCZxu+EUnANBlVE=
X-Received: by 2002:a50:ee8f:: with SMTP id f15mr8081524edr.168.1591342552038;
 Fri, 05 Jun 2020 00:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <87pnagf912.fsf@nanos.tec.linutronix.de> <87367a91rn.fsf@nanos.tec.linutronix.de>
 <CAJfpegvchB2H=NK3JU0BQS7h=kXyifgKD=JHjjT6vTYVMspY2A@mail.gmail.com> <1a1c32fe-d124-0e47-c9e4-695be7ea7567@redhat.com>
In-Reply-To: <1a1c32fe-d124-0e47-c9e4-695be7ea7567@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 5 Jun 2020 09:35:40 +0200
Message-ID: <CAJfpegvwBx49j9XwJZXcSUK=V9oHES31zB2sev0xwS4wfhah-g@mail.gmail.com>
Subject: Re: system time goes weird in kvm guest after host suspend/resume
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 10:14 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 04/06/20 21:28, Miklos Szeredi wrote:
> > time(2) returns good time, while clock_gettime(2) returns bad time.
> > Here's an example:
> >
> > time=1591298725 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
> > time=1591298726 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
> > time=1591298727 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
> > time=1591298728 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
> > time=1591298729 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
> >
> > As you can see, only time(2) is updated, the others remain the same.
> > date(1) uses clock_gettime(CLOCK_REALTIME) so that shows the bad date.
> >
> > When the correct time reaches the value returned by CLOCK_REALTIME,
> > the value jumps exactly 2199 seconds.
>
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
> tk->xtime_sec.  So the problem is the nanosecond part which is off by
> 2199*10^9 nanoseconds, and that is suspiciously close to 2^31...

Yep: looking at the nanosecond values as well, the difference is
exactly 2199023255552 which is 2^41.

Thanks,
Miklos
