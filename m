Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD43C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3D722DA9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgHEQdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:33:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:35993 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgHEQ3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:29:43 -0400
IronPort-SDR: LuY4aAebNIiETGCDg9cPzeLq+WZSG9S7NSDgMepsxn+Un5WVOtW79svyd4Utjq/zeo6R7fQDct
 SDR2CuXoxu8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="132066948"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="gz'50?scan'50,208,50";a="132066948"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 03:32:29 -0700
IronPort-SDR: asWjGtoRaTsREYg3HX2T5L9qhKcDEW2vKQ6NFpwD7GVrRVh3Lo1BaYxjSatvo1G2SwtXerO/wZ
 fjxfuQUXdwKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="gz'50?scan'50,208,50";a="332801832"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2020 03:32:27 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3Gig-0000jY-Om; Wed, 05 Aug 2020 10:32:26 +0000
Date:   Wed, 5 Aug 2020 18:31:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: sound/core/hwdep.c:265:29: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202008051841.4F6v77Ox%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4da9f3302615f4191814f826054846bf843e24fa
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   7 weeks ago
config: sh-randconfig-s031-20200805 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-117-g8c7aee71-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   sound/core/hwdep.c:265:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   sound/core/hwdep.c:265:29: sparse:     expected int const *__gu_addr
   sound/core/hwdep.c:265:29: sparse:     got int [noderef] __user *
>> sound/core/hwdep.c:265:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> sound/core/hwdep.c:265:29: sparse:     expected void const volatile [noderef] __user *
   sound/core/hwdep.c:265:29: sparse:     got int const *__gu_addr
   sound/core/hwdep.c:294:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   sound/core/hwdep.c:294:29: sparse:     expected unsigned int const *__gu_addr
   sound/core/hwdep.c:294:29: sparse:     got unsigned int [noderef] __user *
>> sound/core/hwdep.c:294:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   sound/core/hwdep.c:294:29: sparse:     expected void const volatile [noderef] __user *
   sound/core/hwdep.c:294:29: sparse:     got unsigned int const *__gu_addr
--
   drivers/auxdisplay/charlcd.c:675:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *tmp @@
   drivers/auxdisplay/charlcd.c:675:21: sparse:     expected char const *__gu_addr
   drivers/auxdisplay/charlcd.c:675:21: sparse:     got char const [noderef] __user *tmp
>> drivers/auxdisplay/charlcd.c:675:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
>> drivers/auxdisplay/charlcd.c:675:21: sparse:     expected void const volatile [noderef] __user *
   drivers/auxdisplay/charlcd.c:675:21: sparse:     got char const *__gu_addr
--
   drivers/usb/core/devio.c:313:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] *p @@     got restricted __le16 * @@
   drivers/usb/core/devio.c:313:17: sparse:     expected unsigned short [usertype] *p
   drivers/usb/core/devio.c:313:17: sparse:     got restricted __le16 *
   drivers/usb/core/devio.c:314:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] *p @@     got restricted __le16 * @@
   drivers/usb/core/devio.c:314:17: sparse:     expected unsigned short [usertype] *p
   drivers/usb/core/devio.c:314:17: sparse:     got restricted __le16 *
   drivers/usb/core/devio.c:315:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] *p @@     got restricted __le16 * @@
   drivers/usb/core/devio.c:315:17: sparse:     expected unsigned short [usertype] *p
   drivers/usb/core/devio.c:315:17: sparse:     got restricted __le16 *
   drivers/usb/core/devio.c:316:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] *p @@     got restricted __le16 * @@
   drivers/usb/core/devio.c:316:17: sparse:     expected unsigned short [usertype] *p
   drivers/usb/core/devio.c:316:17: sparse:     got restricted __le16 *
   drivers/usb/core/devio.c:937:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:937:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:937:13: sparse:     got unsigned int [noderef] __user *
