Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C47C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CD1206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgA3Ivr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:51:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:56308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbgA3Ivr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:51:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4EBC2ACCA;
        Thu, 30 Jan 2020 08:51:43 +0000 (UTC)
Date:   Thu, 30 Jan 2020 09:51:34 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
Message-ID: <20200130085134.GB6684@zn.tnic>
References: <20200128165906.GA67781@gmail.com>
 <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <20200129132618.GA30979@zn.tnic>
 <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
 <20200129183404.GB30979@zn.tnic>
 <CAHk-=wh62anGKKEeey8ubD+-+3qSv059z7zSWZ4J=CoaOo4j_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh62anGKKEeey8ubD+-+3qSv059z7zSWZ4J=CoaOo4j_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 10:56:43AM -0800, Linus Torvalds wrote:
> Ahh, yeah, good spotting.
> 
> And I wonder if we should just make that
> 
>         movq %rdx, %rcx
> 
> unconditional, because all the cases basically want it anyway (the
> "label 4" case does it after the jump).
> 
> It might even make sense to move it to the top of __memmove, depending
> on how well those early instructions decode.

Yah, that makes sense and it kinda works but let me sanity-check whether
what we're doing is still worth our time.

In one of my previous mails:

https://lkml.kernel.org/r/20200129132618.GA30979@zn.tnic

I showed that the total length of instructions we're talking about here
is 10 + 6 = 16 bytes.

The current version I have ATM (with "mov %rdx, %rcx" hoisted up in the
function):

        ALTERNATIVE_2 \
                "cmp $0x20, %rdx; jb 1f; cmp $680, %rdx; jb 3f; cmpb %dil, %sil; je 4f", \
                "cmp $0x20, %rdx; jb 1f; rep movsb; retq", X86_FEATURE_ERMS, \
                "rep movsb; retq", X86_FEATURE_FSRM

has grown to:

[    4.182616] apply_alternatives: feat: 9*32+9, old: (__memmove+0x1a/0x1a0 (ffffffff817d90da) len: 24), repl: (ffffffff8251dbbb, len: 13), pad: 0
[    4.183915] ffffffff817d90da: old_insn: 48 83 fa 20 0f 82 f2 00 00 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 3e
[    4.184982] ffffffff8251dbbb: rpl_insn: 48 83 fa 20 0f 82 11 b6 2b ff f3 a4 c3
[    4.185801] ffffffff817d90da: final_insn: 48 83 fa 20 0f 82 11 b6 2b ff f3 a4 c3 0f 1f 84 00 00 00 00 00 0f 1f 00

The default case is the longest:

ffffffff817d90da:       48 83 fa 20             cmp $0x20,%rdx
ffffffff817d90de:       0f 82 11 b6 2b ff       jb ffffffff80a946f5
ffffffff817d90e4:       f3 a4                   rep movsb %ds:(%rsi),%es:(%rdi)
ffffffff817d90e6:       c3                      retq 
ffffffff817d90e7:       0f 1f 84 00 00 00 00    nopl 0x0(%rax,%rax,1)
ffffffff817d90ee:       00 
ffffffff817d90ef:       0f 1f 00                nopl (%rax)

24 bytes which is already 8 bytes more.

The only argument I see for this is readability as the single
ALTERNATIVE_2 statement shows straight-forward what gets replaced where.
VS as it is right now needs a bit more staring.

However, this new version has hit another shortcoming of the
alternatives - check this out:

So I enabled only X86_FEATURE_ERMS in my guest first to see how

        ALTERNATIVE_2 \
                "cmp $0x20, %rdx; jb 1f; cmp $680, %rdx; jb 3f; cmpb %dil, %sil; je 4f", \
                "cmp $0x20, %rdx; jb 1f; rep movsb; retq", X86_FEATURE_ERMS, \
^^^^^^^^^^^^^^^^^^^^^

that line would work.

                "rep movsb; retq", X86_FEATURE_FSRM

And it exploded, see the end of this mail. Stopping right before
widen_string() showed me this:

We call memmove with:

rdx            0x1      1
rsi            0xffffffff82543b62       -2108408990
rdi            0xffffffff82543b65       -2108408987

i.e., length is only one.

We run into

	"cmp $0x20, %rdx; jb 1f; rep movsb; retq"

and now look how that "jb 1f" looks in gdb:

...
rip            0xffffffff817d90de       0xffffffff817d90de <memmove+30>
...

=> 0xffffffff817d90de <memmove+30>:     jb     0xffffffff80a946f5
0xffffc90000013c48:     0xffffffff817cfee8      0xffffc90000013da8
0xffffc90000013c58:     0xffffffff82543f40      0xffffffff81eefabe
0xffffc90000013c68:     0xffffffff817d0306      0xffffffff82543b62
0xffffc90000013c78:     0xffffffff82543b62      0xffffffff82543f40
0xffffc90000013c88:     0xffffffff81eb892b      0xffffffff817d2f36
Dump of assembler code from 0xffffffff817d90de to 0xffffffff817d90f2:
=> 0xffffffff817d90de <memmove+30>:     0f 82 11 b6 2b ff       jb     0xffffffff80a946f5
   0xffffffff817d90e4 <memmove+36>:     f3 a4   rep movsb %ds:(%rsi),%es:(%rdi)
   0xffffffff817d90e6 <memmove+38>:     c3      retq   
   0xffffffff817d90e7 <memmove+39>:     0f 1f 84 00 00 00 00 00 nopl   0x0(%rax,%rax,1)
   0xffffffff817d90ef <memmove+47>:     0f 1f 00        nopl   (%rax)

