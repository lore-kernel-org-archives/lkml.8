Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D018CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 01:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7AFE206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 01:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593395983;
	bh=dX0ond8LQtfn1hNhjsh/h9hbAMSX/l0mn+zPmUSb8l4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T5RmbGSxOy4LdE8z1kY9JxO/e7bbowp44PTFIsewWlDpDHDvbIF/VNu2LiXckKwVa
	 6jHSlEz9YWpQhdgLxIpUxoGWocaL7A/ZkzZbhlnWKU7ZKYQNb56DTUF6WXHHv45wBH
	 iweFvIupk74cEFbOZjbzb96dfTy01aGtetzQiCg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgF2B7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 21:59:19 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:52993 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgF2B7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 21:59:18 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 05T1wrhY026679;
        Mon, 29 Jun 2020 10:58:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 05T1wrhY026679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593395934;
        bh=9tkczWrDF94rquYkpshg2066UxbdWAU7/IQZMMHgcHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MoUBXjDjfwrD004XaAp3FMcLiojjTf55KcU/DYvYxStWC40CZcjrT78rvjMFch90P
         HlltjJnPbG5QhlSt/EgW0HF0IOWOWgOV53vEtx00cOensKuUnjk2K/kGI+j4ChWX4/
         aLK1eEe0SuGPdgm4MgdKa2VPfhrPI6RylthG0HnLGEnfl05LWSFqbVsopd8RcsjOvg
         nwqFY9A1QflE19mYgLutRkBS4+jqQNisPOgT8pEaVffVsgYpNDeCiZ3CMqj0GOhfft
         v77TMKMVIZXlx442Ad8ptxX1TasPNVvfUbOXIkj240jKJ5k4XJ+Zu9b97pusJypkIN
         EPEHtVDLArEKQ==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id p25so603529vsg.4;
        Sun, 28 Jun 2020 18:58:54 -0700 (PDT)
X-Gm-Message-State: AOAM533PkJpGLG87aVtYiN8garf64zRObOUFm5K8B0HRucVRIyTB5pmE
        6QZPkC7/BbLQHRxt8SKq9i+Bi210dknkgxiSKe8=
X-Google-Smtp-Source: ABdhPJwwt9nTyJt4lJs7J7MMu8vv3Mejl87SDD9G5fLdcZ9lM2EsdqTD+d8PRiUxM0DLIMECB7cyX4bKJHxdyHuX5I8=
X-Received: by 2002:a67:6383:: with SMTP id x125mr9987726vsb.54.1593395933076;
 Sun, 28 Jun 2020 18:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200623114614.792648-1-yamada.masahiro@socionext.com>
 <20200623114614.792648-4-yamada.masahiro@socionext.com> <20200623122413.GA954398@dell>
 <CAK7LNAR-dm6Zbtt9MsUunn9+qqwTtRCbq4Wzb=8uKLtfaLK6TQ@mail.gmail.com>
 <20200624181605.GJ954398@dell> <CAK7LNATFUX56t=wn-3qOSYLwESp63gqDWjADEVQ1g1CYrGxA3g@mail.gmail.com>
 <20200625145726.GT954398@dell>
In-Reply-To: <20200625145726.GT954398@dell>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 29 Jun 2020 10:58:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQdoe_eS8d9AoF1p4QgAB7oUM9aA+qgFS2GwPZsZbTnhg@mail.gmail.com>
Message-ID: <CAK7LNAQdoe_eS8d9AoF1p4QgAB7oUM9aA+qgFS2GwPZsZbTnhg@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: uniphier: change support card to simple-mfd
 from simple-bus
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 11:57 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 25 Jun 2020, Masahiro Yamada wrote:
>
> > On Thu, Jun 25, 2020 at 3:16 AM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Thu, 25 Jun 2020, Masahiro Yamada wrote:
> > >
> > > > On Tue, Jun 23, 2020 at 9:24 PM Lee Jones <lee.jones@linaro.org> wr=
ote:
> > > > >
> > > > > On Tue, 23 Jun 2020, Masahiro Yamada wrote:
> > > > >
> > > > > > 'make ARCH=3Darm dtbs_check' emits the following warning:
> > > > > >
> > > > > >   support-card@1,1f00000: $nodename:0: 'support-card@1,1f00000'=
 does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> > > > > >
