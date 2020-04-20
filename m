Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78249C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 04:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4118F20724
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 04:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="nISDxD3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgDTEtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 00:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgDTEtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 00:49:17 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEFDC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 21:49:17 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id pg17so6816118ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 21:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bYADXM3fnqTfOLHn4Df6MYywErUdtpTsT63FwdWOqRk=;
        b=nISDxD3HO2jVVJbdvMhiaYcZtVzlGcweDRXzQY92JFIkrrQ7r/xRLigEEOLCujOL+I
         hG9XJbHC8L03WDMy90kKhhG5++FUfqGBeDWN7uGC4p9/ldHu9J3u74miQSCAfK7qWa0n
         lbNvMbMpMN2lq9MDNLSr0dyqgCTQfNdzI1B5p6kZ1JGEJ3PJPohL17GTbeNDIqR+o/ah
         /D1uxeYF+nsnbnA8wvGfsrhW0RriE5UuKNuexQ5IGSb6uwKoyeE3qodhdhtsHkfS91r/
         d8gjqFSrkUeBH5BoicjM4RpME5ipKP9pXu6Lg9CsEtnsRcHbRGDowZN1WeYx7YLu9zwz
         LQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bYADXM3fnqTfOLHn4Df6MYywErUdtpTsT63FwdWOqRk=;
        b=AorFdyhPmWYfft10jTCCEnjwnz6EmKE1mErm26Wk0m7nJpxC5j3ORpw89kOx8NVUxl
         aaHErcSq+Hw1GOLCbpAqtK0ugZFRnKqQa6zvtfOsRjHLT2NLqRkzs+HH5c6OfGXKeqyR
         9bxJMkO5kykbT99H8Dx+W/ru1FoSTZdex8yo6VKqEfzLM/daW3iwOLOdVbFC2KzL24o6
         EGPY8U9ItIAsqpdchVW7TKIiIAWa/FjInxVOAqEm7b26tEzjwZnuVmRt+YzQcF/E1nw3
         9tvH/k2ApITZdBBji0gJ2mtZvh2+6D0ZDKgLaWiier+1WwmjWo/0/Oqz5HBGCBiZM76A
         5WCw==
X-Gm-Message-State: AGi0PuZh9FZopxuOp2r9yCph84C/fsW7tsSAAr11p1RhEs5e+8uASl1n
        SKPyQJw/J1FCXpCzgLXaq6ct29YwqY9jMmFVXzL9LA==
X-Google-Smtp-Source: APiQypJjK+fbgyqJBENqgkXJyIItyuRieCz/uLksLTOhvGqapOfk0h8cn5GHx2HeZyprYusoat++oP3HC9G0314tHNg=
X-Received: by 2002:a17:906:90cc:: with SMTP id v12mr14356816ejw.211.1587358155985;
 Sun, 19 Apr 2020 21:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4goJ2jbXNVZbMUKtRUominhuMhuTKrMh=fnhrfvC4jyjw@mail.gmail.com>
 <alpine.LRH.2.02.2004081439080.13932@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4grNHvyYEc4W6PkymhEJvLb17tXbC3JZdqvtFxmMZ8DCQ@mail.gmail.com>
 <alpine.LRH.2.02.2004090612320.27517@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2004160411460.7833@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gpe8u=zNrRhvd9ioVNGbOJfRUXzFZuV--be6Hbj0xXtQ@mail.gmail.com>
 <alpine.LRH.2.02.2004170831530.16047@file01.intranet.prod.int.rdu2.redhat.com>
 <69c2e011c5814255926f309dd50e6d67@AcuMS.aculab.com> <alpine.LRH.2.02.2004181110160.30139@file01.intranet.prod.int.rdu2.redhat.com>
 <8452b36a07b1440a8da6d4a1623858c1@AcuMS.aculab.com>
In-Reply-To: <8452b36a07b1440a8da6d4a1623858c1@AcuMS.aculab.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 19 Apr 2020 21:49:05 -0700
Message-ID: <CAPcyv4gP4gt7EF8q0hxSvENLATrK8ZEt3uQiUNh8zRNoJ_Ut6A@mail.gmail.com>
Subject: Re: [PATCH] x86: introduce memcpy_flushcache_clflushopt
To:     David Laight <David.Laight@aculab.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 10:49 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Mikulas Patocka
> > Sent: 18 April 2020 16:21
> >
> > On Sat, 18 Apr 2020, David Laight wrote:
> >
> > > From: Mikulas Patocka
> > > > Sent: 17 April 2020 13:47
> > > ...
> > > > Index: linux-2.6/drivers/md/dm-writecache.c
> > > > ===================================================================
> > > > --- linux-2.6.orig/drivers/md/dm-writecache.c     2020-04-17 14:06:35.139999000 +0200
> > > > +++ linux-2.6/drivers/md/dm-writecache.c  2020-04-17 14:06:35.129999000 +0200
> > > > @@ -1166,7 +1166,10 @@ static void bio_copy_block(struct dm_wri
> > > >                   }
> > > >           } else {
> > > >                   flush_dcache_page(bio_page(bio));
> > > > -                 memcpy_flushcache(data, buf, size);
> > > > +                 if (likely(size > 512))
> > > > +                         memcpy_flushcache_clflushopt(data, buf, size);
> > > > +                 else
> > > > +                         memcpy_flushcache(data, buf, size);
> > >
> > > Hmmm... have you looked at how long clflush actually takes?
> > > It isn't too bad if you just do a small number, but using it
> > > to flush large buffers can be very slow.
> >
> > Yes, I have. It's here:
> > http://people.redhat.com/~mpatocka/testcases/pmem/microbenchmarks/pmem.txt
> >
> > sequential write 8 + clflush  - 0.3 GB/s on nvdimm
> > sequential write 8 + clflushopt - 1.6 GB/s on nvdimm
> > sequential write-nt 8 bytes   - 1.3 GB/s on nvdimm
>
> That table doesn't give enough information to be useful.
> The cpu speed, memory speed and transfer lengths are all relevant.
>
> > > I've an Ivy bridge system where the X-server process requests the
> > > frame buffer be flushed out every 10 seconds (no idea why).
> > > With my 2560x1440 monitor this takes over 3ms.
> > >
> > > This really needs a cond_resched() every few clflush instructions.
> > >
> > >     David
> >
> > AFAIK Ivy Bridge doesn't have clflushopt, it only has clflush. clflush
> > only allows one outstanding cacle line flush, so it's very slow.
> > clflushopt and clwb relaxed this restriction and there can be multiple
> > cache-invalidation requests in flight until the user serializes it with
> > the sfence instruction.
>
> It isn't that simple.
> While clflush on Ivybridge is slower than clflushopt on newer processors
> both instructions are (relatively) fast for something like 16 or 32
> iterations. After that they get much slower.
> I can't remember where I found the relevant figures, even the ones I
> found didn't show how large the transfers needed to be before the bytes/sec
> became constant.
>
> > The patch checks for clflushopt with
> > "static_cpu_has(X86_FEATURE_CLFLUSHOPT)" and if it is not present, it
> > falls back to non-temporal stores.
>
> Ok, I was expecting you'd be falling back to clflush first.

clflush is a serializing instruction, clflushopt and non-temporal
stores are not.
