Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D638C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D6F2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585071124;
	bh=XrbSYSn0v2QhTqwv1gzwq0TtnL+FkC0EuEseXdyHrsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=m20B24+7E4SMJ+dCE+PmlqmlEnvYrQmvog+C+QoDZoDI1wLV/sboIcfOj/9bCv+pe
	 2GGJTQflfZxvZzCw17hWydGh2bj0BSXn9fdge4pIbGRYHKBpUZjU36QOl3biix5PPX
	 8JLXlLH9tX9HNT0kagrh6XgTQ2AN6lbCeD5xbqKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgCXRcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:32:04 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:17456 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgCXRcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:32:03 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 02OHVt37003399
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 02:31:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 02OHVt37003399
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585071116;
        bh=Xv8QceqshOBI8Wr/8hADstw0UzLndq6ibetmQTGIu8I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rBHjS74fHmi/Vsm1h/jZTJ/r+lq/RoOin2H83K6lnhfLB+EvFunVyhfDRBbXSNmXX
         MXbrywVuxK115JT2wWQ7iy/U8JOFC636+SeO04NanX7qTIhGv0AOt2IxD3sclyd+Bj
         79lPEEamP6SZ+o6TaQVIuSofw8L4oGjGu49+MqWXTtjjuLrRY/AyhSagT4TZwvlsji
         aWLB4iFbJVqESFaI+h1FxEM2FVi0SK2VylGWmhQhBBe8cj2SuzQxnUE+2bSuiDJMI1
         +LNeCkvlTo7RuDx2Z+qJ18+It0TsbbWlWIblF+u2gKljbq0mraGcyNJLtoAgOMlIwW
         7RFilgyEO5oAg==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id a63so11676607vsa.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 10:31:55 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1tnvDuGcYySRJzu22Bo62YSFGZL0RTBgOwZ2LuyB3zWJnT7ltK
        0gb+vF8WEyNaub9lZsnParIf9vocDpFhABPLVqU=
X-Google-Smtp-Source: ADFU+vvZ4VMG/RJoeev3JBg2YB1M2xw2PQqyKfmIWy/xpuE7SXvDI/xFaoI/Pm2UPP2WO22YHwWuYtwLBDy7b6AZvu0=
X-Received: by 2002:a67:33cb:: with SMTP id z194mr21777249vsz.155.1585071114650;
 Tue, 24 Mar 2020 10:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook> <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan> <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic> <20200323204454.GA2611336@zx2c4.com>
 <202003231350.7D35351@keescook> <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
 <CAK7LNARDb4SmQ2Y94CHAzP2qh_Ju7pu-w7kb0XKdP=2P-T+njQ@mail.gmail.com> <20200324153847.GA2870597@rani.riverdale.lan>
In-Reply-To: <20200324153847.GA2870597@rani.riverdale.lan>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 25 Mar 2020 02:31:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQeeUt6L7xkk2UHE3v6b0e+iD1cx6_JSrZKEYxt2bEhHQ@mail.gmail.com>
Message-ID: <CAK7LNAQeeUt6L7xkk2UHE3v6b0e+iD1cx6_JSrZKEYxt2bEhHQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
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

On Wed, Mar 25, 2020 at 12:38 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Mar 24, 2020 at 06:12:01PM +0900, Masahiro Yamada wrote:
> > On Tue, Mar 24, 2020 at 6:02 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > Hi.
> > >
> > >
> > >
> > > On Tue, Mar 24, 2020 at 5:51 AM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Mon, Mar 23, 2020 at 02:44:54PM -0600, Jason A. Donenfeld wrote:
> > > > > On Mon, Mar 16, 2020 at 05:02:59PM +0100, Borislav Petkov wrote:
> > > > > > Long overdue patch, see below.
> > > > > >
> > > > > > Plan is to queue it after 5.7-rc1.
> > > > > >
> > > > > > ---
> > > > > > From: Borislav Petkov <bp@suse.de>
> > > > > > Date: Mon, 16 Mar 2020 16:28:36 +0100
> > > > > > Subject: [PATCH] Documentation/changes: Raise minimum supported binutilsa version to 2.23
> > > > > >
> > > > > > The currently minimum-supported binutils version 2.21 has the problem of
> > > > > > promoting symbols which are defined outside of a section into absolute.
> > > > > > According to Arvind:
> > > > > >
> > > > > >   binutils-2.21 and -2.22. An x86-64 defconfig will fail with
> > > > > >           Invalid absolute R_X86_64_32S relocation: _etext
> > > > > >   and after fixing that one, with
> > > > > >           Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve
> > > > > >
> > > > > > Those two versions of binutils have a bug when it comes to handling
> > > > > > symbols defined outside of a section and binutils 2.23 has the proper
> > > > > > fix, see: https://sourceware.org/legacy-ml/binutils/2012-06/msg00155.html
> >
> >
> > This seems to be also related to
> > 7883a14339299773b2ce08dcfd97c63c199a9289
> >
> >
> > I had noticed the symbol "_text"
> > was absolute on binutils <= 2.22,
> > but I was not sure whether it was a bug of the tool.
> >
> > I applied the fix.
> > Perhaps, it was unneeded given that
> > we require the binutils 2.23
> >
>
> Which architecture? x86 at least doesn't even build with <= 2.22, but
> adding workarounds for that shows _text as section-relative (T in nm
> output).


The reporter found this for PowerPC,
but I think this could happen on any architecture.

https://patchwork.kernel.org/patch/11430243/




-- 
Best Regards
Masahiro Yamada
