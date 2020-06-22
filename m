Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23C9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6118B2539A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbgFVDDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:03:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:64418 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731112AbgFVDDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 23:03:01 -0400
IronPort-SDR: 2mvCfWR8xp6ehKMIeICaGTXE5EvLoeptVfruE1+Ub4R6wUvp1xVc5tabHVXG0vQ0B5XcXm7/gM
 7cd4XM8u0EGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="141162195"
X-IronPort-AV: E=Sophos;i="5.75,265,1589266800"; 
   d="gz'50?scan'50,208,50";a="141162195"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2020 19:59:49 -0700
IronPort-SDR: rLCuL/f8r9K4Z5wQGT3DQGDYWMwEv84WfiupnTXR+LQxtTv/+FKyE2VktG3EM3oy/0Mcwo2Dxk
 WxHDpLW7jg7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,265,1589266800"; 
   d="gz'50?scan'50,208,50";a="278475172"
Received: from lkp-server02.sh.intel.com (HELO 3aa54c81372e) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 21 Jun 2020 19:59:47 -0700
Received: from kbuild by 3aa54c81372e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jnCgU-00030e-GU; Mon, 22 Jun 2020 02:59:46 +0000
Date:   Mon, 22 Jun 2020 10:59:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/misc/mic/vop/vop_main.c:551:51: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202006221059.IGzzcJrC%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   48778464bb7d346b47157d21ffde2af6b2d39110
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 days ago
config: sh-randconfig-s032-20200622 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-rc2-13-gc59158c8-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=sh CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/misc/mic/vop/vop_main.c:551:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le64 * @@
>> drivers/misc/mic/vop/vop_main.c:551:51: sparse:     expected void const volatile [noderef] __iomem *
   drivers/misc/mic/vop/vop_main.c:551:51: sparse:     got restricted __le64 *
   drivers/misc/mic/vop/vop_main.c:560:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct mic_device_ctrl *dc @@     got struct mic_device_ctrl [noderef] __iomem *dc @@
   drivers/misc/mic/vop/vop_main.c:560:49: sparse:     expected struct mic_device_ctrl *dc
   drivers/misc/mic/vop/vop_main.c:560:49: sparse:     got struct mic_device_ctrl [noderef] __iomem *dc
   drivers/misc/mic/vop/vop_main.c:579:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct mic_device_ctrl *dc @@     got struct mic_device_ctrl [noderef] __iomem *dc @@
   drivers/misc/mic/vop/vop_main.c:579:49: sparse:     expected struct mic_device_ctrl *dc
   drivers/misc/mic/vop/vop_main.c:579:49: sparse:     got struct mic_device_ctrl [noderef] __iomem *dc
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
   drivers/hid/hidraw.c:389:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/hid/hidraw.c:389:37: sparse:     expected int const *__gu_addr
   drivers/hid/hidraw.c:389:37: sparse:     got int [noderef] __user *
>> drivers/hid/hidraw.c:389:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> drivers/hid/hidraw.c:389:37: sparse:     expected void const volatile [noderef] __user *
   drivers/hid/hidraw.c:389:37: sparse:     got int const *__gu_addr
--
>> drivers/vhost/vringh.c:567:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted __virtio16 const *__gu_addr @@     got restricted __virtio16 [noderef] [usertype] __user * @@
   drivers/vhost/vringh.c:567:18: sparse:     expected restricted __virtio16 const *__gu_addr
>> drivers/vhost/vringh.c:567:18: sparse:     got restricted __virtio16 [noderef] [usertype] __user *
>> drivers/vhost/vringh.c:567:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got restricted __virtio16 const *__gu_addr @@
>> drivers/vhost/vringh.c:567:18: sparse:     expected void const volatile [noderef] __user *
   drivers/vhost/vringh.c:567:18: sparse:     got restricted __virtio16 const *__gu_addr
--
>> kernel/bpf/cgroup.c:1402:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   kernel/bpf/cgroup.c:1402:21: sparse:     expected int const *__gu_addr
>> kernel/bpf/cgroup.c:1402:21: sparse:     got int [noderef] __user *optlen
>> kernel/bpf/cgroup.c:1402:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> kernel/bpf/cgroup.c:1402:21: sparse:     expected void const volatile [noderef] __user *
   kernel/bpf/cgroup.c:1402:21: sparse:     got int const *__gu_addr
