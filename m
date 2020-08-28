Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B5CC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F02208C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brkXHNfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgH1HHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgH1HHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:07:23 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA1BC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 00:07:23 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id v13so14184oiv.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 00:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pgztyPJ+HoTFkAXRpIdttagMgd+kIjYcrjfVyLosO0=;
        b=brkXHNfWnNhZJaUoSEwoddkP1PZyGs5tC9d9Glaz5ACKAaLR+ATB6lPjc3kJsproCB
         JNj3xuFGNIoNSrL/xlnLyPH89U9xlDfTj6yBsxQXt1JE42B8g+WeyrMSISKnocnfe2mS
         86D9afCAdLCF+xNbZTYOFutqpZysrtWcakhiQb+TiRIqDBR9WZS8fbOhmPWJes4yDDiK
         8Mw79WWH6VY60D1zQso30t+ULMY5SN5/7k8iCVyyZE1fCykfGb7wtBxA5BC0S3vUYPSe
         2tZxR0UmmL5ISEqJ7bm3wuQY48HeFejrYGBR29EO6hGPoUgQBHpjqv4PPd3El3Oq1oXB
         F3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pgztyPJ+HoTFkAXRpIdttagMgd+kIjYcrjfVyLosO0=;
        b=iwD3k93Ut7bOzn4nK7xyBGF7vf8CwY9SPmmifYxkzsvKqU0UFwBsCLQLMW3vllcULH
         jy0h5r6B+Fwpjo8KUiKZYLr36JC+Tsz2SrP85N56ZXZl/UVlbV8Xg8vtSL3iR+vsivxy
         K8+wU5jgTkOQkM944MwCYdRVpukx4iP4mR+0MwpuTCnVsf/3aaEhwXP5zVzVLwsTAVKs
         90xxLFS3VPcVd8P4teijLdAaykCRxG6fjl2WS97mOf0mMGsWhaIgBX/v66nXNX3gjGFX
         86igOHPaKhQoxpES2O4VRWh8nHGy2ENKdrRmqAEAMUinuyC3FeYYNOqe4gZvRQJJKTeM
         LPLA==
X-Gm-Message-State: AOAM530+WHV/ry/IQjw4Doz/wIojif/G3StWBj8Gwyl1A0lB5y6dI4Wv
        4J4A0pbWAeokqzOHPTQ2h/6ml9rN08sV2t2SZE0=
X-Google-Smtp-Source: ABdhPJw5lDwWk4jtlvrn7tvwnuHbYy98u/y+DmnaPWlvbLGlL4XSoXv6nzWKjoqd6TxSY9igEhLWAHGlqCCCR95Ftdk=
X-Received: by 2002:aca:ec95:: with SMTP id k143mr178854oih.76.1598598442889;
 Fri, 28 Aug 2020 00:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200827013636.149307-1-allen.lkml@gmail.com> <CAHk-=whiEUUrtnbgUH2xsD0+jNyoXudYJ4hGCA55MCjryaHGjw@mail.gmail.com>
 <1598553133.4237.8.camel@HansenPartnership.com> <CAHk-=wi8o+FvfQkUiH_2MUs3J19FzfMzumOViAJ2aboGg9qY7Q@mail.gmail.com>
 <CAHk-=wingJWToQfoc+m2am7Q=7r8XD+6p0FXasCRAzOdcRyngw@mail.gmail.com>
 <202008271150.7231B901@keescook> <CAHk-=whDhHWQo_QjZp36=x=GLMGOJ2xnfsUk9xkUuWRz=i9gOg@mail.gmail.com>
In-Reply-To: <CAHk-=whDhHWQo_QjZp36=x=GLMGOJ2xnfsUk9xkUuWRz=i9gOg@mail.gmail.com>
From:   Allen <allen.lkml@gmail.com>
Date:   Fri, 28 Aug 2020 12:37:11 +0530
Message-ID: <CAOMdWSJEkZoR2og6WDMBfr+ns93cBYuyjM+=8LKsvEba8NoQaA@mail.gmail.com>
Subject: Re: [PATCH] linux/kernel.h: add container_from()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I don't see that kind of redundancy being a _problem_, though. "So
> much redundancy" is just over-stating the issue completely.
>
> In fact, we often encourage people to split declaration from
> initialization exactly because it results in simpler expressions and
> more legible code, even if that name is now redundant. So it's a small
> extra typing of the type. Big deal.
>
> The above is also a common pattern that once you know how
> container_of() works, it's very legible.
>
> Sure, if you're new to the kernel, and haven't seen "container_of()"
> in other projects, it might initially be a bit of an odd pattern, but
> that's the advantage of having one single standardized model: it
> becomes a pattern, and you don't have to think about it.
>
> And particularly with that argument-type pattern, you really have to
> work at making over-long lines, since the indentation level will by
> definition be just one.
>
> Looking around, I do see a lot of people doing line-breaks, but that
> tends to be when they insist on putting the variable initialization in
> the declaration. And even then, it often seems pointless (eg
>
>         struct idp_led *led = container_of(cdev,
>                         struct idp_led, cdev);
>
> was split for no good reason I can see, but it seems to be a pattern
> in that file).
>
> You really have to pick some pretty excessive type names (or variable
> names) to get close to 80 characters. Again, to pick an example:
>
>         struct timer_group_priv *priv = container_of(handle,
>                         struct timer_group_priv, timer[handle->num]);
>
> ends up being long even if you were to split it, but that funky
> container_from() wouldn't have helped the real problem - the fact that
> the above is complex and nasty.
>

 An example with a really long member name is

+struct nokia_modem_device *modem = from_tasklet(modem, t,
+        nokia_modem_rst_ind_tasklet);

With container_of() one can imagine how long it would end up. And
am sure we have many more examples in the kernel.

I agree, It would have been simpler to use container_of() as it's been
widely used, but as mentioned by Kees, for 1-to-many conversions
it does not work well.

I guess container_from() is a NAK, if you would want us to just use
container_of() to keep the code clean and simple instead of using wrappers,
or any other method, we are open to suggestions.

Thanks,
- Allen
