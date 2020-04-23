Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E52C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5193621744
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c16Sp4Er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgDWQlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729603AbgDWQlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:41:01 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D530C09B041
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:41:00 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id m18so7144306otq.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SOe0ETUVWf9QBhUpjdDzv1oJQEcA0KNgTGa9NeEMr3M=;
        b=c16Sp4EruLB1iph0N0Ak0Rkp4aDeehgaXEvCEFDv+BknoOtjMSCEyJHjB26awjErGj
         tLHXvhblOVboC1oICcDSSRxw20xkXdfUjtwffSZIJNuI3M4+zEYHjkRhdFmEhrLraHEf
         TzJYKBr5Rz+FjF93J6bnwT4Vgm6KT5gAzH3GvTZVFCY4nvojDQlIC3HEnN2lN1ahnHmT
         gcDTV1cf+yqPP+M7P9RQvnYB9dHvLMVE2sA1d+rgYmhKpGgw/3FTG4SCDAIdApqsn7Mg
         B3JgelWIXcPSjLY0nQTyujdpHZ9FTAi+1D98WG6Uec+/Qq7UPMEO5OOj4h5SON5oVL09
         YO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SOe0ETUVWf9QBhUpjdDzv1oJQEcA0KNgTGa9NeEMr3M=;
        b=XH2lvetPSzE5cJxe1SueDAxfGX5LbrAc1I21hQow5J5ycQDh+e7OJd8wYLKxmOgn9k
         syo82YxA/4I/9T05A98Ig6UciC2uzpZATxyv/M42MY5Y3YgdFe3xcxQeZU1jLseZA08z
         u4eykMYDO31wu+ATRUI6o4r+KRvxxx5JaVuPmXed3ghTl3ppMSo2BFRxDa0NvOUYvXEb
         esZAVDR2C9Oc5EG9tlQbN+mQ2OgfmurQ0DYSioabECRPFNLDqUAN3UTxkx4LFAZet+NB
         7IZ9QQxIoPFFUHfMavHD7dsDNrKmr9oN2hcP4ecvXWmikvespCZ6lUh+Rth2l62HRdzB
         YSrQ==
X-Gm-Message-State: AGi0PuZZSx3uOarsGuVX5rCeLcEgPZps7frV4MrwDI6/gAmdyNT6v5Ga
        NqW4v+66EQ4PvyGgIxIGAjQYhlfJmiblYY4s9KVwng==
X-Google-Smtp-Source: APiQypJhBwTJg4zN3XLVWcJZ4tqh+DW2MFd7y/lmmao9JYqUGgWMpV7N/EjcHGxyCOShg98r2Iucm44Nw0YtGSPpqZc=
X-Received: by 2002:a05:6830:22dc:: with SMTP id q28mr3954905otc.221.1587660059847;
 Thu, 23 Apr 2020 09:40:59 -0700 (PDT)
MIME-Version: 1.0
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 23 Apr 2020 09:40:47 -0700
Message-ID: <CALAqxLURuJ-tMxMY6Z2BvLmyd6X+w7SiSB5otoH6vx+NxJm-NA@mail.gmail.com>
Subject: BUG: Invalid wait context with 5.7-rc2?
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     lkml <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Folks,

Recently, I've seen some occasional hangs earlyish in boot on my
HiKey960 board with 5.7-rc1/rc2. The kernel isn't totally wedged as I
will see some kernel messages (firmware loading failures, etc) much
later if I leave it.  But oddly sysrq doesn't respond.

Figuring it must be some sort of deadlock, I added LOCKDEP and a bunch
of other debug options and started booting in a loop. So far I've not
been able to trigger the original problem, but I do see the following
every boot:

Curious if this was already on anyone's radar?

thanks
-john

[    2.111212] =============================
[    2.115256] [ BUG: Invalid wait context ]
[    2.119303] 5.7.0-rc2-00070-g4160a2ecd371 #247 Not tainted
[    2.124842] -----------------------------
[    2.128886] swapper/5/0 is trying to lock:
[    2.133019] ffffff8219c33258 (&pool->lock){..-.}-{3:3}, at:
__queue_work+0x108/0x7c8
[    2.140856] other info that might help us debug this:
[    2.145954] context-{2:2}
[    2.148593] 1 lock held by swapper/5/0:
[    2.152461]  #0: ffffffc011d749c8 (rcu_read_lock){....}-{1:3}, at:
__queue_work+0x48/0x7c8
[    2.160814] stack backtrace:
[    2.163719] CPU: 5 PID: 0 Comm: swapper/5 Not tainted
5.7.0-rc2-00070-g4160a2ecd371 #247
[    2.171891] Hardware name: HiKey960 (DT)
[    2.175847] Call trace:
[    2.178315]  dump_backtrace+0x0/0x1a8
[    2.182009]  show_stack+0x18/0x28
[    2.185354]  dump_stack+0xdc/0x148
[    2.188786]  __lock_acquire+0x5c0/0x1568
[    2.192744]  lock_acquire+0x100/0x378
[    2.196441]  _raw_spin_lock+0x64/0x108
[    2.200225]  __queue_work+0x108/0x7c8
[    2.203918]  queue_work_on+0xd0/0xf0
[    2.207526]  timers_update_nohz+0x28/0x38
[    2.211572]  tick_setup_sched_timer+0x110/0x178
[    2.216144]  hrtimer_run_queues+0x114/0x170
[    2.220365]  run_local_timers+0x30/0x70
[    2.224234]  update_process_times+0x28/0x58
[    2.228457]  tick_periodic+0x48/0x148
[    2.232151]  tick_handle_periodic+0x28/0xc8
[    2.236375]  arch_timer_handler_phys+0x2c/0x50
[    2.238026] VFS: Disk quotas dquot_6.6.0
[    2.240862]  handle_percpu_devid_irq+0xe0/0x460
[    2.240866]  generic_handle_irq+0x30/0x48
[    2.240868]  __handle_domain_irq+0x88/0xf8
[    2.240873]  gic_handle_irq+0x5c/0xb0
[    2.240877]  el1_irq+0xf4/0x1c0
[    2.240882]  arch_cpu_idle+0x2c/0x230
[    2.244918] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.249406]  default_idle_call+0x20/0x44
[    2.249409]  do_idle+0x1ec/0x2d0
[    2.249411]  cpu_startup_entry+0x24/0x48
[    2.249416]  secondary_start_kernel+0x160/0x210