--
>> sound/core/rawmidi.c:654:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/rawmidi.c:654:13: sparse:     expected unsigned int const *__gu_addr
>> sound/core/rawmidi.c:654:13: sparse:     got unsigned int [noderef] __user *
>> sound/core/rawmidi.c:654:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> sound/core/rawmidi.c:654:13: sparse:     expected void const volatile [noderef] __user *
   sound/core/rawmidi.c:654:13: sparse:     got unsigned int const *__gu_addr
>> sound/core/rawmidi.c:656:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:656:13: sparse:     expected int const *__gu_addr
>> sound/core/rawmidi.c:656:13: sparse:     got int [noderef] __user *
>> sound/core/rawmidi.c:656:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:656:13: sparse:     expected void const volatile [noderef] __user *
   sound/core/rawmidi.c:656:13: sparse:     got int const *__gu_addr
   sound/core/rawmidi.c:658:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/rawmidi.c:658:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/rawmidi.c:658:13: sparse:     got unsigned int [noderef] __user *
   sound/core/rawmidi.c:658:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   sound/core/rawmidi.c:658:13: sparse:     expected void const volatile [noderef] __user *
   sound/core/rawmidi.c:658:13: sparse:     got unsigned int const *__gu_addr
   sound/core/rawmidi.c:836:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:836:21: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:836:21: sparse:     got int [noderef] __user *
   sound/core/rawmidi.c:836:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:836:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/rawmidi.c:836:21: sparse:     got int const *__gu_addr
   sound/core/rawmidi.c:874:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:874:21: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:874:21: sparse:     got int [noderef] __user *
   sound/core/rawmidi.c:874:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:874:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/rawmidi.c:874:21: sparse:     got int const *__gu_addr
   sound/core/rawmidi.c:889:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:889:21: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:889:21: sparse:     got int [noderef] __user *
   sound/core/rawmidi.c:889:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:889:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/rawmidi.c:889:21: sparse:     got int const *__gu_addr
   sound/core/rawmidi.c:923:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:923:21: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:923:21: sparse:     got int [noderef] __user *
   sound/core/rawmidi.c:923:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:923:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/rawmidi.c:923:21: sparse:     got int const *__gu_addr
   sound/core/rawmidi.c:945:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/rawmidi.c:945:21: sparse:     expected int const *__gu_addr
   sound/core/rawmidi.c:945:21: sparse:     got int [noderef] __user *
   sound/core/rawmidi.c:945:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/rawmidi.c:945:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/rawmidi.c:945:21: sparse:     got int const *__gu_addr
--
   sound/core/control.c:776:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:776:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:777:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:777:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:796:48: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1462:40: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
>> sound/core/control.c:1565:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ptr @@
   sound/core/control.c:1565:13: sparse:     expected int const *__gu_addr
>> sound/core/control.c:1565:13: sparse:     got int [noderef] __user *ptr
>> sound/core/control.c:1565:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> sound/core/control.c:1565:13: sparse:     expected void const volatile [noderef] __user *
   sound/core/control.c:1565:13: sparse:     got int const *__gu_addr
--
>> sound/core/hwdep.c:265:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/hwdep.c:265:29: sparse:     expected int const *__gu_addr
>> sound/core/hwdep.c:265:29: sparse:     got int [noderef] __user *
>> sound/core/hwdep.c:265:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> sound/core/hwdep.c:265:29: sparse:     expected void const volatile [noderef] __user *
   sound/core/hwdep.c:265:29: sparse:     got int const *__gu_addr
>> sound/core/hwdep.c:294:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/hwdep.c:294:29: sparse:     expected unsigned int const *__gu_addr
>> sound/core/hwdep.c:294:29: sparse:     got unsigned int [noderef] __user *
>> sound/core/hwdep.c:294:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   sound/core/hwdep.c:294:29: sparse:     expected void const volatile [noderef] __user *
   sound/core/hwdep.c:294:29: sparse:     got unsigned int const *__gu_addr
