Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267B7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A1520776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbgE0P7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:59:55 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37641 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgE0P7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:59:54 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MTR6K-1jRxsz1Bsq-00ThRF for <linux-kernel@vger.kernel.org>; Wed, 27 May
 2020 17:59:53 +0200
Received: by mail-qk1-f171.google.com with SMTP id w1so1410146qkw.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:59:53 -0700 (PDT)
X-Gm-Message-State: AOAM5307y7h5mQL0sUrCKOVIH09FXkf/OnjoXcyTBnAB1CWImKaCFMUe
        wrOO/Xk1syxwLO75iytRvkBQawNWBxdxmNK6NRs=
X-Google-Smtp-Source: ABdhPJxDutw7MBd/EYBIKtYxOivFQlLGm+KC5RbbRJSXfuIwQcc5opcAUQCuxjh5ZJMaChtg/SMDmArapoMUIIqUbag=
X-Received: by 2002:ae9:c10d:: with SMTP id z13mr4427434qki.3.1590595192185;
 Wed, 27 May 2020 08:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200527134151.834555-1-arnd@arndb.de> <20200527134743.GH5308@sirena.org.uk>
In-Reply-To: <20200527134743.GH5308@sirena.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 17:59:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3fmQSTAKehsjZX8CEEEK7oHoGdviLKY2JE4=tTccGkyQ@mail.gmail.com>
Message-ID: <CAK8P3a3fmQSTAKehsjZX8CEEEK7oHoGdviLKY2JE4=tTccGkyQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: amd: rt5682: fix soundwire dependencies
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/2wIZzDDzQfrpWPFB69zwAucAUGfcez+Giw5RW1G7/iCV6t6Epr
 42uliFgccxu6zXDveSMeqkHrETPJ6RnokDMk1LAYuItH/7Qd6X174boFXYQ24iucpwS0p5t
 5BVfCUP5xqGIXYurM2FDO1oKtWVbuAt1zyGKlpOELMBpLKAjqbcDtAJAZ1arEZAIEBGu22o
 aBVmIrFcbdGvSsd0DOvJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:33NcIUxmnpY=:+Qa5+8GfW5bgys04GaMR4D
 IBMzfSuIv0eLT+MhfECkVOAMfqLR5AIG7h7yCWw1Xyiw/Z7ZdON2bs2iKNyLt+V77F24Sh8XJ
 GWnMT9TaYejGKVa1JXaN0PrJL5Vu+AWvAExQ39t6r4gXpZaA3+X3p22ld1ky5Fcv80R/Mr0VR
 X15NJRwYebTlgToemrvXvb4JpFjZ/UIct9eB/oa8PKDRZis6SbicZ9cgmU6IgbH/LA8NKeoVB
 9+BzX2gjaEBrhj1l2YxinNpWNynEuQUK3G7qcNr5jawA2Z2Bna6mc7X4igEGgtiZGRjl4o+JF
 w7qrbYGAU1bddDYlakf8CJU92G/WRKkycmowKrDm8Gu1ODfaRI/Qiq7OrsCP6U3KudzdjN3Uk
 5Gw5vpBo7T0ksIi49y5VWLoiMAiu6IvJxNqfAlT9AayB2BjpR9zJaIfhP5DxpLm7KDPDzPt6a
 4BxhIi/mGS/jcMiOYMwIwERU6QASeJD8Ae1Nls9tvztZwu1n/LEDxOBu3hM2hXYUSj5fmzdf8
 dqkGvYN5jWuhTDeT0dJ68GIcYezB4Gfq4raKcJTq0nvb9fQeq2M8hNcviuDMW6SNH2eMhNOzz
 NyEOlw+MReRrq+4qnLMQJgSAI1/5IotQLYNWv4bo2y+ZVVnZ0IEQ+YRSGn5NkaL2yjRcsHJUf
 h7T6dh0UFn95bK4fJYsYoHe+RsWoyxjCmMzlpnNymYCLV/y/WeKwEAua5pHMlZFTADOSvkEh9
 EYUo+ufr7KjYVzAAnIas/5TUl0QKxTKHSEUpVVNl2AOyEh2spZ2ilTBmnV7q9RN0RsezoPFav
 +lTGUUwfpBIEk/cUlLpmS+N2Ok9KbMdLiRgEaw/ZLcuXFd/pc4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 3:47 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 03:41:26PM +0200, Arnd Bergmann wrote:
>
> > Maybe the SND_SOC_RT5682 driver itself can be reworked so that
> > the common part depends on neither soundwire nor i2c and the two
> > bus specific options can be loadable modules when the common part
> > is built-in.
>
> Yes, please do that.

It took me longer than I thought it would, but I have a patch now.
I'll send it after it passes more randconfig builds to ensure it covers
all corner cases.

      Arnd
