Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1196DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40A920CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgCCNht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:37:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:3885 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbgCCNhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:37:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 05:36:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="274202654"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Mar 2020 05:36:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D260D17C; Tue,  3 Mar 2020 15:36:49 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/19] mfd: intel_soc_pmic: Add SCU IPC member to struct intel_soc_pmic
Date:   Tue,  3 Mar 2020 16:36:40 +0300
Message-Id: <20200303133649.39819-11-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303133649.39819-1-mika.westerberg@linux.intel.com>
References: <20200303133649.39819-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both PMIC drivers (intel_soc_pmic_mrfld and intel_soc_pmic_bxtwc) will
be using this field going forward to access the SCU IPC instance.

While there add kernel-doc for the intel_soc_pmic structure.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/intel_soc_pmic.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/mfd/intel_soc_pmic.h b/include/linux/mfd/intel_soc_pmic.h
index bfecd6bd4990..6a88e34cb955 100644
--- a/include/linux/mfd/intel_soc_pmic.h
+++ b/include/linux/mfd/intel_soc_pmic.h
@@ -13,6 +13,20 @@
 
 #include <linux/regmap.h>
 
+/**
+ * struct intel_soc_pmic - Intel SoC PMIC data
+ * @irq: Master interrupt number of the parent PMIC device
+ * @regmap: Pointer to the parent PMIC device regmap structure
+ * @irq_chip_data: IRQ chip data for the PMIC itself
+ * @irq_chip_data_pwrbtn: Chained IRQ chip data for the Power Button
+ * @irq_chip_data_tmu: Chained IRQ chip data for the Time Management Unit
+ * @irq_chip_data_bcu: Chained IRQ chip data for the Burst Control Unit
+ * @irq_chip_data_adc: Chained IRQ chip data for the General Purpose ADC
+ * @irq_chip_data_chgr: Chained IRQ chip data for the External Charger
+ * @irq_chip_data_crit: Chained IRQ chip data for the Critical Event Handler
+ * @dev: Pointer to the parent PMIC device
+ * @scu: Pointer to the SCU IPC device data structure
+ */
 struct intel_soc_pmic {
 	int irq;
 	struct regmap *regmap;
@@ -24,6 +38,7 @@ struct intel_soc_pmic {
 	struct regmap_irq_chip_data *irq_chip_data_chgr;
 	struct regmap_irq_chip_data *irq_chip_data_crit;
 	struct device *dev;
+	struct intel_scu_ipc_dev *scu;
 };
 
 int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,
-- 
2.25.1

