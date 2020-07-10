Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB11C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 04:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23EB22072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 04:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGJE4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 00:56:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:40770 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgGJE4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 00:56:46 -0400
IronPort-SDR: 0ALZuTgVWhXWSUZVIRVC2RhdcSwQsQScxNeK22NFjFAQCn5htP+CDGEtyajVghQcTxKwx28aX4
 BV6NnOhPozDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="128216101"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="gz'50?scan'50,208,50";a="128216101"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 21:30:26 -0700
IronPort-SDR: NKRcTp7KP2LMS3LpilZPSzGTPYarTwGkqKjFlPP9kwUDgjsg1bSn1EhcoXqW+Gf5IMVRDys3s1
 q71nneryhFBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="gz'50?scan'50,208,50";a="284385940"
Received: from lkp-server02.sh.intel.com (HELO 0fc60ea15964) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Jul 2020 21:30:23 -0700
Received: from kbuild by 0fc60ea15964 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtkg2-00001B-UV; Fri, 10 Jul 2020 04:30:22 +0000
Date:   Fri, 10 Jul 2020 12:29:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/tdfxfb.c:1120:27: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202007101217.a8z0IfHv%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bddd227f3dc55975e2b8dfa7fc6f959b062a2c7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: mips-randconfig-s031-20200710 (attached as .config)
compiler: mips64el-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-37-gc9676a3b-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/tdfxfb.c:1120:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *__s @@     got unsigned char [noderef] [usertype] __iomem *cursorbase @@
   drivers/video/fbdev/tdfxfb.c:1120:27: sparse:     expected void *__s
   drivers/video/fbdev/tdfxfb.c:1120:27: sparse:     got unsigned char [noderef] [usertype] __iomem *cursorbase
   drivers/video/fbdev/tdfxfb.c:1131:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tdfxfb.c:1134:33: sparse: sparse: cast removes address space '__iomem' of expression
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
--
>> drivers/video/fbdev/aty/mach64_cursor.c:156:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *__s @@     got unsigned char [noderef] [usertype] __iomem *dst @@
   drivers/video/fbdev/aty/mach64_cursor.c:156:23: sparse:     expected void *__s
   drivers/video/fbdev/aty/mach64_cursor.c:156:23: sparse:     got unsigned char [noderef] [usertype] __iomem *dst
   drivers/video/fbdev/aty/mach64_cursor.c:187:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/aty/mach64_cursor.c:188:25: sparse: sparse: cast removes address space '__iomem' of expression
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
--
   drivers/isdn/hardware/mISDN/hfcmulti.c:452:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:452:22: sparse:     expected unsigned int [usertype] val
   drivers/isdn/hardware/mISDN/hfcmulti.c:452:22: sparse:     got restricted __le32 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:457:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:457:22: sparse:     expected unsigned short [usertype] val
   drivers/isdn/hardware/mISDN/hfcmulti.c:457:22: sparse:     got restricted __le16 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:472:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:472:24: sparse:     expected unsigned int [usertype] val
   drivers/isdn/hardware/mISDN/hfcmulti.c:472:24: sparse:     got restricted __le32 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:478:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:478:24: sparse:     expected unsigned short [usertype] val
   drivers/isdn/hardware/mISDN/hfcmulti.c:478:24: sparse:     got restricted __le16 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:496:32: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:501:32: sparse: sparse: cast to restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:518:25: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:524:25: sparse: sparse: cast to restricted __le16
>> drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse:     got void *
   arch/mips/include/asm/io.h:353:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:353:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:353:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: too many warnings
--
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
>> drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse:     got unsigned int [usertype] *
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
>> drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse:     got unsigned int [usertype] *
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
>> drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse:     got unsigned int [usertype] *
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
>> drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:261:1: sparse:     got unsigned int [usertype] *
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse:     got unsigned int [usertype] *
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse:     got unsigned int [usertype] *
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse:     got unsigned int [usertype] *
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/isdn/hardware/mISDN/mISDNinfineon.c:262:1: sparse:     got unsigned int [usertype] *
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:371:1: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:372:1: sparse: sparse: cast to restricted __le32

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

--5vNYLRcllDrimb99
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--5vNYLRcllDrimb99--
