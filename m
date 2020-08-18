Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BB9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 046BF20658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgHRHF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:05:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:5362 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgHRHF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:05:56 -0400
IronPort-SDR: hea/rvP8r/4189/5lS5ZC080VxkpmQDYFQJe+CbcTR8PE4XFM4ihwNcdhOiHqVdYI73C3Z7Dub
 XRSvT31Af4gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="239677181"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="gz'50?scan'50,208,50";a="239677181"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 23:52:38 -0700
IronPort-SDR: 4RliSa213J2qTsQpaqhRRhm2QMSOG/rY858FS5VriZz1H4Atl9EAMukYxaSTi12p8rbpEUWbGM
 3KEpvYpYo6WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="gz'50?scan'50,208,50";a="496743235"
Received: from lkp-server02.sh.intel.com (HELO 2f0d8b563e65) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2020 23:52:36 -0700
Received: from kbuild by 2f0d8b563e65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k7vU3-00013K-Og; Tue, 18 Aug 2020 06:52:35 +0000
Date:   Tue, 18 Aug 2020 14:51:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/md/dm-ioctl.c:1783:36: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202008181429.nvYd1HHz%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06a4ec1d9dc652e17ee3ac2ceb6c7cf6c2b75cdd
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   9 weeks ago
config: sh-randconfig-s031-20200818 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-180-g49f7e13a-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/md/dm-ioctl.c:1783:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __user *__cl_addr @@
   drivers/md/dm-ioctl.c:1783:36: sparse:     expected void *addr
>> drivers/md/dm-ioctl.c:1783:36: sparse:     got void [noderef] __user *__cl_addr
   drivers/md/dm-ioctl.c:1798:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __user *__cl_addr @@
   drivers/md/dm-ioctl.c:1798:28: sparse:     expected void *addr
   drivers/md/dm-ioctl.c:1798:28: sparse:     got void [noderef] __user *__cl_addr
--
   drivers/hid/hidraw.c:389:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/hid/hidraw.c:389:37: sparse:     expected int const *__gu_addr
   drivers/hid/hidraw.c:389:37: sparse:     got int [noderef] __user *
>> drivers/hid/hidraw.c:389:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> drivers/hid/hidraw.c:389:37: sparse:     expected void const volatile [noderef] __user *
   drivers/hid/hidraw.c:389:37: sparse:     got int const *__gu_addr
--
   kernel/bpf/cgroup.c:1402:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   kernel/bpf/cgroup.c:1402:21: sparse:     expected int const *__gu_addr
   kernel/bpf/cgroup.c:1402:21: sparse:     got int [noderef] __user *optlen
>> kernel/bpf/cgroup.c:1402:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> kernel/bpf/cgroup.c:1402:21: sparse:     expected void const volatile [noderef] __user *
   kernel/bpf/cgroup.c:1402:21: sparse:     got int const *__gu_addr
--
   fs/ext4/ioctl.c:609:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/ext4/ioctl.c:609:13: sparse:     expected unsigned int const *__gu_addr
   fs/ext4/ioctl.c:609:13: sparse:     got unsigned int [noderef] [usertype] __user *
>> fs/ext4/ioctl.c:609:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> fs/ext4/ioctl.c:609:13: sparse:     expected void const volatile [noderef] __user *
   fs/ext4/ioctl.c:609:13: sparse:     got unsigned int const *__gu_addr
   fs/ext4/ioctl.c:833:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext4/ioctl.c:833:21: sparse:     expected int const *__gu_addr
   fs/ext4/ioctl.c:833:21: sparse:     got int [noderef] __user *
>> fs/ext4/ioctl.c:833:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   fs/ext4/ioctl.c:833:21: sparse:     expected void const volatile [noderef] __user *
   fs/ext4/ioctl.c:833:21: sparse:     got int const *__gu_addr
   fs/ext4/ioctl.c:884:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext4/ioctl.c:884:21: sparse:     expected int const *__gu_addr
   fs/ext4/ioctl.c:884:21: sparse:     got int [noderef] __user *
   fs/ext4/ioctl.c:884:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   fs/ext4/ioctl.c:884:21: sparse:     expected void const volatile [noderef] __user *
   fs/ext4/ioctl.c:884:21: sparse:     got int const *__gu_addr
   fs/ext4/ioctl.c:917:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/ext4/ioctl.c:917:21: sparse:     expected unsigned int const *__gu_addr
   fs/ext4/ioctl.c:917:21: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/ext4/ioctl.c:917:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   fs/ext4/ioctl.c:917:21: sparse:     expected void const volatile [noderef] __user *
   fs/ext4/ioctl.c:917:21: sparse:     got unsigned int const *__gu_addr
