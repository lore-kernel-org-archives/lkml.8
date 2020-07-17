Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B6BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FB92070A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGQMxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:53:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:36821 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgGQMxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:53:08 -0400
IronPort-SDR: Bggb/Pb+aegY/qcBAgXcHNA60v2FD8DyLpd+j2djqDm/dzmTQYk+btHzNZJLYl49gy77ZiWW2l
 93NkZTej+6EQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="234432923"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="gz'50?scan'50,208,50";a="234432923"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 05:52:31 -0700
IronPort-SDR: K7BwbN3FOdoftIErbovBMkn00Kkz/Q+mHIp7R6oXXDR6rHnw/7+lOBm3l1VnnS3rOoeRRHLnjY
 Tjv9f8U8rorw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="gz'50?scan'50,208,50";a="430831998"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Jul 2020 05:52:28 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwPqm-0000J7-AZ; Fri, 17 Jul 2020 12:52:28 +0000
Date:   Fri, 17 Jul 2020 20:51:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/misc/cxl/flash.c:294:42: sparse: sparse: incorrect type in
 argument 2 (different address spaces)
Message-ID: <202007172041.Zz1eNB2Y%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8882572675c1bb1cc544f4e229a11661f1fc52e4
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   4 weeks ago
config: powerpc64-randconfig-s031-20200717 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-49-g707c5017-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/misc/cxl/flash.c:95:9: sparse: sparse: cast to restricted __be32
   drivers/misc/cxl/flash.c:243:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] version @@     got restricted __be16 [usertype] @@
   drivers/misc/cxl/flash.c:243:33: sparse:     expected unsigned short [usertype] version
   drivers/misc/cxl/flash.c:243:33: sparse:     got restricted __be16 [usertype]
   drivers/misc/cxl/flash.c:244:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] vendor @@     got restricted __be16 [usertype] @@
   drivers/misc/cxl/flash.c:244:32: sparse:     expected unsigned short [usertype] vendor
   drivers/misc/cxl/flash.c:244:32: sparse:     got restricted __be16 [usertype]
   drivers/misc/cxl/flash.c:245:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] device @@     got restricted __be16 [usertype] @@
   drivers/misc/cxl/flash.c:245:32: sparse:     expected unsigned short [usertype] device
   drivers/misc/cxl/flash.c:245:32: sparse:     got restricted __be16 [usertype]
   drivers/misc/cxl/flash.c:246:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] subsystem_vendor @@     got restricted __be16 [usertype] @@
   drivers/misc/cxl/flash.c:246:42: sparse:     expected unsigned short [usertype] subsystem_vendor
   drivers/misc/cxl/flash.c:246:42: sparse:     got restricted __be16 [usertype]
   drivers/misc/cxl/flash.c:247:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] subsystem @@     got restricted __be16 [usertype] @@
   drivers/misc/cxl/flash.c:247:35: sparse:     expected unsigned short [usertype] subsystem
   drivers/misc/cxl/flash.c:247:35: sparse:     got restricted __be16 [usertype]
   drivers/misc/cxl/flash.c:248:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] image_offset @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/flash.c:248:38: sparse:     expected unsigned long long [usertype] image_offset
   drivers/misc/cxl/flash.c:248:38: sparse:     got restricted __be64 [usertype]
   drivers/misc/cxl/flash.c:249:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] image_length @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/flash.c:249:38: sparse:     expected unsigned long long [usertype] image_length
   drivers/misc/cxl/flash.c:249:38: sparse:     got restricted __be64 [usertype]
>> drivers/misc/cxl/flash.c:294:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void *[assigned] from @@
>> drivers/misc/cxl/flash.c:294:42: sparse:     expected void const [noderef] __user *from
   drivers/misc/cxl/flash.c:294:42: sparse:     got void *[assigned] from
   drivers/misc/cxl/flash.c:298:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] phys_addr @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/flash.c:298:33: sparse:     expected unsigned long long [usertype] phys_addr
   drivers/misc/cxl/flash.c:298:33: sparse:     got restricted __be64 [usertype]
   drivers/misc/cxl/flash.c:299:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] len @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/flash.c:299:27: sparse:     expected unsigned long long [usertype] len
   drivers/misc/cxl/flash.c:299:27: sparse:     got restricted __be64 [usertype]
   drivers/misc/cxl/flash.c:301:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] len @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/flash.c:301:35: sparse:     expected unsigned long long [usertype] len
   drivers/misc/cxl/flash.c:301:35: sparse:     got restricted __be64 [usertype]
