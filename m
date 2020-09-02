Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5F7C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ADAD206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlekZuAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIBDvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 23:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBDvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 23:51:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8C5C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 20:51:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d22so2085665pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 20:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TgNFIclCjKBVcMLVGnTR8noskX1L4KnNRWG9Uvk7Vuo=;
        b=nlekZuABKBYMISQ00I6SyeAtmaxW0Eg0yxoNp5tD7udQChmUhYPHvOzHX/89Jc4Ngm
         N07/hLniY6BqxYspJ+Ve98aN8xZ7kd20jm42P73IWXuJZOna5rNlbEQavIwBUMdSVO8R
         HeMy6vBNpotT8ssnX+A6ShEo5r80lSc671A3EeetVUGHHfeu2RmLnFPhuOSXF+7Twg6X
         hvCv53NfuC8sHF/LSBl4uZ8XzG7qq4bJMkLyuCAyEUxgF18wPSBMpxPSoiAhZABqECub
         sbo0UixaOq/za9/BIdNYEr2pNYXfSzyo9CJpJv18MfvV8ANxJ6CSLbnYU4rMfCoOhuVw
         UpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TgNFIclCjKBVcMLVGnTR8noskX1L4KnNRWG9Uvk7Vuo=;
        b=GWbyUQ8kv5B/lM0EbrW8XNzutX/JJXDBg0TRq2W/YS5xNCfP5dGfFkHYyOxEW4Z0rn
         IDe6CAuQFH0qWQAZEKx/rqukKVcfBLIiBX/PGHDz1qHFqfrFI/u4tvCeFwyi08OixaN+
         nvVXVGrrL2ZhbotzI55bxnA5zU1aNIAbrekZ/BJ4QnO9p2gvUzsH51PKjwSWbzLn0Y7w
         oSt08/K69WuHI6AIPQ3aEUPUxqOc70Gl9yi6oEVS4DcJNRv4uL0AimMRmnXXCnvOVZM/
         gJu5lKD17MTWZgDhdwcIuCKYJEF4wIbUakc4dF8H89R8p9OrDGsUH2nigVVPGJCFflPq
         ikng==
X-Gm-Message-State: AOAM531Ogqyq8X/ViO0IcSvm4BKegv2nPxOe3yJ/nM5mpGFgVY9N/qEh
        QUoklhqxADpnTG8HObqWiAA=
X-Google-Smtp-Source: ABdhPJwZyfL7VWqKqenw0H1nmOi7MunU7ENyk9pYU11nO66Mzd4ul4EwIAukhvezsaL72QFteTzdoA==
X-Received: by 2002:a63:6cc4:: with SMTP id h187mr364956pgc.129.1599018708876;
        Tue, 01 Sep 2020 20:51:48 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k4sm3914501pfp.189.2020.09.01.20.51.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Sep 2020 20:51:47 -0700 (PDT)
Date:   Tue, 1 Sep 2020 20:51:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH v2 11/11] lockdep,trace: Expose tracepoints
Message-ID: <20200902035146.GA45826@roeck-us.net>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.782688941@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821085348.782688941@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 10:47:49AM +0200, Peter Zijlstra wrote:
> The lockdep tracepoints are under the lockdep recursion counter, this
> has a bunch of nasty side effects:
> 
>  - TRACE_IRQFLAGS doesn't work across the entire tracepoint
> 
>  - RCU-lockdep doesn't see the tracepoints either, hiding numerous
>    "suspicious RCU usage" warnings.
> 
> Pull the trace_lock_*() tracepoints completely out from under the
> lockdep recursion handling and completely rely on the trace level
> recusion handling -- also, tracing *SHOULD* not be taking locks in any
> case.
> 

Wonder what is worse - the problem or its fix. This patch results in
a number of WARNING backtraces for several archtectures/platforms.
Reverting it fixes the problems.

Guenter

---
arm:

