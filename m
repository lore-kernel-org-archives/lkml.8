Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD68C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 16:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E791022314
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 16:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g13xT9lR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgBHQNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 11:13:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41488 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgBHQNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 11:13:23 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so1326326lfp.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 08:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BkYFBfPyKvzswGG782ra4Cz2lr/kus4X+MdHQ5OLnxY=;
        b=g13xT9lRDBeSSVFO+kBC3mdWI5j/QJCzhboNBShh6kPm1TZqzhX30e23v9f3eZxIA5
         FjEDqbcigQAODS24Y9dE/P91Ne94AB65F2YT/QU/cCjesANOJKSEuEbxfDW3OQWjU69I
         pXGrLq1oHlNdpOUh2j6vFjgGGIMdx3SPZ+0oNX3GWxWC7DLMFoabTFAFrtUlj8r2QidB
         ZpJHd9S8b1Is1Rii9fw8UiloEg6sVDZthJYg46tCMYn95K0/HobWb8vtyW0glSoYC5cG
         dBLa3jJM/NZfVHKSJx4QGTcI7ZKztP+TlK4IDsM4W20HN4MHytROUCSMcjPAlR3q99Id
         8xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BkYFBfPyKvzswGG782ra4Cz2lr/kus4X+MdHQ5OLnxY=;
        b=VAgQf2BoCj/l3tVXn2f8oHlVF3aphXwSw13gC2j9bAeB2MNXIlbr0s9YL2lFjvdHoV
         h2lg4f5Br8DrXY7mTgXDrwn0Twi5TCIhinetQqTCOOgKpzBw3deLSjtaf6a0XUZ2xRVP
         ysLEmh25IZR/DZWcI2BeYiaDOW/K/NTnzVx5yYoYywN7vHQoAAnXdBIWTZRgZiiAANXU
         xzAvup3EbGeutUKbPJIEIBuHbCXSFCy6jfPYJ0FVxKxsGSeJRjDQqaKVZnlen9H1VdLO
         WEDleDskHbbuAePOu3cehvsEPpsQD2k6byOyE908SOavnKNkAroBGvewKOcKD/MVjz8y
         sTUQ==
X-Gm-Message-State: APjAAAWAz8fuu64VpTlTj9avN5QXGsZwgC74nR+/VCYQGns9FBbhCC7r
        VcQ25DeqmxPcUEalBncGhbEvZI4AW2clxl3RlUc31w==
X-Google-Smtp-Source: APXvYqzuJN8dkvQp+rwG/MibhW0AJPGZ/u9gK+LJnQwiyGSEYMA7Grr36OxXieQ+lWGoDpkTrhzsEJ/YuBgvZ5541ew=
X-Received: by 2002:ac2:5f65:: with SMTP id c5mr2252748lfc.207.1581178401452;
 Sat, 08 Feb 2020 08:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20200203161902.288335885@linuxfoundation.org> <CA+G9fYuzYzwqaL6_5=2+KmRHy=BDRS0WgW2dGSL6wi+_FFFhCg@mail.gmail.com>
 <20200205130706.GA1208327@kroah.com>
In-Reply-To: <20200205130706.GA1208327@kroah.com>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Sat, 8 Feb 2020 10:13:10 -0600
Message-ID: <CAEUSe79EBivBWSxjNfoZBWKaO-uv2tzMChuiLRjFwQuGAPvBsg@mail.gmail.com>
Subject: Re: [PATCH 5.5 00/23] 5.5.2-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, 5 Feb 2020 at 07:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 04, 2020 at 09:15:44PM +0530, Naresh Kamboju wrote:
> > On Mon, 3 Feb 2020 at 22:08, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 5.5.2 release.
> > > There are 23 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Wed, 05 Feb 2020 16:17:59 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/pa=
tch-5.5.2-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-5.5.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Results from Linaro=E2=80=99s test farm.
> > No regressions on arm64, arm, x86_64, and i386.
>
> Thanks for testing all of these and letting me know.
>
> It would be interesting to figure out how all of the different build
> errors on this "round" of releases did not trip up your systems...

We're not building these configs:
  allyesconfig allmodconfig omap2plus_defconfig imx_v6_v7_defconfig
nor building for ARCH=3Driscv, which were the ones failing.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