--
>> sound/core/timer.c:2045:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/timer.c:2045:13: sparse:     expected int const *__gu_addr
>> sound/core/timer.c:2045:13: sparse:     got int [noderef] __user *p
>> sound/core/timer.c:2045:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> sound/core/timer.c:2045:13: sparse:     expected void const volatile [noderef] __user *
   sound/core/timer.c:2045:13: sparse:     got int const *__gu_addr
   sound/core/timer.c:790:25: sparse: sparse: context imbalance in 'snd_timer_process_callbacks' - unexpected unlock
--
>> sound/core/pcm.c:92:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/pcm.c:92:29: sparse:     expected int const *__gu_addr
>> sound/core/pcm.c:92:29: sparse:     got int [noderef] __user *
>> sound/core/pcm.c:92:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> sound/core/pcm.c:92:29: sparse:     expected void const volatile [noderef] __user *
   sound/core/pcm.c:92:29: sparse:     got int const *__gu_addr
>> sound/core/pcm.c:112:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm.c:112:29: sparse:     expected unsigned int const *__gu_addr
>> sound/core/pcm.c:112:29: sparse:     got unsigned int [noderef] __user *
>> sound/core/pcm.c:112:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   sound/core/pcm.c:112:29: sparse:     expected void const volatile [noderef] __user *
   sound/core/pcm.c:112:29: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm.c:114:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/pcm.c:114:29: sparse:     expected int const *__gu_addr
   sound/core/pcm.c:114:29: sparse:     got int [noderef] __user *
   sound/core/pcm.c:114:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/pcm.c:114:29: sparse:     expected void const volatile [noderef] __user *
   sound/core/pcm.c:114:29: sparse:     got int const *__gu_addr
   sound/core/pcm.c:119:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm.c:119:29: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm.c:119:29: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm.c:119:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   sound/core/pcm.c:119:29: sparse:     expected void const volatile [noderef] __user *
   sound/core/pcm.c:119:29: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm.c:155:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/pcm.c:155:29: sparse:     expected int const *__gu_addr
   sound/core/pcm.c:155:29: sparse:     got int [noderef] __user *
   sound/core/pcm.c:155:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/pcm.c:155:29: sparse:     expected void const volatile [noderef] __user *
   sound/core/pcm.c:155:29: sparse:     got int const *__gu_addr
   sound/core/pcm.c:999:9: sparse: sparse: context imbalance in 'snd_pcm_detach_substream' - different lock contexts for basic block
--
>> sound/core/pcm_native.c:1010:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   sound/core/pcm_native.c:1010:20: sparse:     expected unsigned int const *__gu_addr
>> sound/core/pcm_native.c:1010:20: sparse:     got unsigned int [noderef] [usertype] __user *
>> sound/core/pcm_native.c:1010:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> sound/core/pcm_native.c:1010:20: sparse:     expected void const volatile [noderef] __user *
   sound/core/pcm_native.c:1010:20: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:1036:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   sound/core/pcm_native.c:1036:20: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:1036:20: sparse:     got unsigned int [noderef] [usertype] __user *
   sound/core/pcm_native.c:1036:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:1036:20: sparse:     expected void const volatile [noderef] __user *
   sound/core/pcm_native.c:1036:20: sparse:     got unsigned int const *__gu_addr
>> sound/core/pcm_native.c:2944:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:2944:13: sparse:     expected unsigned int const *__gu_addr
>> sound/core/pcm_native.c:2944:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:2944:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:2944:13: sparse:     expected void const volatile [noderef] __user *
   sound/core/pcm_native.c:2944:13: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:3037:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3037:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:3037:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3037:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:3037:13: sparse:     expected void const volatile [noderef] __user *
   sound/core/pcm_native.c:3037:13: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:3038:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3038:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:3038:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3038:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:3038:13: sparse:     expected void const volatile [noderef] __user *
   sound/core/pcm_native.c:3038:13: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:3039:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3039:13: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:3039:13: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3039:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:3039:13: sparse:     expected void const volatile [noderef] __user *
   sound/core/pcm_native.c:3039:13: sparse:     got unsigned int const *__gu_addr
>> sound/core/pcm_native.c:3087:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *_arg @@
   sound/core/pcm_native.c:3087:13: sparse:     expected int const *__gu_addr
