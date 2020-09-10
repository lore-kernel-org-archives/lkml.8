Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A565BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EDAC221E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2FVxidr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgIJVVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731124AbgIJOYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:24:31 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DD3C06179B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:12:21 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t16so6466371edw.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WIAhAuLgDdPSGxj2Ew6TBsWzqG0AWB20MCV379BU/Do=;
        b=2FVxidr6NlneB8Gmibj6gBVHoksBaQhNh/Pa99uSRsuX1CtDjXuJO4TnOOkqPg98OU
         vIsTys1U+0M76zR1CSbNWhghuIoEnVDnyThfuNpDrZ2WJaDwNyfQUbb/uADXW4ATR/MA
         rI68vkQ/4I4jM3eynKWqMYQWpwg6j9XKfiyZ4KiHDHD0B6a29FR4miMf8oLVF6z4XQjV
         0E9xnBoWH719C00nntMdQCfUS03tFtyDeNxnXVdQbuYEIwT6/a4Jqkv5upJGNwfNXX+v
         OYlt9rIRAyUKl8ve8x32msPCfnL/XphXmaBzAw0BD+J239W471xZXzCnY8irgnM3IReW
         8cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WIAhAuLgDdPSGxj2Ew6TBsWzqG0AWB20MCV379BU/Do=;
        b=ZxY0BzblfmDi8/pPQFo3+/amd3VQALObxZEHtwOT+s7LGgbu58ceQVLyhk1Vr1bw7w
         EWBfSRBYeoHo1uGioNrmVmo+3Yc6G6kNXkehrSCGBgLbWqFVl5G54sqM/mH2M52fAJtX
         TWVXJ4q8hXLrKp1N4ud90AIhae8KMgqAEihSqL3VBpjlPTNdnhjCtPN9AA1wxqto40qo
         T7dNOc7UfCpknxLjika+hVEY7bUK9qAV5WMbdqptnUKYtm4d9ZEX/aTVdp/1vx0SQoSd
         ZaS4IA8CW+mwWzxR1BrdAEHJyCTCieyOZZOHCRPYnSCGLzke3MCk7JRN4vkpcjaXfzTp
         uuGA==
X-Gm-Message-State: AOAM531Rk66vGAsS/c4jtQucpg/qnyJixldVheClgkIzNUqaKal3HQoq
        j+E+vPAlJnEiSdlx1hHfXTN5Er4vUKr/aaKWQtLE4Q==
X-Google-Smtp-Source: ABdhPJyp9pgsGGia4YBlKO5fHgEaMpyornUGWuYNvZfvB0Ap2lxYBxPVJeSWvJQWYY9Y09p6HIl0ZTwrv6A+KqJ4HEM=
X-Received: by 2002:a50:9b44:: with SMTP id a4mr8400212edj.12.1599747139721;
 Thu, 10 Sep 2020 07:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200827140020.159627-1-warthog618@gmail.com> <CACRpkdZZMbfpKy4gcfAzNq53LkYLcL9wm3Qtzyj_K8vkUW9RfQ@mail.gmail.com>
 <CAMpxmJXRY2wqqN3SzfJN+QTWAHYSYz4vEjLKWU82Y=PAmcm=5w@mail.gmail.com>
 <20200827224742.GA3714@sol> <CACRpkdZroNFFsHoBHUFTUUQij7nOcPQiXP-567+fH-Xerv=L4w@mail.gmail.com>
 <20200829013532.GA5905@sol> <CAMpxmJWjPzueMeKopo7qFke05CEePVD4YGbUiN7b_STKoYt0ZQ@mail.gmail.com>
 <20200910140949.GV1891694@smile.fi.intel.com>
In-Reply-To: <20200910140949.GV1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 10 Sep 2020 16:12:08 +0200
Message-ID: <CAMpxmJVG+0ndrnNODv=niNtULBBtGJi+R7LKRh6R1Kex+ef_Cw@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] gpio: cdev: add uAPI v2
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 4:09 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 01, 2020 at 11:28:13AM +0200, Bartosz Golaszewski wrote:
> > On Sat, Aug 29, 2020 at 3:35 AM Kent Gibson <warthog618@gmail.com> wrote:
> > >
> > > On Fri, Aug 28, 2020 at 04:37:19PM +0200, Linus Walleij wrote:
> > > > On Fri, Aug 28, 2020 at 12:47 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > >
> > > > > The particular use case I am considering is one I had been asked about -
> > > > > changing a requested line from input with edge detection to output, and
> > > > > vice versa. Losing interrupts isn't really an issue for this use case -
> > > > > it is expected.  Yet the current implementation requires a re-request.
> > > >
> > > > This is possible to do for in-kernel users, but I don't know if that makes
> > > > sense for userspace. It is for one-offs and prototyping after all, there
> > > > is no need (IMO) to make it overly convenient for users to implement
> > > > all kind of weirdness in userspace unless there is a very real use case.
> > > >
> > >
> > > Fair point - in fact it is the same one that made me reconsider why I
> > > was so concerned about potentially losing an edge event in a few rare
> > > corner cases.
> > >
> > > Another point for this change are that it actually simplifies the kernel
> > > code, as it takes as much code to detect and filter these cases as it
> > > does to include them in the normal flow.
> > >
> > > I had a play with it yesterday and the change removes two whole
> > > functions, gpio_v2_line_config_change_validate() and
> > > gpio_v2_line_config_has_edge_detection() at the expense of making
> > > debounce_update() a little more complicated. I'm happy to put together a
> > > v6 that incorporates those changes if there aren't any strenuous
> > > objections - we can always revert to v5.  Or I could mail the couple of
> > > patches I've made and if they seem reasonable then I could merge them
> > > into this set?
> > >
> > > Cheers,
> > > Kent.
> >
> > I personally like v6 more. The code is more elegant and we've also
> > tried limiting GPIO chardev features before and now we're doing v2 so
> > let's not make the same mistake twice. :)
> >
> > I'll try to review v6 in detail later today.
>
> Let me briefly review to this. Can you remind which patch has a top level
> description of what features are provided in comparison to uAPI v1?
> (Btw, do we have some kind of comparison table?)

We are now at v8 for this series. The cover letter contains a lot of
info and patch 4/20 defining the uAPI header explains v2 even more. I
think these are the most important parts. Any implementation details
can be fixed later as opposed to the API itself.

Bart
