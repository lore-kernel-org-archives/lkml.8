Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C57C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF256206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DfM0dsqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgFHMMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbgFHMMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:12:33 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706C6C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 05:12:31 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id e125so10063602lfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TBN6LwR1xQ7giOqILnPE//JlJlIgyTPuIyOhAD+Fs0g=;
        b=DfM0dsqO0f/Qnck/+Ah62rrhJWnxesv6sNiGtGlrUMkIZe0uxoX3qyYJ/QidMJamvz
         L6Bnwt3S8/SXA6KWjuV0bzahAGv1Sl1x5CS5ZEehyidgKzWz4cs/2fohftpz4t03IhmP
         CIv70QYr+yH0TB6vG8xKqYy3fw6Phyc4Ob7FxTujExXWYnwYzNFN5dt5DjZOB2jtHVyi
         pScpc+vtrc/434ZaGx0d5mEXfZ/lyQGuLIT9J5uRdtiXT2AiODcOPqwI9F21ZHqEftmT
         +8AxS85z10y6qTHVnRXGdeaO6dgqPm/WflvEoPVFPCoCi/JhDSoY89tbNu6R2JazK7tp
         A7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TBN6LwR1xQ7giOqILnPE//JlJlIgyTPuIyOhAD+Fs0g=;
        b=R05cNj28hxzllEU+Arf60KEaJsHjcfDWetY6kUcH5OiriqZtHdEyEyoClG/pr9/5Q1
         zOQYuVu29wP6dr+jcZiXV6j5m2KrJXJnfonb7FHn0Ve0mSy22eyySFSdEDRR3Pqc1P/8
         1O9/zuUc5lK2GIfpbNppEWuva72pgGvaRYTlynPoxwbz/1UIrqEax3DajzNJHwR4FTaw
         1vbx4MEZx99lOqzdvBFgFdEKUl4hycPtBY4QRkAKbtLtWj5rqgjCnk4bQeG/XILUhiw+
         WBTUNnNFzHZ7344UKlqYUBz3zOgzNT21QJOp1QfFDfzibjJlvdntNuLqdKnRT6DmpoDx
         vpkQ==
X-Gm-Message-State: AOAM532gBDkIbiEhOir7HO8G9X4HcRCP/GF1nqabvJc6HdWFPEts6mmO
        1gdUAoAxnNrdpEZu1pbTigH1iFvapAb5nOAU6daiYg==
X-Google-Smtp-Source: ABdhPJxmk7CcERIdwxefncHfN7iBpWg2VOzmqMraSrfW9OEJJz2SzxogXSAbo+g1hJ04P05NhatbtFCl4F1ofn3LcNs=
X-Received: by 2002:a19:c8cb:: with SMTP id y194mr12833236lff.89.1591618349925;
 Mon, 08 Jun 2020 05:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200526104717.3181-1-dinghao.liu@zju.edu.cn> <CACRpkdZi=UaGES_bupj_fQB+sPj5zOvONdCn7_Rs_j9mcukAAQ@mail.gmail.com>
 <20200531150000.20d1ec61@archlinux>
In-Reply-To: <20200531150000.20d1ec61@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Jun 2020 14:12:18 +0200
Message-ID: <CACRpkdZy0Pip1ii0g+PYpnkO21e6=J0ZXzudEgvEycCbmWYJxA@mail.gmail.com>
Subject: Re: [PATCH] [v2] iio: magnetometer: ak8974: Fix runtime PM imbalance
 on error
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, Kangjie Lu <kjlu@umn.edu>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

sorry for missing this :(

On Sun, May 31, 2020 at 4:00 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 26 May 2020 13:13:56 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > On Tue, May 26, 2020 at 12:47 PM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
> >
> > > When devm_regmap_init_i2c() returns an error code, a pairing
> > > runtime PM usage counter decrement is needed to keep the
> > > counter balanced. For error paths after ak8974_set_power(),
> > > ak8974_detect() and ak8974_reset(), things are the same.
> > >
> > > However, When iio_triggered_buffer_setup() returns an error
> > > code, there will be two PM usgae counter decrements.
> > >
> > > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> > > ---
> > >
> > > Changelog:
> > >
> > > v2: - Change 3 goto targets from "power_off" to
> > >       "disabel_pm". Remove unused lable "power_off".
> > >       Move 3 PM runtime related calls to the end of
> > >       the function.
> >
> > Thanks for fixing this Dinghao!
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Could I have a fixes tag for this one?

It's been  there since the beginning so:
Fixes: 7c94a8b2ee8c ("iio: magn: add a driver for AK8974")

Yours,
Linus Walleij
