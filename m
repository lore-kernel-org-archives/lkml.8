Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0A9C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14B722B42
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595451115;
	bh=mF3MJR/qxIp+nbQ94v18XXzDQdmyapy79Ztw3OgQHqY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=JMZZJHM6Jqij03EZkjg+nZg7r+V6D5CWxUqIlsEs93OkZXkcugT8ompV/2RxSDd2f
	 2MpZyDGQ0s15Sy8YrfL+SXiCms5FQfiJ2nxnqxw3PmkCdClRQ/40JxDlzYSMpAQo3n
	 6Zd0IFDsI5/sVvH3OGElPBSRm56M9GQODc8Q7MHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbgGVUvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgGVUvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:51:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FA2E2086A;
        Wed, 22 Jul 2020 20:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595451113;
        bh=mF3MJR/qxIp+nbQ94v18XXzDQdmyapy79Ztw3OgQHqY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LOt9PSQbCV7kJfzvrITgn+PeMGQvLdPYxJidohLmszcAVI/qn9/VBXkx7hWk+fhyf
         DtxojwwdqweQj0Cm6lIurQWh05VKrhVdwCQfqxCW616laYx65WjoIBG27PFWV9sRH+
         2CtjRsT9PNcx0RXDAGjrbGveYyMvgpW5V7uBtn4g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 396663522AB9; Wed, 22 Jul 2020 13:51:53 -0700 (PDT)
Date:   Wed, 22 Jul 2020 13:51:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will@kernel.org, hch@lst.de,
        axboe@kernel.dk, chris@chris-wilson.co.uk, davem@davemloft.net,
        kuba@kernel.org, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [RFC][PATCH 0/9] smp: irq_work / smp_call_function rework
Message-ID: <20200722205153.GB23360@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200722150149.525408253@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722150149.525408253@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 05:01:49PM +0200, Peter Zijlstra wrote:
> Hi,
> 
> Here are a number of patches that continue the irq_work / smp_call_function
> integration / cleanup.
> 
> One of the biggest warts in this area is smp_call_function_single_async(); it
> looks like a useful function but is incredibly hard to use correctly due to the
> test-and-set LOCK on the csd not being atomic. This means you need to be
> incredibly careful to not corrupt the csd.
> 
> Simple patterns like allowing any CPU to IPI any other CPU end up requiring
> nr_cpu^2 storage because of this.
> 
> On top of that the csd has external data, vs the more common internal/embedded
> data pattern.
> 
> Now, irq_work has the embedded data pattern, but requires arch support for
> self-IPI. But because irq_work for remote CPUs relies on the smp_call_function
> infrastructure we can implement a generic irq_work_queue_remote().
> 
> Then it goes a bit ugly, and I introduce irq_work_queue_remote_static() that is
> non-atomic in exactly the same way smp_call_function_single_async() is now, but
> at least it has embedded data. A few performance sensitive users of
> smp_call_function_single_async() are converted.
> 
> Finally, smp_call_function_single_async() is made safer by using an atomic
> test-and-set.
> 
> TL;DR, I think at least the first few patches should go in the next round, but
> the rest can use some feedback.

And scftorture doesn't much like the full set of patches.  Though this
is early enough during boot that I am not sure that scftorture had much
chance to do any real damage.

I started with next-20200722, and reverted these three commits per our
IRC discussion:

c1c8004b7415 ("smp: Make symbol 'csd_bug_count' static")
1af4b06012bd ("kernel/smp: Provide CSD lock timeout diagnostics")
e327200d9d75 ("smp: Add source and destination CPUs to __call_single_data")

I ran scftorture using the following command on my 12-hardware-thread
x86 laptop:

tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration 2 --trust-make

Rerunning this on top of the last of the above reverts completed with
no drama, as in no complaints and "echo $?" said "0".

Does this reproduce at your end?  If not, any debug code I should apply
or debug options I should enable?

						Thanx, Paul

------------------------------------------------------------------------