>> sound/core/pcm_native.c:3087:13: sparse:     got int [noderef] __user *_arg
>> sound/core/pcm_native.c:3087:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/pcm_native.c:3087:13: sparse:     expected void const volatile [noderef] __user *
   sound/core/pcm_native.c:3087:13: sparse:     got int const *__gu_addr
>> sound/core/pcm_native.c:3153:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] [usertype] __user *_frames @@
   sound/core/pcm_native.c:3153:13: sparse:     expected unsigned long const *__gu_addr
>> sound/core/pcm_native.c:3153:13: sparse:     got unsigned long [noderef] [usertype] __user *_frames
>> sound/core/pcm_native.c:3153:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned long const *__gu_addr @@
   sound/core/pcm_native.c:3153:13: sparse:     expected void const volatile [noderef] __user *
   sound/core/pcm_native.c:3153:13: sparse:     got unsigned long const *__gu_addr
   sound/core/pcm_native.c:3169:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] [usertype] __user *_frames @@
   sound/core/pcm_native.c:3169:13: sparse:     expected unsigned long const *__gu_addr
   sound/core/pcm_native.c:3169:13: sparse:     got unsigned long [noderef] [usertype] __user *_frames
   sound/core/pcm_native.c:3169:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned long const *__gu_addr @@
   sound/core/pcm_native.c:3169:13: sparse:     expected void const volatile [noderef] __user *
   sound/core/pcm_native.c:3169:13: sparse:     got unsigned long const *__gu_addr
   sound/core/pcm_native.c:3203:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/pcm_native.c:3203:21: sparse:     expected unsigned int const *__gu_addr
   sound/core/pcm_native.c:3203:21: sparse:     got unsigned int [noderef] __user *
   sound/core/pcm_native.c:3203:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   sound/core/pcm_native.c:3203:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/pcm_native.c:3203:21: sparse:     got unsigned int const *__gu_addr
   sound/core/pcm_native.c:95:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock' - different lock contexts for basic block
   include/linux/spinlock.h:393:9: sparse: sparse: context imbalance in 'snd_pcm_group_unlock' - unexpected unlock
   sound/core/pcm_native.c:97:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock_irq' - different lock contexts for basic block
   include/asm-generic/irqflags.h:47:9: sparse: sparse: context imbalance in 'snd_pcm_group_unlock_irq' - unexpected unlock
   sound/core/pcm_native.c:145:9: sparse: sparse: context imbalance in 'snd_pcm_stream_lock_nested' - different lock contexts for basic block
   sound/core/pcm_native.c:171:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave' - different lock contexts for basic block
   include/linux/spinlock.h:408:9: sparse: sparse: context imbalance in 'snd_pcm_stream_unlock_irqrestore' - unexpected unlock
   include/linux/spinlock.h:393:9: sparse: sparse: context imbalance in 'snd_pcm_action_group' - unexpected unlock
   sound/core/pcm_native.c:1273:9: sparse: sparse: context imbalance in 'snd_pcm_stream_group_ref' - different lock contexts for basic block
--
>> drivers/tty/vt/keyboard.c:1729:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1729:21: sparse:     expected unsigned int const *__gu_addr
>> drivers/tty/vt/keyboard.c:1729:21: sparse:     got unsigned int [noderef] __user *
>> drivers/tty/vt/keyboard.c:1729:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> drivers/tty/vt/keyboard.c:1729:21: sparse:     expected void const volatile [noderef] __user *
   drivers/tty/vt/keyboard.c:1729:21: sparse:     got unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1767:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1767:21: sparse:     expected unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1767:21: sparse:     got unsigned int [noderef] __user *
   drivers/tty/vt/keyboard.c:1767:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/tty/vt/keyboard.c:1767:21: sparse:     expected void const volatile [noderef] __user *
   drivers/tty/vt/keyboard.c:1767:21: sparse:     got unsigned int const *__gu_addr
--
>> drivers/tty/vt/vt.c:4210:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char [noderef] __user * @@
   drivers/tty/vt/vt.c:4210:13: sparse:     expected char const *__gu_addr
