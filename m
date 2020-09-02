Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE35C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 05:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367D420758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 05:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBFju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 01:39:50 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:48902 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgIBFjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 01:39:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 3D18B200FEC7;
        Wed,  2 Sep 2020 13:39:45 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6QfhGBe3Q0fI; Wed,  2 Sep 2020 13:39:45 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 1AA39200FEC1;
        Wed,  2 Sep 2020 13:39:45 +0800 (HKT)
Received: from [10.128.3.2] (061244237146.static.ctinets.com [61.244.237.146])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 05A47C01B69;
        Wed,  2 Sep 2020 13:39:44 +0800 (HKT)
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: v4.9.234, WARNING: CPU: 1 PID: 166 at kernel/locking/lockdep.c:3326
Message-ID: <325dc67c-308d-d66f-23ee-a9857d82bb64@gtsys.com.hk>
Date:   Wed, 2 Sep 2020 13:39:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

have a reproachable kernel crash oops after update to 4.9.234
IMX6DL boot process.

Regards
Chris

[  OK  ] Started Various fixups to make systemd work better on Debian.
[    3.635568] ------------[ cut here ]------------
[    3.640597] WARNING: CPU: 1 PID: 166 at kernel/locking/lockdep.c:3326 
__lock_acquire+0x58c/0x1cf0
[    3.649480] DEBUG_LOCKS_WARN_ON(class_idx > MAX_LOCKDEP_KEYS)[ 
3.655058] Modules linked in:
[    3.658131] CPU: 1 PID: 166 Comm: systemd-cgroups Not tainted 4.9.234 #57
[    3.664927] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    3.671458] Backtrace:
[    3.673949] [<c010b1c8>] (dump_backtrace) from [<c010b478>] 
(show_stack+0x18/0x1c)
[    3.681526]  r6:60000093 r5:00000000 r4:c0d1d434 r3:00000000
[    3.687202] [<c010b460>] (show_stack) from [<c03ab94c>] 
(dump_stack+0xf0/0x11c)
[    3.694528] [<c03ab85c>] (dump_stack) from [<c01246ac>] 
(__warn+0xec/0x104)
[    3.701498]  r8:00000cfe r7:00000009 r6:c0aebbc0 r5:00000000 
r4:ec86fd38 r3:00000001
[    3.709249] [<c01245c0>] (__warn) from [<c0124704>] 
(warn_slowpath_fmt+0x40/0x48)
[    3.716739]  r9:ee1c6560 r8:00000002 r7:ee1c6000 r6:c0d1d508 
r5:c14dc0ac r4:c0ae8f88
[    3.724492] [<c01246c8>] (warn_slowpath_fmt) from [<c0173080>] 
(__lock_acquire+0x58c/0x1cf0)
[    3.732933]  r3:c0aecb48 r2:c0ae8f88
[    3.736511]  r4:c3c3c50c
[    3.739052] [<c0172af4>] (__lock_acquire) from [<c0174c0c>] 
(lock_acquire+0x78/0x98)
[    3.746801]  r10:b6fa9000 r9:ee7a0480 r8:c0d51598 r7:00000001 
r6:00000080 r5:60000093
[    3.754632]  r4:00000000
[    3.757180] [<c0174b94>] (lock_acquire) from [<c080b2b8>] 
(_raw_spin_lock_irq+0x5c/0x6c)
[    3.765275]  r7:b6fa9000 r6:ed9fe118 r5:c01fbc08 r4:ed9fe118
[    3.770946] [<c080b25c>] (_raw_spin_lock_irq) from [<c01fbc08>] 
(__vma_link_file+0x80/0x98)
[    3.779299]  r5:ec9009f8 r4:ed9fe10c
[    3.782882] [<c01fbb88>] (__vma_link_file) from [<c01fc528>] 
(__vma_adjust+0xc4/0x664)
[    3.790803]  r6:ec900840 r5:ec900c08 r4:ec900c44 r3:ec9009f8
[    3.796471] [<c01fc464>] (__vma_adjust) from [<c01fcbe4>] 
(__split_vma+0x11c/0x1b8)
[    3.804133]  r10:b6fa9000 r9:00000000 r8:c0d51598 r7:b6fa9000 
r6:00000000 r5:ec900c08
[    3.811964]  r4:ec9009f8
[    3.814507] [<c01fcac8>] (__split_vma) from [<c01fd6ac>] 
(split_vma+0x28/0x34)
[    3.821736]  r9:00100073 r8:ee7a0480 r7:b6fa8000 r6:00000000 
r5:00000000 r4:ec900c08
[    3.829487] [<c01fd684>] (split_vma) from [<c0200114>] 
(mprotect_fixup+0x244/0x274)
[    3.837151] [<c01ffed0>] (mprotect_fixup) from [<c0200298>] 
(do_mprotect_pkey+0x154/0x20c)
[    3.845420]  r10:0000007d r9:b6fa9000 r8:00000005 r7:00000001 
r6:00000000 r5:00000001
[    3.853252]  r4:b6fa9000
[    3.855794] [<c0200144>] (do_mprotect_pkey) from [<c0200364>] 
(SyS_mprotect+0x14/0x18)
[    3.863717]  r9:ec86e000 r8:c0107c44 r7:0000007d r6:b6f8a250 
r5:b6fd3d98 r4:b6fd2c50
[    3.871469] [<c0200350>] (SyS_mprotect) from [<c0107a60>] 
(ret_fast_syscall+0x0/0x1c)
[    3.879306] ---[ end trace 890e4e38c95446ca ]---
