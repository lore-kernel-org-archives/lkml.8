Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3C4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 05:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB3D20776
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 05:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgEXF3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 01:29:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:12732 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgEXF3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 01:29:01 -0400
IronPort-SDR: XL5yFXlMDsiNSA5wECb4tnSuLouarHAQwX48990wHRh6ECkd+JhRLZzR6OGzrwjBUl7YCpd1Wx
 /9tQGS9XG7zQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2020 22:29:00 -0700
IronPort-SDR: IFoBZC1WP6hBXsYE3/GxtlXqtrs/WO8+ir/h98nDrVPJEs71hmxFrY7SD8/yFWEWXQPvGwNv7D
 wLcfFuLgPzyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,428,1583222400"; 
   d="scan'208";a="413178843"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 May 2020 22:28:58 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jcjBx-0002Yw-TK; Sun, 24 May 2020 13:28:57 +0800
Date:   Sun, 24 May 2020 13:28:30 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: drivers/misc/pci_endpoint_test.c:347:6: warning: Local variable
 'irq_type' shadows outer variable [shadowVariable]
Message-ID: <202005241325.ko7vAgMK%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   caffb99b6929f41a69edbb5aef3a359bf45f3315
commit: b2ba9225e0313b1de631a44b7b48c109032bffec misc: pci_endpoint_test: Avoid using module parameter to determine irqtype
date:   7 weeks ago
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        git checkout b2ba9225e0313b1de631a44b7b48c109032bffec
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/misc/pci_endpoint_test.c:347:6: warning: Local variable 'irq_type' shadows outer variable [shadowVariable]
    int irq_type = test->irq_type;
        ^
   drivers/misc/pci_endpoint_test.c:86:12: note: Shadowed declaration
   static int irq_type = IRQ_TYPE_MSI;
              ^
   drivers/misc/pci_endpoint_test.c:347:6: note: Shadow variable
    int irq_type = test->irq_type;
        ^
   drivers/misc/pci_endpoint_test.c:481:6: warning: Local variable 'irq_type' shadows outer variable [shadowVariable]
    int irq_type = test->irq_type;
        ^
   drivers/misc/pci_endpoint_test.c:86:12: note: Shadowed declaration
   static int irq_type = IRQ_TYPE_MSI;
              ^
   drivers/misc/pci_endpoint_test.c:481:6: note: Shadow variable
    int irq_type = test->irq_type;
        ^
   drivers/misc/pci_endpoint_test.c:580:6: warning: Local variable 'irq_type' shadows outer variable [shadowVariable]
    int irq_type = test->irq_type;
        ^
   drivers/misc/pci_endpoint_test.c:86:12: note: Shadowed declaration
   static int irq_type = IRQ_TYPE_MSI;
              ^
   drivers/misc/pci_endpoint_test.c:580:6: note: Shadow variable
    int irq_type = test->irq_type;
        ^

