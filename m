Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E059C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C475206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgD1WB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:01:58 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:60511 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgD1WB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:01:58 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MkYsS-1ikppa38uM-00m166 for <linux-kernel@vger.kernel.org>; Wed, 29 Apr
 2020 00:01:56 +0200
Received: by mail-lf1-f53.google.com with SMTP id t11so18065555lfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:01:56 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ0Ks2qBXKHmVtnYrBKsSv5H8uHhTx0gONPcaiSYuRRobzjZqOq
        bgFYylM86dv0KRCk0nokTek3t9qnAAyZ2lEla/k=
X-Google-Smtp-Source: APiQypKRCC3KPD04zAsw5+cxuEvdnddfpLWkPhoC2m7sjHNQVxlSGSJA7IqZ0gPza4uX18XwephNlgb4sPXRsKwTwuc=
X-Received: by 2002:a05:6512:10cd:: with SMTP id k13mr20513654lfg.173.1588111316217;
 Tue, 28 Apr 2020 15:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200428212752.2901778-1-arnd@arndb.de> <6b39fbba-c65d-2c02-14bf-11c2d00547af@linux.intel.com>
In-Reply-To: <6b39fbba-c65d-2c02-14bf-11c2d00547af@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Apr 2020 00:01:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a24whg2RhJE3Vf5u3EWy+wvFqhXdp7EQZuQx0shPsMARw@mail.gmail.com>
Message-ID: <CAK8P3a24whg2RhJE3Vf5u3EWy+wvFqhXdp7EQZuQx0shPsMARw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: sort out Kconfig, again
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        sound-open-firmware@alsa-project.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:BuX9Dak/99iKtVorhI5pIQrR/G5WeKHpo8sqZxqcDq27jW9wC+c
 5yj99ZyaqEkdQqFg/T6WdO7q48IUCp+AGoUxLQf6RFMCA9h13zoO34mNXeSfBX7R9lwHJUb
 uYS8PHfYdNvGvVGZKuEFR7wAORhaTF47EZlv+SbMGKYSz+fqZdVQqFu7XGH+LzN/I0BGKaz
 scj1GnEBv4zkKWvgglFeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zZn11hZBU0o=:tzLBf539tsDGuKSM6X3RpA
 n/syzXeZ4FFMMz36g6DOCM+4kGFxOBBUu5kKGB1Cp5GW1NNkQAj/4weWH9v2UnrqncHU9Mqax
 fyyazErfhjsC+Hd9bzFtml/vd+fYHoG7XyxLBv3hiaCFVGg+1+an5qkpIoG85KpnuU0pYKeyo
 WjuHEqIfo+UY2DWiCGvUShvgKAcNk7d8CF8I2+vieEGkxzzdlJvBHei7PZy1w4UBTAm46Cj97
 45XWVDr9lRkbM6G+LeFMsX/eVIbLjQNJHrlXz7ERsuTo5iphY5CsE63q1owxl9EdhRmuD1yTH
 V9ZSt47OJ3RovzMXN7fJMI7mqOtaR7+cRAl1r3VBN1YsXYnxcpWIVFu3nf5idM8qKk8uEJADs
 hhX0QroEszan7Qz8EKzguTlKe8SiV5ceAItkWNk6CRTLFBSEReDjRutidd/u19WNp3foz8b1N
 LPR97UpU35qfBjixCnPQwCCk+WwaSeZzJi+oeL01f5e88eijN2yeS3XxWYSHW20J7ybhkXK3c
 wW3YCDOXuUfRdUM9N4tRiEv2WiCYJv0EY1yiOHF6uytZd7Rn0F4aVTmsDRaHTdrKtKZFcTNUs
 itndCqzuOKuO80P57gUZH//hmNIzBDpaXWs6gTRVa58YEzMdmw0C377qG4gYq61Q1al+uH/RG
 zy8Ta93ndddSZcicawVxXk9O4BWbQ0iCS/ch0B1mFtuw94pScLsmkQbI0t19w847MlKFlfjpM
 n1jCywQCVTSZgKcIlRq94ALXWV3KGnYP0AyMU4fH8ER9QPCPgTaFoqxPjBGuEkeZ1dVUl1MHB
 kbA39/Uq+agfLate3ZdVn0AC2es+ODwCK63SyBggGofOKKzQXI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:43 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 4/28/20 4:27 PM, Arnd Bergmann wrote:
> > The imx8 config keeps causing issues:
> >
> > WARNING: unmet direct dependencies detected for SND_SOC_SOF_IMX8M
> >    Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && SND_SOC_SOF_TOPLEVEL [=y] && SND_SOC_SOF_IMX_TOPLEVEL [=y] && IMX_DSP [=n]
> >    Selected by [m]:
> >    - SND_SOC_SOF_IMX_OF [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && SND_SOC_SOF_TOPLEVEL [=y] && SND_SOC_SOF_IMX_TOPLEVEL [=y] && SND_SOC_SOF_IMX8M_SUPPORT [=y]
> >
> > This is complicated by two drivers having dependencies on both
> > platform specific drivers and the SND_SOC_SOF_OF framework code,
> > and using an somewhat obscure method to build them the same way
> > as the SOC_SOF_OF symbol (built-in or modular).
> >
> > My solution now ensures that the two drivers can only be enabled
> > when the dependencies are met:
> >
> > - When the platform specific drivers are built-in, everything is
> >    fine, as SOC_SOF_OF is either =y or =m
> >
> > - When both are loadable modules, it also works, both for Kconfig
> >    and at runtime
> >
> > - When the hardware drivers are loadable modules or disabled, and
> >    SOC_SOF_OF=y, prevent the IMX_SOF_OF drivers from being turned on,
> >    as this would be broken.
> >
> > It seems that this is just an elaborate way to describe two tristate
> > symbols that have straight dependencies, but maybe I'm missing some
> > subtle point. It seems to always build for me now.
>
> Thanks Arnd, do you mind sharing your config?

https://pastebin.com/HRX5xi3R

> We noticed last week that
> there's a depend/select confusion might be simpler to fix, see
> https://github.com/thesofproject/linux/pull/2047/commits
>
> If I look at the first line I see a IMX_DSP=n which looks exactly like
> what we wanted to fix.

Yes, I think that fix addresses the build warning as well, but looking
more closely I don't think it's what you want: If you do this on
a config that has the IMX_DSP disabled, it would appear to the
user that you have enabled the drivers, but the actual code is still
disabled.

      Arnd
