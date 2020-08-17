Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC59FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 00:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4672075D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 00:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHQAxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 20:53:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:4149 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgHQAxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 20:53:45 -0400
IronPort-SDR: zxaCYdVBK5mB/s/CdStLmZV4T+FCqnkHOb/B/8hOluxJ6v8CpqB1HkKULYMSBNnfma7gvWvPuf
 Awz2bXWyHxDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="218945424"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="gz'50?scan'50,208,50";a="218945424"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2020 17:39:59 -0700
IronPort-SDR: O+UjRxu1AxKbqdWc89aoDY5VoE8uPGWysXnvbqyxulsyEMJ4POYIfI9XTmq00zf7ZklmYhVtnB
 4KsPgpdL03Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="gz'50?scan'50,208,50";a="292278678"
Received: from lkp-server02.sh.intel.com (HELO 2f0d8b563e65) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Aug 2020 17:39:57 -0700
Received: from kbuild by 2f0d8b563e65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k7TBt-0000HF-55; Mon, 17 Aug 2020 00:39:57 +0000
Date:   Mon, 17 Aug 2020 08:39:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/message/fusion/mptbase.c:3754:9: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202008170854.OyeMkeEy%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   8 weeks ago
config: riscv-randconfig-s031-20200817 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-180-g49f7e13a-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/message/fusion/mptbase.c:640:25: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:3141:37: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3142:37: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:3143:40: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3144:36: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3145:37: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:3146:26: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3149:42: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3150:43: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3161:41: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3166:49: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:3168:36: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3175:33: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:3176:40: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3178:33: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:3180:33: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3181:42: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:3190:46: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:3299:30: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:3300:29: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3301:30: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:3302:30: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3303:30: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3304:33: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3305:39: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3306:36: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3307:33: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3371:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] MsgVersion @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:3371:37: sparse:     expected unsigned short [addressable] [assigned] [usertype] MsgVersion
   drivers/message/fusion/mptbase.c:3371:37: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:3372:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] HeaderVersion @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:3372:40: sparse:     expected unsigned short [addressable] [assigned] [usertype] HeaderVersion
   drivers/message/fusion/mptbase.c:3372:40: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:3379:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] ReplyFrameSize @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:3379:33: sparse:     expected unsigned short [addressable] [assigned] [usertype] ReplyFrameSize
   drivers/message/fusion/mptbase.c:3379:33: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:3385:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] HostMfaHighAddr @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:3385:42: sparse:     expected unsigned int [addressable] [assigned] [usertype] HostMfaHighAddr
   drivers/message/fusion/mptbase.c:3385:42: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:3386:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] SenseBufferHighAddr @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:3386:46: sparse:     expected unsigned int [addressable] [assigned] [usertype] SenseBufferHighAddr
   drivers/message/fusion/mptbase.c:3386:46: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:3389:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] HostMfaHighAddr @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:3389:42: sparse:     expected unsigned int [addressable] [assigned] [usertype] HostMfaHighAddr
   drivers/message/fusion/mptbase.c:3389:42: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:3390:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] SenseBufferHighAddr @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:3390:46: sparse:     expected unsigned int [addressable] [assigned] [usertype] SenseBufferHighAddr
   drivers/message/fusion/mptbase.c:3390:46: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:3619:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ImageSize @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:3619:27: sparse:     expected unsigned int [usertype] ImageSize
   drivers/message/fusion/mptbase.c:3619:27: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:3643:26: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3647:21: sparse: sparse: cast to restricted __le32
