Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446A8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 01:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ABB120738
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 01:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHBBmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 21:42:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:8536 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgHBBmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 21:42:52 -0400
IronPort-SDR: tipXHHb+ph7IyWQf/YQ620ASu4XaDsQGNE5TvCU4DyLdn7LY5VDGry20MOc4IzcxQGbyRxTIsN
 xwXYGM+GrYVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9700"; a="139927390"
X-IronPort-AV: E=Sophos;i="5.75,424,1589266800"; 
   d="gz'50?scan'50,208,50";a="139927390"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2020 18:42:27 -0700
IronPort-SDR: nqjl7Ex6bUQyytOoMSqxPOf7L5kziWVzk8CWe9a4fjeNfXSMkDDaIwYoFIR72U8SlnqpqfGRng
 9FgvAY9e1oXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,424,1589266800"; 
   d="gz'50?scan'50,208,50";a="329655529"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Aug 2020 18:42:07 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k230o-0001Sv-Hk; Sun, 02 Aug 2020 01:42:06 +0000
Date:   Sun, 2 Aug 2020 09:41:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/nxp/lpc_eth.c:561:35: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202008020922.EakmwwA0%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d52daa8620c65960e1ef882adc1f92061326bd7a
commit: 35974a7cc23c5deb5597c0a42183172498c4a0a8 net: lpc-enet: allow compile testing
date:   12 months ago
config: nios2-randconfig-s031-20200802 (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-115-g5fc204f2-dirty
        git checkout 35974a7cc23c5deb5597c0a42183172498c4a0a8
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/nxp/lpc_eth.c:561:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] packet @@     got unsigned int @@
>> drivers/net/ethernet/nxp/lpc_eth.c:561:35: sparse:     expected restricted __le32 [usertype] packet
>> drivers/net/ethernet/nxp/lpc_eth.c:561:35: sparse:     got unsigned int
   drivers/net/ethernet/nxp/lpc_eth.c:572:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] packet @@     got unsigned int @@
   drivers/net/ethernet/nxp/lpc_eth.c:572:35: sparse:     expected restricted __le32 [usertype] packet
   drivers/net/ethernet/nxp/lpc_eth.c:572:35: sparse:     got unsigned int
>> drivers/net/ethernet/nxp/lpc_eth.c:574:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got int @@
>> drivers/net/ethernet/nxp/lpc_eth.c:574:36: sparse:     expected restricted __le32 [usertype] control
>> drivers/net/ethernet/nxp/lpc_eth.c:574:36: sparse:     got int
>> drivers/net/ethernet/nxp/lpc_eth.c:900:31: sparse: sparse: restricted __le32 degrades to integer
>> drivers/net/ethernet/nxp/lpc_eth.c:903:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ethst @@     got restricted __le32 [usertype] statusinfo @@
>> drivers/net/ethernet/nxp/lpc_eth.c:903:23: sparse:     expected unsigned int [usertype] ethst
>> drivers/net/ethernet/nxp/lpc_eth.c:903:23: sparse:     got restricted __le32 [usertype] statusinfo
>> drivers/net/ethernet/nxp/lpc_eth.c:909:41: sparse: sparse: incorrect type in initializer (different base types) @@     expected int si @@     got restricted __le32 [usertype] statusinfo @@
>> drivers/net/ethernet/nxp/lpc_eth.c:909:41: sparse:     expected int si
   drivers/net/ethernet/nxp/lpc_eth.c:909:41: sparse:     got restricted __le32 [usertype] statusinfo
>> drivers/net/ethernet/nxp/lpc_eth.c:1051:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] control @@     got unsigned int @@
   drivers/net/ethernet/nxp/lpc_eth.c:1051:28: sparse:     expected restricted __le32 [usertype] control
   drivers/net/ethernet/nxp/lpc_eth.c:1051:28: sparse:     got unsigned int
   drivers/net/ethernet/nxp/lpc_eth.c:1308:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:2> **mapbase @@     got void ** @@
   drivers/net/ethernet/nxp/lpc_eth.c:1308:42: sparse:     expected void [noderef] <asn:2> **mapbase
>> drivers/net/ethernet/nxp/lpc_eth.c:1308:42: sparse:     got void **
   drivers/net/ethernet/nxp/lpc_eth.c: note: in included file (through arch/nios2/include/asm/io.h, include/linux/io.h, arch/nios2/include/asm/pgtable.h, ...):
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]

vim +561 drivers/net/ethernet/nxp/lpc_eth.c