--
   drivers/misc/cxl/guest.c:104:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] phys_addr @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/guest.c:104:33: sparse:     expected unsigned long long [usertype] phys_addr
   drivers/misc/cxl/guest.c:104:33: sparse:     got restricted __be64 [usertype]
   drivers/misc/cxl/guest.c:105:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] len @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/guest.c:105:27: sparse:     expected unsigned long long [usertype] len
   drivers/misc/cxl/guest.c:105:27: sparse:     got restricted __be64 [usertype]
   drivers/misc/cxl/guest.c:107:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] len @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/guest.c:107:35: sparse:     expected unsigned long long [usertype] len
   drivers/misc/cxl/guest.c:107:35: sparse:     got restricted __be64 [usertype]
>> drivers/misc/cxl/guest.c:439:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got unsigned short [usertype] * @@
>> drivers/misc/cxl/guest.c:439:33: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/misc/cxl/guest.c:439:33: sparse:     got unsigned short [usertype] *
>> drivers/misc/cxl/guest.c:442:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int * @@
>> drivers/misc/cxl/guest.c:442:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/misc/cxl/guest.c:442:33: sparse:     got unsigned int *
>> drivers/misc/cxl/guest.c:445:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr @@     got unsigned long long [usertype] * @@
>> drivers/misc/cxl/guest.c:445:33: sparse:     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr
   drivers/misc/cxl/guest.c:445:33: sparse:     got unsigned long long [usertype] *
   drivers/misc/cxl/guest.c:533:23: sparse: sparse: invalid assignment: |=
   drivers/misc/cxl/guest.c:533:23: sparse:    left side has type restricted __be64
   drivers/misc/cxl/guest.c:533:23: sparse:    right side has type unsigned long long
   drivers/misc/cxl/guest.c:534:23: sparse: sparse: invalid assignment: |=
   drivers/misc/cxl/guest.c:534:23: sparse:    left side has type restricted __be64
   drivers/misc/cxl/guest.c:534:23: sparse:    right side has type unsigned long long
   drivers/misc/cxl/guest.c:536:31: sparse: sparse: invalid assignment: |=
   drivers/misc/cxl/guest.c:536:31: sparse:    left side has type restricted __be64
   drivers/misc/cxl/guest.c:536:31: sparse:    right side has type unsigned long long
   drivers/misc/cxl/guest.c:539:23: sparse: sparse: invalid assignment: |=
   drivers/misc/cxl/guest.c:539:23: sparse:    left side has type restricted __be64
   drivers/misc/cxl/guest.c:539:23: sparse:    right side has type unsigned long long
   drivers/misc/cxl/guest.c:540:23: sparse: sparse: invalid assignment: |=
   drivers/misc/cxl/guest.c:540:23: sparse:    left side has type restricted __be64
   drivers/misc/cxl/guest.c:540:23: sparse:    right side has type unsigned long long
   drivers/misc/cxl/guest.c:542:31: sparse: sparse: invalid assignment: |=
   drivers/misc/cxl/guest.c:542:31: sparse:    left side has type restricted __be64
   drivers/misc/cxl/guest.c:542:31: sparse:    right side has type unsigned long long
   drivers/misc/cxl/guest.c:545:31: sparse: sparse: invalid assignment: |=
   drivers/misc/cxl/guest.c:545:31: sparse:    left side has type restricted __be64
   drivers/misc/cxl/guest.c:545:31: sparse:    right side has type unsigned long long
   drivers/misc/cxl/guest.c:548:31: sparse: sparse: cast from restricted __be64