RIP is 0xffffffff817d90de but the JMP absolute target is
0xffffffff80a946f5. And that's waaaay off. And then it dawned on me -
apply_alternatives() only fixes jumps when they're the first byte of the
replacement:

                if (a->replacementlen && is_jmp(replacement[0]))
                        recompute_jump(a, instr, replacement, insn_buff);

and otherwise the JMPs are wrong in .altinstr_replacement as there
they're relative to the next RIP of the insn there:

ffffffff8251dbbb:       48 83 fa 20             cmp    $0x20,%rdx
ffffffff8251dbbf:       0f 82 11 b6 2b ff       jb     ffffffff817d91d6 <__memmove+0x116>

i.e., that offset is from *this* section to the place where __memmove is
and hasn't been fixed up.

And this whole deal has popped up in the past but we've never decided
that it is worth implementing proper insn parsing in the alternatives so
that only the correct insn bytes which are jumps, get to be recomputed.

So I can put it on my TODO to fix that but it would require more staring
and experimenting before we can have JMP insns in arbitrary places in
the insn replacement. The good thing is we have an insn decoder in the
kernel now so using that should be relatively easy.

Question is, do we really need it?

Thoughts?

[    4.391913] BUG: unable to handle page fault for address: ffffffff80a946f5
[    4.391913] #PF: supervisor instruction fetch in kernel mode
[    4.391913] #PF: error_code(0x0010) - not-present page
[    4.391913] PGD 200a067 P4D 200a067 PUD 200b063 PMD 0 
[    4.391913] Oops: 0010 [#1] PREEMPT SMP
[    4.391913] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0+ #19
[    4.391913] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[    4.391913] RIP: 0010:0xffffffff80a946f5
[    4.391913] Code: Bad RIP value.
[    4.391913] RSP: 0000:ffffc90000013c48 EFLAGS: 00010087
[    4.391913] RAX: ffffffff82543b65 RBX: 0000000000000003 RCX: 0000000000000001
[    4.391913] RDX: 0000000000000001 RSI: ffffffff82543b62 RDI: ffffffff82543b65
[    4.391913] RBP: ffffffff82543b62 R08: ffffffff82543b63 R09: 0000000000000001
[    4.391913] R10: ffffffff82543f40 R11: 0000000082543b61 R12: ffffffff82543b63
[    4.391913] R13: ffff0a0000000404 R14: 00000000000003e0 R15: ffffffff81eb892b
[    4.391913] FS:  0000000000000000(0000) GS:ffff88807da00000(0000) knlGS:0000000000000000
[    4.391913] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.391913] CR2: ffffffff80a946cb CR3: 0000000002009000 CR4: 00000000003406f0
[    4.391913] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    4.391913] DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
[    4.391913] Call Trace:
[    4.391913]  ? widen_string+0x98/0xb0
[    4.391913]  ? string+0x56/0x60
[    4.391913]  ? vsnprintf+0x256/0x4f0
[    4.391913]  ? vscnprintf+0x9/0x30
[    4.391913]  ? vprintk_store+0x4c/0x220
[    4.391913]  ? vprintk_emit+0x114/0x2b0
[    4.391913]  ? printk+0x48/0x4a
[    4.391913]  ? native_cpu_up.cold+0x9e/0xd4
[    4.391913]  ? cpus_read_trylock+0x50/0x50
[    4.391913]  ? bringup_cpu+0x3c/0x100
[    4.391913]  ? cpuhp_invoke_callback+0x95/0x5f0
[    4.391913]  ? _cpu_up+0xa4/0x140
[    4.391913]  ? do_cpu_up+0xa8/0xb0
[    4.391913]  ? smp_init+0x58/0xac
[    4.391913]  ? kernel_init_freeable+0xa0/0x183
[    4.391913]  ? rest_init+0xb9/0xb9
[    4.391913]  ? kernel_init+0xa/0xf7
[    4.391913]  ? ret_from_fork+0x35/0x40
[    4.391913] Modules linked in:
[    4.391913] CR2: ffffffff80a946f5
[    4.391913] ---[ end trace 2d921178836b2f4d ]---
[    4.391913] RIP: 0010:0xffffffff80a946f5
[    4.391913] Code: Bad RIP value.
[    4.391913] RSP: 0000:ffffc90000013c48 EFLAGS: 00010087
[    4.391913] RAX: ffffffff82543b65 RBX: 0000000000000003 RCX: 0000000000000001
[    4.391913] RDX: 0000000000000001 RSI: ffffffff82543b62 RDI: ffffffff82543b65
[    4.391913] RBP: ffffffff82543b62 R08: ffffffff82543b63 R09: 0000000000000001
[    4.391913] R10: ffffffff82543f40 R11: 0000000082543b61 R12: ffffffff82543b63
[    4.391913] R13: ffff0a0000000404 R14: 00000000000003e0 R15: ffffffff81eb892b
[    4.391913] FS:  0000000000000000(0000) GS:ffff88807da00000(0000) knlGS:0000000000000000
[    4.391913] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.391913] CR2: ffffffff80a946cb CR3: 0000000002009000 CR4: 00000000003406f0
[    4.391913] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    4.391913] DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
[    4.391913] note: swapper/0[1] exited with preempt_count 1
[    4.391913] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
