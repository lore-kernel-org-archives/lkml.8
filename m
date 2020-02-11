Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E202C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7420220714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjsA5BIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgBKJqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:46:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37566 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgBKJqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:46:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so11427441wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 01:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w1TSPc+JlTHAhFmRkBjf4YDoyFF0cD7ftWasXNuoumE=;
        b=FjsA5BIkZ+hT2wm9mmhX5eKcsNzWDFh8FGGRHbRT6gQ9+e4gbSCL8XUhCvFdE9YSxm
         +O2IY3hVHB+BNd+87rqADV+sqQ5SGlwrKmZupaGnHcEPtO7b06ZqZ+mOUwqwfaJoIEHH
         yX/nBYG2N75UIkPiSwTr9GasTdh4gW36/zcwWqSmkwvgIrkm+mg5TmeGUN7D7oaEpvNg
         BhkvZ0GtgFAEkgw0vrXnFnAQyfvz8D1GkCYuCXzPWpTTSiVl4Qs4MOfXJJ4H2wPk1hvR
         utZEamgdQNk0xMtA+Pxk/ranvt1ndcWGzL4Ph95+IcIyFFSYHKpysmncNo5yrWfTF7X9
         jn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1TSPc+JlTHAhFmRkBjf4YDoyFF0cD7ftWasXNuoumE=;
        b=p+g2Xk1a/POSuhexX+crB4TqNuKEzIVUPWgGMeFkeVGSHrYEMyjgAzmDzXqdqDgfyV
         thor+Tsw+gy1sdDqaexOeLS7hcPr3MXipPUtPJvWN3dbCOHDIlRHudKIrNQtNroaJEWO
         M+naJxckp42jMJpktxBgRZiXIa2H6JJKX756h1+0zBXnvFp4HSpmNx1vnY6VE/FHdqFA
         OF04FYPvNLaVj0dD5Pa77JPw8RbPgduv/B2gBYnek3p402/6FoC/tRi6jzJJPNPZxopj
         c+Q8AImyG0MPi/6gG85uzHJtY4RFyGQ9YOiPW6aNM0tIn5E9tS0WDegvTvuZtiZ+0lWx
         FbGg==
X-Gm-Message-State: APjAAAV2SXEilRVamSfG0295bfDV9KX5To+uJfq8GZnHNHgy+x7iXS9r
        gtSFpv7l/JZVpI9yIQyukcptx4/HKMoh9klZeqU=
X-Google-Smtp-Source: APXvYqwhSf8JavKelhdt3J0bOLew5DzoXQ+67dDmYAeO5cfMhbaTYXoo2bO/py7GSWzLHg3jBl4sXXUIKRdKaJbTXNo=
X-Received: by 2002:adf:ed09:: with SMTP id a9mr7806457wro.350.1581414409744;
 Tue, 11 Feb 2020 01:46:49 -0800 (PST)
MIME-Version: 1.0
References: <20200210061544.7600-1-yuehaibing@huawei.com> <9351a746-8823-ee26-70da-fd3127a02c91@linux.intel.com>
 <be093793-3514-840a-ff2f-4dc21d8ee7f1@huawei.com>
In-Reply-To: <be093793-3514-840a-ff2f-4dc21d8ee7f1@huawei.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 11 Feb 2020 11:46:38 +0200
Message-ID: <CAEnQRZDWFgXocRJxtc2e7McRCAtod6-GwPJaVMdb4ymBZgSD1w@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH -next] ASoC: SOF: imx8: Fix randbuild error
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>, krzk@kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 3:59 AM Yuehaibing <yuehaibing@huawei.com> wrote:
>
> On 2020/2/11 5:00, Pierre-Louis Bossart wrote:
> >
> >
> > On 2/10/20 12:15 AM, YueHaibing wrote:
> >> when do randconfig like this:
> >> CONFIG_SND_SOC_SOF_IMX8_SUPPORT=y
> >> CONFIG_SND_SOC_SOF_IMX8=y
> >> CONFIG_SND_SOC_SOF_OF=y
> >> CONFIG_IMX_DSP=m
> >> CONFIG_IMX_SCU=y
> >>
> >> there is a link error:
> >>
> >> sound/soc/sof/imx/imx8.o: In function 'imx8_send_msg':
> >> imx8.c:(.text+0x380): undefined reference to 'imx_dsp_ring_doorbell'
> >>
> >> Select IMX_DSP in SND_SOC_SOF_IMX8_SUPPORT to fix this
> >>
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Fixes: f9ad75468453 ("ASoC: SOF: imx: fix reverse CONFIG_SND_SOC_SOF_OF dependency")
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >
> > Thanks for the report.
> >
> > Would you mind sharing the .config and instructions to reproduce this case? we have an unrelated issue with allyesconfig that was reviewed here:
> >
> > https://github.com/thesofproject/linux/pull/1778
> >
> > and I'd probably a good thing to fix everything in one shot.
>
> config is attached, which is on x86_64

Thanks, I think this is legit. It was introduced with:

commit f52cdcce9197fef9d4a68792dd3b840ad2b77117
Author: Daniel Baluta <daniel.baluta@nxp.com>
Date:   Sat Jan 4 15:39:53 2020 +0000

    firmware: imx: Allow IMX DSP to be selected as module

    IMX DSP is only needed by SOF or any other module that
    wants to communicate with the DSP. When SOF is build
    as a module IMX DSP is forced to be built inside the
    kernel image. This is not optimal, so allow IMX DSP
    to be built as a module.

    Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
    Signed-off-by: Shawn Guo <shawnguo@kernel.org>

So, I think we should change the Fixes tag. Are there
any clear rules on when to use select vs depends?

On my side, I know what both are doing but it is not clear
when to use them.

> >
> > Thanks!
> >
> >> ---
> >>   sound/soc/sof/imx/Kconfig | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
> >> index bae4f7b..81274906 100644
> >> --- a/sound/soc/sof/imx/Kconfig
> >> +++ b/sound/soc/sof/imx/Kconfig
> >> @@ -14,7 +14,7 @@ if SND_SOC_SOF_IMX_TOPLEVEL
> >>   config SND_SOC_SOF_IMX8_SUPPORT
> >>       bool "SOF support for i.MX8"
> >>       depends on IMX_SCU
> >> -    depends on IMX_DSP
> >> +    select IMX_DSP
> >>       help
> >>         This adds support for Sound Open Firmware for NXP i.MX8 platforms
> >>         Say Y if you have such a device.
> >>
> >
> > .
> >
