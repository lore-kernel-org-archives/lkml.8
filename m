Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82108C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B14120656
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="nCU/NKcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgFLTsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:48:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53226 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFLTsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:48:01 -0400
Received: from zn.tnic (p200300ec2f0af400e40e5fe0afa6da82.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:f400:e40e:5fe0:afa6:da82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 385071EC02A2;
        Fri, 12 Jun 2020 21:47:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591991279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=U0vIwTOm+bSy7bM15RwUhOkigup/iBvfB33kOPuQzrA=;
        b=nCU/NKcldiHmw7ezHf+JEwrhpBg1G2V6IaQvSiQvj2lYmFvxmilvYclr/CMQ3IsSX9c7EA
        J8yxjLrhK3J0v31ecxjGAcFOyQjG0ujEHPV9jAv6m2afzWY/U5vslw4IJi5dfArF3SajYP
        sriKlP9P54k5OJQQ0WWEuCnEeTD+sao=
Date:   Fri, 12 Jun 2020 21:47:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/msr: Filter MSR writes
Message-ID: <20200612194753.GG22660@zn.tnic>
References: <20200612105026.GA22660@zn.tnic>
 <CAHk-=wjKr+eAdPg3q7S6N4Cwd1aMEOHc5qLaKE-wwhouZRo=uw@mail.gmail.com>
 <20200612174801.GE22660@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200612174801.GE22660@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 07:48:01PM +0200, Borislav Petkov wrote:
> > So the first phase might be to introduce this, but have the default
> > for non-recognized MSR's be "log", not "deny".
> 
> Ok. How are we going to "learn" about those non-recognized MSRs? Ask
> people to send us a note to lkml so that we can fix the list once they
> see the logged message?

We could do something noisy like this:

[   27.395795] msr: filter_write: Write to unrecognized MSR 0x10
[   27.396865] msr: Please report to x86@kernel.org
[   27.397811] ------------[ cut here ]------------
[   27.398630] WARNING: CPU: 10 PID: 4405 at arch/x86/kernel/msr.c:83 msr_write.cold+0x1f/0x26 [msr]
[   27.400123] Modules linked in: msr
[   27.400728] CPU: 10 PID: 4405 Comm: wrmsr Not tainted 5.7.0+ #2
[   27.400838] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
[   27.400838] RIP: 0010:msr_write.cold+0x1f/0x26 [msr]
[   27.400838] Code: eb e0 49 c7 c4 ea ff ff ff eb d7 48 c7 c6 40 11 00 a0 48 c7 c7 c0 10 00 a0 e8 5f 83 0c e1 48 c7 c7 f0 10 00 a0 e8 53 83 0c e1 <0f> 0b e9 af fe ff ff 8b 3d 7c 20 00 00 be 01 00 00 00 e8 1e c7 06
[   27.400838] RSP: 0018:ffffc900003d7e98 EFLAGS: 00010282
[   27.400838] RAX: 0000000000000024 RBX: 0000000000000008 RCX: 0000000000000007
[   27.400838] RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff88807dc98360
[   27.400838] RBP: 00007fffffffe978 R08: 00000000000001ca R09: 0000000000000000
[   27.400838] R10: ffffffff82549708 R11: ffffc900003d7d50 R12: 0000000000000008
[   27.400838] R13: 0000000000000000 R14: 0000000000000010 R15: 0000000000000000
[   27.400838] FS:  00007ffff7fb7540(0000) GS:ffff88807dc80000(0000) knlGS:0000000000000000
[   27.400838] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.400838] CR2: 00007ffff7e672a0 CR3: 0000000078a4c000 CR4: 00000000003406e0
[   27.400838] Call Trace:
[   27.400838]  vfs_write+0xe4/0x1e0
[   27.400838]  ksys_pwrite64+0x7d/0xb0
[   27.400838]  do_syscall_64+0x48/0x140
[   27.400838]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   27.400838] RIP: 0033:0x7ffff7edda37
[   27.400838] Code: ff ff eb b6 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8d 05 c9 7c 0d 00 49 89 ca 8b 00 85 c0 75 10 b8 12 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 59 c3 41 55 49 89 cd 41 54 49 89 d4 55 48 89
[   27.400838] RSP: 002b:00007fffffffe968 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
[   27.400838] RAX: ffffffffffffffda RBX: 00007fffffffeb78 RCX: 00007ffff7edda37
[   27.400838] RDX: 0000000000000008 RSI: 00007fffffffe978 RDI: 0000000000000003
[   27.400838] RBP: 0000000000000003 R08: 00007fffffffedb6 R09: 0000000000000000
[   27.400838] R10: 0000000000000010 R11: 0000000000000246 R12: 00007fffffffeb78
[   27.400838] R13: 0000000000000010 R14: 0000000000000000 R15: 0000000000000010
[   27.400838] ---[ end trace 3bd374c0e61187b1 ]---

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
