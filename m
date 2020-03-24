Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D37C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C58F2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585041169;
	bh=WZ77bB07ahHDFIxfI0N0EhNYsHG1t+Bp8ngw0FIPZDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PH5ToqIJ4c46NQzAlv0NDO2hM1Ogp8eFmHQIVRb3rYUN7gS9tKWMO+qOBD2nIbS6g
	 u8Y3Fp2R82wGuPMRmPGR/kaOQZKPnlytXO/+QxGTwdh5MWqW0oAaHVSGYADE4veugS
	 PSNGD8XJS5sI1WIPTswlQqK/Do06rwfB3NAxcrME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgCXJMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:12:48 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:21903 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgCXJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:12:48 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 02O9Cd40007119
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 18:12:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 02O9Cd40007119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585041159;
        bh=swDS97mEzML7M+UgdPS2qRvo+g9Z1BxodzvheYPexOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VXFqjHQUpXPnM3EbJTrh//kdquO34vop+pt+NH4INJf+F9mu6j/ATHRApSVQUlRQm
         BPl3+YRHAoKfJRlWRKwMxPSXpaXTAcMCFSUPnWGm5ld0W+BwYd3FsZpijan1XwPxJA
         ljsDK2cWC6GA8Mty60EhDjJDGMTLDyERjRZhK1dlODYm8IhoJq1A04BDdYf8afQfat
         LNg07S+gaevNcjvL/+IpnwSte9qxdDxOtrM4+wAb9uV9OBa0hbToZpnYoDcXEykazb
         Pmxa+NXsFxgn1g5qjBaiM8MRFSSUFYRCW4qaer0lM4uib8gcIUx+81MvH6sU9krzYl
         m374HH+iaQW5A==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id u11so715517vsg.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 02:12:39 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1qdfW/iUrATWLLPuis6UQCONlFLc4+Ta0vDgDycDXhHnrqG6yu
        kXha8n3T87lK97HjBpJgsc3pyXmbPwEU2Hu6Odk=
X-Google-Smtp-Source: ADFU+vuE4DNCdSn6UWfz14oVMVXG4qgoUTYHKqZxfC5M7JxfwigwrK0PbzxrGqAixYqAa52fua5rFT9AxBsaYi7UWVA=
X-Received: by 2002:a67:8745:: with SMTP id j66mr17620480vsd.181.1585041158484;
 Tue, 24 Mar 2020 02:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200113161310.GA191743@rani.riverdale.lan> <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook> <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan> <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic> <20200323204454.GA2611336@zx2c4.com>
 <202003231350.7D35351@keescook> <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
In-Reply-To: <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 Mar 2020 18:12:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNARDb4SmQ2Y94CHAzP2qh_Ju7pu-w7kb0XKdP=2P-T+njQ@mail.gmail.com>
Message-ID: <CAK7LNARDb4SmQ2Y94CHAzP2qh_Ju7pu-w7kb0XKdP=2P-T+njQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
To:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
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

On Tue, Mar 24, 2020 at 6:02 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi.
>
>
>
> On Tue, Mar 24, 2020 at 5:51 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Mar 23, 2020 at 02:44:54PM -0600, Jason A. Donenfeld wrote:
> > > On Mon, Mar 16, 2020 at 05:02:59PM +0100, Borislav Petkov wrote:
> > > > Long overdue patch, see below.
> > > >
> > > > Plan is to queue it after 5.7-rc1.
> > > >
> > > > ---
> > > > From: Borislav Petkov <bp@suse.de>
> > > > Date: Mon, 16 Mar 2020 16:28:36 +0100
> > > > Subject: [PATCH] Documentation/changes: Raise minimum supported binutilsa version to 2.23
> > > >
> > > > The currently minimum-supported binutils version 2.21 has the problem of
> > > > promoting symbols which are defined outside of a section into absolute.
> > > > According to Arvind:
> > > >
> > > >   binutils-2.21 and -2.22. An x86-64 defconfig will fail with
> > > >           Invalid absolute R_X86_64_32S relocation: _etext
> > > >   and after fixing that one, with
> > > >           Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve
> > > >
> > > > Those two versions of binutils have a bug when it comes to handling
> > > > symbols defined outside of a section and binutils 2.23 has the proper
> > > > fix, see: https://sourceware.org/legacy-ml/binutils/2012-06/msg00155.html


This seems to be also related to
7883a14339299773b2ce08dcfd97c63c199a9289


I had noticed the symbol "_text"
was absolute on binutils <= 2.22,
but I was not sure whether it was a bug of the tool.

I applied the fix.
Perhaps, it was unneeded given that
we require the binutils 2.23





> > > >
> > > > Therefore, up to the fixed version directly, skipping the broken ones.
> > > >
> > > > Currently shipping distros already have the fixed binutils version so
> > > > there should be no breakage resulting from this.
> > > >
> > > > For more details about the whole thing, see the thread in Link.
> > >
> > > That sounds very good to me. Then we'll be able to use ADX instructions
> > > without ifdefs.
> > >
> > > Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >
> > Can you send these now and we can land in 5.7 with the doc change?
> >
> > -Kees
>
>
> Kees,
>
> I folded this patch into the following series (16 patches):
> https://lore.kernel.org/patchwork/project/lkml/list/?series=435391
>
> This patch (14/16) is a prerequisite for 15/16.
>
>
>
> Borislav,
>
> When I forwarded this patch, I fixed up one more line.
> (changes.rst duplicates the same information...)
>
> Please see this. I hope this should be OK.
> https://lore.kernel.org/patchwork/patch/1214519/
>
>
>
> > --
> > Kees Cook
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