--
   arch/powerpc/platforms/pasemi/dma_lib.c:364:57: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned long long [usertype] dma_handle @@     got restricted gfp_t @@
   arch/powerpc/platforms/pasemi/dma_lib.c:364:57: sparse:     expected unsigned long long [usertype] dma_handle
   arch/powerpc/platforms/pasemi/dma_lib.c:364:57: sparse:     got restricted gfp_t
>> arch/powerpc/platforms/pasemi/dma_lib.c:481:16: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem *[assigned] ret @@
   arch/powerpc/platforms/pasemi/dma_lib.c:481:16: sparse:     expected void *
>> arch/powerpc/platforms/pasemi/dma_lib.c:481:16: sparse:     got void [noderef] __iomem *[assigned] ret
>> arch/powerpc/platforms/pasemi/dma_lib.c:487:23: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/powerpc/platforms/pasemi/dma_lib.c:487:23: sparse:     expected void *
>> arch/powerpc/platforms/pasemi/dma_lib.c:487:23: sparse:     got void [noderef] __iomem *
>> arch/powerpc/platforms/pasemi/dma_lib.c:524:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *static [toplevel] iob_regs @@     got void * @@
>> arch/powerpc/platforms/pasemi/dma_lib.c:524:18: sparse:     expected void [noderef] __iomem *static [toplevel] iob_regs
   arch/powerpc/platforms/pasemi/dma_lib.c:524:18: sparse:     got void *
>> arch/powerpc/platforms/pasemi/dma_lib.c:533:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *static [toplevel] dma_regs @@     got void * @@
>> arch/powerpc/platforms/pasemi/dma_lib.c:533:18: sparse:     expected void [noderef] __iomem *static [toplevel] dma_regs
   arch/powerpc/platforms/pasemi/dma_lib.c:533:18: sparse:     got void *
>> arch/powerpc/platforms/pasemi/dma_lib.c:546:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
>> arch/powerpc/platforms/pasemi/dma_lib.c:546:34: sparse:     expected void [noderef] __iomem *
   arch/powerpc/platforms/pasemi/dma_lib.c:546:34: sparse:     got void *
   arch/powerpc/platforms/pasemi/dma_lib.c:553:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/powerpc/platforms/pasemi/dma_lib.c:553:34: sparse:     expected void [noderef] __iomem *
   arch/powerpc/platforms/pasemi/dma_lib.c:553:34: sparse:     got void *
>> arch/powerpc/platforms/pasemi/dma_lib.c:565:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct pasdma_status *static [toplevel] dma_status @@     got void [noderef] __iomem * @@
   arch/powerpc/platforms/pasemi/dma_lib.c:565:20: sparse:     expected struct pasdma_status *static [toplevel] dma_status
   arch/powerpc/platforms/pasemi/dma_lib.c:565:20: sparse:     got void [noderef] __iomem *
--
   arch/powerpc/platforms/cell/spu_syscalls.c:154:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> arch/powerpc/platforms/cell/spu_syscalls.c:154:9: sparse:    struct spufs_calls [noderef] __rcu *
   arch/powerpc/platforms/cell/spu_syscalls.c:154:9: sparse:    struct spufs_calls *
   arch/powerpc/platforms/cell/spu_syscalls.c:162:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   arch/powerpc/platforms/cell/spu_syscalls.c:162:9: sparse:    struct spufs_calls [noderef] __rcu *
   arch/powerpc/platforms/cell/spu_syscalls.c:162:9: sparse:    struct spufs_calls *
--
>> arch/powerpc/platforms/cell/spufs/file.c:277:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got char * @@
>> arch/powerpc/platforms/cell/spufs/file.c:277:41: sparse:     expected void volatile [noderef] __iomem *d
   arch/powerpc/platforms/cell/spufs/file.c:277:41: sparse:     got char *
