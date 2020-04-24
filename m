Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FCAC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E82420736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587692513;
	bh=UHl3f9KMN5Mp5iMxWneKGyf/iaA1jKo8Qh5hVET/Cr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eewS3DVLwOXB9KYk7zhFc6oNjqMep6858TdR8atITOTabodmwwvPAlOw0wRaS9mmf
	 4JjaQuAu6tzbL/hUw7S2d4lGnUeCf7NfRhcx5+wdeTe3CX9hh3xb/NLXaY82iixHUw
	 0hprlFZ0aKKopU2NmS36QYQSRF2/GAfDFrgnxnQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgDXBlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:41:52 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:44456 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgDXBlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 21:41:51 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 03O1fZLW015549
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:41:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 03O1fZLW015549
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587692496;
        bh=1SEaeJhyzWU9jqAsfWMzXzgCHVbK39e/WrbxIKUu+9Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zjP6/500g28HsFRys18oTDgIc5zqswWxubUWm5vAW6XbUYRbiAOAoTGUi607PAgaZ
         UHqR4PqJDMjbNCBxdP+N6iRPSLg1wgQLeJXiIE+5RbmoCewH/cMHABVXJpg6vfewbV
         kLDupuMG063b92KrY4bcHmJhiscmfHgGsv8ZYj+bNAZhjyczJwOrg0d8hRkYJ6IoI7
         by5pPFl1PargBRg1X1U6pq7PvjFu6yi0F2aKB5y9hK2bXAd5+pxvKXEYigqnF0bG+H
         JyOyKxRvlHuTWKRrFWlBXZEHHLSq+V1wAKp3EYYyJp0ai1Hrg07FEaGa2Y1GnlCro/
         PwMivZffezdwQ==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id f7so2326197vkl.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 18:41:36 -0700 (PDT)
X-Gm-Message-State: AGi0PuZK3gAWTbj3R6x7GwO7er3DN+yqMoIUeRgNzq+qrKgyXvcUt991
        du7NPgasdbudY5PLg0Y/2YVX9+7edbSGy8Y9m7U=
X-Google-Smtp-Source: APiQypJiQIUSipFhDNU2QSUU4sKY7y2xH1moEdr0+/BEit/iYa7pPZLaJvyceF6V1UOvqEW1T7uWgrOhfAhS9eLwumg=
X-Received: by 2002:a1f:3649:: with SMTP id d70mr5910043vka.12.1587692495242;
 Thu, 23 Apr 2020 18:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200419131947.173685-1-sedat.dilek@gmail.com> <CAKwvOd=Rt0q0+nRJasc8GzOXSj1_-jZGNc2bAWJkmd7Vzr8FFw@mail.gmail.com>
In-Reply-To: <CAKwvOd=Rt0q0+nRJasc8GzOXSj1_-jZGNc2bAWJkmd7Vzr8FFw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 24 Apr 2020 10:40:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQzh8EajBkXSSgFh2=5iF38XvkADf1C7J0JnwTov=NmNQ@mail.gmail.com>
Message-ID: <CAK7LNAQzh8EajBkXSSgFh2=5iF38XvkADf1C7J0JnwTov=NmNQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] kbuild: add CONFIG_LD_IS_BINUTILS
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 3:44 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Apr 19, 2020 at 6:19 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > This patch is currently not mandatory but a prerequisites for the second one.
> >
> > Folks from ClangBuiltLinux project like the combination of Clang compiler
> > and LLD linker from LLVM project to build their Linux kernels.
> >
> > Sami Tolvanen <samitolvanen@google.com> has a patch for using LD_IS_LLD (see [1]).
> >
> > Documentation/process/changes.rst says and uses "binutils" that's why I called
> > it LD_IS_BINUTILS (see [2] and [3]).
> >
> > The second patch will rename existing LD_VERSION to BINUTILS_VERSION to have
> > a consistent naming convention like:
> >
> > 1. CC_IS_GCC and GCC_VERSION
> > 2. CC_IS_CLANG and CLANG_VERSION
> > 3. LD_IS_BINUTILS and BINUTILS_VERSION
> >
> > [1] https://github.com/samitolvanen/linux/commit/61889e01f0ed4f07a9d631f163bba6c6637bfa46
> > [2] https://git.kernel.org/linus/tree/Documentation/process/changes.rst#n34
> > [3] https://git.kernel.org/linus/tree/Documentation/process/changes.rst#n76
> >
> > Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
>
> Just some background on Sami's patch.  Originally we were using
> ld.gold (for LTO for Pixel 3) before moving to ld.lld (for LTO for
> Pixel 4 and later).  Not sure if Kconfig would be a better place to
> check if gold is used, then warn?  I kind of prefer the distinction
> that binutils contains two different linkers, though if no one is
> supporting ld.gold, and it doesn't work for the kernel, then maybe
> that preference is moot?


I prefer LD_IS_BFD, like this patch:
https://lore.kernel.org/patchwork/patch/1039719/

We do not need LD_IS_GOLD, though.




-- 
Best Regards
Masahiro Yamada
