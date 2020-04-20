Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E497C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381F2206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgDTNDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:03:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:65382 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgDTNDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:03:37 -0400
IronPort-SDR: YLZNMtyeTQhZwrtbIgwJ76R2pycG9xgohg9k4PMX1+2FZpWYFD+BKrltHYKmbHgk0wsELvcv/+
 qybWdd40VUiQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 06:03:36 -0700
IronPort-SDR: ZXwZkDXXR4gEPdqiOraDhHgmpgWTtuxOYe9vGAjmq8VqsjVZfrUZSKkTzQH3DzadbHk7HR7nAj
 jVsipxjkSe+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="364994592"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2020 06:03:34 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jQW5E-00046y-Ru; Mon, 20 Apr 2020 21:03:32 +0800
Date:   Mon, 20 Apr 2020 21:02:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: drivers/mtd/spi-nor/controllers/intel-spi.c:224:20: warning: Clarify
 calculation precedence for '&' and '?'. [clarifyCalculation]
Message-ID: <202004202142.XUbqbo8p%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ae83d0b416db002fe95601e7f97f64b59514d936
commit: 2098c564701c0dde76063dd9c5c00a7a1f173541 mtd: spi-nor: Compile files in controllers/ directory
date:   11 days ago

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/mtd/spi-nor/controllers/intel-spi.c:224:20: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
       value & PR_WPE ? 'W' : '.',
                      ^
   drivers/mtd/spi-nor/controllers/intel-spi.c:225:20: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
       value & PR_RPE ? 'R' : '.');
                      ^

vim +224 drivers/mtd/spi-nor/controllers/intel-spi.c

