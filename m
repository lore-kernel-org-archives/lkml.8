Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEB0C3402A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 22:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908D920836
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 22:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iCVpOe7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgBQWJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 17:09:46 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40524 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgBQWJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 17:09:45 -0500
Received: by mail-io1-f68.google.com with SMTP id x1so8635166iop.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 14:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Omu0NuzaolVnSx+lzNIehq/LH4WJjwka83BM14aUe54=;
        b=iCVpOe7WsfoX/5+MZ7nl4keAYitzKy0yV7RlA0i4AO/J36knvEx8lMaYo/OXa8Rvjs
         xkuw887fAWD1+yXzmaB4+sdQS6RL5fCV/Ou+94O3RQyXjLfs+VHut1Tmwtdrl39nxck/
         gQbVWU5sKU+7RAc5i2by5TEL+kqzqnotCEm6f9XxghErud7lXxBHwxLsv1/v0DV6dfl3
         4RXZ4GCoQu/LBntfMP9WI6Eidd7SrBpppEcRp+Rl4AuU11PpY6aj94+NvMP/JTIkfA7H
         hJdefnIk7nGEo6HsNJdHMM7WK5nFz04oSHgqmCjfuHzop0id+dend0MtGyHtyAaLdYZy
         d9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Omu0NuzaolVnSx+lzNIehq/LH4WJjwka83BM14aUe54=;
        b=gMoAsKHoHCH2lQ+85mQG3aXPRGgDTY7xvXd5ysveA0lRA9d7WOSrPnpts3NMVUduzb
         9nvZJEJOoWLTzr6C98Yx91cQM7JiuY156mHT3vLLaz1BD21CT22tpw8Nmgukm6RKAozB
         uqaTWPC0qwzfibK2rZHyWc1BYFk4SmgaEbSGa11iSCzrPHYKk0SrCltyFiVSMyVDNZPF
         VyvsxcLRAjreitgzidAaptzaoq16gJcDGVL4b/dtvZdkaVFfMI7rQDRsG1K+klKYYf/r
         mr8QDPr57cy6dkuQYcsQePAlh6dbJltmHi6x7gbCn2q+fp3LDgcOy9qXZaxMV7qvR1k+
         DdBQ==
X-Gm-Message-State: APjAAAVUMdv+o/fVEQXc+Ns2nf9rzdqaWqsvztv3EClpOlyaeU9PDhsS
        LUaRvLKFsfdg6Iky3TudZd/3YYjUt+Iw8XUiaykfYQ==
X-Google-Smtp-Source: APXvYqzONE5LXJ9iPg+x6SUKk/LzrP5otAyAI4puc1UkiSI0bZWhfMMZy6M6j7oq6XHKO7wn2VIMiIcWLx/NtAUjdPw=
X-Received: by 2002:a5d:8952:: with SMTP id b18mr13653283iot.40.1581977383891;
 Mon, 17 Feb 2020 14:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20200217195435.9309-1-brgl@bgdev.pl> <20200217195435.9309-7-brgl@bgdev.pl>
 <CAMuHMdWAxhUWPt06vcaHwD34=k=ihzVAxSTtFnO4r2bY7nAmjA@mail.gmail.com>
In-Reply-To: <CAMuHMdWAxhUWPt06vcaHwD34=k=ihzVAxSTtFnO4r2bY7nAmjA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 17 Feb 2020 23:09:33 +0100
Message-ID: <CAMRc=MdPhJqsqZUO59m+s2tfQxx+Q8w4fbNxgXReW4UEDVNV+w@mail.gmail.com>
Subject: Re: [PATCH 6/6] nvmem: increase the reference count of a gpio passed
 over config
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 17 lut 2020 o 22:13 Geert Uytterhoeven <geert@linux-m68k.org> napisa=
=C5=82(a):
>
> Hi Bartosz,
>
> On Mon, Feb 17, 2020 at 8:56 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > We can obtain the write-protect GPIO in nvmem_register() by requesting
> > it ourselves or by storing the gpio_desc passed in nvmem_config. In the
> > latter case we need to increase the reference count so that it gets
> > freed correctly.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Thanks for your patch!
>
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -349,11 +349,13 @@ struct nvmem_device *nvmem_register(const struct =
nvmem_config *config)
> >                 return ERR_PTR(rval);
> >         }
> >
> > -       if (config->wp_gpio)
> > +       if (config->wp_gpio) {
> >                 nvmem->wp_gpio =3D config->wp_gpio;
> > -       else
> > +               gpiod_ref(config->wp_gpio);
>
> If gpiod_ref() would return the passed GPIO, or an error code, you could =
write
>
>         nvmem->wp_gpio =3D gpiod_ref(config->wp_gpio);
>

Yes, makes perfect sense - v2 coming up tomorrow.

Bart
