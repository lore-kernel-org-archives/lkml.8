Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90943C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 15:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5261B206F5
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 15:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0oIvEOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgDEPCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 11:02:04 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35517 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgDEPCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 11:02:04 -0400
Received: by mail-il1-f196.google.com with SMTP id 7so12245577ill.2;
        Sun, 05 Apr 2020 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=g8MbrIxOq0zCTo9fKog8mhMy9bOW8Fg9D9RRomTrVFI=;
        b=c0oIvEOdEgPWSDDAJkRrteqAJ3sCP4mCe/YU5gQyLw7rZEqtGK3507vguvbOdjP0Ku
         l/gsKL4J9b55i0DtEkFtOrwhBm9U/Ud17zTpDyGTAtqirorOHRySO1PQ2DTpj8My2A36
         QI8PVjlCjThg1wzF8PEAbT/Fj2TVpekpwd82Jn6Rm48N7aj2COYNCPr5f5AUPEraQVIb
         RQxjVxFxo/KJcJsMlulaasXOgVZ6b1hpo8jVevu095Ezb4QRJpZai8VErHtcWIpY77xi
         gPJbT3QZJioFrrvD+9Id+v9oBZgWb/axGwLn2rqkmaxybnljKKmMRejVqScpghWMmJKD
         ZOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=g8MbrIxOq0zCTo9fKog8mhMy9bOW8Fg9D9RRomTrVFI=;
        b=RL0DuaqWP5W8KZTVooKJH53TWwcAfwOnBMbmxSVaDpgZq+Rpm8amAPiSftyfGk3Ykd
         eOdE8m4r0lBZCtRWSkwVrWqAeJPrW3XeVRNsHA4SmiwP58edhE8G0YcGaU7w3WxYB1px
         Nr11/dgeFlliDa4Gt2YTYgNm+vGCcs5IBvbJt06N3k3K2P7EWP0AISCehmhMK19hwh+S
         2TfBh3hZBOcrD9SFfK49RoOuS6SDYXNuAVqQGXcrUXeO/SccWtgT8oyv3hMN8uM3B+QY
         G/TqgyHkFw1CAJOXpB/HRJ/ESj4c5MMZvvCLbpBDduq+k06V6035wfhJ0pOlBrU1ayam
         wyJA==
X-Gm-Message-State: AGi0PuYLINfheUPWueSW4PYYmaiS9fmix9jN40VeDK59kep2G8C2PSVQ
        DPGuamzv7/8OkDgPdofgfjP6IA7cvuLpQmln2/U=
X-Google-Smtp-Source: APiQypL0dkIH9W+iVFh+3Kch1QpTGXIz6w0urhh9Ynz7E5vaHn9o5pPCdsvh7b7WT0kXp4kHiPPmamoXZdEpSSTdNn8=
X-Received: by 2002:a05:6e02:6cd:: with SMTP id p13mr16728576ils.150.1586098922818;
 Sun, 05 Apr 2020 08:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200405104913.22806-1-peron.clem@gmail.com> <20200405115138.vrrvv7spnv6ifm6x@core.my.home>
 <CAJiuCcfAKCs5ZLi_O21eyx-ZraC2Sb_ugQSmOEYm5+eVkQ7ZSw@mail.gmail.com> <20200405145443.uycsh73kxmurdmil@core.my.home>
In-Reply-To: <20200405145443.uycsh73kxmurdmil@core.my.home>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 5 Apr 2020 17:01:51 +0200
Message-ID: <CAJiuCceROWv1ni3YZ6rU71O9R__t6ZOgnkZQDjBhJvhqHRAVng@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 0/7] Add support for Allwinner H6 DVFS
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 5 Apr 2020 at 16:54, Ond=C5=99ej Jirman <megous@megous.com> wrote:
>
> Hi,
>
> On Sun, Apr 05, 2020 at 04:33:37PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Ond=C5=99ej,
>
> [ ... ]
>
> > Good point, this information should be added for both CPU and GPU regul=
ator.
> > This could be nice to confirm this point with a scope.
> >
> > Also I remark that Allwinner user higher temperature than what we set :
> > alarm_low_temp =3D <105000>;
> > alarm_high_temp =3D <110000>;
> > alarm_temp_hysteresis =3D <15000>;
> > shut_temp=3D <115000>;
> > https://github.com/orangepi-xunlong/OrangePiH6_Linux4_9/blob/master/arc=
h/arm64/boot/dts/sunxi/sun50iw6p1.dtsi#L1924
> >
> > Don't you think that we can push a bit higher the temperature it's
> > actually at 80=C2=B0C ?
>
> We probably can. But just 5=C2=B0C between high temp and criticla temp is=
 probably
> not enough. I'd probably set our value to something like 90-100=C2=B0C so=
 that quick
> temperature spike before regulation kicks in would not shutdown the CPU.

OK I will push it to 85=C2=B0C and leave the critical to 100=C2=B0C.

Test it again and will send a v2

Regards,
Cl=C3=A9ment

>
> regards,
>         o.
>
> > Thanks for the review,
> > Clement
> >
