Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C4BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DD2206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGIKdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:33:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:4926 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgGIKdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:33:19 -0400
IronPort-SDR: gBBo9huT+cO7tP3DFCdb3zc7FV0+cz/Rql4AQDl+b0jxbH1NV3I0jjlEN+VoqCJ6Ik4y8UcA9T
 a04e3YESmPrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="209504255"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="gz'50?scan'50,208,50";a="209504255"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 03:33:12 -0700
IronPort-SDR: A1ElBQNCiBYBK7QRtqJO7spJ1dK4UfPoHYFFkDzxtWGdVCEZ8Bb2IpqFRimhQ7OhBtA1VbKVYy
 51GzJ2p74cvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="gz'50?scan'50,208,50";a="484227001"
Received: from lkp-server01.sh.intel.com (HELO 6136dd46483e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jul 2020 03:33:10 -0700
Received: from kbuild by 6136dd46483e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtTrZ-0000Z3-Hi; Thu, 09 Jul 2020 10:33:09 +0000
Date:   Thu, 9 Jul 2020 18:33:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: fs/orangefs/file.c:424:21: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202007091855.CJBpUVBf%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bddd227f3dc55975e2b8dfa7fc6f959b062a2c7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: sh-randconfig-s032-20200709 (attached as .config)
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

   fs/orangefs/file.c:118:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected int open_for_write @@     got restricted fmode_t @@
   fs/orangefs/file.c:118:32: sparse:     expected int open_for_write
   fs/orangefs/file.c:118:32: sparse:     got restricted fmode_t
   fs/orangefs/file.c:119:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected int open_for_read @@     got restricted fmode_t @@
   fs/orangefs/file.c:119:31: sparse:     expected int open_for_read
   fs/orangefs/file.c:119:31: sparse:     got restricted fmode_t
   fs/orangefs/file.c:424:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/orangefs/file.c:424:21: sparse:     expected int const *__gu_addr
   fs/orangefs/file.c:424:21: sparse:     got int [noderef] __user *
>> fs/orangefs/file.c:424:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> fs/orangefs/file.c:424:21: sparse:     expected void const volatile [noderef] __user *
   fs/orangefs/file.c:424:21: sparse:     got int const *__gu_addr
--
>> net/bluetooth/rfcomm/sock.c:659:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/rfcomm/sock.c:659:21: sparse:     expected unsigned int const *__gu_addr
>> net/bluetooth/rfcomm/sock.c:659:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> net/bluetooth/rfcomm/sock.c:659:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> net/bluetooth/rfcomm/sock.c:659:21: sparse:     expected void const volatile [noderef] __user *
   net/bluetooth/rfcomm/sock.c:659:21: sparse:     got unsigned int const *__gu_addr
   net/bluetooth/rfcomm/sock.c:735:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/rfcomm/sock.c:735:21: sparse:     expected unsigned int const *__gu_addr
   net/bluetooth/rfcomm/sock.c:735:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/bluetooth/rfcomm/sock.c:735:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   net/bluetooth/rfcomm/sock.c:735:21: sparse:     expected void const volatile [noderef] __user *
   net/bluetooth/rfcomm/sock.c:735:21: sparse:     got unsigned int const *__gu_addr
>> net/bluetooth/rfcomm/sock.c:767:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/rfcomm/sock.c:767:13: sparse:     expected int const *__gu_addr
>> net/bluetooth/rfcomm/sock.c:767:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/rfcomm/sock.c:767:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/bluetooth/rfcomm/sock.c:767:13: sparse:     expected void const volatile [noderef] __user *
   net/bluetooth/rfcomm/sock.c:767:13: sparse:     got int const *__gu_addr
   net/bluetooth/rfcomm/sock.c:845:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/rfcomm/sock.c:845:13: sparse:     expected int const *__gu_addr
   net/bluetooth/rfcomm/sock.c:845:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/rfcomm/sock.c:845:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/bluetooth/rfcomm/sock.c:845:13: sparse:     expected void const volatile [noderef] __user *
   net/bluetooth/rfcomm/sock.c:845:13: sparse:     got int const *__gu_addr
--
   drivers/rtc/rtc-m41t80.c:736:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/rtc/rtc-m41t80.c:736:21: sparse:     expected int const *__gu_addr
   drivers/rtc/rtc-m41t80.c:736:21: sparse:     got int [noderef] __user *
>> drivers/rtc/rtc-m41t80.c:736:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> drivers/rtc/rtc-m41t80.c:736:21: sparse:     expected void const volatile [noderef] __user *
   drivers/rtc/rtc-m41t80.c:736:21: sparse:     got int const *__gu_addr

vim +424 fs/orangefs/file.c

5aca284210ce82 Darrick J. Wong 2019-07-01  393  
5db11c21a929cd Mike Marshall   2015-07-17  394  /*
5db11c21a929cd Mike Marshall   2015-07-17  395   * Perform a miscellaneous operation on a file.
5db11c21a929cd Mike Marshall   2015-07-17  396   */
8bb8aefd5afb54 Yi Liu          2015-11-24  397  static long orangefs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
5db11c21a929cd Mike Marshall   2015-07-17  398  {
5aca284210ce82 Darrick J. Wong 2019-07-01  399  	struct inode *inode = file_inode(file);
5db11c21a929cd Mike Marshall   2015-07-17  400  	int ret = -ENOTTY;
5db11c21a929cd Mike Marshall   2015-07-17  401  	__u64 val = 0;
5db11c21a929cd Mike Marshall   2015-07-17  402  	unsigned long uval;
5db11c21a929cd Mike Marshall   2015-07-17  403  
5db11c21a929cd Mike Marshall   2015-07-17  404  	gossip_debug(GOSSIP_FILE_DEBUG,
8bb8aefd5afb54 Yi Liu          2015-11-24  405  		     "orangefs_ioctl: called with cmd %d\n",
5db11c21a929cd Mike Marshall   2015-07-17  406  		     cmd);
5db11c21a929cd Mike Marshall   2015-07-17  407  
5db11c21a929cd Mike Marshall   2015-07-17  408  	/*
5db11c21a929cd Mike Marshall   2015-07-17  409  	 * we understand some general ioctls on files, such as the immutable
5db11c21a929cd Mike Marshall   2015-07-17  410  	 * and append flags
5db11c21a929cd Mike Marshall   2015-07-17  411  	 */
5db11c21a929cd Mike Marshall   2015-07-17  412  	if (cmd == FS_IOC_GETFLAGS) {
5aca284210ce82 Darrick J. Wong 2019-07-01  413  		ret = orangefs_getflags(inode, &uval);
5aca284210ce82 Darrick J. Wong 2019-07-01  414  		if (ret)
5db11c21a929cd Mike Marshall   2015-07-17  415  			return ret;
5db11c21a929cd Mike Marshall   2015-07-17  416  		gossip_debug(GOSSIP_FILE_DEBUG,
8bb8aefd5afb54 Yi Liu          2015-11-24  417  			     "orangefs_ioctl: FS_IOC_GETFLAGS: %llu\n",
5db11c21a929cd Mike Marshall   2015-07-17  418  			     (unsigned long long)uval);
5db11c21a929cd Mike Marshall   2015-07-17  419  		return put_user(uval, (int __user *)arg);
5db11c21a929cd Mike Marshall   2015-07-17  420  	} else if (cmd == FS_IOC_SETFLAGS) {
5aca284210ce82 Darrick J. Wong 2019-07-01  421  		unsigned long old_uval;
5aca284210ce82 Darrick J. Wong 2019-07-01  422  
5db11c21a929cd Mike Marshall   2015-07-17  423  		ret = 0;
5db11c21a929cd Mike Marshall   2015-07-17 @424  		if (get_user(uval, (int __user *)arg))
5db11c21a929cd Mike Marshall   2015-07-17  425  			return -EFAULT;
5db11c21a929cd Mike Marshall   2015-07-17  426  		/*
8bb8aefd5afb54 Yi Liu          2015-11-24  427  		 * ORANGEFS_MIRROR_FL is set internally when the mirroring mode
5db11c21a929cd Mike Marshall   2015-07-17  428  		 * is turned on for a file. The user is not allowed to turn
5db11c21a929cd Mike Marshall   2015-07-17  429  		 * on this bit, but the bit is present if the user first gets
5db11c21a929cd Mike Marshall   2015-07-17  430  		 * the flags and then updates the flags with some new
5db11c21a929cd Mike Marshall   2015-07-17  431  		 * settings. So, we ignore it in the following edit. bligon.
5db11c21a929cd Mike Marshall   2015-07-17  432  		 */
8bb8aefd5afb54 Yi Liu          2015-11-24  433  		if ((uval & ~ORANGEFS_MIRROR_FL) &
5db11c21a929cd Mike Marshall   2015-07-17  434  		    (~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NOATIME_FL))) {
8bb8aefd5afb54 Yi Liu          2015-11-24  435  			gossip_err("orangefs_ioctl: the FS_IOC_SETFLAGS only supports setting one of FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NOATIME_FL\n");
5db11c21a929cd Mike Marshall   2015-07-17  436  			return -EINVAL;
5db11c21a929cd Mike Marshall   2015-07-17  437  		}
5aca284210ce82 Darrick J. Wong 2019-07-01  438  		ret = orangefs_getflags(inode, &old_uval);
5aca284210ce82 Darrick J. Wong 2019-07-01  439  		if (ret)
5aca284210ce82 Darrick J. Wong 2019-07-01  440  			return ret;
5aca284210ce82 Darrick J. Wong 2019-07-01  441  		ret = vfs_ioc_setflags_prepare(inode, old_uval, uval);
5aca284210ce82 Darrick J. Wong 2019-07-01  442  		if (ret)
5aca284210ce82 Darrick J. Wong 2019-07-01  443  			return ret;
5db11c21a929cd Mike Marshall   2015-07-17  444  		val = uval;
5db11c21a929cd Mike Marshall   2015-07-17  445  		gossip_debug(GOSSIP_FILE_DEBUG,
8bb8aefd5afb54 Yi Liu          2015-11-24  446  			     "orangefs_ioctl: FS_IOC_SETFLAGS: %llu\n",
5db11c21a929cd Mike Marshall   2015-07-17  447  			     (unsigned long long)val);
5aca284210ce82 Darrick J. Wong 2019-07-01  448  		ret = orangefs_inode_setxattr(inode,
5db11c21a929cd Mike Marshall   2015-07-17  449  					      "user.pvfs2.meta_hint",
555fa0fa618b84 Al Viro         2015-11-11  450  					      &val, sizeof(val), 0);
5db11c21a929cd Mike Marshall   2015-07-17  451  	}
5db11c21a929cd Mike Marshall   2015-07-17  452  
5db11c21a929cd Mike Marshall   2015-07-17  453  	return ret;
5db11c21a929cd Mike Marshall   2015-07-17  454  }
5db11c21a929cd Mike Marshall   2015-07-17  455  

:::::: The code at line 424 was first introduced by commit
:::::: 5db11c21a929cd9d8c0484006efb1014fc723c93 Orangefs: kernel client part 2

:::::: TO: Mike Marshall <hubcap@omnibond.com>
:::::: CC: Mike Marshall <hubcap@omnibond.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6TrnltStXW4iwmi0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AA==

--6TrnltStXW4iwmi0--
