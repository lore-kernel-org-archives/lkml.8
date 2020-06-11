Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FD0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 04:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616BA2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 04:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgFKEyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 00:54:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:1485 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgFKEyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 00:54:38 -0400
IronPort-SDR: 5qcqX8+s+Pozrs3kK408XdNKV/OwGZbqYdAqBTnUhUlBYWKP1CJPPv/MiLtVD0vSzqyC2mz/Yo
 C/Ob3ImBl8ug==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 21:46:33 -0700
IronPort-SDR: INuM0lhi99DuR9zg4dgy6Xrq3ARHhqrXoxhCbySU4M5LFwAaK58dpu6llZp2g5SUd2Ly4c/N0R
 bQOor0TU+JVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; 
   d="gz'50?scan'50,208,50";a="447789164"
Received: from lkp-server01.sh.intel.com (HELO b6eec31c25be) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Jun 2020 21:46:30 -0700
Received: from kbuild by b6eec31c25be with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jjF6k-00005X-7N; Thu, 11 Jun 2020 04:46:30 +0000
Date:   Thu, 11 Jun 2020 12:45:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     SrujanaChalla <schalla@marvell.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c:881:45: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202006111230.Y7IEC8dt%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b29482fde649c72441d5478a4ea2c52c56d97a5e
commit: 6482023b9d3350bf1b756ef36e1ea1a1c871879c crypto: marvell - enable OcteonTX cpt options for build
date:   3 months ago
config: s390-randconfig-s032-20200611 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-250-g42323db3-dirty
        git checkout 6482023b9d3350bf1b756ef36e1ea1a1c871879c
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=s390 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c:306:22: sparse: sparse: cast to restricted __be32
>> drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c:881:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c:881:45: sparse:     expected unsigned long long [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c:881:45: sparse:     got restricted __be64 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c:885:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __be16 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c:885:45: sparse:     expected unsigned short [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c:885:45: sparse:     got restricted __be16 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c:905:23: sparse: sparse: cast to restricted __be32
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
--
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:365:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] opcode @@     got restricted __be16 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:365:29: sparse:     expected unsigned short [assigned] [usertype] opcode
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:365:29: sparse:     got restricted __be16 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:366:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] param1 @@     got restricted __be16 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:366:29: sparse:     expected unsigned short [assigned] [usertype] param1
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:366:29: sparse:     got restricted __be16 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:367:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] param2 @@     got restricted __be16 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:367:29: sparse:     expected unsigned short [assigned] [usertype] param2
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:367:29: sparse:     got restricted __be16 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:368:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] dlen @@     got restricted __be16 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:368:29: sparse:     expected unsigned short [assigned] [usertype] dlen
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:368:29: sparse:     got restricted __be16 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:371:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [assigned] [usertype] u64 @@     got restricted __be64 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:371:24: sparse:     expected unsigned long long [assigned] [usertype] u64
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:371:24: sparse:     got restricted __be64 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:439:19: sparse: sparse: cast to restricted __be64
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:209:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:209:33: sparse:     expected unsigned long long [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:209:33: sparse:     got restricted __be64
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:127:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] len0 @@     got restricted __be16 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:127:34: sparse:     expected unsigned short [usertype] len0
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:127:34: sparse:     got restricted __be16 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:128:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] len1 @@     got restricted __be16 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:128:34: sparse:     expected unsigned short [usertype] len1
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:128:34: sparse:     got restricted __be16 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:129:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] len2 @@     got restricted __be16 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:129:34: sparse:     expected unsigned short [usertype] len2
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:129:34: sparse:     got restricted __be16 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:130:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] len3 @@     got restricted __be16 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:130:34: sparse:     expected unsigned short [usertype] len3
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:130:34: sparse:     got restricted __be16 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:131:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ptr0 @@     got restricted __be64 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:131:30: sparse:     expected unsigned long long [usertype] ptr0
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:131:30: sparse:     got restricted __be64 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:132:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ptr1 @@     got restricted __be64 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:132:30: sparse:     expected unsigned long long [usertype] ptr1
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:132:30: sparse:     got restricted __be64 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:133:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ptr2 @@     got restricted __be64 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:133:30: sparse:     expected unsigned long long [usertype] ptr2
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:133:30: sparse:     got restricted __be64 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:134:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ptr3 @@     got restricted __be64 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:134:30: sparse:     expected unsigned long long [usertype] ptr3
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:134:30: sparse:     got restricted __be64 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:141:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] len2 @@     got restricted __be16 [usertype] @@
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:141:34: sparse:     expected unsigned short [usertype] len2
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:141:34: sparse:     got restricted __be16 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:142:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ptr2 @@     got restricted __be64 [usertype] @@
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:142:30: sparse:     expected unsigned long long [usertype] ptr2
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:142:30: sparse:     got restricted __be64 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:145:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] len1 @@     got restricted __be16 [usertype] @@
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:145:34: sparse:     expected unsigned short [usertype] len1
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:145:34: sparse:     got restricted __be16 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:146:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ptr1 @@     got restricted __be64 [usertype] @@
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:146:30: sparse:     expected unsigned long long [usertype] ptr1
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:146:30: sparse:     got restricted __be64 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:149:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] len0 @@     got restricted __be16 [usertype] @@
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:149:34: sparse:     expected unsigned short [usertype] len0
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:149:34: sparse:     got restricted __be16 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:150:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ptr0 @@     got restricted __be64 [usertype] @@
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:150:30: sparse:     expected unsigned long long [usertype] ptr0
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:150:30: sparse:     got restricted __be64 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:127:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] len0 @@     got restricted __be16 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:127:34: sparse:     expected unsigned short [usertype] len0
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:127:34: sparse:     got restricted __be16 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:128:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] len1 @@     got restricted __be16 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:128:34: sparse:     expected unsigned short [usertype] len1
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:128:34: sparse:     got restricted __be16 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:129:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] len2 @@     got restricted __be16 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:129:34: sparse:     expected unsigned short [usertype] len2
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:129:34: sparse:     got restricted __be16 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:130:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] len3 @@     got restricted __be16 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:130:34: sparse:     expected unsigned short [usertype] len3
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:130:34: sparse:     got restricted __be16 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:131:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ptr0 @@     got restricted __be64 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:131:30: sparse:     expected unsigned long long [usertype] ptr0
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:131:30: sparse:     got restricted __be64 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:132:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ptr1 @@     got restricted __be64 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:132:30: sparse:     expected unsigned long long [usertype] ptr1
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:132:30: sparse:     got restricted __be64 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:133:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ptr2 @@     got restricted __be64 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:133:30: sparse:     expected unsigned long long [usertype] ptr2
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:133:30: sparse:     got restricted __be64 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:134:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ptr3 @@     got restricted __be64 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:134:30: sparse:     expected unsigned long long [usertype] ptr3
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:134:30: sparse:     got restricted __be64 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:141:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] len2 @@     got restricted __be16 [usertype] @@
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:141:34: sparse:     expected unsigned short [usertype] len2
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:141:34: sparse:     got restricted __be16 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:142:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ptr2 @@     got restricted __be64 [usertype] @@
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:142:30: sparse:     expected unsigned long long [usertype] ptr2
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:142:30: sparse:     got restricted __be64 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:145:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] len1 @@     got restricted __be16 [usertype] @@
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:145:34: sparse:     expected unsigned short [usertype] len1
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:145:34: sparse:     got restricted __be16 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:146:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ptr1 @@     got restricted __be64 [usertype] @@
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:146:30: sparse:     expected unsigned long long [usertype] ptr1
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:146:30: sparse:     got restricted __be64 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:149:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] len0 @@     got restricted __be16 [usertype] @@
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:149:34: sparse:     expected unsigned short [usertype] len0
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:149:34: sparse:     got restricted __be16 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:150:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ptr0 @@     got restricted __be64 [usertype] @@
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:150:30: sparse:     expected unsigned long long [usertype] ptr0
   drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c:150:30: sparse:     got restricted __be64 [usertype]