--
   fs/ext2/ioctl.c:47:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext2/ioctl.c:47:21: sparse:     expected int const *__gu_addr
   fs/ext2/ioctl.c:47:21: sparse:     got int [noderef] __user *
>> fs/ext2/ioctl.c:47:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> fs/ext2/ioctl.c:47:21: sparse:     expected void const volatile [noderef] __user *
   fs/ext2/ioctl.c:47:21: sparse:     got int const *__gu_addr
   fs/ext2/ioctl.c:92:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext2/ioctl.c:92:21: sparse:     expected int const *__gu_addr
   fs/ext2/ioctl.c:92:21: sparse:     got int [noderef] __user *
   fs/ext2/ioctl.c:92:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   fs/ext2/ioctl.c:92:21: sparse:     expected void const volatile [noderef] __user *
   fs/ext2/ioctl.c:92:21: sparse:     got int const *__gu_addr
   fs/ext2/ioctl.c:123:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext2/ioctl.c:123:21: sparse:     expected int const *__gu_addr
   fs/ext2/ioctl.c:123:21: sparse:     got int [noderef] __user *
   fs/ext2/ioctl.c:123:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   fs/ext2/ioctl.c:123:21: sparse:     expected void const volatile [noderef] __user *
   fs/ext2/ioctl.c:123:21: sparse:     got int const *__gu_addr
--
   fs/fat/file.c:44:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *user_attr @@
   fs/fat/file.c:44:15: sparse:     expected unsigned int const *__gu_addr
   fs/fat/file.c:44:15: sparse:     got unsigned int [noderef] [usertype] __user *user_attr
>> fs/fat/file.c:44:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> fs/fat/file.c:44:15: sparse:     expected void const volatile [noderef] __user *
   fs/fat/file.c:44:15: sparse:     got unsigned int const *__gu_addr
--
   fs/jfs/ioctl.c:83:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/jfs/ioctl.c:83:21: sparse:     expected int const *__gu_addr
   fs/jfs/ioctl.c:83:21: sparse:     got int [noderef] __user *
>> fs/jfs/ioctl.c:83:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> fs/jfs/ioctl.c:83:21: sparse:     expected void const volatile [noderef] __user *
   fs/jfs/ioctl.c:83:21: sparse:     got int const *__gu_addr
--
   fs/xfs/xfs_ioctl.c:2249:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/xfs/xfs_ioctl.c:2249:21: sparse:     expected unsigned int const *__gu_addr
   fs/xfs/xfs_ioctl.c:2249:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> fs/xfs/xfs_ioctl.c:2249:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> fs/xfs/xfs_ioctl.c:2249:21: sparse:     expected void const volatile [noderef] __user *
   fs/xfs/xfs_ioctl.c:2249:21: sparse:     got unsigned int const *__gu_addr
--
   fs/nilfs2/ioctl.c:138:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/nilfs2/ioctl.c:138:13: sparse:     expected int const *__gu_addr
   fs/nilfs2/ioctl.c:138:13: sparse:     got int [noderef] __user *
>> fs/nilfs2/ioctl.c:138:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> fs/nilfs2/ioctl.c:138:13: sparse:     expected void const volatile [noderef] __user *
   fs/nilfs2/ioctl.c:138:13: sparse:     got int const *__gu_addr
--
   net/bluetooth/hci_core.c:2090:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   net/bluetooth/hci_core.c:2090:13: sparse:     expected unsigned short const *__gu_addr
   net/bluetooth/hci_core.c:2090:13: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/bluetooth/hci_core.c:2090:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned short const *__gu_addr @@
>> net/bluetooth/hci_core.c:2090:13: sparse:     expected void const volatile [noderef] __user *
   net/bluetooth/hci_core.c:2090:13: sparse:     got unsigned short const *__gu_addr
--
   drivers/input/mousedev.c:683:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/input/mousedev.c:683:21: sparse:     expected char const *__gu_addr
   drivers/input/mousedev.c:683:21: sparse:     got char const [noderef] __user *
>> drivers/input/mousedev.c:683:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
>> drivers/input/mousedev.c:683:21: sparse:     expected void const volatile [noderef] __user *
   drivers/input/mousedev.c:683:21: sparse:     got char const *__gu_addr
--
   drivers/input/joydev.c:528:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/input/joydev.c:528:24: sparse:     expected signed int const *__gu_addr
   drivers/input/joydev.c:528:24: sparse:     got signed int [noderef] [usertype] __user *
>> drivers/input/joydev.c:528:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got signed int const *__gu_addr @@
>> drivers/input/joydev.c:528:24: sparse:     expected void const volatile [noderef] __user *
   drivers/input/joydev.c:528:24: sparse:     got signed int const *__gu_addr
   drivers/input/joydev.c:680:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long const *__gu_addr @@     got long [noderef] __user * @@
   drivers/input/joydev.c:680:26: sparse:     expected long const *__gu_addr
   drivers/input/joydev.c:680:26: sparse:     got long [noderef] __user *
