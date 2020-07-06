Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE83C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F26206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgGFP3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:29:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:8092 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729321AbgGFP3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:29:46 -0400
IronPort-SDR: GivQhM/zuI5Ap5hk7AED7tS8858feK4O4FYt8L/rmKuOeDs0KzxIBO5ANFZu50454PqocSTe51
 +AP3RJ71rviA==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="127460021"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="gz'50?scan'50,208,50";a="127460021"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 03:24:31 -0700
IronPort-SDR: c373GC6to/7SUh/bD/3/zIlq9jZiAmJFBAp+t8aCzEcAv/8CBk5m4AALrVRUvfqaceVSFe6xnA
 o/qtaHbAUEIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="gz'50?scan'50,208,50";a="323159753"
Received: from lkp-server01.sh.intel.com (HELO 82346ce9ac16) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2020 03:24:29 -0700
Received: from kbuild by 82346ce9ac16 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jsOIX-0000B0-7e; Mon, 06 Jul 2020 10:24:29 +0000
Date:   Mon, 6 Jul 2020 18:23:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Timur Tabi <timur@kernel.org>
Subject: drivers/net/wan/fsl_ucc_hdlc.c:305:17: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202007061850.wRyBEu1u%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rasmus,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258
commit: 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5 soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
date:   7 months ago
config: arm64-randconfig-s032-20200706 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-14-g8fce3d7a-dirty
        git checkout 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/wan/fsl_ucc_hdlc.c:305:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
>> drivers/net/wan/fsl_ucc_hdlc.c:305:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/wan/fsl_ucc_hdlc.c:305:17: sparse:     got restricted __be16 *
>> drivers/net/wan/fsl_ucc_hdlc.c:306:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:306:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/wan/fsl_ucc_hdlc.c:306:17: sparse:     got restricted __be32 *
   drivers/net/wan/fsl_ucc_hdlc.c:316:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:316:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/wan/fsl_ucc_hdlc.c:316:17: sparse:     got restricted __be16 *
   drivers/net/wan/fsl_ucc_hdlc.c:317:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:317:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/wan/fsl_ucc_hdlc.c:317:17: sparse:     got restricted __be32 *
>> drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __be16 [usertype] @@
   drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse:     expected unsigned short [usertype]
   drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse:     got restricted __be16 [usertype]
   drivers/net/wan/fsl_ucc_hdlc.c:375:36: sparse: sparse: restricted __be16 degrades to integer
>> drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd [noderef] <asn:2> *bd @@     got struct qe_bd *curtx_bd @@
   drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse:     expected struct qe_bd [noderef] <asn:2> *bd
   drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse:     got struct qe_bd *curtx_bd
   drivers/net/wan/fsl_ucc_hdlc.c:408:9: sparse: sparse: dereference of noderef expression
>> drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd [noderef] <asn:2> *[assigned] bd @@     got struct qe_bd *tx_bd_base @@
   drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse:     expected struct qe_bd [noderef] <asn:2> *[assigned] bd
   drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse:     got struct qe_bd *tx_bd_base
   drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse:    struct qe_bd [noderef] <asn:2> *
   drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse:    struct qe_bd *
>> drivers/net/wan/fsl_ucc_hdlc.c:458:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
>> drivers/net/wan/fsl_ucc_hdlc.c:458:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
>> drivers/net/wan/fsl_ucc_hdlc.c:458:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
>> drivers/net/wan/fsl_ucc_hdlc.c:458:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:502:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:502:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:502:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:502:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:524:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:524:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:524:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:524:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:548:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:548:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:548:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:548:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:592:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:607:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:607:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:607:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:607:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
>> drivers/net/wan/fsl_ucc_hdlc.c:852:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct qe_mux *qe_mux_reg @@     got struct qe_mux [noderef] <asn:2> * @@
>> drivers/net/wan/fsl_ucc_hdlc.c:855:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
>> drivers/net/wan/fsl_ucc_hdlc.c:855:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
>> drivers/net/wan/fsl_ucc_hdlc.c:855:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
>> drivers/net/wan/fsl_ucc_hdlc.c:855:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
>> drivers/net/wan/fsl_ucc_hdlc.c:855:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
>> drivers/net/wan/fsl_ucc_hdlc.c:855:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:856:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:856:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:856:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:856:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:856:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:856:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:859:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:859:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:859:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:859:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:859:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:859:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
>> drivers/net/wan/fsl_ucc_hdlc.c:862:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:867:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct qe_mux *qe_mux_reg @@     got struct qe_mux [noderef] <asn:2> * @@
>> drivers/net/wan/fsl_ucc_hdlc.c:869:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] <asn:2> * @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:871:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:872:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:874:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:996:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:997:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:1007:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:1008:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:408:9: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:408:9: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:725:29: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:816:21: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:1024:29: sparse: sparse: dereference of noderef expression

vim +305 drivers/net/wan/fsl_ucc_hdlc.c

