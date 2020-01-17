Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25844C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFD320728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bSqq+fKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbgAQAif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:38:35 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35026 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgAQAie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 19:38:34 -0500
Received: by mail-lf1-f65.google.com with SMTP id 15so17022225lfr.2;
        Thu, 16 Jan 2020 16:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lFmi0DxXN3LQfVQ6vLdLOH7+FXKf60l5t8jOk9ir+hY=;
        b=bSqq+fKFKHllfQv4OkGRC0YVtTDOsOdFgKOM0YLGOeTcrFeEYB/RRnlN8Fc20L42Yg
         VR6USRmCFpha6wIc+VWy+Jol3GGR10EURTbYmZZnN0XriEeaHR4g/fmndB3eoEwsQdby
         GsGvRyC+iF0u27znNKyS1zrm8A47+zk3SAh1PZ8tVvI9Bf+ogZe0lst6WWe0EKQ/SZnK
         Ki0keDTBTvgV6/RycTaInDHmaz8gOYVTGEDEi4gQXdp5vJfOKJy3Un7+aFlzo/RTefc+
         keH6eakh4NiLb6I0VR1k+OOr2BBCe7xcaJ4eddPWHY7gph8emqlAu5J/znx0x0jyQTz5
         HKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lFmi0DxXN3LQfVQ6vLdLOH7+FXKf60l5t8jOk9ir+hY=;
        b=d/hvUeGNFh5RSQR4/gD2NeVfzwNlq/b7k1S27d3+atcXWuF/z+FDdMr3HmuWW3mZcl
         567AnwKldf31IeAk4UQ4Ntl1aO6CCFMMIIyuCJVWr+8HojmF+kH8XwnuNT7H3Z+ha+ww
         L7XJ0ZIqsZdBF5oKZAv/EOUm7JhguLNZbt3xBEs1VTLHhyI1d8iHp8alL25vNSmJEdY0
         1Hf7glyJpMz6825cBYys5gXvqWKoeOdVjEJ6EjRtVT7TgOMhFCFwbQ8yU5SbyD29/3PF
         V9ydwQOT4AwRyD9SR+ILhUfst69wGCSSC11sfJ2/3/wuiGf9jeurOrs3GiPHXHuw192L
         CGiw==
X-Gm-Message-State: APjAAAUavESn6pRpwoFeEDsEJBhhgxn0Xf2mQeQRHkLvwV5LOiDLX+gi
        zrZz/aeR62mrXFU2xcZvCdgYc54Q5PJSEMeKW7LBSFYRKuk=
X-Google-Smtp-Source: APXvYqx1/X32n1YsVwgIiVtIlX04BK83qTRTYXpZGzO2c20mhtHCRHRe/aNxxnQBJBqsuvHgDmYDIxupajkUvoYw094=
X-Received: by 2002:ac2:52a3:: with SMTP id r3mr3855156lfm.189.1579221512601;
 Thu, 16 Jan 2020 16:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20200116141800.9828-1-linux@roeck-us.net>
In-Reply-To: <20200116141800.9828-1-linux@roeck-us.net>
From:   Ken Moffat <zarniwhoop73@googlemail.com>
Date:   Fri, 17 Jan 2020 00:38:20 +0000
Message-ID: <CANVEwpZVZs5gnvQTgwZGcT6JG7WdGrOVpbHWGD08bjPascjL=g@mail.gmail.com>
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

On Thu, 16 Jan 2020 at 14:18, Guenter Roeck <linux@roeck-us.net> wrote:
>
> This patch series implements various improvements for the k10temp driver.
>
> Patch 1/4 introduces the use of bit operations.
>
> Patch 2/4 converts the driver to use the devm_hwmon_device_register_with_=
info
> API. This not only simplifies the code and reduces its size, it also
> makes the code easier to maintain and enhance.
>
> Patch 3/4 adds support for reporting Core Complex Die (CCD) temperatures
> on Ryzen 3 (Zen2) CPUs.
>
> Patch 4/4 adds support for reporting core and SoC current and voltage
> information on Ryzen CPUs.
>

> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:        +1.36 V
> Vsoc:         +1.18 V
> Tdie:         +86.8=C2=B0C  (high =3D +70.0=C2=B0C)
> Tctl:         +86.8=C2=B0C
> Tccd1:        +80.0=C2=B0C
> Tccd2:        +81.8=C2=B0C
> Icore:       +44.14 A
> Isoc:        +13.83 A
>
> The patch series has only been tested with Ryzen 3900 CPUs. Further test
> coverage will be necessary before the changes can be applied to the Linux
> kernel.

I have some Zen1 and Zen1+ here.

My Ryzen 3 1300X, applied to 5.5.0-rc5

machine idle, I thought at first the temperature may be a bit low, so
I've added other reported temperatures.  I now think it is maybe ok.

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +1.41 V
Vsoc:         +0.89 V
Tdie:         +21.2=C2=B0C  (high =3D +70.0=C2=B0C)
Tctl:         +21.2=C2=B0C
Icore:       +30.14 A
Isoc:         +8.66 A

SYSTIN:                 +29.0=C2=B0C  (high =3D  +0.0=C2=B0C, hyst =3D  +0.=
0=C2=B0C)
ALARM  sensor =3D thermistor
CPUTIN:                 +25.5=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.=
0=C2=B0C)
sensor =3D thermistor
AUXTIN0:                 -1.5=C2=B0C    sensor =3D thermistor
AUXTIN1:                +87.0=C2=B0C    sensor =3D thermistor
AUXTIN2:                +23.0=C2=B0C    sensor =3D thermistor
AUXTIN3:                -27.0=C2=B0C    sensor =3D thermistor
SMBUSMASTER 0:          +20.5=C2=B0C

After about 2 minutes of make -j8 on kernel, to load it

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +1.26 V
Vsoc:         +0.89 V
Tdie:         +46.2=C2=B0C  (high =3D +70.0=C2=B0C)
Tctl:         +46.2=C2=B0C
Icore:       +45.73 A
Isoc:        +11.18 A

SYSTIN:                 +29.0=C2=B0C  (high =3D  +0.0=C2=B0C, hyst =3D  +0.=
0=C2=B0C)
ALARM  sensor =3D thermistor
CPUTIN:                 +38.5=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.=
0=C2=B0C)
sensor =3D thermistor
AUXTIN0:                 -7.5=C2=B0C    sensor =3D thermistor
AUXTIN1:                +85.0=C2=B0C    sensor =3D thermistor
AUXTIN2:                +23.0=C2=B0C    sensor =3D thermistor
AUXTIN3:                -27.0=C2=B0C    sensor =3D thermistor
SMBUSMASTER 0:          +46.0=C2=B0C

So I guess the temperatures *are* in the right area.
Interestingly, the Vcore restores to above +1.4V when idle.

And my Ryzen 5 3400G (Zen+), applied to 5.4.12, box is idle,
also showing the gpu measurements of this APU to confirm the
temperature:

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +0.94 V
Vsoc:         +1.09 V
Tdie:         +34.8=C2=B0C  (high =3D +70.0=C2=B0C)
Tctl:         +34.8=C2=B0C
Icore:        +6.24 A
Isoc:         +8.30 A

amdgpu-pci-0900
Adapter: PCI adapter
vddgfx:           N/A
vddnb:            N/A
edge:         +34.0=C2=B0C  (crit =3D +80.0=C2=B0C, hyst =3D  +0.0=C2=B0C)

For my Ryzen 5 2500u laptop (Zen1), again showing the gpu:

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +0.97 V
Vsoc:         +0.93 V
Tdie:         +37.2=C2=B0C  (high =3D +70.0=C2=B0C)
Tctl:         +37.2=C2=B0C
Icore:       +19.75 A
Isoc:         +8.66 A

amdgpu-pci-0300
Adapter: PCI adapter
vddgfx:           N/A
vddnb:            N/A
edge:         +37.0=C2=B0C  (crit =3D +80.0=C2=B0C, hyst =3D  +0.0=C2=B0C)

Thanks.
=C4=B8en

--=20
We hope and trust that our values and loyal customers will bear with
us in the coming months as we interact synergistically with change
management in our striving for excellence.  That is our mission.
