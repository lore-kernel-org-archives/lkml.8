Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584C4C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D45921481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UdJojwKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgIGLFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgIGK4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:56:32 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B364DC061755
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:56:30 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id h11so12107859ilj.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RpqzXli+XwCeMDV3owXAXqs2l8fk/xVY+BAwh0ak7Y=;
        b=UdJojwKSlBl1Tz+n0b1d7FQshL4EUtEIMahQ4fGtI2Y2E4fryVcKbeE0sXH9qI7yPm
         ht/QXwE8hxsAbPH1+Lle01u/vcrJm1XxLztsetw7WKfv6RKaZk0+VtY3wrXz/taGbnhi
         BUpskNdAvj8qCP98GPh4jgZSDszAfYsVkJNZNmuS97HqgwWBDAC9G4xgYiMaE9Ll4IW2
         dv89Z5sjugBIhI33dMFvXroe7cuI/54CVfFHkOupSnM7ORAguKkXoN2aeXvuRT87mqm4
         IzSdxnCuu6913KmUrirpZd9GKBd9MuFYho3sTMT3c5mJai5KCZBDm/WE5pzGlS0VsfgI
         FDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RpqzXli+XwCeMDV3owXAXqs2l8fk/xVY+BAwh0ak7Y=;
        b=BwZAp1XtsaT8c0sUjeMShjxJBKh0lE1+1cfm2LxIi4GtM5rVwZEVQX4akYp+zhKlSI
         auLzvPrl/uk3i5qGxn/X99aeSfoD+5X0MwOHNJw9T0LmNfvlwhFb+IQDvfO/2TxSti8E
         iCzyEYzSS0qjtD4TzUFTGQa+cfIFbZo4zNyGbOGhHK9/LyMQhXmHw/luZSrsFeMmrVrG
         wdwMBdlSmF3ORVcEn06DBsD+aTHrwJLEUNVrFM1yMVM8d1E3fVvnF5yIuNy/5x8shSCv
         Ag1XgLdE2g+IW43aiRGHC9QzcJey7JT9jYK1YEK8VOYGvxNKqmWOP1Sdrxb+8eH4NXnj
         bDEQ==
X-Gm-Message-State: AOAM5313Kj0vOpl9oWvqMZcFzSaLPd+tchGHfp+3eVNGQKK8lOJFycMC
        FpzAH+XnoUIDfWnYK6RLVVuLx+uh/GFpzLp9h/Tgnw==
X-Google-Smtp-Source: ABdhPJzrrBWKvS/0CytuqACgZ2NZ/VYj5Aa6yYN+qHpPMg92bY9CYtJjq/jiXt/5mZGa37+9U5ia18jssb2wZ1ZnqRM=
X-Received: by 2002:a92:1b0b:: with SMTP id b11mr18787396ilb.287.1599476189880;
 Mon, 07 Sep 2020 03:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-5-brgl@bgdev.pl>
 <20200904163820.GX1891694@smile.fi.intel.com>
In-Reply-To: <20200904163820.GX1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Sep 2020 12:56:19 +0200
Message-ID: <CAMRc=Mc2mhsNo10RDVLGNPCADivYNco21+QZfehAgMRzZW3Sfg@mail.gmail.com>
Subject: Re: [PATCH 04/23] gpiolib: generalize devprop_gpiochip_set_names()
 for device properties
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 6:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 04, 2020 at 05:45:28PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > devprop_gpiochip_set_names() is overly complicated with taking the
> > fwnode argument (which requires using dev_fwnode() & of_fwnode_handle()
> > in ACPI and OF GPIO code respectively). Let's just switch to using the
> > generic device properties.
> >
> > This allows us to pull the code setting line names directly into
> > gpiochip_add_data_with_key() instead of handling it separately for
> > ACPI and OF.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/gpio/gpiolib-acpi.c    |  3 ---
> >  drivers/gpio/gpiolib-devprop.c | 19 ++++++++++---------
> >  drivers/gpio/gpiolib-of.c      |  5 -----
> >  drivers/gpio/gpiolib.c         |  8 ++++----
> >  include/linux/gpio/driver.h    |  3 +--
> >  5 files changed, 15 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> > index 54ca3c18b291..834a12f3219e 100644
> > --- a/drivers/gpio/gpiolib-acpi.c
> > +++ b/drivers/gpio/gpiolib-acpi.c
> > @@ -1221,9 +1221,6 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
> >               return;
> >       }
> >
> > -     if (!chip->names)
> > -             devprop_gpiochip_set_names(chip, dev_fwnode(chip->parent));
> > -
> >       acpi_gpiochip_request_regions(acpi_gpio);
> >       acpi_gpiochip_scan_gpios(acpi_gpio);
> >       acpi_walk_dep_device_list(handle);
> > diff --git a/drivers/gpio/gpiolib-devprop.c b/drivers/gpio/gpiolib-devprop.c
> > index 26741032fa9e..a28659b4f9c9 100644
> > --- a/drivers/gpio/gpiolib-devprop.c
> > +++ b/drivers/gpio/gpiolib-devprop.c
> > @@ -17,25 +17,24 @@
> >  /**
> >   * devprop_gpiochip_set_names - Set GPIO line names using device properties
> >   * @chip: GPIO chip whose lines should be named, if possible
> > - * @fwnode: Property Node containing the gpio-line-names property
> >   *
> >   * Looks for device property "gpio-line-names" and if it exists assigns
> >   * GPIO line names for the chip. The memory allocated for the assigned
> > - * names belong to the underlying firmware node and should not be released
> > + * names belong to the underlying software node and should not be released
> >   * by the caller.
> >   */
> > -void devprop_gpiochip_set_names(struct gpio_chip *chip,
> > -                             const struct fwnode_handle *fwnode)
> > +int devprop_gpiochip_set_names(struct gpio_chip *chip)
> >  {
> >       struct gpio_device *gdev = chip->gpiodev;
> > +     struct device *dev = chip->parent;
> >       const char **names;
> >       int ret, i;
> >       int count;
> >
> > -     count = fwnode_property_read_string_array(fwnode, "gpio-line-names",
> > +     count = device_property_read_string_array(dev, "gpio-line-names",
> >                                                 NULL, 0);
> >       if (count < 0)
> > -             return;
> > +             return 0;
>
> Can we introduce a followup to 33ee09cd59ce ("device property: Add helpers to
> count items in an array") for strings?
>

Sure, I'll do this in v2.

Bart
