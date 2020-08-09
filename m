Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFAAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 12:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C8C206B6
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 12:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgHIMNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 08:13:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:2868 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgHIMLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 08:11:38 -0400
IronPort-SDR: O2qktHtnCA2GSgqznWDmb0jJ+4atBvuNNA6NHVKdfIrUWPdRH8PYSHAJQPahm2TWdY6P9eR+L1
 fnb/5SQ2Ox8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9707"; a="141024427"
X-IronPort-AV: E=Sophos;i="5.75,453,1589266800"; 
   d="scan'208";a="141024427"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2020 05:11:36 -0700
IronPort-SDR: DORVzznwUnpcJ1QioXnxsjvUe9JaYCG/7mF0c704yejo/eRMxTHp1ptYDeKur7tyS5I20G+7yr
 q/wQRfTqz7Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,453,1589266800"; 
   d="scan'208";a="307803767"
Received: from lkp-server02.sh.intel.com (HELO 5ad9e2f13e37) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 09 Aug 2020 05:11:34 -0700
Received: from kbuild by 5ad9e2f13e37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k4kAo-00008y-9S; Sun, 09 Aug 2020 12:11:34 +0000
Date:   Sun, 9 Aug 2020 20:10:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: fs/f2fs/file.c:761:9: warning: Identical condition 'err', second
 condition is always false
Message-ID: <202008092050.gjiX70dJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06a81c1c7db9bd5de0bd38cd5acc44bb22b99150
commit: 3265d3db1f16395cfc6b8ea9b31b4001d98d05ef f2fs: support partial truncation on compressed inode
date:   3 months ago
compiler: xtensa-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> fs/f2fs/file.c:761:9: warning: Identical condition 'err', second condition is always false [identicalConditionAfterEarlyExit]
    return err;
           ^
   fs/f2fs/file.c:753:6: note: first condition
    if (err)
        ^
   fs/f2fs/file.c:761:9: note: second condition
    return err;
           ^
>> fs/f2fs/file.c:1689:12: warning: Variable 'new_size' is reassigned a value before the old one has been used. [redundantAssignment]
     new_size = (last_off == pg_end) ? offset + len :
              ^
   fs/f2fs/file.c:1620:0: note: Variable 'new_size' is reassigned a value before the old one has been used.
    loff_t new_size = i_size_read(inode);
   ^
   fs/f2fs/file.c:1689:12: note: Variable 'new_size' is reassigned a value before the old one has been used.
     new_size = (last_off == pg_end) ? offset + len :
              ^
>> fs/f2fs/file.c:2789:6: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
    ret = -EINVAL;
        ^
   fs/f2fs/file.c:2784:7: note: Variable 'ret' is reassigned a value before the old one has been used.
     ret = -EBUSY;
         ^
   fs/f2fs/file.c:2789:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = -EINVAL;
        ^
   fs/f2fs/file.c:2811:6: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
    ret = f2fs_convert_inline_inode(src);
        ^
   fs/f2fs/file.c:2789:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = -EINVAL;
        ^
   fs/f2fs/file.c:2811:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = f2fs_convert_inline_inode(src);
        ^
   fs/f2fs/file.c:2840:6: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
    ret = __exchange_data_block(src, dst, pos_in >> F2FS_BLKSIZE_BITS,
        ^
   fs/f2fs/file.c:2834:7: note: Variable 'ret' is reassigned a value before the old one has been used.
     ret = -EBUSY;
         ^
   fs/f2fs/file.c:2840:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = __exchange_data_block(src, dst, pos_in >> F2FS_BLKSIZE_BITS,
        ^
   fs/f2fs/f2fs.h:2209:15: warning: Local variable valid_node_count shadows outer function [shadowFunction]
    unsigned int valid_node_count, user_block_count;
                 ^
   fs/f2fs/f2fs.h:2305:28: note: Shadowed declaration
   static inline unsigned int valid_node_count(struct f2fs_sb_info *sbi)
                              ^
   fs/f2fs/f2fs.h:2209:15: note: Shadow variable
    unsigned int valid_node_count, user_block_count;
                 ^

vim +/err +761 fs/f2fs/file.c

   760	
 > 761		return err;
   762	}
   763	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
