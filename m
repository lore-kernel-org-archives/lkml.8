Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF61BC352A3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B823A217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="Tv8MZfQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgBFT0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:26:54 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39576 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgBFT0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:26:53 -0500
Received: by mail-vs1-f65.google.com with SMTP id p14so4547728vsq.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=S7KpLMUY7LiWZq/Kj/eAi+yNVL0NiKccJvwviJrN6LU=;
        b=Tv8MZfQyvsljJl/L3IaZhjvF0zhvW7SGNWz006rU+AEOnWunbxolvEn+ld89B6WyJW
         yn7gHQ2DktgOFMcX/tw2hqsr4MwhiimED2xSWJRNi0Apz814aNulaQTHc9vuGeK9IDNT
         It5U1ReUUYb4xFG50FuVrDTevCZD9OT1L6gMNuK6aOR8E6g97ydSvQuyTUAWyDPrMdh6
         vnjEkFc16T2U61hgk19+NgLZQA6IzseSsUaAl2CKt1oSsru/HYy478Lyv/RNrNgsMfJg
         E34mx0+Ekt0XJqgazqxe82zwubl03+fz1uevMPW37HhjqMn6CPFGAdE0XsKrux2KOFyn
         AYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=S7KpLMUY7LiWZq/Kj/eAi+yNVL0NiKccJvwviJrN6LU=;
        b=lHDNWIC08x/fv45y3j934x989hDvgiXYamtJrNCwo4VR8Rvr0xJ3D0wgnv5EK4X4BM
         Yugayaw0JSkJJZU5MGMGQVwkZeiRYaePaRUhtwbyupMgHwfT5ioKYKNrdjBjPY2BVePn
         aLM7ESOx0dMwJIBdcTE8qnjXJ5Dvz26/aRVQ44HDiDQUtwIcbMUGb2FHXuF6yLaX1x/n
         m8uDrmHP/BLqEM3JhD7Os5tWdxJZiFk4pwI45C2yFaTGfwHwztEiCctsyboaOrzCwCqf
         9SUcM0CwPfNYCuI0VNd7zchIrPJ+8joXjeUFlHQT0TVua36cJ8PLLB8onpV1HASCLvyb
         rh9Q==
X-Gm-Message-State: APjAAAViEc92QLX1c9CZY4v5d7SjLxYHZFs4mXJYzresfg5/8hgtK2nk
        jzFskRzBVByuhygS1Y90BfKBEbS+/LKGlxlHVTlgRg==
X-Google-Smtp-Source: APXvYqwoojhOiE1bY8Keza3r5GUPbzrgIujBGiCbM5sfzEmHarjYTwY433tNBdAO58ymcgqBI0TN5G4Kv1fiGkD0b+o=
X-Received: by 2002:a67:d011:: with SMTP id r17mr2575599vsi.159.1581017212681;
 Thu, 06 Feb 2020 11:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20191219172823.1652600-1-anarsoul@gmail.com> <CAHLCerPWEDqEE8LRUiO5GpeP+BfnestocndBQq6oXAxVN=+3ow@mail.gmail.com>
 <20200206155703.fyry7nh473mc7pqy@core.my.home>
In-Reply-To: <20200206155703.fyry7nh473mc7pqy@core.my.home>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 7 Feb 2020 00:56:41 +0530
Message-ID: <CAHLCerMLFYRNUfPAzbUTZkn33P7LG5PtHMNiSJ2GMCoJ=0k74w@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
To:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 9:27 PM Ond=C5=99ej Jirman <megous@megous.com> wrote=
:
>
> Hi Amit,
>
> On Thu, Feb 06, 2020 at 07:43:59PM +0530, Amit Kucheria wrote:
> > Hi Vasily,
> >
> > For this entire series, the DTS files don't contain any trip points.
> > Did I miss some other series?
> >
> > At a minimum, you should add some "hot" or "critical" trip points
> > since then don't require a cooling-map with throttling actions. If you
> > have "passive" trip points, then you need to provide cooling-maps.
> >
> > Since this series has been merged, could you please follow up with a
> > fixup series to add the trip points?
>
> I don't think lack of trip points causes runtime issues. Or does it? I pl=
anned
> to send update with some trip points and cooling maps for 5.7 merge windo=
w.
> Is this acceptable?

Yes, I think that would be fine.

> If not, I can send a patch that adds:
>
> + trips {
> +         cpu-very-hot {
> +                 temperature =3D <100000>;
> +                 hysteresis =3D <0>;
> +                 type =3D "critical";
> +         };
> + };
>
> and
>
> + trips {
> +         gpu-very-hot {
> +                 temperature =3D <100000>;
> +                 hysteresis =3D <0>;
> +                 type =3D "critical";
> +         };
> + };
>
> everywhere where appropriate. Though that will make rebase of out of
> tree patches that already have a more complicated setup to be sent for th=
e next
> merge window a bit tedious.

Right, don't do that.

> thank you,
>         Ondrej
>
> > Regards,
> > Amit
> > p.s. We should catch all this automatically, I'll send out yaml
> > bindings for the thermal framework soon that should catch this stuff.
