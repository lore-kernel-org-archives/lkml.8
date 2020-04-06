Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEC0C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 02:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FBC20769
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 02:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/RUHsnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgDFCvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 22:51:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34042 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgDFCvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 22:51:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id a23so5357218plm.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 19:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qVmMl4mrtJRlr3vwlO0iUFusN/sBqN0+cctsLCUqzok=;
        b=V/RUHsnzpav2AZ7ys8IPEYbGHWLJCW9TKqAAQ7OdbWdXuirMw7SIGDgPIdwLQGV9WW
         DIxJj5/+Xk05ZBEwXPErZ59uvE68GHRmDTbJeF0pkIm3cZ8GFbSxBfmFGjAGwILDupeA
         fvRppBB8b3sllgBz4IkMr7Ek3lFQSuvpWkr/uC+eYWG8b7fOsRt2X94LQFrLaLvbLLDR
         2gE8vDkHO+2czM6YwT1G69YEV6ICAl4Hapzg0OKzXhE7KvsQbRtpmcnafZVK79dZQ2M3
         8p+nwKSOgX4fe3MzTkyxckLjVtS3NPcVRI2I5ZAXR9hi3XB7wuRk1zYdPJaLYI859Uyo
         lnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qVmMl4mrtJRlr3vwlO0iUFusN/sBqN0+cctsLCUqzok=;
        b=j5N0+ECnKtKYOvGEssJpjeCev800nEcGulGhrrPpdQXqUB2Dx3tB8ijtWnAW/6uTLj
         DTZPFc8BN5WFXqdkSKTK9h9KrjkfFSSjNY0Y60cw1GAhM5uBQmgtxEP+M7tKWgCH7fGx
         Ddq/7CcgHMM4Ag6oW7z3kObQzinH/m0cYmKOtjcB3+39j2CKOJR6yr87KGi+99n+gDIp
         AFNsE73HgYAb6Q0vtyA63H3ikdFakASjWMj7qGjm15Xn+8AXpAMJiwygmF++dsDgKRIZ
         0lb4w0fp59jndpjB1FnOgGZemacc9QJWHwLcBPx2QORYjT/8cjHW0dMJCNmrIFXXnj0q
         S3Vw==
X-Gm-Message-State: AGi0PuZCpOJ2+b7qR+VSIryjGv2Cu0fCU4LOBxs8j9nFalFTLa5E4p2Q
        JfP3U0/aCOwE0rCm939Kk8jM4pU=
X-Google-Smtp-Source: APiQypJD5usLFfYFDEEbQnVTsB7XI1J1qdT6IazEgfcXHBbdz8HTbPGB8Txp64SGlrhPLT+/C4EW7A==
X-Received: by 2002:a17:90a:22ab:: with SMTP id s40mr23210933pjc.24.1586141465676;
        Sun, 05 Apr 2020 19:51:05 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:13bf:1a76:f832:439c:9244:ba33])
        by smtp.gmail.com with ESMTPSA id s15sm10432180pfd.164.2020.04.05.19.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Apr 2020 19:51:03 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Mon, 6 Apr 2020 08:20:57 +0530
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Amol Grover <frextrite@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, philip.li@intel.com
Subject: Re: db4ead2cd5 ("Default enable RCU list lockdep debugging with
 .."): WARNING: suspicious RCU usage
Message-ID: <20200406025056.GA13310@madhuparna-HP-Notebook>
References: <5e89ae97.XlZ1PbIKMXWOOfLI%lkp@intel.com>
 <20200405145232.GY19865@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405145232.GY19865@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 05, 2020 at 07:52:32AM -0700, Paul E. McKenney wrote:
> On Sun, Apr 05, 2020 at 06:10:31PM +0800, kernel test robot wrote:
> > Greetings,
> > 
> > 0day kernel testing robot got the below dmesg and the first bad commit is
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.03.21a
> 
> Is some of the required conversion still left to be done?  Or on its
> way up some other tree?
> 
> If either of these two, my normal approach would be to hold this commit
> back in order to give the fixes time to hit mainline.
> 
> But either way, please let me know!
>
Yes, some of the patches are not yet reviewed by maintainers and we will
resend them. Also, this report reports a few new ones that we haven't
fixed yet (need some help from maintainers to do so).
We are working on fixing them. May be holding the commit is a
good idea.

Thank you,
Madhuparna
> 							Thanx, Paul
> 
> > commit db4ead2cd52533bf97d630f5561841246c5f3725
> > Author:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > AuthorDate: Fri Feb 28 14:54:51 2020 +0530
> > Commit:     Paul E. McKenney <paulmck@kernel.org>
> > CommitDate: Sat Mar 21 19:50:34 2020 -0700
> > 
> >     Default enable RCU list lockdep debugging with PROVE_RCU
> >     
> >     This patch default enables CONFIG_PROVE_RCU_LIST option with
> >     CONFIG_PROVE_RCU for RCU list lockdep debugging.
> >     
> >     With this change, RCU list lockdep debugging will be default
> >     enabled in CONFIG_PROVE_RCU=y kernels.
> >     
> >     Most of the RCU users (in core kernel/, drivers/, and net/
> >     subsystem) have already been modified to include lockdep
> >     expressions hence RCU list debugging can be enabled by
> >     default.
> >     
> >     However, there are still chances of enountering
> >     false-positive lockdep splats because not everything is converted,
> >     in case RCU list primitives are used in non-RCU read-side critical
> >     section but under the protection of a lock. It would be okay to
> >     have a few false-positives, as long as bugs are identified, since this
> >     patch only affects debugging kernels.
> >     
> >     Co-developed-by: Amol Grover <frextrite@gmail.com>
> >     Signed-off-by: Amol Grover <frextrite@gmail.com>
> >     Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >     Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > cf8f47c8ae  Documentation/locking/atomic: Add a litmus test smp_mb__after_atomic()
> > db4ead2cd5  Default enable RCU list lockdep debugging with PROVE_RCU
> > 7351c51a0d  MAINTAINERS: Update maintainers for new Documentaion/litmus-tests/
> > +-----------------------------------------------------------------------------+------------+------------+------------+
> > |                                                                             | cf8f47c8ae | db4ead2cd5 | 7351c51a0d |
> > +-----------------------------------------------------------------------------+------------+------------+------------+
> > | boot_successes                                                              | 32         | 0          | 0          |
> > | boot_failures                                                               | 1          | 15         | 11         |
> > | BUG:kernel_hang_in_boot_stage                                               | 1          |            |            |
> > | WARNING:suspicious_RCU_usage                                                | 0          | 15         | 10         |
> > | net/netfilter/ipset/ip_set_core.c:#RCU-list_traversed_in_non-reader_section | 0          | 15         | 10         |
> > | net/ipv6/ip6mr.c:#RCU-list_traversed_in_non-reader_section                  | 0          | 15         | 10         |
> > | net/caif/caif_dev.c:#RCU-list_traversed_in_non-reader_section               | 0          | 15         | 10         |
> > | kernel/kprobes.c:#RCU-list_traversed_in_non-reader_section                  | 0          | 4          |            |
> > | security/device_cgroup.c:#RCU-list_traversed_in_non-reader_section          | 0          | 1          |            |
> > | net/ipv4/fib_trie.c:#RCU-list_traversed_in_non-reader_section               | 0          | 1          | 2          |
> > | BUG:kernel_timeout_in_boot_stage                                            | 0          | 0          | 1          |
> > +-----------------------------------------------------------------------------+------------+------------+------------+
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > [   11.651810]     input device check on
> > [   11.652195]     Actions configured
> > [   11.652952] random: get_random_u32 called from bucket_table_alloc+0x1c9/0x1f0 with crng_init=0
> > [   11.653119] 
> > [   11.654186] =============================
> > [   11.654619] WARNING: suspicious RCU usage
> > [   11.655022] 5.6.0-rc1-00179-gdb4ead2cd5253 #1 Not tainted
> > [   11.655583] -----------------------------
> > [   11.656001] net/netfilter/ipset/ip_set_core.c:89 RCU-list traversed in non-reader section!!
> > [   11.657003] 
> > [   11.657003] other info that might help us debug this:
> > [   11.657003] 
> > [   11.657805] 
> > [   11.657805] rcu_scheduler_active = 2, debug_locks = 1
> > [   11.658478] 1 lock held by swapper/1:
> > [   11.658848]  #0: ffffffffaf73d3a8 (ip_set_type_mutex){+.+.}, at: ip_set_type_register+0xad/0x220
> > [   11.659741] 
> > [   11.659741] stack backtrace:
> > [   11.660184] CPU: 0 PID: 1 Comm: swapper Not tainted 5.6.0-rc1-00179-gdb4ead2cd5253 #1
> > [   11.660968] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > [   11.661802] Call Trace:
> > [   11.662068]  find_set_type+0x4e/0xd0
> > [   11.662469]  ip_set_type_register+0xcf/0x220
> > [   11.662903]  ? ip_set_net_init+0x173/0x173
> > [   11.663322]  ? rdinit_setup+0x3d/0x3d
> > [   11.663723]  do_one_initcall+0x180/0x3c0
> > [   11.664131]  ? boot_config_checksum+0x40/0x40
> > [   11.664624]  ? rdinit_setup+0x3d/0x3d
> > [   11.664994]  ? rcu_read_lock_sched_held+0x68/0x90
> > [   11.665496]  ? rdinit_setup+0x3d/0x3d
> > [   11.665862]  kernel_init_freeable+0x1e2/0x26a
> > [   11.666294]  ? rest_init+0x150/0x150
> > [   11.666691]  kernel_init+0xf/0x110
> > [   11.667034]  ? _raw_spin_unlock_irq+0x24/0x30
> > [   11.667493]  ? rest_init+0x150/0x150
> > [   11.667853]  ret_from_fork+0x3a/0x50
> > [   11.669523] random: get_random_u32 called from cache_alloc_refill+0x5e7/0xa90 with crng_init=0
> > [   11.669748] ipip: IPv4 and MPLS over IPv4 tunneling driver
> > [   11.674200] Initializing XFRM netlink socket
> > [   11.674883] random: get_random_u64 called from cache_random_seq_create+0x7b/0x160 with crng_init=0
> > [   11.676317] NET: Registered protocol family 10
> > [   11.677022] 
> > [   11.677242] =============================
> > [   11.677668] WARNING: suspicious RCU usage
> > [   11.678065] 5.6.0-rc1-00179-gdb4ead2cd5253 #1 Not tainted
> > [   11.678614] -----------------------------
> > [   11.679013] net/ipv6/ip6mr.c:123 RCU-list traversed in non-reader section!!
> > [   11.679880] 
> > [   11.679880] other info that might help us debug this:
> > [   11.679880] 
> > [   11.680672] 
> > [   11.680672] rcu_scheduler_active = 2, debug_locks = 1
> > [   11.681297] 1 lock held by swapper/1:
> > [   11.681690]  #0: ffffffffaf6da050 (pernet_ops_rwsem){+.+.}, at: register_pernet_subsys+0x15/0x40
> > [   11.682567] 
> > [   11.682567] stack backtrace:
> > [   11.682996] CPU: 0 PID: 1 Comm: swapper Not tainted 5.6.0-rc1-00179-gdb4ead2cd5253 #1
> > [   11.683765] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > [   11.684596] Call Trace:
> > [   11.684858]  ip6mr_get_table+0x49/0xb0
> > [   11.685240]  ip6mr_new_table+0x11/0x40
> > [   11.685650]  ip6mr_net_init+0xf0/0x208
> > [   11.686032]  ops_init+0x171/0x1a0
> > [   11.686512]  register_pernet_operations+0xe5/0x130
> > [   11.686985]  ? unix_sysctl_register+0xac/0xac
> > [   11.687449]  register_pernet_subsys+0x24/0x40
> > [   11.687898]  ip6_mr_init+0x42/0xe9
> > [   11.688247]  inet6_init+0x115/0x3a2
> > [   11.688630]  do_one_initcall+0x180/0x3c0
> > [   11.689024]  ? boot_config_checksum+0x40/0x40
> > [   11.689513]  ? rdinit_setup+0x3d/0x3d
> > [   11.689884]  ? rcu_read_lock_sched_held+0x68/0x90
> > [   11.690361]  ? rdinit_setup+0x3d/0x3d
> > [   11.690760]  kernel_init_freeable+0x1e2/0x26a
> > [   11.691193]  ? rest_init+0x150/0x150
> > [   11.691593]  kernel_init+0xf/0x110
> > [   11.691946]  ? _raw_spin_unlock_irq+0x24/0x30
> > [   11.692378]  ? rest_init+0x150/0x150
> > [   11.692764]  ret_from_fork+0x3a/0x50
> > [   11.753551] Segment Routing with IPv6
> > [   11.758974] NET: Registered protocol family 15
> > [   11.759476] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> > [   11.760073] Bluetooth: BNEP socket layer initialized
> > [   11.784884] NET: Registered protocol family 33
> > 
> >                                                           # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> > git bisect start 73b26e71d01ce8404dc027a706629e8929b36d1b bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9 --
> > git bisect  bad 34362bbc3d05f71ec02fcaa838ceede3d1630cf0  # 12:25  B      0     4   20   0  rcu: update.c: get rid of some doc warnings
> > git bisect good 748300715e5446d8c068a31cf175ff6176bf2b5c  # 12:55  G     10     0    0   0  rcutorture: Make kvm-recheck-rcu.sh handle truncated lines
> > git bisect good 4afdf88fdb2cde22a569131a5138fe25b76b4e84  # 13:19  G     11     0    1   1  Documentation/locking/atomic: Fix atomic-set litmus test
> > git bisect  bad c0b2582103dd8ecc5940c408476d157f375e1c35  # 14:42  B      0     2   18   0  tools/memory-model: Fix "conflict" definition
> > git bisect good f6640be5aa933c8463d537ef3194ae7f3ea86de0  # 15:20  G     10     0    0   0  Documentation/locking/atomic: Add a litmus test for atomic_set()
> > git bisect good cf8f47c8aeb07af6c4b2aeca776c273fdae0f532  # 15:52  G     10     0    0   0  Documentation/locking/atomic: Add a litmus test smp_mb__after_atomic()
> > git bisect  bad db4ead2cd52533bf97d630f5561841246c5f3725  # 16:12  B      0     1   17   0  Default enable RCU list lockdep debugging with PROVE_RCU
> > # first bad commit: [db4ead2cd52533bf97d630f5561841246c5f3725] Default enable RCU list lockdep debugging with PROVE_RCU
> > git bisect good cf8f47c8aeb07af6c4b2aeca776c273fdae0f532  # 16:23  G     31     0    0   1  Documentation/locking/atomic: Add a litmus test smp_mb__after_atomic()
> > # extra tests with debug options
> > git bisect  bad db4ead2cd52533bf97d630f5561841246c5f3725  # 16:59  B      0     4   20   0  Default enable RCU list lockdep debugging with PROVE_RCU
> > # extra tests on head commit of rcu/dev.2020.03.21a
> > git bisect  bad 7351c51a0dd642488f1889ba01e53258fa8ef419  # 17:37  B      0     1   17   0  MAINTAINERS: Update maintainers for new Documentaion/litmus-tests/
> > # bad: [7351c51a0dd642488f1889ba01e53258fa8ef419] MAINTAINERS: Update maintainers for new Documentaion/litmus-tests/
> > # extra tests on revert first bad commit
> > git bisect good b52d80817f291a4d33804db66576edda2c4b9c04  # 18:10  G     10     0    0   0  Revert "Default enable RCU list lockdep debugging with PROVE_RCU"
> > # good: [b52d80817f291a4d33804db66576edda2c4b9c04] Revert "Default enable RCU list lockdep debugging with PROVE_RCU"
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/lkp@lists.01.org
> 
> 
> 
> > #!/bin/bash
> > 
> > kernel=$1
> > initrd=yocto-x86_64-trinity.cgz
> > 
> > wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/$initrd
> > 
> > kvm=(
> > 	qemu-system-x86_64
> > 	-enable-kvm
> > 	-cpu Haswell,+smep,+smap
> > 	-kernel $kernel
> > 	-initrd $initrd
> > 	-m 8192
> > 	-smp 2
> > 	-device e1000,netdev=net0
> > 	-netdev user,id=net0,hostfwd=tcp::32032-:22
> > 	-boot order=nc
> > 	-no-reboot
> > 	-watchdog i6300esb
> > 	-watchdog-action debug
> > 	-rtc base=localtime
> > 	-serial stdio
> > 	-display none
> > 	-monitor null
> > )
> > 
> > append=(
> > 	root=/dev/ram0
> > 	hung_task_panic=1
> > 	debug
> > 	apic=debug
> > 	sysrq_always_enabled
> > 	rcupdate.rcu_cpu_stall_timeout=100
> > 	net.ifnames=0
> > 	printk.devkmsg=on
> > 	panic=-1
> > 	softlockup_panic=1
> > 	nmi_watchdog=panic
> > 	oops=panic
> > 	load_ramdisk=2
> > 	prompt_ramdisk=0
> > 	drbd.minor_count=8
> > 	systemd.log_level=err
> > 	ignore_loglevel
> > 	console=tty0
> > 	earlyprintk=ttyS0,115200
> > 	console=ttyS0,115200
> > 	vga=normal
> > 	rw
> > 	rcuperf.shutdown=0
> > 	watchdog_thresh=60
> > )
> > 
> > "${kvm[@]}" -append "${append[*]}"
> 
> 
> > #
> > # Automatically generated file; DO NOT EDIT.
> > # Linux/x86_64 5.6.0-rc1 Kernel Configuration
> > #
> > 
> > #
> > # Compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> > #
> > CONFIG_CC_IS_GCC=y
> > CONFIG_GCC_VERSION=70500
> > CONFIG_CLANG_VERSION=0
> > CONFIG_CC_CAN_LINK=y
> > CONFIG_CC_HAS_ASM_GOTO=y
> > CONFIG_CC_HAS_ASM_INLINE=y
> > CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
> > CONFIG_CONSTRUCTORS=y
> > CONFIG_IRQ_WORK=y
> > CONFIG_BUILDTIME_TABLE_SORT=y
> > CONFIG_THREAD_INFO_IN_TASK=y
> > 
> > #
> > # General setup
> > #
> > CONFIG_BROKEN_ON_SMP=y
> > CONFIG_INIT_ENV_ARG_LIMIT=32
> > # CONFIG_COMPILE_TEST is not set
> > CONFIG_LOCALVERSION=""
> > CONFIG_LOCALVERSION_AUTO=y
> > CONFIG_BUILD_SALT=""
> > CONFIG_HAVE_KERNEL_GZIP=y
> > CONFIG_HAVE_KERNEL_BZIP2=y
> > CONFIG_HAVE_KERNEL_LZMA=y
> > CONFIG_HAVE_KERNEL_XZ=y
> > CONFIG_HAVE_KERNEL_LZO=y
> > CONFIG_HAVE_KERNEL_LZ4=y
> > # CONFIG_KERNEL_GZIP is not set
> > # CONFIG_KERNEL_BZIP2 is not set
> > # CONFIG_KERNEL_LZMA is not set
> > CONFIG_KERNEL_XZ=y
> > # CONFIG_KERNEL_LZO is not set
> > # CONFIG_KERNEL_LZ4 is not set
> > CONFIG_DEFAULT_HOSTNAME="(none)"
> > CONFIG_SWAP=y
> > # CONFIG_SYSVIPC is not set
> > # CONFIG_POSIX_MQUEUE is not set
> > CONFIG_CROSS_MEMORY_ATTACH=y
> > # CONFIG_USELIB is not set
> > # CONFIG_AUDIT is not set
> > CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> > 
> > #
> > # IRQ subsystem
> > #
> > CONFIG_GENERIC_IRQ_PROBE=y
> > CONFIG_GENERIC_IRQ_SHOW=y
> > CONFIG_GENERIC_IRQ_CHIP=y
> > CONFIG_IRQ_DOMAIN=y
> > CONFIG_IRQ_SIM=y
> > CONFIG_IRQ_DOMAIN_HIERARCHY=y
> > CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> > CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> > CONFIG_IRQ_FORCED_THREADING=y
> > CONFIG_SPARSE_IRQ=y
> > # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> > # end of IRQ subsystem
> > 
> > CONFIG_CLOCKSOURCE_WATCHDOG=y
> > CONFIG_ARCH_CLOCKSOURCE_DATA=y
> > CONFIG_ARCH_CLOCKSOURCE_INIT=y
> > CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> > CONFIG_GENERIC_TIME_VSYSCALL=y
> > CONFIG_GENERIC_CLOCKEVENTS=y
> > CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> > CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> > CONFIG_GENERIC_CMOS_UPDATE=y
> > 
> > #
> > # Timers subsystem
> > #
> > CONFIG_TICK_ONESHOT=y
> > CONFIG_HZ_PERIODIC=y
> > # CONFIG_NO_HZ_IDLE is not set
> > CONFIG_NO_HZ=y
> > CONFIG_HIGH_RES_TIMERS=y
> > # end of Timers subsystem
> > 
> > # CONFIG_PREEMPT_NONE is not set
> > CONFIG_PREEMPT_VOLUNTARY=y
> > # CONFIG_PREEMPT is not set
> > CONFIG_PREEMPT_COUNT=y
> > 
> > #
> > # CPU/Task time and stats accounting
> > #
> > CONFIG_TICK_CPU_ACCOUNTING=y
> > # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> > # CONFIG_IRQ_TIME_ACCOUNTING is not set
> > CONFIG_BSD_PROCESS_ACCT=y
> > # CONFIG_BSD_PROCESS_ACCT_V3 is not set
> > # CONFIG_TASKSTATS is not set
> > # CONFIG_PSI is not set
> > # end of CPU/Task time and stats accounting
> > 
> > #
> > # RCU Subsystem
> > #
> > CONFIG_TINY_RCU=y
> > # CONFIG_RCU_EXPERT is not set
> > CONFIG_SRCU=y
> > CONFIG_TINY_SRCU=y
> > CONFIG_TASKS_RCU=y
> > # end of RCU Subsystem
> > 
> > CONFIG_IKCONFIG=y
> > CONFIG_IKCONFIG_PROC=y
> > # CONFIG_IKHEADERS is not set
> > CONFIG_LOG_BUF_SHIFT=20
> > CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> > 
> > #
> > # Scheduler features
> > #
> > # end of Scheduler features
> > 
> > CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> > CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> > CONFIG_CC_HAS_INT128=y
> > CONFIG_ARCH_SUPPORTS_INT128=y
> > CONFIG_CGROUPS=y
> > # CONFIG_MEMCG is not set
> > # CONFIG_BLK_CGROUP is not set
> > CONFIG_CGROUP_SCHED=y
> > CONFIG_FAIR_GROUP_SCHED=y
> > # CONFIG_CFS_BANDWIDTH is not set
> > # CONFIG_RT_GROUP_SCHED is not set
> > # CONFIG_CGROUP_PIDS is not set
> > CONFIG_CGROUP_RDMA=y
> > # CONFIG_CGROUP_FREEZER is not set
> > # CONFIG_CGROUP_HUGETLB is not set
> > CONFIG_CGROUP_DEVICE=y
> > # CONFIG_CGROUP_CPUACCT is not set
> > CONFIG_CGROUP_PERF=y
> > CONFIG_CGROUP_BPF=y
> > # CONFIG_CGROUP_DEBUG is not set
> > CONFIG_SOCK_CGROUP_DATA=y
> > CONFIG_NAMESPACES=y
> > CONFIG_UTS_NS=y
> > CONFIG_TIME_NS=y
> > # CONFIG_USER_NS is not set
> > CONFIG_PID_NS=y
> > # CONFIG_NET_NS is not set
> > CONFIG_CHECKPOINT_RESTORE=y
> > CONFIG_SCHED_AUTOGROUP=y
> > # CONFIG_SYSFS_DEPRECATED is not set
> > # CONFIG_RELAY is not set
> > CONFIG_BLK_DEV_INITRD=y
> > CONFIG_INITRAMFS_SOURCE=""
> > CONFIG_RD_GZIP=y
> > CONFIG_RD_BZIP2=y
> > CONFIG_RD_LZMA=y
> > CONFIG_RD_XZ=y
> > CONFIG_RD_LZO=y
> > CONFIG_RD_LZ4=y
> > CONFIG_BOOT_CONFIG=y
> > CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> > # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> > CONFIG_SYSCTL=y
> > CONFIG_SYSCTL_EXCEPTION_TRACE=y
> > CONFIG_HAVE_PCSPKR_PLATFORM=y
> > CONFIG_BPF=y
> > CONFIG_EXPERT=y
> > CONFIG_MULTIUSER=y
> > # CONFIG_SGETMASK_SYSCALL is not set
> > CONFIG_SYSFS_SYSCALL=y
> > CONFIG_FHANDLE=y
> > CONFIG_POSIX_TIMERS=y
> > CONFIG_PRINTK=y
> > CONFIG_PRINTK_NMI=y
> > CONFIG_BUG=y
> > # CONFIG_ELF_CORE is not set
> > # CONFIG_PCSPKR_PLATFORM is not set
> > CONFIG_BASE_FULL=y
> > CONFIG_FUTEX=y
> > CONFIG_FUTEX_PI=y
> > CONFIG_EPOLL=y
> > CONFIG_SIGNALFD=y
> > CONFIG_TIMERFD=y
> > CONFIG_EVENTFD=y
> > CONFIG_SHMEM=y
> > # CONFIG_AIO is not set
> > CONFIG_IO_URING=y
> > CONFIG_ADVISE_SYSCALLS=y
> > CONFIG_MEMBARRIER=y
> > CONFIG_KALLSYMS=y
> > CONFIG_KALLSYMS_ALL=y
> > CONFIG_KALLSYMS_BASE_RELATIVE=y
> > CONFIG_BPF_SYSCALL=y
> > CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
> > CONFIG_USERFAULTFD=y
> > CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> > CONFIG_RSEQ=y
> > # CONFIG_DEBUG_RSEQ is not set
> > CONFIG_EMBEDDED=y
> > CONFIG_HAVE_PERF_EVENTS=y
> > CONFIG_PERF_USE_VMALLOC=y
> > CONFIG_PC104=y
> > 
> > #
> > # Kernel Performance Events And Counters
> > #
> > CONFIG_PERF_EVENTS=y
> > CONFIG_DEBUG_PERF_USE_VMALLOC=y
> > # end of Kernel Performance Events And Counters
> > 
> > # CONFIG_VM_EVENT_COUNTERS is not set
> > # CONFIG_COMPAT_BRK is not set
> > CONFIG_SLAB=y
> > # CONFIG_SLUB is not set
> > # CONFIG_SLOB is not set
> > # CONFIG_SLAB_MERGE_DEFAULT is not set
> > CONFIG_SLAB_FREELIST_RANDOM=y
> > # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> > # CONFIG_PROFILING is not set
> > CONFIG_TRACEPOINTS=y
> > # end of General setup
> > 
> > CONFIG_64BIT=y
> > CONFIG_X86_64=y
> > CONFIG_X86=y
> > CONFIG_INSTRUCTION_DECODER=y
> > CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> > CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
> > CONFIG_LOCKDEP_SUPPORT=y
> > CONFIG_STACKTRACE_SUPPORT=y
> > CONFIG_MMU=y
> > CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> > CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> > CONFIG_GENERIC_BUG=y
> > CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> > CONFIG_GENERIC_CALIBRATE_DELAY=y
> > CONFIG_ARCH_HAS_CPU_RELAX=y
> > CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> > CONFIG_ARCH_HAS_FILTER_PGPROT=y
> > CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> > CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> > CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> > CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> > CONFIG_ARCH_SUSPEND_POSSIBLE=y
> > CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> > CONFIG_ZONE_DMA32=y
> > CONFIG_AUDIT_ARCH=y
> > CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> > CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
> > CONFIG_ARCH_SUPPORTS_UPROBES=y
> > CONFIG_FIX_EARLYCON_MEM=y
> > CONFIG_PGTABLE_LEVELS=4
> > CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> > 
> > #
> > # Processor type and features
> > #
> > # CONFIG_ZONE_DMA is not set
> > # CONFIG_SMP is not set
> > CONFIG_X86_FEATURE_NAMES=y
> > # CONFIG_X86_X2APIC is not set
> > CONFIG_X86_MPPARSE=y
> > CONFIG_GOLDFISH=y
> > CONFIG_RETPOLINE=y
> > CONFIG_X86_CPU_RESCTRL=y
> > # CONFIG_X86_EXTENDED_PLATFORM is not set
> > # CONFIG_X86_INTEL_LPSS is not set
> > # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> > CONFIG_IOSF_MBI=m
> > # CONFIG_IOSF_MBI_DEBUG is not set
> > # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> > CONFIG_HYPERVISOR_GUEST=y
> > CONFIG_PARAVIRT=y
> > # CONFIG_PARAVIRT_DEBUG is not set
> > # CONFIG_XEN is not set
> > CONFIG_KVM_GUEST=y
> > CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> > # CONFIG_PVH is not set
> > # CONFIG_KVM_DEBUG_FS is not set
> > # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> > CONFIG_PARAVIRT_CLOCK=y
> > # CONFIG_JAILHOUSE_GUEST is not set
> > # CONFIG_ACRN_GUEST is not set
> > # CONFIG_MK8 is not set
> > # CONFIG_MPSC is not set
> > # CONFIG_MCORE2 is not set
> > # CONFIG_MATOM is not set
> > CONFIG_GENERIC_CPU=y
> > CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> > CONFIG_X86_L1_CACHE_SHIFT=6
> > CONFIG_X86_TSC=y
> > CONFIG_X86_CMPXCHG64=y
> > CONFIG_X86_CMOV=y
> > CONFIG_X86_MINIMUM_CPU_FAMILY=64
> > CONFIG_X86_DEBUGCTLMSR=y
> > CONFIG_IA32_FEAT_CTL=y
> > CONFIG_X86_VMX_FEATURE_NAMES=y
> > # CONFIG_PROCESSOR_SELECT is not set
> > CONFIG_CPU_SUP_INTEL=y
> > CONFIG_CPU_SUP_AMD=y
> > CONFIG_CPU_SUP_HYGON=y
> > CONFIG_CPU_SUP_CENTAUR=y
> > CONFIG_CPU_SUP_ZHAOXIN=y
> > CONFIG_HPET_TIMER=y
> > CONFIG_DMI=y
> > # CONFIG_GART_IOMMU is not set
> > CONFIG_NR_CPUS_RANGE_BEGIN=1
> > CONFIG_NR_CPUS_RANGE_END=1
> > CONFIG_NR_CPUS_DEFAULT=1
> > CONFIG_NR_CPUS=1
> > CONFIG_UP_LATE_INIT=y
> > CONFIG_X86_LOCAL_APIC=y
> > CONFIG_X86_IO_APIC=y
> > CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> > # CONFIG_X86_MCE is not set
> > 
> > #
> > # Performance monitoring
> > #
> > CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> > CONFIG_PERF_EVENTS_INTEL_RAPL=y
> > CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> > CONFIG_PERF_EVENTS_AMD_POWER=y
> > # end of Performance monitoring
> > 
> > CONFIG_X86_VSYSCALL_EMULATION=y
> > CONFIG_X86_IOPL_IOPERM=y
> > # CONFIG_I8K is not set
> > CONFIG_MICROCODE=y
> > # CONFIG_MICROCODE_INTEL is not set
> > # CONFIG_MICROCODE_AMD is not set
> > CONFIG_MICROCODE_OLD_INTERFACE=y
> > # CONFIG_X86_MSR is not set
> > CONFIG_X86_CPUID=m
> > # CONFIG_X86_5LEVEL is not set
> > CONFIG_X86_DIRECT_GBPAGES=y
> > # CONFIG_X86_CPA_STATISTICS is not set
> > # CONFIG_AMD_MEM_ENCRYPT is not set
> > CONFIG_ARCH_SPARSEMEM_ENABLE=y
> > CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> > CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> > CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> > # CONFIG_X86_PMEM_LEGACY is not set
> > # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
> > CONFIG_X86_RESERVE_LOW=64
> > # CONFIG_MTRR is not set
> > # CONFIG_ARCH_RANDOM is not set
> > CONFIG_X86_SMAP=y
> > CONFIG_X86_UMIP=y
> > CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
> > CONFIG_X86_INTEL_TSX_MODE_OFF=y
> > # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> > # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> > CONFIG_EFI=y
> > # CONFIG_EFI_STUB is not set
> > # CONFIG_SECCOMP is not set
> > # CONFIG_HZ_100 is not set
> > # CONFIG_HZ_250 is not set
> > # CONFIG_HZ_300 is not set
> > CONFIG_HZ_1000=y
> > CONFIG_HZ=1000
> > CONFIG_SCHED_HRTICK=y
> > # CONFIG_KEXEC is not set
> > # CONFIG_KEXEC_FILE is not set
> > CONFIG_CRASH_DUMP=y
> > CONFIG_PHYSICAL_START=0x1000000
> > CONFIG_RELOCATABLE=y
> > CONFIG_RANDOMIZE_BASE=y
> > CONFIG_X86_NEED_RELOCS=y
> > CONFIG_PHYSICAL_ALIGN=0x200000
> > CONFIG_DYNAMIC_MEMORY_LAYOUT=y
> > CONFIG_RANDOMIZE_MEMORY=y
> > CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
> > CONFIG_LEGACY_VSYSCALL_EMULATE=y
> > # CONFIG_LEGACY_VSYSCALL_XONLY is not set
> > # CONFIG_LEGACY_VSYSCALL_NONE is not set
> > # CONFIG_CMDLINE_BOOL is not set
> > # CONFIG_MODIFY_LDT_SYSCALL is not set
> > CONFIG_HAVE_LIVEPATCH=y
> > # end of Processor type and features
> > 
> > CONFIG_ARCH_HAS_ADD_PAGES=y
> > CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> > CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> > 
> > #
> > # Power management and ACPI options
> > #
> > # CONFIG_SUSPEND is not set
> > # CONFIG_HIBERNATION is not set
> > CONFIG_PM=y
> > CONFIG_PM_DEBUG=y
> > CONFIG_PM_ADVANCED_DEBUG=y
> > # CONFIG_DPM_WATCHDOG is not set
> > CONFIG_PM_CLK=y
> > # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> > CONFIG_ARCH_SUPPORTS_ACPI=y
> > CONFIG_ACPI=y
> > CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> > CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> > CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> > # CONFIG_ACPI_DEBUGGER is not set
> > CONFIG_ACPI_SPCR_TABLE=y
> > CONFIG_ACPI_LPIT=y
> > # CONFIG_ACPI_PROCFS_POWER is not set
> > CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> > # CONFIG_ACPI_EC_DEBUGFS is not set
> > CONFIG_ACPI_AC=y
> > CONFIG_ACPI_BATTERY=y
> > CONFIG_ACPI_BUTTON=y
> > # CONFIG_ACPI_VIDEO is not set
> > CONFIG_ACPI_FAN=y
> > # CONFIG_ACPI_DOCK is not set
> > CONFIG_ACPI_CPU_FREQ_PSS=y
> > CONFIG_ACPI_PROCESSOR_CSTATE=y
> > CONFIG_ACPI_PROCESSOR_IDLE=y
> > CONFIG_ACPI_PROCESSOR=y
> > # CONFIG_ACPI_IPMI is not set
> > # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
> > CONFIG_ACPI_THERMAL=y
> > CONFIG_ACPI_CUSTOM_DSDT_FILE=""
> > CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> > CONFIG_ACPI_TABLE_UPGRADE=y
> > # CONFIG_ACPI_DEBUG is not set
> > # CONFIG_ACPI_PCI_SLOT is not set
> > # CONFIG_ACPI_CONTAINER is not set
> > CONFIG_ACPI_HOTPLUG_IOAPIC=y
> > # CONFIG_ACPI_SBS is not set
> > # CONFIG_ACPI_HED is not set
> > # CONFIG_ACPI_CUSTOM_METHOD is not set
> > # CONFIG_ACPI_BGRT is not set
> > # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> > # CONFIG_ACPI_NFIT is not set
> > CONFIG_HAVE_ACPI_APEI=y
> > CONFIG_HAVE_ACPI_APEI_NMI=y
> > # CONFIG_ACPI_APEI is not set
> > # CONFIG_DPTF_POWER is not set
> > # CONFIG_PMIC_OPREGION is not set
> > # CONFIG_ACPI_CONFIGFS is not set
> > CONFIG_X86_PM_TIMER=y
> > # CONFIG_SFI is not set
> > 
> > #
> > # CPU Frequency scaling
> > #
> > CONFIG_CPU_FREQ=y
> > CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> > CONFIG_CPU_FREQ_GOV_COMMON=y
> > CONFIG_CPU_FREQ_STAT=y
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> > CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
> > CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> > CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> > # CONFIG_CPU_FREQ_GOV_USERSPACE is not set
> > # CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
> > CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> > 
> > #
> > # CPU frequency scaling drivers
> > #
> > # CONFIG_X86_INTEL_PSTATE is not set
> > # CONFIG_X86_PCC_CPUFREQ is not set
> > # CONFIG_X86_ACPI_CPUFREQ is not set
> > # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> > # CONFIG_X86_P4_CLOCKMOD is not set
> > 
> > #
> > # shared options
> > #
> > # end of CPU Frequency scaling
> > 
> > #
> > # CPU Idle
> > #
> > CONFIG_CPU_IDLE=y
> > # CONFIG_CPU_IDLE_GOV_LADDER is not set
> > CONFIG_CPU_IDLE_GOV_MENU=y
> > # CONFIG_CPU_IDLE_GOV_TEO is not set
> > # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> > CONFIG_HALTPOLL_CPUIDLE=y
> > # end of CPU Idle
> > 
> > # CONFIG_INTEL_IDLE is not set
> > # end of Power management and ACPI options
> > 
> > #
> > # Bus options (PCI etc.)
> > #
> > CONFIG_PCI_DIRECT=y
> > # CONFIG_PCI_MMCONFIG is not set
> > # CONFIG_PCI_CNB20LE_QUIRK is not set
> > CONFIG_ISA_BUS=y
> > # CONFIG_ISA_DMA_API is not set
> > CONFIG_AMD_NB=y
> > # CONFIG_X86_SYSFB is not set
> > # end of Bus options (PCI etc.)
> > 
> > #
> > # Binary Emulations
> > #
> > # CONFIG_IA32_EMULATION is not set
> > # CONFIG_X86_X32 is not set
> > # end of Binary Emulations
> > 
> > #
> > # Firmware Drivers
> > #
> > CONFIG_EDD=m
> > CONFIG_EDD_OFF=y
> > CONFIG_FIRMWARE_MEMMAP=y
> > CONFIG_DMIID=y
> > # CONFIG_DMI_SYSFS is not set
> > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> > CONFIG_FW_CFG_SYSFS=m
> > CONFIG_FW_CFG_SYSFS_CMDLINE=y
> > # CONFIG_GOOGLE_FIRMWARE is not set
> > 
> > #
> > # EFI (Extensible Firmware Interface) Support
> > #
> > # CONFIG_EFI_VARS is not set
> > CONFIG_EFI_ESRT=y
> > # CONFIG_EFI_FAKE_MEMMAP is not set
> > CONFIG_EFI_RUNTIME_WRAPPERS=y
> > # CONFIG_EFI_CAPSULE_LOADER is not set
> > # CONFIG_EFI_TEST is not set
> > # CONFIG_EFI_RCI2_TABLE is not set
> > # CONFIG_EFI_DISABLE_PCI_DMA is not set
> > # end of EFI (Extensible Firmware Interface) Support
> > 
> > CONFIG_EFI_EARLYCON=y
> > 
> > #
> > # Tegra firmware driver
> > #
> > # end of Tegra firmware driver
> > # end of Firmware Drivers
> > 
> > CONFIG_HAVE_KVM=y
> > # CONFIG_VIRTUALIZATION is not set
> > 
> > #
> > # General architecture-dependent options
> > #
> > CONFIG_HAVE_OPROFILE=y
> > CONFIG_OPROFILE_NMI_TIMER=y
> > CONFIG_KPROBES=y
> > # CONFIG_JUMP_LABEL is not set
> > CONFIG_OPTPROBES=y
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> > CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> > CONFIG_KRETPROBES=y
> > CONFIG_HAVE_IOREMAP_PROT=y
> > CONFIG_HAVE_KPROBES=y
> > CONFIG_HAVE_KRETPROBES=y
> > CONFIG_HAVE_OPTPROBES=y
> > CONFIG_HAVE_KPROBES_ON_FTRACE=y
> > CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> > CONFIG_HAVE_NMI=y
> > CONFIG_HAVE_ARCH_TRACEHOOK=y
> > CONFIG_HAVE_DMA_CONTIGUOUS=y
> > CONFIG_GENERIC_SMP_IDLE_THREAD=y
> > CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> > CONFIG_ARCH_HAS_SET_MEMORY=y
> > CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> > CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> > CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> > CONFIG_HAVE_ASM_MODVERSIONS=y
> > CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> > CONFIG_HAVE_RSEQ=y
> > CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> > CONFIG_HAVE_CLK=y
> > CONFIG_HAVE_HW_BREAKPOINT=y
> > CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> > CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> > CONFIG_HAVE_PERF_EVENTS_NMI=y
> > CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> > CONFIG_HAVE_PERF_REGS=y
> > CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> > CONFIG_HAVE_ARCH_JUMP_LABEL=y
> > CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> > CONFIG_MMU_GATHER_TABLE_FREE=y
> > CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> > CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> > CONFIG_HAVE_CMPXCHG_LOCAL=y
> > CONFIG_HAVE_CMPXCHG_DOUBLE=y
> > CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> > CONFIG_HAVE_ARCH_STACKLEAK=y
> > CONFIG_HAVE_STACKPROTECTOR=y
> > CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> > CONFIG_STACKPROTECTOR=y
> > CONFIG_STACKPROTECTOR_STRONG=y
> > CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> > CONFIG_HAVE_CONTEXT_TRACKING=y
> > CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> > CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> > CONFIG_HAVE_MOVE_PMD=y
> > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> > CONFIG_HAVE_ARCH_HUGE_VMAP=y
> > CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> > CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> > CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> > CONFIG_MODULES_USE_ELF_RELA=y
> > CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> > CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> > CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> > CONFIG_HAVE_EXIT_THREAD=y
> > CONFIG_ARCH_MMAP_RND_BITS=28
> > CONFIG_HAVE_COPY_THREAD_TLS=y
> > CONFIG_HAVE_STACK_VALIDATION=y
> > CONFIG_HAVE_RELIABLE_STACKTRACE=y
> > CONFIG_ISA_BUS_API=y
> > # CONFIG_COMPAT_32BIT_TIME is not set
> > CONFIG_HAVE_ARCH_VMAP_STACK=y
> > CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> > CONFIG_STRICT_KERNEL_RWX=y
> > CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> > CONFIG_STRICT_MODULE_RWX=y
> > CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> > CONFIG_ARCH_USE_MEMREMAP_PROT=y
> > # CONFIG_LOCK_EVENT_COUNTS is not set
> > CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> > 
> > #
> > # GCOV-based kernel profiling
> > #
> > # CONFIG_GCOV_KERNEL is not set
> > CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> > # end of GCOV-based kernel profiling
> > 
> > CONFIG_PLUGIN_HOSTCC="g++"
> > CONFIG_HAVE_GCC_PLUGINS=y
> > CONFIG_GCC_PLUGINS=y
> > # CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
> > # CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
> > # CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
> > # end of General architecture-dependent options
> > 
> > CONFIG_RT_MUTEXES=y
> > CONFIG_BASE_SMALL=0
> > CONFIG_MODULES=y
> > CONFIG_MODULE_FORCE_LOAD=y
> > CONFIG_MODULE_UNLOAD=y
> > # CONFIG_MODULE_FORCE_UNLOAD is not set
> > # CONFIG_MODVERSIONS is not set
> > # CONFIG_MODULE_SRCVERSION_ALL is not set
> > # CONFIG_MODULE_SIG is not set
> > # CONFIG_MODULE_COMPRESS is not set
> > # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> > # CONFIG_UNUSED_SYMBOLS is not set
> > CONFIG_TRIM_UNUSED_KSYMS=y
> > CONFIG_MODULES_TREE_LOOKUP=y
> > CONFIG_BLOCK=y
> > CONFIG_BLK_SCSI_REQUEST=y
> > CONFIG_BLK_DEV_BSG=y
> > # CONFIG_BLK_DEV_BSGLIB is not set
> > # CONFIG_BLK_DEV_INTEGRITY is not set
> > # CONFIG_BLK_DEV_ZONED is not set
> > # CONFIG_BLK_CMDLINE_PARSER is not set
> > # CONFIG_BLK_WBT is not set
> > CONFIG_BLK_DEBUG_FS=y
> > # CONFIG_BLK_SED_OPAL is not set
> > 
> > #
> > # Partition Types
> > #
> > # CONFIG_PARTITION_ADVANCED is not set
> > CONFIG_MSDOS_PARTITION=y
> > CONFIG_EFI_PARTITION=y
> > # end of Partition Types
> > 
> > CONFIG_BLK_MQ_PCI=y
> > CONFIG_BLK_MQ_VIRTIO=y
> > CONFIG_BLK_PM=y
> > 
> > #
> > # IO Schedulers
> > #
> > CONFIG_MQ_IOSCHED_DEADLINE=y
> > CONFIG_MQ_IOSCHED_KYBER=y
> > # CONFIG_IOSCHED_BFQ is not set
> > # end of IO Schedulers
> > 
> > CONFIG_UNINLINE_SPIN_UNLOCK=y
> > CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> > CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> > CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> > CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> > CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> > 
> > #
> > # Executable file formats
> > #
> > CONFIG_BINFMT_ELF=y
> > CONFIG_ELFCORE=y
> > CONFIG_BINFMT_SCRIPT=y
> > CONFIG_BINFMT_MISC=y
> > CONFIG_COREDUMP=y
> > # end of Executable file formats
> > 
> > #
> > # Memory Management options
> > #
> > CONFIG_SELECT_MEMORY_MODEL=y
> > CONFIG_SPARSEMEM_MANUAL=y
> > CONFIG_SPARSEMEM=y
> > CONFIG_HAVE_MEMORY_PRESENT=y
> > CONFIG_SPARSEMEM_EXTREME=y
> > CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> > # CONFIG_SPARSEMEM_VMEMMAP is not set
> > CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
> > CONFIG_HAVE_FAST_GUP=y
> > # CONFIG_MEMORY_HOTPLUG is not set
> > CONFIG_SPLIT_PTLOCK_CPUS=4
> > CONFIG_MEMORY_BALLOON=y
> > # CONFIG_COMPACTION is not set
> > CONFIG_PHYS_ADDR_T_64BIT=y
> > CONFIG_VIRT_TO_BUS=y
> > CONFIG_KSM=y
> > CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> > # CONFIG_TRANSPARENT_HUGEPAGE is not set
> > CONFIG_ARCH_WANTS_THP_SWAP=y
> > CONFIG_NEED_PER_CPU_KM=y
> > CONFIG_CLEANCACHE=y
> > # CONFIG_FRONTSWAP is not set
> > # CONFIG_CMA is not set
> > CONFIG_MEM_SOFT_DIRTY=y
> > CONFIG_ZPOOL=y
> > CONFIG_ZBUD=y
> > # CONFIG_Z3FOLD is not set
> > CONFIG_ZSMALLOC=m
> > CONFIG_PGTABLE_MAPPING=y
> > CONFIG_ZSMALLOC_STAT=y
> > CONFIG_GENERIC_EARLY_IOREMAP=y
> > CONFIG_IDLE_PAGE_TRACKING=y
> > CONFIG_ARCH_HAS_PTE_DEVMAP=y
> > CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
> > CONFIG_ARCH_HAS_PKEYS=y
> > CONFIG_PERCPU_STATS=y
> > # CONFIG_GUP_BENCHMARK is not set
> > CONFIG_ARCH_HAS_PTE_SPECIAL=y
> > # end of Memory Management options
> > 
> > CONFIG_NET=y
> > CONFIG_SKB_EXTENSIONS=y
> > 
> > #
> > # Networking options
> > #
> > CONFIG_PACKET=m
> > CONFIG_PACKET_DIAG=m
> > CONFIG_UNIX=y
> > CONFIG_UNIX_SCM=y
> > CONFIG_UNIX_DIAG=m
> > CONFIG_TLS=m
> > # CONFIG_TLS_DEVICE is not set
> > # CONFIG_TLS_TOE is not set
> > CONFIG_XFRM=y
> > CONFIG_XFRM_OFFLOAD=y
> > CONFIG_XFRM_ALGO=y
> > CONFIG_XFRM_USER=y
> > # CONFIG_XFRM_INTERFACE is not set
> > # CONFIG_XFRM_SUB_POLICY is not set
> > CONFIG_XFRM_MIGRATE=y
> > CONFIG_XFRM_STATISTICS=y
> > CONFIG_XFRM_IPCOMP=m
> > CONFIG_NET_KEY=y
> > CONFIG_NET_KEY_MIGRATE=y
> > # CONFIG_XDP_SOCKETS is not set
> > CONFIG_INET=y
> > # CONFIG_IP_MULTICAST is not set
> > CONFIG_IP_ADVANCED_ROUTER=y
> > # CONFIG_IP_FIB_TRIE_STATS is not set
> > CONFIG_IP_MULTIPLE_TABLES=y
> > # CONFIG_IP_ROUTE_MULTIPATH is not set
> > # CONFIG_IP_ROUTE_VERBOSE is not set
> > CONFIG_IP_ROUTE_CLASSID=y
> > CONFIG_IP_PNP=y
> > CONFIG_IP_PNP_DHCP=y
> > # CONFIG_IP_PNP_BOOTP is not set
> > # CONFIG_IP_PNP_RARP is not set
> > CONFIG_NET_IPIP=y
> > # CONFIG_NET_IPGRE_DEMUX is not set
> > CONFIG_NET_IP_TUNNEL=y
> > CONFIG_IP_MROUTE_COMMON=y
> > # CONFIG_SYN_COOKIES is not set
> > CONFIG_NET_IPVTI=m
> > CONFIG_NET_UDP_TUNNEL=y
> > CONFIG_NET_FOU=y
> > CONFIG_NET_FOU_IP_TUNNELS=y
> > # CONFIG_INET_AH is not set
> > # CONFIG_INET_ESP is not set
> > CONFIG_INET_IPCOMP=m
> > CONFIG_INET_XFRM_TUNNEL=m
> > CONFIG_INET_TUNNEL=y
> > # CONFIG_INET_DIAG is not set
> > # CONFIG_TCP_CONG_ADVANCED is not set
> > CONFIG_TCP_CONG_CUBIC=y
> > CONFIG_DEFAULT_TCP_CONG="cubic"
> > # CONFIG_TCP_MD5SIG is not set
> > CONFIG_IPV6=y
> > CONFIG_IPV6_ROUTER_PREF=y
> > # CONFIG_IPV6_ROUTE_INFO is not set
> > CONFIG_IPV6_OPTIMISTIC_DAD=y
> > CONFIG_INET6_AH=m
> > CONFIG_INET6_ESP=m
> > CONFIG_INET6_ESP_OFFLOAD=m
> > CONFIG_INET6_IPCOMP=m
> > CONFIG_IPV6_MIP6=m
> > # CONFIG_IPV6_ILA is not set
> > CONFIG_INET6_XFRM_TUNNEL=m
> > CONFIG_INET6_TUNNEL=y
> > CONFIG_IPV6_VTI=m
> > # CONFIG_IPV6_SIT is not set
> > CONFIG_IPV6_TUNNEL=y
> > CONFIG_IPV6_FOU=y
> > CONFIG_IPV6_FOU_TUNNEL=y
> > CONFIG_IPV6_MULTIPLE_TABLES=y
> > CONFIG_IPV6_SUBTREES=y
> > CONFIG_IPV6_MROUTE=y
> > CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
> > CONFIG_IPV6_PIMSM_V2=y
> > CONFIG_IPV6_SEG6_LWTUNNEL=y
> > CONFIG_IPV6_SEG6_HMAC=y
> > CONFIG_IPV6_SEG6_BPF=y
> > CONFIG_MPTCP=y
> > CONFIG_MPTCP_IPV6=y
> > # CONFIG_MPTCP_HMAC_TEST is not set
> > # CONFIG_NETWORK_SECMARK is not set
> > CONFIG_NET_PTP_CLASSIFY=y
> > CONFIG_NETWORK_PHY_TIMESTAMPING=y
> > CONFIG_NETFILTER=y
> > # CONFIG_NETFILTER_ADVANCED is not set
> > 
> > #
> > # Core Netfilter Configuration
> > #
> > # CONFIG_NETFILTER_INGRESS is not set
> > CONFIG_NETFILTER_NETLINK=y
> > CONFIG_NETFILTER_FAMILY_ARP=y
> > CONFIG_NETFILTER_NETLINK_LOG=m
> > # CONFIG_NF_CONNTRACK is not set
> > CONFIG_NF_LOG_COMMON=y
> > CONFIG_NF_LOG_NETDEV=m
> > CONFIG_NF_TABLES=y
> > # CONFIG_NF_TABLES_SET is not set
> > # CONFIG_NF_TABLES_INET is not set
> > # CONFIG_NF_TABLES_NETDEV is not set
> > CONFIG_NFT_NUMGEN=y
> > CONFIG_NFT_COUNTER=y
> > # CONFIG_NFT_LOG is not set
> > CONFIG_NFT_LIMIT=m
> > # CONFIG_NFT_TUNNEL is not set
> > # CONFIG_NFT_OBJREF is not set
> > # CONFIG_NFT_QUOTA is not set
> > CONFIG_NFT_REJECT=m
> > # CONFIG_NFT_COMPAT is not set
> > CONFIG_NFT_HASH=m
> > # CONFIG_NFT_XFRM is not set
> > # CONFIG_NFT_SOCKET is not set
> > # CONFIG_NFT_TPROXY is not set
> > CONFIG_NETFILTER_XTABLES=m
> > 
> > #
> > # Xtables combined modules
> > #
> > CONFIG_NETFILTER_XT_MARK=m
> > 
> > #
> > # Xtables targets
> > #
> > CONFIG_NETFILTER_XT_TARGET_LOG=m
> > CONFIG_NETFILTER_XT_TARGET_NFLOG=m
> > # CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
> > 
> > #
> > # Xtables matches
> > #
> > CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
> > CONFIG_NETFILTER_XT_MATCH_POLICY=m
> > # end of Core Netfilter Configuration
> > 
> > CONFIG_IP_SET=y
> > CONFIG_IP_SET_MAX=256
> > CONFIG_IP_SET_BITMAP_IP=m
> > CONFIG_IP_SET_BITMAP_IPMAC=m
> > CONFIG_IP_SET_BITMAP_PORT=y
> > CONFIG_IP_SET_HASH_IP=m
> > CONFIG_IP_SET_HASH_IPMARK=m
> > CONFIG_IP_SET_HASH_IPPORT=m
> > # CONFIG_IP_SET_HASH_IPPORTIP is not set
> > CONFIG_IP_SET_HASH_IPPORTNET=m
> > CONFIG_IP_SET_HASH_IPMAC=y
> > CONFIG_IP_SET_HASH_MAC=y
> > CONFIG_IP_SET_HASH_NETPORTNET=y
> > CONFIG_IP_SET_HASH_NET=m
> > CONFIG_IP_SET_HASH_NETNET=y
> > CONFIG_IP_SET_HASH_NETPORT=y
> > # CONFIG_IP_SET_HASH_NETIFACE is not set
> > CONFIG_IP_SET_LIST_SET=y
> > # CONFIG_IP_VS is not set
> > 
> > #
> > # IP: Netfilter Configuration
> > #
> > CONFIG_NF_SOCKET_IPV4=y
> > # CONFIG_NF_TPROXY_IPV4 is not set
> > CONFIG_NF_TABLES_IPV4=y
> > CONFIG_NFT_REJECT_IPV4=m
> > CONFIG_NFT_DUP_IPV4=m
> > # CONFIG_NFT_FIB_IPV4 is not set
> > CONFIG_NF_TABLES_ARP=y
> > CONFIG_NF_DUP_IPV4=m
> > CONFIG_NF_LOG_ARP=y
> > CONFIG_NF_LOG_IPV4=m
> > CONFIG_NF_REJECT_IPV4=m
> > CONFIG_IP_NF_IPTABLES=m
> > CONFIG_IP_NF_FILTER=m
> > CONFIG_IP_NF_TARGET_REJECT=m
> > CONFIG_IP_NF_MANGLE=m
> > # CONFIG_IP_NF_RAW is not set
> > # end of IP: Netfilter Configuration
> > 
> > #
> > # IPv6: Netfilter Configuration
> > #
> > CONFIG_NF_SOCKET_IPV6=m
> > # CONFIG_NF_TPROXY_IPV6 is not set
> > # CONFIG_NF_TABLES_IPV6 is not set
> > CONFIG_NF_DUP_IPV6=m
> > CONFIG_NF_REJECT_IPV6=m
> > CONFIG_NF_LOG_IPV6=m
> > CONFIG_IP6_NF_IPTABLES=m
> > # CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
> > # CONFIG_IP6_NF_FILTER is not set
> > # CONFIG_IP6_NF_MANGLE is not set
> > # CONFIG_IP6_NF_RAW is not set
> > # end of IPv6: Netfilter Configuration
> > 
> > # CONFIG_BPFILTER is not set
> > CONFIG_IP_DCCP=y
> > 
> > #
> > # DCCP CCIDs Configuration
> > #
> > CONFIG_IP_DCCP_CCID2_DEBUG=y
> > CONFIG_IP_DCCP_CCID3=y
> > CONFIG_IP_DCCP_CCID3_DEBUG=y
> > CONFIG_IP_DCCP_TFRC_LIB=y
> > CONFIG_IP_DCCP_TFRC_DEBUG=y
> > # end of DCCP CCIDs Configuration
> > 
> > #
> > # DCCP Kernel Hacking
> > #
> > # CONFIG_IP_DCCP_DEBUG is not set
> > # end of DCCP Kernel Hacking
> > 
> > CONFIG_IP_SCTP=m
> > # CONFIG_SCTP_DBG_OBJCNT is not set
> > # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
> > # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
> > CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE=y
> > # CONFIG_SCTP_COOKIE_HMAC_MD5 is not set
> > # CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
> > # CONFIG_RDS is not set
> > CONFIG_TIPC=y
> > # CONFIG_TIPC_MEDIA_UDP is not set
> > CONFIG_TIPC_CRYPTO=y
> > CONFIG_TIPC_DIAG=y
> > CONFIG_ATM=y
> > CONFIG_ATM_CLIP=y
> > # CONFIG_ATM_CLIP_NO_ICMP is not set
> > CONFIG_ATM_LANE=m
> > # CONFIG_ATM_MPOA is not set
> > CONFIG_ATM_BR2684=y
> > # CONFIG_ATM_BR2684_IPFILTER is not set
> > # CONFIG_L2TP is not set
> > CONFIG_STP=m
> > CONFIG_GARP=m
> > # CONFIG_BRIDGE is not set
> > CONFIG_HAVE_NET_DSA=y
> > # CONFIG_NET_DSA is not set
> > CONFIG_VLAN_8021Q=m
> > CONFIG_VLAN_8021Q_GVRP=y
> > # CONFIG_VLAN_8021Q_MVRP is not set
> > CONFIG_DECNET=y
> > # CONFIG_DECNET_ROUTER is not set
> > CONFIG_LLC=y
> > CONFIG_LLC2=y
> > # CONFIG_ATALK is not set
> > CONFIG_X25=m
> > CONFIG_LAPB=m
> > CONFIG_PHONET=y
> > CONFIG_6LOWPAN=m
> > CONFIG_6LOWPAN_DEBUGFS=y
> > # CONFIG_6LOWPAN_NHC is not set
> > CONFIG_IEEE802154=m
> > CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
> > CONFIG_IEEE802154_SOCKET=m
> > # CONFIG_IEEE802154_6LOWPAN is not set
> > # CONFIG_MAC802154 is not set
> > CONFIG_NET_SCHED=y
> > 
> > #
> > # Queueing/Scheduling
> > #
> > # CONFIG_NET_SCH_CBQ is not set
> > CONFIG_NET_SCH_HTB=m
> > CONFIG_NET_SCH_HFSC=m
> > CONFIG_NET_SCH_ATM=y
> > # CONFIG_NET_SCH_PRIO is not set
> > # CONFIG_NET_SCH_MULTIQ is not set
> > # CONFIG_NET_SCH_RED is not set
> > CONFIG_NET_SCH_SFB=y
> > # CONFIG_NET_SCH_SFQ is not set
> > # CONFIG_NET_SCH_TEQL is not set
> > CONFIG_NET_SCH_TBF=m
> > # CONFIG_NET_SCH_CBS is not set
> > # CONFIG_NET_SCH_ETF is not set
> > # CONFIG_NET_SCH_TAPRIO is not set
> > CONFIG_NET_SCH_GRED=y
> > CONFIG_NET_SCH_DSMARK=m
> > CONFIG_NET_SCH_NETEM=m
> > CONFIG_NET_SCH_DRR=y
> > CONFIG_NET_SCH_MQPRIO=y
> > # CONFIG_NET_SCH_SKBPRIO is not set
> > CONFIG_NET_SCH_CHOKE=m
> > CONFIG_NET_SCH_QFQ=m
> > CONFIG_NET_SCH_CODEL=m
> > # CONFIG_NET_SCH_FQ_CODEL is not set
> > # CONFIG_NET_SCH_CAKE is not set
> > CONFIG_NET_SCH_FQ=m
> > CONFIG_NET_SCH_HHF=y
> > CONFIG_NET_SCH_PIE=m
> > # CONFIG_NET_SCH_FQ_PIE is not set
> > # CONFIG_NET_SCH_INGRESS is not set
> > # CONFIG_NET_SCH_PLUG is not set
> > # CONFIG_NET_SCH_ETS is not set
> > CONFIG_NET_SCH_DEFAULT=y
> > # CONFIG_DEFAULT_FQ is not set
> > # CONFIG_DEFAULT_CODEL is not set
> > CONFIG_DEFAULT_PFIFO_FAST=y
> > CONFIG_DEFAULT_NET_SCH="pfifo_fast"
> > 
> > #
> > # Classification
> > #
> > CONFIG_NET_CLS=y
> > CONFIG_NET_CLS_BASIC=y
> > # CONFIG_NET_CLS_TCINDEX is not set
> > CONFIG_NET_CLS_ROUTE4=y
> > # CONFIG_NET_CLS_FW is not set
> > CONFIG_NET_CLS_U32=y
> > CONFIG_CLS_U32_PERF=y
> > # CONFIG_CLS_U32_MARK is not set
> > CONFIG_NET_CLS_RSVP=y
> > # CONFIG_NET_CLS_RSVP6 is not set
> > CONFIG_NET_CLS_FLOW=m
> > # CONFIG_NET_CLS_CGROUP is not set
> > CONFIG_NET_CLS_BPF=m
> > CONFIG_NET_CLS_FLOWER=m
> > CONFIG_NET_CLS_MATCHALL=y
> > CONFIG_NET_EMATCH=y
> > CONFIG_NET_EMATCH_STACK=32
> > # CONFIG_NET_EMATCH_CMP is not set
> > CONFIG_NET_EMATCH_NBYTE=y
> > # CONFIG_NET_EMATCH_U32 is not set
> > # CONFIG_NET_EMATCH_META is not set
> > CONFIG_NET_EMATCH_TEXT=y
> > CONFIG_NET_EMATCH_IPSET=y
> > # CONFIG_NET_EMATCH_IPT is not set
> > CONFIG_NET_CLS_ACT=y
> > CONFIG_NET_ACT_POLICE=y
> > # CONFIG_NET_ACT_GACT is not set
> > # CONFIG_NET_ACT_MIRRED is not set
> > CONFIG_NET_ACT_SAMPLE=m
> > CONFIG_NET_ACT_IPT=m
> > CONFIG_NET_ACT_NAT=y
> > CONFIG_NET_ACT_PEDIT=m
> > CONFIG_NET_ACT_SIMP=y
> > CONFIG_NET_ACT_SKBEDIT=m
> > # CONFIG_NET_ACT_CSUM is not set
> > # CONFIG_NET_ACT_MPLS is not set
> > # CONFIG_NET_ACT_VLAN is not set
> > # CONFIG_NET_ACT_BPF is not set
> > CONFIG_NET_ACT_SKBMOD=y
> > CONFIG_NET_ACT_IFE=m
> > # CONFIG_NET_ACT_TUNNEL_KEY is not set
> > # CONFIG_NET_IFE_SKBMARK is not set
> > # CONFIG_NET_IFE_SKBPRIO is not set
> > # CONFIG_NET_IFE_SKBTCINDEX is not set
> > # CONFIG_NET_TC_SKB_EXT is not set
> > CONFIG_NET_SCH_FIFO=y
> > # CONFIG_DCB is not set
> > CONFIG_DNS_RESOLVER=m
> > CONFIG_BATMAN_ADV=m
> > CONFIG_BATMAN_ADV_BATMAN_V=y
> > # CONFIG_BATMAN_ADV_BLA is not set
> > CONFIG_BATMAN_ADV_DAT=y
> > CONFIG_BATMAN_ADV_NC=y
> > # CONFIG_BATMAN_ADV_MCAST is not set
> > CONFIG_BATMAN_ADV_DEBUGFS=y
> > # CONFIG_BATMAN_ADV_DEBUG is not set
> > # CONFIG_BATMAN_ADV_SYSFS is not set
> > # CONFIG_BATMAN_ADV_TRACING is not set
> > CONFIG_OPENVSWITCH=m
> > # CONFIG_VSOCKETS is not set
> > CONFIG_NETLINK_DIAG=m
> > CONFIG_MPLS=y
> > CONFIG_NET_MPLS_GSO=m
> > CONFIG_MPLS_ROUTING=m
> > CONFIG_MPLS_IPTUNNEL=m
> > CONFIG_NET_NSH=m
> > CONFIG_HSR=m
> > CONFIG_NET_SWITCHDEV=y
> > CONFIG_NET_L3_MASTER_DEV=y
> > CONFIG_NET_NCSI=y
> > # CONFIG_NCSI_OEM_CMD_GET_MAC is not set
> > CONFIG_CGROUP_NET_PRIO=y
> > # CONFIG_CGROUP_NET_CLASSID is not set
> > CONFIG_NET_RX_BUSY_POLL=y
> > CONFIG_BQL=y
> > # CONFIG_BPF_JIT is not set
> > CONFIG_BPF_STREAM_PARSER=y
> > 
> > #
> > # Network testing
> > #
> > CONFIG_NET_PKTGEN=y
> > CONFIG_NET_DROP_MONITOR=m
> > # end of Network testing
> > # end of Networking options
> > 
> > # CONFIG_HAMRADIO is not set
> > # CONFIG_CAN is not set
> > CONFIG_BT=y
> > CONFIG_BT_BREDR=y
> > # CONFIG_BT_RFCOMM is not set
> > CONFIG_BT_BNEP=y
> > # CONFIG_BT_BNEP_MC_FILTER is not set
> > # CONFIG_BT_BNEP_PROTO_FILTER is not set
> > # CONFIG_BT_CMTP is not set
> > # CONFIG_BT_HIDP is not set
> > # CONFIG_BT_HS is not set
> > CONFIG_BT_LE=y
> > CONFIG_BT_6LOWPAN=m
> > CONFIG_BT_LEDS=y
> > CONFIG_BT_SELFTEST=y
> > # CONFIG_BT_SELFTEST_ECDH is not set
> > CONFIG_BT_SELFTEST_SMP=y
> > CONFIG_BT_DEBUGFS=y
> > 
> > #
> > # Bluetooth device drivers
> > #
> > CONFIG_BT_HCIBTSDIO=m
> > # CONFIG_BT_HCIUART is not set
> > CONFIG_BT_HCIDTL1=m
> > CONFIG_BT_HCIBT3C=m
> > # CONFIG_BT_HCIBLUECARD is not set
> > CONFIG_BT_HCIVHCI=m
> > CONFIG_BT_MRVL=y
> > # CONFIG_BT_MRVL_SDIO is not set
> > # CONFIG_BT_MTKSDIO is not set
> > # end of Bluetooth device drivers
> > 
> > CONFIG_AF_RXRPC=y
> > # CONFIG_AF_RXRPC_IPV6 is not set
> > CONFIG_AF_RXRPC_INJECT_LOSS=y
> > CONFIG_AF_RXRPC_DEBUG=y
> > CONFIG_RXKAD=y
> > CONFIG_AF_KCM=m
> > CONFIG_STREAM_PARSER=y
> > CONFIG_FIB_RULES=y
> > # CONFIG_WIRELESS is not set
> > CONFIG_WIMAX=y
> > CONFIG_WIMAX_DEBUG_LEVEL=8
> > CONFIG_RFKILL=y
> > CONFIG_RFKILL_LEDS=y
> > # CONFIG_RFKILL_INPUT is not set
> > # CONFIG_RFKILL_GPIO is not set
> > CONFIG_NET_9P=y
> > CONFIG_NET_9P_VIRTIO=y
> > CONFIG_NET_9P_DEBUG=y
> > CONFIG_CAIF=y
> > # CONFIG_CAIF_DEBUG is not set
> > CONFIG_CAIF_NETDEV=m
> > # CONFIG_CAIF_USB is not set
> > CONFIG_CEPH_LIB=y
> > CONFIG_CEPH_LIB_PRETTYDEBUG=y
> > # CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
> > # CONFIG_NFC is not set
> > CONFIG_PSAMPLE=m
> > CONFIG_NET_IFE=m
> > CONFIG_LWTUNNEL=y
> > # CONFIG_LWTUNNEL_BPF is not set
> > CONFIG_DST_CACHE=y
> > CONFIG_GRO_CELLS=y
> > CONFIG_NET_SOCK_MSG=y
> > CONFIG_FAILOVER=y
> > CONFIG_ETHTOOL_NETLINK=y
> > CONFIG_HAVE_EBPF_JIT=y
> > 
> > #
> > # Device Drivers
> > #
> > CONFIG_HAVE_EISA=y
> > # CONFIG_EISA is not set
> > CONFIG_HAVE_PCI=y
> > CONFIG_PCI=y
> > CONFIG_PCI_DOMAINS=y
> > # CONFIG_PCIEPORTBUS is not set
> > CONFIG_PCIEASPM=y
> > CONFIG_PCIEASPM_DEFAULT=y
> > # CONFIG_PCIEASPM_POWERSAVE is not set
> > # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> > # CONFIG_PCIEASPM_PERFORMANCE is not set
> > # CONFIG_PCIE_PTM is not set
> > # CONFIG_PCI_MSI is not set
> > CONFIG_PCI_QUIRKS=y
> > # CONFIG_PCI_DEBUG is not set
> > # CONFIG_PCI_STUB is not set
> > CONFIG_PCI_LOCKLESS_CONFIG=y
> > # CONFIG_PCI_IOV is not set
> > # CONFIG_PCI_PRI is not set
> > # CONFIG_PCI_PASID is not set
> > CONFIG_PCI_LABEL=y
> > # CONFIG_HOTPLUG_PCI is not set
> > 
> > #
> > # PCI controller drivers
> > #
> > 
> > #
> > # DesignWare PCI Core Support
> > #
> > # end of DesignWare PCI Core Support
> > 
> > #
> > # Cadence PCIe controllers support
> > #
> > # end of Cadence PCIe controllers support
> > # end of PCI controller drivers
> > 
> > #
> > # PCI Endpoint
> > #
> > # CONFIG_PCI_ENDPOINT is not set
> > # end of PCI Endpoint
> > 
> > #
> > # PCI switch controller drivers
> > #
> > # CONFIG_PCI_SW_SWITCHTEC is not set
> > # end of PCI switch controller drivers
> > 
> > CONFIG_PCCARD=m
> > CONFIG_PCMCIA=m
> > # CONFIG_PCMCIA_LOAD_CIS is not set
> > CONFIG_CARDBUS=y
> > 
> > #
> > # PC-card bridges
> > #
> > # CONFIG_YENTA is not set
> > # CONFIG_PD6729 is not set
> > # CONFIG_I82092 is not set
> > # CONFIG_RAPIDIO is not set
> > 
> > #
> > # Generic Driver Options
> > #
> > # CONFIG_UEVENT_HELPER is not set
> > CONFIG_DEVTMPFS=y
> > # CONFIG_DEVTMPFS_MOUNT is not set
> > # CONFIG_STANDALONE is not set
> > # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> > 
> > #
> > # Firmware loader
> > #
> > CONFIG_FW_LOADER=y
> > CONFIG_FW_LOADER_PAGED_BUF=y
> > CONFIG_EXTRA_FIRMWARE=""
> > CONFIG_FW_LOADER_USER_HELPER=y
> > # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> > # CONFIG_FW_LOADER_COMPRESS is not set
> > # end of Firmware loader
> > 
> > CONFIG_ALLOW_DEV_COREDUMP=y
> > # CONFIG_DEBUG_DRIVER is not set
> > # CONFIG_DEBUG_DEVRES is not set
> > # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> > CONFIG_TEST_ASYNC_DRIVER_PROBE=m
> > CONFIG_GENERIC_CPU_AUTOPROBE=y
> > CONFIG_GENERIC_CPU_VULNERABILITIES=y
> > CONFIG_REGMAP=y
> > CONFIG_REGMAP_I2C=m
> > CONFIG_REGMAP_SPI=y
> > CONFIG_REGMAP_SPMI=m
> > CONFIG_REGMAP_W1=m
> > CONFIG_REGMAP_MMIO=y
> > CONFIG_REGMAP_IRQ=y
> > CONFIG_DMA_SHARED_BUFFER=y
> > CONFIG_DMA_FENCE_TRACE=y
> > # end of Generic Driver Options
> > 
> > #
> > # Bus devices
> > #
> > # end of Bus devices
> > 
> > # CONFIG_CONNECTOR is not set
> > # CONFIG_GNSS is not set
> > CONFIG_MTD=y
> > # CONFIG_MTD_TESTS is not set
> > 
> > #
> > # Partition parsers
> > #
> > # CONFIG_MTD_AR7_PARTS is not set
> > # CONFIG_MTD_CMDLINE_PARTS is not set
> > CONFIG_MTD_REDBOOT_PARTS=m
> > CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> > CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
> > CONFIG_MTD_REDBOOT_PARTS_READONLY=y
> > # end of Partition parsers
> > 
> > #
> > # User Modules And Translation Layers
> > #
> > # CONFIG_MTD_BLOCK is not set
> > # CONFIG_MTD_BLOCK_RO is not set
> > # CONFIG_FTL is not set
> > # CONFIG_NFTL is not set
> > # CONFIG_INFTL is not set
> > # CONFIG_RFD_FTL is not set
> > # CONFIG_SSFDC is not set
> > # CONFIG_SM_FTL is not set
> > # CONFIG_MTD_OOPS is not set
> > # CONFIG_MTD_SWAP is not set
> > CONFIG_MTD_PARTITIONED_MASTER=y
> > 
> > #
> > # RAM/ROM/Flash chip drivers
> > #
> > CONFIG_MTD_CFI=y
> > CONFIG_MTD_JEDECPROBE=m
> > CONFIG_MTD_GEN_PROBE=y
> > CONFIG_MTD_CFI_ADV_OPTIONS=y
> > # CONFIG_MTD_CFI_NOSWAP is not set
> > CONFIG_MTD_CFI_BE_BYTE_SWAP=y
> > # CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
> > CONFIG_MTD_CFI_GEOMETRY=y
> > # CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
> > # CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
> > CONFIG_MTD_MAP_BANK_WIDTH_4=y
> > CONFIG_MTD_MAP_BANK_WIDTH_8=y
> > CONFIG_MTD_MAP_BANK_WIDTH_16=y
> > CONFIG_MTD_MAP_BANK_WIDTH_32=y
> > CONFIG_MTD_CFI_I1=y
> > # CONFIG_MTD_CFI_I2 is not set
> > # CONFIG_MTD_CFI_I4 is not set
> > CONFIG_MTD_CFI_I8=y
> > CONFIG_MTD_OTP=y
> > CONFIG_MTD_CFI_INTELEXT=m
> > CONFIG_MTD_CFI_AMDSTD=m
> > # CONFIG_MTD_CFI_STAA is not set
> > CONFIG_MTD_CFI_UTIL=y
> > CONFIG_MTD_RAM=y
> > CONFIG_MTD_ROM=m
> > CONFIG_MTD_ABSENT=m
> > # end of RAM/ROM/Flash chip drivers
> > 
> > #
> > # Mapping drivers for chip access
> > #
> > CONFIG_MTD_COMPLEX_MAPPINGS=y
> > CONFIG_MTD_PHYSMAP=m
> > # CONFIG_MTD_PHYSMAP_COMPAT is not set
> > # CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
> > CONFIG_MTD_SBC_GXX=m
> > CONFIG_MTD_AMD76XROM=m
> > CONFIG_MTD_ICHXROM=m
> > # CONFIG_MTD_ESB2ROM is not set
> > # CONFIG_MTD_CK804XROM is not set
> > # CONFIG_MTD_SCB2_FLASH is not set
> > CONFIG_MTD_NETtel=m
> > CONFIG_MTD_L440GX=m
> > # CONFIG_MTD_PCI is not set
> > CONFIG_MTD_PCMCIA=m
> > # CONFIG_MTD_PCMCIA_ANONYMOUS is not set
> > # CONFIG_MTD_INTEL_VR_NOR is not set
> > CONFIG_MTD_PLATRAM=y
> > # end of Mapping drivers for chip access
> > 
> > #
> > # Self-contained MTD device drivers
> > #
> > # CONFIG_MTD_PMC551 is not set
> > CONFIG_MTD_DATAFLASH=y
> > # CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
> > CONFIG_MTD_DATAFLASH_OTP=y
> > CONFIG_MTD_MCHP23K256=y
> > # CONFIG_MTD_SST25L is not set
> > # CONFIG_MTD_SLRAM is not set
> > CONFIG_MTD_PHRAM=m
> > # CONFIG_MTD_MTDRAM is not set
> > # CONFIG_MTD_BLOCK2MTD is not set
> > 
> > #
> > # Disk-On-Chip Device Drivers
> > #
> > CONFIG_MTD_DOCG3=y
> > CONFIG_BCH_CONST_M=14
> > CONFIG_BCH_CONST_T=4
> > # end of Self-contained MTD device drivers
> > 
> > # CONFIG_MTD_ONENAND is not set
> > # CONFIG_MTD_RAW_NAND is not set
> > # CONFIG_MTD_SPI_NAND is not set
> > 
> > #
> > # LPDDR & LPDDR2 PCM memory drivers
> > #
> > CONFIG_MTD_LPDDR=y
> > CONFIG_MTD_QINFO_PROBE=y
> > # end of LPDDR & LPDDR2 PCM memory drivers
> > 
> > CONFIG_MTD_SPI_NOR=m
> > # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
> > # CONFIG_SPI_MTK_QUADSPI is not set
> > CONFIG_SPI_INTEL_SPI=m
> > # CONFIG_SPI_INTEL_SPI_PCI is not set
> > CONFIG_SPI_INTEL_SPI_PLATFORM=m
> > CONFIG_MTD_UBI=m
> > CONFIG_MTD_UBI_WL_THRESHOLD=4096
> > CONFIG_MTD_UBI_BEB_LIMIT=20
> > # CONFIG_MTD_UBI_FASTMAP is not set
> > CONFIG_MTD_UBI_GLUEBI=m
> > # CONFIG_MTD_UBI_BLOCK is not set
> > # CONFIG_MTD_HYPERBUS is not set
> > # CONFIG_OF is not set
> > CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> > CONFIG_PARPORT=y
> > CONFIG_PARPORT_PC=y
> > # CONFIG_PARPORT_SERIAL is not set
> > CONFIG_PARPORT_PC_FIFO=y
> > CONFIG_PARPORT_PC_SUPERIO=y
> > # CONFIG_PARPORT_PC_PCMCIA is not set
> > CONFIG_PARPORT_AX88796=y
> > CONFIG_PARPORT_1284=y
> > CONFIG_PARPORT_NOT_PC=y
> > CONFIG_PNP=y
> > CONFIG_PNP_DEBUG_MESSAGES=y
> > 
> > #
> > # Protocols
> > #
> > CONFIG_PNPACPI=y
> > CONFIG_BLK_DEV=y
> > # CONFIG_BLK_DEV_NULL_BLK is not set
> > # CONFIG_PARIDE is not set
> > # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> > # CONFIG_ZRAM is not set
> > # CONFIG_BLK_DEV_UMEM is not set
> > # CONFIG_BLK_DEV_LOOP is not set
> > # CONFIG_BLK_DEV_DRBD is not set
> > # CONFIG_BLK_DEV_NBD is not set
> > # CONFIG_BLK_DEV_SKD is not set
> > # CONFIG_BLK_DEV_SX8 is not set
> > # CONFIG_BLK_DEV_RAM is not set
> > # CONFIG_CDROM_PKTCDVD is not set
> > # CONFIG_ATA_OVER_ETH is not set
> > # CONFIG_VIRTIO_BLK is not set
> > # CONFIG_BLK_DEV_RBD is not set
> > # CONFIG_BLK_DEV_RSXX is not set
> > 
> > #
> > # NVME Support
> > #
> > # CONFIG_BLK_DEV_NVME is not set
> > # CONFIG_NVME_FC is not set
> > # CONFIG_NVME_TARGET is not set
> > # end of NVME Support
> > 
> > #
> > # Misc devices
> > #
> > CONFIG_AD525X_DPOT=y
> > CONFIG_AD525X_DPOT_I2C=m
> > CONFIG_AD525X_DPOT_SPI=m
> > # CONFIG_DUMMY_IRQ is not set
> > # CONFIG_IBM_ASM is not set
> > # CONFIG_PHANTOM is not set
> > # CONFIG_TIFM_CORE is not set
> > CONFIG_ICS932S401=m
> > # CONFIG_ENCLOSURE_SERVICES is not set
> > # CONFIG_HP_ILO is not set
> > # CONFIG_APDS9802ALS is not set
> > # CONFIG_ISL29003 is not set
> > CONFIG_ISL29020=m
> > CONFIG_SENSORS_TSL2550=m
> > CONFIG_SENSORS_BH1770=m
> > CONFIG_SENSORS_APDS990X=m
> > CONFIG_HMC6352=m
> > CONFIG_DS1682=m
> > CONFIG_LATTICE_ECP3_CONFIG=m
> > CONFIG_SRAM=y
> > # CONFIG_PCI_ENDPOINT_TEST is not set
> > # CONFIG_XILINX_SDFEC is not set
> > # CONFIG_PVPANIC is not set
> > CONFIG_C2PORT=m
> > CONFIG_C2PORT_DURAMAR_2150=m
> > 
> > #
> > # EEPROM support
> > #
> > # CONFIG_EEPROM_AT24 is not set
> > CONFIG_EEPROM_AT25=y
> > CONFIG_EEPROM_LEGACY=m
> > # CONFIG_EEPROM_MAX6875 is not set
> > # CONFIG_EEPROM_93CX6 is not set
> > CONFIG_EEPROM_93XX46=y
> > CONFIG_EEPROM_IDT_89HPESX=m
> > # CONFIG_EEPROM_EE1004 is not set
> > # end of EEPROM support
> > 
> > # CONFIG_CB710_CORE is not set
> > 
> > #
> > # Texas Instruments shared transport line discipline
> > #
> > # CONFIG_TI_ST is not set
> > # end of Texas Instruments shared transport line discipline
> > 
> > # CONFIG_SENSORS_LIS3_I2C is not set
> > 
> > #
> > # Altera FPGA firmware download module (requires I2C)
> > #
> > CONFIG_ALTERA_STAPL=m
> > # CONFIG_INTEL_MEI is not set
> > # CONFIG_INTEL_MEI_ME is not set
> > # CONFIG_INTEL_MEI_TXE is not set
> > # CONFIG_VMWARE_VMCI is not set
> > 
> > #
> > # Intel MIC & related support
> > #
> > # CONFIG_INTEL_MIC_BUS is not set
> > # CONFIG_SCIF_BUS is not set
> > # CONFIG_VOP_BUS is not set
> > # end of Intel MIC & related support
> > 
> > # CONFIG_GENWQE is not set
> > CONFIG_ECHO=y
> > # CONFIG_MISC_ALCOR_PCI is not set
> > # CONFIG_MISC_RTSX_PCI is not set
> > # CONFIG_HABANA_AI is not set
> > # end of Misc devices
> > 
> > CONFIG_HAVE_IDE=y
> > # CONFIG_IDE is not set
> > 
> > #
> > # SCSI device support
> > #
> > CONFIG_SCSI_MOD=y
> > # CONFIG_RAID_ATTRS is not set
> > # CONFIG_SCSI is not set
> > # end of SCSI device support
> > 
> > # CONFIG_ATA is not set
> > # CONFIG_MD is not set
> > # CONFIG_TARGET_CORE is not set
> > # CONFIG_FUSION is not set
> > 
> > #
> > # IEEE 1394 (FireWire) support
> > #
> > CONFIG_FIREWIRE=m
> > # CONFIG_FIREWIRE_OHCI is not set
> > CONFIG_FIREWIRE_NET=m
> > # CONFIG_FIREWIRE_NOSY is not set
> > # end of IEEE 1394 (FireWire) support
> > 
> > # CONFIG_MACINTOSH_DRIVERS is not set
> > CONFIG_NETDEVICES=y
> > CONFIG_NET_CORE=y
> > # CONFIG_BONDING is not set
> > CONFIG_DUMMY=m
> > # CONFIG_WIREGUARD is not set
> > # CONFIG_EQUALIZER is not set
> > CONFIG_IFB=y
> > CONFIG_NET_TEAM=m
> > # CONFIG_NET_TEAM_MODE_BROADCAST is not set
> > # CONFIG_NET_TEAM_MODE_ROUNDROBIN is not set
> > # CONFIG_NET_TEAM_MODE_RANDOM is not set
> > # CONFIG_NET_TEAM_MODE_ACTIVEBACKUP is not set
> > CONFIG_NET_TEAM_MODE_LOADBALANCE=m
> > CONFIG_MACVLAN=m
> > CONFIG_MACVTAP=m
> > CONFIG_IPVLAN_L3S=y
> > CONFIG_IPVLAN=m
> > CONFIG_IPVTAP=m
> > # CONFIG_VXLAN is not set
> > # CONFIG_GENEVE is not set
> > # CONFIG_GTP is not set
> > CONFIG_MACSEC=y
> > CONFIG_NETCONSOLE=y
> > CONFIG_NETPOLL=y
> > CONFIG_NET_POLL_CONTROLLER=y
> > CONFIG_TUN=m
> > CONFIG_TAP=m
> > CONFIG_TUN_VNET_CROSS_LE=y
> > CONFIG_VETH=m
> > CONFIG_VIRTIO_NET=y
> > # CONFIG_NLMON is not set
> > CONFIG_NET_VRF=y
> > CONFIG_ARCNET=m
> > # CONFIG_ARCNET_1201 is not set
> > CONFIG_ARCNET_1051=m
> > CONFIG_ARCNET_RAW=m
> > CONFIG_ARCNET_CAP=m
> > # CONFIG_ARCNET_COM90xx is not set
> > # CONFIG_ARCNET_COM90xxIO is not set
> > # CONFIG_ARCNET_RIM_I is not set
> > CONFIG_ARCNET_COM20020=m
> > # CONFIG_ARCNET_COM20020_PCI is not set
> > CONFIG_ARCNET_COM20020_CS=m
> > CONFIG_ATM_DRIVERS=y
> > # CONFIG_ATM_DUMMY is not set
> > CONFIG_ATM_TCP=m
> > # CONFIG_ATM_LANAI is not set
> > # CONFIG_ATM_ENI is not set
> > # CONFIG_ATM_FIRESTREAM is not set
> > # CONFIG_ATM_ZATM is not set
> > # CONFIG_ATM_NICSTAR is not set
> > # CONFIG_ATM_IDT77252 is not set
> > # CONFIG_ATM_AMBASSADOR is not set
> > # CONFIG_ATM_HORIZON is not set
> > # CONFIG_ATM_IA is not set
> > # CONFIG_ATM_FORE200E is not set
> > # CONFIG_ATM_HE is not set
> > # CONFIG_ATM_SOLOS is not set
> > # CONFIG_CAIF_DRIVERS is not set
> > 
> > #
> > # Distributed Switch Architecture drivers
> > #
> > # end of Distributed Switch Architecture drivers
> > 
> > CONFIG_ETHERNET=y
> > CONFIG_NET_VENDOR_3COM=y
> > # CONFIG_PCMCIA_3C574 is not set
> > # CONFIG_PCMCIA_3C589 is not set
> > # CONFIG_VORTEX is not set
> > # CONFIG_TYPHOON is not set
> > CONFIG_NET_VENDOR_ADAPTEC=y
> > # CONFIG_ADAPTEC_STARFIRE is not set
> > CONFIG_NET_VENDOR_AGERE=y
> > # CONFIG_ET131X is not set
> > CONFIG_NET_VENDOR_ALACRITECH=y
> > # CONFIG_SLICOSS is not set
> > CONFIG_NET_VENDOR_ALTEON=y
> > # CONFIG_ACENIC is not set
> > # CONFIG_ALTERA_TSE is not set
> > CONFIG_NET_VENDOR_AMAZON=y
> > CONFIG_NET_VENDOR_AMD=y
> > # CONFIG_AMD8111_ETH is not set
> > # CONFIG_PCNET32 is not set
> > # CONFIG_PCMCIA_NMCLAN is not set
> > # CONFIG_AMD_XGBE is not set
> > CONFIG_NET_VENDOR_AQUANTIA=y
> > # CONFIG_AQTION is not set
> > CONFIG_NET_VENDOR_ARC=y
> > CONFIG_NET_VENDOR_ATHEROS=y
> > # CONFIG_ATL2 is not set
> > # CONFIG_ATL1 is not set
> > # CONFIG_ATL1E is not set
> > # CONFIG_ATL1C is not set
> > # CONFIG_ALX is not set
> > # CONFIG_NET_VENDOR_AURORA is not set
> > CONFIG_NET_VENDOR_BROADCOM=y
> > # CONFIG_B44 is not set
> > # CONFIG_BCMGENET is not set
> > # CONFIG_BNX2 is not set
> > # CONFIG_CNIC is not set
> > # CONFIG_TIGON3 is not set
> > # CONFIG_BNX2X is not set
> > # CONFIG_SYSTEMPORT is not set
> > # CONFIG_BNXT is not set
> > CONFIG_NET_VENDOR_BROCADE=y
> > # CONFIG_BNA is not set
> > CONFIG_NET_VENDOR_CADENCE=y
> > # CONFIG_MACB is not set
> > CONFIG_NET_VENDOR_CAVIUM=y
> > # CONFIG_THUNDER_NIC_PF is not set
> > # CONFIG_THUNDER_NIC_VF is not set
> > # CONFIG_THUNDER_NIC_BGX is not set
> > # CONFIG_THUNDER_NIC_RGX is not set
> > # CONFIG_CAVIUM_PTP is not set
> > # CONFIG_LIQUIDIO is not set
> > CONFIG_NET_VENDOR_CHELSIO=y
> > # CONFIG_CHELSIO_T1 is not set
> > # CONFIG_CHELSIO_T3 is not set
> > # CONFIG_CHELSIO_T4 is not set
> > # CONFIG_CHELSIO_T4VF is not set
> > CONFIG_NET_VENDOR_CISCO=y
> > # CONFIG_ENIC is not set
> > CONFIG_NET_VENDOR_CORTINA=y
> > # CONFIG_CX_ECAT is not set
> > # CONFIG_DNET is not set
> > CONFIG_NET_VENDOR_DEC=y
> > # CONFIG_NET_TULIP is not set
> > CONFIG_NET_VENDOR_DLINK=y
> > # CONFIG_DL2K is not set
> > # CONFIG_SUNDANCE is not set
> > CONFIG_NET_VENDOR_EMULEX=y
> > # CONFIG_BE2NET is not set
> > CONFIG_NET_VENDOR_EZCHIP=y
> > CONFIG_NET_VENDOR_FUJITSU=y
> > # CONFIG_PCMCIA_FMVJ18X is not set
> > CONFIG_NET_VENDOR_GOOGLE=y
> > CONFIG_NET_VENDOR_HUAWEI=y
> > CONFIG_NET_VENDOR_I825XX=y
> > CONFIG_NET_VENDOR_INTEL=y
> > # CONFIG_E100 is not set
> > CONFIG_E1000=y
> > # CONFIG_E1000E is not set
> > # CONFIG_IGB is not set
> > # CONFIG_IGBVF is not set
> > # CONFIG_IXGB is not set
> > # CONFIG_IXGBE is not set
> > # CONFIG_I40E is not set
> > # CONFIG_IGC is not set
> > # CONFIG_JME is not set
> > CONFIG_NET_VENDOR_MARVELL=y
> > # CONFIG_MVMDIO is not set
> > # CONFIG_SKGE is not set
> > # CONFIG_SKY2 is not set
> > CONFIG_NET_VENDOR_MELLANOX=y
> > # CONFIG_MLX4_EN is not set
> > # CONFIG_MLX5_CORE is not set
> > # CONFIG_MLXSW_CORE is not set
> > # CONFIG_MLXFW is not set
> > CONFIG_NET_VENDOR_MICREL=y
> > # CONFIG_KS8851 is not set
> > # CONFIG_KS8851_MLL is not set
> > # CONFIG_KSZ884X_PCI is not set
> > CONFIG_NET_VENDOR_MICROCHIP=y
> > # CONFIG_ENC28J60 is not set
> > # CONFIG_ENCX24J600 is not set
> > # CONFIG_LAN743X is not set
> > CONFIG_NET_VENDOR_MICROSEMI=y
> > # CONFIG_MSCC_OCELOT_SWITCH is not set
> > CONFIG_NET_VENDOR_MYRI=y
> > # CONFIG_MYRI10GE is not set
> > # CONFIG_FEALNX is not set
> > CONFIG_NET_VENDOR_NATSEMI=y
> > # CONFIG_NATSEMI is not set
> > # CONFIG_NS83820 is not set
> > CONFIG_NET_VENDOR_NETERION=y
> > # CONFIG_S2IO is not set
> > # CONFIG_VXGE is not set
> > CONFIG_NET_VENDOR_NETRONOME=y
> > CONFIG_NET_VENDOR_NI=y
> > # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> > CONFIG_NET_VENDOR_8390=y
> > # CONFIG_PCMCIA_AXNET is not set
> > # CONFIG_NE2K_PCI is not set
> > # CONFIG_PCMCIA_PCNET is not set
> > CONFIG_NET_VENDOR_NVIDIA=y
> > # CONFIG_FORCEDETH is not set
> > CONFIG_NET_VENDOR_OKI=y
> > # CONFIG_ETHOC is not set
> > CONFIG_NET_VENDOR_PACKET_ENGINES=y
> > # CONFIG_HAMACHI is not set
> > # CONFIG_YELLOWFIN is not set
> > CONFIG_NET_VENDOR_PENSANDO=y
> > # CONFIG_IONIC is not set
> > CONFIG_NET_VENDOR_QLOGIC=y
> > # CONFIG_QLA3XXX is not set
> > # CONFIG_QLCNIC is not set
> > # CONFIG_NETXEN_NIC is not set
> > # CONFIG_QED is not set
> > CONFIG_NET_VENDOR_QUALCOMM=y
> > # CONFIG_QCOM_EMAC is not set
> > # CONFIG_RMNET is not set
> > CONFIG_NET_VENDOR_RDC=y
> > # CONFIG_R6040 is not set
> > CONFIG_NET_VENDOR_REALTEK=y
> > # CONFIG_ATP is not set
> > # CONFIG_8139CP is not set
> > # CONFIG_8139TOO is not set
> > # CONFIG_R8169 is not set
> > CONFIG_NET_VENDOR_RENESAS=y
> > CONFIG_NET_VENDOR_ROCKER=y
> > CONFIG_NET_VENDOR_SAMSUNG=y
> > # CONFIG_SXGBE_ETH is not set
> > CONFIG_NET_VENDOR_SEEQ=y
> > CONFIG_NET_VENDOR_SOLARFLARE=y
> > # CONFIG_SFC is not set
> > # CONFIG_SFC_FALCON is not set
> > CONFIG_NET_VENDOR_SILAN=y
> > # CONFIG_SC92031 is not set
> > CONFIG_NET_VENDOR_SIS=y
> > # CONFIG_SIS900 is not set
> > # CONFIG_SIS190 is not set
> > CONFIG_NET_VENDOR_SMSC=y
> > # CONFIG_PCMCIA_SMC91C92 is not set
> > # CONFIG_EPIC100 is not set
> > # CONFIG_SMSC911X is not set
> > # CONFIG_SMSC9420 is not set
> > CONFIG_NET_VENDOR_SOCIONEXT=y
> > CONFIG_NET_VENDOR_STMICRO=y
> > # CONFIG_STMMAC_ETH is not set
> > CONFIG_NET_VENDOR_SUN=y
> > # CONFIG_HAPPYMEAL is not set
> > # CONFIG_SUNGEM is not set
> > # CONFIG_CASSINI is not set
> > # CONFIG_NIU is not set
> > CONFIG_NET_VENDOR_SYNOPSYS=y
> > # CONFIG_DWC_XLGMAC is not set
> > CONFIG_NET_VENDOR_TEHUTI=y
> > # CONFIG_TEHUTI is not set
> > CONFIG_NET_VENDOR_TI=y
> > # CONFIG_TI_CPSW_PHY_SEL is not set
> > # CONFIG_TLAN is not set
> > CONFIG_NET_VENDOR_VIA=y
> > # CONFIG_VIA_RHINE is not set
> > # CONFIG_VIA_VELOCITY is not set
> > CONFIG_NET_VENDOR_WIZNET=y
> > # CONFIG_WIZNET_W5100 is not set
> > # CONFIG_WIZNET_W5300 is not set
> > CONFIG_NET_VENDOR_XILINX=y
> > # CONFIG_XILINX_AXI_EMAC is not set
> > # CONFIG_XILINX_LL_TEMAC is not set
> > CONFIG_NET_VENDOR_XIRCOM=y
> > # CONFIG_PCMCIA_XIRC2PS is not set
> > # CONFIG_FDDI is not set
> > # CONFIG_HIPPI is not set
> > # CONFIG_NET_SB1000 is not set
> > CONFIG_MDIO_DEVICE=m
> > CONFIG_MDIO_BUS=m
> > # CONFIG_MDIO_BCM_UNIMAC is not set
> > CONFIG_MDIO_BITBANG=m
> > CONFIG_MDIO_GPIO=m
> > # CONFIG_MDIO_MSCC_MIIM is not set
> > # CONFIG_MDIO_THUNDER is not set
> > CONFIG_PHYLIB=m
> > CONFIG_SWPHY=y
> > # CONFIG_LED_TRIGGER_PHY is not set
> > 
> > #
> > # MII PHY device drivers
> > #
> > # CONFIG_ADIN_PHY is not set
> > CONFIG_AMD_PHY=m
> > CONFIG_AQUANTIA_PHY=m
> > # CONFIG_AX88796B_PHY is not set
> > CONFIG_BCM7XXX_PHY=m
> > # CONFIG_BCM87XX_PHY is not set
> > CONFIG_BCM_NET_PHYLIB=m
> > CONFIG_BROADCOM_PHY=m
> > # CONFIG_CICADA_PHY is not set
> > CONFIG_CORTINA_PHY=m
> > # CONFIG_DAVICOM_PHY is not set
> > # CONFIG_DP83822_PHY is not set
> > # CONFIG_DP83TC811_PHY is not set
> > CONFIG_DP83848_PHY=m
> > CONFIG_DP83867_PHY=m
> > # CONFIG_DP83869_PHY is not set
> > CONFIG_FIXED_PHY=m
> > # CONFIG_ICPLUS_PHY is not set
> > # CONFIG_INTEL_XWAY_PHY is not set
> > # CONFIG_LSI_ET1011C_PHY is not set
> > CONFIG_LXT_PHY=m
> > CONFIG_MARVELL_PHY=m
> > # CONFIG_MARVELL_10G_PHY is not set
> > CONFIG_MICREL_PHY=m
> > # CONFIG_MICROCHIP_PHY is not set
> > # CONFIG_MICROCHIP_T1_PHY is not set
> > CONFIG_MICROSEMI_PHY=m
> > CONFIG_NATIONAL_PHY=m
> > # CONFIG_NXP_TJA11XX_PHY is not set
> > # CONFIG_AT803X_PHY is not set
> > CONFIG_QSEMI_PHY=m
> > CONFIG_REALTEK_PHY=m
> > # CONFIG_RENESAS_PHY is not set
> > CONFIG_ROCKCHIP_PHY=m
> > CONFIG_SMSC_PHY=m
> > # CONFIG_STE10XP is not set
> > CONFIG_TERANETICS_PHY=m
> > CONFIG_VITESSE_PHY=m
> > # CONFIG_XILINX_GMII2RGMII is not set
> > CONFIG_MICREL_KS8995MA=m
> > # CONFIG_PLIP is not set
> > CONFIG_PPP=y
> > # CONFIG_PPP_BSDCOMP is not set
> > CONFIG_PPP_DEFLATE=m
> > CONFIG_PPP_FILTER=y
> > CONFIG_PPP_MPPE=y
> > # CONFIG_PPP_MULTILINK is not set
> > CONFIG_PPPOATM=y
> > CONFIG_PPPOE=y
> > # CONFIG_PPP_ASYNC is not set
> > # CONFIG_PPP_SYNC_TTY is not set
> > # CONFIG_SLIP is not set
> > CONFIG_SLHC=y
> > 
> > #
> > # Host-side USB support is needed for USB Network Adapter support
> > #
> > # CONFIG_WLAN is not set
> > 
> > #
> > # WiMAX Wireless Broadband devices
> > #
> > 
> > #
> > # Enable USB support to see WiMAX USB drivers
> > #
> > # end of WiMAX Wireless Broadband devices
> > 
> > # CONFIG_WAN is not set
> > CONFIG_IEEE802154_DRIVERS=m
> > # CONFIG_VMXNET3 is not set
> > # CONFIG_FUJITSU_ES is not set
> > # CONFIG_NETDEVSIM is not set
> > CONFIG_NET_FAILOVER=y
> > CONFIG_ISDN=y
> > CONFIG_ISDN_CAPI=y
> > CONFIG_MISDN=y
> > # CONFIG_MISDN_DSP is not set
> > # CONFIG_MISDN_L1OIP is not set
> > 
> > #
> > # mISDN hardware drivers
> > #
> > # CONFIG_MISDN_HFCPCI is not set
> > # CONFIG_MISDN_HFCMULTI is not set
> > # CONFIG_MISDN_AVMFRITZ is not set
> > # CONFIG_MISDN_SPEEDFAX is not set
> > # CONFIG_MISDN_INFINEON is not set
> > # CONFIG_MISDN_W6692 is not set
> > # CONFIG_MISDN_NETJET is not set
> > CONFIG_NVM=y
> > # CONFIG_NVM_PBLK is not set
> > 
> > #
> > # Input device support
> > #
> > CONFIG_INPUT=y
> > CONFIG_INPUT_LEDS=m
> > # CONFIG_INPUT_FF_MEMLESS is not set
> > # CONFIG_INPUT_POLLDEV is not set
> > # CONFIG_INPUT_SPARSEKMAP is not set
> > # CONFIG_INPUT_MATRIXKMAP is not set
> > 
> > #
> > # Userland interfaces
> > #
> > # CONFIG_INPUT_MOUSEDEV is not set
> > # CONFIG_INPUT_JOYDEV is not set
> > # CONFIG_INPUT_EVDEV is not set
> > # CONFIG_INPUT_EVBUG is not set
> > 
> > #
> > # Input Device Drivers
> > #
> > CONFIG_INPUT_KEYBOARD=y
> > # CONFIG_KEYBOARD_ADC is not set
> > # CONFIG_KEYBOARD_ADP5588 is not set
> > # CONFIG_KEYBOARD_ADP5589 is not set
> > # CONFIG_KEYBOARD_APPLESPI is not set
> > CONFIG_KEYBOARD_ATKBD=y
> > # CONFIG_KEYBOARD_QT1050 is not set
> > # CONFIG_KEYBOARD_QT1070 is not set
> > # CONFIG_KEYBOARD_QT2160 is not set
> > # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> > # CONFIG_KEYBOARD_LKKBD is not set
> > # CONFIG_KEYBOARD_GPIO is not set
> > # CONFIG_KEYBOARD_GPIO_POLLED is not set
> > # CONFIG_KEYBOARD_TCA6416 is not set
> > # CONFIG_KEYBOARD_TCA8418 is not set
> > # CONFIG_KEYBOARD_MATRIX is not set
> > # CONFIG_KEYBOARD_LM8323 is not set
> > # CONFIG_KEYBOARD_LM8333 is not set
> > # CONFIG_KEYBOARD_MAX7359 is not set
> > # CONFIG_KEYBOARD_MCS is not set
> > # CONFIG_KEYBOARD_MPR121 is not set
> > # CONFIG_KEYBOARD_NEWTON is not set
> > # CONFIG_KEYBOARD_OPENCORES is not set
> > # CONFIG_KEYBOARD_SAMSUNG is not set
> > # CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
> > # CONFIG_KEYBOARD_STOWAWAY is not set
> > # CONFIG_KEYBOARD_SUNKBD is not set
> > # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> > # CONFIG_KEYBOARD_XTKBD is not set
> > # CONFIG_KEYBOARD_CROS_EC is not set
> > CONFIG_INPUT_MOUSE=y
> > CONFIG_MOUSE_PS2=y
> > CONFIG_MOUSE_PS2_ALPS=y
> > CONFIG_MOUSE_PS2_BYD=y
> > CONFIG_MOUSE_PS2_LOGIPS2PP=y
> > CONFIG_MOUSE_PS2_SYNAPTICS=y
> > CONFIG_MOUSE_PS2_CYPRESS=y
> > CONFIG_MOUSE_PS2_LIFEBOOK=y
> > CONFIG_MOUSE_PS2_TRACKPOINT=y
> > # CONFIG_MOUSE_PS2_ELANTECH is not set
> > # CONFIG_MOUSE_PS2_SENTELIC is not set
> > # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> > CONFIG_MOUSE_PS2_FOCALTECH=y
> > # CONFIG_MOUSE_PS2_VMMOUSE is not set
> > # CONFIG_MOUSE_SERIAL is not set
> > # CONFIG_MOUSE_APPLETOUCH is not set
> > # CONFIG_MOUSE_BCM5974 is not set
> > # CONFIG_MOUSE_CYAPA is not set
> > # CONFIG_MOUSE_ELAN_I2C is not set
> > # CONFIG_MOUSE_VSXXXAA is not set
> > # CONFIG_MOUSE_GPIO is not set
> > # CONFIG_MOUSE_SYNAPTICS_I2C is not set
> > # CONFIG_MOUSE_SYNAPTICS_USB is not set
> > # CONFIG_INPUT_JOYSTICK is not set
> > # CONFIG_INPUT_TABLET is not set
> > # CONFIG_INPUT_TOUCHSCREEN is not set
> > # CONFIG_INPUT_MISC is not set
> > # CONFIG_RMI4_CORE is not set
> > 
> > #
> > # Hardware I/O ports
> > #
> > CONFIG_SERIO=y
> > CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> > CONFIG_SERIO_I8042=y
> > CONFIG_SERIO_SERPORT=y
> > # CONFIG_SERIO_CT82C710 is not set
> > CONFIG_SERIO_PARKBD=m
> > # CONFIG_SERIO_PCIPS2 is not set
> > CONFIG_SERIO_LIBPS2=y
> > CONFIG_SERIO_RAW=m
> > CONFIG_SERIO_ALTERA_PS2=m
> > CONFIG_SERIO_PS2MULT=m
> > CONFIG_SERIO_ARC_PS2=m
> > # CONFIG_SERIO_GPIO_PS2 is not set
> > # CONFIG_USERIO is not set
> > CONFIG_GAMEPORT=y
> > CONFIG_GAMEPORT_NS558=y
> > CONFIG_GAMEPORT_L4=m
> > # CONFIG_GAMEPORT_EMU10K1 is not set
> > # CONFIG_GAMEPORT_FM801 is not set
> > # end of Hardware I/O ports
> > # end of Input device support
> > 
> > #
> > # Character devices
> > #
> > CONFIG_TTY=y
> > # CONFIG_VT is not set
> > CONFIG_UNIX98_PTYS=y
> > CONFIG_LEGACY_PTYS=y
> > CONFIG_LEGACY_PTY_COUNT=256
> > # CONFIG_SERIAL_NONSTANDARD is not set
> > # CONFIG_NOZOMI is not set
> > # CONFIG_N_GSM is not set
> > # CONFIG_TRACE_SINK is not set
> > # CONFIG_NULL_TTY is not set
> > # CONFIG_GOLDFISH_TTY is not set
> > CONFIG_LDISC_AUTOLOAD=y
> > CONFIG_DEVMEM=y
> > # CONFIG_DEVKMEM is not set
> > 
> > #
> > # Serial drivers
> > #
> > CONFIG_SERIAL_EARLYCON=y
> > CONFIG_SERIAL_8250=y
> > CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> > CONFIG_SERIAL_8250_PNP=y
> > # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> > # CONFIG_SERIAL_8250_FINTEK is not set
> > CONFIG_SERIAL_8250_CONSOLE=y
> > CONFIG_SERIAL_8250_PCI=y
> > CONFIG_SERIAL_8250_EXAR=y
> > # CONFIG_SERIAL_8250_CS is not set
> > # CONFIG_SERIAL_8250_MEN_MCB is not set
> > CONFIG_SERIAL_8250_NR_UARTS=4
> > CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> > # CONFIG_SERIAL_8250_EXTENDED is not set
> > CONFIG_SERIAL_8250_DWLIB=y
> > # CONFIG_SERIAL_8250_DW is not set
> > # CONFIG_SERIAL_8250_RT288X is not set
> > CONFIG_SERIAL_8250_LPSS=y
> > CONFIG_SERIAL_8250_MID=y
> > 
> > #
> > # Non-8250 serial port support
> > #
> > # CONFIG_SERIAL_MAX3100 is not set
> > # CONFIG_SERIAL_MAX310X is not set
> > # CONFIG_SERIAL_UARTLITE is not set
> > CONFIG_SERIAL_CORE=y
> > CONFIG_SERIAL_CORE_CONSOLE=y
> > # CONFIG_SERIAL_JSM is not set
> > # CONFIG_SERIAL_SCCNXP is not set
> > # CONFIG_SERIAL_SC16IS7XX is not set
> > # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> > # CONFIG_SERIAL_ALTERA_UART is not set
> > # CONFIG_SERIAL_IFX6X60 is not set
> > # CONFIG_SERIAL_ARC is not set
> > # CONFIG_SERIAL_RP2 is not set
> > # CONFIG_SERIAL_FSL_LPUART is not set
> > # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> > # CONFIG_SERIAL_MEN_Z135 is not set
> > # end of Serial drivers
> > 
> > CONFIG_SERIAL_MCTRL_GPIO=y
> > # CONFIG_SERIAL_DEV_BUS is not set
> > # CONFIG_TTY_PRINTK is not set
> > # CONFIG_PRINTER is not set
> > CONFIG_PPDEV=m
> > # CONFIG_VIRTIO_CONSOLE is not set
> > CONFIG_IPMI_HANDLER=m
> > CONFIG_IPMI_DMI_DECODE=y
> > CONFIG_IPMI_PLAT_DATA=y
> > # CONFIG_IPMI_PANIC_EVENT is not set
> > # CONFIG_IPMI_DEVICE_INTERFACE is not set
> > CONFIG_IPMI_SI=m
> > CONFIG_IPMI_SSIF=m
> > # CONFIG_IPMI_WATCHDOG is not set
> > CONFIG_IPMI_POWEROFF=m
> > # CONFIG_IPMB_DEVICE_INTERFACE is not set
> > # CONFIG_HW_RANDOM is not set
> > CONFIG_NVRAM=y
> > # CONFIG_APPLICOM is not set
> > 
> > #
> > # PCMCIA character devices
> > #
> > # CONFIG_SYNCLINK_CS is not set
> > CONFIG_CARDMAN_4000=m
> > CONFIG_CARDMAN_4040=m
> > CONFIG_SCR24X=m
> > # CONFIG_IPWIRELESS is not set
> > # end of PCMCIA character devices
> > 
> > # CONFIG_MWAVE is not set
> > # CONFIG_RAW_DRIVER is not set
> > # CONFIG_HPET is not set
> > CONFIG_HANGCHECK_TIMER=y
> > # CONFIG_TCG_TPM is not set
> > CONFIG_TELCLOCK=y
> > CONFIG_DEVPORT=y
> > # CONFIG_XILLYBUS is not set
> > # end of Character devices
> > 
> > # CONFIG_RANDOM_TRUST_CPU is not set
> > # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> > 
> > #
> > # I2C support
> > #
> > CONFIG_I2C=m
> > CONFIG_I2C_BOARDINFO=y
> > CONFIG_I2C_COMPAT=y
> > # CONFIG_I2C_CHARDEV is not set
> > CONFIG_I2C_MUX=m
> > 
> > #
> > # Multiplexer I2C Chip support
> > #
> > CONFIG_I2C_MUX_GPIO=m
> > # CONFIG_I2C_MUX_LTC4306 is not set
> > CONFIG_I2C_MUX_PCA9541=m
> > # CONFIG_I2C_MUX_PCA954x is not set
> > # CONFIG_I2C_MUX_REG is not set
> > # CONFIG_I2C_MUX_MLXCPLD is not set
> > # end of Multiplexer I2C Chip support
> > 
> > # CONFIG_I2C_HELPER_AUTO is not set
> > CONFIG_I2C_SMBUS=m
> > 
> > #
> > # I2C Algorithms
> > #
> > CONFIG_I2C_ALGOBIT=m
> > CONFIG_I2C_ALGOPCF=m
> > CONFIG_I2C_ALGOPCA=m
> > # end of I2C Algorithms
> > 
> > #
> > # I2C Hardware Bus support
> > #
> > 
> > #
> > # PC SMBus host controller drivers
> > #
> > # CONFIG_I2C_ALI1535 is not set
> > # CONFIG_I2C_ALI1563 is not set
> > # CONFIG_I2C_ALI15X3 is not set
> > # CONFIG_I2C_AMD756 is not set
> > # CONFIG_I2C_AMD8111 is not set
> > # CONFIG_I2C_AMD_MP2 is not set
> > # CONFIG_I2C_I801 is not set
> > # CONFIG_I2C_ISCH is not set
> > # CONFIG_I2C_ISMT is not set
> > # CONFIG_I2C_PIIX4 is not set
> > # CONFIG_I2C_NFORCE2 is not set
> > # CONFIG_I2C_NVIDIA_GPU is not set
> > # CONFIG_I2C_SIS5595 is not set
> > # CONFIG_I2C_SIS630 is not set
> > # CONFIG_I2C_SIS96X is not set
> > # CONFIG_I2C_VIA is not set
> > # CONFIG_I2C_VIAPRO is not set
> > 
> > #
> > # ACPI drivers
> > #
> > # CONFIG_I2C_SCMI is not set
> > 
> > #
> > # I2C system bus drivers (mostly embedded / system-on-chip)
> > #
> > # CONFIG_I2C_CBUS_GPIO is not set
> > CONFIG_I2C_DESIGNWARE_CORE=m
> > CONFIG_I2C_DESIGNWARE_PLATFORM=m
> > # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> > # CONFIG_I2C_DESIGNWARE_PCI is not set
> > # CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
> > # CONFIG_I2C_EMEV2 is not set
> > CONFIG_I2C_GPIO=m
> > # CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
> > # CONFIG_I2C_KEMPLD is not set
> > CONFIG_I2C_OCORES=m
> > CONFIG_I2C_PCA_PLATFORM=m
> > CONFIG_I2C_SIMTEC=m
> > CONFIG_I2C_XILINX=m
> > 
> > #
> > # External I2C/SMBus adapter drivers
> > #
> > CONFIG_I2C_PARPORT=m
> > # CONFIG_I2C_TAOS_EVM is not set
> > 
> > #
> > # Other I2C/SMBus bus drivers
> > #
> > CONFIG_I2C_MLXCPLD=m
> > CONFIG_I2C_CROS_EC_TUNNEL=m
> > # end of I2C Hardware Bus support
> > 
> > CONFIG_I2C_STUB=m
> > CONFIG_I2C_SLAVE=y
> > CONFIG_I2C_SLAVE_EEPROM=m
> > # CONFIG_I2C_DEBUG_CORE is not set
> > # CONFIG_I2C_DEBUG_ALGO is not set
> > # CONFIG_I2C_DEBUG_BUS is not set
> > # end of I2C support
> > 
> > # CONFIG_I3C is not set
> > CONFIG_SPI=y
> > CONFIG_SPI_DEBUG=y
> > CONFIG_SPI_MASTER=y
> > CONFIG_SPI_MEM=y
> > 
> > #
> > # SPI Master Controller Drivers
> > #
> > CONFIG_SPI_ALTERA=y
> > # CONFIG_SPI_AXI_SPI_ENGINE is not set
> > CONFIG_SPI_BITBANG=y
> > CONFIG_SPI_BUTTERFLY=y
> > CONFIG_SPI_CADENCE=m
> > CONFIG_SPI_DESIGNWARE=m
> > # CONFIG_SPI_DW_PCI is not set
> > # CONFIG_SPI_DW_MMIO is not set
> > # CONFIG_SPI_NXP_FLEXSPI is not set
> > # CONFIG_SPI_GPIO is not set
> > CONFIG_SPI_LM70_LLP=y
> > # CONFIG_SPI_OC_TINY is not set
> > # CONFIG_SPI_PXA2XX is not set
> > # CONFIG_SPI_ROCKCHIP is not set
> > # CONFIG_SPI_SC18IS602 is not set
> > # CONFIG_SPI_SIFIVE is not set
> > # CONFIG_SPI_MXIC is not set
> > # CONFIG_SPI_XCOMM is not set
> > CONFIG_SPI_XILINX=y
> > CONFIG_SPI_ZYNQMP_GQSPI=y
> > 
> > #
> > # SPI Protocol Masters
> > #
> > # CONFIG_SPI_SPIDEV is not set
> > # CONFIG_SPI_LOOPBACK_TEST is not set
> > # CONFIG_SPI_TLE62X0 is not set
> > # CONFIG_SPI_SLAVE is not set
> > CONFIG_SPMI=y
> > CONFIG_HSI=y
> > CONFIG_HSI_BOARDINFO=y
> > 
> > #
> > # HSI controllers
> > #
> > 
> > #
> > # HSI clients
> > #
> > CONFIG_HSI_CHAR=y
> > # CONFIG_PPS is not set
> > 
> > #
> > # PTP clock support
> > #
> > # CONFIG_PTP_1588_CLOCK is not set
> > # end of PTP clock support
> > 
> > # CONFIG_PINCTRL is not set
> > CONFIG_GPIOLIB=y
> > CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> > CONFIG_GPIO_ACPI=y
> > CONFIG_GPIOLIB_IRQCHIP=y
> > CONFIG_DEBUG_GPIO=y
> > CONFIG_GPIO_SYSFS=y
> > CONFIG_GPIO_GENERIC=m
> > CONFIG_GPIO_MAX730X=y
> > 
> > #
> > # Memory mapped GPIO drivers
> > #
> > # CONFIG_GPIO_AMDPT is not set
> > CONFIG_GPIO_DWAPB=m
> > # CONFIG_GPIO_EXAR is not set
> > # CONFIG_GPIO_GENERIC_PLATFORM is not set
> > # CONFIG_GPIO_ICH is not set
> > # CONFIG_GPIO_MB86S7X is not set
> > # CONFIG_GPIO_MENZ127 is not set
> > # CONFIG_GPIO_VX855 is not set
> > # CONFIG_GPIO_XILINX is not set
> > # CONFIG_GPIO_AMD_FCH is not set
> > # end of Memory mapped GPIO drivers
> > 
> > #
> > # Port-mapped I/O GPIO drivers
> > #
> > CONFIG_GPIO_104_DIO_48E=y
> > # CONFIG_GPIO_104_IDIO_16 is not set
> > # CONFIG_GPIO_104_IDI_48 is not set
> > # CONFIG_GPIO_F7188X is not set
> > CONFIG_GPIO_GPIO_MM=y
> > CONFIG_GPIO_IT87=y
> > # CONFIG_GPIO_SCH is not set
> > CONFIG_GPIO_SCH311X=m
> > # CONFIG_GPIO_WINBOND is not set
> > CONFIG_GPIO_WS16C48=y
> > # end of Port-mapped I/O GPIO drivers
> > 
> > #
> > # I2C GPIO expanders
> > #
> > CONFIG_GPIO_ADP5588=m
> > CONFIG_GPIO_MAX7300=m
> > CONFIG_GPIO_MAX732X=m
> > # CONFIG_GPIO_PCA953X is not set
> > # CONFIG_GPIO_PCF857X is not set
> > # CONFIG_GPIO_TPIC2810 is not set
> > # end of I2C GPIO expanders
> > 
> > #
> > # MFD GPIO expanders
> > #
> > # CONFIG_GPIO_BD9571MWV is not set
> > CONFIG_GPIO_KEMPLD=m
> > # CONFIG_GPIO_LP873X is not set
> > CONFIG_GPIO_TPS65086=m
> > # CONFIG_GPIO_TPS65912 is not set
> > CONFIG_GPIO_UCB1400=m
> > CONFIG_GPIO_WM831X=m
> > # end of MFD GPIO expanders
> > 
> > #
> > # PCI GPIO expanders
> > #
> > # CONFIG_GPIO_AMD8111 is not set
> > # CONFIG_GPIO_BT8XX is not set
> > # CONFIG_GPIO_ML_IOH is not set
> > # CONFIG_GPIO_PCI_IDIO_16 is not set
> > # CONFIG_GPIO_PCIE_IDIO_24 is not set
> > # CONFIG_GPIO_RDC321X is not set
> > # end of PCI GPIO expanders
> > 
> > #
> > # SPI GPIO expanders
> > #
> > # CONFIG_GPIO_MAX3191X is not set
> > CONFIG_GPIO_MAX7301=y
> > CONFIG_GPIO_MC33880=m
> > CONFIG_GPIO_PISOSR=m
> > CONFIG_GPIO_XRA1403=y
> > # end of SPI GPIO expanders
> > 
> > CONFIG_GPIO_MOCKUP=y
> > CONFIG_W1=y
> > 
> > #
> > # 1-wire Bus Masters
> > #
> > # CONFIG_W1_MASTER_MATROX is not set
> > # CONFIG_W1_MASTER_DS2482 is not set
> > CONFIG_W1_MASTER_DS1WM=m
> > CONFIG_W1_MASTER_GPIO=y
> > # CONFIG_W1_MASTER_SGI is not set
> > # end of 1-wire Bus Masters
> > 
> > #
> > # 1-wire Slaves
> > #
> > CONFIG_W1_SLAVE_THERM=m
> > # CONFIG_W1_SLAVE_SMEM is not set
> > CONFIG_W1_SLAVE_DS2405=m
> > # CONFIG_W1_SLAVE_DS2408 is not set
> > # CONFIG_W1_SLAVE_DS2413 is not set
> > # CONFIG_W1_SLAVE_DS2406 is not set
> > CONFIG_W1_SLAVE_DS2423=y
> > CONFIG_W1_SLAVE_DS2805=y
> > # CONFIG_W1_SLAVE_DS2430 is not set
> > CONFIG_W1_SLAVE_DS2431=y
> > # CONFIG_W1_SLAVE_DS2433 is not set
> > CONFIG_W1_SLAVE_DS2438=m
> > # CONFIG_W1_SLAVE_DS250X is not set
> > CONFIG_W1_SLAVE_DS2780=y
> > CONFIG_W1_SLAVE_DS2781=y
> > CONFIG_W1_SLAVE_DS28E04=m
> > # CONFIG_W1_SLAVE_DS28E17 is not set
> > # end of 1-wire Slaves
> > 
> > CONFIG_POWER_AVS=y
> > # CONFIG_QCOM_CPR is not set
> > CONFIG_POWER_RESET=y
> > # CONFIG_POWER_RESET_RESTART is not set
> > CONFIG_POWER_SUPPLY=y
> > CONFIG_POWER_SUPPLY_DEBUG=y
> > CONFIG_POWER_SUPPLY_HWMON=y
> > CONFIG_PDA_POWER=y
> > CONFIG_GENERIC_ADC_BATTERY=m
> > CONFIG_WM831X_BACKUP=y
> > # CONFIG_WM831X_POWER is not set
> > # CONFIG_TEST_POWER is not set
> > # CONFIG_CHARGER_ADP5061 is not set
> > CONFIG_BATTERY_DS2760=m
> > # CONFIG_BATTERY_DS2780 is not set
> > CONFIG_BATTERY_DS2781=y
> > CONFIG_BATTERY_DS2782=m
> > CONFIG_BATTERY_SBS=m
> > CONFIG_CHARGER_SBS=m
> > # CONFIG_MANAGER_SBS is not set
> > # CONFIG_BATTERY_BQ27XXX is not set
> > CONFIG_BATTERY_DA9150=m
> > # CONFIG_BATTERY_MAX17040 is not set
> > # CONFIG_BATTERY_MAX17042 is not set
> > CONFIG_BATTERY_MAX1721X=m
> > # CONFIG_CHARGER_MAX8903 is not set
> > CONFIG_CHARGER_LP8727=m
> > CONFIG_CHARGER_GPIO=y
> > # CONFIG_CHARGER_MANAGER is not set
> > # CONFIG_CHARGER_LT3651 is not set
> > CONFIG_CHARGER_MAX14577=m
> > CONFIG_CHARGER_MAX77693=m
> > # CONFIG_CHARGER_BQ2415X is not set
> > # CONFIG_CHARGER_BQ24257 is not set
> > CONFIG_CHARGER_BQ24735=m
> > # CONFIG_CHARGER_BQ25890 is not set
> > CONFIG_CHARGER_SMB347=m
> > CONFIG_BATTERY_GAUGE_LTC2941=m
> > # CONFIG_BATTERY_GOLDFISH is not set
> > CONFIG_BATTERY_RT5033=m
> > CONFIG_CHARGER_RT9455=m
> > # CONFIG_CHARGER_CROS_USBPD is not set
> > CONFIG_HWMON=y
> > CONFIG_HWMON_VID=y
> > # CONFIG_HWMON_DEBUG_CHIP is not set
> > 
> > #
> > # Native drivers
> > #
> > CONFIG_SENSORS_ABITUGURU=y
> > # CONFIG_SENSORS_ABITUGURU3 is not set
> > # CONFIG_SENSORS_AD7314 is not set
> > CONFIG_SENSORS_AD7414=m
> > # CONFIG_SENSORS_AD7418 is not set
> > CONFIG_SENSORS_ADM1021=m
> > CONFIG_SENSORS_ADM1025=m
> > # CONFIG_SENSORS_ADM1026 is not set
> > CONFIG_SENSORS_ADM1029=m
> > CONFIG_SENSORS_ADM1031=m
> > # CONFIG_SENSORS_ADM1177 is not set
> > CONFIG_SENSORS_ADM9240=m
> > CONFIG_SENSORS_ADT7X10=m
> > CONFIG_SENSORS_ADT7310=m
> > # CONFIG_SENSORS_ADT7410 is not set
> > # CONFIG_SENSORS_ADT7411 is not set
> > # CONFIG_SENSORS_ADT7462 is not set
> > CONFIG_SENSORS_ADT7470=m
> > CONFIG_SENSORS_ADT7475=m
> > # CONFIG_SENSORS_AS370 is not set
> > CONFIG_SENSORS_ASC7621=m
> > # CONFIG_SENSORS_K8TEMP is not set
> > # CONFIG_SENSORS_K10TEMP is not set
> > # CONFIG_SENSORS_FAM15H_POWER is not set
> > # CONFIG_SENSORS_APPLESMC is not set
> > CONFIG_SENSORS_ASB100=m
> > CONFIG_SENSORS_ASPEED=m
> > # CONFIG_SENSORS_ATXP1 is not set
> > # CONFIG_SENSORS_DS620 is not set
> > CONFIG_SENSORS_DS1621=m
> > # CONFIG_SENSORS_DELL_SMM is not set
> > # CONFIG_SENSORS_I5K_AMB is not set
> > CONFIG_SENSORS_F71805F=m
> > # CONFIG_SENSORS_F71882FG is not set
> > CONFIG_SENSORS_F75375S=m
> > CONFIG_SENSORS_MC13783_ADC=m
> > CONFIG_SENSORS_FSCHMD=m
> > CONFIG_SENSORS_FTSTEUTATES=m
> > CONFIG_SENSORS_GL518SM=m
> > CONFIG_SENSORS_GL520SM=m
> > # CONFIG_SENSORS_G760A is not set
> > # CONFIG_SENSORS_G762 is not set
> > CONFIG_SENSORS_HIH6130=m
> > CONFIG_SENSORS_IBMAEM=m
> > # CONFIG_SENSORS_IBMPEX is not set
> > CONFIG_SENSORS_IIO_HWMON=m
> > # CONFIG_SENSORS_I5500 is not set
> > CONFIG_SENSORS_CORETEMP=m
> > CONFIG_SENSORS_IT87=y
> > CONFIG_SENSORS_JC42=m
> > CONFIG_SENSORS_POWR1220=m
> > CONFIG_SENSORS_LINEAGE=m
> > CONFIG_SENSORS_LTC2945=m
> > # CONFIG_SENSORS_LTC2947_I2C is not set
> > # CONFIG_SENSORS_LTC2947_SPI is not set
> > CONFIG_SENSORS_LTC2990=m
> > CONFIG_SENSORS_LTC4151=m
> > CONFIG_SENSORS_LTC4215=m
> > CONFIG_SENSORS_LTC4222=m
> > CONFIG_SENSORS_LTC4245=m
> > CONFIG_SENSORS_LTC4260=m
> > CONFIG_SENSORS_LTC4261=m
> > # CONFIG_SENSORS_MAX1111 is not set
> > CONFIG_SENSORS_MAX16065=m
> > CONFIG_SENSORS_MAX1619=m
> > CONFIG_SENSORS_MAX1668=m
> > CONFIG_SENSORS_MAX197=y
> > CONFIG_SENSORS_MAX31722=y
> > # CONFIG_SENSORS_MAX31730 is not set
> > # CONFIG_SENSORS_MAX6621 is not set
> > CONFIG_SENSORS_MAX6639=m
> > CONFIG_SENSORS_MAX6642=m
> > # CONFIG_SENSORS_MAX6650 is not set
> > CONFIG_SENSORS_MAX6697=m
> > CONFIG_SENSORS_MAX31790=m
> > CONFIG_SENSORS_MCP3021=m
> > CONFIG_SENSORS_TC654=m
> > CONFIG_SENSORS_ADCXX=m
> > CONFIG_SENSORS_LM63=m
> > # CONFIG_SENSORS_LM70 is not set
> > CONFIG_SENSORS_LM73=m
> > CONFIG_SENSORS_LM75=m
> > # CONFIG_SENSORS_LM77 is not set
> > CONFIG_SENSORS_LM78=m
> > CONFIG_SENSORS_LM80=m
> > # CONFIG_SENSORS_LM83 is not set
> > # CONFIG_SENSORS_LM85 is not set
> > # CONFIG_SENSORS_LM87 is not set
> > # CONFIG_SENSORS_LM90 is not set
> > # CONFIG_SENSORS_LM92 is not set
> > CONFIG_SENSORS_LM93=m
> > CONFIG_SENSORS_LM95234=m
> > # CONFIG_SENSORS_LM95241 is not set
> > CONFIG_SENSORS_LM95245=m
> > CONFIG_SENSORS_PC87360=m
> > # CONFIG_SENSORS_PC87427 is not set
> > # CONFIG_SENSORS_NTC_THERMISTOR is not set
> > CONFIG_SENSORS_NCT6683=y
> > CONFIG_SENSORS_NCT6775=y
> > CONFIG_SENSORS_NCT7802=m
> > CONFIG_SENSORS_NCT7904=m
> > # CONFIG_SENSORS_NPCM7XX is not set
> > CONFIG_SENSORS_PCF8591=m
> > CONFIG_PMBUS=m
> > CONFIG_SENSORS_PMBUS=m
> > CONFIG_SENSORS_ADM1275=m
> > # CONFIG_SENSORS_BEL_PFE is not set
> > CONFIG_SENSORS_IBM_CFFPS=m
> > # CONFIG_SENSORS_INSPUR_IPSPS is not set
> > CONFIG_SENSORS_IR35221=m
> > # CONFIG_SENSORS_IR38064 is not set
> > # CONFIG_SENSORS_IRPS5401 is not set
> > # CONFIG_SENSORS_ISL68137 is not set
> > # CONFIG_SENSORS_LM25066 is not set
> > CONFIG_SENSORS_LTC2978=m
> > CONFIG_SENSORS_LTC2978_REGULATOR=y
> > CONFIG_SENSORS_LTC3815=m
> > CONFIG_SENSORS_MAX16064=m
> > # CONFIG_SENSORS_MAX20730 is not set
> > CONFIG_SENSORS_MAX20751=m
> > # CONFIG_SENSORS_MAX31785 is not set
> > # CONFIG_SENSORS_MAX34440 is not set
> > # CONFIG_SENSORS_MAX8688 is not set
> > # CONFIG_SENSORS_PXE1610 is not set
> > CONFIG_SENSORS_TPS40422=m
> > # CONFIG_SENSORS_TPS53679 is not set
> > CONFIG_SENSORS_UCD9000=m
> > CONFIG_SENSORS_UCD9200=m
> > # CONFIG_SENSORS_XDPE122 is not set
> > # CONFIG_SENSORS_ZL6100 is not set
> > CONFIG_SENSORS_SHT15=y
> > # CONFIG_SENSORS_SHT21 is not set
> > # CONFIG_SENSORS_SHT3x is not set
> > # CONFIG_SENSORS_SHTC1 is not set
> > # CONFIG_SENSORS_SIS5595 is not set
> > CONFIG_SENSORS_DME1737=m
> > CONFIG_SENSORS_EMC1403=m
> > # CONFIG_SENSORS_EMC2103 is not set
> > CONFIG_SENSORS_EMC6W201=m
> > CONFIG_SENSORS_SMSC47M1=y
> > CONFIG_SENSORS_SMSC47M192=m
> > # CONFIG_SENSORS_SMSC47B397 is not set
> > CONFIG_SENSORS_SCH56XX_COMMON=y
> > CONFIG_SENSORS_SCH5627=m
> > CONFIG_SENSORS_SCH5636=y
> > CONFIG_SENSORS_STTS751=m
> > CONFIG_SENSORS_SMM665=m
> > CONFIG_SENSORS_ADC128D818=m
> > CONFIG_SENSORS_ADS7828=m
> > CONFIG_SENSORS_ADS7871=y
> > CONFIG_SENSORS_AMC6821=m
> > # CONFIG_SENSORS_INA209 is not set
> > # CONFIG_SENSORS_INA2XX is not set
> > CONFIG_SENSORS_INA3221=m
> > CONFIG_SENSORS_TC74=m
> > # CONFIG_SENSORS_THMC50 is not set
> > # CONFIG_SENSORS_TMP102 is not set
> > # CONFIG_SENSORS_TMP103 is not set
> > # CONFIG_SENSORS_TMP108 is not set
> > CONFIG_SENSORS_TMP401=m
> > # CONFIG_SENSORS_TMP421 is not set
> > # CONFIG_SENSORS_TMP513 is not set
> > # CONFIG_SENSORS_VIA_CPUTEMP is not set
> > # CONFIG_SENSORS_VIA686A is not set
> > CONFIG_SENSORS_VT1211=m
> > # CONFIG_SENSORS_VT8231 is not set
> > # CONFIG_SENSORS_W83773G is not set
> > CONFIG_SENSORS_W83781D=m
> > CONFIG_SENSORS_W83791D=m
> > CONFIG_SENSORS_W83792D=m
> > CONFIG_SENSORS_W83793=m
> > CONFIG_SENSORS_W83795=m
> > # CONFIG_SENSORS_W83795_FANCTRL is not set
> > CONFIG_SENSORS_W83L785TS=m
> > # CONFIG_SENSORS_W83L786NG is not set
> > CONFIG_SENSORS_W83627HF=m
> > CONFIG_SENSORS_W83627EHF=y
> > # CONFIG_SENSORS_WM831X is not set
> > 
> > #
> > # ACPI drivers
> > #
> > # CONFIG_SENSORS_ACPI_POWER is not set
> > # CONFIG_SENSORS_ATK0110 is not set
> > CONFIG_THERMAL=y
> > # CONFIG_THERMAL_STATISTICS is not set
> > CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> > CONFIG_THERMAL_HWMON=y
> > CONFIG_THERMAL_WRITABLE_TRIPS=y
> > CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> > # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> > # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> > # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
> > CONFIG_THERMAL_GOV_STEP_WISE=y
> > # CONFIG_THERMAL_GOV_BANG_BANG is not set
> > CONFIG_THERMAL_GOV_USER_SPACE=y
> > # CONFIG_THERMAL_EMULATION is not set
> > 
> > #
> > # Intel thermal drivers
> > #
> > CONFIG_INTEL_POWERCLAMP=y
> > # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> > 
> > #
> > # ACPI INT340X thermal drivers
> > #
> > # CONFIG_INT340X_THERMAL is not set
> > # end of ACPI INT340X thermal drivers
> > 
> > # CONFIG_INTEL_PCH_THERMAL is not set
> > # end of Intel thermal drivers
> > 
> > CONFIG_GENERIC_ADC_THERMAL=m
> > CONFIG_WATCHDOG=y
> > CONFIG_WATCHDOG_CORE=y
> > CONFIG_WATCHDOG_NOWAYOUT=y
> > # CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
> > CONFIG_WATCHDOG_OPEN_TIMEOUT=0
> > # CONFIG_WATCHDOG_SYSFS is not set
> > 
> > #
> > # Watchdog Pretimeout Governors
> > #
> > # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
> > 
> > #
> > # Watchdog Device Drivers
> > #
> > CONFIG_SOFT_WATCHDOG=y
> > CONFIG_DA9063_WATCHDOG=m
> > # CONFIG_MENZ069_WATCHDOG is not set
> > # CONFIG_WDAT_WDT is not set
> > CONFIG_WM831X_WATCHDOG=y
> > # CONFIG_XILINX_WATCHDOG is not set
> > CONFIG_ZIIRAVE_WATCHDOG=m
> > CONFIG_CADENCE_WATCHDOG=m
> > # CONFIG_DW_WATCHDOG is not set
> > CONFIG_MAX63XX_WATCHDOG=m
> > CONFIG_RETU_WATCHDOG=m
> > # CONFIG_ACQUIRE_WDT is not set
> > CONFIG_ADVANTECH_WDT=y
> > # CONFIG_ALIM1535_WDT is not set
> > # CONFIG_ALIM7101_WDT is not set
> > CONFIG_EBC_C384_WDT=m
> > # CONFIG_F71808E_WDT is not set
> > # CONFIG_SP5100_TCO is not set
> > # CONFIG_SBC_FITPC2_WATCHDOG is not set
> > # CONFIG_EUROTECH_WDT is not set
> > CONFIG_IB700_WDT=m
> > # CONFIG_IBMASR is not set
> > CONFIG_WAFER_WDT=y
> > # CONFIG_I6300ESB_WDT is not set
> > # CONFIG_IE6XX_WDT is not set
> > # CONFIG_ITCO_WDT is not set
> > CONFIG_IT8712F_WDT=y
> > CONFIG_IT87_WDT=y
> > # CONFIG_HP_WATCHDOG is not set
> > CONFIG_KEMPLD_WDT=y
> > # CONFIG_SC1200_WDT is not set
> > # CONFIG_PC87413_WDT is not set
> > # CONFIG_NV_TCO is not set
> > # CONFIG_60XX_WDT is not set
> > CONFIG_CPU5_WDT=y
> > CONFIG_SMSC_SCH311X_WDT=y
> > CONFIG_SMSC37B787_WDT=y
> > # CONFIG_TQMX86_WDT is not set
> > # CONFIG_VIA_WDT is not set
> > # CONFIG_W83627HF_WDT is not set
> > CONFIG_W83877F_WDT=y
> > # CONFIG_W83977F_WDT is not set
> > CONFIG_MACHZ_WDT=y
> > # CONFIG_SBC_EPX_C3_WATCHDOG is not set
> > # CONFIG_NI903X_WDT is not set
> > # CONFIG_NIC7018_WDT is not set
> > # CONFIG_MEN_A21_WDT is not set
> > 
> > #
> > # PCI-based Watchdog Cards
> > #
> > # CONFIG_PCIPCWATCHDOG is not set
> > # CONFIG_WDTPCI is not set
> > CONFIG_SSB_POSSIBLE=y
> > CONFIG_SSB=m
> > CONFIG_SSB_SPROM=y
> > CONFIG_SSB_PCIHOST_POSSIBLE=y
> > CONFIG_SSB_PCIHOST=y
> > CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
> > CONFIG_SSB_PCMCIAHOST=y
> > CONFIG_SSB_SDIOHOST_POSSIBLE=y
> > # CONFIG_SSB_SDIOHOST is not set
> > CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
> > # CONFIG_SSB_DRIVER_PCICORE is not set
> > CONFIG_SSB_DRIVER_GPIO=y
> > CONFIG_BCMA_POSSIBLE=y
> > # CONFIG_BCMA is not set
> > 
> > #
> > # Multifunction device drivers
> > #
> > CONFIG_MFD_CORE=y
> > CONFIG_MFD_BCM590XX=m
> > CONFIG_MFD_BD9571MWV=m
> > # CONFIG_MFD_AXP20X_I2C is not set
> > CONFIG_MFD_CROS_EC_DEV=y
> > # CONFIG_MFD_MADERA is not set
> > # CONFIG_MFD_DA9052_SPI is not set
> > # CONFIG_MFD_DA9062 is not set
> > CONFIG_MFD_DA9063=m
> > CONFIG_MFD_DA9150=m
> > CONFIG_MFD_MC13XXX=m
> > # CONFIG_MFD_MC13XXX_SPI is not set
> > CONFIG_MFD_MC13XXX_I2C=m
> > CONFIG_HTC_PASIC3=m
> > # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> > # CONFIG_LPC_ICH is not set
> > # CONFIG_LPC_SCH is not set
> > # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> > # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> > # CONFIG_MFD_INTEL_LPSS_PCI is not set
> > # CONFIG_MFD_JANZ_CMODIO is not set
> > CONFIG_MFD_KEMPLD=y
> > CONFIG_MFD_88PM800=m
> > CONFIG_MFD_88PM805=m
> > CONFIG_MFD_MAX14577=m
> > CONFIG_MFD_MAX77693=m
> > CONFIG_MFD_MAX8907=m
> > # CONFIG_MFD_MT6397 is not set
> > # CONFIG_MFD_MENF21BMC is not set
> > CONFIG_EZX_PCAP=y
> > CONFIG_MFD_RETU=m
> > # CONFIG_MFD_PCF50633 is not set
> > CONFIG_UCB1400_CORE=m
> > # CONFIG_MFD_RDC321X is not set
> > CONFIG_MFD_RT5033=m
> > # CONFIG_MFD_SI476X_CORE is not set
> > # CONFIG_MFD_SM501 is not set
> > CONFIG_MFD_SKY81452=m
> > CONFIG_ABX500_CORE=y
> > CONFIG_MFD_SYSCON=y
> > CONFIG_MFD_TI_AM335X_TSCADC=y
> > # CONFIG_MFD_LP3943 is not set
> > CONFIG_MFD_TI_LMU=m
> > CONFIG_TPS6105X=m
> > # CONFIG_TPS65010 is not set
> > CONFIG_TPS6507X=m
> > CONFIG_MFD_TPS65086=m
> > CONFIG_MFD_TI_LP873X=m
> > CONFIG_MFD_TPS65912=m
> > CONFIG_MFD_TPS65912_I2C=m
> > CONFIG_MFD_TPS65912_SPI=m
> > CONFIG_MFD_WL1273_CORE=m
> > CONFIG_MFD_LM3533=m
> > # CONFIG_MFD_TQMX86 is not set
> > # CONFIG_MFD_VX855 is not set
> > # CONFIG_MFD_ARIZONA_I2C is not set
> > # CONFIG_MFD_ARIZONA_SPI is not set
> > CONFIG_MFD_WM831X=y
> > CONFIG_MFD_WM831X_SPI=y
> > # CONFIG_MFD_WM8994 is not set
> > # end of Multifunction device drivers
> > 
> > CONFIG_REGULATOR=y
> > # CONFIG_REGULATOR_DEBUG is not set
> > CONFIG_REGULATOR_FIXED_VOLTAGE=y
> > # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
> > # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> > # CONFIG_REGULATOR_88PG86X is not set
> > # CONFIG_REGULATOR_88PM800 is not set
> > # CONFIG_REGULATOR_ACT8865 is not set
> > CONFIG_REGULATOR_AD5398=m
> > CONFIG_REGULATOR_ANATOP=y
> > CONFIG_REGULATOR_BCM590XX=m
> > # CONFIG_REGULATOR_BD9571MWV is not set
> > CONFIG_REGULATOR_DA9210=m
> > CONFIG_REGULATOR_DA9211=m
> > CONFIG_REGULATOR_FAN53555=m
> > # CONFIG_REGULATOR_GPIO is not set
> > CONFIG_REGULATOR_ISL9305=m
> > CONFIG_REGULATOR_ISL6271A=m
> > CONFIG_REGULATOR_LM363X=m
> > CONFIG_REGULATOR_LP3971=m
> > CONFIG_REGULATOR_LP3972=m
> > # CONFIG_REGULATOR_LP872X is not set
> > # CONFIG_REGULATOR_LP8755 is not set
> > # CONFIG_REGULATOR_LTC3589 is not set
> > # CONFIG_REGULATOR_LTC3676 is not set
> > CONFIG_REGULATOR_MAX14577=m
> > CONFIG_REGULATOR_MAX1586=m
> > CONFIG_REGULATOR_MAX8649=m
> > CONFIG_REGULATOR_MAX8660=m
> > # CONFIG_REGULATOR_MAX8907 is not set
> > CONFIG_REGULATOR_MAX8952=m
> > CONFIG_REGULATOR_MAX77693=m
> > CONFIG_REGULATOR_MC13XXX_CORE=m
> > # CONFIG_REGULATOR_MC13783 is not set
> > CONFIG_REGULATOR_MC13892=m
> > # CONFIG_REGULATOR_MP8859 is not set
> > # CONFIG_REGULATOR_MT6311 is not set
> > CONFIG_REGULATOR_PCAP=y
> > # CONFIG_REGULATOR_PFUZE100 is not set
> > # CONFIG_REGULATOR_PV88060 is not set
> > # CONFIG_REGULATOR_PV88080 is not set
> > CONFIG_REGULATOR_PV88090=m
> > # CONFIG_REGULATOR_QCOM_SPMI is not set
> > CONFIG_REGULATOR_RT5033=m
> > CONFIG_REGULATOR_SKY81452=m
> > # CONFIG_REGULATOR_SLG51000 is not set
> > CONFIG_REGULATOR_TPS51632=m
> > CONFIG_REGULATOR_TPS6105X=m
> > CONFIG_REGULATOR_TPS62360=m
> > CONFIG_REGULATOR_TPS65023=m
> > CONFIG_REGULATOR_TPS6507X=m
> > CONFIG_REGULATOR_TPS65086=m
> > CONFIG_REGULATOR_TPS65132=m
> > CONFIG_REGULATOR_TPS6524X=m
> > CONFIG_REGULATOR_TPS65912=m
> > CONFIG_REGULATOR_WM831X=y
> > CONFIG_RC_CORE=m
> > CONFIG_RC_MAP=m
> > CONFIG_LIRC=y
> > CONFIG_RC_DECODERS=y
> > CONFIG_IR_NEC_DECODER=m
> > CONFIG_IR_RC5_DECODER=m
> > CONFIG_IR_RC6_DECODER=m
> > CONFIG_IR_JVC_DECODER=m
> > CONFIG_IR_SONY_DECODER=m
> > CONFIG_IR_SANYO_DECODER=m
> > CONFIG_IR_SHARP_DECODER=m
> > CONFIG_IR_MCE_KBD_DECODER=m
> > CONFIG_IR_XMP_DECODER=m
> > CONFIG_IR_IMON_DECODER=m
> > # CONFIG_IR_RCMM_DECODER is not set
> > CONFIG_RC_DEVICES=y
> > # CONFIG_RC_ATI_REMOTE is not set
> > # CONFIG_IR_ENE is not set
> > # CONFIG_IR_IMON is not set
> > # CONFIG_IR_IMON_RAW is not set
> > # CONFIG_IR_MCEUSB is not set
> > # CONFIG_IR_ITE_CIR is not set
> > # CONFIG_IR_FINTEK is not set
> > # CONFIG_IR_NUVOTON is not set
> > # CONFIG_IR_REDRAT3 is not set
> > # CONFIG_IR_STREAMZAP is not set
> > # CONFIG_IR_WINBOND_CIR is not set
> > # CONFIG_IR_IGORPLUGUSB is not set
> > # CONFIG_IR_IGUANA is not set
> > # CONFIG_IR_TTUSBIR is not set
> > CONFIG_RC_LOOPBACK=m
> > # CONFIG_IR_SERIAL is not set
> > # CONFIG_IR_SIR is not set
> > # CONFIG_RC_XBOX_DVD is not set
> > CONFIG_MEDIA_SUPPORT=m
> > 
> > #
> > # Multimedia core support
> > #
> > # CONFIG_MEDIA_CAMERA_SUPPORT is not set
> > CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
> > CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> > CONFIG_MEDIA_RADIO_SUPPORT=y
> > CONFIG_MEDIA_SDR_SUPPORT=y
> > CONFIG_MEDIA_CEC_SUPPORT=y
> > # CONFIG_MEDIA_CONTROLLER is not set
> > CONFIG_VIDEO_DEV=m
> > CONFIG_VIDEO_V4L2=m
> > CONFIG_VIDEO_V4L2_I2C=y
> > # CONFIG_VIDEO_ADV_DEBUG is not set
> > CONFIG_VIDEO_FIXED_MINOR_RANGES=y
> > CONFIG_V4L2_FWNODE=m
> > CONFIG_DVB_CORE=m
> > # CONFIG_DVB_MMAP is not set
> > # CONFIG_DVB_NET is not set
> > CONFIG_DVB_MAX_ADAPTERS=16
> > # CONFIG_DVB_DYNAMIC_MINORS is not set
> > # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
> > # CONFIG_DVB_ULE_DEBUG is not set
> > 
> > #
> > # Media drivers
> > #
> > # CONFIG_MEDIA_PCI_SUPPORT is not set
> > # CONFIG_DVB_PLATFORM_DRIVERS is not set
> > CONFIG_CEC_PLATFORM_DRIVERS=y
> > # CONFIG_VIDEO_CROS_EC_CEC is not set
> > # CONFIG_VIDEO_SECO_CEC is not set
> > CONFIG_SDR_PLATFORM_DRIVERS=y
> > 
> > #
> > # Supported MMC/SDIO adapters
> > #
> > CONFIG_SMS_SDIO_DRV=m
> > # CONFIG_RADIO_ADAPTERS is not set
> > 
> > #
> > # Supported FireWire (IEEE 1394) Adapters
> > #
> > # CONFIG_DVB_FIREDTV is not set
> > CONFIG_MEDIA_COMMON_OPTIONS=y
> > 
> > #
> > # common driver options
> > #
> > CONFIG_SMS_SIANO_MDTV=m
> > CONFIG_SMS_SIANO_RC=y
> > 
> > #
> > # Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
> > #
> > # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> > CONFIG_MEDIA_ATTACH=y
> > CONFIG_VIDEO_IR_I2C=m
> > 
> > #
> > # I2C Encoders, decoders, sensors and other helper chips
> > #
> > 
> > #
> > # Audio decoders, processors and mixers
> > #
> > CONFIG_VIDEO_TVAUDIO=m
> > # CONFIG_VIDEO_TDA7432 is not set
> > # CONFIG_VIDEO_TDA9840 is not set
> > CONFIG_VIDEO_TEA6415C=m
> > CONFIG_VIDEO_TEA6420=m
> > CONFIG_VIDEO_MSP3400=m
> > CONFIG_VIDEO_CS3308=m
> > CONFIG_VIDEO_CS5345=m
> > CONFIG_VIDEO_CS53L32A=m
> > # CONFIG_VIDEO_TLV320AIC23B is not set
> > # CONFIG_VIDEO_UDA1342 is not set
> > CONFIG_VIDEO_WM8775=m
> > CONFIG_VIDEO_WM8739=m
> > # CONFIG_VIDEO_VP27SMPX is not set
> > CONFIG_VIDEO_SONY_BTF_MPX=m
> > 
> > #
> > # RDS decoders
> > #
> > # CONFIG_VIDEO_SAA6588 is not set
> > 
> > #
> > # Video decoders
> > #
> > # CONFIG_VIDEO_ADV7183 is not set
> > # CONFIG_VIDEO_BT819 is not set
> > CONFIG_VIDEO_BT856=m
> > CONFIG_VIDEO_BT866=m
> > CONFIG_VIDEO_KS0127=m
> > CONFIG_VIDEO_ML86V7667=m
> > CONFIG_VIDEO_SAA7110=m
> > CONFIG_VIDEO_SAA711X=m
> > # CONFIG_VIDEO_TVP514X is not set
> > CONFIG_VIDEO_TVP5150=m
> > # CONFIG_VIDEO_TVP7002 is not set
> > CONFIG_VIDEO_TW2804=m
> > CONFIG_VIDEO_TW9903=m
> > CONFIG_VIDEO_TW9906=m
> > # CONFIG_VIDEO_TW9910 is not set
> > # CONFIG_VIDEO_VPX3220 is not set
> > 
> > #
> > # Video and audio decoders
> > #
> > CONFIG_VIDEO_SAA717X=m
> > # CONFIG_VIDEO_CX25840 is not set
> > 
> > #
> > # Video encoders
> > #
> > # CONFIG_VIDEO_SAA7127 is not set
> > # CONFIG_VIDEO_SAA7185 is not set
> > # CONFIG_VIDEO_ADV7170 is not set
> > CONFIG_VIDEO_ADV7175=m
> > # CONFIG_VIDEO_ADV7343 is not set
> > CONFIG_VIDEO_ADV7393=m
> > CONFIG_VIDEO_AK881X=m
> > CONFIG_VIDEO_THS8200=m
> > 
> > #
> > # Camera sensor devices
> > #
> > 
> > #
> > # Lens drivers
> > #
> > 
> > #
> > # Flash devices
> > #
> > 
> > #
> > # Video improvement chips
> > #
> > # CONFIG_VIDEO_UPD64031A is not set
> > CONFIG_VIDEO_UPD64083=m
> > 
> > #
> > # Audio/Video compression chips
> > #
> > # CONFIG_VIDEO_SAA6752HS is not set
> > 
> > #
> > # SDR tuner chips
> > #
> > CONFIG_SDR_MAX2175=m
> > 
> > #
> > # Miscellaneous helper chips
> > #
> > # CONFIG_VIDEO_THS7303 is not set
> > CONFIG_VIDEO_M52790=m
> > # CONFIG_VIDEO_I2C is not set
> > # end of I2C Encoders, decoders, sensors and other helper chips
> > 
> > #
> > # SPI helper chips
> > #
> > # end of SPI helper chips
> > 
> > #
> > # Media SPI Adapters
> > #
> > CONFIG_CXD2880_SPI_DRV=m
> > # end of Media SPI Adapters
> > 
> > CONFIG_MEDIA_TUNER=m
> > 
> > #
> > # Customize TV tuners
> > #
> > CONFIG_MEDIA_TUNER_SIMPLE=m
> > CONFIG_MEDIA_TUNER_TDA18250=m
> > CONFIG_MEDIA_TUNER_TDA8290=m
> > CONFIG_MEDIA_TUNER_TDA827X=m
> > CONFIG_MEDIA_TUNER_TDA18271=m
> > CONFIG_MEDIA_TUNER_TDA9887=m
> > CONFIG_MEDIA_TUNER_TEA5761=m
> > # CONFIG_MEDIA_TUNER_TEA5767 is not set
> > CONFIG_MEDIA_TUNER_MSI001=m
> > CONFIG_MEDIA_TUNER_MT20XX=m
> > CONFIG_MEDIA_TUNER_MT2060=m
> > CONFIG_MEDIA_TUNER_MT2063=m
> > CONFIG_MEDIA_TUNER_MT2266=m
> > CONFIG_MEDIA_TUNER_MT2131=m
> > # CONFIG_MEDIA_TUNER_QT1010 is not set
> > CONFIG_MEDIA_TUNER_XC2028=m
> > # CONFIG_MEDIA_TUNER_XC5000 is not set
> > CONFIG_MEDIA_TUNER_XC4000=m
> > # CONFIG_MEDIA_TUNER_MXL5005S is not set
> > CONFIG_MEDIA_TUNER_MXL5007T=m
> > CONFIG_MEDIA_TUNER_MC44S803=m
> > CONFIG_MEDIA_TUNER_MAX2165=m
> > CONFIG_MEDIA_TUNER_TDA18218=m
> > CONFIG_MEDIA_TUNER_FC0011=m
> > CONFIG_MEDIA_TUNER_FC0012=m
> > CONFIG_MEDIA_TUNER_FC0013=m
> > CONFIG_MEDIA_TUNER_TDA18212=m
> > # CONFIG_MEDIA_TUNER_E4000 is not set
> > CONFIG_MEDIA_TUNER_FC2580=m
> > # CONFIG_MEDIA_TUNER_M88RS6000T is not set
> > # CONFIG_MEDIA_TUNER_TUA9001 is not set
> > # CONFIG_MEDIA_TUNER_SI2157 is not set
> > # CONFIG_MEDIA_TUNER_IT913X is not set
> > CONFIG_MEDIA_TUNER_R820T=m
> > CONFIG_MEDIA_TUNER_MXL301RF=m
> > # CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
> > CONFIG_MEDIA_TUNER_QM1D1B0004=m
> > # end of Customize TV tuners
> > 
> > #
> > # Customise DVB Frontends
> > #
> > 
> > #
> > # Multistandard (satellite) frontends
> > #
> > CONFIG_DVB_STB0899=m
> > CONFIG_DVB_STB6100=m
> > CONFIG_DVB_STV090x=m
> > CONFIG_DVB_STV0910=m
> > CONFIG_DVB_STV6110x=m
> > # CONFIG_DVB_STV6111 is not set
> > CONFIG_DVB_MXL5XX=m
> > CONFIG_DVB_M88DS3103=m
> > 
> > #
> > # Multistandard (cable + terrestrial) frontends
> > #
> > # CONFIG_DVB_DRXK is not set
> > CONFIG_DVB_TDA18271C2DD=m
> > CONFIG_DVB_SI2165=m
> > # CONFIG_DVB_MN88472 is not set
> > # CONFIG_DVB_MN88473 is not set
> > 
> > #
> > # DVB-S (satellite) frontends
> > #
> > CONFIG_DVB_CX24110=m
> > CONFIG_DVB_CX24123=m
> > CONFIG_DVB_MT312=m
> > CONFIG_DVB_ZL10036=m
> > # CONFIG_DVB_ZL10039 is not set
> > CONFIG_DVB_S5H1420=m
> > # CONFIG_DVB_STV0288 is not set
> > CONFIG_DVB_STB6000=m
> > # CONFIG_DVB_STV0299 is not set
> > CONFIG_DVB_STV6110=m
> > CONFIG_DVB_STV0900=m
> > # CONFIG_DVB_TDA8083 is not set
> > CONFIG_DVB_TDA10086=m
> > CONFIG_DVB_TDA8261=m
> > CONFIG_DVB_VES1X93=m
> > CONFIG_DVB_TUNER_ITD1000=m
> > # CONFIG_DVB_TUNER_CX24113 is not set
> > # CONFIG_DVB_TDA826X is not set
> > CONFIG_DVB_TUA6100=m
> > # CONFIG_DVB_CX24116 is not set
> > CONFIG_DVB_CX24117=m
> > CONFIG_DVB_CX24120=m
> > # CONFIG_DVB_SI21XX is not set
> > CONFIG_DVB_TS2020=m
> > CONFIG_DVB_DS3000=m
> > CONFIG_DVB_MB86A16=m
> > CONFIG_DVB_TDA10071=m
> > 
> > #
> > # DVB-T (terrestrial) frontends
> > #
> > # CONFIG_DVB_SP8870 is not set
> > CONFIG_DVB_SP887X=m
> > CONFIG_DVB_CX22700=m
> > # CONFIG_DVB_CX22702 is not set
> > CONFIG_DVB_S5H1432=m
> > CONFIG_DVB_DRXD=m
> > # CONFIG_DVB_L64781 is not set
> > CONFIG_DVB_TDA1004X=m
> > # CONFIG_DVB_NXT6000 is not set
> > CONFIG_DVB_MT352=m
> > CONFIG_DVB_ZL10353=m
> > CONFIG_DVB_DIB3000MB=m
> > # CONFIG_DVB_DIB3000MC is not set
> > CONFIG_DVB_DIB7000M=m
> > CONFIG_DVB_DIB7000P=m
> > # CONFIG_DVB_DIB9000 is not set
> > CONFIG_DVB_TDA10048=m
> > # CONFIG_DVB_AF9013 is not set
> > CONFIG_DVB_EC100=m
> > CONFIG_DVB_STV0367=m
> > # CONFIG_DVB_CXD2820R is not set
> > # CONFIG_DVB_CXD2841ER is not set
> > # CONFIG_DVB_RTL2830 is not set
> > CONFIG_DVB_RTL2832=m
> > # CONFIG_DVB_SI2168 is not set
> > # CONFIG_DVB_ZD1301_DEMOD is not set
> > CONFIG_DVB_CXD2880=m
> > 
> > #
> > # DVB-C (cable) frontends
> > #
> > # CONFIG_DVB_VES1820 is not set
> > # CONFIG_DVB_TDA10021 is not set
> > # CONFIG_DVB_TDA10023 is not set
> > # CONFIG_DVB_STV0297 is not set
> > 
> > #
> > # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> > #
> > # CONFIG_DVB_NXT200X is not set
> > CONFIG_DVB_OR51211=m
> > CONFIG_DVB_OR51132=m
> > CONFIG_DVB_BCM3510=m
> > CONFIG_DVB_LGDT330X=m
> > CONFIG_DVB_LGDT3305=m
> > CONFIG_DVB_LGDT3306A=m
> > # CONFIG_DVB_LG2160 is not set
> > # CONFIG_DVB_S5H1409 is not set
> > CONFIG_DVB_AU8522=m
> > CONFIG_DVB_AU8522_DTV=m
> > CONFIG_DVB_AU8522_V4L=m
> > CONFIG_DVB_S5H1411=m
> > 
> > #
> > # ISDB-T (terrestrial) frontends
> > #
> > CONFIG_DVB_S921=m
> > CONFIG_DVB_DIB8000=m
> > # CONFIG_DVB_MB86A20S is not set
> > 
> > #
> > # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> > #
> > CONFIG_DVB_TC90522=m
> > CONFIG_DVB_MN88443X=m
> > 
> > #
> > # Digital terrestrial only tuners/PLL
> > #
> > # CONFIG_DVB_PLL is not set
> > CONFIG_DVB_TUNER_DIB0070=m
> > CONFIG_DVB_TUNER_DIB0090=m
> > 
> > #
> > # SEC control devices for DVB-S
> > #
> > CONFIG_DVB_DRX39XYJ=m
> > CONFIG_DVB_LNBH25=m
> > CONFIG_DVB_LNBH29=m
> > CONFIG_DVB_LNBP21=m
> > CONFIG_DVB_LNBP22=m
> > # CONFIG_DVB_ISL6405 is not set
> > CONFIG_DVB_ISL6421=m
> > # CONFIG_DVB_ISL6423 is not set
> > # CONFIG_DVB_A8293 is not set
> > CONFIG_DVB_LGS8GL5=m
> > CONFIG_DVB_LGS8GXX=m
> > CONFIG_DVB_ATBM8830=m
> > # CONFIG_DVB_TDA665x is not set
> > # CONFIG_DVB_IX2505V is not set
> > CONFIG_DVB_M88RS2000=m
> > CONFIG_DVB_AF9033=m
> > CONFIG_DVB_HORUS3A=m
> > CONFIG_DVB_ASCOT2E=m
> > CONFIG_DVB_HELENE=m
> > 
> > #
> > # Common Interface (EN50221) controller drivers
> > #
> > # CONFIG_DVB_CXD2099 is not set
> > CONFIG_DVB_SP2=m
> > 
> > #
> > # Tools to develop new frontends
> > #
> > # CONFIG_DVB_DUMMY_FE is not set
> > # end of Customise DVB Frontends
> > 
> > #
> > # Graphics support
> > #
> > # CONFIG_AGP is not set
> > CONFIG_VGA_ARB=y
> > CONFIG_VGA_ARB_MAX_GPUS=16
> > # CONFIG_VGA_SWITCHEROO is not set
> > CONFIG_DRM=m
> > CONFIG_DRM_MIPI_DBI=m
> > # CONFIG_DRM_DP_AUX_CHARDEV is not set
> > CONFIG_DRM_EXPORT_FOR_TESTS=y
> > CONFIG_DRM_DEBUG_SELFTEST=m
> > CONFIG_DRM_KMS_HELPER=m
> > CONFIG_DRM_KMS_FB_HELPER=y
> > # CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
> > CONFIG_DRM_FBDEV_EMULATION=y
> > CONFIG_DRM_FBDEV_OVERALLOC=100
> > # CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
> > # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
> > # CONFIG_DRM_DP_CEC is not set
> > CONFIG_DRM_GEM_CMA_HELPER=y
> > CONFIG_DRM_KMS_CMA_HELPER=y
> > CONFIG_DRM_GEM_SHMEM_HELPER=y
> > 
> > #
> > # I2C encoder or helper chips
> > #
> > CONFIG_DRM_I2C_CH7006=m
> > CONFIG_DRM_I2C_SIL164=m
> > CONFIG_DRM_I2C_NXP_TDA998X=m
> > # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> > # end of I2C encoder or helper chips
> > 
> > #
> > # ARM devices
> > #
> > # end of ARM devices
> > 
> > # CONFIG_DRM_RADEON is not set
> > # CONFIG_DRM_AMDGPU is not set
> > 
> > #
> > # ACP (Audio CoProcessor) Configuration
> > #
> > # end of ACP (Audio CoProcessor) Configuration
> > 
> > # CONFIG_DRM_NOUVEAU is not set
> > # CONFIG_DRM_I915 is not set
> > CONFIG_DRM_VGEM=m
> > # CONFIG_DRM_VKMS is not set
> > # CONFIG_DRM_VMWGFX is not set
> > # CONFIG_DRM_GMA500 is not set
> > # CONFIG_DRM_AST is not set
> > # CONFIG_DRM_MGAG200 is not set
> > # CONFIG_DRM_CIRRUS_QEMU is not set
> > # CONFIG_DRM_QXL is not set
> > # CONFIG_DRM_BOCHS is not set
> > CONFIG_DRM_VIRTIO_GPU=m
> > CONFIG_DRM_PANEL=y
> > 
> > #
> > # Display Panels
> > #
> > # end of Display Panels
> > 
> > CONFIG_DRM_BRIDGE=y
> > CONFIG_DRM_PANEL_BRIDGE=y
> > 
> > #
> > # Display Interface Bridges
> > #
> > # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> > # end of Display Interface Bridges
> > 
> > # CONFIG_DRM_ETNAVIV is not set
> > # CONFIG_TINYDRM_HX8357D is not set
> > # CONFIG_TINYDRM_ILI9225 is not set
> > # CONFIG_TINYDRM_ILI9341 is not set
> > CONFIG_TINYDRM_MI0283QT=m
> > CONFIG_TINYDRM_REPAPER=m
> > CONFIG_TINYDRM_ST7586=m
> > # CONFIG_TINYDRM_ST7735R is not set
> > # CONFIG_DRM_VBOXVIDEO is not set
> > # CONFIG_DRM_LEGACY is not set
> > CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
> > CONFIG_DRM_LIB_RANDOM=y
> > 
> > #
> > # Frame buffer Devices
> > #
> > CONFIG_FB_CMDLINE=y
> > CONFIG_FB_NOTIFY=y
> > CONFIG_FB=m
> > # CONFIG_FIRMWARE_EDID is not set
> > CONFIG_FB_CFB_FILLRECT=m
> > CONFIG_FB_CFB_COPYAREA=m
> > CONFIG_FB_CFB_IMAGEBLIT=m
> > CONFIG_FB_SYS_FILLRECT=m
> > CONFIG_FB_SYS_COPYAREA=m
> > CONFIG_FB_SYS_IMAGEBLIT=m
> > # CONFIG_FB_FOREIGN_ENDIAN is not set
> > CONFIG_FB_SYS_FOPS=m
> > CONFIG_FB_DEFERRED_IO=y
> > CONFIG_FB_HECUBA=m
> > CONFIG_FB_BACKLIGHT=m
> > # CONFIG_FB_MODE_HELPERS is not set
> > # CONFIG_FB_TILEBLITTING is not set
> > 
> > #
> > # Frame buffer hardware drivers
> > #
> > # CONFIG_FB_CIRRUS is not set
> > # CONFIG_FB_PM2 is not set
> > # CONFIG_FB_CYBER2000 is not set
> > CONFIG_FB_ARC=m
> > # CONFIG_FB_VGA16 is not set
> > CONFIG_FB_N411=m
> > CONFIG_FB_HGA=m
> > CONFIG_FB_OPENCORES=m
> > CONFIG_FB_S1D13XXX=m
> > # CONFIG_FB_NVIDIA is not set
> > # CONFIG_FB_RIVA is not set
> > # CONFIG_FB_I740 is not set
> > # CONFIG_FB_LE80578 is not set
> > # CONFIG_FB_MATROX is not set
> > # CONFIG_FB_RADEON is not set
> > # CONFIG_FB_ATY128 is not set
> > # CONFIG_FB_ATY is not set
> > # CONFIG_FB_S3 is not set
> > # CONFIG_FB_SAVAGE is not set
> > # CONFIG_FB_SIS is not set
> > # CONFIG_FB_VIA is not set
> > # CONFIG_FB_NEOMAGIC is not set
> > # CONFIG_FB_KYRO is not set
> > # CONFIG_FB_3DFX is not set
> > # CONFIG_FB_VOODOO1 is not set
> > # CONFIG_FB_VT8623 is not set
> > # CONFIG_FB_TRIDENT is not set
> > # CONFIG_FB_ARK is not set
> > # CONFIG_FB_PM3 is not set
> > # CONFIG_FB_CARMINE is not set
> > CONFIG_FB_IBM_GXT4500=m
> > CONFIG_FB_GOLDFISH=m
> > CONFIG_FB_VIRTUAL=m
> > CONFIG_FB_METRONOME=m
> > # CONFIG_FB_MB862XX is not set
> > # CONFIG_FB_SM712 is not set
> > # end of Frame buffer Devices
> > 
> > #
> > # Backlight & LCD device support
> > #
> > # CONFIG_LCD_CLASS_DEVICE is not set
> > CONFIG_BACKLIGHT_CLASS_DEVICE=m
> > CONFIG_BACKLIGHT_GENERIC=m
> > # CONFIG_BACKLIGHT_LM3533 is not set
> > # CONFIG_BACKLIGHT_APPLE is not set
> > # CONFIG_BACKLIGHT_QCOM_WLED is not set
> > CONFIG_BACKLIGHT_SAHARA=m
> > CONFIG_BACKLIGHT_WM831X=m
> > # CONFIG_BACKLIGHT_ADP8860 is not set
> > CONFIG_BACKLIGHT_ADP8870=m
> > CONFIG_BACKLIGHT_LM3639=m
> > CONFIG_BACKLIGHT_SKY81452=m
> > CONFIG_BACKLIGHT_GPIO=m
> > CONFIG_BACKLIGHT_LV5207LP=m
> > CONFIG_BACKLIGHT_BD6107=m
> > CONFIG_BACKLIGHT_ARCXCNN=m
> > # end of Backlight & LCD device support
> > 
> > CONFIG_HDMI=y
> > CONFIG_LOGO=y
> > # CONFIG_LOGO_LINUX_MONO is not set
> > CONFIG_LOGO_LINUX_VGA16=y
> > CONFIG_LOGO_LINUX_CLUT224=y
> > # end of Graphics support
> > 
> > CONFIG_SOUND=y
> > CONFIG_SOUND_OSS_CORE=y
> > CONFIG_SOUND_OSS_CORE_PRECLAIM=y
> > CONFIG_SND=y
> > CONFIG_SND_TIMER=y
> > CONFIG_SND_PCM=m
> > CONFIG_SND_PCM_ELD=y
> > CONFIG_SND_PCM_IEC958=y
> > CONFIG_SND_DMAENGINE_PCM=m
> > CONFIG_SND_HWDEP=m
> > CONFIG_SND_SEQ_DEVICE=y
> > CONFIG_SND_COMPRESS_OFFLOAD=m
> > CONFIG_SND_JACK=y
> > CONFIG_SND_JACK_INPUT_DEV=y
> > CONFIG_SND_OSSEMUL=y
> > CONFIG_SND_MIXER_OSS=m
> > CONFIG_SND_PCM_OSS=m
> > # CONFIG_SND_PCM_OSS_PLUGINS is not set
> > CONFIG_SND_PCM_TIMER=y
> > # CONFIG_SND_HRTIMER is not set
> > # CONFIG_SND_DYNAMIC_MINORS is not set
> > # CONFIG_SND_SUPPORT_OLD_API is not set
> > CONFIG_SND_PROC_FS=y
> > CONFIG_SND_VERBOSE_PROCFS=y
> > # CONFIG_SND_VERBOSE_PRINTK is not set
> > CONFIG_SND_DEBUG=y
> > # CONFIG_SND_DEBUG_VERBOSE is not set
> > # CONFIG_SND_PCM_XRUN_DEBUG is not set
> > # CONFIG_SND_CTL_VALIDATION is not set
> > CONFIG_SND_VMASTER=y
> > CONFIG_SND_DMA_SGBUF=y
> > CONFIG_SND_SEQUENCER=y
> > CONFIG_SND_SEQ_DUMMY=y
> > CONFIG_SND_SEQUENCER_OSS=m
> > CONFIG_SND_SEQ_MIDI_EVENT=m
> > CONFIG_SND_VX_LIB=m
> > CONFIG_SND_AC97_CODEC=m
> > # CONFIG_SND_DRIVERS is not set
> > CONFIG_SND_PCI=y
> > # CONFIG_SND_AD1889 is not set
> > # CONFIG_SND_ASIHPI is not set
> > # CONFIG_SND_ATIIXP is not set
> > # CONFIG_SND_ATIIXP_MODEM is not set
> > # CONFIG_SND_AU8810 is not set
> > # CONFIG_SND_AU8820 is not set
> > # CONFIG_SND_AU8830 is not set
> > # CONFIG_SND_AW2 is not set
> > # CONFIG_SND_BT87X is not set
> > # CONFIG_SND_CA0106 is not set
> > # CONFIG_SND_CMIPCI is not set
> > # CONFIG_SND_OXYGEN is not set
> > # CONFIG_SND_CS4281 is not set
> > # CONFIG_SND_CS46XX is not set
> > # CONFIG_SND_CTXFI is not set
> > # CONFIG_SND_DARLA20 is not set
> > # CONFIG_SND_GINA20 is not set
> > # CONFIG_SND_LAYLA20 is not set
> > # CONFIG_SND_DARLA24 is not set
> > # CONFIG_SND_GINA24 is not set
> > # CONFIG_SND_LAYLA24 is not set
> > # CONFIG_SND_MONA is not set
> > # CONFIG_SND_MIA is not set
> > # CONFIG_SND_ECHO3G is not set
> > # CONFIG_SND_INDIGO is not set
> > # CONFIG_SND_INDIGOIO is not set
> > # CONFIG_SND_INDIGODJ is not set
> > # CONFIG_SND_INDIGOIOX is not set
> > # CONFIG_SND_INDIGODJX is not set
> > # CONFIG_SND_ENS1370 is not set
> > # CONFIG_SND_ENS1371 is not set
> > # CONFIG_SND_FM801 is not set
> > # CONFIG_SND_HDSP is not set
> > # CONFIG_SND_HDSPM is not set
> > # CONFIG_SND_ICE1724 is not set
> > # CONFIG_SND_INTEL8X0 is not set
> > # CONFIG_SND_INTEL8X0M is not set
> > # CONFIG_SND_KORG1212 is not set
> > # CONFIG_SND_LOLA is not set
> > # CONFIG_SND_LX6464ES is not set
> > # CONFIG_SND_MIXART is not set
> > # CONFIG_SND_NM256 is not set
> > # CONFIG_SND_PCXHR is not set
> > # CONFIG_SND_RIPTIDE is not set
> > # CONFIG_SND_RME32 is not set
> > # CONFIG_SND_RME96 is not set
> > # CONFIG_SND_RME9652 is not set
> > # CONFIG_SND_SE6X is not set
> > # CONFIG_SND_VIA82XX is not set
> > # CONFIG_SND_VIA82XX_MODEM is not set
> > # CONFIG_SND_VIRTUOSO is not set
> > # CONFIG_SND_VX222 is not set
> > # CONFIG_SND_YMFPCI is not set
> > 
> > #
> > # HD-Audio
> > #
> > # CONFIG_SND_HDA_INTEL is not set
> > # end of HD-Audio
> > 
> > CONFIG_SND_HDA_PREALLOC_SIZE=0
> > CONFIG_SND_SPI=y
> > # CONFIG_SND_FIREWIRE is not set
> > CONFIG_SND_PCMCIA=y
> > CONFIG_SND_VXPOCKET=m
> > CONFIG_SND_PDAUDIOCF=m
> > CONFIG_SND_SOC=m
> > CONFIG_SND_SOC_AC97_BUS=y
> > CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
> > CONFIG_SND_SOC_COMPRESS=y
> > CONFIG_SND_SOC_ACPI=m
> > CONFIG_SND_SOC_AMD_ACP=m
> > # CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH is not set
> > # CONFIG_SND_SOC_AMD_CZ_RT5645_MACH is not set
> > # CONFIG_SND_SOC_AMD_ACP3x is not set
> > # CONFIG_SND_ATMEL_SOC is not set
> > # CONFIG_SND_DESIGNWARE_I2S is not set
> > 
> > #
> > # SoC Audio for Freescale CPUs
> > #
> > 
> > #
> > # Common SoC Audio options for Freescale CPUs:
> > #
> > # CONFIG_SND_SOC_FSL_ASRC is not set
> > # CONFIG_SND_SOC_FSL_SAI is not set
> > # CONFIG_SND_SOC_FSL_AUDMIX is not set
> > CONFIG_SND_SOC_FSL_SSI=m
> > # CONFIG_SND_SOC_FSL_SPDIF is not set
> > CONFIG_SND_SOC_FSL_ESAI=m
> > # CONFIG_SND_SOC_FSL_MICFIL is not set
> > # CONFIG_SND_SOC_IMX_AUDMUX is not set
> > # end of SoC Audio for Freescale CPUs
> > 
> > CONFIG_SND_I2S_HI6210_I2S=m
> > # CONFIG_SND_SOC_IMG is not set
> > CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
> > CONFIG_SND_SST_IPC=m
> > CONFIG_SND_SST_IPC_ACPI=m
> > CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
> > # CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
> > CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
> > # CONFIG_SND_SOC_INTEL_SKYLAKE is not set
> > # CONFIG_SND_SOC_INTEL_SKL is not set
> > # CONFIG_SND_SOC_INTEL_APL is not set
> > # CONFIG_SND_SOC_INTEL_KBL is not set
> > # CONFIG_SND_SOC_INTEL_GLK is not set
> > # CONFIG_SND_SOC_INTEL_CNL is not set
> > # CONFIG_SND_SOC_INTEL_CFL is not set
> > # CONFIG_SND_SOC_INTEL_CML_H is not set
> > # CONFIG_SND_SOC_INTEL_CML_LP is not set
> > CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
> > CONFIG_SND_SOC_INTEL_MACH=y
> > # CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
> > # CONFIG_SND_SOC_MTK_BTCVSD is not set
> > # CONFIG_SND_SOC_SOF_TOPLEVEL is not set
> > 
> > #
> > # STMicroelectronics STM32 SOC audio support
> > #
> > # end of STMicroelectronics STM32 SOC audio support
> > 
> > # CONFIG_SND_SOC_XILINX_I2S is not set
> > # CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
> > # CONFIG_SND_SOC_XILINX_SPDIF is not set
> > CONFIG_SND_SOC_XTFPGA_I2S=m
> > # CONFIG_ZX_TDM is not set
> > CONFIG_SND_SOC_I2C_AND_SPI=m
> > 
> > #
> > # CODEC drivers
> > #
> > CONFIG_SND_SOC_AC97_CODEC=m
> > CONFIG_SND_SOC_ADAU_UTILS=m
> > # CONFIG_SND_SOC_ADAU1701 is not set
> > CONFIG_SND_SOC_ADAU17X1=m
> > CONFIG_SND_SOC_ADAU1761=m
> > CONFIG_SND_SOC_ADAU1761_I2C=m
> > CONFIG_SND_SOC_ADAU1761_SPI=m
> > CONFIG_SND_SOC_ADAU7002=m
> > # CONFIG_SND_SOC_ADAU7118_HW is not set
> > # CONFIG_SND_SOC_ADAU7118_I2C is not set
> > CONFIG_SND_SOC_AK4104=m
> > # CONFIG_SND_SOC_AK4118 is not set
> > # CONFIG_SND_SOC_AK4458 is not set
> > CONFIG_SND_SOC_AK4554=m
> > CONFIG_SND_SOC_AK4613=m
> > CONFIG_SND_SOC_AK4642=m
> > CONFIG_SND_SOC_AK5386=m
> > # CONFIG_SND_SOC_AK5558 is not set
> > CONFIG_SND_SOC_ALC5623=m
> > # CONFIG_SND_SOC_BD28623 is not set
> > CONFIG_SND_SOC_BT_SCO=m
> > # CONFIG_SND_SOC_CROS_EC_CODEC is not set
> > # CONFIG_SND_SOC_CS35L32 is not set
> > CONFIG_SND_SOC_CS35L33=m
> > # CONFIG_SND_SOC_CS35L34 is not set
> > CONFIG_SND_SOC_CS35L35=m
> > # CONFIG_SND_SOC_CS35L36 is not set
> > CONFIG_SND_SOC_CS42L42=m
> > CONFIG_SND_SOC_CS42L51=m
> > CONFIG_SND_SOC_CS42L51_I2C=m
> > # CONFIG_SND_SOC_CS42L52 is not set
> > # CONFIG_SND_SOC_CS42L56 is not set
> > # CONFIG_SND_SOC_CS42L73 is not set
> > CONFIG_SND_SOC_CS4265=m
> > CONFIG_SND_SOC_CS4270=m
> > CONFIG_SND_SOC_CS4271=m
> > CONFIG_SND_SOC_CS4271_I2C=m
> > CONFIG_SND_SOC_CS4271_SPI=m
> > CONFIG_SND_SOC_CS42XX8=m
> > CONFIG_SND_SOC_CS42XX8_I2C=m
> > # CONFIG_SND_SOC_CS43130 is not set
> > # CONFIG_SND_SOC_CS4341 is not set
> > CONFIG_SND_SOC_CS4349=m
> > # CONFIG_SND_SOC_CS53L30 is not set
> > # CONFIG_SND_SOC_CX2072X is not set
> > # CONFIG_SND_SOC_DA7213 is not set
> > # CONFIG_SND_SOC_DMIC is not set
> > CONFIG_SND_SOC_HDMI_CODEC=m
> > CONFIG_SND_SOC_ES7134=m
> > # CONFIG_SND_SOC_ES7241 is not set
> > # CONFIG_SND_SOC_ES8316 is not set
> > CONFIG_SND_SOC_ES8328=m
> > CONFIG_SND_SOC_ES8328_I2C=m
> > CONFIG_SND_SOC_ES8328_SPI=m
> > # CONFIG_SND_SOC_GTM601 is not set
> > CONFIG_SND_SOC_INNO_RK3036=m
> > # CONFIG_SND_SOC_MAX98088 is not set
> > # CONFIG_SND_SOC_MAX98357A is not set
> > # CONFIG_SND_SOC_MAX98504 is not set
> > # CONFIG_SND_SOC_MAX9867 is not set
> > CONFIG_SND_SOC_MAX98927=m
> > # CONFIG_SND_SOC_MAX98373 is not set
> > CONFIG_SND_SOC_MAX9860=m
> > CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
> > CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
> > CONFIG_SND_SOC_PCM1681=m
> > # CONFIG_SND_SOC_PCM1789_I2C is not set
> > CONFIG_SND_SOC_PCM179X=m
> > CONFIG_SND_SOC_PCM179X_I2C=m
> > CONFIG_SND_SOC_PCM179X_SPI=m
> > # CONFIG_SND_SOC_PCM186X_I2C is not set
> > # CONFIG_SND_SOC_PCM186X_SPI is not set
> > # CONFIG_SND_SOC_PCM3060_I2C is not set
> > # CONFIG_SND_SOC_PCM3060_SPI is not set
> > CONFIG_SND_SOC_PCM3168A=m
> > CONFIG_SND_SOC_PCM3168A_I2C=m
> > CONFIG_SND_SOC_PCM3168A_SPI=m
> > CONFIG_SND_SOC_PCM512x=m
> > # CONFIG_SND_SOC_PCM512x_I2C is not set
> > CONFIG_SND_SOC_PCM512x_SPI=m
> > # CONFIG_SND_SOC_RK3328 is not set
> > CONFIG_SND_SOC_RL6231=m
> > CONFIG_SND_SOC_RT5616=m
> > CONFIG_SND_SOC_RT5631=m
> > CONFIG_SND_SOC_SGTL5000=m
> > CONFIG_SND_SOC_SIGMADSP=m
> > CONFIG_SND_SOC_SIGMADSP_REGMAP=m
> > # CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
> > CONFIG_SND_SOC_SIRF_AUDIO_CODEC=m
> > CONFIG_SND_SOC_SPDIF=m
> > # CONFIG_SND_SOC_SSM2305 is not set
> > CONFIG_SND_SOC_SSM2602=m
> > CONFIG_SND_SOC_SSM2602_SPI=m
> > # CONFIG_SND_SOC_SSM2602_I2C is not set
> > CONFIG_SND_SOC_SSM4567=m
> > CONFIG_SND_SOC_STA32X=m
> > CONFIG_SND_SOC_STA350=m
> > CONFIG_SND_SOC_STI_SAS=m
> > CONFIG_SND_SOC_TAS2552=m
> > # CONFIG_SND_SOC_TAS2562 is not set
> > # CONFIG_SND_SOC_TAS2770 is not set
> > CONFIG_SND_SOC_TAS5086=m
> > CONFIG_SND_SOC_TAS571X=m
> > # CONFIG_SND_SOC_TAS5720 is not set
> > # CONFIG_SND_SOC_TAS6424 is not set
> > # CONFIG_SND_SOC_TDA7419 is not set
> > CONFIG_SND_SOC_TFA9879=m
> > CONFIG_SND_SOC_TLV320AIC23=m
> > CONFIG_SND_SOC_TLV320AIC23_I2C=m
> > # CONFIG_SND_SOC_TLV320AIC23_SPI is not set
> > CONFIG_SND_SOC_TLV320AIC31XX=m
> > # CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
> > # CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
> > CONFIG_SND_SOC_TLV320AIC3X=m
> > # CONFIG_SND_SOC_TS3A227E is not set
> > # CONFIG_SND_SOC_TSCS42XX is not set
> > # CONFIG_SND_SOC_TSCS454 is not set
> > # CONFIG_SND_SOC_UDA1334 is not set
> > CONFIG_SND_SOC_WM8510=m
> > CONFIG_SND_SOC_WM8523=m
> > CONFIG_SND_SOC_WM8524=m
> > CONFIG_SND_SOC_WM8580=m
> > # CONFIG_SND_SOC_WM8711 is not set
> > # CONFIG_SND_SOC_WM8728 is not set
> > CONFIG_SND_SOC_WM8731=m
> > CONFIG_SND_SOC_WM8737=m
> > CONFIG_SND_SOC_WM8741=m
> > # CONFIG_SND_SOC_WM8750 is not set
> > # CONFIG_SND_SOC_WM8753 is not set
> > CONFIG_SND_SOC_WM8770=m
> > CONFIG_SND_SOC_WM8776=m
> > # CONFIG_SND_SOC_WM8782 is not set
> > CONFIG_SND_SOC_WM8804=m
> > CONFIG_SND_SOC_WM8804_I2C=m
> > # CONFIG_SND_SOC_WM8804_SPI is not set
> > CONFIG_SND_SOC_WM8903=m
> > # CONFIG_SND_SOC_WM8904 is not set
> > CONFIG_SND_SOC_WM8960=m
> > # CONFIG_SND_SOC_WM8962 is not set
> > CONFIG_SND_SOC_WM8974=m
> > CONFIG_SND_SOC_WM8978=m
> > CONFIG_SND_SOC_WM8985=m
> > CONFIG_SND_SOC_ZX_AUD96P22=m
> > # CONFIG_SND_SOC_MAX9759 is not set
> > # CONFIG_SND_SOC_MT6351 is not set
> > # CONFIG_SND_SOC_MT6358 is not set
> > # CONFIG_SND_SOC_MT6660 is not set
> > CONFIG_SND_SOC_NAU8540=m
> > CONFIG_SND_SOC_NAU8810=m
> > # CONFIG_SND_SOC_NAU8822 is not set
> > CONFIG_SND_SOC_NAU8824=m
> > CONFIG_SND_SOC_TPA6130A2=m
> > # end of CODEC drivers
> > 
> > CONFIG_SND_SIMPLE_CARD_UTILS=m
> > CONFIG_SND_SIMPLE_CARD=m
> > CONFIG_SND_X86=y
> > CONFIG_AC97_BUS=m
> > 
> > #
> > # HID support
> > #
> > CONFIG_HID=y
> > # CONFIG_HID_BATTERY_STRENGTH is not set
> > # CONFIG_HIDRAW is not set
> > # CONFIG_UHID is not set
> > CONFIG_HID_GENERIC=y
> > 
> > #
> > # Special HID drivers
> > #
> > # CONFIG_HID_A4TECH is not set
> > # CONFIG_HID_ACRUX is not set
> > # CONFIG_HID_APPLE is not set
> > # CONFIG_HID_ASUS is not set
> > # CONFIG_HID_AUREAL is not set
> > # CONFIG_HID_BELKIN is not set
> > # CONFIG_HID_CHERRY is not set
> > # CONFIG_HID_CHICONY is not set
> > # CONFIG_HID_COUGAR is not set
> > # CONFIG_HID_MACALLY is not set
> > # CONFIG_HID_PRODIKEYS is not set
> > # CONFIG_HID_CMEDIA is not set
> > # CONFIG_HID_CYPRESS is not set
> > # CONFIG_HID_DRAGONRISE is not set
> > # CONFIG_HID_EMS_FF is not set
> > # CONFIG_HID_ELECOM is not set
> > # CONFIG_HID_EZKEY is not set
> > # CONFIG_HID_GEMBIRD is not set
> > # CONFIG_HID_GFRM is not set
> > # CONFIG_HID_KEYTOUCH is not set
> > # CONFIG_HID_KYE is not set
> > # CONFIG_HID_WALTOP is not set
> > # CONFIG_HID_VIEWSONIC is not set
> > # CONFIG_HID_GYRATION is not set
> > # CONFIG_HID_ICADE is not set
> > # CONFIG_HID_ITE is not set
> > # CONFIG_HID_JABRA is not set
> > # CONFIG_HID_TWINHAN is not set
> > # CONFIG_HID_KENSINGTON is not set
> > # CONFIG_HID_LCPOWER is not set
> > # CONFIG_HID_LED is not set
> > # CONFIG_HID_LENOVO is not set
> > # CONFIG_HID_LOGITECH is not set
> > # CONFIG_HID_MAGICMOUSE is not set
> > # CONFIG_HID_MALTRON is not set
> > # CONFIG_HID_MAYFLASH is not set
> > # CONFIG_HID_REDRAGON is not set
> > # CONFIG_HID_MICROSOFT is not set
> > # CONFIG_HID_MONTEREY is not set
> > # CONFIG_HID_MULTITOUCH is not set
> > # CONFIG_HID_NTI is not set
> > # CONFIG_HID_ORTEK is not set
> > # CONFIG_HID_PANTHERLORD is not set
> > # CONFIG_HID_PETALYNX is not set
> > # CONFIG_HID_PICOLCD is not set
> > # CONFIG_HID_PLANTRONICS is not set
> > # CONFIG_HID_PRIMAX is not set
> > # CONFIG_HID_SAITEK is not set
> > # CONFIG_HID_SAMSUNG is not set
> > # CONFIG_HID_SPEEDLINK is not set
> > # CONFIG_HID_STEAM is not set
> > # CONFIG_HID_STEELSERIES is not set
> > # CONFIG_HID_SUNPLUS is not set
> > # CONFIG_HID_RMI is not set
> > # CONFIG_HID_GREENASIA is not set
> > # CONFIG_HID_SMARTJOYPLUS is not set
> > # CONFIG_HID_TIVO is not set
> > # CONFIG_HID_TOPSEED is not set
> > # CONFIG_HID_THINGM is not set
> > # CONFIG_HID_THRUSTMASTER is not set
> > # CONFIG_HID_UDRAW_PS3 is not set
> > # CONFIG_HID_WIIMOTE is not set
> > # CONFIG_HID_XINMO is not set
> > # CONFIG_HID_ZEROPLUS is not set
> > # CONFIG_HID_ZYDACRON is not set
> > # CONFIG_HID_SENSOR_HUB is not set
> > # CONFIG_HID_ALPS is not set
> > # end of Special HID drivers
> > 
> > #
> > # I2C HID support
> > #
> > # CONFIG_I2C_HID is not set
> > # end of I2C HID support
> > 
> > #
> > # Intel ISH HID support
> > #
> > # CONFIG_INTEL_ISH_HID is not set
> > # end of Intel ISH HID support
> > # end of HID support
> > 
> > CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> > CONFIG_USB_SUPPORT=y
> > # CONFIG_USB_LED_TRIG is not set
> > # CONFIG_USB_ULPI_BUS is not set
> > # CONFIG_USB_CONN_GPIO is not set
> > CONFIG_USB_ARCH_HAS_HCD=y
> > # CONFIG_USB is not set
> > CONFIG_USB_PCI=y
> > 
> > #
> > # USB port drivers
> > #
> > 
> > #
> > # USB Physical Layer drivers
> > #
> > # CONFIG_NOP_USB_XCEIV is not set
> > # CONFIG_USB_GPIO_VBUS is not set
> > # CONFIG_TAHVO_USB is not set
> > # end of USB Physical Layer drivers
> > 
> > # CONFIG_USB_GADGET is not set
> > # CONFIG_TYPEC is not set
> > # CONFIG_USB_ROLE_SWITCH is not set
> > CONFIG_MMC=m
> > CONFIG_MMC_BLOCK=m
> > CONFIG_MMC_BLOCK_MINORS=8
> > # CONFIG_SDIO_UART is not set
> > CONFIG_MMC_TEST=m
> > 
> > #
> > # MMC/SD/SDIO Host Controller Drivers
> > #
> > CONFIG_MMC_DEBUG=y
> > # CONFIG_MMC_SDHCI is not set
> > # CONFIG_MMC_TIFM_SD is not set
> > CONFIG_MMC_GOLDFISH=m
> > CONFIG_MMC_SPI=m
> > # CONFIG_MMC_SDRICOH_CS is not set
> > # CONFIG_MMC_CB710 is not set
> > # CONFIG_MMC_VIA_SDMMC is not set
> > # CONFIG_MMC_USDHI6ROL0 is not set
> > # CONFIG_MMC_CQHCI is not set
> > # CONFIG_MMC_TOSHIBA_PCI is not set
> > # CONFIG_MMC_MTK is not set
> > # CONFIG_MEMSTICK is not set
> > CONFIG_NEW_LEDS=y
> > CONFIG_LEDS_CLASS=m
> > CONFIG_LEDS_CLASS_FLASH=m
> > CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
> > 
> > #
> > # LED drivers
> > #
> > # CONFIG_LEDS_APU is not set
> > CONFIG_LEDS_AS3645A=m
> > CONFIG_LEDS_LM3530=m
> > # CONFIG_LEDS_LM3532 is not set
> > # CONFIG_LEDS_LM3533 is not set
> > CONFIG_LEDS_LM3642=m
> > # CONFIG_LEDS_LM3601X is not set
> > # CONFIG_LEDS_PCA9532 is not set
> > # CONFIG_LEDS_GPIO is not set
> > CONFIG_LEDS_LP3944=m
> > CONFIG_LEDS_LP3952=m
> > CONFIG_LEDS_LP55XX_COMMON=m
> > # CONFIG_LEDS_LP5521 is not set
> > CONFIG_LEDS_LP5523=m
> > CONFIG_LEDS_LP5562=m
> > CONFIG_LEDS_LP8501=m
> > # CONFIG_LEDS_CLEVO_MAIL is not set
> > CONFIG_LEDS_PCA955X=m
> > # CONFIG_LEDS_PCA955X_GPIO is not set
> > CONFIG_LEDS_PCA963X=m
> > CONFIG_LEDS_WM831X_STATUS=m
> > CONFIG_LEDS_DAC124S085=m
> > CONFIG_LEDS_REGULATOR=m
> > # CONFIG_LEDS_BD2802 is not set
> > # CONFIG_LEDS_INTEL_SS4200 is not set
> > # CONFIG_LEDS_MC13783 is not set
> > # CONFIG_LEDS_TCA6507 is not set
> > CONFIG_LEDS_TLC591XX=m
> > CONFIG_LEDS_LM355x=m
> > 
> > #
> > # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> > #
> > CONFIG_LEDS_BLINKM=m
> > # CONFIG_LEDS_MLXCPLD is not set
> > # CONFIG_LEDS_MLXREG is not set
> > CONFIG_LEDS_USER=m
> > # CONFIG_LEDS_NIC78BX is not set
> > # CONFIG_LEDS_TI_LMU_COMMON is not set
> > CONFIG_LEDS_TPS6105X=m
> > 
> > #
> > # LED Triggers
> > #
> > CONFIG_LEDS_TRIGGERS=y
> > # CONFIG_LEDS_TRIGGER_TIMER is not set
> > CONFIG_LEDS_TRIGGER_ONESHOT=y
> > CONFIG_LEDS_TRIGGER_MTD=y
> > CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> > CONFIG_LEDS_TRIGGER_BACKLIGHT=y
> > # CONFIG_LEDS_TRIGGER_CPU is not set
> > # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> > CONFIG_LEDS_TRIGGER_GPIO=y
> > # CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
> > 
> > #
> > # iptables trigger is under Netfilter config (LED target)
> > #
> > # CONFIG_LEDS_TRIGGER_TRANSIENT is not set
> > CONFIG_LEDS_TRIGGER_CAMERA=y
> > # CONFIG_LEDS_TRIGGER_PANIC is not set
> > # CONFIG_LEDS_TRIGGER_NETDEV is not set
> > # CONFIG_LEDS_TRIGGER_PATTERN is not set
> > # CONFIG_LEDS_TRIGGER_AUDIO is not set
> > # CONFIG_ACCESSIBILITY is not set
> > # CONFIG_INFINIBAND is not set
> > CONFIG_EDAC_ATOMIC_SCRUB=y
> > CONFIG_EDAC_SUPPORT=y
> > CONFIG_EDAC=y
> > # CONFIG_EDAC_LEGACY_SYSFS is not set
> > # CONFIG_EDAC_DEBUG is not set
> > # CONFIG_EDAC_E752X is not set
> > # CONFIG_EDAC_I82975X is not set
> > # CONFIG_EDAC_I3000 is not set
> > # CONFIG_EDAC_I3200 is not set
> > # CONFIG_EDAC_IE31200 is not set
> > # CONFIG_EDAC_X38 is not set
> > # CONFIG_EDAC_I5400 is not set
> > # CONFIG_EDAC_I5000 is not set
> > # CONFIG_EDAC_I5100 is not set
> > # CONFIG_EDAC_I7300 is not set
> > CONFIG_RTC_LIB=y
> > CONFIG_RTC_MC146818_LIB=y
> > # CONFIG_RTC_CLASS is not set
> > # CONFIG_DMADEVICES is not set
> > 
> > #
> > # DMABUF options
> > #
> > CONFIG_SYNC_FILE=y
> > CONFIG_SW_SYNC=y
> > # CONFIG_UDMABUF is not set
> > # CONFIG_DMABUF_SELFTESTS is not set
> > # CONFIG_DMABUF_HEAPS is not set
> > # end of DMABUF options
> > 
> > CONFIG_AUXDISPLAY=y
> > # CONFIG_HD44780 is not set
> > # CONFIG_KS0108 is not set
> > # CONFIG_IMG_ASCII_LCD is not set
> > CONFIG_PARPORT_PANEL=m
> > CONFIG_PANEL_PARPORT=0
> > CONFIG_PANEL_PROFILE=5
> > # CONFIG_PANEL_CHANGE_MESSAGE is not set
> > # CONFIG_CHARLCD_BL_OFF is not set
> > # CONFIG_CHARLCD_BL_ON is not set
> > CONFIG_CHARLCD_BL_FLASH=y
> > CONFIG_PANEL=m
> > CONFIG_CHARLCD=m
> > CONFIG_UIO=m
> > # CONFIG_UIO_CIF is not set
> > CONFIG_UIO_PDRV_GENIRQ=m
> > # CONFIG_UIO_DMEM_GENIRQ is not set
> > # CONFIG_UIO_AEC is not set
> > # CONFIG_UIO_SERCOS3 is not set
> > # CONFIG_UIO_PCI_GENERIC is not set
> > # CONFIG_UIO_NETX is not set
> > CONFIG_UIO_PRUSS=m
> > # CONFIG_UIO_MF624 is not set
> > # CONFIG_VIRT_DRIVERS is not set
> > CONFIG_VIRTIO=y
> > CONFIG_VIRTIO_MENU=y
> > # CONFIG_VIRTIO_PCI is not set
> > CONFIG_VIRTIO_BALLOON=m
> > # CONFIG_VIRTIO_INPUT is not set
> > CONFIG_VIRTIO_MMIO=y
> > # CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
> > 
> > #
> > # Microsoft Hyper-V guest support
> > #
> > # CONFIG_HYPERV is not set
> > # end of Microsoft Hyper-V guest support
> > 
> > CONFIG_GREYBUS=m
> > CONFIG_STAGING=y
> > # CONFIG_COMEDI is not set
> > 
> > #
> > # IIO staging drivers
> > #
> > 
> > #
> > # Accelerometers
> > #
> > # CONFIG_ADIS16203 is not set
> > CONFIG_ADIS16240=m
> > # end of Accelerometers
> > 
> > #
> > # Analog to digital converters
> > #
> > CONFIG_AD7816=m
> > CONFIG_AD7192=m
> > # CONFIG_AD7280 is not set
> > # end of Analog to digital converters
> > 
> > #
> > # Analog digital bi-direction converters
> > #
> > CONFIG_ADT7316=m
> > # CONFIG_ADT7316_SPI is not set
> > CONFIG_ADT7316_I2C=m
> > # end of Analog digital bi-direction converters
> > 
> > #
> > # Capacitance to digital converters
> > #
> > # CONFIG_AD7150 is not set
> > CONFIG_AD7746=m
> > # end of Capacitance to digital converters
> > 
> > #
> > # Direct Digital Synthesis
> > #
> > CONFIG_AD9832=m
> > CONFIG_AD9834=m
> > # end of Direct Digital Synthesis
> > 
> > #
> > # Network Analyzer, Impedance Converters
> > #
> > # CONFIG_AD5933 is not set
> > # end of Network Analyzer, Impedance Converters
> > 
> > #
> > # Active energy metering IC
> > #
> > CONFIG_ADE7854=m
> > CONFIG_ADE7854_I2C=m
> > CONFIG_ADE7854_SPI=m
> > # end of Active energy metering IC
> > 
> > #
> > # Resolver to digital converters
> > #
> > CONFIG_AD2S1210=m
> > # end of Resolver to digital converters
> > # end of IIO staging drivers
> > 
> > # CONFIG_FB_SM750 is not set
> > 
> > #
> > # Speakup console speech
> > #
> > # end of Speakup console speech
> > 
> > CONFIG_STAGING_MEDIA=y
> > 
> > #
> > # soc_camera sensor drivers
> > #
> > 
> > #
> > # Android
> > #
> > # CONFIG_ASHMEM is not set
> > CONFIG_ION=y
> > CONFIG_ION_SYSTEM_HEAP=y
> > # end of Android
> > 
> > # CONFIG_FIREWIRE_SERIAL is not set
> > # CONFIG_GOLDFISH_AUDIO is not set
> > # CONFIG_GS_FPGABOOT is not set
> > # CONFIG_UNISYSSPAR is not set
> > CONFIG_FB_TFT=m
> > CONFIG_FB_TFT_AGM1264K_FL=m
> > # CONFIG_FB_TFT_BD663474 is not set
> > CONFIG_FB_TFT_HX8340BN=m
> > CONFIG_FB_TFT_HX8347D=m
> > # CONFIG_FB_TFT_HX8353D is not set
> > # CONFIG_FB_TFT_HX8357D is not set
> > # CONFIG_FB_TFT_ILI9163 is not set
> > CONFIG_FB_TFT_ILI9320=m
> > CONFIG_FB_TFT_ILI9325=m
> > CONFIG_FB_TFT_ILI9340=m
> > # CONFIG_FB_TFT_ILI9341 is not set
> > # CONFIG_FB_TFT_ILI9481 is not set
> > CONFIG_FB_TFT_ILI9486=m
> > CONFIG_FB_TFT_PCD8544=m
> > CONFIG_FB_TFT_RA8875=m
> > CONFIG_FB_TFT_S6D02A1=m
> > CONFIG_FB_TFT_S6D1121=m
> > # CONFIG_FB_TFT_SEPS525 is not set
> > # CONFIG_FB_TFT_SH1106 is not set
> > CONFIG_FB_TFT_SSD1289=m
> > CONFIG_FB_TFT_SSD1305=m
> > CONFIG_FB_TFT_SSD1306=m
> > # CONFIG_FB_TFT_SSD1331 is not set
> > # CONFIG_FB_TFT_SSD1351 is not set
> > CONFIG_FB_TFT_ST7735R=m
> > # CONFIG_FB_TFT_ST7789V is not set
> > CONFIG_FB_TFT_TINYLCD=m
> > CONFIG_FB_TFT_TLS8204=m
> > # CONFIG_FB_TFT_UC1611 is not set
> > # CONFIG_FB_TFT_UC1701 is not set
> > # CONFIG_FB_TFT_UPD161704 is not set
> > # CONFIG_FB_TFT_WATTEROTT is not set
> > CONFIG_MOST=m
> > # CONFIG_MOST_CDEV is not set
> > # CONFIG_MOST_NET is not set
> > # CONFIG_MOST_SOUND is not set
> > # CONFIG_MOST_VIDEO is not set
> > # CONFIG_MOST_I2C is not set
> > CONFIG_GREYBUS_AUDIO=m
> > # CONFIG_GREYBUS_BOOTROM is not set
> > CONFIG_GREYBUS_FIRMWARE=m
> > # CONFIG_GREYBUS_HID is not set
> > CONFIG_GREYBUS_LIGHT=m
> > # CONFIG_GREYBUS_LOG is not set
> > CONFIG_GREYBUS_LOOPBACK=m
> > CONFIG_GREYBUS_POWER=m
> > # CONFIG_GREYBUS_RAW is not set
> > # CONFIG_GREYBUS_VIBRATOR is not set
> > CONFIG_GREYBUS_BRIDGED_PHY=m
> > CONFIG_GREYBUS_GPIO=m
> > CONFIG_GREYBUS_I2C=m
> > # CONFIG_GREYBUS_SDIO is not set
> > CONFIG_GREYBUS_SPI=m
> > # CONFIG_GREYBUS_UART is not set
> > CONFIG_PI433=m
> > 
> > #
> > # Gasket devices
> > #
> > # CONFIG_STAGING_GASKET_FRAMEWORK is not set
> > # end of Gasket devices
> > 
> > # CONFIG_FIELDBUS_DEV is not set
> > # CONFIG_KPC2000 is not set
> > CONFIG_UWB=y
> > # CONFIG_UWB_WHCI is not set
> > # CONFIG_STAGING_EXFAT_FS is not set
> > # CONFIG_QLGE is not set
> > CONFIG_NET_VENDOR_HP=y
> > # CONFIG_HP100 is not set
> > # CONFIG_X86_PLATFORM_DEVICES is not set
> > CONFIG_PMC_ATOM=y
> > # CONFIG_GOLDFISH_PIPE is not set
> > CONFIG_MFD_CROS_EC=y
> > CONFIG_CHROME_PLATFORMS=y
> > CONFIG_CHROMEOS_LAPTOP=m
> > # CONFIG_CHROMEOS_PSTORE is not set
> > # CONFIG_CHROMEOS_TBMC is not set
> > CONFIG_CROS_EC=y
> > # CONFIG_CROS_EC_I2C is not set
> > # CONFIG_CROS_EC_SPI is not set
> > # CONFIG_CROS_EC_LPC is not set
> > CONFIG_CROS_EC_PROTO=y
> > # CONFIG_CROS_KBD_LED_BACKLIGHT is not set
> > CONFIG_CROS_EC_CHARDEV=y
> > CONFIG_CROS_EC_LIGHTBAR=y
> > CONFIG_CROS_EC_DEBUGFS=y
> > CONFIG_CROS_EC_SENSORHUB=y
> > CONFIG_CROS_EC_SYSFS=y
> > # CONFIG_MELLANOX_PLATFORM is not set
> > CONFIG_CLKDEV_LOOKUP=y
> > CONFIG_HAVE_CLK_PREPARE=y
> > CONFIG_COMMON_CLK=y
> > 
> > #
> > # Common Clock Framework
> > #
> > # CONFIG_COMMON_CLK_WM831X is not set
> > # CONFIG_COMMON_CLK_MAX9485 is not set
> > # CONFIG_COMMON_CLK_SI5341 is not set
> > # CONFIG_COMMON_CLK_SI5351 is not set
> > # CONFIG_COMMON_CLK_SI544 is not set
> > # CONFIG_COMMON_CLK_CDCE706 is not set
> > # CONFIG_COMMON_CLK_CS2000_CP is not set
> > # end of Common Clock Framework
> > 
> > # CONFIG_HWSPINLOCK is not set
> > 
> > #
> > # Clock Source drivers
> > #
> > CONFIG_CLKEVT_I8253=y
> > CONFIG_CLKBLD_I8253=y
> > # end of Clock Source drivers
> > 
> > # CONFIG_MAILBOX is not set
> > CONFIG_IOMMU_SUPPORT=y
> > 
> > #
> > # Generic IOMMU Pagetable Support
> > #
> > # end of Generic IOMMU Pagetable Support
> > 
> > # CONFIG_IOMMU_DEBUGFS is not set
> > # CONFIG_AMD_IOMMU is not set
> > 
> > #
> > # Remoteproc drivers
> > #
> > # CONFIG_REMOTEPROC is not set
> > # end of Remoteproc drivers
> > 
> > #
> > # Rpmsg drivers
> > #
> > # CONFIG_RPMSG_VIRTIO is not set
> > # end of Rpmsg drivers
> > 
> > # CONFIG_SOUNDWIRE is not set
> > 
> > #
> > # SOC (System On Chip) specific Drivers
> > #
> > 
> > #
> > # Amlogic SoC drivers
> > #
> > # end of Amlogic SoC drivers
> > 
> > #
> > # Aspeed SoC drivers
> > #
> > # end of Aspeed SoC drivers
> > 
> > #
> > # Broadcom SoC drivers
> > #
> > # end of Broadcom SoC drivers
> > 
> > #
> > # NXP/Freescale QorIQ SoC drivers
> > #
> > # end of NXP/Freescale QorIQ SoC drivers
> > 
> > #
> > # i.MX SoC drivers
> > #
> > # end of i.MX SoC drivers
> > 
> > #
> > # Qualcomm SoC drivers
> > #
> > # end of Qualcomm SoC drivers
> > 
> > # CONFIG_SOC_TI is not set
> > 
> > #
> > # Xilinx SoC drivers
> > #
> > # CONFIG_XILINX_VCU is not set
> > # end of Xilinx SoC drivers
> > # end of SOC (System On Chip) specific Drivers
> > 
> > # CONFIG_PM_DEVFREQ is not set
> > # CONFIG_EXTCON is not set
> > # CONFIG_MEMORY is not set
> > CONFIG_IIO=m
> > CONFIG_IIO_BUFFER=y
> > CONFIG_IIO_BUFFER_CB=m
> > # CONFIG_IIO_BUFFER_HW_CONSUMER is not set
> > CONFIG_IIO_KFIFO_BUF=m
> > CONFIG_IIO_TRIGGERED_BUFFER=m
> > CONFIG_IIO_CONFIGFS=m
> > CONFIG_IIO_TRIGGER=y
> > CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> > # CONFIG_IIO_SW_DEVICE is not set
> > # CONFIG_IIO_SW_TRIGGER is not set
> > 
> > #
> > # Accelerometers
> > #
> > # CONFIG_ADIS16201 is not set
> > CONFIG_ADIS16209=m
> > CONFIG_ADXL345=m
> > CONFIG_ADXL345_I2C=m
> > CONFIG_ADXL345_SPI=m
> > # CONFIG_ADXL372_SPI is not set
> > # CONFIG_ADXL372_I2C is not set
> > # CONFIG_BMA180 is not set
> > CONFIG_BMA220=m
> > # CONFIG_BMA400 is not set
> > # CONFIG_BMC150_ACCEL is not set
> > CONFIG_DA280=m
> > # CONFIG_DA311 is not set
> > CONFIG_DMARD09=m
> > CONFIG_DMARD10=m
> > # CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
> > # CONFIG_IIO_ST_ACCEL_3AXIS is not set
> > CONFIG_KXSD9=m
> > CONFIG_KXSD9_SPI=m
> > # CONFIG_KXSD9_I2C is not set
> > CONFIG_KXCJK1013=m
> > CONFIG_MC3230=m
> > CONFIG_MMA7455=m
> > CONFIG_MMA7455_I2C=m
> > CONFIG_MMA7455_SPI=m
> > CONFIG_MMA7660=m
> > CONFIG_MMA8452=m
> > # CONFIG_MMA9551 is not set
> > # CONFIG_MMA9553 is not set
> > CONFIG_MXC4005=m
> > CONFIG_MXC6255=m
> > CONFIG_SCA3000=m
> > # CONFIG_STK8312 is not set
> > CONFIG_STK8BA50=m
> > # end of Accelerometers
> > 
> > #
> > # Analog to digital converters
> > #
> > CONFIG_AD_SIGMA_DELTA=m
> > # CONFIG_AD7091R5 is not set
> > # CONFIG_AD7124 is not set
> > # CONFIG_AD7266 is not set
> > CONFIG_AD7291=m
> > # CONFIG_AD7292 is not set
> > CONFIG_AD7298=m
> > CONFIG_AD7476=m
> > CONFIG_AD7606=m
> > CONFIG_AD7606_IFACE_PARALLEL=m
> > CONFIG_AD7606_IFACE_SPI=m
> > # CONFIG_AD7766 is not set
> > # CONFIG_AD7768_1 is not set
> > CONFIG_AD7780=m
> > CONFIG_AD7791=m
> > # CONFIG_AD7793 is not set
> > # CONFIG_AD7887 is not set
> > # CONFIG_AD7923 is not set
> > # CONFIG_AD7949 is not set
> > # CONFIG_AD799X is not set
> > # CONFIG_CC10001_ADC is not set
> > # CONFIG_DA9150_GPADC is not set
> > # CONFIG_HI8435 is not set
> > CONFIG_HX711=m
> > # CONFIG_INA2XX_ADC is not set
> > CONFIG_LTC2471=m
> > # CONFIG_LTC2485 is not set
> > # CONFIG_LTC2496 is not set
> > CONFIG_LTC2497=m
> > # CONFIG_MAX1027 is not set
> > # CONFIG_MAX11100 is not set
> > # CONFIG_MAX1118 is not set
> > CONFIG_MAX1363=m
> > # CONFIG_MAX9611 is not set
> > CONFIG_MCP320X=m
> > CONFIG_MCP3422=m
> > # CONFIG_MCP3911 is not set
> > CONFIG_MEN_Z188_ADC=m
> > # CONFIG_NAU7802 is not set
> > CONFIG_QCOM_VADC_COMMON=m
> > # CONFIG_QCOM_SPMI_IADC is not set
> > CONFIG_QCOM_SPMI_VADC=m
> > # CONFIG_QCOM_SPMI_ADC5 is not set
> > CONFIG_STX104=m
> > # CONFIG_TI_ADC081C is not set
> > CONFIG_TI_ADC0832=m
> > CONFIG_TI_ADC084S021=m
> > CONFIG_TI_ADC12138=m
> > CONFIG_TI_ADC108S102=m
> > # CONFIG_TI_ADC128S052 is not set
> > CONFIG_TI_ADC161S626=m
> > CONFIG_TI_ADS1015=m
> > CONFIG_TI_ADS7950=m
> > CONFIG_TI_AM335X_ADC=m
> > CONFIG_TI_TLC4541=m
> > # CONFIG_XILINX_XADC is not set
> > # end of Analog to digital converters
> > 
> > #
> > # Analog Front Ends
> > #
> > # end of Analog Front Ends
> > 
> > #
> > # Amplifiers
> > #
> > CONFIG_AD8366=m
> > # end of Amplifiers
> > 
> > #
> > # Chemical Sensors
> > #
> > CONFIG_ATLAS_PH_SENSOR=m
> > # CONFIG_BME680 is not set
> > CONFIG_CCS811=m
> > CONFIG_IAQCORE=m
> > # CONFIG_SENSIRION_SGP30 is not set
> > # CONFIG_SPS30 is not set
> > CONFIG_VZ89X=m
> > # end of Chemical Sensors
> > 
> > CONFIG_IIO_CROS_EC_SENSORS_CORE=m
> > # CONFIG_IIO_CROS_EC_SENSORS is not set
> > # CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE is not set
> > 
> > #
> > # Hid Sensor IIO Common
> > #
> > # end of Hid Sensor IIO Common
> > 
> > CONFIG_IIO_MS_SENSORS_I2C=m
> > 
> > #
> > # SSP Sensor Common
> > #
> > CONFIG_IIO_SSP_SENSORS_COMMONS=m
> > CONFIG_IIO_SSP_SENSORHUB=m
> > # end of SSP Sensor Common
> > 
> > CONFIG_IIO_ST_SENSORS_I2C=m
> > CONFIG_IIO_ST_SENSORS_SPI=m
> > CONFIG_IIO_ST_SENSORS_CORE=m
> > 
> > #
> > # Digital to analog converters
> > #
> > CONFIG_AD5064=m
> > CONFIG_AD5360=m
> > CONFIG_AD5380=m
> > CONFIG_AD5421=m
> > # CONFIG_AD5446 is not set
> > CONFIG_AD5449=m
> > CONFIG_AD5592R_BASE=m
> > # CONFIG_AD5592R is not set
> > CONFIG_AD5593R=m
> > CONFIG_AD5504=m
> > CONFIG_AD5624R_SPI=m
> > # CONFIG_LTC1660 is not set
> > CONFIG_LTC2632=m
> > # CONFIG_AD5686_SPI is not set
> > # CONFIG_AD5696_I2C is not set
> > CONFIG_AD5755=m
> > # CONFIG_AD5758 is not set
> > CONFIG_AD5761=m
> > # CONFIG_AD5764 is not set
> > CONFIG_AD5791=m
> > # CONFIG_AD7303 is not set
> > # CONFIG_CIO_DAC is not set
> > CONFIG_AD8801=m
> > # CONFIG_DS4424 is not set
> > # CONFIG_M62332 is not set
> > CONFIG_MAX517=m
> > CONFIG_MCP4725=m
> > CONFIG_MCP4922=m
> > # CONFIG_TI_DAC082S085 is not set
> > # CONFIG_TI_DAC5571 is not set
> > # CONFIG_TI_DAC7311 is not set
> > # CONFIG_TI_DAC7612 is not set
> > # end of Digital to analog converters
> > 
> > #
> > # IIO dummy driver
> > #
> > # end of IIO dummy driver
> > 
> > #
> > # Frequency Synthesizers DDS/PLL
> > #
> > 
> > #
> > # Clock Generator/Distribution
> > #
> > CONFIG_AD9523=m
> > # end of Clock Generator/Distribution
> > 
> > #
> > # Phase-Locked Loop (PLL) frequency synthesizers
> > #
> > # CONFIG_ADF4350 is not set
> > # CONFIG_ADF4371 is not set
> > # end of Phase-Locked Loop (PLL) frequency synthesizers
> > # end of Frequency Synthesizers DDS/PLL
> > 
> > #
> > # Digital gyroscope sensors
> > #
> > CONFIG_ADIS16080=m
> > # CONFIG_ADIS16130 is not set
> > CONFIG_ADIS16136=m
> > CONFIG_ADIS16260=m
> > CONFIG_ADXRS450=m
> > CONFIG_BMG160=m
> > CONFIG_BMG160_I2C=m
> > CONFIG_BMG160_SPI=m
> > # CONFIG_FXAS21002C is not set
> > CONFIG_MPU3050=m
> > CONFIG_MPU3050_I2C=m
> > CONFIG_IIO_ST_GYRO_3AXIS=m
> > CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
> > CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
> > CONFIG_ITG3200=m
> > # end of Digital gyroscope sensors
> > 
> > #
> > # Health Sensors
> > #
> > 
> > #
> > # Heart Rate Monitors
> > #
> > CONFIG_AFE4403=m
> > CONFIG_AFE4404=m
> > CONFIG_MAX30100=m
> > # CONFIG_MAX30102 is not set
> > # end of Heart Rate Monitors
> > # end of Health Sensors
> > 
> > #
> > # Humidity sensors
> > #
> > CONFIG_AM2315=m
> > CONFIG_DHT11=m
> > # CONFIG_HDC100X is not set
> > # CONFIG_HTS221 is not set
> > CONFIG_HTU21=m
> > CONFIG_SI7005=m
> > CONFIG_SI7020=m
> > # end of Humidity sensors
> > 
> > #
> > # Inertial measurement units
> > #
> > CONFIG_ADIS16400=m
> > # CONFIG_ADIS16460 is not set
> > # CONFIG_ADIS16480 is not set
> > CONFIG_BMI160=m
> > CONFIG_BMI160_I2C=m
> > CONFIG_BMI160_SPI=m
> > # CONFIG_FXOS8700_I2C is not set
> > # CONFIG_FXOS8700_SPI is not set
> > CONFIG_KMX61=m
> > CONFIG_INV_MPU6050_IIO=m
> > # CONFIG_INV_MPU6050_I2C is not set
> > CONFIG_INV_MPU6050_SPI=m
> > # CONFIG_IIO_ST_LSM6DSX is not set
> > # end of Inertial measurement units
> > 
> > CONFIG_IIO_ADIS_LIB=m
> > CONFIG_IIO_ADIS_LIB_BUFFER=y
> > 
> > #
> > # Light sensors
> > #
> > # CONFIG_ACPI_ALS is not set
> > CONFIG_ADJD_S311=m
> > # CONFIG_ADUX1020 is not set
> > # CONFIG_AL3320A is not set
> > CONFIG_APDS9300=m
> > # CONFIG_APDS9960 is not set
> > CONFIG_BH1750=m
> > # CONFIG_BH1780 is not set
> > CONFIG_CM32181=m
> > CONFIG_CM3232=m
> > # CONFIG_CM3323 is not set
> > CONFIG_CM36651=m
> > CONFIG_IIO_CROS_EC_LIGHT_PROX=m
> > CONFIG_GP2AP020A00F=m
> > # CONFIG_SENSORS_ISL29018 is not set
> > CONFIG_SENSORS_ISL29028=m
> > # CONFIG_ISL29125 is not set
> > # CONFIG_JSA1212 is not set
> > # CONFIG_RPR0521 is not set
> > CONFIG_SENSORS_LM3533=m
> > CONFIG_LTR501=m
> > # CONFIG_LV0104CS is not set
> > # CONFIG_MAX44000 is not set
> > # CONFIG_MAX44009 is not set
> > # CONFIG_NOA1305 is not set
> > CONFIG_OPT3001=m
> > CONFIG_PA12203001=m
> > # CONFIG_SI1133 is not set
> > # CONFIG_SI1145 is not set
> > # CONFIG_STK3310 is not set
> > # CONFIG_ST_UVIS25 is not set
> > CONFIG_TCS3414=m
> > CONFIG_TCS3472=m
> > CONFIG_SENSORS_TSL2563=m
> > # CONFIG_TSL2583 is not set
> > # CONFIG_TSL2772 is not set
> > CONFIG_TSL4531=m
> > # CONFIG_US5182D is not set
> > # CONFIG_VCNL4000 is not set
> > # CONFIG_VCNL4035 is not set
> > # CONFIG_VEML6030 is not set
> > CONFIG_VEML6070=m
> > # CONFIG_VL6180 is not set
> > # CONFIG_ZOPT2201 is not set
> > # end of Light sensors
> > 
> > #
> > # Magnetometer sensors
> > #
> > CONFIG_AK8975=m
> > CONFIG_AK09911=m
> > CONFIG_BMC150_MAGN=m
> > # CONFIG_BMC150_MAGN_I2C is not set
> > CONFIG_BMC150_MAGN_SPI=m
> > CONFIG_MAG3110=m
> > CONFIG_MMC35240=m
> > # CONFIG_IIO_ST_MAGN_3AXIS is not set
> > CONFIG_SENSORS_HMC5843=m
> > CONFIG_SENSORS_HMC5843_I2C=m
> > CONFIG_SENSORS_HMC5843_SPI=m
> > # CONFIG_SENSORS_RM3100_I2C is not set
> > # CONFIG_SENSORS_RM3100_SPI is not set
> > # end of Magnetometer sensors
> > 
> > #
> > # Multiplexers
> > #
> > # end of Multiplexers
> > 
> > #
> > # Inclinometer sensors
> > #
> > # end of Inclinometer sensors
> > 
> > #
> > # Triggers - standalone
> > #
> > CONFIG_IIO_INTERRUPT_TRIGGER=m
> > CONFIG_IIO_SYSFS_TRIGGER=m
> > # end of Triggers - standalone
> > 
> > #
> > # Digital potentiometers
> > #
> > # CONFIG_AD5272 is not set
> > CONFIG_DS1803=m
> > # CONFIG_MAX5432 is not set
> > # CONFIG_MAX5481 is not set
> > CONFIG_MAX5487=m
> > # CONFIG_MCP4018 is not set
> > # CONFIG_MCP4131 is not set
> > CONFIG_MCP4531=m
> > # CONFIG_MCP41010 is not set
> > CONFIG_TPL0102=m
> > # end of Digital potentiometers
> > 
> > #
> > # Digital potentiostats
> > #
> > CONFIG_LMP91000=m
> > # end of Digital potentiostats
> > 
> > #
> > # Pressure sensors
> > #
> > # CONFIG_ABP060MG is not set
> > # CONFIG_BMP280 is not set
> > # CONFIG_IIO_CROS_EC_BARO is not set
> > # CONFIG_DLHL60D is not set
> > # CONFIG_DPS310 is not set
> > CONFIG_HP03=m
> > CONFIG_MPL115=m
> > CONFIG_MPL115_I2C=m
> > CONFIG_MPL115_SPI=m
> > CONFIG_MPL3115=m
> > CONFIG_MS5611=m
> > # CONFIG_MS5611_I2C is not set
> > CONFIG_MS5611_SPI=m
> > CONFIG_MS5637=m
> > CONFIG_IIO_ST_PRESS=m
> > CONFIG_IIO_ST_PRESS_I2C=m
> > CONFIG_IIO_ST_PRESS_SPI=m
> > CONFIG_T5403=m
> > CONFIG_HP206C=m
> > # CONFIG_ZPA2326 is not set
> > # end of Pressure sensors
> > 
> > #
> > # Lightning sensors
> > #
> > CONFIG_AS3935=m
> > # end of Lightning sensors
> > 
> > #
> > # Proximity and distance sensors
> > #
> > # CONFIG_ISL29501 is not set
> > # CONFIG_LIDAR_LITE_V2 is not set
> > # CONFIG_MB1232 is not set
> > # CONFIG_PING is not set
> > # CONFIG_RFD77402 is not set
> > # CONFIG_SRF04 is not set
> > # CONFIG_SX9500 is not set
> > CONFIG_SRF08=m
> > # CONFIG_VL53L0X_I2C is not set
> > # end of Proximity and distance sensors
> > 
> > #
> > # Resolver to digital converters
> > #
> > # CONFIG_AD2S90 is not set
> > CONFIG_AD2S1200=m
> > # end of Resolver to digital converters
> > 
> > #
> > # Temperature sensors
> > #
> > # CONFIG_LTC2983 is not set
> > CONFIG_MAXIM_THERMOCOUPLE=m
> > CONFIG_MLX90614=m
> > # CONFIG_MLX90632 is not set
> > CONFIG_TMP006=m
> > CONFIG_TMP007=m
> > CONFIG_TSYS01=m
> > CONFIG_TSYS02D=m
> > # CONFIG_MAX31856 is not set
> > # end of Temperature sensors
> > 
> > # CONFIG_NTB is not set
> > # CONFIG_VME_BUS is not set
> > # CONFIG_PWM is not set
> > 
> > #
> > # IRQ chip support
> > #
> > # end of IRQ chip support
> > 
> > CONFIG_IPACK_BUS=m
> > # CONFIG_BOARD_TPCI200 is not set
> > # CONFIG_SERIAL_IPOCTAL is not set
> > CONFIG_RESET_CONTROLLER=y
> > # CONFIG_RESET_BRCMSTB_RESCAL is not set
> > CONFIG_RESET_TI_SYSCON=y
> > 
> > #
> > # PHY Subsystem
> > #
> > CONFIG_GENERIC_PHY=y
> > # CONFIG_BCM_KONA_USB2_PHY is not set
> > # CONFIG_PHY_PXA_28NM_HSIC is not set
> > CONFIG_PHY_PXA_28NM_USB2=m
> > # CONFIG_PHY_CPCAP_USB is not set
> > # CONFIG_PHY_INTEL_EMMC is not set
> > # end of PHY Subsystem
> > 
> > # CONFIG_POWERCAP is not set
> > CONFIG_MCB=y
> > # CONFIG_MCB_PCI is not set
> > CONFIG_MCB_LPC=y
> > 
> > #
> > # Performance monitor support
> > #
> > # end of Performance monitor support
> > 
> > CONFIG_RAS=y
> > # CONFIG_USB4 is not set
> > 
> > #
> > # Android
> > #
> > CONFIG_ANDROID=y
> > CONFIG_ANDROID_BINDER_IPC=y
> > # CONFIG_ANDROID_BINDERFS is not set
> > CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
> > # CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
> > # end of Android
> > 
> > # CONFIG_LIBNVDIMM is not set
> > CONFIG_DAX=y
> > CONFIG_NVMEM=y
> > CONFIG_NVMEM_SYSFS=y
> > # CONFIG_NVMEM_SPMI_SDAM is not set
> > 
> > #
> > # HW tracing support
> > #
> > # CONFIG_STM is not set
> > CONFIG_INTEL_TH=y
> > # CONFIG_INTEL_TH_PCI is not set
> > # CONFIG_INTEL_TH_ACPI is not set
> > # CONFIG_INTEL_TH_GTH is not set
> > CONFIG_INTEL_TH_MSU=m
> > CONFIG_INTEL_TH_PTI=y
> > CONFIG_INTEL_TH_DEBUG=y
> > # end of HW tracing support
> > 
> > # CONFIG_FPGA is not set
> > # CONFIG_TEE is not set
> > # CONFIG_UNISYS_VISORBUS is not set
> > # CONFIG_SIOX is not set
> > # CONFIG_SLIMBUS is not set
> > # CONFIG_INTERCONNECT is not set
> > # CONFIG_COUNTER is not set
> > # end of Device Drivers
> > 
> > #
> > # File systems
> > #
> > CONFIG_DCACHE_WORD_ACCESS=y
> > # CONFIG_VALIDATE_FS_PARSER is not set
> > CONFIG_FS_IOMAP=y
> > # CONFIG_EXT2_FS is not set
> > # CONFIG_EXT3_FS is not set
> > # CONFIG_EXT4_FS is not set
> > # CONFIG_REISERFS_FS is not set
> > # CONFIG_JFS_FS is not set
> > CONFIG_XFS_FS=m
> > # CONFIG_XFS_QUOTA is not set
> > # CONFIG_XFS_POSIX_ACL is not set
> > # CONFIG_XFS_RT is not set
> > # CONFIG_XFS_ONLINE_SCRUB is not set
> > # CONFIG_XFS_WARN is not set
> > # CONFIG_XFS_DEBUG is not set
> > # CONFIG_GFS2_FS is not set
> > # CONFIG_OCFS2_FS is not set
> > CONFIG_BTRFS_FS=m
> > # CONFIG_BTRFS_FS_POSIX_ACL is not set
> > # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> > # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> > # CONFIG_BTRFS_DEBUG is not set
> > # CONFIG_BTRFS_ASSERT is not set
> > # CONFIG_BTRFS_FS_REF_VERIFY is not set
> > # CONFIG_NILFS2_FS is not set
> > # CONFIG_F2FS_FS is not set
> > # CONFIG_FS_DAX is not set
> > CONFIG_FS_POSIX_ACL=y
> > CONFIG_EXPORTFS=y
> > # CONFIG_EXPORTFS_BLOCK_OPS is not set
> > CONFIG_FILE_LOCKING=y
> > CONFIG_MANDATORY_FILE_LOCKING=y
> > # CONFIG_FS_ENCRYPTION is not set
> > # CONFIG_FS_VERITY is not set
> > CONFIG_FSNOTIFY=y
> > # CONFIG_DNOTIFY is not set
> > CONFIG_INOTIFY_USER=y
> > CONFIG_FANOTIFY=y
> > CONFIG_QUOTA=y
> > # CONFIG_QUOTA_NETLINK_INTERFACE is not set
> > CONFIG_PRINT_QUOTA_WARNING=y
> > CONFIG_QUOTA_DEBUG=y
> > CONFIG_QFMT_V1=y
> > # CONFIG_QFMT_V2 is not set
> > CONFIG_QUOTACTL=y
> > # CONFIG_AUTOFS4_FS is not set
> > # CONFIG_AUTOFS_FS is not set
> > CONFIG_FUSE_FS=y
> > CONFIG_CUSE=m
> > # CONFIG_VIRTIO_FS is not set
> > CONFIG_OVERLAY_FS=m
> > CONFIG_OVERLAY_FS_REDIRECT_DIR=y
> > CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
> > # CONFIG_OVERLAY_FS_INDEX is not set
> > # CONFIG_OVERLAY_FS_XINO_AUTO is not set
> > # CONFIG_OVERLAY_FS_METACOPY is not set
> > 
> > #
> > # Caches
> > #
> > CONFIG_FSCACHE=y
> > # CONFIG_FSCACHE_STATS is not set
> > # CONFIG_FSCACHE_HISTOGRAM is not set
> > CONFIG_FSCACHE_DEBUG=y
> > # CONFIG_FSCACHE_OBJECT_LIST is not set
> > # CONFIG_CACHEFILES is not set
> > # end of Caches
> > 
> > #
> > # CD-ROM/DVD Filesystems
> > #
> > # CONFIG_ISO9660_FS is not set
> > # CONFIG_UDF_FS is not set
> > # end of CD-ROM/DVD Filesystems
> > 
> > #
> > # DOS/FAT/NT Filesystems
> > #
> > # CONFIG_MSDOS_FS is not set
> > # CONFIG_VFAT_FS is not set
> > # CONFIG_NTFS_FS is not set
> > # end of DOS/FAT/NT Filesystems
> > 
> > #
> > # Pseudo filesystems
> > #
> > CONFIG_PROC_FS=y
> > # CONFIG_PROC_KCORE is not set
> > CONFIG_PROC_VMCORE=y
> > # CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
> > CONFIG_PROC_SYSCTL=y
> > CONFIG_PROC_PAGE_MONITOR=y
> > CONFIG_PROC_CHILDREN=y
> > CONFIG_PROC_PID_ARCH_STATUS=y
> > CONFIG_PROC_CPU_RESCTRL=y
> > CONFIG_KERNFS=y
> > CONFIG_SYSFS=y
> > CONFIG_TMPFS=y
> > CONFIG_TMPFS_POSIX_ACL=y
> > CONFIG_TMPFS_XATTR=y
> > CONFIG_HUGETLBFS=y
> > CONFIG_HUGETLB_PAGE=y
> > CONFIG_MEMFD_CREATE=y
> > CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> > CONFIG_CONFIGFS_FS=m
> > CONFIG_EFIVAR_FS=m
> > # end of Pseudo filesystems
> > 
> > CONFIG_MISC_FILESYSTEMS=y
> > # CONFIG_ORANGEFS_FS is not set
> > # CONFIG_ADFS_FS is not set
> > # CONFIG_AFFS_FS is not set
> > # CONFIG_ECRYPT_FS is not set
> > # CONFIG_HFS_FS is not set
> > # CONFIG_HFSPLUS_FS is not set
> > # CONFIG_BEFS_FS is not set
> > # CONFIG_BFS_FS is not set
> > # CONFIG_EFS_FS is not set
> > # CONFIG_JFFS2_FS is not set
> > # CONFIG_UBIFS_FS is not set
> > # CONFIG_CRAMFS is not set
> > # CONFIG_SQUASHFS is not set
> > # CONFIG_VXFS_FS is not set
> > # CONFIG_MINIX_FS is not set
> > # CONFIG_OMFS_FS is not set
> > # CONFIG_HPFS_FS is not set
> > # CONFIG_QNX4FS_FS is not set
> > # CONFIG_QNX6FS_FS is not set
> > # CONFIG_ROMFS_FS is not set
> > CONFIG_PSTORE=y
> > CONFIG_PSTORE_DEFLATE_COMPRESS=y
> > # CONFIG_PSTORE_LZO_COMPRESS is not set
> > # CONFIG_PSTORE_LZ4_COMPRESS is not set
> > # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
> > # CONFIG_PSTORE_842_COMPRESS is not set
> > # CONFIG_PSTORE_ZSTD_COMPRESS is not set
> > CONFIG_PSTORE_COMPRESS=y
> > CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
> > CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
> > CONFIG_PSTORE_CONSOLE=y
> > CONFIG_PSTORE_PMSG=y
> > # CONFIG_PSTORE_FTRACE is not set
> > CONFIG_PSTORE_RAM=m
> > # CONFIG_SYSV_FS is not set
> > # CONFIG_UFS_FS is not set
> > # CONFIG_EROFS_FS is not set
> > CONFIG_NETWORK_FILESYSTEMS=y
> > CONFIG_NFS_FS=y
> > CONFIG_NFS_V2=y
> > CONFIG_NFS_V3=y
> > # CONFIG_NFS_V3_ACL is not set
> > CONFIG_NFS_V4=m
> > # CONFIG_NFS_SWAP is not set
> > # CONFIG_NFS_V4_1 is not set
> > # CONFIG_ROOT_NFS is not set
> > # CONFIG_NFS_FSCACHE is not set
> > # CONFIG_NFS_USE_LEGACY_DNS is not set
> > CONFIG_NFS_USE_KERNEL_DNS=y
> > CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> > # CONFIG_NFSD is not set
> > CONFIG_GRACE_PERIOD=y
> > CONFIG_LOCKD=y
> > CONFIG_LOCKD_V4=y
> > CONFIG_NFS_COMMON=y
> > CONFIG_SUNRPC=y
> > CONFIG_SUNRPC_GSS=m
> > CONFIG_RPCSEC_GSS_KRB5=m
> > # CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
> > # CONFIG_SUNRPC_DEBUG is not set
> > CONFIG_CEPH_FS=y
> > CONFIG_CEPH_FSCACHE=y
> > # CONFIG_CEPH_FS_POSIX_ACL is not set
> > CONFIG_CIFS=m
> > # CONFIG_CIFS_STATS2 is not set
> > # CONFIG_CIFS_ALLOW_INSECURE_LEGACY is not set
> > CONFIG_CIFS_UPCALL=y
> > CONFIG_CIFS_XATTR=y
> > # CONFIG_CIFS_DEBUG is not set
> > # CONFIG_CIFS_DFS_UPCALL is not set
> > # CONFIG_CIFS_FSCACHE is not set
> > # CONFIG_CODA_FS is not set
> > # CONFIG_AFS_FS is not set
> > # CONFIG_9P_FS is not set
> > CONFIG_NLS=y
> > CONFIG_NLS_DEFAULT="iso8859-1"
> > CONFIG_NLS_CODEPAGE_437=m
> > # CONFIG_NLS_CODEPAGE_737 is not set
> > # CONFIG_NLS_CODEPAGE_775 is not set
> > CONFIG_NLS_CODEPAGE_850=y
> > CONFIG_NLS_CODEPAGE_852=m
> > CONFIG_NLS_CODEPAGE_855=y
> > # CONFIG_NLS_CODEPAGE_857 is not set
> > # CONFIG_NLS_CODEPAGE_860 is not set
> > CONFIG_NLS_CODEPAGE_861=m
> > CONFIG_NLS_CODEPAGE_862=m
> > # CONFIG_NLS_CODEPAGE_863 is not set
> > CONFIG_NLS_CODEPAGE_864=m
> > # CONFIG_NLS_CODEPAGE_865 is not set
> > CONFIG_NLS_CODEPAGE_866=m
> > CONFIG_NLS_CODEPAGE_869=y
> > CONFIG_NLS_CODEPAGE_936=m
> > CONFIG_NLS_CODEPAGE_950=y
> > CONFIG_NLS_CODEPAGE_932=y
> > CONFIG_NLS_CODEPAGE_949=y
> > CONFIG_NLS_CODEPAGE_874=m
> > CONFIG_NLS_ISO8859_8=y
> > CONFIG_NLS_CODEPAGE_1250=y
> > # CONFIG_NLS_CODEPAGE_1251 is not set
> > CONFIG_NLS_ASCII=m
> > # CONFIG_NLS_ISO8859_1 is not set
> > CONFIG_NLS_ISO8859_2=m
> > CONFIG_NLS_ISO8859_3=y
> > CONFIG_NLS_ISO8859_4=m
> > CONFIG_NLS_ISO8859_5=y
> > # CONFIG_NLS_ISO8859_6 is not set
> > # CONFIG_NLS_ISO8859_7 is not set
> > CONFIG_NLS_ISO8859_9=y
> > CONFIG_NLS_ISO8859_13=m
> > CONFIG_NLS_ISO8859_14=m
> > CONFIG_NLS_ISO8859_15=m
> > CONFIG_NLS_KOI8_R=y
> > CONFIG_NLS_KOI8_U=y
> > CONFIG_NLS_MAC_ROMAN=y
> > CONFIG_NLS_MAC_CELTIC=y
> > CONFIG_NLS_MAC_CENTEURO=m
> > CONFIG_NLS_MAC_CROATIAN=m
> > CONFIG_NLS_MAC_CYRILLIC=m
> > # CONFIG_NLS_MAC_GAELIC is not set
> > # CONFIG_NLS_MAC_GREEK is not set
> > # CONFIG_NLS_MAC_ICELAND is not set
> > # CONFIG_NLS_MAC_INUIT is not set
> > CONFIG_NLS_MAC_ROMANIAN=y
> > CONFIG_NLS_MAC_TURKISH=m
> > CONFIG_NLS_UTF8=y
> > CONFIG_DLM=m
> > CONFIG_DLM_DEBUG=y
> > # CONFIG_UNICODE is not set
> > CONFIG_IO_WQ=y
> > # end of File systems
> > 
> > #
> > # Security options
> > #
> > CONFIG_KEYS=y
> > # CONFIG_KEYS_REQUEST_CACHE is not set
> > CONFIG_PERSISTENT_KEYRINGS=y
> > CONFIG_BIG_KEYS=y
> > # CONFIG_ENCRYPTED_KEYS is not set
> > # CONFIG_KEY_DH_OPERATIONS is not set
> > # CONFIG_SECURITY_DMESG_RESTRICT is not set
> > # CONFIG_SECURITY is not set
> > CONFIG_SECURITYFS=y
> > CONFIG_PAGE_TABLE_ISOLATION=y
> > CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> > CONFIG_HARDENED_USERCOPY=y
> > CONFIG_HARDENED_USERCOPY_FALLBACK=y
> > CONFIG_HARDENED_USERCOPY_PAGESPAN=y
> > CONFIG_FORTIFY_SOURCE=y
> > # CONFIG_STATIC_USERMODEHELPER is not set
> > CONFIG_DEFAULT_SECURITY_DAC=y
> > CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity"
> > 
> > #
> > # Kernel hardening options
> > #
> > 
> > #
> > # Memory initialization
> > #
> > CONFIG_INIT_STACK_NONE=y
> > # CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
> > # CONFIG_GCC_PLUGIN_STACKLEAK is not set
> > # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> > # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> > # end of Memory initialization
> > # end of Kernel hardening options
> > # end of Security options
> > 
> > CONFIG_XOR_BLOCKS=m
> > CONFIG_CRYPTO=y
> > 
> > #
> > # Crypto core or helper
> > #
> > CONFIG_CRYPTO_ALGAPI=y
> > CONFIG_CRYPTO_ALGAPI2=y
> > CONFIG_CRYPTO_AEAD=y
> > CONFIG_CRYPTO_AEAD2=y
> > CONFIG_CRYPTO_SKCIPHER=y
> > CONFIG_CRYPTO_SKCIPHER2=y
> > CONFIG_CRYPTO_HASH=y
> > CONFIG_CRYPTO_HASH2=y
> > CONFIG_CRYPTO_RNG=y
> > CONFIG_CRYPTO_RNG2=y
> > CONFIG_CRYPTO_RNG_DEFAULT=y
> > CONFIG_CRYPTO_AKCIPHER2=y
> > CONFIG_CRYPTO_KPP2=y
> > CONFIG_CRYPTO_KPP=y
> > CONFIG_CRYPTO_ACOMP2=y
> > CONFIG_CRYPTO_MANAGER=y
> > CONFIG_CRYPTO_MANAGER2=y
> > CONFIG_CRYPTO_USER=m
> > CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> > CONFIG_CRYPTO_GF128MUL=y
> > CONFIG_CRYPTO_NULL=y
> > CONFIG_CRYPTO_NULL2=y
> > CONFIG_CRYPTO_CRYPTD=y
> > CONFIG_CRYPTO_AUTHENC=m
> > # CONFIG_CRYPTO_TEST is not set
> > CONFIG_CRYPTO_SIMD=y
> > CONFIG_CRYPTO_GLUE_HELPER_X86=y
> > 
> > #
> > # Public-key cryptography
> > #
> > # CONFIG_CRYPTO_RSA is not set
> > # CONFIG_CRYPTO_DH is not set
> > CONFIG_CRYPTO_ECC=y
> > CONFIG_CRYPTO_ECDH=y
> > # CONFIG_CRYPTO_ECRDSA is not set
> > # CONFIG_CRYPTO_CURVE25519 is not set
> > # CONFIG_CRYPTO_CURVE25519_X86 is not set
> > 
> > #
> > # Authenticated Encryption with Associated Data
> > #
> > CONFIG_CRYPTO_CCM=y
> > CONFIG_CRYPTO_GCM=y
> > CONFIG_CRYPTO_CHACHA20POLY1305=m
> > # CONFIG_CRYPTO_AEGIS128 is not set
> > # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
> > CONFIG_CRYPTO_SEQIV=y
> > CONFIG_CRYPTO_ECHAINIV=m
> > 
> > #
> > # Block modes
> > #
> > CONFIG_CRYPTO_CBC=y
> > # CONFIG_CRYPTO_CFB is not set
> > CONFIG_CRYPTO_CTR=y
> > CONFIG_CRYPTO_CTS=m
> > CONFIG_CRYPTO_ECB=y
> > CONFIG_CRYPTO_LRW=y
> > # CONFIG_CRYPTO_OFB is not set
> > CONFIG_CRYPTO_PCBC=y
> > CONFIG_CRYPTO_XTS=y
> > CONFIG_CRYPTO_KEYWRAP=m
> > # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
> > # CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
> > # CONFIG_CRYPTO_ADIANTUM is not set
> > # CONFIG_CRYPTO_ESSIV is not set
> > 
> > #
> > # Hash modes
> > #
> > CONFIG_CRYPTO_CMAC=y
> > CONFIG_CRYPTO_HMAC=y
> > # CONFIG_CRYPTO_XCBC is not set
> > CONFIG_CRYPTO_VMAC=y
> > 
> > #
> > # Digest
> > #
> > CONFIG_CRYPTO_CRC32C=y
> > CONFIG_CRYPTO_CRC32C_INTEL=m
> > CONFIG_CRYPTO_CRC32=m
> > CONFIG_CRYPTO_CRC32_PCLMUL=m
> > CONFIG_CRYPTO_XXHASH=m
> > CONFIG_CRYPTO_BLAKE2B=m
> > # CONFIG_CRYPTO_BLAKE2S is not set
> > # CONFIG_CRYPTO_BLAKE2S_X86 is not set
> > CONFIG_CRYPTO_CRCT10DIF=m
> > CONFIG_CRYPTO_GHASH=y
> > CONFIG_CRYPTO_POLY1305=y
> > # CONFIG_CRYPTO_POLY1305_X86_64 is not set
> > CONFIG_CRYPTO_MD4=m
> > CONFIG_CRYPTO_MD5=y
> > CONFIG_CRYPTO_MICHAEL_MIC=m
> > CONFIG_CRYPTO_RMD128=m
> > CONFIG_CRYPTO_RMD160=y
> > CONFIG_CRYPTO_RMD256=y
> > # CONFIG_CRYPTO_RMD320 is not set
> > CONFIG_CRYPTO_SHA1=y
> > CONFIG_CRYPTO_SHA1_SSSE3=y
> > # CONFIG_CRYPTO_SHA256_SSSE3 is not set
> > CONFIG_CRYPTO_SHA512_SSSE3=m
> > CONFIG_CRYPTO_SHA256=y
> > CONFIG_CRYPTO_SHA512=y
> > CONFIG_CRYPTO_SHA3=m
> > # CONFIG_CRYPTO_SM3 is not set
> > # CONFIG_CRYPTO_STREEBOG is not set
> > # CONFIG_CRYPTO_TGR192 is not set
> > CONFIG_CRYPTO_WP512=y
> > CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
> > 
> > #
> > # Ciphers
> > #
> > CONFIG_CRYPTO_AES=y
> > # CONFIG_CRYPTO_AES_TI is not set
> > CONFIG_CRYPTO_AES_NI_INTEL=m
> > CONFIG_CRYPTO_ANUBIS=m
> > CONFIG_CRYPTO_ARC4=y
> > CONFIG_CRYPTO_BLOWFISH=y
> > CONFIG_CRYPTO_BLOWFISH_COMMON=y
> > CONFIG_CRYPTO_BLOWFISH_X86_64=m
> > # CONFIG_CRYPTO_CAMELLIA is not set
> > CONFIG_CRYPTO_CAMELLIA_X86_64=y
> > CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
> > CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
> > CONFIG_CRYPTO_CAST_COMMON=y
> > CONFIG_CRYPTO_CAST5=m
> > CONFIG_CRYPTO_CAST5_AVX_X86_64=m
> > CONFIG_CRYPTO_CAST6=y
> > CONFIG_CRYPTO_CAST6_AVX_X86_64=y
> > CONFIG_CRYPTO_DES=m
> > # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
> > CONFIG_CRYPTO_FCRYPT=y
> > # CONFIG_CRYPTO_KHAZAD is not set
> > CONFIG_CRYPTO_SALSA20=m
> > CONFIG_CRYPTO_CHACHA20=y
> > CONFIG_CRYPTO_CHACHA20_X86_64=y
> > # CONFIG_CRYPTO_SEED is not set
> > CONFIG_CRYPTO_SERPENT=y
> > CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
> > CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
> > CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
> > # CONFIG_CRYPTO_SM4 is not set
> > CONFIG_CRYPTO_TEA=m
> > CONFIG_CRYPTO_TWOFISH=y
> > CONFIG_CRYPTO_TWOFISH_COMMON=y
> > CONFIG_CRYPTO_TWOFISH_X86_64=m
> > CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
> > CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
> > 
> > #
> > # Compression
> > #
> > CONFIG_CRYPTO_DEFLATE=y
> > CONFIG_CRYPTO_LZO=y
> > # CONFIG_CRYPTO_842 is not set
> > CONFIG_CRYPTO_LZ4=y
> > CONFIG_CRYPTO_LZ4HC=m
> > # CONFIG_CRYPTO_ZSTD is not set
> > 
> > #
> > # Random Number Generation
> > #
> > # CONFIG_CRYPTO_ANSI_CPRNG is not set
> > CONFIG_CRYPTO_DRBG_MENU=y
> > CONFIG_CRYPTO_DRBG_HMAC=y
> > # CONFIG_CRYPTO_DRBG_HASH is not set
> > # CONFIG_CRYPTO_DRBG_CTR is not set
> > CONFIG_CRYPTO_DRBG=y
> > CONFIG_CRYPTO_JITTERENTROPY=y
> > CONFIG_CRYPTO_USER_API=y
> > CONFIG_CRYPTO_USER_API_HASH=y
> > CONFIG_CRYPTO_USER_API_SKCIPHER=y
> > CONFIG_CRYPTO_USER_API_RNG=y
> > CONFIG_CRYPTO_USER_API_AEAD=y
> > # CONFIG_CRYPTO_STATS is not set
> > 
> > #
> > # Crypto library routines
> > #
> > CONFIG_CRYPTO_LIB_AES=y
> > CONFIG_CRYPTO_LIB_ARC4=y
> > # CONFIG_CRYPTO_LIB_BLAKE2S is not set
> > CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
> > CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> > # CONFIG_CRYPTO_LIB_CHACHA is not set
> > # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> > CONFIG_CRYPTO_LIB_DES=m
> > CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
> > CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> > # CONFIG_CRYPTO_LIB_POLY1305 is not set
> > # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> > CONFIG_CRYPTO_LIB_SHA256=y
> > # CONFIG_CRYPTO_HW is not set
> > # CONFIG_ASYMMETRIC_KEY_TYPE is not set
> > 
> > #
> > # Certificates for signature checking
> > #
> > CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> > CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> > # end of Certificates for signature checking
> > 
> > CONFIG_BINARY_PRINTF=y
> > 
> > #
> > # Library routines
> > #
> > CONFIG_RAID6_PQ=m
> > CONFIG_RAID6_PQ_BENCHMARK=y
> > # CONFIG_PACKING is not set
> > CONFIG_BITREVERSE=y
> > CONFIG_GENERIC_STRNCPY_FROM_USER=y
> > CONFIG_GENERIC_STRNLEN_USER=y
> > CONFIG_GENERIC_NET_UTILS=y
> > CONFIG_GENERIC_FIND_FIRST_BIT=y
> > # CONFIG_CORDIC is not set
> > CONFIG_PRIME_NUMBERS=m
> > CONFIG_RATIONAL=y
> > CONFIG_GENERIC_PCI_IOMAP=y
> > CONFIG_GENERIC_IOMAP=y
> > CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> > CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> > CONFIG_CRC_CCITT=y
> > CONFIG_CRC16=y
> > # CONFIG_CRC_T10DIF is not set
> > CONFIG_CRC_ITU_T=m
> > CONFIG_CRC32=y
> > CONFIG_CRC32_SELFTEST=y
> > # CONFIG_CRC32_SLICEBY8 is not set
> > CONFIG_CRC32_SLICEBY4=y
> > # CONFIG_CRC32_SARWATE is not set
> > # CONFIG_CRC32_BIT is not set
> > # CONFIG_CRC64 is not set
> > CONFIG_CRC4=y
> > CONFIG_CRC7=m
> > CONFIG_LIBCRC32C=y
> > # CONFIG_CRC8 is not set
> > CONFIG_XXHASH=y
> > CONFIG_RANDOM32_SELFTEST=y
> > CONFIG_ZLIB_INFLATE=y
> > CONFIG_ZLIB_DEFLATE=y
> > CONFIG_LZO_COMPRESS=y
> > CONFIG_LZO_DECOMPRESS=y
> > CONFIG_LZ4_COMPRESS=y
> > CONFIG_LZ4HC_COMPRESS=m
> > CONFIG_LZ4_DECOMPRESS=y
> > CONFIG_ZSTD_COMPRESS=m
> > CONFIG_ZSTD_DECOMPRESS=m
> > CONFIG_XZ_DEC=y
> > CONFIG_XZ_DEC_X86=y
> > CONFIG_XZ_DEC_POWERPC=y
> > # CONFIG_XZ_DEC_IA64 is not set
> > # CONFIG_XZ_DEC_ARM is not set
> > # CONFIG_XZ_DEC_ARMTHUMB is not set
> > CONFIG_XZ_DEC_SPARC=y
> > CONFIG_XZ_DEC_BCJ=y
> > # CONFIG_XZ_DEC_TEST is not set
> > CONFIG_DECOMPRESS_GZIP=y
> > CONFIG_DECOMPRESS_BZIP2=y
> > CONFIG_DECOMPRESS_LZMA=y
> > CONFIG_DECOMPRESS_XZ=y
> > CONFIG_DECOMPRESS_LZO=y
> > CONFIG_DECOMPRESS_LZ4=y
> > CONFIG_GENERIC_ALLOCATOR=y
> > CONFIG_REED_SOLOMON=m
> > CONFIG_REED_SOLOMON_ENC8=y
> > CONFIG_REED_SOLOMON_DEC8=y
> > CONFIG_BCH=y
> > CONFIG_BCH_CONST_PARAMS=y
> > CONFIG_TEXTSEARCH=y
> > CONFIG_TEXTSEARCH_KMP=y
> > CONFIG_TEXTSEARCH_BM=y
> > CONFIG_TEXTSEARCH_FSM=y
> > CONFIG_ASSOCIATIVE_ARRAY=y
> > CONFIG_HAS_IOMEM=y
> > CONFIG_HAS_IOPORT_MAP=y
> > CONFIG_HAS_DMA=y
> > CONFIG_NEED_SG_DMA_LENGTH=y
> > CONFIG_NEED_DMA_MAP_STATE=y
> > CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> > CONFIG_SWIOTLB=y
> > # CONFIG_DMA_API_DEBUG is not set
> > CONFIG_SGL_ALLOC=y
> > CONFIG_DQL=y
> > CONFIG_GLOB=y
> > # CONFIG_GLOB_SELFTEST is not set
> > CONFIG_NLATTR=y
> > # CONFIG_IRQ_POLL is not set
> > CONFIG_LIBXBC=y
> > CONFIG_OID_REGISTRY=m
> > CONFIG_UCS2_STRING=y
> > CONFIG_HAVE_GENERIC_VDSO=y
> > CONFIG_GENERIC_GETTIMEOFDAY=y
> > CONFIG_GENERIC_VDSO_TIME_NS=y
> > CONFIG_FONT_SUPPORT=y
> > CONFIG_FONT_8x16=y
> > CONFIG_FONT_AUTOSELECT=y
> > CONFIG_ARCH_HAS_PMEM_API=y
> > CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> > CONFIG_ARCH_STACKWALK=y
> > CONFIG_STACKDEPOT=y
> > CONFIG_SBITMAP=y
> > CONFIG_STRING_SELFTEST=y
> > # end of Library routines
> > 
> > #
> > # Kernel hacking
> > #
> > 
> > #
> > # printk and dmesg options
> > #
> > CONFIG_PRINTK_TIME=y
> > # CONFIG_PRINTK_CALLER is not set
> > CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> > CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> > CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> > # CONFIG_BOOT_PRINTK_DELAY is not set
> > CONFIG_DYNAMIC_DEBUG=y
> > CONFIG_SYMBOLIC_ERRNAME=y
> > CONFIG_DEBUG_BUGVERBOSE=y
> > # end of printk and dmesg options
> > 
> > #
> > # Compile-time checks and compiler options
> > #
> > CONFIG_DEBUG_INFO=y
> > CONFIG_DEBUG_INFO_REDUCED=y
> > # CONFIG_DEBUG_INFO_SPLIT is not set
> > # CONFIG_DEBUG_INFO_DWARF4 is not set
> > # CONFIG_DEBUG_INFO_BTF is not set
> > # CONFIG_GDB_SCRIPTS is not set
> > # CONFIG_ENABLE_MUST_CHECK is not set
> > CONFIG_FRAME_WARN=8192
> > CONFIG_STRIP_ASM_SYMS=y
> > CONFIG_READABLE_ASM=y
> > # CONFIG_HEADERS_INSTALL is not set
> > CONFIG_OPTIMIZE_INLINING=y
> > # CONFIG_DEBUG_SECTION_MISMATCH is not set
> > # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
> > CONFIG_STACK_VALIDATION=y
> > CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> > # end of Compile-time checks and compiler options
> > 
> > #
> > # Generic Kernel Debugging Instruments
> > #
> > CONFIG_MAGIC_SYSRQ=y
> > CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> > # CONFIG_MAGIC_SYSRQ_SERIAL is not set
> > CONFIG_DEBUG_FS=y
> > CONFIG_HAVE_ARCH_KGDB=y
> > # CONFIG_KGDB is not set
> > CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> > CONFIG_UBSAN=y
> > # CONFIG_UBSAN_SANITIZE_ALL is not set
> > CONFIG_UBSAN_NO_ALIGNMENT=y
> > # CONFIG_TEST_UBSAN is not set
> > CONFIG_HAVE_ARCH_KCSAN=y
> > # end of Generic Kernel Debugging Instruments
> > 
> > CONFIG_DEBUG_KERNEL=y
> > CONFIG_DEBUG_MISC=y
> > 
> > #
> > # Memory Debugging
> > #
> > CONFIG_PAGE_EXTENSION=y
> > CONFIG_DEBUG_PAGEALLOC=y
> > # CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
> > # CONFIG_PAGE_OWNER is not set
> > # CONFIG_PAGE_POISONING is not set
> > CONFIG_DEBUG_PAGE_REF=y
> > CONFIG_DEBUG_RODATA_TEST=y
> > CONFIG_GENERIC_PTDUMP=y
> > # CONFIG_PTDUMP_DEBUGFS is not set
> > # CONFIG_DEBUG_OBJECTS is not set
> > # CONFIG_DEBUG_SLAB is not set
> > CONFIG_HAVE_DEBUG_KMEMLEAK=y
> > # CONFIG_DEBUG_KMEMLEAK is not set
> > CONFIG_DEBUG_STACK_USAGE=y
> > CONFIG_SCHED_STACK_END_CHECK=y
> > # CONFIG_DEBUG_VM is not set
> > CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> > CONFIG_DEBUG_VIRTUAL=y
> > CONFIG_DEBUG_MEMORY_INIT=y
> > CONFIG_HAVE_ARCH_KASAN=y
> > CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> > CONFIG_CC_HAS_KASAN_GENERIC=y
> > CONFIG_KASAN=y
> > CONFIG_KASAN_GENERIC=y
> > CONFIG_KASAN_OUTLINE=y
> > # CONFIG_KASAN_INLINE is not set
> > CONFIG_KASAN_STACK=1
> > # CONFIG_KASAN_VMALLOC is not set
> > # CONFIG_TEST_KASAN is not set
> > # end of Memory Debugging
> > 
> > CONFIG_DEBUG_SHIRQ=y
> > 
> > #
> > # Debug Oops, Lockups and Hangs
> > #
> > # CONFIG_PANIC_ON_OOPS is not set
> > CONFIG_PANIC_ON_OOPS_VALUE=0
> > CONFIG_PANIC_TIMEOUT=0
> > CONFIG_LOCKUP_DETECTOR=y
> > CONFIG_SOFTLOCKUP_DETECTOR=y
> > CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> > CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
> > CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> > CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> > CONFIG_HARDLOCKUP_DETECTOR=y
> > CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
> > CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
> > # CONFIG_DETECT_HUNG_TASK is not set
> > # CONFIG_WQ_WATCHDOG is not set
> > # end of Debug Oops, Lockups and Hangs
> > 
> > #
> > # Scheduler Debugging
> > #
> > CONFIG_SCHED_DEBUG=y
> > CONFIG_SCHED_INFO=y
> > CONFIG_SCHEDSTATS=y
> > # end of Scheduler Debugging
> > 
> > # CONFIG_DEBUG_TIMEKEEPING is not set
> > 
> > #
> > # Lock Debugging (spinlocks, mutexes, etc...)
> > #
> > CONFIG_LOCK_DEBUGGING_SUPPORT=y
> > CONFIG_PROVE_LOCKING=y
> > CONFIG_LOCK_STAT=y
> > CONFIG_DEBUG_RT_MUTEXES=y
> > CONFIG_DEBUG_SPINLOCK=y
> > CONFIG_DEBUG_MUTEXES=y
> > CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> > CONFIG_DEBUG_RWSEMS=y
> > CONFIG_DEBUG_LOCK_ALLOC=y
> > CONFIG_LOCKDEP=y
> > # CONFIG_DEBUG_LOCKDEP is not set
> > CONFIG_DEBUG_ATOMIC_SLEEP=y
> > # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> > CONFIG_LOCK_TORTURE_TEST=m
> > CONFIG_WW_MUTEX_SELFTEST=m
> > # end of Lock Debugging (spinlocks, mutexes, etc...)
> > 
> > CONFIG_TRACE_IRQFLAGS=y
> > CONFIG_STACKTRACE=y
> > CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
> > # CONFIG_DEBUG_KOBJECT is not set
> > 
> > #
> > # Debug kernel data structures
> > #
> > CONFIG_DEBUG_LIST=y
> > # CONFIG_DEBUG_PLIST is not set
> > # CONFIG_DEBUG_SG is not set
> > CONFIG_DEBUG_NOTIFIERS=y
> > CONFIG_BUG_ON_DATA_CORRUPTION=y
> > # end of Debug kernel data structures
> > 
> > CONFIG_DEBUG_CREDENTIALS=y
> > 
> > #
> > # RCU Debugging
> > #
> > CONFIG_PROVE_RCU=y
> > CONFIG_PROVE_RCU_LIST=y
> > CONFIG_TORTURE_TEST=m
> > # CONFIG_RCU_PERF_TEST is not set
> > CONFIG_RCU_TORTURE_TEST=m
> > # CONFIG_RCU_TRACE is not set
> > CONFIG_RCU_EQS_DEBUG=y
> > # end of RCU Debugging
> > 
> > # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> > # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> > CONFIG_LATENCYTOP=y
> > CONFIG_USER_STACKTRACE_SUPPORT=y
> > CONFIG_NOP_TRACER=y
> > CONFIG_HAVE_FUNCTION_TRACER=y
> > CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> > CONFIG_HAVE_DYNAMIC_FTRACE=y
> > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> > CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> > CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> > CONFIG_HAVE_FENTRY=y
> > CONFIG_HAVE_C_RECORDMCOUNT=y
> > CONFIG_TRACER_MAX_TRACE=y
> > CONFIG_TRACE_CLOCK=y
> > CONFIG_RING_BUFFER=y
> > CONFIG_EVENT_TRACING=y
> > CONFIG_CONTEXT_SWITCH_TRACER=y
> > CONFIG_RING_BUFFER_ALLOW_SWAP=y
> > CONFIG_PREEMPTIRQ_TRACEPOINTS=y
> > CONFIG_TRACING=y
> > CONFIG_GENERIC_TRACER=y
> > CONFIG_TRACING_SUPPORT=y
> > CONFIG_FTRACE=y
> > CONFIG_BOOTTIME_TRACING=y
> > CONFIG_FUNCTION_TRACER=y
> > # CONFIG_FUNCTION_GRAPH_TRACER is not set
> > # CONFIG_DYNAMIC_FTRACE is not set
> > CONFIG_FUNCTION_PROFILER=y
> > CONFIG_STACK_TRACER=y
> > # CONFIG_PREEMPTIRQ_EVENTS is not set
> > CONFIG_IRQSOFF_TRACER=y
> > # CONFIG_SCHED_TRACER is not set
> > # CONFIG_HWLAT_TRACER is not set
> > # CONFIG_MMIOTRACE is not set
> > CONFIG_FTRACE_SYSCALLS=y
> > CONFIG_TRACER_SNAPSHOT=y
> > CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> > CONFIG_TRACE_BRANCH_PROFILING=y
> > # CONFIG_BRANCH_PROFILE_NONE is not set
> > CONFIG_PROFILE_ANNOTATED_BRANCHES=y
> > # CONFIG_BRANCH_TRACER is not set
> > # CONFIG_BLK_DEV_IO_TRACE is not set
> > # CONFIG_KPROBE_EVENTS is not set
> > # CONFIG_UPROBE_EVENTS is not set
> > CONFIG_DYNAMIC_EVENTS=y
> > CONFIG_TRACING_MAP=y
> > CONFIG_HIST_TRIGGERS=y
> > # CONFIG_TRACE_EVENT_INJECT is not set
> > # CONFIG_TRACEPOINT_BENCHMARK is not set
> > CONFIG_RING_BUFFER_BENCHMARK=y
> > # CONFIG_TRACE_EVAL_MAP_FILE is not set
> > # CONFIG_FTRACE_STARTUP_TEST is not set
> > # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> > # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> > # CONFIG_SYNTH_EVENT_GEN_TEST is not set
> > # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> > # CONFIG_SAMPLES is not set
> > CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> > CONFIG_STRICT_DEVMEM=y
> > # CONFIG_IO_STRICT_DEVMEM is not set
> > 
> > #
> > # x86 Debugging
> > #
> > CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> > CONFIG_X86_VERBOSE_BOOTUP=y
> > CONFIG_EARLY_PRINTK=y
> > # CONFIG_EARLY_PRINTK_DBGP is not set
> > # CONFIG_EARLY_PRINTK_USB_XDBC is not set
> > # CONFIG_EFI_PGT_DUMP is not set
> > # CONFIG_DEBUG_WX is not set
> > CONFIG_DOUBLEFAULT=y
> > CONFIG_DEBUG_TLBFLUSH=y
> > CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> > # CONFIG_X86_DECODER_SELFTEST is not set
> > # CONFIG_IO_DELAY_0X80 is not set
> > CONFIG_IO_DELAY_0XED=y
> > # CONFIG_IO_DELAY_UDELAY is not set
> > # CONFIG_IO_DELAY_NONE is not set
> > CONFIG_DEBUG_BOOT_PARAMS=y
> > # CONFIG_CPA_DEBUG is not set
> > CONFIG_DEBUG_ENTRY=y
> > # CONFIG_DEBUG_NMI_SELFTEST is not set
> > CONFIG_X86_DEBUG_FPU=y
> > # CONFIG_PUNIT_ATOM_DEBUG is not set
> > CONFIG_UNWINDER_ORC=y
> > # CONFIG_UNWINDER_FRAME_POINTER is not set
> > # end of x86 Debugging
> > 
> > #
> > # Kernel Testing and Coverage
> > #
> > # CONFIG_KUNIT is not set
> > CONFIG_NOTIFIER_ERROR_INJECTION=m
> > CONFIG_PM_NOTIFIER_ERROR_INJECT=m
> > # CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
> > CONFIG_FUNCTION_ERROR_INJECTION=y
> > # CONFIG_FAULT_INJECTION is not set
> > CONFIG_ARCH_HAS_KCOV=y
> > CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> > CONFIG_KCOV=y
> > # CONFIG_KCOV_INSTRUMENT_ALL is not set
> > CONFIG_RUNTIME_TESTING_MENU=y
> > # CONFIG_LKDTM is not set
> > # CONFIG_TEST_LIST_SORT is not set
> > # CONFIG_TEST_SORT is not set
> > # CONFIG_KPROBES_SANITY_TEST is not set
> > # CONFIG_BACKTRACE_SELF_TEST is not set
> > # CONFIG_RBTREE_TEST is not set
> > # CONFIG_REED_SOLOMON_TEST is not set
> > # CONFIG_INTERVAL_TREE_TEST is not set
> > # CONFIG_PERCPU_TEST is not set
> > # CONFIG_ATOMIC64_SELFTEST is not set
> > # CONFIG_TEST_HEXDUMP is not set
> > # CONFIG_TEST_STRING_HELPERS is not set
> > CONFIG_TEST_STRSCPY=m
> > # CONFIG_TEST_KSTRTOX is not set
> > CONFIG_TEST_PRINTF=m
> > CONFIG_TEST_BITMAP=m
> > # CONFIG_TEST_BITFIELD is not set
> > # CONFIG_TEST_UUID is not set
> > # CONFIG_TEST_XARRAY is not set
> > # CONFIG_TEST_OVERFLOW is not set
> > # CONFIG_TEST_RHASHTABLE is not set
> > # CONFIG_TEST_HASH is not set
> > # CONFIG_TEST_IDA is not set
> > CONFIG_TEST_LKM=m
> > CONFIG_TEST_VMALLOC=m
> > CONFIG_TEST_USER_COPY=m
> > CONFIG_TEST_BPF=m
> > CONFIG_TEST_BLACKHOLE_DEV=m
> > # CONFIG_FIND_BIT_BENCHMARK is not set
> > CONFIG_TEST_FIRMWARE=y
> > CONFIG_TEST_SYSCTL=m
> > # CONFIG_TEST_UDELAY is not set
> > CONFIG_TEST_STATIC_KEYS=m
> > CONFIG_TEST_KMOD=m
> > # CONFIG_TEST_DEBUG_VIRTUAL is not set
> > # CONFIG_TEST_MEMCAT_P is not set
> > # CONFIG_TEST_STACKINIT is not set
> > # CONFIG_TEST_MEMINIT is not set
> > # CONFIG_MEMTEST is not set
> > # end of Kernel Testing and Coverage
> > # end of Kernel hacking
> 
> > #
> > # Automatically generated file; DO NOT EDIT.
> > # Linux/x86_64 5.6.0-rc1 Kernel Configuration
> > #
> > 
> > #
> > # Compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> > #
> > CONFIG_CC_IS_GCC=y
> > CONFIG_GCC_VERSION=70500
> > CONFIG_CLANG_VERSION=0
> > CONFIG_CC_CAN_LINK=y
> > CONFIG_CC_HAS_ASM_GOTO=y
> > CONFIG_CC_HAS_ASM_INLINE=y
> > CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
> > CONFIG_CONSTRUCTORS=y
> > CONFIG_IRQ_WORK=y
> > CONFIG_BUILDTIME_TABLE_SORT=y
> > CONFIG_THREAD_INFO_IN_TASK=y
> > 
> > #
> > # General setup
> > #
> > CONFIG_BROKEN_ON_SMP=y
> > CONFIG_INIT_ENV_ARG_LIMIT=32
> > # CONFIG_COMPILE_TEST is not set
> > CONFIG_LOCALVERSION=""
> > CONFIG_LOCALVERSION_AUTO=y
> > CONFIG_BUILD_SALT=""
> > CONFIG_HAVE_KERNEL_GZIP=y
> > CONFIG_HAVE_KERNEL_BZIP2=y
> > CONFIG_HAVE_KERNEL_LZMA=y
> > CONFIG_HAVE_KERNEL_XZ=y
> > CONFIG_HAVE_KERNEL_LZO=y
> > CONFIG_HAVE_KERNEL_LZ4=y
> > # CONFIG_KERNEL_GZIP is not set
> > # CONFIG_KERNEL_BZIP2 is not set
> > # CONFIG_KERNEL_LZMA is not set
> > CONFIG_KERNEL_XZ=y
> > # CONFIG_KERNEL_LZO is not set
> > # CONFIG_KERNEL_LZ4 is not set
> > CONFIG_DEFAULT_HOSTNAME="(none)"
> > CONFIG_SWAP=y
> > # CONFIG_SYSVIPC is not set
> > # CONFIG_POSIX_MQUEUE is not set
> > CONFIG_CROSS_MEMORY_ATTACH=y
> > # CONFIG_USELIB is not set
> > # CONFIG_AUDIT is not set
> > CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> > 
> > #
> > # IRQ subsystem
> > #
> > CONFIG_GENERIC_IRQ_PROBE=y
> > CONFIG_GENERIC_IRQ_SHOW=y
> > CONFIG_GENERIC_IRQ_CHIP=y
> > CONFIG_IRQ_DOMAIN=y
> > CONFIG_IRQ_SIM=y
> > CONFIG_IRQ_DOMAIN_HIERARCHY=y
> > CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> > CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> > CONFIG_IRQ_FORCED_THREADING=y
> > CONFIG_SPARSE_IRQ=y
> > # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> > # end of IRQ subsystem
> > 
> > CONFIG_CLOCKSOURCE_WATCHDOG=y
> > CONFIG_ARCH_CLOCKSOURCE_DATA=y
> > CONFIG_ARCH_CLOCKSOURCE_INIT=y
> > CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> > CONFIG_GENERIC_TIME_VSYSCALL=y
> > CONFIG_GENERIC_CLOCKEVENTS=y
> > CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> > CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> > CONFIG_GENERIC_CMOS_UPDATE=y
> > 
> > #
> > # Timers subsystem
> > #
> > CONFIG_TICK_ONESHOT=y
> > CONFIG_HZ_PERIODIC=y
> > # CONFIG_NO_HZ_IDLE is not set
> > CONFIG_NO_HZ=y
> > CONFIG_HIGH_RES_TIMERS=y
> > # end of Timers subsystem
> > 
> > # CONFIG_PREEMPT_NONE is not set
> > CONFIG_PREEMPT_VOLUNTARY=y
> > # CONFIG_PREEMPT is not set
> > CONFIG_PREEMPT_COUNT=y
> > 
> > #
> > # CPU/Task time and stats accounting
> > #
> > CONFIG_TICK_CPU_ACCOUNTING=y
> > # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> > # CONFIG_IRQ_TIME_ACCOUNTING is not set
> > CONFIG_BSD_PROCESS_ACCT=y
> > # CONFIG_BSD_PROCESS_ACCT_V3 is not set
> > # CONFIG_TASKSTATS is not set
> > # CONFIG_PSI is not set
> > # end of CPU/Task time and stats accounting
> > 
> > #
> > # RCU Subsystem
> > #
> > CONFIG_TINY_RCU=y
> > # CONFIG_RCU_EXPERT is not set
> > CONFIG_SRCU=y
> > CONFIG_TINY_SRCU=y
> > CONFIG_TASKS_RCU=y
> > # end of RCU Subsystem
> > 
> > CONFIG_IKCONFIG=y
> > CONFIG_IKCONFIG_PROC=y
> > # CONFIG_IKHEADERS is not set
> > CONFIG_LOG_BUF_SHIFT=20
> > CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> > 
> > #
> > # Scheduler features
> > #
> > # end of Scheduler features
> > 
> > CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> > CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> > CONFIG_CC_HAS_INT128=y
> > CONFIG_ARCH_SUPPORTS_INT128=y
> > CONFIG_CGROUPS=y
> > # CONFIG_MEMCG is not set
> > # CONFIG_BLK_CGROUP is not set
> > CONFIG_CGROUP_SCHED=y
> > CONFIG_FAIR_GROUP_SCHED=y
> > # CONFIG_CFS_BANDWIDTH is not set
> > # CONFIG_RT_GROUP_SCHED is not set
> > # CONFIG_CGROUP_PIDS is not set
> > CONFIG_CGROUP_RDMA=y
> > # CONFIG_CGROUP_FREEZER is not set
> > # CONFIG_CGROUP_HUGETLB is not set
> > CONFIG_CGROUP_DEVICE=y
> > # CONFIG_CGROUP_CPUACCT is not set
> > CONFIG_CGROUP_PERF=y
> > CONFIG_CGROUP_BPF=y
> > # CONFIG_CGROUP_DEBUG is not set
> > CONFIG_SOCK_CGROUP_DATA=y
> > CONFIG_NAMESPACES=y
> > CONFIG_UTS_NS=y
> > CONFIG_TIME_NS=y
> > # CONFIG_USER_NS is not set
> > CONFIG_PID_NS=y
> > # CONFIG_NET_NS is not set
> > CONFIG_CHECKPOINT_RESTORE=y
> > CONFIG_SCHED_AUTOGROUP=y
> > # CONFIG_SYSFS_DEPRECATED is not set
> > # CONFIG_RELAY is not set
> > CONFIG_BLK_DEV_INITRD=y
> > CONFIG_INITRAMFS_SOURCE=""
> > CONFIG_RD_GZIP=y
> > CONFIG_RD_BZIP2=y
> > CONFIG_RD_LZMA=y
> > CONFIG_RD_XZ=y
> > CONFIG_RD_LZO=y
> > CONFIG_RD_LZ4=y
> > CONFIG_BOOT_CONFIG=y
> > CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> > # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> > CONFIG_SYSCTL=y
> > CONFIG_SYSCTL_EXCEPTION_TRACE=y
> > CONFIG_HAVE_PCSPKR_PLATFORM=y
> > CONFIG_BPF=y
> > CONFIG_EXPERT=y
> > CONFIG_MULTIUSER=y
> > # CONFIG_SGETMASK_SYSCALL is not set
> > CONFIG_SYSFS_SYSCALL=y
> > CONFIG_FHANDLE=y
> > CONFIG_POSIX_TIMERS=y
> > CONFIG_PRINTK=y
> > CONFIG_PRINTK_NMI=y
> > CONFIG_BUG=y
> > # CONFIG_ELF_CORE is not set
> > # CONFIG_PCSPKR_PLATFORM is not set
> > CONFIG_BASE_FULL=y
> > CONFIG_FUTEX=y
> > CONFIG_FUTEX_PI=y
> > CONFIG_EPOLL=y
> > CONFIG_SIGNALFD=y
> > CONFIG_TIMERFD=y
> > CONFIG_EVENTFD=y
> > CONFIG_SHMEM=y
> > # CONFIG_AIO is not set
> > CONFIG_IO_URING=y
> > CONFIG_ADVISE_SYSCALLS=y
> > CONFIG_MEMBARRIER=y
> > CONFIG_KALLSYMS=y
> > CONFIG_KALLSYMS_ALL=y
> > CONFIG_KALLSYMS_BASE_RELATIVE=y
> > CONFIG_BPF_SYSCALL=y
> > CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
> > CONFIG_USERFAULTFD=y
> > CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> > CONFIG_RSEQ=y
> > # CONFIG_DEBUG_RSEQ is not set
> > CONFIG_EMBEDDED=y
> > CONFIG_HAVE_PERF_EVENTS=y
> > CONFIG_PERF_USE_VMALLOC=y
> > CONFIG_PC104=y
> > 
> > #
> > # Kernel Performance Events And Counters
> > #
> > CONFIG_PERF_EVENTS=y
> > CONFIG_DEBUG_PERF_USE_VMALLOC=y
> > # end of Kernel Performance Events And Counters
> > 
> > # CONFIG_VM_EVENT_COUNTERS is not set
> > # CONFIG_COMPAT_BRK is not set
> > CONFIG_SLAB=y
> > # CONFIG_SLUB is not set
> > # CONFIG_SLOB is not set
> > # CONFIG_SLAB_MERGE_DEFAULT is not set
> > CONFIG_SLAB_FREELIST_RANDOM=y
> > # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> > # CONFIG_PROFILING is not set
> > CONFIG_TRACEPOINTS=y
> > # end of General setup
> > 
> > CONFIG_64BIT=y
> > CONFIG_X86_64=y
> > CONFIG_X86=y
> > CONFIG_INSTRUCTION_DECODER=y
> > CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> > CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
> > CONFIG_LOCKDEP_SUPPORT=y
> > CONFIG_STACKTRACE_SUPPORT=y
> > CONFIG_MMU=y
> > CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> > CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> > CONFIG_GENERIC_BUG=y
> > CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> > CONFIG_GENERIC_CALIBRATE_DELAY=y
> > CONFIG_ARCH_HAS_CPU_RELAX=y
> > CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> > CONFIG_ARCH_HAS_FILTER_PGPROT=y
> > CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> > CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> > CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> > CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> > CONFIG_ARCH_SUSPEND_POSSIBLE=y
> > CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> > CONFIG_ZONE_DMA32=y
> > CONFIG_AUDIT_ARCH=y
> > CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> > CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
> > CONFIG_ARCH_SUPPORTS_UPROBES=y
> > CONFIG_FIX_EARLYCON_MEM=y
> > CONFIG_PGTABLE_LEVELS=4
> > CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> > 
> > #
> > # Processor type and features
> > #
> > # CONFIG_ZONE_DMA is not set
> > # CONFIG_SMP is not set
> > CONFIG_X86_FEATURE_NAMES=y
> > # CONFIG_X86_X2APIC is not set
> > CONFIG_X86_MPPARSE=y
> > CONFIG_GOLDFISH=y
> > CONFIG_RETPOLINE=y
> > CONFIG_X86_CPU_RESCTRL=y
> > # CONFIG_X86_EXTENDED_PLATFORM is not set
> > # CONFIG_X86_INTEL_LPSS is not set
> > # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> > CONFIG_IOSF_MBI=m
> > # CONFIG_IOSF_MBI_DEBUG is not set
> > # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> > CONFIG_HYPERVISOR_GUEST=y
> > CONFIG_PARAVIRT=y
> > # CONFIG_PARAVIRT_DEBUG is not set
> > # CONFIG_XEN is not set
> > CONFIG_KVM_GUEST=y
> > CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> > # CONFIG_PVH is not set
> > # CONFIG_KVM_DEBUG_FS is not set
> > # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> > CONFIG_PARAVIRT_CLOCK=y
> > # CONFIG_JAILHOUSE_GUEST is not set
> > # CONFIG_ACRN_GUEST is not set
> > # CONFIG_MK8 is not set
> > # CONFIG_MPSC is not set
> > # CONFIG_MCORE2 is not set
> > # CONFIG_MATOM is not set
> > CONFIG_GENERIC_CPU=y
> > CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> > CONFIG_X86_L1_CACHE_SHIFT=6
> > CONFIG_X86_TSC=y
> > CONFIG_X86_CMPXCHG64=y
> > CONFIG_X86_CMOV=y
> > CONFIG_X86_MINIMUM_CPU_FAMILY=64
> > CONFIG_X86_DEBUGCTLMSR=y
> > CONFIG_IA32_FEAT_CTL=y
> > CONFIG_X86_VMX_FEATURE_NAMES=y
> > # CONFIG_PROCESSOR_SELECT is not set
> > CONFIG_CPU_SUP_INTEL=y
> > CONFIG_CPU_SUP_AMD=y
> > CONFIG_CPU_SUP_HYGON=y
> > CONFIG_CPU_SUP_CENTAUR=y
> > CONFIG_CPU_SUP_ZHAOXIN=y
> > CONFIG_HPET_TIMER=y
> > CONFIG_DMI=y
> > # CONFIG_GART_IOMMU is not set
> > CONFIG_NR_CPUS_RANGE_BEGIN=1
> > CONFIG_NR_CPUS_RANGE_END=1
> > CONFIG_NR_CPUS_DEFAULT=1
> > CONFIG_NR_CPUS=1
> > CONFIG_UP_LATE_INIT=y
> > CONFIG_X86_LOCAL_APIC=y
> > CONFIG_X86_IO_APIC=y
> > CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> > # CONFIG_X86_MCE is not set
> > 
> > #
> > # Performance monitoring
> > #
> > CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> > CONFIG_PERF_EVENTS_INTEL_RAPL=y
> > CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> > CONFIG_PERF_EVENTS_AMD_POWER=y
> > # end of Performance monitoring
> > 
> > CONFIG_X86_VSYSCALL_EMULATION=y
> > CONFIG_X86_IOPL_IOPERM=y
> > # CONFIG_I8K is not set
> > CONFIG_MICROCODE=y
> > # CONFIG_MICROCODE_INTEL is not set
> > # CONFIG_MICROCODE_AMD is not set
> > CONFIG_MICROCODE_OLD_INTERFACE=y
> > # CONFIG_X86_MSR is not set
> > CONFIG_X86_CPUID=m
> > # CONFIG_X86_5LEVEL is not set
> > CONFIG_X86_DIRECT_GBPAGES=y
> > # CONFIG_X86_CPA_STATISTICS is not set
> > # CONFIG_AMD_MEM_ENCRYPT is not set
> > CONFIG_ARCH_SPARSEMEM_ENABLE=y
> > CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> > CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> > CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> > # CONFIG_X86_PMEM_LEGACY is not set
> > # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
> > CONFIG_X86_RESERVE_LOW=64
> > # CONFIG_MTRR is not set
> > # CONFIG_ARCH_RANDOM is not set
> > CONFIG_X86_SMAP=y
> > CONFIG_X86_UMIP=y
> > CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
> > CONFIG_X86_INTEL_TSX_MODE_OFF=y
> > # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> > # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> > CONFIG_EFI=y
> > # CONFIG_EFI_STUB is not set
> > # CONFIG_SECCOMP is not set
> > # CONFIG_HZ_100 is not set
> > # CONFIG_HZ_250 is not set
> > # CONFIG_HZ_300 is not set
> > CONFIG_HZ_1000=y
> > CONFIG_HZ=1000
> > CONFIG_SCHED_HRTICK=y
> > # CONFIG_KEXEC is not set
> > # CONFIG_KEXEC_FILE is not set
> > CONFIG_CRASH_DUMP=y
> > CONFIG_PHYSICAL_START=0x1000000
> > CONFIG_RELOCATABLE=y
> > CONFIG_RANDOMIZE_BASE=y
> > CONFIG_X86_NEED_RELOCS=y
> > CONFIG_PHYSICAL_ALIGN=0x200000
> > CONFIG_DYNAMIC_MEMORY_LAYOUT=y
> > CONFIG_RANDOMIZE_MEMORY=y
> > CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
> > CONFIG_LEGACY_VSYSCALL_EMULATE=y
> > # CONFIG_LEGACY_VSYSCALL_XONLY is not set
> > # CONFIG_LEGACY_VSYSCALL_NONE is not set
> > # CONFIG_CMDLINE_BOOL is not set
> > # CONFIG_MODIFY_LDT_SYSCALL is not set
> > CONFIG_HAVE_LIVEPATCH=y
> > # end of Processor type and features
> > 
> > CONFIG_ARCH_HAS_ADD_PAGES=y
> > CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> > CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> > 
> > #
> > # Power management and ACPI options
> > #
> > # CONFIG_SUSPEND is not set
> > # CONFIG_HIBERNATION is not set
> > CONFIG_PM=y
> > CONFIG_PM_DEBUG=y
> > CONFIG_PM_ADVANCED_DEBUG=y
> > # CONFIG_DPM_WATCHDOG is not set
> > CONFIG_PM_CLK=y
> > # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> > CONFIG_ARCH_SUPPORTS_ACPI=y
> > CONFIG_ACPI=y
> > CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> > CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> > CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> > # CONFIG_ACPI_DEBUGGER is not set
> > CONFIG_ACPI_SPCR_TABLE=y
> > CONFIG_ACPI_LPIT=y
> > # CONFIG_ACPI_PROCFS_POWER is not set
> > CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> > # CONFIG_ACPI_EC_DEBUGFS is not set
> > CONFIG_ACPI_AC=y
> > CONFIG_ACPI_BATTERY=y
> > CONFIG_ACPI_BUTTON=y
> > # CONFIG_ACPI_VIDEO is not set
> > CONFIG_ACPI_FAN=y
> > # CONFIG_ACPI_DOCK is not set
> > CONFIG_ACPI_CPU_FREQ_PSS=y
> > CONFIG_ACPI_PROCESSOR_CSTATE=y
> > CONFIG_ACPI_PROCESSOR_IDLE=y
> > CONFIG_ACPI_PROCESSOR=y
> > # CONFIG_ACPI_IPMI is not set
> > # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
> > CONFIG_ACPI_THERMAL=y
> > CONFIG_ACPI_CUSTOM_DSDT_FILE=""
> > CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> > CONFIG_ACPI_TABLE_UPGRADE=y
> > # CONFIG_ACPI_DEBUG is not set
> > # CONFIG_ACPI_PCI_SLOT is not set
> > # CONFIG_ACPI_CONTAINER is not set
> > CONFIG_ACPI_HOTPLUG_IOAPIC=y
> > # CONFIG_ACPI_SBS is not set
> > # CONFIG_ACPI_HED is not set
> > # CONFIG_ACPI_CUSTOM_METHOD is not set
> > # CONFIG_ACPI_BGRT is not set
> > # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> > # CONFIG_ACPI_NFIT is not set
> > CONFIG_HAVE_ACPI_APEI=y
> > CONFIG_HAVE_ACPI_APEI_NMI=y
> > # CONFIG_ACPI_APEI is not set
> > # CONFIG_DPTF_POWER is not set
> > # CONFIG_PMIC_OPREGION is not set
> > # CONFIG_ACPI_CONFIGFS is not set
> > CONFIG_X86_PM_TIMER=y
> > # CONFIG_SFI is not set
> > 
> > #
> > # CPU Frequency scaling
> > #
> > CONFIG_CPU_FREQ=y
> > CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> > CONFIG_CPU_FREQ_GOV_COMMON=y
> > CONFIG_CPU_FREQ_STAT=y
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> > CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
> > CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> > CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> > # CONFIG_CPU_FREQ_GOV_USERSPACE is not set
> > # CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
> > CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> > 
> > #
> > # CPU frequency scaling drivers
> > #
> > # CONFIG_X86_INTEL_PSTATE is not set
> > # CONFIG_X86_PCC_CPUFREQ is not set
> > # CONFIG_X86_ACPI_CPUFREQ is not set
> > # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> > # CONFIG_X86_P4_CLOCKMOD is not set
> > 
> > #
> > # shared options
> > #
> > # end of CPU Frequency scaling
> > 
> > #
> > # CPU Idle
> > #
> > CONFIG_CPU_IDLE=y
> > # CONFIG_CPU_IDLE_GOV_LADDER is not set
> > CONFIG_CPU_IDLE_GOV_MENU=y
> > # CONFIG_CPU_IDLE_GOV_TEO is not set
> > # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> > CONFIG_HALTPOLL_CPUIDLE=y
> > # end of CPU Idle
> > 
> > # CONFIG_INTEL_IDLE is not set
> > # end of Power management and ACPI options
> > 
> > #
> > # Bus options (PCI etc.)
> > #
> > CONFIG_PCI_DIRECT=y
> > # CONFIG_PCI_MMCONFIG is not set
> > # CONFIG_PCI_CNB20LE_QUIRK is not set
> > CONFIG_ISA_BUS=y
> > # CONFIG_ISA_DMA_API is not set
> > CONFIG_AMD_NB=y
> > # CONFIG_X86_SYSFB is not set
> > # end of Bus options (PCI etc.)
> > 
> > #
> > # Binary Emulations
> > #
> > # CONFIG_IA32_EMULATION is not set
> > # CONFIG_X86_X32 is not set
> > # end of Binary Emulations
> > 
> > #
> > # Firmware Drivers
> > #
> > CONFIG_EDD=m
> > CONFIG_EDD_OFF=y
> > CONFIG_FIRMWARE_MEMMAP=y
> > CONFIG_DMIID=y
> > # CONFIG_DMI_SYSFS is not set
> > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> > CONFIG_FW_CFG_SYSFS=m
> > CONFIG_FW_CFG_SYSFS_CMDLINE=y
> > # CONFIG_GOOGLE_FIRMWARE is not set
> > 
> > #
> > # EFI (Extensible Firmware Interface) Support
> > #
> > # CONFIG_EFI_VARS is not set
> > CONFIG_EFI_ESRT=y
> > # CONFIG_EFI_FAKE_MEMMAP is not set
> > CONFIG_EFI_RUNTIME_WRAPPERS=y
> > # CONFIG_EFI_CAPSULE_LOADER is not set
> > # CONFIG_EFI_TEST is not set
> > # CONFIG_EFI_RCI2_TABLE is not set
> > # CONFIG_EFI_DISABLE_PCI_DMA is not set
> > # end of EFI (Extensible Firmware Interface) Support
> > 
> > CONFIG_EFI_EARLYCON=y
> > 
> > #
> > # Tegra firmware driver
> > #
> > # end of Tegra firmware driver
> > # end of Firmware Drivers
> > 
> > CONFIG_HAVE_KVM=y
> > # CONFIG_VIRTUALIZATION is not set
> > 
> > #
> > # General architecture-dependent options
> > #
> > CONFIG_HAVE_OPROFILE=y
> > CONFIG_OPROFILE_NMI_TIMER=y
> > CONFIG_KPROBES=y
> > # CONFIG_JUMP_LABEL is not set
> > CONFIG_OPTPROBES=y
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> > CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> > CONFIG_KRETPROBES=y
> > CONFIG_HAVE_IOREMAP_PROT=y
> > CONFIG_HAVE_KPROBES=y
> > CONFIG_HAVE_KRETPROBES=y
> > CONFIG_HAVE_OPTPROBES=y
> > CONFIG_HAVE_KPROBES_ON_FTRACE=y
> > CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> > CONFIG_HAVE_NMI=y
> > CONFIG_HAVE_ARCH_TRACEHOOK=y
> > CONFIG_HAVE_DMA_CONTIGUOUS=y
> > CONFIG_GENERIC_SMP_IDLE_THREAD=y
> > CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> > CONFIG_ARCH_HAS_SET_MEMORY=y
> > CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> > CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> > CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> > CONFIG_HAVE_ASM_MODVERSIONS=y
> > CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> > CONFIG_HAVE_RSEQ=y
> > CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> > CONFIG_HAVE_CLK=y
> > CONFIG_HAVE_HW_BREAKPOINT=y
> > CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> > CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> > CONFIG_HAVE_PERF_EVENTS_NMI=y
> > CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> > CONFIG_HAVE_PERF_REGS=y
> > CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> > CONFIG_HAVE_ARCH_JUMP_LABEL=y
> > CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> > CONFIG_MMU_GATHER_TABLE_FREE=y
> > CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> > CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> > CONFIG_HAVE_CMPXCHG_LOCAL=y
> > CONFIG_HAVE_CMPXCHG_DOUBLE=y
> > CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> > CONFIG_HAVE_ARCH_STACKLEAK=y
> > CONFIG_HAVE_STACKPROTECTOR=y
> > CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> > CONFIG_STACKPROTECTOR=y
> > CONFIG_STACKPROTECTOR_STRONG=y
> > CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> > CONFIG_HAVE_CONTEXT_TRACKING=y
> > CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> > CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> > CONFIG_HAVE_MOVE_PMD=y
> > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> > CONFIG_HAVE_ARCH_HUGE_VMAP=y
> > CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> > CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> > CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> > CONFIG_MODULES_USE_ELF_RELA=y
> > CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> > CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> > CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> > CONFIG_HAVE_EXIT_THREAD=y
> > CONFIG_ARCH_MMAP_RND_BITS=28
> > CONFIG_HAVE_COPY_THREAD_TLS=y
> > CONFIG_HAVE_STACK_VALIDATION=y
> > CONFIG_HAVE_RELIABLE_STACKTRACE=y
> > CONFIG_ISA_BUS_API=y
> > # CONFIG_COMPAT_32BIT_TIME is not set
> > CONFIG_HAVE_ARCH_VMAP_STACK=y
> > CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> > CONFIG_STRICT_KERNEL_RWX=y
> > CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> > CONFIG_STRICT_MODULE_RWX=y
> > CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> > CONFIG_ARCH_USE_MEMREMAP_PROT=y
> > # CONFIG_LOCK_EVENT_COUNTS is not set
> > CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> > 
> > #
> > # GCOV-based kernel profiling
> > #
> > # CONFIG_GCOV_KERNEL is not set
> > CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> > # end of GCOV-based kernel profiling
> > 
> > CONFIG_PLUGIN_HOSTCC="g++"
> > CONFIG_HAVE_GCC_PLUGINS=y
> > CONFIG_GCC_PLUGINS=y
> > # CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
> > # CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
> > # CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
> > # end of General architecture-dependent options
> > 
> > CONFIG_RT_MUTEXES=y
> > CONFIG_BASE_SMALL=0
> > CONFIG_MODULES=y
> > CONFIG_MODULE_FORCE_LOAD=y
> > CONFIG_MODULE_UNLOAD=y
> > # CONFIG_MODULE_FORCE_UNLOAD is not set
> > # CONFIG_MODVERSIONS is not set
> > # CONFIG_MODULE_SRCVERSION_ALL is not set
> > # CONFIG_MODULE_SIG is not set
> > # CONFIG_MODULE_COMPRESS is not set
> > # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> > # CONFIG_UNUSED_SYMBOLS is not set
> > CONFIG_TRIM_UNUSED_KSYMS=y
> > CONFIG_MODULES_TREE_LOOKUP=y
> > CONFIG_BLOCK=y
> > CONFIG_BLK_SCSI_REQUEST=y
> > CONFIG_BLK_DEV_BSG=y
> > # CONFIG_BLK_DEV_BSGLIB is not set
> > # CONFIG_BLK_DEV_INTEGRITY is not set
> > # CONFIG_BLK_DEV_ZONED is not set
> > # CONFIG_BLK_CMDLINE_PARSER is not set
> > # CONFIG_BLK_WBT is not set
> > CONFIG_BLK_DEBUG_FS=y
> > # CONFIG_BLK_SED_OPAL is not set
> > 
> > #
> > # Partition Types
> > #
> > # CONFIG_PARTITION_ADVANCED is not set
> > CONFIG_MSDOS_PARTITION=y
> > CONFIG_EFI_PARTITION=y
> > # end of Partition Types
> > 
> > CONFIG_BLK_MQ_PCI=y
> > CONFIG_BLK_MQ_VIRTIO=y
> > CONFIG_BLK_PM=y
> > 
> > #
> > # IO Schedulers
> > #
> > CONFIG_MQ_IOSCHED_DEADLINE=y
> > CONFIG_MQ_IOSCHED_KYBER=y
> > # CONFIG_IOSCHED_BFQ is not set
> > # end of IO Schedulers
> > 
> > CONFIG_UNINLINE_SPIN_UNLOCK=y
> > CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> > CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> > CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> > CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> > CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> > 
> > #
> > # Executable file formats
> > #
> > CONFIG_BINFMT_ELF=y
> > CONFIG_ELFCORE=y
> > CONFIG_BINFMT_SCRIPT=y
> > CONFIG_BINFMT_MISC=y
> > CONFIG_COREDUMP=y
> > # end of Executable file formats
> > 
> > #
> > # Memory Management options
> > #
> > CONFIG_SELECT_MEMORY_MODEL=y
> > CONFIG_SPARSEMEM_MANUAL=y
> > CONFIG_SPARSEMEM=y
> > CONFIG_HAVE_MEMORY_PRESENT=y
> > CONFIG_SPARSEMEM_EXTREME=y
> > CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> > # CONFIG_SPARSEMEM_VMEMMAP is not set
> > CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
> > CONFIG_HAVE_FAST_GUP=y
> > # CONFIG_MEMORY_HOTPLUG is not set
> > CONFIG_SPLIT_PTLOCK_CPUS=4
> > CONFIG_MEMORY_BALLOON=y
> > # CONFIG_COMPACTION is not set
> > CONFIG_PHYS_ADDR_T_64BIT=y
> > CONFIG_VIRT_TO_BUS=y
> > CONFIG_KSM=y
> > CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> > # CONFIG_TRANSPARENT_HUGEPAGE is not set
> > CONFIG_ARCH_WANTS_THP_SWAP=y
> > CONFIG_NEED_PER_CPU_KM=y
> > CONFIG_CLEANCACHE=y
> > # CONFIG_FRONTSWAP is not set
> > # CONFIG_CMA is not set
> > CONFIG_MEM_SOFT_DIRTY=y
> > CONFIG_ZPOOL=y
> > CONFIG_ZBUD=y
> > # CONFIG_Z3FOLD is not set
> > CONFIG_ZSMALLOC=m
> > CONFIG_PGTABLE_MAPPING=y
> > CONFIG_ZSMALLOC_STAT=y
> > CONFIG_GENERIC_EARLY_IOREMAP=y
> > CONFIG_IDLE_PAGE_TRACKING=y
> > CONFIG_ARCH_HAS_PTE_DEVMAP=y
> > CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
> > CONFIG_ARCH_HAS_PKEYS=y
> > CONFIG_PERCPU_STATS=y
> > # CONFIG_GUP_BENCHMARK is not set
> > CONFIG_ARCH_HAS_PTE_SPECIAL=y
> > # end of Memory Management options
> > 
> > CONFIG_NET=y
> > CONFIG_SKB_EXTENSIONS=y
> > 
> > #
> > # Networking options
> > #
> > CONFIG_PACKET=m
> > CONFIG_PACKET_DIAG=m
> > CONFIG_UNIX=y
> > CONFIG_UNIX_SCM=y
> > CONFIG_UNIX_DIAG=m
> > CONFIG_TLS=m
> > # CONFIG_TLS_DEVICE is not set
> > # CONFIG_TLS_TOE is not set
> > CONFIG_XFRM=y
> > CONFIG_XFRM_OFFLOAD=y
> > CONFIG_XFRM_ALGO=y
> > CONFIG_XFRM_USER=y
> > # CONFIG_XFRM_INTERFACE is not set
> > # CONFIG_XFRM_SUB_POLICY is not set
> > CONFIG_XFRM_MIGRATE=y
> > CONFIG_XFRM_STATISTICS=y
> > CONFIG_XFRM_IPCOMP=m
> > CONFIG_NET_KEY=y
> > CONFIG_NET_KEY_MIGRATE=y
> > # CONFIG_XDP_SOCKETS is not set
> > CONFIG_INET=y
> > # CONFIG_IP_MULTICAST is not set
> > CONFIG_IP_ADVANCED_ROUTER=y
> > # CONFIG_IP_FIB_TRIE_STATS is not set
> > CONFIG_IP_MULTIPLE_TABLES=y
> > # CONFIG_IP_ROUTE_MULTIPATH is not set
> > # CONFIG_IP_ROUTE_VERBOSE is not set
> > CONFIG_IP_ROUTE_CLASSID=y
> > CONFIG_IP_PNP=y
> > CONFIG_IP_PNP_DHCP=y
> > # CONFIG_IP_PNP_BOOTP is not set
> > # CONFIG_IP_PNP_RARP is not set
> > CONFIG_NET_IPIP=y
> > # CONFIG_NET_IPGRE_DEMUX is not set
> > CONFIG_NET_IP_TUNNEL=y
> > CONFIG_IP_MROUTE_COMMON=y
> > # CONFIG_SYN_COOKIES is not set
> > CONFIG_NET_IPVTI=m
> > CONFIG_NET_UDP_TUNNEL=y
> > CONFIG_NET_FOU=y
> > CONFIG_NET_FOU_IP_TUNNELS=y
> > # CONFIG_INET_AH is not set
> > # CONFIG_INET_ESP is not set
> > CONFIG_INET_IPCOMP=m
> > CONFIG_INET_XFRM_TUNNEL=m
> > CONFIG_INET_TUNNEL=y
> > # CONFIG_INET_DIAG is not set
> > # CONFIG_TCP_CONG_ADVANCED is not set
> > CONFIG_TCP_CONG_CUBIC=y
> > CONFIG_DEFAULT_TCP_CONG="cubic"
> > # CONFIG_TCP_MD5SIG is not set
> > CONFIG_IPV6=y
> > CONFIG_IPV6_ROUTER_PREF=y
> > # CONFIG_IPV6_ROUTE_INFO is not set
> > CONFIG_IPV6_OPTIMISTIC_DAD=y
> > CONFIG_INET6_AH=m
> > CONFIG_INET6_ESP=m
> > CONFIG_INET6_ESP_OFFLOAD=m
> > CONFIG_INET6_IPCOMP=m
> > CONFIG_IPV6_MIP6=m
> > # CONFIG_IPV6_ILA is not set
> > CONFIG_INET6_XFRM_TUNNEL=m
> > CONFIG_INET6_TUNNEL=y
> > CONFIG_IPV6_VTI=m
> > # CONFIG_IPV6_SIT is not set
> > CONFIG_IPV6_TUNNEL=y
> > CONFIG_IPV6_FOU=y
> > CONFIG_IPV6_FOU_TUNNEL=y
> > CONFIG_IPV6_MULTIPLE_TABLES=y
> > CONFIG_IPV6_SUBTREES=y
> > CONFIG_IPV6_MROUTE=y
> > CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
> > CONFIG_IPV6_PIMSM_V2=y
> > CONFIG_IPV6_SEG6_LWTUNNEL=y
> > CONFIG_IPV6_SEG6_HMAC=y
> > CONFIG_IPV6_SEG6_BPF=y
> > CONFIG_MPTCP=y
> > CONFIG_MPTCP_IPV6=y
> > # CONFIG_MPTCP_HMAC_TEST is not set
> > # CONFIG_NETWORK_SECMARK is not set
> > CONFIG_NET_PTP_CLASSIFY=y
> > CONFIG_NETWORK_PHY_TIMESTAMPING=y
> > CONFIG_NETFILTER=y
> > # CONFIG_NETFILTER_ADVANCED is not set
> > 
> > #
> > # Core Netfilter Configuration
> > #
> > # CONFIG_NETFILTER_INGRESS is not set
> > CONFIG_NETFILTER_NETLINK=y
> > CONFIG_NETFILTER_FAMILY_ARP=y
> > CONFIG_NETFILTER_NETLINK_LOG=m
> > # CONFIG_NF_CONNTRACK is not set
> > CONFIG_NF_LOG_COMMON=y
> > CONFIG_NF_LOG_NETDEV=m
> > CONFIG_NF_TABLES=y
> > # CONFIG_NF_TABLES_SET is not set
> > # CONFIG_NF_TABLES_INET is not set
> > # CONFIG_NF_TABLES_NETDEV is not set
> > CONFIG_NFT_NUMGEN=y
> > CONFIG_NFT_COUNTER=y
> > # CONFIG_NFT_LOG is not set
> > CONFIG_NFT_LIMIT=m
> > # CONFIG_NFT_TUNNEL is not set
> > # CONFIG_NFT_OBJREF is not set
> > # CONFIG_NFT_QUOTA is not set
> > CONFIG_NFT_REJECT=m
> > # CONFIG_NFT_COMPAT is not set
> > CONFIG_NFT_HASH=m
> > # CONFIG_NFT_XFRM is not set
> > # CONFIG_NFT_SOCKET is not set
> > # CONFIG_NFT_TPROXY is not set
> > CONFIG_NETFILTER_XTABLES=m
> > 
> > #
> > # Xtables combined modules
> > #
> > CONFIG_NETFILTER_XT_MARK=m
> > 
> > #
> > # Xtables targets
> > #
> > CONFIG_NETFILTER_XT_TARGET_LOG=m
> > CONFIG_NETFILTER_XT_TARGET_NFLOG=m
> > # CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
> > 
> > #
> > # Xtables matches
> > #
> > CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
> > CONFIG_NETFILTER_XT_MATCH_POLICY=m
> > # end of Core Netfilter Configuration
> > 
> > CONFIG_IP_SET=y
> > CONFIG_IP_SET_MAX=256
> > CONFIG_IP_SET_BITMAP_IP=m
> > CONFIG_IP_SET_BITMAP_IPMAC=m
> > CONFIG_IP_SET_BITMAP_PORT=y
> > CONFIG_IP_SET_HASH_IP=m
> > CONFIG_IP_SET_HASH_IPMARK=m
> > CONFIG_IP_SET_HASH_IPPORT=m
> > # CONFIG_IP_SET_HASH_IPPORTIP is not set
> > CONFIG_IP_SET_HASH_IPPORTNET=m
> > CONFIG_IP_SET_HASH_IPMAC=y
> > CONFIG_IP_SET_HASH_MAC=y
> > CONFIG_IP_SET_HASH_NETPORTNET=y
> > CONFIG_IP_SET_HASH_NET=m
> > CONFIG_IP_SET_HASH_NETNET=y
> > CONFIG_IP_SET_HASH_NETPORT=y
> > # CONFIG_IP_SET_HASH_NETIFACE is not set
> > CONFIG_IP_SET_LIST_SET=y
> > # CONFIG_IP_VS is not set
> > 
> > #
> > # IP: Netfilter Configuration
> > #
> > CONFIG_NF_SOCKET_IPV4=y
> > # CONFIG_NF_TPROXY_IPV4 is not set
> > CONFIG_NF_TABLES_IPV4=y
> > CONFIG_NFT_REJECT_IPV4=m
> > CONFIG_NFT_DUP_IPV4=m
> > # CONFIG_NFT_FIB_IPV4 is not set
> > CONFIG_NF_TABLES_ARP=y
> > CONFIG_NF_DUP_IPV4=m
> > CONFIG_NF_LOG_ARP=y
> > CONFIG_NF_LOG_IPV4=m
> > CONFIG_NF_REJECT_IPV4=m
> > CONFIG_IP_NF_IPTABLES=m
> > CONFIG_IP_NF_FILTER=m
> > CONFIG_IP_NF_TARGET_REJECT=m
> > CONFIG_IP_NF_MANGLE=m
> > # CONFIG_IP_NF_RAW is not set
> > # end of IP: Netfilter Configuration
> > 
> > #
> > # IPv6: Netfilter Configuration
> > #
> > CONFIG_NF_SOCKET_IPV6=m
> > # CONFIG_NF_TPROXY_IPV6 is not set
> > # CONFIG_NF_TABLES_IPV6 is not set
> > CONFIG_NF_DUP_IPV6=m
> > CONFIG_NF_REJECT_IPV6=m
> > CONFIG_NF_LOG_IPV6=m
> > CONFIG_IP6_NF_IPTABLES=m
> > # CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
> > # CONFIG_IP6_NF_FILTER is not set
> > # CONFIG_IP6_NF_MANGLE is not set
> > # CONFIG_IP6_NF_RAW is not set
> > # end of IPv6: Netfilter Configuration
> > 
> > # CONFIG_BPFILTER is not set
> > CONFIG_IP_DCCP=y
> > 
> > #
> > # DCCP CCIDs Configuration
> > #
> > CONFIG_IP_DCCP_CCID2_DEBUG=y
> > CONFIG_IP_DCCP_CCID3=y
> > CONFIG_IP_DCCP_CCID3_DEBUG=y
> > CONFIG_IP_DCCP_TFRC_LIB=y
> > CONFIG_IP_DCCP_TFRC_DEBUG=y
> > # end of DCCP CCIDs Configuration
> > 
> > #
> > # DCCP Kernel Hacking
> > #
> > # CONFIG_IP_DCCP_DEBUG is not set
> > # end of DCCP Kernel Hacking
> > 
> > CONFIG_IP_SCTP=m
> > # CONFIG_SCTP_DBG_OBJCNT is not set
> > # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
> > # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
> > CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE=y
> > # CONFIG_SCTP_COOKIE_HMAC_MD5 is not set
> > # CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
> > # CONFIG_RDS is not set
> > CONFIG_TIPC=y
> > # CONFIG_TIPC_MEDIA_UDP is not set
> > CONFIG_TIPC_CRYPTO=y
> > CONFIG_TIPC_DIAG=y
> > CONFIG_ATM=y
> > CONFIG_ATM_CLIP=y
> > # CONFIG_ATM_CLIP_NO_ICMP is not set
> > CONFIG_ATM_LANE=m
> > # CONFIG_ATM_MPOA is not set
> > CONFIG_ATM_BR2684=y
> > # CONFIG_ATM_BR2684_IPFILTER is not set
> > # CONFIG_L2TP is not set
> > CONFIG_STP=m
> > CONFIG_GARP=m
> > # CONFIG_BRIDGE is not set
> > CONFIG_HAVE_NET_DSA=y
> > # CONFIG_NET_DSA is not set
> > CONFIG_VLAN_8021Q=m
> > CONFIG_VLAN_8021Q_GVRP=y
> > # CONFIG_VLAN_8021Q_MVRP is not set
> > CONFIG_DECNET=y
> > # CONFIG_DECNET_ROUTER is not set
> > CONFIG_LLC=y
> > CONFIG_LLC2=y
> > # CONFIG_ATALK is not set
> > CONFIG_X25=m
> > CONFIG_LAPB=m
> > CONFIG_PHONET=y
> > CONFIG_6LOWPAN=m
> > CONFIG_6LOWPAN_DEBUGFS=y
> > # CONFIG_6LOWPAN_NHC is not set
> > CONFIG_IEEE802154=m
> > CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
> > CONFIG_IEEE802154_SOCKET=m
> > # CONFIG_IEEE802154_6LOWPAN is not set
> > # CONFIG_MAC802154 is not set
> > CONFIG_NET_SCHED=y
> > 
> > #
> > # Queueing/Scheduling
> > #
> > # CONFIG_NET_SCH_CBQ is not set
> > CONFIG_NET_SCH_HTB=m
> > CONFIG_NET_SCH_HFSC=m
> > CONFIG_NET_SCH_ATM=y
> > # CONFIG_NET_SCH_PRIO is not set
> > # CONFIG_NET_SCH_MULTIQ is not set
> > # CONFIG_NET_SCH_RED is not set
> > CONFIG_NET_SCH_SFB=y
> > # CONFIG_NET_SCH_SFQ is not set
> > # CONFIG_NET_SCH_TEQL is not set
> > CONFIG_NET_SCH_TBF=m
> > # CONFIG_NET_SCH_CBS is not set
> > # CONFIG_NET_SCH_ETF is not set
> > # CONFIG_NET_SCH_TAPRIO is not set
> > CONFIG_NET_SCH_GRED=y
> > CONFIG_NET_SCH_DSMARK=m
> > CONFIG_NET_SCH_NETEM=m
> > CONFIG_NET_SCH_DRR=y
> > CONFIG_NET_SCH_MQPRIO=y
> > # CONFIG_NET_SCH_SKBPRIO is not set
> > CONFIG_NET_SCH_CHOKE=m
> > CONFIG_NET_SCH_QFQ=m
> > CONFIG_NET_SCH_CODEL=m
> > # CONFIG_NET_SCH_FQ_CODEL is not set
> > # CONFIG_NET_SCH_CAKE is not set
> > CONFIG_NET_SCH_FQ=m
> > CONFIG_NET_SCH_HHF=y
> > CONFIG_NET_SCH_PIE=m
> > # CONFIG_NET_SCH_FQ_PIE is not set
> > # CONFIG_NET_SCH_INGRESS is not set
> > # CONFIG_NET_SCH_PLUG is not set
> > # CONFIG_NET_SCH_ETS is not set
> > CONFIG_NET_SCH_DEFAULT=y
> > # CONFIG_DEFAULT_FQ is not set
> > # CONFIG_DEFAULT_CODEL is not set
> > CONFIG_DEFAULT_PFIFO_FAST=y
> > CONFIG_DEFAULT_NET_SCH="pfifo_fast"
> > 
> > #
> > # Classification
> > #
> > CONFIG_NET_CLS=y
> > CONFIG_NET_CLS_BASIC=y
> > # CONFIG_NET_CLS_TCINDEX is not set
> > CONFIG_NET_CLS_ROUTE4=y
> > # CONFIG_NET_CLS_FW is not set
> > CONFIG_NET_CLS_U32=y
> > CONFIG_CLS_U32_PERF=y
> > # CONFIG_CLS_U32_MARK is not set
> > CONFIG_NET_CLS_RSVP=y
> > # CONFIG_NET_CLS_RSVP6 is not set
> > CONFIG_NET_CLS_FLOW=m
> > # CONFIG_NET_CLS_CGROUP is not set
> > CONFIG_NET_CLS_BPF=m
> > CONFIG_NET_CLS_FLOWER=m
> > CONFIG_NET_CLS_MATCHALL=y
> > CONFIG_NET_EMATCH=y
> > CONFIG_NET_EMATCH_STACK=32
> > # CONFIG_NET_EMATCH_CMP is not set
> > CONFIG_NET_EMATCH_NBYTE=y
> > # CONFIG_NET_EMATCH_U32 is not set
> > # CONFIG_NET_EMATCH_META is not set
> > CONFIG_NET_EMATCH_TEXT=y
> > CONFIG_NET_EMATCH_IPSET=y
> > # CONFIG_NET_EMATCH_IPT is not set
> > CONFIG_NET_CLS_ACT=y
> > CONFIG_NET_ACT_POLICE=y
> > # CONFIG_NET_ACT_GACT is not set
> > # CONFIG_NET_ACT_MIRRED is not set
> > CONFIG_NET_ACT_SAMPLE=m
> > CONFIG_NET_ACT_IPT=m
> > CONFIG_NET_ACT_NAT=y
> > CONFIG_NET_ACT_PEDIT=m
> > CONFIG_NET_ACT_SIMP=y
> > CONFIG_NET_ACT_SKBEDIT=m
> > # CONFIG_NET_ACT_CSUM is not set
> > # CONFIG_NET_ACT_MPLS is not set
> > # CONFIG_NET_ACT_VLAN is not set
> > # CONFIG_NET_ACT_BPF is not set
> > CONFIG_NET_ACT_SKBMOD=y
> > CONFIG_NET_ACT_IFE=m
> > # CONFIG_NET_ACT_TUNNEL_KEY is not set
> > # CONFIG_NET_IFE_SKBMARK is not set
> > # CONFIG_NET_IFE_SKBPRIO is not set
> > # CONFIG_NET_IFE_SKBTCINDEX is not set
> > # CONFIG_NET_TC_SKB_EXT is not set
> > CONFIG_NET_SCH_FIFO=y
> > # CONFIG_DCB is not set
> > CONFIG_DNS_RESOLVER=m
> > CONFIG_BATMAN_ADV=m
> > CONFIG_BATMAN_ADV_BATMAN_V=y
> > # CONFIG_BATMAN_ADV_BLA is not set
> > CONFIG_BATMAN_ADV_DAT=y
> > CONFIG_BATMAN_ADV_NC=y
> > # CONFIG_BATMAN_ADV_MCAST is not set
> > CONFIG_BATMAN_ADV_DEBUGFS=y
> > # CONFIG_BATMAN_ADV_DEBUG is not set
> > # CONFIG_BATMAN_ADV_SYSFS is not set
> > # CONFIG_BATMAN_ADV_TRACING is not set
> > CONFIG_OPENVSWITCH=m
> > # CONFIG_VSOCKETS is not set
> > CONFIG_NETLINK_DIAG=m
> > CONFIG_MPLS=y
> > CONFIG_NET_MPLS_GSO=m
> > CONFIG_MPLS_ROUTING=m
> > CONFIG_MPLS_IPTUNNEL=m
> > CONFIG_NET_NSH=m
> > CONFIG_HSR=m
> > CONFIG_NET_SWITCHDEV=y
> > CONFIG_NET_L3_MASTER_DEV=y
> > CONFIG_NET_NCSI=y
> > # CONFIG_NCSI_OEM_CMD_GET_MAC is not set
> > CONFIG_CGROUP_NET_PRIO=y
> > # CONFIG_CGROUP_NET_CLASSID is not set
> > CONFIG_NET_RX_BUSY_POLL=y
> > CONFIG_BQL=y
> > # CONFIG_BPF_JIT is not set
> > CONFIG_BPF_STREAM_PARSER=y
> > 
> > #
> > # Network testing
> > #
> > CONFIG_NET_PKTGEN=y
> > CONFIG_NET_DROP_MONITOR=m
> > # end of Network testing
> > # end of Networking options
> > 
> > # CONFIG_HAMRADIO is not set
> > # CONFIG_CAN is not set
> > CONFIG_BT=y
> > CONFIG_BT_BREDR=y
> > # CONFIG_BT_RFCOMM is not set
> > CONFIG_BT_BNEP=y
> > # CONFIG_BT_BNEP_MC_FILTER is not set
> > # CONFIG_BT_BNEP_PROTO_FILTER is not set
> > # CONFIG_BT_CMTP is not set
> > # CONFIG_BT_HIDP is not set
> > # CONFIG_BT_HS is not set
> > CONFIG_BT_LE=y
> > CONFIG_BT_6LOWPAN=m
> > CONFIG_BT_LEDS=y
> > CONFIG_BT_SELFTEST=y
> > # CONFIG_BT_SELFTEST_ECDH is not set
> > CONFIG_BT_SELFTEST_SMP=y
> > CONFIG_BT_DEBUGFS=y
> > 
> > #
> > # Bluetooth device drivers
> > #
> > CONFIG_BT_HCIBTSDIO=m
> > # CONFIG_BT_HCIUART is not set
> > CONFIG_BT_HCIDTL1=m
> > CONFIG_BT_HCIBT3C=m
> > # CONFIG_BT_HCIBLUECARD is not set
> > CONFIG_BT_HCIVHCI=m
> > CONFIG_BT_MRVL=y
> > # CONFIG_BT_MRVL_SDIO is not set
> > # CONFIG_BT_MTKSDIO is not set
> > # end of Bluetooth device drivers
> > 
> > CONFIG_AF_RXRPC=y
> > # CONFIG_AF_RXRPC_IPV6 is not set
> > CONFIG_AF_RXRPC_INJECT_LOSS=y
> > CONFIG_AF_RXRPC_DEBUG=y
> > CONFIG_RXKAD=y
> > CONFIG_AF_KCM=m
> > CONFIG_STREAM_PARSER=y
> > CONFIG_FIB_RULES=y
> > # CONFIG_WIRELESS is not set
> > CONFIG_WIMAX=y
> > CONFIG_WIMAX_DEBUG_LEVEL=8
> > CONFIG_RFKILL=y
> > CONFIG_RFKILL_LEDS=y
> > # CONFIG_RFKILL_INPUT is not set
> > # CONFIG_RFKILL_GPIO is not set
> > CONFIG_NET_9P=y
> > CONFIG_NET_9P_VIRTIO=y
> > CONFIG_NET_9P_DEBUG=y
> > CONFIG_CAIF=y
> > # CONFIG_CAIF_DEBUG is not set
> > CONFIG_CAIF_NETDEV=m
> > # CONFIG_CAIF_USB is not set
> > CONFIG_CEPH_LIB=y
> > CONFIG_CEPH_LIB_PRETTYDEBUG=y
> > # CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
> > # CONFIG_NFC is not set
> > CONFIG_PSAMPLE=m
> > CONFIG_NET_IFE=m
> > CONFIG_LWTUNNEL=y
> > # CONFIG_LWTUNNEL_BPF is not set
> > CONFIG_DST_CACHE=y
> > CONFIG_GRO_CELLS=y
> > CONFIG_NET_SOCK_MSG=y
> > CONFIG_FAILOVER=y
> > CONFIG_ETHTOOL_NETLINK=y
> > CONFIG_HAVE_EBPF_JIT=y
> > 
> > #
> > # Device Drivers
> > #
> > CONFIG_HAVE_EISA=y
> > # CONFIG_EISA is not set
> > CONFIG_HAVE_PCI=y
> > CONFIG_PCI=y
> > CONFIG_PCI_DOMAINS=y
> > # CONFIG_PCIEPORTBUS is not set
> > CONFIG_PCIEASPM=y
> > CONFIG_PCIEASPM_DEFAULT=y
> > # CONFIG_PCIEASPM_POWERSAVE is not set
> > # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> > # CONFIG_PCIEASPM_PERFORMANCE is not set
> > # CONFIG_PCIE_PTM is not set
> > # CONFIG_PCI_MSI is not set
> > CONFIG_PCI_QUIRKS=y
> > # CONFIG_PCI_DEBUG is not set
> > # CONFIG_PCI_STUB is not set
> > CONFIG_PCI_LOCKLESS_CONFIG=y
> > # CONFIG_PCI_IOV is not set
> > # CONFIG_PCI_PRI is not set
> > # CONFIG_PCI_PASID is not set
> > CONFIG_PCI_LABEL=y
> > # CONFIG_HOTPLUG_PCI is not set
> > 
> > #
> > # PCI controller drivers
> > #
> > 
> > #
> > # DesignWare PCI Core Support
> > #
> > # end of DesignWare PCI Core Support
> > 
> > #
> > # Cadence PCIe controllers support
> > #
> > # end of Cadence PCIe controllers support
> > # end of PCI controller drivers
> > 
> > #
> > # PCI Endpoint
> > #
> > # CONFIG_PCI_ENDPOINT is not set
> > # end of PCI Endpoint
> > 
> > #
> > # PCI switch controller drivers
> > #
> > # CONFIG_PCI_SW_SWITCHTEC is not set
> > # end of PCI switch controller drivers
> > 
> > CONFIG_PCCARD=m
> > CONFIG_PCMCIA=m
> > # CONFIG_PCMCIA_LOAD_CIS is not set
> > CONFIG_CARDBUS=y
> > 
> > #
> > # PC-card bridges
> > #
> > # CONFIG_YENTA is not set
> > # CONFIG_PD6729 is not set
> > # CONFIG_I82092 is not set
> > # CONFIG_RAPIDIO is not set
> > 
> > #
> > # Generic Driver Options
> > #
> > # CONFIG_UEVENT_HELPER is not set
> > CONFIG_DEVTMPFS=y
> > # CONFIG_DEVTMPFS_MOUNT is not set
> > # CONFIG_STANDALONE is not set
> > # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> > 
> > #
> > # Firmware loader
> > #
> > CONFIG_FW_LOADER=y
> > CONFIG_FW_LOADER_PAGED_BUF=y
> > CONFIG_EXTRA_FIRMWARE=""
> > CONFIG_FW_LOADER_USER_HELPER=y
> > # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> > # CONFIG_FW_LOADER_COMPRESS is not set
> > # end of Firmware loader
> > 
> > CONFIG_ALLOW_DEV_COREDUMP=y
> > # CONFIG_DEBUG_DRIVER is not set
> > # CONFIG_DEBUG_DEVRES is not set
> > # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> > CONFIG_TEST_ASYNC_DRIVER_PROBE=m
> > CONFIG_GENERIC_CPU_AUTOPROBE=y
> > CONFIG_GENERIC_CPU_VULNERABILITIES=y
> > CONFIG_REGMAP=y
> > CONFIG_REGMAP_I2C=m
> > CONFIG_REGMAP_SPI=y
> > CONFIG_REGMAP_SPMI=m
> > CONFIG_REGMAP_W1=m
> > CONFIG_REGMAP_MMIO=y
> > CONFIG_REGMAP_IRQ=y
> > CONFIG_DMA_SHARED_BUFFER=y
> > CONFIG_DMA_FENCE_TRACE=y
> > # end of Generic Driver Options
> > 
> > #
> > # Bus devices
> > #
> > # end of Bus devices
> > 
> > # CONFIG_CONNECTOR is not set
> > # CONFIG_GNSS is not set
> > CONFIG_MTD=y
> > # CONFIG_MTD_TESTS is not set
> > 
> > #
> > # Partition parsers
> > #
> > # CONFIG_MTD_AR7_PARTS is not set
> > # CONFIG_MTD_CMDLINE_PARTS is not set
> > CONFIG_MTD_REDBOOT_PARTS=m
> > CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> > CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
> > CONFIG_MTD_REDBOOT_PARTS_READONLY=y
> > # end of Partition parsers
> > 
> > #
> > # User Modules And Translation Layers
> > #
> > # CONFIG_MTD_BLOCK is not set
> > # CONFIG_MTD_BLOCK_RO is not set
> > # CONFIG_FTL is not set
> > # CONFIG_NFTL is not set
> > # CONFIG_INFTL is not set
> > # CONFIG_RFD_FTL is not set
> > # CONFIG_SSFDC is not set
> > # CONFIG_SM_FTL is not set
> > # CONFIG_MTD_OOPS is not set
> > # CONFIG_MTD_SWAP is not set
> > CONFIG_MTD_PARTITIONED_MASTER=y
> > 
> > #
> > # RAM/ROM/Flash chip drivers
> > #
> > CONFIG_MTD_CFI=y
> > CONFIG_MTD_JEDECPROBE=m
> > CONFIG_MTD_GEN_PROBE=y
> > CONFIG_MTD_CFI_ADV_OPTIONS=y
> > # CONFIG_MTD_CFI_NOSWAP is not set
> > CONFIG_MTD_CFI_BE_BYTE_SWAP=y
> > # CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
> > CONFIG_MTD_CFI_GEOMETRY=y
> > # CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
> > # CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
> > CONFIG_MTD_MAP_BANK_WIDTH_4=y
> > CONFIG_MTD_MAP_BANK_WIDTH_8=y
> > CONFIG_MTD_MAP_BANK_WIDTH_16=y
> > CONFIG_MTD_MAP_BANK_WIDTH_32=y
> > CONFIG_MTD_CFI_I1=y
> > # CONFIG_MTD_CFI_I2 is not set
> > # CONFIG_MTD_CFI_I4 is not set
> > CONFIG_MTD_CFI_I8=y
> > CONFIG_MTD_OTP=y
> > CONFIG_MTD_CFI_INTELEXT=m
> > CONFIG_MTD_CFI_AMDSTD=m
> > # CONFIG_MTD_CFI_STAA is not set
> > CONFIG_MTD_CFI_UTIL=y
> > CONFIG_MTD_RAM=y
> > CONFIG_MTD_ROM=m
> > CONFIG_MTD_ABSENT=m
> > # end of RAM/ROM/Flash chip drivers
> > 
> > #
> > # Mapping drivers for chip access
> > #
> > CONFIG_MTD_COMPLEX_MAPPINGS=y
> > CONFIG_MTD_PHYSMAP=m
> > # CONFIG_MTD_PHYSMAP_COMPAT is not set
> > # CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
> > CONFIG_MTD_SBC_GXX=m
> > CONFIG_MTD_AMD76XROM=m
> > CONFIG_MTD_ICHXROM=m
> > # CONFIG_MTD_ESB2ROM is not set
> > # CONFIG_MTD_CK804XROM is not set
> > # CONFIG_MTD_SCB2_FLASH is not set
> > CONFIG_MTD_NETtel=m
> > CONFIG_MTD_L440GX=m
> > # CONFIG_MTD_PCI is not set
> > CONFIG_MTD_PCMCIA=m
> > # CONFIG_MTD_PCMCIA_ANONYMOUS is not set
> > # CONFIG_MTD_INTEL_VR_NOR is not set
> > CONFIG_MTD_PLATRAM=y
> > # end of Mapping drivers for chip access
> > 
> > #
> > # Self-contained MTD device drivers
> > #
> > # CONFIG_MTD_PMC551 is not set
> > CONFIG_MTD_DATAFLASH=y
> > # CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
> > CONFIG_MTD_DATAFLASH_OTP=y
> > CONFIG_MTD_MCHP23K256=y
> > # CONFIG_MTD_SST25L is not set
> > # CONFIG_MTD_SLRAM is not set
> > CONFIG_MTD_PHRAM=m
> > # CONFIG_MTD_MTDRAM is not set
> > # CONFIG_MTD_BLOCK2MTD is not set
> > 
> > #
> > # Disk-On-Chip Device Drivers
> > #
> > CONFIG_MTD_DOCG3=y
> > CONFIG_BCH_CONST_M=14
> > CONFIG_BCH_CONST_T=4
> > # end of Self-contained MTD device drivers
> > 
> > # CONFIG_MTD_ONENAND is not set
> > # CONFIG_MTD_RAW_NAND is not set
> > # CONFIG_MTD_SPI_NAND is not set
> > 
> > #
> > # LPDDR & LPDDR2 PCM memory drivers
> > #
> > CONFIG_MTD_LPDDR=y
> > CONFIG_MTD_QINFO_PROBE=y
> > # end of LPDDR & LPDDR2 PCM memory drivers
> > 
> > CONFIG_MTD_SPI_NOR=m
> > # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
> > # CONFIG_SPI_MTK_QUADSPI is not set
> > CONFIG_SPI_INTEL_SPI=m
> > # CONFIG_SPI_INTEL_SPI_PCI is not set
> > CONFIG_SPI_INTEL_SPI_PLATFORM=m
> > CONFIG_MTD_UBI=m
> > CONFIG_MTD_UBI_WL_THRESHOLD=4096
> > CONFIG_MTD_UBI_BEB_LIMIT=20
> > # CONFIG_MTD_UBI_FASTMAP is not set
> > CONFIG_MTD_UBI_GLUEBI=m
> > # CONFIG_MTD_UBI_BLOCK is not set
> > # CONFIG_MTD_HYPERBUS is not set
> > # CONFIG_OF is not set
> > CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> > CONFIG_PARPORT=y
> > CONFIG_PARPORT_PC=y
> > # CONFIG_PARPORT_SERIAL is not set
> > CONFIG_PARPORT_PC_FIFO=y
> > CONFIG_PARPORT_PC_SUPERIO=y
> > # CONFIG_PARPORT_PC_PCMCIA is not set
> > CONFIG_PARPORT_AX88796=y
> > CONFIG_PARPORT_1284=y
> > CONFIG_PARPORT_NOT_PC=y
> > CONFIG_PNP=y
> > CONFIG_PNP_DEBUG_MESSAGES=y
> > 
> > #
> > # Protocols
> > #
> > CONFIG_PNPACPI=y
> > CONFIG_BLK_DEV=y
> > # CONFIG_BLK_DEV_NULL_BLK is not set
> > # CONFIG_PARIDE is not set
> > # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> > # CONFIG_ZRAM is not set
> > # CONFIG_BLK_DEV_UMEM is not set
> > # CONFIG_BLK_DEV_LOOP is not set
> > # CONFIG_BLK_DEV_DRBD is not set
> > # CONFIG_BLK_DEV_NBD is not set
> > # CONFIG_BLK_DEV_SKD is not set
> > # CONFIG_BLK_DEV_SX8 is not set
> > # CONFIG_BLK_DEV_RAM is not set
> > # CONFIG_CDROM_PKTCDVD is not set
> > # CONFIG_ATA_OVER_ETH is not set
> > # CONFIG_VIRTIO_BLK is not set
> > # CONFIG_BLK_DEV_RBD is not set
> > # CONFIG_BLK_DEV_RSXX is not set
> > 
> > #
> > # NVME Support
> > #
> > # CONFIG_BLK_DEV_NVME is not set
> > # CONFIG_NVME_FC is not set
> > # CONFIG_NVME_TARGET is not set
> > # end of NVME Support
> > 
> > #
> > # Misc devices
> > #
> > CONFIG_AD525X_DPOT=y
> > CONFIG_AD525X_DPOT_I2C=m
> > CONFIG_AD525X_DPOT_SPI=m
> > # CONFIG_DUMMY_IRQ is not set
> > # CONFIG_IBM_ASM is not set
> > # CONFIG_PHANTOM is not set
> > # CONFIG_TIFM_CORE is not set
> > CONFIG_ICS932S401=m
> > # CONFIG_ENCLOSURE_SERVICES is not set
> > # CONFIG_HP_ILO is not set
> > # CONFIG_APDS9802ALS is not set
> > # CONFIG_ISL29003 is not set
> > CONFIG_ISL29020=m
> > CONFIG_SENSORS_TSL2550=m
> > CONFIG_SENSORS_BH1770=m
> > CONFIG_SENSORS_APDS990X=m
> > CONFIG_HMC6352=m
> > CONFIG_DS1682=m
> > CONFIG_LATTICE_ECP3_CONFIG=m
> > CONFIG_SRAM=y
> > # CONFIG_PCI_ENDPOINT_TEST is not set
> > # CONFIG_XILINX_SDFEC is not set
> > # CONFIG_PVPANIC is not set
> > CONFIG_C2PORT=m
> > CONFIG_C2PORT_DURAMAR_2150=m
> > 
> > #
> > # EEPROM support
> > #
> > # CONFIG_EEPROM_AT24 is not set
> > CONFIG_EEPROM_AT25=y
> > CONFIG_EEPROM_LEGACY=m
> > # CONFIG_EEPROM_MAX6875 is not set
> > # CONFIG_EEPROM_93CX6 is not set
> > CONFIG_EEPROM_93XX46=y
> > CONFIG_EEPROM_IDT_89HPESX=m
> > # CONFIG_EEPROM_EE1004 is not set
> > # end of EEPROM support
> > 
> > # CONFIG_CB710_CORE is not set
> > 
> > #
> > # Texas Instruments shared transport line discipline
> > #
> > # CONFIG_TI_ST is not set
> > # end of Texas Instruments shared transport line discipline
> > 
> > # CONFIG_SENSORS_LIS3_I2C is not set
> > 
> > #
> > # Altera FPGA firmware download module (requires I2C)
> > #
> > CONFIG_ALTERA_STAPL=m
> > # CONFIG_INTEL_MEI is not set
> > # CONFIG_INTEL_MEI_ME is not set
> > # CONFIG_INTEL_MEI_TXE is not set
> > # CONFIG_VMWARE_VMCI is not set
> > 
> > #
> > # Intel MIC & related support
> > #
> > # CONFIG_INTEL_MIC_BUS is not set
> > # CONFIG_SCIF_BUS is not set
> > # CONFIG_VOP_BUS is not set
> > # end of Intel MIC & related support
> > 
> > # CONFIG_GENWQE is not set
> > CONFIG_ECHO=y
> > # CONFIG_MISC_ALCOR_PCI is not set
> > # CONFIG_MISC_RTSX_PCI is not set
> > # CONFIG_HABANA_AI is not set
> > # end of Misc devices
> > 
> > CONFIG_HAVE_IDE=y
> > # CONFIG_IDE is not set
> > 
> > #
> > # SCSI device support
> > #
> > CONFIG_SCSI_MOD=y
> > # CONFIG_RAID_ATTRS is not set
> > # CONFIG_SCSI is not set
> > # end of SCSI device support
> > 
> > # CONFIG_ATA is not set
> > # CONFIG_MD is not set
> > # CONFIG_TARGET_CORE is not set
> > # CONFIG_FUSION is not set
> > 
> > #
> > # IEEE 1394 (FireWire) support
> > #
> > CONFIG_FIREWIRE=m
> > # CONFIG_FIREWIRE_OHCI is not set
> > CONFIG_FIREWIRE_NET=m
> > # CONFIG_FIREWIRE_NOSY is not set
> > # end of IEEE 1394 (FireWire) support
> > 
> > # CONFIG_MACINTOSH_DRIVERS is not set
> > CONFIG_NETDEVICES=y
> > CONFIG_NET_CORE=y
> > # CONFIG_BONDING is not set
> > CONFIG_DUMMY=m
> > # CONFIG_WIREGUARD is not set
> > # CONFIG_EQUALIZER is not set
> > CONFIG_IFB=y
> > CONFIG_NET_TEAM=m
> > # CONFIG_NET_TEAM_MODE_BROADCAST is not set
> > # CONFIG_NET_TEAM_MODE_ROUNDROBIN is not set
> > # CONFIG_NET_TEAM_MODE_RANDOM is not set
> > # CONFIG_NET_TEAM_MODE_ACTIVEBACKUP is not set
> > CONFIG_NET_TEAM_MODE_LOADBALANCE=m
> > CONFIG_MACVLAN=m
> > CONFIG_MACVTAP=m
> > CONFIG_IPVLAN_L3S=y
> > CONFIG_IPVLAN=m
> > CONFIG_IPVTAP=m
> > # CONFIG_VXLAN is not set
> > # CONFIG_GENEVE is not set
> > # CONFIG_GTP is not set
> > CONFIG_MACSEC=y
> > CONFIG_NETCONSOLE=y
> > CONFIG_NETPOLL=y
> > CONFIG_NET_POLL_CONTROLLER=y
> > CONFIG_TUN=m
> > CONFIG_TAP=m
> > CONFIG_TUN_VNET_CROSS_LE=y
> > CONFIG_VETH=m
> > CONFIG_VIRTIO_NET=y
> > # CONFIG_NLMON is not set
> > CONFIG_NET_VRF=y
> > CONFIG_ARCNET=m
> > # CONFIG_ARCNET_1201 is not set
> > CONFIG_ARCNET_1051=m
> > CONFIG_ARCNET_RAW=m
> > CONFIG_ARCNET_CAP=m
> > # CONFIG_ARCNET_COM90xx is not set
> > # CONFIG_ARCNET_COM90xxIO is not set
> > # CONFIG_ARCNET_RIM_I is not set
> > CONFIG_ARCNET_COM20020=m
> > # CONFIG_ARCNET_COM20020_PCI is not set
> > CONFIG_ARCNET_COM20020_CS=m
> > CONFIG_ATM_DRIVERS=y
> > # CONFIG_ATM_DUMMY is not set
> > CONFIG_ATM_TCP=m
> > # CONFIG_ATM_LANAI is not set
> > # CONFIG_ATM_ENI is not set
> > # CONFIG_ATM_FIRESTREAM is not set
> > # CONFIG_ATM_ZATM is not set
> > # CONFIG_ATM_NICSTAR is not set
> > # CONFIG_ATM_IDT77252 is not set
> > # CONFIG_ATM_AMBASSADOR is not set
> > # CONFIG_ATM_HORIZON is not set
> > # CONFIG_ATM_IA is not set
> > # CONFIG_ATM_FORE200E is not set
> > # CONFIG_ATM_HE is not set
> > # CONFIG_ATM_SOLOS is not set
> > # CONFIG_CAIF_DRIVERS is not set
> > 
> > #
> > # Distributed Switch Architecture drivers
> > #
> > # end of Distributed Switch Architecture drivers
> > 
> > CONFIG_ETHERNET=y
> > CONFIG_NET_VENDOR_3COM=y
> > # CONFIG_PCMCIA_3C574 is not set
> > # CONFIG_PCMCIA_3C589 is not set
> > # CONFIG_VORTEX is not set
> > # CONFIG_TYPHOON is not set
> > CONFIG_NET_VENDOR_ADAPTEC=y
> > # CONFIG_ADAPTEC_STARFIRE is not set
> > CONFIG_NET_VENDOR_AGERE=y
> > # CONFIG_ET131X is not set
> > CONFIG_NET_VENDOR_ALACRITECH=y
> > # CONFIG_SLICOSS is not set
> > CONFIG_NET_VENDOR_ALTEON=y
> > # CONFIG_ACENIC is not set
> > # CONFIG_ALTERA_TSE is not set
> > CONFIG_NET_VENDOR_AMAZON=y
> > CONFIG_NET_VENDOR_AMD=y
> > # CONFIG_AMD8111_ETH is not set
> > # CONFIG_PCNET32 is not set
> > # CONFIG_PCMCIA_NMCLAN is not set
> > # CONFIG_AMD_XGBE is not set
> > CONFIG_NET_VENDOR_AQUANTIA=y
> > # CONFIG_AQTION is not set
> > CONFIG_NET_VENDOR_ARC=y
> > CONFIG_NET_VENDOR_ATHEROS=y
> > # CONFIG_ATL2 is not set
> > # CONFIG_ATL1 is not set
> > # CONFIG_ATL1E is not set
> > # CONFIG_ATL1C is not set
> > # CONFIG_ALX is not set
> > # CONFIG_NET_VENDOR_AURORA is not set
> > CONFIG_NET_VENDOR_BROADCOM=y
> > # CONFIG_B44 is not set
> > # CONFIG_BCMGENET is not set
> > # CONFIG_BNX2 is not set
> > # CONFIG_CNIC is not set
> > # CONFIG_TIGON3 is not set
> > # CONFIG_BNX2X is not set
> > # CONFIG_SYSTEMPORT is not set
> > # CONFIG_BNXT is not set
> > CONFIG_NET_VENDOR_BROCADE=y
> > # CONFIG_BNA is not set
> > CONFIG_NET_VENDOR_CADENCE=y
> > # CONFIG_MACB is not set
> > CONFIG_NET_VENDOR_CAVIUM=y
> > # CONFIG_THUNDER_NIC_PF is not set
> > # CONFIG_THUNDER_NIC_VF is not set
> > # CONFIG_THUNDER_NIC_BGX is not set
> > # CONFIG_THUNDER_NIC_RGX is not set
> > # CONFIG_CAVIUM_PTP is not set
> > # CONFIG_LIQUIDIO is not set
> > CONFIG_NET_VENDOR_CHELSIO=y
> > # CONFIG_CHELSIO_T1 is not set
> > # CONFIG_CHELSIO_T3 is not set
> > # CONFIG_CHELSIO_T4 is not set
> > # CONFIG_CHELSIO_T4VF is not set
> > CONFIG_NET_VENDOR_CISCO=y
> > # CONFIG_ENIC is not set
> > CONFIG_NET_VENDOR_CORTINA=y
> > # CONFIG_CX_ECAT is not set
> > # CONFIG_DNET is not set
> > CONFIG_NET_VENDOR_DEC=y
> > # CONFIG_NET_TULIP is not set
> > CONFIG_NET_VENDOR_DLINK=y
> > # CONFIG_DL2K is not set
> > # CONFIG_SUNDANCE is not set
> > CONFIG_NET_VENDOR_EMULEX=y
> > # CONFIG_BE2NET is not set
> > CONFIG_NET_VENDOR_EZCHIP=y
> > CONFIG_NET_VENDOR_FUJITSU=y
> > # CONFIG_PCMCIA_FMVJ18X is not set
> > CONFIG_NET_VENDOR_GOOGLE=y
> > CONFIG_NET_VENDOR_HUAWEI=y
> > CONFIG_NET_VENDOR_I825XX=y
> > CONFIG_NET_VENDOR_INTEL=y
> > # CONFIG_E100 is not set
> > CONFIG_E1000=y
> > # CONFIG_E1000E is not set
> > # CONFIG_IGB is not set
> > # CONFIG_IGBVF is not set
> > # CONFIG_IXGB is not set
> > # CONFIG_IXGBE is not set
> > # CONFIG_I40E is not set
> > # CONFIG_IGC is not set
> > # CONFIG_JME is not set
> > CONFIG_NET_VENDOR_MARVELL=y
> > # CONFIG_MVMDIO is not set
> > # CONFIG_SKGE is not set
> > # CONFIG_SKY2 is not set
> > CONFIG_NET_VENDOR_MELLANOX=y
> > # CONFIG_MLX4_EN is not set
> > # CONFIG_MLX5_CORE is not set
> > # CONFIG_MLXSW_CORE is not set
> > # CONFIG_MLXFW is not set
> > CONFIG_NET_VENDOR_MICREL=y
> > # CONFIG_KS8851 is not set
> > # CONFIG_KS8851_MLL is not set
> > # CONFIG_KSZ884X_PCI is not set
> > CONFIG_NET_VENDOR_MICROCHIP=y
> > # CONFIG_ENC28J60 is not set
> > # CONFIG_ENCX24J600 is not set
> > # CONFIG_LAN743X is not set
> > CONFIG_NET_VENDOR_MICROSEMI=y
> > # CONFIG_MSCC_OCELOT_SWITCH is not set
> > CONFIG_NET_VENDOR_MYRI=y
> > # CONFIG_MYRI10GE is not set
> > # CONFIG_FEALNX is not set
> > CONFIG_NET_VENDOR_NATSEMI=y
> > # CONFIG_NATSEMI is not set
> > # CONFIG_NS83820 is not set
> > CONFIG_NET_VENDOR_NETERION=y
> > # CONFIG_S2IO is not set
> > # CONFIG_VXGE is not set
> > CONFIG_NET_VENDOR_NETRONOME=y
> > CONFIG_NET_VENDOR_NI=y
> > # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> > CONFIG_NET_VENDOR_8390=y
> > # CONFIG_PCMCIA_AXNET is not set
> > # CONFIG_NE2K_PCI is not set
> > # CONFIG_PCMCIA_PCNET is not set
> > CONFIG_NET_VENDOR_NVIDIA=y
> > # CONFIG_FORCEDETH is not set
> > CONFIG_NET_VENDOR_OKI=y
> > # CONFIG_ETHOC is not set
> > CONFIG_NET_VENDOR_PACKET_ENGINES=y
> > # CONFIG_HAMACHI is not set
> > # CONFIG_YELLOWFIN is not set
> > CONFIG_NET_VENDOR_PENSANDO=y
> > # CONFIG_IONIC is not set
> > CONFIG_NET_VENDOR_QLOGIC=y
> > # CONFIG_QLA3XXX is not set
> > # CONFIG_QLCNIC is not set
> > # CONFIG_NETXEN_NIC is not set
> > # CONFIG_QED is not set
> > CONFIG_NET_VENDOR_QUALCOMM=y
> > # CONFIG_QCOM_EMAC is not set
> > # CONFIG_RMNET is not set
> > CONFIG_NET_VENDOR_RDC=y
> > # CONFIG_R6040 is not set
> > CONFIG_NET_VENDOR_REALTEK=y
> > # CONFIG_ATP is not set
> > # CONFIG_8139CP is not set
> > # CONFIG_8139TOO is not set
> > # CONFIG_R8169 is not set
> > CONFIG_NET_VENDOR_RENESAS=y
> > CONFIG_NET_VENDOR_ROCKER=y
> > CONFIG_NET_VENDOR_SAMSUNG=y
> > # CONFIG_SXGBE_ETH is not set
> > CONFIG_NET_VENDOR_SEEQ=y
> > CONFIG_NET_VENDOR_SOLARFLARE=y
> > # CONFIG_SFC is not set
> > # CONFIG_SFC_FALCON is not set
> > CONFIG_NET_VENDOR_SILAN=y
> > # CONFIG_SC92031 is not set
> > CONFIG_NET_VENDOR_SIS=y
> > # CONFIG_SIS900 is not set
> > # CONFIG_SIS190 is not set
> > CONFIG_NET_VENDOR_SMSC=y
> > # CONFIG_PCMCIA_SMC91C92 is not set
> > # CONFIG_EPIC100 is not set
> > # CONFIG_SMSC911X is not set
> > # CONFIG_SMSC9420 is not set
> > CONFIG_NET_VENDOR_SOCIONEXT=y
> > CONFIG_NET_VENDOR_STMICRO=y
> > # CONFIG_STMMAC_ETH is not set
> > CONFIG_NET_VENDOR_SUN=y
> > # CONFIG_HAPPYMEAL is not set
> > # CONFIG_SUNGEM is not set
> > # CONFIG_CASSINI is not set
> > # CONFIG_NIU is not set
> > CONFIG_NET_VENDOR_SYNOPSYS=y
> > # CONFIG_DWC_XLGMAC is not set
> > CONFIG_NET_VENDOR_TEHUTI=y
> > # CONFIG_TEHUTI is not set
> > CONFIG_NET_VENDOR_TI=y
> > # CONFIG_TI_CPSW_PHY_SEL is not set
> > # CONFIG_TLAN is not set
> > CONFIG_NET_VENDOR_VIA=y
> > # CONFIG_VIA_RHINE is not set
> > # CONFIG_VIA_VELOCITY is not set
> > CONFIG_NET_VENDOR_WIZNET=y
> > # CONFIG_WIZNET_W5100 is not set
> > # CONFIG_WIZNET_W5300 is not set
> > CONFIG_NET_VENDOR_XILINX=y
> > # CONFIG_XILINX_AXI_EMAC is not set
> > # CONFIG_XILINX_LL_TEMAC is not set
> > CONFIG_NET_VENDOR_XIRCOM=y
> > # CONFIG_PCMCIA_XIRC2PS is not set
> > # CONFIG_FDDI is not set
> > # CONFIG_HIPPI is not set
> > # CONFIG_NET_SB1000 is not set
> > CONFIG_MDIO_DEVICE=m
> > CONFIG_MDIO_BUS=m
> > # CONFIG_MDIO_BCM_UNIMAC is not set
> > CONFIG_MDIO_BITBANG=m
> > CONFIG_MDIO_GPIO=m
> > # CONFIG_MDIO_MSCC_MIIM is not set
> > # CONFIG_MDIO_THUNDER is not set
> > CONFIG_PHYLIB=m
> > CONFIG_SWPHY=y
> > # CONFIG_LED_TRIGGER_PHY is not set
> > 
> > #
> > # MII PHY device drivers
> > #
> > # CONFIG_ADIN_PHY is not set
> > CONFIG_AMD_PHY=m
> > CONFIG_AQUANTIA_PHY=m
> > # CONFIG_AX88796B_PHY is not set
> > CONFIG_BCM7XXX_PHY=m
> > # CONFIG_BCM87XX_PHY is not set
> > CONFIG_BCM_NET_PHYLIB=m
> > CONFIG_BROADCOM_PHY=m
> > # CONFIG_CICADA_PHY is not set
> > CONFIG_CORTINA_PHY=m
> > # CONFIG_DAVICOM_PHY is not set
> > # CONFIG_DP83822_PHY is not set
> > # CONFIG_DP83TC811_PHY is not set
> > CONFIG_DP83848_PHY=m
> > CONFIG_DP83867_PHY=m
> > # CONFIG_DP83869_PHY is not set
> > CONFIG_FIXED_PHY=m
> > # CONFIG_ICPLUS_PHY is not set
> > # CONFIG_INTEL_XWAY_PHY is not set
> > # CONFIG_LSI_ET1011C_PHY is not set
> > CONFIG_LXT_PHY=m
> > CONFIG_MARVELL_PHY=m
> > # CONFIG_MARVELL_10G_PHY is not set
> > CONFIG_MICREL_PHY=m
> > # CONFIG_MICROCHIP_PHY is not set
> > # CONFIG_MICROCHIP_T1_PHY is not set
> > CONFIG_MICROSEMI_PHY=m
> > CONFIG_NATIONAL_PHY=m
> > # CONFIG_NXP_TJA11XX_PHY is not set
> > # CONFIG_AT803X_PHY is not set
> > CONFIG_QSEMI_PHY=m
> > CONFIG_REALTEK_PHY=m
> > # CONFIG_RENESAS_PHY is not set
> > CONFIG_ROCKCHIP_PHY=m
> > CONFIG_SMSC_PHY=m
> > # CONFIG_STE10XP is not set
> > CONFIG_TERANETICS_PHY=m
> > CONFIG_VITESSE_PHY=m
> > # CONFIG_XILINX_GMII2RGMII is not set
> > CONFIG_MICREL_KS8995MA=m
> > # CONFIG_PLIP is not set
> > CONFIG_PPP=y
> > # CONFIG_PPP_BSDCOMP is not set
> > CONFIG_PPP_DEFLATE=m
> > CONFIG_PPP_FILTER=y
> > CONFIG_PPP_MPPE=y
> > # CONFIG_PPP_MULTILINK is not set
> > CONFIG_PPPOATM=y
> > CONFIG_PPPOE=y
> > # CONFIG_PPP_ASYNC is not set
> > # CONFIG_PPP_SYNC_TTY is not set
> > # CONFIG_SLIP is not set
> > CONFIG_SLHC=y
> > 
> > #
> > # Host-side USB support is needed for USB Network Adapter support
> > #
> > # CONFIG_WLAN is not set
> > 
> > #
> > # WiMAX Wireless Broadband devices
> > #
> > 
> > #
> > # Enable USB support to see WiMAX USB drivers
> > #
> > # end of WiMAX Wireless Broadband devices
> > 
> > # CONFIG_WAN is not set
> > CONFIG_IEEE802154_DRIVERS=m
> > # CONFIG_VMXNET3 is not set
> > # CONFIG_FUJITSU_ES is not set
> > # CONFIG_NETDEVSIM is not set
> > CONFIG_NET_FAILOVER=y
> > CONFIG_ISDN=y
> > CONFIG_ISDN_CAPI=y
> > CONFIG_MISDN=y
> > # CONFIG_MISDN_DSP is not set
> > # CONFIG_MISDN_L1OIP is not set
> > 
> > #
> > # mISDN hardware drivers
> > #
> > # CONFIG_MISDN_HFCPCI is not set
> > # CONFIG_MISDN_HFCMULTI is not set
> > # CONFIG_MISDN_AVMFRITZ is not set
> > # CONFIG_MISDN_SPEEDFAX is not set
> > # CONFIG_MISDN_INFINEON is not set
> > # CONFIG_MISDN_W6692 is not set
> > # CONFIG_MISDN_NETJET is not set
> > CONFIG_NVM=y
> > # CONFIG_NVM_PBLK is not set
> > 
> > #
> > # Input device support
> > #
> > CONFIG_INPUT=y
> > CONFIG_INPUT_LEDS=m
> > # CONFIG_INPUT_FF_MEMLESS is not set
> > # CONFIG_INPUT_POLLDEV is not set
> > # CONFIG_INPUT_SPARSEKMAP is not set
> > # CONFIG_INPUT_MATRIXKMAP is not set
> > 
> > #
> > # Userland interfaces
> > #
> > # CONFIG_INPUT_MOUSEDEV is not set
> > # CONFIG_INPUT_JOYDEV is not set
> > # CONFIG_INPUT_EVDEV is not set
> > # CONFIG_INPUT_EVBUG is not set
> > 
> > #
> > # Input Device Drivers
> > #
> > CONFIG_INPUT_KEYBOARD=y
> > # CONFIG_KEYBOARD_ADC is not set
> > # CONFIG_KEYBOARD_ADP5588 is not set
> > # CONFIG_KEYBOARD_ADP5589 is not set
> > # CONFIG_KEYBOARD_APPLESPI is not set
> > CONFIG_KEYBOARD_ATKBD=y
> > # CONFIG_KEYBOARD_QT1050 is not set
> > # CONFIG_KEYBOARD_QT1070 is not set
> > # CONFIG_KEYBOARD_QT2160 is not set
> > # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> > # CONFIG_KEYBOARD_LKKBD is not set
> > # CONFIG_KEYBOARD_GPIO is not set
> > # CONFIG_KEYBOARD_GPIO_POLLED is not set
> > # CONFIG_KEYBOARD_TCA6416 is not set
> > # CONFIG_KEYBOARD_TCA8418 is not set
> > # CONFIG_KEYBOARD_MATRIX is not set
> > # CONFIG_KEYBOARD_LM8323 is not set
> > # CONFIG_KEYBOARD_LM8333 is not set
> > # CONFIG_KEYBOARD_MAX7359 is not set
> > # CONFIG_KEYBOARD_MCS is not set
> > # CONFIG_KEYBOARD_MPR121 is not set
> > # CONFIG_KEYBOARD_NEWTON is not set
> > # CONFIG_KEYBOARD_OPENCORES is not set
> > # CONFIG_KEYBOARD_SAMSUNG is not set
> > # CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
> > # CONFIG_KEYBOARD_STOWAWAY is not set
> > # CONFIG_KEYBOARD_SUNKBD is not set
> > # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> > # CONFIG_KEYBOARD_XTKBD is not set
> > # CONFIG_KEYBOARD_CROS_EC is not set
> > CONFIG_INPUT_MOUSE=y
> > CONFIG_MOUSE_PS2=y
> > CONFIG_MOUSE_PS2_ALPS=y
> > CONFIG_MOUSE_PS2_BYD=y
> > CONFIG_MOUSE_PS2_LOGIPS2PP=y
> > CONFIG_MOUSE_PS2_SYNAPTICS=y
> > CONFIG_MOUSE_PS2_CYPRESS=y
> > CONFIG_MOUSE_PS2_LIFEBOOK=y
> > CONFIG_MOUSE_PS2_TRACKPOINT=y
> > # CONFIG_MOUSE_PS2_ELANTECH is not set
> > # CONFIG_MOUSE_PS2_SENTELIC is not set
> > # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> > CONFIG_MOUSE_PS2_FOCALTECH=y
> > # CONFIG_MOUSE_PS2_VMMOUSE is not set
> > # CONFIG_MOUSE_SERIAL is not set
> > # CONFIG_MOUSE_APPLETOUCH is not set
> > # CONFIG_MOUSE_BCM5974 is not set
> > # CONFIG_MOUSE_CYAPA is not set
> > # CONFIG_MOUSE_ELAN_I2C is not set
> > # CONFIG_MOUSE_VSXXXAA is not set
> > # CONFIG_MOUSE_GPIO is not set
> > # CONFIG_MOUSE_SYNAPTICS_I2C is not set
> > # CONFIG_MOUSE_SYNAPTICS_USB is not set
> > # CONFIG_INPUT_JOYSTICK is not set
> > # CONFIG_INPUT_TABLET is not set
> > # CONFIG_INPUT_TOUCHSCREEN is not set
> > # CONFIG_INPUT_MISC is not set
> > # CONFIG_RMI4_CORE is not set
> > 
> > #
> > # Hardware I/O ports
> > #
> > CONFIG_SERIO=y
> > CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> > CONFIG_SERIO_I8042=y
> > CONFIG_SERIO_SERPORT=y
> > # CONFIG_SERIO_CT82C710 is not set
> > CONFIG_SERIO_PARKBD=m
> > # CONFIG_SERIO_PCIPS2 is not set
> > CONFIG_SERIO_LIBPS2=y
> > CONFIG_SERIO_RAW=m
> > CONFIG_SERIO_ALTERA_PS2=m
> > CONFIG_SERIO_PS2MULT=m
> > CONFIG_SERIO_ARC_PS2=m
> > # CONFIG_SERIO_GPIO_PS2 is not set
> > # CONFIG_USERIO is not set
> > CONFIG_GAMEPORT=y
> > CONFIG_GAMEPORT_NS558=y
> > CONFIG_GAMEPORT_L4=m
> > # CONFIG_GAMEPORT_EMU10K1 is not set
> > # CONFIG_GAMEPORT_FM801 is not set
> > # end of Hardware I/O ports
> > # end of Input device support
> > 
> > #
> > # Character devices
> > #
> > CONFIG_TTY=y
> > # CONFIG_VT is not set
> > CONFIG_UNIX98_PTYS=y
> > CONFIG_LEGACY_PTYS=y
> > CONFIG_LEGACY_PTY_COUNT=256
> > # CONFIG_SERIAL_NONSTANDARD is not set
> > # CONFIG_NOZOMI is not set
> > # CONFIG_N_GSM is not set
> > # CONFIG_TRACE_SINK is not set
> > # CONFIG_NULL_TTY is not set
> > # CONFIG_GOLDFISH_TTY is not set
> > CONFIG_LDISC_AUTOLOAD=y
> > CONFIG_DEVMEM=y
> > # CONFIG_DEVKMEM is not set
> > 
> > #
> > # Serial drivers
> > #
> > CONFIG_SERIAL_EARLYCON=y
> > CONFIG_SERIAL_8250=y
> > CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> > CONFIG_SERIAL_8250_PNP=y
> > # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> > # CONFIG_SERIAL_8250_FINTEK is not set
> > CONFIG_SERIAL_8250_CONSOLE=y
> > CONFIG_SERIAL_8250_PCI=y
> > CONFIG_SERIAL_8250_EXAR=y
> > # CONFIG_SERIAL_8250_CS is not set
> > # CONFIG_SERIAL_8250_MEN_MCB is not set
> > CONFIG_SERIAL_8250_NR_UARTS=4
> > CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> > # CONFIG_SERIAL_8250_EXTENDED is not set
> > CONFIG_SERIAL_8250_DWLIB=y
> > # CONFIG_SERIAL_8250_DW is not set
> > # CONFIG_SERIAL_8250_RT288X is not set
> > CONFIG_SERIAL_8250_LPSS=y
> > CONFIG_SERIAL_8250_MID=y
> > 
> > #
> > # Non-8250 serial port support
> > #
> > # CONFIG_SERIAL_MAX3100 is not set
> > # CONFIG_SERIAL_MAX310X is not set
> > # CONFIG_SERIAL_UARTLITE is not set
> > CONFIG_SERIAL_CORE=y
> > CONFIG_SERIAL_CORE_CONSOLE=y
> > # CONFIG_SERIAL_JSM is not set
> > # CONFIG_SERIAL_SCCNXP is not set
> > # CONFIG_SERIAL_SC16IS7XX is not set
> > # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> > # CONFIG_SERIAL_ALTERA_UART is not set
> > # CONFIG_SERIAL_IFX6X60 is not set
> > # CONFIG_SERIAL_ARC is not set
> > # CONFIG_SERIAL_RP2 is not set
> > # CONFIG_SERIAL_FSL_LPUART is not set
> > # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> > # CONFIG_SERIAL_MEN_Z135 is not set
> > # end of Serial drivers
> > 
> > CONFIG_SERIAL_MCTRL_GPIO=y
> > # CONFIG_SERIAL_DEV_BUS is not set
> > # CONFIG_TTY_PRINTK is not set
> > # CONFIG_PRINTER is not set
> > CONFIG_PPDEV=m
> > # CONFIG_VIRTIO_CONSOLE is not set
> > CONFIG_IPMI_HANDLER=m
> > CONFIG_IPMI_DMI_DECODE=y
> > CONFIG_IPMI_PLAT_DATA=y
> > # CONFIG_IPMI_PANIC_EVENT is not set
> > # CONFIG_IPMI_DEVICE_INTERFACE is not set
> > CONFIG_IPMI_SI=m
> > CONFIG_IPMI_SSIF=m
> > # CONFIG_IPMI_WATCHDOG is not set
> > CONFIG_IPMI_POWEROFF=m
> > # CONFIG_IPMB_DEVICE_INTERFACE is not set
> > # CONFIG_HW_RANDOM is not set
> > CONFIG_NVRAM=y
> > # CONFIG_APPLICOM is not set
> > 
> > #
> > # PCMCIA character devices
> > #
> > # CONFIG_SYNCLINK_CS is not set
> > CONFIG_CARDMAN_4000=m
> > CONFIG_CARDMAN_4040=m
> > CONFIG_SCR24X=m
> > # CONFIG_IPWIRELESS is not set
> > # end of PCMCIA character devices
> > 
> > # CONFIG_MWAVE is not set
> > # CONFIG_RAW_DRIVER is not set
> > # CONFIG_HPET is not set
> > CONFIG_HANGCHECK_TIMER=y
> > # CONFIG_TCG_TPM is not set
> > CONFIG_TELCLOCK=y
> > CONFIG_DEVPORT=y
> > # CONFIG_XILLYBUS is not set
> > # end of Character devices
> > 
> > # CONFIG_RANDOM_TRUST_CPU is not set
> > # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> > 
> > #
> > # I2C support
> > #
> > CONFIG_I2C=m
> > CONFIG_I2C_BOARDINFO=y
> > CONFIG_I2C_COMPAT=y
> > # CONFIG_I2C_CHARDEV is not set
> > CONFIG_I2C_MUX=m
> > 
> > #
> > # Multiplexer I2C Chip support
> > #
> > CONFIG_I2C_MUX_GPIO=m
> > # CONFIG_I2C_MUX_LTC4306 is not set
> > CONFIG_I2C_MUX_PCA9541=m
> > # CONFIG_I2C_MUX_PCA954x is not set
> > # CONFIG_I2C_MUX_REG is not set
> > # CONFIG_I2C_MUX_MLXCPLD is not set
> > # end of Multiplexer I2C Chip support
> > 
> > # CONFIG_I2C_HELPER_AUTO is not set
> > CONFIG_I2C_SMBUS=m
> > 
> > #
> > # I2C Algorithms
> > #
> > CONFIG_I2C_ALGOBIT=m
> > CONFIG_I2C_ALGOPCF=m
> > CONFIG_I2C_ALGOPCA=m
> > # end of I2C Algorithms
> > 
> > #
> > # I2C Hardware Bus support
> > #
> > 
> > #
> > # PC SMBus host controller drivers
> > #
> > # CONFIG_I2C_ALI1535 is not set
> > # CONFIG_I2C_ALI1563 is not set
> > # CONFIG_I2C_ALI15X3 is not set
> > # CONFIG_I2C_AMD756 is not set
> > # CONFIG_I2C_AMD8111 is not set
> > # CONFIG_I2C_AMD_MP2 is not set
> > # CONFIG_I2C_I801 is not set
> > # CONFIG_I2C_ISCH is not set
> > # CONFIG_I2C_ISMT is not set
> > # CONFIG_I2C_PIIX4 is not set
> > # CONFIG_I2C_NFORCE2 is not set
> > # CONFIG_I2C_NVIDIA_GPU is not set
> > # CONFIG_I2C_SIS5595 is not set
> > # CONFIG_I2C_SIS630 is not set
> > # CONFIG_I2C_SIS96X is not set
> > # CONFIG_I2C_VIA is not set
> > # CONFIG_I2C_VIAPRO is not set
> > 
> > #
> > # ACPI drivers
> > #
> > # CONFIG_I2C_SCMI is not set
> > 
> > #
> > # I2C system bus drivers (mostly embedded / system-on-chip)
> > #
> > # CONFIG_I2C_CBUS_GPIO is not set
> > CONFIG_I2C_DESIGNWARE_CORE=m
> > CONFIG_I2C_DESIGNWARE_PLATFORM=m
> > # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> > # CONFIG_I2C_DESIGNWARE_PCI is not set
> > # CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
> > # CONFIG_I2C_EMEV2 is not set
> > CONFIG_I2C_GPIO=m
> > # CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
> > # CONFIG_I2C_KEMPLD is not set
> > CONFIG_I2C_OCORES=m
> > CONFIG_I2C_PCA_PLATFORM=m
> > CONFIG_I2C_SIMTEC=m
> > CONFIG_I2C_XILINX=m
> > 
> > #
> > # External I2C/SMBus adapter drivers
> > #
> > CONFIG_I2C_PARPORT=m
> > # CONFIG_I2C_TAOS_EVM is not set
> > 
> > #
> > # Other I2C/SMBus bus drivers
> > #
> > CONFIG_I2C_MLXCPLD=m
> > CONFIG_I2C_CROS_EC_TUNNEL=m
> > # end of I2C Hardware Bus support
> > 
> > CONFIG_I2C_STUB=m
> > CONFIG_I2C_SLAVE=y
> > CONFIG_I2C_SLAVE_EEPROM=m
> > # CONFIG_I2C_DEBUG_CORE is not set
> > # CONFIG_I2C_DEBUG_ALGO is not set
> > # CONFIG_I2C_DEBUG_BUS is not set
> > # end of I2C support
> > 
> > # CONFIG_I3C is not set
> > CONFIG_SPI=y
> > CONFIG_SPI_DEBUG=y
> > CONFIG_SPI_MASTER=y
> > CONFIG_SPI_MEM=y
> > 
> > #
> > # SPI Master Controller Drivers
> > #
> > CONFIG_SPI_ALTERA=y
> > # CONFIG_SPI_AXI_SPI_ENGINE is not set
> > CONFIG_SPI_BITBANG=y
> > CONFIG_SPI_BUTTERFLY=y
> > CONFIG_SPI_CADENCE=m
> > CONFIG_SPI_DESIGNWARE=m
> > # CONFIG_SPI_DW_PCI is not set
> > # CONFIG_SPI_DW_MMIO is not set
> > # CONFIG_SPI_NXP_FLEXSPI is not set
> > # CONFIG_SPI_GPIO is not set
> > CONFIG_SPI_LM70_LLP=y
> > # CONFIG_SPI_OC_TINY is not set
> > # CONFIG_SPI_PXA2XX is not set
> > # CONFIG_SPI_ROCKCHIP is not set
> > # CONFIG_SPI_SC18IS602 is not set
> > # CONFIG_SPI_SIFIVE is not set
> > # CONFIG_SPI_MXIC is not set
> > # CONFIG_SPI_XCOMM is not set
> > CONFIG_SPI_XILINX=y
> > CONFIG_SPI_ZYNQMP_GQSPI=y
> > 
> > #
> > # SPI Protocol Masters
> > #
> > # CONFIG_SPI_SPIDEV is not set
> > # CONFIG_SPI_LOOPBACK_TEST is not set
> > # CONFIG_SPI_TLE62X0 is not set
> > # CONFIG_SPI_SLAVE is not set
> > CONFIG_SPMI=y
> > CONFIG_HSI=y
> > CONFIG_HSI_BOARDINFO=y
> > 
> > #
> > # HSI controllers
> > #
> > 
> > #
> > # HSI clients
> > #
> > CONFIG_HSI_CHAR=y
> > # CONFIG_PPS is not set
> > 
> > #
> > # PTP clock support
> > #
> > # CONFIG_PTP_1588_CLOCK is not set
> > # end of PTP clock support
> > 
> > # CONFIG_PINCTRL is not set
> > CONFIG_GPIOLIB=y
> > CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> > CONFIG_GPIO_ACPI=y
> > CONFIG_GPIOLIB_IRQCHIP=y
> > CONFIG_DEBUG_GPIO=y
> > CONFIG_GPIO_SYSFS=y
> > CONFIG_GPIO_GENERIC=m
> > CONFIG_GPIO_MAX730X=y
> > 
> > #
> > # Memory mapped GPIO drivers
> > #
> > # CONFIG_GPIO_AMDPT is not set
> > CONFIG_GPIO_DWAPB=m
> > # CONFIG_GPIO_EXAR is not set
> > # CONFIG_GPIO_GENERIC_PLATFORM is not set
> > # CONFIG_GPIO_ICH is not set
> > # CONFIG_GPIO_MB86S7X is not set
> > # CONFIG_GPIO_MENZ127 is not set
> > # CONFIG_GPIO_VX855 is not set
> > # CONFIG_GPIO_XILINX is not set
> > # CONFIG_GPIO_AMD_FCH is not set
> > # end of Memory mapped GPIO drivers
> > 
> > #
> > # Port-mapped I/O GPIO drivers
> > #
> > CONFIG_GPIO_104_DIO_48E=y
> > # CONFIG_GPIO_104_IDIO_16 is not set
> > # CONFIG_GPIO_104_IDI_48 is not set
> > # CONFIG_GPIO_F7188X is not set
> > CONFIG_GPIO_GPIO_MM=y
> > CONFIG_GPIO_IT87=y
> > # CONFIG_GPIO_SCH is not set
> > CONFIG_GPIO_SCH311X=m
> > # CONFIG_GPIO_WINBOND is not set
> > CONFIG_GPIO_WS16C48=y
> > # end of Port-mapped I/O GPIO drivers
> > 
> > #
> > # I2C GPIO expanders
> > #
> > CONFIG_GPIO_ADP5588=m
> > CONFIG_GPIO_MAX7300=m
> > CONFIG_GPIO_MAX732X=m
> > # CONFIG_GPIO_PCA953X is not set
> > # CONFIG_GPIO_PCF857X is not set
> > # CONFIG_GPIO_TPIC2810 is not set
> > # end of I2C GPIO expanders
> > 
> > #
> > # MFD GPIO expanders
> > #
> > # CONFIG_GPIO_BD9571MWV is not set
> > CONFIG_GPIO_KEMPLD=m
> > # CONFIG_GPIO_LP873X is not set
> > CONFIG_GPIO_TPS65086=m
> > # CONFIG_GPIO_TPS65912 is not set
> > CONFIG_GPIO_UCB1400=m
> > CONFIG_GPIO_WM831X=m
> > # end of MFD GPIO expanders
> > 
> > #
> > # PCI GPIO expanders
> > #
> > # CONFIG_GPIO_AMD8111 is not set
> > # CONFIG_GPIO_BT8XX is not set
> > # CONFIG_GPIO_ML_IOH is not set
> > # CONFIG_GPIO_PCI_IDIO_16 is not set
> > # CONFIG_GPIO_PCIE_IDIO_24 is not set
> > # CONFIG_GPIO_RDC321X is not set
> > # end of PCI GPIO expanders
> > 
> > #
> > # SPI GPIO expanders
> > #
> > # CONFIG_GPIO_MAX3191X is not set
> > CONFIG_GPIO_MAX7301=y
> > CONFIG_GPIO_MC33880=m
> > CONFIG_GPIO_PISOSR=m
> > CONFIG_GPIO_XRA1403=y
> > # end of SPI GPIO expanders
> > 
> > CONFIG_GPIO_MOCKUP=y
> > CONFIG_W1=y
> > 
> > #
> > # 1-wire Bus Masters
> > #
> > # CONFIG_W1_MASTER_MATROX is not set
> > # CONFIG_W1_MASTER_DS2482 is not set
> > CONFIG_W1_MASTER_DS1WM=m
> > CONFIG_W1_MASTER_GPIO=y
> > # CONFIG_W1_MASTER_SGI is not set
> > # end of 1-wire Bus Masters
> > 
> > #
> > # 1-wire Slaves
> > #
> > CONFIG_W1_SLAVE_THERM=m
> > # CONFIG_W1_SLAVE_SMEM is not set
> > CONFIG_W1_SLAVE_DS2405=m
> > # CONFIG_W1_SLAVE_DS2408 is not set
> > # CONFIG_W1_SLAVE_DS2413 is not set
> > # CONFIG_W1_SLAVE_DS2406 is not set
> > CONFIG_W1_SLAVE_DS2423=y
> > CONFIG_W1_SLAVE_DS2805=y
> > # CONFIG_W1_SLAVE_DS2430 is not set
> > CONFIG_W1_SLAVE_DS2431=y
> > # CONFIG_W1_SLAVE_DS2433 is not set
> > CONFIG_W1_SLAVE_DS2438=m
> > # CONFIG_W1_SLAVE_DS250X is not set
> > CONFIG_W1_SLAVE_DS2780=y
> > CONFIG_W1_SLAVE_DS2781=y
> > CONFIG_W1_SLAVE_DS28E04=m
> > # CONFIG_W1_SLAVE_DS28E17 is not set
> > # end of 1-wire Slaves
> > 
> > CONFIG_POWER_AVS=y
> > # CONFIG_QCOM_CPR is not set
> > CONFIG_POWER_RESET=y
> > # CONFIG_POWER_RESET_RESTART is not set
> > CONFIG_POWER_SUPPLY=y
> > CONFIG_POWER_SUPPLY_DEBUG=y
> > CONFIG_POWER_SUPPLY_HWMON=y
> > CONFIG_PDA_POWER=y
> > CONFIG_GENERIC_ADC_BATTERY=m
> > CONFIG_WM831X_BACKUP=y
> > # CONFIG_WM831X_POWER is not set
> > # CONFIG_TEST_POWER is not set
> > # CONFIG_CHARGER_ADP5061 is not set
> > CONFIG_BATTERY_DS2760=m
> > # CONFIG_BATTERY_DS2780 is not set
> > CONFIG_BATTERY_DS2781=y
> > CONFIG_BATTERY_DS2782=m
> > CONFIG_BATTERY_SBS=m
> > CONFIG_CHARGER_SBS=m
> > # CONFIG_MANAGER_SBS is not set
> > # CONFIG_BATTERY_BQ27XXX is not set
> > CONFIG_BATTERY_DA9150=m
> > # CONFIG_BATTERY_MAX17040 is not set
> > # CONFIG_BATTERY_MAX17042 is not set
> > CONFIG_BATTERY_MAX1721X=m
> > # CONFIG_CHARGER_MAX8903 is not set
> > CONFIG_CHARGER_LP8727=m
> > CONFIG_CHARGER_GPIO=y
> > # CONFIG_CHARGER_MANAGER is not set
> > # CONFIG_CHARGER_LT3651 is not set
> > CONFIG_CHARGER_MAX14577=m
> > CONFIG_CHARGER_MAX77693=m
> > # CONFIG_CHARGER_BQ2415X is not set
> > # CONFIG_CHARGER_BQ24257 is not set
> > CONFIG_CHARGER_BQ24735=m
> > # CONFIG_CHARGER_BQ25890 is not set
> > CONFIG_CHARGER_SMB347=m
> > CONFIG_BATTERY_GAUGE_LTC2941=m
> > # CONFIG_BATTERY_GOLDFISH is not set
> > CONFIG_BATTERY_RT5033=m
> > CONFIG_CHARGER_RT9455=m
> > # CONFIG_CHARGER_CROS_USBPD is not set
> > CONFIG_HWMON=y
> > CONFIG_HWMON_VID=y
> > # CONFIG_HWMON_DEBUG_CHIP is not set
> > 
> > #
> > # Native drivers
> > #
> > CONFIG_SENSORS_ABITUGURU=y
> > # CONFIG_SENSORS_ABITUGURU3 is not set
> > # CONFIG_SENSORS_AD7314 is not set
> > CONFIG_SENSORS_AD7414=m
> > # CONFIG_SENSORS_AD7418 is not set
> > CONFIG_SENSORS_ADM1021=m
> > CONFIG_SENSORS_ADM1025=m
> > # CONFIG_SENSORS_ADM1026 is not set
> > CONFIG_SENSORS_ADM1029=m
> > CONFIG_SENSORS_ADM1031=m
> > # CONFIG_SENSORS_ADM1177 is not set
> > CONFIG_SENSORS_ADM9240=m
> > CONFIG_SENSORS_ADT7X10=m
> > CONFIG_SENSORS_ADT7310=m
> > # CONFIG_SENSORS_ADT7410 is not set
> > # CONFIG_SENSORS_ADT7411 is not set
> > # CONFIG_SENSORS_ADT7462 is not set
> > CONFIG_SENSORS_ADT7470=m
> > CONFIG_SENSORS_ADT7475=m
> > # CONFIG_SENSORS_AS370 is not set
> > CONFIG_SENSORS_ASC7621=m
> > # CONFIG_SENSORS_K8TEMP is not set
> > # CONFIG_SENSORS_K10TEMP is not set
> > # CONFIG_SENSORS_FAM15H_POWER is not set
> > # CONFIG_SENSORS_APPLESMC is not set
> > CONFIG_SENSORS_ASB100=m
> > CONFIG_SENSORS_ASPEED=m
> > # CONFIG_SENSORS_ATXP1 is not set
> > # CONFIG_SENSORS_DS620 is not set
> > CONFIG_SENSORS_DS1621=m
> > # CONFIG_SENSORS_DELL_SMM is not set
> > # CONFIG_SENSORS_I5K_AMB is not set
> > CONFIG_SENSORS_F71805F=m
> > # CONFIG_SENSORS_F71882FG is not set
> > CONFIG_SENSORS_F75375S=m
> > CONFIG_SENSORS_MC13783_ADC=m
> > CONFIG_SENSORS_FSCHMD=m
> > CONFIG_SENSORS_FTSTEUTATES=m
> > CONFIG_SENSORS_GL518SM=m
> > CONFIG_SENSORS_GL520SM=m
> > # CONFIG_SENSORS_G760A is not set
> > # CONFIG_SENSORS_G762 is not set
> > CONFIG_SENSORS_HIH6130=m
> > CONFIG_SENSORS_IBMAEM=m
> > # CONFIG_SENSORS_IBMPEX is not set
> > CONFIG_SENSORS_IIO_HWMON=m
> > # CONFIG_SENSORS_I5500 is not set
> > CONFIG_SENSORS_CORETEMP=m
> > CONFIG_SENSORS_IT87=y
> > CONFIG_SENSORS_JC42=m
> > CONFIG_SENSORS_POWR1220=m
> > CONFIG_SENSORS_LINEAGE=m
> > CONFIG_SENSORS_LTC2945=m
> > # CONFIG_SENSORS_LTC2947_I2C is not set
> > # CONFIG_SENSORS_LTC2947_SPI is not set
> > CONFIG_SENSORS_LTC2990=m
> > CONFIG_SENSORS_LTC4151=m
> > CONFIG_SENSORS_LTC4215=m
> > CONFIG_SENSORS_LTC4222=m
> > CONFIG_SENSORS_LTC4245=m
> > CONFIG_SENSORS_LTC4260=m
> > CONFIG_SENSORS_LTC4261=m
> > # CONFIG_SENSORS_MAX1111 is not set
> > CONFIG_SENSORS_MAX16065=m
> > CONFIG_SENSORS_MAX1619=m
> > CONFIG_SENSORS_MAX1668=m
> > CONFIG_SENSORS_MAX197=y
> > CONFIG_SENSORS_MAX31722=y
> > # CONFIG_SENSORS_MAX31730 is not set
> > # CONFIG_SENSORS_MAX6621 is not set
> > CONFIG_SENSORS_MAX6639=m
> > CONFIG_SENSORS_MAX6642=m
> > # CONFIG_SENSORS_MAX6650 is not set
> > CONFIG_SENSORS_MAX6697=m
> > CONFIG_SENSORS_MAX31790=m
> > CONFIG_SENSORS_MCP3021=m
> > CONFIG_SENSORS_TC654=m
> > CONFIG_SENSORS_ADCXX=m
> > CONFIG_SENSORS_LM63=m
> > # CONFIG_SENSORS_LM70 is not set
> > CONFIG_SENSORS_LM73=m
> > CONFIG_SENSORS_LM75=m
> > # CONFIG_SENSORS_LM77 is not set
> > CONFIG_SENSORS_LM78=m
> > CONFIG_SENSORS_LM80=m
> > # CONFIG_SENSORS_LM83 is not set
> > # CONFIG_SENSORS_LM85 is not set
> > # CONFIG_SENSORS_LM87 is not set
> > # CONFIG_SENSORS_LM90 is not set
> > # CONFIG_SENSORS_LM92 is not set
> > CONFIG_SENSORS_LM93=m
> > CONFIG_SENSORS_LM95234=m
> > # CONFIG_SENSORS_LM95241 is not set
> > CONFIG_SENSORS_LM95245=m
> > CONFIG_SENSORS_PC87360=m
> > # CONFIG_SENSORS_PC87427 is not set
> > # CONFIG_SENSORS_NTC_THERMISTOR is not set
> > CONFIG_SENSORS_NCT6683=y
> > CONFIG_SENSORS_NCT6775=y
> > CONFIG_SENSORS_NCT7802=m
> > CONFIG_SENSORS_NCT7904=m
> > # CONFIG_SENSORS_NPCM7XX is not set
> > CONFIG_SENSORS_PCF8591=m
> > CONFIG_PMBUS=m
> > CONFIG_SENSORS_PMBUS=m
> > CONFIG_SENSORS_ADM1275=m
> > # CONFIG_SENSORS_BEL_PFE is not set
> > CONFIG_SENSORS_IBM_CFFPS=m
> > # CONFIG_SENSORS_INSPUR_IPSPS is not set
> > CONFIG_SENSORS_IR35221=m
> > # CONFIG_SENSORS_IR38064 is not set
> > # CONFIG_SENSORS_IRPS5401 is not set
> > # CONFIG_SENSORS_ISL68137 is not set
> > # CONFIG_SENSORS_LM25066 is not set
> > CONFIG_SENSORS_LTC2978=m
> > CONFIG_SENSORS_LTC2978_REGULATOR=y
> > CONFIG_SENSORS_LTC3815=m
> > CONFIG_SENSORS_MAX16064=m
> > # CONFIG_SENSORS_MAX20730 is not set
> > CONFIG_SENSORS_MAX20751=m
> > # CONFIG_SENSORS_MAX31785 is not set
> > # CONFIG_SENSORS_MAX34440 is not set
> > # CONFIG_SENSORS_MAX8688 is not set
> > # CONFIG_SENSORS_PXE1610 is not set
> > CONFIG_SENSORS_TPS40422=m
> > # CONFIG_SENSORS_TPS53679 is not set
> > CONFIG_SENSORS_UCD9000=m
> > CONFIG_SENSORS_UCD9200=m
> > # CONFIG_SENSORS_XDPE122 is not set
> > # CONFIG_SENSORS_ZL6100 is not set
> > CONFIG_SENSORS_SHT15=y
> > # CONFIG_SENSORS_SHT21 is not set
> > # CONFIG_SENSORS_SHT3x is not set
> > # CONFIG_SENSORS_SHTC1 is not set
> > # CONFIG_SENSORS_SIS5595 is not set
> > CONFIG_SENSORS_DME1737=m
> > CONFIG_SENSORS_EMC1403=m
> > # CONFIG_SENSORS_EMC2103 is not set
> > CONFIG_SENSORS_EMC6W201=m
> > CONFIG_SENSORS_SMSC47M1=y
> > CONFIG_SENSORS_SMSC47M192=m
> > # CONFIG_SENSORS_SMSC47B397 is not set
> > CONFIG_SENSORS_SCH56XX_COMMON=y
> > CONFIG_SENSORS_SCH5627=m
> > CONFIG_SENSORS_SCH5636=y
> > CONFIG_SENSORS_STTS751=m
> > CONFIG_SENSORS_SMM665=m
> > CONFIG_SENSORS_ADC128D818=m
> > CONFIG_SENSORS_ADS7828=m
> > CONFIG_SENSORS_ADS7871=y
> > CONFIG_SENSORS_AMC6821=m
> > # CONFIG_SENSORS_INA209 is not set
> > # CONFIG_SENSORS_INA2XX is not set
> > CONFIG_SENSORS_INA3221=m
> > CONFIG_SENSORS_TC74=m
> > # CONFIG_SENSORS_THMC50 is not set
> > # CONFIG_SENSORS_TMP102 is not set
> > # CONFIG_SENSORS_TMP103 is not set
> > # CONFIG_SENSORS_TMP108 is not set
> > CONFIG_SENSORS_TMP401=m
> > # CONFIG_SENSORS_TMP421 is not set
> > # CONFIG_SENSORS_TMP513 is not set
> > # CONFIG_SENSORS_VIA_CPUTEMP is not set
> > # CONFIG_SENSORS_VIA686A is not set
> > CONFIG_SENSORS_VT1211=m
> > # CONFIG_SENSORS_VT8231 is not set
> > # CONFIG_SENSORS_W83773G is not set
> > CONFIG_SENSORS_W83781D=m
> > CONFIG_SENSORS_W83791D=m
> > CONFIG_SENSORS_W83792D=m
> > CONFIG_SENSORS_W83793=m
> > CONFIG_SENSORS_W83795=m
> > # CONFIG_SENSORS_W83795_FANCTRL is not set
> > CONFIG_SENSORS_W83L785TS=m
> > # CONFIG_SENSORS_W83L786NG is not set
> > CONFIG_SENSORS_W83627HF=m
> > CONFIG_SENSORS_W83627EHF=y
> > # CONFIG_SENSORS_WM831X is not set
> > 
> > #
> > # ACPI drivers
> > #
> > # CONFIG_SENSORS_ACPI_POWER is not set
> > # CONFIG_SENSORS_ATK0110 is not set
> > CONFIG_THERMAL=y
> > # CONFIG_THERMAL_STATISTICS is not set
> > CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> > CONFIG_THERMAL_HWMON=y
> > CONFIG_THERMAL_WRITABLE_TRIPS=y
> > CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> > # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> > # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> > # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
> > CONFIG_THERMAL_GOV_STEP_WISE=y
> > # CONFIG_THERMAL_GOV_BANG_BANG is not set
> > CONFIG_THERMAL_GOV_USER_SPACE=y
> > # CONFIG_THERMAL_EMULATION is not set
> > 
> > #
> > # Intel thermal drivers
> > #
> > CONFIG_INTEL_POWERCLAMP=y
> > # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> > 
> > #
> > # ACPI INT340X thermal drivers
> > #
> > # CONFIG_INT340X_THERMAL is not set
> > # end of ACPI INT340X thermal drivers
> > 
> > # CONFIG_INTEL_PCH_THERMAL is not set
> > # end of Intel thermal drivers
> > 
> > CONFIG_GENERIC_ADC_THERMAL=m
> > CONFIG_WATCHDOG=y
> > CONFIG_WATCHDOG_CORE=y
> > CONFIG_WATCHDOG_NOWAYOUT=y
> > # CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
> > CONFIG_WATCHDOG_OPEN_TIMEOUT=0
> > # CONFIG_WATCHDOG_SYSFS is not set
> > 
> > #
> > # Watchdog Pretimeout Governors
> > #
> > # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
> > 
> > #
> > # Watchdog Device Drivers
> > #
> > CONFIG_SOFT_WATCHDOG=y
> > CONFIG_DA9063_WATCHDOG=m
> > # CONFIG_MENZ069_WATCHDOG is not set
> > # CONFIG_WDAT_WDT is not set
> > CONFIG_WM831X_WATCHDOG=y
> > # CONFIG_XILINX_WATCHDOG is not set
> > CONFIG_ZIIRAVE_WATCHDOG=m
> > CONFIG_CADENCE_WATCHDOG=m
> > # CONFIG_DW_WATCHDOG is not set
> > CONFIG_MAX63XX_WATCHDOG=m
> > CONFIG_RETU_WATCHDOG=m
> > # CONFIG_ACQUIRE_WDT is not set
> > CONFIG_ADVANTECH_WDT=y
> > # CONFIG_ALIM1535_WDT is not set
> > # CONFIG_ALIM7101_WDT is not set
> > CONFIG_EBC_C384_WDT=m
> > # CONFIG_F71808E_WDT is not set
> > # CONFIG_SP5100_TCO is not set
> > # CONFIG_SBC_FITPC2_WATCHDOG is not set
> > # CONFIG_EUROTECH_WDT is not set
> > CONFIG_IB700_WDT=m
> > # CONFIG_IBMASR is not set
> > CONFIG_WAFER_WDT=y
> > # CONFIG_I6300ESB_WDT is not set
> > # CONFIG_IE6XX_WDT is not set
> > # CONFIG_ITCO_WDT is not set
> > CONFIG_IT8712F_WDT=y
> > CONFIG_IT87_WDT=y
> > # CONFIG_HP_WATCHDOG is not set
> > CONFIG_KEMPLD_WDT=y
> > # CONFIG_SC1200_WDT is not set
> > # CONFIG_PC87413_WDT is not set
> > # CONFIG_NV_TCO is not set
> > # CONFIG_60XX_WDT is not set
> > CONFIG_CPU5_WDT=y
> > CONFIG_SMSC_SCH311X_WDT=y
> > CONFIG_SMSC37B787_WDT=y
> > # CONFIG_TQMX86_WDT is not set
> > # CONFIG_VIA_WDT is not set
> > # CONFIG_W83627HF_WDT is not set
> > CONFIG_W83877F_WDT=y
> > # CONFIG_W83977F_WDT is not set
> > CONFIG_MACHZ_WDT=y
> > # CONFIG_SBC_EPX_C3_WATCHDOG is not set
> > # CONFIG_NI903X_WDT is not set
> > # CONFIG_NIC7018_WDT is not set
> > # CONFIG_MEN_A21_WDT is not set
> > 
> > #
> > # PCI-based Watchdog Cards
> > #
> > # CONFIG_PCIPCWATCHDOG is not set
> > # CONFIG_WDTPCI is not set
> > CONFIG_SSB_POSSIBLE=y
> > CONFIG_SSB=m
> > CONFIG_SSB_SPROM=y
> > CONFIG_SSB_PCIHOST_POSSIBLE=y
> > CONFIG_SSB_PCIHOST=y
> > CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
> > CONFIG_SSB_PCMCIAHOST=y
> > CONFIG_SSB_SDIOHOST_POSSIBLE=y
> > # CONFIG_SSB_SDIOHOST is not set
> > CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
> > # CONFIG_SSB_DRIVER_PCICORE is not set
> > CONFIG_SSB_DRIVER_GPIO=y
> > CONFIG_BCMA_POSSIBLE=y
> > # CONFIG_BCMA is not set
> > 
> > #
> > # Multifunction device drivers
> > #
> > CONFIG_MFD_CORE=y
> > CONFIG_MFD_BCM590XX=m
> > CONFIG_MFD_BD9571MWV=m
> > # CONFIG_MFD_AXP20X_I2C is not set
> > CONFIG_MFD_CROS_EC_DEV=y
> > # CONFIG_MFD_MADERA is not set
> > # CONFIG_MFD_DA9052_SPI is not set
> > # CONFIG_MFD_DA9062 is not set
> > CONFIG_MFD_DA9063=m
> > CONFIG_MFD_DA9150=m
> > CONFIG_MFD_MC13XXX=m
> > # CONFIG_MFD_MC13XXX_SPI is not set
> > CONFIG_MFD_MC13XXX_I2C=m
> > CONFIG_HTC_PASIC3=m
> > # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> > # CONFIG_LPC_ICH is not set
> > # CONFIG_LPC_SCH is not set
> > # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> > # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> > # CONFIG_MFD_INTEL_LPSS_PCI is not set
> > # CONFIG_MFD_JANZ_CMODIO is not set
> > CONFIG_MFD_KEMPLD=y
> > CONFIG_MFD_88PM800=m
> > CONFIG_MFD_88PM805=m
> > CONFIG_MFD_MAX14577=m
> > CONFIG_MFD_MAX77693=m
> > CONFIG_MFD_MAX8907=m
> > # CONFIG_MFD_MT6397 is not set
> > # CONFIG_MFD_MENF21BMC is not set
> > CONFIG_EZX_PCAP=y
> > CONFIG_MFD_RETU=m
> > # CONFIG_MFD_PCF50633 is not set
> > CONFIG_UCB1400_CORE=m
> > # CONFIG_MFD_RDC321X is not set
> > CONFIG_MFD_RT5033=m
> > # CONFIG_MFD_SI476X_CORE is not set
> > # CONFIG_MFD_SM501 is not set
> > CONFIG_MFD_SKY81452=m
> > CONFIG_ABX500_CORE=y
> > CONFIG_MFD_SYSCON=y
> > CONFIG_MFD_TI_AM335X_TSCADC=y
> > # CONFIG_MFD_LP3943 is not set
> > CONFIG_MFD_TI_LMU=m
> > CONFIG_TPS6105X=m
> > # CONFIG_TPS65010 is not set
> > CONFIG_TPS6507X=m
> > CONFIG_MFD_TPS65086=m
> > CONFIG_MFD_TI_LP873X=m
> > CONFIG_MFD_TPS65912=m
> > CONFIG_MFD_TPS65912_I2C=m
> > CONFIG_MFD_TPS65912_SPI=m
> > CONFIG_MFD_WL1273_CORE=m
> > CONFIG_MFD_LM3533=m
> > # CONFIG_MFD_TQMX86 is not set
> > # CONFIG_MFD_VX855 is not set
> > # CONFIG_MFD_ARIZONA_I2C is not set
> > # CONFIG_MFD_ARIZONA_SPI is not set
> > CONFIG_MFD_WM831X=y
> > CONFIG_MFD_WM831X_SPI=y
> > # CONFIG_MFD_WM8994 is not set
> > # end of Multifunction device drivers
> > 
> > CONFIG_REGULATOR=y
> > # CONFIG_REGULATOR_DEBUG is not set
> > CONFIG_REGULATOR_FIXED_VOLTAGE=y
> > # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
> > # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> > # CONFIG_REGULATOR_88PG86X is not set
> > # CONFIG_REGULATOR_88PM800 is not set
> > # CONFIG_REGULATOR_ACT8865 is not set
> > CONFIG_REGULATOR_AD5398=m
> > CONFIG_REGULATOR_ANATOP=y
> > CONFIG_REGULATOR_BCM590XX=m
> > # CONFIG_REGULATOR_BD9571MWV is not set
> > CONFIG_REGULATOR_DA9210=m
> > CONFIG_REGULATOR_DA9211=m
> > CONFIG_REGULATOR_FAN53555=m
> > # CONFIG_REGULATOR_GPIO is not set
> > CONFIG_REGULATOR_ISL9305=m
> > CONFIG_REGULATOR_ISL6271A=m
> > CONFIG_REGULATOR_LM363X=m
> > CONFIG_REGULATOR_LP3971=m
> > CONFIG_REGULATOR_LP3972=m
> > # CONFIG_REGULATOR_LP872X is not set
> > # CONFIG_REGULATOR_LP8755 is not set
> > # CONFIG_REGULATOR_LTC3589 is not set
> > # CONFIG_REGULATOR_LTC3676 is not set
> > CONFIG_REGULATOR_MAX14577=m
> > CONFIG_REGULATOR_MAX1586=m
> > CONFIG_REGULATOR_MAX8649=m
> > CONFIG_REGULATOR_MAX8660=m
> > # CONFIG_REGULATOR_MAX8907 is not set
> > CONFIG_REGULATOR_MAX8952=m
> > CONFIG_REGULATOR_MAX77693=m
> > CONFIG_REGULATOR_MC13XXX_CORE=m
> > # CONFIG_REGULATOR_MC13783 is not set
> > CONFIG_REGULATOR_MC13892=m
> > # CONFIG_REGULATOR_MP8859 is not set
> > # CONFIG_REGULATOR_MT6311 is not set
> > CONFIG_REGULATOR_PCAP=y
> > # CONFIG_REGULATOR_PFUZE100 is not set
> > # CONFIG_REGULATOR_PV88060 is not set
> > # CONFIG_REGULATOR_PV88080 is not set
> > CONFIG_REGULATOR_PV88090=m
> > # CONFIG_REGULATOR_QCOM_SPMI is not set
> > CONFIG_REGULATOR_RT5033=m
> > CONFIG_REGULATOR_SKY81452=m
> > # CONFIG_REGULATOR_SLG51000 is not set
> > CONFIG_REGULATOR_TPS51632=m
> > CONFIG_REGULATOR_TPS6105X=m
> > CONFIG_REGULATOR_TPS62360=m
> > CONFIG_REGULATOR_TPS65023=m
> > CONFIG_REGULATOR_TPS6507X=m
> > CONFIG_REGULATOR_TPS65086=m
> > CONFIG_REGULATOR_TPS65132=m
> > CONFIG_REGULATOR_TPS6524X=m
> > CONFIG_REGULATOR_TPS65912=m
> > CONFIG_REGULATOR_WM831X=y
> > CONFIG_RC_CORE=m
> > CONFIG_RC_MAP=m
> > CONFIG_LIRC=y
> > CONFIG_RC_DECODERS=y
> > CONFIG_IR_NEC_DECODER=m
> > CONFIG_IR_RC5_DECODER=m
> > CONFIG_IR_RC6_DECODER=m
> > CONFIG_IR_JVC_DECODER=m
> > CONFIG_IR_SONY_DECODER=m
> > CONFIG_IR_SANYO_DECODER=m
> > CONFIG_IR_SHARP_DECODER=m
> > CONFIG_IR_MCE_KBD_DECODER=m
> > CONFIG_IR_XMP_DECODER=m
> > CONFIG_IR_IMON_DECODER=m
> > # CONFIG_IR_RCMM_DECODER is not set
> > CONFIG_RC_DEVICES=y
> > # CONFIG_RC_ATI_REMOTE is not set
> > # CONFIG_IR_ENE is not set
> > # CONFIG_IR_IMON is not set
> > # CONFIG_IR_IMON_RAW is not set
> > # CONFIG_IR_MCEUSB is not set
> > # CONFIG_IR_ITE_CIR is not set
> > # CONFIG_IR_FINTEK is not set
> > # CONFIG_IR_NUVOTON is not set
> > # CONFIG_IR_REDRAT3 is not set
> > # CONFIG_IR_STREAMZAP is not set
> > # CONFIG_IR_WINBOND_CIR is not set
> > # CONFIG_IR_IGORPLUGUSB is not set
> > # CONFIG_IR_IGUANA is not set
> > # CONFIG_IR_TTUSBIR is not set
> > CONFIG_RC_LOOPBACK=m
> > # CONFIG_IR_SERIAL is not set
> > # CONFIG_IR_SIR is not set
> > # CONFIG_RC_XBOX_DVD is not set
> > CONFIG_MEDIA_SUPPORT=m
> > 
> > #
> > # Multimedia core support
> > #
> > # CONFIG_MEDIA_CAMERA_SUPPORT is not set
> > CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
> > CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> > CONFIG_MEDIA_RADIO_SUPPORT=y
> > CONFIG_MEDIA_SDR_SUPPORT=y
> > CONFIG_MEDIA_CEC_SUPPORT=y
> > # CONFIG_MEDIA_CONTROLLER is not set
> > CONFIG_VIDEO_DEV=m
> > CONFIG_VIDEO_V4L2=m
> > CONFIG_VIDEO_V4L2_I2C=y
> > # CONFIG_VIDEO_ADV_DEBUG is not set
> > CONFIG_VIDEO_FIXED_MINOR_RANGES=y
> > CONFIG_V4L2_FWNODE=m
> > CONFIG_DVB_CORE=m
> > # CONFIG_DVB_MMAP is not set
> > # CONFIG_DVB_NET is not set
> > CONFIG_DVB_MAX_ADAPTERS=16
> > # CONFIG_DVB_DYNAMIC_MINORS is not set
> > # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
> > # CONFIG_DVB_ULE_DEBUG is not set
> > 
> > #
> > # Media drivers
> > #
> > # CONFIG_MEDIA_PCI_SUPPORT is not set
> > # CONFIG_DVB_PLATFORM_DRIVERS is not set
> > CONFIG_CEC_PLATFORM_DRIVERS=y
> > # CONFIG_VIDEO_CROS_EC_CEC is not set
> > # CONFIG_VIDEO_SECO_CEC is not set
> > CONFIG_SDR_PLATFORM_DRIVERS=y
> > 
> > #
> > # Supported MMC/SDIO adapters
> > #
> > CONFIG_SMS_SDIO_DRV=m
> > # CONFIG_RADIO_ADAPTERS is not set
> > 
> > #
> > # Supported FireWire (IEEE 1394) Adapters
> > #
> > # CONFIG_DVB_FIREDTV is not set
> > CONFIG_MEDIA_COMMON_OPTIONS=y
> > 
> > #
> > # common driver options
> > #
> > CONFIG_SMS_SIANO_MDTV=m
> > CONFIG_SMS_SIANO_RC=y
> > 
> > #
> > # Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
> > #
> > # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> > CONFIG_MEDIA_ATTACH=y
> > CONFIG_VIDEO_IR_I2C=m
> > 
> > #
> > # I2C Encoders, decoders, sensors and other helper chips
> > #
> > 
> > #
> > # Audio decoders, processors and mixers
> > #
> > CONFIG_VIDEO_TVAUDIO=m
> > # CONFIG_VIDEO_TDA7432 is not set
> > # CONFIG_VIDEO_TDA9840 is not set
> > CONFIG_VIDEO_TEA6415C=m
> > CONFIG_VIDEO_TEA6420=m
> > CONFIG_VIDEO_MSP3400=m
> > CONFIG_VIDEO_CS3308=m
> > CONFIG_VIDEO_CS5345=m
> > CONFIG_VIDEO_CS53L32A=m
> > # CONFIG_VIDEO_TLV320AIC23B is not set
> > # CONFIG_VIDEO_UDA1342 is not set
> > CONFIG_VIDEO_WM8775=m
> > CONFIG_VIDEO_WM8739=m
> > # CONFIG_VIDEO_VP27SMPX is not set
> > CONFIG_VIDEO_SONY_BTF_MPX=m
> > 
> > #
> > # RDS decoders
> > #
> > # CONFIG_VIDEO_SAA6588 is not set
> > 
> > #
> > # Video decoders
> > #
> > # CONFIG_VIDEO_ADV7183 is not set
> > # CONFIG_VIDEO_BT819 is not set
> > CONFIG_VIDEO_BT856=m
> > CONFIG_VIDEO_BT866=m
> > CONFIG_VIDEO_KS0127=m
> > CONFIG_VIDEO_ML86V7667=m
> > CONFIG_VIDEO_SAA7110=m
> > CONFIG_VIDEO_SAA711X=m
> > # CONFIG_VIDEO_TVP514X is not set
> > CONFIG_VIDEO_TVP5150=m
> > # CONFIG_VIDEO_TVP7002 is not set
> > CONFIG_VIDEO_TW2804=m
> > CONFIG_VIDEO_TW9903=m
> > CONFIG_VIDEO_TW9906=m
> > # CONFIG_VIDEO_TW9910 is not set
> > # CONFIG_VIDEO_VPX3220 is not set
> > 
> > #
> > # Video and audio decoders
> > #
> > CONFIG_VIDEO_SAA717X=m
> > # CONFIG_VIDEO_CX25840 is not set
> > 
> > #
> > # Video encoders
> > #
> > # CONFIG_VIDEO_SAA7127 is not set
> > # CONFIG_VIDEO_SAA7185 is not set
> > # CONFIG_VIDEO_ADV7170 is not set
> > CONFIG_VIDEO_ADV7175=m
> > # CONFIG_VIDEO_ADV7343 is not set
> > CONFIG_VIDEO_ADV7393=m
> > CONFIG_VIDEO_AK881X=m
> > CONFIG_VIDEO_THS8200=m
> > 
> > #
> > # Camera sensor devices
> > #
> > 
> > #
> > # Lens drivers
> > #
> > 
> > #
> > # Flash devices
> > #
> > 
> > #
> > # Video improvement chips
> > #
> > # CONFIG_VIDEO_UPD64031A is not set
> > CONFIG_VIDEO_UPD64083=m
> > 
> > #
> > # Audio/Video compression chips
> > #
> > # CONFIG_VIDEO_SAA6752HS is not set
> > 
> > #
> > # SDR tuner chips
> > #
> > CONFIG_SDR_MAX2175=m
> > 
> > #
> > # Miscellaneous helper chips
> > #
> > # CONFIG_VIDEO_THS7303 is not set
> > CONFIG_VIDEO_M52790=m
> > # CONFIG_VIDEO_I2C is not set
> > # end of I2C Encoders, decoders, sensors and other helper chips
> > 
> > #
> > # SPI helper chips
> > #
> > # end of SPI helper chips
> > 
> > #
> > # Media SPI Adapters
> > #
> > CONFIG_CXD2880_SPI_DRV=m
> > # end of Media SPI Adapters
> > 
> > CONFIG_MEDIA_TUNER=m
> > 
> > #
> > # Customize TV tuners
> > #
> > CONFIG_MEDIA_TUNER_SIMPLE=m
> > CONFIG_MEDIA_TUNER_TDA18250=m
> > CONFIG_MEDIA_TUNER_TDA8290=m
> > CONFIG_MEDIA_TUNER_TDA827X=m
> > CONFIG_MEDIA_TUNER_TDA18271=m
> > CONFIG_MEDIA_TUNER_TDA9887=m
> > CONFIG_MEDIA_TUNER_TEA5761=m
> > # CONFIG_MEDIA_TUNER_TEA5767 is not set
> > CONFIG_MEDIA_TUNER_MSI001=m
> > CONFIG_MEDIA_TUNER_MT20XX=m
> > CONFIG_MEDIA_TUNER_MT2060=m
> > CONFIG_MEDIA_TUNER_MT2063=m
> > CONFIG_MEDIA_TUNER_MT2266=m
> > CONFIG_MEDIA_TUNER_MT2131=m
> > # CONFIG_MEDIA_TUNER_QT1010 is not set
> > CONFIG_MEDIA_TUNER_XC2028=m
> > # CONFIG_MEDIA_TUNER_XC5000 is not set
> > CONFIG_MEDIA_TUNER_XC4000=m
> > # CONFIG_MEDIA_TUNER_MXL5005S is not set
> > CONFIG_MEDIA_TUNER_MXL5007T=m
> > CONFIG_MEDIA_TUNER_MC44S803=m
> > CONFIG_MEDIA_TUNER_MAX2165=m
> > CONFIG_MEDIA_TUNER_TDA18218=m
> > CONFIG_MEDIA_TUNER_FC0011=m
> > CONFIG_MEDIA_TUNER_FC0012=m
> > CONFIG_MEDIA_TUNER_FC0013=m
> > CONFIG_MEDIA_TUNER_TDA18212=m
> > # CONFIG_MEDIA_TUNER_E4000 is not set
> > CONFIG_MEDIA_TUNER_FC2580=m
> > # CONFIG_MEDIA_TUNER_M88RS6000T is not set
> > # CONFIG_MEDIA_TUNER_TUA9001 is not set
> > # CONFIG_MEDIA_TUNER_SI2157 is not set
> > # CONFIG_MEDIA_TUNER_IT913X is not set
> > CONFIG_MEDIA_TUNER_R820T=m
> > CONFIG_MEDIA_TUNER_MXL301RF=m
> > # CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
> > CONFIG_MEDIA_TUNER_QM1D1B0004=m
> > # end of Customize TV tuners
> > 
> > #
> > # Customise DVB Frontends
> > #
> > 
> > #
> > # Multistandard (satellite) frontends
> > #
> > CONFIG_DVB_STB0899=m
> > CONFIG_DVB_STB6100=m
> > CONFIG_DVB_STV090x=m
> > CONFIG_DVB_STV0910=m
> > CONFIG_DVB_STV6110x=m
> > # CONFIG_DVB_STV6111 is not set
> > CONFIG_DVB_MXL5XX=m
> > CONFIG_DVB_M88DS3103=m
> > 
> > #
> > # Multistandard (cable + terrestrial) frontends
> > #
> > # CONFIG_DVB_DRXK is not set
> > CONFIG_DVB_TDA18271C2DD=m
> > CONFIG_DVB_SI2165=m
> > # CONFIG_DVB_MN88472 is not set
> > # CONFIG_DVB_MN88473 is not set
> > 
> > #
> > # DVB-S (satellite) frontends
> > #
> > CONFIG_DVB_CX24110=m
> > CONFIG_DVB_CX24123=m
> > CONFIG_DVB_MT312=m
> > CONFIG_DVB_ZL10036=m
> > # CONFIG_DVB_ZL10039 is not set
> > CONFIG_DVB_S5H1420=m
> > # CONFIG_DVB_STV0288 is not set
> > CONFIG_DVB_STB6000=m
> > # CONFIG_DVB_STV0299 is not set
> > CONFIG_DVB_STV6110=m
> > CONFIG_DVB_STV0900=m
> > # CONFIG_DVB_TDA8083 is not set
> > CONFIG_DVB_TDA10086=m
> > CONFIG_DVB_TDA8261=m
> > CONFIG_DVB_VES1X93=m
> > CONFIG_DVB_TUNER_ITD1000=m
> > # CONFIG_DVB_TUNER_CX24113 is not set
> > # CONFIG_DVB_TDA826X is not set
> > CONFIG_DVB_TUA6100=m
> > # CONFIG_DVB_CX24116 is not set
> > CONFIG_DVB_CX24117=m
> > CONFIG_DVB_CX24120=m
> > # CONFIG_DVB_SI21XX is not set
> > CONFIG_DVB_TS2020=m
> > CONFIG_DVB_DS3000=m
> > CONFIG_DVB_MB86A16=m
> > CONFIG_DVB_TDA10071=m
> > 
> > #
> > # DVB-T (terrestrial) frontends
> > #
> > # CONFIG_DVB_SP8870 is not set
> > CONFIG_DVB_SP887X=m
> > CONFIG_DVB_CX22700=m
> > # CONFIG_DVB_CX22702 is not set
> > CONFIG_DVB_S5H1432=m
> > CONFIG_DVB_DRXD=m
> > # CONFIG_DVB_L64781 is not set
> > CONFIG_DVB_TDA1004X=m
> > # CONFIG_DVB_NXT6000 is not set
> > CONFIG_DVB_MT352=m
> > CONFIG_DVB_ZL10353=m
> > CONFIG_DVB_DIB3000MB=m
> > # CONFIG_DVB_DIB3000MC is not set
> > CONFIG_DVB_DIB7000M=m
> > CONFIG_DVB_DIB7000P=m
> > # CONFIG_DVB_DIB9000 is not set
> > CONFIG_DVB_TDA10048=m
> > # CONFIG_DVB_AF9013 is not set
> > CONFIG_DVB_EC100=m
> > CONFIG_DVB_STV0367=m
> > # CONFIG_DVB_CXD2820R is not set
> > # CONFIG_DVB_CXD2841ER is not set
> > # CONFIG_DVB_RTL2830 is not set
> > CONFIG_DVB_RTL2832=m
> > # CONFIG_DVB_SI2168 is not set
> > # CONFIG_DVB_ZD1301_DEMOD is not set
> > CONFIG_DVB_CXD2880=m
> > 
> > #
> > # DVB-C (cable) frontends
> > #
> > # CONFIG_DVB_VES1820 is not set
> > # CONFIG_DVB_TDA10021 is not set
> > # CONFIG_DVB_TDA10023 is not set
> > # CONFIG_DVB_STV0297 is not set
> > 
> > #
> > # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> > #
> > # CONFIG_DVB_NXT200X is not set
> > CONFIG_DVB_OR51211=m
> > CONFIG_DVB_OR51132=m
> > CONFIG_DVB_BCM3510=m
> > CONFIG_DVB_LGDT330X=m
> > CONFIG_DVB_LGDT3305=m
> > CONFIG_DVB_LGDT3306A=m
> > # CONFIG_DVB_LG2160 is not set
> > # CONFIG_DVB_S5H1409 is not set
> > CONFIG_DVB_AU8522=m
> > CONFIG_DVB_AU8522_DTV=m
> > CONFIG_DVB_AU8522_V4L=m
> > CONFIG_DVB_S5H1411=m
> > 
> > #
> > # ISDB-T (terrestrial) frontends
> > #
> > CONFIG_DVB_S921=m
> > CONFIG_DVB_DIB8000=m
> > # CONFIG_DVB_MB86A20S is not set
> > 
> > #
> > # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> > #
> > CONFIG_DVB_TC90522=m
> > CONFIG_DVB_MN88443X=m
> > 
> > #
> > # Digital terrestrial only tuners/PLL
> > #
> > # CONFIG_DVB_PLL is not set
> > CONFIG_DVB_TUNER_DIB0070=m
> > CONFIG_DVB_TUNER_DIB0090=m
> > 
> > #
> > # SEC control devices for DVB-S
> > #
> > CONFIG_DVB_DRX39XYJ=m
> > CONFIG_DVB_LNBH25=m
> > CONFIG_DVB_LNBH29=m
> > CONFIG_DVB_LNBP21=m
> > CONFIG_DVB_LNBP22=m
> > # CONFIG_DVB_ISL6405 is not set
> > CONFIG_DVB_ISL6421=m
> > # CONFIG_DVB_ISL6423 is not set
> > # CONFIG_DVB_A8293 is not set
> > CONFIG_DVB_LGS8GL5=m
> > CONFIG_DVB_LGS8GXX=m
> > CONFIG_DVB_ATBM8830=m
> > # CONFIG_DVB_TDA665x is not set
> > # CONFIG_DVB_IX2505V is not set
> > CONFIG_DVB_M88RS2000=m
> > CONFIG_DVB_AF9033=m
> > CONFIG_DVB_HORUS3A=m
> > CONFIG_DVB_ASCOT2E=m
> > CONFIG_DVB_HELENE=m
> > 
> > #
> > # Common Interface (EN50221) controller drivers
> > #
> > # CONFIG_DVB_CXD2099 is not set
> > CONFIG_DVB_SP2=m
> > 
> > #
> > # Tools to develop new frontends
> > #
> > # CONFIG_DVB_DUMMY_FE is not set
> > # end of Customise DVB Frontends
> > 
> > #
> > # Graphics support
> > #
> > # CONFIG_AGP is not set
> > CONFIG_VGA_ARB=y
> > CONFIG_VGA_ARB_MAX_GPUS=16
> > # CONFIG_VGA_SWITCHEROO is not set
> > CONFIG_DRM=m
> > CONFIG_DRM_MIPI_DBI=m
> > # CONFIG_DRM_DP_AUX_CHARDEV is not set
> > CONFIG_DRM_EXPORT_FOR_TESTS=y
> > CONFIG_DRM_DEBUG_SELFTEST=m
> > CONFIG_DRM_KMS_HELPER=m
> > CONFIG_DRM_KMS_FB_HELPER=y
> > # CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
> > CONFIG_DRM_FBDEV_EMULATION=y
> > CONFIG_DRM_FBDEV_OVERALLOC=100
> > # CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
> > # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
> > # CONFIG_DRM_DP_CEC is not set
> > CONFIG_DRM_GEM_CMA_HELPER=y
> > CONFIG_DRM_KMS_CMA_HELPER=y
> > CONFIG_DRM_GEM_SHMEM_HELPER=y
> > 
> > #
> > # I2C encoder or helper chips
> > #
> > CONFIG_DRM_I2C_CH7006=m
> > CONFIG_DRM_I2C_SIL164=m
> > CONFIG_DRM_I2C_NXP_TDA998X=m
> > # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> > # end of I2C encoder or helper chips
> > 
> > #
> > # ARM devices
> > #
> > # end of ARM devices
> > 
> > # CONFIG_DRM_RADEON is not set
> > # CONFIG_DRM_AMDGPU is not set
> > 
> > #
> > # ACP (Audio CoProcessor) Configuration
> > #
> > # end of ACP (Audio CoProcessor) Configuration
> > 
> > # CONFIG_DRM_NOUVEAU is not set
> > # CONFIG_DRM_I915 is not set
> > CONFIG_DRM_VGEM=m
> > # CONFIG_DRM_VKMS is not set
> > # CONFIG_DRM_VMWGFX is not set
> > # CONFIG_DRM_GMA500 is not set
> > # CONFIG_DRM_AST is not set
> > # CONFIG_DRM_MGAG200 is not set
> > # CONFIG_DRM_CIRRUS_QEMU is not set
> > # CONFIG_DRM_QXL is not set
> > # CONFIG_DRM_BOCHS is not set
> > CONFIG_DRM_VIRTIO_GPU=m
> > CONFIG_DRM_PANEL=y
> > 
> > #
> > # Display Panels
> > #
> > # end of Display Panels
> > 
> > CONFIG_DRM_BRIDGE=y
> > CONFIG_DRM_PANEL_BRIDGE=y
> > 
> > #
> > # Display Interface Bridges
> > #
> > # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> > # end of Display Interface Bridges
> > 
> > # CONFIG_DRM_ETNAVIV is not set
> > # CONFIG_TINYDRM_HX8357D is not set
> > # CONFIG_TINYDRM_ILI9225 is not set
> > # CONFIG_TINYDRM_ILI9341 is not set
> > CONFIG_TINYDRM_MI0283QT=m
> > CONFIG_TINYDRM_REPAPER=m
> > CONFIG_TINYDRM_ST7586=m
> > # CONFIG_TINYDRM_ST7735R is not set
> > # CONFIG_DRM_VBOXVIDEO is not set
> > # CONFIG_DRM_LEGACY is not set
> > CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
> > CONFIG_DRM_LIB_RANDOM=y
> > 
> > #
> > # Frame buffer Devices
> > #
> > CONFIG_FB_CMDLINE=y
> > CONFIG_FB_NOTIFY=y
> > CONFIG_FB=m
> > # CONFIG_FIRMWARE_EDID is not set
> > CONFIG_FB_CFB_FILLRECT=m
> > CONFIG_FB_CFB_COPYAREA=m
> > CONFIG_FB_CFB_IMAGEBLIT=m
> > CONFIG_FB_SYS_FILLRECT=m
> > CONFIG_FB_SYS_COPYAREA=m
> > CONFIG_FB_SYS_IMAGEBLIT=m
> > # CONFIG_FB_FOREIGN_ENDIAN is not set
> > CONFIG_FB_SYS_FOPS=m
> > CONFIG_FB_DEFERRED_IO=y
> > CONFIG_FB_HECUBA=m
> > CONFIG_FB_BACKLIGHT=m
> > # CONFIG_FB_MODE_HELPERS is not set
> > # CONFIG_FB_TILEBLITTING is not set
> > 
> > #
> > # Frame buffer hardware drivers
> > #
> > # CONFIG_FB_CIRRUS is not set
> > # CONFIG_FB_PM2 is not set
> > # CONFIG_FB_CYBER2000 is not set
> > CONFIG_FB_ARC=m
> > # CONFIG_FB_VGA16 is not set
> > CONFIG_FB_N411=m
> > CONFIG_FB_HGA=m
> > CONFIG_FB_OPENCORES=m
> > CONFIG_FB_S1D13XXX=m
> > # CONFIG_FB_NVIDIA is not set
> > # CONFIG_FB_RIVA is not set
> > # CONFIG_FB_I740 is not set
> > # CONFIG_FB_LE80578 is not set
> > # CONFIG_FB_MATROX is not set
> > # CONFIG_FB_RADEON is not set
> > # CONFIG_FB_ATY128 is not set
> > # CONFIG_FB_ATY is not set
> > # CONFIG_FB_S3 is not set
> > # CONFIG_FB_SAVAGE is not set
> > # CONFIG_FB_SIS is not set
> > # CONFIG_FB_VIA is not set
> > # CONFIG_FB_NEOMAGIC is not set
> > # CONFIG_FB_KYRO is not set
> > # CONFIG_FB_3DFX is not set
> > # CONFIG_FB_VOODOO1 is not set
> > # CONFIG_FB_VT8623 is not set
> > # CONFIG_FB_TRIDENT is not set
> > # CONFIG_FB_ARK is not set
> > # CONFIG_FB_PM3 is not set
> > # CONFIG_FB_CARMINE is not set
> > CONFIG_FB_IBM_GXT4500=m
> > CONFIG_FB_GOLDFISH=m
> > CONFIG_FB_VIRTUAL=m
> > CONFIG_FB_METRONOME=m
> > # CONFIG_FB_MB862XX is not set
> > # CONFIG_FB_SM712 is not set
> > # end of Frame buffer Devices
> > 
> > #
> > # Backlight & LCD device support
> > #
> > # CONFIG_LCD_CLASS_DEVICE is not set
> > CONFIG_BACKLIGHT_CLASS_DEVICE=m
> > CONFIG_BACKLIGHT_GENERIC=m
> > # CONFIG_BACKLIGHT_LM3533 is not set
> > # CONFIG_BACKLIGHT_APPLE is not set
> > # CONFIG_BACKLIGHT_QCOM_WLED is not set
> > CONFIG_BACKLIGHT_SAHARA=m
> > CONFIG_BACKLIGHT_WM831X=m
> > # CONFIG_BACKLIGHT_ADP8860 is not set
> > CONFIG_BACKLIGHT_ADP8870=m
> > CONFIG_BACKLIGHT_LM3639=m
> > CONFIG_BACKLIGHT_SKY81452=m
> > CONFIG_BACKLIGHT_GPIO=m
> > CONFIG_BACKLIGHT_LV5207LP=m
> > CONFIG_BACKLIGHT_BD6107=m
> > CONFIG_BACKLIGHT_ARCXCNN=m
> > # end of Backlight & LCD device support
> > 
> > CONFIG_HDMI=y
> > CONFIG_LOGO=y
> > # CONFIG_LOGO_LINUX_MONO is not set
> > CONFIG_LOGO_LINUX_VGA16=y
> > CONFIG_LOGO_LINUX_CLUT224=y
> > # end of Graphics support
> > 
> > CONFIG_SOUND=y
> > CONFIG_SOUND_OSS_CORE=y
> > CONFIG_SOUND_OSS_CORE_PRECLAIM=y
> > CONFIG_SND=y
> > CONFIG_SND_TIMER=y
> > CONFIG_SND_PCM=m
> > CONFIG_SND_PCM_ELD=y
> > CONFIG_SND_PCM_IEC958=y
> > CONFIG_SND_DMAENGINE_PCM=m
> > CONFIG_SND_HWDEP=m
> > CONFIG_SND_SEQ_DEVICE=y
> > CONFIG_SND_COMPRESS_OFFLOAD=m
> > CONFIG_SND_JACK=y
> > CONFIG_SND_JACK_INPUT_DEV=y
> > CONFIG_SND_OSSEMUL=y
> > CONFIG_SND_MIXER_OSS=m
> > CONFIG_SND_PCM_OSS=m
> > # CONFIG_SND_PCM_OSS_PLUGINS is not set
> > CONFIG_SND_PCM_TIMER=y
> > # CONFIG_SND_HRTIMER is not set
> > # CONFIG_SND_DYNAMIC_MINORS is not set
> > # CONFIG_SND_SUPPORT_OLD_API is not set
> > CONFIG_SND_PROC_FS=y
> > CONFIG_SND_VERBOSE_PROCFS=y
> > # CONFIG_SND_VERBOSE_PRINTK is not set
> > CONFIG_SND_DEBUG=y
> > # CONFIG_SND_DEBUG_VERBOSE is not set
> > # CONFIG_SND_PCM_XRUN_DEBUG is not set
> > # CONFIG_SND_CTL_VALIDATION is not set
> > CONFIG_SND_VMASTER=y
> > CONFIG_SND_DMA_SGBUF=y
> > CONFIG_SND_SEQUENCER=y
> > CONFIG_SND_SEQ_DUMMY=y
> > CONFIG_SND_SEQUENCER_OSS=m
> > CONFIG_SND_SEQ_MIDI_EVENT=m
> > CONFIG_SND_VX_LIB=m
> > CONFIG_SND_AC97_CODEC=m
> > # CONFIG_SND_DRIVERS is not set
> > CONFIG_SND_PCI=y
> > # CONFIG_SND_AD1889 is not set
> > # CONFIG_SND_ASIHPI is not set
> > # CONFIG_SND_ATIIXP is not set
> > # CONFIG_SND_ATIIXP_MODEM is not set
> > # CONFIG_SND_AU8810 is not set
> > # CONFIG_SND_AU8820 is not set
> > # CONFIG_SND_AU8830 is not set
> > # CONFIG_SND_AW2 is not set
> > # CONFIG_SND_BT87X is not set
> > # CONFIG_SND_CA0106 is not set
> > # CONFIG_SND_CMIPCI is not set
> > # CONFIG_SND_OXYGEN is not set
> > # CONFIG_SND_CS4281 is not set
> > # CONFIG_SND_CS46XX is not set
> > # CONFIG_SND_CTXFI is not set
> > # CONFIG_SND_DARLA20 is not set
> > # CONFIG_SND_GINA20 is not set
> > # CONFIG_SND_LAYLA20 is not set
> > # CONFIG_SND_DARLA24 is not set
> > # CONFIG_SND_GINA24 is not set
> > # CONFIG_SND_LAYLA24 is not set
> > # CONFIG_SND_MONA is not set
> > # CONFIG_SND_MIA is not set
> > # CONFIG_SND_ECHO3G is not set
> > # CONFIG_SND_INDIGO is not set
> > # CONFIG_SND_INDIGOIO is not set
> > # CONFIG_SND_INDIGODJ is not set
> > # CONFIG_SND_INDIGOIOX is not set
> > # CONFIG_SND_INDIGODJX is not set
> > # CONFIG_SND_ENS1370 is not set
> > # CONFIG_SND_ENS1371 is not set
> > # CONFIG_SND_FM801 is not set
> > # CONFIG_SND_HDSP is not set
> > # CONFIG_SND_HDSPM is not set
> > # CONFIG_SND_ICE1724 is not set
> > # CONFIG_SND_INTEL8X0 is not set
> > # CONFIG_SND_INTEL8X0M is not set
> > # CONFIG_SND_KORG1212 is not set
> > # CONFIG_SND_LOLA is not set
> > # CONFIG_SND_LX6464ES is not set
> > # CONFIG_SND_MIXART is not set
> > # CONFIG_SND_NM256 is not set
> > # CONFIG_SND_PCXHR is not set
> > # CONFIG_SND_RIPTIDE is not set
> > # CONFIG_SND_RME32 is not set
> > # CONFIG_SND_RME96 is not set
> > # CONFIG_SND_RME9652 is not set
> > # CONFIG_SND_SE6X is not set
> > # CONFIG_SND_VIA82XX is not set
> > # CONFIG_SND_VIA82XX_MODEM is not set
> > # CONFIG_SND_VIRTUOSO is not set
> > # CONFIG_SND_VX222 is not set
> > # CONFIG_SND_YMFPCI is not set
> > 
> > #
> > # HD-Audio
> > #
> > # CONFIG_SND_HDA_INTEL is not set
> > # end of HD-Audio
> > 
> > CONFIG_SND_HDA_PREALLOC_SIZE=0
> > CONFIG_SND_SPI=y
> > # CONFIG_SND_FIREWIRE is not set
> > CONFIG_SND_PCMCIA=y
> > CONFIG_SND_VXPOCKET=m
> > CONFIG_SND_PDAUDIOCF=m
> > CONFIG_SND_SOC=m
> > CONFIG_SND_SOC_AC97_BUS=y
> > CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
> > CONFIG_SND_SOC_COMPRESS=y
> > CONFIG_SND_SOC_ACPI=m
> > CONFIG_SND_SOC_AMD_ACP=m
> > # CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH is not set
> > # CONFIG_SND_SOC_AMD_CZ_RT5645_MACH is not set
> > # CONFIG_SND_SOC_AMD_ACP3x is not set
> > # CONFIG_SND_ATMEL_SOC is not set
> > # CONFIG_SND_DESIGNWARE_I2S is not set
> > 
> > #
> > # SoC Audio for Freescale CPUs
> > #
> > 
> > #
> > # Common SoC Audio options for Freescale CPUs:
> > #
> > # CONFIG_SND_SOC_FSL_ASRC is not set
> > # CONFIG_SND_SOC_FSL_SAI is not set
> > # CONFIG_SND_SOC_FSL_AUDMIX is not set
> > CONFIG_SND_SOC_FSL_SSI=m
> > # CONFIG_SND_SOC_FSL_SPDIF is not set
> > CONFIG_SND_SOC_FSL_ESAI=m
> > # CONFIG_SND_SOC_FSL_MICFIL is not set
> > # CONFIG_SND_SOC_IMX_AUDMUX is not set
> > # end of SoC Audio for Freescale CPUs
> > 
> > CONFIG_SND_I2S_HI6210_I2S=m
> > # CONFIG_SND_SOC_IMG is not set
> > CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
> > CONFIG_SND_SST_IPC=m
> > CONFIG_SND_SST_IPC_ACPI=m
> > CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
> > # CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
> > CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
> > # CONFIG_SND_SOC_INTEL_SKYLAKE is not set
> > # CONFIG_SND_SOC_INTEL_SKL is not set
> > # CONFIG_SND_SOC_INTEL_APL is not set
> > # CONFIG_SND_SOC_INTEL_KBL is not set
> > # CONFIG_SND_SOC_INTEL_GLK is not set
> > # CONFIG_SND_SOC_INTEL_CNL is not set
> > # CONFIG_SND_SOC_INTEL_CFL is not set
> > # CONFIG_SND_SOC_INTEL_CML_H is not set
> > # CONFIG_SND_SOC_INTEL_CML_LP is not set
> > CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
> > CONFIG_SND_SOC_INTEL_MACH=y
> > # CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
> > # CONFIG_SND_SOC_MTK_BTCVSD is not set
> > # CONFIG_SND_SOC_SOF_TOPLEVEL is not set
> > 
> > #
> > # STMicroelectronics STM32 SOC audio support
> > #
> > # end of STMicroelectronics STM32 SOC audio support
> > 
> > # CONFIG_SND_SOC_XILINX_I2S is not set
> > # CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
> > # CONFIG_SND_SOC_XILINX_SPDIF is not set
> > CONFIG_SND_SOC_XTFPGA_I2S=m
> > # CONFIG_ZX_TDM is not set
> > CONFIG_SND_SOC_I2C_AND_SPI=m
> > 
> > #
> > # CODEC drivers
> > #
> > CONFIG_SND_SOC_AC97_CODEC=m
> > CONFIG_SND_SOC_ADAU_UTILS=m
> > # CONFIG_SND_SOC_ADAU1701 is not set
> > CONFIG_SND_SOC_ADAU17X1=m
> > CONFIG_SND_SOC_ADAU1761=m
> > CONFIG_SND_SOC_ADAU1761_I2C=m
> > CONFIG_SND_SOC_ADAU1761_SPI=m
> > CONFIG_SND_SOC_ADAU7002=m
> > # CONFIG_SND_SOC_ADAU7118_HW is not set
> > # CONFIG_SND_SOC_ADAU7118_I2C is not set
> > CONFIG_SND_SOC_AK4104=m
> > # CONFIG_SND_SOC_AK4118 is not set
> > # CONFIG_SND_SOC_AK4458 is not set
> > CONFIG_SND_SOC_AK4554=m
> > CONFIG_SND_SOC_AK4613=m
> > CONFIG_SND_SOC_AK4642=m
> > CONFIG_SND_SOC_AK5386=m
> > # CONFIG_SND_SOC_AK5558 is not set
> > CONFIG_SND_SOC_ALC5623=m
> > # CONFIG_SND_SOC_BD28623 is not set
> > CONFIG_SND_SOC_BT_SCO=m
> > # CONFIG_SND_SOC_CROS_EC_CODEC is not set
> > # CONFIG_SND_SOC_CS35L32 is not set
> > CONFIG_SND_SOC_CS35L33=m
> > # CONFIG_SND_SOC_CS35L34 is not set
> > CONFIG_SND_SOC_CS35L35=m
> > # CONFIG_SND_SOC_CS35L36 is not set
> > CONFIG_SND_SOC_CS42L42=m
> > CONFIG_SND_SOC_CS42L51=m
> > CONFIG_SND_SOC_CS42L51_I2C=m
> > # CONFIG_SND_SOC_CS42L52 is not set
> > # CONFIG_SND_SOC_CS42L56 is not set
> > # CONFIG_SND_SOC_CS42L73 is not set
> > CONFIG_SND_SOC_CS4265=m
> > CONFIG_SND_SOC_CS4270=m
> > CONFIG_SND_SOC_CS4271=m
> > CONFIG_SND_SOC_CS4271_I2C=m
> > CONFIG_SND_SOC_CS4271_SPI=m
> > CONFIG_SND_SOC_CS42XX8=m
> > CONFIG_SND_SOC_CS42XX8_I2C=m
> > # CONFIG_SND_SOC_CS43130 is not set
> > # CONFIG_SND_SOC_CS4341 is not set
> > CONFIG_SND_SOC_CS4349=m
> > # CONFIG_SND_SOC_CS53L30 is not set
> > # CONFIG_SND_SOC_CX2072X is not set
> > # CONFIG_SND_SOC_DA7213 is not set
> > # CONFIG_SND_SOC_DMIC is not set
> > CONFIG_SND_SOC_HDMI_CODEC=m
> > CONFIG_SND_SOC_ES7134=m
> > # CONFIG_SND_SOC_ES7241 is not set
> > # CONFIG_SND_SOC_ES8316 is not set
> > CONFIG_SND_SOC_ES8328=m
> > CONFIG_SND_SOC_ES8328_I2C=m
> > CONFIG_SND_SOC_ES8328_SPI=m
> > # CONFIG_SND_SOC_GTM601 is not set
> > CONFIG_SND_SOC_INNO_RK3036=m
> > # CONFIG_SND_SOC_MAX98088 is not set
> > # CONFIG_SND_SOC_MAX98357A is not set
> > # CONFIG_SND_SOC_MAX98504 is not set
> > # CONFIG_SND_SOC_MAX9867 is not set
> > CONFIG_SND_SOC_MAX98927=m
> > # CONFIG_SND_SOC_MAX98373 is not set
> > CONFIG_SND_SOC_MAX9860=m
> > CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
> > CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
> > CONFIG_SND_SOC_PCM1681=m
> > # CONFIG_SND_SOC_PCM1789_I2C is not set
> > CONFIG_SND_SOC_PCM179X=m
> > CONFIG_SND_SOC_PCM179X_I2C=m
> > CONFIG_SND_SOC_PCM179X_SPI=m
> > # CONFIG_SND_SOC_PCM186X_I2C is not set
> > # CONFIG_SND_SOC_PCM186X_SPI is not set
> > # CONFIG_SND_SOC_PCM3060_I2C is not set
> > # CONFIG_SND_SOC_PCM3060_SPI is not set
> > CONFIG_SND_SOC_PCM3168A=m
> > CONFIG_SND_SOC_PCM3168A_I2C=m
> > CONFIG_SND_SOC_PCM3168A_SPI=m
> > CONFIG_SND_SOC_PCM512x=m
> > # CONFIG_SND_SOC_PCM512x_I2C is not set
> > CONFIG_SND_SOC_PCM512x_SPI=m
> > # CONFIG_SND_SOC_RK3328 is not set
> > CONFIG_SND_SOC_RL6231=m
> > CONFIG_SND_SOC_RT5616=m
> > CONFIG_SND_SOC_RT5631=m
> > CONFIG_SND_SOC_SGTL5000=m
> > CONFIG_SND_SOC_SIGMADSP=m
> > CONFIG_SND_SOC_SIGMADSP_REGMAP=m
> > # CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
> > CONFIG_SND_SOC_SIRF_AUDIO_CODEC=m
> > CONFIG_SND_SOC_SPDIF=m
> > # CONFIG_SND_SOC_SSM2305 is not set
> > CONFIG_SND_SOC_SSM2602=m
> > CONFIG_SND_SOC_SSM2602_SPI=m
> > # CONFIG_SND_SOC_SSM2602_I2C is not set
> > CONFIG_SND_SOC_SSM4567=m
> > CONFIG_SND_SOC_STA32X=m
> > CONFIG_SND_SOC_STA350=m
> > CONFIG_SND_SOC_STI_SAS=m
> > CONFIG_SND_SOC_TAS2552=m
> > # CONFIG_SND_SOC_TAS2562 is not set
> > # CONFIG_SND_SOC_TAS2770 is not set
> > CONFIG_SND_SOC_TAS5086=m
> > CONFIG_SND_SOC_TAS571X=m
> > # CONFIG_SND_SOC_TAS5720 is not set
> > # CONFIG_SND_SOC_TAS6424 is not set
> > # CONFIG_SND_SOC_TDA7419 is not set
> > CONFIG_SND_SOC_TFA9879=m
> > CONFIG_SND_SOC_TLV320AIC23=m
> > CONFIG_SND_SOC_TLV320AIC23_I2C=m
> > # CONFIG_SND_SOC_TLV320AIC23_SPI is not set
> > CONFIG_SND_SOC_TLV320AIC31XX=m
> > # CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
> > # CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
> > CONFIG_SND_SOC_TLV320AIC3X=m
> > # CONFIG_SND_SOC_TS3A227E is not set
> > # CONFIG_SND_SOC_TSCS42XX is not set
> > # CONFIG_SND_SOC_TSCS454 is not set
> > # CONFIG_SND_SOC_UDA1334 is not set
> > CONFIG_SND_SOC_WM8510=m
> > CONFIG_SND_SOC_WM8523=m
> > CONFIG_SND_SOC_WM8524=m
> > CONFIG_SND_SOC_WM8580=m
> > # CONFIG_SND_SOC_WM8711 is not set
> > # CONFIG_SND_SOC_WM8728 is not set
> > CONFIG_SND_SOC_WM8731=m
> > CONFIG_SND_SOC_WM8737=m
> > CONFIG_SND_SOC_WM8741=m
> > # CONFIG_SND_SOC_WM8750 is not set
> > # CONFIG_SND_SOC_WM8753 is not set
> > CONFIG_SND_SOC_WM8770=m
> > CONFIG_SND_SOC_WM8776=m
> > # CONFIG_SND_SOC_WM8782 is not set
> > CONFIG_SND_SOC_WM8804=m
> > CONFIG_SND_SOC_WM8804_I2C=m
> > # CONFIG_SND_SOC_WM8804_SPI is not set
> > CONFIG_SND_SOC_WM8903=m
> > # CONFIG_SND_SOC_WM8904 is not set
> > CONFIG_SND_SOC_WM8960=m
> > # CONFIG_SND_SOC_WM8962 is not set
> > CONFIG_SND_SOC_WM8974=m
> > CONFIG_SND_SOC_WM8978=m
> > CONFIG_SND_SOC_WM8985=m
> > CONFIG_SND_SOC_ZX_AUD96P22=m
> > # CONFIG_SND_SOC_MAX9759 is not set
> > # CONFIG_SND_SOC_MT6351 is not set
> > # CONFIG_SND_SOC_MT6358 is not set
> > # CONFIG_SND_SOC_MT6660 is not set
> > CONFIG_SND_SOC_NAU8540=m
> > CONFIG_SND_SOC_NAU8810=m
> > # CONFIG_SND_SOC_NAU8822 is not set
> > CONFIG_SND_SOC_NAU8824=m
> > CONFIG_SND_SOC_TPA6130A2=m
> > # end of CODEC drivers
> > 
> > CONFIG_SND_SIMPLE_CARD_UTILS=m
> > CONFIG_SND_SIMPLE_CARD=m
> > CONFIG_SND_X86=y
> > CONFIG_AC97_BUS=m
> > 
> > #
> > # HID support
> > #
> > CONFIG_HID=y
> > # CONFIG_HID_BATTERY_STRENGTH is not set
> > # CONFIG_HIDRAW is not set
> > # CONFIG_UHID is not set
> > CONFIG_HID_GENERIC=y
> > 
> > #
> > # Special HID drivers
> > #
> > # CONFIG_HID_A4TECH is not set
> > # CONFIG_HID_ACRUX is not set
> > # CONFIG_HID_APPLE is not set
> > # CONFIG_HID_ASUS is not set
> > # CONFIG_HID_AUREAL is not set
> > # CONFIG_HID_BELKIN is not set
> > # CONFIG_HID_CHERRY is not set
> > # CONFIG_HID_CHICONY is not set
> > # CONFIG_HID_COUGAR is not set
> > # CONFIG_HID_MACALLY is not set
> > # CONFIG_HID_PRODIKEYS is not set
> > # CONFIG_HID_CMEDIA is not set
> > # CONFIG_HID_CYPRESS is not set
> > # CONFIG_HID_DRAGONRISE is not set
> > # CONFIG_HID_EMS_FF is not set
> > # CONFIG_HID_ELECOM is not set
> > # CONFIG_HID_EZKEY is not set
> > # CONFIG_HID_GEMBIRD is not set
> > # CONFIG_HID_GFRM is not set
> > # CONFIG_HID_KEYTOUCH is not set
> > # CONFIG_HID_KYE is not set
> > # CONFIG_HID_WALTOP is not set
> > # CONFIG_HID_VIEWSONIC is not set
> > # CONFIG_HID_GYRATION is not set
> > # CONFIG_HID_ICADE is not set
> > # CONFIG_HID_ITE is not set
> > # CONFIG_HID_JABRA is not set
> > # CONFIG_HID_TWINHAN is not set
> > # CONFIG_HID_KENSINGTON is not set
> > # CONFIG_HID_LCPOWER is not set
> > # CONFIG_HID_LED is not set
> > # CONFIG_HID_LENOVO is not set
> > # CONFIG_HID_LOGITECH is not set
> > # CONFIG_HID_MAGICMOUSE is not set
> > # CONFIG_HID_MALTRON is not set
> > # CONFIG_HID_MAYFLASH is not set
> > # CONFIG_HID_REDRAGON is not set
> > # CONFIG_HID_MICROSOFT is not set
> > # CONFIG_HID_MONTEREY is not set
> > # CONFIG_HID_MULTITOUCH is not set
> > # CONFIG_HID_NTI is not set
> > # CONFIG_HID_ORTEK is not set
> > # CONFIG_HID_PANTHERLORD is not set
> > # CONFIG_HID_PETALYNX is not set
> > # CONFIG_HID_PICOLCD is not set
> > # CONFIG_HID_PLANTRONICS is not set
> > # CONFIG_HID_PRIMAX is not set
> > # CONFIG_HID_SAITEK is not set
> > # CONFIG_HID_SAMSUNG is not set
> > # CONFIG_HID_SPEEDLINK is not set
> > # CONFIG_HID_STEAM is not set
> > # CONFIG_HID_STEELSERIES is not set
> > # CONFIG_HID_SUNPLUS is not set
> > # CONFIG_HID_RMI is not set
> > # CONFIG_HID_GREENASIA is not set
> > # CONFIG_HID_SMARTJOYPLUS is not set
> > # CONFIG_HID_TIVO is not set
> > # CONFIG_HID_TOPSEED is not set
> > # CONFIG_HID_THINGM is not set
> > # CONFIG_HID_THRUSTMASTER is not set
> > # CONFIG_HID_UDRAW_PS3 is not set
> > # CONFIG_HID_WIIMOTE is not set
> > # CONFIG_HID_XINMO is not set
> > # CONFIG_HID_ZEROPLUS is not set
> > # CONFIG_HID_ZYDACRON is not set
> > # CONFIG_HID_SENSOR_HUB is not set
> > # CONFIG_HID_ALPS is not set
> > # end of Special HID drivers
> > 
> > #
> > # I2C HID support
> > #
> > # CONFIG_I2C_HID is not set
> > # end of I2C HID support
> > 
> > #
> > # Intel ISH HID support
> > #
> > # CONFIG_INTEL_ISH_HID is not set
> > # end of Intel ISH HID support
> > # end of HID support
> > 
> > CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> > CONFIG_USB_SUPPORT=y
> > # CONFIG_USB_LED_TRIG is not set
> > # CONFIG_USB_ULPI_BUS is not set
> > # CONFIG_USB_CONN_GPIO is not set
> > CONFIG_USB_ARCH_HAS_HCD=y
> > # CONFIG_USB is not set
> > CONFIG_USB_PCI=y
> > 
> > #
> > # USB port drivers
> > #
> > 
> > #
> > # USB Physical Layer drivers
> > #
> > # CONFIG_NOP_USB_XCEIV is not set
> > # CONFIG_USB_GPIO_VBUS is not set
> > # CONFIG_TAHVO_USB is not set
> > # end of USB Physical Layer drivers
> > 
> > # CONFIG_USB_GADGET is not set
> > # CONFIG_TYPEC is not set
> > # CONFIG_USB_ROLE_SWITCH is not set
> > CONFIG_MMC=m
> > CONFIG_MMC_BLOCK=m
> > CONFIG_MMC_BLOCK_MINORS=8
> > # CONFIG_SDIO_UART is not set
> > CONFIG_MMC_TEST=m
> > 
> > #
> > # MMC/SD/SDIO Host Controller Drivers
> > #
> > CONFIG_MMC_DEBUG=y
> > # CONFIG_MMC_SDHCI is not set
> > # CONFIG_MMC_TIFM_SD is not set
> > CONFIG_MMC_GOLDFISH=m
> > CONFIG_MMC_SPI=m
> > # CONFIG_MMC_SDRICOH_CS is not set
> > # CONFIG_MMC_CB710 is not set
> > # CONFIG_MMC_VIA_SDMMC is not set
> > # CONFIG_MMC_USDHI6ROL0 is not set
> > # CONFIG_MMC_CQHCI is not set
> > # CONFIG_MMC_TOSHIBA_PCI is not set
> > # CONFIG_MMC_MTK is not set
> > # CONFIG_MEMSTICK is not set
> > CONFIG_NEW_LEDS=y
> > CONFIG_LEDS_CLASS=m
> > CONFIG_LEDS_CLASS_FLASH=m
> > CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
> > 
> > #
> > # LED drivers
> > #
> > # CONFIG_LEDS_APU is not set
> > CONFIG_LEDS_AS3645A=m
> > CONFIG_LEDS_LM3530=m
> > # CONFIG_LEDS_LM3532 is not set
> > # CONFIG_LEDS_LM3533 is not set
> > CONFIG_LEDS_LM3642=m
> > # CONFIG_LEDS_LM3601X is not set
> > # CONFIG_LEDS_PCA9532 is not set
> > # CONFIG_LEDS_GPIO is not set
> > CONFIG_LEDS_LP3944=m
> > CONFIG_LEDS_LP3952=m
> > CONFIG_LEDS_LP55XX_COMMON=m
> > # CONFIG_LEDS_LP5521 is not set
> > CONFIG_LEDS_LP5523=m
> > CONFIG_LEDS_LP5562=m
> > CONFIG_LEDS_LP8501=m
> > # CONFIG_LEDS_CLEVO_MAIL is not set
> > CONFIG_LEDS_PCA955X=m
> > # CONFIG_LEDS_PCA955X_GPIO is not set
> > CONFIG_LEDS_PCA963X=m
> > CONFIG_LEDS_WM831X_STATUS=m
> > CONFIG_LEDS_DAC124S085=m
> > CONFIG_LEDS_REGULATOR=m
> > # CONFIG_LEDS_BD2802 is not set
> > # CONFIG_LEDS_INTEL_SS4200 is not set
> > # CONFIG_LEDS_MC13783 is not set
> > # CONFIG_LEDS_TCA6507 is not set
> > CONFIG_LEDS_TLC591XX=m
> > CONFIG_LEDS_LM355x=m
> > 
> > #
> > # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> > #
> > CONFIG_LEDS_BLINKM=m
> > # CONFIG_LEDS_MLXCPLD is not set
> > # CONFIG_LEDS_MLXREG is not set
> > CONFIG_LEDS_USER=m
> > # CONFIG_LEDS_NIC78BX is not set
> > # CONFIG_LEDS_TI_LMU_COMMON is not set
> > CONFIG_LEDS_TPS6105X=m
> > 
> > #
> > # LED Triggers
> > #
> > CONFIG_LEDS_TRIGGERS=y
> > # CONFIG_LEDS_TRIGGER_TIMER is not set
> > CONFIG_LEDS_TRIGGER_ONESHOT=y
> > CONFIG_LEDS_TRIGGER_MTD=y
> > CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> > CONFIG_LEDS_TRIGGER_BACKLIGHT=y
> > # CONFIG_LEDS_TRIGGER_CPU is not set
> > # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> > CONFIG_LEDS_TRIGGER_GPIO=y
> > # CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
> > 
> > #
> > # iptables trigger is under Netfilter config (LED target)
> > #
> > # CONFIG_LEDS_TRIGGER_TRANSIENT is not set
> > CONFIG_LEDS_TRIGGER_CAMERA=y
> > # CONFIG_LEDS_TRIGGER_PANIC is not set
> > # CONFIG_LEDS_TRIGGER_NETDEV is not set
> > # CONFIG_LEDS_TRIGGER_PATTERN is not set
> > # CONFIG_LEDS_TRIGGER_AUDIO is not set
> > # CONFIG_ACCESSIBILITY is not set
> > # CONFIG_INFINIBAND is not set
> > CONFIG_EDAC_ATOMIC_SCRUB=y
> > CONFIG_EDAC_SUPPORT=y
> > CONFIG_EDAC=y
> > # CONFIG_EDAC_LEGACY_SYSFS is not set
> > # CONFIG_EDAC_DEBUG is not set
> > # CONFIG_EDAC_E752X is not set
> > # CONFIG_EDAC_I82975X is not set
> > # CONFIG_EDAC_I3000 is not set
> > # CONFIG_EDAC_I3200 is not set
> > # CONFIG_EDAC_IE31200 is not set
> > # CONFIG_EDAC_X38 is not set
> > # CONFIG_EDAC_I5400 is not set
> > # CONFIG_EDAC_I5000 is not set
> > # CONFIG_EDAC_I5100 is not set
> > # CONFIG_EDAC_I7300 is not set
> > CONFIG_RTC_LIB=y
> > CONFIG_RTC_MC146818_LIB=y
> > # CONFIG_RTC_CLASS is not set
> > # CONFIG_DMADEVICES is not set
> > 
> > #
> > # DMABUF options
> > #
> > CONFIG_SYNC_FILE=y
> > CONFIG_SW_SYNC=y
> > # CONFIG_UDMABUF is not set
> > # CONFIG_DMABUF_SELFTESTS is not set
> > # CONFIG_DMABUF_HEAPS is not set
> > # end of DMABUF options
> > 
> > CONFIG_AUXDISPLAY=y
> > # CONFIG_HD44780 is not set
> > # CONFIG_KS0108 is not set
> > # CONFIG_IMG_ASCII_LCD is not set
> > CONFIG_PARPORT_PANEL=m
> > CONFIG_PANEL_PARPORT=0
> > CONFIG_PANEL_PROFILE=5
> > # CONFIG_PANEL_CHANGE_MESSAGE is not set
> > # CONFIG_CHARLCD_BL_OFF is not set
> > # CONFIG_CHARLCD_BL_ON is not set
> > CONFIG_CHARLCD_BL_FLASH=y
> > CONFIG_PANEL=m
> > CONFIG_CHARLCD=m
> > CONFIG_UIO=m
> > # CONFIG_UIO_CIF is not set
> > CONFIG_UIO_PDRV_GENIRQ=m
> > # CONFIG_UIO_DMEM_GENIRQ is not set
> > # CONFIG_UIO_AEC is not set
> > # CONFIG_UIO_SERCOS3 is not set
> > # CONFIG_UIO_PCI_GENERIC is not set
> > # CONFIG_UIO_NETX is not set
> > CONFIG_UIO_PRUSS=m
> > # CONFIG_UIO_MF624 is not set
> > # CONFIG_VIRT_DRIVERS is not set
> > CONFIG_VIRTIO=y
> > CONFIG_VIRTIO_MENU=y
> > # CONFIG_VIRTIO_PCI is not set
> > CONFIG_VIRTIO_BALLOON=m
> > # CONFIG_VIRTIO_INPUT is not set
> > CONFIG_VIRTIO_MMIO=y
> > # CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
> > 
> > #
> > # Microsoft Hyper-V guest support
> > #
> > # CONFIG_HYPERV is not set
> > # end of Microsoft Hyper-V guest support
> > 
> > CONFIG_GREYBUS=m
> > CONFIG_STAGING=y
> > # CONFIG_COMEDI is not set
> > 
> > #
> > # IIO staging drivers
> > #
> > 
> > #
> > # Accelerometers
> > #
> > # CONFIG_ADIS16203 is not set
> > CONFIG_ADIS16240=m
> > # end of Accelerometers
> > 
> > #
> > # Analog to digital converters
> > #
> > CONFIG_AD7816=m
> > CONFIG_AD7192=m
> > # CONFIG_AD7280 is not set
> > # end of Analog to digital converters
> > 
> > #
> > # Analog digital bi-direction converters
> > #
> > CONFIG_ADT7316=m
> > # CONFIG_ADT7316_SPI is not set
> > CONFIG_ADT7316_I2C=m
> > # end of Analog digital bi-direction converters
> > 
> > #
> > # Capacitance to digital converters
> > #
> > # CONFIG_AD7150 is not set
> > CONFIG_AD7746=m
> > # end of Capacitance to digital converters
> > 
> > #
> > # Direct Digital Synthesis
> > #
> > CONFIG_AD9832=m
> > CONFIG_AD9834=m
> > # end of Direct Digital Synthesis
> > 
> > #
> > # Network Analyzer, Impedance Converters
> > #
> > # CONFIG_AD5933 is not set
> > # end of Network Analyzer, Impedance Converters
> > 
> > #
> > # Active energy metering IC
> > #
> > CONFIG_ADE7854=m
> > CONFIG_ADE7854_I2C=m
> > CONFIG_ADE7854_SPI=m
> > # end of Active energy metering IC
> > 
> > #
> > # Resolver to digital converters
> > #
> > CONFIG_AD2S1210=m
> > # end of Resolver to digital converters
> > # end of IIO staging drivers
> > 
> > # CONFIG_FB_SM750 is not set
> > 
> > #
> > # Speakup console speech
> > #
> > # end of Speakup console speech
> > 
> > CONFIG_STAGING_MEDIA=y
> > 
> > #
> > # soc_camera sensor drivers
> > #
> > 
> > #
> > # Android
> > #
> > # CONFIG_ASHMEM is not set
> > CONFIG_ION=y
> > CONFIG_ION_SYSTEM_HEAP=y
> > # end of Android
> > 
> > # CONFIG_FIREWIRE_SERIAL is not set
> > # CONFIG_GOLDFISH_AUDIO is not set
> > # CONFIG_GS_FPGABOOT is not set
> > # CONFIG_UNISYSSPAR is not set
> > CONFIG_FB_TFT=m
> > CONFIG_FB_TFT_AGM1264K_FL=m
> > # CONFIG_FB_TFT_BD663474 is not set
> > CONFIG_FB_TFT_HX8340BN=m
> > CONFIG_FB_TFT_HX8347D=m
> > # CONFIG_FB_TFT_HX8353D is not set
> > # CONFIG_FB_TFT_HX8357D is not set
> > # CONFIG_FB_TFT_ILI9163 is not set
> > CONFIG_FB_TFT_ILI9320=m
> > CONFIG_FB_TFT_ILI9325=m
> > CONFIG_FB_TFT_ILI9340=m
> > # CONFIG_FB_TFT_ILI9341 is not set
> > # CONFIG_FB_TFT_ILI9481 is not set
> > CONFIG_FB_TFT_ILI9486=m
> > CONFIG_FB_TFT_PCD8544=m
> > CONFIG_FB_TFT_RA8875=m
> > CONFIG_FB_TFT_S6D02A1=m
> > CONFIG_FB_TFT_S6D1121=m
> > # CONFIG_FB_TFT_SEPS525 is not set
> > # CONFIG_FB_TFT_SH1106 is not set
> > CONFIG_FB_TFT_SSD1289=m
> > CONFIG_FB_TFT_SSD1305=m
> > CONFIG_FB_TFT_SSD1306=m
> > # CONFIG_FB_TFT_SSD1331 is not set
> > # CONFIG_FB_TFT_SSD1351 is not set
> > CONFIG_FB_TFT_ST7735R=m
> > # CONFIG_FB_TFT_ST7789V is not set
> > CONFIG_FB_TFT_TINYLCD=m
> > CONFIG_FB_TFT_TLS8204=m
> > # CONFIG_FB_TFT_UC1611 is not set
> > # CONFIG_FB_TFT_UC1701 is not set
> > # CONFIG_FB_TFT_UPD161704 is not set
> > # CONFIG_FB_TFT_WATTEROTT is not set
> > CONFIG_MOST=m
> > # CONFIG_MOST_CDEV is not set
> > # CONFIG_MOST_NET is not set
> > # CONFIG_MOST_SOUND is not set
> > # CONFIG_MOST_VIDEO is not set
> > # CONFIG_MOST_I2C is not set
> > CONFIG_GREYBUS_AUDIO=m
> > # CONFIG_GREYBUS_BOOTROM is not set
> > CONFIG_GREYBUS_FIRMWARE=m
> > # CONFIG_GREYBUS_HID is not set
> > CONFIG_GREYBUS_LIGHT=m
> > # CONFIG_GREYBUS_LOG is not set
> > CONFIG_GREYBUS_LOOPBACK=m
> > CONFIG_GREYBUS_POWER=m
> > # CONFIG_GREYBUS_RAW is not set
> > # CONFIG_GREYBUS_VIBRATOR is not set
> > CONFIG_GREYBUS_BRIDGED_PHY=m
> > CONFIG_GREYBUS_GPIO=m
> > CONFIG_GREYBUS_I2C=m
> > # CONFIG_GREYBUS_SDIO is not set
> > CONFIG_GREYBUS_SPI=m
> > # CONFIG_GREYBUS_UART is not set
> > CONFIG_PI433=m
> > 
> > #
> > # Gasket devices
> > #
> > # CONFIG_STAGING_GASKET_FRAMEWORK is not set
> > # end of Gasket devices
> > 
> > # CONFIG_FIELDBUS_DEV is not set
> > # CONFIG_KPC2000 is not set
> > CONFIG_UWB=y
> > # CONFIG_UWB_WHCI is not set
> > # CONFIG_STAGING_EXFAT_FS is not set
> > # CONFIG_QLGE is not set
> > CONFIG_NET_VENDOR_HP=y
> > # CONFIG_HP100 is not set
> > # CONFIG_X86_PLATFORM_DEVICES is not set
> > CONFIG_PMC_ATOM=y
> > # CONFIG_GOLDFISH_PIPE is not set
> > CONFIG_MFD_CROS_EC=y
> > CONFIG_CHROME_PLATFORMS=y
> > CONFIG_CHROMEOS_LAPTOP=m
> > # CONFIG_CHROMEOS_PSTORE is not set
> > # CONFIG_CHROMEOS_TBMC is not set
> > CONFIG_CROS_EC=y
> > # CONFIG_CROS_EC_I2C is not set
> > # CONFIG_CROS_EC_SPI is not set
> > # CONFIG_CROS_EC_LPC is not set
> > CONFIG_CROS_EC_PROTO=y
> > # CONFIG_CROS_KBD_LED_BACKLIGHT is not set
> > CONFIG_CROS_EC_CHARDEV=y
> > CONFIG_CROS_EC_LIGHTBAR=y
> > CONFIG_CROS_EC_DEBUGFS=y
> > CONFIG_CROS_EC_SENSORHUB=y
> > CONFIG_CROS_EC_SYSFS=y
> > # CONFIG_MELLANOX_PLATFORM is not set
> > CONFIG_CLKDEV_LOOKUP=y
> > CONFIG_HAVE_CLK_PREPARE=y
> > CONFIG_COMMON_CLK=y
> > 
> > #
> > # Common Clock Framework
> > #
> > # CONFIG_COMMON_CLK_WM831X is not set
> > # CONFIG_COMMON_CLK_MAX9485 is not set
> > # CONFIG_COMMON_CLK_SI5341 is not set
> > # CONFIG_COMMON_CLK_SI5351 is not set
> > # CONFIG_COMMON_CLK_SI544 is not set
> > # CONFIG_COMMON_CLK_CDCE706 is not set
> > # CONFIG_COMMON_CLK_CS2000_CP is not set
> > # end of Common Clock Framework
> > 
> > # CONFIG_HWSPINLOCK is not set
> > 
> > #
> > # Clock Source drivers
> > #
> > CONFIG_CLKEVT_I8253=y
> > CONFIG_CLKBLD_I8253=y
> > # end of Clock Source drivers
> > 
> > # CONFIG_MAILBOX is not set
> > CONFIG_IOMMU_SUPPORT=y
> > 
> > #
> > # Generic IOMMU Pagetable Support
> > #
> > # end of Generic IOMMU Pagetable Support
> > 
> > # CONFIG_IOMMU_DEBUGFS is not set
> > # CONFIG_AMD_IOMMU is not set
> > 
> > #
> > # Remoteproc drivers
> > #
> > # CONFIG_REMOTEPROC is not set
> > # end of Remoteproc drivers
> > 
> > #
> > # Rpmsg drivers
> > #
> > # CONFIG_RPMSG_VIRTIO is not set
> > # end of Rpmsg drivers
> > 
> > # CONFIG_SOUNDWIRE is not set
> > 
> > #
> > # SOC (System On Chip) specific Drivers
> > #
> > 
> > #
> > # Amlogic SoC drivers
> > #
> > # end of Amlogic SoC drivers
> > 
> > #
> > # Aspeed SoC drivers
> > #
> > # end of Aspeed SoC drivers
> > 
> > #
> > # Broadcom SoC drivers
> > #
> > # end of Broadcom SoC drivers
> > 
> > #
> > # NXP/Freescale QorIQ SoC drivers
> > #
> > # end of NXP/Freescale QorIQ SoC drivers
> > 
> > #
> > # i.MX SoC drivers
> > #
> > # end of i.MX SoC drivers
> > 
> > #
> > # Qualcomm SoC drivers
> > #
> > # end of Qualcomm SoC drivers
> > 
> > # CONFIG_SOC_TI is not set
> > 
> > #
> > # Xilinx SoC drivers
> > #
> > # CONFIG_XILINX_VCU is not set
> > # end of Xilinx SoC drivers
> > # end of SOC (System On Chip) specific Drivers
> > 
> > # CONFIG_PM_DEVFREQ is not set
> > # CONFIG_EXTCON is not set
> > # CONFIG_MEMORY is not set
> > CONFIG_IIO=m
> > CONFIG_IIO_BUFFER=y
> > CONFIG_IIO_BUFFER_CB=m
> > # CONFIG_IIO_BUFFER_HW_CONSUMER is not set
> > CONFIG_IIO_KFIFO_BUF=m
> > CONFIG_IIO_TRIGGERED_BUFFER=m
> > CONFIG_IIO_CONFIGFS=m
> > CONFIG_IIO_TRIGGER=y
> > CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> > # CONFIG_IIO_SW_DEVICE is not set
> > # CONFIG_IIO_SW_TRIGGER is not set
> > 
> > #
> > # Accelerometers
> > #
> > # CONFIG_ADIS16201 is not set
> > CONFIG_ADIS16209=m
> > CONFIG_ADXL345=m
> > CONFIG_ADXL345_I2C=m
> > CONFIG_ADXL345_SPI=m
> > # CONFIG_ADXL372_SPI is not set
> > # CONFIG_ADXL372_I2C is not set
> > # CONFIG_BMA180 is not set
> > CONFIG_BMA220=m
> > # CONFIG_BMA400 is not set
> > # CONFIG_BMC150_ACCEL is not set
> > CONFIG_DA280=m
> > # CONFIG_DA311 is not set
> > CONFIG_DMARD09=m
> > CONFIG_DMARD10=m
> > # CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
> > # CONFIG_IIO_ST_ACCEL_3AXIS is not set
> > CONFIG_KXSD9=m
> > CONFIG_KXSD9_SPI=m
> > # CONFIG_KXSD9_I2C is not set
> > CONFIG_KXCJK1013=m
> > CONFIG_MC3230=m
> > CONFIG_MMA7455=m
> > CONFIG_MMA7455_I2C=m
> > CONFIG_MMA7455_SPI=m
> > CONFIG_MMA7660=m
> > CONFIG_MMA8452=m
> > # CONFIG_MMA9551 is not set
> > # CONFIG_MMA9553 is not set
> > CONFIG_MXC4005=m
> > CONFIG_MXC6255=m
> > CONFIG_SCA3000=m
> > # CONFIG_STK8312 is not set
> > CONFIG_STK8BA50=m
> > # end of Accelerometers
> > 
> > #
> > # Analog to digital converters
> > #
> > CONFIG_AD_SIGMA_DELTA=m
> > # CONFIG_AD7091R5 is not set
> > # CONFIG_AD7124 is not set
> > # CONFIG_AD7266 is not set
> > CONFIG_AD7291=m
> > # CONFIG_AD7292 is not set
> > CONFIG_AD7298=m
> > CONFIG_AD7476=m
> > CONFIG_AD7606=m
> > CONFIG_AD7606_IFACE_PARALLEL=m
> > CONFIG_AD7606_IFACE_SPI=m
> > # CONFIG_AD7766 is not set
> > # CONFIG_AD7768_1 is not set
> > CONFIG_AD7780=m
> > CONFIG_AD7791=m
> > # CONFIG_AD7793 is not set
> > # CONFIG_AD7887 is not set
> > # CONFIG_AD7923 is not set
> > # CONFIG_AD7949 is not set
> > # CONFIG_AD799X is not set
> > # CONFIG_CC10001_ADC is not set
> > # CONFIG_DA9150_GPADC is not set
> > # CONFIG_HI8435 is not set
> > CONFIG_HX711=m
> > # CONFIG_INA2XX_ADC is not set
> > CONFIG_LTC2471=m
> > # CONFIG_LTC2485 is not set
> > # CONFIG_LTC2496 is not set
> > CONFIG_LTC2497=m
> > # CONFIG_MAX1027 is not set
> > # CONFIG_MAX11100 is not set
> > # CONFIG_MAX1118 is not set
> > CONFIG_MAX1363=m
> > # CONFIG_MAX9611 is not set
> > CONFIG_MCP320X=m
> > CONFIG_MCP3422=m
> > # CONFIG_MCP3911 is not set
> > CONFIG_MEN_Z188_ADC=m
> > # CONFIG_NAU7802 is not set
> > CONFIG_QCOM_VADC_COMMON=m
> > # CONFIG_QCOM_SPMI_IADC is not set
> > CONFIG_QCOM_SPMI_VADC=m
> > # CONFIG_QCOM_SPMI_ADC5 is not set
> > CONFIG_STX104=m
> > # CONFIG_TI_ADC081C is not set
> > CONFIG_TI_ADC0832=m
> > CONFIG_TI_ADC084S021=m
> > CONFIG_TI_ADC12138=m
> > CONFIG_TI_ADC108S102=m
> > # CONFIG_TI_ADC128S052 is not set
> > CONFIG_TI_ADC161S626=m
> > CONFIG_TI_ADS1015=m
> > CONFIG_TI_ADS7950=m
> > CONFIG_TI_AM335X_ADC=m
> > CONFIG_TI_TLC4541=m
> > # CONFIG_XILINX_XADC is not set
> > # end of Analog to digital converters
> > 
> > #
> > # Analog Front Ends
> > #
> > # end of Analog Front Ends
> > 
> > #
> > # Amplifiers
> > #
> > CONFIG_AD8366=m
> > # end of Amplifiers
> > 
> > #
> > # Chemical Sensors
> > #
> > CONFIG_ATLAS_PH_SENSOR=m
> > # CONFIG_BME680 is not set
> > CONFIG_CCS811=m
> > CONFIG_IAQCORE=m
> > # CONFIG_SENSIRION_SGP30 is not set
> > # CONFIG_SPS30 is not set
> > CONFIG_VZ89X=m
> > # end of Chemical Sensors
> > 
> > CONFIG_IIO_CROS_EC_SENSORS_CORE=m
> > # CONFIG_IIO_CROS_EC_SENSORS is not set
> > # CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE is not set
> > 
> > #
> > # Hid Sensor IIO Common
> > #
> > # end of Hid Sensor IIO Common
> > 
> > CONFIG_IIO_MS_SENSORS_I2C=m
> > 
> > #
> > # SSP Sensor Common
> > #
> > CONFIG_IIO_SSP_SENSORS_COMMONS=m
> > CONFIG_IIO_SSP_SENSORHUB=m
> > # end of SSP Sensor Common
> > 
> > CONFIG_IIO_ST_SENSORS_I2C=m
> > CONFIG_IIO_ST_SENSORS_SPI=m
> > CONFIG_IIO_ST_SENSORS_CORE=m
> > 
> > #
> > # Digital to analog converters
> > #
> > CONFIG_AD5064=m
> > CONFIG_AD5360=m
> > CONFIG_AD5380=m
> > CONFIG_AD5421=m
> > # CONFIG_AD5446 is not set
> > CONFIG_AD5449=m
> > CONFIG_AD5592R_BASE=m
> > # CONFIG_AD5592R is not set
> > CONFIG_AD5593R=m
> > CONFIG_AD5504=m
> > CONFIG_AD5624R_SPI=m
> > # CONFIG_LTC1660 is not set
> > CONFIG_LTC2632=m
> > # CONFIG_AD5686_SPI is not set
> > # CONFIG_AD5696_I2C is not set
> > CONFIG_AD5755=m
> > # CONFIG_AD5758 is not set
> > CONFIG_AD5761=m
> > # CONFIG_AD5764 is not set
> > CONFIG_AD5791=m
> > # CONFIG_AD7303 is not set
> > # CONFIG_CIO_DAC is not set
> > CONFIG_AD8801=m
> > # CONFIG_DS4424 is not set
> > # CONFIG_M62332 is not set
> > CONFIG_MAX517=m
> > CONFIG_MCP4725=m
> > CONFIG_MCP4922=m
> > # CONFIG_TI_DAC082S085 is not set
> > # CONFIG_TI_DAC5571 is not set
> > # CONFIG_TI_DAC7311 is not set
> > # CONFIG_TI_DAC7612 is not set
> > # end of Digital to analog converters
> > 
> > #
> > # IIO dummy driver
> > #
> > # end of IIO dummy driver
> > 
> > #
> > # Frequency Synthesizers DDS/PLL
> > #
> > 
> > #
> > # Clock Generator/Distribution
> > #
> > CONFIG_AD9523=m
> > # end of Clock Generator/Distribution
> > 
> > #
> > # Phase-Locked Loop (PLL) frequency synthesizers
> > #
> > # CONFIG_ADF4350 is not set
> > # CONFIG_ADF4371 is not set
> > # end of Phase-Locked Loop (PLL) frequency synthesizers
> > # end of Frequency Synthesizers DDS/PLL
> > 
> > #
> > # Digital gyroscope sensors
> > #
> > CONFIG_ADIS16080=m
> > # CONFIG_ADIS16130 is not set
> > CONFIG_ADIS16136=m
> > CONFIG_ADIS16260=m
> > CONFIG_ADXRS450=m
> > CONFIG_BMG160=m
> > CONFIG_BMG160_I2C=m
> > CONFIG_BMG160_SPI=m
> > # CONFIG_FXAS21002C is not set
> > CONFIG_MPU3050=m
> > CONFIG_MPU3050_I2C=m
> > CONFIG_IIO_ST_GYRO_3AXIS=m
> > CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
> > CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
> > CONFIG_ITG3200=m
> > # end of Digital gyroscope sensors
> > 
> > #
> > # Health Sensors
> > #
> > 
> > #
> > # Heart Rate Monitors
> > #
> > CONFIG_AFE4403=m
> > CONFIG_AFE4404=m
> > CONFIG_MAX30100=m
> > # CONFIG_MAX30102 is not set
> > # end of Heart Rate Monitors
> > # end of Health Sensors
> > 
> > #
> > # Humidity sensors
> > #
> > CONFIG_AM2315=m
> > CONFIG_DHT11=m
> > # CONFIG_HDC100X is not set
> > # CONFIG_HTS221 is not set
> > CONFIG_HTU21=m
> > CONFIG_SI7005=m
> > CONFIG_SI7020=m
> > # end of Humidity sensors
> > 
> > #
> > # Inertial measurement units
> > #
> > CONFIG_ADIS16400=m
> > # CONFIG_ADIS16460 is not set
> > # CONFIG_ADIS16480 is not set
> > CONFIG_BMI160=m
> > CONFIG_BMI160_I2C=m
> > CONFIG_BMI160_SPI=m
> > # CONFIG_FXOS8700_I2C is not set
> > # CONFIG_FXOS8700_SPI is not set
> > CONFIG_KMX61=m
> > CONFIG_INV_MPU6050_IIO=m
> > # CONFIG_INV_MPU6050_I2C is not set
> > CONFIG_INV_MPU6050_SPI=m
> > # CONFIG_IIO_ST_LSM6DSX is not set
> > # end of Inertial measurement units
> > 
> > CONFIG_IIO_ADIS_LIB=m
> > CONFIG_IIO_ADIS_LIB_BUFFER=y
> > 
> > #
> > # Light sensors
> > #
> > # CONFIG_ACPI_ALS is not set
> > CONFIG_ADJD_S311=m
> > # CONFIG_ADUX1020 is not set
> > # CONFIG_AL3320A is not set
> > CONFIG_APDS9300=m
> > # CONFIG_APDS9960 is not set
> > CONFIG_BH1750=m
> > # CONFIG_BH1780 is not set
> > CONFIG_CM32181=m
> > CONFIG_CM3232=m
> > # CONFIG_CM3323 is not set
> > CONFIG_CM36651=m
> > CONFIG_IIO_CROS_EC_LIGHT_PROX=m
> > CONFIG_GP2AP020A00F=m
> > # CONFIG_SENSORS_ISL29018 is not set
> > CONFIG_SENSORS_ISL29028=m
> > # CONFIG_ISL29125 is not set
> > # CONFIG_JSA1212 is not set
> > # CONFIG_RPR0521 is not set
> > CONFIG_SENSORS_LM3533=m
> > CONFIG_LTR501=m
> > # CONFIG_LV0104CS is not set
> > # CONFIG_MAX44000 is not set
> > # CONFIG_MAX44009 is not set
> > # CONFIG_NOA1305 is not set
> > CONFIG_OPT3001=m
> > CONFIG_PA12203001=m
> > # CONFIG_SI1133 is not set
> > # CONFIG_SI1145 is not set
> > # CONFIG_STK3310 is not set
> > # CONFIG_ST_UVIS25 is not set
> > CONFIG_TCS3414=m
> > CONFIG_TCS3472=m
> > CONFIG_SENSORS_TSL2563=m
> > # CONFIG_TSL2583 is not set
> > # CONFIG_TSL2772 is not set
> > CONFIG_TSL4531=m
> > # CONFIG_US5182D is not set
> > # CONFIG_VCNL4000 is not set
> > # CONFIG_VCNL4035 is not set
> > # CONFIG_VEML6030 is not set
> > CONFIG_VEML6070=m
> > # CONFIG_VL6180 is not set
> > # CONFIG_ZOPT2201 is not set
> > # end of Light sensors
> > 
> > #
> > # Magnetometer sensors
> > #
> > CONFIG_AK8975=m
> > CONFIG_AK09911=m
> > CONFIG_BMC150_MAGN=m
> > # CONFIG_BMC150_MAGN_I2C is not set
> > CONFIG_BMC150_MAGN_SPI=m
> > CONFIG_MAG3110=m
> > CONFIG_MMC35240=m
> > # CONFIG_IIO_ST_MAGN_3AXIS is not set
> > CONFIG_SENSORS_HMC5843=m
> > CONFIG_SENSORS_HMC5843_I2C=m
> > CONFIG_SENSORS_HMC5843_SPI=m
> > # CONFIG_SENSORS_RM3100_I2C is not set
> > # CONFIG_SENSORS_RM3100_SPI is not set
> > # end of Magnetometer sensors
> > 
> > #
> > # Multiplexers
> > #
> > # end of Multiplexers
> > 
> > #
> > # Inclinometer sensors
> > #
> > # end of Inclinometer sensors
> > 
> > #
> > # Triggers - standalone
> > #
> > CONFIG_IIO_INTERRUPT_TRIGGER=m
> > CONFIG_IIO_SYSFS_TRIGGER=m
> > # end of Triggers - standalone
> > 
> > #
> > # Digital potentiometers
> > #
> > # CONFIG_AD5272 is not set
> > CONFIG_DS1803=m
> > # CONFIG_MAX5432 is not set
> > # CONFIG_MAX5481 is not set
> > CONFIG_MAX5487=m
> > # CONFIG_MCP4018 is not set
> > # CONFIG_MCP4131 is not set
> > CONFIG_MCP4531=m
> > # CONFIG_MCP41010 is not set
> > CONFIG_TPL0102=m
> > # end of Digital potentiometers
> > 
> > #
> > # Digital potentiostats
> > #
> > CONFIG_LMP91000=m
> > # end of Digital potentiostats
> > 
> > #
> > # Pressure sensors
> > #
> > # CONFIG_ABP060MG is not set
> > # CONFIG_BMP280 is not set
> > # CONFIG_IIO_CROS_EC_BARO is not set
> > # CONFIG_DLHL60D is not set
> > # CONFIG_DPS310 is not set
> > CONFIG_HP03=m
> > CONFIG_MPL115=m
> > CONFIG_MPL115_I2C=m
> > CONFIG_MPL115_SPI=m
> > CONFIG_MPL3115=m
> > CONFIG_MS5611=m
> > # CONFIG_MS5611_I2C is not set
> > CONFIG_MS5611_SPI=m
> > CONFIG_MS5637=m
> > CONFIG_IIO_ST_PRESS=m
> > CONFIG_IIO_ST_PRESS_I2C=m
> > CONFIG_IIO_ST_PRESS_SPI=m
> > CONFIG_T5403=m
> > CONFIG_HP206C=m
> > # CONFIG_ZPA2326 is not set
> > # end of Pressure sensors
> > 
> > #
> > # Lightning sensors
> > #
> > CONFIG_AS3935=m
> > # end of Lightning sensors
> > 
> > #
> > # Proximity and distance sensors
> > #
> > # CONFIG_ISL29501 is not set
> > # CONFIG_LIDAR_LITE_V2 is not set
> > # CONFIG_MB1232 is not set
> > # CONFIG_PING is not set
> > # CONFIG_RFD77402 is not set
> > # CONFIG_SRF04 is not set
> > # CONFIG_SX9500 is not set
> > CONFIG_SRF08=m
> > # CONFIG_VL53L0X_I2C is not set
> > # end of Proximity and distance sensors
> > 
> > #
> > # Resolver to digital converters
> > #
> > # CONFIG_AD2S90 is not set
> > CONFIG_AD2S1200=m
> > # end of Resolver to digital converters
> > 
> > #
> > # Temperature sensors
> > #
> > # CONFIG_LTC2983 is not set
> > CONFIG_MAXIM_THERMOCOUPLE=m
> > CONFIG_MLX90614=m
> > # CONFIG_MLX90632 is not set
> > CONFIG_TMP006=m
> > CONFIG_TMP007=m
> > CONFIG_TSYS01=m
> > CONFIG_TSYS02D=m
> > # CONFIG_MAX31856 is not set
> > # end of Temperature sensors
> > 
> > # CONFIG_NTB is not set
> > # CONFIG_VME_BUS is not set
> > # CONFIG_PWM is not set
> > 
> > #
> > # IRQ chip support
> > #
> > # end of IRQ chip support
> > 
> > CONFIG_IPACK_BUS=m
> > # CONFIG_BOARD_TPCI200 is not set
> > # CONFIG_SERIAL_IPOCTAL is not set
> > CONFIG_RESET_CONTROLLER=y
> > # CONFIG_RESET_BRCMSTB_RESCAL is not set
> > CONFIG_RESET_TI_SYSCON=y
> > 
> > #
> > # PHY Subsystem
> > #
> > CONFIG_GENERIC_PHY=y
> > # CONFIG_BCM_KONA_USB2_PHY is not set
> > # CONFIG_PHY_PXA_28NM_HSIC is not set
> > CONFIG_PHY_PXA_28NM_USB2=m
> > # CONFIG_PHY_CPCAP_USB is not set
> > # CONFIG_PHY_INTEL_EMMC is not set
> > # end of PHY Subsystem
> > 
> > # CONFIG_POWERCAP is not set
> > CONFIG_MCB=y
> > # CONFIG_MCB_PCI is not set
> > CONFIG_MCB_LPC=y
> > 
> > #
> > # Performance monitor support
> > #
> > # end of Performance monitor support
> > 
> > CONFIG_RAS=y
> > # CONFIG_USB4 is not set
> > 
> > #
> > # Android
> > #
> > CONFIG_ANDROID=y
> > CONFIG_ANDROID_BINDER_IPC=y
> > # CONFIG_ANDROID_BINDERFS is not set
> > CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
> > # CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
> > # end of Android
> > 
> > # CONFIG_LIBNVDIMM is not set
> > CONFIG_DAX=y
> > CONFIG_NVMEM=y
> > CONFIG_NVMEM_SYSFS=y
> > # CONFIG_NVMEM_SPMI_SDAM is not set
> > 
> > #
> > # HW tracing support
> > #
> > # CONFIG_STM is not set
> > CONFIG_INTEL_TH=y
> > # CONFIG_INTEL_TH_PCI is not set
> > # CONFIG_INTEL_TH_ACPI is not set
> > # CONFIG_INTEL_TH_GTH is not set
> > CONFIG_INTEL_TH_MSU=m
> > CONFIG_INTEL_TH_PTI=y
> > CONFIG_INTEL_TH_DEBUG=y
> > # end of HW tracing support
> > 
> > # CONFIG_FPGA is not set
> > # CONFIG_TEE is not set
> > # CONFIG_UNISYS_VISORBUS is not set
> > # CONFIG_SIOX is not set
> > # CONFIG_SLIMBUS is not set
> > # CONFIG_INTERCONNECT is not set
> > # CONFIG_COUNTER is not set
> > # end of Device Drivers
> > 
> > #
> > # File systems
> > #
> > CONFIG_DCACHE_WORD_ACCESS=y
> > # CONFIG_VALIDATE_FS_PARSER is not set
> > CONFIG_FS_IOMAP=y
> > # CONFIG_EXT2_FS is not set
> > # CONFIG_EXT3_FS is not set
> > # CONFIG_EXT4_FS is not set
> > # CONFIG_REISERFS_FS is not set
> > # CONFIG_JFS_FS is not set
> > CONFIG_XFS_FS=m
> > # CONFIG_XFS_QUOTA is not set
> > # CONFIG_XFS_POSIX_ACL is not set
> > # CONFIG_XFS_RT is not set
> > # CONFIG_XFS_ONLINE_SCRUB is not set
> > # CONFIG_XFS_WARN is not set
> > # CONFIG_XFS_DEBUG is not set
> > # CONFIG_GFS2_FS is not set
> > # CONFIG_OCFS2_FS is not set
> > CONFIG_BTRFS_FS=m
> > # CONFIG_BTRFS_FS_POSIX_ACL is not set
> > # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> > # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> > # CONFIG_BTRFS_DEBUG is not set
> > # CONFIG_BTRFS_ASSERT is not set
> > # CONFIG_BTRFS_FS_REF_VERIFY is not set
> > # CONFIG_NILFS2_FS is not set
> > # CONFIG_F2FS_FS is not set
> > # CONFIG_FS_DAX is not set
> > CONFIG_FS_POSIX_ACL=y
> > CONFIG_EXPORTFS=y
> > # CONFIG_EXPORTFS_BLOCK_OPS is not set
> > CONFIG_FILE_LOCKING=y
> > CONFIG_MANDATORY_FILE_LOCKING=y
> > # CONFIG_FS_ENCRYPTION is not set
> > # CONFIG_FS_VERITY is not set
> > CONFIG_FSNOTIFY=y
> > # CONFIG_DNOTIFY is not set
> > CONFIG_INOTIFY_USER=y
> > CONFIG_FANOTIFY=y
> > CONFIG_QUOTA=y
> > # CONFIG_QUOTA_NETLINK_INTERFACE is not set
> > CONFIG_PRINT_QUOTA_WARNING=y
> > CONFIG_QUOTA_DEBUG=y
> > CONFIG_QFMT_V1=y
> > # CONFIG_QFMT_V2 is not set
> > CONFIG_QUOTACTL=y
> > # CONFIG_AUTOFS4_FS is not set
> > # CONFIG_AUTOFS_FS is not set
> > CONFIG_FUSE_FS=y
> > CONFIG_CUSE=m
> > # CONFIG_VIRTIO_FS is not set
> > CONFIG_OVERLAY_FS=m
> > CONFIG_OVERLAY_FS_REDIRECT_DIR=y
> > CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
> > # CONFIG_OVERLAY_FS_INDEX is not set
> > # CONFIG_OVERLAY_FS_XINO_AUTO is not set
> > # CONFIG_OVERLAY_FS_METACOPY is not set
> > 
> > #
> > # Caches
> > #
> > CONFIG_FSCACHE=y
> > # CONFIG_FSCACHE_STATS is not set
> > # CONFIG_FSCACHE_HISTOGRAM is not set
> > CONFIG_FSCACHE_DEBUG=y
> > # CONFIG_FSCACHE_OBJECT_LIST is not set
> > # CONFIG_CACHEFILES is not set
> > # end of Caches
> > 
> > #
> > # CD-ROM/DVD Filesystems
> > #
> > # CONFIG_ISO9660_FS is not set
> > # CONFIG_UDF_FS is not set
> > # end of CD-ROM/DVD Filesystems
> > 
> > #
> > # DOS/FAT/NT Filesystems
> > #
> > # CONFIG_MSDOS_FS is not set
> > # CONFIG_VFAT_FS is not set
> > # CONFIG_NTFS_FS is not set
> > # end of DOS/FAT/NT Filesystems
> > 
> > #
> > # Pseudo filesystems
> > #
> > CONFIG_PROC_FS=y
> > # CONFIG_PROC_KCORE is not set
> > CONFIG_PROC_VMCORE=y
> > # CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
> > CONFIG_PROC_SYSCTL=y
> > CONFIG_PROC_PAGE_MONITOR=y
> > CONFIG_PROC_CHILDREN=y
> > CONFIG_PROC_PID_ARCH_STATUS=y
> > CONFIG_PROC_CPU_RESCTRL=y
> > CONFIG_KERNFS=y
> > CONFIG_SYSFS=y
> > CONFIG_TMPFS=y
> > CONFIG_TMPFS_POSIX_ACL=y
> > CONFIG_TMPFS_XATTR=y
> > CONFIG_HUGETLBFS=y
> > CONFIG_HUGETLB_PAGE=y
> > CONFIG_MEMFD_CREATE=y
> > CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> > CONFIG_CONFIGFS_FS=m
> > CONFIG_EFIVAR_FS=m
> > # end of Pseudo filesystems
> > 
> > CONFIG_MISC_FILESYSTEMS=y
> > # CONFIG_ORANGEFS_FS is not set
> > # CONFIG_ADFS_FS is not set
> > # CONFIG_AFFS_FS is not set
> > # CONFIG_ECRYPT_FS is not set
> > # CONFIG_HFS_FS is not set
> > # CONFIG_HFSPLUS_FS is not set
> > # CONFIG_BEFS_FS is not set
> > # CONFIG_BFS_FS is not set
> > # CONFIG_EFS_FS is not set
> > # CONFIG_JFFS2_FS is not set
> > # CONFIG_UBIFS_FS is not set
> > # CONFIG_CRAMFS is not set
> > # CONFIG_SQUASHFS is not set
> > # CONFIG_VXFS_FS is not set
> > # CONFIG_MINIX_FS is not set
> > # CONFIG_OMFS_FS is not set
> > # CONFIG_HPFS_FS is not set
> > # CONFIG_QNX4FS_FS is not set
> > # CONFIG_QNX6FS_FS is not set
> > # CONFIG_ROMFS_FS is not set
> > CONFIG_PSTORE=y
> > CONFIG_PSTORE_DEFLATE_COMPRESS=y
> > # CONFIG_PSTORE_LZO_COMPRESS is not set
> > # CONFIG_PSTORE_LZ4_COMPRESS is not set
> > # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
> > # CONFIG_PSTORE_842_COMPRESS is not set
> > # CONFIG_PSTORE_ZSTD_COMPRESS is not set
> > CONFIG_PSTORE_COMPRESS=y
> > CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
> > CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
> > CONFIG_PSTORE_CONSOLE=y
> > CONFIG_PSTORE_PMSG=y
> > # CONFIG_PSTORE_FTRACE is not set
> > CONFIG_PSTORE_RAM=m
> > # CONFIG_SYSV_FS is not set
> > # CONFIG_UFS_FS is not set
> > # CONFIG_EROFS_FS is not set
> > CONFIG_NETWORK_FILESYSTEMS=y
> > CONFIG_NFS_FS=y
> > CONFIG_NFS_V2=y
> > CONFIG_NFS_V3=y
> > # CONFIG_NFS_V3_ACL is not set
> > CONFIG_NFS_V4=m
> > # CONFIG_NFS_SWAP is not set
> > # CONFIG_NFS_V4_1 is not set
> > # CONFIG_ROOT_NFS is not set
> > # CONFIG_NFS_FSCACHE is not set
> > # CONFIG_NFS_USE_LEGACY_DNS is not set
> > CONFIG_NFS_USE_KERNEL_DNS=y
> > CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> > # CONFIG_NFSD is not set
> > CONFIG_GRACE_PERIOD=y
> > CONFIG_LOCKD=y
> > CONFIG_LOCKD_V4=y
> > CONFIG_NFS_COMMON=y
> > CONFIG_SUNRPC=y
> > CONFIG_SUNRPC_GSS=m
> > CONFIG_RPCSEC_GSS_KRB5=m
> > # CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
> > # CONFIG_SUNRPC_DEBUG is not set
> > CONFIG_CEPH_FS=y
> > CONFIG_CEPH_FSCACHE=y
> > # CONFIG_CEPH_FS_POSIX_ACL is not set
> > CONFIG_CIFS=m
> > # CONFIG_CIFS_STATS2 is not set
> > # CONFIG_CIFS_ALLOW_INSECURE_LEGACY is not set
> > CONFIG_CIFS_UPCALL=y
> > CONFIG_CIFS_XATTR=y
> > # CONFIG_CIFS_DEBUG is not set
> > # CONFIG_CIFS_DFS_UPCALL is not set
> > # CONFIG_CIFS_FSCACHE is not set
> > # CONFIG_CODA_FS is not set
> > # CONFIG_AFS_FS is not set
> > # CONFIG_9P_FS is not set
> > CONFIG_NLS=y
> > CONFIG_NLS_DEFAULT="iso8859-1"
> > CONFIG_NLS_CODEPAGE_437=m
> > # CONFIG_NLS_CODEPAGE_737 is not set
> > # CONFIG_NLS_CODEPAGE_775 is not set
> > CONFIG_NLS_CODEPAGE_850=y
> > CONFIG_NLS_CODEPAGE_852=m
> > CONFIG_NLS_CODEPAGE_855=y
> > # CONFIG_NLS_CODEPAGE_857 is not set
> > # CONFIG_NLS_CODEPAGE_860 is not set
> > CONFIG_NLS_CODEPAGE_861=m
> > CONFIG_NLS_CODEPAGE_862=m
> > # CONFIG_NLS_CODEPAGE_863 is not set
> > CONFIG_NLS_CODEPAGE_864=m
> > # CONFIG_NLS_CODEPAGE_865 is not set
> > CONFIG_NLS_CODEPAGE_866=m
> > CONFIG_NLS_CODEPAGE_869=y
> > CONFIG_NLS_CODEPAGE_936=m
> > CONFIG_NLS_CODEPAGE_950=y
> > CONFIG_NLS_CODEPAGE_932=y
> > CONFIG_NLS_CODEPAGE_949=y
> > CONFIG_NLS_CODEPAGE_874=m
> > CONFIG_NLS_ISO8859_8=y
> > CONFIG_NLS_CODEPAGE_1250=y
> > # CONFIG_NLS_CODEPAGE_1251 is not set
> > CONFIG_NLS_ASCII=m
> > # CONFIG_NLS_ISO8859_1 is not set
> > CONFIG_NLS_ISO8859_2=m
> > CONFIG_NLS_ISO8859_3=y
> > CONFIG_NLS_ISO8859_4=m
> > CONFIG_NLS_ISO8859_5=y
> > # CONFIG_NLS_ISO8859_6 is not set
> > # CONFIG_NLS_ISO8859_7 is not set
> > CONFIG_NLS_ISO8859_9=y
> > CONFIG_NLS_ISO8859_13=m
> > CONFIG_NLS_ISO8859_14=m
> > CONFIG_NLS_ISO8859_15=m
> > CONFIG_NLS_KOI8_R=y
> > CONFIG_NLS_KOI8_U=y
> > CONFIG_NLS_MAC_ROMAN=y
> > CONFIG_NLS_MAC_CELTIC=y
> > CONFIG_NLS_MAC_CENTEURO=m
> > CONFIG_NLS_MAC_CROATIAN=m
> > CONFIG_NLS_MAC_CYRILLIC=m
> > # CONFIG_NLS_MAC_GAELIC is not set
> > # CONFIG_NLS_MAC_GREEK is not set
> > # CONFIG_NLS_MAC_ICELAND is not set
> > # CONFIG_NLS_MAC_INUIT is not set
> > CONFIG_NLS_MAC_ROMANIAN=y
> > CONFIG_NLS_MAC_TURKISH=m
> > CONFIG_NLS_UTF8=y
> > CONFIG_DLM=m
> > CONFIG_DLM_DEBUG=y
> > # CONFIG_UNICODE is not set
> > CONFIG_IO_WQ=y
> > # end of File systems
> > 
> > #
> > # Security options
> > #
> > CONFIG_KEYS=y
> > # CONFIG_KEYS_REQUEST_CACHE is not set
> > CONFIG_PERSISTENT_KEYRINGS=y
> > CONFIG_BIG_KEYS=y
> > # CONFIG_ENCRYPTED_KEYS is not set
> > # CONFIG_KEY_DH_OPERATIONS is not set
> > # CONFIG_SECURITY_DMESG_RESTRICT is not set
> > # CONFIG_SECURITY is not set
> > CONFIG_SECURITYFS=y
> > CONFIG_PAGE_TABLE_ISOLATION=y
> > CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> > CONFIG_HARDENED_USERCOPY=y
> > CONFIG_HARDENED_USERCOPY_FALLBACK=y
> > CONFIG_HARDENED_USERCOPY_PAGESPAN=y
> > CONFIG_FORTIFY_SOURCE=y
> > # CONFIG_STATIC_USERMODEHELPER is not set
> > CONFIG_DEFAULT_SECURITY_DAC=y
> > CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity"
> > 
> > #
> > # Kernel hardening options
> > #
> > 
> > #
> > # Memory initialization
> > #
> > CONFIG_INIT_STACK_NONE=y
> > # CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
> > # CONFIG_GCC_PLUGIN_STACKLEAK is not set
> > # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> > # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> > # end of Memory initialization
> > # end of Kernel hardening options
> > # end of Security options
> > 
> > CONFIG_XOR_BLOCKS=m
> > CONFIG_CRYPTO=y
> > 
> > #
> > # Crypto core or helper
> > #
> > CONFIG_CRYPTO_ALGAPI=y
> > CONFIG_CRYPTO_ALGAPI2=y
> > CONFIG_CRYPTO_AEAD=y
> > CONFIG_CRYPTO_AEAD2=y
> > CONFIG_CRYPTO_SKCIPHER=y
> > CONFIG_CRYPTO_SKCIPHER2=y
> > CONFIG_CRYPTO_HASH=y
> > CONFIG_CRYPTO_HASH2=y
> > CONFIG_CRYPTO_RNG=y
> > CONFIG_CRYPTO_RNG2=y
> > CONFIG_CRYPTO_RNG_DEFAULT=y
> > CONFIG_CRYPTO_AKCIPHER2=y
> > CONFIG_CRYPTO_KPP2=y
> > CONFIG_CRYPTO_KPP=y
> > CONFIG_CRYPTO_ACOMP2=y
> > CONFIG_CRYPTO_MANAGER=y
> > CONFIG_CRYPTO_MANAGER2=y
> > CONFIG_CRYPTO_USER=m
> > CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> > CONFIG_CRYPTO_GF128MUL=y
> > CONFIG_CRYPTO_NULL=y
> > CONFIG_CRYPTO_NULL2=y
> > CONFIG_CRYPTO_CRYPTD=y
> > CONFIG_CRYPTO_AUTHENC=m
> > # CONFIG_CRYPTO_TEST is not set
> > CONFIG_CRYPTO_SIMD=y
> > CONFIG_CRYPTO_GLUE_HELPER_X86=y
> > 
> > #
> > # Public-key cryptography
> > #
> > # CONFIG_CRYPTO_RSA is not set
> > # CONFIG_CRYPTO_DH is not set
> > CONFIG_CRYPTO_ECC=y
> > CONFIG_CRYPTO_ECDH=y
> > # CONFIG_CRYPTO_ECRDSA is not set
> > # CONFIG_CRYPTO_CURVE25519 is not set
> > # CONFIG_CRYPTO_CURVE25519_X86 is not set
> > 
> > #
> > # Authenticated Encryption with Associated Data
> > #
> > CONFIG_CRYPTO_CCM=y
> > CONFIG_CRYPTO_GCM=y
> > CONFIG_CRYPTO_CHACHA20POLY1305=m
> > # CONFIG_CRYPTO_AEGIS128 is not set
> > # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
> > CONFIG_CRYPTO_SEQIV=y
> > CONFIG_CRYPTO_ECHAINIV=m
> > 
> > #
> > # Block modes
> > #
> > CONFIG_CRYPTO_CBC=y
> > # CONFIG_CRYPTO_CFB is not set
> > CONFIG_CRYPTO_CTR=y
> > CONFIG_CRYPTO_CTS=m
> > CONFIG_CRYPTO_ECB=y
> > CONFIG_CRYPTO_LRW=y
> > # CONFIG_CRYPTO_OFB is not set
> > CONFIG_CRYPTO_PCBC=y
> > CONFIG_CRYPTO_XTS=y
> > CONFIG_CRYPTO_KEYWRAP=m
> > # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
> > # CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
> > # CONFIG_CRYPTO_ADIANTUM is not set
> > # CONFIG_CRYPTO_ESSIV is not set
> > 
> > #
> > # Hash modes
> > #
> > CONFIG_CRYPTO_CMAC=y
> > CONFIG_CRYPTO_HMAC=y
> > # CONFIG_CRYPTO_XCBC is not set
> > CONFIG_CRYPTO_VMAC=y
> > 
> > #
> > # Digest
> > #
> > CONFIG_CRYPTO_CRC32C=y
> > CONFIG_CRYPTO_CRC32C_INTEL=m
> > CONFIG_CRYPTO_CRC32=m
> > CONFIG_CRYPTO_CRC32_PCLMUL=m
> > CONFIG_CRYPTO_XXHASH=m
> > CONFIG_CRYPTO_BLAKE2B=m
> > # CONFIG_CRYPTO_BLAKE2S is not set
> > # CONFIG_CRYPTO_BLAKE2S_X86 is not set
> > CONFIG_CRYPTO_CRCT10DIF=m
> > CONFIG_CRYPTO_GHASH=y
> > CONFIG_CRYPTO_POLY1305=y
> > # CONFIG_CRYPTO_POLY1305_X86_64 is not set
> > CONFIG_CRYPTO_MD4=m
> > CONFIG_CRYPTO_MD5=y
> > CONFIG_CRYPTO_MICHAEL_MIC=m
> > CONFIG_CRYPTO_RMD128=m
> > CONFIG_CRYPTO_RMD160=y
> > CONFIG_CRYPTO_RMD256=y
> > # CONFIG_CRYPTO_RMD320 is not set
> > CONFIG_CRYPTO_SHA1=y
> > CONFIG_CRYPTO_SHA1_SSSE3=y
> > # CONFIG_CRYPTO_SHA256_SSSE3 is not set
> > CONFIG_CRYPTO_SHA512_SSSE3=m
> > CONFIG_CRYPTO_SHA256=y
> > CONFIG_CRYPTO_SHA512=y
> > CONFIG_CRYPTO_SHA3=m
> > # CONFIG_CRYPTO_SM3 is not set
> > # CONFIG_CRYPTO_STREEBOG is not set
> > # CONFIG_CRYPTO_TGR192 is not set
> > CONFIG_CRYPTO_WP512=y
> > CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
> > 
> > #
> > # Ciphers
> > #
> > CONFIG_CRYPTO_AES=y
> > # CONFIG_CRYPTO_AES_TI is not set
> > CONFIG_CRYPTO_AES_NI_INTEL=m
> > CONFIG_CRYPTO_ANUBIS=m
> > CONFIG_CRYPTO_ARC4=y
> > CONFIG_CRYPTO_BLOWFISH=y
> > CONFIG_CRYPTO_BLOWFISH_COMMON=y
> > CONFIG_CRYPTO_BLOWFISH_X86_64=m
> > # CONFIG_CRYPTO_CAMELLIA is not set
> > CONFIG_CRYPTO_CAMELLIA_X86_64=y
> > CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
> > CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
> > CONFIG_CRYPTO_CAST_COMMON=y
> > CONFIG_CRYPTO_CAST5=m
> > CONFIG_CRYPTO_CAST5_AVX_X86_64=m
> > CONFIG_CRYPTO_CAST6=y
> > CONFIG_CRYPTO_CAST6_AVX_X86_64=y
> > CONFIG_CRYPTO_DES=m
> > # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
> > CONFIG_CRYPTO_FCRYPT=y
> > # CONFIG_CRYPTO_KHAZAD is not set
> > CONFIG_CRYPTO_SALSA20=m
> > CONFIG_CRYPTO_CHACHA20=y
> > CONFIG_CRYPTO_CHACHA20_X86_64=y
> > # CONFIG_CRYPTO_SEED is not set
> > CONFIG_CRYPTO_SERPENT=y
> > CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
> > CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
> > CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
> > # CONFIG_CRYPTO_SM4 is not set
> > CONFIG_CRYPTO_TEA=m
> > CONFIG_CRYPTO_TWOFISH=y
> > CONFIG_CRYPTO_TWOFISH_COMMON=y
> > CONFIG_CRYPTO_TWOFISH_X86_64=m
> > CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
> > CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
> > 
> > #
> > # Compression
> > #
> > CONFIG_CRYPTO_DEFLATE=y
> > CONFIG_CRYPTO_LZO=y
> > # CONFIG_CRYPTO_842 is not set
> > CONFIG_CRYPTO_LZ4=y
> > CONFIG_CRYPTO_LZ4HC=m
> > # CONFIG_CRYPTO_ZSTD is not set
> > 
> > #
> > # Random Number Generation
> > #
> > # CONFIG_CRYPTO_ANSI_CPRNG is not set
> > CONFIG_CRYPTO_DRBG_MENU=y
> > CONFIG_CRYPTO_DRBG_HMAC=y
> > # CONFIG_CRYPTO_DRBG_HASH is not set
> > # CONFIG_CRYPTO_DRBG_CTR is not set
> > CONFIG_CRYPTO_DRBG=y
> > CONFIG_CRYPTO_JITTERENTROPY=y
> > CONFIG_CRYPTO_USER_API=y
> > CONFIG_CRYPTO_USER_API_HASH=y
> > CONFIG_CRYPTO_USER_API_SKCIPHER=y
> > CONFIG_CRYPTO_USER_API_RNG=y
> > CONFIG_CRYPTO_USER_API_AEAD=y
> > # CONFIG_CRYPTO_STATS is not set
> > 
> > #
> > # Crypto library routines
> > #
> > CONFIG_CRYPTO_LIB_AES=y
> > CONFIG_CRYPTO_LIB_ARC4=y
> > # CONFIG_CRYPTO_LIB_BLAKE2S is not set
> > CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
> > CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> > # CONFIG_CRYPTO_LIB_CHACHA is not set
> > # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> > CONFIG_CRYPTO_LIB_DES=m
> > CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
> > CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> > # CONFIG_CRYPTO_LIB_POLY1305 is not set
> > # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> > CONFIG_CRYPTO_LIB_SHA256=y
> > # CONFIG_CRYPTO_HW is not set
> > # CONFIG_ASYMMETRIC_KEY_TYPE is not set
> > 
> > #
> > # Certificates for signature checking
> > #
> > CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> > CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> > # end of Certificates for signature checking
> > 
> > CONFIG_BINARY_PRINTF=y
> > 
> > #
> > # Library routines
> > #
> > CONFIG_RAID6_PQ=m
> > CONFIG_RAID6_PQ_BENCHMARK=y
> > # CONFIG_PACKING is not set
> > CONFIG_BITREVERSE=y
> > CONFIG_GENERIC_STRNCPY_FROM_USER=y
> > CONFIG_GENERIC_STRNLEN_USER=y
> > CONFIG_GENERIC_NET_UTILS=y
> > CONFIG_GENERIC_FIND_FIRST_BIT=y
> > # CONFIG_CORDIC is not set
> > CONFIG_PRIME_NUMBERS=m
> > CONFIG_RATIONAL=y
> > CONFIG_GENERIC_PCI_IOMAP=y
> > CONFIG_GENERIC_IOMAP=y
> > CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> > CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> > CONFIG_CRC_CCITT=y
> > CONFIG_CRC16=y
> > # CONFIG_CRC_T10DIF is not set
> > CONFIG_CRC_ITU_T=m
> > CONFIG_CRC32=y
> > CONFIG_CRC32_SELFTEST=y
> > # CONFIG_CRC32_SLICEBY8 is not set
> > CONFIG_CRC32_SLICEBY4=y
> > # CONFIG_CRC32_SARWATE is not set
> > # CONFIG_CRC32_BIT is not set
> > # CONFIG_CRC64 is not set
> > CONFIG_CRC4=y
> > CONFIG_CRC7=m
> > CONFIG_LIBCRC32C=y
> > # CONFIG_CRC8 is not set
> > CONFIG_XXHASH=y
> > CONFIG_RANDOM32_SELFTEST=y
> > CONFIG_ZLIB_INFLATE=y
> > CONFIG_ZLIB_DEFLATE=y
> > CONFIG_LZO_COMPRESS=y
> > CONFIG_LZO_DECOMPRESS=y
> > CONFIG_LZ4_COMPRESS=y
> > CONFIG_LZ4HC_COMPRESS=m
> > CONFIG_LZ4_DECOMPRESS=y
> > CONFIG_ZSTD_COMPRESS=m
> > CONFIG_ZSTD_DECOMPRESS=m
> > CONFIG_XZ_DEC=y
> > CONFIG_XZ_DEC_X86=y
> > CONFIG_XZ_DEC_POWERPC=y
> > # CONFIG_XZ_DEC_IA64 is not set
> > # CONFIG_XZ_DEC_ARM is not set
> > # CONFIG_XZ_DEC_ARMTHUMB is not set
> > CONFIG_XZ_DEC_SPARC=y
> > CONFIG_XZ_DEC_BCJ=y
> > # CONFIG_XZ_DEC_TEST is not set
> > CONFIG_DECOMPRESS_GZIP=y
> > CONFIG_DECOMPRESS_BZIP2=y
> > CONFIG_DECOMPRESS_LZMA=y
> > CONFIG_DECOMPRESS_XZ=y
> > CONFIG_DECOMPRESS_LZO=y
> > CONFIG_DECOMPRESS_LZ4=y
> > CONFIG_GENERIC_ALLOCATOR=y
> > CONFIG_REED_SOLOMON=m
> > CONFIG_REED_SOLOMON_ENC8=y
> > CONFIG_REED_SOLOMON_DEC8=y
> > CONFIG_BCH=y
> > CONFIG_BCH_CONST_PARAMS=y
> > CONFIG_TEXTSEARCH=y
> > CONFIG_TEXTSEARCH_KMP=y
> > CONFIG_TEXTSEARCH_BM=y
> > CONFIG_TEXTSEARCH_FSM=y
> > CONFIG_ASSOCIATIVE_ARRAY=y
> > CONFIG_HAS_IOMEM=y
> > CONFIG_HAS_IOPORT_MAP=y
> > CONFIG_HAS_DMA=y
> > CONFIG_NEED_SG_DMA_LENGTH=y
> > CONFIG_NEED_DMA_MAP_STATE=y
> > CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> > CONFIG_SWIOTLB=y
> > # CONFIG_DMA_API_DEBUG is not set
> > CONFIG_SGL_ALLOC=y
> > CONFIG_DQL=y
> > CONFIG_GLOB=y
> > # CONFIG_GLOB_SELFTEST is not set
> > CONFIG_NLATTR=y
> > # CONFIG_IRQ_POLL is not set
> > CONFIG_LIBXBC=y
> > CONFIG_OID_REGISTRY=m
> > CONFIG_UCS2_STRING=y
> > CONFIG_HAVE_GENERIC_VDSO=y
> > CONFIG_GENERIC_GETTIMEOFDAY=y
> > CONFIG_GENERIC_VDSO_TIME_NS=y
> > CONFIG_FONT_SUPPORT=y
> > CONFIG_FONT_8x16=y
> > CONFIG_FONT_AUTOSELECT=y
> > CONFIG_ARCH_HAS_PMEM_API=y
> > CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> > CONFIG_ARCH_STACKWALK=y
> > CONFIG_STACKDEPOT=y
> > CONFIG_SBITMAP=y
> > CONFIG_STRING_SELFTEST=y
> > # end of Library routines
> > 
> > #
> > # Kernel hacking
> > #
> > 
> > #
> > # printk and dmesg options
> > #
> > CONFIG_PRINTK_TIME=y
> > # CONFIG_PRINTK_CALLER is not set
> > CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> > CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> > CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> > # CONFIG_BOOT_PRINTK_DELAY is not set
> > CONFIG_DYNAMIC_DEBUG=y
> > CONFIG_SYMBOLIC_ERRNAME=y
> > CONFIG_DEBUG_BUGVERBOSE=y
> > # end of printk and dmesg options
> > 
> > #
> > # Compile-time checks and compiler options
> > #
> > CONFIG_DEBUG_INFO=y
> > CONFIG_DEBUG_INFO_REDUCED=y
> > # CONFIG_DEBUG_INFO_SPLIT is not set
> > # CONFIG_DEBUG_INFO_DWARF4 is not set
> > # CONFIG_DEBUG_INFO_BTF is not set
> > # CONFIG_GDB_SCRIPTS is not set
> > # CONFIG_ENABLE_MUST_CHECK is not set
> > CONFIG_FRAME_WARN=8192
> > CONFIG_STRIP_ASM_SYMS=y
> > CONFIG_READABLE_ASM=y
> > # CONFIG_HEADERS_INSTALL is not set
> > CONFIG_OPTIMIZE_INLINING=y
> > # CONFIG_DEBUG_SECTION_MISMATCH is not set
> > # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
> > CONFIG_STACK_VALIDATION=y
> > CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> > # end of Compile-time checks and compiler options
> > 
> > #
> > # Generic Kernel Debugging Instruments
> > #
> > CONFIG_MAGIC_SYSRQ=y
> > CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> > # CONFIG_MAGIC_SYSRQ_SERIAL is not set
> > CONFIG_DEBUG_FS=y
> > CONFIG_HAVE_ARCH_KGDB=y
> > # CONFIG_KGDB is not set
> > CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> > CONFIG_UBSAN=y
> > # CONFIG_UBSAN_SANITIZE_ALL is not set
> > CONFIG_UBSAN_NO_ALIGNMENT=y
> > # CONFIG_TEST_UBSAN is not set
> > CONFIG_HAVE_ARCH_KCSAN=y
> > # end of Generic Kernel Debugging Instruments
> > 
> > CONFIG_DEBUG_KERNEL=y
> > CONFIG_DEBUG_MISC=y
> > 
> > #
> > # Memory Debugging
> > #
> > CONFIG_PAGE_EXTENSION=y
> > CONFIG_DEBUG_PAGEALLOC=y
> > # CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
> > # CONFIG_PAGE_OWNER is not set
> > # CONFIG_PAGE_POISONING is not set
> > CONFIG_DEBUG_PAGE_REF=y
> > CONFIG_DEBUG_RODATA_TEST=y
> > CONFIG_GENERIC_PTDUMP=y
> > # CONFIG_PTDUMP_DEBUGFS is not set
> > # CONFIG_DEBUG_OBJECTS is not set
> > # CONFIG_DEBUG_SLAB is not set
> > CONFIG_HAVE_DEBUG_KMEMLEAK=y
> > # CONFIG_DEBUG_KMEMLEAK is not set
> > CONFIG_DEBUG_STACK_USAGE=y
> > CONFIG_SCHED_STACK_END_CHECK=y
> > # CONFIG_DEBUG_VM is not set
> > CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> > CONFIG_DEBUG_VIRTUAL=y
> > CONFIG_DEBUG_MEMORY_INIT=y
> > CONFIG_HAVE_ARCH_KASAN=y
> > CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> > CONFIG_CC_HAS_KASAN_GENERIC=y
> > CONFIG_KASAN=y
> > CONFIG_KASAN_GENERIC=y
> > CONFIG_KASAN_OUTLINE=y
> > # CONFIG_KASAN_INLINE is not set
> > CONFIG_KASAN_STACK=1
> > # CONFIG_KASAN_VMALLOC is not set
> > # CONFIG_TEST_KASAN is not set
> > # end of Memory Debugging
> > 
> > CONFIG_DEBUG_SHIRQ=y
> > 
> > #
> > # Debug Oops, Lockups and Hangs
> > #
> > # CONFIG_PANIC_ON_OOPS is not set
> > CONFIG_PANIC_ON_OOPS_VALUE=0
> > CONFIG_PANIC_TIMEOUT=0
> > CONFIG_LOCKUP_DETECTOR=y
> > CONFIG_SOFTLOCKUP_DETECTOR=y
> > CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> > CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
> > CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> > CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> > CONFIG_HARDLOCKUP_DETECTOR=y
> > CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
> > CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
> > # CONFIG_DETECT_HUNG_TASK is not set
> > # CONFIG_WQ_WATCHDOG is not set
> > # end of Debug Oops, Lockups and Hangs
> > 
> > #
> > # Scheduler Debugging
> > #
> > CONFIG_SCHED_DEBUG=y
> > CONFIG_SCHED_INFO=y
> > CONFIG_SCHEDSTATS=y
> > # end of Scheduler Debugging
> > 
> > # CONFIG_DEBUG_TIMEKEEPING is not set
> > 
> > #
> > # Lock Debugging (spinlocks, mutexes, etc...)
> > #
> > CONFIG_LOCK_DEBUGGING_SUPPORT=y
> > CONFIG_PROVE_LOCKING=y
> > CONFIG_LOCK_STAT=y
> > CONFIG_DEBUG_RT_MUTEXES=y
> > CONFIG_DEBUG_SPINLOCK=y
> > CONFIG_DEBUG_MUTEXES=y
> > CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> > CONFIG_DEBUG_RWSEMS=y
> > CONFIG_DEBUG_LOCK_ALLOC=y
> > CONFIG_LOCKDEP=y
> > # CONFIG_DEBUG_LOCKDEP is not set
> > CONFIG_DEBUG_ATOMIC_SLEEP=y
> > # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> > CONFIG_LOCK_TORTURE_TEST=m
> > CONFIG_WW_MUTEX_SELFTEST=m
> > # end of Lock Debugging (spinlocks, mutexes, etc...)
> > 
> > CONFIG_TRACE_IRQFLAGS=y
> > CONFIG_STACKTRACE=y
> > CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
> > # CONFIG_DEBUG_KOBJECT is not set
> > 
> > #
> > # Debug kernel data structures
> > #
> > CONFIG_DEBUG_LIST=y
> > # CONFIG_DEBUG_PLIST is not set
> > # CONFIG_DEBUG_SG is not set
> > CONFIG_DEBUG_NOTIFIERS=y
> > CONFIG_BUG_ON_DATA_CORRUPTION=y
> > # end of Debug kernel data structures
> > 
> > CONFIG_DEBUG_CREDENTIALS=y
> > 
> > #
> > # RCU Debugging
> > #
> > CONFIG_PROVE_RCU=y
> > CONFIG_PROVE_RCU_LIST=y
> > CONFIG_TORTURE_TEST=m
> > # CONFIG_RCU_PERF_TEST is not set
> > CONFIG_RCU_TORTURE_TEST=m
> > # CONFIG_RCU_TRACE is not set
> > CONFIG_RCU_EQS_DEBUG=y
> > # end of RCU Debugging
> > 
> > # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> > # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> > CONFIG_LATENCYTOP=y
> > CONFIG_USER_STACKTRACE_SUPPORT=y
> > CONFIG_NOP_TRACER=y
> > CONFIG_HAVE_FUNCTION_TRACER=y
> > CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> > CONFIG_HAVE_DYNAMIC_FTRACE=y
> > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> > CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> > CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> > CONFIG_HAVE_FENTRY=y
> > CONFIG_HAVE_C_RECORDMCOUNT=y
> > CONFIG_TRACER_MAX_TRACE=y
> > CONFIG_TRACE_CLOCK=y
> > CONFIG_RING_BUFFER=y
> > CONFIG_EVENT_TRACING=y
> > CONFIG_CONTEXT_SWITCH_TRACER=y
> > CONFIG_RING_BUFFER_ALLOW_SWAP=y
> > CONFIG_PREEMPTIRQ_TRACEPOINTS=y
> > CONFIG_TRACING=y
> > CONFIG_GENERIC_TRACER=y
> > CONFIG_TRACING_SUPPORT=y
> > CONFIG_FTRACE=y
> > CONFIG_BOOTTIME_TRACING=y
> > CONFIG_FUNCTION_TRACER=y
> > # CONFIG_FUNCTION_GRAPH_TRACER is not set
> > # CONFIG_DYNAMIC_FTRACE is not set
> > CONFIG_FUNCTION_PROFILER=y
> > CONFIG_STACK_TRACER=y
> > # CONFIG_PREEMPTIRQ_EVENTS is not set
> > CONFIG_IRQSOFF_TRACER=y
> > # CONFIG_SCHED_TRACER is not set
> > # CONFIG_HWLAT_TRACER is not set
> > # CONFIG_MMIOTRACE is not set
> > CONFIG_FTRACE_SYSCALLS=y
> > CONFIG_TRACER_SNAPSHOT=y
> > CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> > CONFIG_TRACE_BRANCH_PROFILING=y
> > # CONFIG_BRANCH_PROFILE_NONE is not set
> > CONFIG_PROFILE_ANNOTATED_BRANCHES=y
> > # CONFIG_BRANCH_TRACER is not set
> > # CONFIG_BLK_DEV_IO_TRACE is not set
> > # CONFIG_KPROBE_EVENTS is not set
> > # CONFIG_UPROBE_EVENTS is not set
> > CONFIG_DYNAMIC_EVENTS=y
> > CONFIG_TRACING_MAP=y
> > CONFIG_HIST_TRIGGERS=y
> > # CONFIG_TRACE_EVENT_INJECT is not set
> > # CONFIG_TRACEPOINT_BENCHMARK is not set
> > CONFIG_RING_BUFFER_BENCHMARK=y
> > # CONFIG_TRACE_EVAL_MAP_FILE is not set
> > # CONFIG_FTRACE_STARTUP_TEST is not set
> > # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> > # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> > # CONFIG_SYNTH_EVENT_GEN_TEST is not set
> > # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> > # CONFIG_SAMPLES is not set
> > CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> > CONFIG_STRICT_DEVMEM=y
> > # CONFIG_IO_STRICT_DEVMEM is not set
> > 
> > #
> > # x86 Debugging
> > #
> > CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> > CONFIG_X86_VERBOSE_BOOTUP=y
> > CONFIG_EARLY_PRINTK=y
> > # CONFIG_EARLY_PRINTK_DBGP is not set
> > # CONFIG_EARLY_PRINTK_USB_XDBC is not set
> > # CONFIG_EFI_PGT_DUMP is not set
> > # CONFIG_DEBUG_WX is not set
> > CONFIG_DOUBLEFAULT=y
> > CONFIG_DEBUG_TLBFLUSH=y
> > CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> > # CONFIG_X86_DECODER_SELFTEST is not set
> > # CONFIG_IO_DELAY_0X80 is not set
> > CONFIG_IO_DELAY_0XED=y
> > # CONFIG_IO_DELAY_UDELAY is not set
> > # CONFIG_IO_DELAY_NONE is not set
> > CONFIG_DEBUG_BOOT_PARAMS=y
> > # CONFIG_CPA_DEBUG is not set
> > CONFIG_DEBUG_ENTRY=y
> > # CONFIG_DEBUG_NMI_SELFTEST is not set
> > CONFIG_X86_DEBUG_FPU=y
> > # CONFIG_PUNIT_ATOM_DEBUG is not set
> > CONFIG_UNWINDER_ORC=y
> > # CONFIG_UNWINDER_FRAME_POINTER is not set
> > # end of x86 Debugging
> > 
> > #
> > # Kernel Testing and Coverage
> > #
> > # CONFIG_KUNIT is not set
> > CONFIG_NOTIFIER_ERROR_INJECTION=m
> > CONFIG_PM_NOTIFIER_ERROR_INJECT=m
> > # CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
> > CONFIG_FUNCTION_ERROR_INJECTION=y
> > # CONFIG_FAULT_INJECTION is not set
> > CONFIG_ARCH_HAS_KCOV=y
> > CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> > CONFIG_KCOV=y
> > # CONFIG_KCOV_INSTRUMENT_ALL is not set
> > CONFIG_RUNTIME_TESTING_MENU=y
> > # CONFIG_LKDTM is not set
> > # CONFIG_TEST_LIST_SORT is not set
> > # CONFIG_TEST_SORT is not set
> > # CONFIG_KPROBES_SANITY_TEST is not set
> > # CONFIG_BACKTRACE_SELF_TEST is not set
> > # CONFIG_RBTREE_TEST is not set
> > # CONFIG_REED_SOLOMON_TEST is not set
> > # CONFIG_INTERVAL_TREE_TEST is not set
> > # CONFIG_PERCPU_TEST is not set
> > # CONFIG_ATOMIC64_SELFTEST is not set
> > # CONFIG_TEST_HEXDUMP is not set
> > # CONFIG_TEST_STRING_HELPERS is not set
> > CONFIG_TEST_STRSCPY=m
> > # CONFIG_TEST_KSTRTOX is not set
> > CONFIG_TEST_PRINTF=m
> > CONFIG_TEST_BITMAP=m
> > # CONFIG_TEST_BITFIELD is not set
> > # CONFIG_TEST_UUID is not set
> > # CONFIG_TEST_XARRAY is not set
> > # CONFIG_TEST_OVERFLOW is not set
> > # CONFIG_TEST_RHASHTABLE is not set
> > # CONFIG_TEST_HASH is not set
> > # CONFIG_TEST_IDA is not set
> > CONFIG_TEST_LKM=m
> > CONFIG_TEST_VMALLOC=m
> > CONFIG_TEST_USER_COPY=m
> > CONFIG_TEST_BPF=m
> > CONFIG_TEST_BLACKHOLE_DEV=m
> > # CONFIG_FIND_BIT_BENCHMARK is not set
> > CONFIG_TEST_FIRMWARE=y
> > CONFIG_TEST_SYSCTL=m
> > # CONFIG_TEST_UDELAY is not set
> > CONFIG_TEST_STATIC_KEYS=m
> > CONFIG_TEST_KMOD=m
> > # CONFIG_TEST_DEBUG_VIRTUAL is not set
> > # CONFIG_TEST_MEMCAT_P is not set
> > # CONFIG_TEST_STACKINIT is not set
> > # CONFIG_TEST_MEMINIT is not set
> > # CONFIG_MEMTEST is not set
> > # end of Kernel Testing and Coverage
> > # end of Kernel hacking
> 
