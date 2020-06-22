Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEA8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16BA22071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgFVPgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:36:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:11968 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729150AbgFVPgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:36:39 -0400
IronPort-SDR: k3GQYyzSrLxx3BOxDagJROOzuhEyURwp/fbBbelC8kE6Qv40B4dGgH2+fNRrlXnRiIiMxsveLp
 IaKmIxcTx8/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="143749801"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="gz'50?scan'50,208,50";a="143749801"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 08:36:04 -0700
IronPort-SDR: u0vWWEw2WWRTvxAbR60Hu9a7xJ5i5moHIhxKyxdXTi4WDQl49tfXc4PUJT0dK5G9Fx7OZnS6uk
 /k/RVNsoGFNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="gz'50?scan'50,208,50";a="478497136"
Received: from lkp-server01.sh.intel.com (HELO f484c95e4fd1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2020 08:36:01 -0700
Received: from kbuild by f484c95e4fd1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jnOUK-0000MW-NV; Mon, 22 Jun 2020 15:36:00 +0000
Date:   Mon, 22 Jun 2020 23:35:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/block/drbd/drbd_int.h:1725:14: sparse: struct disk_conf
 __rcu COPYING CREDITS Documentation Kbuild Kconfig LICENSES MAINTAINERS
 Makefile README arch block certs crypto drivers fs include init ipc kernel
 lib mm net samples scripts security sound tools usr virt
Message-ID: <202006222333.rf8UYcbF%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   625d3449788f85569096780592549d0340e9c0c7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   4 days ago
config: arc-randconfig-s031-20200622 (attached as .config)
compiler: arc-elf-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=arc CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/block/drbd/drbd_bitmap.c:495:14: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long [assigned] mask @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:495:14: sparse:     expected unsigned long [assigned] mask
   drivers/block/drbd/drbd_bitmap.c:495:14: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:531:14: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long [assigned] mask @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:531:14: sparse:     expected unsigned long [assigned] mask
   drivers/block/drbd/drbd_bitmap.c:531:14: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:572:27: sparse: sparse: invalid assignment: &=
   drivers/block/drbd/drbd_bitmap.c:572:27: sparse:    left side has type unsigned long
   drivers/block/drbd/drbd_bitmap.c:572:27: sparse:    right side has type restricted __le32
   drivers/block/drbd/drbd_bitmap.c:924:13: sparse: sparse: context imbalance in 'drbd_bm_aio_ctx_destroy' - unexpected unlock
   drivers/block/drbd/drbd_int.h:1725:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf *
--
   drivers/block/drbd/drbd_proc.c:270:30: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_proc.c:270:30: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_proc.c:270:30: sparse:    struct net_conf *
--
   drivers/block/drbd/drbd_worker.c:621:39: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_worker.c:621:39: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_worker.c:621:39: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_worker.c:513:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_worker.c:513:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_worker.c:513:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_worker.c:514:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_worker.c:514:16: sparse:    struct fifo_buffer [noderef] __rcu *
   drivers/block/drbd/drbd_worker.c:514:16: sparse:    struct fifo_buffer *
   drivers/block/drbd/drbd_worker.c:563:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_worker.c:563:13: sparse:    struct fifo_buffer [noderef] __rcu *
   drivers/block/drbd/drbd_worker.c:563:13: sparse:    struct fifo_buffer *
   drivers/block/drbd/drbd_worker.c:567:39: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_worker.c:567:39: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_worker.c:567:39: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_worker.c:1000:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_worker.c:1000:22: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_worker.c:1000:22: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_worker.c:1542:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_worker.c:1542:32: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_worker.c:1542:32: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_worker.c:1651:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_worker.c:1651:32: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_worker.c:1651:32: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_worker.c:1688:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_worker.c:1688:16: sparse:    struct fifo_buffer [noderef] __rcu *
   drivers/block/drbd/drbd_worker.c:1688:16: sparse:    struct fifo_buffer *
   drivers/block/drbd/drbd_worker.c:1717:34: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_worker.c:1717:34: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_worker.c:1717:34: sparse:    struct net_conf *
   drivers/block/drbd/drbd_worker.c:1890:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_worker.c:1890:38: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_worker.c:1890:38: sparse:    struct net_conf *
   drivers/block/drbd/drbd_worker.c:2095:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_worker.c:2095:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_worker.c:2095:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_worker.c:2150:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_worker.c:2150:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_worker.c:2150:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_worker.c:59:25: sparse: sparse: context imbalance in 'drbd_md_endio' - unexpected unlock
   drivers/block/drbd/drbd_int.h:1725:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_int.h:1725:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_int.h:2144:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf *
--
   drivers/block/drbd/drbd_receiver.c:5361:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5361:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5361:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5361:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5361:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5361:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5362:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5362:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5362:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5362:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5362:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5362:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5371:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5371:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5371:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5371:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5371:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5371:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5428:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_receiver.c:5428:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:5428:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:271:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:271:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:271:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:527:29: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:527:29: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:527:29: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:599:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:599:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:599:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:703:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:703:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:703:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:772:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:772:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:772:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:1165:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1165:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1165:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1165:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1166:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1166:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1166:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1166:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1167:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1167:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1167:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1167:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1167:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1167:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1171:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1171:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1171:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1171:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1172:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1172:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1172:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1172:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1172:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1172:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1177:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1177:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1177:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1177:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1178:28: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1178:28: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1178:28: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1178:28: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:820:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:820:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:820:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:875:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:875:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:875:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:1040:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:1040:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:1040:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:1432:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_receiver.c:1432:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:1432:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:1587:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:1587:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:1587:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:1893:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1893:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1893:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1893:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1893:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1893:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1897:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1897:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1897:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1897:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1897:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1897:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1909:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1909:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1909:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1909:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1909:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1909:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2157:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2157:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2157:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2157:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2157:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2157:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2157:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2157:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2157:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2157:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2191:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2191:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2191:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2191:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2191:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2191:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2191:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2191:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2191:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2191:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2405:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:2405:22: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:2405:22: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:2415:27: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:2415:27: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:2415:27: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:2594:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2594:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2594:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2594:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2594:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2594:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2622:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2622:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2622:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2622:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2622:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2622:18: sparse: sparse: too many warnings
   drivers/block/drbd/drbd_receiver.c:2666:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:2666:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:2666:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:2798:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:2798:22: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:2798:22: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:3066:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3066:23: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3066:23: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3142:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3142:23: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3142:23: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3199:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3199:23: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3199:23: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3545:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3545:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3545:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3703:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3703:22: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3703:22: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3789:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3789:9: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3789:9: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:4044:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:4044:25: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:4044:25: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:4049:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:4049:17: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:4049:17: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:4055:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_receiver.c:4055:17: sparse:    struct fifo_buffer [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:4055:17: sparse:    struct fifo_buffer *
   drivers/block/drbd/drbd_receiver.c:4132:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:4132:28: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:4132:28: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:4174:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:4174:25: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:4174:25: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:5969:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:5969:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:5969:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:6062:37: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:6062:37: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:6062:37: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:6159:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:6159:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:6159:14: sparse:    struct net_conf *
--
   drivers/block/drbd/drbd_req.c:575:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_req.c:575:22: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_req.c:575:22: sparse:    struct net_conf *
   drivers/block/drbd/drbd_req.c:688:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_req.c:688:22: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_req.c:688:22: sparse:    struct net_conf *
   drivers/block/drbd/drbd_req.c:980:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_req.c:980:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_req.c:980:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_req.c:1053:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_req.c:1053:15: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_req.c:1053:15: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_req.c:1699:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_req.c:1699:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_req.c:1699:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_req.c:1706:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_req.c:1706:22: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_req.c:1706:22: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_int.h:2144:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:1725:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_int.h:1725:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_int.h:2144:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:2144:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:2144:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:1725:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf *
--
   drivers/block/drbd/drbd_actlog.c:111:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_actlog.c:111:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_actlog.c:111:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_actlog.c:386:36: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_actlog.c:386:36: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_actlog.c:386:36: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_actlog.c:457:44: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_actlog.c:457:44: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_actlog.c:457:44: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_int.h:1725:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_int.h:1725:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf *
--
   drivers/block/drbd/drbd_main.c:575:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] magic @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:575:20: sparse:     expected unsigned int [usertype] magic
   drivers/block/drbd/drbd_main.c:575:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:576:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] command @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_main.c:576:20: sparse:     expected unsigned short [usertype] command
   drivers/block/drbd/drbd_main.c:576:20: sparse:     got restricted __be16 [usertype]
   drivers/block/drbd/drbd_main.c:577:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] length @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_main.c:577:20: sparse:     expected unsigned short [usertype] length
   drivers/block/drbd/drbd_main.c:577:20: sparse:     got restricted __be16 [usertype]
   drivers/block/drbd/drbd_main.c:583:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] magic @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_main.c:583:20: sparse:     expected unsigned short [usertype] magic
   drivers/block/drbd/drbd_main.c:583:20: sparse:     got restricted __be16 [usertype]
   drivers/block/drbd/drbd_main.c:584:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] command @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_main.c:584:20: sparse:     expected unsigned short [usertype] command
   drivers/block/drbd/drbd_main.c:584:20: sparse:     got restricted __be16 [usertype]
   drivers/block/drbd/drbd_main.c:585:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:585:19: sparse:     expected unsigned int [usertype] length
   drivers/block/drbd/drbd_main.c:585:19: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:592:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] magic @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:592:18: sparse:     expected unsigned int [usertype] magic
   drivers/block/drbd/drbd_main.c:592:18: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:593:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] volume @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_main.c:593:19: sparse:     expected unsigned short [usertype] volume
   drivers/block/drbd/drbd_main.c:593:19: sparse:     got restricted __be16 [usertype]
   drivers/block/drbd/drbd_main.c:594:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] command @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_main.c:594:20: sparse:     expected unsigned short [usertype] command
   drivers/block/drbd/drbd_main.c:594:20: sparse:     got restricted __be16 [usertype]
   drivers/block/drbd/drbd_main.c:595:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:595:19: sparse:     expected unsigned int [usertype] length
   drivers/block/drbd/drbd_main.c:595:19: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:734:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_main.c:734:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_main.c:734:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_main.c:748:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_main.c:748:22: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_main.c:748:22: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_main.c:785:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_main.c:785:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_main.c:785:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_main.c:845:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:849:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:851:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_main.c:851:23: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_main.c:851:23: sparse:    struct net_conf *
   drivers/block/drbd/drbd_main.c:910:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] uuid @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:921:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] physical_block_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:922:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] logical_block_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:923:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] alignment_offset @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:924:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] io_min @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:925:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] io_opt @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:930:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] physical_block_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:931:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] logical_block_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:933:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] io_min @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:934:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] io_opt @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:964:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_main.c:964:26: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_main.c:964:26: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_main.c:1007:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] state @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1030:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] state @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1043:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] mask @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1044:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1059:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] mask @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1060:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1072:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] retcode @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1086:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] retcode @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1123:19: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_main.c:1123:19: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_main.c:1123:19: sparse:    struct net_conf *
   drivers/block/drbd/drbd_main.c:1330:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] set_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1330:21: sparse:     expected unsigned int [usertype] set_size
   drivers/block/drbd/drbd_main.c:1330:21: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1358:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] seq_num @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1358:20: sparse:     expected unsigned int [usertype] seq_num
   drivers/block/drbd/drbd_main.c:1358:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1370:54: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1370:54: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1370:54: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1390:31: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1390:31: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1390:31: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1391:31: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1391:31: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1391:31: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1401:31: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1401:31: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1401:31: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1402:31: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1402:31: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1402:31: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1403:31: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected unsigned long long [usertype] block_id @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1403:31: sparse:     expected unsigned long long [usertype] block_id
   drivers/block/drbd/drbd_main.c:1403:31: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1416:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1416:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1416:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1417:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1417:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1417:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1432:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1432:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1432:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1434:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1434:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1434:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1450:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1450:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1450:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1452:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1452:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1452:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1465:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1465:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1465:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1467:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1467:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1467:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1690:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1690:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1690:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1692:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] seq_num @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1692:20: sparse:     expected unsigned int [usertype] seq_num
   drivers/block/drbd/drbd_main.c:1692:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1706:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dp_flags @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1706:21: sparse:     expected unsigned int [usertype] dp_flags
   drivers/block/drbd/drbd_main.c:1706:21: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1711:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1711:25: sparse:     expected unsigned int [usertype] size
   drivers/block/drbd/drbd_main.c:1711:25: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1721:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1721:29: sparse:     expected unsigned int [usertype] size
   drivers/block/drbd/drbd_main.c:1721:29: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1797:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1797:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1797:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1820:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1820:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1820:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1821:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1821:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1821:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1857:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_main.c:1857:40: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_main.c:1857:40: sparse:    struct net_conf *
   drivers/block/drbd/drbd_main.c:3106:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] la_size_sect @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:3106:30: sparse:     expected unsigned long long [usertype] la_size_sect
   drivers/block/drbd/drbd_main.c:3106:30: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:3108:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:3108:33: sparse:     expected unsigned long long
   drivers/block/drbd/drbd_main.c:3108:33: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:3109:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3109:23: sparse:     expected unsigned int [usertype] flags
   drivers/block/drbd/drbd_main.c:3109:23: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3110:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] magic @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3110:23: sparse:     expected unsigned int [usertype] magic
   drivers/block/drbd/drbd_main.c:3110:23: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3112:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] md_size_sect @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3112:31: sparse:     expected unsigned int [usertype] md_size_sect
   drivers/block/drbd/drbd_main.c:3112:31: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3113:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_offset @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3113:31: sparse:     expected unsigned int [usertype] al_offset
   drivers/block/drbd/drbd_main.c:3113:31: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3114:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_nr_extents @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3114:31: sparse:     expected unsigned int [usertype] al_nr_extents
   drivers/block/drbd/drbd_main.c:3114:31: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3115:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bm_bytes_per_bit @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3115:34: sparse:     expected unsigned int [usertype] bm_bytes_per_bit
   drivers/block/drbd/drbd_main.c:3115:34: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3116:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] device_uuid @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:3116:29: sparse:     expected unsigned long long [usertype] device_uuid
   drivers/block/drbd/drbd_main.c:3116:29: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:3118:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bm_offset @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3118:27: sparse:     expected unsigned int [usertype] bm_offset
   drivers/block/drbd/drbd_main.c:3118:27: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3119:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] la_peer_max_bio_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3119:38: sparse:     expected unsigned int [usertype] la_peer_max_bio_size
   drivers/block/drbd/drbd_main.c:3119:38: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3121:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_stripes @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3121:28: sparse:     expected unsigned int [usertype] al_stripes
   drivers/block/drbd/drbd_main.c:3121:28: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3122:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_stripe_size_4k @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3122:35: sparse:     expected unsigned int [usertype] al_stripe_size_4k
   drivers/block/drbd/drbd_main.c:3122:35: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3175:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3175:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3175:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3175:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3175:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3175:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3176:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3176:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3176:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3176:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3176:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3176:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3338:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3338:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3338:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3338:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3338:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3338:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3339:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3339:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3339:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3339:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3339:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3339:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3357:13: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3357:13: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3357:13: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3357:13: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3357:13: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3357:13: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3358:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3358:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3358:17: sparse: sparse: too many warnings
   drivers/block/drbd/drbd_main.c:3778:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_main.c:3778:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_main.c:3778:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:2144:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:2144:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:2144:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:2144:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:1725:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:1725:14: sparse:    struct disk_conf *
