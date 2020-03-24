Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAD3C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714EF20775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585042891;
	bh=3afcWwst+W5PNQxjjXTCKuGiIHeDOoMCIbE1+Y9EAxA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FJOtS3bLzr/MH4sDh7vtiZ3Q5xvs1jjjyUjoKzaPNhxyUgyOsGAsvaxry1RaKGXr3
	 bxYoinKw98hO2ct4VaFz1GDWQNNWjFz89rvJlXrb6bNK7IiApXBMVHrt3n0aJYX/vj
	 tDw+Cg3W+Wr9idDw+PXWorRA4uSEF+Maf+ViDkyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgCXJla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:41:30 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:34157 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgCXJla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:41:30 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 02O9fLgg032455
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 18:41:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 02O9fLgg032455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585042882;
        bh=82BgOMSoaTDtOIOOtwd7fbpbY84K58yiAstJ896NIdc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OYAxlqJy7nn954mLzzfxgmAW3hKo6pBq5nI634Njtgqgoo8tpOYDlyHHX0Zgd4ICX
         uIjYrLmxNd4TEuyPHliEl9rvbgHDaQJojkyFlvIaqURWyoqLBMve2YA+DooAPFGiLm
         pk+FY9zLpEs6FG+KUR9bVnie2G1WXHsmGHUtWtRPBLTkHA4aHJy3TotDIRAR/TiQ+2
         Fxfjm43oPU90ycD0uSzPKKdLTj9HPwNr/U6kFxhHmEDfKK/WKp+4/8ULCBhmllfM+Z
         A3S8Hr224F40Jtdf3VzBPKhFvJNqGSgv5GJjvnnr9bSRR5v5Mn5aT3fa9IFV4Yevo9
         MU6P9CwXKHXNQ==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id n6so10716080vsc.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 02:41:22 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0gM5TXXeThZsAaIu9we1Ek4ulLKCyk8FbUVD0J7Yw0cH2QU7Rv
        qhAHdzVtyLP1aAKPJpBH6S1yoK86dg/9TutgnxE=
X-Google-Smtp-Source: ADFU+vvGbvure8KQmFyl8bvowVopMrrBg3plzS806cRmX33yAFXCtGaS6MbeXjAEgdJVECX0kR9Zakymvopx22Nv4Uw=
X-Received: by 2002:a67:2d55:: with SMTP id t82mr18517511vst.215.1585042880978;
 Tue, 24 Mar 2020 02:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200113161310.GA191743@rani.riverdale.lan> <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook> <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan> <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic> <20200323204454.GA2611336@zx2c4.com>
 <202003231350.7D35351@keescook> <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
 <20200324091437.GB22931@zn.tnic>
In-Reply-To: <20200324091437.GB22931@zn.tnic>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 Mar 2020 18:40:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNASyFuNfLsfTkttWjZFi-K_TKCQoEaFf45JKFo-FPwZy_w@mail.gmail.com>
Message-ID: <CAK7LNASyFuNfLsfTkttWjZFi-K_TKCQoEaFf45JKFo-FPwZy_w@mail.gmail.com>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 6:14 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Mar 24, 2020 at 06:02:02PM +0900, Masahiro Yamada wrote:
> > Borislav,
> >
> > When I forwarded this patch, I fixed up one more line.
> > (changes.rst duplicates the same information...)
> >
> > Please see this. I hope this should be OK.
> > https://lore.kernel.org/patchwork/patch/1214519/
>
> Thanks.
>
> However, I wanted to queue this patch *after* 5.7-rc1 and so that it
> lands in 5.8 and so that it has a maximum cycle in testing - well, it is
> not really testing but getting more people to see it and have the chance
> to complain - and not queue it now.
>
> I did some searching on distrowatch.com last night and the couple of
> distros shipping binutils 2.23 I saw, were already EOL but the search
> was not exhaustive.

OK, if we take time for this decision,
we can drop 14/16 and 15/16 for now.


> And from looking at your patchset, I think it should get the max time
> testing in linux-next too, so that we have time to address any build
> issues it might uncover.


Linus was positive to have this for 5.7
https://lkml.org/lkml/2020/3/21/262

I hope 01-13 will get merged for the next MW.
We still have a couple of weeks to test it in -next.




> IMO.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
Best Regards
Masahiro Yamada
