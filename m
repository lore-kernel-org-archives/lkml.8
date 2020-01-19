Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9EEC33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F070246AE
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RpW/ireN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgASBIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 20:08:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43304 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgASBIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 20:08:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so30259797ljm.10;
        Sat, 18 Jan 2020 17:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AacwWKGmxUoGXrit3bF9ylLS3wXZpgvHLwTaKYgi69w=;
        b=RpW/ireN3w+1bwBpTacY+Z1NKdxGZUeDlAtj/ztPUxyaDz8fjxjgOXhI4BiV5GAK4P
         x3vBbsxKC2VYYrUDsOphEwohyRvDx99QCyGhY/e12B6xMhcdyRqaT3qKppkrBOzPQwlL
         KJLeGgD0p4kpAkLKJpEw8Jmu+gSc658JgnqoiFOKGJiyJJUhRQQ+kMLTa+0utyUl3wmV
         0aa54kMX7A88c88WwB4QZXpLQXijhRI9xFcaBKg55hc65pEMSrLTLE3qIDV5Mg7DAmKu
         acXUwglJ5PfRFd1nBQRfWmaEXPpj2N7L5Xa1sS6wnVZX49YMr9CL9CatK05HKVxxQ78M
         WXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AacwWKGmxUoGXrit3bF9ylLS3wXZpgvHLwTaKYgi69w=;
        b=CXo2NOOtNsVrYBRQu+6RMy6m+zWK+MGrWqZBmsI2lbGPhzqoW/qYnjahgFKtSvfa7K
         YbOSseAjBflQB5evueReDrie2Xwdwv/hV6H0UxsWrqHeb/bnifW1Hu8SrEB9afS5PerB
         jkVCG0Daqsd2TrfD0AKQ4Il/4YN6lNhJ0BQGZk6bvMNM4ZtyEGlAwCfRXxfQtGahN/ah
         zwokK4Lxf9F05kqBla6ZF6QWtDkuy0oqP7qhd2k41Qk7i1QJ/rnRU0kMMZUEwcqKF9yb
         scIWeVVdCGg4EqcPDpTddbPCugQVlBeK3dZdccx/xz4Ju5Weh8+bGdagljeuE+iVbes8
         SwGw==
X-Gm-Message-State: APjAAAWZrKY1hZE9wJv9HIfo2jXiRG+wduUknZIXtA0kFiSUjbTDFr4W
        WNsm9SDZcVL/heWbiR7pG5Oezq3z14Bqj6A37Ng=
X-Google-Smtp-Source: APXvYqzA22+3Ab2p8KzOLW/XygyGuPG7mUsIgFaYy39U/tQHQpBRZ4hZ6yGrXiX1R/69yFV/8ftvndEOHFXfMIpi+xY=
X-Received: by 2002:a05:651c:32b:: with SMTP id b11mr9814411ljp.203.1579396130247;
 Sat, 18 Jan 2020 17:08:50 -0800 (PST)
MIME-Version: 1.0
References: <20200118172615.26329-1-linux@roeck-us.net> <CANVEwpbgi5sUdBTyo330oCZ1T-cD+DoBJWrE9JbXw-DvYTiBvw@mail.gmail.com>
 <7345a801-6e9d-b85f-1a8a-72ee89cc0330@roeck-us.net>
