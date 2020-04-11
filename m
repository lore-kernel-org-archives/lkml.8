Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52610C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285E220732
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgDKImL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 04:42:11 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37007 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDKImL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 04:42:11 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MFbmS-1jVV2l2xUU-00H3rK for <linux-kernel@vger.kernel.org>; Sat, 11 Apr
 2020 10:42:09 +0200
Received: by mail-qt1-f179.google.com with SMTP id 71so3228083qtc.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 01:42:09 -0700 (PDT)
X-Gm-Message-State: AGi0PuaWleGPhd7l+zmIchiChOLi+yv+azJit4kA/OVkf4GJc0jrRbgz
        qziwQfNBfKm24zdvlmv34zPGdRmDINMUoJvXPeg=
X-Google-Smtp-Source: APiQypKx65/p6WW92zSZ2CyKhh2cuZ0iET7gTdxYbdQ2/4iyVb3rc1yA58jI/FaC5SOkJs2zhW/0Vbu58ZufulEQPi0=
X-Received: by 2002:aed:20e3:: with SMTP id 90mr2735437qtb.142.1586594528587;
 Sat, 11 Apr 2020 01:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <s5h5zgwouw8.wl-tiwai@suse.de>
In-Reply-To: <s5h5zgwouw8.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 11 Apr 2020 10:41:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1La1gbSp0A9JaQ5KavGELQ8NsKQvCdAdya24agJzTOJA@mail.gmail.com>
Message-ID: <CAK8P3a1La1gbSp0A9JaQ5KavGELQ8NsKQvCdAdya24agJzTOJA@mail.gmail.com>
Subject: ASoC: s3c-i2s-v2 regression, was: [GIT PULL] sound updates for 5.6-rc1
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IoC/nyrA7CFklGQgxRZQPL7EcnHdAjQ7winHI3GqA1dPnV//w5o
 1HclXw5EYYo/8ENKe0XxArkeX0Gn6GG5SRhzsBplWHJtstCQQLkI/Vtl4ymMt6kOz9EPwO0
 9EvfCl9Ir9Da7D+9h+0BV72jVcC5SxSSepKxPCncmDZ6xMiDSLN1ym2DIysLNqWduzS1cYC
 A+23DCU2SZdR7OYqlmQ0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wDmURRlnq2U=:pEX9WWH24KMo288TMXCgri
 Qb+pRNJP7YFk7Mn1Jie0MZW2uiQg7drEg/scxrZZahJQUsowEO59aD0ZuuLS/l1GWMHbp5vLG
 JxuhX/tr0Y412sW/4EcWqP2qFbhOTIz/8Zr5J+cKF76nQNZbHXeKh6TdJw8Eehvpc1TjPH0lJ
 HD4KDrQf6g29Vy7ovtPYCiCB6Q8w77upxq37pZDU36OFFepCtjMgZkMcTB8oLEEJeGsNNC/VN
 PFymGXAJBmpPAlQw2EHtoaBi+Gx4fZgN3J/SVytfxQXFzC822Tx6A3n4vrXKetD7PoARWEVCR
 b5SRB+YOY+GeLkVTbWjPTTh5TFOuLV2KQHZ5qJBAPhMp7fB3SBw69xP4syCftoLip5V/GGMWi
 jUwh2ogzE6XQVW/nNFvukCC+dVVeQ1sa7ziwg7TsCbl0y0pHvvOg6cIXiieXph+hLeZ01texJ
 vrraJ7SC07nngYFnOX1UzifGrM1QIfvZxLQT5Bm7PduC1SAalRsZqCtl3io5q8ENY7mpRWyJs
 MsMrX/D5GdJh1rb5ca0wQQxf2m1wl1xr6KmmVvam+0X8BpybrtjRsgfrGPpXNk0GUbwn+GmUu
 DmCRhIckNPbAxTovPlZQ1DBqCX/dpd/vvEAb8xw4BzKJYcRP2CX4mdhqFif3Ju8cdd0FObs3G
 UPxGwWjTR5rpPXSZLlVkLnM+bfNtZjXD53oVPuw+xe3r+WVSx4/A9/XVudEBngrji/3B6HdoV
 NrS8+F/Xb36HKrkYJh+aBslJQlbdJ7dEK/0hYYr4PoxuZKYIVF30mIVvWU7Ppv0MHJeDhK8jg
 P03O7wo3k5+Ggfh2IX+FR86763YFvQ83uMkB0w6FlCCfpmnb50=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 9:21 AM Takashi Iwai <tiwai@suse.de> wrote:

> Kuninori Morimoto (66):
>       ASoC: bcm: cygnus-ssp: move .suspend/.resume to component
>       ASoC: atmel: atmel_ssc_dai: move .suspend/.resume to component
>       ASoC: cirrus: ep93xx-i2s: move .suspend/.resume to component
>       ASoC: jz4740: jz4740-i2s: move .suspend/.resume to component
>       ASoC: mediatek: move .suspend/.resume to component
>       ASoC: samsung: s3c24xx-i2s: move .suspend/.resume to component
>       ASoC: samsung: spdif: move .suspend/.resume to component
>       ASoC: sti: sti_uniperif: move .suspend/.resume to component
>       ASoC: ti: omap-mcpdm: move .suspend/.resume to component
>       ASoC: uniphier: move .suspend/.resume to component
>       ASoC: dwc: dwc-i2s: move .suspend/.resume to component
>       ASoC: samsung: i2s: move .suspend/.resume to component
>       ASoC: ux500: ux500_msp_dai: remove unused DAI .suspend/.resume
>       ASoC: pxa: pxa-ssp: move .suspend/.resume to component
>       ASoC: pxa: pxa2xx-i2s: move .suspend/.resume to component
>       ASoC: soc-core: remove DAI suspend/resume

I only found it now during randconfig testing, but it seems that there is
(at least) one patching in this conversion series that was part of linux-5.6:

sound/soc/samsung/s3c-i2s-v2.c: In function 's3c_i2sv2_register_component':
sound/soc/samsung/s3c-i2s-v2.c:726:9: error: 'struct
snd_soc_dai_driver' has no member named 'suspend'
  726 |  dai_drv->suspend = s3c2412_i2s_suspend;
      |         ^~
sound/soc/samsung/s3c-i2s-v2.c:727:9: error: 'struct
snd_soc_dai_driver' has no member named 'resume'
  727 |  dai_drv->resume = s3c2412_i2s_resume;
      |         ^~

I tried fixing it myself but could not see an obvious solution. Can someone
else who understands this code better than me have a look?

       Arnd
