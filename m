Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CDDC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F98206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JGVOHbBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbgIHQhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732050AbgIHQhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:37:16 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22D2C0619F1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 07:02:14 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t13so15440782ile.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2SewoQNKfdvZ9130x2jsaU2/okRx8tFDqHXaAJPM5A=;
        b=JGVOHbBqWPpU0Q8L9woL1d2GbtrYzS0DIxJiG4Qc526y6YGijYry+9DuHLrGk4AkPh
         HglsW33sBrVqBLvI9Ldp2kiLotwU1516D9ublRTSbn0LX163oAsZQmRc6bBYvnr8MK4w
         b5lQLeL6I9nDr91a0Rn7qLmZLCyLCwF421imiVyR7bzfJ0uEwHIDk776XryoZ9LdO2l0
         9lWCcj0feoWEV4gREwpnhXS9Cwa9rCO3LLtNCxlelLRT9AInUx2swiSZBuGA/b4bPucX
         ttG4115TcL1RGy9WHQ7VfRs5NRWPB5K2DQTRmBAVvfrAVGKtV9f9Tv46q8DKYLBD6foj
         ilKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2SewoQNKfdvZ9130x2jsaU2/okRx8tFDqHXaAJPM5A=;
        b=Jp+a+iWV6IzFaCAuXJEkLuRPRbvg5OMd1f9k31+bzJCxo6CpZ6o++9bHITt/bwh2Q2
         nnQ3sRL/tIN1E2o5KMGajkPAjUiNkVyaNE6WEQIGF+zG7FzyvYO/kcLJr//wYvNG0vf2
         /JWpmOEeBZlmDu0bXuttCrsEB6dezMmr0K/Hvaf3LpHuOOs/q1/tTVcvZfLogoyXQdQp
         1nDqdUOV2eRm4xqgVuw4D3uXOWUMjlvEAApn/X8HBMgsQinnkT3jCxAqd+vnTFEhLIgl
         M64jgvRXXUpd2OIf9X+7Tf53oZWe2Mngp1zFDHQAm7nuFlRtLG+DRdpZdgNQaSupninV
         TDUw==
X-Gm-Message-State: AOAM530s3Lo3DdhMQUi9yrKj4H9Siyc9EsAcWsxvSkvJLCYkEVOFhmie
        NpiIG99bhBXg9QJsR16PtHH6ttoru55AQHRXDFeE8A==
X-Google-Smtp-Source: ABdhPJzwsSeBQ9p0c9q0Y8FRcx34We+BdEwhPsmnqyBN9DlgrfGhwepub6Xs5dnl/CskrDY7ZWHiqagdY7hXazz18Nw=
X-Received: by 2002:a92:189:: with SMTP id 131mr24167998ilb.40.1599573733037;
 Tue, 08 Sep 2020 07:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200908125813.8809-1-brgl@bgdev.pl> <20200908125813.8809-4-brgl@bgdev.pl>
 <20200908134957.GB1891694@smile.fi.intel.com>
In-Reply-To: <20200908134957.GB1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 8 Sep 2020 16:01:59 +0200
Message-ID: <CAMRc=MdECnhqbRCFAy7hMQrWvF+Vz-rAU1GSD+d85eRSM6L9Lg@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpiolib: unexport devprop_gpiochip_set_names()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 3:52 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 08, 2020 at 02:58:13PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Now that devprop_gpiochip_set_names() is only used in a single place
> > inside drivers/gpio/gpiolib.c, there's no need anymore for it to be
> > exported or to even live in its own source file. Pull this function into
> > the core source file for gpiolib.
>
> Did you miss to remove old file?
>
> >  drivers/gpio/Makefile       |  1 -
> >  drivers/gpio/gpiolib.c      | 47 +++++++++++++++++++++++++++++++++++++
> >  include/linux/gpio/driver.h |  2 --
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Arr yes, rebase failed me. :(

Bart
