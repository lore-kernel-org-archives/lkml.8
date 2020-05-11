Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D5DC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84DDD206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JoL4nZBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgEKNTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725993AbgEKNTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:19:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4FFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:19:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id s9so7490212lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSnS7Ie9UNZzxFtT0FPY3YdLhDlPLgdcToB0TW/eJg0=;
        b=JoL4nZBSDZztmVrBLOHK7hCH/R93C83xJ8g+4nQTwPOC3pvybxZKQ8jDzL/Pn16UcC
         OW7PpuAjZBExsCIE+cfPrBJzeJ9eUTgpr0IQ3gr6sDH+92v8UvMCjopEW4ZpS2RqphXg
         iPp0tSNcmMHyze+geUPBeMLreZgMirsjuT/SqkTLn1y3vp4o3eBmRcRtM1T83uhc/mtm
         guoHXI4v33wpgxZKoXEPQ+eNT7mYyrcySBEftYTouad+MGWtGH5KUOjk40cFiFpRbgZZ
         6sLaDQtaimgVJHNxtMXqUTtZ2JFeBldWgk8jbSc841TWeU8KfzOLVpG5B9c0JtwOHg+d
         4vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSnS7Ie9UNZzxFtT0FPY3YdLhDlPLgdcToB0TW/eJg0=;
        b=qry2b2RYot4k2SFxEQWXadnc+7tjcnR92LQhgFtDmITksKq57F9nfC4CpyuUg+F/VP
         +RBALZu74CohdMr+rRgax1JHNymapt7LNzsY63FItwUIH59a8EbtS4lB4RZ2HFzddUSU
         0kvMyPUxJ1JHu5ZdxQhbQRLHCIShCvEYRbzZ1z9slRflliplY86lZdhc8cKxUf9OU/De
         xp648uEK61N9ka4Hp7NHc1bLUPjWvhrYlhNQFMG9uslvYtnQDEl4lDGAL66cjc+keb3S
         2omfl1AH4G8MKwCD5WBlLx9cZu3Nv3AXwaY+g7AOv591m+phAhxKyi87mm8o9r3tnQ//
         UnCw==
X-Gm-Message-State: AOAM53172NAU1f8prI+gr4V9Qgtx3YjdpKhHcgc9OD5T74PUot+OXm8m
        OBpFmg9lLChG+VPCOI06SoYDf61OPUtgwpIu3lK5aA==
X-Google-Smtp-Source: ABdhPJyVUXYypgLE/nyWeGyB9xDhwePfsjNO0riSZ2z4h3PL0zyZXlon+1CQvNGe8A8LtGcrB1RK4hdWU7Ds8+ea4Mc=
X-Received: by 2002:a19:c6c1:: with SMTP id w184mr11135402lff.20.1589203147183;
 Mon, 11 May 2020 06:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200505115420.18765-1-anders.roxell@linaro.org> <CAK7LNAR6MeBRhP1A3oc-UVATNN4r2Ru1LUp2=DqiLSKDL9gwOQ@mail.gmail.com>
In-Reply-To: <CAK7LNAR6MeBRhP1A3oc-UVATNN4r2Ru1LUp2=DqiLSKDL9gwOQ@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 11 May 2020 15:18:56 +0200
Message-ID: <CADYN=9+MZyCHdp2VbBCjk4u9zVaSXYe6vWwyFa6cy5GOA+-a8w@mail.gmail.com>
Subject: Re: [PATCH] scripts: fix deprecated always and hostprogs-y
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 at 20:36, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, May 5, 2020 at 8:54 PM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > When I did an allmodconfig build the following warning showed up:
> >
> > scripts/Makefile.lib:8: 'always' is deprecated. Please use 'always-y' instead
> > scripts/Makefile.lib:12: 'hostprogs-y' and 'hostprogs-m' are deprecated. Please use 'hostprogs' instead
> >
> > Rework to use the new 'always-y' and 'hostprogs'.
> >
> > Fixes: ee066c3ddf7b ("kbuild: warn if always, hostprogs-y, or hostprogs-m is used")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
>
> As Stephen Rothwell reported
> (https://lkml.org/lkml/2020/5/3/392),
> this warning appears by merging the
> two different trees.

Right, I see.

>
>
> You sent this patch to the kbuild maintainers,
> but samples/watch_queue/Makefile does not exist
> in the kbuild tree.

oops, I'm sorry.

>
>
> Also, please drop the fixes tag.

I will.

> The commit hash might change.
>
>
> > ---
> >  samples/watch_queue/Makefile | 4 ++--
> >  scripts/Makefile.build       | 1 -
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/samples/watch_queue/Makefile b/samples/watch_queue/Makefile
> > index eec00dd0a8df..8511fb6c53d2 100644
> > --- a/samples/watch_queue/Makefile
> > +++ b/samples/watch_queue/Makefile
> > @@ -1,7 +1,7 @@
> >  # List of programs to build
> > -hostprogs-y := watch_test
> > +hostprogs := watch_test
> >
> >  # Tell kbuild to always build the programs
> > -always := $(hostprogs-y)
> > +always-y := $(hostprogs)
> >
> >  HOSTCFLAGS_watch_test.o += -I$(objtree)/usr/include
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 3665b1a0bc8e..abdba70f33a1 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -15,7 +15,6 @@ obj-y :=
> >  obj-m :=
> >  lib-y :=
> >  lib-m :=
> > -always :=
> >  always-y :=
> >  always-m :=
> >  targets :=
>
>
> Why are you deleting 'always'?
> It would immediately break
> the downstream Makefiles immediately.

Thank you, you are correct.

I will send out a new patch shortly to the correct list.

Cheers,
Anders
