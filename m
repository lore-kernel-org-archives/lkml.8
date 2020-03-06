Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88F2C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE1F207FD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/jJLIWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgCFJuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:50:16 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:36180 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgCFJuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:50:16 -0500
Received: by mail-lj1-f174.google.com with SMTP id 195so1553141ljf.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 01:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=X4iWU+PNricn3LX28QiGaI9dpcW9GvtHEa2KhI4bUoc=;
        b=e/jJLIWOxUzjtvT67fBqtctitIU2GvqC5LTjaUSB//nbrIiaFLdml9UaIvBCkI2FiG
         rJlpl3Nrz2ApxcfSozKaZYwWb7yLrm6G6HBSbjBlHBOw1+yg7t2OVw4ANTobZbK1bqaS
         kKgZnnKN8oBNeBrZPi+gSrQXOVRF4FnQJH72eFI8U81olwEuy2tETUekwjB1gyXTeGTf
         BBEMrDEh7uISM2/tikVcPlacCcNdeYFqMaNp3PuwMUPGVz5/+TKoAd4vPL6ciYA2jmWC
         1pJ1AHIpfb8FkP7QB4LOJLDdJDCl7j5wTHRRm+BXzsK7dPhPsn9Qmt5KMwE+zpYR/JCl
         1fDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=X4iWU+PNricn3LX28QiGaI9dpcW9GvtHEa2KhI4bUoc=;
        b=HjzjppkUCykCMybM0iKn76FD+sdsrghrs1NmDjz9EasWvKEWfKQkSFdsr0qyJocL9p
         rW8SIozc99TyaTMurAm1akgm0a90WukxXc1L6/3Wzc2eDuw+HwLulZMmGRHuzA9Pr6af
         A6AGS8sdWV2c84m1Uw0XIHiGS8uoOQuIk7ubIbu3a3S8zOLfKk0/ZnxHKje/Syd29mtH
         nO0I6V2w4ZeSrTlhz1cEeEbbnJ2xdDvDC/0UpdwBPXv5wQRySjLfevUDE+r1e7ms/OUq
         RjCt7nLAJim3dDALyBDL3MBZ1eTe8McHQtfa5Q7r/FIvjysNBrUr93KpJhxvi6u94ouJ
         QEiQ==
X-Gm-Message-State: ANhLgQ0UYNk4ZXoUIpM8wOINMu8gmQQg1gBQoattf0rYuuHg97Qz9qwM
        SQpMqPLIqLMP+93pO1moc0Mk3yRccbxofWC1xspE8k2Qb253FA==
X-Google-Smtp-Source: ADFU+vthm617g5gQGf1l/4mANn7cZuYjsdsTZfheUeowTV5O5sBST+PDwFr+p2qijdOTlxvbnFWJ5brrpBpaTFH5uD0=
X-Received: by 2002:a05:651c:414:: with SMTP id 20mr1443556lja.165.1583488211243;
 Fri, 06 Mar 2020 01:50:11 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 6 Mar 2020 15:19:59 +0530
Message-ID: <CA+G9fYsHgBmYBsR1XA5zoa4B4YJ4f+tEpy+dBReT8J=OE4X=cA@mail.gmail.com>
Subject: WARNING: suspicious RCU usage 5.6.0-rc4-next-20200305 -
 kprobes.c:2240 RCU-list traversed in non-reader section
To:     open list <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        rostedt@goodmis.org, Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regression on Linux next 5.6.0-rc4-next-20200305
the "WARNING: suspicious RCU usage" on x86_64, i386, arm and arm64 boot log.

Steps to reproduce,
Boot linux next tag version 20200305 and on boot you notice below RCU warning.

