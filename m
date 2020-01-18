Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEFEC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 08:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703BE20730
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 08:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579334494;
	bh=QZRfRTcVJI//te9sCP4zKTxHjzJXiThJCDSqkyFq4H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GrFUo4ecrYoe5Mtybsu47511u98LmN3kalkqqQY9b8Qz2wLb9Vqd+lrQdOjxbj1BT
	 mWD40DxQL7WD+YmcA686LQ8G4EHo9NMnmdEbP/U9IXEPd68DsPMq3bfo6W9TpLvt+j
	 U4YG8GYtaK5CTVX1f7+o6j4iR/umuc1SBN5QGRBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgARIBd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 03:01:33 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46571 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgARIBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 03:01:33 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so24499800edi.13;
        Sat, 18 Jan 2020 00:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ERU6n/vLZIFZzZezcuFNkuC3YsIDUkY1X3kuKRLhtPI=;
        b=eOgsulatxPkywHX40RO1s4lGujdrNsZOhY7xYFyktnUWeN6DdMwkjdr8fc5tc8VOcQ
         bb+JQaCgaIgdestFURn13nodToqF1Egn4qp248N+af6iWkhhwsTqGMcUUoNf66PscbmM
         +a/i/0gayRgMdgKRcqr9VGolp3RfAMJBHesNwx2MYjqo0dqphXR3DDut1529vN/biP9u
         Y9d6JX8Yce6HszQC8RbD0LnU9/weCwlhNXB7Xs5f5qf+nFz+WuOiNZPzXradnMLHIqeU
         1m359M2+zxEMpAtK9n258Lmw0oi80mqSOeED3/xlRrKTHxmU/rYca65fAgpp85oky9Ix
         Zd7A==
X-Gm-Message-State: APjAAAWT2bpVSj5yQ0KD3eim8xBJXrhB1H2t+N0RhkqRL6mS7zkW13ls
        lsqklSh8r555P7RPqB5XXhw=
X-Google-Smtp-Source: APXvYqzM9VN5q/4nn9B+1luAc1pp6crhzwh/UF9BKC38MwwSTn2ijgX/sa79XihoD247g4XK/lOAqA==
X-Received: by 2002:a50:d55d:: with SMTP id f29mr7582483edj.364.1579334491153;
        Sat, 18 Jan 2020 00:01:31 -0800 (PST)
Received: from kozik-lap ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id d23sm403430ejt.40.2020.01.18.00.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jan 2020 00:01:30 -0800 (PST)
Date:   Sat, 18 Jan 2020 09:01:28 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH] sh: sh4a: Remove unused tmu3_device
Message-ID: <20200118080128.GA7123@kozik-lap>
References: <20200108194520.3341-1-krzk@kernel.org>
 <CAMuHMdULhY=_GF2MsX-h_j=eLKL+2x3=YcgmFRsAy1_LUOdZ+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAMuHMdULhY=_GF2MsX-h_j=eLKL+2x3=YcgmFRsAy1_LUOdZ+g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 01:56:58PM +0100, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Wed, Jan 8, 2020 at 8:45 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Remove left-over from previous cleanups to silence the warning:
> >
> >     arch/sh/kernel/cpu/sh4a/setup-sh7786.c:243:31:
> >         warning: ‘tmu3_device’ defined but not used [-Wunused-variable]
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/sh/kernel/cpu/sh4a/setup-sh7786.c | 21 ---------------------
> >  1 file changed, 21 deletions(-)
> >
> > diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> > index 4b0db8259e3d..22d1c38f742f 100644
> > --- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> > +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> > @@ -229,27 +229,6 @@ static struct platform_device tmu2_device = {
> >         .num_resources  = ARRAY_SIZE(tmu2_resources),
> >  };
> >
> > -static struct sh_timer_config tmu3_platform_data = {
> > -       .channels_mask = 7,
> > -};
> > -
> > -static struct resource tmu3_resources[] = {
> > -       DEFINE_RES_MEM(0xffde0000, 0x2c),
> > -       DEFINE_RES_IRQ(evt2irq(0x7c0)),
> > -       DEFINE_RES_IRQ(evt2irq(0x7c0)),
> > -       DEFINE_RES_IRQ(evt2irq(0x7c0)),
> > -};
> > -
> > -static struct platform_device tmu3_device = {
> > -       .name           = "sh-tmu",
> > -       .id             = 3,
> > -       .dev = {
> > -               .platform_data  = &tmu3_platform_data,
> > -       },
> > -       .resource       = tmu3_resources,
> > -       .num_resources  = ARRAY_SIZE(tmu3_resources),
> > -};
> > -
> >  static const struct sh_dmae_channel dmac0_channels[] = {
> >         {
> >                 .offset = 0,
> 
> Looks like the previous cleanup accidentally removed one too many tmu
> device pointers.  The old style used one device per timer, the new style
> uses one device per 3 timers, i.e. 4 devices for 12 timers.
> 
> So the correct fix would be to re-add "&tmu3_device" to
> sh7786_early_devices[].
> 
> Fixes: 1399c195ef5009bf ("sh: Switch to new style TMU device")

Indeed, thanks. I'll send v2.

Best regards,
Krzysztof

