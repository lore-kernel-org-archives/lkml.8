Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFA9C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6250E20748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="u/6t5akL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgAQS6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:58:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40465 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQS6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:58:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id u1so27521750ljk.7;
        Fri, 17 Jan 2020 10:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/tOLKL6GvbqkH2XLAhjtSdxwRQosff/wTkJjejjyrD4=;
        b=u/6t5akLd/Yj79vPlE/l6MNh77xCuaFRXPZyaR8sMx1yWpnaaN+/FZbVA1s72HxeoU
         GUSW3W6vrtk7am/qL1wan7Qlhwfw36bBdXgFf/qzKj4HdNzQBI1t1cfNunSKya06J+G/
         VXZyTH0NakXYXv9oBHyjbCpuyazHrJeZbObI8LqYYcOJqRtgqof26N83hEmGJ6rXSIdk
         qj7V7rT07a8jEH0CShBFWAv3kikmO1LiGp2cl+Qjgmpyux33TIbuC5f+MbImPBMpBR9H
         Ahwh3ZYkp2dSttvYRV60rA3hhltEtuahxATjxjKYxcMzig9FyMQiy/uRK12KCGd3RVjo
         1EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/tOLKL6GvbqkH2XLAhjtSdxwRQosff/wTkJjejjyrD4=;
        b=rENFktEJltLNMbcvLuakkUmgfDMpAvClOPOr2WLx3uxz3SW52HXfYn0NChtWr9YKIe
         zG5Xw22WheAgKrOj83wqkPchnlHEE7tqnvc8O2bNExqxXkyeeOwz+GhnNFn25iNKVRl3
         TwLAtEpvm3oJ86IiDXOREJAypRQBuV/Mckwuc1kijbsz6vaabPHVKgyRlI7i2DCQV8dT
         VCBrAesQBYeCYqNLG+MtgbbUw3pZ9hLTs9pCIQpwEdVNOzU1pj7fnMOnzbO59UzSWzqv
         q/IVpmCmbV91TMY9ClZDF9DR2K+75LWd1n62UF44drnQmukmiQ0D3Aykxb1Io7pRu+cs
         zCgA==
X-Gm-Message-State: APjAAAVtAr1npY1g1MPqEZAz15d0Gf1fmk753g7RPzAuWgOA3paVH7oB
        i0wGjnVpED3Hnpvy45L5vavbnU7LEEkwoDmi5as=
X-Google-Smtp-Source: APXvYqzW+lwmGgKJsy9pK7Vb5mP4XrWvBsv90vEc12eysWIMZuzHInPpvDMQRKNDPrrYD8qyTdSQIfu5HkpMPHRMxeo=
X-Received: by 2002:a2e:924d:: with SMTP id v13mr6434172ljg.267.1579287509851;
 Fri, 17 Jan 2020 10:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20200116141800.9828-1-linux@roeck-us.net> <CANVEwpZVZs5gnvQTgwZGcT6JG7WdGrOVpbHWGD08bjPascjL=g@mail.gmail.com>
 <964a5977-8d67-b0fd-4df4-c6bd41a8ad58@roeck-us.net> <CANVEwpZnaHBfF_NWp_3_wM4S3fhFrFuDXQWRMrp=-K4L0m1b6w@mail.gmail.com>
 <00c42e87-dd87-9116-607f-a0bdbf49d948@roeck-us.net>
In-Reply-To: <00c42e87-dd87-9116-607f-a0bdbf49d948@roeck-us.net>
From:   Ken Moffat <zarniwhoop73@googlemail.com>
Date:   Fri, 17 Jan 2020 18:58:19 +0000
Message-ID: <CANVEwpYneogzspz525v6beD3ay97rsUFwbJAvFbktb+Tq+UoKg@mail.gmail.com>
Subject: Re: [RFT PATCH 0/4] hwmon: k10temp driver improvements
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 at 14:14, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 1/16/20 8:47 PM, Ken Moffat wrote:
> > unfortunately I don't have any report of in0. I'm guessing I need some
> > module(s) which did not seem to do anything useful in the past.
> >
> > All I have in the 'in' area is
> > nct6779-isa-0290
> > Adapter: ISA adapter
> > Vcore:                  +0.30 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> > in1:                    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
> > AVCC:                   +3.39 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =
ALARM
> > +3.3V:                  +3.39 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =
ALARM

>
> Looks like someone configured /etc/sensors3.conf on that system which tel=
ls it
> to report in0 as Vcore. So there is a very clear mismatch. Can you report
> the values seen when the system is under load ?
>
> Thanks,
> Guenter

I do have sensors3.conf from lm_sensors-3.4.0. Here are the figures
 under load.

Vcore:                  +0.65 V  (min =3D  +0.00 V, max =3D  +1.74 V)

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +1.27 V
Vsoc:         +0.89 V
Tdie:         +46.2=C2=B0C  (high =3D +70.0=C2=B0C)
Tctl:         +46.2=C2=B0C
Icore:       +48.84 A
Isoc:        +10.10 A

=C4=B8en
--=20
Before the universe began, there was a sound. It went: "One, two, ONE,
two, three, four" [...] The cataclysmic power chord that followed was
the creation of time and space and matter and it does Not Fade Away.
