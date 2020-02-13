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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2092FC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA69724673
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THiYYtRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgBMVMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:12:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41172 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgBMVMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:12:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so8473496wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 13:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iLnuSGH6jNEPRpXsbLdWMvvm70on1OtXGRCIuCTYax4=;
        b=THiYYtRd1Hw9OOJtDh3m0bsQpuPbcL6D15Or8KKVQBdszixBwTMpdrWI1sdey73UL6
         OMnfWvyrWMTpxJtIWoOC3klZgu1IWrwgGpKzMr1l6YiTs0DTZmmHJJcXX96UNF87RkqM
         HIFVzoYj/EtPV4PceO73UE9E2E+l505vMkvdCLvqEdLKR6NepxAChTX8Ksv5A3MY10wx
         MRDdAInFdByqnE458Nnhm4UsbhvGkS+b6VwbMIinCdiLagqLPLJoH+eJrkk9PW7dAYay
         e6CshZ/C9jEucmAiBLXhWu3nU7PBF+CispXbP2m0DDejFGVPd1+CTDQtGHZ+f7WzC7Ag
         k7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iLnuSGH6jNEPRpXsbLdWMvvm70on1OtXGRCIuCTYax4=;
        b=MbJ9zdlFB/+M2l+Als5gR3HP6Yjh7NyDgORh0huyuQ3ANphrKYh8WTOA3Na3WMJwva
         uYASSPRxPzAEUEoN0EH2/yi/SHic5/090lDBDTzYhp8eysiOi2VJLUNM+5dgmKp3ul/V
         5eq+ZFGmWPrVSnyEDFIbO+TaNszIDhk1QogEC39Z6ugnviKJVO4TIzvtbspTLodz4+ms
         bBqxl3fNO9VCB7yl3Hekb3wRqX9tIKJAV0dMfgfghccEaYjB/fhbwXbL/G93wJzrXXqm
         goZgB7aF6r8ML7oy9ehTGk99tuFvs3W3sCLJOMi+8GEmmxOo0njwG+oVREHw8kHd/dQa
         3Cag==
X-Gm-Message-State: APjAAAVzYS47J8pwJnYcXBfqgoPiIBEDjMrSnhlay66l3rcuDoR0k5Ok
        b2fwcalBR9I/Fz/oqWxqnJdP3OwdmvnDewzsa5o=
X-Google-Smtp-Source: APXvYqz2/8nyozAwb5c39LHVAvkkzIlzsIxS4KXcp3M3SHYFP+afkm8+EUw7r7XUouiqxTfEbIygo0weNf0szTqLQ0o=
X-Received: by 2002:adf:ed09:: with SMTP id a9mr24147253wro.350.1581628354989;
 Thu, 13 Feb 2020 13:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20200210061544.7600-1-yuehaibing@huawei.com> <9351a746-8823-ee26-70da-fd3127a02c91@linux.intel.com>
 <be093793-3514-840a-ff2f-4dc21d8ee7f1@huawei.com> <CAEnQRZDWFgXocRJxtc2e7McRCAtod6-GwPJaVMdb4ymBZgSD1w@mail.gmail.com>
 <CAJKOXPcxL2vpWGwO1OL9Vv0g6hzbW-AyGJNn=7Yq2iy10_cbhg@mail.gmail.com>
In-Reply-To: <CAJKOXPcxL2vpWGwO1OL9Vv0g6hzbW-AyGJNn=7Yq2iy10_cbhg@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 13 Feb 2020 23:12:23 +0200
Message-ID: <CAEnQRZBgpcLz29PG6pY_6xaULO6siGumqrsO0gRReMRwUOqW2w@mail.gmail.com>
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
>
> > So, I think we should change the Fixes tag. Are there
> > any clear rules on when to use select vs depends?
> >
> > On my side, I know what both are doing but it is not clear
> > when to use them.
>
> Visible symbols usually should not be selected. The same with symbols
> with dependencies. The docs have this rule mentioned.

You mean if module X depends on module Y, we shouldn't use select?
But this exactly what this patch does :).

The problem here is that when X depends on Y, and X=y and Y=m
when we try to compile X if get an error because we cannot find a symbol from Y.

I think if X depends on Y, and X is forced to "y" then also Y should
be forced on "y".
