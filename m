Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58C7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E3572065F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHn/oQ3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGQMBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgGQMB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:01:29 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47179C08C5C0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 05:01:29 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e8so12317972ljb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 05:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ub697sVNwFF1cayMFoyuXRD/DoOaqjni0fvqH97Bh1w=;
        b=IHn/oQ3biBmtQTO5y7w6n8hxo4+QzjCMbkZ1yYDEmlK1IiEezprP1XH4WeAHB2zkHe
         hmdMyuTF1dqBdEUsXKFaqlfCQVn0rz3kdGh01jVdAMYMlh8dKckB6QiQb+Z3J9IEWpov
         Wj/tGt7StMejsVMfR63BSFLTj5vywd40zL2bAOryUkVHWuWJ2eGzJnYPRamRGxAo69hT
         l/EBIEEBX5eEqhjV4NKVn0aFVGQfI23mg+z0Q5NeiwOXlcFeOln4x5woeIRnF1hj6X3y
         RdMs52IyAVdBgTN7DeAzbCTCQrAMFhghih+fFuQ+cuBiRZ0Oo5JJF3eXDGk91tNE4Hqk
         CfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ub697sVNwFF1cayMFoyuXRD/DoOaqjni0fvqH97Bh1w=;
        b=VcIoLECd2TfQRXhldPuw1wUvu8uGnEx1mrYtp0lWZC1YjQCPLR/qP5pWRpeTe4DDTx
         iNcz2Ql6rSYdwFQcynAxncpyAFXCHc6snIH1PDUXG/rMNaKJZj9iyOJRK3J322i0fiaN
         jlV0CVKaqr1qcBeJsS7W8xJ/SeYVIL52P/cqCkFU8IySPck0HQxOBBkHl9HUB+Zy0TXj
         pbUX3MEJJKIFfhc1z6JZOdturwFGPZZXAeSwsiHHywdDYmJ5KsVfq4NeUFP8kTGt6bng
         1Wp2plgf+B70LGVnSRFK5NbJaERQ7pNVai0wzWXlPStOKYxeruX9gxrbtUf9uiPVhZTC
         A9nw==
X-Gm-Message-State: AOAM5335kmWyVHs5eBH+8yGCvhHBc6WeSdnBXjDUt4ZrFi4fYwa+syvw
        ESwMciy+ME4LS/pVXgZB07HVUC2uaJqCv37rDWAFDg==
X-Google-Smtp-Source: ABdhPJx85nks8yaHQQYuyBdwuRKFsp37cc6OWGOcSWI/V0vNVyp7ufOAVlF+nDIW3hoBpajbiNi0N+nPII8MvmaiPNY=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr4129807ljc.104.1594987287043;
 Fri, 17 Jul 2020 05:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <1594164323-14920-1-git-send-email-Anson.Huang@nxp.com>
 <CACRpkdYP4J+MZjxWUnkM-XGaMmFFZfMCfY13r7G6r2=v3F6zQw@mail.gmail.com>
 <DB3PR0402MB39168FEA9306CBF90A596E31F5630@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916FB27846F462C2210C3BFF57E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CACRpkda2gdu8FsSM0MC6g8C1mebmVc5dFWJZwNvQUPXNi5bnkQ@mail.gmail.com> <DB3PR0402MB39167A4BB808A0679257DEF9F57F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39167A4BB808A0679257DEF9F57F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Jul 2020 14:01:16 +0200
Message-ID: <CACRpkdbCVZaHqijqMck+jLAJuCAT31HA=9wwcV_EnQc=hsXLwg@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: mxc: Support module build
To:     Anson Huang <anson.huang@nxp.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Adam Ford <aford173@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Jon Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, John,

we need some guidance here. See below.

On Thu, Jul 16, 2020 at 4:38 PM Anson Huang <anson.huang@nxp.com> wrote:
> [Me]
> > On Wed, Jul 15, 2020 at 4:44 AM Anson Huang <anson.huang@nxp.com>

> > > I tried to replace the subsys_initcall() with
> > > module_platform_driver(), but met issue about "
> > > register_syscore_ops(&mxc_gpio_syscore_ops);" which is called in
> > > gpio_mxc_init() function, this function should be called ONLY once,
> > > moving it to .probe function is NOT working, so we may need to keep the
> > > gpio_mxc_init(), that is another reason that we may need to keep
> > > subsys_initcall()?
> >
> > This looks a bit dangerous to keep like this while allowing this code to be used
> > from a module.
> >
> > What happens if you insmod and rmmod this a few times, really?
> > How is this tested?
> >
> > This is not really modularized if that isn't working, just that modprobing once
> > works isn't real modularization IMO, it seems more like a quick and dirty way
> > to get Androids GKI somewhat working with the module while not properly
> > making the module a module.
> >
> > You need input from the driver maintainers on how to handle this.
>
> As far as I know, some general/critical modules are NOT supporting rmmod, like
> clk, pinctrl, gpio etc., and I am NOT sure whether Android GKI need to support
> rmmod for these system-wide-used module, I will ask them for more detail about
> this.
>
> The requirement I received is to support loadable module, but so far no hard requirement
> to support module remove for gpio driver, so, is it OK to add it step by step, and this patch
> series ONLY to support module build and one time modprobe?

While I am a big fan of the Android GKI initiative this needs to be aligned
with the Linux core maintainers, so let's ask Greg. I am also paging
John Stultz on this: he is close to this action.

They both know the Android people very well.

So there is a rationale like this going on: in order to achieve GKI goals
and have as much as possible of the Linux kernel stashed into loadable
kernel modules, it has been elevated to modus operandi amongst
the developers pushing this change that it is OK to pile up a load of
modules that cannot ever be unloaded.

This is IIUC regardless of whether all consumers of the module are
actually gone: it would be OK to say make it impossible to rmmod
a clk driver even of zero clocks from that driver is in use. So it is not
dependency-graph problem, it is a "load once, never remove" approach.

This rationale puts me as subsystem maintainer in an unpleasant spot:
it is really hard to tell case-to-case whether that change really is a
technical advantage for the kernel per se or whether it is done for the
greater ecosystem of Android.

Often I would say it makes it possible to build a smaller kernel vmlinux
so OK that is an advantage. On the other hand I have an inkling that I
should be pushing developers to make sure that rmmod works.

As a minimum requirement I would expect this to be marked by

struct device_driver {
   (...)
    /* This module absolutely cannot be unbound */
   .suppress_bind_attrs = true;
};

So that noone would be able to try to unbind this (could even be an
attack vector!)

What is our broader reasoning when it comes to this? (I might have
missed some mail thread here.)

Yours,
Linus Walleij