>> drivers/usb/core/devio.c:937:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> drivers/usb/core/devio.c:937:13: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/core/devio.c:937:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:938:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:938:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:938:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:938:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:938:13: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/core/devio.c:938:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:953:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] __user * @@
   drivers/usb/core/devio.c:953:21: sparse:     expected unsigned char const *__gu_addr
   drivers/usb/core/devio.c:953:21: sparse:     got unsigned char [noderef] __user *
>> drivers/usb/core/devio.c:953:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
   drivers/usb/core/devio.c:953:21: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/core/devio.c:953:21: sparse:     got unsigned char const *__gu_addr
   drivers/usb/core/devio.c:1276:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:1276:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1276:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:1276:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:1276:13: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/core/devio.c:1276:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1295:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:1295:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1295:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:1295:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:1295:13: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/core/devio.c:1295:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1427:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/usb/core/devio.c:1427:13: sparse:     expected int const *__gu_addr
   drivers/usb/core/devio.c:1427:13: sparse:     got int [noderef] __user *
>> drivers/usb/core/devio.c:1427:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/usb/core/devio.c:1427:13: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/core/devio.c:1427:13: sparse:     got int const *__gu_addr
   drivers/usb/core/devio.c:2177:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2177:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2177:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2177:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2177:13: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/core/devio.c:2177:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2187:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2187:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2187:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2187:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2187:13: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/core/devio.c:2187:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2303:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2303:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2303:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2303:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2303:13: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/core/devio.c:2303:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2316:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2316:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2316:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2316:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2316:13: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/core/devio.c:2316:13: sparse:     got unsigned int const *__gu_addr
--
>> drivers/usb/cdns3/drd.c:43:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
>> drivers/usb/cdns3/drd.c:43:31: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:43:31: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:45:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:45:25: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:45:25: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:47:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:47:31: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:47:31: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:49:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:49:25: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:49:25: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:71:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:71:14: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:71:14: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:81:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:81:19: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:81:19: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:114:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:114:9: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:114:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:123:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:123:9: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:123:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:141:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:141:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:141:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:144:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:144:23: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:144:23: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:144:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:144:23: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:144:23: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:152:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:152:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:152:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:156:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:156:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:156:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:156:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:156:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:156:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:178:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:178:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:178:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:182:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:182:23: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:182:23: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:182:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:182:23: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:182:23: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:195:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:195:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:195:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:199:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:199:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:199:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:199:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:219:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:219:9: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:219:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:284:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:284:15: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:284:15: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:303:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:303:9: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:303:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:326:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cdns3_otg_legacy_regs *otg_v0_regs @@     got void [noderef] __iomem *[assigned] regs @@
   drivers/usb/cdns3/drd.c:326:27: sparse:     expected struct cdns3_otg_legacy_regs *otg_v0_regs
   drivers/usb/cdns3/drd.c:326:27: sparse:     got void [noderef] __iomem *[assigned] regs
   drivers/usb/cdns3/drd.c:327:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:327:14: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:327:14: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:330:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cdns3_otg_common_regs *otg_regs @@     got void [noderef] __iomem *[assigned] regs @@
   drivers/usb/cdns3/drd.c:330:32: sparse:     expected struct cdns3_otg_common_regs *otg_regs
   drivers/usb/cdns3/drd.c:330:32: sparse:     got void [noderef] __iomem *[assigned] regs
   drivers/usb/cdns3/drd.c:331:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:331:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:331:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:332:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:332:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:332:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:336:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cdns3_otg_regs *otg_v1_regs @@     got void [noderef] __iomem *[assigned] regs @@
   drivers/usb/cdns3/drd.c:336:35: sparse:     expected struct cdns3_otg_regs *otg_v1_regs
   drivers/usb/cdns3/drd.c:336:35: sparse:     got void [noderef] __iomem *[assigned] regs
   drivers/usb/cdns3/drd.c:339:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:339:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:339:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:340:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:340:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:340:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:340:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:340:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:340:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:345:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:345:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:345:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:368:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:368:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/usb/cdns3/drd.c:368:17: sparse:     got restricted __le32 *