x86_boot log,
--------------------
[    0.000000] Linux version 5.6.0-rc4-next-20200305 (oe-user@oe-host)
(gcc version 7.3.0 (GCC)) #1 SMP Thu Mar 5 07:09:13 UTC 2020
[    0.000000] Command line: root=/dev/nfs rw
nfsroot=10.66.16.116:/var/lib/lava/dispatcher/tmp/1269574/extract-nfsrootfs-nqxjbzn7,tcp,hard,intr
ip=dhcp console=ttyS0,115200n8 lava_mac=00:90:05:af:00:7d
<trim>
[    2.960824] =============================
[    2.964838] WARNING: suspicious RCU usage
[    2.968860] 5.6.0-rc4-next-20200305 #1 Not tainted
[    2.973659] -----------------------------
[    2.977670] /usr/src/kernel/drivers/iommu/dmar.c:366 RCU-list
traversed in non-reader section!!
[    2.986366]
[    2.986366] other info that might help us debug this:
[    2.986366]
[    2.994372]
[    2.994372] rcu_scheduler_active = 2, debug_locks = 1
[    3.000899] 1 lock held by swapper/0/1:
[    3.004736]  #0: ffffffffb6330aa8 (dmar_global_lock){+.+.}, at:
intel_iommu_init+0x14f/0x1610
[    3.013275]
[    3.013275] stack backtrace:
[    3.017635] CPU: 2 PID: 1 Comm: swapper/0 Not tainted
5.6.0-rc4-next-20200305 #1
[    3.018630] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[    3.018630] Call Trace:
[    3.018630]  dump_stack+0x7a/0xa5
[    3.018630]  lockdep_rcu_suspicious+0xc5/0x100
[    3.018630]  dmar_find_dmaru+0x7f/0x90
[    3.018630]  dmar_parse_one_drhd+0x21/0x550
[    3.018630]  dmar_walk_remapping_entries+0xa6/0x1d0
[    3.018630]  ? e820__memblock_setup+0x8c/0x8c
[    3.018630]  ? rdinit_setup+0x30/0x30
[    3.018630]  dmar_table_init+0xc8/0x157
[    3.018630]  ? dmar_free_dev_scope+0xe0/0xe0
[    3.018630]  ? intel_iommu_setup+0x21b/0x21b
[    3.018630]  ? __intel_map_single+0x210/0x210
[    3.018630]  ? dmar_find_dmaru+0x90/0x90
[    3.018630]  ? amd_iommu_apply_ivrs_quirks+0x17/0x17
[    3.018630]  intel_iommu_init+0x154/0x1610
[    3.018630]  ? lockdep_hardirqs_on+0xf6/0x190
[    3.018630]  ? kfree+0x184/0x2e0
[    3.018630]  ? trace_hardirqs_on+0x4c/0x100
[    3.018630]  ? unpack_to_rootfs+0x296/0x2c0
[    3.018630]  ? rdinit_setup+0x30/0x30
[    3.018630]  ? e820__memblock_setup+0x8c/0x8c
[    3.018630]  ? rdinit_setup+0x30/0x30
[    3.018630]  pci_iommu_init+0x1a/0x44
[    3.018630]  ? pci_iommu_init+0x1a/0x44
[    3.018630]  do_one_initcall+0x61/0x2f0
[    3.018630]  ? rdinit_setup+0x30/0x30
[    3.018630]  ? rcu_read_lock_sched_held+0x4f/0x80
[    3.018630]  kernel_init_freeable+0x219/0x279
[    3.018630]  ? rest_init+0x250/0x250
[    3.018630]  kernel_init+0xe/0x110
[    3.018630]  ret_from_fork+0x3a/0x50
<trim>
[   13.765411] =============================
[   13.765412] WARNING: suspicious RCU usage
[   13.765413] 5.6.0-rc4-next-20200305 #1 Not tainted
[   13.765414] -----------------------------
[   13.765415] /usr/src/kernel/kernel/kprobes.c:2240 RCU-list
traversed in non-reader section!!
[   13.765416]
[   13.765416] other info that might help us debug this:
[   13.765416]
[   13.765417]
[   13.765417] rcu_scheduler_active = 2, debug_locks = 1
[   13.765418] 2 locks held by systemd-modules/164:
[   13.765418]  #0: ffffffffb62834e8
((module_notify_list).rwsem){++++}, at:
blocking_notifier_call_chain+0x2f/0x70
[   13.765423]  #1: ffffffffb628abe0 (kprobe_mutex){+.+.}, at:
kprobes_module_callback+0x41/0x250
[   13.765427]
[   13.765427] stack backtrace:
[   13.765429] CPU: 3 PID: 164 Comm: systemd-modules Not tainted
5.6.0-rc4-next-20200305 #1
[   13.765430] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   13.765431] Call Trace:
[   13.765434]  dump_stack+0x7a/0xa5
[   13.765437]  lockdep_rcu_suspicious+0xc5/0x100
[   13.765442]  kprobes_module_callback+0x1b7/0x250
[   13.765445]  notifier_call_chain+0x4c/0x70
[   13.765449]  blocking_notifier_call_chain+0x49/0x70
[   13.765453]  do_init_module+0xa4/0x226
[   13.765456]  load_module+0x24e6/0x2ac0
[   13.765472]  __do_sys_finit_module+0xfc/0x120
[   13.884088]  ? __do_sys_finit_module+0xfc/0x120
[   13.888629]  __x64_sys_finit_module+0x1a/0x20
[   13.892980]  do_syscall_64+0x55/0x200
[   13.896638]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   13.901689] RIP: 0033:0x7fe279551f59
[   13.905259] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0f ff 2b 00 f7 d8 64 89
01 48
[   13.923998] RSP: 002b:00007ffd2560f0e8 EFLAGS: 00000206 ORIG_RAX:
0000000000000139
[   13.931564] RAX: ffffffffffffffda RBX: 000055d618061400 RCX: 00007fe279551f59
[   13.938694] RDX: 0000000000000000 RSI: 00007fe2798266a3 RDI: 0000000000000005
[   13.945819] RBP: 00007fe2798266a3 R08: 0000000000000000 R09: 0000000000000000
[   13.952942] R10: 0000000000000005 R11: 0000000000000206 R12: 0000000000000000
[   13.960066] R13: 0000000000020000 R14: 000055d617dab004 R15: 00007ffd2560f220

Full boot log link,
https://lkft.validation.linaro.org/scheduler/job/1269574#L1095

metadata:
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git branch: master
  git describe: next-20200305
  make_kernelversion: 5.6.0-rc4
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-next/719/config

-- 
Linaro LKFT
https://lkft.linaro.org