[    1.230832] BUG: unable to handle page fault for address: 00000002000009f1
[    1.231342] #PF: supervisor read access in kernel mode
[    1.231705] #PF: error_code(0x0000) - not-present page
[    1.231818] PGD 0 P4D 0 
[    1.231818] Oops: 0000 [#1] SMP PTI
[    1.231818] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.8.0-rc6-next-20200722+ #4
[    1.231818] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1ubuntu1 04/01/2014
[    1.231818] RIP: 0010:nohz_work_func+0x0/0xa0
[    1.231818] Code: e8 35 52 ff ff 48 89 c3 eb 93 8b 43 70 89 44 24 04 eb c2 48 c7 c0 ea ff ff ff eb 94 e8 c9 02 a7 00 66 0f 1f 84 00 00 00 00 00 <4c> 63 8f f0 09 00 00 48 c7 c1 00 91 02 00 48 89 ca 4a 03 14 cd e0
[    1.231818] RSP: 0000:ffff8fa4c0130fb8 EFLAGS: 00010086
[    1.231818] RAX: ffff8d505f2a9118 RBX: 0000000000000000 RCX: ffff8d505f2a9118
[    1.231818] RDX: ffffffff8f692330 RSI: 0000000000000000 RDI: 0000000200000001
[    1.231818] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000028980
[    1.231818] R10: ffff8fa4c0077dc0 R11: 0000000000000000 R12: 0000000000000000
[    1.231818] R13: ffff8d505f2a9118 R14: 0000000000000000 R15: 0000000000000000
[    1.238055] FS:  0000000000000000(0000) GS:ffff8d505f280000(0000) knlGS:0000000000000000
[    1.238055] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.238055] CR2: 00000002000009f1 CR3: 000000001440a000 CR4: 00000000000006e0
[    1.238055] Call Trace:
[    1.238055]  <IRQ>
[    1.238055]  flush_smp_call_function_queue+0xc4/0x1e0
[    1.238055]  __sysvec_call_function_single+0x28/0xb0
[    1.238055]  asm_call_on_stack+0x12/0x20
[    1.238055]  </IRQ>
[    1.238055]  sysvec_call_function_single+0x52/0x80
[    1.238055]  asm_sysvec_call_function_single+0x12/0x20
[    1.238055] RIP: 0010:default_idle+0x20/0x140
[    1.238055] Code: 9f ff ff cc cc cc cc cc cc cc 41 55 41 54 55 53 65 8b 2d e3 8c f0 6f 0f 1f 44 00 00 e9 07 00 00 00 0f 00 2d 54 d4 4f 00 fb f4 <65> 8b 2d c9 8c f0 6f 0f 1f 44 00 00 5b 5d 41 5c 41 5d c3 65 8b 05
[    1.238055] RSP: 0000:ffff8fa4c0077ed0 EFLAGS: 00000246
[    1.238055] RAX: ffffffff90108670 RBX: 0000000000000002 RCX: 7fffffffb80ea43f
[    1.238055] RDX: 00000000000cc596 RSI: 0000000000000002 RDI: ffff8d505f29e460
[    1.238055] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
[    1.238055] R10: ffff8fa4c0077eb0 R11: 0000000000000000 R12: 0000000000000000
[    1.238055] R13: 0000000000000000 R14: ffffffffffffffff R15: ffff8d505ed3a700
[    1.238055]  ? __sched_text_end+0x7/0x7
[    1.238055]  do_idle+0x1ca/0x2b0
[    1.238055]  cpu_startup_entry+0x14/0x20
[    1.238055]  secondary_startup_64+0xb6/0xc0
[    1.238055] Modules linked in:
[    1.238055] CR2: 00000002000009f1
[    1.238055] ---[ end trace d53a363244ab3d2f ]---
[    1.238055] RIP: 0010:nohz_work_func+0x0/0xa0
[    1.238055] Code: e8 35 52 ff ff 48 89 c3 eb 93 8b 43 70 89 44 24 04 eb c2 48 c7 c0 ea ff ff ff eb 94 e8 c9 02 a7 00 66 0f 1f 84 00 00 00 00 00 <4c> 63 8f f0 09 00 00 48 c7 c1 00 91 02 00 48 89 ca 4a 03 14 cd e0
[    1.238055] RSP: 0000:ffff8fa4c0130fb8 EFLAGS: 00010086
[    1.238055] RAX: ffff8d505f2a9118 RBX: 0000000000000000 RCX: ffff8d505f2a9118
[    1.238055] RDX: ffffffff8f692330 RSI: 0000000000000000 RDI: 0000000200000001
[    1.238055] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000028980
[    1.238055] R10: ffff8fa4c0077dc0 R11: 0000000000000000 R12: 0000000000000000
[    1.238055] R13: ffff8d505f2a9118 R14: 0000000000000000 R15: 0000000000000000
[    1.238055] FS:  0000000000000000(0000) GS:ffff8d505f280000(0000) knlGS:0000000000000000
[    1.238055] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.238055] CR2: 00000002000009f1 CR3: 000000001440a000 CR4: 00000000000006e0
[    1.238055] Kernel panic - not syncing: Fatal exception in interrupt
[    1.238055] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
