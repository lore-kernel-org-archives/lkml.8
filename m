Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB76DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100E6206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbgF3G5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:57:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:3594 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgF3G5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:57:53 -0400
IronPort-SDR: UCKN6TDtJerJvX/tGD1QULD/VbiOK/76bEzwQXeqUhShE0vrGkWVqUCAoxtnXonKW4h31w0dFL
 HwjM74W40MKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="144330951"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="gz'50?scan'50,208,50";a="144330951"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 22:01:38 -0700
IronPort-SDR: xUvmJXSLNY/t37aqE+ROGZSoKZAnNiknuu0TIWu6dqqnye8VNLyFU+W0Df3+YXowLbLS3JMc4g
 NmDNdrVlFpBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="gz'50?scan'50,208,50";a="386594051"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2020 22:01:35 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jq8Ol-0001Ki-AD; Tue, 30 Jun 2020 05:01:35 +0000
Date:   Tue, 30 Jun 2020 13:01:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: net/netrom/af_netrom.c:309:13: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202006301310.U9hBnzZj%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7c30b859a947535f2213277e827d7ac7dcff9c84
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   12 days ago
config: sh-randconfig-s031-20200630 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C= CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> net/netrom/af_netrom.c:309:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   net/netrom/af_netrom.c:309:13: sparse:     expected unsigned int const *__gu_addr
>> net/netrom/af_netrom.c:309:13: sparse:     got unsigned int [noderef] __user *
>> net/netrom/af_netrom.c:309:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> net/netrom/af_netrom.c:309:13: sparse:     expected void const volatile [noderef] __user *
   net/netrom/af_netrom.c:309:13: sparse:     got unsigned int const *__gu_addr
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/netrom/af_netrom.c:359:13: sparse:     expected int const *__gu_addr
>> net/netrom/af_netrom.c:359:13: sparse:     got int [noderef] __user *optlen
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/netrom/af_netrom.c:359:13: sparse:     expected void const volatile [noderef] __user *
   net/netrom/af_netrom.c:359:13: sparse:     got int const *__gu_addr
--
   drivers/spi/spidev.c:396:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:396:34: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:396:34: sparse:     got unsigned char [noderef] [usertype] __user *
>> drivers/spi/spidev.c:396:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
>> drivers/spi/spidev.c:396:34: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:396:34: sparse:     got unsigned char const *__gu_addr
   drivers/spi/spidev.c:398:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:398:34: sparse:     expected unsigned int const *__gu_addr
   drivers/spi/spidev.c:398:34: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/spi/spidev.c:398:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/spi/spidev.c:398:34: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:398:34: sparse:     got unsigned int const *__gu_addr
   drivers/spi/spidev.c:422:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:422:26: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:422:26: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/spi/spidev.c:422:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
   drivers/spi/spidev.c:422:26: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:422:26: sparse:     got unsigned char const *__gu_addr
   drivers/spi/spidev.c:439:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:439:26: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:439:26: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/spi/spidev.c:439:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
   drivers/spi/spidev.c:439:26: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:439:26: sparse:     got unsigned char const *__gu_addr
   drivers/spi/spidev.c:452:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:452:26: sparse:     expected unsigned int const *__gu_addr
   drivers/spi/spidev.c:452:26: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/spi/spidev.c:452:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/spi/spidev.c:452:26: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:452:26: sparse:     got unsigned int const *__gu_addr
--
>> drivers/net/hamradio/6pack.c:710:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/hamradio/6pack.c:710:21: sparse:     expected int const *__gu_addr
>> drivers/net/hamradio/6pack.c:710:21: sparse:     got int [noderef] __user *
>> drivers/net/hamradio/6pack.c:710:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> drivers/net/hamradio/6pack.c:710:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/hamradio/6pack.c:710:21: sparse:     got int const *__gu_addr
   {standard input}: Assembler messages:
   {standard input}:1340: Error: unknown opcode
   {standard input}:1371: Error: unknown opcode
   {standard input}:1576: Error: unknown opcode
   {standard input}:1853: Error: unknown opcode
   {standard input}:2081: Error: unknown opcode
   {standard input}:2320: Error: unknown opcode
   {standard input}:2893: Error: unknown opcode
   {standard input}:3462: Error: unknown opcode
   {standard input}:3750: Error: unknown opcode
   {standard input}:4086: Error: unknown opcode
   {standard input}:4363: Error: unknown opcode
   {standard input}:6410: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/net/hamradio/6pack.o] Error 1
   drivers/net/hamradio/baycom_ser_fdx.c:290:43: sparse: sparse: dubious: x | !y
   {standard input}: Assembler messages:
   {standard input}:1038: Error: unknown opcode
   {standard input}:1546: Error: unknown opcode
   {standard input}:1696: Error: unknown opcode
   {standard input}:1890: Error: unknown opcode
   {standard input}:2760: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:280: drivers/net/hamradio/hdlcdrv.o] Error 1
   make[4]: Target '__build' not remade because of errors.
--
   drivers/net/slip/slip.c:458:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:458:14: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:458:14: sparse:    void *
   drivers/net/slip/slip.c:892:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:892:9: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:892:9: sparse:    void *
   drivers/net/slip/slip.c:1099:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
>> drivers/net/slip/slip.c:1099:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/slip/slip.c:1124:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/slip/slip.c:1124:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/slip/slip.c:1150:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/slip/slip.c:1150:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   {standard input}: Assembler messages:
   {standard input}:50: Error: unknown opcode
   {standard input}:113: Error: unknown opcode
   {standard input}:878: Error: unknown opcode
   {standard input}:931: Error: unknown opcode
   {standard input}:4211: Error: unknown opcode
   {standard input}:4254: Error: unknown opcode
   {standard input}:4693: Error: unknown opcode
   {standard input}:4736: Error: unknown opcode
   {standard input}:6118: Error: unknown opcode
   {standard input}:6216: Error: unknown opcode
   {standard input}:6472: Error: unknown opcode
   {standard input}:6541: Error: unknown opcode
   {standard input}:6631: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/net/slip/slip.o] Error 1
   make[4]: Target '__build' not remade because of errors.
--
>> drivers/net/hamradio/6pack.c:710:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/hamradio/6pack.c:710:21: sparse:     expected int const *__gu_addr
>> drivers/net/hamradio/6pack.c:710:21: sparse:     got int [noderef] __user *
>> drivers/net/hamradio/6pack.c:710:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> drivers/net/hamradio/6pack.c:710:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/hamradio/6pack.c:710:21: sparse:     got int const *__gu_addr
--
   drivers/net/slip/slip.c:458:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:458:14: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:458:14: sparse:    void *
   drivers/net/slip/slip.c:892:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:892:9: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:892:9: sparse:    void *
   drivers/net/slip/slip.c:1099:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
>> drivers/net/slip/slip.c:1099:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/slip/slip.c:1124:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/slip/slip.c:1124:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/slip/slip.c:1150:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/slip/slip.c:1150:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
--
   drivers/tty/pty.c:183:13: sparse:     got int [noderef] __user *arg
   drivers/tty/pty.c:183:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/tty/pty.c:183:13: sparse:     expected void const volatile [noderef] __user *
   drivers/tty/pty.c:183:13: sparse:     got int const *__gu_addr
   make[3]: *** [scripts/Makefile.build:281: drivers/dma-buf/sync_file.o] Error 1
   net/ipv4/ip_sockglue.c:759:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/ipv4/ip_sockglue.c:759:29: sparse:     expected int const *__gu_addr
   net/ipv4/ip_sockglue.c:759:29: sparse:     got int [noderef] __user *
   net/ipv4/ip_sockglue.c:759:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/ipv4/ip_sockglue.c:759:29: sparse:     expected void const volatile [noderef] __user *
   net/ipv4/ip_sockglue.c:759:29: sparse:     got int const *__gu_addr
   net/ipv4/ip_sockglue.c:764:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] __user * @@
   net/ipv4/ip_sockglue.c:764:29: sparse:     expected unsigned char const *__gu_addr
   net/ipv4/ip_sockglue.c:764:29: sparse:     got unsigned char [noderef] __user *
   net/ipv4/ip_sockglue.c:764:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
   net/ipv4/ip_sockglue.c:764:29: sparse:     expected void const volatile [noderef] __user *
   net/ipv4/ip_sockglue.c:764:29: sparse:     got unsigned char const *__gu_addr
   net/ipv4/ip_sockglue.c:1486:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/ip_sockglue.c:1486:13: sparse:     expected int const *__gu_addr
   net/ipv4/ip_sockglue.c:1486:13: sparse:     got int [noderef] __user *optlen
   net/ipv4/ip_sockglue.c:1486:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/ipv4/ip_sockglue.c:1486:13: sparse:     expected void const volatile [noderef] __user *
   net/ipv4/ip_sockglue.c:1486:13: sparse:     got int const *__gu_addr
   {standard input}:27022: Error: unknown opcode
   {standard input}:27272: Error: unknown opcode
   {standard input}:27304: Error: unknown opcode
   make[3]: Target '__build' not remade because of errors.
   make[2]: *** [scripts/Makefile.build:497: net/llc] Error 2
   make[3]: *** [scripts/Makefile.build:280: net/core/neighbour.o] Error 1
   {standard input}:27788: Error: unknown opcode
   {standard input}:27931: Error: unknown opcode
   {standard input}:28560: Error: unknown opcode
   {standard input}:29015: Error: unknown opcode
   {standard input}:29090: Error: unknown opcode
   {standard input}:29469: Error: unknown opcode
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:497: drivers/base/regmap] Error 2
   {standard input}: Assembler messages:
   {standard input}:864: Error: unknown opcode
   {standard input}:917: Error: unknown opcode
   {standard input}:1952: Error: unknown opcode
   {standard input}:2118: Error: unknown opcode
   {standard input}:2536: Error: unknown opcode
   {standard input}:2597: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/bridge/br_device.o] Error 1
   make[3]: *** [scripts/Makefile.build:280: net/packet/af_packet.o] Error 1
   make[3]: Target '__build' not remade because of errors.
   make[2]: *** [scripts/Makefile.build:497: net/packet] Error 2
   {standard input}:29907: Error: unknown opcode
   {standard input}:31270: Error: unknown opcode
   {standard input}:31449: Error: unknown opcode
   {standard input}:32568: Error: unknown opcode
   net/appletalk/aarp.c:68: warning: Function parameter or member 'last_sent' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'packet_queue' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'status' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'expires_at' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'target_addr' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'dev' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'hwaddr' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'xmit_count' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'next' not described in 'aarp_entry'
   make[3]: *** [scripts/Makefile.build:280: net/core/rtnetlink.o] Error 1
   {standard input}:35660: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:66: Error: unknown opcode
   {standard input}:129: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:1292: Error: unknown opcode
   {standard input}:1323: Error: unknown opcode
   {standard input}:1550: Error: unknown opcode
   {standard input}:36867: Error: unknown opcode
   {standard input}:2519: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/ipv6/anycast.o] Error 1
   {standard input}:2306: Error: unknown opcode
   {standard input}:4145: Error: unknown opcode
   {standard input}:4785: Error: unknown opcode
   {standard input}:6063: Error: unknown opcode
   {standard input}:6408: Error: unknown opcode
   net/x25/af_x25.c:448:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/x25/af_x25.c:448:13: sparse:     expected int const *__gu_addr
   net/x25/af_x25.c:448:13: sparse:     got int [noderef] __user *
   net/x25/af_x25.c:448:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/x25/af_x25.c:448:13: sparse:     expected void const volatile [noderef] __user *
   net/x25/af_x25.c:448:13: sparse:     got int const *__gu_addr
   net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/x25/af_x25.c:470:13: sparse:     expected int const *__gu_addr
   net/x25/af_x25.c:470:13: sparse:     got int [noderef] __user *optlen
   net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/x25/af_x25.c:470:13: sparse:     expected void const volatile [noderef] __user *
   net/x25/af_x25.c:470:13: sparse:     got int const *__gu_addr
   {standard input}: Assembler messages:
   {standard input}:2717: Error: unknown opcode
   {standard input}:2748: Error: unknown opcode
   {standard input}:2902: Error: unknown opcode
   {standard input}:3899: Error: unknown opcode
   {standard input}:7318: Error: unknown opcode
   {standard input}:7424: Error: unknown opcode
   {standard input}:8378: Error: unknown opcode
   {standard input}:43209: Error: unknown opcode
   {standard input}:44807: Error: unknown opcode
