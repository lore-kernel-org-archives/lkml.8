Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B999AC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9144720714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK5UM98Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgCXPiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:38:55 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46181 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgCXPiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:38:51 -0400
Received: by mail-qv1-f66.google.com with SMTP id m2so9390913qvu.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F+3p+/xcZiv6xilnEHl5U2W+xRkiW2C+XgoTd0APaos=;
        b=TK5UM98YXaYMxWjm94qtf9zo+Z7sDOl4IRl2oyMzGixx91hgeEgGnkRcVK1uJ6DWjE
         PxDrt7hVE01ZRhsvMth/jBBrsL2K9n2kbcaNEJosLOJVIzz0NmV2i3NFP+TKON/oLoj5
         CxoV8t5j4bbHRCtrU4f1sVvBJwQvr7kPqMJZKD6RWlXYVDCg7YnD4fMx4uDJbH+Z/n6A
         DfYF8C/rk7wJNIwouwWcqZgv72LZUt8/n2UInYZff0q2yb6WFTR8S9qLqKTggfR5OoXm
         ilKAFLeNHOhZUKKouzPufEQ1YvI+FnjgVxJ5C29I8/2NFQx1WxUYQRhmrZVbqC6FBRyw
         OWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=F+3p+/xcZiv6xilnEHl5U2W+xRkiW2C+XgoTd0APaos=;
        b=jkuCvEaFw+NB2DJSDUDtDkj/IZWNEG5lNzRbqubEirENJ4D3WdnZvDIsBxMNnFBW5A
         HroNdf7VydGHSqbncMkMc4904XiMrBUbvm3MRf1LBRD8mqEqwJFBCCKjB0TY4qhtvkrn
         HyGGJtxWm1hhA5YZIxR2WpNcdWZYvUPr5LgwEyNY+8T4usHVnLM43eq7rvkE6m9WFkeW
         9QUyH6eqEBItny/buN3UAD8KJgL9/C7YmqvpmOwyYNTrOpfFtKHMh9esTnl6FioDWqQG
         8kCF3ftz1DAC5SGpxgNlmrfDDxeSTFK6ytY9M3t/3QRAt5bw5s+FnBzAUweumYi1qJ9L
         kg1A==
X-Gm-Message-State: ANhLgQ168KtblMZBeidbx9CNIltAeOAhoajIs6bM6839tTsTf6oFeo0U
        YEksvFKJ+hXNiPEXc+2PsBNMyrJC
X-Google-Smtp-Source: ADFU+vsIZaPS9Kuuv6XaZh8mWcoCzWXQ7bjIXfbCq0k6R5Asm2Wmwa3KY3LZBGZamYelnm11Y4xPRQ==
X-Received: by 2002:a0c:fc03:: with SMTP id z3mr18986209qvo.210.1585064330702;
        Tue, 24 Mar 2020 08:38:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d2sm1796229qkl.98.2020.03.24.08.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 08:38:50 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 24 Mar 2020 11:38:48 -0400
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
Message-ID: <20200324153847.GA2870597@rani.riverdale.lan>
References: <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook>
 <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan>
 <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic>
 <20200323204454.GA2611336@zx2c4.com>
 <202003231350.7D35351@keescook>
 <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
 <CAK7LNARDb4SmQ2Y94CHAzP2qh_Ju7pu-w7kb0XKdP=2P-T+njQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNARDb4SmQ2Y94CHAzP2qh_Ju7pu-w7kb0XKdP=2P-T+njQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 06:12:01PM +0900, Masahiro Yamada wrote:
> On Tue, Mar 24, 2020 at 6:02 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Hi.
> >
> >
> >
> > On Tue, Mar 24, 2020 at 5:51 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Mon, Mar 23, 2020 at 02:44:54PM -0600, Jason A. Donenfeld wrote:
> > > > On Mon, Mar 16, 2020 at 05:02:59PM +0100, Borislav Petkov wrote:
> > > > > Long overdue patch, see below.
> > > > >
> > > > > Plan is to queue it after 5.7-rc1.
> > > > >
> > > > > ---
> > > > > From: Borislav Petkov <bp@suse.de>
> > > > > Date: Mon, 16 Mar 2020 16:28:36 +0100
> > > > > Subject: [PATCH] Documentation/changes: Raise minimum supported binutilsa version to 2.23
> > > > >
> > > > > The currently minimum-supported binutils version 2.21 has the problem of
> > > > > promoting symbols which are defined outside of a section into absolute.
> > > > > According to Arvind:
> > > > >
> > > > >   binutils-2.21 and -2.22. An x86-64 defconfig will fail with
> > > > >           Invalid absolute R_X86_64_32S relocation: _etext
> > > > >   and after fixing that one, with
> > > > >           Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve
> > > > >
> > > > > Those two versions of binutils have a bug when it comes to handling
> > > > > symbols defined outside of a section and binutils 2.23 has the proper
> > > > > fix, see: https://sourceware.org/legacy-ml/binutils/2012-06/msg00155.html
> 
> 
> This seems to be also related to
> 7883a14339299773b2ce08dcfd97c63c199a9289
> 
> 
> I had noticed the symbol "_text"
> was absolute on binutils <= 2.22,
> but I was not sure whether it was a bug of the tool.
> 
> I applied the fix.
> Perhaps, it was unneeded given that
> we require the binutils 2.23
> 

Which architecture? x86 at least doesn't even build with <= 2.22, but
adding workarounds for that shows _text as section-relative (T in nm
output).
