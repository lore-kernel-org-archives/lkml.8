Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6180BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 23:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0F921775
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 23:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgGRXhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 19:37:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:50807 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgGRXhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 19:37:15 -0400
IronPort-SDR: NoWlNoCMfRB5VZ3I8ahRuz5NyQtXeJiiCBKeBxH/MszAxn7/c0SBatHsMoYVGZKE+J6yKHoAS+
 hWGYwrlkFQDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9686"; a="129343910"
X-IronPort-AV: E=Sophos;i="5.75,368,1589266800"; 
   d="gz'50?scan'50,208,50";a="129343910"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 15:41:02 -0700
IronPort-SDR: bJk01T3iWwU7yJDebQ6mUp7iDNw+giN/++5HdbykL9mzqgib1vNUYgrOYKl40CvkY2tsT9IPUP
 WY3lHksXEwVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,368,1589266800"; 
   d="gz'50?scan'50,208,50";a="317662332"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2020 15:40:59 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwvVr-0000xL-99; Sat, 18 Jul 2020 22:40:59 +0000
Date:   Sun, 19 Jul 2020 06:40:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/tdfxfb.c:1120:17: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202007190627.yKn6EaYg%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6cf7ccba29dcf39ab27630c383a3844078a6d5cd
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   4 weeks ago
config: s390-randconfig-s032-20200719 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-49-g707c5017-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/tdfxfb.c:1120:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got unsigned char [noderef] [usertype] __iomem *cursorbase @@
   drivers/video/fbdev/tdfxfb.c:1120:17: sparse:     expected void *s
   drivers/video/fbdev/tdfxfb.c:1120:17: sparse:     got unsigned char [noderef] [usertype] __iomem *cursorbase
   drivers/video/fbdev/tdfxfb.c:1131:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tdfxfb.c:1134:33: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
--
   drivers/scsi/megaraid/megaraid_sas_base.c:4534:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4534:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4534:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:4785:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4785:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4785:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:6594:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6594:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:6594:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:4441:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4441:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4441:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:281:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/megaraid/megaraid_sas_base.c:281:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/megaraid/megaraid_sas_base.c:281:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/megaraid/megaraid_sas_base.c:281:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/megaraid/megaraid_sas_base.c:287:31: sparse: sparse: cast from restricted __le16
   drivers/scsi/megaraid/megaraid_sas_base.c:287:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] flags @@
   drivers/scsi/megaraid/megaraid_sas_base.c:287:31: sparse:     expected unsigned short [usertype] val
   drivers/scsi/megaraid/megaraid_sas_base.c:287:31: sparse:     got restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:287:31: sparse: sparse: cast from restricted __le16
   drivers/scsi/megaraid/megaraid_sas_base.c:287:31: sparse: sparse: cast from restricted __le16
   drivers/scsi/megaraid/megaraid_sas_base.c:413:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:413:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:413:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:413:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:413:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:413:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:1206:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] opcode @@     got restricted __le32 [usertype] opcode @@
   drivers/scsi/megaraid/megaraid_sas_base.c:1206:32: sparse:     expected unsigned int [usertype] opcode
   drivers/scsi/megaraid/megaraid_sas_base.c:1206:32: sparse:     got restricted __le32 [usertype] opcode
   drivers/scsi/megaraid/megaraid_sas_base.c:1984:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:1984:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:1984:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:1984:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:1984:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:1984:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:2025:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:2025:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:2025:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:2025:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:2025:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:2025:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:4665:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4665:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4665:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:4904:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4904:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4904:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:5089:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:5089:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:5089:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:5171:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:5171:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:5171:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:6147:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/megaraid/megaraid_sas_base.c:6146:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] [usertype] __iomem * @@     got unsigned int [usertype] * @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6146:57: sparse:     expected unsigned int [noderef] [usertype] __iomem *
   drivers/scsi/megaraid/megaraid_sas_base.c:6146:57: sparse:     got unsigned int [usertype] *
   drivers/scsi/megaraid/megaraid_sas_base.c:6151:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/megaraid/megaraid_sas_base.c:6150:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] [usertype] __iomem * @@     got unsigned int [usertype] * @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6150:57: sparse:     expected unsigned int [noderef] [usertype] __iomem *
   drivers/scsi/megaraid/megaraid_sas_base.c:6150:57: sparse:     got unsigned int [usertype] *
   drivers/scsi/megaraid/megaraid_sas_base.c:6458:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6458:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:6458:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:6672:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6672:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:6672:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:7407:44: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/megaraid/megaraid_sas_base.c:8031:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected int crash_support @@     got restricted __le32 @@
   drivers/scsi/megaraid/megaraid_sas_base.c:8031:23: sparse:     expected int crash_support
   drivers/scsi/megaraid/megaraid_sas_base.c:8031:23: sparse:     got restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:8114:31: sparse: sparse: invalid assignment: &=
   drivers/scsi/megaraid/megaraid_sas_base.c:8114:31: sparse:    left side has type restricted __le16
   drivers/scsi/megaraid/megaraid_sas_base.c:8114:31: sparse:    right side has type int
   drivers/scsi/megaraid/megaraid_sas_base.c:8208:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long @@     got restricted __le64 [usertype] @@
   drivers/scsi/megaraid/megaraid_sas_base.c:8208:36: sparse:     expected unsigned long
   drivers/scsi/megaraid/megaraid_sas_base.c:8208:36: sparse:     got restricted __le64 [usertype]
   drivers/scsi/megaraid/megaraid_sas_base.c:8210:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long @@     got restricted __le32 [usertype] @@
   drivers/scsi/megaraid/megaraid_sas_base.c:8210:36: sparse:     expected unsigned long
   drivers/scsi/megaraid/megaraid_sas_base.c:8210:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] *sense_cioc_ptr @@
   drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     expected void const volatile [noderef] __user *
   drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     got unsigned int [usertype] *sense_cioc_ptr
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] *sense_cioc_ptr @@
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     expected void const [noderef] __user *ptr
   drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     got unsigned int [usertype] *sense_cioc_ptr
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] *sense_cioc_ptr @@
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     expected void const [noderef] __user *ptr
   drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     got unsigned int [usertype] *sense_cioc_ptr
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] *sense_cioc_ptr @@
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     expected void const [noderef] __user *ptr
   drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     got unsigned int [usertype] *sense_cioc_ptr
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] *sense_cioc_ptr @@
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     expected void const [noderef] __user *ptr
   drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     got unsigned int [usertype] *sense_cioc_ptr
   drivers/scsi/megaraid/megaraid_sas_base.c:8459:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got void [noderef] __user **sense_ioc_ptr @@
   drivers/scsi/megaraid/megaraid_sas_base.c:8459:21: sparse:     expected void const volatile [noderef] __user *
   drivers/scsi/megaraid/megaraid_sas_base.c:8459:21: sparse:     got void [noderef] __user **sense_ioc_ptr