> > > > > > Maybe, simple-mfd could be a better fit for this device.
> > > > >
> > > > > The two should be equivalent.
> > > >
> > > > Yes, I know.
> > > > That's why I can change "simple-bus" to "simple-mfd"
> > > > with no risk.
> > > >
> > > > The difference is schema-check.
> > > >
> > > > The node name for "simple-bus" is checked by 'make dtbs_check'.
> > > >
> > > > See this code:
> > > > https://github.com/robherring/dt-schema/blob/v2020.05/schemas/simpl=
e-bus.yaml#L17
> > > >
> > > > Even if I rename the node, it does not accept the
> > > > unit name '1,1f00000'
> > > >
> > > > > What do you mean by "maybe"?  Does this squash the warning?
> > > >
> > > > "maybe" means I am not quite sure
> > > > which compatible is a better fit
> > > > to describe this device.
> > > >
> > > > As mentioned above, simple-bus and simple-mfd
> > > > are interchangeable from a driver point of view.
> > > >
> > > > This add-on board is integrated with various peripherals
> > > > such as 16550a serial, smsc9115 ether etc.
> > > > The address-decode is implemented in a CPLD device.
> > > > It has chip selects and local addresses, which are mapped to
> > > > the parent.
> > > >
> > > > It can be either simple-bus or simple-mfd, I think.
> > > >
> > > >
> > > > dt-schema checks the node name of simple-bus.
> > > > Currently, there is no check for simple-mfd.
> > > >
> > > > So, I think this patch is an easy solution
> > > > to fix the warning.
> > >
> > > Yes, looking at the documentation it seems as though 'simple-mfd'
> > > would be a better fit.  Is the device a single IP with various
> > > different functions?
> >
> > Not an IP.
> >
> > This is a small board that consists of
> > a CPLD + ethernet controller + serial controller + LED, etc.
>
> Then simple MFD does not seem like a good fit.
>
> Neither does 'simple-bus'.

Then, I do not know what to do.


This board connection is so simple
that no hardware initialization needed to get access
to peripherals.

So, 'simple-bus' or 'simple-mfd' is preferred.

If this is not either simple-bus or simple-mfd,
I need a special driver to probe the
child devices such as ethernet, serial etc.



> What is it you're trying to describe in the device hierarchy?


The connection is as follows:


|-Main board -|      |----- add-on board ----|
|             |      |     (this board)      |
|             |      |                       |
|    (SoC) ---|------|--- CPLD --- ethernet  |
|             |      |          |- serial    |
|-------------|      |          |- LED       |
                     |                       |
                     |-----------------------|



uniphier-support-card.dtsi describes the
"add-on board" part.
Address-decode is implemented in CPLD.


So, the criteria to become MFD is
whether it is an IP integrated into SoC.


- implemented in an SoC  --> MFD

- implemented in a board + CPLD  --> not MFD


Right?




>
> > > > Rob is in Cc. Please add comments if any.
> > > >
> > > > > Isn't the issue caused by the ','?
> > > >
> > > > Right.
> > > >
> > > > The node name of simple-bus
> > > > must meet the regular expression:
> > > > "^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$"
> > > >
> > > >
> > > > Even if I rename the node
> > > > "support-card@1,1f00000"
> > > > to "bus@1,1f00000", the warning is still
> > > > displayed due to ','
> > > >
> > > > "1,1f00000" means
> > > > the address 0x01f00000 of chip select 1.
> > >
> > > Is this an officially accepted format?
> >
> > I am not sure if it is official.
> >
> > Rob said the data fields should be separated by commas.
> > https://www.spinics.net/lists/devicetree/msg201565.html
>
> Are you sure he doesn't mean in the 'reg' property.
>
> Rather than the node-name@NNNNNNNN syntax.
>
> BTW, I think the error you link to above is related to the
> node-name@NNNNNNNN not matching the value listed in the 'reg'
> property.


If I get rid of @NNNNNNNN part,
DTC warns the following for W=3D1 builds:

arch/arm/boot/dts/uniphier-support-card.dtsi:12.29-32.4: Warning
(unit_address_vs_reg): /soc/system-bus@58c00000/support-card: node has
a reg or ranges property, but no unit name



So, 'reg' or 'range' requires a unit name.

A unit name should be a base address.
If it has a chip select, the format is
<chip-select>,<base-address>

But the schema does not allow commas
in a unit name of simple-bus.

This is the problem I am trying to do something for.





>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
Best Regards
Masahiro Yamada
