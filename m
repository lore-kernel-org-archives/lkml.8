Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8364EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECDE206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KtB3LGG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCMPmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:42:33 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33248 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgCMPmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:42:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id p62so13239006qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6/tSWTOSokDaSLggKP1HqKo4a75wbNfLxPcipQGdxLE=;
        b=KtB3LGG2Arpcozo/aW3qbochdvnzKEsD68N3u4qA7UcAAkoE+zoZyS6SIP9HrY0GPd
         Kj/YNL+tZLoNpTY/5B5tEGZpxbA0+r2O77lHf2LB/wtSyY+LANEwWgYvoA+/BrvF7jOj
         vI3Ghq3wtN888lFZQHO5DFf2WtvQINDtzT5mEZGkoJpn9vJqsTVGjPbAMjoyuudJ363f
         pOtL5xqfR85MvoDBcjj5Xj3neKQRL68tzXq2TSNgzvoCI/AG41LP7/QK38yr6EHrQ4QC
         E0Qf4buwvIlnCgYeq5H1DlaGqoXxdESCpaWKPmvTcBSVL+iua4lZtd0qGFbbbZAD6y0a
         czvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6/tSWTOSokDaSLggKP1HqKo4a75wbNfLxPcipQGdxLE=;
        b=VgjHVaa5wi8TCUoK+BpUikdiQO/5Ocz4KJp7eV/jb+rfWReiTPpKnZbEqlGs0syoGi
         RFGe81ZDVaTE2ML3IVIwxtjUQIWCJKUi3QhZhAqf1/cY71DL1tkWPB4SoLiiQLwZK6yb
         ptJn9zmYkJT/iAK9mJ/T97KxzDB1w6uQqVYhDR57X7tZZdzwh/DjsDpBrAqFEeTiq50y
         C3BGrX9rHl1lItA/RfezbBq4DejvopCpewHneHymRviryuxKejZoUpbQ7xtrVd5A2j82
         zTB8VyhVfEkeUFnGHIxKEScK+W5sF9oGar/WwjnaHQQNU8J58OmUfqHfB4p8u9AFAZof
         /wLw==
X-Gm-Message-State: ANhLgQ0q0xF5yMw5K3BFbSGCY2Nb0en8qLqxx6OlQNrwGzqJ2a1sbuqA
        Yt0ZuVSf2nViv16/z6FZ3DX3ZA==
X-Google-Smtp-Source: ADFU+vsx8SwoclhWQekqTzRhnlLJyG4LxqKx6O74Bj4Jt2Ygk+HDl8agn3DKIQ717jhgb2on9XnUNg==
X-Received: by 2002:ae9:f707:: with SMTP id s7mr6160432qkg.5.1584114150220;
        Fri, 13 Mar 2020 08:42:30 -0700 (PDT)
Received: from ovpn-127-199.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p35sm10245065qtk.2.2020.03.13.08.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 08:42:29 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de
Cc:     john.stultz@linaro.org, sboyd@kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] timer: silenct a lockdep splat with debugobjects
Date:   Fri, 13 Mar 2020 11:42:21 -0400
Message-Id: <20200313154221.1566-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

psi_enqueue() calls add_timer() with pi->lock and rq->lock held which
in-turn could allcate with debugobjcets in the locking order,

pi->lock
  rq->lock
    base->lock
      batched_entropy_u32.lock

while the random code could always call into the scheduler via
try_to_wake_up() in the locking order,

batched_entropy_u32.lock
  pi->lock

Thus, it could generate a lockdep splat below right after boot. Ideally,
psi_enqueue() might be able to be called without either pi->lock or
rq->lock held, but it is tricky to do.

Since,

1) debugobjects is only used in a debug kernel.
2) the chance to trigger a real deadlock is relative low.
3) once the splat happened, it will disable lockdep to prevent it from
   catching any more important issues later.

just silent the splat by temporarily lettting lockdep ignore lockes
inside debug_timer_activate() which sounds like a reasonable tradeoff
for debug kernels.