>> arch/powerpc/platforms/cell/spufs/file.c:279:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *s @@     got char * @@
>> arch/powerpc/platforms/cell/spufs/file.c:279:48: sparse:     expected void const volatile [noderef] __iomem *s
   arch/powerpc/platforms/cell/spufs/file.c:279:48: sparse:     got char *
   arch/powerpc/platforms/cell/spufs/file.c:2442:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got int [assigned] rc @@
   arch/powerpc/platforms/cell/spufs/file.c:2442:24: sparse:     expected restricted __poll_t
   arch/powerpc/platforms/cell/spufs/file.c:2442:24: sparse:     got int [assigned] rc
--
>> arch/powerpc/platforms/ps3/gelic_udbg.c:127:53: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *start @@     got struct debug_block [noderef] __iomem * @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:127:53: sparse:     expected void *start
>> arch/powerpc/platforms/ps3/gelic_udbg.c:127:53: sparse:     got struct debug_block [noderef] __iomem *
>> arch/powerpc/platforms/ps3/gelic_udbg.c:130:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got struct debug_block [noderef] __iomem * @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:130:17: sparse:     expected void *
   arch/powerpc/platforms/ps3/gelic_udbg.c:130:17: sparse:     got struct debug_block [noderef] __iomem *
>> arch/powerpc/platforms/ps3/gelic_udbg.c:132:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 static [addressable] [noderef] [toplevel] [usertype] __iomem buf_addr @@     got unsigned long long @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:132:28: sparse:     expected restricted __be32 static [addressable] [noderef] [toplevel] [usertype] __iomem buf_addr
   arch/powerpc/platforms/ps3/gelic_udbg.c:132:28: sparse:     got unsigned long long
>> arch/powerpc/platforms/ps3/gelic_udbg.c:144:18: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/ps3/gelic_udbg.c:144:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ethhdr [noderef] __iomem *static [toplevel] h_eth @@     got struct ethhdr * @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:144:15: sparse:     expected struct ethhdr [noderef] __iomem *static [toplevel] h_eth
   arch/powerpc/platforms/ps3/gelic_udbg.c:144:15: sparse:     got struct ethhdr *
>> arch/powerpc/platforms/ps3/gelic_udbg.c:146:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned char [usertype] *addr @@     got unsigned char [noderef] __iomem * @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:146:28: sparse:     expected unsigned char [usertype] *addr
>> arch/powerpc/platforms/ps3/gelic_udbg.c:146:28: sparse:     got unsigned char [noderef] __iomem *
>> arch/powerpc/platforms/ps3/gelic_udbg.c:147:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] __iomem ( * )[6] @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:147:17: sparse:     expected void *
>> arch/powerpc/platforms/ps3/gelic_udbg.c:147:17: sparse:     got unsigned char [noderef] __iomem ( * )[6]
>> arch/powerpc/platforms/ps3/gelic_udbg.c:156:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem h_proto @@     got int @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:156:31: sparse:     expected restricted __be16 [noderef] [usertype] __iomem h_proto
   arch/powerpc/platforms/ps3/gelic_udbg.c:156:31: sparse:     got int
   arch/powerpc/platforms/ps3/gelic_udbg.c:159:27: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/ps3/gelic_udbg.c:159:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct vlan_hdr [noderef] __iomem *static [toplevel] h_vlan @@     got struct vlan_hdr * @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:159:24: sparse:     expected struct vlan_hdr [noderef] __iomem *static [toplevel] h_vlan
   arch/powerpc/platforms/ps3/gelic_udbg.c:159:24: sparse:     got struct vlan_hdr *
>> arch/powerpc/platforms/ps3/gelic_udbg.c:160:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem h_vlan_TCI @@     got unsigned long long [addressable] [usertype] vlan_id @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:160:36: sparse:     expected restricted __be16 [noderef] [usertype] __iomem h_vlan_TCI
   arch/powerpc/platforms/ps3/gelic_udbg.c:160:36: sparse:     got unsigned long long [addressable] [usertype] vlan_id
