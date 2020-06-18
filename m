Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1603C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A5D212CC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgFRK0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:26:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:48103 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgFRKYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:24:00 -0400
IronPort-SDR: qoEf6Da9lc9Ao8ULn+1fUT7K8nQ3Gk1QHdMRBavHMq7yw/lnAjtM0/Y5jFoZ7NK6mG6iMqUHIT
 7rseD7rwrEAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="142462020"
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="gz'50?scan'50,208,50";a="142462020"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 03:06:45 -0700
IronPort-SDR: TZhveOoBArADGOIeToP8GwkHYr2crU1+hpMUHOYTb9trkjB0FVbWbLEQq3vrOrFeigEF/YhxhM
 /iGFOtFUXHqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="gz'50?scan'50,208,50";a="263557596"
Received: from lkp-server02.sh.intel.com (HELO 5ce11009e457) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2020 03:06:43 -0700
Received: from kbuild by 5ce11009e457 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jlrRS-0000CY-C8; Thu, 18 Jun 2020 10:06:42 +0000
Date:   Thu, 18 Jun 2020 18:06:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] sparse: use identifiers to define address spaces
Message-ID: <202006181747.1x7hGaZR%lkp@intel.com>
References: <20200617220226.88948-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20200617220226.88948-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.8-rc1 next-20200618]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Luc-Van-Oostenryck/sparse-use-identifiers-to-define-address-spaces/20200618-060614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a5dc8300df75e8b8384b4c82225f1e4a0b4d9b55
config: i386-randconfig-s001-20200618 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-rc1-10-gc17b1b06-dirty
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=i386 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/spi/spi-fsl-spi.c:93:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:93:44: sparse:     expected struct fsl_spi_reg *reg_base
>> drivers/spi/spi-fsl-spi.c:93:44: sparse:     got void [noderef] __iomem *reg_base
>> drivers/spi/spi-fsl-spi.c:94:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *mode @@     got restricted __be32 * @@
>> drivers/spi/spi-fsl-spi.c:94:33: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *mode
   drivers/spi/spi-fsl-spi.c:94:33: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:294:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:294:44: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:294:44: sparse:     got void [noderef] __iomem *reg_base
>> drivers/spi/spi-fsl-spi.c:299:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
>> drivers/spi/spi-fsl-spi.c:299:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:299:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:303:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:303:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:303:32: sparse:     got restricted __be32 *
>> drivers/spi/spi-fsl-spi.c:317:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:317:18: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:317:18: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:350:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:350:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:350:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:459:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:459:18: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:459:18: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:462:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:462:45: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:462:45: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:498:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:498:44: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:498:44: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:502:53: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:502:53: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:502:53: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:511:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:511:47: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:511:47: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:516:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:516:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:516:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:522:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:522:40: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:522:40: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:533:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:533:44: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:533:44: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:536:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:536:40: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:536:40: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:553:51: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:553:51: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:553:51: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:560:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:560:48: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:560:48: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:562:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:562:40: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:562:40: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:571:51: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:571:51: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:571:51: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:575:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:575:46: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:575:46: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:585:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:585:40: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:585:40: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:652:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-spi.c:652:18: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:652:18: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-spi.c:655:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:655:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:655:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:656:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:656:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:656:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:657:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:657:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:657:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:658:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:658:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:658:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:669:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:669:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-spi.c:669:32: sparse:     got restricted __be32 *
--
>> drivers/misc/habanalabs/goya/goya.c:2703:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/habanalabs/goya/goya.c:808:23: sparse: sparse: cast truncates bits from constant value (7ffc113000 becomes fc113000)
   drivers/misc/habanalabs/goya/goya.c:810:22: sparse: sparse: cast truncates bits from constant value (7ffc112000 becomes fc112000)
   drivers/misc/habanalabs/goya/goya.c:814:17: sparse: sparse: cast truncates bits from constant value (7ffc800040 becomes fc800040)
   drivers/misc/habanalabs/goya/goya.c:857:17: sparse: sparse: cast truncates bits from constant value (7ffc800040 becomes fc800040)
   drivers/misc/habanalabs/goya/goya.c:1066:9: sparse: sparse: cast truncates bits from constant value (8000000000 becomes 0)
   drivers/misc/habanalabs/goya/goya.c:1541:23: sparse: sparse: cast truncates bits from constant value (7ffc113000 becomes fc113000)
   drivers/misc/habanalabs/goya/goya.c:1543:22: sparse: sparse: cast truncates bits from constant value (7ffc112000 becomes fc112000)
   drivers/misc/habanalabs/goya/goya.c:1547:17: sparse: sparse: cast truncates bits from constant value (7ffc800040 becomes fc800040)
   drivers/misc/habanalabs/goya/goya.c:1590:23: sparse: sparse: cast truncates bits from constant value (7ffc113000 becomes fc113000)
   drivers/misc/habanalabs/goya/goya.c:1592:22: sparse: sparse: cast truncates bits from constant value (7ffc112000 becomes fc112000)
   drivers/misc/habanalabs/goya/goya.c:1596:17: sparse: sparse: cast truncates bits from constant value (7ffc800040 becomes fc800040)
   drivers/misc/habanalabs/goya/goya.c:1628:22: sparse: sparse: cast truncates bits from constant value (7ffc112000 becomes fc112000)
   drivers/misc/habanalabs/goya/goya.c:1648:23: sparse: sparse: cast truncates bits from constant value (7ffc113000 becomes fc113000)
   drivers/misc/habanalabs/goya/goya.c:1650:22: sparse: sparse: cast truncates bits from constant value (7ffc112000 becomes fc112000)
   drivers/misc/habanalabs/goya/goya.c:1654:17: sparse: sparse: cast truncates bits from constant value (7ffc800040 becomes fc800040)
   drivers/misc/habanalabs/goya/goya.c:1697:23: sparse: sparse: cast truncates bits from constant value (7ffc113000 becomes fc113000)
   drivers/misc/habanalabs/goya/goya.c:1699:22: sparse: sparse: cast truncates bits from constant value (7ffc112000 becomes fc112000)
   drivers/misc/habanalabs/goya/goya.c:1703:17: sparse: sparse: cast truncates bits from constant value (7ffc800040 becomes fc800040)
   drivers/misc/habanalabs/goya/goya.c:1738:22: sparse: sparse: cast truncates bits from constant value (7ffc112000 becomes fc112000)
   drivers/misc/habanalabs/goya/goya.c:2276:27: sparse: sparse: cast truncates bits from constant value (7ff0000000 becomes f0000000)
   drivers/misc/habanalabs/goya/goya.c:3344:26: sparse: sparse: cast truncates bits from constant value (7ffc112000 becomes fc112000)
   drivers/misc/habanalabs/goya/goya.c:3345:24: sparse: sparse: cast truncates bits from constant value (7ffc112ffc becomes fc112ffc)
--
>> drivers/usb/cdns3/drd.c:43:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
>> drivers/usb/cdns3/drd.c:43:42: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:43:42: sparse:     got restricted __le32 *
>> drivers/usb/cdns3/drd.c:45:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
>> drivers/usb/cdns3/drd.c:45:42: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:45:42: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:47:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:47:42: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:47:42: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:49:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:49:42: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:49:42: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:71:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:71:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:71:25: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:81:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:81:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:81:30: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:114:24: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:114:24: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:114:24: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:124:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:124:48: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:124:48: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:141:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:141:56: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:141:56: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:144:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:144:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:144:23: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:144:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:144:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:144:23: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:154:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:154:29: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:154:29: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:156:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:156:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:156:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:156:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:156:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:156:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:178:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:178:55: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:178:55: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:182:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:182:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:182:23: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:182:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:182:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:182:23: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:197:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:197:29: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:197:29: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:199:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:199:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:219:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:219:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:219:25: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:284:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:284:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:284:26: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:303:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:303:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:303:25: sparse:     got restricted __le32 *
>> drivers/usb/cdns3/drd.c:326:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cdns3_otg_legacy_regs *otg_v0_regs @@     got void [noderef] __iomem *[assigned] regs @@
   drivers/usb/cdns3/drd.c:326:27: sparse:     expected struct cdns3_otg_legacy_regs *otg_v0_regs
>> drivers/usb/cdns3/drd.c:326:27: sparse:     got void [noderef] __iomem *[assigned] regs
   drivers/usb/cdns3/drd.c:327:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:327:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:327:25: sparse:     got restricted __le32 *
>> drivers/usb/cdns3/drd.c:330:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cdns3_otg_common_regs *otg_regs @@     got void [noderef] __iomem *[assigned] regs @@
   drivers/usb/cdns3/drd.c:330:32: sparse:     expected struct cdns3_otg_common_regs *otg_regs
   drivers/usb/cdns3/drd.c:330:32: sparse:     got void [noderef] __iomem *[assigned] regs
   drivers/usb/cdns3/drd.c:331:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:331:32: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:331:32: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:332:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:332:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:332:17: sparse:     got restricted __le32 *
>> drivers/usb/cdns3/drd.c:336:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cdns3_otg_regs *otg_v1_regs @@     got void [noderef] __iomem *[assigned] regs @@
   drivers/usb/cdns3/drd.c:336:35: sparse:     expected struct cdns3_otg_regs *otg_v1_regs
   drivers/usb/cdns3/drd.c:336:35: sparse:     got void [noderef] __iomem *[assigned] regs
   drivers/usb/cdns3/drd.c:339:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:339:32: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:339:32: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:340:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:340:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:340:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:340:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:340:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:340:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:345:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:345:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:345:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:368:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:368:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/cdns3/drd.c:368:28: sparse:     got restricted __le32 *
--
>> drivers/edac/x38_edac.c:168:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *window @@     got void *pvt_info @@
>> drivers/edac/x38_edac.c:168:35: sparse:     expected void [noderef] __iomem *window
   drivers/edac/x38_edac.c:168:35: sparse:     got void *pvt_info
>> drivers/edac/x38_edac.c:362:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *pvt_info @@     got void [noderef] __iomem *[assigned] window @@
   drivers/edac/x38_edac.c:362:23: sparse:     expected void *pvt_info
>> drivers/edac/x38_edac.c:362:23: sparse:     got void [noderef] __iomem *[assigned] window
>> drivers/edac/x38_edac.c:440:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pvt_info @@
>> drivers/edac/x38_edac.c:440:20: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/edac/x38_edac.c:440:20: sparse:     got void *pvt_info
--
>> arch/x86/kernel/signal.c:337:9: sparse: sparse: cast removes address space '__user' of expression
>> arch/x86/kernel/signal.c:337:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned long long [usertype] * @@
>> arch/x86/kernel/signal.c:337:9: sparse:     expected void const volatile [noderef] __user *
   arch/x86/kernel/signal.c:337:9: sparse:     got unsigned long long [usertype] *
>> arch/x86/kernel/signal.c:337:9: sparse: sparse: cast removes address space '__user' of expression
>> arch/x86/kernel/signal.c:337:9: sparse: sparse: cast removes address space '__user' of expression
>> arch/x86/kernel/signal.c:337:9: sparse: sparse: cast removes address space '__user' of expression
>> arch/x86/kernel/signal.c:337:9: sparse: sparse: cast removes address space '__user' of expression
>> arch/x86/kernel/signal.c:337:9: sparse: sparse: cast removes address space '__user' of expression
>> arch/x86/kernel/signal.c:337:9: sparse: sparse: cast removes address space '__user' of expression
>> arch/x86/kernel/signal.c:337:9: sparse: sparse: cast removes address space '__user' of expression
>> arch/x86/kernel/signal.c:337:9: sparse: sparse: cast removes address space '__user' of expression
>> arch/x86/kernel/signal.c:337:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/signal.c:397:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/signal.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned long long [usertype] * @@
   arch/x86/kernel/signal.c:397:9: sparse:     expected void const volatile [noderef] __user *
   arch/x86/kernel/signal.c:397:9: sparse:     got unsigned long long [usertype] *
   arch/x86/kernel/signal.c:397:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/signal.c:397:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/signal.c:397:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/signal.c:397:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/signal.c:397:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/signal.c:397:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/signal.c:397:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/signal.c:397:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/signal.c:397:9: sparse: sparse: cast removes address space '__user' of expression
--
>> arch/x86/platform/geode/net5501.c:103:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *rombase @@     got void [noderef] __iomem * @@
   arch/x86/platform/geode/net5501.c:103:17: sparse:     expected unsigned char *rombase
>> arch/x86/platform/geode/net5501.c:103:17: sparse:     got void [noderef] __iomem *
>> arch/x86/platform/geode/net5501.c:127:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char *rombase @@
>> arch/x86/platform/geode/net5501.c:127:17: sparse:     expected void volatile [noderef] __iomem *addr
   arch/x86/platform/geode/net5501.c:127:17: sparse:     got unsigned char *rombase
--
>> arch/x86/platform/olpc/olpc_ofw.c:32:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct pgd_t [usertype] *base @@     got void [noderef] __iomem * @@
   arch/x86/platform/olpc/olpc_ofw.c:32:14: sparse:     expected struct pgd_t [usertype] *base
>> arch/x86/platform/olpc/olpc_ofw.c:32:14: sparse:     got void [noderef] __iomem *
>> arch/x86/platform/olpc/olpc_ofw.c:44:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got struct pgd_t [usertype] *base @@
>> arch/x86/platform/olpc/olpc_ofw.c:44:23: sparse:     expected void [noderef] __iomem *addr
   arch/x86/platform/olpc/olpc_ofw.c:44:23: sparse:     got struct pgd_t [usertype] *base
--
>> drivers/gpu/drm/drm_bufs.c:225:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *handle @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/drm_bufs.c:225:45: sparse:     expected void *handle
>> drivers/gpu/drm/drm_bufs.c:225:45: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/drm_bufs.c:228:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *handle @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/drm_bufs.c:228:45: sparse:     expected void *handle
   drivers/gpu/drm/drm_bufs.c:228:45: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/drm_bufs.c:343:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *handle @@
>> drivers/gpu/drm/drm_bufs.c:343:36: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/drm_bufs.c:343:36: sparse:     got void *handle
   drivers/gpu/drm/drm_bufs.c:360:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *handle @@
   drivers/gpu/drm/drm_bufs.c:360:36: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/drm_bufs.c:360:36: sparse:     got void *handle
   drivers/gpu/drm/drm_bufs.c:536:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *handle @@
   drivers/gpu/drm/drm_bufs.c:536:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/drm_bufs.c:536:28: sparse:     got void *handle
--
>> drivers/gpu/drm/drm_vm.c:276:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *handle @@
>> drivers/gpu/drm/drm_vm.c:276:44: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/drm_vm.c:276:44: sparse:     got void *handle
--
>> sound/soc/intel/atom/sst/sst_loader.c:212:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *destn @@     got void [noderef] __iomem * @@
   sound/soc/intel/atom/sst/sst_loader.c:212:43: sparse:     expected void *destn
>> sound/soc/intel/atom/sst/sst_loader.c:212:43: sparse:     got void [noderef] __iomem *
--
>> drivers/video/fbdev/cirrusfb.c:1851:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/cirrusfb.c:1851:17: sparse:     expected void *
   drivers/video/fbdev/cirrusfb.c:1851:17: sparse:     got char [noderef] __iomem *screen_base
--
   drivers/ipack/carriers/tpci200.c:153:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/ipack/carriers/tpci200.c:153:28: sparse:    struct slot_irq [noderef] __rcu *
   drivers/ipack/carriers/tpci200.c:153:28: sparse:    struct slot_irq *
   drivers/ipack/carriers/tpci200.c:187:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/ipack/carriers/tpci200.c:187:9: sparse:    struct slot_irq [noderef] __rcu *
   drivers/ipack/carriers/tpci200.c:187:9: sparse:    struct slot_irq *
   drivers/ipack/carriers/tpci200.c:236:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/ipack/carriers/tpci200.c:236:9: sparse:    struct slot_irq [noderef] __rcu *
   drivers/ipack/carriers/tpci200.c:236:9: sparse:    struct slot_irq *
--
>> drivers/ntb/ntb_transport.c:1790:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __iomem *offset @@
   drivers/ntb/ntb_transport.c:1790:43: sparse:     expected void *to
   drivers/ntb/ntb_transport.c:1790:43: sparse:     got void [noderef] __iomem *offset
>> drivers/ntb/ntb_transport.c:1790:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void *buf @@
>> drivers/ntb/ntb_transport.c:1790:56: sparse:     expected void const [noderef] __user *from
   drivers/ntb/ntb_transport.c:1790:56: sparse:     got void *buf
--
>> drivers/video/fbdev/geode/lxfb_ops.c:604:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *gp_regs @@
   drivers/video/fbdev/geode/lxfb_ops.c:604:9: sparse:     expected void const *
>> drivers/video/fbdev/geode/lxfb_ops.c:604:9: sparse:     got void [noderef] __iomem *gp_regs
>> drivers/video/fbdev/geode/lxfb_ops.c:605:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *dc_regs @@
   drivers/video/fbdev/geode/lxfb_ops.c:605:9: sparse:     expected void const *
>> drivers/video/fbdev/geode/lxfb_ops.c:605:9: sparse:     got void [noderef] __iomem *dc_regs
>> drivers/video/fbdev/geode/lxfb_ops.c:606:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *vp_regs @@
   drivers/video/fbdev/geode/lxfb_ops.c:606:9: sparse:     expected void const *
>> drivers/video/fbdev/geode/lxfb_ops.c:606:9: sparse:     got void [noderef] __iomem *vp_regs
>> drivers/video/fbdev/geode/lxfb_ops.c:607:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/lxfb_ops.c:607:9: sparse:     expected void const *
>> drivers/video/fbdev/geode/lxfb_ops.c:607:9: sparse:     got void [noderef] __iomem *
   drivers/video/fbdev/geode/lxfb_ops.c:635:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/lxfb_ops.c:635:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:635:9: sparse:     got void [noderef] __iomem *
>> drivers/video/fbdev/geode/lxfb_ops.c:761:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/lxfb_ops.c:761:9: sparse:     expected void *
   drivers/video/fbdev/geode/lxfb_ops.c:761:9: sparse:     got void [noderef] __iomem *
--
>> drivers/video/fbdev/geode/suspend_gx.c:32:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *gp_regs @@
   drivers/video/fbdev/geode/suspend_gx.c:32:9: sparse:     expected void const *
>> drivers/video/fbdev/geode/suspend_gx.c:32:9: sparse:     got void [noderef] __iomem *gp_regs
>> drivers/video/fbdev/geode/suspend_gx.c:33:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *dc_regs @@
   drivers/video/fbdev/geode/suspend_gx.c:33:9: sparse:     expected void const *
>> drivers/video/fbdev/geode/suspend_gx.c:33:9: sparse:     got void [noderef] __iomem *dc_regs
>> drivers/video/fbdev/geode/suspend_gx.c:34:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *vid_regs @@
   drivers/video/fbdev/geode/suspend_gx.c:34:9: sparse:     expected void const *
>> drivers/video/fbdev/geode/suspend_gx.c:34:9: sparse:     got void [noderef] __iomem *vid_regs
>> drivers/video/fbdev/geode/suspend_gx.c:35:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/suspend_gx.c:35:9: sparse:     expected void const *
>> drivers/video/fbdev/geode/suspend_gx.c:35:9: sparse:     got void [noderef] __iomem *
--
>> drivers/ntb/hw/mscc/ntb_hw_switchtec.c:897:29: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/ntb/hw/mscc/ntb_hw_switchtec.c:897:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ntb_ctrl_regs [noderef] __iomem *mmio_ctrl @@     got void * @@
>> drivers/ntb/hw/mscc/ntb_hw_switchtec.c:897:26: sparse:     expected struct ntb_ctrl_regs [noderef] __iomem *mmio_ctrl
   drivers/ntb/hw/mscc/ntb_hw_switchtec.c:897:26: sparse:     got void *
   drivers/ntb/hw/mscc/ntb_hw_switchtec.c:899:30: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/ntb/hw/mscc/ntb_hw_switchtec.c:899:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ntb_dbmsg_regs [noderef] __iomem *mmio_dbmsg @@     got void * @@
>> drivers/ntb/hw/mscc/ntb_hw_switchtec.c:899:27: sparse:     expected struct ntb_dbmsg_regs [noderef] __iomem *mmio_dbmsg
   drivers/ntb/hw/mscc/ntb_hw_switchtec.c:899:27: sparse:     got void *
   drivers/ntb/hw/mscc/ntb_hw_switchtec.c:697:38: sparse: sparse: dereference of noderef expression
   include/linux/io-64-nonatomic-lo-hi.h:75:19: sparse: sparse: cast truncates bits from constant value (10100000000 becomes 0)
--
>> drivers/gpu/drm/nouveau/nvkm/core/gpuobj.c:97:22: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem *map @@
   drivers/gpu/drm/nouveau/nvkm/core/gpuobj.c:97:22: sparse:     expected void *
>> drivers/gpu/drm/nouveau/nvkm/core/gpuobj.c:97:22: sparse:     got void [noderef] __iomem *map
>> drivers/gpu/drm/nouveau/nvkm/core/gpuobj.c:155:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *map @@     got void * @@
>> drivers/gpu/drm/nouveau/nvkm/core/gpuobj.c:155:21: sparse:     expected void [noderef] __iomem *map
   drivers/gpu/drm/nouveau/nvkm/core/gpuobj.c:155:21: sparse:     got void *
>> drivers/gpu/drm/nouveau/nvkm/core/gpuobj.c:157:33: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/gpu/drm/nouveau/nvkm/core/gpuobj.c:157:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *map @@     got unsigned char [usertype] * @@
   drivers/gpu/drm/nouveau/nvkm/core/gpuobj.c:157:30: sparse:     expected void [noderef] __iomem *map
   drivers/gpu/drm/nouveau/nvkm/core/gpuobj.c:157:30: sparse:     got unsigned char [usertype] *
   drivers/gpu/drm/nouveau/nvkm/core/gpuobj.c:162:22: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem *map @@
   drivers/gpu/drm/nouveau/nvkm/core/gpuobj.c:162:22: sparse:     expected void *
   drivers/gpu/drm/nouveau/nvkm/core/gpuobj.c:162:22: sparse:     got void [noderef] __iomem *map
