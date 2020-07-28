Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F004C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66464207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgG1HdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:33:25 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59395 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgG1HdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:33:24 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M5wY1-1jstSr2c6V-007SDZ; Tue, 28 Jul 2020 09:33:22 +0200
Received: by mail-qk1-f182.google.com with SMTP id d14so17758976qke.13;
        Tue, 28 Jul 2020 00:33:22 -0700 (PDT)
X-Gm-Message-State: AOAM532BQ+s5ICG6L12NLE9Hs+FfQYc0wbilyCn6Kwj4XGW6/2v/5AcH
        Dwo0TOcF9S2lstanQijrSzHQk+6iP+WkYWCa890=
X-Google-Smtp-Source: ABdhPJyH+gWHXjrGEuHOeWvO276kXhceg1tMppa3WwG/C7HXdHfY+pk3TGktoWb4j9eUkwKsfNI2wnx9708ArU04HS8=
X-Received: by 2002:a37:b942:: with SMTP id j63mr12955439qkf.138.1595921601417;
 Tue, 28 Jul 2020 00:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200626080642.4244-1-krzk@kernel.org> <20200728143650.32818d3c@xhacker.debian>
In-Reply-To: <20200728143650.32818d3c@xhacker.debian>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Jul 2020 09:33:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a26kvOP=3EEDaOFtO5YbqTwBsUr_eKDc5nWxw=NgzZ0MQ@mail.gmail.com>
Message-ID: <CAK8P3a26kvOP=3EEDaOFtO5YbqTwBsUr_eKDc5nWxw=NgzZ0MQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: berlin: Align L2 cache-controller nodename with dtschema
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
List-Id: <soc.lore.kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, SoC Team <soc@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:KC+4x0xayWr25E4c58DHjwTtcrQ/oG63hi4Ypr6VRrcziXCQJDu
 ceUoZfQuoucqHFJxB7NwxCZOtdLgXZycTOd6eVEVBW4rTGNqXh2B2jIAUl6KxZpk6wXUD0a
 1Nyity52Cep2K4IQ7gF4vsvTHn4DXltoJtozIDT+XfdnIkuzfFxQ8vlWuCNnYfv89s9WUmy
 cnT2t9MJQMFShc4N/Dg+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0fLPHurEOpY=:BaNYWA0+5811ripqKSxdCe
 6/S66Kj94Y2wM8os4wJ6JEXkKFzMwDDKD+lVmrT3Gjf+GWbcLxHVEamVhfwP47gE69sG3C99R
 o5RoHxuCreDK+4FR+wkEIElIycYtdSJJtVf2INXuB4vxFIoRTFCHv41W71feWBS3Et/2F7xxe
 jDBlHgH4BL10MXAYiXnmsFYnrOSQeulTVmyGXTUieYkGR1duceuU0SEiO7yLU6bKwDJ8Cu6nT
 m0zEl4gjskqY4HSbvmQjH3h2jv0t0cWAyHhJTgUi0z2eB5AVALinvUGsK4w2QYRnMVm8UCjH0
 OZdTghrhnvlamKAP4UDILWtV3dUBnHHN1PdCqHNO6HwMYnXWBWh1atZMer3/0F7kYFpMrC4IJ
 LfPFb9KBZvfFGd1zXVySrFcDh3hGhBv6u1errfSFiJmksX9IvJZ9xVt9w3bxfpmgm/MIWTtt+
 Rp5/82ioNoYianyB6Lvh8qpe5QwLwPcv2luRVF2B206IydYxFetqfR7kKO6yKIA7J/k0FmJ0P
 cYx8MDaRFf0QguSSmQnOt3HzWiHiHjkelb1elTu7Txso8wvSnSwIrkyBAfC29fOAabvnYJ8kA
 vb5uDMUQPqSfP0wBumOtLc6Y36mIowuC5DmVD4shoNmtDGqujX0R/X3UOMmoHRdLOU2JakWDR
 +16nXo34E5p5/RWFNVWl1FCsALRLoGs5BwRX1fcr79m06z7OCTp2IHzqhyREJiYkLxsOeSFIK
 GOgrwFaD1+2LV7nyUebRxze5MF2Vlv4UTd9bQeo4H4JlouVS6bfaf/7C/rAsh9cLBi7D61hvD
 QLbgACCREmKsSjoLzqK6G9DKEPVWeghf3Zlcqb97MD+a2peo8fn1PHwTlyIUgHIwZMRk4wC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 8:37 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> Hi arm-soc,
>
>
> On Fri, 26 Jun 2020 10:06:41 +0200 Krzysztof Kozlowski wrote:
>
> >
> >
> > Fix dtschema validator warnings like:
> >     l2-cache-controller@ac0000: $nodename:0:
> >         'l2-cache-controller@ac0000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Reviewed-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>
> As for berlin linux-5.9, we only have this one patch, could you please
> directly take this patch?

Applied now. To ensure we actually see the patch, it's better if you can just
send a new copy with your added Signed-off-by to soc@kernel.org than to
reply to the original email.

Thanks,

     Arnd