>> arch/powerpc/platforms/ps3/gelic_udbg.c:161:51: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem h_vlan_encapsulated_proto @@     got int @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:161:51: sparse:     expected restricted __be16 [noderef] [usertype] __iomem h_vlan_encapsulated_proto
   arch/powerpc/platforms/ps3/gelic_udbg.c:161:51: sparse:     got int
   arch/powerpc/platforms/ps3/gelic_udbg.c:162:25: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/ps3/gelic_udbg.c:162:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct iphdr [noderef] __iomem *static [toplevel] h_ip @@     got struct iphdr * @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:162:22: sparse:     expected struct iphdr [noderef] __iomem *static [toplevel] h_ip
   arch/powerpc/platforms/ps3/gelic_udbg.c:162:22: sparse:     got struct iphdr *
   arch/powerpc/platforms/ps3/gelic_udbg.c:164:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem h_proto @@     got int @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:164:31: sparse:     expected restricted __be16 [noderef] [usertype] __iomem h_proto
   arch/powerpc/platforms/ps3/gelic_udbg.c:164:31: sparse:     got int
   arch/powerpc/platforms/ps3/gelic_udbg.c:165:25: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:165:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct iphdr [noderef] __iomem *static [toplevel] h_ip @@     got struct iphdr * @@
   arch/powerpc/platforms/ps3/gelic_udbg.c:165:22: sparse:     expected struct iphdr [noderef] __iomem *static [toplevel] h_ip
   arch/powerpc/platforms/ps3/gelic_udbg.c:165:22: sparse:     got struct iphdr *
>> arch/powerpc/platforms/ps3/gelic_udbg.c:174:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [noderef] [usertype] __iomem daddr @@     got unsigned int @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:174:21: sparse:     expected restricted __be32 [noderef] [usertype] __iomem daddr
   arch/powerpc/platforms/ps3/gelic_udbg.c:174:21: sparse:     got unsigned int
   arch/powerpc/platforms/ps3/gelic_udbg.c:177:18: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/ps3/gelic_udbg.c:177:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct udphdr [noderef] __iomem *static [toplevel] h_udp @@     got struct udphdr * @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:177:15: sparse:     expected struct udphdr [noderef] __iomem *static [toplevel] h_udp
   arch/powerpc/platforms/ps3/gelic_udbg.c:177:15: sparse:     got struct udphdr *
>> arch/powerpc/platforms/ps3/gelic_udbg.c:178:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem source @@     got int @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:178:23: sparse:     expected restricted __be16 [noderef] [usertype] __iomem source
   arch/powerpc/platforms/ps3/gelic_udbg.c:178:23: sparse:     got int
>> arch/powerpc/platforms/ps3/gelic_udbg.c:179:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem dest @@     got int @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:179:21: sparse:     expected restricted __be16 [noderef] [usertype] __iomem dest
   arch/powerpc/platforms/ps3/gelic_udbg.c:179:21: sparse:     got int
   arch/powerpc/platforms/ps3/gelic_udbg.c:181:25: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/ps3/gelic_udbg.c:181:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *static [toplevel] pmsg @@     got char * @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:181:22: sparse:     expected char [noderef] __iomem *static [toplevel] pmsg
   arch/powerpc/platforms/ps3/gelic_udbg.c:181:22: sparse:     got char *
>> arch/powerpc/platforms/ps3/gelic_udbg.c:198:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 static [addressable] [noderef] [toplevel] [usertype] __iomem buf_size @@     got int @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:198:28: sparse:     expected restricted __be32 static [addressable] [noderef] [toplevel] [usertype] __iomem buf_size
   arch/powerpc/platforms/ps3/gelic_udbg.c:198:28: sparse:     got int
>> arch/powerpc/platforms/ps3/gelic_udbg.c:199:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem tot_len @@     got unsigned long @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:199:23: sparse:     expected restricted __be16 [noderef] [usertype] __iomem tot_len
   arch/powerpc/platforms/ps3/gelic_udbg.c:199:23: sparse:     got unsigned long