>> net/netrom/af_netrom.c:309:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   net/netrom/af_netrom.c:309:13: sparse:     expected unsigned int const *__gu_addr
>> net/netrom/af_netrom.c:309:13: sparse:     got unsigned int [noderef] __user *
>> net/netrom/af_netrom.c:309:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> net/netrom/af_netrom.c:309:13: sparse:     expected void const volatile [noderef] __user *
   net/netrom/af_netrom.c:309:13: sparse:     got unsigned int const *__gu_addr
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/netrom/af_netrom.c:359:13: sparse:     expected int const *__gu_addr
>> net/netrom/af_netrom.c:359:13: sparse:     got int [noderef] __user *optlen
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/netrom/af_netrom.c:359:13: sparse:     expected void const volatile [noderef] __user *
   net/netrom/af_netrom.c:359:13: sparse:     got int const *__gu_addr
   make[4]: Target '__build' not remade because of errors.
   make[2]: *** [scripts/Makefile.build:497: drivers/char] Error 2
   make[3]: *** [scripts/Makefile.build:497: drivers/char/tpm] Error 2
   make[3]: Target '__build' not remade because of errors.
   {standard input}: Assembler messages:
   {standard input}:50: Error: unknown opcode
   {standard input}:3142: Error: unknown opcode
   {standard input}:3367: Error: unknown opcode
   {standard input}:3419: Error: unknown opcode
   {standard input}:3809: Error: unknown opcode
   {standard input}:3958: Error: unknown opcode
   {standard input}:44867: Error: unknown opcode
   {standard input}:46057: Error: unknown opcode
   {standard input}:46977: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:280: drivers/tty/pty.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:980: Error: unknown opcode
   {standard input}:15342: Error: unknown opcode
   {standard input}:15419: Error: unknown opcode
   {standard input}:15531: Error: unknown opcode
   {standard input}:15578: Error: unknown opcode
   {standard input}:15897: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/bridge/br_fdb.o] Error 1
   {standard input}:47787: Error: unknown opcode
   {standard input}:48665: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/ipv4/ip_options.o] Error 1
   {standard input}:49563: Error: unknown opcode
   {standard input}:49639: Error: unknown opcode
   net/ipv6/addrconf.c:6944:38: sparse: sparse: incorrect type in argument 3 (incompatible argument 3 (different address spaces)) @@     expected int ( [usertype] *proc_handler )( ... ) @@     got int ( * )( ... ) @@
   net/ipv6/addrconf.c:6944:38: sparse:     expected int ( [usertype] *proc_handler )( ... )
   net/ipv6/addrconf.c:6944:38: sparse:     got int ( * )( ... )
   make[3]: *** [scripts/Makefile.build:281: net/appletalk/ddp.o] Error 1
   drivers/tty/serial/sifive.c:157: warning: cannot understand function prototype: 'struct sifive_serial_port '
   {standard input}: Assembler messages:
   {standard input}:2000: Error: unknown opcode
   {standard input}:2139: Error: unknown opcode
   {standard input}:2186: Error: unknown opcode
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:497: drivers/tty/serial] Error 2
   {standard input}: Assembler messages:
   {standard input}:1176: Error: unknown opcode
   {standard input}:1207: Error: unknown opcode
   {standard input}:3244: Error: unknown opcode
   {standard input}:4093: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:280: drivers/dma-buf/sw_sync.o] Error 1
   make[2]: *** [scripts/Makefile.build:497: drivers/dma-buf] Error 2
   make[3]: Target '__build' not remade because of errors.
   {standard input}:5115: Error: unknown opcode
   {standard input}:5303: Error: unknown opcode
   {standard input}:6264: Error: unknown opcode
   drivers/tty/sysrq.c:1112:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buf @@
   drivers/tty/sysrq.c:1112:21: sparse:     expected char const *__gu_addr
   drivers/tty/sysrq.c:1112:21: sparse:     got char const [noderef] __user *buf
   drivers/tty/sysrq.c:1112:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
   drivers/tty/sysrq.c:1112:21: sparse:     expected void const volatile [noderef] __user *
   drivers/tty/sysrq.c:1112:21: sparse:     got char const *__gu_addr
   drivers/tty/sysrq.c:148:13: sparse: sparse: context imbalance in 'sysrq_handle_crash' - unexpected unlock
   {standard input}: Assembler messages:
   {standard input}:1765: Error: unknown opcode
   {standard input}:1904: Error: unknown opcode
   {standard input}:1951: Error: unknown opcode
   make[3]: Target '__build' not remade because of errors.
   make[2]: *** [scripts/Makefile.build:497: drivers/misc] Error 2
   {standard input}: Assembler messages:
   {standard input}:2813: Error: unknown opcode
   {standard input}:4294: Error: unknown opcode
   {standard input}:4937: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:1441: Error: unknown opcode
   {standard input}:58795: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:280: drivers/base/dd.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:267: Error: unknown opcode
   {standard input}:314: Error: unknown opcode
   {standard input}:1655: Error: unknown opcode
   {standard input}:3214: Error: unknown opcode
   {standard input}:3412: Error: unknown opcode
   net/ipv4/inet_connection_sock.c:181:36: sparse: sparse: context imbalance in 'inet_csk_find_open_port' - wrong count at exit
   net/ipv4/inet_connection_sock.c:348:24: sparse: sparse: context imbalance in 'inet_csk_get_port' - different lock contexts for basic block
   net/ipv4/inet_connection_sock.c:1000:9: sparse: sparse: context imbalance in 'inet_csk_complete_hashdance' - unexpected unlock
   {standard input}:7929: Error: unknown opcode
   {standard input}:2893: Error: unknown opcode
   {standard input}:4277: Error: unknown opcode
   {standard input}:4308: Error: unknown opcode
   {standard input}:6070: Error: unknown opcode
   {standard input}:6159: Error: unknown opcode
   {standard input}:9662: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/ipv6/ip6_input.o] Error 1
   drivers/base/platform.c:1352:20: warning: no previous prototype for 'early_platform_cleanup' [-Wmissing-prototypes]
    1352 | void __weak __init early_platform_cleanup(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~
   {standard input}:6875: Error: unknown opcode
   {standard input}:10789: Error: unknown opcode
   {standard input}:10861: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/ipv4/ip_sockglue.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:3561: Error: unknown opcode
--
   net/ax25/af_ax25.c:695:13: sparse:     expected void const volatile [noderef] __user *
   net/ax25/af_ax25.c:695:13: sparse:     got int const *__gu_addr
   net/ax25/af_ax25.c:1736:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long const *__gu_addr @@     got long [noderef] __user * @@
   net/ax25/af_ax25.c:1736:21: sparse:     expected long const *__gu_addr
   net/ax25/af_ax25.c:1736:21: sparse:     got long [noderef] __user *
   net/ax25/af_ax25.c:1736:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got long const *__gu_addr @@
   net/ax25/af_ax25.c:1736:21: sparse:     expected void const volatile [noderef] __user *
   net/ax25/af_ax25.c:1736:21: sparse:     got long const *__gu_addr
   {standard input}:5040: Error: unknown opcode
   {standard input}:5088: Error: unknown opcode
   {standard input}:3287: Error: unknown opcode
   {standard input}:6781: Error: unknown opcode
   {standard input}:6827: Error: unknown opcode
   net/phonet/pep.c:986:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/phonet/pep.c:986:21: sparse:     expected int const *__gu_addr
   net/phonet/pep.c:986:21: sparse:     got int [noderef] __user *
   net/phonet/pep.c:986:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/phonet/pep.c:986:21: sparse:     expected void const volatile [noderef] __user *
   net/phonet/pep.c:986:21: sparse:     got int const *__gu_addr
   net/phonet/pep.c:1047:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/phonet/pep.c:1047:13: sparse:     expected int const *__gu_addr
   net/phonet/pep.c:1047:13: sparse:     got int [noderef] __user *optlen
   net/phonet/pep.c:1047:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/phonet/pep.c:1047:13: sparse:     expected void const volatile [noderef] __user *
   net/phonet/pep.c:1047:13: sparse:     got int const *__gu_addr
   make[3]: *** [scripts/Makefile.build:281: net/ipv4/raw.o] Error 1
   make[3]: *** [scripts/Makefile.build:281: drivers/spi/spi.o] Error 1
   {standard input}:5219: Error: unknown opcode
   {standard input}:5282: Error: unknown opcode
   {standard input}:6306: Error: unknown opcode
   drivers/mtd/devices/phram.c:19: warning: Function parameter or member 'fmt' not described in 'pr_fmt'
   make[5]: *** [scripts/Makefile.build:280: drivers/mtd/nand/onenand/onenand_base.o] Error 1
   make[5]: Target '__build' not remade because of errors.
   make[4]: *** [scripts/Makefile.build:497: drivers/mtd/nand/onenand] Error 2
   {standard input}:10001: Error: unknown opcode
   {standard input}:10258: Error: unknown opcode
   {standard input}:10390: Error: unknown opcode
   {standard input}:10540: Error: unknown opcode
   {standard input}:10770: Error: unknown opcode
   {standard input}:11490: Error: unknown opcode
   {standard input}:11559: Error: unknown opcode
   {standard input}:11759: Error: unknown opcode
   {standard input}:11790: Error: unknown opcode
   {standard input}:11885: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/bluetooth/hci_sock.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:350: Error: unknown opcode
   {standard input}:585: Error: unknown opcode
   {standard input}:706: Error: unknown opcode
   drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'dev' not described in 'devm_mfd_add_devices'
   drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'id' not described in 'devm_mfd_add_devices'
   drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'cells' not described in 'devm_mfd_add_devices'
   drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'n_devs' not described in 'devm_mfd_add_devices'
   drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'mem_base' not described in 'devm_mfd_add_devices'
   drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'irq_base' not described in 'devm_mfd_add_devices'
   drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'domain' not described in 'devm_mfd_add_devices'
   {standard input}: Assembler messages:
   {standard input}:759: Error: unknown opcode
   drivers/mtd/chips/map_ram.c:93:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/mtd/chips/map_ram.c:93:15: sparse:     expected void *
   drivers/mtd/chips/map_ram.c:93:15: sparse:     got void [noderef] __iomem *
   make[4]: *** [scripts/Makefile.build:281: drivers/mtd/chips/gen_probe.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:75: Error: unknown opcode
   {standard input}:1766: Error: unknown opcode
   {standard input}:1814: Error: unknown opcode
   {standard input}:12106: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:1155: Error: unknown opcode
   {standard input}:2560: Error: unknown opcode
   {standard input}:2592: Error: unknown opcode
   {standard input}:2699: Error: unknown opcode
   {standard input}:3078: Error: unknown opcode
   {standard input}:3109: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/phonet/af_phonet.o] Error 1
   {standard input}:7351: Error: unknown opcode
   {standard input}:7382: Error: unknown opcode
   {standard input}:7764: Error: unknown opcode
   {standard input}:8187: Error: unknown opcode
   {standard input}:8273: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:8496: Error: unknown opcode
   {standard input}:8587: Error: unknown opcode
   {standard input}:8635: Error: unknown opcode
   {standard input}:8980: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:807: Error: unknown opcode
   {standard input}:988: Error: unknown opcode
   {standard input}:4646: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/mtd/devices/block2mtd.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:466: Error: unknown opcode
   {standard input}:497: Error: unknown opcode
   {standard input}:709: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:280: net/ax25/ax25_uid.o] Error 1
   {standard input}:12301: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/wireless/util.o] Error 1
   drivers/spi/spidev.c:396:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:396:34: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:396:34: sparse:     got unsigned char [noderef] [usertype] __user *
>> drivers/spi/spidev.c:396:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
>> drivers/spi/spidev.c:396:34: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:396:34: sparse:     got unsigned char const *__gu_addr
   drivers/spi/spidev.c:398:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:398:34: sparse:     expected unsigned int const *__gu_addr
   drivers/spi/spidev.c:398:34: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/spi/spidev.c:398:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/spi/spidev.c:398:34: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:398:34: sparse:     got unsigned int const *__gu_addr
   drivers/spi/spidev.c:422:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:422:26: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:422:26: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/spi/spidev.c:422:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
   drivers/spi/spidev.c:422:26: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:422:26: sparse:     got unsigned char const *__gu_addr
   drivers/spi/spidev.c:439:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:439:26: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:439:26: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/spi/spidev.c:439:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
   drivers/spi/spidev.c:439:26: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:439:26: sparse:     got unsigned char const *__gu_addr
   drivers/spi/spidev.c:452:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:452:26: sparse:     expected unsigned int const *__gu_addr
   drivers/spi/spidev.c:452:26: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/spi/spidev.c:452:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/spi/spidev.c:452:26: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:452:26: sparse:     got unsigned int const *__gu_addr
   {standard input}: Assembler messages:
   {standard input}:874: Error: unknown opcode
   {standard input}:1901: Error: unknown opcode
   {standard input}:2245: Error: unknown opcode
   {standard input}:2276: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/phonet/pep-gprs.o] Error 1
   drivers/mtd/nand/spi/toshiba.c:36: warning: Function parameter or member 'write_cache_variants' not described in 'SPINAND_OP_VARIANTS'
   drivers/mtd/nand/spi/toshiba.c:36: warning: Function parameter or member '0' not described in 'SPINAND_OP_VARIANTS'
   {standard input}:12600: Error: unknown opcode
   {standard input}:13131: Error: unknown opcode
   {standard input}:15828: Error: unknown opcode
   {standard input}:33000: Error: unknown opcode
   {standard input}:33215: Error: unknown opcode
   {standard input}:33246: Error: unknown opcode
   {standard input}:34197: Error: unknown opcode
   {standard input}:34568: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:3526: Error: unknown opcode
   {standard input}:3557: Error: unknown opcode
   {standard input}:3859: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:940: Error: unknown opcode
   {standard input}:1506: Error: unknown opcode
   {standard input}:1737: Error: unknown opcode
   {standard input}:2647: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: drivers/target/target_core_tmr.o] Error 1
   {standard input}:20117: Error: unknown opcode
   {standard input}:20167: Error: unknown opcode
   {standard input}:20855: Error: unknown opcode
   {standard input}:21030: Error: unknown opcode
   {standard input}:36297: Error: unknown opcode
   {standard input}:4490: Error: unknown opcode
   drivers/mtd/chips/map_rom.c:79:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/mtd/chips/map_rom.c:79:15: sparse:     expected void *
   drivers/mtd/chips/map_rom.c:79:15: sparse:     got void [noderef] __iomem *
   {standard input}:14370: Error: unknown opcode
   {standard input}:15608: Error: unknown opcode
   {standard input}:18286: Error: unknown opcode
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:497: drivers/mtd/devices] Error 2
   net/ipv4/udp_offload.c:135:60: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __wsum [usertype] res @@     got fouled restricted __sum16 @@
   net/ipv4/udp_offload.c:135:60: sparse:     expected restricted __wsum [usertype] res
   net/ipv4/udp_offload.c:135:60: sparse:     got fouled restricted __sum16
   net/ipv4/udp_offload.c:167:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct net_offload const **offloads @@     got struct net_offload const [noderef] __rcu ** @@
   net/ipv4/udp_offload.c:167:26: sparse:     expected struct net_offload const **offloads
   net/ipv4/udp_offload.c:167:26: sparse:     got struct net_offload const [noderef] __rcu **
   net/ipv4/udp_offload.c:168:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/ipv4/udp_offload.c:168:23: sparse:    struct net_offload const [noderef] __rcu *
   net/ipv4/udp_offload.c:168:23: sparse:    struct net_offload const *
   net/ipv4/udp_offload.c:267:49: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __wsum [usertype] res @@     got fouled restricted __sum16 @@
   net/ipv4/udp_offload.c:267:49: sparse:     expected restricted __wsum [usertype] res
   net/ipv4/udp_offload.c:267:49: sparse:     got fouled restricted __sum16
   net/ipv4/udp_offload.c:269:60: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __wsum [usertype] res @@     got fouled restricted __sum16 @@
   net/ipv4/udp_offload.c:269:60: sparse:     expected restricted __wsum [usertype] res
   net/ipv4/udp_offload.c:269:60: sparse:     got fouled restricted __sum16
   net/ipv4/udp_offload.c:285:41: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __wsum [usertype] res @@     got fouled restricted __sum16 @@
   net/ipv4/udp_offload.c:285:41: sparse:     expected restricted __wsum [usertype] res
   net/ipv4/udp_offload.c:285:41: sparse:     got fouled restricted __sum16
   net/ipv4/udp_offload.c:287:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __wsum [usertype] res @@     got fouled restricted __sum16 @@
   net/ipv4/udp_offload.c:287:52: sparse:     expected restricted __wsum [usertype] res
   net/ipv4/udp_offload.c:287:52: sparse:     got fouled restricted __sum16
   {standard input}:22451: Error: unknown opcode
   {standard input}:23124: Error: unknown opcode
   {standard input}:25063: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/ipv6/udp.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:45: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/bluetooth/hci_event.o] Error 1
   {standard input}:11858: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:280: net/ax25/af_ax25.o] Error 1
   {standard input}:3142: Error: unknown opcode
   {standard input}:3173: Error: unknown opcode
   {standard input}:3327: Error: unknown opcode
   {standard input}:3681: Error: unknown opcode
   {standard input}:4932: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:2186: Error: unknown opcode
   {standard input}:2660: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: drivers/spi/spidev.o] Error 1
   include/linux/bottom_half.h:32:30: sparse: sparse: context imbalance in 'icmp_reply' - different lock contexts for basic block