--
>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:281:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:281:21: sparse:     expected unsigned long long [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:281:21: sparse:     got restricted __be64 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:281:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:281:21: sparse:     expected unsigned long long [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:281:21: sparse:     got restricted __be64 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:696:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:696:24: sparse:     expected unsigned int [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:696:24: sparse:     got restricted __be32 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:696:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:696:24: sparse:     expected unsigned int [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:696:24: sparse:     got restricted __be32 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:705:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] @@
   drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:705:24: sparse:     expected unsigned long long [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:705:24: sparse:     got restricted __be64 [usertype]
>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:1012:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] flags @@     got restricted __be64 [usertype] @@
>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:1012:31: sparse:     expected unsigned long long [usertype] flags
   drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:1012:31: sparse:     got restricted __be64 [usertype]
   drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:1032:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] flags @@     got restricted __be64 [usertype] @@
   drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:1032:34: sparse:     expected unsigned long long [usertype] flags
   drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:1032:34: sparse:     got restricted __be64 [usertype]

vim +881 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c

d9110b0b01ff1cd SrujanaChalla 2020-03-13  858  
d9110b0b01ff1cd SrujanaChalla 2020-03-13  859  static int copy_ucode_to_dma_mem(struct device *dev,
d9110b0b01ff1cd SrujanaChalla 2020-03-13  860  				 struct otx_cpt_ucode *ucode,
d9110b0b01ff1cd SrujanaChalla 2020-03-13  861  				 const u8 *ucode_data)
d9110b0b01ff1cd SrujanaChalla 2020-03-13  862  {
d9110b0b01ff1cd SrujanaChalla 2020-03-13  863  	u32 i;
d9110b0b01ff1cd SrujanaChalla 2020-03-13  864  
d9110b0b01ff1cd SrujanaChalla 2020-03-13  865  	/*  Allocate DMAable space */
d9110b0b01ff1cd SrujanaChalla 2020-03-13  866  	ucode->va = dma_alloc_coherent(dev, ucode->size +
d9110b0b01ff1cd SrujanaChalla 2020-03-13  867  				       OTX_CPT_UCODE_ALIGNMENT,
d9110b0b01ff1cd SrujanaChalla 2020-03-13  868  				       &ucode->dma, GFP_KERNEL);
d9110b0b01ff1cd SrujanaChalla 2020-03-13  869  	if (!ucode->va) {
d9110b0b01ff1cd SrujanaChalla 2020-03-13  870  		dev_err(dev, "Unable to allocate space for microcode");
d9110b0b01ff1cd SrujanaChalla 2020-03-13  871  		return -ENOMEM;
d9110b0b01ff1cd SrujanaChalla 2020-03-13  872  	}
d9110b0b01ff1cd SrujanaChalla 2020-03-13  873  	ucode->align_va = PTR_ALIGN(ucode->va, OTX_CPT_UCODE_ALIGNMENT);
d9110b0b01ff1cd SrujanaChalla 2020-03-13  874  	ucode->align_dma = PTR_ALIGN(ucode->dma, OTX_CPT_UCODE_ALIGNMENT);
d9110b0b01ff1cd SrujanaChalla 2020-03-13  875  
d9110b0b01ff1cd SrujanaChalla 2020-03-13  876  	memcpy((void *) ucode->align_va, (void *) ucode_data +
d9110b0b01ff1cd SrujanaChalla 2020-03-13  877  	       sizeof(struct otx_cpt_ucode_hdr), ucode->size);
d9110b0b01ff1cd SrujanaChalla 2020-03-13  878  
d9110b0b01ff1cd SrujanaChalla 2020-03-13  879  	/* Byte swap 64-bit */
d9110b0b01ff1cd SrujanaChalla 2020-03-13  880  	for (i = 0; i < (ucode->size / 8); i++)
d9110b0b01ff1cd SrujanaChalla 2020-03-13 @881  		((u64 *)ucode->align_va)[i] =
d9110b0b01ff1cd SrujanaChalla 2020-03-13  882  				cpu_to_be64(((u64 *)ucode->align_va)[i]);
d9110b0b01ff1cd SrujanaChalla 2020-03-13  883  	/*  Ucode needs 16-bit swap */
d9110b0b01ff1cd SrujanaChalla 2020-03-13  884  	for (i = 0; i < (ucode->size / 2); i++)
d9110b0b01ff1cd SrujanaChalla 2020-03-13 @885  		((u16 *)ucode->align_va)[i] =
d9110b0b01ff1cd SrujanaChalla 2020-03-13  886  				cpu_to_be16(((u16 *)ucode->align_va)[i]);
d9110b0b01ff1cd SrujanaChalla 2020-03-13  887  	return 0;
d9110b0b01ff1cd SrujanaChalla 2020-03-13  888  }
d9110b0b01ff1cd SrujanaChalla 2020-03-13  889  

:::::: The code at line 881 was first introduced by commit
:::::: d9110b0b01ff1cd02751cd5c2c94e938a8906083 crypto: marvell - add support for OCTEON TX CPT engine

:::::: TO: SrujanaChalla <schalla@marvell.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ibTvN161/egqYuK8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ibTvN161/egqYuK8--