vim +/irq_type +347 drivers/misc/pci_endpoint_test.c

   326	
   327	static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
   328					   unsigned long arg)
   329	{
   330		struct pci_endpoint_test_xfer_param param;
   331		bool ret = false;
   332		void *src_addr;
   333		void *dst_addr;
   334		u32 flags = 0;
   335		bool use_dma;
   336		size_t size;
   337		dma_addr_t src_phys_addr;
   338		dma_addr_t dst_phys_addr;
   339		struct pci_dev *pdev = test->pdev;
   340		struct device *dev = &pdev->dev;
   341		void *orig_src_addr;
   342		dma_addr_t orig_src_phys_addr;
   343		void *orig_dst_addr;
   344		dma_addr_t orig_dst_phys_addr;
   345		size_t offset;
   346		size_t alignment = test->alignment;
 > 347		int irq_type = test->irq_type;
   348		u32 src_crc32;
   349		u32 dst_crc32;
   350		int err;
   351	
   352		err = copy_from_user(&param, (void __user *)arg, sizeof(param));
   353		if (err) {
   354			dev_err(dev, "Failed to get transfer param\n");
   355			return false;
   356		}
   357	
   358		size = param.size;
   359		if (size > SIZE_MAX - alignment)
   360			goto err;
   361	
   362		use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
   363		if (use_dma)
   364			flags |= FLAG_USE_DMA;
   365	
   366		if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
   367			dev_err(dev, "Invalid IRQ type option\n");
   368			goto err;
   369		}
   370	
   371		orig_src_addr = kzalloc(size + alignment, GFP_KERNEL);
   372		if (!orig_src_addr) {
   373			dev_err(dev, "Failed to allocate source buffer\n");
   374			ret = false;
   375			goto err;
   376		}
   377	
   378		get_random_bytes(orig_src_addr, size + alignment);
   379		orig_src_phys_addr = dma_map_single(dev, orig_src_addr,
   380						    size + alignment, DMA_TO_DEVICE);
   381		if (dma_mapping_error(dev, orig_src_phys_addr)) {
   382			dev_err(dev, "failed to map source buffer address\n");
   383			ret = false;
   384			goto err_src_phys_addr;
   385		}
   386	
   387		if (alignment && !IS_ALIGNED(orig_src_phys_addr, alignment)) {
   388			src_phys_addr = PTR_ALIGN(orig_src_phys_addr, alignment);
   389			offset = src_phys_addr - orig_src_phys_addr;
   390			src_addr = orig_src_addr + offset;
   391		} else {
   392			src_phys_addr = orig_src_phys_addr;
   393			src_addr = orig_src_addr;
   394		}
   395	
   396		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_SRC_ADDR,
   397					 lower_32_bits(src_phys_addr));
   398	
   399		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
   400					 upper_32_bits(src_phys_addr));
   401	
   402		src_crc32 = crc32_le(~0, src_addr, size);
   403	
   404		orig_dst_addr = kzalloc(size + alignment, GFP_KERNEL);
   405		if (!orig_dst_addr) {
   406			dev_err(dev, "Failed to allocate destination address\n");
   407			ret = false;
   408			goto err_dst_addr;
   409		}
   410	
   411		orig_dst_phys_addr = dma_map_single(dev, orig_dst_addr,
   412						    size + alignment, DMA_FROM_DEVICE);
   413		if (dma_mapping_error(dev, orig_dst_phys_addr)) {
   414			dev_err(dev, "failed to map destination buffer address\n");
   415			ret = false;
   416			goto err_dst_phys_addr;
   417		}
   418	
   419		if (alignment && !IS_ALIGNED(orig_dst_phys_addr, alignment)) {
   420			dst_phys_addr = PTR_ALIGN(orig_dst_phys_addr, alignment);
   421			offset = dst_phys_addr - orig_dst_phys_addr;
   422			dst_addr = orig_dst_addr + offset;
   423		} else {
   424			dst_phys_addr = orig_dst_phys_addr;
   425			dst_addr = orig_dst_addr;
   426		}
   427	
   428		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
   429					 lower_32_bits(dst_phys_addr));
   430		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
   431					 upper_32_bits(dst_phys_addr));
   432	
   433		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE,
   434					 size);
   435	
   436		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
   437		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
   438		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
   439		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
   440					 COMMAND_COPY);
   441	
   442		wait_for_completion(&test->irq_raised);
   443	
   444		dma_unmap_single(dev, orig_dst_phys_addr, size + alignment,
   445				 DMA_FROM_DEVICE);
   446	
   447		dst_crc32 = crc32_le(~0, dst_addr, size);
   448		if (dst_crc32 == src_crc32)
   449			ret = true;
   450	
   451	err_dst_phys_addr:
   452		kfree(orig_dst_addr);
   453	
   454	err_dst_addr:
   455		dma_unmap_single(dev, orig_src_phys_addr, size + alignment,
   456				 DMA_TO_DEVICE);
   457	
   458	err_src_phys_addr:
   459		kfree(orig_src_addr);
   460	
   461	err:
   462		return ret;
   463	}
   464	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
