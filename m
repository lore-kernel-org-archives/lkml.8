Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5ABC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0649B20709
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkynUYmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgIBEVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 00:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgIBEVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:21:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB9EC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 21:21:40 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u13so962208pgh.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 21:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LKQKhtIfhcA5XI/wQxsyuxsW3s34NXQ+H+5AvGC+LTs=;
        b=ZkynUYmUrQoKZjujvmP7eeV+8cjl83RY8NokImwNzx0bSYs2DqrkmIXtBkSnWJ0S2s
         eBG+KvCM/OJjJtvUgkqQckCs2lvU6xxC7mSMGQ1I6xRUsGP6G1v4MdCUIncdVM24YiUk
         qvnIH2hWTCVwWceL8UqKcUsKr8v1Jj7ioobBcqJHrsHUEfq2KRv9i0i75+dGXqUCuCC/
         zBhd8lTY+5WZu207xifg9r12Y0vurIWe827o6voBFoK29HkLQp9sVNXMjy/8qLIRpKV/
         UPKoVQG7c2WStEIE0uP9FDlAbI1vvpPreUDIEe4O5X+qUGFwsvH5sqdTDI/BrI8ZhyUI
         e9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LKQKhtIfhcA5XI/wQxsyuxsW3s34NXQ+H+5AvGC+LTs=;
        b=twWH+aWkdP2a4BrXk9Mc0lohjYIC/Agdt+9c0WG9I5c/We//+MuacSJ97enPtEe0KF
         Fr9WGD14bItvzLCXyJApdQMhIOKm6kdDsqmEDjDy0DOwua2ftYQWnxfLRmsDprU3IhNe
         QytayLVRTv4Ho8Ll6mPcN/cTKEsFkjaPNzoSGNaHSxDVL9mKQJrnu/41QncH0R+O5Utr
         C3UGBRoWx4tS+ruspUDeY/LEBHTH0MuA4Slvw8iSrncqGj1Q+h3ws/B33loAMYGSLe5m
         BAiZhN776SzTbUiAjOXom6a8v2qtHq0g35MqMXr1Aw0LR2Em4J7XyYd++wOQHNXqESO/
         lwiQ==
X-Gm-Message-State: AOAM533nBvkU4b7KAqMO15IYgz9grRH+JOuDzvrU3hL/ARFYaBOIrhZ6
        un2kEgXoCvBZySUpTLFFvXACVUoCvHk=
X-Google-Smtp-Source: ABdhPJxLeILlZrTIve9BT8pCu/40W58I2Opn98UIpH2hTWZHjD24yAa9t8pIHzExvi7givMe3eRKjA==
X-Received: by 2002:a62:7b8d:: with SMTP id w135mr1455285pfc.79.1599020499896;
        Tue, 01 Sep 2020 21:21:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w6sm3511470pgr.82.2020.09.01.21.21.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Sep 2020 21:21:39 -0700 (PDT)
Date:   Tue, 1 Sep 2020 21:21:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH v2 10/11] lockdep: Only trace IRQ edges
Message-ID: <20200902042137.GA163925@roeck-us.net>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.723775490@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821085348.723775490@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 10:47:48AM +0200, Peter Zijlstra wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Problem:
> 
> 	raw_local_irq_save();
> 	local_irq_save();
> 	...
> 	local_irq_restore();
> 	raw_local_irq_restore();
> 
> existing instances:
> 
>  - lock_acquire()
>      raw_local_irq_save()
>      __lock_acquire()
>        arch_spin_lock(&graph_lock)
>          pv_wait() := kvm_wait() (same or worse for Xen/HyperV)
>            local_irq_save()
> 
>  - trace_clock_global()
>      raw_local_irq_save()
>      arch_spin_lock()
>        pv_wait() := kvm_wait()
> 	 local_irq_save()
> 
>  - apic_retrigger_irq()
>      raw_local_irq_save()
>      apic->send_IPI() := default_send_IPI_single_phys()
>        local_irq_save()
> 
> Possible solutions:
> 
>  A) make it work by enabling the tracing inside raw_*()
>  B) make it work by keeping tracing disabled inside raw_*()
> 
> Now, given that the only reason to use the raw_* variant is because you don't
> want tracing, A) seems like a weird option (although it can be done), so we
> pick B) and declare any code that ends up doing:
> 
> 	raw_local_irq_save()
> 	local_irq_save()
> 	lockdep_assert_irqs_disabled();
> 
> broken. AFAICT this problem has existed forever, the only reason it came
> up is because I changed IRQ tracing vs lockdep recursion and the first
> instance is fairly common, the other cases hardly ever happen.
> 

On sparc64, this patch results in the traceback below. The traceback is gone
after reverting the patch.

Guenter

---
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4875 check_flags.part.39+0x280/0x2a0
[    0.000000] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.9.0-rc3 #1
[    0.000000] Call Trace:
[    0.000000] [<0000000000469890>] __warn+0xb0/0xe0
[    0.000000] [<00000000004698fc>] warn_slowpath_fmt+0x3c/0x80
[    0.000000] [<00000000004cfce0>] check_flags.part.39+0x280/0x2a0
[    0.000000] [<00000000004cff18>] lock_acquire+0x218/0x4e0
[    0.000000] [<0000000000d740c8>] _raw_spin_lock+0x28/0x40
[    0.000000] [<00000000009870f4>] p1275_cmd_direct+0x14/0x60
[    0.000000] [<00000000009872cc>] prom_getproplen+0x4c/0x60
[    0.000000] [<0000000000987308>] prom_getproperty+0x8/0x80
[    0.000000] [<0000000000987390>] prom_getint+0x10/0x40
[    0.000000] [<00000000017df4b4>] prom_init+0x38/0x8c
[    0.000000] [<0000000000d6b558>] tlb_fixup_done+0x44/0x6c
[    0.000000] [<00000000ffd0e930>] 0xffd0e930
[    0.000000] irq event stamp: 1
[    0.000000] hardirqs last  enabled at (1): [<0000000000987124>] p1275_cmd_direct+0x44/0x60
[    0.000000] hardirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.000000] softirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.000000] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.000000] random: get_random_bytes called from print_oops_end_marker+0x30/0x60 with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] possible reason: unannotated irqs-off.

---
bisect log:

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
# bad: [044d0d6de9f50192f9697583504a382347ee95ca] lockdep: Only trace IRQ edges
git bisect bad 044d0d6de9f50192f9697583504a382347ee95ca
# good: [021c109330ebc1f54b546c63a078ea3c31356ecb] arm64: Implement arch_irqs_disabled()
git bisect good 021c109330ebc1f54b546c63a078ea3c31356ecb
# good: [99dc56feb7932020502d40107a712fa302b32082] mips: Implement arch_irqs_disabled()
git bisect good 99dc56feb7932020502d40107a712fa302b32082
# first bad commit: [044d0d6de9f50192f9697583504a382347ee95ca] lockdep: Only trace IRQ edges
