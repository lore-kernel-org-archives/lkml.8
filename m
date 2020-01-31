Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DD1C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E72206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580437207;
	bh=Vz6hJWDsKX0a+SxkdvBMgG4b72iwTw8oFYBE1jQZPvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I4nJaB0a9O9FfrjBGl0FJpDEouFMYuMR2Tk1vBLznZ4e2+iLdqPHA+ytl/E8OLiof
	 WEyXXUACTVGWR+O5F72zDxICPN3987JgjLVmmWVXcYxg0VYMgqh4+YX2j2/Aq0aeu0
	 f2cdX25shJETsydyYzsKYyU9hiI94r8aB1KHAs8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgAaCUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 21:20:07 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:21130 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgAaCUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 21:20:06 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 00V2JpbD022951
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 11:19:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 00V2JpbD022951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1580437192;
        bh=Rmw2ES2NtwlDLJNZ5F0cMIG+v7B9YVLRJoeV03Y+h9M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2zHNxt53hzEP5jckpzpUCyrhLpfwSGnJABGpEANWbiTk4Is8lc28PgKrxuKRIzVyL
         IG7OONYu4r5O1Poozp3DCQ2Cp48f2IWhggJazj6zxpXRsxfnyTHq5Ncu709c8DJR+l
         s4dmTAnDq43a8DOAyvAKQpf1RCMgdDA7WC3QCAFbRLxmGMCp9DvrJJaIjA8/pInqyM
         QdLx3si1Dd7NuPxXG49Z7nP03Z+HDQxMPGJt+TOgVmqgSKK41h65sE5r+YeVv/7Fj1
         uTBaBH+ZeU6pQ3G8iiI1tycwh/WQ+aKIF9P6Yh/XaQlAUjE2SutVTYh9FGG/N8fO52
         vSswElyZQRk9Q==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id g23so3437942vsr.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 18:19:51 -0800 (PST)
X-Gm-Message-State: APjAAAWeFonF9xC7TufI5QGnkpqnxf+pix1G0ssldAleI0lunhYP6X/8
        PkyTXbHYX2dubs4xKuXlftA95FuUYlAYzQJRrZ4=
X-Google-Smtp-Source: APXvYqzexMZUAD4bymyzre34E6fe//hwk0NuPtd/vurYf4ipBg/PIV8QUSWu4IiMCZ/JOMBf5eBe6jLVwqW23CMz2GE=
X-Received: by 2002:a67:6485:: with SMTP id y127mr5416364vsb.54.1580437190760;
 Thu, 30 Jan 2020 18:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20200130191938.2444-1-krzk@kernel.org> <20200130213839.GW24874@lianli.shorne-pla.net>
In-Reply-To: <20200130213839.GW24874@lianli.shorne-pla.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 31 Jan 2020 11:19:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNATwE2My-kZZugH7L+6jteU4dosiDt8e-H03n_-VH8nT1Q@mail.gmail.com>
Message-ID: <CAK7LNATwE2My-kZZugH7L+6jteU4dosiDt8e-H03n_-VH8nT1Q@mail.gmail.com>
Subject: Re: [PATCH] openrisc: configs: Cleanup CONFIG_CROSS_COMPILE
To:     Stafford Horne <shorne@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Andrew Morton <akpm@linux-foundation.org>,
        openrisc@lists.librecores.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,


On Fri, Jan 31, 2020 at 6:38 AM Stafford Horne <shorne@gmail.com> wrote:
>
> +cc: Masahiro,
>
> On Thu, Jan 30, 2020 at 08:19:38PM +0100, Krzysztof Kozlowski wrote:
> > CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
> > CONFIG_CROSS_COMPILE support").
>
> I see this patch is already in, but does it break 0-day test tools that depend
> on this CONFIG_CROSS_COMPILE setup?  I guess its been in since 2018, so there
> should be no problem.


As far as I understand, the 0-day bot passes CROSS_COMPILE= from the
command line because I see it in "make.cross" script, which is
attached in reports.

I did not hear any complaint from 0-day bot maintainers.



> Can you also help to update "Documentation/openrisc/openrisc_port.rst"?  It
> mentions the build steps are:
>
>     Build the Linux kernel as usual::
>
>         make ARCH=openrisc defconfig
>         make ARCH=openrisc
>
> This now changes, I used to use `make ARCH=openrisc CROSS_COMPILE=or1k-linux-`
> is this still going to work?

Yes, it still works.



> -Stafford
>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/openrisc/configs/or1ksim_defconfig    | 1 -
> >  arch/openrisc/configs/simple_smp_defconfig | 1 -
> >  2 files changed, 2 deletions(-)
> >
> > diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
> > index d8ff4f8ffb88..75f2da324d0e 100644
> > --- a/arch/openrisc/configs/or1ksim_defconfig
> > +++ b/arch/openrisc/configs/or1ksim_defconfig
> > @@ -1,4 +1,3 @@
> > -CONFIG_CROSS_COMPILE="or1k-linux-"
> >  CONFIG_NO_HZ=y
> >  CONFIG_LOG_BUF_SHIFT=14
> >  CONFIG_BLK_DEV_INITRD=y
> > diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
> > index 64278992df9c..ff49d868e040 100644
> > --- a/arch/openrisc/configs/simple_smp_defconfig
> > +++ b/arch/openrisc/configs/simple_smp_defconfig
> > @@ -1,4 +1,3 @@
> > -CONFIG_CROSS_COMPILE="or1k-linux-"
> >  CONFIG_LOCALVERSION="-simple-smp"
> >  CONFIG_NO_HZ=y
> >  CONFIG_LOG_BUF_SHIFT=14
> > --
> > 2.17.1
> >



-- 
Best Regards
Masahiro Yamada
