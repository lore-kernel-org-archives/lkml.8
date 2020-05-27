Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAEEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C02F2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgE0XYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 19:24:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:53318 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE0XYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 19:24:44 -0400
IronPort-SDR: +oEe0FXf4nwCo05Me466O9FlQmw2/cwILNSIr+ew9degc8T+oHu6WZPPSLWcOZpthWrFPoq1GK
 kaRdOhX/peCw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 16:23:25 -0700
IronPort-SDR: oK0riTk2t697VwRYVuzx4Xi3PKKAGx+1CifU9cnRCBv6EOj1mggilVapLlBqSTgpKWc/2RW1kB
 aQuvoKJWkKpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="gz'50?scan'50,208,50";a="284970346"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 May 2020 16:23:23 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1je5OM-000FwV-Oo; Thu, 28 May 2020 07:23:22 +0800
Date:   Thu, 28 May 2020 07:23:08 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/tty/serial/ucc_uart.c:1001:29: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202005280754.prZeXen4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b0c3ba31be3e45a130e13b278cf3b90f69bda6f6
commit: 461c3ac0dc46ba7fc09628aadf63c81253c4c3de soc: fsl: qe: fix sparse warnings for ucc_slow.c
date:   9 weeks ago
config: arm64-randconfig-s031-20200527 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-240-gf0fe1cd9-dirty
        git checkout 461c3ac0dc46ba7fc09628aadf63c81253c4c3de
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=arm64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/tty/serial/ucc_uart.c:637:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:637:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:637:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:638:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:638:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:638:9: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:639:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:639:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:639:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:653:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ucc_uart_pram *uccup @@     got struct ucc_uart_pram [noderef] <asn:2> *uccup @@
   drivers/tty/serial/ucc_uart.c:653:46: sparse:     expected struct ucc_uart_pram *uccup
   drivers/tty/serial/ucc_uart.c:653:46: sparse:     got struct ucc_uart_pram [noderef] <asn:2> *uccup
   drivers/tty/serial/ucc_uart.c:661:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:661:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:661:9: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:662:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:662:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:662:9: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:663:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:663:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:663:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:664:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:664:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:664:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:665:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:665:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:665:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:666:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:666:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:666:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:667:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:667:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:667:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:668:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:668:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:668:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:669:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:669:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:669:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:670:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:670:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:670:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:671:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:671:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:671:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:672:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:672:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:672:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:674:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:674:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:674:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:675:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:675:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:675:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:713:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:713:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:713:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:714:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:714:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:714:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:715:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:715:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:715:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:716:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:716:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:716:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:717:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:717:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:717:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:718:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:718:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:718:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:719:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:719:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:719:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:720:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:720:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:720:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:721:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:721:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:721:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:722:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:722:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:722:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:724:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:724:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:724:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:726:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:726:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:726:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:727:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:727:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:727:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:728:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:728:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:728:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:1000:27: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/tty/serial/ucc_uart.c:1000:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ucc_uart_pram [noderef] <asn:2> *uccup @@     got struct ucc_uart_pram * @@
   drivers/tty/serial/ucc_uart.c:1000:24: sparse:     expected struct ucc_uart_pram [noderef] <asn:2> *uccup
   drivers/tty/serial/ucc_uart.c:1000:24: sparse:     got struct ucc_uart_pram *
>> drivers/tty/serial/ucc_uart.c:1001:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd *rx_bd_base @@     got struct qe_bd [noderef] <asn:2> *rx_bd @@
   drivers/tty/serial/ucc_uart.c:1001:29: sparse:     expected struct qe_bd *rx_bd_base
   drivers/tty/serial/ucc_uart.c:1001:29: sparse:     got struct qe_bd [noderef] <asn:2> *rx_bd
>> drivers/tty/serial/ucc_uart.c:1002:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd *tx_bd_base @@     got struct qe_bd [noderef] <asn:2> *tx_bd @@
   drivers/tty/serial/ucc_uart.c:1002:29: sparse:     expected struct qe_bd *tx_bd_base
   drivers/tty/serial/ucc_uart.c:1002:29: sparse:     got struct qe_bd [noderef] <asn:2> *tx_bd

vim +1001 drivers/tty/serial/ucc_uart.c