--
   drivers/input/joystick/analog.c:179:24: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:179:24: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:179:24: sparse: sparse: not a function <noident>
   drivers/input/serio/serio_raw.c:219:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/input/serio/serio_raw.c:219:21: sparse:     expected char const *__gu_addr
   drivers/input/serio/serio_raw.c:219:21: sparse:     got char const [noderef] __user *
   drivers/input/serio/serio_raw.c:219:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
   drivers/input/serio/serio_raw.c:219:21: sparse:     expected void const volatile [noderef] __user *
   drivers/input/serio/serio_raw.c:219:21: sparse:     got char const *__gu_addr
   {standard input}: Assembler messages:
   {standard input}:73: Error: unknown opcode
   {standard input}:136: Error: unknown opcode
   drivers/input/joystick/analog.c:160:2: warning: #warning Precise timer not defined for this architecture. [-Wcpp]
     160 | #warning Precise timer not defined for this architecture.
         |  ^~~~~~~
   net/wireless/wext-compat.c:229: warning: Excess function parameter 'dev' description in 'cfg80211_wext_freq'
   {standard input}: Assembler messages:
   {standard input}:5244: Error: unknown opcode
   {standard input}:5575: Error: unknown opcode
   {standard input}:5630: Error: unknown opcode
   {standard input}:2270: Error: unknown opcode
   {standard input}:4319: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:280: drivers/input/keyboard/atkbd.o] Error 1
   drivers/input/rmi4/rmi_f01.c:106: warning: Cannot understand  * @ctrl0 - see the bit definitions above.
    on line 106 - I thought it was a doc line
   {standard input}: Assembler messages:
   {standard input}:1293: Error: unknown opcode
   {standard input}:1324: Error: unknown opcode
   {standard input}:2714: Error: unknown opcode
   {standard input}:3449: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:280: drivers/input/serio/serio_raw.o] Error 1
   drivers/input/misc/drv260x.c: In function 'drv260x_probe':
   drivers/input/misc/drv260x.c:478:20: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
     478 |  if (haptics->mode < DRV260X_LRA_MODE ||
         |                    ^
   drivers/input/misc/drv260x.c:490:23: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
     490 |  if (haptics->library < DRV260X_LIB_EMPTY ||
         |                       ^
   {standard input}:9002: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:60: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:280: drivers/input/joystick/analog.o] Error 1
   drivers/mfd/tps6586x.c:323:16: sparse: sparse: cast to restricted __le32
   {standard input}:12235: Error: unknown opcode
   {standard input}:12483: Error: unknown opcode
   {standard input}:12527: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/sunrpc/svcsock.o] Error 1
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'input_dev' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'client' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'regmap' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'work' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'enable_gpio' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'regulator' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'magnitude' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'mode' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'library' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'rated_voltage' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'overdrive_voltage' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:244: warning: Function parameter or member 'voltage' not described in 'drv260x_calculate_voltage'
   {standard input}: Assembler messages:
   {standard input}:2063: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:280: drivers/input/joystick/grip.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:1011: Error: unknown opcode
   {standard input}:1042: Error: unknown opcode
   {standard input}:1237: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/batman-adv/main.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:1743: Error: unknown opcode
   {standard input}:1931: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:2523: Error: unknown opcode
   {standard input}:2554: Error: unknown opcode
   {standard input}:2712: Error: unknown opcode
   {standard input}:2894: Error: unknown opcode
   {standard input}:3285: Error: unknown opcode
   {standard input}:3421: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/gpu/drm/drm_prime.o] Error 1
   drivers/input/misc/drv2665.c:59: warning: Function parameter or member 'input_dev' not described in 'drv2665_data'
   drivers/input/misc/drv2665.c:59: warning: Function parameter or member 'client' not described in 'drv2665_data'
   drivers/input/misc/drv2665.c:59: warning: Function parameter or member 'regmap' not described in 'drv2665_data'
   drivers/input/misc/drv2665.c:59: warning: Function parameter or member 'work' not described in 'drv2665_data'
   drivers/input/misc/drv2665.c:59: warning: Function parameter or member 'regulator' not described in 'drv2665_data'
   {standard input}:4519: Error: unknown opcode
   {standard input}:4905: Error: unknown opcode
   {standard input}:6574: Error: unknown opcode
   {standard input}:6659: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:280: net/sunrpc/svcauth_unix.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:251: Error: unknown opcode
   {standard input}:1121: Error: unknown opcode
   {standard input}:1290: Error: unknown opcode
   {standard input}:1707: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/sunrpc/svcauth.o] Error 1
>> drivers/net/hamradio/6pack.c:710:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/hamradio/6pack.c:710:21: sparse:     expected int const *__gu_addr
>> drivers/net/hamradio/6pack.c:710:21: sparse:     got int [noderef] __user *
>> drivers/net/hamradio/6pack.c:710:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> drivers/net/hamradio/6pack.c:710:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/hamradio/6pack.c:710:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_async.c:420:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_async.c:420:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_async.c:420:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_async.c:420:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_async.c:420:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_async.c:420:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_async.c:435:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/net/ppp/ppp_async.c:435:21: sparse:     expected unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:435:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/net/ppp/ppp_async.c:435:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/net/ppp/ppp_async.c:435:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_async.c:435:21: sparse:     got unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:446:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/net/ppp/ppp_async.c:446:21: sparse:     expected unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:446:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/net/ppp/ppp_async.c:446:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/net/ppp/ppp_async.c:446:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_async.c:446:21: sparse:     got unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:471:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_async.c:471:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_async.c:471:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_async.c:471:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_async.c:471:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_async.c:471:21: sparse:     got int const *__gu_addr
   {standard input}: Assembler messages:
   {standard input}:195: Error: unknown opcode
   {standard input}:1586: Error: unknown opcode
   {standard input}:1617: Error: unknown opcode
   {standard input}:1741: Error: unknown opcode
   {standard input}:1800: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:633: Error: unknown opcode
   {standard input}:667: Error: unknown opcode
   drivers/net/ppp/ppp_generic.c:925:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:925:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:954:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:954:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:651:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:651:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:681:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:681:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:688:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:688:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:726:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:726:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:755:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:755:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:823:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:823:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     got int const *__gu_addr
   {standard input}:2331: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:182: Error: unknown opcode
   {standard input}:2055: Error: unknown opcode
   {standard input}:2104: Error: unknown opcode
   {standard input}:2124: Error: unknown opcode
   {standard input}:2522: Error: unknown opcode
   {standard input}:3777: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:280: net/sunrpc/rpcb_clnt.o] Error 1
   {standard input}:5433: Error: unknown opcode
   {standard input}:5499: Error: unknown opcode
   {standard input}:7784: Error: unknown opcode
