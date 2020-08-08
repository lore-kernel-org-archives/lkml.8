Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133A7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 03:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB68214F1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 03:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgHHDgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 23:36:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:6958 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgHHDgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 23:36:36 -0400
IronPort-SDR: fb4ODeR6K4HnUcc5en7EwlOV0CHQel+cdHnQ1wwgm2Ff12wQJFqvaz59NKeRHHlLl/y0rmNlGc
 RAqKM1MlnI9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9706"; a="141106442"
X-IronPort-AV: E=Sophos;i="5.75,448,1589266800"; 
   d="scan'208";a="141106442"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 20:36:35 -0700
IronPort-SDR: YCM9EXbK/jh/TXTYVnB9ql35sqCQ845r9LoyiK6mYKlUsLwY5MO8wcXm99P/dz9QDI27s6GwGf
 DqUIg5Y4IDJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,448,1589266800"; 
   d="scan'208";a="289816114"
Received: from lkp-server02.sh.intel.com (HELO 090e49ab5480) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 07 Aug 2020 20:36:34 -0700
Received: from kbuild by 090e49ab5480 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k4Fes-0000dk-2J; Sat, 08 Aug 2020 03:36:34 +0000
Date:   Sat, 8 Aug 2020 11:35:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: fs/init.c:72:8: warning: Variable 'error' is reassigned a value
 before the old one has been used.
Message-ID: <202008081143.D8Y8xO2X%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   30185b69a2d533c4ba6ca926b8390ce7de495e29
commit: 4b7ca5014cbef51cdb99fd644eae4f3773747a05 init: add an init_chroot helper
date:   8 days ago
compiler: hppa-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> fs/init.c:72:8: warning: Variable 'error' is reassigned a value before the old one has been used. [redundantAssignment]
    error = security_path_chroot(&path);
          ^
   fs/init.c:69:8: note: Variable 'error' is reassigned a value before the old one has been used.
    error = -EPERM;
          ^
   fs/init.c:72:8: note: Variable 'error' is reassigned a value before the old one has been used.
    error = security_path_chroot(&path);
          ^

vim +/error +72 fs/init.c

    57	
    58	int __init init_chroot(const char *filename)
    59	{
    60		struct path path;
    61		int error;
    62	
    63		error = kern_path(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
    64		if (error)
    65			return error;
    66		error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
    67		if (error)
    68			goto dput_and_out;
    69		error = -EPERM;
    70		if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT))
    71			goto dput_and_out;
  > 72		error = security_path_chroot(&path);
    73		if (error)
    74			goto dput_and_out;
    75		set_fs_root(current->fs, &path);
    76	dput_and_out:
    77		path_put(&path);
    78		return error;
    79	}
    80	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
