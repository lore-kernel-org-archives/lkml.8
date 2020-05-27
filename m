Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D1AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D4020873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389202AbgE0OqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:46:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:52167 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730377AbgE0OqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:46:07 -0400
IronPort-SDR: VPZUsTibs8G19aeGrXRNqbhYL3pOmJiJoYDDd7jEb2MRomGsXM30CAM7uZlGF2nFtW+fAbSXOZ
 eoorDF5t3Auw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 07:04:47 -0700
IronPort-SDR: 0LQD7W3TbXOBplLKGeT/Cg1asQqBZsXasYWKUW3BIjqAnVoIED0qu+HflrxVZJTO1UJkVR9Btj
 G7Enbtzp2DPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="gz'50?scan'50,208,50";a="468719118"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 May 2020 07:04:43 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jdwfh-0000Ku-Rz; Wed, 27 May 2020 22:04:41 +0800
Date:   Wed, 27 May 2020 22:04:32 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Timur Tabi <timur@kernel.org>
Subject: drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202005272220.0hZcbdqj%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Rasmus,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   444fc5cde64330661bf59944c43844e7d4c2ccd8
commit: 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5 soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
date:   6 months ago
config: arm64-randconfig-s031-20200527 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-240-gf0fe1cd9-dirty
        git checkout 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=arm64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:286:6: sparse: sparse: symbol 'qe_uart_set_mctrl' was not declared. Should it be static?
>> drivers/tty/serial/ucc_uart.c:349:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:349:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:349:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:350:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:352:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:352:21: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:352:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:371:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:371:18: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:371:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:384:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:384:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:384:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:385:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:385:17: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:385:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:385:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:385:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:385:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:388:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:388:21: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:388:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:476:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:476:26: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:476:26: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:483:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:483:21: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:483:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:514:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:514:17: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:514:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:514:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:514:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:514:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:517:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:517:21: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:517:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:608:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:608:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:608:17: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:609:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:609:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:609:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:610:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:610:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:610:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:616:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:616:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:616:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:617:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:617:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:617:9: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:618:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:618:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:618:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:629:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:629:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:629:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:630:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:630:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:630:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:631:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:631:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:631:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:641:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:641:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:641:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:642:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:642:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:642:9: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:643:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:643:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:643:9: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:657:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ucc_uart_pram *uccup @@     got struct ucc_uart_pram [noderef] <asn:2> *uccup @@
   drivers/tty/serial/ucc_uart.c:657:46: sparse:     expected struct ucc_uart_pram *uccup
   drivers/tty/serial/ucc_uart.c:657:46: sparse:     got struct ucc_uart_pram [noderef] <asn:2> *uccup
>> drivers/tty/serial/ucc_uart.c:665:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:665:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:665:9: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:666:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:666:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:666:9: sparse:     got unsigned char *
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
   drivers/tty/serial/ucc_uart.c:673:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:673:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:673:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:674:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:674:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:674:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:675:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:675:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:675:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:676:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:676:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:676:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:678:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:678:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:678:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:679:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:679:9: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:679:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:717:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:717:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:717:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:718:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:718:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:718:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:719:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:719:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:719:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:720:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:720:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:720:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:721:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:721:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:721:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:722:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:722:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:722:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:723:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:723:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:723:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:724:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:724:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:724:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:725:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:725:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:725:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:726:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:726:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:726:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:728:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:728:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:728:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:730:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:730:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:730:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:731:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:731:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:731:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:732:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:732:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/tty/serial/ucc_uart.c:732:17: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:1004:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ucc_uart_pram [noderef] <asn:2> *uccup @@     got struct ucc_uart_pram * @@
   drivers/tty/serial/ucc_uart.c:1004:24: sparse:     expected struct ucc_uart_pram [noderef] <asn:2> *uccup
   drivers/tty/serial/ucc_uart.c:1004:24: sparse:     got struct ucc_uart_pram *

vim +264 drivers/tty/serial/ucc_uart.c