>> drivers/input/joydev.c:680:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got long const *__gu_addr @@
   drivers/input/joydev.c:680:26: sparse:     expected void const volatile [noderef] __user *
   drivers/input/joydev.c:680:26: sparse:     got long const *__gu_addr
--
   drivers/input/evdev.c:854:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/input/evdev.c:854:13: sparse:     expected int const *__gu_addr
   drivers/input/evdev.c:854:13: sparse:     got int [noderef] __user *
>> drivers/input/evdev.c:854:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> drivers/input/evdev.c:854:13: sparse:     expected void const volatile [noderef] __user *
   drivers/input/evdev.c:854:13: sparse:     got int const *__gu_addr
   drivers/input/evdev.c:928:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/input/evdev.c:928:13: sparse:     expected int const *__gu_addr
   drivers/input/evdev.c:928:13: sparse:     got int [noderef] __user *
   drivers/input/evdev.c:928:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/input/evdev.c:928:13: sparse:     expected void const volatile [noderef] __user *
   drivers/input/evdev.c:928:13: sparse:     got int const *__gu_addr
>> drivers/input/evdev.c:1023:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __user *__cl_addr @@
   drivers/input/evdev.c:1023:21: sparse:     expected void *addr
>> drivers/input/evdev.c:1023:21: sparse:     got void [noderef] __user *__cl_addr
   drivers/input/evdev.c:1066:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/input/evdev.c:1066:21: sparse:     expected int const *__gu_addr
   drivers/input/evdev.c:1066:21: sparse:     got int [noderef] __user *ip
   drivers/input/evdev.c:1066:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/input/evdev.c:1066:21: sparse:     expected void const volatile [noderef] __user *
   drivers/input/evdev.c:1066:21: sparse:     got int const *__gu_addr
   drivers/input/evdev.c:1068:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/input/evdev.c:1068:21: sparse:     expected int const *__gu_addr
   drivers/input/evdev.c:1068:21: sparse:     got int [noderef] __user *
   drivers/input/evdev.c:1068:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/input/evdev.c:1068:21: sparse:     expected void const volatile [noderef] __user *
   drivers/input/evdev.c:1068:21: sparse:     got int const *__gu_addr
--
   net/phonet/datagram.c:47:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/phonet/datagram.c:47:29: sparse:     expected unsigned int const *__gu_addr
   net/phonet/datagram.c:47:29: sparse:     got unsigned int [noderef] [usertype] __user *
>> net/phonet/datagram.c:47:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> net/phonet/datagram.c:47:29: sparse:     expected void const volatile [noderef] __user *
   net/phonet/datagram.c:47:29: sparse:     got unsigned int const *__gu_addr
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

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=670d0a4b10704667765f7d18f7592993d02783aa
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 670d0a4b10704667765f7d18f7592993d02783aa
vim +1783 drivers/md/dm-ioctl.c

