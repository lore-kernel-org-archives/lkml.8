Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB97FC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37B52065E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com header.i=@solid-run-com.20150623.gappssmtp.com header.b="CZYJVHdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgG0P4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgG0P43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:56:29 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174FFC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:56:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id g11so5825299ejr.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1XOxgs+ESH1/h8P2K3MXhzlqoLMlitlCI9KqWLboA8=;
        b=CZYJVHdAzY438h4GmyeOZBJQ3RJwFLYRn2E1DQxZ5Wezrb7oXcGMUySyBcYrem9oJy
         v85wJKg5Rry75jt4q6esgMorhv+VWA221Nuuh5qDR5tG7dD9q/LbW6zFOy2DW2bvdrJv
         ZNvdyj5EbtQj6TmMRDcsjCv2mWuGyN0FcsmIs93lPfCDGeJQWQRjQ404EeNfqdNnGcFt
         XZC1sEOze1Vc5O8S/dxoJFzqKDS8l3ev1Y1e8lQkG7Kaf0NZxeZFNYTXoaB2XOwyfgX+
         Du1cltEgNV4JdfnK0pNQ6BMRBpMrFN2f6ZQNYq0BSmbOH2DBb9/L9dpaGCLi2/5G6HeL
         Eedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1XOxgs+ESH1/h8P2K3MXhzlqoLMlitlCI9KqWLboA8=;
        b=lbjSjJSwtg146hVbzTCMRG1pKRRIIoHYrvG76mxHEDMfLe9dcKtfmC4g3dbYLa1P5T
         xe2edtaiReGmAVokwoJpu/1oYblIl3TpCOmB6fkGSDlGw09SqfOWy+p3jMjob0ZMrprX
         hGMB0lZCxm4MYGC5O2YSkBPyqkc/o6taVskwOPAlheD9OZ6Pkio/bmqbDds1ENO+KAA/
         hDy9ia+DHkpdXCwkJHz15MsAZ+oUtLJAJwDBPzNICNKpQgbWL/FCyM0mf8Mfgh1IC23h
         s0POuNOA6WwsCPAgkHeRT/gjdTc9TRcqOxVyjubUm2t8faSRcI00QegS6l1Rr91o7v4r
         /4ug==
X-Gm-Message-State: AOAM531GQjMoZyzip9/Ne1uJjpFGlDKBqKaxzWo/Bvh23USoEwgfRICZ
        Fk9lGj3vXw/e1abEMnqGoKfT97eMgbzf/ubJSI4Cww==
X-Google-Smtp-Source: ABdhPJyNSLUvhPPAp68+3bvGDOcxxHsEMX1B13+H02YFrz1OJkOjrSCdVMD5/2ncg2y+CTRAol+zwks9nnOn444jfsY=
X-Received: by 2002:a17:906:600f:: with SMTP id o15mr6771795ejj.41.1595865387804;
 Mon, 27 Jul 2020 08:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-1-miguelborgesdefreitas@gmail.com> <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
 <20200723174905.GA596242@bogus> <20200723195755.GV3428@piout.net>
 <20200727094553.GH1551@shell.armlinux.org.uk> <20200727144938.GC239143@piout.net>
 <20200727152439.GK1551@shell.armlinux.org.uk> <20200727154104.GE239143@piout.net>
 <20200727154335.GL1551@shell.armlinux.org.uk>
In-Reply-To: <20200727154335.GL1551@shell.armlinux.org.uk>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Mon, 27 Jul 2020 17:55:50 +0200
Message-ID: <CABdtJHuVaTa5T0-KdQ-wZQrmFQ6HO3FvgnTgSo3aOi+=SPzDZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>,
        a.zummo@towertech.it, Baruch Siach <baruch@tkos.co.il>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 5:43 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jul 27, 2020 at 05:41:04PM +0200, Alexandre Belloni wrote:
> > On 27/07/2020 16:24:39+0100, Russell King - ARM Linux admin wrote:
> > > On Mon, Jul 27, 2020 at 04:49:38PM +0200, Alexandre Belloni wrote:
> > > > On 27/07/2020 10:45:53+0100, Russell King - ARM Linux admin wrote:
> > > > > > This is but this shouldn't be a DT property as it has to be changed
> > > > > > dynamically. I'm working on an ioctl interface to change this
> > > > > > configuration.
> > > > >
> > > > > Why does it need to be changed dynamically?  If the hardware components
> > > > > are not fitted to allow the RTC to be safely used without DSM, then
> > > > > why should userspace be able to disable DSM?
> > > >
> > > > For RTCs with a standby mode, you want to be able to return to standby
> > > > mode.
> > > >
> > > > That would happen for example after factory flashing in that common use
> > > > case:
> > > >  - the board is manufactured
> > > >  - Vbackup is installed, the RTC switches to standby mode
> > > >  - the board is then booted to flash a system, Vprimary is now present,
> > > >    the RTC switches to DSM.
> > > >
> > > > At this point, if the board is simply shut down, the RTC will start
> > > > draining Vbackup before leaving the factory. Instead, we want to be able
> > > > to return to standby mode until the final user switches the product on
> > > > for the first time.
> > >
> > > I don't think you're understanding what's going on with this proposed
> > > patch.  The cubox-i does work today, and the RTC does survive most
> > > power-downs. There are situations where it doesn't.
> > >
> > > So, let's take your process above.
> > >
> > > - the board is manufactured
> > > - Vbackup is installed, the RTC switches to standby mode
> > > - the board is then booted to flash a system, Vprimary is now present
> > > - the board is powered down.  the RTC _might_ switch over to battery
> > >   if it notices the power failure in time, or it might not.  A random
> > >   sample of units leaving the factory have the RTC in standby mode.
> > >   Others are draining the battery.
> > >
> > > I'm not saying what you propose isn't a good idea.  I'm questioning
> > > why we should expose this in the generic kernel on platforms where
> > > it's likely to end up with the RTC being corrupted.
> > >
> >
> > Note that I didn't say we should expose settings that are not working
> > but it is a different discussion.
>
> It isn't a different discussion - that is exactly what the point of
> my emails to you all along have been!
>
> So, can we please have that discussion, it is pertinent to this patch.
>

Thinking about this some more, I believe whether or not an IOCTL
interface is in the works or needed is irrelevant.  This patch
describes the hardware and how it is designed and the topic of
discussion is if we need a simple boolean state, or if we need
something that could be used to support dynamic configuration in the
future.  I would rather make this decision now rather than keep
tacking on boolean config options, or revisit a bunch of device-tree
changes.