[   27.055084]
[   27.056213] =============================
[   27.056274] WARNING: suspicious RCU usage
[   27.056335] 5.9.0-rc3 #1 Not tainted
[   27.056396] -----------------------------
[   27.056457] include/trace/events/lock.h:13 suspicious rcu_dereference_check() usage!
[   27.056549]
[   27.056549] other info that might help us debug this:
[   27.056549]
[   27.056640]
[   27.056640] rcu_scheduler_active = 2, debug_locks = 1
[   27.056732] RCU used illegally from extended quiescent state!
[   27.056793] no locks held by swapper/0/0.
[   27.056854]
[   27.056854] stack backtrace:
[   27.056915] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
[   27.057006] Hardware name: Generic OMAP3-GP (Flattened Device Tree)
[   27.057098] [<c03125b4>] (unwind_backtrace) from [<c030c32c>] (show_stack+0x10/0x14)
[   27.057189] [<c030c32c>] (show_stack) from [<c08e7a4c>] (dump_stack+0xd8/0xf8)
[   27.057312] [<c08e7a4c>] (dump_stack) from [<c03b04bc>] (lock_acquire+0x4d8/0x4dc)
[   27.057464] [<c03b04bc>] (lock_acquire) from [<c12457e8>] (_raw_spin_lock_irqsave+0x58/0x74)
[   27.057617] [<c12457e8>] (_raw_spin_lock_irqsave) from [<c0338198>] (pwrdm_lock+0x10/0x18)
[   27.057739] [<c0338198>] (pwrdm_lock) from [<c033a214>] (clkdm_deny_idle+0x10/0x24)
[   27.057891] [<c033a214>] (clkdm_deny_idle) from [<c0332e10>] (omap3_enter_idle_bm+0xd4/0x1b8)
[   27.058044] [<c0332e10>] (omap3_enter_idle_bm) from [<c0f740d4>] (cpuidle_enter_state+0x16c/0x620)
[   27.058197] [<c0f740d4>] (cpuidle_enter_state) from [<c0f745ec>] (cpuidle_enter+0x50/0x54)
[   27.058349] [<c0f745ec>] (cpuidle_enter) from [<c0383aac>] (do_idle+0x228/0x2b8)
[   27.058471] [<c0383aac>] (do_idle) from [<c0383f34>] (cpu_startup_entry+0x18/0x1c)
[   27.058624] [<c0383f34>] (cpu_startup_entry) from [<c1c00e8c>] (start_kernel+0x518/0x558)
[   27.059692]
[   27.059753] =============================
[   27.059753] WARNING: suspicious RCU usage
[   27.059753] 5.9.0-rc3 #1 Not tainted
[   27.059753] -----------------------------
[   27.059753] include/trace/events/lock.h:58 suspicious rcu_dereference_check() usage!
[   27.059783]
[   27.059783] other info that might help us debug this:
[   27.059783]
[   27.059783]
[   27.059783] rcu_scheduler_active = 2, debug_locks = 1
[   27.059783] RCU used illegally from extended quiescent state!
[   27.059783] 1 lock held by swapper/0/0:
[   27.059814]  #0: c1e30f3c (logbuf_lock){-...}-{2:2}, at: vprintk_emit+0x60/0x38c
[   27.059906]
[   27.059936] stack backtrace:
[   27.059936] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
[   27.059936] Hardware name: Generic OMAP3-GP (Flattened Device Tree)
[   27.059936] [<c03125b4>] (unwind_backtrace) from [<c030c32c>] (show_stack+0x10/0x14)
[   27.059936] [<c030c32c>] (show_stack) from [<c08e7a4c>] (dump_stack+0xd8/0xf8)
[   27.059936] [<c08e7a4c>] (dump_stack) from [<c03b4e70>] (lock_release+0x41c/0x420)
[   27.059936] [<c03b4e70>] (lock_release) from [<c124598c>] (_raw_spin_unlock+0x14/0x38)
[   27.059967] [<c124598c>] (_raw_spin_unlock) from [<c03c34c8>] (vprintk_emit+0xb4/0x38c)
[   27.059967] [<c03c34c8>] (vprintk_emit) from [<c03c37c0>] (vprintk_default+0x20/0x28)
[   27.059967] [<c03c37c0>] (vprintk_default) from [<c03c4088>] (printk+0x30/0x5c)
[   27.059967] [<c03c4088>] (printk) from [<c03b6c0c>] (lockdep_rcu_suspicious+0x2c/0xec)
[   27.059967] [<c03b6c0c>] (lockdep_rcu_suspicious) from [<c03b04bc>] (lock_acquire+0x4d8/0x4dc)
[   27.059967] [<c03b04bc>] (lock_acquire) from [<c12457e8>] (_raw_spin_lock_irqsave+0x58/0x74)
[   27.059997] [<c12457e8>] (_raw_spin_lock_irqsave) from [<c0338198>] (pwrdm_lock+0x10/0x18)
[   27.059997] [<c0338198>] (pwrdm_lock) from [<c033a214>] (clkdm_deny_idle+0x10/0x24)
[   27.059997] [<c033a214>] (clkdm_deny_idle) from [<c0332e10>] (omap3_enter_idle_bm+0xd4/0x1b8)
[   27.059997] [<c0332e10>] (omap3_enter_idle_bm) from [<c0f740d4>] (cpuidle_enter_state+0x16c/0x620)
[   27.059997] [<c0f740d4>] (cpuidle_enter_state) from [<c0f745ec>] (cpuidle_enter+0x50/0x54)
[   27.059997] [<c0f745ec>] (cpuidle_enter) from [<c0383aac>] (do_idle+0x228/0x2b8)
[   27.059997] [<c0383aac>] (do_idle) from [<c0383f34>] (cpu_startup_entry+0x18/0x1c)
[   27.060028] [<c0383f34>] (cpu_startup_entry) from [<c1c00e8c>] (start_kernel+0x518/0x558)

