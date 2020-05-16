Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9221BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A3720671
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sb2u9Onl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgEPJu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 05:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726188AbgEPJu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 05:50:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7162FC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 02:50:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id o14so4799935ljp.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 02:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1GD9cgKsC79o9xJsFY0Rns6nb+f4FHwgFZwwSnHIkTc=;
        b=sb2u9OnlDoL8lkNLTwelDEfXi/WEWCJjI3l+P0QcJOHgy9wSzCLwwc1VkUZa/OoGnA
         DUue2YQa+84RNibQpALhfGWyLO8ISaZJBZ1i14d3Bhsg3yV4Xc+OFzhPNdhl4rYe2Djb
         fBewE/WyObg4MkP3XmpHGrl8BoGlq6sLUMPkJciEZ+nkRZgpOy1xSOpdFjmRzqhveq9O
         FHDUEd1RqoBo7lNAbzOR4vGEWR2FTJXpv70HrrPfekZeZEE6PLmHRR7P76kOM+FaQcMK
         2FUlRXgnq+TCik3LC9RMsq2UCen8+25JIeP8m2wepXbgzJzUM6wk076iGwXin06dzd39
         UVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1GD9cgKsC79o9xJsFY0Rns6nb+f4FHwgFZwwSnHIkTc=;
        b=FTtrkkN7I2kmJn062dJ/Cn2LR1VgGFgU8kASuvgWD58gAUlOE0HG6MudfiAlmVZwzg
         wcfoANhtgGSOK+MNWl+TLJYVj0qldVQVrkem7LmJAzDZBHMPsCR/mJizEdkNWi/Ge2ra
         PlzEk5V5A9f55pWU7u/0gAvLL6Shpir5z+hbImvXMDcgDK/7llqZ1Qf32+mJGRvlTv8Z
         8WptQX4mULlBQ96HANsJ2fQQdvAjegvw1TWO+pzT6lCQPaXByUPPa+v+yJ1BEDSdzvJ8
         lzqKz2PbSFTvTRIBPHepoze9fcQGVaq8MLwVznc3cRqoPZZZC6Ga99b6SuY2s6irD/0i
         Lg7A==
X-Gm-Message-State: AOAM532Eh0G7zV/JRrVorK1g5TdpfWPH9+a665oIyDAxfnZHDAkphGVA
        iFJxLRgnprQqVjljzMC6ybE8HZxf+Rx7tTgl5ofnM5xFlOk=
X-Google-Smtp-Source: ABdhPJwkRrLnDqSZW2Mpi1EcGqJXQJ6amPZbPk+Px2GETB6jrwczKWRBcTjwl8q/ztLfiuhOzxTwXKsTf9W3DppXQkU=
X-Received: by 2002:a05:651c:154:: with SMTP id c20mr4472762ljd.99.1589622655910;
 Sat, 16 May 2020 02:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200224094158.28761-1-brgl@bgdev.pl> <20200224094158.28761-3-brgl@bgdev.pl>
 <CACRpkdZSooH+mXbimgT-hnaC2gO1nTi+rY7UmUhVg9bk1j+Eow@mail.gmail.com>
 <CAMRc=Mf2Mx+rB7du8D66WP=Js0wuK8x44aT9H2q6JhLJvrOcVQ@mail.gmail.com>
 <CACRpkdaPwfpfDJ2CjGCVFbMvXaSnCXaisvb2N-edeZO0Tbkssw@mail.gmail.com>
 <CAMRc=Mf5cYtWxAVeMQmxwyoi9oxtVSidBQsdRV9H2E52H1TqKQ@mail.gmail.com> <CAMRc=MenC3i-jQYPMdnOfpvNvs1GzCo-B5oem3osdaZZ9mULag@mail.gmail.com>
In-Reply-To: <CAMRc=MenC3i-jQYPMdnOfpvNvs1GzCo-B5oem3osdaZZ9mULag@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 16 May 2020 11:50:45 +0200
Message-ID: <CACRpkdaAYox65p9=Aheu5iomJRGPBc7CvnxJqPeqXdNdunAXPg@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpiolib: use kref in gpio_desc
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 3:42 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> So this "numbing down" of the chip works - in that I don't see any
> splat in the above use-case but right now if nvmem takes an existing
> GPIO descriptor over nvmem_config, then it will call gpiod_put() on it
> and we'll do the same in the provider driver leading to the following
> warning:

Isn't that the WARN_ON(extra_checks) in gpiod_free()?
What part of the if() clause is causing this? I.e.:
if (desc && desc->gdev && gpiod_free_commit(desc)) ...

I suspect gpiod_free_commit() is causing it by returning nonzero.
We could essentially ignore that if and only if the gpio_chip
has been detached from the gpio_device.

This should fix the problem if I'm right.

Yours,
Linus Walleij
