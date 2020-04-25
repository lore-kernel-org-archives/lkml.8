Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E91C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 18:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3470206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 18:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDYSiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 14:38:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:57374 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgDYSiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 14:38:14 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 03PIb3e7031547;
        Sat, 25 Apr 2020 13:37:03 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 03PIb15d031546;
        Sat, 25 Apr 2020 13:37:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 25 Apr 2020 13:37:01 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Jakub Jelinek <jakub@redhat.com>, jgross@suse.com,
        x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, Michael Matz <matz@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric_Pierret_=28fepitre=29?= 
        <frederic.pierret@qubes-os.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH] x86: Fix early boot crash on gcc-10, next try
Message-ID: <20200425183701.GE17645@gate.crashing.org>
References: <20200422192113.GG26846@zn.tnic> <CAKwvOdkbcO8RzoafON2mGiSy5P96P5+aY8GySysF2my7q+nTqw@mail.gmail.com> <20200422212605.GI26846@zn.tnic> <CAKwvOd=exxhfb8N6=1Q=wBUaYcRDEq3L1+TiHDLz+pxWg8OuwQ@mail.gmail.com> <20200423125300.GC26021@zn.tnic> <20200423161126.GD26021@zn.tnic> <20200425014657.GA2191784@rani.riverdale.lan> <20200425085759.GA24294@zn.tnic> <20200425150440.GA470719@rani.riverdale.lan> <20200425173140.GB24294@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425173140.GB24294@zn.tnic>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 07:31:40PM +0200, Borislav Petkov wrote:
> > There's also the one in init/main.c which is used by multiple
> > architectures. On x86 at least, the call to arch_call_rest_init at the
> > end of start_kernel does not get tail-call optimized by gcc-10, but I
> > don't see anything that actually prevents that from happening. We should
> > add the asm("") there as well I think, unless the compiler guys see
> > something about this function that will always prevent the optimization?
> 
> Hmm, that's what I was afraid of - having to sprinkle this around. Yah, let's
> wait for compiler guys to have a look here and then maybe I'll convert that
> thing to a macro called
> 
> 	compiler_prevent_tail_call_opt()
> 
> or so, so that it can be sprinkled around. ;-\

That is a lot more typing then
	asm("");
but more seriously, you probably should explain why you do not want a
tail call *anyway*, and in such a comment you can say that is what the
asm is for.

I don't see anything that prevents the tailcall in current code either,
fwiw.


Segher
