Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80653C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6590F2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgGFHyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:54:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33671 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbgGFHyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 03:54:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id h13so10417603otr.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 00:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LD+h1ou7CMJWkRCFX30pCtLbgBWxfUAHgmEH8FmfFc=;
        b=lRnRnJx0EEbb/5r0Vu+FR1Dq4InzqT3/p6GYupCTE4p9zFpyXabwBtccaMfUe59+R3
         UPyrlv6ijx5xsGRKvv+gWd1rdmuolRC8810YoPoXVAYGJv2wP6DsxIVootMvZVnmhmDR
         J3ZZuzDACOEm5MvGSjcsPHCiDrNf9Rw8uhSRfHKcS9A5EZkpGfwouyTc58ymW+Xzg28c
         NrqVA7CHD3wsBr3z5A7L9gxG9h9IKI3pM+rzPZrOdT/Mls+rnppIwmS8chlrRDG+zd2w
         4nT3HEFT+5a2yXPvqdUcsorozr99XpOpvQamkEc1DcFttG9gZCzv6MKEtrYpHK7UUxlO
         jlhg==
X-Gm-Message-State: AOAM5335hg9aIrvHV59/uBmrU2S89tUjdlhYHq1twS9rK67U/AY6ecie
        KZXtZAc8gwxWuo12QGHa0So0AMjP6AH9+UUbtn59JEJGiP8=
X-Google-Smtp-Source: ABdhPJyDOZ21sDaaK43TlEvNWaB21raXUjSfvE1nLN0SOasbrMzZp2l0MTob81KSQ7yvXH6iW8pjFalfbAoIiPAkjrI=
X-Received: by 2002:a05:6830:1451:: with SMTP id w17mr28084181otp.250.1594022047849;
 Mon, 06 Jul 2020 00:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAFhKne_ZVWVhZX5hNEbeGBfU6BMRN9JKQeTsVYOcMmEH1cd3xg@mail.gmail.com>
 <87h7ul15le.fsf@notabene.neil.brown.name> <20200706072221.GA1947246@kroah.com>
In-Reply-To: <20200706072221.GA1947246@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Jul 2020 09:53:55 +0200
Message-ID: <CAMuHMdWj2d5GF1ZkuhzQxg9teA51zjF0oQQPWcphzK=kJ6-x9Q@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     NeilBrown <neilb@suse.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 9:22 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Jul 06, 2020 at 05:10:37PM +1000, NeilBrown wrote:
> > On Sat, Jul 04 2020, Matthew Wilcox wrote:
> > > Another suggestion for "slave" replacement should be "device". This is in
> > > the context of the w1 bus which is by far the largest user of the
> > > master/slave terminology in the kernel.

W1 the largest? Really?

> >
> > Ugh.  Please, no.  "device" doesn't mean anything, in that you can use
> > it to refer to any thing.  (i.e. it is almost semantically equivalent to
> > "thing").
>
> Context is everything, you can have a "controller" and a "device" that
> the controller controls.  These are common terms in many specs today,

A "controller" is also any block of electronics that performs a function
involving a state machine.
So for SPI and I2C, we'll have Linux drivers talking to an "SPI controller
controller", an "SPI device controller", an "I2C controller controller",
and an "I2C device controller".
For W1, Linux is still limited to supporting "W1 controller controllers",
but supporting "W1 device controllers" might be just beyond the horizon...

> look at the USB spec for an example of these terms being used in this
> way for many decades.

And when does the "gadget" enter the show? ;-)

P.S. In Dutch, we just assimilate all English technical words, and
     they'll only have that specific meaning.  E.g. if someone
     talks about the "cloud", even lay people know they're not talking
     about those things that may ruin your holiday outside.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
