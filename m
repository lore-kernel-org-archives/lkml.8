Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6B4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 03:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17FA12068E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 03:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgFKDaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 23:30:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:7190 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgFKDaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 23:30:09 -0400
IronPort-SDR: t18uIEPpfmsaeehARCmKMbI+oYMjnVRLSo+G+3GCkW+a6yl5dnyGv4yUyDDWKKD7MDm8QVNYpJ
 PDCQCBlW8ZEA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 20:29:49 -0700
IronPort-SDR: Q215t5xvuZte9pBmchVY9tsdMWziOmh8Yw4N6ZZbOMNLwWcdHzvxi/k1ay1eDTEuWxD1CYFyGh
 22PjDOq8C4fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; 
   d="gz'50?scan'50,208,50";a="380266339"
Received: from lkp-server01.sh.intel.com (HELO b6eec31c25be) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jun 2020 20:29:46 -0700
Received: from kbuild by b6eec31c25be with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jjDuT-00003z-DK; Thu, 11 Jun 2020 03:29:45 +0000
Date:   Thu, 11 Jun 2020 11:29:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: drivers/video/fbdev/tdfxfb.c:1120:27: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202006111104.mpw7WICp%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b29482fde649c72441d5478a4ea2c52c56d97a5e
commit: 80591e61a0f7e88deaada69844e4a31280c4a38f kbuild: tell sparse about the $ARCH
date:   7 months ago
config: s390-randconfig-s032-20200611 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-247-gcadbd124-dirty
        git checkout 80591e61a0f7e88deaada69844e4a31280c4a38f
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=s390 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/tdfxfb.c:1120:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got unsigned char [noderef] [usertype] <asn:2> *cursorbase @@
>> drivers/video/fbdev/tdfxfb.c:1120:27: sparse:     expected void *p
   drivers/video/fbdev/tdfxfb.c:1120:27: sparse:     got unsigned char [noderef] [usertype] <asn:2> *cursorbase
   drivers/video/fbdev/tdfxfb.c:1131:33: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/video/fbdev/tdfxfb.c:1134:33: sparse: sparse: cast removes address space '<asn:2>' of expression
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
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
--
>> drivers/video/fbdev/sstfb.c:337:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got char [noderef] <asn:2> *screen_base @@
>> drivers/video/fbdev/sstfb.c:337:23: sparse:     expected void *p
   drivers/video/fbdev/sstfb.c:337:23: sparse:     got char [noderef] <asn:2> *screen_base
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
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
--
>> drivers/video/fbdev/kyro/fbdev.c:725:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got char [noderef] <asn:2> *screen_base @@
>> drivers/video/fbdev/kyro/fbdev.c:725:23: sparse:     expected void *p
   drivers/video/fbdev/kyro/fbdev.c:725:23: sparse:     got char [noderef] <asn:2> *screen_base

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

--FCuugMFkClbJLl1L
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
H6jOEBWg3gEA

--FCuugMFkClbJLl1L--
