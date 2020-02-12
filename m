Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4312C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B975620714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQTj4phV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgBLJzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:55:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33471 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbgBLJza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:55:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id u6so1436600wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 01:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qqmmgh1mRA8+uKd3OvijHJxqdZDdPNm7C7N0rHwtQ0=;
        b=ZQTj4phV6Ct6hAZ9+3hpFPdlE3z+Cx/i/rtMRiLdQSrUdYcPxaojrRblBDxxa9sUFr
         z4/+4zKw6rfRxYW1MyKnDCMlDrNwIEqHnZ2oRp6ckiZA6XWcT8zUmtRvkopMkOfRmunq
         a0X31u+6mOY7gexXKHddCIOlf2V9zMC2huzBvbOBm5jznmroIIpWafVfqoJLwEYdE5M8
         pT2y5sVIRhjfuakBod8G4f5eJXiYCUZ+8j3897A0IK+3idy4rTesYmDiBfm2L03KOUxi
         nS2WG4GzIK8YAls2dsBBOYXz/riEAmjDZi9MO3zW9DqQMRvwBZGz0VJ08eC6f3J96v2l
         nhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qqmmgh1mRA8+uKd3OvijHJxqdZDdPNm7C7N0rHwtQ0=;
        b=Y8OFqHPma3USYJvaEjYTjD6JQTTN3OnFOHMREpiOrsuVDOYDtclLX9oBxu9/Z6+6W3
         nlZpCuGOoiRYCiTJ8oW/Kx823NzPNahp8uaeI66O67kCBXu92BGwNyjkLyg202dvk23f
         8eeyjpGm0EZ2JuvOOnUBKWr5ziLU/8tRL98+ObyIsaD/9HTo1bwSMwoxxcfgfy4zvd4M
         wXSkpy0B10WKz8Deq3RkFNSIeWPDGueKPzGWblYQGZ+b0yucJvaIC/XdEIbZ3vMm9KDr
         s4b8xbITrhrxv0rr0BM+WVZczFZTS5LC6RGkmZ+knPMS5je6J/NtcWLxnbk687zFMgnL
         c44g==
X-Gm-Message-State: APjAAAXDT4ScHd6+Lp3l0W7P8WBeJXOvv3DPOsXSR3bHLMntEJw0xI29
        SZBcxajkddb6VaptBnJnbkzK5Bl4KxItu5GuJk6YJNpjLf0=
X-Google-Smtp-Source: APXvYqxL9Eo4qb2sOJrd1wkpY5K5/0EEQ1noRNaNgdXfALwcSpj9a+jGRMYLeglfrh/aGIAZ7gTQTMGTxHsaLfrIN3k=
X-Received: by 2002:adf:f7c6:: with SMTP id a6mr15060118wrq.164.1581501328222;
 Wed, 12 Feb 2020 01:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20200210061544.7600-1-yuehaibing@huawei.com> <9351a746-8823-ee26-70da-fd3127a02c91@linux.intel.com>
 <be093793-3514-840a-ff2f-4dc21d8ee7f1@huawei.com> <CAEnQRZDWFgXocRJxtc2e7McRCAtod6-GwPJaVMdb4ymBZgSD1w@mail.gmail.com>
 <CAJKOXPcxL2vpWGwO1OL9Vv0g6hzbW-AyGJNn=7Yq2iy10_cbhg@mail.gmail.com>
In-Reply-To: <CAJKOXPcxL2vpWGwO1OL9Vv0g6hzbW-AyGJNn=7Yq2iy10_cbhg@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 12 Feb 2020 11:55:16 +0200
Message-ID: <CAEnQRZB2n+NOEete9fe7=EU9D2gfURf52NnUZTRDM0n9ey_FSw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH -next] ASoC: SOF: imx8: Fix randbuild error
To:     Krzysztof Kozlowski <krzk@kernel.org>
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

On Tue, Feb 11, 2020 at 11:59 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 11 Feb 2020 at 10:46, Daniel Baluta <daniel.baluta@gmail.com> wrote:
> >
> > On Tue, Feb 11, 2020 at 3:59 AM Yuehaibing <yuehaibing@huawei.com> wrote:
> > >
> > > On 2020/2/11 5:00, Pierre-Louis Bossart wrote:
> > > >
> > > >
> > > > On 2/10/20 12:15 AM, YueHaibing wrote:
> > > >> when do randconfig like this:
> > > >> CONFIG_SND_SOC_SOF_IMX8_SUPPORT=y
> > > >> CONFIG_SND_SOC_SOF_IMX8=y
> > > >> CONFIG_SND_SOC_SOF_OF=y
> > > >> CONFIG_IMX_DSP=m
> > > >> CONFIG_IMX_SCU=y
> > > >>
> > > >> there is a link error:
> > > >>
> > > >> sound/soc/sof/imx/imx8.o: In function 'imx8_send_msg':
> > > >> imx8.c:(.text+0x380): undefined reference to 'imx_dsp_ring_doorbell'
> > > >>
> > > >> Select IMX_DSP in SND_SOC_SOF_IMX8_SUPPORT to fix this
> > > >>
> > > >> Reported-by: Hulk Robot <hulkci@huawei.com>
> > > >> Fixes: f9ad75468453 ("ASoC: SOF: imx: fix reverse CONFIG_SND_SOC_SOF_OF dependency")
> > > >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > >
> > > > Thanks for the report.
> > > >
> > > > Would you mind sharing the .config and instructions to reproduce this case? we have an unrelated issue with allyesconfig that was reviewed here:
> > > >
> > > > https://github.com/thesofproject/linux/pull/1778
> > > >
> > > > and I'd probably a good thing to fix everything in one shot.
> > >
> > > config is attached, which is on x86_64
> >
> > Thanks, I think this is legit. It was introduced with:
> >
> > commit f52cdcce9197fef9d4a68792dd3b840ad2b77117
> > Author: Daniel Baluta <daniel.baluta@nxp.com>
> > Date:   Sat Jan 4 15:39:53 2020 +0000
> >
> >     firmware: imx: Allow IMX DSP to be selected as module
> >
> >     IMX DSP is only needed by SOF or any other module that
> >     wants to communicate with the DSP. When SOF is build
> >     as a module IMX DSP is forced to be built inside the
> >     kernel image. This is not optimal, so allow IMX DSP
> >     to be built as a module.
> >
> >     Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> >     Signed-off-by: Shawn Guo <shawnguo@kernel.org>
>
> Hi,
>
> Since it's a module, don't you just miss EXPORT_SYMBOL there?

This is a good point. Will have a deeper look at this asap and sent a
fix .

>
> > So, I think we should change the Fixes tag. Are there
> > any clear rules on when to use select vs depends?
> >
> > On my side, I know what both are doing but it is not clear
> > when to use them.
>
> Visible symbols usually should not be selected. The same with symbols
> with dependencies. The docs have this rule mentioned.

I see. Thanks!