00: [  321.354464] WARNING: possible circular locking dependency detected
00: [  321.354479] 5.6.0-rc5-next-20200312+ #5 Not tainted
00: [  321.354489] ------------------------------------------------------
00: [  321.354501] swapper/0/0 is trying to acquire lock:
00: [  321.354512] 00000000163eaa48 (&p->pi_lock){-.-.}, at: try_to_wake_up+0xce
00: /0xd88
00: [  321.354543]
00: [  321.354543] but task is already holding lock:
00: [  321.354554] 000000004e23d1b8 (random_write_wait.lock){..-.}, at: __wake_up_common_lock+0xd2/0x140
__wake_up_common_lock at kernel/sched/wait.c:123 (discriminator 1)
00: [  321.354579]
00: [  321.354579] which lock already depends on the new lock.
00: [  321.354579]
00: [  321.354592]
00: [  321.354592] the existing dependency chain (in reverse order) is:
00: [  321.354604]
00: [  321.354604] -> #4 (random_write_wait.lock){..-.}:
00: [  321.354623]        lock_acquire+0x212/0x460
00: [  321.354640]        _raw_spin_lock_irqsave+0xc4/0xe0
00: [  321.354652]        __wake_up_common_lock+0xd2/0x140
00: [  321.354664]        __wake_up+0x2a/0x38
00: [  321.354680]        crng_reseed+0x7da/0xb70
00: [  321.354692]        _extract_crng+0xf6/0x100
00: [  321.354704]        crng_reseed+0x7a4/0xb70
00: [  321.354716]        _extract_crng+0xf6/0x100
00: [  321.354729]        get_random_u32+0x100/0x138
00: [  321.354746]        new_slab+0x188/0x760
00: [  321.354758]        ___slab_alloc+0x5d2/0x928
00: [  321.354771]        __slab_alloc+0x52/0x88
00: [  321.355194]        kmem_cache_alloc+0x34a/0x558
00: [  321.355213]        skb_clone+0x8c/0x138
00: [  321.355228]        arp_rcv+0x76/0x2d8
00: [  321.355244]        __netif_receive_skb_core+0xd08/0x1588
00: [  321.355258]        __netif_receive_skb_list_core+0x28a/0x530
00: [  321.355273]        netif_receive_skb_list_internal+0x4ae/0x760
00: [  321.355288]        napi_complete_done+0x178/0x320
00: [  321.355302]        qeth_poll+0xffa/0x1130
00: [  321.355315]        net_rx_action+0x30a/0x9e0
00: [  321.355330]        __do_softirq+0x1da/0xa28
00: [  321.355347]        do_softirq_own_stack+0xe4/0x100
00: [  321.355361]        irq_exit+0x148/0x1c0
00: [  321.355373]        do_IRQ+0xb8/0x108
00: [  321.355399]        io_int_handler+0x134/0x2c0
00: [  321.355412]        enabled_wait+0x64/0x168
00: [  321.355424]        enabled_wait+0x42/0x168
00: [  321.355435]        arch_cpu_idle+0xc2/0xc8
00: [  321.355447]        default_idle_call+0xdc/0xf8
00: [  321.355463]        do_idle+0x1fa/0x2a8
00: [  321.355474]        cpu_startup_entry+0x36/0x40
00: [  321.355490]        arch_call_rest_init+0xa8/0xb8
00: [  321.355501]
00: [  321.355501] -> #3 (batched_entropy_u32.lock){-.-.}:
00: [  321.355523]        lock_acquire+0x212/0x460
00: [  321.355536]        _raw_spin_lock_irqsave+0xc4/0xe0
00: [  321.355551]        get_random_u32+0x5a/0x138
00: [  321.355564]        new_slab+0x188/0x760
00: [  321.355576]        ___slab_alloc+0x5d2/0x928
00: [  321.355589]        __slab_alloc+0x52/0x88
00: [  321.355801]        kmem_cache_alloc+0x34a/0x558
00: [  321.355819]        fill_pool+0x29e/0x490
00: [  321.355835]        __debug_object_init+0xa0/0x828
00: [  321.355848]        debug_object_activate+0x200/0x368
00: [  321.355864]        add_timer+0x242/0x538
00: [  321.355877]        queue_delayed_work_on+0x13e/0x148
00: [  321.355893]        init_mm_internals+0x4c6/0x550
00: [  321.355905]        kernel_init_freeable+0x224/0x590
00: [  321.355921]        kernel_init+0x22/0x188
00: [  321.355933]        ret_from_fork+0x30/0x34
00: [  321.355942]
00: [  321.355942] -> #2 (&base->lock){-.-.}:
00: [  321.355961]        lock_acquire+0x212/0x460
00: [  321.355973]        _raw_spin_lock_irqsave+0xc4/0xe0
00: [  321.355986]        lock_timer_base+0xca/0x1a0
00: [  321.355998]        add_timer+0xe6/0x538
00: [  321.356010]        queue_delayed_work_on+0x13e/0x148
00: [  321.356025]        psi_task_change+0x510/0x8d0
00: [  321.356037]        activate_task+0x1f8/0x280
00: [  321.356050]        wake_up_new_task+0x410/0x7e0
00: [  321.356064]        _do_fork+0x24e/0xab0
00: [  321.356076]        kernel_thread+0xbc/0xd8
00: [  321.356089]        rest_init+0x36/0x338
00: [  321.356100]        arch_call_rest_init+0xa8/0xb8
00: [  321.356110]
00: [  321.356110] -> #1 (&rq->lock){-.-.}:
00: [  321.356127]        lock_acquire+0x212/0x460
00: [  321.356140]        _raw_spin_lock+0x4c/0x60
00: [  321.356152]        task_fork_fair+0x4a/0x270
00: [  321.356165]        sched_fork+0x262/0x3e0
00: [  321.356326]        copy_process+0x1160/0x2d20
00: [  321.356339]        _do_fork+0x134/0xab0
00: [  321.356351]        kernel_thread+0xbc/0xd8
00: [  321.356364]        rest_init+0x36/0x338
00: [  321.356376]        arch_call_rest_init+0xa8/0xb8
00: [  321.356385]
00: [  321.356385] -> #0 (&p->pi_lock){-.-.}:
00: [  321.356403]        check_noncircular+0x330/0x3d8
00: [  321.356416]        __lock_acquire+0x23d2/0x49f8
00: [  321.356428]        lock_acquire+0x212/0x460
00: [  321.356441]        _raw_spin_lock_irqsave+0xc4/0xe0
00: [  321.356454]        try_to_wake_up+0xce/0xd88
00: [  321.356470]        pollwake+0x118/0x160
00: [  321.356482]        __wake_up_common+0xf2/0x2e8
00: [  321.356495]        __wake_up_common_lock+0x100/0x140
00: [  321.356507]        __wake_up+0x2a/0x38
00: [  321.356519]        crng_reseed+0x7da/0xb70
00: [  321.356531]        _extract_crng+0xf6/0x100
00: [  321.356543]        crng_reseed+0x7a4/0xb70
00: [  321.356555]        _extract_crng+0xf6/0x100
00: [  321.356568]        get_random_u32+0x100/0x138
00: [  321.356581]        new_slab+0x188/0x760
00: [  321.356593]        ___slab_alloc+0x5d2/0x928
00: [  321.356606]        __slab_alloc+0x52/0x88
00: [  321.356619]        kmem_cache_alloc+0x34a/0x558
00: [  321.356632]        skb_clone+0x8c/0x138
00: [  321.356645]        arp_rcv+0x76/0x2d8
00: [  321.356658]        __netif_receive_skb_core+0xd08/0x1588
00: [  321.356673]        __netif_receive_skb_list_core+0x28a/0x530
00: [  321.356688]        netif_receive_skb_list_internal+0x4ae/0x760
00: [  321.356840]        napi_complete_done+0x178/0x320
00: [  321.356855]        qeth_poll+0xffa/0x1130
00: [  321.356867]        net_rx_action+0x30a/0x9e0
00: [  321.356880]        __do_softirq+0x1da/0xa28
00: [  321.356895]        do_softirq_own_stack+0xe4/0x100
00: [  321.356908]        irq_exit+0x148/0x1c0
00: [  321.356920]        do_IRQ+0xb8/0x108
00: [  321.356932]        io_int_handler+0x134/0x2c0
00: [  321.356945]        enabled_wait+0x64/0x168
00: [  321.356980]        enabled_wait+0x42/0x168
00: [  321.357004]        arch_cpu_idle+0xc2/0xc8
00: [  321.357018]        default_idle_call+0xdc/0xf8
00: [  321.357032]        do_idle+0x1fa/0x2a8
00: [  321.357043]        cpu_startup_entry+0x36/0x40
00: [  321.357057]        arch_call_rest_init+0xa8/0xb8
00: [  321.357067]
00: [  321.357067] other info that might help us debug this:
00: [  321.357067]
00: [  321.357084] Chain exists of:
00: [  321.357084]   &p->pi_lock --> batched_entropy_u32.lock --> random_write_wait.lock
00: [  321.357084]
00: [  321.357108]  Possible unsafe locking scenario:
00: [  321.357108]
00: [  321.357119]        CPU0                    CPU1
00: [  321.357129]        ----                    ----
00: [  321.357138]   lock(random_write_wait.lock);
00: [  321.357149]                                lock(batched_entropy_u32.lock);
00: [  321.357163]                                lock(random_write_wait.lock);
00: [  321.357177]   lock(&p->pi_lock);
00: [  321.357337]
00: [  321.357337]  *** DEADLOCK ***
00: [  321.357337]
00: [  321.357351] 3 locks held by swapper/0/0:
00: [  321.357360]  #0: 000000004df6a1a0 (rcu_read_lock){....}, at: netif_receive_skb_list_internal+0x27c/0x760
00: [  321.357387]  #1: 000000006cfe3840 (batched_entropy_u32.lock){-.-.}, at: get_random_u32+0x5a/0x138
00: [  321.357411]  #2: 000000004e23d1b8 (random_write_wait.lock){..-.}, at: __wake_up_common_lock+0xd2/0x140
00: [  321.357434]
00: [  321.357434] stack backtrace:
00: [  321.357451] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc5-next-20200312+ #5
00: [  321.357465] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
00: [  321.357476] Call Trace:
00: [  321.357491]  [<000000004d12def0>] show_stack+0x118/0x1b8
00: [  321.357506]  [<000000004da308de>] dump_stack+0x12e/0x180
00: [  321.357521]  [<000000004d224218>] check_noncircular+0x330/0x3d8
00: [  321.357535]  [<000000004d22a82a>] __lock_acquire+0x23d2/0x49f8
00: [  321.357550]  [<000000004d2274aa>] lock_acquire+0x212/0x460
00: [  321.357564]  [<000000004da6bf6c>] _raw_spin_lock_irqsave+0xc4/0xe0
00: [  321.357579]  [<000000004d1bf9f6>] try_to_wake_up+0xce/0xd88
00: [  321.357594]  [<000000004d53a748>] pollwake+0x118/0x160
00: [  321.357607]  [<000000004d1ffb8a>] __wake_up_common+0xf2/0x2e8
00: [  321.357622]  [<000000004d1ffe80>] __wake_up_common_lock+0x100/0x140
00: [  321.357654]  [<000000004d1ffeea>] __wake_up+0x2a/0x38
00: [  321.357669]  [<000000004d77cef2>] crng_reseed+0x7da/0xb70
00: [  321.357683]  [<000000004d77d37e>] _extract_crng+0xf6/0x100
00: [  321.357834]  [<000000004d77cebc>] crng_reseed+0x7a4/0xb70
00: [  321.357849]  [<000000004d77d37e>] _extract_crng+0xf6/0x100
00: [  321.357865]  [<000000004d77e1e0>] get_random_u32+0x100/0x138
00: [  321.357880]  [<000000004d4ad5a8>] new_slab+0x188/0x760
00: [  321.357895]  [<000000004d4b0cea>] ___slab_alloc+0x5d2/0x928
00: [  321.357911]  [<000000004d4b1092>] __slab_alloc+0x52/0x88
00: [  321.357925]  [<000000004d4b1412>] kmem_cache_alloc+0x34a/0x558
00: [  321.357939]  [<000000004d88b79c>] skb_clone+0x8c/0x138
00: [  321.357953]  [<000000004d9c7da6>] arp_rcv+0x76/0x2d8
00: [  321.357968]  [<000000004d8bd170>] __netif_receive_skb_core+0xd08/0x1588
00: [  321.358018]  [<000000004d8bec1a>] __netif_receive_skb_list_core+0x28a/0x5
00: [  321.358045]  [<000000004d8bf36e>] netif_receive_skb_list_internal+0x4ae/0
00: [  321.358062]  [<000000004d8c2050>] napi_complete_done+0x178/0x320
00: [  321.358077]  [<000000004d858a8a>] qeth_poll+0xffa/0x1130
00: [  321.358093]  [<000000004d8c2f8a>] net_rx_action+0x30a/0x9e0
00: [  321.358108]  [<000000004da6e272>] __do_softirq+0x1da/0xa28
00: [  321.358124]  [<000000004d124cc4>] do_softirq_own_stack+0xe4/0x100
00: [  321.358164]  [<000000004d16fa00>] irq_exit+0x148/0x1c0
00: [  321.358179]  [<000000004d124480>] do_IRQ+0xb8/0x108
00: [  321.358194]  [<000000004da6d4a4>] io_int_handler+0x134/0x2c0
00: [  321.358208]  [<000000004d115d84>] enabled_wait+0x64/0x168
00: [  321.358247] ([<000000004d115d62>] enabled_wait+0x42/0x168)
00: [  321.358263]  [<000000004d116212>] arch_cpu_idle+0xc2/0xc8
00: [  321.358277]  [<000000004da6bc2c>] default_idle_call+0xdc/0xf8
00: [  321.358292]  [<000000004d1cb872>] do_idle+0x1fa/0x2a8
00: [  321.358458]  [<000000004d1cbd0e>] cpu_startup_entry+0x36/0x40
00: [  321.358473]  [<000000004e40c098>] arch_call_rest_init+0xa8/0xb8
00: [  321.358484] INFO: lockdep is turned off.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/time/timer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4820823515e9..27bfb8376d71 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1036,7 +1036,13 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 		}
 	}
 
+	/*
+	 * It will allocate under rq->lock and trigger a lockdep slat with
+	 * random code. Don't disable lockdep with debugobjects.
+	 */
+	lockdep_off();
 	debug_timer_activate(timer);
+	lockdep_on();
 
 	timer->expires = expires;
 	/*
-- 
2.21.0 (Apple Git-122.2)