b7370112f5195a stigge@antcom.de 2012-03-08  521  
b7370112f5195a stigge@antcom.de 2012-03-08  522  /* Setup TX/RX descriptors */
b7370112f5195a stigge@antcom.de 2012-03-08  523  static void __lpc_txrx_desc_setup(struct netdata_local *pldat)
b7370112f5195a stigge@antcom.de 2012-03-08  524  {
b7370112f5195a stigge@antcom.de 2012-03-08  525  	u32 *ptxstat;
b7370112f5195a stigge@antcom.de 2012-03-08  526  	void *tbuff;
b7370112f5195a stigge@antcom.de 2012-03-08  527  	int i;
b7370112f5195a stigge@antcom.de 2012-03-08  528  	struct txrx_desc_t *ptxrxdesc;
b7370112f5195a stigge@antcom.de 2012-03-08  529  	struct rx_status_t *prxstat;
b7370112f5195a stigge@antcom.de 2012-03-08  530  
b7370112f5195a stigge@antcom.de 2012-03-08  531  	tbuff = PTR_ALIGN(pldat->dma_buff_base_v, 16);
b7370112f5195a stigge@antcom.de 2012-03-08  532  
b7370112f5195a stigge@antcom.de 2012-03-08  533  	/* Setup TX descriptors, status, and buffers */
b7370112f5195a stigge@antcom.de 2012-03-08  534  	pldat->tx_desc_v = tbuff;
b7370112f5195a stigge@antcom.de 2012-03-08  535  	tbuff += sizeof(struct txrx_desc_t) * ENET_TX_DESC;
b7370112f5195a stigge@antcom.de 2012-03-08  536  
b7370112f5195a stigge@antcom.de 2012-03-08  537  	pldat->tx_stat_v = tbuff;
b7370112f5195a stigge@antcom.de 2012-03-08  538  	tbuff += sizeof(u32) * ENET_TX_DESC;
b7370112f5195a stigge@antcom.de 2012-03-08  539  
b7370112f5195a stigge@antcom.de 2012-03-08  540  	tbuff = PTR_ALIGN(tbuff, 16);
b7370112f5195a stigge@antcom.de 2012-03-08  541  	pldat->tx_buff_v = tbuff;
b7370112f5195a stigge@antcom.de 2012-03-08  542  	tbuff += ENET_MAXF_SIZE * ENET_TX_DESC;
b7370112f5195a stigge@antcom.de 2012-03-08  543  
b7370112f5195a stigge@antcom.de 2012-03-08  544  	/* Setup RX descriptors, status, and buffers */
b7370112f5195a stigge@antcom.de 2012-03-08  545  	pldat->rx_desc_v = tbuff;
b7370112f5195a stigge@antcom.de 2012-03-08  546  	tbuff += sizeof(struct txrx_desc_t) * ENET_RX_DESC;
b7370112f5195a stigge@antcom.de 2012-03-08  547  
b7370112f5195a stigge@antcom.de 2012-03-08  548  	tbuff = PTR_ALIGN(tbuff, 16);
b7370112f5195a stigge@antcom.de 2012-03-08  549  	pldat->rx_stat_v = tbuff;
b7370112f5195a stigge@antcom.de 2012-03-08  550  	tbuff += sizeof(struct rx_status_t) * ENET_RX_DESC;
b7370112f5195a stigge@antcom.de 2012-03-08  551  
b7370112f5195a stigge@antcom.de 2012-03-08  552  	tbuff = PTR_ALIGN(tbuff, 16);
b7370112f5195a stigge@antcom.de 2012-03-08  553  	pldat->rx_buff_v = tbuff;
b7370112f5195a stigge@antcom.de 2012-03-08  554  	tbuff += ENET_MAXF_SIZE * ENET_RX_DESC;
b7370112f5195a stigge@antcom.de 2012-03-08  555  
b7370112f5195a stigge@antcom.de 2012-03-08  556  	/* Map the TX descriptors to the TX buffers in hardware */
b7370112f5195a stigge@antcom.de 2012-03-08  557  	for (i = 0; i < ENET_TX_DESC; i++) {
b7370112f5195a stigge@antcom.de 2012-03-08  558  		ptxstat = &pldat->tx_stat_v[i];
b7370112f5195a stigge@antcom.de 2012-03-08  559  		ptxrxdesc = &pldat->tx_desc_v[i];
b7370112f5195a stigge@antcom.de 2012-03-08  560  
b7370112f5195a stigge@antcom.de 2012-03-08 @561  		ptxrxdesc->packet = __va_to_pa(
b7370112f5195a stigge@antcom.de 2012-03-08  562  				pldat->tx_buff_v + i * ENET_MAXF_SIZE, pldat);
b7370112f5195a stigge@antcom.de 2012-03-08  563  		ptxrxdesc->control = 0;
b7370112f5195a stigge@antcom.de 2012-03-08  564  		*ptxstat = 0;
b7370112f5195a stigge@antcom.de 2012-03-08  565  	}
b7370112f5195a stigge@antcom.de 2012-03-08  566  
b7370112f5195a stigge@antcom.de 2012-03-08  567  	/* Map the RX descriptors to the RX buffers in hardware */
b7370112f5195a stigge@antcom.de 2012-03-08  568  	for (i = 0; i < ENET_RX_DESC; i++) {
b7370112f5195a stigge@antcom.de 2012-03-08  569  		prxstat = &pldat->rx_stat_v[i];
b7370112f5195a stigge@antcom.de 2012-03-08  570  		ptxrxdesc = &pldat->rx_desc_v[i];
b7370112f5195a stigge@antcom.de 2012-03-08  571  
b7370112f5195a stigge@antcom.de 2012-03-08  572  		ptxrxdesc->packet = __va_to_pa(
b7370112f5195a stigge@antcom.de 2012-03-08  573  				pldat->rx_buff_v + i * ENET_MAXF_SIZE, pldat);
b7370112f5195a stigge@antcom.de 2012-03-08 @574  		ptxrxdesc->control = RXDESC_CONTROL_INT | (ENET_MAXF_SIZE - 1);
b7370112f5195a stigge@antcom.de 2012-03-08  575  		prxstat->statusinfo = 0;
b7370112f5195a stigge@antcom.de 2012-03-08  576  		prxstat->statushashcrc = 0;
b7370112f5195a stigge@antcom.de 2012-03-08  577  	}
b7370112f5195a stigge@antcom.de 2012-03-08  578  
b7370112f5195a stigge@antcom.de 2012-03-08  579  	/* Setup base addresses in hardware to point to buffers and
b7370112f5195a stigge@antcom.de 2012-03-08  580  	 * descriptors
b7370112f5195a stigge@antcom.de 2012-03-08  581  	 */
b7370112f5195a stigge@antcom.de 2012-03-08  582  	writel((ENET_TX_DESC - 1),
b7370112f5195a stigge@antcom.de 2012-03-08  583  	       LPC_ENET_TXDESCRIPTORNUMBER(pldat->net_base));
b7370112f5195a stigge@antcom.de 2012-03-08  584  	writel(__va_to_pa(pldat->tx_desc_v, pldat),
b7370112f5195a stigge@antcom.de 2012-03-08  585  	       LPC_ENET_TXDESCRIPTOR(pldat->net_base));
b7370112f5195a stigge@antcom.de 2012-03-08  586  	writel(__va_to_pa(pldat->tx_stat_v, pldat),
b7370112f5195a stigge@antcom.de 2012-03-08  587  	       LPC_ENET_TXSTATUS(pldat->net_base));
b7370112f5195a stigge@antcom.de 2012-03-08  588  	writel((ENET_RX_DESC - 1),
b7370112f5195a stigge@antcom.de 2012-03-08  589  	       LPC_ENET_RXDESCRIPTORNUMBER(pldat->net_base));
b7370112f5195a stigge@antcom.de 2012-03-08  590  	writel(__va_to_pa(pldat->rx_desc_v, pldat),
b7370112f5195a stigge@antcom.de 2012-03-08  591  	       LPC_ENET_RXDESCRIPTOR(pldat->net_base));
b7370112f5195a stigge@antcom.de 2012-03-08  592  	writel(__va_to_pa(pldat->rx_stat_v, pldat),
b7370112f5195a stigge@antcom.de 2012-03-08  593  	       LPC_ENET_RXSTATUS(pldat->net_base));
b7370112f5195a stigge@antcom.de 2012-03-08  594  }
b7370112f5195a stigge@antcom.de 2012-03-08  595  

:::::: The code at line 561 was first introduced by commit
:::::: b7370112f5195ae2e2e52b5ef46961422fa4daf0 lpc32xx: Added ethernet driver

:::::: TO: stigge@antcom.de <stigge@antcom.de>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--SLDf9lqlvOQaIe6s
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
OfqFtZdBMKpxJOMiarEx3CL/B8M9ftWkogEA

--SLDf9lqlvOQaIe6s--
