Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEBAC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33C8217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOQ57w7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgAUFWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 00:22:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33734 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUFWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 00:22:38 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so1390059lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 21:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10uCgcOh8GuCTdROrJG14zIlnNqN7+lyAEGCAJKzUfc=;
        b=dOQ57w7jyqlaZZnfUqU30rYP+QwDhn3BqXdBNi8JOs01giS1JtB6zi7cgcXOpIo/rp
         OiRnjC976CNRBC3SvehF0SmewOrluwhJ6CvKczX5MSpoDrxsUNbngcW/M+KMDKwk/XL6
         x001e3/AzYitXD56P4BdOfsJhW3CAqeJnEND3wgMdOAAqPRRirt/V+JJ1S2THPXviNVT
         xQyAkoR3/0sDfkJQeeTioyhXh31fhCXWz46MKLJVqRG056YxUlzxOPWkfaOBR8BNVxal
         LkP2WI1LKUe7VLvLede/ld8TBAYX/xB2upvusOp78qLCF4oWCRCxt/AxgLA7fS/MFjuE
         iRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10uCgcOh8GuCTdROrJG14zIlnNqN7+lyAEGCAJKzUfc=;
        b=MjqIdl5bBHIbDqmc7T5lGlat7A39GPTc/ffdMwS11+RVWdCFGkcZJyG+yIL6Ie91eZ
         sNbqzyAaBXl5pZa6P28MvBD8ROcCeb5hbQvk9WvEG4oYxdjwD3i9hdsXTuTR4k9z19er
         2B5S/Ce7QVezk7vwiJ47cDa0MnUS1/hkuVBeUxNyOvUS/lSHYDkBkIdeyhc3gGHe64zL
         DMlGPo/yigK4jGVGoR6fe6SOupVpfoTLdgdI15qPYpxiWooNXKPnXN6ac3GV0dY3vQrq
         61tLSQntLh0ci6RzA4sUv9Si/vtU5V6mgTmE7yZ+ViFRFscDuyicsk9b+YQiyR1432z/
         Ui9w==
X-Gm-Message-State: APjAAAV9XWiTM3ORaL73LzxL46heC3+4yDPx5fGaABAezscn0820WX16
        a65/YxWIN6I46IzPEt6C6QVTVTlndZH6wbCmMN66sQ==
X-Google-Smtp-Source: APXvYqy8XKTOi45XgTiwsd3r7Km7sRCJLEdT9n2xrYyCwIS+rCJCk4nzsYegcyvKX6J9fRND5avEPUy9QCaCWYw2jcM=
X-Received: by 2002:a2e:3504:: with SMTP id z4mr15624527ljz.273.1579584156292;
 Mon, 20 Jan 2020 21:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20191230120021.32630-1-jagan@amarulasolutions.com> <20200109074625.GE4456@T480>
In-Reply-To: <20200109074625.GE4456@T480>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Jan 2020 10:52:25 +0530
Message-ID: <CA+G9fYvKw7ijk-vxA58SR_d0_-3_in28uFG5H6pikypgDpAHPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: imx6q-icore-mipi: Use 1.5 version of
 i.Core MX6DL
To:     Shawn Guo <shawnguo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        linux- stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following dtbs build error noticed for arm build on stable rc 4.19 branch.

# make -sk KBUILD_BUILD_USER=KernelCI -C/linux ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- HOSTCC=gcc O=build dtbs
 #
 ../arch/arm/boot/dts/imx6dl-icore-mipi.dts:11:10: fatal error:
imx6qdl-icore-1.5.dtsi: No such file or directory
    11 | #include "imx6qdl-icore-1.5.dtsi"
       |          ^~~~~~~~~~~~~~~~~~~~~~~~
 compilation terminated.
 make[2]: *** [scripts/Makefile.lib:294:
arch/arm/boot/dts/imx6dl-icore-mipi.dtb] Error 1


On Thu, 9 Jan 2020 at 13:16, Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Dec 30, 2019 at 05:30:19PM +0530, Jagan Teki wrote:
> > The EDIMM STARTER KIT i.Core 1.5 MIPI Evaluation is based on
> > the 1.5 version of the i.Core MX6 cpu module. The 1.5 version
> > differs from the original one for a few details, including the
> > ethernet PHY interface clock provider.
> >
> > With this commit, the ethernet interface works properly:
> > SMSC LAN8710/LAN8720 2188000.ethernet-1:00: attached PHY driver
> >
> > While before using the 1.5 version, ethernet failed to startup
> > do to un-clocked PHY interface:
> > fec 2188000.ethernet eth0: could not attach to PHY
> >
> > Similar fix has merged for i.Core MX6Q but missed to update for DL.
> >
> > Fixes: a8039f2dd089 ("ARM: dts: imx6dl: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit support")
> > Cc: Jacopo Mondi <jacopo@jmondi.org>
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> Applied all 3, thanks.
