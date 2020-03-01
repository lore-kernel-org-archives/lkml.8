Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30F6C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 06:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7593214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 06:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6KF6AWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgCAGCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 01:02:45 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39335 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgCAGCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 01:02:45 -0500
Received: by mail-ot1-f67.google.com with SMTP id x97so6582887ota.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 22:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=msYhHKDbpsMG2w9mCj7lPOvJY1xEhuhsfntlq+bf8BA=;
        b=S6KF6AWqhizA52RVFitlfUgnJCq8dLJx7DthSeSj4bnsje1bmNs3gEFdh1d08vYuw0
         9tec+ZoPQpEHkPX6SltnyGlQYpspoMlpU9accakccfWD4HiCSq7pKR0wxGW0tDGYwLYn
         s9fLqtAjWgdIJz5xELuI2AkF5AyuYhhZXRcZ8HNTtFBnup2Gvf/1jhhrh5WtGM6cc+aa
         2f+9UFnaDP1I5sZuSynYSg+1s8l8I3kvvHk9Af/N75gUh3o80eHr0VxDxaqSZV5KZ8+1
         8iGqBcJ8e1veHbwZFNb7Nb35smkng3sWB8WkSKiW9OVffdd6iM6GWcPttOVFjsQgqQg5
         4Txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=msYhHKDbpsMG2w9mCj7lPOvJY1xEhuhsfntlq+bf8BA=;
        b=Dk4ZqQgMj1M/xzIOwpzAHys2LyOQVG1x0BPXy3Xwc3Mq+IoxEy19Wa0vyRwLY5qujD
         gbCZ0Xf63aa+35W7mWjyIt9J7wkqPwJ5mJPf5cSgJa6nT0dX9mfddWGMVAhcRYJIL0x6
         Cpv5YDk8UCnBWbrgicKVoVA0uQSn2cAIJrSKIm3WRGn5eEPhBnAHJXVYJ/1S7yQhkv4y
         jWVCKQrfCvIfuRB/cJ2eEoEEsxSvCYlF3JrtqueYrNZ9JomujjM0/wcXuDkotFPCAODI
         At8+9bXGqckypkvOefZ5tU4LjmjIYvLJdKpxs6fGOBB9QbCsVdeKRoRTtauTFTVjH8an
         7uMw==
X-Gm-Message-State: APjAAAWc0dPIkrJrkMDeB1j/kNqaXmbeH6AbazJPKeECxUDiNFJjLfEV
        0KkYoIqJKoDLAg5H8KZayeCTBTPQlKP4nzRIqjY43w==
X-Google-Smtp-Source: APXvYqxhEsdn3qe1Mk9llVRvWHZCP9VngVo2Sl/YFYMxg0VCASgpRMFpbPyP0CwM3z5XkqByrmUCQy4vbf9JZZ2uTyk=
X-Received: by 2002:a05:6830:20c2:: with SMTP id z2mr8550546otq.228.1583042561952;
 Sat, 29 Feb 2020 22:02:41 -0800 (PST)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Sun, 1 Mar 2020 07:02:15 +0100
Message-ID: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
Subject: x86 entry perf unwinding failure (missing IRET_REGS annotation on
 stack switch?)
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

With the latest kernel from Linus' tree (fb279f4e2386), on a box that
needs KPTI, as soon as I run "sudo <path>/perf top -g", I see this
warning (if I modify the unwinding code to use %px there instead of
%p):

[   83.716065] WARNING: stack recursion on stack type 4
[   83.716070] WARNING: can't dereference registers at
fffffe0000002190 for ip
swapgs_restore_regs_and_return_to_usermode+0x79/0x80

So apparently some ORC annotations are a bit off. I decided to write a
little helper script that can interleave "objtool orc dump" and
"objdump -d" output to make it easier for me to understand what's
going on; you can save it to tools/objtool and run it from there:

==============
#!/usr/bin/env python3
import subprocess
import sys
import re

objfile = sys.argv[1]

