Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4EBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CBA207F7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgFEFyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 01:54:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:44527 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgFEFyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 01:54:06 -0400
IronPort-SDR: fDB2dBAhVZjsYsmp1dEPk2ovzWgMhb7ooTIknazw/sIszovwpteJAm5FbIhbY5dGPwqHpouHXM
 DGfCozPmFeqw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 22:52:30 -0700
IronPort-SDR: pTeK94snVpfQQQuXpiqph7qUk/b8B6F9ORsXZ2ew5+OsWI96SI/eZ6NXp2LOIqQY8uuE/zHUzb
 Gt9iC2aTr0Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,475,1583222400"; 
   d="gz'50?scan'50,208,50";a="273364127"
Received: from lkp-server02.sh.intel.com (HELO 85fa322b0eb2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Jun 2020 22:52:29 -0700
Received: from kbuild by 85fa322b0eb2 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jh5HI-00006M-Lp; Fri, 05 Jun 2020 05:52:28 +0000
Date:   Fri, 5 Jun 2020 13:51:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Timur Tabi <timur@kernel.org>
Subject: drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202006051344.APPFfjro%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   435faf5c218a47fd6258187f62d9bb1009717896
commit: 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5 soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
date:   6 months ago
config: arm-randconfig-s031-20200605 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-246-g41f651b4-dirty
        git checkout 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=arm CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
>> drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
>> drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
>> drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
>> drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:286:6: sparse: sparse: symbol 'qe_uart_set_mctrl' was not declared. Should it be static?
   drivers/tty/serial/ucc_uart.c:349:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:349:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:349:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:352:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:352:21: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:352:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:352:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:352:21: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:352:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:352:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:352:21: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:352:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:352:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:352:21: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:352:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:371:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:371:18: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:371:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:371:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:371:18: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:371:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:371:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:371:18: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:371:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:371:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:371:18: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:371:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:384:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:384:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:384:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:385:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:385:17: sparse:     expected void const volatile [noderef] <asn:2> *
   drivers/tty/serial/ucc_uart.c:385:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:385:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:385:17: sparse:     expected void const volatile [noderef] <asn:2> *

vim +264 drivers/tty/serial/ucc_uart.c

d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  248  
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  249  /*
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  250   * Return 1 if the QE is done transmitting all buffers for this port
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  251   *
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  252   * This function scans each BD in sequence.  If we find a BD that is not
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  253   * ready (READY=1), then we return 0 indicating that the QE is still sending
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  254   * data.  If we reach the last BD (WRAP=1), then we know we've scanned
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  255   * the entire list, and all BDs are done.
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  256   */
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  257  static unsigned int qe_uart_tx_empty(struct uart_port *port)
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  258  {
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  259  	struct uart_qe_port *qe_port =
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  260  		container_of(port, struct uart_qe_port, port);
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  261  	struct qe_bd *bdp = qe_port->tx_bd_base;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  262  
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  263  	while (1) {
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28 @264  		if (qe_ioread16be(&bdp->status) & BD_SC_READY)
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  265  			/* This BD is not done, so return "not done" */
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  266  			return 0;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  267  
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  268  		if (qe_ioread16be(&bdp->status) & BD_SC_WRAP)
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  269  			/*
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  270  			 * This BD is done and it's the last one, so return
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  271  			 * "done"
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  272  			 */
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  273  			return 1;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  274  
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  275  		bdp++;
fc811472c2167c drivers/tty/serial/ucc_uart.c Joe Perches      2013-10-08  276  	}
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  277  }
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  278  

:::::: The code at line 264 was first introduced by commit
:::::: 8b1cdc4033bd1659c5499c918d4e59bf8253abec serial: ucc_uart: replace ppc-specific IO accessors

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Li Yang <leoyang.li@nxp.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--W/nzBZO5zC0uMSeA
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--W/nzBZO5zC0uMSeA--
