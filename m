Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF04C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70D022314
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf3W1BUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgBMVJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:09:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34900 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgBMVJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:09:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so8460620wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 13:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZtGcUpA5w76Gcek+VkqKEDd0yDqjEFq7/gNXQdanLGM=;
        b=Mf3W1BUftM+nHyrzCX/s/zOBXQMM8Okj/NIiHqnyaNOVn9jeL+X5uDsvbhzPHs4ZYm
         Eywp6G8pCTJEPMEOzfDlStUka5S959F5fX2EOBMECYxssoK5tkYaGz5fR740k+uwX471
         xr7QHag/Smbp2tbSvoVKpw9CmTlS4i0HGeiXZhZ3mXb/Aila2GCHeova4TFb8L7ki8cc
         8Cb/+2IB82/9tcSUyspxstMFFE03/nSdqiwVBfLvGYn0fVx0uxDIH24GzIGcgxrN9TWW
         /foFhhuCCVAYNigjgDUFZ4sb0kgTydppAjzxko/meQW72KN2UZo9k129RSjVX01uo5ph
         CPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZtGcUpA5w76Gcek+VkqKEDd0yDqjEFq7/gNXQdanLGM=;
        b=IKUQanoJMX+0u3xZPuMFGKHbLkJo4riCgGt8dhtk1lk+Iz9G8STFLyCcHSzc2QZ3lN
         JPrPutXbUB3Oc6wRUf2lWdyuOj/PZw5xCnckRkB2CbK2Sj8PQN1uD2MIhkqbeZRaYhrj
         d7vFSYKg8YoVsVB+l03HPHFrjzpmFnloUJaww5W7u8BJqYQtGeWuo16WWHhZFJLOvM37
         8Z/DLo3xHc2z8oTkZzT2kf5O/mTuMqBvGsBxmTHm+pIm/i0bQ7COnj+K+1pCUc93qALt
         v7XksEjSE0/CRED1RcPNktx8e9FdMbfDYwsmwXpGC1qvh/OGdeLCrwnUia2+kXkz770y
         JraA==
X-Gm-Message-State: APjAAAU80lw1+LKtlq+qIHa6CnxlQ0xwurVlfUihWkVR4qZT4WDQ5sr/
        47DW0zq8Jih6sBcgeFNU7rnC2kJT3ndWTcJzC9g=
X-Google-Smtp-Source: APXvYqzGqv+wev1io566qMCQSBk8Usb8vOHvyhzTsTli9ft0dX6qZZT5ThpS8E5SOs7v3YSOIfjh2hVo6p2lk1M1uxE=
X-Received: by 2002:a05:6000:367:: with SMTP id f7mr23219823wrf.174.1581628191354;
 Thu, 13 Feb 2020 13:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20200210061544.7600-1-yuehaibing@huawei.com> <9351a746-8823-ee26-70da-fd3127a02c91@linux.intel.com>
 <be093793-3514-840a-ff2f-4dc21d8ee7f1@huawei.com> <CAEnQRZDWFgXocRJxtc2e7McRCAtod6-GwPJaVMdb4ymBZgSD1w@mail.gmail.com>
 <CAJKOXPcxL2vpWGwO1OL9Vv0g6hzbW-AyGJNn=7Yq2iy10_cbhg@mail.gmail.com>
In-Reply-To: <CAJKOXPcxL2vpWGwO1OL9Vv0g6hzbW-AyGJNn=7Yq2iy10_cbhg@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 13 Feb 2020 23:09:39 +0200
Message-ID: <CAEnQRZA4W-i4zcF8jUL2zp5-dO-iX=KSp5Do2pCK9_oZiVtYEQ@mail.gmail.com>
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

Hi Krzysztof,

Which symbol misses an EXPORT_SYMBOL?
We already have EXPORT_SYMBOL(imx_dsp_ring_doorbell);
