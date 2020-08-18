Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58805C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3714C2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lbSYVl4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgHRQ3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgHRQ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:27:24 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F574C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:27:24 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c6so18098633ilo.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oryb9Gw/XAffWSWQvfMiaYrjBvPkCAMTzbIDIXNJbnI=;
        b=lbSYVl4iccAlsHjqO4TXn8l7W42NVRbWABhoe/TSlReejliAxJF6mSRBLxDZNPJNZh
         VId4k9ffeWPZhk7cbu1TO7cS/PNEVLwghIPT6w6bL9qC/JdbsNwj29BHb6Di8pjDYd6t
         Mb2Tj5uHQalzN89CEw8MTgpDGxSlc9Qr6rOFCyrfhM2cJuE07faFRcVHPHcuNjNsYD8h
         gn37CS6aTkVi9vjW3F+tGK72J0Xcltvu5GUZOJml8o8u07l9AaJo4Zwu5kdMWo9WTeex
         bxkuSzPNLlN7W1jffzHdrMP5MTNsNLgCT2Qq6iS6IKQpIJZweyCvjyX90YIefZjzDyp2
         IE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oryb9Gw/XAffWSWQvfMiaYrjBvPkCAMTzbIDIXNJbnI=;
        b=RvlGillKtpUUhSHqCAmj6yaWyXhQURUnq/YymJRxXwP9D6gR5zA3IVvNyqTTt4jvHr
         Hkw9/LuXxHE3Y5iq18z5LLUqIa6sQ+Sc8qYrcu31vUCig4NAmX5HuGN9DMLyxanIyW3k
         knXxHhHsksGKLlkTTo+FhekjOqltIiKB/eKazpYiWZ35ViFDkAPrken3puu9WeQUBLtC
         eMuKX7LcwE1GNKXlj94Fb4d6rI1nt13OUCKhEQdoDWVG7OPFfRTv69PMExFy/siVxXZg
         boy5iiEhA4cADPw0p9P0gpJLwgheF48GqB4NRQ2SofS+wS0riNOphEjAHC6ys8bp2CwB
         4AJg==
X-Gm-Message-State: AOAM5337VkpnBcdqjD8VXE8zQUgsW5YZq957UX5HMUCpwZJeQERovM4y
        I8tmzV9Vay5IOImqewCsUSbApM2g7L3WUQ3ob+u0WQ==
X-Google-Smtp-Source: ABdhPJzG6Vqg4L5Wbx1ozdnU3GZmWNDJJUJs9j/zG7IUQgWN6QYwYtaA8cti9q2O+EPbmg1Ym7IzGb6KgGhztaQ6jQY=
X-Received: by 2002:a92:d30a:: with SMTP id x10mr18640134ila.287.1597768043689;
 Tue, 18 Aug 2020 09:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200817170535.17041-1-brgl@bgdev.pl> <20200817170535.17041-2-brgl@bgdev.pl>
 <20200817173908.GS1891694@smile.fi.intel.com> <CAMRc=MdaaWhV_ZKHgWy_Gxkp=jMuZcwqpoE8Ya_84n9ZT5O31A@mail.gmail.com>
 <20200818082500.GB1891694@smile.fi.intel.com>
In-Reply-To: <20200818082500.GB1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 18 Aug 2020 18:27:12 +0200
Message-ID: <CAMRc=Md5yrgxnPf=qwKYhwHACcq-XeKOKZ76OwYdMGO8SgYmzQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] devres: provide devm_krealloc()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:40 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 17, 2020 at 10:02:05PM +0200, Bartosz Golaszewski wrote:
> > On Mon, Aug 17, 2020 at 7:43 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Aug 17, 2020 at 07:05:33PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> ...
>
> > > > +static struct devres *to_devres(void *data)
> > > > +{
> > > > +     return (struct devres *)((u8 *)data - ALIGN(sizeof(struct dev=
res),
> > > > +                                                 ARCH_KMALLOC_MINA=
LIGN));
> > >
> > > Do you really need both explicit castings?
> > >
> >
> > Yeah, we can probably drop the (struct devres *) here.
>
> void * -> u8 * here is also not needed, it is considered byte access IIRC=
.
>

Actually it turns out that while we don't need the (void *) -> (u8 *)
casting, we must cast to (struct devres *) or the following error is
produced:

drivers/base/devres.c: In function =E2=80=98to_devres=E2=80=99:
drivers/base/devres.c:41:21: error: returning =E2=80=98u8 *=E2=80=99 {aka =
=E2=80=98unsigned
char *=E2=80=99} from a function with incompatible return type =E2=80=98str=
uct devres
*=E2=80=99 [-Werror=3Dincompatible-pointer-types]
  return ((u8 *)data - ALIGN(sizeof(struct devres),
         ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        ARCH_KMALLOC_MINALIGN));
        ~~~~~~~~~~~~~~~~~~~~~~~

Bart
