Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA2CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E4F205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPOEgylv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgG0LFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgG0LFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:05:38 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4486BC061794;
        Mon, 27 Jul 2020 04:05:38 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n5so9299726pgf.7;
        Mon, 27 Jul 2020 04:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qqDBKnihG2XgFKzkTVnXhmjbAmwos65pYeAfPUz+TY=;
        b=pPOEgylv6Y7MH8bv2omt+P9eNrjYD7Gvv22lyPeZ4pECv3ufllmMYYWrrdlnuFjRt9
         bSrYstVxo77gL0pHHgw8bECA5nf07LTnlcgRF3i9sjV5KKWuALEkWJTlys0zNsienGpA
         dkHALVm2EgRvjRA5At8fFLtQ78K5l17DNoHOBIV1hk//wRPHK6uIV/9e1YEjsvNHOHQG
         ztl5zdAaROYoT6DQ4IROwPgdWd/No7ZqJgo1A3UN0FDpzVpZI4QF673lDaRm+z94DAw2
         wJSsCSJfGbSolsww0hAWb69VzcQXvLlfNJjCi4PLOk0gmQ4RT+wGrTL4TJoxBaDaPjlf
         23eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qqDBKnihG2XgFKzkTVnXhmjbAmwos65pYeAfPUz+TY=;
        b=sL8sIIXplUsyUmZTobtnlvsd9vIU2US8wP0z4idK4riD0D+6fGb5gO7JL3hZbKvS59
         8XuAfQUzYqFdZVXAZb+pG1zN7M7ecf2URjDFSPUq+RM3L5kv0f4MhvT1s6xsM/PML2v5
         BgzchDLvhacwz+tSfE9Y1bqXw9NAM7BsWlZj7Ii13+67c3wLZ3XFS2ijOOFBAH3d3jXP
         iY9HzVXxtXwvJwkf2krzneEnJEefZh9R6r86yJQPARfrbn5X1YWZqv7ALXrBxXHfREH+
         eA2XqRUuBzbPmDnkzk11xIPEMYw9nX+8LKhr3fgv7CuezaORTz0CdfS3l6gx52beRTVW
         QyUQ==
X-Gm-Message-State: AOAM533BFVb2XAYVnss90Lw752S5NRBNEfzcd5DtbK4RTGW+HdtXVJ+s
        fxtyFDSIiHeWZsCIDzWbZvBDMCFIOibPhS3RBes=
X-Google-Smtp-Source: ABdhPJzuBsxSLlKiomAknMEpLElLpk5DVv+r46SMf/pRDFGSQfeU2Cks1QOuxgp9TA0kJMnMY0dnmVF9jMWf+22TFXs=
X-Received: by 2002:a63:924b:: with SMTP id s11mr18731996pgn.74.1595847937830;
 Mon, 27 Jul 2020 04:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200725150651.17029-1-vadym.kochan@plvision.eu>
 <20200725150651.17029-3-vadym.kochan@plvision.eu> <CAHp75VeLS+-QkHuee8oPP4TDQoQPGFHSVpzi0e4m3Xhy2K+d1g@mail.gmail.com>
 <20200726225545.GA11300@plvision.eu> <CAHp75Vea6eWUqvXAKtu5Qv3Q0Oo=mxD+zf+zogZdcYOFtRe17g@mail.gmail.com>
 <20200727093421.GA21360@plvision.eu>
In-Reply-To: <20200727093421.GA21360@plvision.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jul 2020 14:05:23 +0300
Message-ID: <CAHp75VcC1zts-5fncuJAXq2wmZfZCvmmng4V_wvQWpV1Yny3dw@mail.gmail.com>
Subject: Re: [net-next v3 2/6] net: marvell: prestera: Add PCI interface support
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Andrii Savka <andrii.savka@plvision.eu>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mickey Rachamim <mickeyr@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 12:34 PM Vadym Kochan <vadym.kochan@plvision.eu> wrote:
> On Mon, Jul 27, 2020 at 11:04:56AM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 27, 2020 at 1:55 AM Vadym Kochan <vadym.kochan@plvision.eu> wrote:
> > > On Sun, Jul 26, 2020 at 01:32:19PM +0300, Andy Shevchenko wrote:
> > > > On Sat, Jul 25, 2020 at 6:10 PM Vadym Kochan <vadym.kochan@plvision.eu> wrote:

...

> > > > > +config PRESTERA_PCI
> > > > > +       tristate "PCI interface driver for Marvell Prestera Switch ASICs family"
> > > > > +       depends on PCI && HAS_IOMEM && PRESTERA
> > > >
> > > > > +       default m
> > > >
> > > > Even if I have CONFIG_PRESTERA=y, why as a user I must have this as a module?
> > > > If it's a crucial feature, shouldn't it be rather
> > > >   default CONFIG_PRESTERA
> > > > ?
> > >
> > > The firmware image should be located on rootfs, and in case the rootfs
> > > should be mounted later the pci driver can't pick this up when
> > > statically compiled so I left it as 'm' by default.
> >
> > We have for a long time to catch firmware blobs from initrd (initramfs).
> > default m is very unusual.
> >
> For example drivers/net/ethernet/mellanox/mlxsw/pci.c also uses 'm' as
> default, but may be in that case the reason is that there are several
> bus implementations - i2c, pci.

% git grep -n -w 'default m if' -- $(git ls-files | grep Kconfig) | wc -l
240
% git grep -n -w 'default m' -- $(git ls-files | grep Kconfig) | wc -l
293
% git grep -n -w 'default' -- $(git ls-files | grep Kconfig) | wc -l
5226

So, basically 'default m' cases are ~1% (53) of all default cases
(5226) in the tree.

...

> > Maybe you may replace __stringify by explicit characters / strings and
> > comment how the name was constructed?
> >
> > #define FW_NAME "patch/to/it/fileX.Y.img"
> >
> I used snprintf, and now it looks simpler.

Works for me!

-- 
With Best Regards,
Andy Shevchenko