--
   make[3]: *** [scripts/Makefile.build:497: drivers/net/ppp] Error 2
   drivers/mfd/lm3533-ctrlbank.c: In function 'lm3533_ctrlbank_set_brightness':
   drivers/mfd/lm3533-ctrlbank.c:98:10: warning: comparison is always false due to limited range of data type [-Wtype-limits]
      98 |  if (val > LM3533_##_NAME##_MAX)     5905-      |          ^
   drivers/mfd/lm3533-ctrlbank.c:125:1: note: in expansion of macro 'lm3533_ctrlbank_set'
     125 | lm3533_ctrlbank_set(brightness, BRIGHTNESS);
         | ^~~~~~~~~~~~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:688: Error: unknown opcode
   {standard input}:735: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/wireless/wext-spy.o] Error 1
   make[3]: *** [scripts/Makefile.build:281: net/batman-adv/originator.o] Error 1
   include/linux/unaligned/be_byteshift.h:26:16: sparse: sparse: cast truncates bits from constant value (1000 becomes 0)
   {standard input}: Assembler messages:
   {standard input}:427: Error: unknown opcode
   {standard input}:631: Error: unknown opcode
   {standard input}:662: Error: unknown opcode
   {standard input}:888: Error: unknown opcode
   {standard input}:1334: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:828: Error: unknown opcode
   {standard input}:924: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: drivers/input/sparse-keymap.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:489: Error: unknown opcode
   drivers/i2c/busses/i2c-rk3x.c:244: warning: Function parameter or member 'i2c' not described in 'rk3x_i2c_start'
   drivers/i2c/busses/i2c-rk3x.c:265: warning: Function parameter or member 'i2c' not described in 'rk3x_i2c_stop'
   drivers/i2c/busses/i2c-rk3x.c:303: warning: Function parameter or member 'i2c' not described in 'rk3x_i2c_prepare_read'
   drivers/i2c/busses/i2c-rk3x.c:334: warning: Function parameter or member 'i2c' not described in 'rk3x_i2c_fill_transmit_buf'
   drivers/i2c/busses/i2c-rk3x.c:972: warning: Function parameter or member 'i2c' not described in 'rk3x_i2c_setup'
   make[4]: *** [scripts/Makefile.build:281: drivers/input/joystick/twidjoy.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:460: Error: unknown opcode
   {standard input}:2838: Error: unknown opcode
   {standard input}:4044: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/input/joystick/spaceorb.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:1334: Error: unknown opcode
   {standard input}:1437: Error: unknown opcode
   {standard input}:1769: Error: unknown opcode
   {standard input}:1839: Error: unknown opcode
   {standard input}:5148: Error: unknown opcode
   {standard input}:6423: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: drivers/i2c/i2c-core-of.o] Error 1
   {standard input}:6974: Error: unknown opcode
   {standard input}:7411: Error: unknown opcode
   {standard input}:9262: Error: unknown opcode
   {standard input}:9859: Error: unknown opcode
   drivers/input/mousedev.c:683:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/input/mousedev.c:683:21: sparse:     expected char const *__gu_addr
   drivers/input/mousedev.c:683:21: sparse:     got char const [noderef] __user *
   drivers/input/mousedev.c:683:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
   drivers/input/mousedev.c:683:21: sparse:     expected void const volatile [noderef] __user *
   drivers/input/mousedev.c:683:21: sparse:     got char const *__gu_addr
   make[3]: *** [scripts/Makefile.build:281: net/batman-adv/tp_meter.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:489: Error: unknown opcode
   {standard input}:520: Error: unknown opcode
   {standard input}:945: Error: unknown opcode
   {standard input}:2544: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/gpu/drm/drm_mode_object.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:6331: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: drivers/i2c/i2c-core-smbus.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:8660: Error: unknown opcode
   {standard input}:8879: Error: unknown opcode
   {standard input}:9080: Error: unknown opcode
   {standard input}:11045: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:1227: Error: unknown opcode
   {standard input}:1263: Error: unknown opcode
   {standard input}:1433: Error: unknown opcode
   {standard input}:2014: Error: unknown opcode
   {standard input}:2049: Error: unknown opcode
   {standard input}:2256: Error: unknown opcode
   {standard input}:2305: Error: unknown opcode
   {standard input}:3016: Error: unknown opcode
   {standard input}:3249: Error: unknown opcode
   {standard input}:3280: Error: unknown opcode
   {standard input}:3922: Error: unknown opcode
   {standard input}:4045: Error: unknown opcode
   {standard input}:4160: Error: unknown opcode
   {standard input}:4384: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/sunrpc/xprtmultipath.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:656: Error: unknown opcode
   {standard input}:701: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/input/keyboard/newtonkbd.o] Error 1
   make[3]: *** [scripts/Makefile.build:281: drivers/i2c/i2c-core-base.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:4684: Error: unknown opcode
   drivers/net/slip/slip.c:458:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:458:14: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:458:14: sparse:    void *
   drivers/net/slip/slip.c:892:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:892:9: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:892:9: sparse:    void *
   drivers/net/slip/slip.c:1099:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
>> drivers/net/slip/slip.c:1099:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/slip/slip.c:1124:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/slip/slip.c:1124:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/slip/slip.c:1150:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/slip/slip.c:1150:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   {standard input}: Assembler messages:
   {standard input}:345: Error: unknown opcode
   {standard input}:376: Error: unknown opcode
   {standard input}:746: Error: unknown opcode
   {standard input}:1215: Error: unknown opcode
   {standard input}:3366: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:497: drivers/media/i2c] Error 2
   make[4]: *** [scripts/Makefile.build:281: drivers/media/i2c/ir-kbd-i2c.o] Error 1
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:281: net/batman-adv/tvlv.o] Error 1
   make[3]: *** [scripts/Makefile.build:497: drivers/input/joystick] Error 2
   make[4]: Target '__build' not remade because of errors.
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   {standard input}: Assembler messages:
   {standard input}:50: Error: unknown opcode
   {standard input}:113: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:60: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:1038: Error: unknown opcode
   {standard input}:1546: Error: unknown opcode
   {standard input}:1696: Error: unknown opcode
   {standard input}:1890: Error: unknown opcode
   {standard input}:2760: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:280: drivers/input/misc/uinput.o] Error 1
   make[3]: *** [scripts/Makefile.build:497: drivers/input/misc] Error 2
   make[4]: Target '__build' not remade because of errors.
   make[4]: *** [scripts/Makefile.build:280: drivers/net/hamradio/hdlcdrv.o] Error 1
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:497: drivers/net/hamradio] Error 2
   {standard input}:4163: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:280: drivers/input/mousedev.o] Error 1
   drivers/w1/slaves/w1_therm.c:875:18: sparse: sparse: cast to restricted __le64
   make[3]: Target '__build' not remade because of errors.
   make[2]: *** [scripts/Makefile.build:497: net/wireless] Error 2
   {standard input}: Assembler messages:
   {standard input}:62: Error: unknown opcode
   {standard input}:1378: Error: unknown opcode
   {standard input}:1551: Error: unknown opcode
   drivers/w1/masters/ds2482.c:23: warning: Incorrect use of kernel-doc format:  * Allow the active pullup to be disabled, default is enabled.
   drivers/w1/masters/ds2482.c:32: warning: cannot understand function prototype: 'int ds2482_active_pullup = 1; '
   drivers/w1/masters/ds2482.c:82: warning: cannot understand function prototype: 'const u8 ds2482_chan_wr[8] =         '
   drivers/w1/masters/ds2482.c:132: warning: Function parameter or member 'conf' not described in 'ds2482_calculate_config'
   make[4]: *** [scripts/Makefile.build:281: drivers/media/mc/mc-devnode.o] Error 1
   drivers/w1/masters/ds2482.c:149: warning: Function parameter or member 'pdev' not described in 'ds2482_select_register'
   drivers/w1/masters/ds2482.c:149: warning: Function parameter or member 'read_ptr' not described in 'ds2482_select_register'
   drivers/w1/masters/ds2482.c:170: warning: Function parameter or member 'pdev' not described in 'ds2482_send_cmd'
   drivers/w1/masters/ds2482.c:170: warning: Function parameter or member 'cmd' not described in 'ds2482_send_cmd'
   drivers/w1/masters/ds2482.c:190: warning: Function parameter or member 'pdev' not described in 'ds2482_send_cmd_data'
   drivers/w1/masters/ds2482.c:190: warning: Function parameter or member 'cmd' not described in 'ds2482_send_cmd_data'
   drivers/w1/masters/ds2482.c:190: warning: Function parameter or member 'byte' not described in 'ds2482_send_cmd_data'
   drivers/w1/masters/ds2482.c:214: warning: Function parameter or member 'pdev' not described in 'ds2482_wait_1wire_idle'
   drivers/w1/masters/ds2482.c:241: warning: Function parameter or member 'pdev' not described in 'ds2482_set_channel'
   drivers/w1/masters/ds2482.c:241: warning: Function parameter or member 'channel' not described in 'ds2482_set_channel'
   drivers/w1/masters/ds2482.c:264: warning: Function parameter or member 'data' not described in 'ds2482_w1_touch_bit'
   drivers/w1/masters/ds2482.c:264: warning: Function parameter or member 'bit' not described in 'ds2482_w1_touch_bit'
   drivers/w1/masters/ds2482.c:296: warning: Function parameter or member 'data' not described in 'ds2482_w1_triplet'
   drivers/w1/masters/ds2482.c:296: warning: Function parameter or member 'dbit' not described in 'ds2482_w1_triplet'
   drivers/w1/masters/ds2482.c:326: warning: Function parameter or member 'data' not described in 'ds2482_w1_write_byte'
   drivers/w1/masters/ds2482.c:326: warning: Function parameter or member 'byte' not described in 'ds2482_w1_write_byte'
   drivers/w1/masters/ds2482.c:350: warning: Function parameter or member 'data' not described in 'ds2482_w1_read_byte'
   drivers/w1/masters/ds2482.c:387: warning: Function parameter or member 'data' not described in 'ds2482_w1_reset_bus'
   drivers/w1/masters/ds2482.c:547: warning: cannot understand function prototype: 'const struct i2c_device_id ds2482_id[] = '
   drivers/w1/slaves/w1_therm.c: In function 'w1_seq_show':
   drivers/w1/slaves/w1_therm.c:1709:6: warning: variable 'rv' set but not used [-Wunused-but-set-variable]
    1709 |  int rv;
         |      ^~
   drivers/w1/w1.c:426:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] rn64_le @@     got restricted __le64 [usertype] @@
   drivers/w1/w1.c:426:17: sparse:     expected unsigned long long [usertype] rn64_le
   drivers/w1/w1.c:426:17: sparse:     got restricted __le64 [usertype]
   drivers/w1/w1.c:920:21: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long long [usertype] rn_le @@     got restricted __le64 [usertype] @@
   drivers/w1/w1.c:920:21: sparse:     expected unsigned long long [usertype] rn_le
   drivers/w1/w1.c:920:21: sparse:     got restricted __le64 [usertype]
   {standard input}: Assembler messages:
   {standard input}:2301: Error: unknown opcode
   {standard input}:2789: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:146: Error: unknown opcode
   {standard input}:259: Error: unknown opcode
   make[5]: *** [scripts/Makefile.build:281: drivers/media/cec/core/cec-core.o] Error 1
   drivers/input/keyboard/samsung-keypad.c: In function 'samsung_keypad_irq':
   drivers/input/keyboard/samsung-keypad.c:149:15: warning: variable 'val' set but not used [-Wunused-but-set-variable]
--
         |                                                              ^
   include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/bbt.c:90:18: note: in expansion of macro 'GENMASK'
      90 |  return status & GENMASK(bits_per_block - 1, 0);
         |                  ^~~~~~~
   include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
      26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
         |                                        ^
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/bbt.c:90:18: note: in expansion of macro 'GENMASK'
      90 |  return status & GENMASK(bits_per_block - 1, 0);
         |                  ^~~~~~~
   drivers/mtd/nand/bbt.c: In function 'nanddev_bbt_set_block_status':
   include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
      26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
         |                            ^
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/bbt.c:114:31: note: in expansion of macro 'GENMASK'
     114 |  unsigned long val = status & GENMASK(bits_per_block - 1, 0);
         |                               ^~~~~~~
   include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
      26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
         |                                        ^
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/bbt.c:114:31: note: in expansion of macro 'GENMASK'
     114 |  unsigned long val = status & GENMASK(bits_per_block - 1, 0);
         |                               ^~~~~~~
   include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
      26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
         |                            ^
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/bbt.c:125:14: note: in expansion of macro 'GENMASK'
     125 |   pos[1] &= ~GENMASK(rbits - 1, 0);
         |              ^~~~~~~
   include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
      26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
         |                                        ^
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/bbt.c:125:14: note: in expansion of macro 'GENMASK'
     125 |   pos[1] &= ~GENMASK(rbits - 1, 0);
         |              ^~~~~~~
   {standard input}:22723: Error: unknown opcode
   {standard input}:23563: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/mtd/chips/cfi_cmdset_0001.o] Error 1
   {standard input}:25098: Error: unknown opcode
   {standard input}:25198: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:7022: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: drivers/spi/spi.o] Error 1
   drivers/mtd/devices/phram.c:19: warning: Function parameter or member 'fmt' not described in 'pr_fmt'
   make[5]: *** [scripts/Makefile.build:280: drivers/mtd/nand/onenand/onenand_base.o] Error 1
   make[5]: Target '__build' not remade because of errors.
   make[4]: *** [scripts/Makefile.build:497: drivers/mtd/nand/onenand] Error 2
   drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'dev' not described in 'devm_mfd_add_devices'
   drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'id' not described in 'devm_mfd_add_devices'
   drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'cells' not described in 'devm_mfd_add_devices'
   drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'n_devs' not described in 'devm_mfd_add_devices'
   drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'mem_base' not described in 'devm_mfd_add_devices'
   drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'irq_base' not described in 'devm_mfd_add_devices'
   drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'domain' not described in 'devm_mfd_add_devices'
   {standard input}: Assembler messages:
   {standard input}:759: Error: unknown opcode
   drivers/mtd/chips/map_ram.c:93:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/mtd/chips/map_ram.c:93:15: sparse:     expected void *
   drivers/mtd/chips/map_ram.c:93:15: sparse:     got void [noderef] __iomem *
   make[4]: *** [scripts/Makefile.build:281: drivers/mtd/chips/gen_probe.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:807: Error: unknown opcode
   {standard input}:988: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/mtd/devices/block2mtd.o] Error 1
   drivers/spi/spidev.c:396:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:396:34: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:396:34: sparse:     got unsigned char [noderef] [usertype] __user *
>> drivers/spi/spidev.c:396:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
>> drivers/spi/spidev.c:396:34: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:396:34: sparse:     got unsigned char const *__gu_addr
   drivers/spi/spidev.c:398:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:398:34: sparse:     expected unsigned int const *__gu_addr
   drivers/spi/spidev.c:398:34: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/spi/spidev.c:398:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/spi/spidev.c:398:34: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:398:34: sparse:     got unsigned int const *__gu_addr
   drivers/spi/spidev.c:422:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:422:26: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:422:26: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/spi/spidev.c:422:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
   drivers/spi/spidev.c:422:26: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:422:26: sparse:     got unsigned char const *__gu_addr
   drivers/spi/spidev.c:439:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:439:26: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:439:26: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/spi/spidev.c:439:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
   drivers/spi/spidev.c:439:26: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:439:26: sparse:     got unsigned char const *__gu_addr
   drivers/spi/spidev.c:452:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:452:26: sparse:     expected unsigned int const *__gu_addr
   drivers/spi/spidev.c:452:26: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/spi/spidev.c:452:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/spi/spidev.c:452:26: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:452:26: sparse:     got unsigned int const *__gu_addr
   drivers/mtd/nand/spi/toshiba.c:36: warning: Function parameter or member 'write_cache_variants' not described in 'SPINAND_OP_VARIANTS'
   drivers/mtd/nand/spi/toshiba.c:36: warning: Function parameter or member '0' not described in 'SPINAND_OP_VARIANTS'
   {standard input}: Assembler messages:
   {standard input}:940: Error: unknown opcode
   {standard input}:1506: Error: unknown opcode
   {standard input}:1737: Error: unknown opcode
   {standard input}:2647: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: drivers/target/target_core_tmr.o] Error 1
   drivers/mtd/chips/map_rom.c:79:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/mtd/chips/map_rom.c:79:15: sparse:     expected void *
   drivers/mtd/chips/map_rom.c:79:15: sparse:     got void [noderef] __iomem *
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:497: drivers/mtd/devices] Error 2
   {standard input}: Assembler messages:
   {standard input}:2186: Error: unknown opcode
   {standard input}:2660: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: drivers/spi/spidev.o] Error 1
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:497: drivers/mtd/chips] Error 2
   {standard input}: Assembler messages:
   {standard input}:3961: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:497: drivers/mtd/nand] Error 2
   make[4]: Target '__build' not remade because of errors.
   {standard input}:7182: Error: unknown opcode
   {standard input}:7213: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:280: drivers/scsi/scsi_scan.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:2252: Error: unknown opcode
   {standard input}:2503: Error: unknown opcode
   {standard input}:2534: Error: unknown opcode
   {standard input}:2933: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:3819: Error: unknown opcode
   {standard input}:4738: Error: unknown opcode
   {standard input}:4874: Error: unknown opcode
   {standard input}:7458: Error: unknown opcode
   {standard input}:7492: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/target/iscsi/iscsi_target_nego.o] Error 1
   {standard input}:4297: Error: unknown opcode
   {standard input}:6837: Error: unknown opcode
   {standard input}:7771: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:280: drivers/target/iscsi/iscsi_target_login.o] Error 1
   drivers/spi/spi-bitbang.c:181: warning: Function parameter or member 'spi' not described in 'spi_bitbang_setup'
   drivers/spi/spi-bitbang.c:215: warning: Function parameter or member 'spi' not described in 'spi_bitbang_cleanup'
   drivers/spi/spi-bitbang.c:434: warning: Function parameter or member 'bitbang' not described in 'spi_bitbang_stop'
   drivers/mtd/ubi/cdev.c:467:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:467:23: sparse:     expected signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:467:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:467:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got signed int const *__gu_addr @@
   drivers/mtd/ubi/cdev.c:467:23: sparse:     expected void const volatile [noderef] __user *
   drivers/mtd/ubi/cdev.c:467:23: sparse:     got signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:512:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:512:23: sparse:     expected signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:512:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:512:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got signed int const *__gu_addr @@
   drivers/mtd/ubi/cdev.c:512:23: sparse:     expected void const volatile [noderef] __user *
   drivers/mtd/ubi/cdev.c:512:23: sparse:     got signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:526:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:526:23: sparse:     expected signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:526:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:526:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got signed int const *__gu_addr @@
   drivers/mtd/ubi/cdev.c:526:23: sparse:     expected void const volatile [noderef] __user *
   drivers/mtd/ubi/cdev.c:526:23: sparse:     got signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:882:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:882:23: sparse:     expected signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:882:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:882:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got signed int const *__gu_addr @@
   drivers/mtd/ubi/cdev.c:882:23: sparse:     expected void const volatile [noderef] __user *
   drivers/mtd/ubi/cdev.c:882:23: sparse:     got signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:969:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:969:23: sparse:     expected signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:969:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:969:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got signed int const *__gu_addr @@
   drivers/mtd/ubi/cdev.c:969:23: sparse:     expected void const volatile [noderef] __user *
   drivers/mtd/ubi/cdev.c:969:23: sparse:     got signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:984:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:984:23: sparse:     expected signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:984:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:984:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got signed int const *__gu_addr @@
   drivers/mtd/ubi/cdev.c:984:23: sparse:     expected void const volatile [noderef] __user *
