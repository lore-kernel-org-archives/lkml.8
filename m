Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BA6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D378722CAD
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="zUrPexf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgHESXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:23:22 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:54253 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbgHESLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:11:10 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 8c70ede0;
        Wed, 5 Aug 2020 10:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=mail; bh=efBYDnuTLbkDHTL1rdVUDH8Rfsw=; b=zUrPexf
        6VxWKr7WZP2DJAmsR4tHX9xc9wEih5Bwi/w2pm87SxOpb576kP76yIuAphrKA5JT
        WisRSKFZpdxc1bAVnYipOL/T25XhWuiVvUl9gRjdee+TnG8TlTHy/D4bYG2j2URn
        iksLnzT3LZymo5LZDWIMGcOgssAr6YIVpUgl2z5GI6I2ABdRQ7Iyr/a5Fvc+AM6l
        dLQJYWQdgP+OOO7ORr7ubvBietrNqcXNqbvUErhg9+hekE6i/divKmKIJhBnVKMQ
        KIIll6MfI3qG6FCANidKvtzdPKppvPXTvxmurkSHzhthLG0X0tyyPiYAoYu50NTJ
        U9YzreSV9mb494A==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 96870002 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 5 Aug 2020 10:39:25 +0000 (UTC)
Date:   Wed, 5 Aug 2020 13:03:48 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [GIT PULL] x86/mm changes for v5.9
Message-ID: <20200805110348.GA108872@zx2c4.com>
References: <20200803190354.GA1293087@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200803190354.GA1293087@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Joerg,

On Mon, Aug 03, 2020 at 09:03:54PM +0200, Ingo Molnar wrote:
> Linus,
> 
> Please pull the latest x86/mm git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2020-08-03
> 
>    # HEAD: 2b32ab031e82a109e2c5b0d30ce563db0fe286b4 x86/mm/64: Make sync_global_pgds() static
> 
> The biggest change is to not sync the vmalloc and ioremap ranges for x86-64 anymore.
> 
>  Thanks,
> 
> 	Ingo
> 
> ------------------>
> Joerg Roedel (3):
>       x86/mm: Pre-allocate P4D/PUD pages for vmalloc area
>       x86/mm/64: Do not sync vmalloc/ioremap mappings
>       x86/mm/64: Make sync_global_pgds() static

The commit 8bb9bf242d1f ("x86/mm/64: Do not sync vmalloc/ioremap
mappings") causes the OOPS below, in Linus' tree and in linux-next,
unearthed by my CI on <https://www.wireguard.com/build-status/>.
Bisecting reveals 8bb9bf242d1f, and reverting this makes the OOPS go
away.

Jason


BUG: unable to handle page fault for address: ffffe8ffffd00608
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 2 PID: 22 Comm: kworker/2:0 Not tainted 5.8.0+ #154
RIP: 0010:process_one_work+0x2c/0x2d0
Code: 41 56 41 55 41 54 55 48 89 f5 53 48 89 fb 48 83 ec 08 48 8b 06 4c 8b 67 40 49 89 c6 45 30 f6 a8 04 b8 00 00 00 00 4c 0f 44 f0 <49> 8b 46 08 44 8b a8 00 01 05
RSP: 0018:ffff88800016be98 EFLAGS: 00010002
RAX: 0000000000000000 RBX: ffff888000010c00 RCX: 0000000000000000
RDX: 00000000fffedb85 RSI: ffff888000391900 RDI: ffff888000010c00
RBP: ffff888000391900 R08: ffff888000391900 R09: ffff888000350090
R10: ffffffffff770df6 R11: ffff88800f91f840 R12: ffff88800f91f140
R13: ffff88800f91f160 R14: ffffe8ffffd00600 R15: ffff88800f91f140
FS:  0000000000000000(0000) GS:ffff88800f900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffe8ffffd00608 CR3: 00000000001be005 CR4: 00000000001706a0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 worker_thread+0x4b/0x3b0
 ? rescuer_thread+0x360/0x360
 kthread+0x116/0x140
 ? __kthread_create_worker+0x110/0x110
 ret_from_fork+0x1f/0x30
CR2: ffffe8ffffd00608
---[ end trace ca0cfc5a79414fb2 ]---
RIP: 0010:process_one_work+0x2c/0x2d0
Code: 41 56 41 55 41 54 55 48 89 f5 53 48 89 fb 48 83 ec 08 48 8b 06 4c 8b 67 40 49 89 c6 45 30 f6 a8 04 b8 00 00 00 00 4c 0f 44 f0 <49> 8b 46 08 44 8b a8 00 01 05
RSP: 0018:ffff88800016be98 EFLAGS: 00010002
RAX: 0000000000000000 RBX: ffff888000010c00 RCX: 0000000000000000
RDX: 00000000fffedb85 RSI: ffff888000391900 RDI: ffff888000010c00
RBP: ffff888000391900 R08: ffff888000391900 R09: ffff888000350090
R10: ffffffffff770df6 R11: ffff88800f91f840 R12: ffff88800f91f140
R13: ffff88800f91f160 R14: ffffe8ffffd00600 R15: ffff88800f91f140
FS:  0000000000000000(0000) GS:ffff88800f900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffe8ffffd00608 CR3: 00000000001be005 CR4: 00000000001706a0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception

