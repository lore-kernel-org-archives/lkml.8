Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CF5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106B020776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gprvDCD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgE2J6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2J6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:58:01 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE99C08C5C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 02:58:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l27so1504714ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 02:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=99pOzzXbN5adJubUzcJGXQQVBGmFL/nmnlnO5ZMkTJo=;
        b=gprvDCD/kRqOIy/BgHi73ZOyKU+h3Vg37a1mXEhQlyYlrku3TB6/A76nUIjpaO1btt
         EQke9n3jMnQ/wZAeMgOMUcfevQ0bxQ5mrKEX6oYqc3jJn6VP9WIwAMmPKFTMJdRJ7g16
         1atubjMdmy4paGmVrxzOP5bb7C99Mhzjc1+sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99pOzzXbN5adJubUzcJGXQQVBGmFL/nmnlnO5ZMkTJo=;
        b=YGf2fmrtmyYdZ/g6ukvZCmp1d509kSYAIkQQjg2rCYEBpGkpAomal0d7E+h62QV975
         EO9Yb9ufo82m3/+y8YFW71cY3j9PI6aVft0XVnSB2tDVmTi4ntPs43VVZLS3sDAsgI2t
         ghn3XJGiVgVzVZMGlt0L9zYsz+SbZMI//+zG/0qM3jXaitUv4SeB0T3MlB30TcGeyxLb
         ZQ4g5xHYfKVS+UY6ZejliCJN9dDsOGSbANKfIDlCz1XXo52B3dUWYDPw9kJ8gwAr3Cbm
         65+qW7fscJB5MZLrVWldavwChvgyWEWu7e+N+tj4qm6qhWDRQlQyN7guwgKZ2WICuV7R
         akrw==
X-Gm-Message-State: AOAM531KNLGyz0cVa6SIciNs4yM21QPw4sZOB1hybXwtoucR0V7CJrIz
        fAu39XbeVuaoMm9/VEkAmSwt9UXc++eTDK3k7MjfB45k0f7VnQ==
X-Google-Smtp-Source: ABdhPJyb/rBlZlBbzxI1OWPb1qBLaJ06N49Sr4s+4Q+qqtyiGbwnxNhE0Ti1HY50v9eJThFRtvBgzAEfY0HHuTPZLDQ=
X-Received: by 2002:a17:907:20d9:: with SMTP id qq25mr6687153ejb.202.1590746278813;
 Fri, 29 May 2020 02:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegstNYeseo_C4KOF9Y74qRxr78x2tK-9rTgmYM4CK30nRQ@mail.gmail.com>
 <875zcfoko9.fsf@nanos.tec.linutronix.de> <CAJfpegsjd+FJ0ZNHJ_qzJo0Dx22ZaWh-WZ48f94Z3AUXbJfYYQ@mail.gmail.com>
In-Reply-To: <CAJfpegsjd+FJ0ZNHJ_qzJo0Dx22ZaWh-WZ48f94Z3AUXbJfYYQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 29 May 2020 11:57:45 +0200
Message-ID: <CAJfpegv0fNfHrkovSXCNq5Hk+yHP7usfMgr0qjPfwqiovKygDA@mail.gmail.com>
Subject: Re: system time goes weird in kvm guest after host suspend/resume
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 11:51 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, May 28, 2020 at 10:43 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Miklos Szeredi <miklos@szeredi.hu> writes:
> > > Bisected it to:
> > >
> > > b95a8a27c300 ("x86/vdso: Use generic VDSO clock mode storage")
> > >
> > > The effect observed is that after the host is resumed, the clock in
> > > the guest is somewhat in the future and is stopped.  I.e. repeated
> > > date(1) invocations show the same time.
> >
> > TBH, the bisect does not make any sense at all. It's renaming the
> > constants and moving the storage space and I just read it line for line
> > again that the result is equivalent. I'll have a look once the merge
> > window dust settles a bit.
>
> Yet, reverting just that single commit against latest linus tree fixes
> the issue.  Which I think is a pretty good indication that that commit
> *is* doing something.
>
> The jump forward is around 35 minutes; that seems to be consistent as well.

Oh, and here's a dmesg extract for the good case:

[   26.402239] clocksource: timekeeping watchdog on CPU0: Marking
clocksource 'tsc' as unstable because the skew is too large:
[   26.407029] clocksource:                       'kvm-clock' wd_now:
635480f3c wd_last: 3ce94a718 mask: ffffffffffffffff
[   26.407632] clocksource:                       'tsc' cs_now:
92d2e5d08 cs_last: 81305ceee mask: ffffffffffffffff
[   26.409097] tsc: Marking TSC unstable due to clocksource watchdog

and the bad one:

[   36.667576] clocksource: timekeeping watchdog on CPU1: Marking
clocksource 'tsc' as unstable because the skew is too large:
[   36.690441] clocksource:                       'kvm-clock' wd_now:
89885027c wd_last: 3ea987282 mask: ffffffffffffffff
[   36.690994] clocksource:                       'tsc' cs_now:
95666ec22 cs_last: 84e747930 mask: ffffffffffffffff
[   36.691901] tsc: Marking TSC unstable due to clocksource watchdog

Thanks,
Miklos