--
   make[4]: *** [scripts/Makefile.build:281: drivers/input/rmi4/rmi_driver.o] Error 1
   {standard input}:8780: Error: unknown opcode
   {standard input}:10054: Error: unknown opcode
   {standard input}:6282: Error: unknown opcode
   {standard input}:8161: Error: unknown opcode
   {standard input}:10803: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/net/phy/phy_device.o] Error 1
   make[4]: *** [scripts/Makefile.build:281: drivers/net/caif/caif_hsi.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:705: Error: unknown opcode
   {standard input}:2503: Error: unknown opcode
   {standard input}:2548: Error: unknown opcode
   {standard input}:2582: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: drivers/input/input.o] Error 1
   make[3]: *** [scripts/Makefile.build:497: drivers/net/caif] Error 2
   make[4]: *** [scripts/Makefile.build:281: drivers/net/caif/caif_virtio.o] Error 1
   make[4]: Target '__build' not remade because of errors.
   drivers/input/joystick/analog.c:169:17: sparse: sparse: undefined identifier 'boot_cpu_has'
   drivers/input/joystick/analog.c:169:17: sparse: sparse: undefined identifier 'rdtsc'
   drivers/input/joystick/analog.c:169:17: sparse: sparse: cast from unknown type
   drivers/input/joystick/analog.c:179:24: sparse: sparse: undefined identifier 'boot_cpu_has'
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: undefined identifier 'X86_FEATURE_TSC'
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:179:24: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:179:24: sparse: sparse: undefined identifier 'X86_FEATURE_TSC'
   drivers/input/joystick/analog.c:179:24: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:179:24: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:179:24: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:169:17: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:179:24: sparse: sparse: not a function <noident>
   drivers/input/joystick/analog.c:179:24: sparse: sparse: not a function <noident>
   drivers/input/serio/serio_raw.c:219:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/input/serio/serio_raw.c:219:21: sparse:     expected char const *__gu_addr
   drivers/input/serio/serio_raw.c:219:21: sparse:     got char const [noderef] __user *
   drivers/input/serio/serio_raw.c:219:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
   drivers/input/serio/serio_raw.c:219:21: sparse:     expected void const volatile [noderef] __user *
   drivers/input/serio/serio_raw.c:219:21: sparse:     got char const *__gu_addr
   drivers/input/joystick/analog.c:160:2: warning: #warning Precise timer not defined for this architecture. [-Wcpp]
     160 | #warning Precise timer not defined for this architecture.
         |  ^~~~~~~
   {standard input}: Assembler messages:
   {standard input}:5244: Error: unknown opcode
   {standard input}:5575: Error: unknown opcode
   {standard input}:5630: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:280: drivers/input/keyboard/atkbd.o] Error 1
   drivers/input/rmi4/rmi_f01.c:106: warning: Cannot understand  * @ctrl0 - see the bit definitions above.
    on line 106 - I thought it was a doc line
   {standard input}: Assembler messages:
   {standard input}:1293: Error: unknown opcode
   {standard input}:1324: Error: unknown opcode
   {standard input}:2714: Error: unknown opcode
   {standard input}:3449: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:280: drivers/input/serio/serio_raw.o] Error 1
   drivers/input/misc/drv260x.c: In function 'drv260x_probe':
   drivers/input/misc/drv260x.c:478:20: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
     478 |  if (haptics->mode < DRV260X_LRA_MODE ||
         |                    ^
   drivers/input/misc/drv260x.c:490:23: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
     490 |  if (haptics->library < DRV260X_LIB_EMPTY ||
         |                       ^
   {standard input}: Assembler messages:
   {standard input}:60: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:280: drivers/input/joystick/analog.o] Error 1
   drivers/mfd/tps6586x.c:323:16: sparse: sparse: cast to restricted __le32
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'input_dev' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'client' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'regmap' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'work' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'enable_gpio' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'regulator' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'magnitude' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'mode' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'library' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'rated_voltage' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'overdrive_voltage' not described in 'drv260x_data'
   drivers/input/misc/drv260x.c:244: warning: Function parameter or member 'voltage' not described in 'drv260x_calculate_voltage'
   {standard input}: Assembler messages:
   {standard input}:2063: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:280: drivers/input/joystick/grip.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:1743: Error: unknown opcode
   {standard input}:1931: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/gpu/drm/drm_prime.o] Error 1
   drivers/input/misc/drv2665.c:59: warning: Function parameter or member 'input_dev' not described in 'drv2665_data'
   drivers/input/misc/drv2665.c:59: warning: Function parameter or member 'client' not described in 'drv2665_data'
   drivers/input/misc/drv2665.c:59: warning: Function parameter or member 'regmap' not described in 'drv2665_data'
   drivers/input/misc/drv2665.c:59: warning: Function parameter or member 'work' not described in 'drv2665_data'
   drivers/input/misc/drv2665.c:59: warning: Function parameter or member 'regulator' not described in 'drv2665_data'
>> drivers/net/hamradio/6pack.c:710:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/hamradio/6pack.c:710:21: sparse:     expected int const *__gu_addr
>> drivers/net/hamradio/6pack.c:710:21: sparse:     got int [noderef] __user *
>> drivers/net/hamradio/6pack.c:710:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> drivers/net/hamradio/6pack.c:710:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/hamradio/6pack.c:710:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_async.c:420:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_async.c:420:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_async.c:420:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_async.c:420:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_async.c:420:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_async.c:420:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_async.c:435:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/net/ppp/ppp_async.c:435:21: sparse:     expected unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:435:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/net/ppp/ppp_async.c:435:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/net/ppp/ppp_async.c:435:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_async.c:435:21: sparse:     got unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:446:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/net/ppp/ppp_async.c:446:21: sparse:     expected unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:446:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/net/ppp/ppp_async.c:446:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/net/ppp/ppp_async.c:446:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_async.c:446:21: sparse:     got unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:471:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_async.c:471:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_async.c:471:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_async.c:471:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_async.c:471:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_async.c:471:21: sparse:     got int const *__gu_addr
   {standard input}: Assembler messages:
   {standard input}:633: Error: unknown opcode
   {standard input}:667: Error: unknown opcode
   drivers/net/ppp/ppp_generic.c:925:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:925:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:954:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:954:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:651:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:651:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:681:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:681:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:688:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:688:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:726:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:726:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:755:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:755:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:823:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:823:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     got int const *__gu_addr
   {standard input}:5433: Error: unknown opcode
   {standard input}:5499: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/net/phy/mdio_bus.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:2330: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/input/joystick/grip_mp.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:52: Error: unknown opcode
   {standard input}:113: Error: unknown opcode
   {standard input}:2195: Error: unknown opcode
   {standard input}:2226: Error: unknown opcode
   {standard input}:2653: Error: unknown opcode
   {standard input}:3418: Error: unknown opcode
   {standard input}:3983: Error: unknown opcode
   {standard input}:4049: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/net/ppp/ppp_async.o] Error 1
   drivers/input/serio/apbps2.c: In function 'apbps2_open':
   drivers/input/serio/apbps2.c:106:16: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
--
   {standard input}:454: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/input/joystick/magellan.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:6459: Error: unknown opcode
   {standard input}:6490: Error: unknown opcode
   {standard input}:6633: Error: unknown opcode
   {standard input}:6837: Error: unknown opcode
   {standard input}:7814: Error: unknown opcode
   {standard input}:8237: Error: unknown opcode
   {standard input}:8407: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:280: drivers/input/ff-memless.o] Error 1
   {standard input}:8991: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:446: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/input/misc/pcf50633-input.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:1527: Error: unknown opcode
   {standard input}:1559: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:6562: Error: unknown opcode
   {standard input}:6593: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:280: drivers/gpu/drm/drm_atomic.o] Error 1
   make[4]: *** [scripts/Makefile.build:280: drivers/gpu/drm/drm_framebuffer.o] Error 1
   drivers/net/hamradio/baycom_ser_fdx.c:290:43: sparse: sparse: dubious: x | !y
   {standard input}: Assembler messages:
   {standard input}:5009: Error: unknown opcode
   {standard input}:5040: Error: unknown opcode
   {standard input}:5507: Error: unknown opcode
   {standard input}:8186: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:280: drivers/gpu/drm/drm_connector.o] Error 1
   {standard input}:17424: Error: unknown opcode
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:497: drivers/input/rmi4] Error 2
   {standard input}:18539: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:280: drivers/net/ppp/ppp_generic.o] Error 1
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:497: drivers/net/ppp] Error 2
   drivers/mfd/lm3533-ctrlbank.c: In function 'lm3533_ctrlbank_set_brightness':
   drivers/mfd/lm3533-ctrlbank.c:98:10: warning: comparison is always false due to limited range of data type [-Wtype-limits]
      98 |  if (val > LM3533_##_NAME##_MAX)     2920-      |          ^
   drivers/mfd/lm3533-ctrlbank.c:125:1: note: in expansion of macro 'lm3533_ctrlbank_set'
     125 | lm3533_ctrlbank_set(brightness, BRIGHTNESS);
         | ^~~~~~~~~~~~~~~~~~~
   include/linux/unaligned/be_byteshift.h:26:16: sparse: sparse: cast truncates bits from constant value (1000 becomes 0)
   {standard input}: Assembler messages:
   {standard input}:828: Error: unknown opcode
   {standard input}:924: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: drivers/input/sparse-keymap.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:489: Error: unknown opcode
   drivers/i2c/busses/i2c-rk3x.c:244: warning: Function parameter or member 'i2c' not described in 'rk3x_i2c_start'
   drivers/i2c/busses/i2c-rk3x.c:265: warning: Function parameter or member 'i2c' not described in 'rk3x_i2c_stop'
   drivers/i2c/busses/i2c-rk3x.c:303: warning: Function parameter or member 'i2c' not described in 'rk3x_i2c_prepare_read'
   drivers/i2c/busses/i2c-rk3x.c:334: warning: Function parameter or member 'i2c' not described in 'rk3x_i2c_fill_transmit_buf'
   drivers/i2c/busses/i2c-rk3x.c:972: warning: Function parameter or member 'i2c' not described in 'rk3x_i2c_setup'
   make[4]: *** [scripts/Makefile.build:281: drivers/input/joystick/twidjoy.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:460: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/input/joystick/spaceorb.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:1334: Error: unknown opcode
   {standard input}:1437: Error: unknown opcode
   {standard input}:1769: Error: unknown opcode
   {standard input}:1839: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: drivers/i2c/i2c-core-of.o] Error 1
   drivers/input/mousedev.c:683:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/input/mousedev.c:683:21: sparse:     expected char const *__gu_addr
   drivers/input/mousedev.c:683:21: sparse:     got char const [noderef] __user *
   drivers/input/mousedev.c:683:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
   drivers/input/mousedev.c:683:21: sparse:     expected void const volatile [noderef] __user *
   drivers/input/mousedev.c:683:21: sparse:     got char const *__gu_addr
   {standard input}: Assembler messages:
   {standard input}:489: Error: unknown opcode
   {standard input}:520: Error: unknown opcode
   {standard input}:945: Error: unknown opcode
   {standard input}:2544: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/gpu/drm/drm_mode_object.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:6331: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: drivers/i2c/i2c-core-smbus.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:8660: Error: unknown opcode
   {standard input}:8879: Error: unknown opcode
   {standard input}:9080: Error: unknown opcode
   {standard input}:11045: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:656: Error: unknown opcode
   {standard input}:701: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/input/keyboard/newtonkbd.o] Error 1
   make[3]: *** [scripts/Makefile.build:281: drivers/i2c/i2c-core-base.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:4684: Error: unknown opcode
   drivers/net/slip/slip.c:458:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:458:14: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:458:14: sparse:    void *
   drivers/net/slip/slip.c:892:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:892:9: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:892:9: sparse:    void *
   drivers/net/slip/slip.c:1099:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
>> drivers/net/slip/slip.c:1099:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/slip/slip.c:1124:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/slip/slip.c:1124:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/slip/slip.c:1150:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/slip/slip.c:1150:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   make[3]: *** [scripts/Makefile.build:497: drivers/media/i2c] Error 2
   make[4]: *** [scripts/Makefile.build:281: drivers/media/i2c/ir-kbd-i2c.o] Error 1
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:497: drivers/input/joystick] Error 2
   make[4]: Target '__build' not remade because of errors.
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   {standard input}: Assembler messages:
   {standard input}:50: Error: unknown opcode
   {standard input}:113: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:60: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:1038: Error: unknown opcode
   {standard input}:1546: Error: unknown opcode
   {standard input}:1696: Error: unknown opcode
   {standard input}:1890: Error: unknown opcode
   {standard input}:2760: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:280: drivers/input/misc/uinput.o] Error 1
   make[3]: *** [scripts/Makefile.build:497: drivers/input/misc] Error 2
   make[4]: Target '__build' not remade because of errors.
   make[4]: *** [scripts/Makefile.build:280: drivers/net/hamradio/hdlcdrv.o] Error 1
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:497: drivers/net/hamradio] Error 2
   {standard input}:4163: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:280: drivers/input/mousedev.o] Error 1
   drivers/w1/slaves/w1_therm.c:875:18: sparse: sparse: cast to restricted __le64
   {standard input}: Assembler messages:
   {standard input}:62: Error: unknown opcode
   {standard input}:1378: Error: unknown opcode
   {standard input}:1551: Error: unknown opcode
   drivers/w1/masters/ds2482.c:23: warning: Incorrect use of kernel-doc format:  * Allow the active pullup to be disabled, default is enabled.
   drivers/w1/masters/ds2482.c:32: warning: cannot understand function prototype: 'int ds2482_active_pullup = 1; '
   drivers/w1/masters/ds2482.c:82: warning: cannot understand function prototype: 'const u8 ds2482_chan_wr[8] =         '
   drivers/w1/masters/ds2482.c:132: warning: Function parameter or member 'conf' not described in 'ds2482_calculate_config'
   make[4]: *** [scripts/Makefile.build:281: drivers/media/mc/mc-devnode.o] Error 1
   drivers/w1/masters/ds2482.c:149: warning: Function parameter or member 'pdev' not described in 'ds2482_select_register'
   drivers/w1/masters/ds2482.c:149: warning: Function parameter or member 'read_ptr' not described in 'ds2482_select_register'
   drivers/w1/masters/ds2482.c:170: warning: Function parameter or member 'pdev' not described in 'ds2482_send_cmd'
   drivers/w1/masters/ds2482.c:170: warning: Function parameter or member 'cmd' not described in 'ds2482_send_cmd'
   drivers/w1/masters/ds2482.c:190: warning: Function parameter or member 'pdev' not described in 'ds2482_send_cmd_data'
   drivers/w1/masters/ds2482.c:190: warning: Function parameter or member 'cmd' not described in 'ds2482_send_cmd_data'
   drivers/w1/masters/ds2482.c:190: warning: Function parameter or member 'byte' not described in 'ds2482_send_cmd_data'
   drivers/w1/masters/ds2482.c:214: warning: Function parameter or member 'pdev' not described in 'ds2482_wait_1wire_idle'
   drivers/w1/masters/ds2482.c:241: warning: Function parameter or member 'pdev' not described in 'ds2482_set_channel'
   drivers/w1/masters/ds2482.c:241: warning: Function parameter or member 'channel' not described in 'ds2482_set_channel'
   drivers/w1/masters/ds2482.c:264: warning: Function parameter or member 'data' not described in 'ds2482_w1_touch_bit'
   drivers/w1/masters/ds2482.c:264: warning: Function parameter or member 'bit' not described in 'ds2482_w1_touch_bit'
   drivers/w1/masters/ds2482.c:296: warning: Function parameter or member 'data' not described in 'ds2482_w1_triplet'
   drivers/w1/masters/ds2482.c:296: warning: Function parameter or member 'dbit' not described in 'ds2482_w1_triplet'
   drivers/w1/masters/ds2482.c:326: warning: Function parameter or member 'data' not described in 'ds2482_w1_write_byte'
   drivers/w1/masters/ds2482.c:326: warning: Function parameter or member 'byte' not described in 'ds2482_w1_write_byte'
   drivers/w1/masters/ds2482.c:350: warning: Function parameter or member 'data' not described in 'ds2482_w1_read_byte'
   drivers/w1/masters/ds2482.c:387: warning: Function parameter or member 'data' not described in 'ds2482_w1_reset_bus'
   drivers/w1/masters/ds2482.c:547: warning: cannot understand function prototype: 'const struct i2c_device_id ds2482_id[] = '
   drivers/w1/slaves/w1_therm.c: In function 'w1_seq_show':
   drivers/w1/slaves/w1_therm.c:1709:6: warning: variable 'rv' set but not used [-Wunused-but-set-variable]
    1709 |  int rv;
         |      ^~
   drivers/w1/w1.c:426:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] rn64_le @@     got restricted __le64 [usertype] @@
   drivers/w1/w1.c:426:17: sparse:     expected unsigned long long [usertype] rn64_le
   drivers/w1/w1.c:426:17: sparse:     got restricted __le64 [usertype]
   drivers/w1/w1.c:920:21: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long long [usertype] rn_le @@     got restricted __le64 [usertype] @@
   drivers/w1/w1.c:920:21: sparse:     expected unsigned long long [usertype] rn_le
   drivers/w1/w1.c:920:21: sparse:     got restricted __le64 [usertype]
   {standard input}: Assembler messages:
   {standard input}:2301: Error: unknown opcode
   {standard input}:2789: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:146: Error: unknown opcode
   {standard input}:259: Error: unknown opcode
   make[5]: *** [scripts/Makefile.build:281: drivers/media/cec/core/cec-core.o] Error 1
   drivers/input/keyboard/samsung-keypad.c: In function 'samsung_keypad_irq':
   drivers/input/keyboard/samsung-keypad.c:149:15: warning: variable 'val' set but not used [-Wunused-but-set-variable]
     149 |  unsigned int val;
         |               ^~~
   {standard input}:5548: Error: unknown opcode
   {standard input}:5641: Error: unknown opcode
   {standard input}:5826: Error: unknown opcode
   {standard input}:5977: Error: unknown opcode
   {standard input}:7225: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/media/v4l2-core/v4l2-dev.o] Error 1
   drivers/input/joydev.c:528:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
