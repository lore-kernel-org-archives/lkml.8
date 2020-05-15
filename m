Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5420C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0332078C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgEONoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:44:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:60750 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgEONoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:44:07 -0400
IronPort-SDR: vgXafYPNrZei6ZKRyO6G8T/q3ZNdA899gAHAf3yARhVafce2xfOc76umBqvjMuDm5CEMluuGKt
 c/xeyxd0A13A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 06:44:07 -0700
IronPort-SDR: XUuWNIa/68RF2TL7GYDZ0s/YCiuLMpru58HLd5CXgkXXhAEkeWFMozt3KinDZ4zrLhmR6Dbdkm
 2j14CFRSWdTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="464907167"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 May 2020 06:44:03 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jZad9-00018C-6A; Fri, 15 May 2020 21:44:03 +0800
Date:   Fri, 15 May 2020 21:43:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, arnd@arndb.de, brendanhiggins@google.com,
        tglx@linutronix.de, boris.brezillon@collabora.com,
        anders.roxell@linaro.org, masonccyang@mxic.com.tw
Subject: Re: [PATCH v7 2/2] mtd: rawnand: Add NAND controller support on
 Intel LGM SoC
Message-ID: <202005152142.AWvx4xc5%lkp@intel.com>
References: <20200515105537.4876-3-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515105537.4876-3-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Ramuthevar,Vadivel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on arm-soc/for-next linus/master linux/master v5.7-rc5 next-20200514]
[cannot apply to mtd/master]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Ramuthevar-Vadivel-MuruganX/mtd-rawnand-Add-NAND-controller-support-on-Intel-LGM-SoC/20200515-185904
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-193-gb8fad4bc-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/mtd/nand/raw/intel-nand-controller.c:441:24: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int val @@    got restricted __be32 [assignedunsigned int val @@
>> drivers/mtd/nand/raw/intel-nand-controller.c:441:24: sparse:    expected unsigned int val
>> drivers/mtd/nand/raw/intel-nand-controller.c:441:24: sparse:    got restricted __be32 [assigned] [usertype] reg
   drivers/mtd/nand/raw/intel-nand-controller.c:444:24: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int val @@    got restricted __be32 [assignedunsigned int val @@
   drivers/mtd/nand/raw/intel-nand-controller.c:444:24: sparse:    expected unsigned int val
   drivers/mtd/nand/raw/intel-nand-controller.c:444:24: sparse:    got restricted __be32 [assigned] [usertype] reg

vim +441 drivers/mtd/nand/raw/intel-nand-controller.c

   420	
   421	static int ebu_nand_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
   422					     int oob_required, int page)
   423	{
   424		struct mtd_info *mtd = nand_to_mtd(chip);
   425		struct ebu_nand_controller *ebu_host = nand_get_controller_data(chip);
   426		void __iomem *int_sta = ebu_host->hsnand + HSNAND_INT_STA;
   427		int ret, val, x;
   428		__be32 reg;
   429	
   430		ebu_nand_trigger(ebu_host, page, NAND_CMD_SEQIN);
   431	
   432		ret = ebu_dma_start(ebu_host, DMA_MEM_TO_DEV, buf, mtd->writesize);
   433		if (ret)
   434			return ret;
   435	
   436		if (oob_required) {
   437			const u8 *pdata;
   438	
   439			pdata = chip->oob_poi;
   440			reg = cpu_to_be32(*pdata++);
 > 441			writel(reg, ebu_host->hsnand + HSNAND_CMSG_0);
   442	
   443			reg = cpu_to_be32(*pdata);
   444			writel(reg, ebu_host->hsnand + HSNAND_CMSG_1);
   445		}
   446	
   447		ret = readl_poll_timeout_atomic(int_sta, val,
   448						!(val & HSNAND_INT_STA_WR_C), 10, 1000);
   449		if (ret)
   450			return -EIO;
   451	
   452		x = readl(ebu_host->hsnand + HSNAND_CTL);
   453		x &= ~HSNAND_CTL_GO;
   454		writel(x, ebu_host->hsnand + HSNAND_CTL);
   455	
   456		return 0;
   457	}
   458	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
