Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38470C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE7220719
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rnoi6H+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgIJV6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgIJLn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:43:27 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5056EC0617A4;
        Thu, 10 Sep 2020 04:43:26 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lo4so8194670ejb.8;
        Thu, 10 Sep 2020 04:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=W1JDflo8cgm4wnW3SEWEeLep6SeHVGwwH72bCedaQio=;
        b=Rnoi6H+joWbARSCxl8x6FJqKLHSWV0pk8yXybey9Rxp9j3TKb/ze5Vl5jhhpCjDLSO
         ok0UVWHMyLN6Sbo1Y/oRQXSmdf/GN/vSwxrfBJBlgkfEj1brlNdm+885H2Xe/2ijqbtZ
         ur15wY+7IyuEIcbXHLRcuZ3j7fEmoeSBJqJ8y/uTwn0wfNevjvWAaK1IEQydQ9yINMce
         me3aZvVLbvazmGphG90Tde3b2fd3IUyEFBBvRoXKd5sVunjWjC4PrHx3jidVcmffAJMz
         cb9Bi+RDo8X+Tw04J43T+bi/TA512QHp9hd5r/coaP8xHdPzji9ciiUKa8PtmKOnTpBH
         vang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=W1JDflo8cgm4wnW3SEWEeLep6SeHVGwwH72bCedaQio=;
        b=tv2LTV2tExc6nKKr05Cu8ld7XGfuTeNgcfczC1cWsR4Ub2I3MPvGg7jRSYyidJruBf
         VfCCeRulZwpmdaF4bNznB+w6BCwk+Fe85wBXlciT0kzsLlJfwDGbFzFbQHGLVM4owSGX
         eAfBsHfMMgkIUu4COYTcQEwF09lDmO5jY91J8NSHMsXolPssk9Jm53FcHerAwhA763E1
         po5uTrE+27lbYT/S07Wel92b/aTfanODgDKS1A/2h3YVWSaxWkTKIsnsipX0hkL6tBQS
         qiDDm7W/9xU4zNncVEbBUl75HyTjeTwuDRVz0glApV9CrfUeGoPWl/nOpXIWgA9XQyaF
         ZirQ==
X-Gm-Message-State: AOAM532yHunvXETbs1l0rzweH5U5KpUkJoCU+An3weY90XLargaI6v+D
        VCrqmmmXQoxTW/48vavGl807d/x7jG0UQPj734lPgXik8kmkkw==
X-Google-Smtp-Source: ABdhPJwF0ksgguUN9gWBuFhnnJ+aMLRrdqYql/B1YWTkMs8Lu/P94YYrncfeOjcycJVULaT+3i5EPOMptbMITvPPNiA=
X-Received: by 2002:a17:907:110f:: with SMTP id qu15mr8806891ejb.359.1599738204481;
 Thu, 10 Sep 2020 04:43:24 -0700 (PDT)
MIME-Version: 1.0
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Thu, 10 Sep 2020 14:43:13 +0300
Message-ID: <CADxRZqwGH3c5SvByBB3WSQhR_0NLCY=3RZ6541m8afX-scA4HA@mail.gmail.com>
Subject: [sparc64] kernel OOPS bisected from "lockdep: improve
 current->(hard|soft)irqs_enabled synchronisation with actual irq state"
To:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The following git patch 044d0d6de9f50192f9697583504a382347ee95ca
(linux git master branch) introduced the following kernel OOPS upon
kernel boot on my sparc64 T5-2 ldom (VM):

$ uname -a
Linux ttip 5.9.0-rc2-00011-g044d0d6de9f5 #59 SMP Thu Sep 10 13:07:45
MSK 2020 sparc64 GNU/Linux

