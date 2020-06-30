Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7361CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D0720723
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390105AbgF3RPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:15:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:56805 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389152AbgF3RPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:15:18 -0400
IronPort-SDR: xHmj2c5tLF176qRK8zkpkKCjEHozchTeXEUfLMqzaNlfAIXHVMvaj4Yl04KTs6WWTUphlWiDsM
 ksnEmNUQO8CQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="126366807"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="gz'50?scan'50,208,50";a="126366807"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 07:59:03 -0700
IronPort-SDR: slflu33pMqiIiwzhjoXwPjpBVqGJE6EbnUSSxFd6Wbti39P2sJ0+m2pvgfLWVz0iRdUu/emSqp
 pRFLXdBqlmFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="gz'50?scan'50,208,50";a="312389190"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Jun 2020 07:59:00 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jqHiu-0001ZX-4O; Tue, 30 Jun 2020 14:59:00 +0000
Date:   Tue, 30 Jun 2020 22:58:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/tty/serial/arc_uart.c:124:9: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202006302219.6dOhF2Hk%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7c30b859a947535f2213277e827d7ac7dcff9c84
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   12 days ago
config: m68k-randconfig-s031-20200630 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

                    from drivers/video/fbdev/core/fb_defio.c:11:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 933-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_early.c:44:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:46:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:48:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:67:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:70:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:73:17: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/nfc/pn533/pn533.c:117:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be16 [usertype] sc @@     got int @@
   drivers/nfc/pn533/pn533.c:117:39: sparse:     expected restricted __be16 [usertype] sc
   drivers/nfc/pn533/pn533.c:117:39: sparse:     got int
   drivers/nfc/pn533/pn533.c:130:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be16 [usertype] sc @@     got int @@
   drivers/nfc/pn533/pn533.c:130:39: sparse:     expected restricted __be16 [usertype] sc
   drivers/nfc/pn533/pn533.c:130:39: sparse:     got int
   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:23,
                    from include/linux/bitops.h:5,
                    from drivers/regulator/axp20x-regulator.c:16:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 964-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/mfd/88pm860x-core.c:10:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 980-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/connector/cn_proc.c:11:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 995-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/misc/mic/bus/vop_bus.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 1015-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c: In function 'fbcon_exit':
   drivers/video/fbdev/core/fbcon.c:3652:7: warning: variable 'pending' set but not used [-Wunused-but-set-variable]
    3652 |   int pending = 0;
         |       ^~~~~~~
>> drivers/tty/serial/arc_uart.c:124:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/serial/arc_uart.c:124:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:129:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:132:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:132:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:142:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:163:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:171:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:173:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:185:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:185:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:242:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:219:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:219:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:225:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:225:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:233:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:278:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:298:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:298:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:336:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:336:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:343:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:343:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:377:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:377:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:379:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:380:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:382:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:382:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:515:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:518:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:566:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:567:9: sparse: sparse: cast removes address space '__iomem' of expression
   In file included from include/linux/dev_printk.h:14,
                    from include/linux/device.h:15,
                    from drivers/nfc/pn533/pn533.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 1069-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/regulator/da9052-regulator.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 1086-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from include/linux/pagemap.h:8,
                    from drivers/dax/super.c:5:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 1106-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/tty/serial/fsl_linflexuart.c:147:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:149:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:156:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:157:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:195:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:196:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:209:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:212:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:216:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:248:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:250:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:270:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:272:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:295:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:310:18: sparse: sparse: cast removes address space '__iomem' of expression
--
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/err.h:5,
                    from drivers/regulator/gpio-regulator.c:21:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2140-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/ide/ide-pm.c:2:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2155-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/ide/ide-probe.c:20:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2172-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/string.h:6,
                    from drivers/ide/ide-taskfile.c:13:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2187-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/scsi/scsicam.c:14:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2204-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/mfd/wm8350-core.c:10:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2219-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
>> drivers/ide/ide-io-std.c:34:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:39:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:45:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:54:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:63:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:72:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:84:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:185:25: sparse: sparse: undefined identifier 'io_insl'
   drivers/ide/ide-io-std.c:200:17: sparse: sparse: undefined identifier 'io_insw'
   drivers/ide/ide-io-std.c:229:25: sparse: sparse: undefined identifier 'io_outsl'
   drivers/ide/ide-io-std.c:244:17: sparse: sparse: undefined identifier 'io_outsw'
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:356:33: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:340:33: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:420:25: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:405:25: sparse: sparse: cast removes address space '__iomem' of expression
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bio.h:8,
                    from drivers/scsi/scsi_lib.c:12:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2265-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/ide/ide-devsets.c:3:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2280-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from drivers/regulator/lp3972.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2297-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/ide/ide-sysfs.c:2:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2312-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
