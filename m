Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CF7C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26ED20736
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnKx+7tM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgDTMgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgDTMgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:36:44 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15989C061A0F;
        Mon, 20 Apr 2020 05:36:44 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id s10so8801057iln.11;
        Mon, 20 Apr 2020 05:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3CbBWYh3hEo1SFuuYgcjEPFrVgBlthpwlzKPfvsK3P8=;
        b=OnKx+7tMLS9s7A35dAv/MXJHdXi9YmU0JJngPdWlBRJbsp72/7AK1nIUIq5NLA1x0b
         4AY1rZIBKD++FBAWGobX88d/U2lEQSNH6GwdGormJXygNhWfmr1I0JhLqTUKt04LlGUI
         vfzUqLuOl04JQNi0CHCZquQHcekDYvpH8SFHIXD+iTuR1cRGzL36UBQ/R+OARcJ7LUW9
         R6Ojjm/taf/ATJ0UMHZwcpr+LTnkEsqgPZ+tLMEjNjBfTK++C6DprOuT5+qekXICL8Dq
         S7z8oqcOsBAtsBN8DRVtLMTNkz+hMBzoaE6dgU4/3Jz+dJ0qxQkMNIJJuwaWKR/KwU52
         OGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=3CbBWYh3hEo1SFuuYgcjEPFrVgBlthpwlzKPfvsK3P8=;
        b=od+OcaXZuf+gOqSZ6PQAVrBRppS481lgIMTjfdH9TkmaMuTGn04wtuqvu4+tSrPDlS
         0Tgbb4RA0qNVvS0oudmSRx3dW+caCwLbH+GSjAHK8dM0a4Xuk2Ckg4rXJm1CW8KXbKSI
         xKMtxpTSagVkHtcXaFP8f814/zdRJutp0HpjCsYPHV4DidrCX+byAy8YHgtTtn4k3UtY
         1KuBMFlO2uhyUTMKajE32PKynq4fGmzt1yGuDT3O0ikZqxIvGypbJONMrS3HOLUgpzTX
         9H7SFFW/oIehGRFK5nalCzZu6h7wmp4asFUXHsByTprJ2qekGkTkdtyVmIt975tHRimB
         b+Cw==
X-Gm-Message-State: AGi0Pua5zEfYJ4gPOusN5r/FErPjSKEGm0WsKw0EJL8sUujCc0Kdyy2F
        Lqe87DKqGeuMSVfAj+740QXuk39feGR+hVKfu+I=
X-Google-Smtp-Source: APiQypJ7cU3/3DFBtvn21b9ZEhxAqE5SzZ3rQEgwk7x7gdmwz5XCiiVekQ8ec+23r8/gkwpU5CnetJcsAcu0jPwouYM=
X-Received: by 2002:a05:6e02:111:: with SMTP id t17mr4674601ilm.59.1587386203290;
 Mon, 20 Apr 2020 05:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200419135011.18010-1-peron.clem@gmail.com> <20200420084547.q5xqlbnmug7l45p2@gilmour.lan>
 <20200420103927.uvzotrolz2inz6q2@core.my.home>
In-Reply-To: <20200420103927.uvzotrolz2inz6q2@core.my.home>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 20 Apr 2020 14:36:32 +0200
Message-ID: <CAJiuCcdDge21pRmN8LzKv_tMqBoD9KHg96MUxDS9gp0+xbroJg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Add support for Allwinner H6 DVFS
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej, Maxime,

On Mon, 20 Apr 2020 at 12:39, Ond=C5=99ej Jirman <megous@megous.com> wrote:
>
> Hi Maxime,
>
> On Mon, Apr 20, 2020 at 10:45:47AM +0200, Maxime Ripard wrote:
> > Hi,
> >
> > On Sun, Apr 19, 2020 at 03:50:04PM +0200, Cl=C3=A9ment P=C3=A9ron wrote=
:
> > > Now that required drivers are merged we can contibute on DVFS
> > > support for Allwinner H6.
> > >
> > > This serie is based on Yangtao Li serie[0] and Ond=C5=99ej Jirman wor=
k[1].
> > >
> > > Most of the OPP tables are taken from original vendor kernel[2].
> > > Plus there are new CPU frequencies at 1.6GHz, 1.7GHz and 1.8GHz.
> > >
> > > I wrote a simple script to randomly set a frequency during
> > > a random time[3]. This script is quite stressfull and set some high
> > > frequency without checking temperature. This can result on behavior
> > > that whould not occurs with the real cpufreq framework.
> > > As Maxime point out I also tested with cpufreq-ljt-stress-test
> > > (found here https://github.com/ssvb/cpuburn-arm).
> > > This script doesn't trigger any issue.
> > > I also test that that offlining CPU0 and doing DVFS on other CPUs
> > > works. As CPU regulator is only set for CPU0.
> > >
> > > The GPU devfreq was drop as the regulator is still not properly
> > > drive by panfrost driver[4].
> > > I will re-introduce it later.
> > >
> > > Ond=C5=99ej Jirman has an Orange Pi 3, Jernej has a PineH64 and a Tan=
ix
> > > TX6 boards and I have a Beelink GS1 board so I have enable these
> > > boards. But CPU Devfreq is really touchy has it depends on:
> > > board design, SoC speed_grade and environement which can affect
> > > thermal cooling and have different behavior for different user.
> > >
> > > If people can test this serie and give feedback, I will try to
> > > introduce this in LibreElec tree, so LE community can test it.
> >
> > Applied all of them, thanks!
>
> Please also apply "[PATCH v2 1/7] arm64: dts: allwinner: h6: Add
> clock to CPU cores" from the v2 series, otherwise cpufreq will
> not work.
>
> I can also send a missing patch adding the trip points, and cpu
> as a cooling device, that I linked in my other reply to this patch
> series afterwards, if Cl=C3=A9ment wants.

Indeed I have sent using the following cmd : "git send-email --to=3DXXXX HE=
AD~7"
from the previous version.

I should had do Instead: "git send-email --to=3DXXXX next/master "

Sorry for that :(
Cl=C3=A9ment

>
> regards,
>         o.
>
> > Maxime
>
>
