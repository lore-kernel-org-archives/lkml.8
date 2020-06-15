Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE0FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBDA20714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M8vn4Uj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgFOVrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFOVrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:47:40 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2F4C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:47:39 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id x93so12651713ede.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BB1YkDgb1TtnU58w4brmUgWlmXp8JC/Gj9BUjRlor2w=;
        b=M8vn4Uj3o+fAbFqq2rgvyL1/nkgmiNZTlDfMvhhD8Epkb+VDBJmLRHxsOlU+xgtiH6
         aITNkOMMWeUYAxhcoq+ax6wmOFOY3ZFDg8m/88bRYPJ72onvyoFvDtdTN0A3A0tClOAI
         QaRmjFCpdPfnyL80ZCTzIGyNeEz51cUVECO4TYW+7I3iE8hR/FvQrAzLXsiyMywz6Yv8
         FvlRDxEwceesr5mkofA46gic/5P4uZWqA//ddUZpi6h6ie7le3TTka5YcuDzzUuxbfm4
         TbCQPeyd2Br54RUWbM0RmtQeCk4rXZ61ZlSSC9hcvH7Tg2a+U8VtGFbU419QXqX+Bwqf
         B2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BB1YkDgb1TtnU58w4brmUgWlmXp8JC/Gj9BUjRlor2w=;
        b=XX3j+r3ErE+6qV9InrIJZOP2Z/aQNoyXvh4NF7KPPziLGc9jVGCm0iKTe94ZSgaWxO
         rVUiYR+Z3CjDJmuauH6aPCc8gKlmEYj8sGHkfEuEgjIS3/LDuJiYkO5yRhnKGzH302He
         7R79byKAigv8igSZHv31pBgXFMA2y+gnmpiv+07NRI3w1JKz3nbWR1UX/gaM2PGrBf+X
         eAJPpQhZiNqI39c+5GIzL0aEwjts8ro+yPu3ZKcohqao34adnJfJaNHOnmhzBdbm56bG
         nsrfLQOl2eE6Ygvgj+3LSJrqP9G4uRRr3TaLPxlcqxCi3G8+Q4zKJ0Z4FYPZFI105bDm
         OXrg==
X-Gm-Message-State: AOAM531eQyPG0plINNdcYnwQJCpPFHtImwVAKsQQIEXHwSK1/NHiQinB
        TfuEGWk7TXi+33m3lKFZUMeVGXF8LKnMRdmK0RLcWA==
X-Google-Smtp-Source: ABdhPJy+XsXVdspc9qVg5TDksYXAdSPQwBa788hmG6HcvWOIRktSF0I6TVfG+RbE2aiJL+Q4+mlwR4cePRzLuYV24UY=
X-Received: by 2002:a05:6402:1592:: with SMTP id c18mr27041367edv.40.1592257658022;
 Mon, 15 Jun 2020 14:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200521202716.193316-1-samitolvanen@google.com>
 <CAK7LNARq3g5vA6vy9449SHsKQmbwJrQDSBz4ZbH1pBEvPmusuA@mail.gmail.com>
 <CAK7LNASm2t-Dkr+p_EWvqf_eoKn5R2iXWuBHnTB9n6MUxr3-pQ@mail.gmail.com>
 <1590226253.lnkg0jun9x.astroid@bobo.none> <CAK7LNAR_-q3jhaUzDpkC3ej_DpAerzMsORT-tFw_3AwX7xM0Yw@mail.gmail.com>
In-Reply-To: <CAK7LNAR_-q3jhaUzDpkC3ej_DpAerzMsORT-tFw_3AwX7xM0Yw@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 15 Jun 2020 14:47:27 -0700
Message-ID: <CABCJKufaMU1z-s4S+dHhg0iCyVynLGwsFJgYnYyiBaR=mZt-8w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: reuse vmlinux.o in vmlinux_link
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 8:13 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi Nicholas,
> (+CC: Sam Ravnborg)
>
>
> On Sat, May 23, 2020 at 7:06 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Excerpts from Masahiro Yamada's message of May 23, 2020 3:44 am:
> > > + Michael, and PPC ML.
> > >
> > > They may know something about the reason of failure.
> >
> > Because the linker can't put branch stubs within object code sections,
> > so when you incrementally link them too large, the linker can't resolve
> > branches into other object files.
>
>
> Ah, you are right.
>
> So, this is a problem not only for PPC
> but also for ARM (both 32 and 64 bit), etc.
>
> ARM needs to insert a veneer to jump far.
>
> Prior to thin archive, we could not compile
> ARCH=arm allyesconfig because
> drivers/built-in.o was too large.
>
> This patch gets us back to the too large
> incremental object situation.
>
> With my quick compile-testing,
> ARCH=arm allyesconfig
> and ARCH=arm64 allyesconfig are broken.

Thanks for looking into this! Clang doesn't appear to have this issue
with LTO because it always enables both -ffunction-sections and
-fdata-sections. I confirmed that -ffunction-sections also fixes arm64
allyesconfig with this patch. While I'm fine with reusing vmlinux.o
only with LTO, how would you feel about enabling -ffunction-sections
in the kernel by default?

Sami