--
>> drivers/gpu/drm/nouveau/dispnv50/disp.c:163:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [usertype] *ptr @@     got void [noderef] __iomem *ptr @@
   drivers/gpu/drm/nouveau/dispnv50/disp.c:163:19: sparse:     expected unsigned int [usertype] *ptr
>> drivers/gpu/drm/nouveau/dispnv50/disp.c:163:19: sparse:     got void [noderef] __iomem *ptr
--
>> drivers/gpu/drm/nouveau/nouveau_fence.c:215:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct nouveau_channel [noderef] __rcu *channel @@     got struct nouveau_channel *chan @@
>> drivers/gpu/drm/nouveau/nouveau_fence.c:215:25: sparse:     expected struct nouveau_channel [noderef] __rcu *channel
   drivers/gpu/drm/nouveau/nouveau_fence.c:215:25: sparse:     got struct nouveau_channel *chan
--
>> drivers/gpu/drm/nouveau/nv04_fence.c:42:45: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct nouveau_channel *chan @@     got struct nouveau_channel [noderef] __rcu *channel @@
   drivers/gpu/drm/nouveau/nv04_fence.c:42:45: sparse:     expected struct nouveau_channel *chan
>> drivers/gpu/drm/nouveau/nv04_fence.c:42:45: sparse:     got struct nouveau_channel [noderef] __rcu *channel
--
>> drivers/gpu/drm/nouveau/nv10_fence.c:32:45: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct nouveau_channel *chan @@     got struct nouveau_channel [noderef] __rcu *channel @@
   drivers/gpu/drm/nouveau/nv10_fence.c:32:45: sparse:     expected struct nouveau_channel *chan
>> drivers/gpu/drm/nouveau/nv10_fence.c:32:45: sparse:     got struct nouveau_channel [noderef] __rcu *channel
--
>> drivers/gpu/drm/nouveau/nv84_fence.c:70:45: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct nouveau_channel *chan @@     got struct nouveau_channel [noderef] __rcu *channel @@
   drivers/gpu/drm/nouveau/nv84_fence.c:70:45: sparse:     expected struct nouveau_channel *chan
>> drivers/gpu/drm/nouveau/nv84_fence.c:70:45: sparse:     got struct nouveau_channel [noderef] __rcu *channel
--
>> drivers/gpu/drm/nouveau/nvif/object.c:236:41: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *ptr @@     got void * @@
>> drivers/gpu/drm/nouveau/nvif/object.c:236:41: sparse:     expected void [noderef] __iomem *ptr
   drivers/gpu/drm/nouveau/nvif/object.c:236:41: sparse:     got void *
--
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:     got void *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:     got void *
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *[assigned] emap @@
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse:     got void *[assigned] emap
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *map @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse:     expected void *map
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse:     got void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse:     got void *map
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *map @@     got void *map @@
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse:     expected void [noderef] __iomem *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse:     got void *map
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *[assigned] map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:     got void *[assigned] map
--
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c:182:20: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int [usertype] *vaddr @@
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c:182:20: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c:182:20: sparse:     got unsigned int [usertype] *vaddr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c:225:26: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int [usertype] *vaddr @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c:225:26: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c:225:26: sparse:     got unsigned int [usertype] *vaddr
--
>> drivers/gpu/drm/ast/ast_mode.c:1455:23: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] * @@
>> drivers/gpu/drm/ast/ast_mode.c:1455:23: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/ast/ast_mode.c:1455:23: sparse:     got unsigned char [usertype] *
   drivers/gpu/drm/ast/ast_mode.c:1456:23: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] * @@
   drivers/gpu/drm/ast/ast_mode.c:1456:23: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/ast/ast_mode.c:1456:23: sparse:     got unsigned char [usertype] *
>> drivers/gpu/drm/ast/ast_mode.c:1386:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *[assigned] dstxor @@
   drivers/gpu/drm/ast/ast_mode.c:1386:43: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/ast/ast_mode.c:1386:43: sparse:     got unsigned char [usertype] *[assigned] dstxor
   drivers/gpu/drm/ast/ast_mode.c:1398:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *[assigned] dstxor @@
   drivers/gpu/drm/ast/ast_mode.c:1398:43: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/ast/ast_mode.c:1398:43: sparse:     got unsigned char [usertype] *[assigned] dstxor
>> drivers/gpu/drm/ast/ast_mode.c:1419:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *[assigned] dst @@
   drivers/gpu/drm/ast/ast_mode.c:1419:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/ast/ast_mode.c:1419:22: sparse:     got void *[assigned] dst
>> drivers/gpu/drm/ast/ast_mode.c:1420:27: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/ast/ast_mode.c:1420:27: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/ast/ast_mode.c:1420:27: sparse:     got void *
   drivers/gpu/drm/ast/ast_mode.c:1421:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/ast/ast_mode.c:1421:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/ast/ast_mode.c:1421:28: sparse:     got void *
   drivers/gpu/drm/ast/ast_mode.c:1422:23: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/ast/ast_mode.c:1422:23: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/ast/ast_mode.c:1422:23: sparse:     got void *
   drivers/gpu/drm/ast/ast_mode.c:1423:23: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/ast/ast_mode.c:1423:23: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/ast/ast_mode.c:1423:23: sparse:     got void *

vim +93 drivers/spi/spi-fsl-spi.c

