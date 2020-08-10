Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6C2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 411DF20734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHJXoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 19:44:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:64836 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgHJXob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:44:31 -0400
IronPort-SDR: UoIR9fkMwZPYVRUuf5zsM4ZdoaIDrxkxT3U/e7/m0+L4dAZaqsIkh72PcmEpwabOh3kl3rbQ71
 g3UasnPsQ82A==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="151316869"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="151316869"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 16:43:29 -0700
IronPort-SDR: v9c2PAZwNO3FXNMWA9yOOxmz7419EvMCqt72+4Gq6Z0Rntt/HwMrV/EUUl0Hk17Mk07FsvFvPA
 Wc7qsYn0aqfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="277419707"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Aug 2020 16:43:28 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5HRv-0000GH-Mj; Mon, 10 Aug 2020 23:43:27 +0000
Date:   Tue, 11 Aug 2020 07:42:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/misc/habanalabs/common/firmware_if.c:371:18: warning:
 Shifting signed 32-bit value by 31 bits is undefined behaviour
Message-ID: <202008110732.cIJ0Afx8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc80c51fd4b23ec007e88d4c688f2cac1b8648e7
commit: 7b16a15524d5db449cf5e529602610cdf04eddab habanalabs: fix up absolute include instructions
date:   13 days ago
compiler: riscv64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/misc/habanalabs/common/hw_queue.c:294:8: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
       (1 << CQ_ENTRY_READY_SHIFT));
          ^
--
>> drivers/misc/habanalabs/common/firmware_if.c:371:18: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    if (!(err_val & CPU_BOOT_ERR0_ENABLED))
                    ^
--
>> drivers/misc/habanalabs/gaudi/gaudi.c:3941:20: warning: Variable 'new_dma_pkt->ctl' is reassigned a value before the old one has been used. [redundantAssignment]
     new_dma_pkt->ctl = cpu_to_le32(ctl);
                      ^
   drivers/misc/habanalabs/gaudi/gaudi.c:3935:20: note: Variable 'new_dma_pkt->ctl' is reassigned a value before the old one has been used.
     new_dma_pkt->ctl = user_dma_pkt->ctl;
                      ^
   drivers/misc/habanalabs/gaudi/gaudi.c:3941:20: note: Variable 'new_dma_pkt->ctl' is reassigned a value before the old one has been used.
     new_dma_pkt->ctl = cpu_to_le32(ctl);
                      ^