orc_dump = subprocess.run([sys.path[0]+'/objtool', 'orc', 'dump',
objfile], stdout=subprocess.PIPE).stdout.decode('utf-8')
orc_map = {}
for line in orc_dump.split('\n'):
  parts = line.split(': ', 1)
  if len(parts) != 2:
    continue
  orc_map[parts[0]] = parts[1]

objdump = subprocess.run(['objdump', '-d', objfile],
stdout=subprocess.PIPE).stdout.decode('utf-8')
cur_section = None
hex_re = re.compile('^[a-f0-9]+$')
for line in objdump.split('\n'):
  if line.startswith('Disassembly of section '):
    cur_section = line.split('of section ')[1].split(':')[0]
  if line.find(':') != -1:
    hex_prefix = line.split(':')[0].lstrip()
    if hex_re.match(hex_prefix):
      orc_val = orc_map.get(cur_section+'+'+hex_prefix)
      if orc_val != None:
        print('\033[92m#######' + orc_val + '\033[0m')
  print(line)
==============

swapgs_restore_regs_and_return_to_usermode+0x79/0x80 is offset 0xaa8
in the object file. Here's the interleaved assembly and ORC unwind
info (with ORC info appearing above the line it refers to):

==============
0000000000000a00 <common_interrupt>:
#######sp:sp+8 bp:(und) type:iret end:0
     a00: 48 83 04 24 80        addq   $0xffffffffffffff80,(%rsp)
     a05: e8 00 00 00 00        callq  a0a <common_interrupt+0xa>
#######sp:(sp+0) bp:(und) type:regs end:0
     a0a: e8 00 00 00 00        callq  a0f <ret_from_intr>

0000000000000a0f <ret_from_intr>:
     a0f: fa                    cli
     a10: 5c                    pop    %rsp
#######sp:sp+0 bp:(und) type:regs end:0
     a11: 65 ff 0c 25 00 00 00 decl   %gs:0x0
     a18: 00
     a19: f6 84 24 88 00 00 00 testb  $0x3,0x88(%rsp)
     a20: 03
     a21: 0f 84 88 00 00 00    je     aaf <retint_kernel>
     a27: 48 89 e7              mov    %rsp,%rdi
     a2a: e8 00 00 00 00        callq  a2f
<swapgs_restore_regs_and_return_to_usermode>

0000000000000a2f <swapgs_restore_regs_and_return_to_usermode>:
     a2f: 41 5f                pop    %r15
#######sp:sp-8 bp:(und) type:regs end:0
     a31: 41 5e                pop    %r14
#######sp:sp-16 bp:(und) type:regs end:0
     a33: 41 5d                pop    %r13
#######sp:sp-24 bp:(und) type:regs end:0
     a35: 41 5c                pop    %r12
#######sp:sp-32 bp:(und) type:regs end:0
     a37: 5d                    pop    %rbp
#######sp:sp-40 bp:(und) type:regs end:0
     a38: 5b                    pop    %rbx
#######sp:sp-48 bp:(und) type:regs end:0
     a39: 41 5b                pop    %r11
#######sp:sp-56 bp:(und) type:regs end:0
     a3b: 41 5a                pop    %r10
#######sp:sp-64 bp:(und) type:regs end:0
     a3d: 41 59                pop    %r9
#######sp:sp-72 bp:(und) type:regs end:0
     a3f: 41 58                pop    %r8
#######sp:sp-80 bp:(und) type:regs end:0
     a41: 58                    pop    %rax
#######sp:sp-88 bp:(und) type:regs end:0
     a42: 59                    pop    %rcx
#######sp:sp-96 bp:(und) type:regs end:0
     a43: 5a                    pop    %rdx
#######sp:sp-104 bp:(und) type:regs end:0
     a44: 5e                    pop    %rsi
#######sp:sp-112 bp:(und) type:regs end:0
     a45: 48 89 e7              mov    %rsp,%rdi
     a48: 65 48 8b 24 25 00 00 mov    %gs:0x0,%rsp
     a4f: 00 00
     a51: ff 77 30              pushq  0x30(%rdi)
#######sp:sp-104 bp:(und) type:regs end:0
     a54: ff 77 28              pushq  0x28(%rdi)
