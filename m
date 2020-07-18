Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8B6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633B62073E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgGRRoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:44:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41585 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 13:44:54 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jwqtF-0003Va-3p; Sat, 18 Jul 2020 17:44:49 +0000
Date:   Sat, 18 Jul 2020 19:44:48 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, christian@brauner.io,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
References: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
 <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
 <20200717122651.GA6067@redhat.com>
 <20200717124017.GB6067@redhat.com>
 <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200718171406.GB16791@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 07:14:07PM +0200, Oleg Nesterov wrote:
> On 07/18, Jiri Slaby wrote:
> >
> > On 17. 07. 20, 14:40, Oleg Nesterov wrote:
> > >
> > > please see the updated patch below, lets check ptrace_unfreeze() too.
> >
> > Sure, dmesg attached.
> 
> Thanks a lot!
> 
> But I am totally confused...
> 
> > [   94.513944] ------------[ cut here ]------------
> > [   94.513985] do not call blocking ops when !TASK_RUNNING; state=8 set at [<000000002fe279e9>] ptrace_check_attach+0xbf/0x110
> 
> OK, so the ptracer has already did the TASK_TRACED -> __TASK_TRACED change in
> ptrace_freeze_traced(),
> 
> > [   94.514019] WARNING: CPU: 16 PID: 34171 at kernel/sched/core.c:6881 __might_sleep+0x6c/0x70
> > [   94.514020] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
> > [   94.514082] CPU: 16 PID: 34171 Comm: strace Tainted: G            E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
> > [   94.514084] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
> > [   94.514087] RIP: 0010:__might_sleep+0x6c/0x70
> > [   94.514090] Code: 41 5c 41 5d e9 25 ff ff ff 48 8b 90 68 1a 00 00 48 8b 70 10 48 c7 c7 10 45 70 8f c6 05 4f a9 68 01 01 48 89 d1 e8 7a bb fc ff <0f> 0b eb c8 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 49 89 fd
> > [   94.514092] RSP: 0018:ffff9ffa4ba1be00 EFLAGS: 00010286
> > [   94.514093] RAX: 0000000000000000 RBX: ffff8dc82b503e00 RCX: 0000000000000489
> > [   94.514094] RDX: 0000000000000001 RSI: 0000000000000096 RDI: 0000000000000247
> > [   94.514095] RBP: ffffffff8f6ffa6b R08: 0000000000000004 R09: 0000000000000489
> > [   94.514095] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000039
> > [   94.514096] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dc82b5045e4
> > [   94.514098] FS:  00007fa00f1f9240(0000) GS:ffff8dcb0c000000(0000) knlGS:0000000000000000
> > [   94.514099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   94.514100] CR2: 0000557b53d25877 CR3: 00000004ca490005 CR4: 0000000000360ee0
> > [   94.514103] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   94.514104] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   94.514105] Call Trace:
> > [   94.514821]  ptrace_stop+0x1a9/0x300
> 
> This is already wrong. But
> 
> 	Where does this __might_sleep() come from ??? I ses no blocking calls
> 	in ptrace_stop(). Not to mention it is called with ->siglock held and
> 	right after this lock is dropped we take tasklist_lock.
> 
> 	How this connects to the debugging patch I sent? Did you see this warning
> 	without that patch?
> 	
> 
> > [   94.514888] WARNING: CPU: 16 PID: 34171 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
> ...
> > [   94.514899] RIP: 0010:ptrace_stop+0x1d8/0x300
> 
> This is WARN_ON(current->state) added to ptrace_stop(), this can explain
> BUG_ON() in do_notify_parent() you reported.
> 
> So, the tracee returns from schedule() with ->state != TASK_RUNNING ???
> This must not be possible.
> 
> OK, perhaps task->state was changed by ptrace_unfreeze_traced()? this can
> only happen if it races with ttwu(__TASK_TRACED) without ->siglock held,
> nobody should do this.
> 
> Strange.

I have tried to reproduce this with an vanilla upstream 5.8-rc4 and the
strace test-suite with

make check -j4

and I wasn't able to after multiple retries. Jiri, just to make sure
this is upstream 5.8-rc4 without any additional patches?
Anything special required to reproduce this in the way you run strace
and so on?

Christian