s390:

[   19.490586] =============================
[   19.490752] WARNING: suspicious RCU usage
[   19.490921] 5.9.0-rc3 #1 Not tainted
[   19.491086] -----------------------------
[   19.491253] include/trace/events/lock.h:37 suspicious rcu_dereference_check() usage!
[   19.491418]
[   19.491418] other info that might help us debug this:
[   19.491418]
[   19.491613]
[   19.491613] rcu_scheduler_active = 2, debug_locks = 1
[   19.491779] RCU used illegally from extended quiescent state!
[   19.491950] no locks held by swapper/0/0.
[   19.492118]
[   19.492118] stack backtrace:
[   19.492292] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
[   19.492458] Hardware name: QEMU 2964 QEMU (KVM/Linux)
[   19.492622] Call Trace:
[   19.492798]  [<00000000001164f2>] show_stack+0x9a/0x100
[   19.492972]  [<0000000000982b94>] dump_stack+0x9c/0xd0
[   19.493147]  [<00000000001d5de2>] lock_acquire+0x41a/0x498
[   19.493320]  [<0000000000103b72>] enabled_wait+0xca/0x198
[   19.493493]  [<0000000000103f80>] arch_cpu_idle+0x20/0x38
[   19.493667]  [<0000000000e03c30>] default_idle_call+0x98/0x300
[   19.493847]  [<000000000019958c>] do_idle+0xe4/0x190
[   19.494021]  [<00000000001998f4>] cpu_startup_entry+0x34/0x38
[   19.494196]  [<00000000013a297a>] arch_call_rest_init+0x92/0x98
[   19.494362] no locks held by swapper/0/0.
[   19.497570]
[   19.497595] =============================
[   19.497605] WARNING: suspicious RCU usage
[   19.497614] 5.9.0-rc3 #1 Not tainted
[   19.497624] -----------------------------
[   19.497634] include/trace/events/lock.h:63 suspicious rcu_dereference_check() usage!
[   19.497643]
[   19.497652] other info that might help us debug this:
[   19.497661]
[   19.497669]
[   19.497679] rcu_scheduler_active = 2, debug_locks = 1
[   19.497689] RCU used illegally from extended quiescent state!
[   19.497698] 1 lock held by swapper/0/0:
[   19.497712]  #0: 0000000001252750 (logbuf_lock){-...}-{2:2}, at: vprintk_emit+0x70/0x368
[   19.497779]
[   19.497788] stack backtrace:
[   19.497797] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc3 #1
[   19.497807] Hardware name: QEMU 2964 QEMU (KVM/Linux)
[   19.497816] Call Trace:
[   19.497825]  [<00000000001164f2>] show_stack+0x9a/0x100
[   19.497835]  [<0000000000982b94>] dump_stack+0x9c/0xd0
[   19.497844]  [<00000000001d9914>] lock_release+0x334/0x350
[   19.497854]  [<0000000000e04354>] _raw_spin_unlock+0x2c/0x50
[   19.497863]  [<00000000001e6d5a>] vprintk_emit+0xb2/0x368
[   19.497873]  [<00000000001e704a>] vprintk_default+0x3a/0x48
[   19.497882]  [<00000000001e7b8c>] printk+0x4c/0x58
[   19.497892]  [<00000000001db3c2>] lockdep_rcu_suspicious+0x32/0x110
[   19.497902]  [<00000000001d5de2>] lock_acquire+0x41a/0x498
[   19.497911]  [<0000000000103b72>] enabled_wait+0xca/0x198
[   19.497921]  [<0000000000103f80>] arch_cpu_idle+0x20/0x38
[   19.497932]  [<0000000000e03c30>] default_idle_call+0x98/0x300
[   19.497943]  [<000000000019958c>] do_idle+0xe4/0x190
[   19.497954]  [<00000000001998f4>] cpu_startup_entry+0x34/0x38
[   19.497964]  [<00000000013a297a>] arch_call_rest_init+0x92/0x98
[   19.497974] 1 lock held by swapper/0/0:
[   19.497982]  #0: 0000000001252750 (logbuf_lock){-...}-{2:2}, at: vprintk_emit+0x70/0x368

