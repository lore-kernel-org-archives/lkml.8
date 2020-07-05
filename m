Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBB8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCDA2068F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgGEUp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:45:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:62668 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbgGEUp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:45:28 -0400
IronPort-SDR: McBNPru9Cwunw1SdW5ngbsmXPKbdGQTOHSoKR9+sP/Qt8X6lbtYkyC7clddq+i9L4VvEfuCdJw
 pFqlVbU48IqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="232183475"
X-IronPort-AV: E=Sophos;i="5.75,317,1589266800"; 
   d="gz'50?scan'50,208,50";a="232183475"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2020 13:38:49 -0700
IronPort-SDR: JIKSsclS3wknfNgOxXKBa9OKgBrAOaNS7YYQDhFpBnMx/Zss5e/HCobrJYUK2VRZTUVFu3P0NE
 hglUhOiu5peg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,317,1589266800"; 
   d="gz'50?scan'50,208,50";a="267767704"
Received: from lkp-server01.sh.intel.com (HELO 6dc8ab148a5d) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2020 13:38:47 -0700
Received: from kbuild by 6dc8ab148a5d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jsBPS-0001vp-KW; Sun, 05 Jul 2020 20:38:46 +0000
Date:   Mon, 6 Jul 2020 04:38:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: sound/pcmcia/vx/vxp_ops.c:50:16: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202007060423.RQyOPIjQ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bb5a93aaf25261321db0c499cde7da6ee9d8b164
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   2 weeks ago
config: riscv-randconfig-s032-20200705 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> sound/pcmcia/vx/vxp_ops.c:50:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/vx/vxp_ops.c:50:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/vx/vxp_ops.c:50:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/vx/vxp_ops.c:50:16: sparse:     got void *
   sound/pcmcia/vx/vxp_ops.c:60:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/vx/vxp_ops.c:60:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/vx/vxp_ops.c:60:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/vx/vxp_ops.c:60:9: sparse:     got void *
   sound/pcmcia/vx/vxp_ops.c:365:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/vx/vxp_ops.c:365:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/vx/vxp_ops.c:365:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/vx/vxp_ops.c:365:25: sparse:     got void *
   sound/pcmcia/vx/vxp_ops.c:375:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/vx/vxp_ops.c:375:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/vx/vxp_ops.c:375:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/vx/vxp_ops.c:375:17: sparse:     got void *
   sound/pcmcia/vx/vxp_ops.c:407:35: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/vx/vxp_ops.c:407:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/vx/vxp_ops.c:407:35: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/vx/vxp_ops.c:407:35: sparse:     got void *
   sound/pcmcia/vx/vxp_ops.c:415:27: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/vx/vxp_ops.c:415:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/vx/vxp_ops.c:415:27: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/vx/vxp_ops.c:415:27: sparse:     got void *
   sound/pcmcia/vx/vxp_ops.c:420:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/vx/vxp_ops.c:420:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/vx/vxp_ops.c:420:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/vx/vxp_ops.c:420:17: sparse:     got void *
--
>> drivers/hwmon/f71882fg.c:1159:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/f71882fg.c:1159:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/f71882fg.c:1159:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1159:9: sparse:     got void *
   drivers/hwmon/f71882fg.c:1160:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/f71882fg.c:1160:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/f71882fg.c:1160:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1160:15: sparse:     got void *
   drivers/hwmon/f71882fg.c:1177:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1177:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1177:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1177:9: sparse:     got void *
   drivers/hwmon/f71882fg.c:1178:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1178:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1178:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1178:9: sparse:     got void *
   drivers/hwmon/f71882fg.c:1106:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1106:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1106:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1106:9: sparse:     got void *
   drivers/hwmon/f71882fg.c:1107:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1107:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1107:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1107:16: sparse:     got void *
   drivers/hwmon/f71882fg.c:1106:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1106:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1106:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1106:9: sparse:     got void *
   drivers/hwmon/f71882fg.c:1107:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1107:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1107:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1107:16: sparse:     got void *
   drivers/hwmon/f71882fg.c:1127:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1127:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1127:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1127:9: sparse:     got void *
   drivers/hwmon/f71882fg.c:1128:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1128:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1128:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1128:9: sparse:     got void *
   drivers/hwmon/f71882fg.c:1135:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1135:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1135:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1135:9: sparse:     got void *
   drivers/hwmon/f71882fg.c:1136:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1136:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1136:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1136:9: sparse:     got void *
   drivers/hwmon/f71882fg.c:1135:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1135:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1135:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1135:9: sparse:     got void *
   drivers/hwmon/f71882fg.c:1136:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1136:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1136:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1136:9: sparse:     got void *
   drivers/hwmon/f71882fg.c:1106:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1106:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1106:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1106:9: sparse:     got void *
   drivers/hwmon/f71882fg.c:1107:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1107:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1107:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1107:16: sparse:     got void *
   drivers/hwmon/f71882fg.c:1106:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1106:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1106:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1106:9: sparse:     got void *
   drivers/hwmon/f71882fg.c:1107:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1107:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1107:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1107:16: sparse:     got void *
   drivers/hwmon/f71882fg.c:1141:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/f71882fg.c:1141:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/f71882fg.c:1141:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/f71882fg.c:1141:9: sparse:     got void *