--
   {standard input}:30189: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:1437: Error: unknown opcode
   {standard input}:1471: Error: unknown opcode
   {standard input}:30349: Error: unknown opcode
   {standard input}:30388: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/bridge/br.o] Error 1
   net/ipv4/ip_sockglue.c:759:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/ipv4/ip_sockglue.c:759:29: sparse:     expected int const *__gu_addr
   net/ipv4/ip_sockglue.c:759:29: sparse:     got int [noderef] __user *
   net/ipv4/ip_sockglue.c:759:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/ipv4/ip_sockglue.c:759:29: sparse:     expected void const volatile [noderef] __user *
   net/ipv4/ip_sockglue.c:759:29: sparse:     got int const *__gu_addr
   net/ipv4/ip_sockglue.c:764:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] __user * @@
   net/ipv4/ip_sockglue.c:764:29: sparse:     expected unsigned char const *__gu_addr
   net/ipv4/ip_sockglue.c:764:29: sparse:     got unsigned char [noderef] __user *
   net/ipv4/ip_sockglue.c:764:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
   net/ipv4/ip_sockglue.c:764:29: sparse:     expected void const volatile [noderef] __user *
   net/ipv4/ip_sockglue.c:764:29: sparse:     got unsigned char const *__gu_addr
   net/ipv4/ip_sockglue.c:1486:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/ip_sockglue.c:1486:13: sparse:     expected int const *__gu_addr
   net/ipv4/ip_sockglue.c:1486:13: sparse:     got int [noderef] __user *optlen
   net/ipv4/ip_sockglue.c:1486:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/ipv4/ip_sockglue.c:1486:13: sparse:     expected void const volatile [noderef] __user *
   net/ipv4/ip_sockglue.c:1486:13: sparse:     got int const *__gu_addr
   {standard input}:27022: Error: unknown opcode
   {standard input}:27272: Error: unknown opcode
   {standard input}:27304: Error: unknown opcode
   make[3]: Target '__build' not remade because of errors.
   make[2]: *** [scripts/Makefile.build:497: net/llc] Error 2
   make[3]: *** [scripts/Makefile.build:280: net/core/neighbour.o] Error 1
   {standard input}:27788: Error: unknown opcode
   {standard input}:27931: Error: unknown opcode
   {standard input}:28560: Error: unknown opcode
   {standard input}:29015: Error: unknown opcode
   {standard input}:29090: Error: unknown opcode
   {standard input}:29469: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:864: Error: unknown opcode
   {standard input}:917: Error: unknown opcode
   {standard input}:1952: Error: unknown opcode
   {standard input}:2118: Error: unknown opcode
   {standard input}:2536: Error: unknown opcode
   {standard input}:2597: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/bridge/br_device.o] Error 1
   make[3]: *** [scripts/Makefile.build:280: net/packet/af_packet.o] Error 1
   make[3]: Target '__build' not remade because of errors.
   make[2]: *** [scripts/Makefile.build:497: net/packet] Error 2
   {standard input}:29907: Error: unknown opcode
   {standard input}:31270: Error: unknown opcode
   {standard input}:31449: Error: unknown opcode
   {standard input}:32568: Error: unknown opcode
   net/appletalk/aarp.c:68: warning: Function parameter or member 'last_sent' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'packet_queue' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'status' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'expires_at' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'target_addr' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'dev' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'hwaddr' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'xmit_count' not described in 'aarp_entry'
   net/appletalk/aarp.c:68: warning: Function parameter or member 'next' not described in 'aarp_entry'
   make[3]: *** [scripts/Makefile.build:280: net/core/rtnetlink.o] Error 1
   {standard input}:35660: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:66: Error: unknown opcode
   {standard input}:129: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:1292: Error: unknown opcode
   {standard input}:1323: Error: unknown opcode
   {standard input}:1550: Error: unknown opcode
   {standard input}:36867: Error: unknown opcode
   {standard input}:2519: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/ipv6/anycast.o] Error 1
   {standard input}:2306: Error: unknown opcode
   {standard input}:4145: Error: unknown opcode
   {standard input}:4785: Error: unknown opcode
   {standard input}:6063: Error: unknown opcode
   {standard input}:6408: Error: unknown opcode
   net/x25/af_x25.c:448:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/x25/af_x25.c:448:13: sparse:     expected int const *__gu_addr
   net/x25/af_x25.c:448:13: sparse:     got int [noderef] __user *
   net/x25/af_x25.c:448:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/x25/af_x25.c:448:13: sparse:     expected void const volatile [noderef] __user *
   net/x25/af_x25.c:448:13: sparse:     got int const *__gu_addr
   net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/x25/af_x25.c:470:13: sparse:     expected int const *__gu_addr
   net/x25/af_x25.c:470:13: sparse:     got int [noderef] __user *optlen
   net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/x25/af_x25.c:470:13: sparse:     expected void const volatile [noderef] __user *
   net/x25/af_x25.c:470:13: sparse:     got int const *__gu_addr
   {standard input}: Assembler messages:
   {standard input}:2717: Error: unknown opcode
   {standard input}:2748: Error: unknown opcode
   {standard input}:2902: Error: unknown opcode
   {standard input}:3899: Error: unknown opcode
   {standard input}:7318: Error: unknown opcode
   {standard input}:7424: Error: unknown opcode
   {standard input}:8378: Error: unknown opcode
   {standard input}:43209: Error: unknown opcode
   {standard input}:44807: Error: unknown opcode
>> net/netrom/af_netrom.c:309:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   net/netrom/af_netrom.c:309:13: sparse:     expected unsigned int const *__gu_addr
>> net/netrom/af_netrom.c:309:13: sparse:     got unsigned int [noderef] __user *
>> net/netrom/af_netrom.c:309:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> net/netrom/af_netrom.c:309:13: sparse:     expected void const volatile [noderef] __user *
   net/netrom/af_netrom.c:309:13: sparse:     got unsigned int const *__gu_addr
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/netrom/af_netrom.c:359:13: sparse:     expected int const *__gu_addr
>> net/netrom/af_netrom.c:359:13: sparse:     got int [noderef] __user *optlen
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/netrom/af_netrom.c:359:13: sparse:     expected void const volatile [noderef] __user *
   net/netrom/af_netrom.c:359:13: sparse:     got int const *__gu_addr
   {standard input}:44867: Error: unknown opcode
   {standard input}:46057: Error: unknown opcode
   {standard input}:46977: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:980: Error: unknown opcode
   {standard input}:15342: Error: unknown opcode
   {standard input}:15419: Error: unknown opcode
   {standard input}:15531: Error: unknown opcode
   {standard input}:15578: Error: unknown opcode
   {standard input}:15897: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/bridge/br_fdb.o] Error 1
   {standard input}:47787: Error: unknown opcode
   {standard input}:48665: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/ipv4/ip_options.o] Error 1
   {standard input}:49563: Error: unknown opcode
   {standard input}:49639: Error: unknown opcode
   net/ipv6/addrconf.c:6944:38: sparse: sparse: incorrect type in argument 3 (incompatible argument 3 (different address spaces)) @@     expected int ( [usertype] *proc_handler )( ... ) @@     got int ( * )( ... ) @@
   net/ipv6/addrconf.c:6944:38: sparse:     expected int ( [usertype] *proc_handler )( ... )
   net/ipv6/addrconf.c:6944:38: sparse:     got int ( * )( ... )
   make[3]: *** [scripts/Makefile.build:281: net/appletalk/ddp.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:2000: Error: unknown opcode
   {standard input}:2139: Error: unknown opcode
   {standard input}:2186: Error: unknown opcode
   {standard input}:5115: Error: unknown opcode
   {standard input}:5303: Error: unknown opcode
   {standard input}:6264: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:1765: Error: unknown opcode
   {standard input}:1904: Error: unknown opcode
   {standard input}:1951: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:1441: Error: unknown opcode
   {standard input}:58795: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:267: Error: unknown opcode
   {standard input}:314: Error: unknown opcode
   {standard input}:1655: Error: unknown opcode
   {standard input}:3214: Error: unknown opcode
   {standard input}:3412: Error: unknown opcode
   net/ipv4/inet_connection_sock.c:181:36: sparse: sparse: context imbalance in 'inet_csk_find_open_port' - wrong count at exit
   net/ipv4/inet_connection_sock.c:348:24: sparse: sparse: context imbalance in 'inet_csk_get_port' - different lock contexts for basic block
   net/ipv4/inet_connection_sock.c:1000:9: sparse: sparse: context imbalance in 'inet_csk_complete_hashdance' - unexpected unlock
   {standard input}:7929: Error: unknown opcode
   {standard input}:2893: Error: unknown opcode
   {standard input}:4277: Error: unknown opcode
   {standard input}:4308: Error: unknown opcode
   {standard input}:6070: Error: unknown opcode
   {standard input}:6159: Error: unknown opcode
   {standard input}:9662: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/ipv6/ip6_input.o] Error 1
   {standard input}:6875: Error: unknown opcode
   {standard input}:10789: Error: unknown opcode
   {standard input}:10861: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/ipv4/ip_sockglue.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:3561: Error: unknown opcode
   {standard input}:3592: Error: unknown opcode
   {standard input}:3828: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:582: Error: unknown opcode
   {standard input}:717: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/netrom/nr_dev.o] Error 1
   {standard input}:5136: Error: unknown opcode
   {standard input}:71407: Error: unknown opcode
   {standard input}:71898: Error: unknown opcode
   {standard input}:13905: Error: unknown opcode
   {standard input}:6774: Error: unknown opcode
   {standard input}:8543: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/ipv4/ip_output.o] Error 1
   make[3]: *** [scripts/Makefile.build:281: net/netrom/af_netrom.o] Error 1
   net/ipv4/tcp.c:3095:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/ipv4/tcp.c:3095:13: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3095:13: sparse:     got int [noderef] __user *
   net/ipv4/tcp.c:3095:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3095:13: sparse:     expected void const volatile [noderef] __user *
   net/ipv4/tcp.c:3095:13: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3586:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3586:13: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3586:13: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3586:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3586:13: sparse:     expected void const volatile [noderef] __user *
   net/ipv4/tcp.c:3586:13: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3635:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3635:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3635:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3635:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3635:21: sparse:     expected void const volatile [noderef] __user *
   net/ipv4/tcp.c:3635:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3653:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3653:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3653:21: sparse:     got int [noderef] __user *optlen
   net/ipv4/tcp.c:3653:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/ipv4/tcp.c:3653:21: sparse:     expected void const volatile [noderef] __user *
   net/ipv4/tcp.c:3653:21: sparse:     got int const *__gu_addr
   net/ipv4/tcp.c:3672:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/tcp.c:3672:21: sparse:     expected int const *__gu_addr
   net/ipv4/tcp.c:3672:21: sparse:     got int [noderef] __user *optlen