Bisect log (for arm):

# bad: [f75aef392f869018f78cfedf3c320a6b3fcfda6b] Linux 5.9-rc3
# good: [1127b219ce9481c84edad9711626d856127d5e51] Merge tag 'fallthrough-fixes-5.9-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux
git bisect start 'f75aef392f86' '1127b219ce94'
# good: [8bb5021cc2ee5d5dd129a9f2f5ad2bb76eea297d] Merge tag 'powerpc-5.9-4' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good 8bb5021cc2ee5d5dd129a9f2f5ad2bb76eea297d
# good: [ceb2465c51195967f11f6507538579816ac67cb8] Merge tag 'irqchip-fixes-5.9-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent
git bisect good ceb2465c51195967f11f6507538579816ac67cb8
# bad: [b69bea8a657b681442765b06be92a2607b1bd875] Merge tag 'locking-urgent-2020-08-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad b69bea8a657b681442765b06be92a2607b1bd875
# good: [00b0ed2d4997af6d0a93edef820386951fd66d94] locking/lockdep: Cleanup
git bisect good 00b0ed2d4997af6d0a93edef820386951fd66d94
# good: [044d0d6de9f50192f9697583504a382347ee95ca] lockdep: Only trace IRQ edges
git bisect good 044d0d6de9f50192f9697583504a382347ee95ca
# good: [3edd8db2d53fe6c96ad66248bb1479ae62807268] Merge tag '5.9-rc2-smb-fix' of git://git.samba.org/sfrench/cifs-2.6
git bisect good 3edd8db2d53fe6c96ad66248bb1479ae62807268
# bad: [eb1f00237aca2e368b93db79303f8433d1976d10] lockdep,trace: Expose tracepoints
git bisect bad eb1f00237aca2e368b93db79303f8433d1976d10
# first bad commit: [eb1f00237aca2e368b93db79303f8433d1976d10] lockdep,trace: Expose tracepoints