>> arch/powerpc/platforms/ps3/gelic_udbg.c:201:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem len @@     got unsigned long @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:201:20: sparse:     expected restricted __be16 [noderef] [usertype] __iomem len
   arch/powerpc/platforms/ps3/gelic_udbg.c:201:20: sparse:     got unsigned long
   arch/powerpc/platforms/ps3/gelic_udbg.c:205:14: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/ps3/gelic_udbg.c:208:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __sum16 [noderef] [usertype] __iomem check @@     got unsigned int @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:208:21: sparse:     expected restricted __sum16 [noderef] [usertype] __iomem check
   arch/powerpc/platforms/ps3/gelic_udbg.c:208:21: sparse:     got unsigned int
>> arch/powerpc/platforms/ps3/gelic_udbg.c:210:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 static [addressable] [noderef] [toplevel] [usertype] __iomem dmac_cmd_status @@     got unsigned int @@
>> arch/powerpc/platforms/ps3/gelic_udbg.c:210:35: sparse:     expected restricted __be32 static [addressable] [noderef] [toplevel] [usertype] __iomem dmac_cmd_status
   arch/powerpc/platforms/ps3/gelic_udbg.c:210:35: sparse:     got unsigned int
   arch/powerpc/platforms/ps3/gelic_udbg.c:219:26: sparse: sparse: restricted __be32 degrades to integer
   arch/powerpc/platforms/ps3/gelic_udbg.c:169:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:170:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:171:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:172:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:173:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:203:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:212:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:213:9: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:219:17: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/ps3/gelic_udbg.c:226:15: sparse: sparse: dereference of noderef expression

vim +294 drivers/misc/cxl/flash.c

