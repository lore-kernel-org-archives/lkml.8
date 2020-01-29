Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D560C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF27A214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgA2N0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:26:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:53592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgA2N0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:26:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E459DAC46;
        Wed, 29 Jan 2020 13:26:28 +0000 (UTC)
Date:   Wed, 29 Jan 2020 14:26:18 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
Message-ID: <20200129132618.GA30979@zn.tnic>
References: <20200128165906.GA67781@gmail.com>
 <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 12:06:53PM -0800, Linus Torvalds wrote:
> On Tue, Jan 28, 2020 at 11:51 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >         ALTERNATIVE_2 \
> >                 "cmp  $680, %rdx ; jb 3f ; cmpb %dil, %sil; je 4f", \
> >                 "movq %rdx, %rcx ; rep movsb; retq", X86_FEATURE_FSRM, \
> >                 "cmp $0x20, %rdx; jb 1f; movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS
> 
> Note the UNTESTED part.
> 
> In particular, I didn't check what the priority for the alternatives
> is. Since FSRM being set always implies ERMS being set too, it may be
> that the ERMS case is always picked with the above code.
> 
> So maybe the FSRM and ERMS lines need to be switched around, and
> somebody should add a comment to the ALTERNATIVE_2 macro about the
> priority rules for feature1 vs feature2 when both are set..
> 
> IOW, testing most definitely required for that patch suggestion of mine..

So what is there now before your patch is this (I've forced both
X86_FEATURE_FSRM and X86_FEATURE_ERMS on a BDW guest).

[    4.238160] apply_alternatives: feat: 18*32+4, old: (__memmove+0x17/0x1a0 (ffffffff817d90d7) len: 10), repl: (ffffffff8251dbbb, len: 0), pad: 0
[    4.239503] ffffffff817d90d7: old_insn: 48 83 fa 20 0f 82 f5 00 00 00

That's what in vmlinux:

ffffffff817d90d7:       48 83 fa 20             cmp $0x20,%rdx
ffffffff817d90db:       0f 82 f5 00 00 00       jb ffffffff817d91d6

which is 10 bytes.

It gets replaced to:

[    4.240194] ffffffff817d90d7: final_insn: 0f 1f 84 00 00 00 00 00 66 90

ffffffff817d90d7:       0f 1f 84 00 00 00 00    nopl 0x0(%rax,%rax,1)
ffffffff817d90de:       00
ffffffff817d90df:       66 90                   xchg %ax,%ax

I.e., NOPed out.

ERMS replaces the bytes *after* these 10 bytes, note the VA:

0xffffffff817d90d7 + 0xa = 0xffffffff817d90e1

[    4.240917] apply_alternatives: feat: 9*32+9, old: (__memmove+0x21/0x1a0 (ffffffff817d90e1) len: 6), repl: (ffffffff8251dbbb, len: 6), pad: 6
[    4.242209] ffffffff817d90e1: old_insn: 90 90 90 90 90 90
[    4.242823] ffffffff8251dbbb: rpl_insn: 48 89 d1 f3 a4 c3
[    4.243503] ffffffff817d90e1: final_insn: 48 89 d1 f3 a4 c3

which turns into

ffffffff817d90e1:       48 89 d1                mov %rdx,%rcx
ffffffff817d90e4:       f3 a4                   rep movsb %ds:(%rsi),%es:(%rdi)
ffffffff817d90e6:       c3                      retq

as expected.

And yes, your idea makes sense to use ALTERNATIVE_2 but as it is, it
triple-faults my guest. I'll debug it more later to find out why, when I
get a chance.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