In-Reply-To: <7345a801-6e9d-b85f-1a8a-72ee89cc0330@roeck-us.net>
From:   Ken Moffat <zarniwhoop73@googlemail.com>
Date:   Sun, 19 Jan 2020 01:08:38 +0000
Message-ID: <CANVEwpa2YmfdJ8eAK9-Kx8z+m2uiexCjXF_rV8UpQaampxqO4A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] hwmon: k10temp driver improvements
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        =?UTF-8?Q?Ondrej_=C4=8Cerman?= <ocerman@sda1.eu>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Brad Campbell <lists2009@fnarfbargle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2020 at 00:49, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 1/18/20 4:33 PM, Ken Moffat wrote:
> > On Sat, 18 Jan 2020 at 17:26, Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> This patch series implements various improvements for the k10temp driv=
er.
> >>
> >> Patch 1/5 introduces the use of bit operations.
> >>
> >> Patch 2/5 converts the driver to use the devm_hwmon_device_register_wi=
th_info
> >> API. This not only simplifies the code and reduces its size, it also
> >> makes the code easier to maintain and enhance.
> >>
> >> Patch 3/5 adds support for reporting Core Complex Die (CCD) temperatur=
es
> >> on Ryzen 3 (Zen2) CPUs.
> >>
> >> Patch 4/5 adds support for reporting core and SoC current and voltage
> >> information on Ryzen CPUs.
> >>
> >> Patch 5/5 removes the maximum temperature from Tdie for Ryzen CPUs.
> >> It is inaccurate, misleading, and it just doesn't make sense to report
> >> wrong information.
> >>
> >> With all patches in place, output on Ryzen 3900X CPUs looks as follows
> >> (with the system under load).
> >>
> >> k10temp-pci-00c3
> >> Adapter: PCI adapter
> >> Vcore:        +1.36 V
> >> Vsoc:         +1.18 V
> >> Tdie:         +86.8=C2=B0C
> >> Tctl:         +86.8=C2=B0C
> >> Tccd1:        +80.0=C2=B0C
> >> Tccd2:        +81.8=C2=B0C
> >> Icore:       +44.14 A
> >> Isoc:        +13.83 A
> >>
> >> The voltage and current information is limited to Ryzen CPUs. Voltage
> >> and current reporting on Threadripper and EPYC CPUs is different, and =
the
> >> reported information is either incomplete or wrong. Exclude it for the=
 time
> >> being; it can always be added if/when more information becomes availab=
le.
> >>
> >> Tested with the following Ryzen CPUs:
> >>      1300X A user with this CPU in the system reported somewhat unexpe=
cted
> >>            values for Vcore; it isn't entirely if at all clear why tha=
t is
> >>            the case. Overall this does not warrant holding up the seri=
es.
> >
> > As the owner of that machine, very much agreed.
> >  >>      1600
> >>      1800X
> >>      2200G
> >>      2400G
> >>      3800X
> >>      3900X
> >>      3950X
> >>
> >
> > I also had sensible results for v1 on 2500U and 3400G
> >
> Sorry, I somehow missed that.
>
> >> v2: Added tested-by: tags as received.
> >>      Don't display voltage and current information for Threadripper an=
d EPYC.
> >>      Stop displaying the fixed (and wrong) maximum temperature of 70 d=
egrees C
> >>      for Tdie on model 17h/18h CPUs.
> >
> > For v2 on my 2500U, system idle and then under load -
> >
> > --- k10temp-idle 2020-01-19 00:16:18.812002121 +0000
> > +++ k10temp-load 2020-01-19 00:22:05.595470877 +0000
> > @@ -1,15 +1,15 @@
> >   k10temp-pci-00c3
> >   Adapter: PCI adapter
> > -Vcore:        +0.98 V
> > +Vcore:        +1.15 V
> >   Vsoc:         +0.93 V
> > -Tdie:         +38.2=C2=B0C
> > -Tctl:         +38.2=C2=B0C
> > -Icore:       +10.39 A
> > -Isoc:         +6.49 A
> > +Tdie:         +76.2=C2=B0C
> > +Tctl:         +76.2=C2=B0C
> > +Icore:       +51.96 A
> > +Isoc:         +7.58 A
> >
> >   amdgpu-pci-0300
> >   Adapter: PCI adapter
> >   vddgfx:           N/A
> >   vddnb:            N/A
> > -edge:         +38.0=C2=B0C  (crit =3D +80.0=C2=B0C, hyst =3D  +0.0=C2=
=B0C)
> > +edge:         +76.0=C2=B0C  (crit =3D +80.0=C2=B0C, hyst =3D  +0.0=C2=
=B0C)
> >
> > I'll ony test v2 on the 3400G if you think the results would add someth=
ing.
> >
>
> Thanks a lot for the additional testing! I don't think we need another
> test on 3400G; after all, the actual measurement code didn't change.
>
> Everyone: I'll be happy to add Tested-by: tags with your name and e-mail
> address to the series, but you'll have to send it to me. I appreciate
> all your testing and would like to acknowledge it, but I can not add
> Tested-by: tags (or any other tags, for that matter) on my own.
>
> Thanks,
> Guenter

For the little it is worth:
Tested-by Ken Moffat <zarniwhoop73@googlemail.com>