>> drivers/misc/habanalabs/gaudi/gaudi.c:6249:5: warning: Variable 'rc' is reassigned a value before the old one has been used. [redundantAssignment]
    rc = hl_poll_timeout(
       ^
   drivers/misc/habanalabs/gaudi/gaudi.c:6240:5: note: Variable 'rc' is reassigned a value before the old one has been used.
    rc = hl_poll_timeout(
       ^
   drivers/misc/habanalabs/gaudi/gaudi.c:6249:5: note: Variable 'rc' is reassigned a value before the old one has been used.
    rc = hl_poll_timeout(
       ^
>> drivers/misc/habanalabs/gaudi/gaudi.c:658:7: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
      (1 << GAUDI_PKT_CTL_MB_SHIFT));
         ^
   drivers/misc/habanalabs/gaudi/gaudi.c:2301:34: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
     gaudi->hw_cap_initialized |= 1 << (HW_CAP_TPC_SHIFT + tpc_id);
                                    ^
   drivers/misc/habanalabs/gaudi/gaudi.c:2503:3: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
     WREG32(mmDMA0_QM_CGM_CFG + qman_offset,
     ^
   drivers/misc/habanalabs/gaudi/gaudi.c:2514:3: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
     WREG32(mmDMA0_QM_CGM_CFG + qman_offset,
     ^
   drivers/misc/habanalabs/gaudi/gaudi.c:2520:3: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
     WREG32(mmMME0_QM_CGM_CFG, QMAN_COMMON_CP_CGM_PWR_GATE_EN);
     ^
   drivers/misc/habanalabs/gaudi/gaudi.c:2525:3: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
     WREG32(mmMME2_QM_CGM_CFG, QMAN_COMMON_CP_CGM_PWR_GATE_EN);
     ^
   drivers/misc/habanalabs/gaudi/gaudi.c:2535:3: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
     WREG32(mmTPC0_QM_CGM_CFG + qman_offset,
     ^
   drivers/misc/habanalabs/gaudi/gaudi.c:2884:2: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    WREG32(mmPSOC_GLOBAL_CONF_SOFT_RST_CFG_L, CFG_RST_L_TPC_MASK);
    ^
   drivers/misc/habanalabs/gaudi/gaudi.c:2896:2: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST_CFG_L,
    ^
   drivers/misc/habanalabs/gaudi/gaudi.c:3441:7: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
      (1 << GAUDI_PKT_CTL_MB_SHIFT);
         ^
   drivers/misc/habanalabs/gaudi/gaudi.c:4246:7: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
      (1 << GAUDI_PKT_CTL_MB_SHIFT);
         ^
   drivers/misc/habanalabs/gaudi/gaudi.c:4258:7: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
      (1 << GAUDI_PKT_CTL_MB_SHIFT);
         ^
   drivers/misc/habanalabs/gaudi/gaudi.c:4294:7: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
      (1 << GAUDI_PKT_CTL_MB_SHIFT));
         ^
   drivers/misc/habanalabs/gaudi/gaudi.c:4902:7: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
      (1 << GAUDI_PKT_CTL_MB_SHIFT);
         ^
--
>> drivers/misc/habanalabs/gaudi/gaudi_security.c:519:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME0_CTRL_QM_SLV_LBW_CLK_EN & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:560:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME0_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:597:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME0_QM_PQ_STS0_3 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:617:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME0_QM_CQ_TSIZE_0 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:650:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME0_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:687:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME0_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:724:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME0_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:756:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME0_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:813:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME0_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:871:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME0_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:954:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME1_CTRL_QM_SLV_LBW_CLK_EN & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:998:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME2_CTRL_QM_SLV_LBW_CLK_EN & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1039:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME2_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1076:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME2_QM_PQ_STS0_3 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1096:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME2_QM_CQ_TSIZE_0 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1129:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME2_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1166:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME2_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1203:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME2_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1235:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME2_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1292:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME2_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1351:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME2_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1434:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmMME3_CTRL_QM_SLV_LBW_CLK_EN & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1517:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmDMA0_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1554:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmDMA0_QM_PQ_STS0_3 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1574:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmDMA0_QM_CQ_TSIZE_0 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1607:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmDMA0_QM_CQ_TSIZE_STS_4 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1644:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmDMA0_QM_CP_MSG_BASE2_ADDR_LO_1 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1681:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_2 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1714:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmDMA0_QM_CP_BARRIER_CFG_2 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1771:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmDMA0_QM_ARB_MST_AVAIL_CRED_23 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1830:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmDMA0_QM_ARB_MST_CRED_STS_19 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1912:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmDMA1_QM_PQ_BASE_LO_3 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1949:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmDMA1_QM_PQ_STS0_3 & 0x7F) >> 2);
              ^
   drivers/misc/habanalabs/gaudi/gaudi_security.c:1969:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    mask |= 1 << ((mmDMA1_QM_CQ_TSIZE_0 & 0x7F) >> 2);

vim +371 drivers/misc/habanalabs/common/firmware_if.c

7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  356  
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  357  static void fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg)
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  358  {
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  359  	u32 err_val;
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  360  
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  361  	/* Some of the firmware status codes are deprecated in newer f/w
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  362  	 * versions. In those versions, the errors are reported
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  363  	 * in different registers. Therefore, we need to check those
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  364  	 * registers and print the exact errors. Moreover, there
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  365  	 * may be multiple errors, so we need to report on each error
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  366  	 * separately. Some of the error codes might indicate a state
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  367  	 * that is not an error per-se, but it is an error in production
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  368  	 * environment
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  369  	 */
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  370  	err_val = RREG32(boot_err0_reg);
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26 @371  	if (!(err_val & CPU_BOOT_ERR0_ENABLED))
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  372  		return;
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  373  
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  374  	if (err_val & CPU_BOOT_ERR0_DRAM_INIT_FAIL)
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  375  		dev_err(hdev->dev,
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  376  			"Device boot error - DRAM initialization failed\n");
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  377  	if (err_val & CPU_BOOT_ERR0_FIT_CORRUPTED)
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  378  		dev_err(hdev->dev, "Device boot error - FIT image corrupted\n");
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  379  	if (err_val & CPU_BOOT_ERR0_TS_INIT_FAIL)
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  380  		dev_err(hdev->dev,
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  381  			"Device boot error - Thermal Sensor initialization failed\n");
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  382  	if (err_val & CPU_BOOT_ERR0_DRAM_SKIPPED)
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  383  		dev_warn(hdev->dev,
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  384  			"Device boot warning - Skipped DRAM initialization\n");
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  385  	if (err_val & CPU_BOOT_ERR0_BMC_WAIT_SKIPPED)
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  386  		dev_warn(hdev->dev,
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  387  			"Device boot error - Skipped waiting for BMC\n");
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  388  	if (err_val & CPU_BOOT_ERR0_NIC_DATA_NOT_RDY)
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  389  		dev_err(hdev->dev,
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  390  			"Device boot error - Serdes data from BMC not available\n");
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  391  	if (err_val & CPU_BOOT_ERR0_NIC_FW_FAIL)
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  392  		dev_err(hdev->dev,
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  393  			"Device boot error - NIC F/W initialization failed\n");
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  394  }
7e1c07dd352509 drivers/misc/habanalabs/firmware_if.c Oded Gabbay 2020-03-26  395  

:::::: The code at line 371 was first introduced by commit
:::::: 7e1c07dd35250971cd29c60c786ac676179eb7f9 habanalabs: unify and improve device cpu init

:::::: TO: Oded Gabbay <oded.gabbay@gmail.com>
:::::: CC: Oded Gabbay <oded.gabbay@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