d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   976  
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   977  /*
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   978   * Allocate any memory and I/O resources required by the port.
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   979   */
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   980  static int qe_uart_request_port(struct uart_port *port)
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   981  {
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   982  	int ret;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   983  	struct uart_qe_port *qe_port =
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   984  		container_of(port, struct uart_qe_port, port);
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   985  	struct ucc_slow_info *us_info = &qe_port->us_info;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   986  	struct ucc_slow_private *uccs;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   987  	unsigned int rx_size, tx_size;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   988  	void *bd_virt;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   989  	dma_addr_t bd_dma_addr = 0;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   990  
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   991  	ret = ucc_slow_init(us_info, &uccs);
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   992  	if (ret) {
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   993  		dev_err(port->dev, "could not initialize UCC%u\n",
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   994  		       qe_port->ucc_num);
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   995  		return ret;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   996  	}
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   997  
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   998  	qe_port->us_private = uccs;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15   999  	qe_port->uccp = uccs->us_regs;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1000  	qe_port->uccup = (struct ucc_uart_pram *) uccs->us_pram;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15 @1001  	qe_port->rx_bd_base = uccs->rx_bd;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15 @1002  	qe_port->tx_bd_base = uccs->tx_bd;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1003  
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1004  	/*
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1005  	 * Allocate the transmit and receive data buffers.
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1006  	 */
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1007  
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1008  	rx_size = L1_CACHE_ALIGN(qe_port->rx_nrfifos * qe_port->rx_fifosize);
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1009  	tx_size = L1_CACHE_ALIGN(qe_port->tx_nrfifos * qe_port->tx_fifosize);
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1010  
8b05cefca73bfb drivers/serial/ucc_uart.c Becky Bruce 2008-09-12  1011  	bd_virt = dma_alloc_coherent(port->dev, rx_size + tx_size, &bd_dma_addr,
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1012  		GFP_KERNEL);
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1013  	if (!bd_virt) {
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1014  		dev_err(port->dev, "could not allocate buffer descriptors\n");
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1015  		return -ENOMEM;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1016  	}
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1017  
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1018  	qe_port->bd_virt = bd_virt;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1019  	qe_port->bd_dma_addr = bd_dma_addr;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1020  	qe_port->bd_size = rx_size + tx_size;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1021  
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1022  	qe_port->rx_buf = bd_virt;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1023  	qe_port->tx_buf = qe_port->rx_buf + rx_size;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1024  
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1025  	return 0;
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1026  }
d7584ed2b994a5 drivers/serial/ucc_uart.c Timur Tabi  2008-01-15  1027  

:::::: The code at line 1001 was first introduced by commit
:::::: d7584ed2b994a572326650b0c4d2c25961e6f49d [POWERPC] qe-uart: add support for Freescale QUICCEngine UART

:::::: TO: Timur Tabi <timur@freescale.com>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--EeQfGwPcQSOJBaQU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
GtH9lzh/xHNJKSvG2keAr+XAKiEMA76EZe3FtWxx7DicL/ie6ReFNyM63RRDfVgrmMtagmE5
dGGFsDbwuqmIlvhvInY91mlNUzdOQLYJU6mBv+q20f6XL0KlrdxtJwlvvCA3Y7lfsyNsUDOc
17qK5ZHN761V3cqpwvGqtWyVctVN6iVy17WdSiDUhC9FtLe+z9ougqX6NheYJ+5BdF1ewBYb
0CbCn7isHAUw+D2m6/9WToAAS9YUILIAU5xUAiaBj8ZyIwI38tArxTZZFxMia9cQn0z2bVYW
ocNyUBqFTRu3RUh01n+XwyUHxcU7Et09tDbQ/ZeXw1mL7Nmz9nZEu18h8HXs1pnN8AZkHofK
eLlmgfbOj1GjATfipdzk+PMJLTvII2urMoNQ7GO8XJn4gTfhOtds66omPKfW1f8aGjNy1pxa
lUkQTfxRhN01Npo/GzuqpvQJP0bh1kqhOOsEYyeHnjbfns7H16fDX+QGo6Q6GyJ8IoSGj3l4
Or4MZtxwFPN1UuTrfhTZDVa/2u6bqo1N5Dh0/DLlqBp0zrtv/gWeXl4e5T315UBbsWqMknUv
2EJIFYal2dQtj27BSh3cTfBoZVTOScz4apH72OvpLJmII+MhKvDwDpSCdz76GhBMbEnEJHJt
wJSKG8gpCQAX72oACGyA67iEJWjrAu4CV28uVqvYFsseoYxuUdYzd+ClYSRnnVrfzt8O78CN
MUzUvHZCp1zSTan22Pe1tFjJDRhNyrSW/Bf/Sq2s7RGmJkNTFy4xwlLf9g5goPzCl0if5iGC
EG/F+nuQp4aO5CmR/vRXe2ezmoKhLGusMfYpHPB3y1XtOSHK4/c6lixjOADQkjqgtXcNxvnC
P7+Ab6fh8At/Zs5ffFwSYjODTn8dn+F+JhfpzePxXbv8GmSoWEebV8vTuJF/28xy9n4Zlbnr
sdFLavBL17e6WYD/MfwoJZqFQ8SdYidLZxkpSYkW9rYI/MLZ2X7UPmjmTzvkmhHRDjjocn7G
QZfeuQ/PryB3Y9cvCJ1nEd318nKvoktWSbWpi4xdnm1WIg8OZbGbOSF2Oqoh5AmxrB368K8g
3NttK7d7HC5FfWNWEKQlbhSQ1yqumYhHb3mvJdsy2/OBCMFLxHf0oc8gCtIP8lhLDKBGmYwt
D/Cg2b5oOcVowIIaGZgW4p5ScCbQO0Kr4C/YoQgAjUIryaezsGtrzl5ENdQovZrHGvDo/vD1
+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

--EeQfGwPcQSOJBaQU--
