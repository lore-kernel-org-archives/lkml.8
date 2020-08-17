Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05941C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5624206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgHQJEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:04:05 -0400
Received: from foss.arm.com ([217.140.110.172]:51170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgHQJEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:04:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A72C631B;
        Mon, 17 Aug 2020 02:04:02 -0700 (PDT)
Received: from [10.37.12.68] (unknown [10.37.12.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 741203F6CF;
        Mon, 17 Aug 2020 02:04:01 -0700 (PDT)
Subject: Re: include/linux/sched/topology.h:237:9: error: implicit declaration
 of function 'cpu_logical_map'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <202008170623.tYjq1wEa%lkp@intel.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <1bc8f16a-004b-0352-6675-2c1edeeb9823@arm.com>
Date:   Mon, 17 Aug 2020 10:03:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <202008170623.tYjq1wEa%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/20 11:43 PM, kernel test robot wrote:
> Hi Lukasz,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
> commit: 1bc138c622959979eb547be2d3bbc6442a5c80b0 PM / EM: add support for other devices than CPUs in Energy Model
> date:   8 weeks ago
> config: mips-randconfig-r001-20200817 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project ab9fc8bae805c785066779e76e7846aabad5609e)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install mips cross compiling tool for clang build
>          # apt-get install binutils-mips-linux-gnu
>          git checkout 1bc138c622959979eb547be2d3bbc6442a5c80b0
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=mips
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     arch/mips/include/asm/sync.h:147:34: note: expanded from macro '__SYNC_loongson3_war'
>     # define __SYNC_loongson3_war   (1 << 31)
>                                        ^
>     In file included from arch/mips/kernel/asm-offsets.c:12:
>     In file included from include/linux/compat.h:10:
>     In file included from include/linux/time.h:74:
>     In file included from include/linux/time32.h:13:
>     In file included from include/linux/timex.h:65:
>     In file included from arch/mips/include/asm/timex.h:19:
>     In file included from arch/mips/include/asm/cpu-type.h:12:
>     In file included from include/linux/smp.h:15:
>     include/linux/llist.h:222:9: warning: converting the result of '<<' to a boolean always evaluates to true [-Wtautological-constant-compare]
>             return xchg(&head->first, NULL);
>                    ^
>     arch/mips/include/asm/cmpxchg.h:102:7: note: expanded from macro 'xchg'
>             if (!__SYNC_loongson3_war)                                      \
>                  ^
>     arch/mips/include/asm/sync.h:147:34: note: expanded from macro '__SYNC_loongson3_war'
>     # define __SYNC_loongson3_war   (1 << 31)
>                                        ^
>     In file included from arch/mips/kernel/asm-offsets.c:12:
>     In file included from include/linux/compat.h:15:
>     In file included from include/linux/socket.h:8:
>     In file included from include/linux/uio.h:10:
>     In file included from include/crypto/hash.h:11:
>     In file included from include/linux/crypto.h:19:
>     In file included from include/linux/slab.h:15:
>     In file included from include/linux/gfp.h:9:
>     include/linux/topology.h:119:9: error: implicit declaration of function 'cpu_logical_map' [-Werror,-Wimplicit-function-declaration]
>             return cpu_to_node(raw_smp_processor_id());
>                    ^
>     arch/mips/include/asm/mach-loongson64/topology.h:7:27: note: expanded from macro 'cpu_to_node'
>     #define cpu_to_node(cpu)        (cpu_logical_map(cpu) >> 2)


It looks like the energy_model.h causes this include on mips then some
header is missing (probably smp.h from mips/asm).
I will try to reproduce it and propose a fix.


>                                      ^
>     In file included from arch/mips/kernel/asm-offsets.c:12:
>     In file included from include/linux/compat.h:15:
>     In file included from include/linux/socket.h:8:
>     In file included from include/linux/uio.h:10:
>     In file included from include/crypto/hash.h:11:
>     In file included from include/linux/crypto.h:19:
>     In file included from include/linux/slab.h:15:
>     In file included from include/linux/gfp.h:9:
>     include/linux/topology.h:176:9: error: implicit declaration of function 'cpu_logical_map' [-Werror,-Wimplicit-function-declaration]
>             return cpu_to_node(cpu);
>                    ^
>     arch/mips/include/asm/mach-loongson64/topology.h:7:27: note: expanded from macro 'cpu_to_node'
>     #define cpu_to_node(cpu)        (cpu_logical_map(cpu) >> 2)
>                                      ^
>     In file included from arch/mips/kernel/asm-offsets.c:12:
>     In file included from include/linux/compat.h:15:
>     In file included from include/linux/socket.h:8:
>     In file included from include/linux/uio.h:10:
>     In file included from include/crypto/hash.h:11:
>     In file included from include/linux/crypto.h:19:
>     In file included from include/linux/slab.h:15:
>     In file included from include/linux/gfp.h:9:
>     include/linux/topology.h:210:25: error: implicit declaration of function 'cpu_logical_map' [-Werror,-Wimplicit-function-declaration]
>             return cpumask_of_node(cpu_to_node(cpu));
>                                    ^
>     arch/mips/include/asm/mach-loongson64/topology.h:7:27: note: expanded from macro 'cpu_to_node'
>     #define cpu_to_node(cpu)        (cpu_logical_map(cpu) >> 2)
>                                      ^
>     In file included from arch/mips/kernel/asm-offsets.c:15:
>     In file included from include/linux/mm.h:32:
>     In file included from include/linux/pgtable.h:6:
>     arch/mips/include/asm/pgtable.h:210:3: warning: converting the result of '<<' to a boolean always evaluates to true [-Wtautological-constant-compare]
>                     cmpxchg64(&buddy->pte, 0, _PAGE_GLOBAL);
>                     ^
>     arch/mips/include/asm/cmpxchg.h:220:2: note: expanded from macro 'cmpxchg64'
>             cmpxchg((ptr), (o), (n));                                       \
>             ^
>     arch/mips/include/asm/cmpxchg.h:194:7: note: expanded from macro 'cmpxchg'
>             if (!__SYNC_loongson3_war)                                      \
>                  ^
>     arch/mips/include/asm/sync.h:147:34: note: expanded from macro '__SYNC_loongson3_war'
>     # define __SYNC_loongson3_war   (1 << 31)
>                                        ^
>     In file included from arch/mips/kernel/asm-offsets.c:15:
>     In file included from include/linux/mm.h:32:
>     In file included from include/linux/pgtable.h:6:
>     arch/mips/include/asm/pgtable.h:210:3: warning: converting the result of '<<' to a boolean always evaluates to true [-Wtautological-constant-compare]
>     arch/mips/include/asm/cmpxchg.h:220:2: note: expanded from macro 'cmpxchg64'
>             cmpxchg((ptr), (o), (n));                                       \
>             ^
>     arch/mips/include/asm/cmpxchg.h:204:7: note: expanded from macro 'cmpxchg'
>             if (!__SYNC_loongson3_war)                                      \
>                  ^
>     arch/mips/include/asm/sync.h:147:34: note: expanded from macro '__SYNC_loongson3_war'
>     # define __SYNC_loongson3_war   (1 << 31)
>                                        ^
>     In file included from arch/mips/kernel/asm-offsets.c:17:
>     In file included from include/linux/suspend.h:5:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:22:
>     In file included from include/linux/writeback.h:14:
>     In file included from include/linux/blk-cgroup.h:23:
>     In file included from include/linux/blkdev.h:11:
>     In file included from include/linux/genhd.h:36:
>     In file included from include/linux/device.h:16:
>     In file included from include/linux/energy_model.h:10:
>>> include/linux/sched/topology.h:237:9: error: implicit declaration of function 'cpu_logical_map' [-Werror,-Wimplicit-function-declaration]
>             return cpu_to_node(task_cpu(p));
>                    ^
>     arch/mips/include/asm/mach-loongson64/topology.h:7:27: note: expanded from macro 'cpu_to_node'
>     #define cpu_to_node(cpu)        (cpu_logical_map(cpu) >> 2)
>                                      ^
>     In file included from arch/mips/kernel/asm-offsets.c:24:
>     include/linux/kvm_host.h:332:9: warning: converting the result of '<<' to a boolean always evaluates to true [-Wtautological-constant-compare]
>             return cmpxchg(&vcpu->mode, IN_GUEST_MODE, EXITING_GUEST_MODE);
>                    ^
>     arch/mips/include/asm/cmpxchg.h:194:7: note: expanded from macro 'cmpxchg'
>             if (!__SYNC_loongson3_war)                                      \
>                  ^
>     arch/mips/include/asm/sync.h:147:34: note: expanded from macro '__SYNC_loongson3_war'
>     # define __SYNC_loongson3_war   (1 << 31)
>                                        ^
>     In file included from arch/mips/kernel/asm-offsets.c:24:
>     include/linux/kvm_host.h:332:9: warning: converting the result of '<<' to a boolean always evaluates to true [-Wtautological-constant-compare]
>     arch/mips/include/asm/cmpxchg.h:204:7: note: expanded from macro 'cmpxchg'
>             if (!__SYNC_loongson3_war)                                      \
>                  ^
>     arch/mips/include/asm/sync.h:147:34: note: expanded from macro '__SYNC_loongson3_war'
>     # define __SYNC_loongson3_war   (1 << 31)
>                                        ^
>     arch/mips/kernel/asm-offsets.c:26:6: warning: no previous prototype for function 'output_ptreg_defines' [-Wmissing-prototypes]
>     void output_ptreg_defines(void)
>          ^
>     arch/mips/kernel/asm-offsets.c:26:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     void output_ptreg_defines(void)
>     ^
>     static
>     arch/mips/kernel/asm-offsets.c:78:6: warning: no previous prototype for function 'output_task_defines' [-Wmissing-prototypes]
>     void output_task_defines(void)
>          ^
>     arch/mips/kernel/asm-offsets.c:78:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     void output_task_defines(void)
>     ^
>     static
>     arch/mips/kernel/asm-offsets.c:93:6: warning: no previous prototype for function 'output_thread_info_defines' [-Wmissing-prototypes]
>     void output_thread_info_defines(void)
>          ^
>     arch/mips/kernel/asm-offsets.c:93:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     void output_thread_info_defines(void)
>     ^
>     static
>     arch/mips/kernel/asm-offsets.c:110:6: warning: no previous prototype for function 'output_thread_defines' [-Wmissing-prototypes]
>     void output_thread_defines(void)
>          ^
>     arch/mips/kernel/asm-offsets.c:110:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     void output_thread_defines(void)
>     ^
>     static
>     arch/mips/kernel/asm-offsets.c:181:6: warning: no previous prototype for function 'output_mm_defines' [-Wmissing-prototypes]
>     void output_mm_defines(void)
>          ^
>     arch/mips/kernel/asm-offsets.c:181:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     void output_mm_defines(void)
>     ^
>     static
>     arch/mips/kernel/asm-offsets.c:242:6: warning: no previous prototype for function 'output_sc_defines' [-Wmissing-prototypes]
>     void output_sc_defines(void)
>          ^
>     arch/mips/kernel/asm-offsets.c:242:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     void output_sc_defines(void)
>     ^
>     static
>     arch/mips/kernel/asm-offsets.c:255:6: warning: no previous prototype for function 'output_signal_defined' [-Wmissing-prototypes]
>     void output_signal_defined(void)
>          ^
>     arch/mips/kernel/asm-offsets.c:255:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     void output_signal_defined(void)
>     ^
>     static
>     arch/mips/kernel/asm-offsets.c:322:6: warning: no previous prototype for function 'output_pbe_defines' [-Wmissing-prototypes]
>     void output_pbe_defines(void)
>          ^
>     arch/mips/kernel/asm-offsets.c:322:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     void output_pbe_defines(void)
>     ^
>     static
>     22 warnings and 4 errors generated.
>     make[2]: *** [scripts/Makefile.build:114: arch/mips/kernel/asm-offsets.s] Error 1
>     make[2]: Target 'missing-syscalls' not remade because of errors.
>     make[1]: *** [arch/mips/Makefile:397: archprepare] Error 2
>     make[1]: Target 'prepare' not remade because of errors.
>     make: *** [Makefile:185: __sub-make] Error 2
>     make: Target 'prepare' not remade because of errors.
> 
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1bc138c622959979eb547be2d3bbc6442a5c80b0
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git fetch --no-tags linus master
> git checkout 1bc138c622959979eb547be2d3bbc6442a5c80b0
> vim +/cpu_logical_map +237 include/linux/sched/topology.h
> 
> 36a0df85d2e85e1 Thara Gopinath 2020-02-21  234
> ee6a3d19f15b9b1 Ingo Molnar    2017-02-06  235  static inline int task_node(const struct task_struct *p)
> ee6a3d19f15b9b1 Ingo Molnar    2017-02-06  236  {
> ee6a3d19f15b9b1 Ingo Molnar    2017-02-06 @237  	return cpu_to_node(task_cpu(p));
> ee6a3d19f15b9b1 Ingo Molnar    2017-02-06  238  }
> ee6a3d19f15b9b1 Ingo Molnar    2017-02-06  239
> 
> :::::: The code at line 237 was first introduced by commit
> :::::: ee6a3d19f15b9b10075481088b8d4537f286d7b4 sched/headers: Remove the <linux/topology.h> include from <linux/sched.h>
> 
> :::::: TO: Ingo Molnar <mingo@kernel.org>
> :::::: CC: Ingo Molnar <mingo@kernel.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
