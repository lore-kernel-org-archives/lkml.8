Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2B1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F4F22B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1JMhs8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHEUMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgHEQZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:25:34 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855FFC008699
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 07:36:27 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id y30so1079306ooj.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nPbiD7579GQktE8TnDJJA8yObifQYqFq9LVQt+NlZPM=;
        b=j1JMhs8VF3wjt1nwB/Qsiv0ydH2tqGRaF1GcVJl46CVK+YD01QsJrivwalAX8mS8mv
         /RRjM2DTAEvgzCtjf8pgBhHBVDI1cc2YgBtq6kom614haN8nsoAd3RTdL0V4p4aiRzrk
         5a5EQ4wgp0vo2n4Th0XOCcRN7yYGPRLFrncAvHzkDrEHoglLdZAL/YfDPQdVgoZCkeXT
         toq/zJ4Hq7pObJEa43WDdAC90IfisfI/wvAWFTXh8S8Ol1u0oUkWNBmlijEwyiV7ETDa
         EwSHx8+t86PBrYjFJQpxiWZsD7/rodDUxa2UysziH0yYvl2O8lS22aFV0QFsaeA/7Eq9
         C8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPbiD7579GQktE8TnDJJA8yObifQYqFq9LVQt+NlZPM=;
        b=RaUVYW7MA7tDVYjvL9IMgrQYDRpfR61ntvWe/l27EnSO3KpUJ00xNEQaP7UVR0UkJB
         cdBwbqBEd5d86JsfMLAQIomc9LNxGYWPANUMCLIgve5DKDlWw0s1uSprX2dy8HvDsi3F
         HjXDQms0PpVTlK9x1s0+or4wKrME4lTxgxh08grs5PoPr2ke5OKEvGN0TObEHuirjsnW
         Zb2d/DY1bXgK5NAf9+n4R94d/vf13AOYA8HEBAwnOkxedT6MrxemH7WftHnp0hwD76N8
         Bku1bYtb3eRWWGSTtvZb3zwZvwPB/WkBJDGv46+UQXK7zuoIBx2UAFM7ea3KQkwuCYpg
         ssuA==
X-Gm-Message-State: AOAM5303gJa65K9SQKMKAqx9+sAH5dnQf4r6TJRGC7WF5gS6Kx78VmRk
        hEN1NMs5FW7MTIBhd37i6UcKvGC74cBIxNrj+dVW1g==
X-Google-Smtp-Source: ABdhPJxMzLOWa7F8Ni9O5ai9UfWVloGBmzgxOW+Ubvorq0N6/RoaB4RRoAJ2OdW+axpD7TDExO6ShjGWfvykIItKRPQ=
X-Received: by 2002:a4a:a648:: with SMTP id j8mr3132445oom.36.1596638185370;
 Wed, 05 Aug 2020 07:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007d3b2d05ac1c303e@google.com> <20200805132629.GA87338@elver.google.com>
 <20200805134232.GR2674@hirez.programming.kicks-ass.net> <20200805135940.GA156343@elver.google.com>
 <20200805141237.GS2674@hirez.programming.kicks-ass.net> <20200805141709.GD35926@hirez.programming.kicks-ass.net>
In-Reply-To: <20200805141709.GD35926@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 5 Aug 2020 16:36:12 +0200
Message-ID: <CANpmjNN6FWZ+MsAn3Pj+WEez97diHzqF8hjONtHG15C2gSpSgw@mail.gmail.com>
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

On Wed, 5 Aug 2020 at 16:17, <peterz@infradead.org> wrote:
>
> On Wed, Aug 05, 2020 at 04:12:37PM +0200, peterz@infradead.org wrote:
> > On Wed, Aug 05, 2020 at 03:59:40PM +0200, Marco Elver wrote:
> > > On Wed, Aug 05, 2020 at 03:42PM +0200, peterz@infradead.org wrote:
> >
> > > > Shouldn't we __always_inline those? They're going to be really small.
> > >
> > > I can send a v2, and you can choose. For reference, though:
> > >
> > >     ffffffff86271ee0 <arch_local_save_flags>:
> > >     ffffffff86271ee0:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> > >     ffffffff86271ee5:       48 83 3d 43 87 e4 01    cmpq   $0x0,0x1e48743(%rip)        # ffffffff880ba630 <pv_ops+0x120>
> > >     ffffffff86271eec:       00
> > >     ffffffff86271eed:       74 0d                   je     ffffffff86271efc <arch_local_save_flags+0x1c>
> > >     ffffffff86271eef:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> > >     ffffffff86271ef4:       ff 14 25 30 a6 0b 88    callq  *0xffffffff880ba630
> > >     ffffffff86271efb:       c3                      retq
> > >     ffffffff86271efc:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> > >     ffffffff86271f01:       0f 0b                   ud2
> >
> > >     ffffffff86271a90 <arch_local_irq_restore>:
> > >     ffffffff86271a90:       53                      push   %rbx
> > >     ffffffff86271a91:       48 89 fb                mov    %rdi,%rbx
> > >     ffffffff86271a94:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> > >     ffffffff86271a99:       48 83 3d 97 8b e4 01    cmpq   $0x0,0x1e48b97(%rip)        # ffffffff880ba638 <pv_ops+0x128>
> > >     ffffffff86271aa0:       00
> > >     ffffffff86271aa1:       74 11                   je     ffffffff86271ab4 <arch_local_irq_restore+0x24>
> > >     ffffffff86271aa3:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> > >     ffffffff86271aa8:       48 89 df                mov    %rbx,%rdi
> > >     ffffffff86271aab:       ff 14 25 38 a6 0b 88    callq  *0xffffffff880ba638
> > >     ffffffff86271ab2:       5b                      pop    %rbx
> > >     ffffffff86271ab3:       c3                      retq
> > >     ffffffff86271ab4:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> > >     ffffffff86271ab9:       0f 0b                   ud2
> >
> >
> > Blergh, that's abysmall. In part I suspect because you have
> > CONFIG_PARAVIRT_DEBUG, let me try and untangle that PV macro maze.
>
> Yeah, look here:
>
> 0000 0000000000462149 <arch_local_save_flags>:
> 0000   462149:  ff 14 25 00 00 00 00    callq  *0x0
> 0003                    46214c: R_X86_64_32S    pv_ops+0x120
> 0007   462150:  c3                      retq
>
>
> That's exactly what I was expecting.

Ah, for some reason the __always_inline version does *not* work with
KCSAN -- I'm getting various warnings, including the same lockdep
warning. I think there is some weirdness when this stuff gets inlined
into instrumented functions. At least with KCSAN, when any accesses
here are instrumented, and then KCSAN disable/enables interrupts,
things break. So, these functions should never be instrumented,
noinstr or not. Marking them 'inline noinstr' seems like the safest
option. Without CONFIG_PARAVIRT_DEBUG, any compiler should hopefully
inline them?

Thanks,
-- Marco