c19b6d246a3562 Zhao Qiang       2016-06-06   77  
c19b6d246a3562 Zhao Qiang       2016-06-06   78  static int uhdlc_init(struct ucc_hdlc_private *priv)
c19b6d246a3562 Zhao Qiang       2016-06-06   79  {
c19b6d246a3562 Zhao Qiang       2016-06-06   80  	struct ucc_tdm_info *ut_info;
c19b6d246a3562 Zhao Qiang       2016-06-06   81  	struct ucc_fast_info *uf_info;
c19b6d246a3562 Zhao Qiang       2016-06-06   82  	u32 cecr_subblock;
c19b6d246a3562 Zhao Qiang       2016-06-06   83  	u16 bd_status;
c19b6d246a3562 Zhao Qiang       2016-06-06   84  	int ret, i;
c19b6d246a3562 Zhao Qiang       2016-06-06   85  	void *bd_buffer;
c19b6d246a3562 Zhao Qiang       2016-06-06   86  	dma_addr_t bd_dma_addr;
be2e9415f8b366 Rasmus Villemoes 2019-11-28   87  	s32 riptr;
be2e9415f8b366 Rasmus Villemoes 2019-11-28   88  	s32 tiptr;
c19b6d246a3562 Zhao Qiang       2016-06-06   89  	u32 gumr;
c19b6d246a3562 Zhao Qiang       2016-06-06   90  
c19b6d246a3562 Zhao Qiang       2016-06-06   91  	ut_info = priv->ut_info;
c19b6d246a3562 Zhao Qiang       2016-06-06   92  	uf_info = &ut_info->uf_info;
c19b6d246a3562 Zhao Qiang       2016-06-06   93  
c19b6d246a3562 Zhao Qiang       2016-06-06   94  	if (priv->tsa) {
c19b6d246a3562 Zhao Qiang       2016-06-06   95  		uf_info->tsa = 1;
c19b6d246a3562 Zhao Qiang       2016-06-06   96  		uf_info->ctsp = 1;
040b7c94e4ec58 David Gounaris   2018-09-03   97  		uf_info->cds = 1;
040b7c94e4ec58 David Gounaris   2018-09-03   98  		uf_info->ctss = 1;
040b7c94e4ec58 David Gounaris   2018-09-03   99  	} else {
040b7c94e4ec58 David Gounaris   2018-09-03  100  		uf_info->cds = 0;
040b7c94e4ec58 David Gounaris   2018-09-03  101  		uf_info->ctsp = 0;
040b7c94e4ec58 David Gounaris   2018-09-03  102  		uf_info->ctss = 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  103  	}
067bb938dad61e Holger Brunck    2017-05-17  104  
067bb938dad61e Holger Brunck    2017-05-17  105  	/* This sets HPM register in CMXUCR register which configures a
067bb938dad61e Holger Brunck    2017-05-17  106  	 * open drain connected HDLC bus
067bb938dad61e Holger Brunck    2017-05-17  107  	 */
067bb938dad61e Holger Brunck    2017-05-17  108  	if (priv->hdlc_bus)
067bb938dad61e Holger Brunck    2017-05-17  109  		uf_info->brkpt_support = 1;
067bb938dad61e Holger Brunck    2017-05-17  110  
c19b6d246a3562 Zhao Qiang       2016-06-06  111  	uf_info->uccm_mask = ((UCC_HDLC_UCCE_RXB | UCC_HDLC_UCCE_RXF |
c19b6d246a3562 Zhao Qiang       2016-06-06  112  				UCC_HDLC_UCCE_TXB) << 16);
c19b6d246a3562 Zhao Qiang       2016-06-06  113  
c19b6d246a3562 Zhao Qiang       2016-06-06  114  	ret = ucc_fast_init(uf_info, &priv->uccf);
c19b6d246a3562 Zhao Qiang       2016-06-06  115  	if (ret) {
c19b6d246a3562 Zhao Qiang       2016-06-06  116  		dev_err(priv->dev, "Failed to init uccf.");
c19b6d246a3562 Zhao Qiang       2016-06-06  117  		return ret;
c19b6d246a3562 Zhao Qiang       2016-06-06  118  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  119  
c19b6d246a3562 Zhao Qiang       2016-06-06  120  	priv->uf_regs = priv->uccf->uf_regs;
c19b6d246a3562 Zhao Qiang       2016-06-06  121  	ucc_fast_disable(priv->uccf, COMM_DIR_RX | COMM_DIR_TX);
c19b6d246a3562 Zhao Qiang       2016-06-06  122  
c19b6d246a3562 Zhao Qiang       2016-06-06  123  	/* Loopback mode */
c19b6d246a3562 Zhao Qiang       2016-06-06  124  	if (priv->loopback) {
c19b6d246a3562 Zhao Qiang       2016-06-06  125  		dev_info(priv->dev, "Loopback Mode\n");
54e9e0874938ba Holger Brunck    2017-05-17  126  		/* use the same clock when work in loopback */
54e9e0874938ba Holger Brunck    2017-05-17  127  		qe_setbrg(ut_info->uf_info.rx_clock, 20000000, 1);
54e9e0874938ba Holger Brunck    2017-05-17  128  
c19b6d246a3562 Zhao Qiang       2016-06-06  129  		gumr = ioread32be(&priv->uf_regs->gumr);
c19b6d246a3562 Zhao Qiang       2016-06-06  130  		gumr |= (UCC_FAST_GUMR_LOOPBACK | UCC_FAST_GUMR_CDS |
c19b6d246a3562 Zhao Qiang       2016-06-06  131  			 UCC_FAST_GUMR_TCI);
c19b6d246a3562 Zhao Qiang       2016-06-06  132  		gumr &= ~(UCC_FAST_GUMR_CTSP | UCC_FAST_GUMR_RSYN);
c19b6d246a3562 Zhao Qiang       2016-06-06  133  		iowrite32be(gumr, &priv->uf_regs->gumr);
c19b6d246a3562 Zhao Qiang       2016-06-06  134  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  135  
c19b6d246a3562 Zhao Qiang       2016-06-06  136  	/* Initialize SI */
c19b6d246a3562 Zhao Qiang       2016-06-06  137  	if (priv->tsa)
c19b6d246a3562 Zhao Qiang       2016-06-06  138  		ucc_tdm_init(priv->utdm, priv->ut_info);
c19b6d246a3562 Zhao Qiang       2016-06-06  139  
c19b6d246a3562 Zhao Qiang       2016-06-06  140  	/* Write to QE CECR, UCCx channel to Stop Transmission */
c19b6d246a3562 Zhao Qiang       2016-06-06  141  	cecr_subblock = ucc_fast_get_qe_cr_subblock(uf_info->ucc_num);
c19b6d246a3562 Zhao Qiang       2016-06-06  142  	ret = qe_issue_cmd(QE_STOP_TX, cecr_subblock,
c19b6d246a3562 Zhao Qiang       2016-06-06  143  			   QE_CR_PROTOCOL_UNSPECIFIED, 0);
c19b6d246a3562 Zhao Qiang       2016-06-06  144  
c19b6d246a3562 Zhao Qiang       2016-06-06  145  	/* Set UPSMR normal mode (need fixed)*/
c19b6d246a3562 Zhao Qiang       2016-06-06  146  	iowrite32be(0, &priv->uf_regs->upsmr);
c19b6d246a3562 Zhao Qiang       2016-06-06  147  
067bb938dad61e Holger Brunck    2017-05-17  148  	/* hdlc_bus mode */
067bb938dad61e Holger Brunck    2017-05-17  149  	if (priv->hdlc_bus) {
067bb938dad61e Holger Brunck    2017-05-17  150  		u32 upsmr;
067bb938dad61e Holger Brunck    2017-05-17  151  
067bb938dad61e Holger Brunck    2017-05-17  152  		dev_info(priv->dev, "HDLC bus Mode\n");
067bb938dad61e Holger Brunck    2017-05-17  153  		upsmr = ioread32be(&priv->uf_regs->upsmr);
067bb938dad61e Holger Brunck    2017-05-17  154  
067bb938dad61e Holger Brunck    2017-05-17  155  		/* bus mode and retransmit enable, with collision window
067bb938dad61e Holger Brunck    2017-05-17  156  		 * set to 8 bytes
067bb938dad61e Holger Brunck    2017-05-17  157  		 */
067bb938dad61e Holger Brunck    2017-05-17  158  		upsmr |= UCC_HDLC_UPSMR_RTE | UCC_HDLC_UPSMR_BUS |
067bb938dad61e Holger Brunck    2017-05-17  159  				UCC_HDLC_UPSMR_CW8;
067bb938dad61e Holger Brunck    2017-05-17  160  		iowrite32be(upsmr, &priv->uf_regs->upsmr);
067bb938dad61e Holger Brunck    2017-05-17  161  
067bb938dad61e Holger Brunck    2017-05-17  162  		/* explicitly disable CDS & CTSP */
067bb938dad61e Holger Brunck    2017-05-17  163  		gumr = ioread32be(&priv->uf_regs->gumr);
067bb938dad61e Holger Brunck    2017-05-17  164  		gumr &= ~(UCC_FAST_GUMR_CDS | UCC_FAST_GUMR_CTSP);
067bb938dad61e Holger Brunck    2017-05-17  165  		/* set automatic sync to explicitly ignore CD signal */
067bb938dad61e Holger Brunck    2017-05-17  166  		gumr |= UCC_FAST_GUMR_SYNL_AUTO;
067bb938dad61e Holger Brunck    2017-05-17  167  		iowrite32be(gumr, &priv->uf_regs->gumr);
067bb938dad61e Holger Brunck    2017-05-17  168  	}
067bb938dad61e Holger Brunck    2017-05-17  169  
c19b6d246a3562 Zhao Qiang       2016-06-06  170  	priv->rx_ring_size = RX_BD_RING_LEN;
c19b6d246a3562 Zhao Qiang       2016-06-06  171  	priv->tx_ring_size = TX_BD_RING_LEN;
c19b6d246a3562 Zhao Qiang       2016-06-06  172  	/* Alloc Rx BD */
c19b6d246a3562 Zhao Qiang       2016-06-06  173  	priv->rx_bd_base = dma_alloc_coherent(priv->dev,
5b8aad93c52bdd Holger Brunck    2017-05-17  174  			RX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a3562 Zhao Qiang       2016-06-06  175  			&priv->dma_rx_bd, GFP_KERNEL);
c19b6d246a3562 Zhao Qiang       2016-06-06  176  
c19b6d246a3562 Zhao Qiang       2016-06-06  177  	if (!priv->rx_bd_base) {
c19b6d246a3562 Zhao Qiang       2016-06-06  178  		dev_err(priv->dev, "Cannot allocate MURAM memory for RxBDs\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  179  		ret = -ENOMEM;
1efb597d8bf56c Zhao Qiang       2016-07-15  180  		goto free_uccf;
c19b6d246a3562 Zhao Qiang       2016-06-06  181  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  182  
c19b6d246a3562 Zhao Qiang       2016-06-06  183  	/* Alloc Tx BD */
c19b6d246a3562 Zhao Qiang       2016-06-06  184  	priv->tx_bd_base = dma_alloc_coherent(priv->dev,
5b8aad93c52bdd Holger Brunck    2017-05-17  185  			TX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a3562 Zhao Qiang       2016-06-06  186  			&priv->dma_tx_bd, GFP_KERNEL);
c19b6d246a3562 Zhao Qiang       2016-06-06  187  
c19b6d246a3562 Zhao Qiang       2016-06-06  188  	if (!priv->tx_bd_base) {
c19b6d246a3562 Zhao Qiang       2016-06-06  189  		dev_err(priv->dev, "Cannot allocate MURAM memory for TxBDs\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  190  		ret = -ENOMEM;
1efb597d8bf56c Zhao Qiang       2016-07-15  191  		goto free_rx_bd;
c19b6d246a3562 Zhao Qiang       2016-06-06  192  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  193  
c19b6d246a3562 Zhao Qiang       2016-06-06  194  	/* Alloc parameter ram for ucc hdlc */
85deed56032b6c Holger Brunck    2017-05-22  195  	priv->ucc_pram_offset = qe_muram_alloc(sizeof(struct ucc_hdlc_param),
c19b6d246a3562 Zhao Qiang       2016-06-06  196  				ALIGNMENT_OF_UCC_HDLC_PRAM);
c19b6d246a3562 Zhao Qiang       2016-06-06  197  
be2e9415f8b366 Rasmus Villemoes 2019-11-28  198  	if (priv->ucc_pram_offset < 0) {
24a24d07d688a4 Colin Ian King   2016-08-28  199  		dev_err(priv->dev, "Can not allocate MURAM for hdlc parameter.\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  200  		ret = -ENOMEM;
1efb597d8bf56c Zhao Qiang       2016-07-15  201  		goto free_tx_bd;
c19b6d246a3562 Zhao Qiang       2016-06-06  202  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  203  
6396bb221514d2 Kees Cook        2018-06-12  204  	priv->rx_skbuff = kcalloc(priv->rx_ring_size,
6396bb221514d2 Kees Cook        2018-06-12  205  				  sizeof(*priv->rx_skbuff),
c19b6d246a3562 Zhao Qiang       2016-06-06  206  				  GFP_KERNEL);
c19b6d246a3562 Zhao Qiang       2016-06-06  207  	if (!priv->rx_skbuff)
1efb597d8bf56c Zhao Qiang       2016-07-15  208  		goto free_ucc_pram;
c19b6d246a3562 Zhao Qiang       2016-06-06  209  
6396bb221514d2 Kees Cook        2018-06-12  210  	priv->tx_skbuff = kcalloc(priv->tx_ring_size,
6396bb221514d2 Kees Cook        2018-06-12  211  				  sizeof(*priv->tx_skbuff),
c19b6d246a3562 Zhao Qiang       2016-06-06  212  				  GFP_KERNEL);
c19b6d246a3562 Zhao Qiang       2016-06-06  213  	if (!priv->tx_skbuff)
1efb597d8bf56c Zhao Qiang       2016-07-15  214  		goto free_rx_skbuff;
c19b6d246a3562 Zhao Qiang       2016-06-06  215  
c19b6d246a3562 Zhao Qiang       2016-06-06  216  	priv->skb_curtx = 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  217  	priv->skb_dirtytx = 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  218  	priv->curtx_bd = priv->tx_bd_base;
c19b6d246a3562 Zhao Qiang       2016-06-06  219  	priv->dirty_tx = priv->tx_bd_base;
c19b6d246a3562 Zhao Qiang       2016-06-06  220  	priv->currx_bd = priv->rx_bd_base;
c19b6d246a3562 Zhao Qiang       2016-06-06  221  	priv->currx_bdnum = 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  222  
c19b6d246a3562 Zhao Qiang       2016-06-06  223  	/* init parameter base */
c19b6d246a3562 Zhao Qiang       2016-06-06  224  	cecr_subblock = ucc_fast_get_qe_cr_subblock(uf_info->ucc_num);
c19b6d246a3562 Zhao Qiang       2016-06-06  225  	ret = qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, cecr_subblock,
c19b6d246a3562 Zhao Qiang       2016-06-06  226  			   QE_CR_PROTOCOL_UNSPECIFIED, priv->ucc_pram_offset);
c19b6d246a3562 Zhao Qiang       2016-06-06  227  
c19b6d246a3562 Zhao Qiang       2016-06-06  228  	priv->ucc_pram = (struct ucc_hdlc_param __iomem *)
c19b6d246a3562 Zhao Qiang       2016-06-06  229  					qe_muram_addr(priv->ucc_pram_offset);
c19b6d246a3562 Zhao Qiang       2016-06-06  230  
c19b6d246a3562 Zhao Qiang       2016-06-06  231  	/* Zero out parameter ram */
c19b6d246a3562 Zhao Qiang       2016-06-06  232  	memset_io(priv->ucc_pram, 0, sizeof(struct ucc_hdlc_param));
c19b6d246a3562 Zhao Qiang       2016-06-06  233  
c19b6d246a3562 Zhao Qiang       2016-06-06  234  	/* Alloc riptr, tiptr */
c19b6d246a3562 Zhao Qiang       2016-06-06  235  	riptr = qe_muram_alloc(32, 32);
be2e9415f8b366 Rasmus Villemoes 2019-11-28  236  	if (riptr < 0) {
c19b6d246a3562 Zhao Qiang       2016-06-06  237  		dev_err(priv->dev, "Cannot allocate MURAM mem for Receive internal temp data pointer\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  238  		ret = -ENOMEM;
1efb597d8bf56c Zhao Qiang       2016-07-15  239  		goto free_tx_skbuff;
c19b6d246a3562 Zhao Qiang       2016-06-06  240  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  241  
c19b6d246a3562 Zhao Qiang       2016-06-06  242  	tiptr = qe_muram_alloc(32, 32);
be2e9415f8b366 Rasmus Villemoes 2019-11-28  243  	if (tiptr < 0) {
c19b6d246a3562 Zhao Qiang       2016-06-06  244  		dev_err(priv->dev, "Cannot allocate MURAM mem for Transmit internal temp data pointer\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  245  		ret = -ENOMEM;
1efb597d8bf56c Zhao Qiang       2016-07-15  246  		goto free_riptr;
c19b6d246a3562 Zhao Qiang       2016-06-06  247  	}
148587a59f6b85 Rasmus Villemoes 2019-11-28  248  	if (riptr != (u16)riptr || tiptr != (u16)tiptr) {
148587a59f6b85 Rasmus Villemoes 2019-11-28  249  		dev_err(priv->dev, "MURAM allocation out of addressable range\n");
148587a59f6b85 Rasmus Villemoes 2019-11-28  250  		ret = -ENOMEM;
148587a59f6b85 Rasmus Villemoes 2019-11-28  251  		goto free_tiptr;
148587a59f6b85 Rasmus Villemoes 2019-11-28  252  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  253  
c19b6d246a3562 Zhao Qiang       2016-06-06  254  	/* Set RIPTR, TIPTR */
c19b6d246a3562 Zhao Qiang       2016-06-06  255  	iowrite16be(riptr, &priv->ucc_pram->riptr);
c19b6d246a3562 Zhao Qiang       2016-06-06  256  	iowrite16be(tiptr, &priv->ucc_pram->tiptr);
c19b6d246a3562 Zhao Qiang       2016-06-06  257  
c19b6d246a3562 Zhao Qiang       2016-06-06  258  	/* Set MRBLR */
c19b6d246a3562 Zhao Qiang       2016-06-06  259  	iowrite16be(MAX_RX_BUF_LENGTH, &priv->ucc_pram->mrblr);
c19b6d246a3562 Zhao Qiang       2016-06-06  260  
c19b6d246a3562 Zhao Qiang       2016-06-06  261  	/* Set RBASE, TBASE */
c19b6d246a3562 Zhao Qiang       2016-06-06  262  	iowrite32be(priv->dma_rx_bd, &priv->ucc_pram->rbase);
c19b6d246a3562 Zhao Qiang       2016-06-06  263  	iowrite32be(priv->dma_tx_bd, &priv->ucc_pram->tbase);
c19b6d246a3562 Zhao Qiang       2016-06-06  264  
c19b6d246a3562 Zhao Qiang       2016-06-06  265  	/* Set RSTATE, TSTATE */
c19b6d246a3562 Zhao Qiang       2016-06-06  266  	iowrite32be(BMR_GBL | BMR_BIG_ENDIAN, &priv->ucc_pram->rstate);
c19b6d246a3562 Zhao Qiang       2016-06-06  267  	iowrite32be(BMR_GBL | BMR_BIG_ENDIAN, &priv->ucc_pram->tstate);
c19b6d246a3562 Zhao Qiang       2016-06-06  268  
c19b6d246a3562 Zhao Qiang       2016-06-06  269  	/* Set C_MASK, C_PRES for 16bit CRC */
c19b6d246a3562 Zhao Qiang       2016-06-06  270  	iowrite32be(CRC_16BIT_MASK, &priv->ucc_pram->c_mask);
c19b6d246a3562 Zhao Qiang       2016-06-06  271  	iowrite32be(CRC_16BIT_PRES, &priv->ucc_pram->c_pres);
c19b6d246a3562 Zhao Qiang       2016-06-06  272  
c19b6d246a3562 Zhao Qiang       2016-06-06  273  	iowrite16be(MAX_FRAME_LENGTH, &priv->ucc_pram->mflr);
c19b6d246a3562 Zhao Qiang       2016-06-06  274  	iowrite16be(DEFAULT_RFTHR, &priv->ucc_pram->rfthr);
c19b6d246a3562 Zhao Qiang       2016-06-06  275  	iowrite16be(DEFAULT_RFTHR, &priv->ucc_pram->rfcnt);
045f77baf6b429 David Gounaris   2018-09-03  276  	iowrite16be(priv->hmask, &priv->ucc_pram->hmask);
c19b6d246a3562 Zhao Qiang       2016-06-06  277  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr1);
c19b6d246a3562 Zhao Qiang       2016-06-06  278  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr2);
c19b6d246a3562 Zhao Qiang       2016-06-06  279  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr3);
c19b6d246a3562 Zhao Qiang       2016-06-06  280  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr4);
c19b6d246a3562 Zhao Qiang       2016-06-06  281  
c19b6d246a3562 Zhao Qiang       2016-06-06  282  	/* Get BD buffer */
750afb08ca7131 Luis Chamberlain 2019-01-04  283  	bd_buffer = dma_alloc_coherent(priv->dev,
750afb08ca7131 Luis Chamberlain 2019-01-04  284  				       (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
c19b6d246a3562 Zhao Qiang       2016-06-06  285  				       &bd_dma_addr, GFP_KERNEL);
c19b6d246a3562 Zhao Qiang       2016-06-06  286  
c19b6d246a3562 Zhao Qiang       2016-06-06  287  	if (!bd_buffer) {
c19b6d246a3562 Zhao Qiang       2016-06-06  288  		dev_err(priv->dev, "Could not allocate buffer descriptors\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  289  		ret = -ENOMEM;
1efb597d8bf56c Zhao Qiang       2016-07-15  290  		goto free_tiptr;
c19b6d246a3562 Zhao Qiang       2016-06-06  291  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  292  
c19b6d246a3562 Zhao Qiang       2016-06-06  293  	priv->rx_buffer = bd_buffer;
c19b6d246a3562 Zhao Qiang       2016-06-06  294  	priv->tx_buffer = bd_buffer + RX_BD_RING_LEN * MAX_RX_BUF_LENGTH;
c19b6d246a3562 Zhao Qiang       2016-06-06  295  
c19b6d246a3562 Zhao Qiang       2016-06-06  296  	priv->dma_rx_addr = bd_dma_addr;
c19b6d246a3562 Zhao Qiang       2016-06-06  297  	priv->dma_tx_addr = bd_dma_addr + RX_BD_RING_LEN * MAX_RX_BUF_LENGTH;
c19b6d246a3562 Zhao Qiang       2016-06-06  298  
c19b6d246a3562 Zhao Qiang       2016-06-06  299  	for (i = 0; i < RX_BD_RING_LEN; i++) {
c19b6d246a3562 Zhao Qiang       2016-06-06  300  		if (i < (RX_BD_RING_LEN - 1))
c19b6d246a3562 Zhao Qiang       2016-06-06  301  			bd_status = R_E_S | R_I_S;
c19b6d246a3562 Zhao Qiang       2016-06-06  302  		else
c19b6d246a3562 Zhao Qiang       2016-06-06  303  			bd_status = R_E_S | R_I_S | R_W_S;
c19b6d246a3562 Zhao Qiang       2016-06-06  304  
c19b6d246a3562 Zhao Qiang       2016-06-06 @305  		iowrite16be(bd_status, &priv->rx_bd_base[i].status);
c19b6d246a3562 Zhao Qiang       2016-06-06 @306  		iowrite32be(priv->dma_rx_addr + i * MAX_RX_BUF_LENGTH,
c19b6d246a3562 Zhao Qiang       2016-06-06  307  			    &priv->rx_bd_base[i].buf);
c19b6d246a3562 Zhao Qiang       2016-06-06  308  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  309  
c19b6d246a3562 Zhao Qiang       2016-06-06  310  	for (i = 0; i < TX_BD_RING_LEN; i++) {
c19b6d246a3562 Zhao Qiang       2016-06-06  311  		if (i < (TX_BD_RING_LEN - 1))
c19b6d246a3562 Zhao Qiang       2016-06-06  312  			bd_status =  T_I_S | T_TC_S;
c19b6d246a3562 Zhao Qiang       2016-06-06  313  		else
c19b6d246a3562 Zhao Qiang       2016-06-06  314  			bd_status =  T_I_S | T_TC_S | T_W_S;
c19b6d246a3562 Zhao Qiang       2016-06-06  315  
c19b6d246a3562 Zhao Qiang       2016-06-06  316  		iowrite16be(bd_status, &priv->tx_bd_base[i].status);
c19b6d246a3562 Zhao Qiang       2016-06-06  317  		iowrite32be(priv->dma_tx_addr + i * MAX_RX_BUF_LENGTH,
c19b6d246a3562 Zhao Qiang       2016-06-06  318  			    &priv->tx_bd_base[i].buf);
c19b6d246a3562 Zhao Qiang       2016-06-06  319  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  320  
c19b6d246a3562 Zhao Qiang       2016-06-06  321  	return 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  322  
1efb597d8bf56c Zhao Qiang       2016-07-15  323  free_tiptr:
c19b6d246a3562 Zhao Qiang       2016-06-06  324  	qe_muram_free(tiptr);
1efb597d8bf56c Zhao Qiang       2016-07-15  325  free_riptr:
c19b6d246a3562 Zhao Qiang       2016-06-06  326  	qe_muram_free(riptr);
1efb597d8bf56c Zhao Qiang       2016-07-15  327  free_tx_skbuff:
c19b6d246a3562 Zhao Qiang       2016-06-06  328  	kfree(priv->tx_skbuff);
1efb597d8bf56c Zhao Qiang       2016-07-15  329  free_rx_skbuff:
c19b6d246a3562 Zhao Qiang       2016-06-06  330  	kfree(priv->rx_skbuff);
1efb597d8bf56c Zhao Qiang       2016-07-15  331  free_ucc_pram:
c19b6d246a3562 Zhao Qiang       2016-06-06  332  	qe_muram_free(priv->ucc_pram_offset);
1efb597d8bf56c Zhao Qiang       2016-07-15  333  free_tx_bd:
c19b6d246a3562 Zhao Qiang       2016-06-06  334  	dma_free_coherent(priv->dev,
5b8aad93c52bdd Holger Brunck    2017-05-17  335  			  TX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a3562 Zhao Qiang       2016-06-06  336  			  priv->tx_bd_base, priv->dma_tx_bd);
1efb597d8bf56c Zhao Qiang       2016-07-15  337  free_rx_bd:
c19b6d246a3562 Zhao Qiang       2016-06-06  338  	dma_free_coherent(priv->dev,
5b8aad93c52bdd Holger Brunck    2017-05-17  339  			  RX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a3562 Zhao Qiang       2016-06-06  340  			  priv->rx_bd_base, priv->dma_rx_bd);
1efb597d8bf56c Zhao Qiang       2016-07-15  341  free_uccf:
c19b6d246a3562 Zhao Qiang       2016-06-06  342  	ucc_fast_free(priv->uccf);
c19b6d246a3562 Zhao Qiang       2016-06-06  343  
c19b6d246a3562 Zhao Qiang       2016-06-06  344  	return ret;
c19b6d246a3562 Zhao Qiang       2016-06-06  345  }
c19b6d246a3562 Zhao Qiang       2016-06-06  346  
c19b6d246a3562 Zhao Qiang       2016-06-06  347  static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
c19b6d246a3562 Zhao Qiang       2016-06-06  348  {
c19b6d246a3562 Zhao Qiang       2016-06-06  349  	hdlc_device *hdlc = dev_to_hdlc(dev);
c19b6d246a3562 Zhao Qiang       2016-06-06  350  	struct ucc_hdlc_private *priv = (struct ucc_hdlc_private *)hdlc->priv;
c19b6d246a3562 Zhao Qiang       2016-06-06  351  	struct qe_bd __iomem *bd;
c19b6d246a3562 Zhao Qiang       2016-06-06  352  	u16 bd_status;
c19b6d246a3562 Zhao Qiang       2016-06-06  353  	unsigned long flags;
c19b6d246a3562 Zhao Qiang       2016-06-06  354  	u16 *proto_head;
c19b6d246a3562 Zhao Qiang       2016-06-06  355  
c19b6d246a3562 Zhao Qiang       2016-06-06  356  	switch (dev->type) {
c19b6d246a3562 Zhao Qiang       2016-06-06  357  	case ARPHRD_RAWHDLC:
c19b6d246a3562 Zhao Qiang       2016-06-06  358  		if (skb_headroom(skb) < HDLC_HEAD_LEN) {
c19b6d246a3562 Zhao Qiang       2016-06-06  359  			dev->stats.tx_dropped++;
c19b6d246a3562 Zhao Qiang       2016-06-06  360  			dev_kfree_skb(skb);
c19b6d246a3562 Zhao Qiang       2016-06-06  361  			netdev_err(dev, "No enough space for hdlc head\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  362  			return -ENOMEM;
c19b6d246a3562 Zhao Qiang       2016-06-06  363  		}
c19b6d246a3562 Zhao Qiang       2016-06-06  364  
c19b6d246a3562 Zhao Qiang       2016-06-06  365  		skb_push(skb, HDLC_HEAD_LEN);
c19b6d246a3562 Zhao Qiang       2016-06-06  366  
c19b6d246a3562 Zhao Qiang       2016-06-06  367  		proto_head = (u16 *)skb->data;
c19b6d246a3562 Zhao Qiang       2016-06-06 @368  		*proto_head = htons(DEFAULT_HDLC_HEAD);
c19b6d246a3562 Zhao Qiang       2016-06-06  369  
c19b6d246a3562 Zhao Qiang       2016-06-06  370  		dev->stats.tx_bytes += skb->len;
c19b6d246a3562 Zhao Qiang       2016-06-06  371  		break;
c19b6d246a3562 Zhao Qiang       2016-06-06  372  
c19b6d246a3562 Zhao Qiang       2016-06-06  373  	case ARPHRD_PPP:
c19b6d246a3562 Zhao Qiang       2016-06-06  374  		proto_head = (u16 *)skb->data;
c19b6d246a3562 Zhao Qiang       2016-06-06  375  		if (*proto_head != htons(DEFAULT_PPP_HEAD)) {
c19b6d246a3562 Zhao Qiang       2016-06-06  376  			dev->stats.tx_dropped++;
c19b6d246a3562 Zhao Qiang       2016-06-06  377  			dev_kfree_skb(skb);
c19b6d246a3562 Zhao Qiang       2016-06-06  378  			netdev_err(dev, "Wrong ppp header\n");
c19b6d246a3562 Zhao Qiang       2016-06-06  379  			return -ENOMEM;
c19b6d246a3562 Zhao Qiang       2016-06-06  380  		}
c19b6d246a3562 Zhao Qiang       2016-06-06  381  
c19b6d246a3562 Zhao Qiang       2016-06-06  382  		dev->stats.tx_bytes += skb->len;
c19b6d246a3562 Zhao Qiang       2016-06-06  383  		break;
c19b6d246a3562 Zhao Qiang       2016-06-06  384  
8978ca7c8b7b07 David Gounaris   2018-09-03  385  	case ARPHRD_ETHER:
8978ca7c8b7b07 David Gounaris   2018-09-03  386  		dev->stats.tx_bytes += skb->len;
8978ca7c8b7b07 David Gounaris   2018-09-03  387  		break;
8978ca7c8b7b07 David Gounaris   2018-09-03  388  
c19b6d246a3562 Zhao Qiang       2016-06-06  389  	default:
c19b6d246a3562 Zhao Qiang       2016-06-06  390  		dev->stats.tx_dropped++;
c19b6d246a3562 Zhao Qiang       2016-06-06  391  		dev_kfree_skb(skb);
c19b6d246a3562 Zhao Qiang       2016-06-06  392  		return -ENOMEM;
c19b6d246a3562 Zhao Qiang       2016-06-06  393  	}
2e7ad56aa54778 Mathias Thore    2018-11-07  394  	netdev_sent_queue(dev, skb->len);
c19b6d246a3562 Zhao Qiang       2016-06-06  395  	spin_lock_irqsave(&priv->lock, flags);
c19b6d246a3562 Zhao Qiang       2016-06-06  396  
c19b6d246a3562 Zhao Qiang       2016-06-06  397  	/* Start from the next BD that should be filled */
c19b6d246a3562 Zhao Qiang       2016-06-06 @398  	bd = priv->curtx_bd;
c19b6d246a3562 Zhao Qiang       2016-06-06  399  	bd_status = ioread16be(&bd->status);
c19b6d246a3562 Zhao Qiang       2016-06-06  400  	/* Save the skb pointer so we can free it later */
c19b6d246a3562 Zhao Qiang       2016-06-06  401  	priv->tx_skbuff[priv->skb_curtx] = skb;
c19b6d246a3562 Zhao Qiang       2016-06-06  402  
c19b6d246a3562 Zhao Qiang       2016-06-06  403  	/* Update the current skb pointer (wrapping if this was the last) */
c19b6d246a3562 Zhao Qiang       2016-06-06  404  	priv->skb_curtx =
c19b6d246a3562 Zhao Qiang       2016-06-06  405  	    (priv->skb_curtx + 1) & TX_RING_MOD_MASK(TX_BD_RING_LEN);
c19b6d246a3562 Zhao Qiang       2016-06-06  406  
c19b6d246a3562 Zhao Qiang       2016-06-06  407  	/* copy skb data to tx buffer for sdma processing */
c19b6d246a3562 Zhao Qiang       2016-06-06  408  	memcpy(priv->tx_buffer + (be32_to_cpu(bd->buf) - priv->dma_tx_addr),
c19b6d246a3562 Zhao Qiang       2016-06-06  409  	       skb->data, skb->len);
c19b6d246a3562 Zhao Qiang       2016-06-06  410  
c19b6d246a3562 Zhao Qiang       2016-06-06  411  	/* set bd status and length */
c19b6d246a3562 Zhao Qiang       2016-06-06  412  	bd_status = (bd_status & T_W_S) | T_R_S | T_I_S | T_L_S | T_TC_S;
c19b6d246a3562 Zhao Qiang       2016-06-06  413  
c19b6d246a3562 Zhao Qiang       2016-06-06  414  	iowrite16be(skb->len, &bd->length);
02bb56ddc67116 Zhao Qiang       2017-03-14  415  	iowrite16be(bd_status, &bd->status);
c19b6d246a3562 Zhao Qiang       2016-06-06  416  
c19b6d246a3562 Zhao Qiang       2016-06-06  417  	/* Move to next BD in the ring */
c19b6d246a3562 Zhao Qiang       2016-06-06  418  	if (!(bd_status & T_W_S))
c19b6d246a3562 Zhao Qiang       2016-06-06  419  		bd += 1;
c19b6d246a3562 Zhao Qiang       2016-06-06  420  	else
c19b6d246a3562 Zhao Qiang       2016-06-06 @421  		bd = priv->tx_bd_base;
c19b6d246a3562 Zhao Qiang       2016-06-06  422  
c19b6d246a3562 Zhao Qiang       2016-06-06  423  	if (bd == priv->dirty_tx) {
c19b6d246a3562 Zhao Qiang       2016-06-06  424  		if (!netif_queue_stopped(dev))
c19b6d246a3562 Zhao Qiang       2016-06-06  425  			netif_stop_queue(dev);
c19b6d246a3562 Zhao Qiang       2016-06-06  426  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  427  
c19b6d246a3562 Zhao Qiang       2016-06-06  428  	priv->curtx_bd = bd;
c19b6d246a3562 Zhao Qiang       2016-06-06  429  
c19b6d246a3562 Zhao Qiang       2016-06-06  430  	spin_unlock_irqrestore(&priv->lock, flags);
c19b6d246a3562 Zhao Qiang       2016-06-06  431  
c19b6d246a3562 Zhao Qiang       2016-06-06  432  	return NETDEV_TX_OK;
c19b6d246a3562 Zhao Qiang       2016-06-06  433  }
c19b6d246a3562 Zhao Qiang       2016-06-06  434  
ba59d5705825fb Mathias Thore    2018-10-22  435  static int hdlc_tx_restart(struct ucc_hdlc_private *priv)
ba59d5705825fb Mathias Thore    2018-10-22  436  {
ba59d5705825fb Mathias Thore    2018-10-22  437  	u32 cecr_subblock;
ba59d5705825fb Mathias Thore    2018-10-22  438  
ba59d5705825fb Mathias Thore    2018-10-22  439  	cecr_subblock =
ba59d5705825fb Mathias Thore    2018-10-22  440  		ucc_fast_get_qe_cr_subblock(priv->ut_info->uf_info.ucc_num);
ba59d5705825fb Mathias Thore    2018-10-22  441  
ba59d5705825fb Mathias Thore    2018-10-22  442  	qe_issue_cmd(QE_RESTART_TX, cecr_subblock,
ba59d5705825fb Mathias Thore    2018-10-22  443  		     QE_CR_PROTOCOL_UNSPECIFIED, 0);
ba59d5705825fb Mathias Thore    2018-10-22  444  	return 0;
ba59d5705825fb Mathias Thore    2018-10-22  445  }
ba59d5705825fb Mathias Thore    2018-10-22  446  
c19b6d246a3562 Zhao Qiang       2016-06-06  447  static int hdlc_tx_done(struct ucc_hdlc_private *priv)
c19b6d246a3562 Zhao Qiang       2016-06-06  448  {
c19b6d246a3562 Zhao Qiang       2016-06-06  449  	/* Start from the next BD that should be filled */
c19b6d246a3562 Zhao Qiang       2016-06-06  450  	struct net_device *dev = priv->ndev;
2e7ad56aa54778 Mathias Thore    2018-11-07  451  	unsigned int bytes_sent = 0;
2e7ad56aa54778 Mathias Thore    2018-11-07  452  	int howmany = 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  453  	struct qe_bd *bd;		/* BD pointer */
c19b6d246a3562 Zhao Qiang       2016-06-06  454  	u16 bd_status;
ba59d5705825fb Mathias Thore    2018-10-22  455  	int tx_restart = 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  456  
c19b6d246a3562 Zhao Qiang       2016-06-06  457  	bd = priv->dirty_tx;
c19b6d246a3562 Zhao Qiang       2016-06-06 @458  	bd_status = ioread16be(&bd->status);
c19b6d246a3562 Zhao Qiang       2016-06-06  459  
c19b6d246a3562 Zhao Qiang       2016-06-06  460  	/* Normal processing. */
c19b6d246a3562 Zhao Qiang       2016-06-06  461  	while ((bd_status & T_R_S) == 0) {
c19b6d246a3562 Zhao Qiang       2016-06-06  462  		struct sk_buff *skb;
c19b6d246a3562 Zhao Qiang       2016-06-06  463  
ba59d5705825fb Mathias Thore    2018-10-22  464  		if (bd_status & T_UN_S) { /* Underrun */
ba59d5705825fb Mathias Thore    2018-10-22  465  			dev->stats.tx_fifo_errors++;
ba59d5705825fb Mathias Thore    2018-10-22  466  			tx_restart = 1;
ba59d5705825fb Mathias Thore    2018-10-22  467  		}
ba59d5705825fb Mathias Thore    2018-10-22  468  		if (bd_status & T_CT_S) { /* Carrier lost */
ba59d5705825fb Mathias Thore    2018-10-22  469  			dev->stats.tx_carrier_errors++;
ba59d5705825fb Mathias Thore    2018-10-22  470  			tx_restart = 1;
ba59d5705825fb Mathias Thore    2018-10-22  471  		}
ba59d5705825fb Mathias Thore    2018-10-22  472  
c19b6d246a3562 Zhao Qiang       2016-06-06  473  		/* BD contains already transmitted buffer.   */
c19b6d246a3562 Zhao Qiang       2016-06-06  474  		/* Handle the transmitted buffer and release */
c19b6d246a3562 Zhao Qiang       2016-06-06  475  		/* the BD to be used with the current frame  */
c19b6d246a3562 Zhao Qiang       2016-06-06  476  
c19b6d246a3562 Zhao Qiang       2016-06-06  477  		skb = priv->tx_skbuff[priv->skb_dirtytx];
c19b6d246a3562 Zhao Qiang       2016-06-06  478  		if (!skb)
c19b6d246a3562 Zhao Qiang       2016-06-06  479  			break;
2e7ad56aa54778 Mathias Thore    2018-11-07  480  		howmany++;
2e7ad56aa54778 Mathias Thore    2018-11-07  481  		bytes_sent += skb->len;
c19b6d246a3562 Zhao Qiang       2016-06-06  482  		dev->stats.tx_packets++;
c19b6d246a3562 Zhao Qiang       2016-06-06  483  		memset(priv->tx_buffer +
c19b6d246a3562 Zhao Qiang       2016-06-06  484  		       (be32_to_cpu(bd->buf) - priv->dma_tx_addr),
c19b6d246a3562 Zhao Qiang       2016-06-06  485  		       0, skb->len);
7c3850adbcccc2 Yang Wei         2019-02-06  486  		dev_consume_skb_irq(skb);
c19b6d246a3562 Zhao Qiang       2016-06-06  487  
c19b6d246a3562 Zhao Qiang       2016-06-06  488  		priv->tx_skbuff[priv->skb_dirtytx] = NULL;
c19b6d246a3562 Zhao Qiang       2016-06-06  489  		priv->skb_dirtytx =
c19b6d246a3562 Zhao Qiang       2016-06-06  490  		    (priv->skb_dirtytx +
c19b6d246a3562 Zhao Qiang       2016-06-06  491  		     1) & TX_RING_MOD_MASK(TX_BD_RING_LEN);
c19b6d246a3562 Zhao Qiang       2016-06-06  492  
c19b6d246a3562 Zhao Qiang       2016-06-06  493  		/* We freed a buffer, so now we can restart transmission */
c19b6d246a3562 Zhao Qiang       2016-06-06  494  		if (netif_queue_stopped(dev))
c19b6d246a3562 Zhao Qiang       2016-06-06  495  			netif_wake_queue(dev);
c19b6d246a3562 Zhao Qiang       2016-06-06  496  
c19b6d246a3562 Zhao Qiang       2016-06-06  497  		/* Advance the confirmation BD pointer */
c19b6d246a3562 Zhao Qiang       2016-06-06  498  		if (!(bd_status & T_W_S))
c19b6d246a3562 Zhao Qiang       2016-06-06  499  			bd += 1;
c19b6d246a3562 Zhao Qiang       2016-06-06  500  		else
c19b6d246a3562 Zhao Qiang       2016-06-06  501  			bd = priv->tx_bd_base;
c19b6d246a3562 Zhao Qiang       2016-06-06  502  		bd_status = ioread16be(&bd->status);
c19b6d246a3562 Zhao Qiang       2016-06-06  503  	}
c19b6d246a3562 Zhao Qiang       2016-06-06  504  	priv->dirty_tx = bd;
c19b6d246a3562 Zhao Qiang       2016-06-06  505  
ba59d5705825fb Mathias Thore    2018-10-22  506  	if (tx_restart)
ba59d5705825fb Mathias Thore    2018-10-22  507  		hdlc_tx_restart(priv);
ba59d5705825fb Mathias Thore    2018-10-22  508  
2e7ad56aa54778 Mathias Thore    2018-11-07  509  	netdev_completed_queue(dev, howmany, bytes_sent);
c19b6d246a3562 Zhao Qiang       2016-06-06  510  	return 0;
c19b6d246a3562 Zhao Qiang       2016-06-06  511  }
c19b6d246a3562 Zhao Qiang       2016-06-06  512  

:::::: The code at line 305 was first introduced by commit
:::::: c19b6d246a35627c3a69b2fa6bdece212b48214b drivers/net: support hdlc function for QE-UCC

:::::: TO: Zhao Qiang <qiang.zhao@nxp.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--qDbXVdCdHGoSgWSk
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICMDuAl8AAy5jb25maWcAnDxdc9u2su/9FZr0pZ0zydGXHefe8QMEghQqkmAAULL9wlFt
JfXUsXNku23+/d0F+AGQoJJzO+d06t0FuFgsFvsF/fzTzxPy+vL0Zf9yf7t/ePg2+Xx4PBz3
L4e7yaf7h8P/TiIxyYWesIjrd0Cc3j++/vPv/fHL+XJy9u7s3fTt8XY22RyOj4eHCX16/HT/
+RWG3z89/vTzT/C/nwH45SvMdPyfyX5/vP3jfPn2Aed4+/n2dvJLQumvkw/vFu+mQEtFHvOk
orTiqgLM5bcGBH9UWyYVF/nlh+liOm1pU5InLWrqTLEmqiIqqxKhRTeRg+B5ynM2QO2IzKuM
XK9YVeY855qTlN+wyCOMuCKrlP0IsciVliXVQqoOyuXHaifkpoOsSp5GmmesYlfazK2E1B1e
ryUjETAdC/hXpYnCwUbAidmxh8nz4eX1aydGZKdi+bYiMqlSnnF9uZjjfjSMZQWHz2im9OT+
efL49IIzNKNTQUnayPXNmxC4IqUrWrOCSpFUO/QRi0mZ6motlM5Jxi7f/PL49Hj49U3HiLpW
W17QAA+FUPyqyj6WrHT2yYXiYKpTQHbrkkKpKmOZkNcV0ZrQdWDqUrGUr9xxpAQND1CuyZaB
COnaUuAHSZo2soeNnDy//v787fnl8KWTfcJyJjk1+1xIsXLYd1FqLXbjmCplW5aG8SyOGdUc
WYtj0EC1CdNlPJFE4x5+6xYkI0CpSu0qyRTLo/BQuuaFr7GRyAjPQ7BqzZlEIV0P58oUR8pR
RHBagxNZVrp85xHoa/1Bb0YcEQtJWVSfE54nHVYVRCpWj2j3211qxFZlEit393+eHB7vJk+f
ejsclDEoOK/Zk91njc5QODAbJUrgrYqIJkMpmDO/7dSqhzYTgB7kWvWmRmOlOd1UKylIRInS
J0d7ZEZ39f2Xw/E5pL5mWpEz0EJn0lxU6xu0G5lRp1aSACzgayLioUNsR3GQjTvGQuMyTceG
eF/gyRp11QhLhvdpsJrWXkjGskLDrLnHQgPfirTMNZHX/rQ+Vcg61eOpgOGNTGlR/lvvn/+c
vAA7kz2w9vyyf3me7G9vn14fX+4fP/ekDAMqQs0cVmnbL2+51D007muQS1RDo0gdbZBupSK0
R5SBiQTS0LLwZlGauOqGIDgjKbk2g1wmDepqZKpCccdsw4luboP6+ozMTPX+/YDkHCMPYuFK
pMa0uV82myBpOVEBrYYNqwDn8g9/woUL6hviX1lid3gPhLKqPBBOCOJL0+6gOJicgYlSLKGr
lCvtLt/nuTVsG/sfjqnbtOonqAteg9ljro+RCryTY7hKeKwv51MXjvLLyJWDn807vea53sBF
HrPeHLNF374ouoYFGSvTnAB1+8fh7hX8vcmnw/7l9Xh4NuB6mQGsZ9RUWRTg96gqLzNSrQi4
d9Qz5rWXBizO5hc9i9gO7mPHJvPhrXqyvNHO5qOJFGWhXMUBB4OGz5gltqI5RVDwSJ3Cyygj
p/Ax6OMNk6dI1mXCdLoKkxTgA+mTHERsyyk7RQGT9M/+YJlMxqc/Andv6BIAbxFubjBV3T6U
qBjeNoDjCJCwgyctbaPWPOqNzZnuje14WzO6KQToEV474LuHpWDVH91gs5YwzbWKFawSrgtK
tK8SjWVA0+o40ila261x4KWjheZvksFs1qFw3GwZVcmN664BYAWAuWfroiq9GdEpwF3djGHS
GzGOWoYFSCtRwI0EwRB6ZkYLhMzgoLGAAPrUCv7D8d8aH9/1yEsezc77NGDKKSvwTgBrDarj
yLSIuz+swXfUyp/L+HOoP870cI7Qya46P623wTUisLjYeob9AMa6Mg7UmN3+31WeOXconBRn
FWkMd4x0F0nAzUWfqgPFpWZXvT/hKDizFMKlVzzJSRo7Wmf4dAHGnXQBag3G0AuleFhfuKhK
2XNNmiHRlivWSNERC0y9IlJydzc2SHKdqSGk8nzoFmoEg6cMIyaXU1CLEzuHOmBuBHe1re/d
cQZT5LTZi+50KPYxMCmMYlHk3i5Gn/GAVH0/3wCBi2qbAYfmvu8cUzqbLgeuT52IKQ7HT0/H
L/vH28OE/XV4BD+KwAVM0ZMCL7nziYKfNSY5/PH6Gv/BzzQTbjP7Desre2qPaQiiIThxVF+l
xAvNVVqG7zCVilXIb4PxsD0yYc2V7s8GWLw80QWrJBxOkYUmWZdxDPFmQWAaIwAC94BncTTL
TFCH+Scec9oE2k7wIGKehjXeGChzxShXsn4yp1O67HzZfft8ueKO/fLCZENque57dhYFf+ga
tfSUOssIeB053Bwc7tkMQvLZxSkCcnU5H5mh2dV2otkP0MF8s/NWvJrQjZFR49Y5F2GasoSk
lZEeHL8tSUt2Of3n7rC/mzr/OEmrDVzAw4ns/BA8xSlJ1BDfuLme3XWArU1pWFFDsvWOQfQa
is1VmQWgJOUrCY6CDbhcbbqBALYacwob5GIesq4odOvVNpkxiOyL1F2Wyhz3YcNkztIqExED
N8mNYmK4uhiR6TX8XVm73yh7YvOWJmulLhfex1vXvDTpsH4uA4OZaoMWtIILSrsmXJEctJVE
YleJOAaXFTf6E/7T7bW1fcXD/gXNEaz84XBbp6DdrxCKB9TzAS084Sm7GpObKvMr3uOXpAX3
swkGvKLZ/GJxNjYToMFh9eI2C2cy5flwNq4x1RXcbksgaaZ0yALaDb+6zsVwtZvF2ADQN1Bh
SgrWYzBNZpvBPGuu+DhvGYs4aPHmFIUSJxaXbeEWGuM0u+rL8COYkgGLkpH0JA8STp0i4RjA
EoDpwEToOIXyT1wPyYjWaTh4sAQa07NXs+mo9l3nHyHGGiQWNUskGSxYFTIcc9ox6zKP/Igx
gJ4PZi1zXmCCd2zgFhxqCJOGqnaFVm2cn5urEzhYd9YTe31FBs656/vEXdrBgOHWmxyOx/3L
fvL30/HP/RG8k7vnyV/3+8nLH4fJ/gFclcf9y/1fh+fJp+P+ywGpXMuBlyYWawjEeHhnpQxM
EiUQ+/VvXSZhN8usupifL2YffHH4+PeAD4rTJ1tOzz+MfmT2Yfl+fuIji/n0fdgW+WTL+Xw6
+pHl2fvZOAvLxfLUOmfT+fL97GJklz3K5exiupz+COXs/OxsPnbmPMr5xfnF9P13JTCDvVic
vz+xjOX5Yj7/vihnZ8t5Tx6UbDlgGor5fOFvySjhYrYciawHhGfLAGd9svfLMyfE7WEX09ns
bIDVV/NuvKsEaGurmKQbCNW7rZ4u3IWP0ISU3pB+jGLQ9mlLO52en3leu6Bwd4Nv0FlEzMBz
HUr+4NWUcvRQ2k+fz86n04vp/PQqGMRUM/ezcfkbfKLs2II1TGdBs/T/szO+Ji03xnNXQ12c
ndeoE4p/vgzQeBRbYn3tReDQNrjlxfeGXy4+9KONZugwDrEjlhd+8n6FkXAOLkIe0l0gSDle
nDWNpwgm55aFSk0WpTK3ZiVNovNyftZGFrXni3A/E+z8BX6vahLnTjYAY2JkzuSNkaji/Tge
HFSb9LSlG/BAnGkx+9+gTB4A3GkJQSiFm9eJf9ciZZjENk69A77BE+TKAiDzs7DRBNRiOopC
LQ6dm5vLWRc2+Y57nRQA9WqyAb7jgTVWiAfqMGMU3QXkvp+UMqqb2ATDjn6+z4YJcY7Bnit0
CMM7Hut8d9wPL3YEQl5EVkUWYTQh+wxiQsdc6RU2hfQSkG74pArQTDNNoeuyR6eajGJAG6qE
EUmwnuclB2rYqcJdG45dMUfi5k9QHVfMFqZMqcjWYV6/fn06vkzAU5oUzDTzTJ7vPz8a52jy
1+F4/+n+1jTqTO7un/e/PxzunBYcSdS6iko3JrxiORbfpx7ECQyx/m6KSqi1QoIniWF/u9wy
x6C/Diwh5mfpiHYSGJpDbENyExhCHIHNM8HODEPJ0jl4oL0GG2t9lFpFXkpOmHQNpkj7xZ5R
m6d2ldYrOYX9yodGU5MkwRJAFMmKrHjImJkUh7NRpjKxZmnBegxvL5wygadXuwLMRTmsdrb2
cnZWNbnIltA5I0yDHfUwjWf818W72QTbsu5fwJV+xcyTV7bzFrveVSSOVtmJK6gIGnSLS8GA
Ei0yTgP323bNxm7VUzw665iPr8P7UknE8PMFmJ4Ty4LjgH1Z+QkWRz/vsLg4JWpvtlFKfy1g
KUvMUaZ6oPuFYmUk6vpBbzm1LZdcSK6vTftQ2PBIZvKevkW3KVOs1WBePQSv2ZIswVKMX5Ew
BVy8KDHBV0ihzdFFOw7kgRxz7Mlx9QQMPn1FsxVQUEILjnYVV4M5JS2oCCX2aRaZ3r+ugMZi
DhyVK6fMEXuCizIe3HyPodCFgdeOyca6rVg2X/X09+E4+bJ/3H8+fDk8uutqDm6pCq8/qwY0
tV/PSNQo2MrCFCRC11BWqZQxx6g3ED/9B1Asag5pd2TDTEdTGFq3GaIP0V1zLj4Jc+Vdi9lo
SRhQNN14n27SprYrzGFr97EqxA7tYRxzyrH4MHA9huMD4ulTCKeQiH6czz0SJ7UHM5YuWfMV
3IJGFbAWqHjAX6o300F36Y8xtWkakGqKrKVoO3EBx+8eDs49j300XnGygdgqaIENd5Jv7VXl
t98gUSK2VQqXXzA35FFlLC8DX0GUZk4XaaQtAluQTBzU5nAa7ifREWKoo2/XccZ+jxmCC0V5
gxuN2oYzO01JVmKt/OLj4T+vh8fbb5Pn2/2D18+Fi4KD+dFfJkLMMonWEq/iEfSwr65FoyzG
ejgsRePM4EQjpfbvDMKzosAu//gQ9GNMg8bI1g8GiDxiwFYUXKNLCDiYe2sqKz/Oj4n+Ss2D
Bt+VtCOgkb1opTGCb5c+gj+50v9uhaMrazXyU18jJ3ftAXHnswILKxIeFQjrdjzPsZxd5mdT
3o7Jtz3nyBlkkigN4XrnmrHM5qjn0wbvpF7A7/jogL3zFjhhLnpg3Mwy4/vjl7/3R9c4eItT
GKtjhS4mI8cCIvFsB4EhBqEQqYRpdhWN646PsUSWok5NrIFUpnrrJ8cQHIldngoS2Upbrc3j
TegwKKOU+lI2Ji7eufNrBr5ZfqUBHFxHIkQCNrZZ8kCtwPeZ/ML+eTk8Pt9DYNhJl2Nd/9P+
9vBrE1+6gkYnaktkSDSIYsqtrSIEQ+BMgaJjJi7qISWGwxAZ7yQp/FgJsbDy2l/zPl+DQc9X
FQo2eDEhISWFQh/VEvlz45MIL2xkYLbtW4INuHGaJ4NIrFXR/0Z0bWbJMFS4bLQgXJHPXVN9
be5Gffh83EN8X3/HHn53W8wxrPiWBhkeGd6gBwcrnB1Cz9tRy8FfrRuVqD6GUgIS/lhy6TbF
GJRxBBPfz/UQxhKHTBMSqYLKqold/PGMhnr+XQpCB4NWoAHMbxP30KXWbtRtgJoM1mSTRi4o
A6My+Frdph3MfBgCXmT9srR52mQ/i6FHWcDGR8PVe9ix6Y18hlyBrVGpGLlFzHaKXIOjPL4t
az+5YQeVSoMNyJhei5ECphFxEuzTNjjQnhIfgGBWyNhxkafXPUHXWV5/0nVGxk2uUYWC9XV2
BFQla6+1oYUrNw3cgRnPfwvCMSncbICL3RFN15Hw9gXUANsnbbA9Jh3733GfOe61u9iDqqM+
qCi0AzKC2Wwz7Jvx3wi5mLifGK/hlRSl9pqwW+ygsRCBWcZFgDZzzUgLRa8JW3Ku7F2PvaD+
bNs4OJstf6erKk5Lte41EW6dGJBLfY098eYtXp28GFnn6rogSgWQW8NlmZuOZLomeeK4kd3I
ChxIkrh3AiaLS3xf2EvvwaQ+u+gV4IM7H8pzYB+z7INk6RaJsR26D9oqz1ht60lb1bNU9sWd
rdRU2JlFw09p6vYzeV1oMXA5mr43J+11eHt3+ArXUDA1YjPUfv+rzYH3+zA3tuMocDJ+K7MC
wtcV8/t5IdqCvd4wrCywNB55IGn2s0sulDnsTJJjLphSNtz4ftuThUqmg4i4zE2vEtYdhYSt
+43R/is+IPOag7syiWlrWwux6SGjjBjzzJNSlIFWNQXiMMG3fUQ3JDBIbBi2Za7A7QOBlebx
ddOhPiTYMFb0G9tbJLpZtgY0gqw1GPzz4LrtG1n73rbarblm9TMbj1Rl6G7Xj1j7kgczCnco
5tGMt2c3E6xyX9DY3Tu2afjgdnSgl8EykPWuWgHj9r1BD2eacJGnENxUEiyffqmmE4mn4iew
bne0t0xa1u4CphwHu2J10L4VollxRdd9w15D7cPhEVwkymEKzNTs6v5QfOVhH3E2L5IDi6mr
b1gX067ZdChQVClIuof0U9FOTG/fGvUy1f13hD56zFLgucPuBTybm+H9N/LYr0cVeOY3cv5z
rLiyuuqJ6ecQnamIboeHCU5HU7ZlFBubO7zN7CtTDMcHCKg2gbNqUE05IPRpr5W4N4GP63qQ
A6Od/uGxSVySXhuyUbEmhaRFgdG4HZiSa3BTHE1Isb12BVsHrmXkfEvgk3ee1PnahTPCfrbG
k571rrGLObBldjQkI9wZq10ha6jBIOumnip3ziOPE6j+8KZQExgeQjmVeNj4xbypD/l21PYM
KpNJkQwXgaejw2MpwH0PEHrYDBPLJsBNqNi+/X3/fLib/GlrQl+PT5/u/eQrEtVLDkxnsLYb
n1W99zt9XOAEGxKTM9TVsnrvZqxOMdcMx3YTfCMPzhKll28+/+tfbzyJ4q9bWBr3UvaAtSDo
5OvD6+d7v/bVUVb0mhrdStkV12EvzKEGi4+bAP+XogjFtQ4tnmZ7sfqyCxCMZ6BbmTnr6D98
+I4D2LAG5jLDx0yu62Se+Sh8rdL9EkhtsFyma822DQuY/wnKqaYq8z5Fhx+6EEPfoj+fkrT9
+Qxf1waUPPy+tEbjNmPT7Ska7NTZVRlXCu+T9kVlxTOTtQkOLXM4umC0rrOVSMMkYCCyhm6D
D6zC4jEXhXk1nYIvatzF7uEVGoFQia99rA9uJPcfyBH/BxSIyme9o25/0gWuLfyFFHmdioHp
DFBUq/UJou/M8WMT+L9WMUriVxwGZKiKJ5mxBKfZqWlOM9QR1a9fw7TG2x7nqUWPctRRjPLj
kYwLyJCdEpBDcJqd7wmoR3RSQDsJIcgJCXX4UZ4cklGWfJpxIVm6U1JyKb7D0vfk1KcaCAp/
MOk7yt2ll03bUCUzp8JkzL8dDMYUXDfX6Zc7xbIxpGFpBNc6L+b3hSJD1ut4GMf0B8tdeOgA
3vll9jFqU/ToKLqOD1uh+edw+/qCXXu2s888w3xx8iMrnscZdtm57QqNKzxEwR9+LsW8xcKo
smuUA59+8CMT9VyKSu7m2mow3DzUn7KOU7tyycg6zCKzw5en4zen1hfokDnVONp1nYIvUpIQ
pgOZ5ty26cF0APfDIvuRwvxokg59BgI8cHhZCLW1ZcVBe+yAYvhRc1faduMhPiZKV8kgF4Np
lnasc2bsEtqfTvEcFO9hYKi92ra+mrZX21W99DSrF+MEfnqKmuRT1WsgLtbXynZQ6sDL1tYV
cHndqFBButFUI+gMjjdOermcfjj3ZNNalXrFMeFp6ecMfcyIEzQMssOlfHwvZHqLg51ojkcD
fwzLLi0wWKtCLDaZq8v3DeimEMJR9ZtV6aTabhYxhKTu/DfKPu8Ouf912s9UHLFWwKz+dU1x
LGZSsjblZvrcMLsXFITNHiJJkwQZ7ZACS1iYJ7B+diKWBH8sq5emqZvymx8t6oKTsqhWLKfr
jMiQr+l9yqQ6SOrapnHz09kMN0dgrSvA4Fbb4PNGVT/l6KhBOIn0ssNqs0KzwfImYDCWLz+8
4OsQbOYINDvCUduwUE4arlQnWse/6nYEx7sHWMRJ8EW6+7sL8Ef9+y8+TAsHcBW7xWn8C852
Iv6Psy9pjiNX0rzPr6D1oa37UPMyIvceq0OsmRBjYyAyM1KXMJbEqqI9SpSRrO5X/37cgViw
OCI1U2YqKf1zILDD4XC4GyTdlYYg8VOIemQWXQ1ALhqJyY4qed5Iw2EVYBW2ut7E94n2aron
DTlT61qu3fXCT1cLMdnh04iu5I6BXtXoIV+hZws8CMfi4ou8FQUmgaEzSzipqR5fqq4qKvN3
Fx+jyigGksMSlm5XMZChDmrqcYIYlxWrzFZj1QFlgCQ/UW+jJUfXnIrCuD+5FjAXyntG3rnI
ZOeG6Z12ipWsFHpanizC9FnVoyaCwVFrFiTBidfRkdbgEUQxrMySCMSuqSC7JlNU4XZ3GPtf
mUYDFKqa1ZEanWj6BQToS1lSGR0bfUBMAId/zpXueA1VBe5IPyeHgBP04kwQUWQ1zSxGMJv9
/jkpSiLHaxIcCTLLYGktGSc/FEdGXW2WKJ7tqjDUhIxBnIDumBE2hu6ykh1dxRkZsO1nOUQv
3OAoaF87A8MwamaZoOKzeG18xYCHBvz137789dvzl3/TWz6P1y5VFiwEGxKAiYUvrvFOx7F5
49SrmqpfM1NzyRepQbAUynXYPvKKFjeA1bwvGknq1O09Gb894dYMJ5WPpzfL27GV3trsJ6iX
EigoDXIG4has1TMJB0eMTtxwmmszZOVhDi65cjos0NNUUQixTaMKX4KGn8OeDBmB/EB9ArMa
nGYSH+iwxx0QPi3jDgwNplLdwZsKSydH1BBQuXC4yJsfOpdxON3KSNyqWqVp5KsUWKvIZVll
4VFT6TUdENgr4SCWOJohQMPjwAGmTeWs2nHpU55BNB5WR46cVe+ydP4wAEJWctpdn8bJi9xd
zKpqbjY+DwpX83BWOZAmtRvcnqYq2TVaJgb5zG9u3RlZD9kJJEB9ThSB9ZvqXySbhUea2VtI
M+uPNKvmSMSHl3ViFwhfi8HiYhoWAijsBBwyX19Z6dp8POa0QvPzfvfl9dtvz9+fvt59e0Xn
oO/UYto25sKgQtiNPaxuAxMD1w9M2uc/Ht/+ePrQjlha2iaoD7DdDFvNjRqO7LeK1PO5jqcU
Lx6hhUM+RzP0bJluYkmylLPbocI50+r6+CTSFug2kdzHFJ7UsRWpLM7tbGLC013CbxSIGNVk
lckhTnDCJ3+yGUEUyrk18r89fnz5c2bAN+hsKo7r5lq5qi+ZpINLuqySI7J8lM7wZife6Co3
igt2fthUfzJLmA7htUlIcUjjMsyVXFziqeGtAsop+PMlNEUcgqs6zeK4tc8zJGfRE/NM/EYu
SVTcqDx98iUYjwE//kxr2pvZLDfp2d3mI1Q4NkutW8kSPJnfzGeSJcWhOd6oomiGn61hHpD+
7ilG5wraM4hrB80Wm+AqUpfQP7LoUjuB65ddBMeolZureXXf4IL0c7V/OJVNMPvN+ZW750mC
LL/BEWnXMgSLIVMTDBgu4UYejaafdHAIbeWNVkRDq/lD6cQ77h4zLJoZGcFwWkpvYcNjurnT
rKJx1J6syt/S9+fkUqenCoeFVccqi39E8iBygYaPT4nh2tQxU9upIOby7mDDzGnVq8E09y3E
C1LxbpYpcmVCrxkqB3yg/w7dGHPAHOZuXgBZKh+zmmUWLnIN0VnlOXNLqGbVf/2EjiRF5VEd
CBWQ4tgW6HIKDnTtfAHH3/YqEHqJhkxPlYVPKKolpFpFTYPUuTzrBI3vZ7IVxyo4sqL9GTN7
HnBWOU9GkgHKNJ6LTMDUTo0A3mkfdM8Ac00v+iZOou9PHz/RP8AovOOn3aEOQnQbU9bql25l
5Di7hzWLHbekYV9TupF6oUpWAnUnUcTid6v0asMjW4dsvtOfhMq11Jp4IpvPsAawSeuokyGk
KGS6xh1azFXqqU69w5Pj45d/StNWqzpWRfTsjQzUuR7pih/83cXhoSvDT1FBT2/JM2i5xYUO
nlUjVOj+vyXgx8Ajmt/JX2huzwSb8X2rLnOfm97xxtQchCVfvW7BtwbCeS3q2bSLBkTs10sq
indBU1ZBk2s/4FSl7y4DDQMesYjUKSJLpmmzkJJXZaBTwtrf7FYUDbp/XEPGL6O0TPWIKh4d
jKXSnrw9IJ+B4FUY1+U8koAus4TnYltxbDDMJK3qRHeMo3Ic+IVVNOQsUCIR7f5zwPLGdQEx
cNzzz3S2ZZRkZUNjD5GjLNDf+6XuTVOF+afA8xaUN1KVCxZcpoUjO0O23W7hew8UrTuc9d5W
oPxMXhvLPWLKrN8z5DX3RM6ySPvhq4M0yDT1GEY9CaoqSxAgPtn6ipfSLKi05//VsXQIZ0mS
YE3WmkAxUbsi6/8hAoMw1GkE1OlVSWIeFGDdGT+h9Ibw3DFsXA9/Pf31BAvzP/ogSNr7hZ67
i8IHs+ORfCTdfI9oqtrZDVRt/RmI6PTLpooD6INN157kD0SehhSRSN4kDxlVmyZMZ2oThdzO
Co4zRP4BXZ1DbSlABT3mM7eJyAB/J0SjxXVNtNkD/XF+H/aA9f3oWN47Ts0Cf6AaMeqNGq3c
0geJufQVMnVwTwtcUy6z8PFIR28axxObz76/A52ptB6GYGxyO3DHJCq4Kj1w8JSKvDKgsB+m
pTCcVBcvifWf//Xffvz+/Ptr9/vj+8e/9Ze/L4/v76PPTH3iRsZNnyTJ84Cj5og3EStiEZ7H
SipWUceRpGfRfbsY4HDW78k9yQrGZcCWokqWhZ8rmrqxyWlWXqgKzWmfZWNZCuwxP7fSUbAI
7YbrMQ0yJYJj5tuBoVZDgtSEJTb9EBhvoAJ5M+taoBHOWU0sSYjwAF9rOYuOLAXpn2IsJkZm
JnNm9C31AN+HfUoD0OOSjDWoMm5TUUqwqVqwLeV7eRnbdJYSbSxtrShTPlFCV3tAXuI71jDu
AXvB7oFpJipYEw3WmfbyhEuItjZFVPfHBb5k5CVGTJ7yCGFjDtA4+UzRhn86QNVaS6HHgTYG
FIR0BKnguR45Vs1TWh27MccXLfdYFBMqBFxRSkuQ7c8gxNOT9ixlL9V/RU8Zzl+TEMvqhpUj
TmWmc1BnEnE7b+aM08ExCAuumK4duSk5iGqZljFdtsRLR1TXatBD3WjnNvzd8Zx6jyggmDd6
vkXENTem+LsrkxxdoHbyqpMaH3WlNG+dimCx6p1cqwfD7EM54gdxitFm8BNPb+fqaL8aw5Ly
a6cHpgt1SRIDt30i43VjFrhpdMOVlmpQfffx9P5hKFdEqe8bI7SuAsZ1WXUwKpihBLPyNADV
ens6K+d1EItVSPqAffzyz6ePu/rx6/Mrvhz+eP3y+qJ7r2vJyBORuvDCj64OLjohVE/QSDgY
DJ+8vYgDIL8WFHfx038/fyH8ayLz2frguY10j9hI5FlEu/QHTI5sjT0Ksgj1/xj7kbwKQaY0
S1rr64ea+Pr9OUCXGFXEktQRexW4WgzJ1hrl1IvVzaLRdkv7LkeUCedyRUoNb8Tzjii4IIIk
HDT4cNqZd5UE90Tt1Pb/FKBvfzP/JOeYzpFIonnEAjNduvM2ZrgLsr1vFvkWA37dzZO1M8Xv
69wxVbmjAkO7GmiZ6g40FGIXcXVinDjs7oP/Pt2vJmpJUG0hWJytC6j+nYTHSPSNQU1w9m1s
0fMoDGyqaE1J1cp4sgb0cAtoV09PKX2Fy6cgdOR1YukYV21dKsE4j0lM6fhDNFpSVnthw8Q1
wuCLychxIHdJFB9pqUNh4qRMHDaKsCP9jL/89fTx+vrx591XWTPCpyqkOkYsbIyuN/BTQN48
9omj3F8sW62eSK5g4NrU1OhYSY6bjJ6hQ/mWpAQoweyURIHqi0nSz/BHo+X1OTM+jU5MDVFk
8oruar5R9ZfCPl+riveB0ju76rLSCCg24K7bnLq9D2IjxX1EhvZs6iTIpUch9YktC7v6pF3D
XVidZJoJ9yUR1obqU1lB0sP6RekB1YFaKCGpZfSEd1F8qEotF30ynG5JVqL7z0tQF7Ag6eLW
wBYl6G2rDzzalcWJfCI4cPdONkWMX3yPlBzi0C6yeL88+I5BFuEJjfz8qFCZ/ax1jJiKX8eB
HXRzhC/y5DXJ3FLHSl0lDRDaXgwX7a2M4rKY+hKtFv7WfvarmwhZ+evoaKhO75kqe8rfxorU
E1lR6QbAPf1QMeqaCOXJvaFN2Vf9McQiywArmqS6nwkM3+OuCRIFTH0MDr/My01BKwbDfWUb
YKlrg0uqY38NOrH3NLylaZqrszgDGw4446SsXB+TEQOk1sQ6yqsps4tUIlDHcnRaqMfvg8MJ
FEiLPI1HQhltCKOxtrmpKxF4zg3dJTSdbjGOb4jLs+WQLOlPMMOG45K9hWfuPFTfaAl3vsEx
NHKs1CXb/GEHSFCIw0NfHSRCnaPoiZM1JBcaRANe5Vo2gkJpc0ds3vW8zoarxU8x3/CBj4xd
1VCbA1Zd8y7aE4TzNdlgOoaL6j03qkZd1att25yo2YQQ7Me5mRkrz86s4MDtxgL6mI2Y5fdy
iItmCNrymAq0L6/fP95eX16e3ihhCLNMG/i/54g6hgxi6DpR4Uy0H4ruXpOnN2cmVshRNa0R
fHeiEUcEBcx1HYpAMLDsrbr0AVVhNNJHOosR+95q+/gJw3Zd0Ac3doMw2yOcr4tSxRdRE5Gr
85Msb+lXd3JYDDGA3UV2Bf4VRUCx0I3es9oR0VhMM2dI4L7NaduXmQaSLfT49QlD1AP6pAzj
97t3RzNGQZzA0uFqy+HcczPbMWQLPX3GqZV8//rj9fm7WRD0qSucgpKf1xKOWb3/z/PHlz9/
YrLyS6+LbBLaMfx8btM00c8Pth5BUoSjtS5ipKgIOYSn8exVRb98eXz7evfb2/PXP/Tj9hWv
5ukBEm+2/p6E2M5f7OmAsXVQsZg5vBE/f+m347vSdDtzku4LpUX8VHmNDKtvc1RCTIFk0OSV
/kJxoHU5vockjyr42ivTDKJArBKfGSNWhCeWjVYGo8P+l1cYn29TmdOLFexgJAm3HDFkpLoE
ahuQM4aPKBWZUimh7KhMFRgDrWah9rZi4htc2WnYIKDZkQj6io2CvPTieVb9Cw3Ck/B/R2MG
VekSoe8QQY/IS+ReHVIn3E4mdAwyLYizeXkmt6K8eyh5d38q0PmnodEQOQQYv2vIRziIpobG
lXfHK7TtmXHVHcrgtUV4kz01pUhPw+dTBj+CELbUhiW67NuFqotoOAlqD7nk7475kUXjWlyC
nqi7cR9Sq77D0Dm1iMwphmGqHwMQTMWSLHxbE60xVEs6wC2rMisPV3X4OKa01Pb89d4rKlQP
WnWU8ybsDoyHkK12xIEtFI6njJIfRWyXJGSKag9vYtH1Ta63aR9mJ058i96yrlZVe1LmP6gN
OwRd7137K3OHZ10+dN+kkVGqOK67JRyQDF86KO/Ip9LKkCnUuZk3mpYFfopBa1uCV49vH88i
wOiPx7d37VSDiYJ6iyqYRs96iM03QtqHylTSKRUAZgkrKZkORhV6R7ETT7udVVhRh9M7BhuS
r1LvAmBt3h6/v7/IuKnZ499Wrcqysr6OX2WookEPY+KWz2qrOsj/UZf5P9KXx3fYb/98/qHs
22rrpExvrk9JnETGFEc6zIeOIEcYIyc+d2VlOO0dwKLkF93J04CEsNFc0VPSxREdaWDMHIwG
2yEp86RRXb0jgutCGBT33YXFzbHzZlHfLKeB0wY0BCMV8poqzebGB5f+TIWZRzUroyWTEaYe
HYzgTm+eUrXfHZmKJsk0I4ZxIOQxb2KbDkJHYFMxAJlOrfWTqiCV1Joo5mbYe80bp9zMmJfu
/x5//FDCmYlIxoLr8QusYubEkF6PsUOqXl+qzsDjlWv7l0K0IvSqGDRF3fy6+NduIf6jWLKk
+JUEcFyIYfGrb6wHPUNJ2WKpDKhElE7szBXFcaEmMeddGsJiOHRn9GNPm1WJPODgUwc5uVLe
6hYZffrp5fdf8NjwKN71Q54zFynii3m0XtP3GAjzzCiO1lpyIKrTsolNGvwGuaAJMqkWVr0C
9ihIQrwP/e35u/7w/fz+z1/K779EWEGXjg6/GJfRQXlDEsr3xCDL5b96K5va/LqaWvR2Y2mT
vEgKI7agQsYICRiAQ7hfdTbnwExoWwiusrE2hAHyW9xlDtZY0VaJS4e81p6XVTCy7/5d/u3D
sS+/+yZd7pFbn2DTu/mBFWk5bnNje97OWC/hiQzcjYiQrwdJqqcfQ5CugnyzplbmuFEE4lKz
aATZBSV+RzgZQNMMQ4SqUTaAKH0vktB9GX7SCPG1CHKmFUCsHtrRCmia3F2m+pNC+J3HqrBe
piIAXn1G6UW1jpYAquw1Giq7s+Cqf8EIvAUSkeNFpubvTji7EwcrxZuilC0VU5mJuY87Jy1+
znmi6ckG4xyVLveZ5/cvtvgPuxUcqzCkMV9m54WvXy3Ga3/ddnFVUnWAI2V+7Vt5qvIRzqkO
1VjD0lwcRonMWMT3S5+vFoooBCehrOQnvMvD41+kH0WPcLLKqMsnGayzZAXedEy5CTKaQ+v3
sVXM97uFH+i2zYxn/n6xoDwFSchfKCeZvg0bQNZrAgiP3narWasMiPj8fkF5Hjzm0Wa51mS/
mHubHS1IcXrjGI9PeM2hh99TNW+dOV1HLqmH7nicJuT6yXjUwWFDuXGszlVQ6A9EI9+cBtK7
c1KhIDWpJ4d+F/QuaHztKUtPtkNv6XgetJvdVnlB09P3y6jdEPmB6NLt9scq4VQv9ExJ4i0W
K3X1NQqvVDbcegtrmPcxLP/1+H7Hvr9/vP2Fnlbf797/fHyDvfADj1uYz90L7I13X2GqPv/A
f2oBLlFkJWWV/498qfmv6zmk6h9FwyobVhuM7vlyB4svbDtvT3A+hG9Y3XcuK/2kDwTlh7gK
qKVJ0vSmdybjqQVgH788UKtHEh01O2UxLIMMOsEtQw4j12FyNeGGOcoxAIk36AJGi43qKitl
xIizQdCx2grBThqMT3ISkWBcFMQVaNAE6lXOWLT0xI3giLLXkiS585b71d1/pM9vTxf485/U
pUDK6gRNQcj2GkA8Ol/Jqs9+ZqiAvHbv1/KxqQ03qWZsu7AsYtpwUuxBylR/EJEDda0aS2nD
JWH8nrhEuiBCq39q/a/Eo8Fsqb1j158IoOtX9Rx2bjUY5dGzVsMD+VAVCsET/ckbytWlYRPQ
02zBSPhDyAxfsyKwHfxuaviHqtHWrKobXTsCWHcWXSOiIDqecpyThjRll9bnmvxVZEYYeGGb
njvuxYI6oh894gNgqUDWraiQjEODzg1Ql9fS/iWyObsVNCncGOx7eJR24rDXbLf+mt7CBQN9
okUIJnviLxZ0yyPD0Q3B8CjpKym0jrHbT9CbhtplBcQx7nCmR44f6dcisvI6Ou5SBSjHh30j
/Az72fNvf+FewOUNXaBETbKPT+FaPZqul0LC76tnAKh2oAAQo8IJmBYghJI6dvp6xvfIYQQN
nfr6bEMgK0vioTaMsoY9jM+4tWUJ8bzZrpe0kcHIct7tks1is5gpFSwIdYkBbPH5tvMxusa1
X223P8HSiwt2qVTG3XY/94Zb1qBtrdeBGtgdsjIMMnrajNw8iro0yZjLjTcyPUTB7t6uG7pd
apL7jufMBjnkrLxWn0F1AYrk0A+dA8uZgQCOcR95tF227U0GffcfDAR+cr6Mm2VzRPtHw97r
DGcCEJuWMFIUmV5ebi+j9XZFUXd7bSkHYT+hbVeaa3UsyfjNyreDOKiaRI9MLklCUZky8gSp
ZnBIdAEiabyl5xoXQ6IsiFCbFGne03jGotIRfkxLnF1YQYcD19iaRN/2ggj2E9oOqBfAG+5+
NzlkmwefbzZqrh/t83jneV5n7NjK6RDSknr+vteLPNJkGsiwaw9hQo6mAOQyWO30qOQPDXNs
92rK2vW0eGDAUVwau79jqQhcNuQIuHbPzHN1Dz3E1bKd6lK3nrJ5pEfhUpPjwxWldIP9BQVH
/WVA0dJVjVyjqmGHsliSEGZG1yk8oMeZ2Yc7/MqbJDfP+WrermdsU0NEhivSsHBbAPepehum
22xndqIUJCrPMcm47tGgJ3WN43HQANPtOcL0Bd0En11+IoaSwVlUK5e5ZhBJ0MlboU24Q5Kz
go3LPnWacu0GcWLt9M0pY66H10Oq3kR40l9lPu3Fjp+K2LRitfNL8lOm+xEIE79wuG1T031G
aWQ+bww8hobA2vijdV5oeZDm6tqHlOrB2NuR2B6kJyeVfmBBkQa1zhhXQeBj11BkGQBARria
ygYwrgb0LB/R7kw7tpgY8tjxlFVtndMn1vDTfBMeyvKgt9+BNAxSkqCNJW6wagRo1q6Psd8d
NB+KyAjdYdCqxUpvsyPzlq1npi240QVHPWYpMoCQRU1ChMw1F2j0fFcrdgouCX3kUbjYzl+3
N8QScZGpzX3D9FghL0w+x2mRHWiNCNAdw4W1riS457sRV3YrV8kAcKVxrPJp7i0cvjEP9OT4
lN/cL/KgPiczvjYGNuAJivJGF+KBSO/De77breiNG6G11+WOj+ORareylJZk4YZz2O3SlTzJ
NeNvcZiSbr06p4sCNZNrraeH397C4QQxhdOWw7ZdybIIGizV/Hfhn0ltRPjjvmNBO7eOAukZ
1mVR3h4hxa2SnVmsC7wiEnNMq8iUhOW9cgYF7jIit2QZHQ0WpwMrjIsxOA5At5MVuCZoK5qy
G4eFKik4xrXX1KjlTaHjISsP+s3PQxbAcZXu64fMKaRCnm1SdC74IaGfvatFOaH6P78h8tWx
Vtp6s1i5dClDCqkpUFPtvOXeoU1EqCnp0VjvvA1tya19DjrXERxJZUO/HjfOnjzIQcxSLCg5
LtD9/kllypOE8i+lcpQZHMfhj7br85TuNaCjfXR066QKIoHuOoBHe3+xpB5Eaqm0SQA/944n
OgB5e7dibcgPlsCbPGWE5o7tTQmUN2KVvVGDU6FP46q65on5GmSSmA+O9zYRuh1xKKkLdkOI
49eirPhVuduIL1HXZgfD2/NEddyfKXk2yfHUaNuDpNxIpadgXVTxiwh2xR1+0Rr6wkbJ86yv
yPCzq4+MfEmFGL5OjlhzJRfgC/usHZfk7+6y9hYLgrokqOEJnfn0gTrGUikgKyRMVlfhCwr6
pkMp7syDMo2rdj1sSuOYHlMgYVSuvuRhL5YOcoHQyBsBNwVRuzGWlCg3n7KN9FPBNBlfAqwJ
A3WFGzLu8lNLU7WPTNKLymE+caa50PK/TqgrSp2tj7zcqhcPgkNqKKxSOB5YC4w6FAlAU0ML
ipDncsZyg15GvUJSJcLasmJWSfrXe5RG8HjVHwMLgmLXzy9AUTPMkrhranY44MOPozZ2pa0S
Y3dIt4wpx61Eff4Ss6KTHxgoeWwQev2jQW13u+1+E+pUGBFbvHMwibstQeyi66GAvrXo4qbV
aIZB1adzRywKYqNkvfZGJ8YwQqbU00pc7ZY73zfbUUGbaOd5ZLLVbibZbrMlE232jkQpaxOj
4VlUZWPzTKKkMM5tL8HVkVPGUU/lLTwv0vPL2kYn9Ac1mggnEAMQJzGbJq+rjFJOQOM5yjme
ncy0hfBVEWSOdEGzWyxbM9HDkBORYrihMpL08qErEYiFSs2GyYP3UTqlSbxFq0wpvHiAEcwi
Y2QP11BGKXojsQNMW7/G/1OLRKVaPFZVF/JYD4mDxDhBG1BNnESy7TRfg/OKjNIiIFxwjdWp
qkrNaTASrE+Kx2nOL4qXa8YF+SSb0ZpRnh21XebEw97xmrh/p/d4Q6QRq+PlOQ/aO7SveXl6
f78L314fv/72+P2rYt2pCAno/4P5q8UiN51bjDeHNzMc5RZV63mMM60++BvNoCk1Wg8Z2jqk
WrptQU2pfUYg2jgSFOkue+qeiPmLBXQQ3aBB0dLSYxWBiOY6rKVBbY6HAeFZd4LNtW+NYaHM
VM8U+EsEkxl9r6BXb6GI16aRv8ZhR+uyJqfcc+NFnJqFiRU0YQnLbEGflBU+fK7qYjvnLV4D
UtWWGuHOCHQGGXJm+FVVXINM1eExYaf2/cdfH05TucEFjfrTcFYjaWmKBty6PyOJoOmT4fRF
Alw4SbrPyZdckiUPQGBp7+XzmvHR3AvOEs1nmp6oPPFEc3Wp09HFiyqaGiiH3Qo6qv3VW/ir
eZ7rr9vNzqzWp/IKLM4qJWeyMZKz4dND6RzX2xCZ8j65hqV8Jz8pLHsaiGn0cqowVOv1bvcz
THuiThNLcx8qz71G+gMIFKp1tgZsacD3NguyNnHvL7Xe7Cj7lpEvu6cLg3I9mbF4DIUD1aHj
GhmbKNisvM3cx4Flt/J2xOflaCaALN8t/aUDWFIArGvb5XpPIRGnqFXt+R4B8OIM4sallu6Q
TZTlVHGL5NLo2t+p8qYXFpMB/e+ipSlVSEtZNvVPmcUp40fr+fCUtikvwSWgKgF50sNBHLm6
rA50heRUVlh36Fvkqb653zXlKToCZXZQXLLVYkmP6hanzlxiFHc71SR1QoLK81qqjzQPrdMw
aECY1axVlYVNkc7xJyyTPkHqgkx14DvRw6v+bmwEUD8Nf1eOl70jH+z1QYXiLyXz21wgUhuv
pyam6FqZkQEILhE4inCCYjEmaDaYkNcxSsESPGCpbat8SQwR1cvXhKVlhKeM6EiBQx01gCc1
CzKTKoOb4IdMBMbCeq/akElydA2qwCRiVU0bQx3BPzPtNbKJos8wnjkc+APHY1LB4VLDyEYY
x4GueDFAzYvpuEFjBEXlcDJQugBOj2rA4AlYxhQ1ZgQ1KsM6IOiH1NeuMCagJo8uGt7pnkQm
7MRg18pLegiPbHj4h9F+g4uzOLkwh8Jp5Gpyfb2cPiIu2+aSXoK6ZqpPiBHJg4O41iUgkBOj
pNSdZOhg6IrQMLGh590b1bqwGH4QBfh8TIrjierSgK8XnkcAKARqLmFGpK0CaighGYRoso4C
Q6F7rvhVq0ZkH8kpZ8HGmgIiJKDuG0ZQxPEYGjQKaDlI5WJVk9AmAArXoYnIiGYTxzEoLpr+
WMHuQ/jhKGWVHAJO+grsmeQqCUMuKnM9OpNsAlwppRxPn/3kxsg46cM+ZyvDU6sgGQunoME6
SF9FIpiSrx0F5Mf9OzHjG6nu+rWnUUajEtKljp5GmTpKaL0ejlrHx7evwikS+0d5h8dC7QWr
Fu5C/MT/9+5WJ62MANDJ5H1OX2RIjipCEYHS3wg4Y6GURoxktOKj/6i05NWkmP5j3M8Nj5F9
kjrq5ooRVCGRnRQjyfLJcwWZ48lowkOQJ2brDbSu4HD+IjIZGbIVmS7JT97inrajHJnSfGf6
Ye9VVNQImB4PEnoDqQT78/Ht8QsG7rQePjeNpsI8U/aQp4K1+11XNep9qHx/6iTCXDwVjQgb
rPUAzP8CfSKgo7PaYb5Qfi4dQxOdpjseVaOnKNguC3oBLE5Z5lRUjmcZ+qlPFotnlKemRA9m
ijorOcsX8r0PjLfnxxfijkZWWrzsj9Q7ph7Y+fpT6ZEI+YPIHAVNEtsOfFQ++YjebGUBpShl
UCHQVKbIfEunFSIPHF9VNXsqkLRB7SpPRIufKkueCG/3N8pc1N1JuH5aUWgNQ4/lychCfihp
US3oUC+ojAGvEuiDs8O3u9bePHNVPb7c/FDd+LsdfTfds6FHLML6XLpAeP3+C2YDFDESxXtn
4nlrnxXuAJDZwnNYhxhc9IplDG7hvxhvb5weSfsEvV5hjoXlsy2BnZEZTk90Dl0YUIjKgDdz
/eRYXXo4n4eFa4WD62HkUHWWModD4yGbWZRHUdHSB/eRw9swvnWYmw0dK/fiT01wMMe1g/UW
W3/7VfGbnMZjFhOuK4dvBwnjTUNW3fqG4GIFRpO5xRqh7ZJwK8kOLIJFnr5hG8YArE+fvaUj
KHI/TS+071pjjzDGZh41dWZpRHtQXFE4Tu+wbaFj6IKMXHs8R9YTT6RpbmGQIN3P64Tx9kS7
mcIcI7oL+zfO/QyjVO5VzvCEEWd6nHO88UX/u3HQBCYd/WhIPaN2aJgw3tT0u3jBI+1s5IE7
DVSLGwGr3r8lgaue8wXpgiEF4/Jgfx/9lJcpZTMPeDjz7eMFZOUiVp8XjqQOdy+QRTUHPBMq
/VTXxcFXbYom3IwvoKTMW0wXUZgwozn7FGQb5UxY0l6Lkh6XExPIL4njYVlV4csHezvrHZt9
IUTXaW5ci0hcQJAaSnQ0jAHoVprp1URd6a5ootpf0Usmq4bIIOSsdpZ0lLEj+FM52g8A6sSM
SRg3NrGeahGEdi9ocjVomwrBOsgKzcBJRYvTuTRuDxAW+dHrTXQYs3QytGSENUSiOtQLcm7Q
iX9dtledniK9SRKzZFhw3iyXnyt/Zeo+J9lcjzMCu1N2NbTTA024AScyGfHetdfgCdzu6Okw
33dqfeJNh05IpdNj+xoRSm1f7eq6CvRvJTqohHPAgZH2wgiLiwT0jaYsWkA2HR0K2hFYtXtY
IEqrQGlw9tfLx/OPl6d/QeWwiMIRHiFDivFWh/I0LcKxJgUZLb7P39rVJjr8n550PUfWRKvl
grrfGziqKNivV55VqR74FwGwAvdaG4B21olxovNbxcuzNqoyOi7SbGuqX+m9ZuMRU/+8cdkg
mj07lOEUSQTzHZUC6PZ36q1+Gb2DTID+5+v7xw1H8TJ75q0d0s2Ib+iHXyPezuB5vF3TAQl6
GN9jz+Fd7pAPxUpnKU5UkEf0K28EK8Za+mpRrJFCke7+rnzmAsP55GThjK/Xe3fLAr5xOLro
4f3GPVXODpcpPVbVtmMRXF9sfYX4VpQzdYC9//3+8fTt7jf0Kt37Af2PbzCeXv6+e/r229PX
r09f7/7Rc/0Cx1B0EPqf5sgaTYyd5Zx7xCxwXIsdV1BysmKwK+EkX983DZDyGWWwCK8uzoKo
eTkeoCFbkidn95CRgpN7PMxUVDMC6AlwJjL2D7FEnTerlnxbKUZtmQcxu9fzKg1jAEG7WIsf
LK6kLkJhGc/DemYPp0on1PfL1syes7whnx0L8Fo8nECarvV8hKmDTkILsaBh+mFf8EozblfL
yMOsmajNqr3emNKB379AGPgOBzvg+YdcbR+/Pv740FZZdfiwEq9kT+otqaBnhW81s/SdCWfZ
w5HSPon2K8OySU+fP3elPLroNQ3QVuHs6qSGFVfjTlYsGegKtTdiEpUsP/6U21hfQ2UxMGd6
bx3R2SG5Jl21a9syRgEdOUlAvd8lnT8T0bakT0L37EUfo6ZnQoIFt9obLNaRXKmftdMvdYdQ
GAUNaIST+EGIvSi4dlYhH5rooRjwFyqshHVJH9FgOHyoR174oUmQ8qKJqyFs3gdhQpBfntG1
4jSiMQOUK6csK90pPvy0A2RJ4aTiQ362NIzJ4HSHsU/uxXnYzLMHhXqeaA6FpZc+x2/+gdEh
Hj9e32xxqamgRK9f/kmUp6k6b73b2T4IdKSLSa2kwfRQ1uxhKFPy/fG3l6c7+VDiDm0pi6S5
lLWwcxfKAN4EOXo6v/t4hUyf7mAywhrzVcQwgIVHFPn9f7sKiw7XIs1Jkl3PMaUpGw+xNnqg
E5G91dByrNDeFSn8KCCnJ0imX15gTvAv+hMSGNtWTrP+21Sz9qUK+HLra6vniLSVv6BfmI4s
ZIz1Ac2jyl/yxY7KnEOfkHqukaH11mpw15He5ClBRivC7Ub1qjsgVZDBQmDT6/vdYk0VTT5b
n623pac0cKlocggiA1PBff1h2QCESZ2xguwS6CzqgbGesgsPq6ix89WkH4W4y3MHvXDQH4gO
4DlZ4upht9hQd/Qax25FfKl6WC28PQlgng5gSwBQuN1mQwwOBPYkEOf7jbemU7Sub+xF6AsK
2G6o1hHQfq51JIcr1/3OBh4ivloQ5XuIU79tiREgpE2x6/X2lFYxJQcPJcfcpI223o5oTR7n
ZPMDfbciJyHUDub/3KdMC9sBkMcDFx1v2qihI6IJkQURJhGBN1uWU7FmZJ4bSLr0ZqCuJsEd
gKoZtQEJQ2qqqAjulqTHeItp9tNu8Djz7SOkm10YJdt5SQZGnXj2WMKF4zsS7MiXpEqHLIDN
0dM95qgjokd6UPYgpVSzeKjcjYOWRvZ8orAyolWrHTMGDASUYxEcdKOBcbQ/nOAkFta01zLc
mbSnpT1B+LfHgHxwbMJIvmvPHzjKdJAGlSRdH0rAyIXVD/hs0BZHHDuiyIpfuRr+WtCsiLuC
Kl4MLCbdqwxa8e3xx4+nr3fiE9bpUaTbwol+CLE22bBUo4GVq2Qg5VSNlQbVMu2B26oZlanX
zBgViC9BFVoZov0HbWaDaNrgXwtyHVLbiojRKuHaVCUL8jG7UCKcbOdwt+Hb1mz9pPjs+VuT
WkU7bXeR1NbsuypbbDyrFLCYB+vYh9FbhrQiULIx0lXSMHwi/S5GkF2vOAQoouAaBbQVGJKc
UXbNw/Do0t7r56DAdg/JUTcoqE//+gGnFkMV0Mczcr9m6hkKZ5EOGOA2JqfNgqL6VsdJqn7Z
LTsQ7waWdgP1dEzhKlUVpbv11k7aVCzyd6Y9jaIQMJpKzvo0tptQa5+afS6LwCh+GO/XWy+/
nK1SoBLJ3dpZtdsunYPPPn0o5PXCbixxJnHl1lQcEu02REMBsCcNZCX+AMI5kUy+2HFXDhhM
z0U6w8USU6ehbvfDGGX3xhAPm53D1qYfLqzDsLOdR197DEyJ5PLpSwjBVcfR0vdasgJEQeXz
TB7eqsCk7CNzJnIwMsjL6P5EzeKLtkZePDQMsbRA3i//89xrAfPH9w+jhJBIKsDEYz1y4ZxY
Yu6v9qqDGQ3Z+UZphoxb+k5CTe1dKAFk4jB3pQnhBzpEBlFttTn4y+N/P5ktIfWb+GCaVm+O
LDx3eEUaObBBFtSbTZ1jZ1RKhdAbQ4zvpm/l4i21LlHy2DgA35FC6jqoFMuFC/BcgKtUy2UX
qU83dHBHA5qWRwW2+glAh+jLSq3GyYJeEXQmbzs3yPrBNIreaLXUBWf1eClIGPpLExEVcq9i
o89FClsfSfcmn9OhkMmE/2xo21uVVWpuCEAc+ytdqFLxrIn8/Zr08a1m32zki2Ayj58r4hCG
ypWLEORutokUEW98SjKN9mlTy9SJiI2bl7FqHSu5SQxDqOU0JD/IT1WVXe06Sbqt+h+Y0NsP
Mtp64CCOujBoYPXUshXRskUSso3wEgI9KaHICdI5ydPnKiYfGS9CZdAnroZQXvg0Bp9KmiUH
OB+dHW7HeyYeksZsfeUAndorD4rAIg75hA/+1ogoYUDOd6Mm3zGmhOGxvsHeU98wjP2AivfW
LthInyydBMXuWgXe7br0lGTdITgdEjtPEFG9rWHRZ2D0yqUxWbKVwdRLoMDscOIwMNbtmhoh
Q8swXmGJ7CaDUuz2aniNASBeqw8QivT+duZryLDbUUkdeoypNGJ42aXJmuVm7VE5xkkjYoyL
9lxt1pSKSanscKwgkT3RDqKBVHXxAEjdbh6GVKlgHK+8Nd23Gs+eWhJUDn+9tb+NwHa5JoH1
bk/2GhR1udrODiIx1OXutJpfzYYHTDOTtG7WC13dOpSkbvarNW2GMrCIC304BlSUjmVgOkXc
Wyy0de94cUWyEiJsQF3oKabWBsUw6hnJRXkJruVJdx45gNLUXJhidkmB71CpOozs6AxDXLhi
fgsiP6Hes44wl8ePL39+ff3jrnp7+nj+9vT618fd4fW/n96+v6oH+jEXkAL6j0DfnYk66Qzo
6vPXb0RpDLaiLMlTmIO96gNUzrDFSRqcMp1dr7HLFQ4v04boTI2sfElTsgb7xWY5clGWEcjh
k2b58qBPJB058qRIfQ/j+s58AdWDi82eGo5xADWIddtifPlis35mrEYJ3UbEQ6kKTjNkHQQa
8mCugL1KlshbBEfkywjWswWZvYnRpidkSrxemm/dYY+ca9ug3WD0JrvogwKKfnCRtz42PGUQ
lLfbU1bp3SIvHaicxGZB58QbvBv0yGSVuBmdr36QsXzrLTwz+6kWm+VikfDQ8X18XhT4Xl+T
MRW+xTESDOqpX357fH/6Ok3I6PHtq6Y3wJfc0WyhIWfDjnFQHbky7xPinhARkxy9AZScs1B7
Vqre/iALRzMtI1Uk3g7SqQfUJOLzi9lUA4NOl6+iMFPxKlBJPI13i41sP4XNIVKFUR4QxUOy
/quTFYmYg3vENUl3BDh5hyPwqR5GjkPJ0Yl1pNpKaKih35IYadUlzN5//+v7FzROcvquzdPY
CnCKtCBqdiCQUJcdCMt77ENleIgSKfly61Fi9wAa9kHCLg6vJ3xaZSySBY2/29pxjHUmfCnT
4VND4yGTxXPMolh1jZPG0hXQQr1yElRKvy+bh457IjDrYDVRHe9kFIZanZ6id3ozTsM7HkI5
PmqhDc5Fs+L+vKTlbUyO8Np3uy0aWCj15ABufL20UmiwaNrJVNCkka1C6S0qsipQXSWKakbe
sjW7picaTo4AOLLNClZu0/rk2KAVL2cRfexHGLKy3pD0cFYB7Hi2gJjrSQMW6FNQfIYZXboi
GyHPfZK7Po3wbgebnnPASXRtjg5B3izc/S8Oh+stdWjtYeMaaqKa3Smpuw1F3S8J6m61tEcz
nrrpw9iI+67BKI+kW+tT+jlVEJvN0mIchFGdrNlfa4UBiZm+WkawitI1zAJ6pJ2i0Fst7LVM
SS8Eo7rK9cKQRlWiLPZ9lIpaR05BjdbNekf52BHo/U6/chDEYt1sPPoOWZQvieYXaM5W2007
V3GerxeeUWskWfueQO6vOxi/tEJJJnUEzQjCdk30gJ64yUk3zv3ut4GuqCOzhwarAYXWsC7I
l8t12zU8IrbLrFruV65+GHVGeoZZftJpo1XqJP9XfOMtHMoWeSXscDkhwa1rOFHXyRPdEclk
ZPDNCxKDYbciLVKHeotrc+vLElhvaO2J8m332BUMO8fDrpFhT9rLKLCxpQ1Ue5MCBNZz9U5s
OLBRwtiABaeYFGv7G3dDM4MpL5nnb5cEkOXLtb0qNNFyvds7u94yCBBrZLtzSgiqUZkq6pjG
FArRbquIr7aZas4mKpavPV3LNVAdw1rCuEU4ynoZLGDNJCtH5J4eXnpuDf7Asl7MCH7SHEKv
Xl0ec5A+t96utcb7gIHsRrm+kouXOD4bq5Nu6y76rr8Jw5VLPrrVX826jg9DHpDmlAVNqRkN
jkTnndPEIYM0nMusCdT7hIkBnSicpHcQfjJen0xc6DNMODwc+Wa/CpLRASY79T089+w2axKK
10t9gChYAX/R7mAUpn6EZ3FJnY9sRuhDvL1zfNK6B7ZZjKufCbGPOwo2DjsCIs5DSn+LA8Fs
kczzgYb43sKJeBSSBsV6uV6v6eI4lAATgzwqUBlL5LxekgViPNsvF46vArjxtx51cp6YYPnd
6DuZgg2L5nwOIDdsybILxKeR3dYnO3bcWUnE1cBSPJkvptxSHOkB3Gxpe6yJC48psDfPfsY+
q5jY2oXtNitH8QRIXk/rPPu1786A3nBMHseyMhyrfqLu++VMFrvF/KwcDtOG504N3+7IaYsQ
HMtoqPKg3V2NA8cwUk+ks/j0V40z3ISYD7QUJD19TrRwaAp23u0WunN9A9zNjwPBsyfztk9z
NnZ0gjyP+8REycbHNrNlG05zNjAcDS2EZ4e1HitNwUzhQoHgRLbYBA5o568cSx6Iw2sP+nq2
GihN+8sNWSZ5+qDHynCgcX5anGdufnrtLR0jecaQVmMaJH4qC9uo1haF9AehCjDZM1mYKVxG
/SFdpxRlw1Km2hjUJluNL6AVjwEZU23zatRPRmUMYphaQYYhbEeIvoipURdBsagMm4Fh+iTQ
P50jks7L4qoA6rd4UFzL+a/xY1BXZL45CJj3YUxibV45PsnysrjdBHk+yyMaGJ2YOTzHJ+j3
BIXFsravpw5vjz/+fP5CvO4+HwL9UXpPwG0D3ajwX73NeMoUF3l4v+Fpc0mlg0BfJxfD63jP
F6uvSOAHiLcV62Ku3aEgPa7gpNsOXpLI+go28QiIDKo7wTzJUjRY0798n/Pe249NT0MSktlB
0XKOPrKrMisPV5ho6isj5EtD9BGY5Dj/mKoMmkAMPwRNVEa/whKr10kyZEkg3pxzy4BYYUWX
Vh10e4xtnqMXFKIdI9J5B4KHJO/EfZWjGVwYpuNHtEWk0LPRxTw6JqPvCjwCP33/8vr16e3u
9e3uz6eXH/Av9FKjXEhhKukja7tYbMwqSZ8kmbehjXEHlqKtugaODfsdpcuwuPo3FcobEVcx
pceeOrc9OGOmGHUr1htAkKDByksnPJ3UJ2NI5EEGk4DxKguuZm3vS5jXxv1OX0i1DHqiOohd
DuEQDvLYcI80eCG6+4/gr6/Pr3fRa/X2Cvm+v779J/z4/vvzH3+9PaIaQHAOBfipBPq3i/J0
TgJaby5GjyuIsABhVDo6E2YaXqjCkcmY5+PrXXkRXzeRdiU/scAcyunrl4lnjRbpuEa7G1cy
bn+KC5a/lvY3MrGgO6tfR+8UYki+C8cU4dvz1z+eRo8g/K/ffrGudpV8Dn5sjq2p3rTqSuGp
ywZliVtsPAoyx+6lFoX0EoIMpzgzCxk4/BeLiXMI0POmE48YTDbePcBS7PhgHQU1mtgcY9Vj
y4hk55gT5EvNmgSfW5iFFXfizuI8OAL9IRbCid81tntXrjBnze8ZbpAVZHgYrLHLbdqlkps4
eBMcmPoUHqEqKIRXSzHa4uf3Hy+Pf99Vj9+fXqwJJViF7dTo9cnxPcnZNzORB2d5ldE3NBNT
mrBrUBy69LrYLvxVzPxNsFy457JMxdBp9T3+td/tPPcM6LmLoszQAeFiu/8cUZqdifdTzLqs
gbLkyWItT1BEjvfQwv2i393Hi/02XlB+G6YEZcbypO1wM4F/FqeWFSXRRV1ZM47Gv8eubPDK
eB+QXDzGP97Ca/z1btutlw2n+OD/AQjTLOrO59ZbpIvlqlAPhRNnHfAqhO3tCiKdEkGEZr3G
7ASzKd9svb1HN5DCtJub5T13Gd2LSn86LtZbKOKevCxXExRh2dUh9FO8JCvUe4To+Cb2NvEN
lmR5DPwbLJvlp0WrGpWTXLsgcAwZnrD7slstL+fUo+3HFF5xhMkeoINrj7cOZ4wWP18st+dt
fFlQahmCe7VsvCxRb2zVydtAI7MW1pPtlmZp6lN27YpmuV7vt93loT0EqhxmLDNq+rBmsXpf
MOU5ItpKxYaYmMrGqW4zIroVlDUo2q1x4yK2EvQRBgcV91HklIfi6BQH7rUEF7oOg/zRJ0+x
pGPgjiOr0LFuXLWokjskXbhbL87LLr3oFUbxtWqK5WpjjU6UAbuK7za+MSpBdoY/bKepSiXA
9gtVNzwQ/eVKJzZHVuDjx2izhBphLFADL/mRhYG8S9xu5tGttUvB8pFWK8clXs/Bi80aumNH
a44H8T6Iz9s1qWEUXUbt+z2xC46hvGy1jlQ9A/O58zZW5YuSiBrS9ng0ZKWmCM6MipUqhmsd
VQdLHBCOw6Ftc5d8JRjuWc3ME0jLLUIamtkfcs8/LX3nspp5njHJW3P5NzzZq1OD5fY+Bazm
uV0GtrHGTJzSF/dCZvN8+tq/lyHd5w2HK1cxMYJzQDpa1jbipGiEDqB7OLH6nptVDifP82Kx
St8evz3d/fbX77/DcTM2z5dpCEdyjPOqLHtAE5q7q0pS/t3rBYSWQEsVwZ+UZVmdqJ69eiAq
qyukCiyAYSy6MGN6En7ldF4IkHkhQOeVlnXCDgWskjELtJeiAIZlc+wRouWRAf4iU8JnmiyZ
TStqUaoO9VIMG5CCSJPEneqpBuj4/LJXf+gJUNjFSjVSgLa79c/B2SbhsxNbWZxZyGEHaJXT
tk4AgbgdgWzogl1RXPCTVxDbQMKiF1zMGvYMaDb6ICby5g1lQg8QnPZ5YPRFktLbKEBjCFxH
F3nxYAeqppI+n1151uzsxNjW4aUCu9jycqDl6taxYIs1V9eiI1EXxGmLQUSsBUdDmXPMFEkJ
M43RUgng99faEWM+7JaudRWwc1nGZUnLlQg3IGI4a9OAkJa4R1RQ09HDxBRwZgpn85w53m1j
G6EdoWNg5Tw6pea4OsX0gR0HTgj7Ydus1u5ZM/MWEJtHWrWoXxSbo9D+Dlukc2gmKFmXubOq
6GnJJ71NI9gujYrOHLMRhWPi0mGVK9pu6xmrUi/rkNuZWO/Cxy//fHn+48+Pu3+/w0XLiJU3
bnl42I2ygPP+6kO5fALE9kyFShnhoNmRasInT2BjXSZQmsaRFZ6Y5Nsl+hnjxBXE1W63WdDf
ESBp7qiVZbPcU1WoUHZQ3b8ptdM8qymZndf+YptVFBbGG2+xpRCQNtuoKFQx9kYHjndJMMtL
eq/URW84fGmSNv7uhJYDttqCkrEVDjh2eRtH6ig7Nb7pyqevhHUpNuTNy5Mqn4qfXcnNKDA6
Hd9Qwqhj6kMqLZci7gb3yQqpinKL0CVZbBNZEu3XO50e50FSHPA4ZuVzvMRJpZN48mBNCaRj
hBJhBFimqR5aEdFPgRoQeqD0UWC1ICZcNgdefandgWSh6kaQnFVDFQ3cQC3n06IFrkWAL11g
5S9rd+79xWgHi3IXVI7AcPgddLSbukpxxrcAGH9cBPkyugL1qlbpxJ1hn8yV6ehXXO+qEz4r
tcmoasiv5odG/pk2DKL9tkPlQ2QVU7wtc7c9MxMEsbfb0b6cBdww5oqNN8JCiHbE8UOm087y
4WbAjvdiA+xwUSbgiyO0HWBhs9vSUo+YK8HCW9BqBwHnzBWJQsyO9npwRFUWqfnKd7gi6uGN
K5ogwk3rEK1FHwd1Fsy0GKwic3AWXGeTy+zpS9kxezcss3fjsAvQUrxcXNxYEh3LpSPAJcAM
ToSO4AIT7Hi2NTHEn27m4O62IQs3R1Jwz3DUTeDucUOEMVY3ipi7pyqC7jkKO4m3nek1DLeX
7Vp3yQcG9yfuy/rg+aaEqY6cMnP3ftZuVpuVw2Sm35ecUSkBLnLfESRJLozt0RGjEtCaVQ3I
P248T5buagG6d39ZoI6HT3I7cLxkERsOC3b+zDrS4zfWZ3GCKbl7apxb3+GlDNFrnlJP3Y/x
L8KkQPFfIUZhYO5AQJKjx7FpIW64Rx7IhGSE5DqRBPpLKOyESTI3UwIQyZvo2Nmh5gw2sQej
076sSe7tgkhYXkm4UM4OedCocQZ1HPqQqocEUfa+WTypiXLlH/WxWp04bJPewl0ExElrT4NN
mLW5G2G5WK9s1HLzPPaP9IcmnPVJhyrCt8wQ030Ye/bX6sTOLIDTUZHEgwdo81PYvVmJhfyc
/LpZ6Q2Brjydgm5k9925rcroPiEdZWCiWFxFRKkhLZaRRZBSYGj2LCKD17eZQwWyDacFGxmM
4izhtJQB49BiyCGailf5srxW0pzd1yUK3WXjXm2UUGDMtx0D8dfoTtoq/f76dpe+PT29f3l8
ebqLqtNoQxO9fvv2+l1hff2BJkzvRJL/0tcnLg4NGE+jJmuAGA9cc25MfYJ52TrT81vpeRUz
ewQIKIGvuzKG01PKXMsoMmFQMyzbySobItwMJDfEWJ5rcfUTeJN2ZBvfwydynColyymDlXF4
NPcgs0dnHlNpH2hXECMM8s0Gh3SuWmqaqDn9JyxI5yCQipkTjom5JaG6PDWaAY6RkjtTAjTz
TXJyyYAgbkkClzARVmOmFa3gGQLobRrsRWQwdiDGaw/JgUB/BR9E3E9m7XZpVTbxjfnKTblh
UedqWZQX6oNlXJeMUgOOa19dxEFGDBReprhoZsk5sTQmAz53nBx4RATJmYIDS5m6PhDj18uq
dxRaks5TFX66FrgSKDWRa26TP395e316efry8fb6HTVtQIJdH5eMR7E0qCFth3Xj51NJu9WX
l/95/v796U1ZcSxFsiiq8FhD6j9kGBEBzWiQRp5eNnO1k4zY4ZbiZEGotU4A1pC1ChHEQsDA
Rx7yRcZkkzvTGHbv9/7SjP2SZhICBl7P5sKRoT0Kej7HJtQ2aXUIzEp/hkETz005YcWB/65G
K1jZS5at65DiknfHU0isHpr2y8RAfvKkjZItuAhs4zneb6tsW+l2kUI8b+dG4ETi+rKAb3z5
fiVztzO4X63W1OtMhWG9JhdRQDYe5ZRCZVj5dNL1knxNpTCs13SBs2jtujUceMLYd94sjjxN
xyO3rCik2N6pkjXpTT6+XGdLolslsHQBKxewpiouofldGJWD2cp1Zho51h71ZQGYgc11eEab
MPL8RAm3c6MGOdS39Sp9ax0XR8SafCRb296aKsC19FRrTxVY0Q23XO0p+nqZLekCt/5i67u1
K8gTB1vfmx/CMR0ZbYClbRm9miV861HjD+g+VcmE75YeKRwi4t9q1EOTbxZEtmgzjSGFF8uN
DY5P3GGikmJp0O53C/Jpuc6yJ3qzR4hxJpDlemsdsEdwTZphayybrSPjvb915rucnRcyX3I8
9XEAu0sU35A7DOaYHVgTZHZZQcr1NjuixxDY7ojh3gO6ZxYN3LdOwJ1K88BhAK61CuDlYuPy
pqJyQR0DMnuBzOS/9vx/3cgfhjVMDDv3OoOtiWjZullvPGIaIJ3i54cmW2uvr0cEFX9wmHMj
rppJK48ugP+Lp77zpwpWp73Md2uHdEh8nOf+ckHMQQQ2lKDUA/R4AXC1pmYebwIt3pRKX5Mz
iqMBMRkuaeBoAu6v10QRBbBxAFt6BwPIfF5O8mwdTu81npkbuJ4HpDL3hYzggd1n5bkvbwVP
Gux32/1cE2Xnpb8IWOQTIpAC0r05Miy9lui7CfZbYiPT4FsfIBVqDV8Gvr91XclLFilTEHkj
QovNpzjwlsu5HeSS79a2YnxA/LlNQjAQzYH0nStL2hOrykCtY0hfkschgVAOTVQGSspAOj0f
BXKj4tstsXoifUdMRqDvFnRDAZ0eMKgBWhBDWdDpvPb0hi2QOTEdGbaOLLfkuQiR3ZwCznTy
MNA/i4P7flP5RDOh0LFdE9s9+lZZk70vkDmhrAhOu/WKbJfCtuigOKiSSoBaCaoAjqmLwFeV
ILqGQEsit8AoqOPu1LDMVBNMsFkBuRUe6qA6Cty5eqpPHIiqKrcv8r6TxZoSrGc76vrEMYCc
gx0gM4maVVfNZBe+ArV6e/14/fL6QlmlY+b3IZ05Ynl54sYttxKwbuYTJpum1kP5y1FbVApZ
tVWe7mvJxss99QNK6ctjxPTnAdOYQLzXiepE874AaVkSo1nzQaeesorpt20yfVEYRppIDuro
2B0D3h1VJwJasN6T9L6uDk+REs5aJ4xCUCQXyk2I9Af+/P7l6eXl8fvT61/votX7Cy7Nj/wY
agLtNRk3aq6b2+lY2RzMcgGpuxxZk2SMU3rlgSfMhLUpb1B5Z+XapeqNR9/YXLS2CHjCQ7uL
glNT8hOvoE+hRuhawf9f2qAthikoht/r+wc6Lvh4e315QWtlU70oem2zbRcLq3O6FoeQpGqV
F/Q4PEQBde05cmiO4CfqZNysZZr0H3M1ZnvyvcWxosqD0Y48OFm5U6fQ2HgPZ1WxnKpIUKkR
OWKcvOoeWczw6nq+jkY4zTcCz3aeZxd3JENLlBQUGeWod8Fmgy9TicbEbND3vqMIfc31/JAo
Yqf10dvG4dfHboleHt/fXUtwENG2OGJFQHtU0uTkJAJcGLOnycfwMUXZJP91J5qgKWt8YfL1
6Qcsme93eBMecXb3218fd2F2j6tKx+O7b49/D/fljy/vr3e/Pd19f3r6+vT1/8Bnn7Scjk8v
P8Tl77fXt6e75++/vw4psc7s2+Mfz9//sP2oiOkZRzv95TxQWeXyHC1mZ1zwpbHMIqk7BPFB
D6Y4YeizaC4/EQDiUqtur0TxRG/G+mX/BLgzFThdIAHF6Om0LvXHGDLAyMvjB7Tlt7vDy19P
d9nj309vRpPJ3apox5uSXAwtGKLfXr8+KQEfxIgBaaYs9GiBogAXh3v8HqTkWtFaRwZChvrM
T6V26rWhBhArx4idYkrtMKxkW/XR80T0MBm18gG/DM1hNi/BJ3tIcLqycvcUtjqKGa6JzJOa
6RG3xmT6Dm3dcYn1P2cb39oUcuZTNy5i3YhPjW65IQtx5gltFiv310PZOKIACtxcW6OrfEEQ
XbfRZml16dUKlas2aSxESDNR2sSwPWTke01RsQqE9clvklo5Bjt/eD4YozEzytzUAYhMZxbW
pgNjUaryEtQ1K11NoPsUk1szBvwUC3zK2uakWo3IoYPPadRH/Ei9Al9rZPRZ1L+1+hmEI/zb
X3uta1M9cpDO4B/L9cLqhgFbbRyhbEUrseIezbEx2GHiXh2PQcnvE6Phg8bYaUD+SmLhDcQa
Em0Q1bQjKLHDJ8EhSyA/l+QE/5NfGydP9eff789fHl/k4kjPnuqolLgoK5lXlLCzXm4ZjlvK
7db0XzqMqcUq3HL8iHPMoH8drRDDIYE4NpxZcukFW+2s5KioVv5hi7Fo4zsVG+mfqZhVVtPh
O2/yda7NyOlvQJt2cR1cdHG8R3vJoStOORya0hRfjPlKDz+9Pf/48+kNqj7J6noHo0EbzhD9
44Nce1KD/ojv1jZtkPqMQ1cb+FtrGc3P5i5lwUunlFpUhmnZQIUshehrfQ3L5dqBwzjq66LL
C9y0hRmYqWNkHq/Xy4174y2Sxve3Ruv2RLQbNTMU0I7WWYv2L+/da0By8Beu9acfMNLoxDii
4vuoUWRX5w05fLQdgoVo3VpyOLEaE7JLcAszhlWXRLlFSiwSP4XcnI1pVxeweZnEXpK31AXw
z9RajAY6IVLQfHNniJGpDBP6IkLjKkhTOY3FahwVIRtlZCDaZkqcWOfBEUu7DB8s3y5+ajzy
c3Gdgsi92Bt8vXOSn2SnzS0MvpzFtPWfwedS/hlsxDlRY/2cOHwBiMXB9HajT9aGjn8lJqs5
Woj9ZaY70lMRoReVGZbDrSmADdl/ybWiKHPPOClKm3exKsyUYK4PDqgHorRAzbVSTTjEz66J
dHffIzWirDwlmqLMp96qSvIp4qpoAb+6KNLVdEhzGJDKPI7xkvOl7y+IMgnH17qP1XG7bv7+
8fRLJOOI/Hh5+tfT2z/iJ+XXHf+f548vf9rWmjLvHP3tsaWo13rpm6v5/2vuZrGCl4+nt++P
H093ORyPbXFRFgI9EWdNr68xKi/9jgy4UwM+/z1N8oDjZMcvrNHF5Zx06JQnOW+Y7oRyoLkC
Qj59e337m388f/knEQdySHsqOJquw3HulI9aKjWpW1lqF6RhKfqpJCfGyPQpZ1FdFt1y5wi/
NDDWtPgz4fJJFTamIuYnF6EvnihCeyw8RFC0LoX/ax0gsLDG01uBh9zjBc8/xSGxb1XQH4TV
tCJ9EDSer8cgl/QCpu16TykSJc6Xm9U6MEoaRvlGs0CZqGuTKtxZLCii/39Ze7blxm0lf0WP
SdVmw4tISQ95gEhKYkSKEEHJmnlhObbiUcW2vLamTuZ8/aIBkALAhpyztZWazKi7cSXQ6Ab6
MujNMPSFhbWMPnvwLMDCjfRozz9YHehTO5h10YTMIodfpCCwc7pYXYFkarhy2+MjbA0pbBSJ
JBjm806PC/zh2AHsnjCO1c1FFHBqJLnrgDLRm109hA9xj0dMV+ScekBbaWYEvE8P4CoIVrbe
oONNGM2Gn0zlBnFV1SQEsi9YdTVFEs0M4w9Z1zVVi9WIynHingp3rpV+ZUd/D+vt8j66yq2b
NIhnw0Wfs9BfFKGPJkvTKaQNicUdxL34H8+n179+8n8Wx0S9nI9UNJnvrxB5nL0dH05cVwG5
QrGU0U/wmgvxF5flzxZ/mcPFTTnopsxI6OpiWRy6rF86GLJpuSda5h9UuwTlgM376elpyALV
g53Ndbt3PCs6ioGrOONdVc2gpx2+bDA12yBZZaRu5hlpHE30AW8c+MQMwGzgCBdQ97kjrpdB
6UhJZdB0L7DXN8rT2+X+j+fjx+giZ/a6SjbHy58nEC1GDyLu+ugn+ACX+/en48VeIv1E12TD
IDiha6SEfwj7xOmQlGzMuEkGliv8VsYGvA7wIbE5bD+ZKu6mwpEkySADN0Rs1i7Ocv7/TT4n
eoydK0wsYUiPrPfURsuakc5qhCRN1YShzVzRqJauUZbNKsEDFfBNONYoURqtoiqp0xKvCRBt
fcC1FIFk+d1n9ee0yrHb5SwliWYOca23SaTghJRJIUG1sEbQS1yhDkEVxjeIfwndl37J1y8B
MNBdTIjp6wYiYU24ELp0TRsp56SlhecQP8W8QcJXHHvXkkMORI4Qe+B+62oZkFsXEnzqbuGY
EwlxEeBZhTiyZJT79gBpgxyZcw/MbrfHhHx56KlnJaDN6y37TfNxr+4KZ9dpEYaeEyuuyAOv
JXTupFGuZp+gv37ZbCElj4NKxG+bk/I2wQpmsS2XJR4j5ErjWhvOdaFwTv9OjncuG4WDso74
IouW3lpzKSUkGKy8fu8lz6fj68XQ6Aj7suH6vnvWU4hHwYaphzh8vlsMTY1EffCcoO9Vdifg
2BWNrMdiIxzSJ/ixlMwu4LLZvDag3UE9HuK3Ng4tY79Az2+IhtKF0bpuD5m6Qe+zSubApc5h
Bhbh9/px/vMyWv14O77/sh89fT9yVRtxkv2MVNAejq+dtIlY0YGh4hxCVDjCmAJeJDLaN8kK
EyBlBclaxnLWy6Hx04AcYuyuvtCs3ues0kQ9wPE/8DY0DA8NyOWmkZHmjO5JqFoHjiY5N9mI
MHWtTLj0A0HCIWIi2V1eNcXcjGANJeg+4aSubnbY67ToSL46kjL97UUHZovcpAK7tfbAdbPM
hIsGW7pMRX6ybieo5YB86etMLevsy3yHujvYiT4SSDeU27/tJ8MeKqVUsQfzr5AY7bfAG09v
kHEVTafUUl8p4jJnyY1odIoqZ0Tba3YdNClwo3cNH4wdBVEzCg1v+vxdEVM0+Z+Oj10F8TjB
PUUZWhG2TAJw5+FTlleB58HEIK1IEpoEYQwUn9XFCePQURVnXlM0sYaOD5CCXHZEM5D2aObH
pT9cY4R5U0dfRJmbVU51ByqtlAMej/GuN8EUDRys4X2k6wAe4+AIB09QsO7c1IHLMgx0RVbB
F0WkZ6DvPis/cPgfP2in2Org2Dyvq/bWZObCTDXw1smg9iQ+gKdhNUCUNInRfUbSrR/Mb636
DSdqWhL40Y21pogqpAWBKtGD2qLw43TQcY4ryJwmat0NNiQZFuHQlCBTz+FljvWQI3a3+ldy
lplvw0GFLApwRpJ/zjZlaKmhlNJ9yLncUoYZrLEPE4zdbgC7bSec/SQ3GldkwKjGWAv9pLsa
KcEV8UYD2x0RCYB4KxRrQJgGOA+NtJndZOEbUUEcmTEirlWnO1x3NCgWBLWnMmiEF+eg8/ty
PTWStSv4NIiGLIYDhwwGgC2yntfy7yKfD/mGdrTgK8L5Fbt7q5yv8Y+LMvTtn0Vk3JaHh+Pz
8f38crx0j0ddEBMTI6lf75/PT6PLefR4ejpd7p/huotXNyh7i06vqUP/cfrl8fR+fAD1wK6z
0xTSZhL6Mape/MPaZHX3b/cPnOz14egcSN/kxNfzlfPfk3Gsi3yfV6byH0Fv+F8SzX68Xr4d
P07GnDlppIX48fKv8/tfYqQ//n18/69R/vJ2fBQNJ2jXo1kY6l39hzWoVXHhq4SXPL4//RiJ
FQBrJ0/0BrLJVF/2CtD7PffLyFWVaKk+fpyfQWL+dE19Rtn7HiGLXVO7Rah880CTYZLejvd/
fX+DKnk7x9HH2/H48M0IiYRT9Jcwi7Td7M2oRmsu81fg5gYITPTPas5PAdlSpp1bEgKWvzaM
fDXc0aXq0HbxGdXWenw/nx7N/ShBdjnROeMWucnaZVpyWRdnpF06hRtmKEuultElmVcVauOx
ybn6ySipLQ4OyZmTYs2Vrg3Ei1/ffXW49/UXJ9jNmMxUdL1DA0vzxJW8WGA3GX6nJJAitrwb
neaOTDAC6wqWIpA70x9Hpoe+//jreNFcMa4XMup7LQlbZw3XQkmZ3VV2eo4uoL5ZjXEjB5ek
kCZogQk9izwrUmEZair5qxLex0F7Ze3ckRYHzvU7YaczJ3ikt90dLmxuCzSD00aYwkJuhXZF
jd5QH9V9uqV53R39YqU51fR42Kgq7pB2cq5qfnb2rk7MxnDyZl7qBfoarqtYBTPCg1Z02JqW
bDmoR8bVtMCQ4xwcGvU3sUFrt9JzdzSi8Jxg78wdyX4+HJy8cjDfUjoUyzasqlc7hwbRUX1h
DnuxMisKsqkO/ZRjfSvWIg13Va13mu/PCiLHAq+gdcYZSWbIP4qPdMxQRRNNns8Pf8lUKHAI
Xo8xjfP0aVKN4RYQvdAVAl8WO6i0DQzf70C0YimeS0drX76tozG7TKrZeBo5uGfNBVTMMVwj
YXkkgyxh5QEZObRsjca3FUoNN3Zck2gkE/v6psMlaZJNvE9mAIhmgWsGEgZJtFo0xi3gm7si
9sa6JM2B26rOt64DCQLyfvbt+kBKt7tOSVEShq3Xdp9EKHzOZVArFaaGXeQHFfvYMVwibDaZ
OVx4F2KR5yHQienv18PxRK5aT3LI2WEXnSdlu2H4GdnhGTZn5SFRu1ijzsvDtCztNgQUvzzv
0VukCfFotEyZxvYEiPPnJEE/BaAtYhKFtCgsoNiI1CYVa79MHRgO1U4uQrftMklavpnHJrQs
r+DrS6MiH3s+Fiwm72vTIz0BtEChklaPjVGyUkJj3d2vh870oEpXqBmYA+CFgmNfPJXFZrF+
LwfQYgjlVcmJmOH9sfuuiNEhGRE7NGiMVmGDFfHUHumS7hQGXXpMfS89mEYiYHy36wI+H39C
RNPjyAQDcWxOMdTb7GqQFMdoADUg2MaMNRW1GlcVDluR47DBIqUUhoDHPAxeUMJYj7gKtqpZ
/IqR0TJvKQQ6AElA9w6TL74LY++tKT+ED469O4iNLD3eIWFjPDblhr5zHckuBZdKOFtQEy5R
vfL4NeUGAPJ/VckavTHrSWgtPDE2sf7oM8BOb2Jnerhp2XBiWEqpgLgEhpvssNmWBKvYUZIj
aruoTgMhcadh466dE6xCpPIpPE8FN8vVfbHu4gWX6zQ14Y7RfANzP9CzZCF2/v7+gFmcg/2b
4SotIaaBi4TxM2+eGV+F1YmVigCOT8umjsjkwathLi0TA6++rKkzggnHFmlVFS2ohKRWadNM
05e6Js2OF/C8aYTGMIKsxEXOf/S0fux74j+j43z5dAS8plngG8sO1kmH3m3Wm+pu4w/mRxe0
jekU5jSQrbapjW+NfS+N3ZK8mFeY/WfOt/WO/3+vXbhKGNG/pQRdbaqkMg43VqeHkUCO6P3T
Udj+DR35ukZaumzIXB+UjQEmaCgXKEFvSYEbFdlF+CfZT3Cji8+GYPYT0fU6hIpEwzl4w5Xh
3RLLpgnRx4HcHn6q36MrjmoR6lD7lRtWOTOoOwgcNWIG5l+gZ/yvPpuItaEE9R6zjBbHiNUb
ZRvSQdUt5cv5cnx7Pz8M+UWdlVWTKem3GzpfyBhctMdXuLRr1642B9XLZt9ePp6QFtUNQj9I
ARAXAcgYJVKzgekaNSrXGDLwj7u8HoZUYFUy+on9+LgcX0YV573fTm8/wy3ow+lPvsoGwXqA
8VEuEVR8g26Yyj1p8sUrur+8fHk+P/HaIHC6Hrmhu8hE0LIc3MY+OosNsTID6vv5/vHh/GKV
62ciaef8eGXNXJ84tJC8pD/QX68pNrbn93w76JHGlOEWE1uUu5yLRLaNJYhh8HJlQLSVlUEM
9+tvkVIEHKf0o0jam/EfzAqpAdR1YqcY6x4OPhmVNI3+7/KAzyLshSVN9oH5tfvqByVFfdvv
9898jh1fRqpNfIeCpWw6tzYYV9jzlmU2lM0NCU0AC65cuPhClZSZraptuUA6SKIq1cayWYAf
g11CKXZmswCkmKl8h6WpzTRQzfEu2TBxXNoqKKHGCYrOpr7MXeKxjAIzAFOEfRtf1xBEWU20
jkuZRYRg8MMAWjf5dY+FUAHMTmuDVDKN/xHZbGyTaeOXNIsdMxLL9vCiujMn+YqjpRnmFxDD
hGqH0/Pp9W8XM1Cmsntbtu7sypDC/aPUP+LJXbfhG2X7RZ1tO36rfo6WZ074etY3mUK1y2rf
xWSsNmlWGrb+OhHfFSIzxUbPbGsQwIsW5P3C0eANwChxluanfL7P7J4jfo9w6KtVqZ4zBCUu
Q8vPeJ2WvpbrZHE53EqT3i/9Jrm6h2R/Xx64TqLCiA3OQ0nckjSxkvl2iDr/Wm3IAL5gZDY2
I8sqjMOLRWFLcgjDKELK3fTi0mmmY0xqulKAp9egv/YlZwduNpHxmq7gkr2Bpg9mhwN03Uxn
k3A4K6yMIt01ToG7sDEYIhk++3B+XdVffrMERlr4k6AtaYlzFbliUF+1XG+Z/1DxUzBYm8xR
MLi18hN6V9rF1vBs10qbUw2s/HXgmQhpS/5TDwOjlRmQilYZbOSeJNBJWBfW0izJwdcacbOS
bnbTQxHqd0MKYEdLF+BJ4HhKm5fENzfEvEz42hKuRHj0gZRYAVB6eOgbjyFcX6lT9AlCYmYD
YjSY7vrAUi2mr/hphjxeH5Lf11y71qzLyiQMTNNWLuFMxlHkmAfAmjeyJZmO9YjpHDCLIt+K
cKOgNkDvySEZe57BOzgoDiI0/HGznoa+mYWGg+Yk8tDz7P9kWdQvjEkww2OBcFTsxW2+4CcI
Z0I1KQo0Lymnm+mJEsiBBt4B+LIJm05NGDxWiFcOBb4uvqzm53cAYOyaL/E9z/PtQimZwYpd
UuKIXJQWwyqvTHojs4Xx7dhkCe5B3F1fmu2uDrhZNiSGPhxsai68T1LHwKSvtF2iaJJgPMFa
EJiptvcFYGYk6+Bnih/G2KED756xbuBbJjQcB8aqK7NN+9WXfcJMCshuYtlFy7Nq+BV0WXpP
ZOgRwxn9emrl1gRcMfsblQoCjjeuyYVsUFapdAo3xOhxLjupX5kBuTf1bRjjTCUyYSUXBKwV
3twVYy/0wDnT6L54Hw2Rhanw+0XM5XKjqn1OIWYZ2DkZcCXWHroW/lPjwMX7+fUyyl4fdW2S
Hzd1xhKiFFizTq2Euk14e+aC8OASoYdK1vLt+CIiubHj68fZ4jdNQSCWnLJ3QA+jLNafbORv
k9cnCTOM03OyVRz5yjF5/Xmdg2SzpCH+GsL0+BH7r9PZwbgmtYchQ5ufHhVAWMbJe3N9NnAC
fb5LpkbP1KjkbRCjXblhpUOkIS80VoU4Tk2RsqCUS4Wvmnv5rXGDzciLDZvEKJwaBpzReBwb
v6NZAE7nuuInoGFtAOKpWSyexWbfU1o14F+hQdh4rEfLL+Mg1FOYcY4W+Tb3i6YBxjs5sxtP
AnNX88aiaGIIL3JzpravY29hemMOe0Phx+8vLz+UomnuO6UEishuxiFh4aS6hHp025S9yGqY
bxpdEB1bvB//5/vx9eFHbxf7bwjEkKbsV1oUnTGzfCgQ1973l/P7r+np4/J++uM72AHrq/Mm
nYzb9+3+4/hLwcmOj6PifH4b/cTb+Xn0Z9+PD60fet3/acmu3CcjNDbB04/388fD+e3I57bj
WD33WfqxwY3gt7lUFwfCAi6U4DCTtqS70NO1NgVAN+7yS121IZgY4ihIGdChr6unWYaBh0uK
7gFL3na8f75809h2B32/jGoZ4+n1dLE5+iIbjx2RV0Fl9nDzQoUyAmChLWlIvXOya99fTo+n
y4/hdyNlEOqndrpq9ANjlYIUqQmtq4YF+tub/G2rUatmF+DCMssnXL53ouwER92Y7P5LrsH3
0QVipLwc7z++vx9fjvwQ/s7nw5j3eZn7zoxhi0PFphPdIqmD2ENal4cYl1/3sDZjsTYNLVxH
mHWptVmwMk7ZAR3xjbHJOCunp28X7XNel1lCueBV4MaPJP09bVnouxSZ3cEffIIOWYSQUgnT
a2jKZqE+hwJimMjMV/4ksn6bmnRShoE/RU0AOUY/v/hvK3RUAiGm8EUFqBi1LFzSgFA+WuJ5
ZnLkTkJgRTDzHP6ZJlGAGdsIlG/aC/7OiB+gjkY1rb3IeNRWLciQXLryUltuSMWe84dx4jB3
JQfOdVycBVDabcGmIr6RtK2iDf+wRmuUjyDwAOrYxL6PRhADhGWD06zDEM8I1LS7fc50uaMH
mQdAk7BwrPtZCoAeorabx4Z/jijWJlIAphZgohflgHFk5sHascifBtgLyj7ZFGMjZ5+EhNog
9lkplBwbYtql7ovYdwTN/co/CJ99H2UZJkuQMQXun16PF3nhgfD+tWmaJn4bn4isvdnMwS3U
1VdJlhvXNRFZclZj3SslYRSM8dEptihqFMc1tjTU51yVSTQdh8PvrBBWmi+FrEu+4DwX3HYh
QmdPzus10KSlI5Y7QzcyCNWh9fB8eh18Eo3xI3hB0IXVGv0Cfkavj1ySfj2ara9qadByvRU1
JlcEOK13tOkIHKJyA2b7RVVRV0XCvB6rpB8G3llDmnw7X/ihdkLuaiMjyHQKLtv6HSHXVsZm
8EJQUyxWrWEiPcdmQwtbnHJ0CO0sH8xFD2xW0pnvKdtlR3WyiBTv348fcJoje3FOvdgrtZfQ
eUkDU7+H37byxw9zjWZFzbD/XOPxfectLi349jTMWyPzpkv8tuRyDgu1txe1Z4UnAg61GHY0
1r/ligZebMhGXynhpz3ubjmYvqso9Apud8h2GiLVhzj/fXoBiZKvzdHj6UO6Ug4+izjEzXCN
eUpqSBmWtXtdqZ77hpBSL8Bn08hzWi88M2vkgdfsSOjJaXHBY19EYeEdhk5e/RTdHNj/r++j
ZEvHlzfQZ81lfV2CxWHmxT5mFSxR+qw1JfW82PptXFU0nPWg4RgEIjCivmM9u9a0aXAXon2Z
Ob3N6J1hqiIZer0dPXw7vQ0DGXMM2DFoB2xdtss8GQBaWg5hnM21m/o334bvA4R4H2IwruMy
F9xMPGbhpBWPhi5ovsn45teLFO1CHwtEQqPzNk8azV6hN8LRNhCDp1E+NwaIJYulWT8l/DAD
JxJ4FrSiL0r7uXoL1+Nz3jPsIBM0dPCsIIKVNZnj2Bp8zH4glCTr1koJIu+eGxEbw7GRRVxy
CKqXNAR9FOqS/nFWmTXwFtrUVVHob6SfYeQzkA2FFxS9rxIqjXQqNFqfRkH163QJl9dnA6iy
PzeAkGBZxB3tLlEhJQr7/seHMBe57g9wcKph9esZUTRgW+Zcl00l+roHOWLgG6Xh5KOFEQNa
gePcqNFEzroyRkPKtBiikOMMgdNIZyLbs7ZbIhy5rjZEpCVpkaFIVyWBvtmCpME0K6DYsECE
gzOHBVAZ+CIdNCvM90mDKfTaoFSdRtGEpBkkm0wxVzeTYDjcDsdyMNd2VADsR/pPDb9jmR+y
wr0y5GYYjAyjwT8YENADaYPpphQpk8zme5SZZkYMjSaEIh0mlK4q4J5pGce69gHYKsmKCp4e
6tSMkglIZVK3nXrx+NbHkuxQ0B0EHVoRfEvs6qEn2JYULbi1F6dNsNPtPHRo6483JYYS6ajQ
xrpMVY721ONySqUrkFm3QorF0aGNFjqTQStwor7hpUFi93mN0tL+5mCtG5OEI/3A9trtZDOD
DfatgnFaoucYzNMi47ra71miWd2WicGc+E87dqSGKa4xWOjxHRIBCSnwRV4WY/EAQQBIIPFo
iTnDSOzGuBoAeyUnccp2yljTsPWFTd1CzFy8JPiC2MWkuWxgl7DwoaPGZrXbpFl9CEzTUWGd
T7O+re4D3Zir/63s2XrbRnZ+318R7NN3gO6icZM0+YA+jKWRrbVuGUmxkxfBTdzUaJsEueDs
nl9/SI5Gmgvl9jwUjUlq7sMhZ3ixTlIRJte1Y1+YOopYlRN5iv24GLGwrtiLK8eal35qjdse
Fw0mgSbl3HRGfBmVjbW69JZOKlXmYXnI9ol+ssTetNY2zu0RxRUGrF9UgzHWcn30+ry9JeUr
XHF1wyeF0eFr/Xwy5iEgLNK0AoN/OAtUB/6tVMdkDh1XJXzV5QtlyKMrrutENVdpvLCfa/UX
iZLyRo5Y37q2wojeUdmC9MSJqVS0kovUtvIoEx5OwDjJnH3VwzqR8DtkIJiKNZvUbPYXOTyC
w5+hLXxZaQr7Z1cvc0rfhtEuQYJfwJl2bClkVjkDu8JQZzA2m9GIz07jEiYqadGgZPHxYmbZ
ZiLQtb5EyBB8LbyMC5pRwbqvrF1Sp6Xj+46/yah3MgFFnaU5H2iTrt3g78Jh6DbUuHg7m8BB
onMv3tZObhmX+jKqeU/ckLSOc885FhZrmCfKXG65Rsb6kXyPUYnoVLPNuCMRLSX6BsZ9qHXr
2lvgNUojYemhnlfbSg2CyjqFWY4sRVJu0EnOZYEG1s3R3RLmjxt8jDGMYRJWOtSp9TBSxGjt
dO1QcAWAvlpE6rpq0tI5AQFxBapKw6V7TOqibNLEEU9jDWInhTBkiO7UICY/uWzLxtoA9BNj
11D+TprkxDFop+xWPdlaqMIbDY0IwrE72EbZ+/0yyZvu6tgHzLw2ObcBGN02qU+c7JAa5oDQ
HcIBRI5/RO8oZxOUMBGZuO7c9TFCgZHGqcIlD/+xW4ijFdlaXEPTQOsu+bj51lcpyBl87CqL
aAMzTT3+GWEuYejK6joQNKLt7Vc7LH5S0zazt4/ed3UjmtpdrhoBQlZTgiDLCQ2GxjhDBh+X
c5RKuyz13USHuHTUPC15vuze7h6PvgB3CJgDmbO6s0Wg1eRBTeirfCIFOGHx0qHJgjLxGOry
skg9c1WXKlqmWawk52i/kqqwV5uRxcxBmVduTwgwMjG2Tk2zEU3DCQXLdgFbeW7X0oOoN9Yx
J3VUKelEjB4ulRbpQhRNGnlf6f/Mrhv5aZJeCRWkRjTCcTidQyswbjPlhr2uG2kHsSoVJsry
9rckbsqDoEd1beJSj+/mSVLPpnI2RrCW2ZjjIOF6NWsIxeeO0XE3b2IfiQ4mNrTCrLTS/40u
vxilm1IDum8fPUF2Ux5CntjIcSUO6GU0EHDLXdOdn8ym67ipm3gae6B2v2vGvZnfO2FvOfrp
7nPO00z3fqURTo9/3oqgBb9//8/J7wGRcVp14W4wtR6o/Q1HlUo2GBnB3hmcWpVZswM/xubs
Xx7Pz08v/jj+3SozQ/vUWBJTO/nA5btySD7aj3Uu5uPpBObcTcDl4bibII9kuuCpxpzbxkIe
5ngSM5vEfJjEnExiJlt9djY9HGdc4COH5OLD2UTBF6dTnb74MNW1i5OLqWZ+9LqW1iUun+58
4oPj2YF5BiRv9oFUoo5STmW0az3mGzPzazQI7mbbxk907pQHn/Hgjzz4ggcff5hqLPuc6RB4
7VqV6Xmn/OIIyivtiMb8MHAoCU4mMfhIgvocuZVpOOgArSoZjCpFk4qCwVyrNMu40hZCZm7a
rwEDSsHqQPtSaKBw48IMqKJNeX7udD4VfJA1Q9S0apXWXGgQpGibxFr/ceYwaPg5qfO0RRp5
eV97UFegs3GW3gh6neTDphjrals11u4Lu9u3Z3yfD1LirOS1dRLgLzqi7ED/BFTyspUYX7YX
/MdjUKoaBHOYeSTEcFy8wDTvS+IFU9VCEXFAYAQ1rQr3BE7LungJOrhUwov8V8uoRTW5i0G2
ozfCRqWRc+AbEtbgS6McWRgDcVL40ULqZG6oK+ksLq4HU0B0AAXqdpbNhZtTN6SiW61qYlEm
pSJNvi5bFU0kZwLFDCRyLA8TB+uoDkzHTfibcfhsJ4+szkFeebz9dvf474d3/2x/bN99f9ze
Pe0f3r1sv+ygnP3du/3D6+4eF9u7z09fftfrb7V7fth9P/q6fb7bkV3MuA5/G1P9Hu0f9mh+
vP/Ptndi6OtNQY3CLkQr2AaFs/wwoFqVtQt8foNVBKqYFKvpZJIOOQaaBeqJ260UkyHq6bWy
I7IXKZoU72TdPIrjJSDfP4OeHp7BxcjfwINWhRujNJeY0fM/T6+PR7ePz7ujx+ejr7vvT7Zf
iyaGPi2ckFAOeBbCpZN9YgSGpPUqSqulfbHmIcJPlsKOYmwBQ1Ll5A0aYCyhJeF7DZ9siZhq
/KqqQuqVfXFrSkDWGZLCeSIWTLk93E0Ao1H+AmY/HIJCUSqyoPhFcjw7z9ssQBRtxgPDplf0
fwCm/5hF0TZL4NVMf/yzysUO4X/0Fc7b5+/72z++7f45uqX1fP+8ffr6T7CMlZNaQsPicC1J
J0iigcVLppUyUjGfrKjvdquu5Oz09PjCtFW8vX5Fe8vb7evu7kg+UIMxEcO/969fj8TLy+Pt
nlDx9nUb9CCK8nDWopxpWbSEc1fM3ldldo3W8tNtFHKR1sezc6YQg0KzGs6a3OxVeWlHnxzG
ZimA012Zns/JrezH4519MWhaO+fWQJRwpg8G2YT7I2IWtbQDSfSwTK2Z6spD1VXRPFwVG/fu
0mx0eb1WomJPCTOwMciLTctG9e6bjdFczNAtty9fp0YuF2G7lhxww/XgSlMaI+Ldy2tYg4o+
zNjpQcShXm42yJYPUcwzsZJTaZZsEjZC6NCM5vh9nCbhzmCPCrMjQu4anzAwhi6FlU3WPeF4
qjzmtxIi2Mi+I352esaV92H2PgDXS3HMAbkiAHx6zB0ZgODUWYPNP4RF4ePKvFwwhTULdXzB
5ibS+HWlG6Gljv3TV+e5dOA34f4FWNcwskfRzlOGWkXhJM6zcu3mPvAQQfwCs7QExuFPw1Mj
EqjZmI+CjQHYAwwX0eE0xUzfE/4wXS3FjZs02syPyGoxO7DKzKkQzqyUbIFSVV5sp4AkZyPa
m1NccGtlXSaeLvxbn43gCW3nHVF+GJ7EzTdpWPlNGcDOT0K5JLsJ1wVdYAdQvJ81C1VtH+4e
fxwVbz8+756NSzTXPMxV3kUVJ3DGak6xN1oew/JqjeG4F2G4sw8RAfCvFHOYS7TJtZVKS2bs
OMHeIEwTOGGT8EZKn14BAyk3NAOS1Riwcsz57Ssr3/efn7egHD0/vr3uH5gzMUvnLCshOMcg
ENGfM8ay9xANi9Nb6+DnmoRHDYLi4RJseTJEczwE4ebIAwk4vZGfLg6RjNX7s26THeIIY1d/
RfxE6omTa7lmuCTlyF2nRcHoR4jVhtV1OBA2suN3qqY4h50cMhobGSSb9Ummqyfkge/R/jAS
Ip86klyanvmglbGsGTZiEwvaT79Ey0y+U1RwG3mQ+q8D7MEQ9rFXhQj1Gxo4aLzijhJK/qzN
ZRVrF2MXclodLsGXVpml1+SYtH7GD5/GcurjiMWl/v6E0UOBIorCG4Ie3sUhf6Q+VQe/0j8/
/WB7TcXqsNY/m8t8A2s2OqjSIFmRwkGz6aKiOD3dTOSatOoXV2mbdzfpT8u9jDhrCocAA8MW
nGCKaG2L87NaapHIzVSEPGfcQAr+GREZCddyIudRSHdQkRoIf2GsiG5ZTdin2Osxz0p0plps
WI+f+jrPJV6B06V5c23nCLOQVTvPepq6nbtkm9P3F8At8a45jfCtfjCiGx8DVlF9TnaYiMdS
NA33Hg6kH3vDi6miPtK9EZbDX2qnC7wkr6S2pkO7OGpZ6l7TamEDI1t8oXual6MvaGK9v3/Q
Xnq3X3e33/YP91YsbHo3t18llJOzPMTXn3633st7vNw0aNw7jhjfCwl/xEJd+/Xx1LpoEF0w
S1rd8MTGMOoXOm36NE8LbAOZ7CVGRMsmZTP0THPGZA7MQmKyA2vF0JMJ2QVxWON0BWpoEeFL
iCJPDFsQsEkyWUxgMXte26SZl2RXxSnr0KHSXKK98NyJa61fkEQWFo+JjtMyF45PJfQJDQaj
vNpEywVZciqZeBRoDYVhzI29ceo5tRe9zR8f2TZSEXpHNI7GGB07glXUhZclUZc2bed+5YQy
wZ/DC6LLYwkDHEDOr9nMajbBCfOpUOupda4p5hOvr4A94zVPV8CPrNd0kDWH26yRwHp51TdW
1qS0cdroqdGPnKF0rkQRl7k7Pj2KN3xCKJra+/AblIRB3XHV3Bst13tQ3mwLoVzJnh3XCLXM
t1xqtn28pRaBOfrNDYL9393m3LFT6aHkXlRxu68nSIVtE9MDhcqZsgDaLGG3ssump8EUqwdq
m0d/BZW5czv2uFvc2N7TFmIOCGsbGfbAPACDQBF3dZmVjshvQ/FJ+3wCBVVaqHm0dH6QcVhD
IV9tm8cGDpta4tLmYN0qt1290FL7SmSecbWo6zJKgQ0S01bCebamjCW2h5AGoS1857BGhDtp
UArqG4UP7oCHL5qlh0MEFEFv1L49KeIE+m413dkJ8A5rYnI0HY8yQfZyS7oWYdhvLZu2IuKy
qhl8A+MTl+viAEl9XUSETkoVRITmqbTnuE+CWMziybS3Xqdlk83d7hVlYSgxaHHlYpUMQP1x
wmCifMiYHO++bN++v2JIhdf9/dvj28vRD/08vX3ebY8wFN//W3cw8DHeMnT5/LpBx5qzAFPj
5bnGOuGxLDQ600MvxGLiaHCKSifyGzpEgkuBhCQiA6kwx8E9t2xuEEGqMm93Uy8yvY+tk6Rq
O+WO46UtHGTl3P3FnBhFhqbWVpnZTdcIOxK6usQ7GKvcvErhiLAqTXPnN/xIYquKMo3JYQsk
JGu/tlE9Q6HJkdBIGjNc6yqurZtWA13IBmP5lEls7/6kLBorY5QNPf/blkcIhJ4GMBSO2xHZ
WsSyKh0Y5e5z5JAhfoondrpGJEZaJ+jT8/7h9ZsOPPJj93IfmjiRSLuirFuOgqHBEUbO5jOZ
khEuiHaLDETXbLAo+DhJcdmmsvl0Msxlr9wEJZxYZlFl2ZimxDITnDVSfF0IzAsYOEiA3jYv
UV+TSgEJp1XTNx38u8KoxbUTR3hy6Ibr+/333R+v+x+9uvBCpLca/hwOtK6rv+INYOji0kbu
u4SFrUE85kwELJJ4LVRyMvH9vEmYrxcx7MtIpZX9lCwLsprIW3z1WUo7OwUlGydfpU/nxxcz
24AKCoEjEp1iWYtqJUWsc5TVjhSzBDimGUjh1IalxnxZVrA0kbGlRZYWzpbV/QMNkYz+8rTO
RWOf8D6GWt6VRWbtXjp+1qLoM6kDv6Hzv/Y73cPD4YUDLYIxQbsqzJUAjJFXNn91vfxmZ5zr
N3W8+/x2f4+mT+nDy+vzG0aetP0vBV5tgO5rB3CxgIPZlZ7aT+//PuaodGAUf3gDIz8tMS1i
x/cdf3MXK+Zwb+e1wBAQRdrgXIrM8QkiLGfwSV+NZ5a1O39phNyeoM+QDPrXZxqxDe2GwmyF
HjgVCIwYmdt9BtWlIJ6OSE6lxm9BiPJucOhip0zrspi6zRiLhv3D7V9NoMpYoC+gJ7IjSvuG
1RNg5kx28YkjAbs4imo3WTI6WUzhVNTSvg9H0VDo6EKc0ytL3nMsc34c+8XWmeAWJ63mfmmA
8I7GjmGTDGayEdrwsq0db64aGGfco2QRD3zUK/yKT+ZpBGJNk6qmFRnzsUZMNkznsyH7S2a9
alaFmgXHrq2NLmrbLt1DULoXsbAfgCJqu8YG9wdeaT7VyE4IUbboO8ud2xpPJ4L0i6NRtxeB
viUVtW8f7Fqfjpvem9+ljovVawdAdFQ+Pr28O8K43m9Pmosvtw/3zvVfAVwVTp7S0ZkcMDpc
t3KMJaaRJF+2zaf31tlaJg1eoKGixmT4sCYWkd0SQ6U0ouZW7PoSjjo4COPeqmVwID/UK20i
D0fW3RueUzZzHNtI631SfyBsL/m435BLLDstXI3+KsbRWklZeQxUX86iAd54LPzfy9P+AY3y
oI8/3l53f+/gj93r7Z9//vkvK3YkOq1T2QuSvn2pvlLlle26bn+GXfFZHqr/bSM3MmCUJiNx
cBzx5Ou1xgAvK9eVsG8J+prWtePlqaHUME91QxgoGyFP6BGTDEU0JcrZdSanvsYxI0uJ/lzh
n9qoUbCKm1bJwPR1oBp7fMiZ43+Z5eHiR2FWINjVSeawLmIchLR7RzIjDGHXFmg3BAtZX4Ie
OLFX+mD6OQUc63C21ByHsw4nRz2x2NA3LfrcbV+3Ryjz3OLTRaBw4DMIw/99d3F3cS7CLyjs
QQpHPvMVHcZFR2JIVFI429Q18T/YYrfyCDQhEPZAFB0ywYLEwApltBtVZN0m2cvK7gPKHJiT
cMrUGvHetxYGT0rSTwb+PDt2vlROYAcEycvR8GGM3en0wx9h4M5amVCMGmGOV2jJsmzQSUPf
CJoghPxOA4Iium5KNnYQxRKGhju+OTCgSVtovekwdqFEteRpjEqeeAPDILt12izxjsZXM3p0
TkIgEOCLlUeCwQVoUpCSFDS/kKj/UJdiLRNqNcXz9Jqoa41c1kxXMX5KPcpsQvTOWYDzAYoC
3lmiyumPj1UUMeY1ENrXaBWI3HmFsTj5bgX1mcspv6KekLmZClicN+G8P/fYrjCly/hmpy5B
XEmYghxRYGjreA+whrV6qP5+OfRTzjGhfk7rAkTaZRlOtkEMsq878Lr8OTB3mDXgLAmGinL4
oIOT5GvFPqBqtCiAYwp8sNbfeaEEDRUsX4PnHQN1pQdGRmsZBwhaqGwupzPxmA2pCZyF0Q96
IxS+E0zwTrPS3IcOfH3vo5HX/ijrrTOE07McHc2K7+bAuJa5ULz/mb2Lfp1yqh/cIqfbxkM9
xl6IjJ5mcCatDRlhgtp+fn0OuGoL+5mGfnoHjobJjaDcSN6VeX8I45VmqfoRdMKRVTlPZN2J
J8QUp8uzZ6SQDdk6cXT8PqWLpqFhrNDmXVXb19fN7uUVBTlUPyLMQ7y9t+LpD6rxCsY40DlB
wcOh15NTufokIPjlAccCGjzgMNMalgUXsxB0aV+iqGl+uP1kKfA64F+tOb17uas9bnuaQHvZ
Pv84O+F1LaHys5OuauI2Z03azEJIUeUyx1EaO+xWl6EFWbyPoxMLGHctD0mta97KrdcO8Jau
v4s6QCYTPuBd3yKZldGkO1ypZI1pEOzDtgd1GGSrxgCPXY1/TZEMFF1jB9MeiSLRtBxcf1Ol
00jZzK/swP8WmjyPgSA/cQLYWRQN6x01tgqOq0CaDNaIt7/YvfRfM2vm8+lEAgA=

--qDbXVdCdHGoSgWSk--