>> drivers/scsi/megaraid/megaraid_sas_base.c:8459:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *ptr @@     got void [noderef] __user **sense_ioc_ptr @@
>> drivers/scsi/megaraid/megaraid_sas_base.c:8459:21: sparse:     expected void [noderef] __user *ptr
   drivers/scsi/megaraid/megaraid_sas_base.c:8459:21: sparse:     got void [noderef] __user **sense_ioc_ptr
   drivers/scsi/megaraid/megaraid_sas_base.c:8665:46: sparse: sparse: restricted __le32 degrades to integer
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: too many warnings
--
>> drivers/video/fbdev/kyro/fbdev.c:725:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/kyro/fbdev.c:725:9: sparse:     expected void *s
   drivers/video/fbdev/kyro/fbdev.c:725:9: sparse:     got char [noderef] __iomem *screen_base

vim +1120 drivers/video/fbdev/tdfxfb.c

^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1040  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1041  static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1042  {
a807f618b62594 drivers/video/tdfxfb.c Antonino A. Daplas 2006-01-09  1043  	struct tdfx_par *par = info->par;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1044  	u32 vidcfg;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1045  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1046  	if (!hwcursor)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1047  		return -EINVAL;	/* just to force soft_cursor() call */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1048  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1049  	/* Too large of a cursor or wrong bpp :-( */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1050  	if (cursor->image.width > 64 ||
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1051  	    cursor->image.height > 64 ||
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1052  	    cursor->image.depth > 1)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1053  		return -EINVAL;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1054  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1055  	vidcfg = tdfx_inl(par, VIDPROCCFG);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1056  	if (cursor->enable)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1057  		tdfx_outl(par, VIDPROCCFG, vidcfg | VIDCFG_HWCURSOR_ENABLE);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1058  	else
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1059  		tdfx_outl(par, VIDPROCCFG, vidcfg & ~VIDCFG_HWCURSOR_ENABLE);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1060  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1061  	/*
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1062  	 * If the cursor is not be changed this means either we want the
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1063  	 * current cursor state (if enable is set) or we want to query what
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1064  	 * we can do with the cursor (if enable is not set)
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1065  	 */
8af1d50f7f6793 drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1066  	if (!cursor->set)
8af1d50f7f6793 drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1067  		return 0;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1068  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1069  	/* fix cursor color - XFree86 forgets to restore it properly */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1070  	if (cursor->set & FB_CUR_SETCMAP) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1071  		struct fb_cmap cmap = info->cmap;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1072  		u32 bg_idx = cursor->image.bg_color;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1073  		u32 fg_idx = cursor->image.fg_color;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1074  		unsigned long bg_color, fg_color;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1075  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1076  		fg_color = (((u32)cmap.red[fg_idx]   & 0xff00) << 8) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1077  			   (((u32)cmap.green[fg_idx] & 0xff00) << 0) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1078  			   (((u32)cmap.blue[fg_idx]  & 0xff00) >> 8);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1079  		bg_color = (((u32)cmap.red[bg_idx]   & 0xff00) << 8) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1080  			   (((u32)cmap.green[bg_idx] & 0xff00) << 0) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1081  			   (((u32)cmap.blue[bg_idx]  & 0xff00) >> 8);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1082  		banshee_make_room(par, 2);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1083  		tdfx_outl(par, HWCURC0, bg_color);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1084  		tdfx_outl(par, HWCURC1, fg_color);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1085  	}
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1086  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1087  	if (cursor->set & FB_CUR_SETPOS) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1088  		int x = cursor->image.dx;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1089  		int y = cursor->image.dy - info->var.yoffset;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1090  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1091  		x += 63;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1092  		y += 63;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1093  		banshee_make_room(par, 1);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1094  		tdfx_outl(par, HWCURLOC, (y << 16) + x);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1095  	}
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1096  	if (cursor->set & (FB_CUR_SETIMAGE | FB_CUR_SETSHAPE)) {
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1097  		/*
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1098  		 * Voodoo 3 and above cards use 2 monochrome cursor patterns.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1099  		 *    The reason is so the card can fetch 8 words at a time
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1100  		 * and are stored on chip for use for the next 8 scanlines.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1101  		 * This reduces the number of times for access to draw the
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1102  		 * cursor for each screen refresh.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1103  		 *    Each pattern is a bitmap of 64 bit wide and 64 bit high
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1104  		 * (total of 8192 bits or 1024 bytes). The two patterns are
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1105  		 * stored in such a way that pattern 0 always resides in the
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1106  		 * lower half (least significant 64 bits) of a 128 bit word
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1107  		 * and pattern 1 the upper half. If you examine the data of
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1108  		 * the cursor image the graphics card uses then from the
25985edcedea63 drivers/video/tdfxfb.c Lucas De Marchi    2011-03-30  1109  		 * beginning you see line one of pattern 0, line one of
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1110  		 * pattern 1, line two of pattern 0, line two of pattern 1,
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1111  		 * etc etc. The linear stride for the cursor is always 16 bytes
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1112  		 * (128 bits) which is the maximum cursor width times two for
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1113  		 * the two monochrome patterns.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1114  		 */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1115  		u8 __iomem *cursorbase = info->screen_base + info->fix.smem_len;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1116  		u8 *bitmap = (u8 *)cursor->image.data;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1117  		u8 *mask = (u8 *)cursor->mask;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1118  		int i;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1119  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16 @1120  		fb_memset(cursorbase, 0, 1024);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1121  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1122  		for (i = 0; i < cursor->image.height; i++) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1123  			int h = 0;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1124  			int j = (cursor->image.width + 7) >> 3;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1125  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1126  			for (; j > 0; j--) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1127  				u8 data = *mask ^ *bitmap;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1128  				if (cursor->rop == ROP_COPY)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1129  					data = *mask & *bitmap;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1130  				/* Pattern 0. Copy the cursor mask to it */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1131  				fb_writeb(*mask, cursorbase + h);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1132  				mask++;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1133  				/* Pattern 1. Copy the cursor bitmap to it */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1134  				fb_writeb(data, cursorbase + h + 8);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1135  				bitmap++;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1136  				h++;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1137  			}
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1138  			cursorbase += 16;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1139  		}
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1140  	}
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1141  	return 0;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1142  }
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1143  

:::::: The code at line 1120 was first introduced by commit
:::::: 90b0f08536531abbbe7b5d4944792da08cadde01 tdfxfb: hardware cursor

:::::: TO: Krzysztof Helt <krzysztof.h1@wp.pl>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--u3/rZRmxL6MmkK24
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
4cZOyEckCLAwFtP/AV1EQDEYogEA

--u3/rZRmxL6MmkK24--