c3f3e7717f1cf0 drivers/spi/spi-fsl-spi.c Andreas Larsson  2013-02-15   88  
b36ece832512c1 drivers/spi/spi_fsl_spi.c Mingkai Hu       2010-10-12   89  static void fsl_spi_change_mode(struct spi_device *spi)
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12   90  {
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12   91  	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12   92  	struct spi_mpc8xxx_cs *cs = spi->controller_state;
b36ece832512c1 drivers/spi/spi_fsl_spi.c Mingkai Hu       2010-10-12  @93  	struct fsl_spi_reg *reg_base = mspi->reg_base;
b36ece832512c1 drivers/spi/spi_fsl_spi.c Mingkai Hu       2010-10-12  @94  	__be32 __iomem *mode = &reg_base->mode;
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12   95  	unsigned long flags;
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12   96  
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12   97  	if (cs->hw_mode == mpc8xxx_spi_read_reg(mode))
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12   98  		return;
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12   99  
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12  100  	/* Turn off IRQs locally to minimize time that SPI is disabled. */
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12  101  	local_irq_save(flags);
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12  102  
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12  103  	/* Turn off SPI unit prior changing mode */
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12  104  	mpc8xxx_spi_write_reg(mode, cs->hw_mode & ~SPMODE_ENABLE);
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12  105  
4c1fba442960cf drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12  106  	/* When in CPM mode, we need to reinit tx and rx. */
4c1fba442960cf drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12  107  	if (mspi->flags & SPI_CPM_MODE) {
e8beacbb85a5c1 drivers/spi/spi-fsl-spi.c Andreas Larsson  2013-02-15  108  		fsl_spi_cpm_reinit_txrx(mspi);
4c1fba442960cf drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12  109  	}
f9218c2a60facc drivers/spi/spi_mpc8xxx.c Joakim Tjernlund 2010-05-22  110  	mpc8xxx_spi_write_reg(mode, cs->hw_mode);
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12  111  	local_irq_restore(flags);
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12  112  }
a35c1710956f7a drivers/spi/spi_mpc8xxx.c Anton Vorontsov  2009-10-12  113  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--7AUc2qLy4jB3hD7Z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICDYF614AAy5jb25maWcAjFxLcxy3rt7nV0w5m2QRHz0sXbluacFhs2eY6W62SfY8tOmS
5bGjii3l6nES//sLkP0ge8BxziLHQ4AgmwSBDyCon3/6ecZeXx6/3b7c391+/fp99mX/sH+6
fdl/mn2+/7r/31mmZpWyM5FJ+xaYi/uH13/+c39+dTm7eHv19uS3p7vT2Wr/9LD/OuOPD5/v
v7xC7/vHh59+/omrKpeLlvN2LbSRqmqt2NrrN1/u7n57P/sl23+8v32YvX97DmJOz3/1/3oT
dJOmXXB+/b1vWoyirt+fnJ+c9IQiG9rPzt+duP8NcgpWLQbySSB+yUzLTNkulFXjIAFBVoWs
xEiS+kO7UXo1tswbWWRWlqK1bF6I1ihtR6pdasEyEJMr+A+wGOwKK/PzbOGW+evsef/y+te4
VnOtVqJqYalMWQcDV9K2olq3TMPHylLa6/MzkNJPWZW1hNGtMHZ2/zx7eHxBwcPqKM6KfgHe
vKGaW9aEa+A+qzWssAH/kq1FuxK6EkW7uJHB9ELKHChnNKm4KRlN2d6keqgU4R0QhgUIZhV+
/5Tu5kYsUDy/aa/tzTGZMMXj5HfEgJnIWVNYt6/BCvfNS2VsxUpx/eaXh8eH/a9vRrFmZ9ay
5uSQtTJy25YfGtEIYtANs3zZOmqg7VoZ05aiVHrXMmsZX47ExohCzsMlYQ3YAUK22xumQb7j
gFmCbhW9ssO5mT2/fnz+/vyy/zYq+0JUQkvujlWt1TyYVkgyS7UJtUBn0Gpas2m1MKLK6F58
GWootmSqZLKK24wsKaZ2KYXGz9nRwktmNSw1fCKcIas0zYXT02tm8XyVKpsYklxpLrLORshq
MVJNzbQRyBQufSg5E/NmkZtYC/YPn2aPnyeLPVpBxVdGNTCmV4RMBSO6nQtZnGJ+pzqvWSEz
ZkVbMGNbvuMFsW3OIq5HLZiQnTyxFpU1R4loDlnGYaDjbCXsGMt+b0i+Upm2qXHKvTra+2/7
p2dKI63kKzC+AlQuEFWpdnmDRrZUVbgj0FjDGCqTnDgSvpfM3PoMfVwrdYDkYokK45ZOG9el
29CD6fZ9ai1EWVuQWUVj9O1rVTSVZXpHWwvPRcyl788VdO8XjdfNf+zt85+zF5jO7Bam9vxy
+/I8u727e3x9eLl/+DJZRujQMu5keO0eRkYNdhoykolZzE2GVoELsE/AGOzHlNKuz0Px6GaN
ZdZQn2ZktFJGDkY3kwZdeEYeqn/x9W6VNG9mhtKratcCLRwbfrZiCwpEbYHxzGH3SRN+pJPR
KTpBOmhqMkG1W824GKbXfXH8JYPhWvl/BKZsNWiN4tEur5Zg2ECXSUSCGCMH0y5ze312Mmqe
rOwKgEcuJjyn55GraSrTAS6+BCPqjEGvqebuj/2n16/7p9nn/e3L69P+2TV330VQIyu4YZVt
52ghQW5TlaxubTFv86IxgWfkC62a2oTfCz6UL8iT5pn9VI8x1DIzx+g6K9kxeg7n9kboYyzL
ZiHgc46xZGItuTjGAYcBj93RTxE6Pz4IODCSAXEPOEA43ITewAryVa1ASdBWguON7J7XBUSy
bhBSPPik3MDwYOPAc8f70R9MUbDA78+LFa6Jc4k6ABvuNytBmveMAY7T2QQgQ8MEF0NLDIeh
IUTBjq4mvyPMO1cKTTT+m1op3qoajKy8EYg03IYoXbKKR0s2ZTPwD8ocgSe3gSP3Z1Bmp5cB
anE8YNK4qB3kcWZl0qfmpl7BbApmcTrBKtf5+MObxXCebixiYiVYbgkwNUBgBjS8BLvWHsAP
v/cHzfmSVVmIYjyOHhxxZJumv9uqlGHcFDk6UeSwQ5o+TJOloDwgAxSYN9FcGwihJz/BbgRL
V6vok+WiYkUeqK37LNcwThNRVE4dBbMEqxbhf6kINqnaRk+cPMvWEqbfrTZ1mEH0nGktw81b
Ie+uNIctbbRnQ6tbIzyxVq4jzQaF6gcnlx+Vxjl+8sOdK8A0wDhJkFZxt52RFzfiAykf+oks
Iw2MPwkwfDtg4EArTk+iiNH5ri7BUu+fPj8+fbt9uNvPxH/3DwBAGHg1jhAEIOKINxLCndX1
RPj8dl26AIYEPP9yxFH2uvQDetRIu31TNHM/icCTqrJm4HFdVmU00wWbJwTEbIr2Zdgf9k4v
RI/v0mzoNgsJwYwGO6CogxizYQQKmCs6QmbZ5DnAkZrBiENYSFtSK8oWwhGGOSmZS+4CxNCu
qFwWUUDoLKlze1FgEOeQeubt1WV7Hnga+B06LWN1w519zgSHoDQ4fKqxdWNb5yfs9Zv918/n
Z79hqi9MGa3Ad7amqeso0wVojK88jjyglWWAON3BKhFV6QqcovTR2/XVMTrbXp9e0gy99vxA
TsQWiRuiasPaLPTHPSFSVi+V7Xpn1uYZP+wCNkfONcbIWQwlBquCsREarS1FYwBjWkw8Om9M
cIB6wAFr6wWoSrDObk5GWA+/fPylRfBJlQB41JOcfQJRGqP4ZVOtEnxOo0k2Px85F7ryOQ7w
m0bOi+mUTWNqAZuQIDvA7ZaOFT0+PZDgVMr0Bgym5M5YpOSg9G3BbnbtwqS6Ny7LFJBz8POC
6WLHMUUjAjxSL3x8UYBRK8z1WYCrcAsMw+1Bpcc9ENzngJytrp8e7/bPz49Ps5fvf/lYMYpD
OkE3ELS3KUBvypqwHfiRuWC20cLD5Pj7y9rljQJ9VEWWyzBs0cICPohy2tjTqyPAN13EBLG1
sHOoDSNgGyaJDP0Q5FcgA9gszILWho5skIWVo3wi+hgwhsnbch5Anb5l6lFQps74+dnp9kBB
pJaRR/QhgyolmD0A83Cm0coKynIvd3AkANMASl40Ikw1wbKztYwBa992GOn0CAYc5kSOz8LV
DeaMQMsK22G5UeiaXuhhsB9nVQbWPmQe49d3V5dmS8pHEk24OEKwhk5TI60sEyNdpgSCCQGk
X0r5A/JxenmU+o6mrhJTWv1Pov2Kbue6MYoOBkqRAxIQqqKpG1lhPpsnJtKRz+nsQgmOpiJU
oVwI8P+L7WmkBa6xLRLbw3dabpOLvJaMn7dnaWJiwRBUJ3oBjKL3zFkf73ATptId5Aq/xrtU
n0h6F7IUp2kaOPFFVSKiDaNcpIBiT+xnWW/5cnH5bmKQZSXLpnTmNWelLHbXFyHdmQaImUsT
gDDJwEyhlW+jiBv51+U2Zf+7dChG8KIQPDJFODy4QG+K6aRMx+F2F8wklU/oWMBYB9i9a1zu
FiGCHcTB4rFGHxIAKFamFACBHVA9mEdT8sksDlhulkxtJaXWy1p4QxgM7NpE2RQIyrSN8pRZ
KQkplUM/BmMCwD9zsQBweUoT8QrqgNRFHQeEsQE+wk0nvmrBfcZlriU/aJTqsNld4hLsEJIf
NmqhAeP7TE930+yySHifNvXsZeyFPbQJosFvjw/3L49PPu8/eqIx8Oxcv2Y1rXQhq4MAajPN
XXZxTmLYaBnEgvEdnJAw2Ol+RZ91ejmXdCzoV60u8D+CzMdYBWZiHl0Ry6tVwvpogUsLAHOa
JpYczipYpUS/yBh04ExGsWal8LII0GriGgko76JUzLo0dQEI55zOuI5kzAUSQnuGM1Lq2UG3
A5ZTGonA2VF5DhHL9ck/Vydx1Ub3IdPt4zVD2G0hDpecSjE4DJXDwYLOcDIZEY44lJwmO/vZ
34jjtW1ghWWBilb0KBEvQxtxfRJcCcK0a5vaW5e+hihUGcwj6aaOI39kQaVBjFb2MxgZfffp
icYrZrws2VxfDu6rtFpHOge/MWSRVt6Q2BZFQYA8WYrGCAOBUNtUzklmE7JPl0x3yEDMnRgB
4Fkd5R1zyvIawTFcDxmXN+3pyQmpYkA6u0iSzuNekbiTwD3cXJ8GuueDgqXGa8wg5Si2InIc
XDOzbLOGjNXq5c5INM2grRoV/LTT7zFzKFyWCFXwWH8HQ6D/WVzU5BMa68yoaEpl5hIHoEUF
IRS0Wea7tshskAUfzeyRwDXaeH9uegVdgsIWLv7yPuLx7/3TDIz17Zf9t/3Di5PDeC1nj39h
XVgUBHepAer7w1i8HEK80XuUmGHG64zsyGVSBmx9tQM5CIRBURC0+eD9UOvwuET0R+QPI3vR
JxfwG4MTcvCr91Fuxw2cWLVq6smRKsF82K6YBrvUYXrJtXT5Qz9JtIQgasy4jdl35HXrsiAP
vJdVc+2nc9AV8WRuDn1yyKPFulVrobXMRJjciSUJTlWrhBxs+o1zZsG47qatjbWhtXSNaxhb
TdpyVh0uBQS7qfEdPNcCdt6YiagRVnO31kmyjC6QYuLBZGRd0gHURChbLDToDJ1Idrx2CUiF
FRMtcuWLjuzOaVMvNMum05vSCNU5MkcuMfdOe32/qAqwP5ii5NQ7szGC2ri/mdMJI983cY/u
R24MxIxgnexSHWHTImvQeGA2f8MgolJVsaOcxXAYWS2CIx23d9eA8RBISJglm1N4dzBLEq9l
Ye9lIiHQLzH8mzxXzp+XQxQ02tvY4/aFPbP8af9/r/uHu++z57vbrxNM35+PVGEM0XsQLD99
3QeVwCBpWhDVt7ULtYaAKMtIlYm4IChvkiKsoOsxI6Y+uUbutyf1ibjQQ45fNPjMH3o7txTz
1+e+YfYLHJ7Z/uXu7a/BfR2cp4VCYBjfBWJrWfqfiUtkZMmkFol6DM+gilTJqCOzitJ8pFFT
4tX87AQW8kMjNWVU8Spl3gSmtLtbwYA0ip1MIvnNEewQgvErQgH4u92q0wvoQiFJgE5BBrgS
9uLi5DQwgxB0VsFVg0OvO5PPwy1P7Jzf1fuH26fvM/Ht9ettD21ifNalN3pZB/yxMQGzhTdR
ChB0j6by+6dvf98+7WfZ0/1/oytekcV3+FmGwRS5oLnUpTNxgNhodJ5vWp53BRKh1LC9B5dE
d1CwRSGGccIbCEfA/J5LNNg44OrIWDmlKqOOkgYhBzzrOohMIKYYbnT6RbT7L0+3s8/9Un5y
SxnWhCUYevLBJkTbtloHUBVT6w3o3U1/qTssJbCRm4P3AOAINO3kwZGvtxenwXUuXj4t2Wlb
yWnb2cXltBVCycYMda/9ffHt090f9y/7O4T2v33a/wWfiaZrxOdRgNNVPIRR0EEVhPKX1pRu
uDXq6aOcvgUd56GfWvmLOkLc7xBugZuYi+hixKUEOExuZzCAzxMPIdxcRmTfVC64wpoxjpDr
MPx1DyGsrNq52bDpgwcJi4AXzMQt7Gp60ehb8fqNIqiabu/E4HOQnKqmyiEyd5kBpz+trH4X
PE4pOLaoRGms1HcSlxCGTIhoqhG+yUWjGqJA28AOOE/qS9cJ8JlDNIKBZlcYd8hgRJ9hSRC9
R2vLg0X3M/fvanwpQ7tZSusqMyay8GLZtNmuYmhWrSsJcz0mfOdnc2nReLbTbcQ3QBAzd29k
prsD+AyOZ5X5e+BOhzonF/EZ8SG1cfieJ9lxuWnn8KG+4HFCK+UW9HYkGzedCRPWOOGdb6Or
tlKwJVGt1bQMidATBMd4T+gqNv01t+tBCSHG7yuNdLdEmCuh9jM61EeoYaFXx1aWTQshEsRB
XUSDZTokGWulKZZO7/w58aXH3X3OdDKdsejUDvOXE46un0/KJ2iZahI1EBLQjH/50b/VIhaj
y451NSAjR6o96IlbUIC+TIgHVQy99e8qHSLywVuDmJyMn9xHSrsEU+pVwd22T/WFeBgwVXuF
ahXeQUX2rMLkLpp2rCOJN2hcZ6ShDPSZerqFcNz7NLHgWJ0V6JLKGszcoF/Ayk4tqMDbUVxm
NCreGacZFTdNGMQWLBFpVuNeV7FqqXrX20RbTIA3IPHYtPACK0/msAmA1bKAW+GTP7nocnLn
BwQ28S0DxkXzidtG2XILHsP2j+H0JsDjR0jT7n7lye4UaVxriKGL87M+1Rrb8MHHgyOKHPmg
22j5wqLG5H1DVyjaiorrXT08mVlwtf7t4+3z/tPsT19O+dfT4+f7aXyNbN0yHBvAsfWoaZK6
PTZStCr4ghbTLrIiKwl/gAx7URrWHSuPwwPsCnENVpSOb2y7zTEYSfiiwulhCpe743bv4mDt
WaKawXM11TGO3mMfk2A0Hx6/kpmAcfbELLtvIkuVApaoaDloRwifkIpI/ixRiRJzXSTKQSKu
86t/IwtCjOMfAhq4vH7z/Mft6ZsDGWgItEhUeHU8WK+3AdRiDBj18ZFHK0uXPScGbyo4nGB4
duVchUatN8MWvPiYRR/GmxeJVK+pgti/qfzbbjDz4JJQmfi0snFM7Pu4HGJbwni457SZE+Me
SaZZ9IZiwJMNPtUl0gtW17g6LMtwOVu3QpRV7AvR27nI8f8QYsUPTANed8/TbjQIF0ORovhn
f/f6cvvx694985+5+/WXIPabyyovLXqzILYu8jgY7JgM17K2B82w2Tz0Fphx7e71OrOTmoWb
Yrn/9vj0fVaOubWDAPXoXW1/CVyyqmFxtDjcAHsalRDxnWNprSsm8v0CHDuK82HoFOvjO9lF
E3XAS/HaOv/iikLeBXlK9KrO06buzLVAvYywkS/+U3HaDbFvgPrH4NpQlQP9M0gHNPyD2kxf
vzt5fzn2pBAWVTsT1g+vohtiDgDU3ybTSdq4HrZrvamVijbwZt7Qpv/mPAewQokwZV8xPDJ3
bUOtb+nPHy25Z8Y9plJgXXDsck99aiBAYln/OACj7lW0eb7wdD2B37B+rtYJH7IGMThEYnOA
GcuS6YNSbDjutRUeuYbxR/ddGFTbXbsURT15YZw+auOWDqim2r/8/fj0J0AL6kYXdHclqAUC
ixtANPwFdiPSDdeWSUZvgC0SFcS5Lp0BJKkwb8wKUVlq/0ljNrr2j8nwtTkpChiGG2dXRkVF
O8BUV+G+u99ttuT1ZDBsdsUeqcGQQTNN0/G7ZJ34axeeuND4/qBstuQJRY7WNlU1SaTtKrBA
aiUFvdq+49rS91pIzVVzjDYOSw+A29IyuszZ0QA3pIkQQiuyHMNRh88NG1HhJk2W131zLL7J
6rSCOg7NNj/gQCrsC4Qvin6Xj6PDPxeDtlGVaD0Pb+ahw+mNeE+/fnP3+vH+7k0svcwuDPlo
FHb2MlbT9WWn6xhK0bcLjsk/IsWirDZLwHL8+stjW3t5dG8vic2N51DKmgbEjjrR2ZBkpD34
amhrLzW19o5cZQBuHB6wu1oc9PaadmSqaGnqovurQYmT4Bjd6qfpRiwu22Lzo/EcG/gM+hLQ
b3NdHBcEe+CScDTKr0GxUt3wTyZhggp91lGeerlziQRwemXSEwOzT3KR1Hl9hAi2J+OJeUp8
oJ+wxjrxLt+m/hIPgEeyvThLjDDXMiOxlE9Mot0wUeFp10QKWxesaq9Ozk7pl6mZ4JWgfVxR
cLrsmllW0Hu3PbugRbGafppZL1Vq+EuIEWtGlzxIIQR+0wUdzuJ6pP/AQsap16RZhVlzo/CP
YF1/CzYDto8hAF6TwlQtqrXZSMtpW7Y2+JdpbNKBQty5SjuJsk54RvzCKvHSamnS8MfPNBP0
xyBHcQ4Q0aCRT3F90DY9QMUNDQe6v/WAPLWWibKMkYcXzBhJmVznWbcY3eza+H37/EMEX/DR
9+9xfXeIWWcv++eXSfbNzW5lAb8nPzDTCpymquQkwz3g5wPxE0KIlYNNY6VmWWpdEsdgnqi5
ymGBdMoa5e2KUzHfRmqIoE2UheP5Ao/Z6cEaDoSH/f7T8+zlcfZxD9+J0fsnjNxn4F4cwxif
9y0YxbgMEj6+9a9ag0LYjYRW2u7mK0mm5nBX3gcw2/92YbBUUzP5/tifG+FM/j9nT7LcOK7k
fb7Cp4nuQ0VJ1GLp0AcQhCSWuZmgJKouDLftfuUYt+2w3e9V//1kAlwAMCH1zKEWZSZAEAQS
ucNTqEQUuyaJaR6WbTzhNBIOroQ+r5V8uqFx1MHbMSlMvEWF2VACyxyGlyR2qAaLEzQiEV2I
aleBBt3xHtfn0G6aTr+LHv/9dE8EnGji2D6GhBPEY9IW3PA6uD/aQmvSAirDhrZhDFMKYEa+
lsJIK1C4hfTZN24/iFNxdxIGSH9BiwyNgP+IeKiu4hloU6TCHQ5o67SYoJDh0YdrUknJsohR
MVmjiC1fDqoK46z2of1lLIMDAgRn9iQrzwgyjjYG0X1enNPHCOLgJPCMpGAyjpznuIEeXdRo
wceBjAi7f335fH99xvJOD/0Ctp6/qeDvKRlfhmgsvTiUenMRo1pb6kvVWK6hHvbPx9O/Xo4Y
L4Qj4q/wH/nX29vr+6cZc3SOTNs/X3+HF3h6RvSjt5szVPrN7x4eMW9KoYfZwXJyXV/mq3AW
icw0OptQNQceFCZwn0F1TYdQyovj6kMs6c/af3Lx8vD2+vTy6X5okUUqMoI8sa2GfVcf/3n6
vP9BLyJzyxxboapqE0KMTv1dDD1wVlrrPOUxs7cQQpQLrOGxpyQY9AGcktgEX+7v3h+ufn9/
eviXXXHghOmY1LKPltfB2tJhV8FkTTmE9NjRYdGbuofDmhWxI80MUWdP9+2BcpW7Rvy99rBq
s6RhITTBmJy0swqlHqq02Bh8qoOAnLbP7MIkWcSS3Cx5UJS67z4uUpW7/c0NuXx+hTX6Pgx0
c1SfxBxkD1K23Qjr1Rnukroq2RAUOYx+aKViY/o3H85yigBO+CRBtz3lrugbdL44c126b2RI
hsorh9XNOveMR2PEshtRGdPyRYsWh9J26Go4xuK1bUHbwgAOWpdGMqZcWy2xCn47Y2pXBU72
Ve4pHYvowz7BuiIhMOgqNr3Vpdha9nn9u4kDPoJJM3iih6VjYJrG+bjH8nbcGpZohLK3sXxT
psNR1Bra2MsBkRvFSlXIHsnQPLusjz5/UFKdse3SvK6EuVFilFwxa8B2Iu3ippPIjJDorjuD
IeUgwHpigLaZGVyJvxpY15aPQgFTrP3YIfqeNX1cblqc5wHNPqxH3aaVFSUNP9VCI/jm3fvn
E87Z1dvd+4fF8rERK68xNsuUjBDc5dsRqHxDQeEDq0DoMygd+ogOTeXK/u3L1B6/1YWKYVXB
LaSdeEyPQUKY6WKdW6N3V1Oyh/+CfIHFMnXVr+r97uVDh65fJXd/jyYpzwvnnfCZMfoyYV1r
E0PHZUuWfi3z9Ovm+e4DjssfT2/js1bN8Ca2u/wmIsGdLY9w2PZ9EWlrvqAHNOUoE7UTEmJQ
4b4MWXYD2mhU7Zqp3bmDDc5i584agefHUwIWUCNVSfNwcniGqV4mBZ1wtKwRA4cddcB36H0V
J86aMwV7BbATetXSD6XwSFFnPqIWYe/e3tD20QKVlUBR3d1jpqnzpXNkQHXnrXRX0u4kLY5t
ANtINBrX5d+u7PxykyQRxr0AJgI/qvqmvwX2nHQE+cYz3R3BtsBCDOhJd2c1ja6XdUmWm0N8
zHc18TGEDAN/I36zmszbZgZY8jDAAAZVCcrqLhPV5+Ozp7dkPp9sa2dWeewCWul1BGsYiImn
1AohV2+mykIcMJS0dNqBoqBX5KDeXFhBuuDv4/MfX1Divnt6eXy4gq7a84nSAdWDUr5YTD2v
jaX5usmiwM2xjCuhi/edfDSgpjo8gu+KYHYTLJbOt5FVsHB2pUy6WbBWFAB9zKuK3J2MFQSq
vMIEdDS3qTgOGwtykWxLzE2DVau7Pn38z5f85QvHKR4ZgqzxRDnfzkiucPlzmGPPmKrPV474
NhwaiPO8smomOEdlbMdA9DIjKjwEjUy5y/+OinC0L4zGoW3m16fX3X++wll5Bwre85Ua5R+a
BQ6KrM3cVIegDrMkJoapEe3mGg+kRUe+Q0FPIdsIomsuF4tZTXab1rGnQFdHgdzr3DOpqnDG
gJT6f/4JDBahbenWB8fTx709gTIlCvD33eBfIMCeGyuoBPmOmvtY3uSZfVsEgdSyRe+T/2e0
KozPPlpoUiwbcr7LMKwU33FfH7STxt0magqTAh5/9d/63+AKePLVnzrMh5SzFJk9hFt1b80g
U7Xb+3LH/+WOLx8dfy1YxUfOlXMYJF6yZGzRykS2HmaB3Y3jIP0FlnEk+9DZkQBojomKp5e7
PIlc3qkIQhG29/AEExeHAX9aVLFeGVHbZC9Cyv6JBKrAoKV8RZXBr/KN2SOoF/ssrjyJboDF
gMXKSnQBoI5OI1HwndMR8CYPv1mANpvKgnXr3IRZai/8zkxVM990dWsiu+imRqA/1oLp2Fg3
VcyolaETZ+yqsz5AY+cQd9CxajkiwXKv8YZiiAaFchjYPigDqyWjMz2werW6Xi+p5nBIU1cJ
degsb1+tg5thaCoGTVljUvhSbKtMIV210s/X+9dn08SZFW31Eu07PaSCsjxb8J5rjw0NLFoE
i7qJCjNL0gDaRhcTIe188WifpidcWXR8QJhivh41QzuWVaZMXMWbdCRyKOB1XU/p3rlczwI5
n9BoOOiSXGJdPlzWMfeE9KjDeNGkmy1ZZ2tXNHFiVjMpIrleTQJm5/QkwXoysW480bCA8mmA
7iaBszYVkCwWRs2jDhHuptfXE4t9thj1+PWEih/cpXw5WxhqcCSny5Wl0B5a0yqaJ+hYZszP
2ZnOJ2RLMHcgeBWzwbPUjcqRiU0T/+jisyE6RblmGhltBFUmEkPUm7KShpZTHAqWmRyOBzYf
0b9hNcKAWNkEUzWrOqpeIBcdu1Y0vGFVYNgGBuDCfK8WrIsFUc5cjU9ZvVxdL0bdrWe8XhLQ
up4viceActus1rtCeCq/tmRCTCeTOSntO+/cz1J4PZ04ueMa5tZ/H4Cwf+U+Lbo8rTZ3/+fd
x1X88vH5/tefqv78x4+7d1ArPtEYhY+8egY14+oBeM/TG/7XVFQqtImQw/5/9DveIUksZ8i+
iM/EMAhN1aorrIhTlEpSYdfB6IDwh+hpQFe1oNvtIk4FvbZb8JDynpnHL6jvwwkOAtz747O6
53G0XA95YRuBAWBKgOc6MZYO35HKA245lnDMJLaMCd1WHKlBPWIvqSiuHQtZxhpm9IXX01gy
q3UyDQ0x5TTqyyNIjGNqNdXRnCASM0zMXqkGHf1mb2fw6t86/mWrNW4bk+TbrVZi9YcSQlxN
Z+v51S+bp/fHI/z5dTyqTVyK1pEwOI9aWJPvOB2X1VNkZKT+gM6lZSc+O6b+OzIOCzPHynjK
jWOn+DGOZVjRKCTCijoVYEi6BLix/FRwmHNch3kW+SJElaBAYvC1tntW0lGC4laV7jiTSlAJ
5qkgzfgh8UUuFl7UofZh0Ivl8ZSFsKn3Ee2p23riS2F8UtDaPrwX1yVWaHQVth+Fdtvt6fED
vDmoD6cumPR0fhCVJ4ZSRXK5C3QYVJL6KmOVbnBrZ9j6fH/6/S9kVVK76JmR62oZCrsAjX/Y
pD9qscqApefg6x9ARgFWN+O5I70oE+mML67peNaBYLWmZwiEEEEf2tWp2NEylzEiFrGisgta
tiBlMkcmcKGDrbC3pKims6kv26RrlDCOZgxumaJlEvNcUuq/1bQSuVPZT2QeE1Z7/Fby0kuk
7LvJpi2UZRaEn6vpdNr4VmyB685TtLr9mFnKfdsda1HVW9LdbQ4JGFRWxYweb8lpOK5Lu4oX
qxJfmHdCKziIoLcwYnzf4NJi2Jd5aUW+aEiThasVGaFlNNZXg9q7KpzTmynkKfJTmpeEWe0p
Ne5bXFW8zbOZtzN6U+rCnag6+BpSZ7H9wtwp1RhmlC3BaDOEc5knASVFWY0O8T4l1xLfiUTa
1o0W1FT0wunR9Hz1aPrDDegD5WkzRwZSojUulzUQTVQWrbX+tgJr9vesnB5TjQGRNC6iJSrj
oZHNcnVaWhJT4rvZqo3bHR6UBHQ6htxnkScM1egPS+ELyysQiuDi2MX31kw+TLKCNFmB1ypl
cCKo+xLcrTbuabP/FldyT5yIm/Twbbq6wDh04Tdyhe727GiW6TRQ8SpY1DWNQlXKejE6QlS0
daMtuoknP2tLx44D/ODJpKt9TdyjYcDMvU+nedc3Usc0piJl5UHY186kh9SXpiBvtvTz5c2J
CiA0HwRPYVlu+6aSet54MjEAt/DfpghYeTyL3hwvjCfmpb0IbuRqNafPBkQtaI6nUfBE2pp8
I79Dr7UbwUyPJx9tuIwHq29LuuA5IOtgDlgaDbN9PZ9d2FrqqVKk9BZKT6Wtm8Pv6cSzBDaC
JdmFx2Wsah82sEQNouV+uZqtSDun2aeo0ARviYoy8CzgQ+0pYWB2V+ZZntL8JrPHHoMUJ/5v
vHA1W08IRshqr/Ijght3+bitC1cLIkZ+iCM77ljfSO8IuOOG+Y19hzbfNT72hDWYL5zCumAA
zNM2zuzw0R0I57D+yY5PAiNXN+QFMGbnIpNYi4v8dLdJvrVDmG8TNqtrWn67TbzyIPRZi6zx
oW/J0DxzIHu0h6WWKHvL2TUcLegDoTtt8XvmEShvOdptfSm/ZXpxfZSRHd69nMwvbLxSoNpl
ySnMY49YTWdrTyIuoqqc3q3larpcXxoELCMmyS9eYmJmSaIkS0F0sjJZJJ66rr5HtBRmeUcT
kSegR8Mfu2CeJ3UM4BjhzS/p7TJO7Pr2kq+DyYyKZrJa2dfexXLtOSUANV1f+NAylZxgWTLl
6ylf0yemKGLuu8QD+1tPpx7FCZHzS0xf5hzDTGva/CIrda5ZU1Clyhp58fPuM5spFcUpFR5X
MS4hQVsIOSa3Zp5jLd5fGMQpywvQIC0V4MibOtk6O3zcthK7fWVxbA250MpugbckgHyFCfrS
UwKgom+ZM/o82McN/GzKnVNR2sIesG5fXFFuMKPbY/w9s2u5aEhzXPgWXE9AXxBjdN7ndvVt
W5ciq2M/e21pkgTm+uIHquOStg4iIihoV/Imiui1BAKj58hQyeAhKiy0iAwyPnH95jCo3cmX
DqtFZ5R81+uF50rTIvFUqykKGi5prXgvwzYpe+RdQBRo5vQnQeQN6IYe8x2iC7Flck/PN+LL
KllNPZcNDXia/SEeBfCVR7xAPPzxyXyIjosdza2OzonQpXU3x4iyqSL5YAVO9YlN4aqdfZTv
zl0LUu0WI6mU7DQ1S/CYKMOiR2A7Aw+B6rR3D6qUsZNDil5Zei2WsUwXVJiN2emgIlNIAVK1
d05LZmdgW7hefKKQMqYRZkamCa889N9PkSkdmShlXRZZRiUjluzEx1kzQqX/Xx2fMIP/l3G1
g1+xTMDH4+PV54+OigjJPvq8YynqQLThsLUgNf46VcDKnJBQixNS+fKD9URG46DU+OXtr0+v
gzjOir3xKdTPJhGRxaE0dLPBsLfEVzFTE2GdC5/TTVPouoM3qWcta6KUVWVcu0R9fs8z3lfy
9PL5+P7H3b2dLtq2R1ft+XF8y0/nCcThEt7hKsZ0+6oR6JY34hTmOpt2MLC0MOBt9ElgEBSL
xYq+rNchopSOgaS6Cekh3FbTiefAsGiuL9IEU4/Rp6eJ2roy5XJFV+TpKZMbGO95Ejfym6ZQ
i9RTcqcnrDhbzqd0ZS6TaDWfXvgUei1feLd0NQtolmHRzC7QAKu6ni1o1+tAxOkdPBAU5TTw
mAk7mkwcK48zu6fBkkNo27zwuFaJvfDh2ivb26r/F3qs8iM7MjqaYqDaZxdXFN5qQzt5hkWQ
Bk2V7/nOqdhIUB6T+WR2YUPU1cVBoa2z8cRFDESsAN30wroLyQI7Bg81Ip3wZ1PIgAA1LLFy
KHt4eIooMJqw4N+ioJCgNbIC70k9iwQF28747Un4qbADuweUqmLa3Usx6AE9Hq8cRy8/rS4M
gxAounnsZsbT1KLw3Ns7kLm3XI0INngvgxt8MKAPqfr/2S66yXKanwkf1wSsKBKh3uMMESyi
xdoTEKIp+IkVtH6l8TjvbkSiQ3KQdV2zc514mX/7rv3KOf+ggc4J3BvLD1g4kvZnahJVJtFT
llUT4MxK0EI9zqN2I4IO4TGHxvOR80hJIbu79wdVOyH+ml+hxGeVny7NjH8iK8GhUD+beDWZ
By4Q/nbv8NQIXq0Cfj31GM4UCciBPk7XEnBkEsS61mhQ6zU3cpqVjC5BpLFtiI3TsftkGaTO
5aluNyW/0AcrwvMEWhTxkOwVDYnaslSMAzLa8C/qww8BsIQmoGXnH3fvd/efWPbFzYOoqpNl
/fIVSV6vmqI6GVy3vTfWB9R3U/wWLPokpUQVJ8XSGFgUpA9vfXx/unseZ39p1mVemmYjVoGd
NtADm0jA+aBKD3TJ9TSdTkWxPlqHmi4XiwlrDgxAPmHEpN+gQk9VQDGJuHuZnDXolHlGaUYj
mwhRs9I3fvIOcpMgK5WLBku8E9gSL7lJRU9CPkPUoJRHHjHbJGSywMrrB9cnRM3CETa976Ui
/7bvB14FKzJKwyRKrAt1TUxq32jfojALjUjW01lIry9fsClA1DJWEfofRlaS3RWI7zOvt8Ek
8fgcNAlOZBKT17m3FHaCgwE0FqHb6zdJWyVatIw3sSfyt6VA2Sqms6C6PjjPao9ZtaOYLmN5
7RFrWyJYm6EoI+aJ3m2p2oPgW8W2Xm+kTXqJLN7Uy9qj77Yk6HW+1E1rhS/kRUo4hM6hy8J/
/AB6I+GbFJeeoajibJOI+hIpR08WXlUVxduYAxenrVTdpyzcePY+Ed/i+M4qTXlVJursJNao
rvCVRb5Q+V6JrCpaVcuarWeZZ/n33BfesUePiadHVfsIdkd2hv1jJStLmTHg6nWhc1fMAhDa
fbOK6lchTJdxUlA7uyh8Fq42kJ2PI+w7ybRIY5AXsygxH6OgqnAe1pRw4ZigptV3y7g44PBy
rIyu8J7GrZNH28Y31hUzCm1amjUAWJIDOjKsKZxv3ZFh0cx8Y1OHZx64O7aXpVkG+g6oLwaN
81RQyvVA5jgABgSzborrwVthXZYzIA5mbLUJbuvKjjAcVpVZeQLVvNjx5sk8OxVUuUqVC3xP
SIxD01PGlVmPlDOwFh8Wqp47QYkDfO7hobwM5jTnj4vOe0SyFO+gDeXv6C+XurqeLX/6ykpk
ILS27KiFwLrR+eF9FwC5oVdDdrBKoAChu9F3BRnyAntvy3eC3/TX0HaMgcMfs7yssS5NsKKL
pSMLtFCL07SEvpieDg9qtfaTXaSC4yTOBBkyYpJl+0Ne2QFxiM482jDizj//wnN5GdoTcaiw
SG6Z1ydyPqrZ7HsRzL32hBGhdwZFwj33f4EwkJyss6GDdJUVusqk47XdNug+frnHGrGFFb5s
4bDemq7HOPZqwCuOfUdWBjzH8hXw1XLQrrZWEiFClbkRK3NYrD/gbREselMjGu9ytQ8pA5vu
+/q16V/Pn09vz48/YQZwtKoWECFpq1Vahlr7ht6TRGRkLGXb/0jUGODOJTUjiqTi89lkeabv
grP1Yj61p2pA/BwjYG7HwDSpeZFYSZ5np8Ns31bpRLXb7tixr6p5S7Z5OJTcxn57ewOWVxym
uz0qrqATgP94/fg8W55Wdx5PF7OFO9UKvJx5JlFh69moURpdL3wT36ZEEW2atKDMTYplrSaj
FrHkVFyDRqWVPXdFHNdzt4dMxa76nqlDXWGh7Z0vE8vFYr0YAZezyQi2XtbuQw9kKY8WU6hw
M/X5cEdTfm/VM0/HooFiEn9/fD7+efU7Fttsi5/98id8/ue/rx7//P3x4eHx4eprS/UFlGOs
ivarvRA4Mjf7REVwJGS8zVRquH1kOUiZsINw39nAnyms41LaGd2IFdtgQp3GCpeKQ+A28AgN
iLoRabdpDWjud5ipZcTZpTcoauYsvZpR71LezPz8S8ZpRdaeQKRdOVz8hFPnBTQ2QH3VG/7u
4e7t07fRozhHc//ePD0UPMkCZ+BsZF1WA8/DvNrsv39vcum5BgHJKoZesgOtzimCODv5jfxq
P2Bpo9zRJtVL558/NGdt39hY8M5q1r660S1ekv8MJhM4NkOTbXtZqvN1qj2VDadQ1PJXwLYq
hvdtdTELby7KQILHwAWS0I1HM96PeKUZtdKcOjpYFMt3IwDi+kKtJkyJ4dqODMwsvfvAVcmH
k2gUoIGttLnH7gnjJvFfHfBv4+BIDJkThI3gfYWKY0LbBZCCqDVnvWzHiezHRUfHGqxhRDUx
gGJ1Z1//1n5Tpc3qokFDDzHzXucaIpP0etIkCRX3iGhtQgrtZyGQeE6ut6WnJ+BkgZkLN8Ac
OzjAMWrero+HUMmnKzgpJ86ba+ulOxi31KCBqvICVNzNBi16dle1mxOhgIpjevr6fspu06LZ
3o5qxWlDwLB+DaFuXOoDBzzIw0jfVclqF76zzOEPSNbuSJM8L7Bc+6g4kfnyiVgG9cRtqrgM
2cROldrR94AU9gUghRxvdy1WFvLqfym7tu62cST9V/y003N2e0IAvIAP80CRlMQ2KTEiJSt5
0fE6So/PJnaO4/R0769fFMALLgU6+5LI9RVxR6EKKBQevjyq6DfOcxDiM9ExcIfpdjSMjTQH
UB424aUYWdxQbDM2qCdTeX6XL5G/Pr+4SnDfitI+P/wPZowI8EIizi+O+af7KQ4uzODz5n1y
TnNYvP/0SYbFFiuyzPj7P/xZwvDFd0ycYmtJVDvYlURaD5rFmOkDQQYXhMcQhuiDEaEjx35t
6Xoq9nCuT4Uxlerw3pzRarFBvu8+dPozC5LmvIIiqdJjKpjNSBUT8uv9t29CU5VSz1nW5XdJ
KITOEDt/3l9upxNmfP9Z4k3R4gavskm9i4KEi7usXTl5wmGf74t1D/8FJMDbQw+HasAHpF23
9V1hkSpdAEqKvKB2chp6xeMuOdsdlTVZVFAxpvaro405Qnkg7zFJOvZ7rm89SOLpzKPIScYr
ksdOuqwHjxvzuWFsaKiZLmbJrwMKp+8Lg2edEM7PTpGqnif+gYFbmyPECHETvKt2EHHIn+Zd
R+I85LgIWKrPZPBJ6vXPb0I6ufUcXFXtya2oZrTNAdHDP6phKDQb00rSpi2+TzwzUG//yg0W
Zo/GgYqUrM3XPErcFu7bKqfc9nPRtF2rfZSQWRduu1lC4lB93KNxMiS8KpIgotwpjgrV6JUd
WRro4Q9nojs9QDv0pfNbtvt46fvaSmkyaA1h0LI0ZA6RJ8xtTCBHsbf40KVJHNlyrOnM67Cq
X9AzYLPnOpEWj5EuFQA1vXodPHXE6UC2m3fw+XRzuas9V1PVxGw4wyZ0w9MUj2iIDKrphai3
BpvaEfMOtp6f7ZnS1Jdqbwv+1lkK5LNqcEOLxC5SKoiGTjUPRc6o52KlEnj7IjtVtX3Cr71o
hTUF6MRvNIVY1kmM3aQZRyAjKXEaQwojYlNzxji3h0lbdfvu4NT4fMiIGCfejMdnb+ZTcrcu
6npEt1qWyfOmhp4c8pkpmTebQ7nJev3xg6Fk+e1RE9p3ZFSlyK//fhx2MRz7446Mb7eCd/z+
rH8/vera0TANfAinOELuGgwwdZmZ3m0qvRmQMut16b7c/3E1q6G2ViDyjmH0TUjXeG7WThxQ
mwC/+2DyYBLJ4CAMLYL8GNsNNzgoM9pnAngQeVNlmPwyOQieasg82QngkusxwUyQ40AUnHEg
4YEP8JSMl0HoQ0iCDJZhUExWonyBMzsZ1qwMa5C36Hugkh8ii+um5ky8ZB1LKMUx+3DKxuBn
73Pb0ZnrPqep5xKozoekh3DZariLIT4Xh1I++NQYTg4DN4pBKO8Gh6ZnUNv6g9s+iu5/X1Rn
2t5Zrze0RaY4MFk9mFRZkcNz3ELAaOHf1ZJ+gc0VQ2AqskxSz0e+LOfLaEj8wnnb8Fgf/HBg
uoEBKJTsIDbOrMaPsrznaRhhyuXIkgtNWCvjRL6jAYmwNGFGxZg00Bn0uWjQ0WJKBB+RI0td
boTte8KWzZEFble4uXarzm0yg6iC4YxEJ+fVe5pYMVfs4gu9mmEVHpXw2fFlyF8g1j1t91MS
IUkK/YMkQpnECjpgy+0omXwK18g0aLKCucB2zsZa+IeksKHEkNQF/5j04RwRrEWqroXCL+Qm
Ss5TM6z8CC3dthp5wOKgyUL6toCd85XDYznxnsWeaFta8UkYJUslKMpePjOieGP9JSYtFcsw
MpEUbZ+mpTHFboiODGKMhyRCOlICZvgnHaIRvouh8ySolapxRDxF6tM1KxYmaG8rqw1ryXGU
bbLjplQrne5zMcGDc6ib66EX4jJy6ce8I0GAzuXBQF9uhyJNU/Ta/rjo6H8Kxb2wScORndoT
VQ7n96+Pf1yx6xLD6whFwohhcGlISLDCGAya/jXTGxJQ4gMiPDOA8Nu1Jg9+l9XgQaMI6Rwk
SdDSpTREnpbIij45Ew/AfEDoB9CmEUBMPUDiS0p/OWEChHqIP4TR5UlMF9vmDM/+7MDNVxhh
tZv2LYfgr1jityQAaLFz1llDoq2rw7glbQqIOHfYeI5Kp5c92rrsGp/P+1jrFR4Ec2aA6yZI
O/bnFumpoosp0h3wcgglWMsUZV0LOYV5Z0wsUgUALRFJ2NmOG5EquhUthXsrTE2eEGGvYUFn
dQ5O1xssh3USsSTC7wYpjk2HFLnJCUs4w+uz7vJtgzT3po4I7xoUoAEKCAUzQ8nIPFLb7FbI
sQHbVtuYoKbr1NSrJiuRIgh6W54ROhyN2IbC3G/R4oAEjwvfNPOeCIwMv+UhfkNSwWLuHQjF
BjA8ACw0GASQ6yMiaBSASNIBMP1BbdA+69dhNHCbxiG0EGRmAkAJXtCQUurJLqQhpnoYHDHW
YBJAygF6GcGEPABxECMllAhJPUDMsaIDlGLqjcbASILXW2GLYx6e5vGINAkxTFU0OEJkHkog
QtcnCf1EjVL867xlweLq1tTnQ7nxCYE+j1HVa/q63K0pWTW5rYzNC3J+RkRB3cQMHXlNsjjK
m4RhiSXoUiDoS+0mYERPqxuOtiTEFVmUMYJhccY0HBMKDd5vgu67lTYxYPa8BkeUoRqshMKl
IaE4kAmp7nggsx6AkCL12/W52vWtOmNTfMLzXkxkdCgAlCT4jq/Gk/BgSbTv2rxJzmcsA3lY
meKWZ9s4vnn213cNTJpFnm7bk6UxIXBclAiA/bn8YY5/qJyeF0tVNKUQcssLZim0FfygReOg
JEB7TkAxbIEtVaDp8jBpkOVgRFJETCpsxVJkpHV93yUR3ihNE8fLbSLEFKG84Oh55szUJZyi
tp0AEjTvTLQFXxTA1S6jQYqqNTvw2Vv+lFF8BPV5siS3+22T4+tN37QkWJY9kmVZGEoW3K7X
WMLFMQIMnso1bUSWBifEF83b46AvumDMY0RHPvWEYhrKqeeUoQW54yxJGB6TSefhxHfBf+ZJ
CRZJ2uCgha8Q6XJ3SJblGSBY6oRH/ZJdo3hi/U6kBsU02a59SLldo2WX2/qOS5/vUsU0q+Aa
1U9YzP1tQAimUMg1KTMiRw4keCCpryBmDdYSI1PZCDu83EGQjuGEBiza7MOl0Z6EHpkt1Wgk
m2/+jlR4CBoC4lz6Q9UuFaEo19mx7i+b/UmUuWwvd1VXYinqjOusOojVI/N4r2OfQIwVCEfo
iRw7fuJPHWFcLC8wgKe4/OfNPN8onpACIzuOS//OJY6iPK0P5ftFnnlYHOsMgqUsctne5nNW
WRrEFMtJe98RrlR8NWK9TN8P72Lv80vRd95k5OQSrCwMzm+kBix4xYfD3cW07IJBWIelxPD6
aS4g2rnhUm+M99cxSQaRgPddV62s6B3o65OrvMl0do1s/iXDzko3HixxgwM/PJo4OvRJBYmr
oMj2DQYdgnjhl7zBbu4abIaXh0KGd1vnS6Kffzw9gH/0GAnJfVh+XVhXzCRFutaZtPEkVS+2
pHcsQf2pRtC00ttG9n0bRRQ/rpKfZT3lSbDwWAwwwf1neYcj36NPx0882zrXt+sAkHHcAtOk
kPQijRLS3OGhImSS55aK+YS/KSsbb7gFZV04AKiBC8fo4+LQKvIUVX/neCTqfoyQzLCnam0z
aYi/cNOWq0WLKZYUehd1AI3TWUkz7tgAZZP1JbjwW3upsiVyAu94oMSLcTdEB4xdNwnIcz2T
tq1ioXHK1tPOkHq4YtdVOTNpIkXDjxMSUHLu/TE73E73GmeOus1NP3AgdGbAwlmEyz7Mtz0I
O1xqWLzNYV1jKuRcsCFmk9FZMyK1qje/tx72nTDbv3RG2ia/rM6e+I7A9b6LURdkAKUTbd7s
C70hAbDdaIEmD9WDACNGCNE4fleTTJ0zu5MPzofRVypm2B7UispjjGoeNU90HuJq/MDA0wC3
2iecYrsNE5piFRNk3E6TeB8zT6imEUa3JiU4bg3ODVB+lHf2W7NJcpdkeF9q9EPZH02K5i0x
LxQDzQ4SbcO218IxX5EwcNcOvQDK5dZux0MfBZ6gwxLOoz7iPol4uOUBt+q5i/qYcDubrsyX
F7auCpP4vFSBronMK/oTcSEyKLDcfuBibuAbAyoN9KZYtjpHQeC88JytIILbG5URZr63Gpbr
HNB6uAnIWCQ01i7P7GV78rA38gDPFk+Q8CHJujl64Tarmwy10douJkFkjBPlSe+J9anAxCcF
MS/8mY4eDE0wJYnTTtPNApccxZaoHB390bx5vFhkw/9fo1Kc6q7SE4JoLAITwh51axidsFz9
dESyo7GiDPcMnHEKn9zVhCZseazWDYuYb4LPtyycKuQs4inuUCbx982ZYz7JUkjaF7ZkQfb5
dpdt0HtuUgdVN2YsBV0R3eYfAaT18y5MaortMco2ayISWL0MNBI4rQt3NfzLmoT9E1TAIXps
PIDMldWDJ6lf0R0YkDoDEgXLn6Zp6KwO+20Drk6Eo7u5Oot9Xcn8nGK700pUggZIzPYW8nOt
zfGD9LNv5yGux8DxWXvTx+UGdjb0I5yJNBmPDrCuzhCydF/3xhn6zACx144qJmJ3NOJzzTyw
wSP3d3SuqYFmPqHSbXBxZPAMCiKeAOiEmD4zM4Ety3URaUKDmetiRcRSjuc7TrK62GOyzGUU
XQ1u12g+lhf8jGBmq4a6jngOj6Wnaf1vWZ8mEqHFsa1JE4l931B9QbEQgldtne0iFkX47vfM
5tV+ZhZlHi62kWI5RcwzxqquTpnnGovBFdOEYOb+zAQKTUKw1pAI2oLSkdczBJRO8EbJpIaA
GRkWCz5DarXe+aA4ifGiYf6/HraI4+6SBpe01hYrAYZRHKIllVCMDkNpTple6xaY4EaCxYXa
VHYNdMvSxlLmxXiAjgyFUTzNYQ/FVo5MjgQ1cEwenuKZ5y0RPeJruDaynphBWDiP8N4SSIzK
pqZ9n6TUM0/BskW3JmcWnzTELFINXR8/et4f15hOnAexp2gS5D+RQIqO0Va/+TeT5dWrIQSJ
A1oWqgZMdqoDdfUmsh9U11ClsLwxGTphcwbxshgUPJyGHpkmTISIxAxzEDGYRmMNxSjDZ7sy
vqinozGLzsuG6vgWE2Ho3HFtPAdD+0dhCw0nrbe3i2UYcxrmXujW1D5PYJSZY1LdMcRSsQ/u
psiA5MN+yZwOUHb7vlpXurIpn/WTGOhVViw1mcjCU0Lycclj3ZUcWL0sh6zaddus2N/ZbEYh
5gJgZKFR171b8u64Kg4nGZ2yK+syn2JPNtdPj/ejTv/61zczAPFQ7ayBsO1DDt6CZbus3gtD
+eQrIoQz7yGu/AlrRcVzyOAqO5KVxdcVhzcLNAZk8ZVH3gzUSzIFKHHaZPzwVBXlfjh9Mdto
L13/jSjexWk1Di7ZqKfHT9fnsH58+vHn+ELifFimUj6FtTZZZpppeGt06NhSdKxpiiqGrDgt
PNmpeJQB1lQ7+TrlblNim1WKtT/u9NrJ7JuyoXB51GgRiazrrNvCC4iXXPzqbPRuZ9wzlTms
jms4wUWoRSN6fKP3EdaW2oDWgqQ6LW13GPST2/1ICjL94vH3x9f7Lzf9SUt5Pp8XXd5Yry1q
0E6/myx5s7PopqyFZ0r/SWIdKj7sMnloA33TmZ8VJYSr7cQ8rva7S73vOggWpI8A4DrWJdb/
QzWRiugSYTrMVbUeYpB+fvzyen25frq5/y5S+3J9eIXfrzd/W0vg5qv+8d/012/g6FsFTnQn
PUi/Nyez+H6eq3pX3397/fFyfXf/dP/l+XeoDhIgTI3gbXmujhD/vfE9xW3w7Q8VGuNaMTXn
lT0ji54RabJ6i/fuX3/998vjp8VS5mcacc+zgYqjy7KEMPyhMI3DjL+hd+7c9eBvkKkoo9oU
gdGTnRKi29Iz7bLvCnusrY7Fpuz9W6CSh+Z0OFNvPW8FA1tbi1WKmhm3PbEJzCTswPfDLlVR
rA5VgYalHqbjsYVXl0YJYLRh1R7ZJa/2mG44SiZqaQ8zHZHkki6k5V5/429GQMiBVKo2aHpN
Vtd7exFQH56ckSj7P4w95MvJ8B4QRZ3XyuFhbazOgm2S99Pz2+acmJYD+dhDbTz2oPrWzMYu
hlySkSLIwbt+fLneQaSIX6qyLG8IS8O/ewbvujqURX8yMx+I01u99oKvh+RSpPunh8cvX+5f
/kKcW5TO0/eZPJ5XflM/Pj0+C8Xh4RkCv/zXzbeX54fr9+8QzRCCDn59/NNIYlhWT+NJgzX+
+iJLQtQymfCUm5fVJ4CkKXpUNDCU8CZr5GgUkq5fchp6tWtZGDjkvGMs4G72eRexEN/Amhlq
RvHQfkNJ6hOjQVbllGFuV4rpKOrJQkdfEvp/Yl73mOno5ZtBnWpp0jXt2Zkz+92Hy6pfXxQ2
O7b9VGfLcXEouonRlfdiUsbOO8RDJsaXsxKpp2arfHBz0a6DIjO3TQAIOW6CzhwxGjpgxrnb
CQMZLBk311XPib8jBBo5kksQY4d42wVEv1MyDNeax6LMsQNI6UecxlFkp9/lTmQSIo02Ih4z
bZzWbURM41kD0M3FCU+CwGnQ/o5yPaDOSE1V1AaXGiNZCzpqsY8z4MzUHUdtpMFYvjeGuj3m
ZPslTvtJNWYQT7rSjo7n69NC2jRxqyIB9DqVNuITRDgqYPlDFjpNKskpOoNSxlO/kMpuOSfY
MNh2nNqBF412mtpEa6fHr0LM/HH9en16vYGQ/06DHdsiDgNGMjdHBdl31Iws3eTnde2dYnl4
FjxCzsFRIFoCEGdJRLedIyy9KaigcsXh5vXHkzAixmTnGG0WpFbox+8PV7E4P12f4WmM65dv
xqd2YycMvaw0iIyIJqkjGBCbu4NXZNuqGHaiR/3BX5QpXp5VQCPVTUfi2EjR+UJTSgBztZ78
XFDOAxWR/HBy1RvjM2sjZLDsVcP9+P76/PXxf69gHshWd7QeyQ9PG7S607OOgQpivhxqoZym
S6AuTtx09UMtC025fonSAMssSsxATi6MuqppXE1XBYEn96anwdlTbsDM7XoHRX1DTCaqL4EW
RpinWO97YsQs1rFzTgP9upqJRUHg/S70Ys25Fh9G3RKauHtxCs3DsOP6gmag2ZmSOPL2oBwb
6P08nW2dix70tJXE6ALmKdmQtefL0t9Y61wskv5xwfmhi8XHSzuhQwmOWRqgl+XMKUtJlPiy
q/qUeM53dbYDx99usbqZBeSw9gzJhhRENGfoaTCJr0S9Q12MYYJJl1jfrzfCyrtZvzw/vYpP
pr0r6b7y/VUoMvcvn25++X7/KmT14+v17zefNVbNTuz6VcBT48LlQI7xczmFnoI00F6amoj2
JoogxkINdVljI/qB3B4Us8V0yJBUzouOWRcssao+yLD3/3kjRL5YcF/hOVBvpYvD+dbMfJS1
OS0Kq6zVMA/1Qu04DxPqlFWS3ZIK7NfO2xlGEkKRDPE7ehNqHrHJfHtGMNMZsI+16EYWm+VX
xNSqaLQloXkCPHYr9TiFjiMlWBwpNLVzUoMCGT5B4HQLDzhz+yoIeOyyGqE2gHgqO3JO7e8H
AVDYB7IzqLoBW6XmrM52qhnMGDs9lRLuhTHj2FI8d7jdUmJEuhOl78TyhrvTyiHfMX8vQZj9
jMROkrKhE4IO6P7ml5+Zal0rlBS7AkCzmk/UlCZo8wmyb3DLIcuceSimN3bzA6A6Do0grnM1
Q6tAu3MfB/Z4FDMtou5cYpEzJ4tqBQ3eYMaSjudmaoKcABmltkgmaeAJaK/VDNMS5A73Og2I
U/IyXxb8TN9sUH0ktHEa2IeBQA2JfUZ46GvKmdPPiuztZ5DB3P7mY0HEugvnQ3tfdw+Gwqju
w7jNh6XCO2JBZnB7zqmWpOjIoZZ8UTIvmTZK+07kuXt+ef3XTfb1+vL4cP/07vb55Xr/dNPP
M+hdLhewoj95SyaGpLCirXG6P0TmPf2RaHhIyCOJvGGRLXbrTdEz9ZaJ0bgDHds70GA9boAi
i46yZztM0sBaArIjjyjFaBe1lW0UZkBOoedO8pgLcUVV1RU/L6tSM8DCMMX40hSTopMG7ga+
zNhc9f/j/1WaPgdvUVzJCJkbJWA849TSvnl++vLXoD6+a+vazEAQ8NVP1FmI/QWxMnOZly3U
BkCZjwfK47OyN5+fX5QW5OhhLD1/+M0aRLvVlkYILXVorT0jJc1pM/Ag9YVLn3DUl3VGrUkO
Rj2zB3/HN3XkziRBPuOmhkypXwklFw2zNciYOI4sBbo60yiIrCMfaUFRZ80CKc+som73h2PH
rMmbdfm+p9Yh1ras1Vmj0lSfv359fpJX018+3z9c/4+xa+tx3FbSf6VxFljsPixWF8uWF5gH
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
TwIA

--7AUc2qLy4jB3hD7Z--