>> drivers/tty/vt/vt.c:4210:13: sparse:     got char [noderef] __user *
>> drivers/tty/vt/vt.c:4210:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
>> drivers/tty/vt/vt.c:4210:13: sparse:     expected void const volatile [noderef] __user *
   drivers/tty/vt/vt.c:4210:13: sparse:     got char const *__gu_addr
   drivers/tty/vt/vt.c:233:5: sparse: sparse: symbol 'console_blank_hook' was not declared. Should it be static?
   drivers/tty/vt/vt.c:2901:19: sparse: sparse: symbol 'console_driver' was not declared. Should it be static?
>> drivers/tty/vt/vt.c:3057:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char [noderef] __user *p @@
   drivers/tty/vt/vt.c:3057:13: sparse:     expected char const *__gu_addr
>> drivers/tty/vt/vt.c:3057:13: sparse:     got char [noderef] __user *p
   drivers/tty/vt/vt.c:3057:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
   drivers/tty/vt/vt.c:3057:13: sparse:     expected void const volatile [noderef] __user *
   drivers/tty/vt/vt.c:3057:13: sparse:     got char const *__gu_addr
   drivers/tty/vt/vt.c:3110:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char [noderef] __user * @@
   drivers/tty/vt/vt.c:3110:37: sparse:     expected char const *__gu_addr
   drivers/tty/vt/vt.c:3110:37: sparse:     got char [noderef] __user *
   drivers/tty/vt/vt.c:3110:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
   drivers/tty/vt/vt.c:3110:37: sparse:     expected void const volatile [noderef] __user *
   drivers/tty/vt/vt.c:3110:37: sparse:     got char const *__gu_addr
>> drivers/tty/vt/vt.c:3123:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/tty/vt/vt.c:3123:29: sparse:     expected signed int const *__gu_addr
>> drivers/tty/vt/vt.c:3123:29: sparse:     got signed int [noderef] [usertype] __user *
>> drivers/tty/vt/vt.c:3123:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got signed int const *__gu_addr @@
   drivers/tty/vt/vt.c:3123:29: sparse:     expected void const volatile [noderef] __user *
   drivers/tty/vt/vt.c:3123:29: sparse:     got signed int const *__gu_addr
   drivers/tty/vt/vt.c:2942:13: sparse: sparse: context imbalance in 'vt_console_print' - wrong count at exit
--
>> drivers/tty/vt/vt_ioctl.c:839:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:839:21: sparse:     expected unsigned short const *__gu_addr
>> drivers/tty/vt/vt_ioctl.c:839:21: sparse:     got unsigned short [noderef] __user *
>> drivers/tty/vt/vt_ioctl.c:839:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned short const *__gu_addr @@
>> drivers/tty/vt/vt_ioctl.c:839:21: sparse:     expected void const volatile [noderef] __user *
   drivers/tty/vt/vt_ioctl.c:839:21: sparse:     got unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:840:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:840:21: sparse:     expected unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:840:21: sparse:     got unsigned short [noderef] __user *
   drivers/tty/vt/vt_ioctl.c:840:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned short const *__gu_addr @@
   drivers/tty/vt/vt_ioctl.c:840:21: sparse:     expected void const volatile [noderef] __user *
   drivers/tty/vt/vt_ioctl.c:840:21: sparse:     got unsigned short const *__gu_addr

vim +551 drivers/misc/mic/vop/vop_main.c

c1becd2849681e Ashutosh Dixit     2016-02-08  548  
ba01cea2be8872 Vincent Whitchurch 2019-02-22  549  static struct _vop_vdev *vop_dc_to_vdev(struct mic_device_ctrl *dc)
ba01cea2be8872 Vincent Whitchurch 2019-02-22  550  {
ba01cea2be8872 Vincent Whitchurch 2019-02-22 @551  	return (struct _vop_vdev *)(unsigned long)readq(&dc->vdev);
ba01cea2be8872 Vincent Whitchurch 2019-02-22  552  }
ba01cea2be8872 Vincent Whitchurch 2019-02-22  553  

:::::: The code at line 551 was first introduced by commit
:::::: ba01cea2be8872591452e84acebede388c91249b mic: vop: Cast pointers to unsigned long

:::::: TO: Vincent Whitchurch <vincent.whitchurch@axis.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--DocE+STaALJfprDB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
qTG/LssyaodalBdBNI4yS/0PMsoI6jClAQA=

--DocE+STaALJfprDB--
