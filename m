Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666F4C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 157C22070A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGQFd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 01:33:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:27085 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgGQFd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 01:33:59 -0400
IronPort-SDR: NUdn6WPGYZ+6ExfrZtmkgm8fOJzLNGPAwA8YeuSCcW8oNEMLm8h9HANLtZcUk0O6Lp1s5VEBm0
 cQvSQZLTB82Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="137657723"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="gz'50?scan'50,208,50";a="137657723"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 22:33:37 -0700
IronPort-SDR: T33nUsfEBNU3s2YemQ5NDDBGhEuo9qwvJgZcWfZMyLj939lfJNuTauab4WE4qjS7t/i6ysebuo
 BJ7q2kSba9lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="gz'50?scan'50,208,50";a="286714062"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2020 22:33:33 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwJ00-00006k-VN; Fri, 17 Jul 2020 05:33:32 +0000
Date:   Fri, 17 Jul 2020 13:33:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v4 3/7] vmalloc: Add text_alloc() and text_free()
Message-ID: <202007171307.FxBl7xyN%lkp@intel.com>
References: <20200717030422.679972-4-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20200717030422.679972-4-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jarkko,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on jeyu/modules-next v5.8-rc5 next-20200716]
[cannot apply to tip/x86/core tip/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jarkko-Sakkinen/arch-x86-kprobes-Remove-MODULES-dependency/20200717-110947
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 07a56bb875afbe39dabbf6ba7b83783d166863db
config: sparc-randconfig-s031-20200717 (attached as .config)
compiler: sparc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-49-g707c5017-dirty
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sparc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/sparc/include/asm/page.h:10,
                    from arch/sparc/include/asm/string_32.h:13,
                    from arch/sparc/include/asm/string.h:7,
                    from include/linux/string.h:20,
                    from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from arch/sparc/include/asm/smp_32.h:15,
                    from arch/sparc/include/asm/smp.h:7,
                    from arch/sparc/include/asm/switch_to_32.h:5,
                    from arch/sparc/include/asm/switch_to.h:7,
                    from arch/sparc/include/asm/ptrace.h:120,
                    from arch/sparc/include/asm/thread_info_32.h:19,
                    from arch/sparc/include/asm/thread_info.h:7,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:16,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
>> include/linux/mmzone.h:1317:29: error: expected identifier or '(' before 'unsigned'
    1317 | static inline int pfn_valid(unsigned long pfn)
         |                             ^~~~~~~~
   arch/sparc/include/asm/page_32.h:133:28: note: in definition of macro 'pfn_valid'
     133 | #define pfn_valid(pfn)  (((pfn) >= (pfn_base)) && (((pfn)-(pfn_base)) < max_mapnr))
         |                            ^~~
>> arch/sparc/include/asm/page_32.h:133:33: error: expected ')' before '>=' token
     133 | #define pfn_valid(pfn)  (((pfn) >= (pfn_base)) && (((pfn)-(pfn_base)) < max_mapnr))
         |                                 ^~
   include/linux/mmzone.h:1317:19: note: in expansion of macro 'pfn_valid'
    1317 | static inline int pfn_valid(unsigned long pfn)
         |                   ^~~~~~~~~
   arch/sparc/include/asm/page_32.h:133:48: error: expected ')' before '&&' token
     133 | #define pfn_valid(pfn)  (((pfn) >= (pfn_base)) && (((pfn)-(pfn_base)) < max_mapnr))
         |                                                ^~
   include/linux/mmzone.h:1317:19: note: in expansion of macro 'pfn_valid'
    1317 | static inline int pfn_valid(unsigned long pfn)
         |                   ^~~~~~~~~
   In file included from include/linux/page-flags-layout.h:28,
                    from include/linux/mmzone.h:19,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:16,
                    from include/linux/moduleloader.h:6,
                    from include/linux/vmalloc.h:12,
                    from include/asm-generic/io.h:911,
                    from arch/sparc/include/asm/io_32.h:14,
                    from arch/sparc/include/asm/io.h:7,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:18,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   include/linux/mmzone.h: In function 'pfn_in_present_section':
>> arch/sparc/include/asm/sparsemem.h:11:33: error: 'MAX_PHYS_ADDRESS_BITS' undeclared (first use in this function); did you mean 'MAX_PHYSADDR_BITS'?
      11 | #define MAX_PHYSMEM_BITS        MAX_PHYS_ADDRESS_BITS
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/page-flags-layout.h:31:25: note: in expansion of macro 'MAX_PHYSMEM_BITS'
      31 | #define SECTIONS_SHIFT (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
         |                         ^~~~~~~~~~~~~~~~
   include/linux/mmzone.h:1104:34: note: in expansion of macro 'SECTIONS_SHIFT'
    1104 | #define NR_MEM_SECTIONS  (1UL << SECTIONS_SHIFT)
         |                                  ^~~~~~~~~~~~~~
   include/linux/mmzone.h:1336:32: note: in expansion of macro 'NR_MEM_SECTIONS'
    1336 |  if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
         |                                ^~~~~~~~~~~~~~~
   arch/sparc/include/asm/sparsemem.h:11:33: note: each undeclared identifier is reported only once for each function it appears in
      11 | #define MAX_PHYSMEM_BITS        MAX_PHYS_ADDRESS_BITS
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/page-flags-layout.h:31:25: note: in expansion of macro 'MAX_PHYSMEM_BITS'
      31 | #define SECTIONS_SHIFT (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
         |                         ^~~~~~~~~~~~~~~~
   include/linux/mmzone.h:1104:34: note: in expansion of macro 'SECTIONS_SHIFT'
    1104 | #define NR_MEM_SECTIONS  (1UL << SECTIONS_SHIFT)
         |                                  ^~~~~~~~~~~~~~
   include/linux/mmzone.h:1336:32: note: in expansion of macro 'NR_MEM_SECTIONS'
    1336 |  if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
         |                                ^~~~~~~~~~~~~~~
   In file included from include/linux/local_lock.h:5,
                    from include/linux/radix-tree.h:19,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from arch/sparc/include/asm/openprom.h:15,
                    from arch/sparc/include/asm/oplib_32.h:12,
                    from arch/sparc/include/asm/oplib.h:7,
                    from arch/sparc/include/asm/pgtable_32.h:32,
                    from arch/sparc/include/asm/pgtable.h:7,
                    from arch/sparc/include/asm/viking.h:13,
                    from arch/sparc/include/asm/mbus.h:12,
                    from arch/sparc/include/asm/elf_32.h:94,
                    from arch/sparc/include/asm/elf.h:7,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:18,
                    from include/linux/moduleloader.h:6,
                    from include/linux/vmalloc.h:12,
                    from include/asm-generic/io.h:911,
                    from arch/sparc/include/asm/io_32.h:14,
                    from arch/sparc/include/asm/io.h:7,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:18,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   include/linux/local_lock_internal.h: In function 'local_lock_acquire':
>> include/linux/local_lock_internal.h:41:13: error: 'current' undeclared (first use in this function)
      41 |  l->owner = current;
         |             ^~~~~~~
   In file included from include/linux/kernel.h:11,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:15,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   include/linux/local_lock_internal.h: In function 'local_lock_release':
   include/linux/local_lock_internal.h:46:34: error: 'current' undeclared (first use in this function)
      46 |  DEBUG_LOCKS_WARN_ON(l->owner != current);
         |                                  ^~~~~~~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/local_lock_internal.h:46:2: note: in expansion of macro 'DEBUG_LOCKS_WARN_ON'
      46 |  DEBUG_LOCKS_WARN_ON(l->owner != current);
         |  ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/sched/signal.h:7,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/proc_fs.h:10,
                    from arch/sparc/include/asm/prom.h:18,
                    from include/linux/of.h:250,
                    from arch/sparc/include/asm/openprom.h:15,
                    from arch/sparc/include/asm/oplib_32.h:12,
                    from arch/sparc/include/asm/oplib.h:7,
                    from arch/sparc/include/asm/pgtable_32.h:32,
                    from arch/sparc/include/asm/pgtable.h:7,
                    from arch/sparc/include/asm/viking.h:13,
                    from arch/sparc/include/asm/mbus.h:12,
                    from arch/sparc/include/asm/elf_32.h:94,
                    from arch/sparc/include/asm/elf.h:7,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:18,
                    from include/linux/moduleloader.h:6,
                    from include/linux/vmalloc.h:12,
                    from include/asm-generic/io.h:911,
                    from arch/sparc/include/asm/io_32.h:14,
                    from arch/sparc/include/asm/io.h:7,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:18,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   include/linux/sched.h: In function 'is_percpu_thread':
>> include/linux/sched.h:1552:10: error: 'current' undeclared (first use in this function)
    1552 |  return (current->flags & PF_NO_SETAFFINITY) &&
         |          ^~~~~~~
   include/linux/sched.h: In function 'current_restore_flags':
   include/linux/sched.h:1613:2: error: 'current' undeclared (first use in this function)
    1613 |  current->flags &= ~flags;
         |  ^~~~~~~
   In file included from arch/sparc/include/asm/uaccess.h:7,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/proc_fs.h:10,
                    from arch/sparc/include/asm/prom.h:18,
                    from include/linux/of.h:250,
                    from arch/sparc/include/asm/openprom.h:15,
                    from arch/sparc/include/asm/oplib_32.h:12,
                    from arch/sparc/include/asm/oplib.h:7,
                    from arch/sparc/include/asm/pgtable_32.h:32,
                    from arch/sparc/include/asm/pgtable.h:7,
                    from arch/sparc/include/asm/viking.h:13,
                    from arch/sparc/include/asm/mbus.h:12,
                    from arch/sparc/include/asm/elf_32.h:94,
                    from arch/sparc/include/asm/elf.h:7,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:18,
                    from include/linux/moduleloader.h:6,
                    from include/linux/vmalloc.h:12,
                    from include/asm-generic/io.h:911,
                    from arch/sparc/include/asm/io_32.h:14,
                    from arch/sparc/include/asm/io.h:7,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:18,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   arch/sparc/include/asm/uaccess_32.h: In function 'clear_user':
>> arch/sparc/include/asm/uaccess_32.h:28:19: error: 'current' undeclared (first use in this function)
      28 | #define get_fs() (current->thread.current_ds)
         |                   ^~~~~~~
   arch/sparc/include/asm/uaccess_32.h:38:49: note: in definition of macro '__user_ok'
      38 | #define __user_ok(addr, size) ({ (void)(size); (addr) < STACK_TOP; })
         |                                                 ^~~~
   arch/sparc/include/asm/uaccess_32.h:40:53: note: in expansion of macro 'get_fs'
      40 | #define __access_ok(addr, size) (__user_ok((addr) & get_fs().seg, (size)))
         |                                                     ^~~~~~
   arch/sparc/include/asm/uaccess_32.h:273:11: note: in expansion of macro '__access_ok'
     273 |  if (n && __access_ok((unsigned long) addr, n))
         |           ^~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:15,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   include/linux/uaccess.h: In function '_copy_from_user':
>> arch/sparc/include/asm/uaccess_32.h:28:19: error: 'current' undeclared (first use in this function)
      28 | #define get_fs() (current->thread.current_ds)
         |                   ^~~~~~~
   include/linux/compiler.h:77:40: note: in definition of macro 'likely'
      77 | # define likely(x) __builtin_expect(!!(x), 1)
         |                                        ^
   arch/sparc/include/asm/uaccess_32.h:40:34: note: in expansion of macro '__user_ok'
      40 | #define __access_ok(addr, size) (__user_ok((addr) & get_fs().seg, (size)))
         |                                  ^~~~~~~~~
   arch/sparc/include/asm/uaccess_32.h:40:53: note: in expansion of macro 'get_fs'
      40 | #define __access_ok(addr, size) (__user_ok((addr) & get_fs().seg, (size)))
         |                                                     ^~~~~~
   arch/sparc/include/asm/uaccess_32.h:41:31: note: in expansion of macro '__access_ok'
      41 | #define access_ok(addr, size) __access_ok((unsigned long)(addr), size)
         |                               ^~~~~~~~~~~
   include/linux/uaccess.h:111:13: note: in expansion of macro 'access_ok'
     111 |  if (likely(access_ok(from, n))) {
         |             ^~~~~~~~~
   In file included from arch/sparc/include/asm/uaccess.h:7,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/proc_fs.h:10,
                    from arch/sparc/include/asm/prom.h:18,
                    from include/linux/of.h:250,
                    from arch/sparc/include/asm/openprom.h:15,
                    from arch/sparc/include/asm/oplib_32.h:12,
                    from arch/sparc/include/asm/oplib.h:7,
                    from arch/sparc/include/asm/pgtable_32.h:32,
                    from arch/sparc/include/asm/pgtable.h:7,
                    from arch/sparc/include/asm/viking.h:13,
                    from arch/sparc/include/asm/mbus.h:12,
                    from arch/sparc/include/asm/elf_32.h:94,
                    from arch/sparc/include/asm/elf.h:7,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:18,
                    from include/linux/moduleloader.h:6,
                    from include/linux/vmalloc.h:12,
                    from include/asm-generic/io.h:911,
                    from arch/sparc/include/asm/io_32.h:14,
                    from arch/sparc/include/asm/io.h:7,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:18,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   include/linux/uaccess.h: In function '_copy_to_user':
>> arch/sparc/include/asm/uaccess_32.h:28:19: error: 'current' undeclared (first use in this function)
      28 | #define get_fs() (current->thread.current_ds)
         |                   ^~~~~~~
   arch/sparc/include/asm/uaccess_32.h:38:49: note: in definition of macro '__user_ok'
      38 | #define __user_ok(addr, size) ({ (void)(size); (addr) < STACK_TOP; })
         |                                                 ^~~~
   arch/sparc/include/asm/uaccess_32.h:40:53: note: in expansion of macro 'get_fs'
      40 | #define __access_ok(addr, size) (__user_ok((addr) & get_fs().seg, (size)))
         |                                                     ^~~~~~
   arch/sparc/include/asm/uaccess_32.h:41:31: note: in expansion of macro '__access_ok'
      41 | #define access_ok(addr, size) __access_ok((unsigned long)(addr), size)
         |                               ^~~~~~~~~~~
   include/linux/uaccess.h:129:6: note: in expansion of macro 'access_ok'
     129 |  if (access_ok(to, n)) {
         |      ^~~~~~~~~
   include/linux/uaccess.h: In function 'copy_in_user':
>> arch/sparc/include/asm/uaccess_32.h:28:19: error: 'current' undeclared (first use in this function)
      28 | #define get_fs() (current->thread.current_ds)
         |                   ^~~~~~~
   arch/sparc/include/asm/uaccess_32.h:38:49: note: in definition of macro '__user_ok'
      38 | #define __user_ok(addr, size) ({ (void)(size); (addr) < STACK_TOP; })
         |                                                 ^~~~
   arch/sparc/include/asm/uaccess_32.h:40:53: note: in expansion of macro 'get_fs'
      40 | #define __access_ok(addr, size) (__user_ok((addr) & get_fs().seg, (size)))
         |                                                     ^~~~~~
   arch/sparc/include/asm/uaccess_32.h:41:31: note: in expansion of macro '__access_ok'
      41 | #define access_ok(addr, size) __access_ok((unsigned long)(addr), size)
         |                               ^~~~~~~~~~~
   include/linux/uaccess.h:160:6: note: in expansion of macro 'access_ok'
     160 |  if (access_ok(to, n) && access_ok(from, n))
         |      ^~~~~~~~~
   In file included from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/proc_fs.h:10,
                    from arch/sparc/include/asm/prom.h:18,
                    from include/linux/of.h:250,
                    from arch/sparc/include/asm/openprom.h:15,
                    from arch/sparc/include/asm/oplib_32.h:12,
                    from arch/sparc/include/asm/oplib.h:7,
                    from arch/sparc/include/asm/pgtable_32.h:32,
                    from arch/sparc/include/asm/pgtable.h:7,
                    from arch/sparc/include/asm/viking.h:13,
                    from arch/sparc/include/asm/mbus.h:12,
                    from arch/sparc/include/asm/elf_32.h:94,
                    from arch/sparc/include/asm/elf.h:7,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:18,
                    from include/linux/moduleloader.h:6,
                    from include/linux/vmalloc.h:12,
                    from include/asm-generic/io.h:911,
                    from arch/sparc/include/asm/io_32.h:14,
                    from arch/sparc/include/asm/io.h:7,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:18,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
>> include/linux/uaccess.h:161:7: error: implicit declaration of function 'raw_copy_in_user'; did you mean 'raw_copy_to_user'? [-Werror=implicit-function-declaration]
     161 |   n = raw_copy_in_user(to, from, n);
         |       ^~~~~~~~~~~~~~~~
         |       raw_copy_to_user
   include/linux/uaccess.h: In function 'pagefault_disabled_inc':
>> include/linux/uaccess.h:168:2: error: 'current' undeclared (first use in this function)
     168 |  current->pagefault_disabled++;
         |  ^~~~~~~
   include/linux/uaccess.h: In function 'pagefault_disabled_dec':
   include/linux/uaccess.h:173:2: error: 'current' undeclared (first use in this function)
     173 |  current->pagefault_disabled--;
         |  ^~~~~~~
   include/linux/uaccess.h: In function 'pagefault_disabled':
   include/linux/uaccess.h:208:9: error: 'current' undeclared (first use in this function)
     208 |  return current->pagefault_disabled != 0;
         |         ^~~~~~~
   In file included from include/linux/kernel.h:15,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:15,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   include/linux/ratelimit.h: In function 'ratelimit_state_exit':
>> include/linux/ratelimit.h:63:4: error: 'current' undeclared (first use in this function)
      63 |    current->comm, rs->missed);
         |    ^~~~~~~
   include/linux/printk.h:348:37: note: in definition of macro 'pr_warn'
     348 |  printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                                     ^~~~~~~~~~~
   In file included from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/proc_fs.h:10,
                    from arch/sparc/include/asm/prom.h:18,
                    from include/linux/of.h:250,
                    from arch/sparc/include/asm/openprom.h:15,
                    from arch/sparc/include/asm/oplib_32.h:12,
                    from arch/sparc/include/asm/oplib.h:7,
                    from arch/sparc/include/asm/pgtable_32.h:32,
                    from arch/sparc/include/asm/pgtable.h:7,
                    from arch/sparc/include/asm/viking.h:13,
                    from arch/sparc/include/asm/mbus.h:12,
                    from arch/sparc/include/asm/elf_32.h:94,
                    from arch/sparc/include/asm/elf.h:7,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:18,
                    from include/linux/moduleloader.h:6,
                    from include/linux/vmalloc.h:12,
                    from include/asm-generic/io.h:911,
                    from arch/sparc/include/asm/io_32.h:14,
                    from arch/sparc/include/asm/io.h:7,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:18,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   include/linux/sched/signal.h: In function 'kernel_dequeue_signal':
>> include/linux/sched/signal.h:280:29: error: 'current' undeclared (first use in this function)
     280 |  struct task_struct *task = current;
         |                             ^~~~~~~
   include/linux/sched/signal.h: In function 'kernel_signal_stop':
   include/linux/sched/signal.h:293:17: error: 'current' undeclared (first use in this function)
     293 |  spin_lock_irq(&current->sighand->siglock);
         |                 ^~~~~~~
   include/linux/sched/signal.h: In function 'restart_syscall':
   include/linux/sched/signal.h:352:22: error: 'current' undeclared (first use in this function)
     352 |  set_tsk_thread_flag(current, TIF_SIGPENDING);
         |                      ^~~~~~~
   In file included from include/linux/kernel.h:11,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:15,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   include/linux/sched/signal.h: In function 'fault_signal_pending':
   include/linux/sched/signal.h:391:26: error: 'current' undeclared (first use in this function)
     391 |    (fatal_signal_pending(current) ||
         |                          ^~~~~~~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   In file included from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/proc_fs.h:10,
                    from arch/sparc/include/asm/prom.h:18,
                    from include/linux/of.h:250,
                    from arch/sparc/include/asm/openprom.h:15,
                    from arch/sparc/include/asm/oplib_32.h:12,
                    from arch/sparc/include/asm/oplib.h:7,
                    from arch/sparc/include/asm/pgtable_32.h:32,
                    from arch/sparc/include/asm/pgtable.h:7,
                    from arch/sparc/include/asm/viking.h:13,
                    from arch/sparc/include/asm/mbus.h:12,
                    from arch/sparc/include/asm/elf_32.h:94,
                    from arch/sparc/include/asm/elf.h:7,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:18,
                    from include/linux/moduleloader.h:6,
                    from include/linux/vmalloc.h:12,
                    from include/asm-generic/io.h:911,
                    from arch/sparc/include/asm/io_32.h:14,
                    from arch/sparc/include/asm/io.h:7,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:18,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   include/linux/sched/signal.h: In function 'restore_saved_sigmask':
   include/linux/sched/signal.h:497:26: error: 'current' undeclared (first use in this function)
     497 |   __set_current_blocked(&current->saved_sigmask);
         |                          ^~~~~~~
   include/linux/sched/signal.h: In function 'sigmask_to_save':
   include/linux/sched/signal.h:512:19: error: 'current' undeclared (first use in this function)
     512 |  sigset_t *res = &current->blocked;
         |                   ^~~~~~~
   include/linux/sched/signal.h: In function 'on_sig_stack':
   include/linux/sched/signal.h:541:6: error: 'current' undeclared (first use in this function)
     541 |  if (current->sas_ss_flags & SS_AUTODISARM)
         |      ^~~~~~~
   include/linux/sched/signal.h: In function 'sas_ss_flags':
   include/linux/sched/signal.h:555:7: error: 'current' undeclared (first use in this function)
     555 |  if (!current->sas_ss_size)
         |       ^~~~~~~
   include/linux/sched/signal.h: In function 'sigsp':
   include/linux/sched/signal.h:574:10: error: 'current' undeclared (first use in this function)
     574 |   return current->sas_ss_sp + current->sas_ss_size;
         |          ^~~~~~~
   include/linux/sched/signal.h: In function 'rlimit':
   include/linux/sched/signal.h:710:21: error: 'current' undeclared (first use in this function)
     710 |  return task_rlimit(current, limit);
         |                     ^~~~~~~
   include/linux/sched/signal.h: In function 'rlimit_max':
   include/linux/sched/signal.h:715:25: error: 'current' undeclared (first use in this function)
     715 |  return task_rlimit_max(current, limit);
         |                         ^~~~~~~
   In file included from include/linux/rbtree.h:22,
                    from include/linux/vmalloc.h:10,
                    from include/asm-generic/io.h:911,
                    from arch/sparc/include/asm/io_32.h:14,
                    from arch/sparc/include/asm/io.h:7,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:18,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   include/linux/rcuwait.h: In function 'prepare_to_rcuwait':
>> include/linux/rcuwait.h:47:30: error: 'current' undeclared (first use in this function)
      47 |  rcu_assign_pointer(w->task, current);
         |                              ^~~~~~~
   include/linux/rcupdate.h:409:36: note: in definition of macro 'rcu_assign_pointer'
     409 |  uintptr_t _r_a_p__v = (uintptr_t)(v);          \
         |                                    ^
   In file included from include/linux/sched/signal.h:7,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/proc_fs.h:10,
                    from arch/sparc/include/asm/prom.h:18,
                    from include/linux/of.h:250,
                    from arch/sparc/include/asm/openprom.h:15,
                    from arch/sparc/include/asm/oplib_32.h:12,
                    from arch/sparc/include/asm/oplib.h:7,
                    from arch/sparc/include/asm/pgtable_32.h:32,
                    from arch/sparc/include/asm/pgtable.h:7,
                    from arch/sparc/include/asm/viking.h:13,
                    from arch/sparc/include/asm/mbus.h:12,
                    from arch/sparc/include/asm/elf_32.h:94,
                    from arch/sparc/include/asm/elf.h:7,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:18,
                    from include/linux/moduleloader.h:6,
                    from include/linux/vmalloc.h:12,
                    from include/asm-generic/io.h:911,
                    from arch/sparc/include/asm/io_32.h:14,
                    from arch/sparc/include/asm/io.h:7,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:18,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   include/linux/rcuwait.h: In function 'finish_rcuwait':
   include/linux/sched.h:133:3: error: 'current' undeclared (first use in this function)
     133 |   current->task_state_change = _THIS_IP_;  \
         |   ^~~~~~~
   include/linux/rcuwait.h:53:2: note: in expansion of macro '__set_current_state'
      53 |  __set_current_state(TASK_RUNNING);
         |  ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/fs.h:38,
                    from include/linux/proc_fs.h:10,
                    from arch/sparc/include/asm/prom.h:18,
                    from include/linux/of.h:250,
                    from arch/sparc/include/asm/openprom.h:15,
                    from arch/sparc/include/asm/oplib_32.h:12,
                    from arch/sparc/include/asm/oplib.h:7,
                    from arch/sparc/include/asm/pgtable_32.h:32,
                    from arch/sparc/include/asm/pgtable.h:7,
                    from arch/sparc/include/asm/viking.h:13,
                    from arch/sparc/include/asm/mbus.h:12,
                    from arch/sparc/include/asm/elf_32.h:94,
                    from arch/sparc/include/asm/elf.h:7,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:18,
                    from include/linux/moduleloader.h:6,
                    from include/linux/vmalloc.h:12,
                    from include/asm-generic/io.h:911,
                    from arch/sparc/include/asm/io_32.h:14,
                    from arch/sparc/include/asm/io.h:7,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:18,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   include/linux/ioprio.h: In function 'get_current_ioprio':
>> include/linux/ioprio.h:79:27: error: 'current' undeclared (first use in this function)
      79 |  struct io_context *ioc = current->io_context;
         |                           ^~~~~~~
   In file included from arch/sparc/include/asm/page_32.h:136,
                    from arch/sparc/include/asm/page.h:10,
                    from arch/sparc/include/asm/string_32.h:13,
                    from arch/sparc/include/asm/string.h:7,
                    from include/linux/string.h:20,
                    from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from arch/sparc/include/asm/smp_32.h:15,
                    from arch/sparc/include/asm/smp.h:7,
                    from arch/sparc/include/asm/switch_to_32.h:5,
                    from arch/sparc/include/asm/switch_to.h:7,
                    from arch/sparc/include/asm/ptrace.h:120,
                    from arch/sparc/include/asm/thread_info_32.h:19,
                    from arch/sparc/include/asm/thread_info.h:7,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:16,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   arch/sparc/include/asm/pgtable_32.h: In function 'pmd_page':
   include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'mem_map'?
      54 | #define __pfn_to_page(pfn) (vmemmap + (pfn))
         |                             ^~~~~~~
   include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
      82 | #define pfn_to_page __pfn_to_page
         |                     ^~~~~~~~~~~~~
   arch/sparc/include/asm/pgtable_32.h:135:9: note: in expansion of macro 'pfn_to_page'
     135 |  return pfn_to_page((pmd_val(pmd) & SRMMU_PTD_PMASK) >> (PAGE_SHIFT-4));
         |         ^~~~~~~~~~~
   In file included from arch/sparc/include/asm/page.h:10,
                    from arch/sparc/include/asm/string_32.h:13,
                    from arch/sparc/include/asm/string.h:7,
                    from include/linux/string.h:20,
                    from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from arch/sparc/include/asm/smp_32.h:15,
                    from arch/sparc/include/asm/smp.h:7,
                    from arch/sparc/include/asm/switch_to_32.h:5,
                    from arch/sparc/include/asm/switch_to.h:7,
                    from arch/sparc/include/asm/ptrace.h:120,
                    from arch/sparc/include/asm/thread_info_32.h:19,
                    from arch/sparc/include/asm/thread_info.h:7,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from arch/sparc/vdso/vdso32/../vclock_gettime.c:16,
                    from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   arch/sparc/include/asm/pgtable_32.h: In function 'mk_pte':
   include/asm-generic/memory_model.h:55:54: error: 'vmemmap' undeclared (first use in this function); did you mean 'mem_map'?
      55 | #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
         |                                                      ^~~~~~~
   arch/sparc/include/asm/page_32.h:99:19: note: in definition of macro '__pte'
      99 | #define __pte(x) (x)
         |                   ^
   include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
      81 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   arch/sparc/include/asm/pgtable_32.h:297:16: note: in expansion of macro 'page_to_pfn'
     297 |  return __pte((page_to_pfn(page) << (PAGE_SHIFT-4)) | pgprot_val(pgprot));
         |                ^~~~~~~~~~~
   In file included from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
   arch/sparc/vdso/vdso32/../vclock_gettime.c: At top level:
   arch/sparc/vdso/vdso32/../vclock_gettime.c:254:1: warning: no previous prototype for '__vdso_clock_gettime' [-Wmissing-prototypes]
     254 | __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
         | ^~~~~~~~~~~~~~~~~~~~
   arch/sparc/vdso/vdso32/../vclock_gettime.c:282:1: warning: no previous prototype for '__vdso_clock_gettime_stick' [-Wmissing-prototypes]
     282 | __vdso_clock_gettime_stick(clockid_t clock, struct __kernel_old_timespec *ts)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/sparc/vdso/vdso32/../vclock_gettime.c:307:1: warning: no previous prototype for '__vdso_gettimeofday' [-Wmissing-prototypes]
     307 | __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
         | ^~~~~~~~~~~~~~~~~~~
   arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: warning: no previous prototype for '__vdso_gettimeofday_stick' [-Wmissing-prototypes]
     343 | __vdso_gettimeofday_stick(struct __kernel_old_timeval *tv, struct timezone *tz)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +1317 include/linux/mmzone.h

f46edbd1b1516d Dan Williams   2019-07-18  1315  
7b7bf499f79de3 Will Deacon    2011-05-19  1316  #ifndef CONFIG_HAVE_ARCH_PFN_VALID
d41dee369bff3b Andy Whitcroft 2005-06-23 @1317  static inline int pfn_valid(unsigned long pfn)
d41dee369bff3b Andy Whitcroft 2005-06-23  1318  {
f46edbd1b1516d Dan Williams   2019-07-18  1319  	struct mem_section *ms;
f46edbd1b1516d Dan Williams   2019-07-18  1320  
d41dee369bff3b Andy Whitcroft 2005-06-23  1321  	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
d41dee369bff3b Andy Whitcroft 2005-06-23  1322  		return 0;
f46edbd1b1516d Dan Williams   2019-07-18  1323  	ms = __nr_to_section(pfn_to_section_nr(pfn));
f46edbd1b1516d Dan Williams   2019-07-18  1324  	if (!valid_section(ms))
f46edbd1b1516d Dan Williams   2019-07-18  1325  		return 0;
f46edbd1b1516d Dan Williams   2019-07-18  1326  	/*
f46edbd1b1516d Dan Williams   2019-07-18  1327  	 * Traditionally early sections always returned pfn_valid() for
f46edbd1b1516d Dan Williams   2019-07-18  1328  	 * the entire section-sized span.
f46edbd1b1516d Dan Williams   2019-07-18  1329  	 */
f46edbd1b1516d Dan Williams   2019-07-18  1330  	return early_section(ms) || pfn_section_valid(ms, pfn);
d41dee369bff3b Andy Whitcroft 2005-06-23  1331  }
7b7bf499f79de3 Will Deacon    2011-05-19  1332  #endif
d41dee369bff3b Andy Whitcroft 2005-06-23  1333  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tKW2IUtsqtDRztdT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--tKW2IUtsqtDRztdT--
