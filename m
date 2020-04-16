Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577DEC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDAA21734
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtzsmKq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632745AbgDPLWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632917AbgDPLTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:19:47 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12A6C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:19:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so886543ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NGDiAiHa7gOkZcjetP+fIoZxVSWT0kUGxzHZFTTg7do=;
        b=OtzsmKq4kHVDABFucflRXQScsA5dK0d8y+T7VpIusux0bdbzOkryTGmdsRMejMModx
         hG+VUUfuAGphGgNl/ZWXlXnkPfKW8XJTUtB2InKKwK+VcmtS133aXqUYztuRFDgCKwYr
         CuXgPqQNihksSjAt6Quo/CXuja6kdP04P2Gvo1/g98aFnINd6I9yEQ/8pZ1kl2n2D588
         7oh3h6PhgI4kgcrI04UrK/gjC7byofTga40iU9XD5p9G/tTD9nCNZdb0xlIsO1aFBAIB
         1GMRLSIgOunDZtfkEJg5DwnLQjfuOZf9TkvUJjQS3MjVtW9RVo8n1pZUQ1yFDHuupZdE
         870A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NGDiAiHa7gOkZcjetP+fIoZxVSWT0kUGxzHZFTTg7do=;
        b=I3k+KDhQeHiOU4JcDC2TY2YAiSFt8LWJU64fgtScVztsIWkt0at2pmemsyrcMkxcNs
         mTs7zFS+54toHLs021oo04BZh8NK7fuB9BMXfAnnYSQ6Dc42nGMBbgJisX4wn4OvTlWa
         CmMzALDtZaEIdOwDI5q61cUDSplhAidDqQU0S+NfSSNcaVooMEuw/WcXi7VdgBtcbSBX
         DDMBBlG3AfiVn+QPxCWZl1baVuzVzSlEuUHQnYPCXuJmhK8kC4scRb6zT+Ro/cqxwOEH
         EHlHzERn/aX/ODQA+2jdyUcrtdiFvjmHX4P+4nGoUheNFnIhK8pbyQhE5bo9C5hqQ8GA
         QT0A==
X-Gm-Message-State: AGi0PuZb+/FXqnY5TXdNaGZm8pxcq3VGd15T7loLujqfznufyNBmqglM
        Wm/Ldh/VivuIPWh3FCi5f6uH1k77NIy82ajsYfnhAg==
X-Google-Smtp-Source: APiQypJy9THPwjoS7Jo2tqNfqwFCh62pVSbwOBq6PdDLITxyc2Xnd0cf+VlMiSRhsUAbLwuDb/LTyMe0TXHxVDUdths=
X-Received: by 2002:a2e:5048:: with SMTP id v8mr5663453ljd.99.1587035984361;
 Thu, 16 Apr 2020 04:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200320093125.23092-1-brgl@bgdev.pl> <CACRpkdZgWUwmmuXn12DS3TsQS0yQxcweqK6HGxBm=V_2LBLBMw@mail.gmail.com>
 <CAMpxmJUb09KGreHw6Bdz79rbnQE7oZnWg_5qN_FhzoS2-XccFA@mail.gmail.com>
In-Reply-To: <CAMpxmJUb09KGreHw6Bdz79rbnQE7oZnWg_5qN_FhzoS2-XccFA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 13:19:33 +0200
Message-ID: <CACRpkdaeWtk1fiGMX7QkkCZ-DcFqSvSB9xQmuLy1VO+QWsZo6w@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: don't call sleeping functions with a spinlock taken
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 2:27 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> wt., 14 kwi 2020 o 14:00 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
> >
> > On Fri, Mar 20, 2020 at 10:31 AM Bartosz Golaszewski <brgl@bgdev.pl> wr=
ote:
> >
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > We must not call pinctrl_gpio_can_use_line() with the gpio_lock taken
> > > as it takes a mutex internally. Let's move the call before taking the
> > > spinlock and store the return value.
> > >
> > > This isn't perfect - there's a moment between calling
> > > pinctrl_gpio_can_use_line() and taking the spinlock where the situati=
on
> > > can change but it isn't a regression either: previously this part was=
n't
> > > protected at all and it only affects the information user-space is
> > > seeing.
> > >
> > > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Fixes: d2ac25798208 ("gpiolib: provide a dedicated function for setti=
ng lineinfo")
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > I'm sorry that I lost track of this patch :(
> >
> > Do we still need something like this or has it been fixed
> > by some other patches?
> >
> > Yours,
> > Linus Walleij
>
> Nope, this is still an issue. Do you have a better idea than mine?

Nope, can you just queue it in your tree?
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
