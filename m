Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CC7C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 07:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436F120702
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 07:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgA3H4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 02:56:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:33572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgA3H4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 02:56:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BA704AE71;
        Thu, 30 Jan 2020 07:55:58 +0000 (UTC)
Date:   Thu, 30 Jan 2020 08:55:49 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Damian Tometzki <damian.tometzki@familie-tometzki.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
Message-ID: <20200130075549.GA6684@zn.tnic>
References: <20200128165906.GA67781@gmail.com>
 <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <20200129132618.GA30979@zn.tnic>
 <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
 <20200129183404.GB30979@zn.tnic>
 <c08616b8-d209-ff08-1b74-645a49a486d2@familie-tometzki.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c08616b8-d209-ff08-1b74-645a49a486d2@familie-tometzki.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Damian,

On Thu, Jan 30, 2020 at 06:47:14AM +0100, Damian Tometzki wrote:
> in my qemu env the system isnt coming up. I tried both with and without the
> changes from Borislav.

in the future, please do not hijack the thread like that but start a new
one or open a bug on bugzilla.kernel.org. Your issue is something else.

> 0.605193] ------------[ cut here ]------------
> [    0.605933] General protection fault in user access. Non-canonical
> address?

There it is.

> [    0.605948] WARNING: CPU: 0 PID: 1 at arch/x86/mm/extable.c:77
> ex_handler_uaccess+0x48/0x50
> [    0.606931] Modules linked in:
> [    0.606931] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0 #15
> [    0.606931] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
> [    0.606931] RIP: 0010:ex_handler_uaccess+0x48/0x50
> [    0.606931] Code: 83 c4 08 b8 01 00 00 00 5b c3 80 3d 78 75 50 01 00 75
> dc 48 c7 c7 00 ea 1e 82 48 89 34 24 c6 05 64 75 50 01 01 e8 9e fd 00 00 <0f>
> 0b 48 8b 34 24 eb bd 80 3d 4f 75 50 01 00 55 48 89 fd 53 49
> [    0.606931] RSP: 0000:ffffc900000dbc30 EFLAGS: 00010286
> [    0.606931] RAX: 000000000000003f RBX: ffffffff82339d6c RCX:
> 0000000000000000
> [    0.606931] RDX: 0000000000000007 RSI: ffffffff8316dc5f RDI:
> ffffffff8316e05f
> [    0.606931] RBP: 000000000000000d R08: ffffffff8316dc20 R09:
> 0000000000029840
> [    0.606931] R10: 000000010196fab4 R11: 0000000000000001 R12:
> 0000000000000000
> [    0.606931] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> [    0.606931] FS:  0000000000000000(0000) GS:ffff88800f800000(0000)
> knlGS:0000000000000000
> [    0.606931] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.606931] CR2: 0000000000000000 CR3: 000000000240a000 CR4:
> 00000000000006f0
> [    0.606931] Call Trace:
> [    0.606931]  fixup_exception+0x3e/0x51
> [    0.606931]  do_general_protection+0x9c/0x260
> [    0.606931]  general_protection+0x28/0x30
> [    0.606931] RIP: 0010:copy_user_generic_string+0x2c/0x40
> [    0.606931] Code: 00 83 fa 08 72 27 89 f9 83 e1 07 74 15 83 e9 08 f7 d9
> 29 ca 8a 06 88 07 48 ff c6 48 ff c7 ff c9 75 f2 89 d1 c1 e9 03 83 e2 07 <f3>
> 48 a5 89 d1 f3 a4 31 c0 0f 1f 00 c3 0f 1f 80 00 00 00 00 0f
> [    0.606931] RSP: 0000:ffffc900000dbda0 EFLAGS: 00010246
> [    0.606931] RAX: 0000000000000000 RBX: ffff88801e488000 RCX:
> 0000000000000001
> [    0.606931] RDX: 0000000000000000 RSI: 009896808086a201 RDI:
> ffffc900000dbdc0

It looks like dquot_init->register_sysctl_table-> ... does copy_to_user
at some point and it goes off into the weeds and %rsi becomes
non-canonical.

Please start a new thread or open a bug and upload your .config and
dmesg. We'll continue debugging that there.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