--
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/mmc/core/host.c:361:33: sparse: sparse: cast to restricted __be32
   drivers/mmc/core/host.c:362:33: sparse: sparse: cast to restricted __be32
   drivers/input/touchscreen/wdt87xx_i2c.c:1166:36: warning: 'wdt87xx_acpi_id' defined but not used [-Wunused-const-variable=]
    1166 | static const struct acpi_device_id wdt87xx_acpi_id[] = {
         |                                    ^~~~~~~~~~~~~~~
   drivers/md/dm.c:520:12: sparse: sparse: context imbalance in 'dm_prepare_ioctl' - wrong count at exit
   drivers/md/dm.c:555:13: sparse: sparse: context imbalance in 'dm_unprepare_ioctl' - wrong count at exit
   drivers/md/dm.c:1140:13: sparse: sparse: context imbalance in 'dm_dax_supported' - different lock contexts for basic block
   drivers/md/dm.c:1231:9: sparse: sparse: context imbalance in 'dm_dax_zero_page_range' - unexpected unlock
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from arch/m68k/include/asm/current.h:16,
                    from include/linux/sched.h:12,
                    from include/linux/blkdev.h:5,
                    from drivers/md/md-faulty.c:56:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6519-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from arch/m68k/include/asm/current.h:16,
                    from include/linux/sched.h:12,
                    from include/linux/blkdev.h:5,
                    from drivers/md/md-bitmap.c:19:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6540-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/err.h:5,
                    from include/linux/kthread.h:5,
                    from drivers/md/dm-core.h:12,
                    from drivers/md/dm.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6557-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   In file included from include/linux/kernel.h:11,
                    from include/linux/sched/mm.h:5,
                    from drivers/md/md.c:40:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6575-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from drivers/mmc/core/mmc.c:25:
   drivers/mmc/core/quirks.h:123:31: warning: 'sdio_fixup_methods' defined but not used [-Wunused-const-variable=]
     123 | static const struct mmc_fixup sdio_fixup_methods[] = {
         |                               ^~~~~~~~~~~~~~~~~~
   drivers/mmc/core/quirks.h:17:31: warning: 'mmc_blk_fixups' defined but not used [-Wunused-const-variable=]
      17 | static const struct mmc_fixup mmc_blk_fixups[] = {
         |                               ^~~~~~~~~~~~~~
>> drivers/md/dm-ioctl.c:1783:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct dm_ioctl [noderef] __user *user @@
   drivers/md/dm-ioctl.c:1783:36: sparse:     expected void *to
   drivers/md/dm-ioctl.c:1783:36: sparse:     got struct dm_ioctl [noderef] __user *user
   drivers/md/dm-ioctl.c:1798:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct dm_ioctl [noderef] __user *user @@
   drivers/md/dm-ioctl.c:1798:28: sparse:     expected void *to
   drivers/md/dm-ioctl.c:1798:28: sparse:     got struct dm_ioctl [noderef] __user *user
   drivers/md/md.c: In function 'bind_rdev_to_array':
   drivers/md/md.c:2445:27: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    2445 |   /* failure here is OK */;
         |                           ^
   In file included from include/linux/err.h:5,
                    from include/linux/kthread.h:5,
                    from drivers/md/dm-core.h:12,
                    from drivers/md/dm-table.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   drivers/md/md.c: In function 'slot_store':
   drivers/md/md.c:3206:28: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    3206 |    /* failure here is OK */;
         |                            ^
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6613-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from drivers/md/dm.h:13,
                    from drivers/md/dm-linear.c:7:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6633-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/md/md.c: In function 'remove_and_add_spares':
   drivers/md/md.c:9064:29: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    9064 |     /* failure here is OK */;
         |                             ^
   In file included from include/linux/err.h:5,
                    from include/linux/kthread.h:5,
                    from drivers/md/dm-core.h:12,
                    from drivers/md/dm-ioctl.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6654-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/mmc/core/sd_ops.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6674-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/mmc/core/mmc_ops.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
--
   drivers/extcon/extcon-adc-jack.c:53: warning: Function parameter or member 'dev' not described in 'adc_jack_data'
   drivers/extcon/extcon-adc-jack.c:53: warning: Function parameter or member 'wakeup_source' not described in 'adc_jack_data'
   drivers/leds/leds-tlc591xx.c:138:34: warning: 'of_tlc591xx_leds_match' defined but not used [-Wunused-const-variable=]
     138 | static const struct of_device_id of_tlc591xx_leds_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:23,
                    from include/linux/bitops.h:5,
                    from drivers/iio/accel/adxl372.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7663-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from drivers/greybus/connection.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7681-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/greybus.h:14,
                    from drivers/greybus/bundle.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7697-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'usb_propval' not described in 'extcon_cable'
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'chg_propval' not described in 'extcon_cable'
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'jack_propval' not described in 'extcon_cable'
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'disp_propval' not described in 'extcon_cable'
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'usb_bits' not described in 'extcon_cable'
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'chg_bits' not described in 'extcon_cable'
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'jack_bits' not described in 'extcon_cable'
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'disp_bits' not described in 'extcon_cable'
   drivers/extcon/extcon.c:409: warning: Function parameter or member 'id' not described in 'extcon_sync'
   drivers/extcon/extcon.c:762: warning: Function parameter or member 'edev' not described in 'extcon_set_property_sync'
   drivers/extcon/extcon.c:762: warning: Function parameter or member 'id' not described in 'extcon_set_property_sync'
   drivers/extcon/extcon.c:762: warning: Function parameter or member 'prop' not described in 'extcon_set_property_sync'
   In file included from include/linux/dev_printk.h:14,
                    from include/linux/device.h:15,
                    from include/linux/leds.h:12,
                    from drivers/leds/leds-tps6105x.c:6:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7726-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/leds/leds-wm8350.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7741-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
   In file included from include/linux/kernel.h:11,
                    from drivers/greybus/control.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7764-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/iio/adc/axp20x_adc.c:638:34: warning: 'axp20x_adc_of_match' defined but not used [-Wunused-const-variable=]
     638 | static const struct of_device_id axp20x_adc_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   drivers/iio/accel/bmc150-accel-i2c.c:51:36: warning: 'bmc150_accel_acpi_match' defined but not used [-Wunused-const-variable=]
      51 | static const struct acpi_device_id bmc150_accel_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bio.h:8,
                    from drivers/md/dm-bio-record.h:10,
                    from drivers/md/dm-raid1.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7793-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/fpga/altera-freeze-bridge.c:50:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:54:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:56:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:65:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:69:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:95:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:97:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:108:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:114:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:116:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:130:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:132:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:134:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:145:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:150:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:152:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:154:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:225:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:241:18: sparse: sparse: cast removes address space '__iomem' of expression
   In file included from include/linux/firmware.h:6,
                    from drivers/fpga/fpga-mgr.c:11:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7827-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/debugfs.h:15,
                    from drivers/greybus/svc.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7847-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
--
                    from drivers/video/fbdev/core/fb_defio.c:11:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 933-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_early.c:44:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:46:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:48:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:67:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:70:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:73:17: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/nfc/pn533/pn533.c:117:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be16 [usertype] sc @@     got int @@
   drivers/nfc/pn533/pn533.c:117:39: sparse:     expected restricted __be16 [usertype] sc
   drivers/nfc/pn533/pn533.c:117:39: sparse:     got int
   drivers/nfc/pn533/pn533.c:130:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be16 [usertype] sc @@     got int @@
   drivers/nfc/pn533/pn533.c:130:39: sparse:     expected restricted __be16 [usertype] sc
   drivers/nfc/pn533/pn533.c:130:39: sparse:     got int
   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:23,
                    from include/linux/bitops.h:5,
                    from drivers/regulator/axp20x-regulator.c:16:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 964-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/mfd/88pm860x-core.c:10:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 980-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/connector/cn_proc.c:11:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 995-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/misc/mic/bus/vop_bus.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 1015-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c: In function 'fbcon_exit':
   drivers/video/fbdev/core/fbcon.c:3652:7: warning: variable 'pending' set but not used [-Wunused-but-set-variable]
    3652 |   int pending = 0;
         |       ^~~~~~~
>> drivers/tty/serial/arc_uart.c:124:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/serial/arc_uart.c:124:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:129:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:132:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:132:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:142:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:163:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:171:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:173:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:185:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:185:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:242:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:219:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:219:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:225:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:225:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:233:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:278:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:298:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:298:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:336:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:336:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:343:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:343:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:377:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:377:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:379:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:380:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:382:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:382:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:515:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:518:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:566:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:567:9: sparse: sparse: cast removes address space '__iomem' of expression
   In file included from include/linux/dev_printk.h:14,
                    from include/linux/device.h:15,
                    from drivers/nfc/pn533/pn533.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 1069-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/regulator/da9052-regulator.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 1086-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from include/linux/pagemap.h:8,
                    from drivers/dax/super.c:5:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 1106-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/tty/serial/fsl_linflexuart.c:147:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:149:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:156:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:157:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:195:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:196:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:209:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:212:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:216:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:248:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:250:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:270:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:272:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:295:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:310:18: sparse: sparse: cast removes address space '__iomem' of expression
--
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/err.h:5,
                    from drivers/regulator/gpio-regulator.c:21:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2140-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/ide/ide-pm.c:2:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2155-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/ide/ide-probe.c:20:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2172-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/string.h:6,
                    from drivers/ide/ide-taskfile.c:13:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2187-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/scsi/scsicam.c:14:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2204-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/mfd/wm8350-core.c:10:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2219-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
>> drivers/ide/ide-io-std.c:34:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:39:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:45:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:54:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:63:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:72:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:84:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:185:25: sparse: sparse: undefined identifier 'io_insl'
   drivers/ide/ide-io-std.c:200:17: sparse: sparse: undefined identifier 'io_insw'
   drivers/ide/ide-io-std.c:229:25: sparse: sparse: undefined identifier 'io_outsl'
   drivers/ide/ide-io-std.c:244:17: sparse: sparse: undefined identifier 'io_outsw'
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:356:33: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:340:33: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:420:25: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:405:25: sparse: sparse: cast removes address space '__iomem' of expression
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bio.h:8,
                    from drivers/scsi/scsi_lib.c:12:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2265-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/ide/ide-devsets.c:3:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2280-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from drivers/regulator/lp3972.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2297-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/ide/ide-sysfs.c:2:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 2312-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
--
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/mmc/core/host.c:361:33: sparse: sparse: cast to restricted __be32
   drivers/mmc/core/host.c:362:33: sparse: sparse: cast to restricted __be32
   drivers/input/touchscreen/wdt87xx_i2c.c:1166:36: warning: 'wdt87xx_acpi_id' defined but not used [-Wunused-const-variable=]
    1166 | static const struct acpi_device_id wdt87xx_acpi_id[] = {
         |                                    ^~~~~~~~~~~~~~~
   drivers/md/dm.c:520:12: sparse: sparse: context imbalance in 'dm_prepare_ioctl' - wrong count at exit
   drivers/md/dm.c:555:13: sparse: sparse: context imbalance in 'dm_unprepare_ioctl' - wrong count at exit
   drivers/md/dm.c:1140:13: sparse: sparse: context imbalance in 'dm_dax_supported' - different lock contexts for basic block
   drivers/md/dm.c:1231:9: sparse: sparse: context imbalance in 'dm_dax_zero_page_range' - unexpected unlock
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from arch/m68k/include/asm/current.h:16,
                    from include/linux/sched.h:12,
                    from include/linux/blkdev.h:5,
                    from drivers/md/md-faulty.c:56:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6519-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from arch/m68k/include/asm/current.h:16,
                    from include/linux/sched.h:12,
                    from include/linux/blkdev.h:5,
                    from drivers/md/md-bitmap.c:19:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6540-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/err.h:5,
                    from include/linux/kthread.h:5,
                    from drivers/md/dm-core.h:12,
                    from drivers/md/dm.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6557-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   In file included from include/linux/kernel.h:11,
                    from include/linux/sched/mm.h:5,
                    from drivers/md/md.c:40:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6575-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from drivers/mmc/core/mmc.c:25:
   drivers/mmc/core/quirks.h:123:31: warning: 'sdio_fixup_methods' defined but not used [-Wunused-const-variable=]
     123 | static const struct mmc_fixup sdio_fixup_methods[] = {
         |                               ^~~~~~~~~~~~~~~~~~
   drivers/mmc/core/quirks.h:17:31: warning: 'mmc_blk_fixups' defined but not used [-Wunused-const-variable=]
      17 | static const struct mmc_fixup mmc_blk_fixups[] = {
         |                               ^~~~~~~~~~~~~~
>> drivers/md/dm-ioctl.c:1783:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct dm_ioctl [noderef] __user *user @@
   drivers/md/dm-ioctl.c:1783:36: sparse:     expected void *to
   drivers/md/dm-ioctl.c:1783:36: sparse:     got struct dm_ioctl [noderef] __user *user
   drivers/md/dm-ioctl.c:1798:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct dm_ioctl [noderef] __user *user @@
   drivers/md/dm-ioctl.c:1798:28: sparse:     expected void *to
   drivers/md/dm-ioctl.c:1798:28: sparse:     got struct dm_ioctl [noderef] __user *user
   drivers/md/md.c: In function 'bind_rdev_to_array':
   drivers/md/md.c:2445:27: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    2445 |   /* failure here is OK */;
         |                           ^
   In file included from include/linux/err.h:5,
                    from include/linux/kthread.h:5,
                    from drivers/md/dm-core.h:12,
                    from drivers/md/dm-table.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   drivers/md/md.c: In function 'slot_store':
   drivers/md/md.c:3206:28: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    3206 |    /* failure here is OK */;
         |                            ^
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6613-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from drivers/md/dm.h:13,
                    from drivers/md/dm-linear.c:7:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6633-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/md/md.c: In function 'remove_and_add_spares':
   drivers/md/md.c:9064:29: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    9064 |     /* failure here is OK */;
         |                             ^
   In file included from include/linux/err.h:5,
                    from include/linux/kthread.h:5,
                    from drivers/md/dm-core.h:12,
                    from drivers/md/dm-ioctl.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6654-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/mmc/core/sd_ops.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 6674-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/mmc/core/mmc_ops.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
--
   drivers/extcon/extcon-adc-jack.c:53: warning: Function parameter or member 'dev' not described in 'adc_jack_data'
   drivers/extcon/extcon-adc-jack.c:53: warning: Function parameter or member 'wakeup_source' not described in 'adc_jack_data'
   drivers/leds/leds-tlc591xx.c:138:34: warning: 'of_tlc591xx_leds_match' defined but not used [-Wunused-const-variable=]
     138 | static const struct of_device_id of_tlc591xx_leds_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:23,
                    from include/linux/bitops.h:5,
                    from drivers/iio/accel/adxl372.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7663-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from drivers/greybus/connection.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7681-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/greybus.h:14,
                    from drivers/greybus/bundle.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7697-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'usb_propval' not described in 'extcon_cable'
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'chg_propval' not described in 'extcon_cable'
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'jack_propval' not described in 'extcon_cable'
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'disp_propval' not described in 'extcon_cable'
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'usb_bits' not described in 'extcon_cable'
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'chg_bits' not described in 'extcon_cable'
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'jack_bits' not described in 'extcon_cable'
   drivers/extcon/extcon.c:219: warning: Function parameter or member 'disp_bits' not described in 'extcon_cable'
   drivers/extcon/extcon.c:409: warning: Function parameter or member 'id' not described in 'extcon_sync'
   drivers/extcon/extcon.c:762: warning: Function parameter or member 'edev' not described in 'extcon_set_property_sync'
   drivers/extcon/extcon.c:762: warning: Function parameter or member 'id' not described in 'extcon_set_property_sync'
   drivers/extcon/extcon.c:762: warning: Function parameter or member 'prop' not described in 'extcon_set_property_sync'
   In file included from include/linux/dev_printk.h:14,
                    from include/linux/device.h:15,
                    from include/linux/leds.h:12,
                    from drivers/leds/leds-tps6105x.c:6:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7726-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/leds/leds-wm8350.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7741-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
   In file included from include/linux/kernel.h:11,
                    from drivers/greybus/control.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7764-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/iio/adc/axp20x_adc.c:638:34: warning: 'axp20x_adc_of_match' defined but not used [-Wunused-const-variable=]
     638 | static const struct of_device_id axp20x_adc_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   drivers/iio/accel/bmc150-accel-i2c.c:51:36: warning: 'bmc150_accel_acpi_match' defined but not used [-Wunused-const-variable=]
      51 | static const struct acpi_device_id bmc150_accel_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bio.h:8,
                    from drivers/md/dm-bio-record.h:10,
                    from drivers/md/dm-raid1.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7793-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/fpga/altera-freeze-bridge.c:50:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:54:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:56:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:65:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:69:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:95:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:97:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:108:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:114:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:116:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:130:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:132:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:134:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:145:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:150:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:152:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:154:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:225:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/fpga/altera-freeze-bridge.c:241:18: sparse: sparse: cast removes address space '__iomem' of expression
   In file included from include/linux/firmware.h:6,
                    from drivers/fpga/fpga-mgr.c:11:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7827-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/debugfs.h:15,
                    from drivers/greybus/svc.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 7847-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
--
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/vt/keyboard.c: In function 'k_fn':
   drivers/tty/vt/keyboard.c:744:22: warning: comparison is always true due to limited range of data type [-Wtype-limits]
     744 |  if ((unsigned)value < ARRAY_SIZE(func_table)) {
         |                      ^
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/tty/serial/8250/8250_fintek.c:7:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 109-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/tty/vt/consolemap.c:716: warning: Function parameter or member 'src_vc' not described in 'con_copy_unimap'
   drivers/tty/vt/consolemap.c:716: warning: Excess function parameter 'src_vt' description in 'con_copy_unimap'
   drivers/tty/vt/consolemap.c:739: warning: Function parameter or member 'ct' not described in 'con_get_unimap'
   drivers/tty/vt/consolemap.c:739: warning: Function parameter or member 'uct' not described in 'con_get_unimap'
   drivers/tty/vt/consolemap.c:739: warning: Function parameter or member 'list' not described in 'con_get_unimap'
   drivers/tty/serial/serial_core.c:3299: warning: Function parameter or member 'port' not described in 'uart_get_rs485_mode'
   drivers/tty/serial/serial_core.c:3299: warning: Excess function parameter 'dev' description in 'uart_get_rs485_mode'
   drivers/tty/serial/serial_core.c:3299: warning: Excess function parameter 'rs485conf' description in 'uart_get_rs485_mode'
   drivers/tty/serial/uartlite.c:559:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/uartlite.c:565:17: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/spinlock.h:408:9: sparse: sparse: context imbalance in 'ulite_console_write' - wrong count at exit
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:23,
                    from include/linux/bitops.h:5,
                    from drivers/tty/serial/sc16is7xx.c:11:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 145-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/tty/vt/vt.c:233:5: sparse: sparse: symbol 'console_blank_hook' was not declared. Should it be static?
   drivers/tty/vt/vt.c:2901:19: sparse: sparse: symbol 'console_driver' was not declared. Should it be static?
   drivers/tty/serial/altera_uart.c:86:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/altera_uart.c:91:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/vt/vt.c:4589:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected char const *src @@     got unsigned char [noderef] __user *data @@
   drivers/tty/vt/vt.c:4589:44: sparse:     expected char const *src
   drivers/tty/vt/vt.c:4589:44: sparse:     got unsigned char [noderef] __user *data
   drivers/tty/vt/vt.c:2942:13: sparse: sparse: context imbalance in 'vt_console_print' - wrong count at exit
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/tty/serial/8250/serial_cs.c:35:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 170-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/tty/serial/8250/serial_cs.c: In function 'multi_config':
   drivers/tty/serial/8250/serial_cs.c:562:7: warning: variable 'err' set but not used [-Wunused-but-set-variable]
     562 |   int err;
         |       ^~~
   drivers/tty/serial/8250/8250_early.c:44:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:46:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:48:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:67:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:70:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:73:17: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/serial/arc_uart.c:124:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/serial/arc_uart.c:124:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:129:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:132:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:132:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:142:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:163:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:171:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:173:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:185:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:185:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:242:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:219:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:219:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:225:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:225:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:233:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:278:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:298:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:298:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:336:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:336:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:343:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:343:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:377:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:377:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:379:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:380:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:382:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:382:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:515:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:518:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:566:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:567:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:147:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:149:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:156:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:157:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:195:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:196:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:209:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:212:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:216:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:248:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:250:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:270:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:272:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:295:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:310:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:333:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:335:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:337:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:339:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:346:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:349:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:363:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:368:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:372:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:374:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:378:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:406:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:408:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:423:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:427:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:429:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:432:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:518:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:522:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:168:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:171:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:179:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:168:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:171:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:179:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serdev/core.c: In function 'serdev_controller_remove':
   drivers/tty/serdev/core.c:791:6: warning: variable 'dummy' set but not used [-Wunused-but-set-variable]
     791 |  int dummy;
         |      ^~~~~
   drivers/tty/serdev/core.c:811: warning: Function parameter or member 'owner' not described in '__serdev_device_driver_register'
   drivers/tty/vt/vt.c:1187: warning: Excess function parameter 'real_tty' description in 'vc_do_resize'
   drivers/tty/vt/vt.c:3902: warning: Function parameter or member 'vc' not described in 'con_debug_enter'
   drivers/tty/vt/vt.c:3902: warning: Excess function parameter 'sw' description in 'con_debug_enter'
   drivers/tty/vt/vt.c:3959: warning: Excess function parameter 'sw' description in 'con_debug_leave'
   drivers/tty/vt/defkeymap.c:28:9: sparse: sparse: symbol 'shift_map' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:47:9: sparse: sparse: symbol 'altgr_map' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:66:9: sparse: sparse: symbol 'ctrl_map' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:85:9: sparse: sparse: symbol 'shift_ctrl_map' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:104:9: sparse: sparse: symbol 'alt_map' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:123:9: sparse: sparse: symbol 'ctrl_alt_map' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:149:14: sparse: sparse: symbol 'keymap_count' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:157:6: sparse: sparse: symbol 'func_buf' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:188:6: sparse: sparse: symbol 'funcbufptr' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:189:5: sparse: sparse: symbol 'funcbufsize' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:190:5: sparse: sparse: symbol 'funcbufleft' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:192:6: sparse: sparse: symbol 'func_table' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:226:18: sparse: sparse: symbol 'accent_table' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:263:14: sparse: sparse: symbol 'accent_table_size' was not declared. Should it be static?
   drivers/tty/vt/consolemap_deftbl.c:10:4: sparse: sparse: symbol 'dfont_unicount' was not declared. Should it be static?
   drivers/tty/vt/consolemap_deftbl.c:46:5: sparse: sparse: symbol 'dfont_unitable' was not declared. Should it be static?
   drivers/tty/tty_io.c:218: warning: Function parameter or member 'file' not described in 'tty_free_file'
   drivers/tty/tty_io.c:320: warning: Function parameter or member 'device' not described in 'get_tty_driver'
   drivers/tty/tty_io.c:320: warning: Excess function parameter 'dev_t' description in 'get_tty_driver'
--
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/ide/ide-io.c:27:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 65-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/ide/ide-iops.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 82-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/ide/ide-io.c:320: warning: Function parameter or member 'drive' not described in 'start_request'
   drivers/ide/ide-io.c:320: warning: Function parameter or member 'rq' not described in 'start_request'
   drivers/ide/ide-io.c:623: warning: Function parameter or member 't' not described in 'ide_timer_expiry'
   drivers/ide/ide-io.c:623: warning: Excess function parameter 'data' description in 'ide_timer_expiry'
   drivers/ide/ide-io.c:780: warning: Excess function parameter 'regs' description in 'ide_intr'
   In file included from include/linux/string.h:6,
                    from drivers/ide/ide-lib.c:3:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 102-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/ide/ide-pm.c:2:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 117-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/ide/ide-probe.c:20:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 134-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/string.h:6,
                    from drivers/ide/ide-taskfile.c:13:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 149-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
>> drivers/ide/ide-io-std.c:34:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:39:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:45:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:54:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:63:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:72:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:84:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:185:25: sparse: sparse: undefined identifier 'io_insl'
   drivers/ide/ide-io-std.c:200:17: sparse: sparse: undefined identifier 'io_insw'
   drivers/ide/ide-io-std.c:229:25: sparse: sparse: undefined identifier 'io_outsl'
   drivers/ide/ide-io-std.c:244:17: sparse: sparse: undefined identifier 'io_outsw'
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:356:33: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:340:33: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:420:25: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:405:25: sparse: sparse: cast removes address space '__iomem' of expression
   In file included from include/linux/kernel.h:11,
                    from drivers/ide/ide-devsets.c:3:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 189-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/ide/ide-sysfs.c:2:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 204-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/ide/ide-park.c:2:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 219-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/ide/ide-io-std.c:3:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 234-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from drivers/ide/ide-io-std.c:9:
   drivers/ide/ide-io-std.c: In function 'ide_input_data':
   arch/m68k/include/asm/ide.h:60:38: error: implicit declaration of function 'io_insl' [-Werror=implicit-function-declaration]
      60 | #define __ide_mm_insl(port, addr, n) io_insl((unsigned int)port, addr, n)
         |                                      ^~~~~~~
   drivers/ide/ide-io-std.c:185:4: note: in expansion of macro '__ide_mm_insl'
     185 |    __ide_mm_insl((void __iomem *)data_addr, buf, words);
         |    ^~~~~~~~~~~~~
   arch/m68k/include/asm/ide.h:59:38: error: implicit declaration of function 'io_insw' [-Werror=implicit-function-declaration]
      59 | #define __ide_mm_insw(port, addr, n) io_insw((unsigned int)port, addr, n)
         |                                      ^~~~~~~
   drivers/ide/ide-io-std.c:200:3: note: in expansion of macro '__ide_mm_insw'
     200 |   __ide_mm_insw((void __iomem *)data_addr, buf, words);
         |   ^~~~~~~~~~~~~
   drivers/ide/ide-io-std.c: In function 'ide_output_data':
   arch/m68k/include/asm/ide.h:62:39: error: implicit declaration of function 'io_outsl'; did you mean 'outsl'? [-Werror=implicit-function-declaration]
--
   In file included from include/linux/kernel.h:11,
                    from drivers/md/raid5-ppl.c:7:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 367-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/md/raid5-cache.c: In function 'r5c_tree_index':
   drivers/md/raid5-cache.c:198:11: warning: variable 'offset' set but not used [-Wunused-but-set-variable]
     198 |  sector_t offset;
         |           ^~~~~~
   drivers/md/dm.c:520:12: sparse: sparse: context imbalance in 'dm_prepare_ioctl' - wrong count at exit
   drivers/md/dm.c:555:13: sparse: sparse: context imbalance in 'dm_unprepare_ioctl' - wrong count at exit
   drivers/md/dm.c:1140:13: sparse: sparse: context imbalance in 'dm_dax_supported' - different lock contexts for basic block
   drivers/md/dm.c:1231:9: sparse: sparse: context imbalance in 'dm_dax_zero_page_range' - unexpected unlock
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from arch/m68k/include/asm/current.h:16,
                    from include/linux/sched.h:12,
                    from include/linux/blkdev.h:5,
                    from drivers/md/md-faulty.c:56:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 396-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from arch/m68k/include/asm/current.h:16,
                    from include/linux/sched.h:12,
                    from include/linux/blkdev.h:5,
                    from drivers/md/md-bitmap.c:19:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 417-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/err.h:5,
                    from include/linux/kthread.h:5,
                    from drivers/md/dm-core.h:12,
                    from drivers/md/dm.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 434-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   In file included from include/linux/kernel.h:11,
                    from include/linux/sched/mm.h:5,
                    from drivers/md/md.c:40:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 452-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
>> drivers/md/dm-ioctl.c:1783:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct dm_ioctl [noderef] __user *user @@
   drivers/md/dm-ioctl.c:1783:36: sparse:     expected void *to
   drivers/md/dm-ioctl.c:1783:36: sparse:     got struct dm_ioctl [noderef] __user *user
   drivers/md/dm-ioctl.c:1798:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct dm_ioctl [noderef] __user *user @@
   drivers/md/dm-ioctl.c:1798:28: sparse:     expected void *to
   drivers/md/dm-ioctl.c:1798:28: sparse:     got struct dm_ioctl [noderef] __user *user
   drivers/md/md.c: In function 'bind_rdev_to_array':
   drivers/md/md.c:2445:27: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    2445 |   /* failure here is OK */;
         |                           ^
   In file included from include/linux/err.h:5,
                    from include/linux/kthread.h:5,
                    from drivers/md/dm-core.h:12,
                    from drivers/md/dm-table.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   drivers/md/md.c: In function 'slot_store':
   drivers/md/md.c:3206:28: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    3206 |    /* failure here is OK */;
         |                            ^
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 483-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from drivers/md/dm.h:13,
                    from drivers/md/dm-linear.c:7:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 503-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/md/md.c: In function 'remove_and_add_spares':
   drivers/md/md.c:9064:29: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    9064 |     /* failure here is OK */;
         |                             ^
   In file included from include/linux/err.h:5,
                    from include/linux/kthread.h:5,
                    from drivers/md/dm-core.h:12,
                    from drivers/md/dm-ioctl.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 524-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from drivers/md/dm.h:13,
                    from drivers/md/dm-stripe.c:7:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 544-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from include/linux/err.h:5,
                    from include/linux/kthread.h:5,
                    from drivers/md/dm-core.h:12,
                    from drivers/md/dm-target.c:7:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 561-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
--
   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:23,
                    from include/linux/bitops.h:5,
                    from drivers/iio/accel/adxl372.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 8-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/axp20x_adc.c:638:34: warning: 'axp20x_adc_of_match' defined but not used [-Wunused-const-variable=]
     638 | static const struct of_device_id axp20x_adc_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~
   drivers/iio/accel/bmc150-accel-i2c.c:51:36: warning: 'bmc150_accel_acpi_match' defined but not used [-Wunused-const-variable=]
      51 | static const struct acpi_device_id bmc150_accel_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ltc2497.c:92:34: warning: 'ltc2497_of_match' defined but not used [-Wunused-const-variable=]
      92 | static const struct of_device_id ltc2497_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~
   drivers/iio/accel/da280.c:178:36: warning: 'da280_acpi_match' defined but not used [-Wunused-const-variable=]
     178 | static const struct acpi_device_id da280_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~
   drivers/iio/chemical/atlas-sensor.c:612:34: warning: 'atlas_dt_ids' defined but not used [-Wunused-const-variable=]
     612 | static const struct of_device_id atlas_dt_ids[] = {
         |                                  ^~~~~~~~~~~~
   drivers/iio/adc/max9611.c:117: warning: cannot understand function prototype: 'const unsigned int max9611_mux_conf[][2] = '
   drivers/iio/adc/max9611.c:145: warning: cannot understand function prototype: 'const unsigned int max9611_gain_conf[][2] = '
   drivers/iio/common/ms_sensors/ms_sensors_i2c.c:186: warning: Function parameter or member 'client' not described in 'ms_sensors_read_serial'
   drivers/iio/common/ms_sensors/ms_sensors_i2c.c:186: warning: Excess function parameter 'cli' description in 'ms_sensors_read_serial'
   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/iio/buffer/kfifo_buf.c:2:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 55-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/iio/chemical/ams-iaq-core.c:172:34: warning: 'ams_iaqcore_dt_ids' defined but not used [-Wunused-const-variable=]
     172 | static const struct of_device_id ams_iaqcore_dt_ids[] = {
         |                                  ^~~~~~~~~~~~~~~~~~
   drivers/iio/accel/kxcjk-1013.c:1505:36: warning: 'kx_acpi_match' defined but not used [-Wunused-const-variable=]
    1505 | static const struct acpi_device_id kx_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~
   drivers/iio/chemical/bme680_i2c.c:46:36: warning: 'bme680_acpi_match' defined but not used [-Wunused-const-variable=]
      46 | static const struct acpi_device_id bme680_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   In file included from include/linux/dev_printk.h:14,
                    from include/linux/device.h:15,
                    from drivers/iio/dac/ad5380.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 84-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   arch/m68k/include/asm/bitops.h:493:27: sparse: sparse: not addressable
   In file included from include/linux/kernel.h:11,
                    from drivers/iio/common/st_sensors/st_sensors_i2c.c:10:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 105-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/iio/dac/ad5380.c:64: warning: Function parameter or member 'lock' not described in 'ad5380_state'
   In file included from include/linux/kernel.h:11,
                    from drivers/iio/common/st_sensors/st_sensors_core.c:10:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 121-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
--
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/tty/serial/serial_core.c:321:9: sparse: sparse: context imbalance in 'uart_shutdown' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:569:9: sparse: sparse: context imbalance in 'uart_put_char' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:617:9: sparse: sparse: context imbalance in 'uart_write' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:620:12: sparse: sparse: context imbalance in 'uart_write_room' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:633:12: sparse: sparse: context imbalance in 'uart_chars_in_buffer' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:670:9: sparse: sparse: context imbalance in 'uart_flush_buffer' - different lock contexts for basic block
   drivers/tty/serial/sccnxp.c:228:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/sccnxp.c:239:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/tty/serial/8250/8250_fintek.c:7:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 84-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/tty/serial/serial_core.c:3299: warning: Function parameter or member 'port' not described in 'uart_get_rs485_mode'
   drivers/tty/serial/serial_core.c:3299: warning: Excess function parameter 'dev' description in 'uart_get_rs485_mode'
   drivers/tty/serial/serial_core.c:3299: warning: Excess function parameter 'rs485conf' description in 'uart_get_rs485_mode'
   drivers/tty/serial/uartlite.c:559:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/uartlite.c:565:17: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/spinlock.h:408:9: sparse: sparse: context imbalance in 'ulite_console_write' - wrong count at exit
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:23,
                    from include/linux/bitops.h:5,
                    from drivers/tty/serial/sc16is7xx.c:11:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 115-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/tty/serial/altera_uart.c:86:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/altera_uart.c:91:9: sparse: sparse: cast removes address space '__iomem' of expression
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/tty/serial/8250/serial_cs.c:35:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && 134-      |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/tty/serial/8250/serial_cs.c: In function 'multi_config':
   drivers/tty/serial/8250/serial_cs.c:562:7: warning: variable 'err' set but not used [-Wunused-but-set-variable]
     562 |   int err;
         |       ^~~
   drivers/tty/serial/8250/8250_early.c:44:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:46:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:48:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:67:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:70:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/8250/8250_early.c:73:17: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/serial/arc_uart.c:124:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/serial/arc_uart.c:124:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:129:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:132:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:132:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:142:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:163:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:171:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:173:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:185:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:185:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:242:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:219:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:219:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:225:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:225:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:233:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:278:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:298:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:298:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:336:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:336:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:343:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:343:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:377:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:377:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:379:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:380:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:382:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:382:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:515:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:518:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:566:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:567:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:147:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:149:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:156:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:157:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:195:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:196:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:209:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:212:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:216:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:248:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:250:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:270:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:272:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:295:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:310:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:333:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:335:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:337:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:339:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:346:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:349:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:363:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:368:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:372:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:374:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:378:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:406:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:408:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:423:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:427:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:429:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:432:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:518:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:522:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:168:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:171:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:179:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:168:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:171:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/fsl_linflexuart.c:179:17: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/tty/serial/arc_uart.c:124:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/serial/arc_uart.c:124:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:129:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:132:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:132:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:142:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:163:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:171:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:173:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:185:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:185:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:242:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:219:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:219:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:225:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:225:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:233:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:278:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:298:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:298:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:336:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:336:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:343:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:343:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:377:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:377:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:379:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:380:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:382:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:382:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:515:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:518:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:566:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/arc_uart.c:567:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/ide/ide-io-std.c:34:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:39:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:45:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:54:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:63:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:72:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:84:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ide/ide-io-std.c:185:25: sparse: sparse: undefined identifier 'io_insl'
   drivers/ide/ide-io-std.c:200:17: sparse: sparse: undefined identifier 'io_insw'
   drivers/ide/ide-io-std.c:229:25: sparse: sparse: undefined identifier 'io_outsl'
   drivers/ide/ide-io-std.c:244:17: sparse: sparse: undefined identifier 'io_outsw'
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:464:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:356:33: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:340:33: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:420:25: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:405:25: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/md/dm-ioctl.c:1783:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct dm_ioctl [noderef] __user *user @@
   drivers/md/dm-ioctl.c:1783:36: sparse:     expected void *to
   drivers/md/dm-ioctl.c:1783:36: sparse:     got struct dm_ioctl [noderef] __user *user
   drivers/md/dm-ioctl.c:1798:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct dm_ioctl [noderef] __user *user @@
   drivers/md/dm-ioctl.c:1798:28: sparse:     expected void *to
   drivers/md/dm-ioctl.c:1798:28: sparse:     got struct dm_ioctl [noderef] __user *user
--
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/axp20x_adc.c:638:34: warning: 'axp20x_adc_of_match' defined but not used [-Wunused-const-variable=]
     638 | static const struct of_device_id axp20x_adc_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ltc2497.c:92:34: warning: 'ltc2497_of_match' defined but not used [-Wunused-const-variable=]
      92 | static const struct of_device_id ltc2497_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~
   drivers/iio/adc/max9611.c:117: warning: cannot understand function prototype: 'const unsigned int max9611_mux_conf[][2] = '
   drivers/iio/adc/max9611.c:145: warning: cannot understand function prototype: 'const unsigned int max9611_gain_conf[][2] = '
   drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'dev' not described in 'palmas_gpadc'
   drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'palmas' not described in 'palmas_gpadc'
   drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'irq' not described in 'palmas_gpadc'
   drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'irq_auto_0' not described in 'palmas_gpadc'
   drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'irq_auto_1' not described in 'palmas_gpadc'
   drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'adc_info' not described in 'palmas_gpadc'
   drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'conv_completion' not described in 'palmas_gpadc'
   drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup1_data' not described in 'palmas_gpadc'
   drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup2_data' not described in 'palmas_gpadc'
   drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup1_enable' not described in 'palmas_gpadc'
   drivers/iio/adc/palmas_gpadc.c:114: warning: Function parameter or member 'wakeup2_enable' not described in 'palmas_gpadc'
   drivers/iio/adc/xilinx-xadc-core.c:118:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/xilinx-xadc-core.c:124:16: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/iio/adc/cc10001_adc.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/iio/adc/cc10001_adc.c:76:16: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +124 drivers/tty/serial/arc_uart.c

2ac4ad2a146812 Vineet Gupta 2012-10-27  121  
2ac4ad2a146812 Vineet Gupta 2012-10-27  122  static void arc_serial_stop_rx(struct uart_port *port)
2ac4ad2a146812 Vineet Gupta 2012-10-27  123  {
12d15e6f6377fe Vineet Gupta 2014-06-24 @124  	UART_RX_IRQ_DISABLE(port);
2ac4ad2a146812 Vineet Gupta 2012-10-27  125  }
2ac4ad2a146812 Vineet Gupta 2012-10-27  126  

:::::: The code at line 124 was first introduced by commit
:::::: 12d15e6f6377fe46b1f9dc51133890a732f1ae05 serial/arc: Refactor by referencing to uart_port where possible

:::::: TO: Vineet Gupta <Vineet.Gupta1@synopsys.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--wac7ysb48OaltWcw
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
wHQag+6NTG9TlsuyMHT+Dy5vMSWcSAEA

--wac7ysb48OaltWcw--
