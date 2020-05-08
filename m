Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DB1C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E35922145D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="I6vmXTbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEHMHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:07:15 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:60091 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgEHMHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:07:15 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 76154c00
        for <linux-kernel@vger.kernel.org>;
        Fri, 8 May 2020 11:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=DRgmOZ/pXwQ/5lwVfB4YHbJj45o=; b=I6vmXT
        bN5MOJ0Iiit/gr1I5M01cRzInKwgUcr2MpIOqYfNc3rjh/Wp2etLj/9MdEFcmku/
        PPPCR8w+jzUzLaUMqvoYPjhnGSZogzAdUH8JPImWNju3YglhsTBSpkOVwW5krRkl
        Ah4QCz6HoC6ykmihbgyaS1JXZAM8tkPJt7i7yUQ1q7LskWruczxeb8wP1FG3vhYQ
        egQDWtsp+RibqBD7lyUk+O0/agdVIWZxsYm500cisMvcuc3tNbvOHdxnCdKYsXJ9
        5yha71h54ZxQ275cQhjRzkDnVN/wrvjKoveaN/GaPkQFhEsYV53AVz/dBp1qFZHw
        o8CGEBf4hPVSTsdQ==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9f0bd178 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 8 May 2020 11:54:18 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id m5so1147837ilj.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 05:07:14 -0700 (PDT)
X-Gm-Message-State: AGi0PuaLi//ItJBxzmHH+s0rezCa9W4rldWPZkU11JYu61WSuyxgDdVn
        T+bCgmIQTRxtuwCpwYdAn4DLypL36FQV9L+H1ug=
X-Google-Smtp-Source: APiQypIEXTa/LG7yKrFyK4yQ3doD2b7IYLYXUKP++h7OW0tY/Hch5VlrZsdwjRbzGSjKaE9gMgOh5VVvgjJoviZeMu8=
X-Received: by 2002:a92:5c82:: with SMTP id d2mr2428758ilg.231.1588939633367;
 Fri, 08 May 2020 05:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200507224530.2993316-1-Jason@zx2c4.com> <20200508090202.7s3kcqpvpxx32syu@butterfly.localdomain>
 <CAHmME9pTZTa9AEUL0-ojTr7P-F7NYe8OR9=-GBPaQNpnSDrEiw@mail.gmail.com>
 <20200508113336.2vdfdnc6tqyx4pu6@butterfly.localdomain> <CAK8P3a0dJ0vNnktcoWFiPKB4NJbeyf7nvwWf0YLyeUyxT5pvQg@mail.gmail.com>
In-Reply-To: <CAK8P3a0dJ0vNnktcoWFiPKB4NJbeyf7nvwWf0YLyeUyxT5pvQg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 8 May 2020 06:07:02 -0600
X-Gmail-Original-Message-ID: <CAHmME9p7Hri-vHfwR9GY1gPo91jVx4-hTqsZVRHiioUENRHibA@mail.gmail.com>
Message-ID: <CAHmME9p7Hri-vHfwR9GY1gPo91jVx4-hTqsZVRHiioUENRHibA@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for
 gcc >= 10
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 5:56 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, May 8, 2020 at 1:33 PM Oleksandr Natalenko <oleksandr@redhat.com> wrote:
> >
> > On Fri, May 08, 2020 at 05:21:47AM -0600, Jason A. Donenfeld wrote:
> > > > Should we untangle -O3 from depending on ARC first maybe?
> > >
> > > Oh, hah, good point. Yes, I'll do that for a v2, but will wait another
> > > day for feedback first.
> >
> > Just keep in mind that my previous attempt [1] failed because of too
> > many false positive warnings despite -O3 really uncovered a couple of
> > bugs in the codebase.
>
> I think my warning fixes were mostly picked up in the meantime, but
> if there are any remaining, they would be mixed in with random other
> fixes in my testing tree, so it's hard to know for sure.
>
> I also want to hear the feedback from the gcc developers about what
> the general recommendations are between O2 and O3, and how
> they may have changed over time. According to the gcc-10 documentation,
> the difference between -O2 and -O3 is exactly this set of options:
>
> -fgcse-after-reload
> -fipa-cp-clone
> -floop-interchange
> -floop-unroll-and-jam
> -fpeel-loops
> -fpredictive-commoning
> -fsplit-loops
> -fsplit-paths
> -ftree-loop-distribution
> -ftree-loop-vectorize
> -ftree-partial-pre
> -ftree-slp-vectorize
> -funswitch-loops
> -fvect-cost-model
> -fvect-cost-model=dynamic
> -fversion-loops-for-strides

The other significant thing -- and what prompted this patchset -- is
it looks like gcc 10 has lowered the inlining degree for -O2, and put
gcc 9's inlining parameters from -O2 into gcc-10's -O3.
