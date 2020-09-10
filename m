Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C88EC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E22C221E7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qtJIUX3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgIJVV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731116AbgIJOYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:24:14 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58361C0617A1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=G8KFWo1YZT/jwQRpDVwfY4DfSs9Xk8pRCGIbApr9hxQ=; b=qtJIUX3C9OPEUoxhRq5qtVjFrN
        liojIf66iFvov5CqAyuArA/k4c6N6e3DClhZs3TCVt1tdQc77cLPxerkhbaHk2qqqBTwkEbjA696q
        Jgh0eDiE15I1t923HciVm/1IX1nvIOYM+65XXlZrfYoYgC3vb2HXo7XpFGPgJE93saBFHlrIk0cLV
        vIjrCfmicxgrJaQHs+CYxFnk6wq7LgYlPzVK/AC5Z6B7Z5ht4cXr0qPy7z8lFR11j8K7SW+FiWdkD
        iUU2pHH631+0XehEYg1oXBk+NNw3qIh2R20NkMi0IdxEfz+YUd0l01txTaB3fKUC42YpiSHhnm32u
        IjKIbavg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGNH7-0004sp-RP; Thu, 10 Sep 2020 14:10:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C9E4305815;
        Thu, 10 Sep 2020 16:10:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EEBCC2651245B; Thu, 10 Sep 2020 16:10:06 +0200 (CEST)
Date:   Thu, 10 Sep 2020 16:10:06 +0200
From:   peterz@infradead.org
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, anna-maria@linutronix.de,
        vbabka@suse.cz, mgorman@techsingularity.net, mhocko@suse.com,
        linux-mm@kvack.org
Subject: kcompactd hotplug fail
Message-ID: <20200910141006.GA1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While playing with hotplug, I ran into the below:

[ 2305.676384] ------------[ cut here ]------------
[ 2305.681543] WARNING: CPU: 1 PID: 15 at kernel/sched/core.c:1924 __set_cpus_allowed_ptr+0x1bd/0x230
[ 2305.691540] Modules linked in: kvm_intel kvm irqbypass rapl intel_cstate intel_uncore
[ 2305.700284] CPU: 1 PID: 15 Comm: cpuhp/1 Tainted: G        W         5.9.0-rc1-00126-g560d2f906d7e-dirty #392
[ 2305.711349] Hardware name: Intel Corporation S2600GZ/S2600GZ, BIOS SE5C600.86B.02.02.0002.122320131210 12/23/2013
[ 2305.722803] RIP: 0010:__set_cpus_allowed_ptr+0x1bd/0x230
[ 2305.728732] Code: ba 00 02 00 00 48 c7 c6 20 78 9e 82 4c 89 ef e8 19 ec 5f 00 85 c0 0f 85 5e ff ff ff 83 bb 60 03 00 00 01 0f 84 51 ff ff ff 90 <0f> 0b 90 e9 48 ff ff ff 83 bd 10 0a 00 00 02 48 89 5c 24 10 44 89
[ 2305.749687] RSP: 0000:ffffc900033dbdd8 EFLAGS: 00010002
[ 2305.755518] RAX: 0000000000000000 RBX: ffff88842c33cbc0 RCX: 0000000000000200
[ 2305.763478] RDX: 0000000000000008 RSI: ffffffff829e7820 RDI: ffffffff83055720
[ 2305.771439] RBP: ffff88842f43b4c0 R08: 0000000000000009 R09: ffffffff83055720
[ 2305.779399] R10: 0000000000000008 R11: 0000000000000000 R12: 00000000ffffffea
[ 2305.787360] R13: ffffffff83055720 R14: 000000000000000d R15: 00000000000000b6
[ 2305.795321] FS:  0000000000000000(0000) GS:ffff88842f480000(0000) knlGS:0000000000000000
[ 2305.804348] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2305.810760] CR2: 0000000000000000 CR3: 0000000002810001 CR4: 00000000001706e0
[ 2305.818720] Call Trace:
[ 2305.821454]  kcompactd_cpu_online+0xa1/0xb0
[ 2305.826119]  ? __compaction_suitable+0xa0/0xa0
[ 2305.831079]  cpuhp_invoke_callback+0x9a/0x360
[ 2305.835941]  cpuhp_thread_fun+0x19d/0x220
[ 2305.840414]  ? smpboot_thread_fn+0x1b4/0x280
[ 2305.845178]  ? smpboot_thread_fn+0x26/0x280
[ 2305.849842]  ? smpboot_register_percpu_thread+0xe0/0xe0
[ 2305.855672]  smpboot_thread_fn+0x1d0/0x280
[ 2305.860243]  kthread+0x153/0x170
[ 2305.863843]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 2305.869482]  ret_from_fork+0x22/0x30
[ 2305.873474] irq event stamp: 236
[ 2305.877067] hardirqs last  enabled at (235): [<ffffffff81cfad7c>] _raw_spin_unlock_irqrestore+0x4c/0x60
[ 2305.887550] hardirqs last disabled at (236): [<ffffffff81cf4050>] __schedule+0xc0/0xb10
[ 2305.896482] softirqs last  enabled at (0): [<ffffffff810b9849>] copy_process+0x889/0x1d40
[ 2305.905611] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 2305.912602] ---[ end trace e7f6c2a95b741e6b ]---


Given:


static int __init kcompactd_init(void)
{
	...
	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
					"mm/compaction:online",
					kcompactd_cpu_online, NULL);

and:


	CPUHP_AP_ONLINE_DYN,
	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
	CPUHP_AP_X86_HPET_ONLINE,
	CPUHP_AP_X86_KVM_CLK_ONLINE,
	CPUHP_AP_ACTIVE,

this is somewhat expected behaviour.

It tries and set the compaction affinity to include the newly onlined
CPU before it is marked active and that's a no-no.

Ideally the kcompactd notifier is ran after AP_ACTIVE, not before.
