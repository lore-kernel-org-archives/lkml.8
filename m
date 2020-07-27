Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A057CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D19C20786
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuLyPU3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgG0VNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0VNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:13:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD51AC061794;
        Mon, 27 Jul 2020 14:13:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k20so8451424wmi.5;
        Mon, 27 Jul 2020 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xi8D6LIwsxs0KNLAaqairags+EWlCXEvsyTkAbsZmKs=;
        b=TuLyPU3XGBxurp2UASoX96QUzbR2jSJbe5WazAm1qdG99vSkjG+cJHb9HUMe+JIBhz
         fast/LQJUyOVdK6J3LKYY/MqqZX3hQUOhpvElAQH5AJkKL+nshkiYliekbIMSlY1MbQi
         qgYHU12lPL9wUmTcMi2A4pdg6h/6kmI2oZkTCPMFa2jCopRbmXrMdkioDAMwJM46fYcB
         KkUZtFZokzxqrvxv78A3na9abLnnE20Jy+b9UtQbqt4G4JeTSP1oyknkiDn1Rej2Hh/6
         jZDzxKtOzD48sznc+ITS30CgCIC35vigb/k2a4kkTpobgVcNzdlXAMxcU9pOUnQmBB87
         qA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xi8D6LIwsxs0KNLAaqairags+EWlCXEvsyTkAbsZmKs=;
        b=TYI3Y5UaDMXezA1yolAmPqr21FCy+8s7RvdHYrVw+bd5vCPPX3mYKaf3dLZTKuc2Qr
         UgdZ8571gkYJUczHrC1cCtUQTweeCtSvNqx8P8bEz7lHMh25FBCW9HiqX2/tvVa1YvTg
         YKLBzETz4mqXsgufP4FBN5bYoVHsrXs3csL7o6AQIg+auACzt+Iv98s5svIyUeKZOTyK
         pa/vtNSX1AFaWITjBdEN1/jObcSqJJvkHcHbJ+IEvxhEoMVKfIG2vSaWMnsbz16T+ct3
         BoS+cgBZRJ1gMWpXnOpFcV/aNq6C4VH8sSDYB27M7lZlMY0cHpbzRjp/G+IbRrXcz3mZ
         hxow==
X-Gm-Message-State: AOAM532bVb7ej11AqcG3IaAgkvw6d/w7WGpDasxUjQrCP8IP54oa2gUI
        VZBDvKyTYfWEjxW3eE6k0tyMLBx++628KXj8vwPBCL1FWN0=
X-Google-Smtp-Source: ABdhPJztu3HqUquRNzfmLN8Xq0mFKZJNTddEYzkLA1x0TA8V4L4a76qi3371gYl9RyriudoPuc2q1IKlK2mQXNZnayg=
X-Received: by 2002:a7b:c765:: with SMTP id x5mr959701wmk.14.1595884433463;
 Mon, 27 Jul 2020 14:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
 <20200723174905.GA596242@bogus> <20200723195755.GV3428@piout.net>
 <20200727094553.GH1551@shell.armlinux.org.uk> <20200727144938.GC239143@piout.net>
 <20200727152439.GK1551@shell.armlinux.org.uk> <20200727154104.GE239143@piout.net>
 <20200727154335.GL1551@shell.armlinux.org.uk> <CABdtJHuVaTa5T0-KdQ-wZQrmFQ6HO3FvgnTgSo3aOi+=SPzDZA@mail.gmail.com>
 <20200727161632.GF239143@piout.net> <20200727173051.GM1551@shell.armlinux.org.uk>
In-Reply-To: <20200727173051.GM1551@shell.armlinux.org.uk>
From:   Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
Date:   Mon, 27 Jul 2020 22:13:42 +0100
Message-ID: <CAC4G8N5zUVc0YvT9mCP4BfeQD+KOAo6Rbswo8zqUh_mULa=Xsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jon Nettleton <jon@solid-run.com>,
        Rob Herring <robh@kernel.org>, a.zummo@towertech.it,
        Baruch Siach <baruch@tkos.co.il>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King - ARM Linux admin <linux@armlinux.org.uk> escreveu no dia
segunda, 27/07/2020 =C3=A0(s) 18:30:
>
> On Mon, Jul 27, 2020 at 06:16:32PM +0200, Alexandre Belloni wrote:
> > On 27/07/2020 17:55:50+0200, Jon Nettleton wrote:
> > > > So, can we please have that discussion, it is pertinent to this pat=
ch.
> > > >
> > >
> > > Thinking about this some more, I believe whether or not an IOCTL
> > > interface is in the works or needed is irrelevant.  This patch
> > > describes the hardware and how it is designed and the topic of
> > > discussion is if we need a simple boolean state, or if we need
> > > something that could be used to support dynamic configuration in the
> > > future.  I would rather make this decision now rather than keep
> > > tacking on boolean config options, or revisit a bunch of device-tree
> > > changes.

For what it's worth I also tend to agree.
The patchset, regardless of the property name (that I admit might be
misleading), is intended at enforcing a mode that the RTC/driver
should use by default. This mode is strongly related to the hardware
definition/implementation and its capabilities. While I understand the
need for the IOCTL interface to solve issues exactly like the
aforementioned factory example, I fail to see how it can be of any
help to solve the problem at hand - as it won't likely configure the
driver to use a different default mode depending on the board. The
IOCTL interface might also allow the userspace to change this property
back to the default mode (000) and end up breaking the RTC operation,
but I guess that's the cost of configurability and, in the end, the
user's responsibility.
Any pointers on how to proceed are appreciated.

Regards,

Miguel