--
   drivers/watchdog/kempld_wdt.c:349:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     got int [noderef] __user *p
>> drivers/watchdog/kempld_wdt.c:349:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> drivers/watchdog/kempld_wdt.c:349:21: sparse:     expected void const volatile [noderef] __user *
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     got int const *__gu_addr
--
   drivers/watchdog/pcwd_usb.c:375:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     expected char const *__gu_addr
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     got char const [noderef] __user *
>> drivers/watchdog/pcwd_usb.c:375:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
>> drivers/watchdog/pcwd_usb.c:375:37: sparse:     expected void const volatile [noderef] __user *
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     got char const *__gu_addr
   drivers/watchdog/pcwd_usb.c:423:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     got int [noderef] __user *p
>> drivers/watchdog/pcwd_usb.c:423:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     expected void const volatile [noderef] __user *
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     got int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:447:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     got int [noderef] __user *p
   drivers/watchdog/pcwd_usb.c:447:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     expected void const volatile [noderef] __user *
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     got int const *__gu_addr
--
   drivers/usb/class/usbtmc.c:584:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *arg @@
   drivers/usb/class/usbtmc.c:584:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/class/usbtmc.c:584:13: sparse:     got unsigned int [noderef] [usertype] __user *arg
>> drivers/usb/class/usbtmc.c:584:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> drivers/usb/class/usbtmc.c:584:13: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/class/usbtmc.c:584:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/class/usbtmc.c:1963:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/usb/class/usbtmc.c:1963:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/class/usbtmc.c:1963:13: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/usb/class/usbtmc.c:1963:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/usb/class/usbtmc.c:1963:13: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/class/usbtmc.c:1963:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/class/usbtmc.c:2143:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] __user * @@
   drivers/usb/class/usbtmc.c:2143:26: sparse:     expected unsigned char const *__gu_addr
   drivers/usb/class/usbtmc.c:2143:26: sparse:     got unsigned char [noderef] __user *
>> drivers/usb/class/usbtmc.c:2143:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
   drivers/usb/class/usbtmc.c:2143:26: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/class/usbtmc.c:2143:26: sparse:     got unsigned char const *__gu_addr
--
   drivers/usb/image/mdc800.c:806:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/usb/image/mdc800.c:806:20: sparse:     expected char const *__gu_addr
   drivers/usb/image/mdc800.c:806:20: sparse:     got char const [noderef] __user *
>> drivers/usb/image/mdc800.c:806:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
>> drivers/usb/image/mdc800.c:806:20: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/image/mdc800.c:806:20: sparse:     got char const *__gu_addr
--
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short header @@     got restricted __le16 [usertype] @@
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse:     expected unsigned short header
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse:     got restricted __le16 [usertype]
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] address @@     got restricted __le32 [usertype] @@
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse:     expected unsigned int [usertype] address
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse:     got restricted __le32 [usertype]
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] data @@     got restricted __le32 [usertype] @@
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse:     expected unsigned int [usertype] data
   drivers/usb/misc/sisusbvga/sisusb.c:542:9: sparse:     got restricted __le32 [usertype]
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short header @@     got restricted __le16 [usertype] @@
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse:     expected unsigned short header
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse:     got restricted __le16 [usertype]
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] address @@     got restricted __le32 [usertype] @@
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse:     expected unsigned int [usertype] address
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse:     got restricted __le32 [usertype]
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] data @@     got restricted __le32 [usertype] @@
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse:     expected unsigned int [usertype] data
   drivers/usb/misc/sisusbvga/sisusb.c:578:9: sparse:     got restricted __le32 [usertype]
   drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse:     expected unsigned char const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse:     got unsigned char [noderef] [usertype] __user *
>> drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
>> drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/misc/sisusbvga/sisusb.c:780:37: sparse:     got unsigned char const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:795:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   drivers/usb/misc/sisusbvga/sisusb.c:795:37: sparse:     expected unsigned short const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:795:37: sparse:     got unsigned short [noderef] [usertype] __user *
>> drivers/usb/misc/sisusbvga/sisusb.c:795:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned short const *__gu_addr @@
   drivers/usb/misc/sisusbvga/sisusb.c:795:37: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/misc/sisusbvga/sisusb.c:795:37: sparse:     got unsigned short const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:842:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/usb/misc/sisusbvga/sisusb.c:842:37: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:842:37: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/usb/misc/sisusbvga/sisusb.c:842:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/usb/misc/sisusbvga/sisusb.c:842:37: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/misc/sisusbvga/sisusb.c:842:37: sparse:     got unsigned int const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2653:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2653:29: sparse:     expected unsigned char const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2653:29: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/usb/misc/sisusbvga/sisusb.c:2653:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
   drivers/usb/misc/sisusbvga/sisusb.c:2653:29: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/misc/sisusbvga/sisusb.c:2653:29: sparse:     got unsigned char const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2664:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2664:29: sparse:     expected unsigned short const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2664:29: sparse:     got unsigned short [noderef] [usertype] __user *
   drivers/usb/misc/sisusbvga/sisusb.c:2664:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned short const *__gu_addr @@
   drivers/usb/misc/sisusbvga/sisusb.c:2664:29: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/misc/sisusbvga/sisusb.c:2664:29: sparse:     got unsigned short const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2675:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2675:29: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2675:29: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/usb/misc/sisusbvga/sisusb.c:2675:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/usb/misc/sisusbvga/sisusb.c:2675:29: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/misc/sisusbvga/sisusb.c:2675:29: sparse:     got unsigned int const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2740:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/usb/misc/sisusbvga/sisusb.c:2740:21: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/misc/sisusbvga/sisusb.c:2740:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/usb/misc/sisusbvga/sisusb.c:2740:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   drivers/usb/misc/sisusbvga/sisusb.c:2740:21: sparse:     expected void const volatile [noderef] __user *
   drivers/usb/misc/sisusbvga/sisusb.c:2740:21: sparse:     got unsigned int const *__gu_addr
--
>> drivers/fpga/dfl-fme-main.c:143:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     expected int const *__gu_addr
>> drivers/fpga/dfl-fme-main.c:143:13: sparse:     got int [noderef] __user *
>> drivers/fpga/dfl-fme-main.c:143:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> drivers/fpga/dfl-fme-main.c:143:13: sparse:     expected void const volatile [noderef] __user *
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     got int const *__gu_addr
   drivers/fpga/dfl-fme-main.c:155:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     expected int const *__gu_addr
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     got int [noderef] __user *
   drivers/fpga/dfl-fme-main.c:155:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     expected void const volatile [noderef] __user *
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     got int const *__gu_addr