>> drivers/message/fusion/mptbase.c:3754:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/message/fusion/mptbase.c:3754:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/message/fusion/mptbase.c:3754:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/message/fusion/mptbase.c:3754:9: sparse:     got void *
   drivers/message/fusion/mptbase.c:3761:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/message/fusion/mptbase.c:3761:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/message/fusion/mptbase.c:3761:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/message/fusion/mptbase.c:3761:17: sparse:     got void *
   drivers/message/fusion/mptbase.c:3775:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/message/fusion/mptbase.c:3775:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/message/fusion/mptbase.c:3775:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/message/fusion/mptbase.c:3775:17: sparse:     got void *
   drivers/message/fusion/mptbase.c:3778:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/message/fusion/mptbase.c:3778:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/message/fusion/mptbase.c:3778:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/message/fusion/mptbase.c:3778:25: sparse:     got void *
   drivers/message/fusion/mptbase.c:3785:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/message/fusion/mptbase.c:3785:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/message/fusion/mptbase.c:3785:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/message/fusion/mptbase.c:3785:9: sparse:     got void *
   drivers/message/fusion/mptbase.c:3789:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/message/fusion/mptbase.c:3789:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/message/fusion/mptbase.c:3789:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/message/fusion/mptbase.c:3789:9: sparse:     got void *
   drivers/message/fusion/mptbase.c:3799:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/message/fusion/mptbase.c:3799:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/message/fusion/mptbase.c:3799:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/message/fusion/mptbase.c:3799:17: sparse:     got void *
   drivers/message/fusion/mptbase.c:3800:30: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/message/fusion/mptbase.c:3800:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/message/fusion/mptbase.c:3800:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/message/fusion/mptbase.c:3800:30: sparse:     got void *
   drivers/message/fusion/mptbase.c:3802:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/message/fusion/mptbase.c:3802:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/message/fusion/mptbase.c:3802:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/message/fusion/mptbase.c:3802:17: sparse:     got void *
   drivers/message/fusion/mptbase.c:3803:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/message/fusion/mptbase.c:3803:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/message/fusion/mptbase.c:3803:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/message/fusion/mptbase.c:3803:17: sparse:     got void *
   drivers/message/fusion/mptbase.c:4884:38: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:4889:46: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:4905:25: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:5334:44: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:5428:54: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:5429:59: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:5510:47: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:5537:38: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:5544:40: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:5548:49: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:6180:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:6182:31: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:6188:58: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CoalescingTimeout @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:6188:58: sparse:     expected unsigned int [usertype] CoalescingTimeout
   drivers/message/fusion/mptbase.c:6188:58: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:6287:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] MsgContext @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:6287:24: sparse:     expected unsigned int [addressable] [assigned] [usertype] MsgContext
   drivers/message/fusion/mptbase.c:6287:24: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1321:21: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:7710:17: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:7711:21: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:7713:27: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:7759:61: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:529:19: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:539:20: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:541:37: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:919:55: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] req_idx @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:919:55: sparse:     expected unsigned short [usertype] req_idx
   drivers/message/fusion/mptbase.c:919:55: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:969:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] req_idx @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:969:47: sparse:     expected unsigned short [usertype] req_idx
   drivers/message/fusion/mptbase.c:969:47: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:1004:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] req_idx @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:1004:47: sparse:     expected unsigned short [usertype] req_idx
   drivers/message/fusion/mptbase.c:1004:47: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:1031:13: sparse: sparse: restricted __le32 degrades to integer
   drivers/message/fusion/mptbase.c:1034:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] arg1 @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1034:34: sparse:     expected unsigned int [usertype] arg1
   drivers/message/fusion/mptbase.c:1034:34: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1057:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] FlagsLength @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1057:27: sparse:     expected unsigned int [usertype] FlagsLength
   drivers/message/fusion/mptbase.c:1057:27: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1058:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Address @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1058:23: sparse:     expected unsigned int [usertype] Address
   drivers/message/fusion/mptbase.c:1058:23: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1074:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Low @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1074:27: sparse:     expected unsigned int [usertype] Low
   drivers/message/fusion/mptbase.c:1074:27: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1076:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] High @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1076:28: sparse:     expected unsigned int [usertype] High
   drivers/message/fusion/mptbase.c:1076:28: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1078:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] FlagsLength @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1078:27: sparse:     expected unsigned int [usertype] FlagsLength
   drivers/message/fusion/mptbase.c:1078:27: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1097:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Low @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1097:27: sparse:     expected unsigned int [usertype] Low
   drivers/message/fusion/mptbase.c:1097:27: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1115:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] High @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1115:28: sparse:     expected unsigned int [usertype] High
   drivers/message/fusion/mptbase.c:1115:28: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1116:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] FlagsLength @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1116:27: sparse:     expected unsigned int [usertype] FlagsLength
   drivers/message/fusion/mptbase.c:1116:27: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1134:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] Length @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:1134:24: sparse:     expected unsigned short [usertype] Length
   drivers/message/fusion/mptbase.c:1134:24: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:1137:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Address @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1137:25: sparse:     expected unsigned int [usertype] Address
   drivers/message/fusion/mptbase.c:1137:25: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1155:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] Length @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:1155:24: sparse:     expected unsigned short [usertype] Length
   drivers/message/fusion/mptbase.c:1155:24: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:1161:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Low @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1161:29: sparse:     expected unsigned int [usertype] Low
   drivers/message/fusion/mptbase.c:1161:29: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1163:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] High @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1163:30: sparse:     expected unsigned int [usertype] High
   drivers/message/fusion/mptbase.c:1163:30: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1203:55: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] req_idx @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:1203:55: sparse:     expected unsigned short [usertype] req_idx
   drivers/message/fusion/mptbase.c:1203:55: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:2155:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] device_state @@     got restricted pci_power_t @@
   drivers/message/fusion/mptbase.c:2155:22: sparse:     expected unsigned int [usertype] device_state
   drivers/message/fusion/mptbase.c:2155:22: sparse:     got restricted pci_power_t
   drivers/message/fusion/mptbase.c:2180:35: sparse: sparse: too many warnings

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=670d0a4b10704667765f7d18f7592993d02783aa
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 670d0a4b10704667765f7d18f7592993d02783aa
vim +/__iomem +3754 drivers/message/fusion/mptbase.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  3663  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3664  /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
d9489fb6061479 Randy Dunlap      2006-12-06  3665  /**
^1da177e4c3f41 Linus Torvalds    2005-04-16  3666   *	mpt_downloadboot - DownloadBoot code
^1da177e4c3f41 Linus Torvalds    2005-04-16  3667   *	@ioc: Pointer to MPT_ADAPTER structure
d9489fb6061479 Randy Dunlap      2006-12-06  3668   *	@pFwHeader: Pointer to firmware header info
^1da177e4c3f41 Linus Torvalds    2005-04-16  3669   *	@sleepFlag: Specifies whether the process can sleep
^1da177e4c3f41 Linus Torvalds    2005-04-16  3670   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  3671   *	FwDownloadBoot requires Programmed IO access.
^1da177e4c3f41 Linus Torvalds    2005-04-16  3672   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  3673   *	Returns 0 for success
^1da177e4c3f41 Linus Torvalds    2005-04-16  3674   *		-1 FW Image size is 0
^1da177e4c3f41 Linus Torvalds    2005-04-16  3675   *		-2 No valid cached_fw Pointer
^1da177e4c3f41 Linus Torvalds    2005-04-16  3676   *		<0 for fw upload failure.
^1da177e4c3f41 Linus Torvalds    2005-04-16  3677   */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3678  static int
82ffb671640647 Christoph Hellwig 2005-09-09  3679  mpt_downloadboot(MPT_ADAPTER *ioc, MpiFwHeader_t *pFwHeader, int sleepFlag)
^1da177e4c3f41 Linus Torvalds    2005-04-16  3680  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3681  	MpiExtImageHeader_t	*pExtImage;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3682  	u32			 fwSize;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3683  	u32			 diag0val;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3684  	int			 count;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3685  	u32			*ptrFw;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3686  	u32			 diagRwData;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3687  	u32			 nextImage;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3688  	u32			 load_addr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3689  	u32 			 ioc_state=0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3690  
436ace725f35eb Prakash, Sathya   2007-07-24  3691  	ddlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "downloadboot: fw size 0x%x (%d), FW Ptr %p\n",
82ffb671640647 Christoph Hellwig 2005-09-09  3692  				ioc->name, pFwHeader->ImageSize, pFwHeader->ImageSize, pFwHeader));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3693  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3694  	CHIPREG_WRITE32(&ioc->chip->WriteSequence, 0xFF);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3695  	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_1ST_KEY_VALUE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3696  	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_2ND_KEY_VALUE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3697  	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_3RD_KEY_VALUE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3698  	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_4TH_KEY_VALUE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3699  	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_5TH_KEY_VALUE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3700  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3701  	CHIPREG_WRITE32(&ioc->chip->Diagnostic, (MPI_DIAG_PREVENT_IOC_BOOT | MPI_DIAG_DISABLE_ARM));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3702  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3703  	/* wait 1 msec */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3704  	if (sleepFlag == CAN_SLEEP) {
d6be06c84da962 Michael Reed      2006-05-24  3705  		msleep(1);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3706  	} else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3707  		mdelay (1);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3708  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3709  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3710  	diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3711  	CHIPREG_WRITE32(&ioc->chip->Diagnostic, diag0val | MPI_DIAG_RESET_ADAPTER);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3712  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3713  	for (count = 0; count < 30; count ++) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3714  		diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3715  		if (!(diag0val & MPI_DIAG_RESET_ADAPTER)) {
436ace725f35eb Prakash, Sathya   2007-07-24  3716  			ddlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "RESET_ADAPTER cleared, count=%d\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  3717  				ioc->name, count));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3718  			break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3719  		}
82ffb671640647 Christoph Hellwig 2005-09-09  3720  		/* wait .1 sec */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3721  		if (sleepFlag == CAN_SLEEP) {
d6be06c84da962 Michael Reed      2006-05-24  3722  			msleep (100);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3723  		} else {
82ffb671640647 Christoph Hellwig 2005-09-09  3724  			mdelay (100);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3725  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3726  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3727  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3728  	if ( count == 30 ) {
436ace725f35eb Prakash, Sathya   2007-07-24  3729  		ddlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "downloadboot failed! "
82ffb671640647 Christoph Hellwig 2005-09-09  3730  		"Unable to get MPI_DIAG_DRWE mode, diag0val=%x\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  3731  		ioc->name, diag0val));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3732  		return -3;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3733  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3734  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3735  	CHIPREG_WRITE32(&ioc->chip->WriteSequence, 0xFF);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3736  	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_1ST_KEY_VALUE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3737  	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_2ND_KEY_VALUE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3738  	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_3RD_KEY_VALUE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3739  	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_4TH_KEY_VALUE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3740  	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_5TH_KEY_VALUE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3741  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3742  	/* Set the DiagRwEn and Disable ARM bits */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3743  	CHIPREG_WRITE32(&ioc->chip->Diagnostic, (MPI_DIAG_RW_ENABLE | MPI_DIAG_DISABLE_ARM));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3744  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3745  	fwSize = (pFwHeader->ImageSize + 3)/4;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3746  	ptrFw = (u32 *) pFwHeader;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3747  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3748  	/* Write the LoadStartAddress to the DiagRw Address Register
^1da177e4c3f41 Linus Torvalds    2005-04-16  3749  	 * using Programmed IO
^1da177e4c3f41 Linus Torvalds    2005-04-16  3750  	 */
3fadc59d603caf Moore, Eric Dean  2005-05-11  3751  	if (ioc->errata_flag_1064)
3fadc59d603caf Moore, Eric Dean  2005-05-11  3752  		pci_enable_io_access(ioc->pcidev);
3fadc59d603caf Moore, Eric Dean  2005-05-11  3753  
^1da177e4c3f41 Linus Torvalds    2005-04-16 @3754  	CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwAddress, pFwHeader->LoadStartAddress);
436ace725f35eb Prakash, Sathya   2007-07-24  3755  	ddlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "LoadStart addr written 0x%x \n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  3756  		ioc->name, pFwHeader->LoadStartAddress));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3757  
436ace725f35eb Prakash, Sathya   2007-07-24  3758  	ddlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "Write FW Image: 0x%x bytes @ %p\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  3759  				ioc->name, fwSize*4, ptrFw));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3760  	while (fwSize--) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3761  		CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwData, *ptrFw++);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3762  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3763  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3764  	nextImage = pFwHeader->NextImageHeaderOffset;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3765  	while (nextImage) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3766  		pExtImage = (MpiExtImageHeader_t *) ((char *)pFwHeader + nextImage);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3767  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3768  		load_addr = pExtImage->LoadStartAddress;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3769  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3770  		fwSize = (pExtImage->ImageSize + 3) >> 2;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3771  		ptrFw = (u32 *)pExtImage;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3772  
436ace725f35eb Prakash, Sathya   2007-07-24  3773  		ddlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "Write Ext Image: 0x%x (%d) bytes @ %p load_addr=%x\n",
c6678e0cfb41b0 Christoph Hellwig 2005-08-18  3774  						ioc->name, fwSize*4, fwSize*4, ptrFw, load_addr));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3775  		CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwAddress, load_addr);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3776  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3777  		while (fwSize--) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3778  			CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwData, *ptrFw++);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3779  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3780  		nextImage = pExtImage->NextImageHeaderOffset;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3781  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3782  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3783  	/* Write the IopResetVectorRegAddr */
436ace725f35eb Prakash, Sathya   2007-07-24  3784  	ddlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "Write IopResetVector Addr=%x! \n", ioc->name, 	pFwHeader->IopResetRegAddr));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3785  	CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwAddress, pFwHeader->IopResetRegAddr);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3786  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3787  	/* Write the IopResetVectorValue */
436ace725f35eb Prakash, Sathya   2007-07-24  3788  	ddlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "Write IopResetVector Value=%x! \n", ioc->name, pFwHeader->IopResetVectorValue));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3789  	CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwData, pFwHeader->IopResetVectorValue);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3790  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3791  	/* Clear the internal flash bad bit - autoincrementing register,
^1da177e4c3f41 Linus Torvalds    2005-04-16  3792  	 * so must do two writes.
^1da177e4c3f41 Linus Torvalds    2005-04-16  3793  	 */
a9b2937a1eab29 Moore, Eric Dean  2005-11-16  3794  	if (ioc->bus_type == SPI) {
82ffb671640647 Christoph Hellwig 2005-09-09  3795  		/*
82ffb671640647 Christoph Hellwig 2005-09-09  3796  		 * 1030 and 1035 H/W errata, workaround to access
82ffb671640647 Christoph Hellwig 2005-09-09  3797  		 * the ClearFlashBadSignatureBit
82ffb671640647 Christoph Hellwig 2005-09-09  3798  		 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3799  		CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwAddress, 0x3F000000);
^1da177e4c3f41 Linus Torvalds    2005-04-16 @3800  		diagRwData = CHIPREG_PIO_READ32(&ioc->pio_chip->DiagRwData);
82ffb671640647 Christoph Hellwig 2005-09-09  3801  		diagRwData |= 0x40000000;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3802  		CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwAddress, 0x3F000000);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3803  		CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwData, diagRwData);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3804  
82ffb671640647 Christoph Hellwig 2005-09-09  3805  	} else /* if((ioc->bus_type == SAS) || (ioc->bus_type == FC)) */ {
82ffb671640647 Christoph Hellwig 2005-09-09  3806  		diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
82ffb671640647 Christoph Hellwig 2005-09-09  3807  		CHIPREG_WRITE32(&ioc->chip->Diagnostic, diag0val |
82ffb671640647 Christoph Hellwig 2005-09-09  3808  		    MPI_DIAG_CLEAR_FLASH_BAD_SIG);
82ffb671640647 Christoph Hellwig 2005-09-09  3809  
82ffb671640647 Christoph Hellwig 2005-09-09  3810  		/* wait 1 msec */
82ffb671640647 Christoph Hellwig 2005-09-09  3811  		if (sleepFlag == CAN_SLEEP) {
d6be06c84da962 Michael Reed      2006-05-24  3812  			msleep (1);
82ffb671640647 Christoph Hellwig 2005-09-09  3813  		} else {
82ffb671640647 Christoph Hellwig 2005-09-09  3814  			mdelay (1);
82ffb671640647 Christoph Hellwig 2005-09-09  3815  		}
82ffb671640647 Christoph Hellwig 2005-09-09  3816  	}
82ffb671640647 Christoph Hellwig 2005-09-09  3817  
3fadc59d603caf Moore, Eric Dean  2005-05-11  3818  	if (ioc->errata_flag_1064)
3fadc59d603caf Moore, Eric Dean  2005-05-11  3819  		pci_disable_io_access(ioc->pcidev);
3fadc59d603caf Moore, Eric Dean  2005-05-11  3820  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3821  	diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
436ace725f35eb Prakash, Sathya   2007-07-24  3822  	ddlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "downloadboot diag0val=%x, "
82ffb671640647 Christoph Hellwig 2005-09-09  3823  		"turning off PREVENT_IOC_BOOT, DISABLE_ARM, RW_ENABLE\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  3824  		ioc->name, diag0val));
82ffb671640647 Christoph Hellwig 2005-09-09  3825  	diag0val &= ~(MPI_DIAG_PREVENT_IOC_BOOT | MPI_DIAG_DISABLE_ARM | MPI_DIAG_RW_ENABLE);
436ace725f35eb Prakash, Sathya   2007-07-24  3826  	ddlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "downloadboot now diag0val=%x\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  3827  		ioc->name, diag0val));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3828  	CHIPREG_WRITE32(&ioc->chip->Diagnostic, diag0val);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3829  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3830  	/* Write 0xFF to reset the sequencer */
^1da177e4c3f41 Linus Torvalds    2005-04-16  3831  	CHIPREG_WRITE32(&ioc->chip->WriteSequence, 0xFF);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3832  
82ffb671640647 Christoph Hellwig 2005-09-09  3833  	if (ioc->bus_type == SAS) {
82ffb671640647 Christoph Hellwig 2005-09-09  3834  		ioc_state = mpt_GetIocState(ioc, 0);
82ffb671640647 Christoph Hellwig 2005-09-09  3835  		if ( (GetIocFacts(ioc, sleepFlag,
82ffb671640647 Christoph Hellwig 2005-09-09  3836  				MPT_HOSTEVENT_IOC_BRINGUP)) != 0 ) {
436ace725f35eb Prakash, Sathya   2007-07-24  3837  			ddlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "GetIocFacts failed: IocState=%x\n",
82ffb671640647 Christoph Hellwig 2005-09-09  3838  					ioc->name, ioc_state));
82ffb671640647 Christoph Hellwig 2005-09-09  3839  			return -EFAULT;
82ffb671640647 Christoph Hellwig 2005-09-09  3840  		}
82ffb671640647 Christoph Hellwig 2005-09-09  3841  	}
82ffb671640647 Christoph Hellwig 2005-09-09  3842  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3843  	for (count=0; count<HZ*20; count++) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3844  		if ((ioc_state = mpt_GetIocState(ioc, 0)) & MPI_IOC_STATE_READY) {
436ace725f35eb Prakash, Sathya   2007-07-24  3845  			ddlprintk(ioc, printk(MYIOC_s_DEBUG_FMT
436ace725f35eb Prakash, Sathya   2007-07-24  3846  				"downloadboot successful! (count=%d) IocState=%x\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  3847  				ioc->name, count, ioc_state));
82ffb671640647 Christoph Hellwig 2005-09-09  3848  			if (ioc->bus_type == SAS) {
82ffb671640647 Christoph Hellwig 2005-09-09  3849  				return 0;
82ffb671640647 Christoph Hellwig 2005-09-09  3850  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3851  			if ((SendIocInit(ioc, sleepFlag)) != 0) {
436ace725f35eb Prakash, Sathya   2007-07-24  3852  				ddlprintk(ioc, printk(MYIOC_s_DEBUG_FMT
436ace725f35eb Prakash, Sathya   2007-07-24  3853  					"downloadboot: SendIocInit failed\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  3854  					ioc->name));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3855  				return -EFAULT;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3856  			}
436ace725f35eb Prakash, Sathya   2007-07-24  3857  			ddlprintk(ioc, printk(MYIOC_s_DEBUG_FMT
436ace725f35eb Prakash, Sathya   2007-07-24  3858  					"downloadboot: SendIocInit successful\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  3859  					ioc->name));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3860  			return 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3861  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3862  		if (sleepFlag == CAN_SLEEP) {
d6be06c84da962 Michael Reed      2006-05-24  3863  			msleep (10);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3864  		} else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  3865  			mdelay (10);
^1da177e4c3f41 Linus Torvalds    2005-04-16  3866  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  3867  	}
436ace725f35eb Prakash, Sathya   2007-07-24  3868  	ddlprintk(ioc, printk(MYIOC_s_DEBUG_FMT
436ace725f35eb Prakash, Sathya   2007-07-24  3869  		"downloadboot failed! IocState=%x\n",ioc->name, ioc_state));
^1da177e4c3f41 Linus Torvalds    2005-04-16  3870  	return -EFAULT;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3871  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  3872  

:::::: The code at line 3754 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--vkogqOf2sHV7VnPd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICGjFOV8AAy5jb25maWcAlDxNd9u2svv7K3Tczb2LtLKduMl7xwsQBCVUJEEDoCR7w6PY
SqpTx/KV5Lb5928G/AJAUOnrIjVnBsBgMJgvAPrpXz9NyNtp/21z2j1unp+/T75uX7aHzWn7
NPmye97+7yQWk1zoCYu5/hmI093L29+/HHbHxz8nH37++PP03eHxcrLYHl62zxO6f/my+/oG
zXf7l3/99C8q8oTPKkqrJZOKi7zSbK1vL0zz66t3z9jZu6+Pj5N/zyj9z+TTz9c/Ty+sZlxV
gLj93oJmfVe3n6bX02mLSOMOfnX9fmr+6/pJST7r0FOr+zlRFVFZNRNa9INYCJ6nPGc9isu7
aiXkoofouWQkBsJEwD+VJgqRMPefJjMjyefJcXt6e+2lEUmxYHkFwlBZYXWdc12xfFkRCdPh
Gde311fQS8uUyAqeMhCg0pPdcfKyP2HH3fwFJWk7xYuLELgipT3LqOQgNEVSbdHHLCFlqg0z
AfBcKJ2TjN1e/Ptl/7L9z0XPn1qRwuarR9yrJS9ogOdCKL6usruSlZaIbSg2pjrtkSui6bzy
WlAplKoylgl5XxGtCZ0DsmOgVCzlUWB8UoJO993MyZKB8KF/g8ChSWqN7UHNEoM+TI5vn4/f
j6ftt36JZyxnklOjLmouVpYCWxg654WrWrHICM9DsGrOmUTm7od9ZYoj5Shi0O2c5DGoUtOz
01QVRCrWwDoR2lzHLCpniXLXevvyNNl/8cQRmnMGasQbBqQlWxQ7BW1dKFFKymoFHEzIULAl
y7VqV0Dvvm0Px9AizB+qAlqJmFN7LrlADIfxg+pq0EHMnM/mlWSq0jyDHRUUwICbvnkhGcsK
DQPk4ZFbgqVIy1wTeR/aMjWNtVuaRlRAmwEYjUEjJ1qUv+jN8Y/JCVicbIDd42lzOk42j4/7
t5fT7uVrLznN6aKCBhWhpl+ezyy7oWLoXlAGew7wehxTLa8tOwmGUWliFs4CgTql5L7tqJOF
Qa0RGhKC4tZMQcdb8xRzRaKUxaanZkX+wbyNfCQtJ2qoRBoEWQFuKPEa2HEMnxVbg8KFOFZO
D6ZPD4TSMX00qh5A9SCkA1mmKXqFTOQuJmcM7Dqb0SjlStuycOfYGZlF/YdldhbdXAW1wXNw
daD6PSgV6EgSMHI80bdX015IPNcL8C4J82gur/1NregcGDZbu1VW9fj79unteXuYfNluTm+H
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

--vkogqOf2sHV7VnPd--