--
   include/linux/genl_magic_func.h:212:12: sparse: sparse: symbol 'drbd_genl_cmd_to_str' was not declared. Should it be static?
   drivers/block/drbd/drbd_nl.c:454:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_nl.c:454:33: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:454:33: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_nl.c:691:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_nl.c:691:38: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:691:38: sparse:    struct net_conf *
   drivers/block/drbd/drbd_nl.c:793:40: sparse: sparse: mixing different enum types:
   drivers/block/drbd/drbd_nl.c:793:40: sparse:    int enum drbd_state_rv
   drivers/block/drbd/drbd_nl.c:793:40: sparse:    unsigned int enum drbd_ret_code
   drivers/block/drbd/drbd_nl.c:795:40: sparse: sparse: mixing different enum types:
   drivers/block/drbd/drbd_nl.c:795:40: sparse:    int enum drbd_state_rv
   drivers/block/drbd/drbd_nl.c:795:40: sparse:    unsigned int enum drbd_ret_code
   drivers/block/drbd/drbd_nl.c:980:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:980:18: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:980:18: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_nl.c:1287:41: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_nl.c:1287:41: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_nl.c:1287:41: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_nl.c:1287:41: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_nl.c:1287:41: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_nl.c:1287:41: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_nl.c:1347:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:1347:22: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:1347:22: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_nl.c:1647:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:1647:17: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:1647:17: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_nl.c:1657:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_nl.c:1657:17: sparse:    struct fifo_buffer [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:1657:17: sparse:    struct fifo_buffer *
   drivers/block/drbd/drbd_nl.c:1880:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:1880:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:1880:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_nl.c:2139:39: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:2139:39: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:2139:39: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_nl.c:2147:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:2147:13: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:2147:13: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_nl.c:2329:50: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:2329:50: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:2329:50: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_nl.c:2352:45: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:2352:45: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:2352:45: sparse:    struct net_conf *
   drivers/block/drbd/drbd_nl.c:2497:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:2497:9: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:2497:9: sparse:    struct net_conf *
   drivers/block/drbd/drbd_nl.c:2660:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:2660:9: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:2660:9: sparse:    struct net_conf *
   drivers/block/drbd/drbd_nl.c:2812:27: sparse: sparse: mixing different enum types:
   drivers/block/drbd/drbd_nl.c:2892:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:2892:18: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:2892:18: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_nl.c:2932:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:2932:17: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:2932:17: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_nl.c:3476:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:3476:33: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:3476:33: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_nl.c:3601:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:3601:28: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:3601:28: sparse:    struct net_conf *
   drivers/block/drbd/drbd_nl.c:3814:29: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:3814:29: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:3814:29: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_nl.c:3820:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:3820:22: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:3820:22: sparse:    struct net_conf *
   drivers/block/drbd/drbd_nl.c:4011:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_nl.c:4011:38: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:4011:38: sparse:    struct net_conf *
   drivers/block/drbd/drbd_nl.c:452:17: sparse: sparse: context imbalance in 'highest_fencing_policy' - different lock contexts for basic block
   drivers/block/drbd/drbd_int.h:2144:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2144:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:780:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:780:24: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:780:24: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:780:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:780:24: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:780:24: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:780:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:780:24: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:780:24: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:780:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:780:24: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:780:24: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:780:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:780:24: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:780:24: sparse:    struct net_conf *
--
   drivers/block/drbd/drbd_state.c:1903:30: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_state.c:1903:30: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_state.c:1903:30: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_state.c:834:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_state.c:834:22: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_state.c:834:22: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_state.c:838:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_state.c:838:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_state.c:838:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_state.c:1064:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_state.c:1064:22: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_state.c:1064:22: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_state.c:1341:36: sparse: sparse: cast to non-scalar
   drivers/block/drbd/drbd_state.c:1342:36: sparse: sparse: cast to non-scalar
   drivers/block/drbd/drbd_state.c:2069:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_state.c:2069:17: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_state.c:2069:17: sparse:    struct net_conf *
   drivers/block/drbd/drbd_state.c:838:14: sparse: sparse: context imbalance in 'is_valid_state' - different lock contexts for basic block
   drivers/block/drbd/drbd_state.c:1070:9: sparse: sparse: context imbalance in 'sanitize_state' - different lock contexts for basic block
   drivers/block/drbd/drbd_state.c:1949:25: sparse: sparse: context imbalance in 'after_state_ch' - unexpected unlock
   drivers/block/drbd/drbd_state.c:2364:32: sparse: sparse: context imbalance in '_conn_request_state' - unexpected unlock
--
>> drivers/mtd/devices/phram.c:85:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *priv @@
>> drivers/mtd/devices/phram.c:85:34: sparse:     expected void const [noderef] __iomem *addr
   drivers/mtd/devices/phram.c:85:34: sparse:     got void *priv
   drivers/mtd/devices/phram.c:101:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *priv @@     got void [noderef] __iomem * @@
   drivers/mtd/devices/phram.c:101:23: sparse:     expected void *priv
   drivers/mtd/devices/phram.c:101:23: sparse:     got void [noderef] __iomem *
   drivers/mtd/devices/phram.c:131:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *priv @@
   drivers/mtd/devices/phram.c:131:25: sparse:     expected void const [noderef] __iomem *addr
   drivers/mtd/devices/phram.c:131:25: sparse:     got void *priv
--
>> net/ipv4/tcp_cong.c:228:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct tcp_congestion_ops const *prev @@     got struct tcp_congestion_ops const [noderef] __rcu *[assigned] old_val @@
   net/ipv4/tcp_cong.c:228:22: sparse:     expected struct tcp_congestion_ops const *prev
>> net/ipv4/tcp_cong.c:228:22: sparse:     got struct tcp_congestion_ops const [noderef] __rcu *[assigned] old_val

vim +1725 drivers/block/drbd/drbd_int.h

383606e0dea6a38 Lars Ellenberg      2012-06-14  1716  
b411b3637fa71fc Philipp Reisner     2009-09-25  1717  #define __drbd_chk_io_error(m,f) __drbd_chk_io_error_(m,f, __func__)
b30ab7913b0a7b1 Andreas Gruenbacher 2011-07-03  1718  static inline void __drbd_chk_io_error_(struct drbd_device *device,
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1719  		enum drbd_force_detach_flags df,
383606e0dea6a38 Lars Ellenberg      2012-06-14  1720  		const char *where)
b411b3637fa71fc Philipp Reisner     2009-09-25  1721  {
daeda1cca91d58b Philipp Reisner     2011-05-03  1722  	enum drbd_io_error_p ep;
daeda1cca91d58b Philipp Reisner     2011-05-03  1723  
daeda1cca91d58b Philipp Reisner     2011-05-03  1724  	rcu_read_lock();
b30ab7913b0a7b1 Andreas Gruenbacher 2011-07-03 @1725  	ep = rcu_dereference(device->ldev->disk_conf)->on_io_error;
daeda1cca91d58b Philipp Reisner     2011-05-03  1726  	rcu_read_unlock();
daeda1cca91d58b Philipp Reisner     2011-05-03  1727  	switch (ep) {
daeda1cca91d58b Philipp Reisner     2011-05-03  1728  	case EP_PASS_ON: /* FIXME would this be better named "Ignore"? */
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1729  		if (df == DRBD_READ_ERROR || df == DRBD_WRITE_ERROR) {
7383506c87237db Lars Ellenberg      2010-05-27  1730  			if (__ratelimit(&drbd_ratelimit_state))
d01801710265cfb Andreas Gruenbacher 2011-07-03  1731  				drbd_err(device, "Local IO failed in %s.\n", where);
b30ab7913b0a7b1 Andreas Gruenbacher 2011-07-03  1732  			if (device->state.disk > D_INCONSISTENT)
b30ab7913b0a7b1 Andreas Gruenbacher 2011-07-03  1733  				_drbd_set_state(_NS(device, disk, D_INCONSISTENT), CS_HARD, NULL);
b411b3637fa71fc Philipp Reisner     2009-09-25  1734  			break;
b411b3637fa71fc Philipp Reisner     2009-09-25  1735  		}
e16fb3a8d27189a Gustavo A. R. Silva 2019-01-23  1736  		/* fall through - for DRBD_META_IO_ERROR or DRBD_FORCE_DETACH */
b411b3637fa71fc Philipp Reisner     2009-09-25  1737  	case EP_DETACH:
b411b3637fa71fc Philipp Reisner     2009-09-25  1738  	case EP_CALL_HELPER:
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1739  		/* Remember whether we saw a READ or WRITE error.
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1740  		 *
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1741  		 * Recovery of the affected area for WRITE failure is covered
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1742  		 * by the activity log.
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1743  		 * READ errors may fall outside that area though. Certain READ
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1744  		 * errors can be "healed" by writing good data to the affected
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1745  		 * blocks, which triggers block re-allocation in lower layers.
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1746  		 *
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1747  		 * If we can not write the bitmap after a READ error,
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1748  		 * we may need to trigger a full sync (see w_go_diskless()).
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1749  		 *
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1750  		 * Force-detach is not really an IO error, but rather a
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1751  		 * desperate measure to try to deal with a completely
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1752  		 * unresponsive lower level IO stack.
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1753  		 * Still it should be treated as a WRITE error.
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1754  		 *
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1755  		 * Meta IO error is always WRITE error:
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1756  		 * we read meta data only once during attach,
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1757  		 * which will fail in case of errors.
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1758  		 */
b30ab7913b0a7b1 Andreas Gruenbacher 2011-07-03  1759  		set_bit(WAS_IO_ERROR, &device->flags);
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1760  		if (df == DRBD_READ_ERROR)
b30ab7913b0a7b1 Andreas Gruenbacher 2011-07-03  1761  			set_bit(WAS_READ_ERROR, &device->flags);
a2a3c74f243d5d1 Lars Ellenberg      2012-09-22  1762  		if (df == DRBD_FORCE_DETACH)
b30ab7913b0a7b1 Andreas Gruenbacher 2011-07-03  1763  			set_bit(FORCE_DETACH, &device->flags);
b30ab7913b0a7b1 Andreas Gruenbacher 2011-07-03  1764  		if (device->state.disk > D_FAILED) {
b30ab7913b0a7b1 Andreas Gruenbacher 2011-07-03  1765  			_drbd_set_state(_NS(device, disk, D_FAILED), CS_HARD, NULL);
d01801710265cfb Andreas Gruenbacher 2011-07-03  1766  			drbd_err(device,
82f59cc6353889b Lars Ellenberg      2010-10-16  1767  				"Local IO failed in %s. Detaching...\n", where);
b411b3637fa71fc Philipp Reisner     2009-09-25  1768  		}
b411b3637fa71fc Philipp Reisner     2009-09-25  1769  		break;
b411b3637fa71fc Philipp Reisner     2009-09-25  1770  	}
b411b3637fa71fc Philipp Reisner     2009-09-25  1771  }
b411b3637fa71fc Philipp Reisner     2009-09-25  1772  

:::::: The code at line 1725 was first introduced by commit
:::::: b30ab7913b0a7b1d3b1091c8cb3abb1a9f1e0824 drbd: Rename "mdev" to "device"

:::::: TO: Andreas Gruenbacher <agruen@linbit.com>
:::::: CC: Philipp Reisner <philipp.reisner@linbit.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--J/dobhs11T7y2rNN
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--J/dobhs11T7y2rNN--
