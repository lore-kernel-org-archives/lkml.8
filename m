Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C65C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 12:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421E520757
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 12:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdUOwg33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgC2MWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 08:22:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42771 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgC2MWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 08:22:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id 22so7162620pfa.9;
        Sun, 29 Mar 2020 05:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UClIPWeDMQPAzXntBk2QoHfbWj9MDU21yOBf0GHeHw=;
        b=jdUOwg337Wg8hPuF5NdV1z+1iXNGjwb+YDUmS97pf9xkU/BWMOmRa8gpqg/wHMmz2a
         h58yHx1+HaoLmCL6hnIeTPqm+2YMk9XzXIgi8Vgh9+ZM41zzixi1r10H3tUGl6hbw2fa
         +/SCEv5PddejDs3d49ieJ06lzLGUMqG9GyxGvtAAn6VGkc3VIzvQFeTpteUPogXC2Pzf
         Nck2ZgMO6TY1u9JXPbiayQdMPaVsYZN0gYMyxOTiZ2uHnfym+nSJ5RCtbfwJVF5O2hRj
         FXgxRY9UmwUvEuFr258gE1lMF0n3PSTtd9BUt9ycNv+7B5vOzdWySiaKBoIv9i+HiGuE
         66Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UClIPWeDMQPAzXntBk2QoHfbWj9MDU21yOBf0GHeHw=;
        b=KnEe6XjPVjmNADNjUjazYFiieYsEpGXBrvx734J77qKEV74h7t1VVqZ+nDksLazaC4
         QKgn+cMIpVqPNG5RCUZTTeSXSxqkxt+gDHnz8F6iqeWAHwUfP2OOEYT1XCvYxHPa4Z7t
         /ajQeKH6GFa9uotjWYec9CCf1Y2aNhgnUjV/2DkOwVb1Ygm6B+CrZXtzJu7uu/LpVfHe
         lepCJabgYeRi57lvxhjdt3ysLjdbgokwId2ER/IHJK/ln3rz9K+QyRwjQGMyoxuz4Aak
         QPLM/mrT9LilH7CG9PA6hfT3RcA48lsCBlmqnYoyyNhdaSo/MMQVLkwDkyxviQF+7EzX
         qGgQ==
X-Gm-Message-State: ANhLgQ1U/0zf2lpPzYbVrDLusyT3qAZBiW4hfKVmViIGdCJUPICJLte9
        DFTdkENCCbxP/uKVNypcgizCvtl1iSpb1I01dx0=
X-Google-Smtp-Source: ADFU+vtdWfniuNTMK9Zagqw0FyohZmWEmZi+NzvusNKnAyqgygrL2tuE+ttN/w5nkf3Xdl0gmeaKUfp8hzr43IbRckI=
X-Received: by 2002:a63:798a:: with SMTP id u132mr8699746pgc.203.1585484573149;
 Sun, 29 Mar 2020 05:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200329092204.770405-1-jbwyatt4@gmail.com> <alpine.DEB.2.21.2003291127230.2990@hadrien>
 <2fccf96c3754e6319797a10856e438e023f734a7.camel@gmail.com>
 <alpine.DEB.2.21.2003291144460.2990@hadrien> <CAMS7mKBEhqFat8fWi=QiFwfLV9+skwi1hE-swg=XxU48zk=_tQ@mail.gmail.com>
 <alpine.DEB.2.21.2003291235590.2990@hadrien> <ab06bc216dc07b2b070bc2635aaabb1942c6089c.camel@gmail.com>
In-Reply-To: <ab06bc216dc07b2b070bc2635aaabb1942c6089c.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 29 Mar 2020 15:22:41 +0300
Message-ID: <CAHp75VeyV5t3rMw5Za8yFoKmrFLwxDqbLLdDyOr+pezAC+Lv7w@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: fbtft: Replace udelay with
 preferred usleep_range
To:     Sam Muhammed <jane.pnx9@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Soumyajit Deb <debsoumyajit100@gmail.com>,
        John Wyatt <jbwyatt4@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 2:23 PM Sam Muhammed <jane.pnx9@gmail.com> wrote:
> On Sun, 2020-03-29 at 12:37 +0200, Julia Lawall wrote:
> > On Sun, 29 Mar 2020, Soumyajit Deb wrote:
> >

First of all, let's stop topposting.

> > > I had the same doubt the other day about the replacement of udelay() with
> > > usleep_range(). The corresponding range for the single argument value of
> > > udelay() is quite confusing as I couldn't decide the range. But as much as I
> > > noticed checkpatch.pl gives warning for replacing udelay() with
> > > usleep_range() by checking the argument value of udelay(). In the
> > > documentation, it is written udelay() should be used for a sleep time of at
> > > most 10 microseconds but between 10 microseconds and 20 milliseconds,
> > > usleep_range() should be used.
> > > I think the range is code specific and will depend on what range is
> > > acceptable and doesn't break the code.
> > >  Please correct me if I am wrong.
> >
> > The range depends on the associated hardware.  Just because checkpatch
> > suggests something doesn't mean that it is easy to address the problem.

> Hi all, i think when it comes to a significant change in the code, we
> should at least be familiar with the driver or be able to test the
> change.
>
> In the very beginning of the Documentation/timers/timers-howto.rst
> there is the question:
> "Is my code in an atomic context?"
> It's not just about the range, it's more of at which context this code
> runs, for atomic-context -> udelay must be used.
> for non-atomic context -> usleep-range is better for power-management.
>
> unless we are familiar with the driver we wouldn't really know in what
> context this code is run at.
>
> This thread though had the same conversation about this change, for the
> same driver.
> https://patchwork.kernel.org/patch/11137125/

While it's a good discussion it reminds me that this entire function,
i.e. reset(), repeats the on provided by fbtft core.
Yes, the only question if it's atomic or not. IIRC ->reset() is being
called only in non-atomic contexts and keeping reset signal longer is
fine (but better to check with datasheet).

So, I would rather to drop the function completely in order to use
fbtft's core one.

--
With Best Regards,
Andy Shevchenko