(OOPS is from the latest tag, but the same on commit above)
...
rcu: Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:4875 check_flags+0x9c/0x2c0
DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc4 #36
Call Trace:
[<00000000004727a8>] __warn+0xa8/0x120
[<0000000000472c10>] warn_slowpath_fmt+0x64/0x74
[<00000000004e859c>] check_flags+0x9c/0x2c0
[<0000000000c17ca0>] lock_is_held_type+0x20/0x140
[<00000000005095f4>] rcu_read_lock_sched_held+0x54/0xa0
[<00000000004ed4c0>] lock_acquire+0x120/0x480
[<0000000000c21610>] _raw_spin_lock+0x30/0x60
[<00000000009b9bdc>] p1275_cmd_direct+0x1c/0x60
[<00000000009b9ab0>] prom_startcpu_cpuid+0x30/0x40
[<00000000004427e4>] __cpu_up+0x184/0x3a0
[<0000000000474600>] bringup_cpu+0x20/0x120
[<000000000047378c>] cpuhp_invoke_callback+0xec/0x340
[<00000000004753d4>] cpu_up+0x154/0x220
[<0000000000475c60>] bringup_nonboot_cpus+0x60/0xa0
[<0000000000fbc338>] smp_init+0x28/0xa0
[<0000000000fad3b4>] kernel_init_freeable+0x18c/0x300
irq event stamp: 5135
hardirqs last  enabled at (5135): [<0000000000c21a28>]
_raw_spin_unlock_irqrestore+0x28/0x60
hardirqs last disabled at (5134): [<0000000000c217e0>]
_raw_spin_lock_irqsave+0x20/0x80
softirqs last  enabled at (1474): [<0000000000c245a0>] __do_softirq+0x4e0/0x560
softirqs last disabled at (1467): [<000000000042d394>]
do_softirq_own_stack+0x34/0x60
random: get_random_bytes called from __warn+0xc8/0x120 with crng_init=0
---[ end trace 4cf960ae85148e2e ]---
possible reason: unannotated irqs-off.
irq event stamp: 5135
hardirqs last  enabled at (5135): [<0000000000c21a28>]
_raw_spin_unlock_irqrestore+0x28/0x60
hardirqs last disabled at (5134): [<0000000000c217e0>]
_raw_spin_lock_irqsave+0x20/0x80
softirqs last  enabled at (1474): [<0000000000c245a0>] __do_softirq+0x4e0/0x560
softirqs last disabled at (1467): [<000000000042d394>]
do_softirq_own_stack+0x34/0x60
smp: Brought up 1 node, 32 CPUs
devtmpfs: initialized
...

full boot log in [1], kernel config in [2]

linux-2.6$ git bisect log
git bisect start
# good: [d012a7190fc1fd72ed48911e77ca97ba4521bccd] Linux 5.9-rc2
git bisect good d012a7190fc1fd72ed48911e77ca97ba4521bccd
# bad: [34d4ddd359dbcdf6c5fb3f85a179243d7a1cb7f8] Merge tag
'linux-kselftest-5.9-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
git bisect bad 34d4ddd359dbcdf6c5fb3f85a179243d7a1cb7f8
# bad: [e1d0126ca3a66c284a02b083a42e2b39558002cd] Merge tag
'xfs-5.9-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect bad e1d0126ca3a66c284a02b083a42e2b39558002cd
# good: [24148d8648e37f8c15bedddfa50d14a31a0582c5] Merge tag
'io_uring-5.9-2020-08-28' of git://git.kernel.dk/linux-block
git bisect good 24148d8648e37f8c15bedddfa50d14a31a0582c5
# bad: [b69bea8a657b681442765b06be92a2607b1bd875] Merge tag
'locking-urgent-2020-08-30' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad b69bea8a657b681442765b06be92a2607b1bd875
# good: [20934c0de13b49a072fb1e0ca79fe0fe0e40eae5] usb: storage: Add
unusual_uas entry for Sony PSZ drives
git bisect good 20934c0de13b49a072fb1e0ca79fe0fe0e40eae5
# good: [c4011283a7d5d64a50991dd3baa9acdf3d49092c] Merge tag
'dma-mapping-5.9-2' of git://git.infradead.org/users/hch/dma-mapping
git bisect good c4011283a7d5d64a50991dd3baa9acdf3d49092c
# good: [8bb5021cc2ee5d5dd129a9f2f5ad2bb76eea297d] Merge tag
'powerpc-5.9-4' of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good 8bb5021cc2ee5d5dd129a9f2f5ad2bb76eea297d
# good: [00b0ed2d4997af6d0a93edef820386951fd66d94] locking/lockdep: Cleanup
git bisect good 00b0ed2d4997af6d0a93edef820386951fd66d94
# bad: [044d0d6de9f50192f9697583504a382347ee95ca] lockdep: Only trace IRQ edges
git bisect bad 044d0d6de9f50192f9697583504a382347ee95ca
# good: [021c109330ebc1f54b546c63a078ea3c31356ecb] arm64: Implement
arch_irqs_disabled()
git bisect good 021c109330ebc1f54b546c63a078ea3c31356ecb
# good: [99dc56feb7932020502d40107a712fa302b32082] mips: Implement
arch_irqs_disabled()
git bisect good 99dc56feb7932020502d40107a712fa302b32082
# first bad commit: [044d0d6de9f50192f9697583504a382347ee95ca]
lockdep: Only trace IRQ edges


1. https://github.com/mator/sparc64-dmesg/blob/master/dmesg-5.9.0-rc4
2. https://github.com/mator/sparc64-dmesg/blob/master/config-5.9.0-rc4.gz
