Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D302DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E8B206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDXsSyZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCMDOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 23:14:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48900 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726310AbgCMDOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 23:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584069245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3F0B/sbfaNV0/6f7GTRgchOIhAxJh7elAMUW5tz3BzI=;
        b=RDXsSyZVvVNtIzut6JxWl2d2Bib448I4q+MIs2ZZk5zhgJpqO5jlz7P5HWfIUnuvjN9Bng
        Wh10R5DKzGqRRhVOKhTqkkYT2WA523O9ooVqY0FP1udtzzZa+xTdjUGfeY/Azg4mMNdaFS
        gSWF5HjSuVZsimjP7yMoEy+V51/eT5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-RPylyxUcPImAowj3_Up4Qw-1; Thu, 12 Mar 2020 23:14:00 -0400
X-MC-Unique: RPylyxUcPImAowj3_Up4Qw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86D10107ACCC;
        Fri, 13 Mar 2020 03:13:59 +0000 (UTC)
Received: from ming.t460p (ovpn-8-37.pek2.redhat.com [10.72.8.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30CAB92965;
        Fri, 13 Mar 2020 03:13:46 +0000 (UTC)
Date:   Fri, 13 Mar 2020 11:13:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ming Lei <minlei@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] x86/vector: Allow to free vector for managed IRQ
Message-ID: <20200313031341.GC27275@ming.t460p>
References: <20200312205830.81796-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312205830.81796-1-peterx@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 04:58:30PM -0400, Peter Xu wrote:
> After we introduced the "managed_irq" sub-parameter for isolcpus, it's
> possible to free a kernel managed irq vector now.
> 
> It can be triggered easily by booting a VM with a few vcpus, with one
> virtio-blk device and then mark some cores as HK_FLAG_MANAGED_IRQ (in
> below case, there're 4 vcpus, with vcpu 3 isolated with managed_irq):
> 
> [    2.889911] ------------[ cut here ]------------
> [    2.889964] WARNING: CPU: 3 PID: 0 at arch/x86/kernel/apic/vector.c:853 free_moved_vector+0x126/0x160
> [    2.889964] Modules linked in: crc32c_intel serio_raw virtio_blk(+) qemu_fw_cfg
> [    2.889968] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.6.0-rc1 #18
> [    2.889969] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [    2.889970] RIP: 0010:free_moved_vector+0x126/0x160
> [    2.889972] Code: 45 00 48 85 c0 75 df e9 2b ff ff ff 48 8b 05 f9 51 71 01 e8 3c 5a 11 00 85 c0 74 09 80 3d 8d 39 71 01 00 5
> [    2.889972] RSP: 0000:ffffb5ac00110fa0 EFLAGS: 00010002
> [    2.889973] RAX: 0000000000000001 RBX: ffffa00fad2d60c0 RCX: 0000000000000821
> [    2.889974] RDX: 0000000000000000 RSI: 00000000fd2bd4ba RDI: ffffa00fad2d60c0
> [    2.889974] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
> [    2.889975] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000023
> [    2.889975] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
> [    2.889976] FS:  0000000000000000(0000) GS:ffffa00fbbd80000(0000) knlGS:0000000000000000
> [    2.889977] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.889978] CR2: 00000000ffffffff CR3: 0000000123610001 CR4: 0000000000360ee0
> [    2.889980] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    2.889980] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    2.889981] Call Trace:
> [    2.889982]  <IRQ>
> [    2.889987]  smp_irq_move_cleanup_interrupt+0xac/0xc6
> [    2.889989]  irq_move_cleanup_interrupt+0xc/0x20
> [    2.889990]  </IRQ>
> [    2.889991] RIP: 0010:native_safe_halt+0xe/0x10
> [    2.889992] Code: cc cc cc cc cc cc cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d 56 82 4f 00 f4 c3 66 90 e9 07 00 00 00 0f 00 0
> [    2.889993] RSP: 0000:ffffb5ac00083eb0 EFLAGS: 00000206 ORIG_RAX: ffffffffffffffdf
> [    2.889994] RAX: ffffa00fbb260000 RBX: 0000000000000003 RCX: 0000000000000000
> [    2.889994] RDX: ffffa00fbb260000 RSI: 0000000000000006 RDI: ffffa00fbb260000
> [    2.889995] RBP: 0000000000000003 R08: 000000cd42e4dffb R09: 0000000000000000
> [    2.889995] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa00fbb260000
> [    2.889996] R13: 0000000000000000 R14: 0000000000000000 R15: ffffa00fbb260000
> [    2.890003]  default_idle+0x1f/0x140
> [    2.890006]  do_idle+0x1fa/0x270
> [    2.890010]  cpu_startup_entry+0x19/0x20
> [    2.890012]  start_secondary+0x164/0x1b0
> [    2.890014]  secondary_startup_64+0xa4/0xb0
> [    2.890021] irq event stamp: 8758
> [    2.890022] hardirqs last  enabled at (8755): [<ffffffffbbb105ca>] default_idle+0x1a/0x140
> [    2.890023] hardirqs last disabled at (8756): [<ffffffffbb0039f7>] trace_hardirqs_off_thunk+0x1a/0x1c
> [    2.890025] softirqs last  enabled at (8758): [<ffffffffbb0ecce8>] irq_enter+0x68/0x70
> [    2.890026] softirqs last disabled at (8757): [<ffffffffbb0ecccd>] irq_enter+0x4d/0x70
> [    2.890027] ---[ end trace deb5d563d2acb13f ]---
> 
> I believe the same thing will happen to bare metals.
> 
> When allocating the IRQ for the device, activate_managed() will try to
> allocate a vector based on what we've calculated for kernel managed
> IRQs (which does not take HK_FLAG_MANAGED_IRQ into account).  However
> when we bind the IRQ to the IRQ handler, we'll do irq_startup() and
> irq_do_set_affinity(), in which we will start to consider the whole
> HK_FLAG_MANAGED_IRQ logic.  This means the chosen core can be
> different from when we do the allocation.  When that happens, we'll
> need to be able to properly free the old vector on the old core.
> 
> Remove the WARN_ON_ONCE() to allow this to happen.
> 
> Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Ming Lei <minlei@redhat.com>
> CC: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/kernel/apic/vector.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index 2c5676b0a6e7..a1142260b123 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -837,14 +837,6 @@ static void free_moved_vector(struct apic_chip_data *apicd)
>  	unsigned int cpu = apicd->prev_cpu;
>  	bool managed = apicd->is_managed;
>  
> -	/*
> -	 * This should never happen. Managed interrupts are not
> -	 * migrated except on CPU down, which does not involve the
> -	 * cleanup vector. But try to keep the accounting correct
> -	 * nevertheless.
> -	 */
> -	WARN_ON_ONCE(managed);
> -

Since commit 11ea68f553e2, managed interrupt can be migrated on CPU up:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

