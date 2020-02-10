Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC78C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E33B2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SzVkeJG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgBJMHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:07:13 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33939 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJMHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:07:13 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so4026378lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 04:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5HURIH4Bm0vTlNSFeYJE9DXHrvS0pW9cJMdgMNd36RI=;
        b=SzVkeJG2N/sxNxvB/euaotxNHpBj4rQ2MMxTT5/LHcY3YvyRMDsuaLF42dAMjPmVu/
         r4FdBXLN5FSsv224FXCJ6HEjvx/7p+zuW/NOhji+YZ/upkmZdQsLuK+iIg+xEABvjH1E
         gTskJ7R+RNNJAe/dE2RnoicyXpOLi2gEtRqtrgZoDrH+XalO0k+hg6szs0BunVPjosCj
         ZzG9DROI9zBnbJvooENdvnVkGOEbrtL3xKvt/hhRhEOT11RX+TaxZigIurAe5CqTWAG6
         zil2AgWmtFOiNenkoqber1DBhyyuC3G+ct+ABNGSYXmmGjlR0W/DT6PzXPFsVnToolJX
         IIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5HURIH4Bm0vTlNSFeYJE9DXHrvS0pW9cJMdgMNd36RI=;
        b=QjY0UP3mChlRL1g19IGU9ykBcYxmCBR2ekOVE4fRqL8eBm4TPGoKAbRMGeqReQUq28
         nQGfFcqONtl2HDXhbYwiriNN3+C5ZkGncMrg+Ga3ta3iD6KhXOBVXKSURlaHjLHWKqRw
         hSeNPyJXMRKMxcyawPvIXxLs6wm07i9T1Au/ZMVKcX/jEflXK6ct8oxoY1XWSa+F05RP
         0XU66UyQaG6iPRHeiP8d3Izztgo+VmepCd4QK5BtXxgLvLocEcBLjlNLhIGvw3SQkxXy
         h35QpKeZI+K/d5OA2FjmGel6ENFrSdqx2KgLULs7ePik+tKqkvn4cexXVAdOQo4PDteO
         GfMg==
X-Gm-Message-State: APjAAAVct1tCm3t7TnSGy3UwtTORZLROikT8hWSz6SOEVcxvJ0uy9YvO
        ftzxsqwY5nHYjdg371W7VOwrl7B07SzGDtflzU9CLA==
X-Google-Smtp-Source: APXvYqwsIxEhdNQHhf6aCtYimKHnEaw8VjslEWAQSynP+/VeJxnl2+H/eqGqthNwkcGayJAxyqQJCFtDZRA3so/qsj0=
X-Received: by 2002:ac2:5dc8:: with SMTP id x8mr584729lfq.217.1581336430680;
 Mon, 10 Feb 2020 04:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20200209111620.97423-1-sachinagarwal@sachins-MacBook-2.local> <CAMRc=Md9gsrm3OXcMgxd7DuiuZUovBB=Bcqfs7zCLApmgV6A8Q@mail.gmail.com>
In-Reply-To: <CAMRc=Md9gsrm3OXcMgxd7DuiuZUovBB=Bcqfs7zCLApmgV6A8Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Feb 2020 13:06:59 +0100
Message-ID: <CACRpkdZbkJjyRPjgrA=i71tkWcD2nAxymMsXYVVrb=t_EsDSnA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: ich: fix a typo
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     sachin agarwal <asachin591@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:54 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> niedz., 9 lut 2020 o 12:16 sachin agarwal <asachin591@gmail.com> napisa=
=C5=82(a):
> >
> > From: sachin agarwal <asachin591@gmail.com>
> >
> > We had written "Mangagment" rather than "Management".
> >
> > Signed-off-by: Sachin Agarwal <asachin591@gmail.com>
> > ---
> >  drivers/gpio/gpio-ich.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpio-ich.c b/drivers/gpio/gpio-ich.c
> > index 2f086d0aa1f4..9960bb8b0f5b 100644
> > --- a/drivers/gpio/gpio-ich.c
> > +++ b/drivers/gpio/gpio-ich.c
> > @@ -89,7 +89,7 @@ static struct {
> >         struct device *dev;
> >         struct gpio_chip chip;
> >         struct resource *gpio_base;     /* GPIO IO base */
> > -       struct resource *pm_base;       /* Power Mangagment IO base */
> > +       struct resource *pm_base;       /* Power Management IO base */
> >         struct ichx_desc *desc; /* Pointer to chipset-specific descript=
ion */
> >         u32 orig_gpio_ctrl;     /* Orig CTRL value, used to restore on =
exit */
> >         u8 use_gpio;            /* Which GPIO groups are usable */
> > --
> > 2.24.1
> >
>
> I'm seeing that you have been sending a lot of these single typo
> fixes. This is polluting the history and I'm not a fan of that.
>
> Linus: what is your policy on this?

I don't really have one, I think it's usually nice to do as a drive-by
change when fixing something else. I like what is said about
fixing whitespace and codingstyle issues in the document
Documentation/process/2.Process.rst heading
"Getting started with Kernel development":

  Individual developers are often, understandably, at a loss for a place to
  start.  Beginning with a large project can be intimidating; one often wan=
ts
  to test the waters with something smaller first.  This is the point where
  some developers jump into the creation of patches fixing spelling errors =
or
  minor coding style issues.  Unfortunately, such patches create a level of
  noise which is distracting for the development community as a whole, so,
  increasingly, they are looked down upon.  New developers wishing to
  introduce themselves to the community will not get the sort of reception
  they wish for by these means.

(Jonathan Corbet)

I recommend newcomers to read the whole document, or their
contributions might get increasingly ignored.

Yours,
Linus Walleij
