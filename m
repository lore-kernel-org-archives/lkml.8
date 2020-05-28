Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AF0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06156208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbgE1K33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:29:29 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:54951 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387842AbgE1K3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:29:06 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MQ5nK-1jR6cR3J4a-00M11t for <linux-kernel@vger.kernel.org>; Thu, 28 May
 2020 12:29:03 +0200
Received: by mail-qt1-f172.google.com with SMTP id a23so21775044qto.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:29:03 -0700 (PDT)
X-Gm-Message-State: AOAM532jmwbvJQ280XM1MnmAvw2LOR6EVzwdb7C5kmmAHojYLRj3cC/L
        LMqcNVoy0tF4t8Bu8OhdFOyrvHDuyIEI416SQhM=
X-Google-Smtp-Source: ABdhPJz2a2WytWmIneIq2G9OpjaO/RzuEzD9ej4GIQPy/ppJNSDQ6lV/bFBZfFaxAIKkS/hUB94Bg+Cs4mG8X8OBWbA=
X-Received: by 2002:ac8:1844:: with SMTP id n4mr2210189qtk.142.1590661742672;
 Thu, 28 May 2020 03:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200527112608.3886105-1-anders.roxell@linaro.org>
 <20200527112608.3886105-6-anders.roxell@linaro.org> <CAL_Jsq+bwnwQBpxf_Q5GNhCz8+-psH-ovpW80LMk=MK=zcbYcA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+bwnwQBpxf_Q5GNhCz8+-psH-ovpW80LMk=MK=zcbYcA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 May 2020 12:28:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3_5pHCc0WqDNt1Aim2M67cicyq27f0ggqPbJuu97i=Nw@mail.gmail.com>
Message-ID: <CAK8P3a3_5pHCc0WqDNt1Aim2M67cicyq27f0ggqPbJuu97i=Nw@mail.gmail.com>
Subject: Re: [PATCH 5/5] power: vexpress: make the reset driver a module
To:     Rob Herring <robh@kernel.org>
List-Id: <soc.lore.kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        SoC Team <soc@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RQzF1yQzx+K2cLpqpCusoYSQA4uv03CisgmvX1deqeHfNiEWKfS
 JQbQ9CCCZcSJVbmrDB3ve8hjR5GFztB1bHHBjxOC+KdsUpOj2Xa0MPZDK1aiSazBEsNdbAW
 TvAsqim+ALTcJohHUgHTefHr6obVaB9JQf8kAREwuPcshzxcblfVfg9PgyE+RUxyKH9Bwdy
 pfFTlLakx3l6VVhhk93Ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EvMnaEqN+Kk=:I0dZKNV77g33RHmZ+9q2gz
 e+zHIq0pHHDBBFivIlZHrkmo58NTGYg/H63E66BS96NYxmFFxM+HJDsOQFZz4hlbAykLJFXWg
 rXdSMrnmZWk/5kWfcjBusVXtsGsLfpeV/GBiJ84rTxiA8DaswtNWyr83G3uTadZAQ4SCh+58Y
 wNpWrZ4AfLq2WyfygF9v7zLiqdQsekoYYaIVoi5ea96SD1fhE11Zwlo2L+8kllye9HQsXd3oi
 zwoWHRHdZHd/FNTG4P9Kq3T3TMZvowxWQO3p7VxatGkAJpiX7fYpn7k0IH5zZc+GMw/5phTbM
 RHpV1NXV9Rc7kUqEzdU7EkI0AcFLyOVVCIpqHUFmMo28a56FKoCtXa34mG2KpjpRVNJZQTpc6
 nzi41QsWmikRT7bAxLGw44QZU5f31MaMFxFytD5zCPTXl33rLvPiWWsXZdM5A3+wggsWha3oj
 joZaQPBo+7dcbY+pZ1+YHhYd6Tcwmaqid8XMZRZQ+pCVvUiyhd0pLgrXjot56V93H07TULXMj
 3eu1Ng+k0vwLNQW79Pwfs8+0hONmSI+AiL61EaT3060xgVFOe9Rv6AtQ6Awx6XlJiGrb8/C2c
 pfRVO91TE+L6eBIpWSy7DGlhOJbiTzol+G0Eqd5+ou5WHbgZ6O/+cz7izdLbiKqyVrlMuLk95
 uTyCtOR8Lre4ym3Vg4ucPWNSItD9FLdytmvoHMyo5+ALpxuHukb1Hf1dHNm0raCZSGwABTXWv
 guDfhwXn5XV9xljTf/B4YLrickiYg02TkJgbBFfbQ5kP65YihSmm5ip9suohgm5vP86j6QF8n
 CCmpD95qnXEg2TGGaOKAtEUI09+a//ZpyRYdhn2Q+3JnrI4wQ8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 3:32 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 5:26 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > Today the vexpress power driver can only be builtin.  Rework so it's
> > possible for the vexpress power driver to be a module.
>
> This is the same incomplete patch I did[1]. As a module, it needs to
> clean-up everything probe did like overwriting global variables.
>
> Rob
>
> [1] https://lore.kernel.org/linux-arm-kernel/20200419170810.5738-5-robh@kernel.org/

Your version was actually broken because it allowed unloading the
driver again. The version that Anders sent is a bit better because it
explicitly forbids unloading by having a module_init but not module_exit
function, so as long as the .suppress_bind_attrs flag is set, this will
not crash the kernel.

It would be nice to have a .remove callback, but for the merge window
I'm happy with a patch that fixes the build regression.

        Arnd
