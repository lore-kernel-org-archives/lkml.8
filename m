Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE34CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A300A20672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbgF2Thq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:37:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:62621 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730753AbgF2The (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:37:34 -0400
IronPort-SDR: qIaEsk8Ik/06JewCU7+ExiFHX0zLeJ8zChRhF97xCsh/ECIEGJruFS2QD/cIgBdZrl3cw6vLle
 TZW3eXFuImeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="126079101"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="gz'50?scan'50,208,50";a="126079101"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 03:00:31 -0700
IronPort-SDR: lIbhaWSd69ktPeJEd0qowXjJOYrTfJ0XzI59a7lFuKrkSjxabeMqnNT/WU63F92j5JbUDbPdTs
 1+WlnRbYw6FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="gz'50?scan'50,208,50";a="480727641"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2020 03:00:29 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jpqaT-0000vP-Kk; Mon, 29 Jun 2020 10:00:29 +0000
Date:   Mon, 29 Jun 2020 17:59:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: sound/core/oss/mixer_oss.c:312:29: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202006291728.9HrfEJJ4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   11 days ago
config: sh-randconfig-s031-20200629 (attached as .config)
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

>> sound/core/oss/mixer_oss.c:312:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/mixer_oss.c:312:29: sparse:     expected int const *__gu_addr
>> sound/core/oss/mixer_oss.c:312:29: sparse:     got int [noderef] __user *p
>> sound/core/oss/mixer_oss.c:312:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> sound/core/oss/mixer_oss.c:312:29: sparse:     expected void const volatile [noderef] __user *
   sound/core/oss/mixer_oss.c:312:29: sparse:     got int const *__gu_addr
   sound/core/oss/mixer_oss.c:350:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/mixer_oss.c:350:21: sparse:     expected int const *__gu_addr
   sound/core/oss/mixer_oss.c:350:21: sparse:     got int [noderef] __user *p
   sound/core/oss/mixer_oss.c:350:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/oss/mixer_oss.c:350:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/oss/mixer_oss.c:350:21: sparse:     got int const *__gu_addr
--
   sound/core/oss/pcm_oss.c:884:53: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected int format @@     got restricted snd_pcm_format_t [assigned] [usertype] format @@
   sound/core/oss/pcm_oss.c:884:53: sparse:     expected int format
   sound/core/oss/pcm_oss.c:884:53: sparse:     got restricted snd_pcm_format_t [assigned] [usertype] format
   sound/core/oss/pcm_oss.c:884:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted snd_pcm_format_t [assigned] [usertype] sformat @@     got int @@
   sound/core/oss/pcm_oss.c:884:25: sparse:     expected restricted snd_pcm_format_t [assigned] [usertype] sformat
   sound/core/oss/pcm_oss.c:884:25: sparse:     got int
>> sound/core/oss/pcm_oss.c:2592:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/pcm_oss.c:2592:21: sparse:     expected int const *__gu_addr
>> sound/core/oss/pcm_oss.c:2592:21: sparse:     got int [noderef] __user *p
>> sound/core/oss/pcm_oss.c:2592:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> sound/core/oss/pcm_oss.c:2592:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/oss/pcm_oss.c:2592:21: sparse:     got int const *__gu_addr
   sound/core/oss/pcm_oss.c:2603:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/pcm_oss.c:2603:21: sparse:     expected int const *__gu_addr
   sound/core/oss/pcm_oss.c:2603:21: sparse:     got int [noderef] __user *p
   sound/core/oss/pcm_oss.c:2603:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/oss/pcm_oss.c:2603:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/oss/pcm_oss.c:2603:21: sparse:     got int const *__gu_addr
   sound/core/oss/pcm_oss.c:2615:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/pcm_oss.c:2615:21: sparse:     expected int const *__gu_addr
   sound/core/oss/pcm_oss.c:2615:21: sparse:     got int [noderef] __user *p
   sound/core/oss/pcm_oss.c:2615:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/oss/pcm_oss.c:2615:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/oss/pcm_oss.c:2615:21: sparse:     got int const *__gu_addr
   sound/core/oss/pcm_oss.c:2627:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/pcm_oss.c:2627:21: sparse:     expected int const *__gu_addr
   sound/core/oss/pcm_oss.c:2627:21: sparse:     got int [noderef] __user *p
   sound/core/oss/pcm_oss.c:2627:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/oss/pcm_oss.c:2627:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/oss/pcm_oss.c:2627:21: sparse:     got int const *__gu_addr
   sound/core/oss/pcm_oss.c:2644:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/pcm_oss.c:2644:21: sparse:     expected int const *__gu_addr
   sound/core/oss/pcm_oss.c:2644:21: sparse:     got int [noderef] __user *p
   sound/core/oss/pcm_oss.c:2644:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/oss/pcm_oss.c:2644:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/oss/pcm_oss.c:2644:21: sparse:     got int const *__gu_addr
   sound/core/oss/pcm_oss.c:2651:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/pcm_oss.c:2651:21: sparse:     expected int const *__gu_addr
   sound/core/oss/pcm_oss.c:2651:21: sparse:     got int [noderef] __user *p
   sound/core/oss/pcm_oss.c:2651:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/oss/pcm_oss.c:2651:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/oss/pcm_oss.c:2651:21: sparse:     got int const *__gu_addr
   sound/core/oss/pcm_oss.c:2678:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/oss/pcm_oss.c:2678:21: sparse:     expected int const *__gu_addr
   sound/core/oss/pcm_oss.c:2678:21: sparse:     got int [noderef] __user *p
   sound/core/oss/pcm_oss.c:2678:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   sound/core/oss/pcm_oss.c:2678:21: sparse:     expected void const volatile [noderef] __user *
   sound/core/oss/pcm_oss.c:2678:21: sparse:     got int const *__gu_addr
--
   fs/cifs/dfs_cache.c:194:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buffer @@
   fs/cifs/dfs_cache.c:194:14: sparse:     expected char const *__gu_addr
   fs/cifs/dfs_cache.c:194:14: sparse:     got char const [noderef] __user *buffer
>> fs/cifs/dfs_cache.c:194:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
>> fs/cifs/dfs_cache.c:194:14: sparse:     expected void const volatile [noderef] __user *
   fs/cifs/dfs_cache.c:194:14: sparse:     got char const *__gu_addr
--
   fs/f2fs/file.c:47:54: sparse: sparse: cast from restricted vm_fault_t
   fs/f2fs/file.c:1976:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/f2fs/file.c:1976:13: sparse:     expected int const *__gu_addr
   fs/f2fs/file.c:1976:13: sparse:     got int [noderef] __user *
>> fs/f2fs/file.c:1976:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> fs/f2fs/file.c:1976:13: sparse:     expected void const volatile [noderef] __user *
   fs/f2fs/file.c:1976:13: sparse:     got int const *__gu_addr
   fs/f2fs/file.c:2230:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/f2fs/file.c:2230:13: sparse:     expected unsigned int const *__gu_addr
   fs/f2fs/file.c:2230:13: sparse:     got unsigned int [noderef] [usertype] __user *
>> fs/f2fs/file.c:2230:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   fs/f2fs/file.c:2230:13: sparse:     expected void const volatile [noderef] __user *
   fs/f2fs/file.c:2230:13: sparse:     got unsigned int const *__gu_addr
   fs/f2fs/file.c:2467:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/f2fs/file.c:2467:13: sparse:     expected unsigned int const *__gu_addr
   fs/f2fs/file.c:2467:13: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/f2fs/file.c:2467:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   fs/f2fs/file.c:2467:13: sparse:     expected void const volatile [noderef] __user *
   fs/f2fs/file.c:2467:13: sparse:     got unsigned int const *__gu_addr
   fs/f2fs/file.c:3222:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/f2fs/file.c:3222:13: sparse:     expected unsigned int const *__gu_addr
   fs/f2fs/file.c:3222:13: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/f2fs/file.c:3222:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   fs/f2fs/file.c:3222:13: sparse:     expected void const volatile [noderef] __user *
   fs/f2fs/file.c:3222:13: sparse:     got unsigned int const *__gu_addr
   fs/f2fs/file.c:3375:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const [usertype] *pwcs @@     got restricted __le16 * @@
   fs/f2fs/file.c:3375:36: sparse:     expected unsigned short const [usertype] *pwcs
   fs/f2fs/file.c:3375:36: sparse:     got restricted __le16 *
   fs/f2fs/file.c:3411:28: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned short [usertype] *pwcs @@     got restricted __le16 * @@
   fs/f2fs/file.c:3411:28: sparse:     expected unsigned short [usertype] *pwcs
   fs/f2fs/file.c:3411:28: sparse:     got restricted __le16 *
--
   drivers/vhost/scsi.c:1218:30: sparse: sparse: restricted __virtio32 degrades to integer
   drivers/vhost/scsi.c:1218:30: sparse: sparse: restricted __virtio32 degrades to integer
>> drivers/vhost/scsi.c:1697:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *eventsp @@
   drivers/vhost/scsi.c:1697:21: sparse:     expected unsigned int const *__gu_addr
>> drivers/vhost/scsi.c:1697:21: sparse:     got unsigned int [noderef] [usertype] __user *eventsp
>> drivers/vhost/scsi.c:1697:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> drivers/vhost/scsi.c:1697:21: sparse:     expected void const volatile [noderef] __user *
   drivers/vhost/scsi.c:1697:21: sparse:     got unsigned int const *__gu_addr
--
>> drivers/vhost/vhost.c:1564:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *idxp @@
   drivers/vhost/vhost.c:1564:13: sparse:     expected unsigned int const *__gu_addr
>> drivers/vhost/vhost.c:1564:13: sparse:     got unsigned int [noderef] [usertype] __user *idxp
>> drivers/vhost/vhost.c:1564:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> drivers/vhost/vhost.c:1564:13: sparse:     expected void const volatile [noderef] __user *
   drivers/vhost/vhost.c:1564:13: sparse:     got unsigned int const *__gu_addr
>> drivers/vhost/vhost.c:1761:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/vhost/vhost.c:1761:21: sparse:     expected int const *__gu_addr
>> drivers/vhost/vhost.c:1761:21: sparse:     got int [noderef] __user *
>> drivers/vhost/vhost.c:1761:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/vhost/vhost.c:1761:21: sparse:     expected void const volatile [noderef] __user *
   drivers/vhost/vhost.c:1761:21: sparse:     got int const *__gu_addr
--
>> drivers/vhost/vdpa.c:346:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/vhost/vdpa.c:346:13: sparse:     expected unsigned int const *__gu_addr
>> drivers/vhost/vdpa.c:346:13: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/vhost/vdpa.c:346:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> drivers/vhost/vdpa.c:346:13: sparse:     expected void const volatile [noderef] __user *
   drivers/vhost/vdpa.c:346:13: sparse:     got unsigned int const *__gu_addr

vim +312 sound/core/oss/mixer_oss.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  296  
f956b4a3ae790e Takashi Iwai   2005-11-17  297  static int snd_mixer_oss_ioctl1(struct snd_mixer_oss_file *fmixer, unsigned int cmd, unsigned long arg)
^1da177e4c3f41 Linus Torvalds 2005-04-16  298  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  299  	void __user *argp = (void __user *)arg;
^1da177e4c3f41 Linus Torvalds 2005-04-16  300  	int __user *p = argp;
^1da177e4c3f41 Linus Torvalds 2005-04-16  301  	int tmp;
^1da177e4c3f41 Linus Torvalds 2005-04-16  302  
7eaa943c8ed8e9 Takashi Iwai   2008-08-08  303  	if (snd_BUG_ON(!fmixer))
7eaa943c8ed8e9 Takashi Iwai   2008-08-08  304  		return -ENXIO;
^1da177e4c3f41 Linus Torvalds 2005-04-16  305  	if (((cmd >> 8) & 0xff) == 'M') {
^1da177e4c3f41 Linus Torvalds 2005-04-16  306  		switch (cmd) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  307  		case SOUND_MIXER_INFO:
^1da177e4c3f41 Linus Torvalds 2005-04-16  308  			return snd_mixer_oss_info(fmixer, argp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  309  		case SOUND_OLD_MIXER_INFO:
^1da177e4c3f41 Linus Torvalds 2005-04-16  310   			return snd_mixer_oss_info_obsolete(fmixer, argp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  311  		case SOUND_MIXER_WRITE_RECSRC:
^1da177e4c3f41 Linus Torvalds 2005-04-16 @312  			if (get_user(tmp, p))
^1da177e4c3f41 Linus Torvalds 2005-04-16  313  				return -EFAULT;
^1da177e4c3f41 Linus Torvalds 2005-04-16  314  			tmp = snd_mixer_oss_set_recsrc(fmixer, tmp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  315  			if (tmp < 0)
^1da177e4c3f41 Linus Torvalds 2005-04-16  316  				return tmp;
^1da177e4c3f41 Linus Torvalds 2005-04-16  317  			return put_user(tmp, p);
^1da177e4c3f41 Linus Torvalds 2005-04-16  318  		case OSS_GETVERSION:
^1da177e4c3f41 Linus Torvalds 2005-04-16  319  			return put_user(SNDRV_OSS_VERSION, p);
^1da177e4c3f41 Linus Torvalds 2005-04-16  320  		case OSS_ALSAEMULVER:
^1da177e4c3f41 Linus Torvalds 2005-04-16  321  			return put_user(1, p);
^1da177e4c3f41 Linus Torvalds 2005-04-16  322  		case SOUND_MIXER_READ_DEVMASK:
^1da177e4c3f41 Linus Torvalds 2005-04-16  323  			tmp = snd_mixer_oss_devmask(fmixer);
^1da177e4c3f41 Linus Torvalds 2005-04-16  324  			if (tmp < 0)
^1da177e4c3f41 Linus Torvalds 2005-04-16  325  				return tmp;
^1da177e4c3f41 Linus Torvalds 2005-04-16  326  			return put_user(tmp, p);
^1da177e4c3f41 Linus Torvalds 2005-04-16  327  		case SOUND_MIXER_READ_STEREODEVS:
^1da177e4c3f41 Linus Torvalds 2005-04-16  328  			tmp = snd_mixer_oss_stereodevs(fmixer);
^1da177e4c3f41 Linus Torvalds 2005-04-16  329  			if (tmp < 0)
^1da177e4c3f41 Linus Torvalds 2005-04-16  330  				return tmp;
^1da177e4c3f41 Linus Torvalds 2005-04-16  331  			return put_user(tmp, p);
^1da177e4c3f41 Linus Torvalds 2005-04-16  332  		case SOUND_MIXER_READ_RECMASK:
^1da177e4c3f41 Linus Torvalds 2005-04-16  333  			tmp = snd_mixer_oss_recmask(fmixer);
^1da177e4c3f41 Linus Torvalds 2005-04-16  334  			if (tmp < 0)
^1da177e4c3f41 Linus Torvalds 2005-04-16  335  				return tmp;
^1da177e4c3f41 Linus Torvalds 2005-04-16  336  			return put_user(tmp, p);
^1da177e4c3f41 Linus Torvalds 2005-04-16  337  		case SOUND_MIXER_READ_CAPS:
^1da177e4c3f41 Linus Torvalds 2005-04-16  338  			tmp = snd_mixer_oss_caps(fmixer);
^1da177e4c3f41 Linus Torvalds 2005-04-16  339  			if (tmp < 0)
^1da177e4c3f41 Linus Torvalds 2005-04-16  340  				return tmp;
^1da177e4c3f41 Linus Torvalds 2005-04-16  341  			return put_user(tmp, p);
^1da177e4c3f41 Linus Torvalds 2005-04-16  342  		case SOUND_MIXER_READ_RECSRC:
^1da177e4c3f41 Linus Torvalds 2005-04-16  343  			tmp = snd_mixer_oss_get_recsrc(fmixer);
^1da177e4c3f41 Linus Torvalds 2005-04-16  344  			if (tmp < 0)
^1da177e4c3f41 Linus Torvalds 2005-04-16  345  				return tmp;
^1da177e4c3f41 Linus Torvalds 2005-04-16  346  			return put_user(tmp, p);
^1da177e4c3f41 Linus Torvalds 2005-04-16  347  		}
^1da177e4c3f41 Linus Torvalds 2005-04-16  348  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  349  	if (cmd & SIOC_IN) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  350  		if (get_user(tmp, p))
^1da177e4c3f41 Linus Torvalds 2005-04-16  351  			return -EFAULT;
^1da177e4c3f41 Linus Torvalds 2005-04-16  352  		tmp = snd_mixer_oss_set_volume(fmixer, cmd & 0xff, tmp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  353  		if (tmp < 0)
^1da177e4c3f41 Linus Torvalds 2005-04-16  354  			return tmp;
^1da177e4c3f41 Linus Torvalds 2005-04-16  355  		return put_user(tmp, p);
^1da177e4c3f41 Linus Torvalds 2005-04-16  356  	} else if (cmd & SIOC_OUT) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  357  		tmp = snd_mixer_oss_get_volume(fmixer, cmd & 0xff);
^1da177e4c3f41 Linus Torvalds 2005-04-16  358  		if (tmp < 0)
^1da177e4c3f41 Linus Torvalds 2005-04-16  359  			return tmp;
^1da177e4c3f41 Linus Torvalds 2005-04-16  360  		return put_user(tmp, p);
^1da177e4c3f41 Linus Torvalds 2005-04-16  361  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  362  	return -ENXIO;
^1da177e4c3f41 Linus Torvalds 2005-04-16  363  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  364  

:::::: The code at line 312 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--yrj/dFKFPuw6o+aM
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--yrj/dFKFPuw6o+aM--
