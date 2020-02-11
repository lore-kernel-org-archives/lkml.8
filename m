Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C698FC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E202086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581415169;
	bh=eZTJW3fyuVfF78EHcMrcN6Hj2iRFml/KLBuxmsVst/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aR8Efb93ULzh6IQS36yeHUqPfgmnyaX6Mh3zx1YJvj3LZKHp38yLN7wYE1ffmAgv5
	 aD65SQJw6w5rkbybcFWTQNfVnx8W4F3TJetg7Ahp+Zt/5SlgoJULas0CbV95aPNpvq
	 +D01XMn1uxfrRw7XkgNfsKJ7m04CQ5MywQ57twYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgBKJ72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:59:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbgBKJ72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:59:28 -0500
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8316920873
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 09:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581415167;
        bh=eZTJW3fyuVfF78EHcMrcN6Hj2iRFml/KLBuxmsVst/I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ontb1bxQ5hDW5q1FR8Br/ISHJ7XHTUW3ug/87faSNg2bqLqit8Rl8hfXZsGqLbSJq
         hJw4R7PUK3ijRg0f8YseHgmgZlH61VXB6J80qFs5xjpKY/rHGAE8NnaVwdbMf9DhdK
         BfhtnOclYZp6S2JCpvk8o1itiL2qrI3frrZZk4MU=
Received: by mail-lf1-f54.google.com with SMTP id 203so6516326lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 01:59:27 -0800 (PST)
X-Gm-Message-State: APjAAAW+aivS1Z2Yp+CL4AItfbKDAAXAMWoCLczsEjcB+TAFVn4QQNfg
        etC2WS+Hxtqkl8MSCnw+XAfPvG3xt1AruqcP/f4=
X-Google-Smtp-Source: APXvYqwAHORsy+C2v7lVpCe02Mf1CVE+/0/5jXb/E/zbgMCk+yjlFnDzUNYbiYCIu0+5WnyY8bNqPOsV8tBJAugOUOM=
X-Received: by 2002:a19:228c:: with SMTP id i134mr3249949lfi.2.1581415165575;
 Tue, 11 Feb 2020 01:59:25 -0800 (PST)
MIME-Version: 1.0
References: <20200210061544.7600-1-yuehaibing@huawei.com> <9351a746-8823-ee26-70da-fd3127a02c91@linux.intel.com>
 <be093793-3514-840a-ff2f-4dc21d8ee7f1@huawei.com> <CAEnQRZDWFgXocRJxtc2e7McRCAtod6-GwPJaVMdb4ymBZgSD1w@mail.gmail.com>
In-Reply-To: <CAEnQRZDWFgXocRJxtc2e7McRCAtod6-GwPJaVMdb4ymBZgSD1w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 11 Feb 2020 10:59:14 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcxL2vpWGwO1OL9Vv0g6hzbW-AyGJNn=7Yq2iy10_cbhg@mail.gmail.com>
Message-ID: <CAJKOXPcxL2vpWGwO1OL9Vv0g6hzbW-AyGJNn=7Yq2iy10_cbhg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH -next] ASoC: SOF: imx8: Fix randbuild error
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Yuehaibing <yuehaibing@huawei.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020 at 10:46, Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> On Tue, Feb 11, 2020 at 3:59 AM Yuehaibing <yuehaibing@huawei.com> wrote:
> >
> > On 2020/2/11 5:00, Pierre-Louis Bossart wrote:
> > >
> > >
> > > On 2/10/20 12:15 AM, YueHaibing wrote:
> > >> when do randconfig like this:
> > >> CONFIG_SND_SOC_SOF_IMX8_SUPPORT=y
> > >> CONFIG_SND_SOC_SOF_IMX8=y
> > >> CONFIG_SND_SOC_SOF_OF=y
> > >> CONFIG_IMX_DSP=m
> > >> CONFIG_IMX_SCU=y
> > >>
> > >> there is a link error:
> > >>
> > >> sound/soc/sof/imx/imx8.o: In function 'imx8_send_msg':
> > >> imx8.c:(.text+0x380): undefined reference to 'imx_dsp_ring_doorbell'
> > >>
> > >> Select IMX_DSP in SND_SOC_SOF_IMX8_SUPPORT to fix this
> > >>
> > >> Reported-by: Hulk Robot <hulkci@huawei.com>
> > >> Fixes: f9ad75468453 ("ASoC: SOF: imx: fix reverse CONFIG_SND_SOC_SOF_OF dependency")
> > >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > >
> > > Thanks for the report.
> > >
> > > Would you mind sharing the .config and instructions to reproduce this case? we have an unrelated issue with allyesconfig that was reviewed here:
> > >
> > > https://github.com/thesofproject/linux/pull/1778
> > >
> > > and I'd probably a good thing to fix everything in one shot.
> >
> > config is attached, which is on x86_64
>
> Thanks, I think this is legit. It was introduced with:
>
> commit f52cdcce9197fef9d4a68792dd3b840ad2b77117
> Author: Daniel Baluta <daniel.baluta@nxp.com>
> Date:   Sat Jan 4 15:39:53 2020 +0000
>
>     firmware: imx: Allow IMX DSP to be selected as module
>
>     IMX DSP is only needed by SOF or any other module that
>     wants to communicate with the DSP. When SOF is build
>     as a module IMX DSP is forced to be built inside the
>     kernel image. This is not optimal, so allow IMX DSP
>     to be built as a module.
>
>     Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>     Signed-off-by: Shawn Guo <shawnguo@kernel.org>

Hi,

Since it's a module, don't you just miss EXPORT_SYMBOL there?

> So, I think we should change the Fixes tag. Are there
> any clear rules on when to use select vs depends?
>
> On my side, I know what both are doing but it is not clear
> when to use them.

Visible symbols usually should not be selected. The same with symbols
with dependencies. The docs have this rule mentioned.

Best regards,
Krzysztof