--
>> drivers/hwmon/sch56xx-common.c:111:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/sch56xx-common.c:111:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/sch56xx-common.c:111:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:111:15: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:112:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/sch56xx-common.c:112:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/sch56xx-common.c:112:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:112:9: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:115:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:115:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:115:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:115:9: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:116:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:116:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:116:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:116:9: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:119:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:119:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:119:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:119:9: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:120:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:120:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:120:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:120:9: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:121:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:121:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:121:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:121:9: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:125:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:125:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:125:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:125:17: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:128:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:128:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:128:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:128:9: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:129:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:129:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:129:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:129:9: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:132:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:132:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:132:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:132:9: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:139:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:139:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:139:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:139:23: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:142:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:142:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:142:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:142:25: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:159:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:159:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:159:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:159:23: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:186:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:186:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:186:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:186:24: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:332:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:332:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:332:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:332:15: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:334:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:334:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:334:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:334:17: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:79:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:79:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:79:9: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:67:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:67:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:67:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:67:9: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:68:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:68:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:68:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:68:16: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:86:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:86:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:86:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:86:9: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:87:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:87:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:87:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:87:9: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:67:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:67:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:67:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:67:9: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:68:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:68:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:68:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:68:16: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:67:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:67:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:67:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:67:9: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:68:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:68:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:68:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/sch56xx-common.c:68:16: sparse:     got void *
   drivers/hwmon/sch56xx-common.c:67:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/sch56xx-common.c:67:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/sch56xx-common.c:67:9: sparse:     expected void volatile [noderef] __iomem *addr
--
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
   drivers/hwmon/w83627ehf.c:121:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:121:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:121:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:121:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:122:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:122:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:122:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:122:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:111:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:111:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:111:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:111:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:112:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:112:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:112:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:112:9: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
   drivers/hwmon/w83627ehf.c:111:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:111:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:111:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:111:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:112:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:112:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:112:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:112:9: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
   drivers/hwmon/w83627ehf.c:97:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:97:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:97:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:97:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:98:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:98:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:98:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:98:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:97:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:97:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:97:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:97:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:98:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:98:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:98:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:98:9: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
   drivers/hwmon/w83627ehf.c:130:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:130:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:130:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:130:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:131:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:131:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:131:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:131:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:132:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:132:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:132:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:132:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:121:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:121:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:121:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:121:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:122:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:122:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:122:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:122:9: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
   drivers/hwmon/w83627ehf.c:130:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:130:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:130:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:130:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:131:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:131:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:131:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:131:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:132:9: sparse: sparse: too many warnings

vim +/__iomem +50 sound/pcmcia/vx/vxp_ops.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  43  
^1da177e4c3f41 Linus Torvalds 2005-04-16  44  /*
^1da177e4c3f41 Linus Torvalds 2005-04-16  45   * snd_vx_inb - read a byte from the register
^1da177e4c3f41 Linus Torvalds 2005-04-16  46   * @offset: register offset
^1da177e4c3f41 Linus Torvalds 2005-04-16  47   */
af26367f69a474 Takashi Iwai   2005-11-17  48  static unsigned char vxp_inb(struct vx_core *chip, int offset)
^1da177e4c3f41 Linus Torvalds 2005-04-16  49  {
^1da177e4c3f41 Linus Torvalds 2005-04-16 @50  	return inb(vxp_reg_addr(chip, offset));
^1da177e4c3f41 Linus Torvalds 2005-04-16  51  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  52  
^1da177e4c3f41 Linus Torvalds 2005-04-16  53  /*
^1da177e4c3f41 Linus Torvalds 2005-04-16  54   * snd_vx_outb - write a byte on the register
^1da177e4c3f41 Linus Torvalds 2005-04-16  55   * @offset: the register offset
^1da177e4c3f41 Linus Torvalds 2005-04-16  56   * @val: the value to write
^1da177e4c3f41 Linus Torvalds 2005-04-16  57   */
af26367f69a474 Takashi Iwai   2005-11-17  58  static void vxp_outb(struct vx_core *chip, int offset, unsigned char val)
^1da177e4c3f41 Linus Torvalds 2005-04-16  59  {
^1da177e4c3f41 Linus Torvalds 2005-04-16 @60  	outb(val, vxp_reg_addr(chip, offset));
^1da177e4c3f41 Linus Torvalds 2005-04-16  61  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  62  

:::::: The code at line 50 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--LQksG6bCIzRHxTLp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
zicjJ4fU8lqWpqf/AQn+2j3WsAEA

--LQksG6bCIzRHxTLp--
