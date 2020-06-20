Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231C5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0103B246AC
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IUS6AQle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgFTVDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 17:03:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34650 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgFTVDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 17:03:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id v3so5502776wrc.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 14:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UK/b7D+TDaCrVMB4MYWyMIM/SEpzN9NfRE/O/U09lk0=;
        b=IUS6AQleG8J86Jl3eO1WPPrNKiihvwPmbT3TAVkX9ztHwed8GfqxXsyfuSTcCJbcVi
         em2pYl0DD42GoU5DiOJLoORK26wRmHBurp/rnSfBzn6SQgdQftiWgIMC7+fXP2wdFLJ2
         /2sJha/Sxg4TQ1KPUU1c3/Wmk8OhuLmViyI5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UK/b7D+TDaCrVMB4MYWyMIM/SEpzN9NfRE/O/U09lk0=;
        b=roi/cNknfgttzb7QE8pyXlP/fDcFhJnLSvg7DOazlca03Qq0UQwqqbjAlvy68QnSzp
         Oj10twPIBqu7d7xgCjuyawjECu95yDDDjLBXmru7kSCZFtF1l+TGG29vk5JzTfi5YIcl
         S7ji9W7mMKDXvWbAWoOwDJj25H2nwu+OGxY8ZUUTpJQDc97Ntx3rTg9P37TSXL9ItG2B
         qmjAYSXfYU2aSETb1oa8cjOd0MfKeJF+y8Ziehp5M8WNTZpORu6xCCJG6TaDa2oCwJLi
         xEfv5TXoVgLt0juK4j6npCrx3AGWiDqTPXa8qszZAU/rA3o/YgV7kU9bZINU3CG/UT7B
         EQ2g==
X-Gm-Message-State: AOAM533iY1uWuLDE5NthLiahIAfo+M3u78r7d/U53/JIXTMMR5M+cYB9
        0ex2V0Yf3dZeD9OCjQANFyWG9ugJrYDMhSQU1Qww/g==
X-Google-Smtp-Source: ABdhPJwne0faQxsH1AV+Rbyt9DjggiwqGRPOyyks3+UnxD4RvMo3kd9QadfLQ7IwwR7btf52DKKCa9bzgz6I0S/v4xM=
X-Received: by 2002:a5d:470b:: with SMTP id y11mr1563972wrq.101.1592686966821;
 Sat, 20 Jun 2020 14:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200619164132.1648-1-ignat@cloudflare.com> <20200619165548.GA24779@redhat.com>
 <alpine.LRH.2.02.2006191429060.23991@file01.intranet.prod.int.rdu2.redhat.com>
 <20200620012332.GA25340@gondor.apana.org.au> <alpine.LRH.2.02.2006201535280.24999@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2006201535280.24999@file01.intranet.prod.int.rdu2.redhat.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Sat, 20 Jun 2020 22:02:36 +0100
Message-ID: <CALrw=nHZK7JhUO+-vAeMxCZqTBGBkWckBeg56pFuc1bo6yep6A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] dm-crypt excessive overhead
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, dm-crypt@saout.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it should.

I got one when I was testing the first iteration (without the tasklet)
of the patch on an NVME? disk.

On Sat, Jun 20, 2020 at 8:36 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Sat, 20 Jun 2020, Herbert Xu wrote:
>
> > On Fri, Jun 19, 2020 at 02:39:39PM -0400, Mikulas Patocka wrote:
> > >
> > > I'm looking at this and I'd like to know why does the crypto API fail in
> > > hard-irq context and why does it work in tasklet context. What's the exact
> > > reason behind this?
> >
> > You're not supposed to do any real work in IRQ handlers.  All
> > the substantial work should be postponed to softirq context.
>
> I see.
>
> BTW - should it also warn if it is running in a process context with
> interrupts disabled?
>
> Mikulas
>
> > Why do you need to do work in hard IRQ context?
> >
> > Cheers,
> > --
> > Email: Herbert Xu <herbert@gondor.apana.org.au>
> > Home Page: http://gondor.apana.org.au/~herbert/
> > PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> >
>
