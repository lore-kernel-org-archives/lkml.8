Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11908C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9192080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592541445;
	bh=qXUyGTMqk0s4pILy6/qQx5eXN3RPzk7XUYvGPBQglZs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Nk3iFqRcdrRVyH3eTJQRa/jV9XvOjJ4YWXnVjIJuX2vG1WTOLAltWUKc1TeETp7q+
	 IAV26x3/2SqbOBqrkuUt1TePNpBf7oyaGthCCtr66etoqrhPal3VJeQRFB6ecVo6b2
	 9ut8gpSQhKDTlMIgw4cwOD5DHq70TJyKviCRpM1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgFSEhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:37:22 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:18009 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFSEhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:37:21 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 05J4am8u013594
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 13:36:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 05J4am8u013594
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592541409;
        bh=/Gxy2SuN9wf+8Jup/o62MfUd0IPatEXu+WO2tRs0Kg4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h/L9Oxrz/nxHFaKO9wfa29AEfizsyoadvlKka+xcg1xkcEo3p/JJA7BCsRUPjy8FW
         /Pv/S9baBkIAXmtCCXWBmpidrv8E3Dqye4AbuGCk35F79JUTxSvR67lwAk0zedcCQc
         1hsCSjB5rDW8AzRe3KFJflUA3v71+icVW77cMGZWZxpxJDdeGz1psOqmhesK6WM2gy
         lFx6USdKo0BOnIKdI+BQ/G4S2ju3KMfhdMewr6tbMJ6TOoB+t2ZOPNgvCd5v/mLTjG
         nYupKF6CQuTPd5YpqbSq5FVY5JEkAUZPno6aLCO7hf2w7sHRUGFPyzYRMMUnXEnzzs
         6FhIVmJPyoLlw==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id o2so4908545vsr.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:36:49 -0700 (PDT)
X-Gm-Message-State: AOAM533ZSAJzZPW4ECS/PfEct8ONirVOQDzWAJraHk4JYJ/qfRFjNeXC
        UvJW4yQKQAwnOaTcgqQaCZuPQtP4QazOhgtNVGE=
X-Google-Smtp-Source: ABdhPJwcxbEXGB1ILzoN07vUgnM3BtfhW4dvOzPp2aW8nPXQl3nRXDMU1mq5+0UX3q62V0OyHdLYDp8ddWv6+raROIs=
X-Received: by 2002:a05:6102:22c4:: with SMTP id a4mr4014045vsh.215.1592541407947;
 Thu, 18 Jun 2020 21:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <git-mailbomb-linux-master-a7f7f6248d9740d710fd6bd190293fe5e16410ac@kernel.org>
 <alpine.DEB.2.21.2006151004180.10003@ramsan.of.borg>
In-Reply-To: <alpine.DEB.2.21.2006151004180.10003@ramsan.of.borg>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 19 Jun 2020 13:36:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQjgvmyRZ=z4EAbSLBB_HF7Ej7D487UYc84po74ukJLRg@mail.gmail.com>
Message-ID: <CAK7LNAQjgvmyRZ=z4EAbSLBB_HF7Ej7D487UYc84po74ukJLRg@mail.gmail.com>
Subject: Re: treewide: replace '---help---' in Kconfig files with 'help'
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 5:06 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>         Hi Yamada-san,
>
> On Sat, 13 Jun 2020, Linux Kernel Mailing List wrote:
> > Commit:     a7f7f6248d9740d710fd6bd190293fe5e16410ac
> > Parent:     e4a42c82e943b97ce124539fcd7a47445b43fa0d
> > Refname:    refs/heads/master
> > Web:        https://git.kernel.org/torvalds/c/a7f7f6248d9740d710fd6bd190293fe5e16410ac
> > Author:     Masahiro Yamada <masahiroy@kernel.org>
> > AuthorDate: Sun Jun 14 01:50:22 2020 +0900
> > Committer:  Masahiro Yamada <masahiroy@kernel.org>
> > CommitDate: Sun Jun 14 01:57:21 2020 +0900
> >
> >    treewide: replace '---help---' in Kconfig files with 'help'
> >
> >    Since commit 84af7a6194e4 ("checkpatch: kconfig: prefer 'help' over
> >    '---help---'"), the number of '---help---' has been gradually
> >    decreasing, but there are still more than 2400 instances.
> >
> >    This commit finishes the conversion. While I touched the lines,
> >    I also fixed the indentation.
> >
> >    There are a variety of indentation styles found.
> >
> >      a) 4 spaces + '---help---'
> >      b) 7 spaces + '---help---'
> >      c) 8 spaces + '---help---'
> >      d) 1 space + 1 tab + '---help---'
> >      e) 1 tab + '---help---'    (correct indentation)
> >      f) 1 tab + 1 space + '---help---'
> >      g) 1 tab + 2 spaces + '---help---'
> >
> >    In order to convert all of them to 1 tab + 'help', I ran the
> >    following commend:
> >
> >      $ find . -name 'Kconfig*' | xargs sed -i 's/^[[:space:]]*---help---/\thelp/'
> >
> >    Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> > index 88b05b5256a9..1fa2fe2ef053 100644
> > --- a/arch/ia64/Kconfig
> > +++ b/arch/ia64/Kconfig
> > @@ -266,7 +266,7 @@ config PERMIT_BSP_REMOVE
> >       bool "Support removal of Bootstrap Processor"
> >       depends on HOTPLUG_CPU
> >       default n
> > -     ---help---
> > +     help
> >       Say Y here if your platform SAL will support removal of BSP with HOTPLUG_CPU
> >       support.
> >
> > @@ -274,7 +274,7 @@ config FORCE_CPEI_RETARGET
> >       bool "Force assumption that CPEI can be re-targeted"
> >       depends on PERMIT_BSP_REMOVE
> >       default n
> > -     ---help---
> > +     help
> >       Say Y if you need to force the assumption that CPEI can be re-targeted to
> >       any cpu in the system. This hint is available via ACPI 3.0 specifications.
> >       Tiger4 systems are capable of re-directing CPEI to any CPU other than BSP.
>
> I guess help text blocks like the above should be indented?
> Unfortunately there are many of them.

Yes, the help body should be indented by 1 tab + 2 spaces,
which is documented in
Documentation/process/coding-style.rst

Since there are too many, I cannot fix them all.


> Thanks!
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds



-- 
Best Regards
Masahiro Yamada