#######sp:sp-96 bp:(und) type:regs end:0
     a57: ff 77 20              pushq  0x20(%rdi)
#######sp:sp-88 bp:(und) type:regs end:0
     a5a: ff 77 18              pushq  0x18(%rdi)
#######sp:sp-80 bp:(und) type:regs end:0
     a5d: ff 77 10              pushq  0x10(%rdi)
#######sp:sp-72 bp:(und) type:regs end:0
     a60: ff 37                pushq  (%rdi)
#######sp:sp-64 bp:(und) type:regs end:0
     a62: 50                    push   %rax
#######sp:sp-56 bp:(und) type:regs end:0
     a63: eb 43                jmp    aa8
<swapgs_restore_regs_and_return_to_usermode+0x79>
     a65: 0f 20 df              mov    %cr3,%rdi
     a68: eb 34                jmp    a9e
<swapgs_restore_regs_and_return_to_usermode+0x6f>
     a6a: 48 89 f8              mov    %rdi,%rax
     a6d: 48 81 e7 ff 07 00 00 and    $0x7ff,%rdi
     a74: 65 48 0f a3 3c 25 00 bt     %rdi,%gs:0x0
     a7b: 00 00 00
     a7e: 73 0f                jae    a8f
<swapgs_restore_regs_and_return_to_usermode+0x60>
     a80: 65 48 0f b3 3c 25 00 btr    %rdi,%gs:0x0
     a87: 00 00 00
     a8a: 48 89 c7              mov    %rax,%rdi
     a8d: eb 08                jmp    a97
<swapgs_restore_regs_and_return_to_usermode+0x68>
     a8f: 48 89 c7              mov    %rax,%rdi
     a92: 48 0f ba ef 3f        bts    $0x3f,%rdi
     a97: 48 81 cf 00 08 00 00 or     $0x800,%rdi
     a9e: 48 81 cf 00 10 00 00 or     $0x1000,%rdi
     aa5: 0f 22 df              mov    %rdi,%cr3
     aa8: 58                    pop    %rax
#######sp:sp-64 bp:(und) type:regs end:0
     aa9: 5f                    pop    %rdi
#######sp:sp-72 bp:(und) type:regs end:0
     aaa: 0f 01 f8              swapgs
     aad: eb 41                jmp    af0 <native_iret>
==============

It looks to me like things go wrong at the point where we switch over
to the trampoline stack? The ORC info claims that we have full user
registers on the trampoline stack (and that we're clobbering them with
our pushes - apparently objtool is not smart enough to realize that
that looks bogus), but at that point we should probably actually use
something like UNWIND_HINT_IRET_REGS, right?


By the way, looking through the rest of the entry stuff, there's some
other funny-looking stuff, too:

============
0000000000000f40 <general_protection>:
#######sp:sp+8 bp:(und) type:iret end:0
     f40:       90                      nop
#######sp:(und) bp:(und) type:call end:0
     f41:       90                      nop
     f42:       90                      nop
#######sp:sp+8 bp:(und) type:iret end:0
     f43:       e8 a8 01 00 00          callq  10f0 <error_entry>
#######sp:sp+0 bp:(und) type:regs end:0
     f48:       f6 84 24 88 00 00 00    testb  $0x3,0x88(%rsp)
     f4f:       03
     f50:       74 00                   je     f52 <general_protection+0x12>
     f52:       48 89 e7                mov    %rsp,%rdi
     f55:       48 8b 74 24 78          mov    0x78(%rsp),%rsi
     f5a:       48 c7 44 24 78 ff ff    movq   $0xffffffffffffffff,0x78(%rsp)
     f61:       ff ff
     f63:       e8 00 00 00 00          callq  f68 <general_protection+0x28>
     f68:       e9 73 02 00 00          jmpq   11e0 <error_exit>
#######sp:(und) bp:(und) type:call end:0
     f6d:       0f 1f 00                nopl   (%rax)
============

So I think on machines without X86_FEATURE_SMAP, trying to unwind from
the two NOPs at f41 and f42 will cause the unwinder to report an
error? Looking at unwind_next_frame(), "sp:(und)" without the "end:1"
marker seems to be reserved for errors.