594ff7d067ca42 Christophe Lombard 2016-03-04  226  
594ff7d067ca42 Christophe Lombard 2016-03-04  227  static int handle_image(struct cxl *adapter, int operation,
594ff7d067ca42 Christophe Lombard 2016-03-04  228  			long (*fct)(u64, u64, u64, u64 *),
594ff7d067ca42 Christophe Lombard 2016-03-04  229  			struct cxl_adapter_image *ai)
594ff7d067ca42 Christophe Lombard 2016-03-04  230  {
594ff7d067ca42 Christophe Lombard 2016-03-04  231  	size_t mod, s_copy, len_chunk = 0;
594ff7d067ca42 Christophe Lombard 2016-03-04  232  	struct ai_header *header = NULL;
594ff7d067ca42 Christophe Lombard 2016-03-04  233  	unsigned int entries = 0, i;
594ff7d067ca42 Christophe Lombard 2016-03-04  234  	void *dest, *from;
594ff7d067ca42 Christophe Lombard 2016-03-04  235  	int rc = 0, need_header;
594ff7d067ca42 Christophe Lombard 2016-03-04  236  
594ff7d067ca42 Christophe Lombard 2016-03-04  237  	/* base adapter image header */
594ff7d067ca42 Christophe Lombard 2016-03-04  238  	need_header = (ai->flags & CXL_AI_NEED_HEADER);
594ff7d067ca42 Christophe Lombard 2016-03-04  239  	if (need_header) {
594ff7d067ca42 Christophe Lombard 2016-03-04  240  		header = kzalloc(sizeof(struct ai_header), GFP_KERNEL);
594ff7d067ca42 Christophe Lombard 2016-03-04  241  		if (!header)
594ff7d067ca42 Christophe Lombard 2016-03-04  242  			return -ENOMEM;
594ff7d067ca42 Christophe Lombard 2016-03-04  243  		header->version = cpu_to_be16(1);
594ff7d067ca42 Christophe Lombard 2016-03-04  244  		header->vendor = cpu_to_be16(adapter->guest->vendor);
594ff7d067ca42 Christophe Lombard 2016-03-04  245  		header->device = cpu_to_be16(adapter->guest->device);
594ff7d067ca42 Christophe Lombard 2016-03-04  246  		header->subsystem_vendor = cpu_to_be16(adapter->guest->subsystem_vendor);
594ff7d067ca42 Christophe Lombard 2016-03-04 @247  		header->subsystem = cpu_to_be16(adapter->guest->subsystem);
594ff7d067ca42 Christophe Lombard 2016-03-04  248  		header->image_offset = cpu_to_be64(CXL_AI_HEADER_SIZE);
594ff7d067ca42 Christophe Lombard 2016-03-04  249  		header->image_length = cpu_to_be64(ai->len_image);
594ff7d067ca42 Christophe Lombard 2016-03-04  250  	}
594ff7d067ca42 Christophe Lombard 2016-03-04  251  
594ff7d067ca42 Christophe Lombard 2016-03-04  252  	/* number of entries in the list */
594ff7d067ca42 Christophe Lombard 2016-03-04  253  	len_chunk = ai->len_data;
594ff7d067ca42 Christophe Lombard 2016-03-04  254  	if (need_header)
594ff7d067ca42 Christophe Lombard 2016-03-04  255  		len_chunk += CXL_AI_HEADER_SIZE;
594ff7d067ca42 Christophe Lombard 2016-03-04  256  
594ff7d067ca42 Christophe Lombard 2016-03-04  257  	entries = len_chunk / CXL_AI_BUFFER_SIZE;
594ff7d067ca42 Christophe Lombard 2016-03-04  258  	mod = len_chunk % CXL_AI_BUFFER_SIZE;
594ff7d067ca42 Christophe Lombard 2016-03-04  259  	if (mod)
594ff7d067ca42 Christophe Lombard 2016-03-04  260  		entries++;
594ff7d067ca42 Christophe Lombard 2016-03-04  261  
594ff7d067ca42 Christophe Lombard 2016-03-04  262  	if (entries > CXL_AI_MAX_ENTRIES) {
594ff7d067ca42 Christophe Lombard 2016-03-04  263  		rc = -EINVAL;
594ff7d067ca42 Christophe Lombard 2016-03-04  264  		goto err;
594ff7d067ca42 Christophe Lombard 2016-03-04  265  	}
594ff7d067ca42 Christophe Lombard 2016-03-04  266  
594ff7d067ca42 Christophe Lombard 2016-03-04  267  	/*          < -- MAX_CHUNK_SIZE = 4096 * 256 = 1048576 bytes -->
594ff7d067ca42 Christophe Lombard 2016-03-04  268  	 * chunk 0  ----------------------------------------------------
594ff7d067ca42 Christophe Lombard 2016-03-04  269  	 *          | header   |  data                                 |
594ff7d067ca42 Christophe Lombard 2016-03-04  270  	 *          ----------------------------------------------------
594ff7d067ca42 Christophe Lombard 2016-03-04  271  	 * chunk 1  ----------------------------------------------------
594ff7d067ca42 Christophe Lombard 2016-03-04  272  	 *          | data                                             |
594ff7d067ca42 Christophe Lombard 2016-03-04  273  	 *          ----------------------------------------------------
594ff7d067ca42 Christophe Lombard 2016-03-04  274  	 * ....
594ff7d067ca42 Christophe Lombard 2016-03-04  275  	 * chunk n  ----------------------------------------------------
594ff7d067ca42 Christophe Lombard 2016-03-04  276  	 *          | data                                             |
594ff7d067ca42 Christophe Lombard 2016-03-04  277  	 *          ----------------------------------------------------
594ff7d067ca42 Christophe Lombard 2016-03-04  278  	 */
594ff7d067ca42 Christophe Lombard 2016-03-04  279  	from = (void *) ai->data;
594ff7d067ca42 Christophe Lombard 2016-03-04  280  	for (i = 0; i < entries; i++) {
594ff7d067ca42 Christophe Lombard 2016-03-04  281  		dest = buffer[i];
594ff7d067ca42 Christophe Lombard 2016-03-04  282  		s_copy = CXL_AI_BUFFER_SIZE;
594ff7d067ca42 Christophe Lombard 2016-03-04  283  
594ff7d067ca42 Christophe Lombard 2016-03-04  284  		if ((need_header) && (i == 0)) {
594ff7d067ca42 Christophe Lombard 2016-03-04  285  			/* add adapter image header */
594ff7d067ca42 Christophe Lombard 2016-03-04  286  			memcpy(buffer[i], header, sizeof(struct ai_header));
594ff7d067ca42 Christophe Lombard 2016-03-04  287  			s_copy = CXL_AI_BUFFER_SIZE - CXL_AI_HEADER_SIZE;
594ff7d067ca42 Christophe Lombard 2016-03-04  288  			dest += CXL_AI_HEADER_SIZE; /* image offset */
594ff7d067ca42 Christophe Lombard 2016-03-04  289  		}
594ff7d067ca42 Christophe Lombard 2016-03-04  290  		if ((i == (entries - 1)) && mod)
594ff7d067ca42 Christophe Lombard 2016-03-04  291  			s_copy = mod;
594ff7d067ca42 Christophe Lombard 2016-03-04  292  
594ff7d067ca42 Christophe Lombard 2016-03-04  293  		/* copy data */
594ff7d067ca42 Christophe Lombard 2016-03-04 @294  		if (copy_from_user(dest, from, s_copy))
594ff7d067ca42 Christophe Lombard 2016-03-04  295  			goto err;
594ff7d067ca42 Christophe Lombard 2016-03-04  296  
594ff7d067ca42 Christophe Lombard 2016-03-04  297  		/* fill in the list */
594ff7d067ca42 Christophe Lombard 2016-03-04  298  		le[i].phys_addr = cpu_to_be64(virt_to_phys(buffer[i]));
594ff7d067ca42 Christophe Lombard 2016-03-04  299  		le[i].len = cpu_to_be64(CXL_AI_BUFFER_SIZE);
594ff7d067ca42 Christophe Lombard 2016-03-04  300  		if ((i == (entries - 1)) && mod)
594ff7d067ca42 Christophe Lombard 2016-03-04  301  			le[i].len = cpu_to_be64(mod);
594ff7d067ca42 Christophe Lombard 2016-03-04  302  		from += s_copy;
594ff7d067ca42 Christophe Lombard 2016-03-04  303  	}
594ff7d067ca42 Christophe Lombard 2016-03-04  304  	pr_devel("%s (op: %i, need header: %i, entries: %i, token: %#llx)\n",
594ff7d067ca42 Christophe Lombard 2016-03-04  305  		 __func__, operation, need_header, entries, continue_token);
594ff7d067ca42 Christophe Lombard 2016-03-04  306  
594ff7d067ca42 Christophe Lombard 2016-03-04  307  	/*
594ff7d067ca42 Christophe Lombard 2016-03-04  308  	 * download/validate the adapter image to the coherent
594ff7d067ca42 Christophe Lombard 2016-03-04  309  	 * platform facility
594ff7d067ca42 Christophe Lombard 2016-03-04  310  	 */
594ff7d067ca42 Christophe Lombard 2016-03-04  311  	rc = fct(adapter->guest->handle, virt_to_phys(le), entries,
594ff7d067ca42 Christophe Lombard 2016-03-04  312  		&continue_token);
594ff7d067ca42 Christophe Lombard 2016-03-04  313  	if (rc == 0) /* success of download/validation operation */
594ff7d067ca42 Christophe Lombard 2016-03-04  314  		continue_token = 0;
594ff7d067ca42 Christophe Lombard 2016-03-04  315  
594ff7d067ca42 Christophe Lombard 2016-03-04  316  err:
594ff7d067ca42 Christophe Lombard 2016-03-04  317  	kfree(header);
594ff7d067ca42 Christophe Lombard 2016-03-04  318  
594ff7d067ca42 Christophe Lombard 2016-03-04  319  	return rc;
594ff7d067ca42 Christophe Lombard 2016-03-04  320  }
594ff7d067ca42 Christophe Lombard 2016-03-04  321  

:::::: The code at line 294 was first introduced by commit
:::::: 594ff7d067ca42676e27e2a7b5dcc0ff039d08ca cxl: Support to flash a new image on the adapter from a guest

:::::: TO: Christophe Lombard <clombard@linux.vnet.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ew6BAiZeqk4r7MaW
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ew6BAiZeqk4r7MaW--
