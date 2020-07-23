Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81331C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5451F22CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgGWNhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:37:51 -0400
Received: from 8bytes.org ([81.169.241.247]:58830 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbgGWNhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:37:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2D1E0346; Thu, 23 Jul 2020 15:37:48 +0200 (CEST)
Date:   Thu, 23 Jul 2020 15:37:43 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Regression on todays tip/master (commit 16f70beccf43)
Message-ID: <20200723133743.GA30716@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while testing the SEV-ES patches on todays tip/master I triggered the BUG
below:

[  137.629660] ------------[ cut here ]------------
[  137.630769] kernel BUG at kernel/signal.c:1917!
[  137.631796] invalid opcode: 0000 [#1] SMP NOPTI
[  137.632822] CPU: 3 PID: 28596 Comm: test_syscall_vd Not tainted 5.8.0-rc6-tip+ #3
[  137.634495] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[  137.636236] RIP: 0010:do_notify_parent+0x25c/0x290
[  137.637311] Code: 41 89 c5 41 83 e5 01 45 31 c0 b9 01 00 00 00 48 8d 74 24 10 44 89 e7 48 8b 95 f0 04 00 00 e8 1b f5 ff ff e9 5a ff ff ff 0f 0b <0f> 0b 48 39 bf 18 05 00 00 75 17 48 8b 97 88 05 00 00 48 8d 87 88
[  137.640453] RSP: 0018:ffffc13942197e10 EFLAGS: 00010002
[  137.641246] RAX: 0000000000000008 RBX: ffff9cd98b5c5c40 RCX: 0000000000000040
[  137.642329] RDX: ffff9cd99fa9dc40 RSI: 0000000000000011 RDI: ffff9cd98b5c5c40
[  137.643397] RBP: ffff9cd98b5c5c40 R08: 0000000000000000 R09: 0000000000000000
[  137.644467] R10: 0000000000000000 R11: 0000000000000000 R12: ffffc13942197ea8
[  137.645536] R13: ffff9cd98b5c6138 R14: 0000000000000001 R15: ffff9cd947de9ec0
[  137.646621] FS:  0000000000000000(0000) GS:ffff9cd9baec0000(0000) knlGS:00000000f7c72700
[  137.647833] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  137.648695] CR2: 00000000f7e74f24 CR3: 0000800043a0a000 CR4: 00000000003506e0
[  137.649790] DR0: 0000000000406188 DR1: 000000000040130a DR2: 0000000000000000
[  137.650861] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[  137.652055] Call Trace:
[  137.652464]  ? perf_iterate_sb+0x142/0x1e0
[  137.653097]  do_exit+0x991/0xaf0
[  137.653610]  ? ptrace_notify+0x4e/0x70
[  137.654183]  do_group_exit+0x3a/0xa0
[  137.654731]  __ia32_sys_exit_group+0x14/0x20
[  137.655382]  do_syscall_32_irqs_on+0x45/0x60
[  137.656035]  do_fast_syscall_32+0x67/0xe0
[  137.656650]  entry_SYSCALL_compat_after_hwframe+0x45/0x4d
[  137.657466] RIP: 0023:0xf7fb5569
[  137.657972] Code: Bad RIP value.
[  137.658468] RSP: 002b:00000000ff9c0efc EFLAGS: 00200296 ORIG_RAX: 00000000000000fc
[  137.659598] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000000000
[  137.660667] RDX: 00000000ff9c0eec RSI: 00000000f7e5b6b8 RDI: 00000000f7e5b6b8
[  137.661750] RBP: 00000000f7e5dc48 R08: 0000000000000000 R09: 0000000000000000
[  137.662815] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  137.663882] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  137.664948] Modules linked in:
[  137.665419] ---[ end trace ed97590b8bdea54b ]---

This is from a guest kernel which runs _without_ my SEV-ES patches, so
built from plain tip/master branch.

The guest had 4 VCPUs and ran 4 instances of the in-kernel x86-selftests
in a loop, together with 'perf top -e cycles:k'. As you can see in the
time-stamps, the issue triggered pretty quickly.

Please let me know if you need more information or testing from my side.

Thanks,

	Joerg
