Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03342C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86E320738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590045709;
	bh=kCJFiC2qcVkXJicasXnpPmEKnb+0hgvDkk2zq6VzoXg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C8sqlk8qSmtphVnZFYBi3kBT6T4GKI6VdyzQup/Pnh9aIYTEPafI2ND0S9l2e/kBt
	 svb5SkqoEEpjP1NOHTsJhxOx86f/AU0LbZ2I8mwV/3FI1FTLz4xnZyaNBgoo4EM1LH
	 y5tK/FuFug3flV2MBstJ294L9x3LR5fEXJKzQ+Tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgEUHVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:21:49 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:32783 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgEUHVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:21:48 -0400
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 04L7LX95019601;
        Thu, 21 May 2020 16:21:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 04L7LX95019601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590045694;
        bh=g3f+D9tafdmbvpg7O9G/hP2TxGYOgCzFzWkyMyDjYrA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I+1vGg9ZzZFhHI5QbI63huhQpyX9MeFb/M4zeXVjfPjwQQZCfA+y/YsUv496JqjmT
         yMbNHCWL1W8zqKknaomuOtWJRcgdJyWnFPtwsJP+UC96+FwEalHYRdHQ1e9vSHQPZ8
         tno7saK/CmyL0DIX3fH/s7kFx3BjFLeVTHJuTxe7Ske2jarpi8fPO8ukh69Ve39zE1
         K+YEGGOZ8PfQTivenitJ4RYyMkMxf8lN7rtSMB1YBA78g2u6G+yUb6Xnu6htRMh4IQ
         DynyryqANNwuxBKF19gH9bgoMrs2SNkam3EtrJurEmlrL4L27RFr/YQpxB4tg/Gc22
         ater2z4rygorA==
X-Nifty-SrcIP: [209.85.221.182]
Received: by mail-vk1-f182.google.com with SMTP id j28so1466843vkn.8;
        Thu, 21 May 2020 00:21:33 -0700 (PDT)
X-Gm-Message-State: AOAM532Fe+S9HVzoPCFCMAUD0IIQdgULKUmRSMOlxYieqk+IenPg3AsG
        wHpAyLwj8NK01OshjjybKe4qquiH6lq2tUM8apw=
X-Google-Smtp-Source: ABdhPJyjSMndqk4OZKdfbRuMSh6rkcEKgLQZKuyQ4RzRUFtqbg+PLCAzB7yLurCO6p/T3vahAlwvUc0+rSJDTOHMnzY=
X-Received: by 2002:a1f:2e16:: with SMTP id u22mr6558972vku.12.1590045692980;
 Thu, 21 May 2020 00:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200514131234.380097-1-efremov@linux.com> <CAK7LNASRv9E-pfYCRmD-RstKhW+WgfHKrn+7bP_dAAkyKaoPGg@mail.gmail.com>
 <e26a1565-e770-0e5e-c730-60cc6fa16a4f@linux.com>
In-Reply-To: <e26a1565-e770-0e5e-c730-60cc6fa16a4f@linux.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 21 May 2020 16:20:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNASqja+eKcTeBA29LoWcMXucWv-L7Jntvzx9a5cam=UcWQ@mail.gmail.com>
Message-ID: <CAK7LNASqja+eKcTeBA29LoWcMXucWv-L7Jntvzx9a5cam=UcWQ@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: add variables for compression tools
To:     Denis Efremov <efremov@linux.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 6:40 PM Denis Efremov <efremov@linux.com> wrote:
>
> It seems that I missed a couple of tar commands in the patch:
> scripts/Makefile.package
> scripts/package/buildtar
>
> On 5/15/20 5:20 AM, Masahiro Yamada wrote:
> > On Thu, May 14, 2020 at 10:14 PM Denis Efremov <efremov@linux.com> wrote:
> >>
> >
> > commit 5054e88a7934d5ff5ec14231c8b8676161bb45fa
> > Author: Paul Eggert <eggert@cs.ucla.edu>
> > Date:   Mon Mar 16 14:25:17 2015 -0700
> >
> >     gzip: make the GZIP env var obsolescent
>
> Other implementations can depend on this.
> pigz still parses GZIP env var:
> https://github.com/madler/pigz/blob/master/pigz.c#L4346
>
> >
> > Some possible options I came up with:
> >
> >
> > [1] Use KGZIP for now, but BZIP2, XZ, etc. for the others.
> >
> >     (Then, rename KGZIP to GZIP when the time comes)
> >
> >
> > [2] Do not take this patch
> >
> >     The whole build process is parallelized
> >     by 'make -j $(nproc)'.
> >
> >     If you are still eager to use pigz instead gzip,
> >     use a symbolic link or a wrapper shell script.
> >
> >     $ ln -s /usr/bin/pigz  /$HOME/bin/gzip
> >     $ PATH="$HOME/bin:$PATH"
> >
>
> [3] GZIP at frontend, KGZIP or _GZIP internally? Something like:
>
> $ cat Makefile
> GZIP=gzip
> override KGZIP=$(GZIP) # optional overrdide. Used to force GZIP value
>                        # in case: make KGZIP=test
>
> unexport GZIP


The command line option is really strong,
so you cannot negate it by 'unexport GZIP'.

override GZIP :=

does not work either in sub-make.





> export KGZIP
>
> default:
>         @env | grep GZIP
>
> $ make GZIP=test
> KGZIP=test
>
> Thanks,
> Denis



-- 
Best Regards
Masahiro Yamada
