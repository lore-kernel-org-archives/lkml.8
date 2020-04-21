Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AA6C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF1B2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="Ha4YDa8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgDUDvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 23:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDUDvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 23:51:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05CBC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 20:51:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id re23so9862659ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 20:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JwKKrpGN9bGHa6yzCTNYdUWBtPrU+5dunfBlkrEsoq4=;
        b=Ha4YDa8RzqgRBLGgtET6TgiypxyCOMB5mu9I0dWakEjcbxf/LpAIjOPGfdIa/h1++8
         /ha2eDCyFV8iuytiCG/YQUY6Uh58skPrPrpIIzs4N5tiqKLchkQyqYduLxtw02EQyMH8
         vFGBg/K/4iK1gSuLTLIgWAG8x5u9PnhJdpx0hefmVdeDh33hsWoFsmZCygkNBUdOPp/C
         ouJ1P1AumF2PJfkQGB1fMWPnAv+/KSRp8QaMP4Nq4KHj+0a7mW+rKLJb4T4SBEnmPBO2
         9K3K0HuLQ0BomjyLGaCjxx2bxLFlwqiYP/obPg/xJY+Z8wW6MbUPkPHzi1CILlhFtiHK
         IF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JwKKrpGN9bGHa6yzCTNYdUWBtPrU+5dunfBlkrEsoq4=;
        b=URgIO11C54RUOl59HsSQyNz+parLzUPVd8GW/w6TwdAe5i98ztrcRoR5QTGIDi3NJZ
         lbnYMomex3hHnZaPaqwPDgxlMbtaPyCn1HoFO+tsZFf6i1Kw5cW574/U/jFXTg/cPF00
         qb7YYJn/PGqDAjrFsWG/qZtOQk7XFCNOHXawJYqC+G1AqVyhJs4c/OOO7PahtrMYdXjl
         OpZ00kKX9dL6yoE5Bs4aY+BJRexLIAg6a8VbYPK+rqzBhOepqDn59zWkUdTuS2PzXzK3
         N1RLD5bjT6Rk2r97QSm+oKH3yhJv1HS7gp7JdOCoKmjAlak0NyiEQnpHfNholRKBvzrI
         DLkQ==
X-Gm-Message-State: AGi0Pub0tvbGEaJd2qxZ+8XHd7i2d6M/299+Kk8EhfHdQb40df/IF4Xv
        ydbNBKM143AiO8X4whFFLs+qUaHFJqagIxMDVYjh+A==
X-Google-Smtp-Source: APiQypKq0NoVkoQsH8O11s3ikua5Aa3+HM1uQAPkbhDvRn6bgnoFYLGtCALPQwjmt8CmqzkRqsccMyNMiBh5FBtH7fE=
X-Received: by 2002:a17:906:680b:: with SMTP id k11mr19265015ejr.46.1587441091301;
 Mon, 20 Apr 2020 20:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200408010232.48432-1-samuel@sholland.org> <244922ec-ed3a-eca7-6640-49de7ad9c605@sholland.org>
 <20200420151010.GL125838@aptenodytes> <5590139.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <5590139.lOV4Wx5bFT@jernej-laptop>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 21 Apr 2020 00:51:19 -0300
Message-ID: <CAAEAJfCjUY3JeZ1dmVwkQaumoCbv8OR0FTP9Prdg=RS=gh_NUg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] media: cedrus: Implement runtime PM
To:     jernej.skrabec@gmail.com
Cc:     Samuel Holland <samuel@sholland.org>, linux-sunxi@googlegroups.com,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej, Paul:

On Mon, 20 Apr 2020 at 13:41, Jernej =C5=A0krabec <jernej.skrabec@gmail.com=
> wrote:
>
> Dne ponedeljek, 20. april 2020 ob 17:10:10 CEST je Paul Kocialkowski
> napisal(a):
> > Hi,
> >
> > On Sun 19 Apr 20, 15:28, Samuel Holland wrote:
> > > On 4/8/20 11:01 AM, Jernej =C5=A0krabec wrote:
> > > > Hi Samuel!
> > > >
> > > > Dne sreda, 08. april 2020 ob 03:02:32 CEST je Samuel Holland napisa=
l(a):
> > > >> This allows the VE clocks and PLL_VE to be disabled most of the ti=
me.
> > > >>
> > > >> Since the device is stateless, each frame gets a separate runtime =
PM
> > > >> reference. Enable autosuspend so the PM callbacks are not run befo=
re
> > > >> and
> > > >> after every frame.
> > > >>
> > > >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> > > >> ---
> > > >>
> > > >> I tested this with v4l2-request-test. I don't have the setup to do
> > > >> anything more complicated at the moment.
> > > >>
> > > >> ---
> > > >>
> > > >>  drivers/staging/media/sunxi/cedrus/cedrus.c   |   7 ++
> > > >>  .../staging/media/sunxi/cedrus/cedrus_hw.c    | 115 ++++++++++++-=
-----
> > > >>  .../staging/media/sunxi/cedrus/cedrus_hw.h    |   3 +
> > > >>  3 files changed, 88 insertions(+), 37 deletions(-)
> > >
> > > [snip]
> > >
> > > > Reset above causes problem. When format is set in cedrus_s_fmt_vid_=
cap()
> > > > a
> > > > function is called, which sets few registers in HW. Of course, ther=
e is
> > > > no
> > > > guarantee that someone will start decoding immediately after captur=
e
> > > > format is set. So, if the driver puts VPU to sleep in the mean time=
,
> > > > reset will clear those registers and decoded video will be in diffe=
rent
> > > > format than expected. It could be even argued that registers should=
 not
> > > > be set in that function and that this is design issue or bug in dri=
ver.
> > >
> > > You're right. I didn't see that cedrus_dst_format_set() was called ou=
tside
> > > cedrus_engine_enable/disable().
> >
> > This might indeed be an issue with multiple decoding contexts in parall=
el,
> > with potentially different formats. For that reason, it looks like the
> > right thing to do would be to set the format at each decoding run based=
 on
> > the format set in the context by s_fmt.
>
> So you are suggesting that cedrus_dst_format_set() should be moved to
> cedrus_device_run(), right? This way all registers are set at each run, w=
hich
> is then truly stateless.
>

BTW, this is how the Hantro and Rockchip's Rkvdec
drivers are implemented. One of the main reasons is
to have simultaneous decoding support.

Thanks,
Ezequiel
