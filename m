Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6395DC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 21:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262672067D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 21:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgGLVyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 17:54:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:5777 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729249AbgGLVyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 17:54:44 -0400
IronPort-SDR: Z+3enSpFQgS/KbKSSjGQ+zn41vPbGvNPWkXbVIDT81J1AtpZ516tZ3jrbYfm3mbkzMAnKvzlU+
 0Vo/JAO+2L4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="210071010"
X-IronPort-AV: E=Sophos;i="5.75,345,1589266800"; 
   d="gz'50?scan'50,208,50";a="210071010"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 14:54:33 -0700
IronPort-SDR: W1QsLa5UQQbeso6q3iB0nlMgPmlL6FyVxkSUNIgZsNMEKyVIa6awBT4hL7CB0O23XlYdkB+NIf
 eBNxVuQOBO1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,345,1589266800"; 
   d="gz'50?scan'50,208,50";a="269563534"
Received: from lkp-server02.sh.intel.com (HELO fb03a464a2e3) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jul 2020 14:54:31 -0700
Received: from kbuild by fb03a464a2e3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jujva-0000Gu-Mx; Sun, 12 Jul 2020 21:54:30 +0000
Date:   Mon, 13 Jul 2020 05:54:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: sound/core/seq/oss/seq_oss_timer.c:224:21: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202007130542.qVYTvMlA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4437dd6e8f71e8b4b5546924a6e48e7edaf4a8dc
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: sh-randconfig-s032-20200713 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-37-gc9676a3b-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     got int [noderef] __user *arg
>> sound/core/seq/oss/seq_oss_timer.c:224:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     got int [noderef] __user *arg
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     got int [noderef] __user *arg
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     got int const *__gu_addr
--
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     got int [noderef] __user *p
>> sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     got int const *__gu_addr
--
   drivers/hid/hidraw.c:389:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/hid/hidraw.c:389:37: sparse:     expected int const *__gu_addr
   drivers/hid/hidraw.c:389:37: sparse:     got int [noderef] __user *
>> drivers/hid/hidraw.c:389:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> drivers/hid/hidraw.c:389:37: sparse:     expected void const volatile [noderef] __user *
   drivers/hid/hidraw.c:389:37: sparse:     got int const *__gu_addr

vim +224 sound/core/seq/oss/seq_oss_timer.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  212  
^1da177e4c3f41 Linus Torvalds 2005-04-16  213  
^1da177e4c3f41 Linus Torvalds 2005-04-16  214  /*
^1da177e4c3f41 Linus Torvalds 2005-04-16  215   * ioctls
^1da177e4c3f41 Linus Torvalds 2005-04-16  216   */
^1da177e4c3f41 Linus Torvalds 2005-04-16  217  int
080dece3460b53 Takashi Iwai   2005-11-17  218  snd_seq_oss_timer_ioctl(struct seq_oss_timer *timer, unsigned int cmd, int __user *arg)
^1da177e4c3f41 Linus Torvalds 2005-04-16  219  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  220  	int value;
^1da177e4c3f41 Linus Torvalds 2005-04-16  221  
^1da177e4c3f41 Linus Torvalds 2005-04-16  222  	if (cmd == SNDCTL_SEQ_CTRLRATE) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  223  		/* if *arg == 0, just return the current rate */
^1da177e4c3f41 Linus Torvalds 2005-04-16 @224  		if (get_user(value, arg))

:::::: The code at line 224 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6c2NcOVqGQ03X4Wi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
8kOATAN2Pdl1fjRzd+enjf8AA90ANqyPAQA=

--6c2NcOVqGQ03X4Wi--
