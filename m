Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8831CC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6F12075A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgDWFyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 01:54:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:50393 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgDWFyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 01:54:38 -0400
IronPort-SDR: cd45g1+s3Ko2z13T/I4BL72MSGBcBQxUlNJkeTjeOmdjxA1OnLgP9RgZLxmUIUNWyHfW4O1e/A
 sginZDNKTnNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 22:54:37 -0700
IronPort-SDR: AvONvmMki+KLtkueEETbgFSKB+AZJ7EMDE+xxKAtUtJ40LM/wH6GAI6mngGShITfLpEv52hvfc
 cF9mhUchwmKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,305,1583222400"; 
   d="scan'208";a="259314499"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2020 22:54:34 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jRUok-000G7e-9T; Thu, 23 Apr 2020 13:54:34 +0800
Date:   Thu, 23 Apr 2020 13:53:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: drivers/mtd/spi-nor/controllers/cadence-quadspi.c:258:18: warning:
 Shifting signed 32-bit value by 31 bits is implementation-defined behaviour
 [shiftTooManyBitsSigned]
Message-ID: <202004231316.wncfJ979%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c578ddb39e565139897124e74e5a43e56538cb33
commit: 2098c564701c0dde76063dd9c5c00a7a1f173541 mtd: spi-nor: Compile files in controllers/ directory
date:   13 days ago

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/mtd/spi-nor/controllers/cadence-quadspi.c:258:18: warning: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour [shiftTooManyBitsSigned]
    return reg & (1 << CQSPI_REG_CONFIG_IDLE_LSB);
                    ^

vim +258 drivers/mtd/spi-nor/controllers/cadence-quadspi.c

14062341053690 drivers/mtd/spi-nor/cadence-quadspi.c Graham Moore 2016-06-04  253  
14062341053690 drivers/mtd/spi-nor/cadence-quadspi.c Graham Moore 2016-06-04  254  static bool cqspi_is_idle(struct cqspi_st *cqspi)
14062341053690 drivers/mtd/spi-nor/cadence-quadspi.c Graham Moore 2016-06-04  255  {
14062341053690 drivers/mtd/spi-nor/cadence-quadspi.c Graham Moore 2016-06-04  256  	u32 reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
14062341053690 drivers/mtd/spi-nor/cadence-quadspi.c Graham Moore 2016-06-04  257  
14062341053690 drivers/mtd/spi-nor/cadence-quadspi.c Graham Moore 2016-06-04 @258  	return reg & (1 << CQSPI_REG_CONFIG_IDLE_LSB);
14062341053690 drivers/mtd/spi-nor/cadence-quadspi.c Graham Moore 2016-06-04  259  }
14062341053690 drivers/mtd/spi-nor/cadence-quadspi.c Graham Moore 2016-06-04  260  

:::::: The code at line 258 was first introduced by commit
:::::: 140623410536905fa6ab737b625decfde6c64a72 mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller

:::::: TO: Graham Moore <grmoore@opensource.altera.com>
:::::: CC: Brian Norris <computersforpeace@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
