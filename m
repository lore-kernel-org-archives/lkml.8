Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2468BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B66206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgHCApS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 20:45:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:43519 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbgHCApS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 20:45:18 -0400
IronPort-SDR: p18vl2B6+YVHpmiojSzTGTmG2ntivavYoMAHoefkZjzRxnZTtpAWtvg3+2izzMhD7qV/KoimL/
 YoPgb4+9rXUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="131590725"
X-IronPort-AV: E=Sophos;i="5.75,428,1589266800"; 
   d="gz'50?scan'50,208,50";a="131590725"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 16:49:15 -0700
IronPort-SDR: 9LiG1qAZwBKbtDX/JDZNY4zve2qBxUlgHqM36VFylg21AtkPsotZbPbQxlpHjTMN0lsvr5nrgP
 70ELwbXWQggg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,428,1589266800"; 
   d="gz'50?scan'50,208,50";a="322008690"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Aug 2020 16:49:13 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k2Nj6-0001lt-RV; Sun, 02 Aug 2020 23:49:12 +0000
Date:   Mon, 3 Aug 2020 07:48:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: net/dccp/ccid.c:69:13: sparse: sparse: incorrect type in initializer
 (different address spaces)
Message-ID: <202008030751.UObVuWSX%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   142c3326b055a278c303bfef8dc6a105fff18ca6
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   6 weeks ago
config: openrisc-randconfig-s031-20200802 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-115-g5fc204f2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> net/dccp/ccid.c:69:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *optlen @@
   net/dccp/ccid.c:69:13: sparse:     expected int *__pu_addr
>> net/dccp/ccid.c:69:13: sparse:     got int [noderef] __user *optlen
   net/dccp/ccid.c: note: in included file (through include/linux/crypto.h, include/crypto/hash.h, include/linux/uio.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   net/dccp/ccid.c: note: in included file (through include/linux/uaccess.h, include/linux/crypto.h, include/crypto/hash.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
>> net/dccp/proto.c:390:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   net/dccp/proto.c:390:22: sparse:     expected int *__pu_addr
   net/dccp/proto.c:390:22: sparse:     got int [noderef] __user *
   net/dccp/proto.c:523:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/dccp/proto.c:523:13: sparse:     expected int const *__gu_addr
   net/dccp/proto.c:523:13: sparse:     got int [noderef] __user *
   net/dccp/proto.c:527:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 const [usertype] service @@     got int [assigned] val @@
   net/dccp/proto.c:527:52: sparse:     expected restricted __be32 const [usertype] service
   net/dccp/proto.c:527:52: sparse:     got int [assigned] val
>> net/dccp/proto.c:610:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *optlen @@
   net/dccp/proto.c:610:13: sparse:     expected int *__pu_addr
   net/dccp/proto.c:610:13: sparse:     got int [noderef] __user *optlen
>> net/dccp/proto.c:611:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted __be32 *__pu_addr @@     got restricted __be32 [noderef] [usertype] __user *optval @@
   net/dccp/proto.c:611:13: sparse:     expected restricted __be32 *__pu_addr
>> net/dccp/proto.c:611:13: sparse:     got restricted __be32 [noderef] [usertype] __user *optval
   net/dccp/proto.c:625:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/dccp/proto.c:625:13: sparse:     expected int const *__gu_addr
   net/dccp/proto.c:625:13: sparse:     got int [noderef] __user *optlen
   net/dccp/proto.c:681:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *optlen @@
   net/dccp/proto.c:681:13: sparse:     expected int *__pu_addr
   net/dccp/proto.c:681:13: sparse:     got int [noderef] __user *optlen
   net/dccp/proto.c:736:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] param @@     got int cmsg_type @@
   net/dccp/proto.c:736:57: sparse:     expected restricted __be32 [usertype] param
   net/dccp/proto.c:736:57: sparse:     got int cmsg_type
   net/dccp/proto.c: note: in included file (through include/linux/crypto.h, include/crypto/hash.h, include/linux/uio.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   net/dccp/proto.c: note: in included file (through include/linux/uaccess.h, include/linux/crypto.h, include/crypto/hash.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   net/dccp/proto.c: note: in included file (through include/linux/crypto.h, include/crypto/hash.h, include/linux/uio.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   net/dccp/proto.c: note: in included file (through include/linux/uaccess.h, include/linux/crypto.h, include/crypto/hash.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   net/dccp/proto.c: note: in included file (through include/asm-generic/atomic.h, arch/openrisc/include/asm/atomic.h, include/linux/atomic.h, ...):
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
--
   drivers/infiniband/core/user_mad.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/ib_umad.h):
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be64
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be16
   include/trace/events/ib_umad.h:16:1: sparse: sparse: cast to restricted __be32
   drivers/infiniband/core/user_mad.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/ib_umad.h):
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] qpn @@     got restricted __be32 [usertype] qpn @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] qpn
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] qpn
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] qkey @@     got restricted __be32 [usertype] qkey @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] qkey
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] qkey
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] lid @@     got restricted __be16 [usertype] lid @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] lid
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] lid
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flow_label @@     got restricted __be32 [usertype] flow_label @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] flow_label
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] flow_label
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] mad_status @@     got restricted __be16 [usertype] status @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] mad_status
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] status
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] class_specific @@     got restricted __be16 [usertype] class_specific @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] class_specific
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] class_specific
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] tid @@     got restricted __be64 [usertype] tid @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned long long [usertype] tid
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be64 [usertype] tid
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] attr_id @@     got restricted __be16 [usertype] attr_id @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned short [usertype] attr_id
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be16 [usertype] attr_id
   include/trace/events/ib_umad.h:16:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] attr_mod @@     got restricted __be32 [usertype] attr_mod @@
   include/trace/events/ib_umad.h:16:1: sparse:     expected unsigned int [usertype] attr_mod
   include/trace/events/ib_umad.h:16:1: sparse:     got restricted __be32 [usertype] attr_mod
>> drivers/infiniband/core/user_mad.c:736:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/infiniband/core/user_mad.c:736:13: sparse:     expected unsigned int *__pu_addr
>> drivers/infiniband/core/user_mad.c:736:13: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/infiniband/core/user_mad.c:804:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/infiniband/core/user_mad.c:804:21: sparse:     expected unsigned int *__pu_addr
   drivers/infiniband/core/user_mad.c:804:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/infiniband/core/user_mad.c:853:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/infiniband/core/user_mad.c:853:13: sparse:     expected unsigned int *__pu_addr
   drivers/infiniband/core/user_mad.c:853:13: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/infiniband/core/user_mad.c:886:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *arg @@
   drivers/infiniband/core/user_mad.c:886:13: sparse:     expected unsigned int const *__gu_addr
   drivers/infiniband/core/user_mad.c:886:13: sparse:     got unsigned int [noderef] [usertype] __user *arg
   drivers/infiniband/core/user_mad.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/infiniband/core/user_mad.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   drivers/infiniband/core/user_mad.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/infiniband/core/user_mad.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   drivers/infiniband/core/user_mad.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/infiniband/core/user_mad.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   drivers/infiniband/core/user_mad.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/infiniband/core/user_mad.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   drivers/infiniband/core/user_mad.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/infiniband/core/user_mad.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
>> drivers/input/keyboard/omap4-keypad.c:376:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *base @@
   drivers/input/keyboard/omap4-keypad.c:376:28: sparse:     expected void *addr
>> drivers/input/keyboard/omap4-keypad.c:376:28: sparse:     got void [noderef] __iomem *base
   drivers/input/keyboard/omap4-keypad.c:395:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *base @@
   drivers/input/keyboard/omap4-keypad.c:395:28: sparse:     expected void *addr
   drivers/input/keyboard/omap4-keypad.c:395:28: sparse:     got void [noderef] __iomem *base
--
>> net/tipc/socket.c:3129:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/tipc/socket.c:3129:21: sparse:     expected unsigned int const *__gu_addr
>> net/tipc/socket.c:3129:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> net/tipc/socket.c:3212:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *ol @@
   net/tipc/socket.c:3212:24: sparse:     expected int *__pu_addr
>> net/tipc/socket.c:3212:24: sparse:     got int [noderef] __user *ol
>> net/tipc/socket.c:3215:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ol @@
   net/tipc/socket.c:3215:15: sparse:     expected int const *__gu_addr
   net/tipc/socket.c:3215:15: sparse:     got int [noderef] __user *ol
   net/tipc/socket.c:3265:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *ol @@
   net/tipc/socket.c:3265:16: sparse:     expected int *__pu_addr
   net/tipc/socket.c:3265:16: sparse:     got int [noderef] __user *ol
   net/tipc/socket.c: note: in included file (through include/asm-generic/atomic.h, arch/openrisc/include/asm/atomic.h, include/linux/atomic.h, ...):
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   net/tipc/socket.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   net/tipc/socket.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   net/tipc/socket.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   net/tipc/socket.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   net/tipc/socket.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   net/tipc/socket.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
>> fs/ocfs2/ioctl.c:858:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   fs/ocfs2/ioctl.c:858:24: sparse:     expected int *__pu_addr
   fs/ocfs2/ioctl.c:858:24: sparse:     got int [noderef] __user *
   fs/ocfs2/ioctl.c:860:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ocfs2/ioctl.c:860:21: sparse:     expected int const *__gu_addr
   fs/ocfs2/ioctl.c:860:21: sparse:     got int [noderef] __user *
   fs/ocfs2/ioctl.c:882:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ocfs2/ioctl.c:882:21: sparse:     expected int const *__gu_addr
   fs/ocfs2/ioctl.c:882:21: sparse:     got int [noderef] __user *
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
>> fs/ocfs2/ioctl.c:46:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/ocfs2/ioctl.c:46:15: sparse:     expected unsigned int *__pu_addr
>> fs/ocfs2/ioctl.c:46:15: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
>> fs/ocfs2/ioctl.c:46:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/ocfs2/ioctl.c:46:15: sparse:     expected unsigned int *__pu_addr
>> fs/ocfs2/ioctl.c:46:15: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   fs/ocfs2/ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
>> drivers/usb/gadget/function/rndis.c:1126:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buffer @@
   drivers/usb/gadget/function/rndis.c:1126:21: sparse:     expected char const *__gu_addr
