Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F169CC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA31B20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="GtADa9cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCTIHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 04:07:40 -0400
Received: from hermes.aosc.io ([199.195.250.187]:48405 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgCTIHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 04:07:40 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 4DFA54CC97;
        Fri, 20 Mar 2020 08:07:37 +0000 (UTC)
Date:   Fri, 20 Mar 2020 15:58:09 +0800
In-Reply-To: <CACRpkdaVrfd1p+WyACy-gq-3BPsXJ_CZwi2OZe+=csseBcvcaA@mail.gmail.com>
References: <20200316133503.144650-1-icenowy@aosc.io> <20200316133503.144650-3-icenowy@aosc.io> <CACRpkdaVrfd1p+WyACy-gq-3BPsXJ_CZwi2OZe+=csseBcvcaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/5] dt-bindings: panel: add binding for Xingbangda XBD599 panel
To:     linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Ondrej Jirman <megous@megous.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <491ADD02-5511-404B-88A8-5725EF061EAC@aosc.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1584691659;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=stsS4dj9oBV/7b45QdrFyqP0smVpfXDmrt3Ueus/OeQ=;
        b=GtADa9cpqzkGuQKMBAZQjihl/+F10s/Hpdjay+d0XsQ1X1T0QH1GPjjqXzeH7LKeP1+eaE
        PFopxiao42wyUcVgcZaQTj5Za9JwlH36zazAmYYv3wkGqvuSHY1oT67WPNFq1YHUyqENjh
        8P3ylWO5/C4wiSlzq9FMcI7DoyWHAKM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B43=E6=9C=8819=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=881=
0:14:27, Linus Walleij <linus=2Ewalleij@linaro=2Eorg> =E5=86=99=E5=88=B0:
>Hi Icenowy,
>
>On Mon, Mar 16, 2020 at 2:37 PM Icenowy Zheng <icenowy@aosc=2Eio> wrote:
>
>> Xingbangda XBD599 is a 5=2E99" 720x1440 MIPI-DSI LCD panel=2E
>>
>> Add its device tree binding=2E
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc=2Eio>
>(=2E=2E=2E)
>
>> +properties:
>> +  compatible:
>> +    const: xingbangda,xbd599
>
>As noticed in the review of the driver, this display is very close to
>himax,hx8363=2E
>
>I think the best is to determin what actual display controller it is,
>I think it is some kind of Ilitek controller since Ilitek ili9342 is
>clearly very similar=2E

It's Sitronix ST7703, same as the Librem 5 panel=2E

>
>The best would be something like name the bindings
>ilitek-ili9342=2Eyaml and then:
>
>properties:
>  compatible:
>    items:
>      - const: xingbangda,xbd599
>      - const: ilitek,ili9342
>
>Possibly use oneOf and add support for the himax,hx8363
>already while you're at it=2E
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