8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  165  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  166  static void intel_spi_dump_regs(struct intel_spi *ispi)
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  167  {
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  168  	u32 value;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  169  	int i;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  170  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  171  	dev_dbg(ispi->dev, "BFPREG=0x%08x\n", readl(ispi->base + BFPREG));
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  172  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  173  	value = readl(ispi->base + HSFSTS_CTL);
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  174  	dev_dbg(ispi->dev, "HSFSTS_CTL=0x%08x\n", value);
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  175  	if (value & HSFSTS_CTL_FLOCKDN)
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  176  		dev_dbg(ispi->dev, "-> Locked\n");
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  177  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  178  	dev_dbg(ispi->dev, "FADDR=0x%08x\n", readl(ispi->base + FADDR));
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  179  	dev_dbg(ispi->dev, "DLOCK=0x%08x\n", readl(ispi->base + DLOCK));
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  180  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  181  	for (i = 0; i < 16; i++)
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  182  		dev_dbg(ispi->dev, "FDATA(%d)=0x%08x\n",
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  183  			i, readl(ispi->base + FDATA(i)));
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  184  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  185  	dev_dbg(ispi->dev, "FRACC=0x%08x\n", readl(ispi->base + FRACC));
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  186  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  187  	for (i = 0; i < ispi->nregions; i++)
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  188  		dev_dbg(ispi->dev, "FREG(%d)=0x%08x\n", i,
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  189  			readl(ispi->base + FREG(i)));
9cbb035cc111f5 drivers/mtd/spi-nor/intel-spi.c Bin Meng        2017-09-11  190  	for (i = 0; i < ispi->pr_num; i++)
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  191  		dev_dbg(ispi->dev, "PR(%d)=0x%08x\n", i,
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  192  			readl(ispi->pregs + PR(i)));
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  193  
3912970809cfbc drivers/mtd/spi-nor/intel-spi.c Jethro Beekman  2019-09-04  194  	if (ispi->sregs) {
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  195  		value = readl(ispi->sregs + SSFSTS_CTL);
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  196  		dev_dbg(ispi->dev, "SSFSTS_CTL=0x%08x\n", value);
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  197  		dev_dbg(ispi->dev, "PREOP_OPTYPE=0x%08x\n",
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  198  			readl(ispi->sregs + PREOP_OPTYPE));
3912970809cfbc drivers/mtd/spi-nor/intel-spi.c Jethro Beekman  2019-09-04  199  		dev_dbg(ispi->dev, "OPMENU0=0x%08x\n",
3912970809cfbc drivers/mtd/spi-nor/intel-spi.c Jethro Beekman  2019-09-04  200  			readl(ispi->sregs + OPMENU0));
3912970809cfbc drivers/mtd/spi-nor/intel-spi.c Jethro Beekman  2019-09-04  201  		dev_dbg(ispi->dev, "OPMENU1=0x%08x\n",
3912970809cfbc drivers/mtd/spi-nor/intel-spi.c Jethro Beekman  2019-09-04  202  			readl(ispi->sregs + OPMENU1));
3912970809cfbc drivers/mtd/spi-nor/intel-spi.c Jethro Beekman  2019-09-04  203  	}
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  204  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  205  	if (ispi->info->type == INTEL_SPI_BYT)
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  206  		dev_dbg(ispi->dev, "BCR=0x%08x\n", readl(ispi->base + BYT_BCR));
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  207  
3163d125b7b1f9 drivers/mtd/spi-nor/intel-spi.c Bin Meng        2017-09-11  208  	dev_dbg(ispi->dev, "LVSCC=0x%08x\n", readl(ispi->base + LVSCC));
3163d125b7b1f9 drivers/mtd/spi-nor/intel-spi.c Bin Meng        2017-09-11  209  	dev_dbg(ispi->dev, "UVSCC=0x%08x\n", readl(ispi->base + UVSCC));
3163d125b7b1f9 drivers/mtd/spi-nor/intel-spi.c Bin Meng        2017-09-11  210  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  211  	dev_dbg(ispi->dev, "Protected regions:\n");
9cbb035cc111f5 drivers/mtd/spi-nor/intel-spi.c Bin Meng        2017-09-11  212  	for (i = 0; i < ispi->pr_num; i++) {
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  213  		u32 base, limit;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  214  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  215  		value = readl(ispi->pregs + PR(i));
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  216  		if (!(value & (PR_WPE | PR_RPE)))
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  217  			continue;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  218  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  219  		limit = (value & PR_LIMIT_MASK) >> PR_LIMIT_SHIFT;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  220  		base = value & PR_BASE_MASK;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  221  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  222  		dev_dbg(ispi->dev, " %02d base: 0x%08x limit: 0x%08x [%c%c]\n",
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  223  			 i, base << 12, (limit << 12) | 0xfff,
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28 @224  			 value & PR_WPE ? 'W' : '.',
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  225  			 value & PR_RPE ? 'R' : '.');
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  226  	}
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  227  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  228  	dev_dbg(ispi->dev, "Flash regions:\n");
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  229  	for (i = 0; i < ispi->nregions; i++) {
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  230  		u32 region, base, limit;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  231  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  232  		region = readl(ispi->base + FREG(i));
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  233  		base = region & FREG_BASE_MASK;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  234  		limit = (region & FREG_LIMIT_MASK) >> FREG_LIMIT_SHIFT;
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  235  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  236  		if (base >= limit || (i > 0 && limit == 0))
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  237  			dev_dbg(ispi->dev, " %02d disabled\n", i);
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  238  		else
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  239  			dev_dbg(ispi->dev, " %02d base: 0x%08x limit: 0x%08x\n",
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  240  				 i, base << 12, (limit << 12) | 0xfff);
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  241  	}
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  242  
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  243  	dev_dbg(ispi->dev, "Using %cW sequencer for register access\n",
2421f1ccbd4e7c drivers/mtd/spi-nor/intel-spi.c Bin Meng        2017-09-11  244  		ispi->swseq_reg ? 'S' : 'H');
3163d125b7b1f9 drivers/mtd/spi-nor/intel-spi.c Bin Meng        2017-09-11  245  	dev_dbg(ispi->dev, "Using %cW sequencer for erase operation\n",
3163d125b7b1f9 drivers/mtd/spi-nor/intel-spi.c Bin Meng        2017-09-11  246  		ispi->swseq_erase ? 'S' : 'H');
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  247  }
8afda8b26d01ee drivers/mtd/spi-nor/intel-spi.c Mika Westerberg 2016-11-28  248  

:::::: The code at line 224 was first introduced by commit
:::::: 8afda8b26d01ee26a60ef2f0284a7f01a5ed96f8 spi-nor: Add support for Intel SPI serial flash controller

:::::: TO: Mika Westerberg <mika.westerberg@linux.intel.com>
:::::: CC: Lee Jones <lee.jones@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
