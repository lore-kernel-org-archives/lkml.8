Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E7EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6367E207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lcZFQ/uh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgHCUDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgHCUDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:03:02 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A59C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 13:03:02 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w9so29201897qts.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6A/5RoJHIBxD93DNQBku4nNngBquUzm6++SOMVJrgBM=;
        b=lcZFQ/uh69bDfLnH4QjtClbnbC9Wijo0Q/P/gHCCdM3fj9wpEmEMnvAE65yi9VW36F
         Upac67ajq0iLvIlPQV1bA+0c7RRbr0o7974MNCj33dgPmZU9xomPvDXh0o5BdQYZchym
         bh+Nkava4V15mqFrjGstx+Ng4+z5bn7clLb0TZWA6a2m1lyGh2Z1ERwlzUZKFHj66WDn
         ZTg6CxoLfSXuTPNX/zP00UjPcthMGxNyReR0JHcFuqWD7H06I8IjWpyD6zZfJG1JOZ8g
         w/KoBLdSkQMvrAP6FtcfqzUsyMO27/6msa3/aHctO8Gud+P6Km5Pbg+1aKUCcaiSPCVo
         xtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6A/5RoJHIBxD93DNQBku4nNngBquUzm6++SOMVJrgBM=;
        b=fwYMWC2CE9yQWpaf4ghOpay5jqhyxc5lX6KyND5K1Egmcd7vATpfgxtXx2xryf4z9m
         wjtBDjV8HFRF8qzKBQd7QVscF28eTiWZ2I77VnKv5UqUGeBmK+XIgPvwri9knjh+4DoK
         T3sVMsbf1/ffIdJJSBQ3cZVuQFWVyAKQWYx6+cJGjJl18pg+37pl1sv4v2e4RmeMrqSB
         Hltkw3xCljHPu+NGLQSsHZfQ60sc+5B5ben185zQeIZbPLo2hbIKhFeSeKLNnJAXNxZV
         3YzQ1t217q9ksGPN5TAhvpWKjZFzxZUuly7PmRTz0ku6tKYFYyh74+5KAgYUUpoOsPMQ
         v7Ig==
X-Gm-Message-State: AOAM532hTjp6QhrqLXQ5JSg80G/QMsbE325fTVHwmKT42dOlu3yZkl1T
        1/36fI/03dL5l68vACY5txWSKDehR8H1rWy+qVlrmw==
X-Google-Smtp-Source: ABdhPJwQsQN+JeQXv8JCZ0M4lUDsVgP2NGa1eLmBTwt/RITNqrQ0yakErPNcRNeQsO/sDXDEeD7zJ0sY6AdMjAxJ5e0=
X-Received: by 2002:ac8:72cc:: with SMTP id o12mr17792007qtp.27.1596484981465;
 Mon, 03 Aug 2020 13:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200725041955.9985-1-warthog618@gmail.com> <20200725041955.9985-6-warthog618@gmail.com>
 <CAHp75VcKtATPDKGAViWqjOJDqukDrgZ13aTU6rTJ1jEeB3vmVw@mail.gmail.com>
 <20200726011244.GA6587@sol> <CAMpxmJWaEVwjXSFHTYmwdfA+88upVkJ4ePSQf_ziSOa1YdOUKQ@mail.gmail.com>
 <20200802033158.GA13174@sol>
In-Reply-To: <20200802033158.GA13174@sol>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 3 Aug 2020 22:02:50 +0200
Message-ID: <CAMpxmJWZpMFbrMBkLiR9q7chdamVnjw0geDf-pgKrz=AWD8mNg@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] gpiolib: cdev: support GPIO_GET_LINE_IOCTL and GPIOLINE_GET_VALUES_IOCTL
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 2, 2020 at 5:32 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Fri, Jul 31, 2020 at 06:05:10PM +0200, Bartosz Golaszewski wrote:
> > On Sun, Jul 26, 2020 at 3:12 AM Kent Gibson <warthog618@gmail.com> wrote:

[snip!]

> > > >
> > > > > +static u64 gpioline_config_flags(struct gpioline_config *lc, int line_idx)
> > > > > +{
> > > > > +       int i;
> > > > > +
> > > > > +       for (i = lc->num_attrs - 1; i >= 0; i--) {
> > > >
> > > > Much better to read is
> > > >
> > > > unsigned int i = lc->num_attrs;
> > > >
> > > > while (i--) {
> > > >  ...
> > > > }
> > > >
> > >
> > > Really? I find that the post-decrement in the while makes determining the
> > > bounds of the loop more confusing.
> > >
> >
> > Agreed, Andy: this is too much nit-picking. :)
> >
>
> I was actually hoping for some feedback on the direction of that loop,
> as it relates to the handling of multiple instances of the same
> attribute associated with a given line.
>
> The reverse loop here implements a last in wins policy, but I'm now
> thinking the kernel should be encouraging userspace to only associate a
> given attribute with a line once, and that a first in wins would help do
> that - as additional associations would be ignored.
>
> Alternatively, the kernel should enforce that an attribute can only be
> associated once, but that would require adding more request validation.
>

I guess this would result in a lot of churn to do validation which is
largely unnecessary? To me the first in wins sounds more consistent.

Also: I just started going through the patches - nice idea with the
GPIO attributes, I really like it. Although I need to give it a longer
thought tomorrow - I'm wondering if we can maybe unify them and the
flags.

[snip]

Bartosz
