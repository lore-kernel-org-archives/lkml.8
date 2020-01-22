Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E7AC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA7A24676
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="eCc0tJA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAVA0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 19:26:51 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41552 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgAVA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 19:26:51 -0500
Received: by mail-qt1-f194.google.com with SMTP id k40so4274971qtk.8;
        Tue, 21 Jan 2020 16:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UwmgdlKgjHnFDwXPHQDLPIyA4oIjjd9BxxZ8z8xhCpA=;
        b=eCc0tJA5csuUZzPSGPdjWmMJX0rRaY8x9WRKXujplY35imBuATdPOK5iz8g1Nsg5FH
         ecVDPh3N20JD8aMFdZ2cIYpQHV5ER8GjbJ0Sba7wV3YjJhCTFkF0V8B/evkJfxeHEkJY
         vWsTo+LO6vMvczAfqBQyp81H/80DDDo7xQEYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UwmgdlKgjHnFDwXPHQDLPIyA4oIjjd9BxxZ8z8xhCpA=;
        b=CBF3w8lBUj8enOxOffbVplppU2NT4Hr63eaWRQOyrimvw0hZYmnDqQokgDkrfr8fOc
         KqFILyD+gG01+RrgeR4Y3xhxWz9TCjoOhZ7VlwuLqephtfVB6wePCI0oitEAjaCD0n9n
         1GCODJEoEkOhbsCRxcEg+PBazlLajCBQ5j7dwqxsAaMhibouF9qV3g4fIYoANyS5NDZD
         RBfOiLK2qfImTZqZA06EeyNfgtcF2wtpykxS4TRRiCTZ9IYEWbYIst9mqtFGxa3r8uyg
         oPqPO2Y0W0D5DEsA9pOnVEWqMA78EsFcJfm+UHUKYW47GHVBd8B3vigPbNb7hVbL4gIo
         Trjg==
X-Gm-Message-State: APjAAAUZPF0EYt/Y2e31h76sf/pJEYRINZQNWHEz5WmoxxRJEaXXtufE
        PZ5NpSiG6AFa27w7mlttvTwtOYf/SpvwpO2g2zg=
X-Google-Smtp-Source: APXvYqwN5FQEcVX8mIhlSegiZeaAu5eJlYidrimv8ngT4f5S3vD71f0OFT/wRQkS6eo1g8RNHSwolhJUcxduZ04xsww=
X-Received: by 2002:ac8:1ac1:: with SMTP id h1mr820343qtk.255.1579652810173;
 Tue, 21 Jan 2020 16:26:50 -0800 (PST)
MIME-Version: 1.0
References: <1577350475-127530-1-git-send-email-pengms1@lenovo.com>
 <CACPK8XeY5dPHtRfFD55dLVHT0SF1gJEVf1DixsbJKpciLP2s5Q@mail.gmail.com> <85dc718f42f54d40ad50853c047ec3ae@lenovo.com>
In-Reply-To: <85dc718f42f54d40ad50853c047ec3ae@lenovo.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 22 Jan 2020 00:26:38 +0000
Message-ID: <CACPK8XctO0SraKF_0Z40S_bBjz_ooQacpej3tMxwTq6XD90DGg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1 1/1] ARM: dts: aspeed: update Hr855xg2
 device tree
To:     Andrew MS1 Peng <pengms1@lenovo.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Derek Lin23 <dlin23@lenovo.com>,
        Harry Sung1 <hsung1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020 at 08:07, Andrew MS1 Peng <pengms1@lenovo.com> wrote:
>
> Hi Joel,
>
> Please help to check below my comments. Thanks.
>
> Regards,
> Andrew Peng
>
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Joel Stanley <joel@jms.id.au>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2020=E5=B9=B41=E6=9C=886=E6=97=A5=
 14:48
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Andrew MS1 Peng <pengms1@lenovo.com>
> > =E6=8A=84=E9=80=81: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> > <mark.rutland@arm.com>; Andrew Jeffery <andrew@aj.id.au>; devicetree
> > <devicetree@vger.kernel.org>; Linux ARM
> > <linux-arm-kernel@lists.infradead.org>; linux-aspeed
> > <linux-aspeed@lists.ozlabs.org>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; Benjamin Fair <benjaminfair@google.com>=
;
> > OpenBMC Maillist <openbmc@lists.ozlabs.org>; Derek Lin23
> > <dlin23@lenovo.com>; Yonghui YH21 Liu <liuyh21@lenovo.com>
> > =E4=B8=BB=E9=A2=98: [External] Re: [PATCH v1 1/1] ARM: dts: aspeed: upd=
ate Hr855xg2
> > device tree
> >
> > On Thu, 26 Dec 2019 at 08:54, Andrew Peng <pengms1@lenovo.com> wrote:
> > >
> >
> > When you have a list of things like below, it's sometimes a good hint t=
hat you
> > should be sending one patch for each bullet point. This makes it easier=
 to
> > review.
> >
>
> Should I separate below changes to six patches for next patch version?
> For example: [PATCH v2 0/5]  [PATCH v2 1/5] ...etc

It's up to you.

I do not require it.

>
> > > Update i2c aliases.
> > > Change flash_memory mapping address and size.
> > > Add in a gpio-keys section.
> > > Enable vhub, vuart, spi1 and spi2.
> > > Add raa228006, ir38164 and sn1701022 hwmon sensors.
> > > Remove some unuse gpio from gpio section.
> >
> > unused?
> >
>
> It was my mistake, the correct sentence should be "Remove gpio from gpio =
section since it controlled by user space."
>
> > >
> > > Signed-off-by: Andrew Peng <pengms1@lenovo.com>
> > > Signed-off-by: Derek Lin <dlin23@lenovo.com>
> > > Signed-off-by: Yonghui Liu <liuyh21@lenovo.com>
> >
> > I got two copies of this. I think they are the same.
> >
>
> I apologize to send twice.
>
> > > ---
> > > v1: initial version
> > >
> > >  arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts | 557
> > > ++++++++++++++++-------
> > >  1 file changed, 382 insertions(+), 175 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> > > b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> > > index 8193fad..e1386d4 100644
> > > --- a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> > > +++ b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> > > @@ -15,14 +15,21 @@
> > >         compatible =3D "lenovo,hr855xg2-bmc", "aspeed,ast2500";
> > >
> >
> > > -               flash_memory: region@98000000 {
> > > +               flash_memory: region@9EFF0000 {
> > >                         no-map;
> > > -                       reg =3D <0x98000000 0x00100000>; /* 1M */
> > > +                       reg =3D <0x9EFF0000 0x00010000>; /* 64K */
> >
> > Do you really use 64K here, or was this a workaround for the lpc-ctlr d=
river
> > requiring a memory region?
> >
>
> We reserve 64K for L2A In-Band Firmware Update (phosphor-ipmi-flash).

Okay, thanks for clarifying.

I am happy with rest of your responses. Please send v2 with these things fi=
xed.

Cheers,

Joel