>> drivers/usb/gadget/function/rndis.c:1126:21: sparse:     got char const [noderef] __user *buffer
--
   net/kcm/kcmsock.c:1280:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/kcm/kcmsock.c:1280:13: sparse:     expected int const *__gu_addr
   net/kcm/kcmsock.c:1280:13: sparse:     got int [noderef] __user *
   net/kcm/kcmsock.c:1310:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/kcm/kcmsock.c:1310:13: sparse:     expected int const *__gu_addr
   net/kcm/kcmsock.c:1310:13: sparse:     got int [noderef] __user *optlen
>> net/kcm/kcmsock.c:1325:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *optlen @@
   net/kcm/kcmsock.c:1325:13: sparse:     expected int *__pu_addr
   net/kcm/kcmsock.c:1325:13: sparse:     got int [noderef] __user *optlen
   net/kcm/kcmsock.c: note: in included file (through include/asm-generic/atomic.h, arch/openrisc/include/asm/atomic.h, include/linux/atomic.h, ...):
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   net/kcm/kcmsock.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   net/kcm/kcmsock.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   net/kcm/kcmsock.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   net/kcm/kcmsock.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from

vim +69 net/dccp/ccid.c

ddebc973c56b51b Gerrit Renker 2009-01-04  59  
ddebc973c56b51b Gerrit Renker 2009-01-04  60  int ccid_getsockopt_builtin_ccids(struct sock *sk, int len,
ddebc973c56b51b Gerrit Renker 2009-01-04  61  				  char __user *optval, int __user *optlen)
ddebc973c56b51b Gerrit Renker 2009-01-04  62  {
ddebc973c56b51b Gerrit Renker 2009-01-04  63  	u8 *ccid_array, array_len;
ddebc973c56b51b Gerrit Renker 2009-01-04  64  	int err = 0;
ddebc973c56b51b Gerrit Renker 2009-01-04  65  
ddebc973c56b51b Gerrit Renker 2009-01-04  66  	if (ccid_get_builtin_ccids(&ccid_array, &array_len))
ddebc973c56b51b Gerrit Renker 2009-01-04  67  		return -ENOBUFS;
ddebc973c56b51b Gerrit Renker 2009-01-04  68  
69a6a0b38a139cc Gerrit Renker 2010-02-07 @69  	if (put_user(array_len, optlen))
69a6a0b38a139cc Gerrit Renker 2010-02-07  70  		err = -EFAULT;
69a6a0b38a139cc Gerrit Renker 2010-02-07  71  	else if (len > 0 && copy_to_user(optval, ccid_array,
69a6a0b38a139cc Gerrit Renker 2010-02-07  72  					 len > array_len ? array_len : len))
ddebc973c56b51b Gerrit Renker 2009-01-04  73  		err = -EFAULT;
ddebc973c56b51b Gerrit Renker 2009-01-04  74  
ddebc973c56b51b Gerrit Renker 2009-01-04  75  	kfree(ccid_array);
ddebc973c56b51b Gerrit Renker 2009-01-04  76  	return err;
ddebc973c56b51b Gerrit Renker 2009-01-04  77  }
ddebc973c56b51b Gerrit Renker 2009-01-04  78  

:::::: The code at line 69 was first introduced by commit
:::::: 69a6a0b38a139ccceef32222108caca8a9b0b795 dccp: allow probing of CCID-array length

:::::: TO: Gerrit Renker <gerrit@erg.abdn.ac.uk>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--/9DWx/yDrRhgMJTb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
NcMLvlBXEX8BJrovPYKWAQA=

--/9DWx/yDrRhgMJTb--
