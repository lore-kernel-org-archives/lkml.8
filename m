Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D006DC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 15:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE2D206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 15:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgCGPVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 10:21:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:12682 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgCGPVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 10:21:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2020 07:21:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,526,1574150400"; 
   d="scan'208";a="235151962"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Mar 2020 07:21:00 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jAbG7-0006az-SF; Sat, 07 Mar 2020 23:20:59 +0800
Date:   Sat, 7 Mar 2020 23:20:11 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Timur Tabi <timur@kernel.org>
Subject: drivers/soc/fsl/qe/ucc.c:637:20: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202003072307.Es4yunVB%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   63849c8f410717eb2e6662f3953ff674727303e7
commit: 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5 soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
date:   3 months ago
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-174-g094d5a94-dirty
        git checkout 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/soc/fsl/qe/ucc.c:637:20: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected struct qe_mux *qe_mux_reg @@    got struct qe_mux [nodstruct qe_mux *qe_mux_reg @@
   drivers/soc/fsl/qe/ucc.c:637:20: sparse:    expected struct qe_mux *qe_mux_reg
   drivers/soc/fsl/qe/ucc.c:637:20: sparse:    got struct qe_mux [noderef] <asn:2> *
>> drivers/soc/fsl/qe/ucc.c:652:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:2> * @@    got [noderef] <asn:2> * @@
   drivers/soc/fsl/qe/ucc.c:652:9: sparse:    expected void [noderef] <asn:2> *
   drivers/soc/fsl/qe/ucc.c:652:9: sparse:    got restricted __be32 *
   drivers/soc/fsl/qe/ucc.c:652:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:2> * @@    got [noderef] <asn:2> * @@
   drivers/soc/fsl/qe/ucc.c:652:9: sparse:    expected void [noderef] <asn:2> *
   drivers/soc/fsl/qe/ucc.c:652:9: sparse:    got restricted __be32 *

vim +637 drivers/soc/fsl/qe/ucc.c

bb8b2062aff321 Zhao Qiang       2016-06-06  629  
bb8b2062aff321 Zhao Qiang       2016-06-06  630  int ucc_set_tdm_rxtx_sync(u32 tdm_num, enum qe_clock clock,
bb8b2062aff321 Zhao Qiang       2016-06-06  631  			  enum comm_dir mode)
bb8b2062aff321 Zhao Qiang       2016-06-06  632  {
bb8b2062aff321 Zhao Qiang       2016-06-06  633  	int source;
bb8b2062aff321 Zhao Qiang       2016-06-06  634  	u32 shift;
bb8b2062aff321 Zhao Qiang       2016-06-06  635  	struct qe_mux *qe_mux_reg;
bb8b2062aff321 Zhao Qiang       2016-06-06  636  
bb8b2062aff321 Zhao Qiang       2016-06-06 @637  	qe_mux_reg = &qe_immr->qmx;
bb8b2062aff321 Zhao Qiang       2016-06-06  638  
bb8b2062aff321 Zhao Qiang       2016-06-06  639  	if (tdm_num >= UCC_TDM_NUM)
bb8b2062aff321 Zhao Qiang       2016-06-06  640  		return -EINVAL;
bb8b2062aff321 Zhao Qiang       2016-06-06  641  
bb8b2062aff321 Zhao Qiang       2016-06-06  642  	/* The communications direction must be RX or TX */
bb8b2062aff321 Zhao Qiang       2016-06-06  643  	if (mode != COMM_DIR_RX && mode != COMM_DIR_TX)
bb8b2062aff321 Zhao Qiang       2016-06-06  644  		return -EINVAL;
bb8b2062aff321 Zhao Qiang       2016-06-06  645  
bb8b2062aff321 Zhao Qiang       2016-06-06  646  	source = ucc_get_tdm_sync_source(tdm_num, clock, mode);
bb8b2062aff321 Zhao Qiang       2016-06-06  647  	if (source < 0)
bb8b2062aff321 Zhao Qiang       2016-06-06  648  		return -EINVAL;
bb8b2062aff321 Zhao Qiang       2016-06-06  649  
bb8b2062aff321 Zhao Qiang       2016-06-06  650  	shift = ucc_get_tdm_sync_shift(mode, tdm_num);
bb8b2062aff321 Zhao Qiang       2016-06-06  651  
d9d95bcad38d18 Rasmus Villemoes 2019-11-28 @652  	qe_clrsetbits_be32(&qe_mux_reg->cmxsi1syr,

:::::: The code at line 637 was first introduced by commit
:::::: bb8b2062aff321af1fc58781cc07fbbea01cceb3 fsl/qe: setup clock source for TDM mode

:::::: TO: Zhao Qiang <qiang.zhao@nxp.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