--
   {standard input}: Assembler messages:
   {standard input}:20486: Error: unknown opcode
   {standard input}:22723: Error: unknown opcode
   {standard input}:23563: Error: unknown opcode
   {standard input}:25098: Error: unknown opcode
   {standard input}:25198: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: drivers/spi/spi.o] Error 1
   drivers/spi/spidev.c:396:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:396:34: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:396:34: sparse:     got unsigned char [noderef] [usertype] __user *
>> drivers/spi/spidev.c:396:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
>> drivers/spi/spidev.c:396:34: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:396:34: sparse:     got unsigned char const *__gu_addr
   drivers/spi/spidev.c:398:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:398:34: sparse:     expected unsigned int const *__gu_addr
   drivers/spi/spidev.c:398:34: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/spi/spidev.c:398:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/spi/spidev.c:398:34: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:398:34: sparse:     got unsigned int const *__gu_addr
   drivers/spi/spidev.c:422:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:422:26: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:422:26: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/spi/spidev.c:422:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
   drivers/spi/spidev.c:422:26: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:422:26: sparse:     got unsigned char const *__gu_addr
   drivers/spi/spidev.c:439:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:439:26: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:439:26: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/spi/spidev.c:439:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
   drivers/spi/spidev.c:439:26: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:439:26: sparse:     got unsigned char const *__gu_addr
   drivers/spi/spidev.c:452:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:452:26: sparse:     expected unsigned int const *__gu_addr
   drivers/spi/spidev.c:452:26: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/spi/spidev.c:452:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/spi/spidev.c:452:26: sparse:     expected void const volatile [noderef] __user *
   drivers/spi/spidev.c:452:26: sparse:     got unsigned int const *__gu_addr
   {standard input}: Assembler messages:
   {standard input}:2186: Error: unknown opcode
   {standard input}:2660: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: drivers/spi/spidev.o] Error 1
   drivers/spi/spi-bitbang.c:181: warning: Function parameter or member 'spi' not described in 'spi_bitbang_setup'
   drivers/spi/spi-bitbang.c:215: warning: Function parameter or member 'spi' not described in 'spi_bitbang_cleanup'
   drivers/spi/spi-bitbang.c:434: warning: Function parameter or member 'bitbang' not described in 'spi_bitbang_stop'
   {standard input}: Assembler messages:
   {standard input}:2232: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: drivers/spi/spi-dw-core.o] Error 1
   drivers/spi/spi-fsl-spi.c:93:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:93:44: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:93:44: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:94:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *mode @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:94:33: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *mode
   drivers/spi/spi-fsl-spi.c:94:33: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:294:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:294:44: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:294:44: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:299:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:299:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:299:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:303:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:303:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:303:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:317:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:317:18: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:317:18: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:350:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:350:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:350:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:459:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:459:18: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:459:18: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:462:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:462:45: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:462:45: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:498:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:498:44: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:498:44: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:502:53: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:502:53: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:502:53: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:511:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:511:47: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:511:47: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:516:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:516:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:516:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:522:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:522:40: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:522:40: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:533:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:533:44: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:533:44: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:536:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:536:40: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:536:40: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:553:51: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:553:51: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:553:51: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:560:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:560:48: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:560:48: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:562:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:562:40: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:562:40: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:571:51: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:571:51: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:571:51: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:575:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:575:46: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:575:46: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:585:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:585:40: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:585:40: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:652:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:652:18: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:652:18: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:655:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
--
   {standard input}: Assembler messages:
   {standard input}:6026: Error: unknown opcode
   make[5]: *** [scripts/Makefile.build:281: drivers/net/phy/mscc/mscc_main.o] Error 1
   make[5]: Target '__build' not remade because of errors.
   make[4]: *** [scripts/Makefile.build:497: drivers/net/phy/mscc] Error 2
   drivers/net/phy/mdio-boardinfo.c:27: warning: Function parameter or member 'bus' not described in 'mdiobus_setup_mdiodev_from_board_info'
   drivers/net/phy/mdio-boardinfo.c:27: warning: Function parameter or member 'cb' not described in 'mdiobus_setup_mdiodev_from_board_info'
   drivers/net/phy/mdio-boardinfo.c:27: warning: Excess function parameter 'mdiodev' description in 'mdiobus_setup_mdiodev_from_board_info'
   {standard input}: Assembler messages:
   {standard input}:4219: Error: unknown opcode
   {standard input}:4308: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/net/phy/phy.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:50: Error: unknown opcode
   {standard input}:113: Error: unknown opcode
   {standard input}:176: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:1352: Error: unknown opcode
   {standard input}:1891: Error: unknown opcode
   {standard input}:2120: Error: unknown opcode
   {standard input}:2379: Error: unknown opcode
   {standard input}:2518: Error: unknown opcode
   {standard input}:2654: Error: unknown opcode
   {standard input}:2847: Error: unknown opcode
   {standard input}:2883: Error: unknown opcode
   {standard input}:3309: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/net/caif/caif_serial.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:9384: Error: unknown opcode
   {standard input}:6282: Error: unknown opcode
   {standard input}:8161: Error: unknown opcode
   {standard input}:10803: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/net/phy/phy_device.o] Error 1
   make[4]: *** [scripts/Makefile.build:281: drivers/net/caif/caif_hsi.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:705: Error: unknown opcode
   {standard input}:2503: Error: unknown opcode
   {standard input}:2548: Error: unknown opcode
   {standard input}:2582: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:497: drivers/net/caif] Error 2
   make[4]: *** [scripts/Makefile.build:281: drivers/net/caif/caif_virtio.o] Error 1
   make[4]: Target '__build' not remade because of errors.
>> drivers/net/hamradio/6pack.c:710:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/hamradio/6pack.c:710:21: sparse:     expected int const *__gu_addr
>> drivers/net/hamradio/6pack.c:710:21: sparse:     got int [noderef] __user *
>> drivers/net/hamradio/6pack.c:710:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> drivers/net/hamradio/6pack.c:710:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/hamradio/6pack.c:710:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_async.c:420:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_async.c:420:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_async.c:420:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_async.c:420:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_async.c:420:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_async.c:420:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_async.c:435:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/net/ppp/ppp_async.c:435:21: sparse:     expected unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:435:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/net/ppp/ppp_async.c:435:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/net/ppp/ppp_async.c:435:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_async.c:435:21: sparse:     got unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:446:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/net/ppp/ppp_async.c:446:21: sparse:     expected unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:446:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/net/ppp/ppp_async.c:446:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/net/ppp/ppp_async.c:446:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_async.c:446:21: sparse:     got unsigned int const *__gu_addr
   drivers/net/ppp/ppp_async.c:471:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_async.c:471:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_async.c:471:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_async.c:471:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_async.c:471:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_async.c:471:21: sparse:     got int const *__gu_addr
   {standard input}: Assembler messages:
   {standard input}:633: Error: unknown opcode
   {standard input}:667: Error: unknown opcode
   drivers/net/ppp/ppp_generic.c:925:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:925:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:925:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:954:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:954:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:954:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:651:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:651:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:651:29: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:681:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:681:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:681:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:688:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:688:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:688:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:726:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:726:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:726:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:755:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:755:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:755:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:823:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/ppp_generic.c:823:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     expected void const volatile [noderef] __user *
   drivers/net/ppp/ppp_generic.c:823:21: sparse:     got int const *__gu_addr
   {standard input}:5433: Error: unknown opcode
   {standard input}:5499: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/net/phy/mdio_bus.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:52: Error: unknown opcode
   {standard input}:113: Error: unknown opcode
   {standard input}:2195: Error: unknown opcode
   {standard input}:2226: Error: unknown opcode
   {standard input}:2653: Error: unknown opcode
   {standard input}:3418: Error: unknown opcode
   {standard input}:3983: Error: unknown opcode
   {standard input}:4049: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/net/ppp/ppp_async.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:1340: Error: unknown opcode
   {standard input}:1371: Error: unknown opcode
   {standard input}:1576: Error: unknown opcode
   {standard input}:1853: Error: unknown opcode
   {standard input}:2081: Error: unknown opcode
   {standard input}:2320: Error: unknown opcode
   {standard input}:2893: Error: unknown opcode
   {standard input}:3462: Error: unknown opcode
   {standard input}:3750: Error: unknown opcode
   {standard input}:4086: Error: unknown opcode
   {standard input}:4363: Error: unknown opcode
   {standard input}:6410: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/net/hamradio/6pack.o] Error 1
   drivers/net/phy/mdio_device.c:188: warning: Function parameter or member 'drv' not described in 'mdio_driver_register'
   drivers/net/phy/mdio_device.c:188: warning: Excess function parameter 'new_driver' description in 'mdio_driver_register'
   {standard input}: Assembler messages:
   {standard input}:6459: Error: unknown opcode
   {standard input}:6490: Error: unknown opcode
   {standard input}:6633: Error: unknown opcode
   {standard input}:6837: Error: unknown opcode
   {standard input}:7814: Error: unknown opcode
   {standard input}:8237: Error: unknown opcode
   {standard input}:8407: Error: unknown opcode
   {standard input}:8991: Error: unknown opcode
   drivers/net/hamradio/baycom_ser_fdx.c:290:43: sparse: sparse: dubious: x | !y
   {standard input}:17424: Error: unknown opcode
   {standard input}:18539: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:280: drivers/net/ppp/ppp_generic.o] Error 1
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:497: drivers/net/ppp] Error 2
   drivers/net/slip/slip.c:458:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:458:14: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:458:14: sparse:    void *
   drivers/net/slip/slip.c:892:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:892:9: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:892:9: sparse:    void *
   drivers/net/slip/slip.c:1099:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