d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  248  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  249  /*
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  250   * Return 1 if the QE is done transmitting all buffers for this port
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  251   *
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  252   * This function scans each BD in sequence.  If we find a BD that is not
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  253   * ready (READY=1), then we return 0 indicating that the QE is still sending
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  254   * data.  If we reach the last BD (WRAP=1), then we know we've scanned
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  255   * the entire list, and all BDs are done.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  256   */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  257  static unsigned int qe_uart_tx_empty(struct uart_port *port)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  258  {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  259  	struct uart_qe_port *qe_port =
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  260  		container_of(port, struct uart_qe_port, port);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  261  	struct qe_bd *bdp = qe_port->tx_bd_base;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  262  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  263  	while (1) {
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28 @264  		if (qe_ioread16be(&bdp->status) & BD_SC_READY)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  265  			/* This BD is not done, so return "not done" */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  266  			return 0;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  267  
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  268  		if (qe_ioread16be(&bdp->status) & BD_SC_WRAP)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  269  			/*
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  270  			 * This BD is done and it's the last one, so return
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  271  			 * "done"
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  272  			 */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  273  			return 1;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  274  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  275  		bdp++;
fc811472c2167cc drivers/tty/serial/ucc_uart.c Joe Perches        2013-10-08  276  	}
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  277  }
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  278  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  279  /*
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  280   * Set the modem control lines
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  281   *
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  282   * Although the QE can control the modem control lines (e.g. CTS), we
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  283   * don't need that support. This function must exist, however, otherwise
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  284   * the kernel will panic.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  285   */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  286  void qe_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  287  {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  288  }
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  289  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  290  /*
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  291   * Get the current modem control line status
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  292   *
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  293   * Although the QE can control the modem control lines (e.g. CTS), this
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  294   * driver currently doesn't support that, so we always return Carrier
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  295   * Detect, Data Set Ready, and Clear To Send.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  296   */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  297  static unsigned int qe_uart_get_mctrl(struct uart_port *port)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  298  {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  299  	return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  300  }
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  301  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  302  /*
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  303   * Disable the transmit interrupt.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  304   *
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  305   * Although this function is called "stop_tx", it does not actually stop
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  306   * transmission of data.  Instead, it tells the QE to not generate an
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  307   * interrupt when the UCC is finished sending characters.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  308   */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  309  static void qe_uart_stop_tx(struct uart_port *port)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  310  {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  311  	struct uart_qe_port *qe_port =
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  312  		container_of(port, struct uart_qe_port, port);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  313  
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  314  	qe_clrbits_be16(&qe_port->uccp->uccm, UCC_UART_UCCE_TX);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  315  }
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  316  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  317  /*
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  318   * Transmit as many characters to the HW as possible.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  319   *
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  320   * This function will attempt to stuff of all the characters from the
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  321   * kernel's transmit buffer into TX BDs.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  322   *
af901ca181d92aa drivers/serial/ucc_uart.c     André Goddard Rosa 2009-11-14  323   * A return value of non-zero indicates that it successfully stuffed all
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  324   * characters from the kernel buffer.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  325   *
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  326   * A return value of zero indicates that there are still characters in the
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  327   * kernel's buffer that have not been transmitted, but there are no more BDs
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  328   * available.  This function should be called again after a BD has been made
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  329   * available.
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  330   */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  331  static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  332  {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  333  	struct qe_bd *bdp;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  334  	unsigned char *p;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  335  	unsigned int count;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  336  	struct uart_port *port = &qe_port->port;
ebd2c8f6d2ec401 drivers/serial/ucc_uart.c     Alan Cox           2009-09-19  337  	struct circ_buf *xmit = &port->state->xmit;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  338  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  339  	bdp = qe_port->rx_cur;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  340  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  341  	/* Handle xon/xoff */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  342  	if (port->x_char) {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  343  		/* Pick next descriptor and fill from buffer */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  344  		bdp = qe_port->tx_cur;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  345  
09a39ec9decd99e drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  346  		p = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  347  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  348  		*p++ = port->x_char;
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28 @349  		qe_iowrite16be(1, &bdp->length);
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  350  		qe_setbits_be16(&bdp->status, BD_SC_READY);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  351  		/* Get next BD. */
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  352  		if (qe_ioread16be(&bdp->status) & BD_SC_WRAP)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  353  			bdp = qe_port->tx_bd_base;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  354  		else
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  355  			bdp++;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  356  		qe_port->tx_cur = bdp;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  357  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  358  		port->icount.tx++;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  359  		port->x_char = 0;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  360  		return 1;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  361  	}
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  362  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  363  	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  364  		qe_uart_stop_tx(port);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  365  		return 0;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  366  	}
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  367  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  368  	/* Pick next descriptor and fill from buffer */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  369  	bdp = qe_port->tx_cur;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  370  
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  371  	while (!(qe_ioread16be(&bdp->status) & BD_SC_READY) &&
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  372  	       (xmit->tail != xmit->head)) {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  373  		count = 0;
09a39ec9decd99e drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  374  		p = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  375  		while (count < qe_port->tx_fifosize) {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  376  			*p++ = xmit->buf[xmit->tail];
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  377  			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  378  			port->icount.tx++;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  379  			count++;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  380  			if (xmit->head == xmit->tail)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  381  				break;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  382  		}
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  383  
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  384  		qe_iowrite16be(count, &bdp->length);
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  385  		qe_setbits_be16(&bdp->status, BD_SC_READY);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  386  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  387  		/* Get next BD. */
8b1cdc4033bd165 drivers/tty/serial/ucc_uart.c Rasmus Villemoes   2019-11-28  388  		if (qe_ioread16be(&bdp->status) & BD_SC_WRAP)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  389  			bdp = qe_port->tx_bd_base;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  390  		else
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  391  			bdp++;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  392  	}
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  393  	qe_port->tx_cur = bdp;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  394  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  395  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  396  		uart_write_wakeup(port);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  397  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  398  	if (uart_circ_empty(xmit)) {
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  399  		/* The kernel buffer is empty, so turn off TX interrupts.  We
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  400  		   don't need to be told when the QE is finished transmitting
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  401  		   the data. */
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  402  		qe_uart_stop_tx(port);
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  403  		return 0;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  404  	}
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  405  
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  406  	return 1;
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  407  }
d7584ed2b994a57 drivers/serial/ucc_uart.c     Timur Tabi         2008-01-15  408  

:::::: The code at line 264 was first introduced by commit
:::::: 8b1cdc4033bd1659c5499c918d4e59bf8253abec serial: ucc_uart: replace ppc-specific IO accessors

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Li Yang <leoyang.li@nxp.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--PEIAKu/WMn1b1Hv9
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--PEIAKu/WMn1b1Hv9--
