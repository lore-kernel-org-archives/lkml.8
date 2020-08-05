Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8FBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E272075D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ghcoPHMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgHETXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbgHERbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:31:20 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE37C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 10:31:20 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j7so23926882oij.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/ISdwGRB2GCE/7Xam1/dQaAy+/JGNh8/9LD5lfT6Q8=;
        b=ghcoPHMA4uw28WgOVzXRPP0CmnoExCjAxOo/7KmxGQsjS8zBNBAhAMXWxKfLFYlEDg
         32FCEyDWyRpnraHu8yP5qT6szaA6vANpE0TJ2lZkz+udUIHLqORuu6tzjUgpt1ZADOMO
         /vqB53nnWRUMh0ukvafMsEeOTfOP5ky5VJw/RAWqyVEa27dZFHxOBog2urmrHqb3fw0r
         F7u/hjaWxzcyXBDXXJc+jAKlLsVzcpzZ72geF7iTiRYzb84u9vAkxi7B2kpJ6PI/Xng1
         aCjYtkP89x85/C/aFifUNRBkQEQr80jm/p2ZXzqzIUsJiaLCDm1MuhlkPXDZC6zBtjlE
         jatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/ISdwGRB2GCE/7Xam1/dQaAy+/JGNh8/9LD5lfT6Q8=;
        b=JTlKq92U91r3Oo0J3g9ch4vimlHCWTcrHLb4sTXshHa/nVqDBdzsSfzFll/DpZQ+dZ
         IR5PeUv8/+fAYMyGFSyC47Tk2P3zXESHHeox4lwGzARmD0H9pixcGDryb1/jTaJb6bAE
         c4hDpPWMfn2DfZXAkeTVpUXcI2vwjM4LOFJ7VOEH4eMBeFkJfsu9eRd3qEcWOpbglnnt
         XnZQ6BA0b+DPmYGXw0pQaOKSsN6kREXYw6AGXrSog+5/iwxpDML483y0z13YVuqCB1Y9
         6u8bAO+V/L8vmyig1nT8aG/JHOSNBcmc3/7cWoXo1EVcH6sqiEYlZzOtA2Tn7HTwzbZy
         cLPQ==
X-Gm-Message-State: AOAM532dFPFDkwpkic3Oq50PfR54KVd+CqBdDTDjNjoctW4F1VD6JXWr
        VOzekPEPgLcbQBt2Edhege1pd8EEQxIehMzc+pNa9A==
X-Google-Smtp-Source: ABdhPJxiDkkic07fV/je3DdhbKQK5XhAfGjN5TMoqNesvJMpBh1CdI81IbcTegAoQDR7HPruFH4dXQnd4r8PoGavTmc=
X-Received: by 2002:aca:d4d5:: with SMTP id l204mr3765321oig.70.1596648678688;
 Wed, 05 Aug 2020 10:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007d3b2d05ac1c303e@google.com> <20200805132629.GA87338@elver.google.com>
 <20200805134232.GR2674@hirez.programming.kicks-ass.net> <20200805135940.GA156343@elver.google.com>
 <20200805141237.GS2674@hirez.programming.kicks-ass.net> <20200805141709.GD35926@hirez.programming.kicks-ass.net>
 <CANpmjNN6FWZ+MsAn3Pj+WEez97diHzqF8hjONtHG15C2gSpSgw@mail.gmail.com>
In-Reply-To: <CANpmjNN6FWZ+MsAn3Pj+WEez97diHzqF8hjONtHG15C2gSpSgw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 5 Aug 2020 19:31:07 +0200
Message-ID: <CANpmjNNy3XKQqgrjGPPKKvXhAoF=mae7dk8hmoS4k4oNnnB=KA@mail.gmail.com>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        fenghua.yu@intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, yu-cheng.yu@intel.com,
        jgross@suse.com, sdeep@vmware.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Aug 2020 at 16:36, Marco Elver <elver@google.com> wrote:
>
> On Wed, 5 Aug 2020 at 16:17, <peterz@infradead.org> wrote:
> >
> > On Wed, Aug 05, 2020 at 04:12:37PM +0200, peterz@infradead.org wrote:
> > > On Wed, Aug 05, 2020 at 03:59:40PM +0200, Marco Elver wrote:
> > > > On Wed, Aug 05, 2020 at 03:42PM +0200, peterz@infradead.org wrote:
> > >
> > > > > Shouldn't we __always_inline those? They're going to be really small.
> > > >
> > > > I can send a v2, and you can choose. For reference, though:
> > > >
> > > >     ffffffff86271ee0 <arch_local_save_flags>:
> > > >     ffffffff86271ee0:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> > > >     ffffffff86271ee5:       48 83 3d 43 87 e4 01    cmpq   $0x0,0x1e48743(%rip)        # ffffffff880ba630 <pv_ops+0x120>
> > > >     ffffffff86271eec:       00
> > > >     ffffffff86271eed:       74 0d                   je     ffffffff86271efc <arch_local_save_flags+0x1c>
> > > >     ffffffff86271eef:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> > > >     ffffffff86271ef4:       ff 14 25 30 a6 0b 88    callq  *0xffffffff880ba630
> > > >     ffffffff86271efb:       c3                      retq
> > > >     ffffffff86271efc:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> > > >     ffffffff86271f01:       0f 0b                   ud2
> > >
> > > >     ffffffff86271a90 <arch_local_irq_restore>:
> > > >     ffffffff86271a90:       53                      push   %rbx
> > > >     ffffffff86271a91:       48 89 fb                mov    %rdi,%rbx
> > > >     ffffffff86271a94:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> > > >     ffffffff86271a99:       48 83 3d 97 8b e4 01    cmpq   $0x0,0x1e48b97(%rip)        # ffffffff880ba638 <pv_ops+0x128>
> > > >     ffffffff86271aa0:       00
> > > >     ffffffff86271aa1:       74 11                   je     ffffffff86271ab4 <arch_local_irq_restore+0x24>
> > > >     ffffffff86271aa3:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> > > >     ffffffff86271aa8:       48 89 df                mov    %rbx,%rdi
> > > >     ffffffff86271aab:       ff 14 25 38 a6 0b 88    callq  *0xffffffff880ba638
> > > >     ffffffff86271ab2:       5b                      pop    %rbx
> > > >     ffffffff86271ab3:       c3                      retq
> > > >     ffffffff86271ab4:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> > > >     ffffffff86271ab9:       0f 0b                   ud2
> > >
> > >
> > > Blergh, that's abysmall. In part I suspect because you have
> > > CONFIG_PARAVIRT_DEBUG, let me try and untangle that PV macro maze.
> >
> > Yeah, look here:
> >
> > 0000 0000000000462149 <arch_local_save_flags>:
> > 0000   462149:  ff 14 25 00 00 00 00    callq  *0x0
> > 0003                    46214c: R_X86_64_32S    pv_ops+0x120
> > 0007   462150:  c3                      retq
> >
> >
> > That's exactly what I was expecting.
>
> Ah, for some reason the __always_inline version does *not* work with
> KCSAN -- I'm getting various warnings, including the same lockdep
> warning. I think there is some weirdness when this stuff gets inlined
> into instrumented functions. At least with KCSAN, when any accesses
> here are instrumented, and then KCSAN disable/enables interrupts,
> things break. So, these functions should never be instrumented,
> noinstr or not. Marking them 'inline noinstr' seems like the safest
> option. Without CONFIG_PARAVIRT_DEBUG, any compiler should hopefully
> inline them?

Oh well, it seems that KCSAN on syzbot still crashes even with this
"fix". It's harder to reproduce though, and I don't have a clear
reproducer other than "fuzz the kernel" right now. I think the new IRQ
state tracking code is still not compatible with KCSAN, even though we
thought it would be. Most likely there are still ways to get recursion
lockdep->KCSAN. An alternative would be to deal with the recursion
like we did before, instead of trying to squash all of it. I'll try to
investigate -- Peter, if you have ideas, help is appreciated.

Thanks,
-- Marco