>> drivers/net/slip/slip.c:1099:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/slip/slip.c:1124:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/slip/slip.c:1124:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/net/slip/slip.c:1150:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/slip/slip.c:1150:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] sum @@
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     expected restricted __wsum [usertype] sum
   arch/sh/include/asm/checksum_32.h:116:27: sparse:     got unsigned int [assigned] sum
   {standard input}: Assembler messages:
   {standard input}:1038: Error: unknown opcode
   {standard input}:1546: Error: unknown opcode
   {standard input}:1696: Error: unknown opcode
   {standard input}:1890: Error: unknown opcode
   {standard input}:2760: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:280: drivers/net/hamradio/hdlcdrv.o] Error 1
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:497: drivers/net/hamradio] Error 2
   {standard input}: Assembler messages:
   {standard input}:50: Error: unknown opcode
   {standard input}:113: Error: unknown opcode
   {standard input}:878: Error: unknown opcode
   {standard input}:931: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:7197: Error: unknown opcode
   {standard input}:4211: Error: unknown opcode
   {standard input}:4254: Error: unknown opcode
   {standard input}:4693: Error: unknown opcode
   {standard input}:4736: Error: unknown opcode
   {standard input}:6118: Error: unknown opcode
   {standard input}:6216: Error: unknown opcode
   {standard input}:6472: Error: unknown opcode
   {standard input}:6541: Error: unknown opcode
   {standard input}:6631: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/net/slip/slip.o] Error 1
   {standard input}:11372: Error: unknown opcode
   {standard input}:14484: Error: unknown opcode
   make[6]: *** [scripts/Makefile.build:280: drivers/net/wireless/ath/ath6kl/debug.o] Error 1
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:497: drivers/net/slip] Error 2
   drivers/net/ieee802154/ca8210.c:1840:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] pan_id @@     got unsigned short [usertype] @@
   drivers/net/ieee802154/ca8210.c:1840:27: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] pan_id
   drivers/net/ieee802154/ca8210.c:1840:27: sparse:     got unsigned short [usertype]
   drivers/net/ieee802154/ca8210.c:1845:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] pan_id @@     got unsigned short [usertype] @@
   drivers/net/ieee802154/ca8210.c:1845:25: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] pan_id
   drivers/net/ieee802154/ca8210.c:1845:25: sparse:     got unsigned short [usertype]
   drivers/net/ieee802154/ca8210.c:1971:28: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned short [usertype] dst_pan_id @@     got restricted __le16 [addressable] [usertype] pan_id @@
   drivers/net/ieee802154/ca8210.c:1971:28: sparse:     expected unsigned short [usertype] dst_pan_id
   drivers/net/ieee802154/ca8210.c:1971:28: sparse:     got restricted __le16 [addressable] [usertype] pan_id
   drivers/net/ieee802154/ca8210.c:326: warning: Function parameter or member 'readq' not described in 'ca8210_test'
   drivers/net/ieee802154/ca8210.c:375: warning: Function parameter or member 'spi_transfer_complete' not described in 'ca8210_priv'
   drivers/net/ieee802154/ca8210.c:375: warning: Function parameter or member 'sync_exchange_complete' not described in 'ca8210_priv'
   drivers/net/ieee802154/ca8210.c:375: warning: Function parameter or member 'promiscuous' not described in 'ca8210_priv'
   drivers/net/ieee802154/ca8210.c:430: warning: Function parameter or member 'short_address' not described in 'macaddr'
   drivers/net/ieee802154/ca8210.c:723: warning: Function parameter or member 'cas_ctl' not described in 'ca8210_rx_done'
   drivers/net/ieee802154/ca8210.c:723: warning: Excess function parameter 'arg' description in 'ca8210_rx_done'
   drivers/net/ieee802154/ca8210.c:1289: warning: Excess function parameter 'device_ref' description in 'tdme_checkpibattribute'
   drivers/net/ieee802154/ca8210.c:3053: warning: Function parameter or member 'spi_device' not described in 'ca8210_remove'
   drivers/net/ieee802154/ca8210.c:3053: warning: Excess function parameter 'priv' description in 'ca8210_remove'
   drivers/net/ieee802154/ca8210.c:3103: warning: Function parameter or member 'spi_device' not described in 'ca8210_probe'
   drivers/net/ieee802154/ca8210.c:3103: warning: Excess function parameter 'priv' description in 'ca8210_probe'
   {standard input}: Assembler messages:
   {standard input}:66: Error: unknown opcode
   {standard input}:129: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:609: Error: unknown opcode
   make[4]: *** [scripts/Makefile.build:281: drivers/net/phy/mdio-xpcs.o] Error 1
   drivers/net/wireless/marvell/libertas/cfg.c: In function 'lbs_ret_scan':
   drivers/net/wireless/marvell/libertas/cfg.c:586:6: warning: variable 'ssid_len' set but not used [-Wunused-but-set-variable]
     586 |   u8 ssid_len = 0;
         |      ^~~~~~~~
   drivers/net/wireless/marvell/libertas/cfg.c:585:13: warning: variable 'ssid' set but not used [-Wunused-but-set-variable]
     585 |   const u8 *ssid = NULL;
         |             ^~~~
   drivers/net/wireless/marvell/libertas/cfg.c:507:6: warning: variable 'tsfsize' set but not used [-Wunused-but-set-variable]
     507 |  int tsfsize;
         |      ^~~~~~~
   drivers/net/wireless/marvell/libertas/cfg.c: In function 'lbs_associate':
   drivers/net/wireless/marvell/libertas/cfg.c:1075:6: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
    1075 |  u8 *tmp;
         |      ^~~
   {standard input}: Assembler messages:
   {standard input}:7516: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:50: Error: unknown opcode
   {standard input}:113: Error: unknown opcode
   {standard input}:13038: Error: unknown opcode
   make[6]: *** [scripts/Makefile.build:281: drivers/net/wireless/marvell/libertas/cfg.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:2550: Error: unknown opcode
--
>> net/netrom/af_netrom.c:309:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   net/netrom/af_netrom.c:309:13: sparse:     expected unsigned int const *__gu_addr
>> net/netrom/af_netrom.c:309:13: sparse:     got unsigned int [noderef] __user *
>> net/netrom/af_netrom.c:309:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> net/netrom/af_netrom.c:309:13: sparse:     expected void const volatile [noderef] __user *
   net/netrom/af_netrom.c:309:13: sparse:     got unsigned int const *__gu_addr
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/netrom/af_netrom.c:359:13: sparse:     expected int const *__gu_addr
>> net/netrom/af_netrom.c:359:13: sparse:     got int [noderef] __user *optlen
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/netrom/af_netrom.c:359:13: sparse:     expected void const volatile [noderef] __user *
   net/netrom/af_netrom.c:359:13: sparse:     got int const *__gu_addr
   {standard input}: Assembler messages:
   {standard input}:3561: Error: unknown opcode
   {standard input}:3592: Error: unknown opcode
   {standard input}:3828: Error: unknown opcode
   {standard input}: Assembler messages:
   {standard input}:582: Error: unknown opcode
   {standard input}:717: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/netrom/nr_dev.o] Error 1
   {standard input}:5136: Error: unknown opcode
   {standard input}:6774: Error: unknown opcode
   {standard input}:8543: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/netrom/af_netrom.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:1100: Error: unknown opcode
   {standard input}:1131: Error: unknown opcode
   {standard input}:1289: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:280: net/netrom/nr_route.o] Error 1
   {standard input}: Assembler messages:
   {standard input}:1215: Error: unknown opcode
   {standard input}:1354: Error: unknown opcode
   {standard input}:1386: Error: unknown opcode
   make[3]: *** [scripts/Makefile.build:281: net/netrom/nr_timer.o] Error 1
   make[3]: Target '__build' not remade because of errors.

vim +309 net/netrom/af_netrom.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  290  
^1da177e4c3f41 Linus Torvalds  2005-04-16  291  /*
^1da177e4c3f41 Linus Torvalds  2005-04-16  292   *	Handling for system calls applied via the various interfaces to a
^1da177e4c3f41 Linus Torvalds  2005-04-16  293   *	NET/ROM socket object.
^1da177e4c3f41 Linus Torvalds  2005-04-16  294   */
^1da177e4c3f41 Linus Torvalds  2005-04-16  295  
^1da177e4c3f41 Linus Torvalds  2005-04-16  296  static int nr_setsockopt(struct socket *sock, int level, int optname,
b7058842c940ad David S. Miller 2009-09-30  297  	char __user *optval, unsigned int optlen)
^1da177e4c3f41 Linus Torvalds  2005-04-16  298  {
^1da177e4c3f41 Linus Torvalds  2005-04-16  299  	struct sock *sk = sock->sk;
^1da177e4c3f41 Linus Torvalds  2005-04-16  300  	struct nr_sock *nr = nr_sk(sk);
32288eb4d940b1 Xi Wang         2011-12-27  301  	unsigned long opt;
^1da177e4c3f41 Linus Torvalds  2005-04-16  302  
^1da177e4c3f41 Linus Torvalds  2005-04-16  303  	if (level != SOL_NETROM)
^1da177e4c3f41 Linus Torvalds  2005-04-16  304  		return -ENOPROTOOPT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  305  
32288eb4d940b1 Xi Wang         2011-12-27  306  	if (optlen < sizeof(unsigned int))
^1da177e4c3f41 Linus Torvalds  2005-04-16  307  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds  2005-04-16  308  
32288eb4d940b1 Xi Wang         2011-12-27 @309  	if (get_user(opt, (unsigned int __user *)optval))
^1da177e4c3f41 Linus Torvalds  2005-04-16  310  		return -EFAULT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  311  
^1da177e4c3f41 Linus Torvalds  2005-04-16  312  	switch (optname) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  313  	case NETROM_T1:
32288eb4d940b1 Xi Wang         2011-12-27  314  		if (opt < 1 || opt > ULONG_MAX / HZ)
^1da177e4c3f41 Linus Torvalds  2005-04-16  315  			return -EINVAL;
^1da177e4c3f41 Linus Torvalds  2005-04-16  316  		nr->t1 = opt * HZ;
^1da177e4c3f41 Linus Torvalds  2005-04-16  317  		return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  318  
^1da177e4c3f41 Linus Torvalds  2005-04-16  319  	case NETROM_T2:
32288eb4d940b1 Xi Wang         2011-12-27  320  		if (opt < 1 || opt > ULONG_MAX / HZ)
^1da177e4c3f41 Linus Torvalds  2005-04-16  321  			return -EINVAL;
^1da177e4c3f41 Linus Torvalds  2005-04-16  322  		nr->t2 = opt * HZ;
^1da177e4c3f41 Linus Torvalds  2005-04-16  323  		return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  324  
^1da177e4c3f41 Linus Torvalds  2005-04-16  325  	case NETROM_N2:
^1da177e4c3f41 Linus Torvalds  2005-04-16  326  		if (opt < 1 || opt > 31)
^1da177e4c3f41 Linus Torvalds  2005-04-16  327  			return -EINVAL;
^1da177e4c3f41 Linus Torvalds  2005-04-16  328  		nr->n2 = opt;
^1da177e4c3f41 Linus Torvalds  2005-04-16  329  		return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  330  
^1da177e4c3f41 Linus Torvalds  2005-04-16  331  	case NETROM_T4:
32288eb4d940b1 Xi Wang         2011-12-27  332  		if (opt < 1 || opt > ULONG_MAX / HZ)
^1da177e4c3f41 Linus Torvalds  2005-04-16  333  			return -EINVAL;
^1da177e4c3f41 Linus Torvalds  2005-04-16  334  		nr->t4 = opt * HZ;
^1da177e4c3f41 Linus Torvalds  2005-04-16  335  		return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  336  
^1da177e4c3f41 Linus Torvalds  2005-04-16  337  	case NETROM_IDLE:
32288eb4d940b1 Xi Wang         2011-12-27  338  		if (opt > ULONG_MAX / (60 * HZ))
^1da177e4c3f41 Linus Torvalds  2005-04-16  339  			return -EINVAL;
^1da177e4c3f41 Linus Torvalds  2005-04-16  340  		nr->idle = opt * 60 * HZ;
^1da177e4c3f41 Linus Torvalds  2005-04-16  341  		return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  342  
^1da177e4c3f41 Linus Torvalds  2005-04-16  343  	default:
^1da177e4c3f41 Linus Torvalds  2005-04-16  344  		return -ENOPROTOOPT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  345  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  346  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  347  
^1da177e4c3f41 Linus Torvalds  2005-04-16  348  static int nr_getsockopt(struct socket *sock, int level, int optname,
^1da177e4c3f41 Linus Torvalds  2005-04-16  349  	char __user *optval, int __user *optlen)
^1da177e4c3f41 Linus Torvalds  2005-04-16  350  {
^1da177e4c3f41 Linus Torvalds  2005-04-16  351  	struct sock *sk = sock->sk;
^1da177e4c3f41 Linus Torvalds  2005-04-16  352  	struct nr_sock *nr = nr_sk(sk);
^1da177e4c3f41 Linus Torvalds  2005-04-16  353  	int val = 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  354  	int len;
^1da177e4c3f41 Linus Torvalds  2005-04-16  355  
^1da177e4c3f41 Linus Torvalds  2005-04-16  356  	if (level != SOL_NETROM)
^1da177e4c3f41 Linus Torvalds  2005-04-16  357  		return -ENOPROTOOPT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  358  
^1da177e4c3f41 Linus Torvalds  2005-04-16 @359  	if (get_user(len, optlen))
^1da177e4c3f41 Linus Torvalds  2005-04-16  360  		return -EFAULT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  361  
^1da177e4c3f41 Linus Torvalds  2005-04-16  362  	if (len < 0)
^1da177e4c3f41 Linus Torvalds  2005-04-16  363  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds  2005-04-16  364  
^1da177e4c3f41 Linus Torvalds  2005-04-16  365  	switch (optname) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  366  	case NETROM_T1:
^1da177e4c3f41 Linus Torvalds  2005-04-16  367  		val = nr->t1 / HZ;
^1da177e4c3f41 Linus Torvalds  2005-04-16  368  		break;
^1da177e4c3f41 Linus Torvalds  2005-04-16  369  
^1da177e4c3f41 Linus Torvalds  2005-04-16  370  	case NETROM_T2:
^1da177e4c3f41 Linus Torvalds  2005-04-16  371  		val = nr->t2 / HZ;
^1da177e4c3f41 Linus Torvalds  2005-04-16  372  		break;
^1da177e4c3f41 Linus Torvalds  2005-04-16  373  
^1da177e4c3f41 Linus Torvalds  2005-04-16  374  	case NETROM_N2:
^1da177e4c3f41 Linus Torvalds  2005-04-16  375  		val = nr->n2;
^1da177e4c3f41 Linus Torvalds  2005-04-16  376  		break;
^1da177e4c3f41 Linus Torvalds  2005-04-16  377  
^1da177e4c3f41 Linus Torvalds  2005-04-16  378  	case NETROM_T4:
^1da177e4c3f41 Linus Torvalds  2005-04-16  379  		val = nr->t4 / HZ;
^1da177e4c3f41 Linus Torvalds  2005-04-16  380  		break;
^1da177e4c3f41 Linus Torvalds  2005-04-16  381  
^1da177e4c3f41 Linus Torvalds  2005-04-16  382  	case NETROM_IDLE:
^1da177e4c3f41 Linus Torvalds  2005-04-16  383  		val = nr->idle / (60 * HZ);
^1da177e4c3f41 Linus Torvalds  2005-04-16  384  		break;
^1da177e4c3f41 Linus Torvalds  2005-04-16  385  
^1da177e4c3f41 Linus Torvalds  2005-04-16  386  	default:
^1da177e4c3f41 Linus Torvalds  2005-04-16  387  		return -ENOPROTOOPT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  388  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  389  
^1da177e4c3f41 Linus Torvalds  2005-04-16  390  	len = min_t(unsigned int, len, sizeof(int));
^1da177e4c3f41 Linus Torvalds  2005-04-16  391  
^1da177e4c3f41 Linus Torvalds  2005-04-16  392  	if (put_user(len, optlen))
^1da177e4c3f41 Linus Torvalds  2005-04-16  393  		return -EFAULT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  394  
^1da177e4c3f41 Linus Torvalds  2005-04-16  395  	return copy_to_user(optval, &val, len) ? -EFAULT : 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  396  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  397  

:::::: The code at line 309 was first introduced by commit
:::::: 32288eb4d940b10e40c6d4178fe3a40d1437d2f8 netrom: avoid overflows in nr_setsockopt()

:::::: TO: Xi Wang <xi.wang@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--RnlQjJ0d97Da+TV1--
