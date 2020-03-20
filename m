Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66CDC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCD920739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="cbDXi+Ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgCTJVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:21:52 -0400
Received: from hermes.aosc.io ([199.195.250.187]:50625 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbgCTJVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:21:52 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id A343A4D036;
        Fri, 20 Mar 2020 09:21:48 +0000 (UTC)
Date:   Fri, 20 Mar 2020 17:21:43 +0800
In-Reply-To: <CACRpkdbeLAyhhkx115zAV0tdC7KJ4T0UoQ2QeDwTVN+btxp=Jw@mail.gmail.com>
References: <20200316133503.144650-1-icenowy@aosc.io> <20200316133503.144650-3-icenowy@aosc.io> <CACRpkdaVrfd1p+WyACy-gq-3BPsXJ_CZwi2OZe+=csseBcvcaA@mail.gmail.com> <491ADD02-5511-404B-88A8-5725EF061EAC@aosc.io> <CACRpkdbeLAyhhkx115zAV0tdC7KJ4T0UoQ2QeDwTVN+btxp=Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/5] dt-bindings: panel: add binding for Xingbangda XBD599 panel
To:     linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>
CC:     Ondrej Jirman <megous@megous.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Chen-Yu Tsai <wens@csie.org>, Sam Ravnborg <sam@ravnborg.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <7BA1F742-0403-47E3-8E91-738947EB4809@aosc.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1584696109;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=lyI5nTAxlpI3YgUaSp33pj/yy+1x1RPrFPLEcSJxVcM=;
        b=cbDXi+EpOG5NSTFJo99k2SiBcR6aPtIoHvmuqhtKqGPOJLBqN+Xcb6lh+lQlNaRxsW1w40
        kMAphAv/W6+0Y8pPo53QMQ//grkWEtYOWMa/kPOnFNJ8Qdqbs7onGp5omHzkXWqVFt0m54
        WgnGaY86aOx+VuMBKQJQupX7ZcPuVck=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B43=E6=9C=8820=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=885=
:11:22, Linus Walleij <linus=2Ewalleij@linaro=2Eorg> =E5=86=99=E5=88=B0:
>On Fri, Mar 20, 2020 at 9:07 AM Icenowy Zheng <icenowy@aosc=2Eio> wrote:
>> =E4=BA=8E 2020=E5=B9=B43=E6=9C=8819=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=8810:14:27, Linus Walleij
><linus=2Ewalleij@linaro=2Eorg> =E5=86=99=E5=88=B0:
>> >On Mon, Mar 16, 2020 at 2:37 PM Icenowy Zheng <icenowy@aosc=2Eio>
>wrote:
>
>> >As noticed in the review of the driver, this display is very close
>to
>> >himax,hx8363=2E
>> >
>> >I think the best is to determin what actual display controller it
>is,
>> >I think it is some kind of Ilitek controller since Ilitek ili9342 is
>> >clearly very similar=2E
>>
>> It's Sitronix ST7703, same as the Librem 5 panel=2E
>
>Heh, I wonder how it comes that it is so similar to Ilitek=2E
>I guess I will never understand how the silicon ecosystem works
>in asia (I did read a lot of Bunnie Huang's articles and hardware
>hacking book to try to understand=2E=2E=2E)
>
>This file should be named sitronix,st7703=2Eyaml then=2E
>
>According to the code in the Librem 5:
>https://source=2Epuri=2Esm/Librem5/linux-next/blob/imx8-current-librem5/d=
rivers/gpu/drm/panel/panel-sitronix-st7701=2Ec
>The actual name of the display is Techstar ts8550b=2E

Sorry, for Librem 5 panel, I mean Rocktech JH057N00900 here=2E

This is also the code that my patchset based on=2E

>And the display controller is st7701, so maybe we should
>actually name it sitronix,st770x=2Eyaml if there are some
>sub-variants of st770x?
>
>> >properties:
>> >  compatible:
>> >    items:
>> >      - const: xingbangda,xbd599
>> >      - const: ilitek,ili9342
>> >
>> >Possibly use oneOf and add support for the himax,hx8363
>> >already while you're at it=2E
>
>This should at least be:
>
>compatible:
>   items:
>     - enum:
>       - xingbangda,xbd599
>       - himax,hx8363
>       - techstar,ts8550b
>     - enum:
>       - sitronix,st7701
>       - sitronix,st7703
>
>So panel nodes using this panel become
>compatible =3D "xingbangda,sbd599", "sitronix,st7703"
>etc=2E
>
>This way it is straight-forward for drivers to identify the panel
>vendor and display controller=2E
>
>Yours,
>Linus Walleij
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists=2Einfradead=2Eorg
>http://lists=2Einfradead=2Eorg/mailman/listinfo/linux-arm-kernel

--=20
=E4=BD=BF=E7=94=A8 K-9 Mail =E5=8F=91=E9=80=81=E8=87=AA=E6=88=91=E7=9A=84A=
ndroid=E8=AE=BE=E5=A4=87=E3=80=82