vim +265 sound/core/hwdep.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  255  
d9a98de218ce18 Takashi Iwai    2005-11-17  256  static int snd_hwdep_control_ioctl(struct snd_card *card,
d9a98de218ce18 Takashi Iwai    2005-11-17  257  				   struct snd_ctl_file * control,
^1da177e4c3f41 Linus Torvalds  2005-04-16  258  				   unsigned int cmd, unsigned long arg)
^1da177e4c3f41 Linus Torvalds  2005-04-16  259  {
^1da177e4c3f41 Linus Torvalds  2005-04-16  260  	switch (cmd) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  261  	case SNDRV_CTL_IOCTL_HWDEP_NEXT_DEVICE:
^1da177e4c3f41 Linus Torvalds  2005-04-16  262  		{
^1da177e4c3f41 Linus Torvalds  2005-04-16  263  			int device;
^1da177e4c3f41 Linus Torvalds  2005-04-16  264  
^1da177e4c3f41 Linus Torvalds  2005-04-16 @265  			if (get_user(device, (int __user *)arg))
^1da177e4c3f41 Linus Torvalds  2005-04-16  266  				return -EFAULT;
1a60d4c5a0c402 Ingo Molnar     2006-01-16  267  			mutex_lock(&register_mutex);
f7b2bb8549e352 Dan Carpenter   2011-10-28  268  
f7b2bb8549e352 Dan Carpenter   2011-10-28  269  			if (device < 0)
f7b2bb8549e352 Dan Carpenter   2011-10-28  270  				device = 0;
f7b2bb8549e352 Dan Carpenter   2011-10-28  271  			else if (device < SNDRV_MINOR_HWDEPS)
f7b2bb8549e352 Dan Carpenter   2011-10-28  272  				device++;
f7b2bb8549e352 Dan Carpenter   2011-10-28  273  			else
f7b2bb8549e352 Dan Carpenter   2011-10-28  274  				device = SNDRV_MINOR_HWDEPS;
f7b2bb8549e352 Dan Carpenter   2011-10-28  275  
^1da177e4c3f41 Linus Torvalds  2005-04-16  276  			while (device < SNDRV_MINOR_HWDEPS) {
f87135f56cb266 Clemens Ladisch 2005-11-20  277  				if (snd_hwdep_search(card, device))
^1da177e4c3f41 Linus Torvalds  2005-04-16  278  					break;
^1da177e4c3f41 Linus Torvalds  2005-04-16  279  				device++;
^1da177e4c3f41 Linus Torvalds  2005-04-16  280  			}
^1da177e4c3f41 Linus Torvalds  2005-04-16  281  			if (device >= SNDRV_MINOR_HWDEPS)
^1da177e4c3f41 Linus Torvalds  2005-04-16  282  				device = -1;
1a60d4c5a0c402 Ingo Molnar     2006-01-16  283  			mutex_unlock(&register_mutex);
^1da177e4c3f41 Linus Torvalds  2005-04-16  284  			if (put_user(device, (int __user *)arg))
^1da177e4c3f41 Linus Torvalds  2005-04-16  285  				return -EFAULT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  286  			return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  287  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  288  	case SNDRV_CTL_IOCTL_HWDEP_INFO:
^1da177e4c3f41 Linus Torvalds  2005-04-16  289  		{
d9a98de218ce18 Takashi Iwai    2005-11-17  290  			struct snd_hwdep_info __user *info = (struct snd_hwdep_info __user *)arg;
f87135f56cb266 Clemens Ladisch 2005-11-20  291  			int device, err;
d9a98de218ce18 Takashi Iwai    2005-11-17  292  			struct snd_hwdep *hwdep;
^1da177e4c3f41 Linus Torvalds  2005-04-16  293  
^1da177e4c3f41 Linus Torvalds  2005-04-16 @294  			if (get_user(device, &info->device))
^1da177e4c3f41 Linus Torvalds  2005-04-16  295  				return -EFAULT;
1a60d4c5a0c402 Ingo Molnar     2006-01-16  296  			mutex_lock(&register_mutex);
f87135f56cb266 Clemens Ladisch 2005-11-20  297  			hwdep = snd_hwdep_search(card, device);
f87135f56cb266 Clemens Ladisch 2005-11-20  298  			if (hwdep)
f87135f56cb266 Clemens Ladisch 2005-11-20  299  				err = snd_hwdep_info(hwdep, info);
f87135f56cb266 Clemens Ladisch 2005-11-20  300  			else
f87135f56cb266 Clemens Ladisch 2005-11-20  301  				err = -ENXIO;
1a60d4c5a0c402 Ingo Molnar     2006-01-16  302  			mutex_unlock(&register_mutex);
f87135f56cb266 Clemens Ladisch 2005-11-20  303  			return err;
^1da177e4c3f41 Linus Torvalds  2005-04-16  304  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  305  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  306  	return -ENOIOCTLCMD;
^1da177e4c3f41 Linus Torvalds  2005-04-16  307  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  308  

:::::: The code at line 265 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--5mCyUwZo2JvN/JJP
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
D2BQ9OLZdn7mWcvzkDaHj/8Fv9/qpX26AQA=

--5mCyUwZo2JvN/JJP--
