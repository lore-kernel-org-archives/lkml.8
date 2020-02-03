Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFEFC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66F82082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Ww7tdXfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgBCOfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:35:55 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37096 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgBCOfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:35:54 -0500
Received: by mail-il1-f196.google.com with SMTP id v13so12780048iln.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 06:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3vC73VMRCUJjEoKooO4GGeMZvtatPSqZubaRoJ/0maU=;
        b=Ww7tdXfKpSRXvrHnkSuKHrbRpi4DH5/7CchCLp5SKZ9rrZinzYyqfLoN6Sgu/XPuwR
         BgRA5X3D5SyMRuHJ+d9ldTYE19s+r3UcEHZPHpbv7s1XufjlIChBtBZSp9R6BotrPamH
         3cboV5nfiJ+BJ7/8SkHTP4we6E7pcvNqDSRKJ0npAjemW2dONSJ4f8qOLMurVjRtjswZ
         qyfi3PZv9X62QAXyOQJ+7ZAWx9YQxJL9rPkGpwR0oykqvskgFIaJ9yVjd6Tcirk4ynSK
         GIjXnxKmlMN2KeTRqxMdB0lKafbe5PGSVfFg5GeSaMXvjj8q6ZExG4UyqheiWBpWLM6V
         eN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3vC73VMRCUJjEoKooO4GGeMZvtatPSqZubaRoJ/0maU=;
        b=aI6iIZUfnglv7eNAuETHxDx7hfWakNzVLQ5aNIMWKvI7xY5wiLU3DRPlmUyydNTwQV
         Aq2wne8RDkV6qF7Q61sBdh3ZJxfnjb34N4MfvaM5jwXNj3mv/W8TE5UWMQjVjOaGmyLt
         8t7b1UhPuZzBUp72qkvKH0+mlTRhI3ioTlRHiwWhTijglK0apwtrhoy7Rg9x34GL5G8X
         5oJZBpM0kT540LXeuQ3zP+kxYGl/uAEiiPQcmWQ4IFaGPfbYMoVAHf+G2iBSj5EECNZD
         GjXfOrdZ6fyp1l2/SHMWj9FmQc8BQHUE2ce6CLzUXMQY6wNYxx1x+KEjBtQ4eoyFa11J
         k+oQ==
X-Gm-Message-State: APjAAAWI9d40IyiOvsHDY4/HNXioT2blyHinHVOqLNj52xqecoxlRTMh
        x7hFgZMMcZfzsAUrubUTmMHCAPNhwmHxhg7uwa0351iT
X-Google-Smtp-Source: APXvYqxF1nO5CaAKrpQm2UE422imsRk3a9e8PXBdHJQflnvmPVwOfzyooj0LB0aXxs6jlS/ozBwkpOCKs28kx3UeSYc=
X-Received: by 2002:a05:6e02:5c8:: with SMTP id l8mr15701758ils.287.1580740552738;
 Mon, 03 Feb 2020 06:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20200203133026.22930-1-brgl@bgdev.pl> <20200203143106.GF32742@smile.fi.intel.com>
In-Reply-To: <20200203143106.GF32742@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 3 Feb 2020 15:35:41 +0100
Message-ID: <CAMRc=Mc1Du1D_-Xsgj6rtGqOd229J1dVqK3XXSx1Q3vvqM1sow@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpiolib: fix a regression introduced by gpio_do_set_config()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 3 lut 2020 o 15:31 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Mon, Feb 03, 2020 at 02:30:23PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > These three patches fix a regression introduced by commit d90f36851d65
> > ("gpiolib: have a single place of calling set_config()"). We first need
> > to revert patches that came on top of it, then apply the actual fix.
>
> Thank you for addressing this!
>
> It might be good to add Fixes / Depends-on to the first two, but I didn't=
 look
> if they are in any of v5.5 or older release.
>

They're not - the patch in question was merged for v5.6 and then the
"fixes" came on top of it once it got into next. We're fine here IMO.

Bart
