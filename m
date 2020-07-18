Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A83FC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8A720702
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EStzw3WY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgGRROR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:14:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37777 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726973AbgGRROQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 13:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595092454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RRksYhmg4/m2MIzfKg2lGVAU6nWBiK4YcY/9VlfMcn4=;
        b=EStzw3WYndHk6nAPiphfFQfsWf2LbKpdFvfy43aR22/0C6er1QA5EC6siZqI3iTEtZE098
        JiVM+xADdqkd3WH7d6Dd6redc4G4km6J64hNrajVe1WTQiijCuetnfgUeT4AnedsC0Rnbl
        lqsZqDqWmZd9oacHB1dcEtJVa5cxJ/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-AZyma5pvPxOv40XJXTcUzg-1; Sat, 18 Jul 2020 13:14:11 -0400
X-MC-Unique: AZyma5pvPxOv40XJXTcUzg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCB97C7465;
        Sat, 18 Jul 2020 17:14:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with SMTP id 66C54619C4;
        Sat, 18 Jul 2020 17:14:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 18 Jul 2020 19:14:09 +0200 (CEST)
Date:   Sat, 18 Jul 2020 19:14:07 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200718171406.GB16791@redhat.com>
References: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
 <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
 <20200717122651.GA6067@redhat.com>
 <20200717124017.GB6067@redhat.com>
 <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18, Jiri Slaby wrote:
>
> On 17. 07. 20, 14:40, Oleg Nesterov wrote:
> >
> > please see the updated patch below, lets check ptrace_unfreeze() too.
>
> Sure, dmesg attached.

Thanks a lot!

But I am totally confused...

> [   94.513944] ------------[ cut here ]------------
> [   94.513985] do not call blocking ops when !TASK_RUNNING; state=8 set at [<000000002fe279e9>] ptrace_check_attach+0xbf/0x110

OK, so the ptracer has already did the TASK_TRACED -> __TASK_TRACED change in
ptrace_freeze_traced(),

> [   94.514019] WARNING: CPU: 16 PID: 34171 at kernel/sched/core.c:6881 __might_sleep+0x6c/0x70
> [   94.514020] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
> [   94.514082] CPU: 16 PID: 34171 Comm: strace Tainted: G            E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
> [   94.514084] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
> [   94.514087] RIP: 0010:__might_sleep+0x6c/0x70
> [   94.514090] Code: 41 5c 41 5d e9 25 ff ff ff 48 8b 90 68 1a 00 00 48 8b 70 10 48 c7 c7 10 45 70 8f c6 05 4f a9 68 01 01 48 89 d1 e8 7a bb fc ff <0f> 0b eb c8 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 49 89 fd
> [   94.514092] RSP: 0018:ffff9ffa4ba1be00 EFLAGS: 00010286
> [   94.514093] RAX: 0000000000000000 RBX: ffff8dc82b503e00 RCX: 0000000000000489
> [   94.514094] RDX: 0000000000000001 RSI: 0000000000000096 RDI: 0000000000000247
> [   94.514095] RBP: ffffffff8f6ffa6b R08: 0000000000000004 R09: 0000000000000489
> [   94.514095] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000039
> [   94.514096] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dc82b5045e4
> [   94.514098] FS:  00007fa00f1f9240(0000) GS:ffff8dcb0c000000(0000) knlGS:0000000000000000
> [   94.514099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   94.514100] CR2: 0000557b53d25877 CR3: 00000004ca490005 CR4: 0000000000360ee0
> [   94.514103] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   94.514104] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   94.514105] Call Trace:
> [   94.514821]  ptrace_stop+0x1a9/0x300

This is already wrong. But

	Where does this __might_sleep() come from ??? I ses no blocking calls
	in ptrace_stop(). Not to mention it is called with ->siglock held and
	right after this lock is dropped we take tasklist_lock.

	How this connects to the debugging patch I sent? Did you see this warning
	without that patch?
	

> [   94.514888] WARNING: CPU: 16 PID: 34171 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
...
> [   94.514899] RIP: 0010:ptrace_stop+0x1d8/0x300

This is WARN_ON(current->state) added to ptrace_stop(), this can explain
BUG_ON() in do_notify_parent() you reported.

So, the tracee returns from schedule() with ->state != TASK_RUNNING ???
This must not be possible.

OK, perhaps task->state was changed by ptrace_unfreeze_traced()? this can
only happen if it races with ttwu(__TASK_TRACED) without ->siglock held,
nobody should do this.

Strange.

Oleg.