9c5091f2eeeffe Mikulas Patocka   2012-12-21  1747  
02cde50b7ea745 Mikulas Patocka   2013-03-01  1748  static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kernel,
800a7340ab7dd6 Wenwen Wang       2018-10-03  1749  		       int ioctl_flags, struct dm_ioctl **param, int *param_flags)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1750  {
02cde50b7ea745 Mikulas Patocka   2013-03-01  1751  	struct dm_ioctl *dmi;
f868120549fc16 Milan Broz        2011-03-24  1752  	int secure_data;
6080758d441acd Bart Van Assche   2016-11-18  1753  	const size_t minimum_data_size = offsetof(struct dm_ioctl, data);
d224e938189771 Michal Hocko      2017-05-08  1754  	unsigned noio_flag;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1755  
02cde50b7ea745 Mikulas Patocka   2013-03-01  1756  	if (copy_from_user(param_kernel, user, minimum_data_size))
^1da177e4c3f41 Linus Torvalds    2005-04-16  1757  		return -EFAULT;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1758  
02cde50b7ea745 Mikulas Patocka   2013-03-01  1759  	if (param_kernel->data_size < minimum_data_size)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1760  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1761  
02cde50b7ea745 Mikulas Patocka   2013-03-01  1762  	secure_data = param_kernel->flags & DM_SECURE_DATA_FLAG;
f868120549fc16 Milan Broz        2011-03-24  1763  
9c5091f2eeeffe Mikulas Patocka   2012-12-21  1764  	*param_flags = secure_data ? DM_WIPE_BUFFER : 0;
9c5091f2eeeffe Mikulas Patocka   2012-12-21  1765  
02cde50b7ea745 Mikulas Patocka   2013-03-01  1766  	if (ioctl_flags & IOCTL_FLAGS_NO_PARAMS) {
02cde50b7ea745 Mikulas Patocka   2013-03-01  1767  		dmi = param_kernel;
02cde50b7ea745 Mikulas Patocka   2013-03-01  1768  		dmi->data_size = minimum_data_size;
02cde50b7ea745 Mikulas Patocka   2013-03-01  1769  		goto data_copied;
02cde50b7ea745 Mikulas Patocka   2013-03-01  1770  	}
02cde50b7ea745 Mikulas Patocka   2013-03-01  1771  
5023e5cf58e1da Mikulas Patocka   2012-12-21  1772  	/*
8c1e2162f27b31 Junaid Shahid     2017-05-18  1773  	 * Use __GFP_HIGH to avoid low memory issues when a device is
8c1e2162f27b31 Junaid Shahid     2017-05-18  1774  	 * suspended and the ioctl is needed to resume it.
9c5091f2eeeffe Mikulas Patocka   2012-12-21  1775  	 * Use kmalloc() rather than vmalloc() when we can.
5023e5cf58e1da Mikulas Patocka   2012-12-21  1776  	 */
9c5091f2eeeffe Mikulas Patocka   2012-12-21  1777  	dmi = NULL;
1c0e883e86ece3 Mikulas Patocka   2013-07-10  1778  	noio_flag = memalloc_noio_save();
8c1e2162f27b31 Junaid Shahid     2017-05-18  1779  	dmi = kvmalloc(param_kernel->data_size, GFP_KERNEL | __GFP_HIGH);
1c0e883e86ece3 Mikulas Patocka   2013-07-10  1780  	memalloc_noio_restore(noio_flag);
9c5091f2eeeffe Mikulas Patocka   2012-12-21  1781  
f868120549fc16 Milan Broz        2011-03-24  1782  	if (!dmi) {
02cde50b7ea745 Mikulas Patocka   2013-03-01 @1783  		if (secure_data && clear_user(user, param_kernel->data_size))
f868120549fc16 Milan Broz        2011-03-24  1784  			return -EFAULT;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1785  		return -ENOMEM;
f868120549fc16 Milan Broz        2011-03-24  1786  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  1787  
028b39e314dd8b Bart Van Assche   2016-06-28  1788  	*param_flags |= DM_PARAMS_MALLOC;
028b39e314dd8b Bart Van Assche   2016-06-28  1789  
800a7340ab7dd6 Wenwen Wang       2018-10-03  1790  	/* Copy from param_kernel (which was already copied from user) */
800a7340ab7dd6 Wenwen Wang       2018-10-03  1791  	memcpy(dmi, param_kernel, minimum_data_size);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1792  
800a7340ab7dd6 Wenwen Wang       2018-10-03  1793  	if (copy_from_user(&dmi->data, (char __user *)user + minimum_data_size,
800a7340ab7dd6 Wenwen Wang       2018-10-03  1794  			   param_kernel->data_size - minimum_data_size))
e910d7ebecd1aa Alasdair G Kergon 2012-12-21  1795  		goto bad;
800a7340ab7dd6 Wenwen Wang       2018-10-03  1796  data_copied:
f868120549fc16 Milan Broz        2011-03-24  1797  	/* Wipe the user buffer so we do not return it to userspace */
02cde50b7ea745 Mikulas Patocka   2013-03-01  1798  	if (secure_data && clear_user(user, param_kernel->data_size))
f868120549fc16 Milan Broz        2011-03-24  1799  		goto bad;
f868120549fc16 Milan Broz        2011-03-24  1800  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1801  	*param = dmi;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1802  	return 0;
6bb43b5d1f54fb Milan Broz        2011-03-24  1803  
6bb43b5d1f54fb Milan Broz        2011-03-24  1804  bad:
02cde50b7ea745 Mikulas Patocka   2013-03-01  1805  	free_params(dmi, param_kernel->data_size, *param_flags);
9c5091f2eeeffe Mikulas Patocka   2012-12-21  1806  
6bb43b5d1f54fb Milan Broz        2011-03-24  1807  	return -EFAULT;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1808  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  1809  

:::::: The code at line 1783 was first introduced by commit
:::::: 02cde50b7ea74557d32ff778c73809322445ccd2 dm ioctl: optimize functions without variable params

:::::: TO: Mikulas Patocka <mpatocka@redhat.com>
:::::: CC: Alasdair G Kergon <agk@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--nFreZHaLTZJo0R7j
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
lv8fAI3WmcfnAQA=

--nFreZHaLTZJo0R7j--
