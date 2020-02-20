Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED989C11D0B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24D6206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zAtgcGHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgBTPD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:03:26 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46869 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgBTPD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:03:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id x14so4526294ljd.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LxO6VpOJIjKHq57KwHOFGT9nr+13wIF/dBwcEWsuzEg=;
        b=zAtgcGHDO2T0usjZzu4nYCT5UC+A/FBkj+nFH5q0RePPgyLofKTbA0zhwIFP6kenac
         xItNUhQqWoQOGlddS+vKnfvA4QCRWBw0FnLnYYZW/9lUWYeSKjq1J5C9R+Yj3wP9kZCR
         FRIwMH0GFjbLIQ6KlXomzKuNSDR1WMkBYUx4+D6hMjYIHVn8EEGL70YdtN4whTUwLJpF
         BDfrKa3HH670i+lf98h876GlLE3KWczf6SP27sz6x0hHuJTWVoiGbf7XqqIjTSMGS33Y
         rbS7kYDF3ii79sHclghTh4+BcwLX5xDkZBaVIAEZGGXs/yfX7HRgkqdcuWY0/5cZ1GG7
         +JCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxO6VpOJIjKHq57KwHOFGT9nr+13wIF/dBwcEWsuzEg=;
        b=do3afy279Yxa+g4PntRSyB7LMEvzxCNiFsndhRIVmA07JPQGLoekt5qBLsLCNu1h86
         u+9UOpJkElUd9IeGnmagDhmhN6MoJtlVuj0zxz7EzIgTTNo/k/xdoHJlhmgH8vasvcdS
         eqNrxNDARbzZvLaWmAhk2HlE/9ULfl4DdUfZkofEs8Sk4MhGsuQsLueLCVOlJGtDzmUX
         o/7wXbTD1zUDUuMzRHd6vbv7Uf4/IW0ulXlv0tTwngOb8aqSNr4UsspmjU+ozBL6gFSL
         GDQuf4e2NmjRn09CHxBRAB24XX5DGcWI4Y0A9i87CQFxE6ZBCeEBtPC8Kv4eXMUyzNtW
         tjMQ==
X-Gm-Message-State: APjAAAVM+1yQRL4asmmhXB9R68n5L+D46+FeEJTHlzG5zaJ6+R9DA3O4
        SjSxz2CXtylZrsTABG2FUR5JUmt7633Vo9Ni+jhp5A==
X-Google-Smtp-Source: APXvYqw6qh6x9/zwhJngNlJ+ruI4osBVT7VUQqyOcXlmxYpb88NIGEaxEuqeNN6LL9GHHlMwg5gYZc3XZAjCDwsiFvY=
X-Received: by 2002:a2e:b6ce:: with SMTP id m14mr17877360ljo.99.1582211002826;
 Thu, 20 Feb 2020 07:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20200211091937.29558-1-brgl@bgdev.pl> <20200211091937.29558-7-brgl@bgdev.pl>
 <CACRpkdZNyCBxQF_pVPGENob5EKZfYjuaNq5bLNA42XjraXzNZg@mail.gmail.com> <CAMRc=MfkbJ=zTvgpaxFC7L7APEhfC7J_PcncGaQ_AQUA9uw2Fw@mail.gmail.com>
In-Reply-To: <CAMRc=MfkbJ=zTvgpaxFC7L7APEhfC7J_PcncGaQ_AQUA9uw2Fw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Feb 2020 16:03:10 +0100
Message-ID: <CACRpkdZE0F_E1o-psXdOh93j1JAS8uqT=ZOf4-mrj5WKoKcD6A@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 6/7] gpiolib: add new ioctl() for monitoring
 changes in line info
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:00 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > On Tue, Feb 11, 2020 at 10:19 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

> > A question:
> >
> > Bartosz, since you know about possible impacts on userspace,
> > since this code use the preferred ktime_get_ns() rather than
> > ktime_get_ns_real(), what happens if we just patch the other
> > event timestamp to use ktime_get_ns() instead, so we use the
> > same everywhere?
> >
> > If it's fine I'd like to just toss in a patch for that as well.
> >
>
> Arnd pointed out it would be an incompatible ABI change[1].

Yeah, I was thinking more about this specific answer from Arnd:

> "It is an incompatible ABI change, the question here is whether anyone
> actually cares. If nothing relies on the timestamps being in
> CLOCK_REALTIME domain, then it can be changed, the question
> is just how you want to prove that this is the case."

So the question is if userspace really cares.

What happens with libgpiod or users of it? Are they assuming
the weirdness of CLOCK_REALTIME, or are they simply assuming
something that is monotonic increasing and just lucky that they
didn't run into anything jumping backwards in time even though
they *could*.

I think I'll propose a change and see what people say.

> However - I asked Khouloud who's working on v2 of the line event
> interface to use ktime_get_ns().

That's great!

Yours,
Linus Walleij
