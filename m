Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23064C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98162467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAVQ2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:28:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:41188 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVQ2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:28:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 08:28:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="427459230"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jan 2020 08:28:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 56DDB29D; Wed, 22 Jan 2020 18:28:14 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] platform/x86: intel_scu_ipc: Remove Lincroft support
Date:   Wed, 22 Jan 2020 19:28:06 +0300
Message-Id: <20200122162813.26070-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122162813.26070-1-mika.westerberg@linux.intel.com>
References: <20200122162813.26070-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moorestown support was removed years ago with by the commit 1a8359e411eb
("x86/mid: Remove Intel Moorestown"). Lincroft is the CPU side chip of
Moorestown and not supported anymore so remove the code from the driver.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index a9b6decbb367..3cf8954a9f3e 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -58,7 +58,6 @@
 #define IPC_RWBUF_SIZE    20		/* IPC Read buffer Size */
 #define IPC_IOC	          0x100		/* IPC command register IOC bit */
 
-#define PCI_DEVICE_ID_LINCROFT		0x082a
 #define PCI_DEVICE_ID_PENWELL		0x080e
 #define PCI_DEVICE_ID_CLOVERVIEW	0x08ea
 #define PCI_DEVICE_ID_TANGIER		0x11a0
@@ -69,11 +68,6 @@ struct intel_scu_ipc_pdata_t {
 	u32 i2c_len;
 };
 
-static const struct intel_scu_ipc_pdata_t intel_scu_ipc_lincroft_pdata = {
-	.i2c_base = 0xff12b000,
-	.i2c_len = 0x10,
-};
-
 /* Penwell and Cloverview */
 static const struct intel_scu_ipc_pdata_t intel_scu_ipc_penwell_pdata = {
 	.i2c_base = 0xff12b000,
@@ -670,7 +664,6 @@ static int ipc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 #define SCU_DEVICE(id, pdata)	{PCI_VDEVICE(INTEL, id), (kernel_ulong_t)&pdata}
 
 static const struct pci_device_id pci_ids[] = {
-	SCU_DEVICE(PCI_DEVICE_ID_LINCROFT,	intel_scu_ipc_lincroft_pdata),
 	SCU_DEVICE(PCI_DEVICE_ID_PENWELL,	intel_scu_ipc_penwell_pdata),
 	SCU_DEVICE(PCI_DEVICE_ID_CLOVERVIEW,	intel_scu_ipc_penwell_pdata),
 	SCU_DEVICE(PCI_DEVICE_ID_TANGIER,	intel_scu_ipc_tangier_pdata),
-- 
2.24.1

