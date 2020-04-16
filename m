Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B609CC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C91320787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502157AbgDPIbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:31:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:18319 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2501895AbgDPIQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:16:37 -0400
IronPort-SDR: Y8pGEpVyL5rtkzQ65WFa8LJBbVwpgDU0iSluK3prUhuBNYLXecvBfA5nl4QoEeU+chdReOyuNS
 gV5jaUcY2gyw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:16:03 -0700
IronPort-SDR: +92X+K1IO0SrIbRLNu0fGGTKoiukqM2epgNMLhvKCJazdcvCQ6yebxtyGbWEvhKmDfVqJJ3OLB
 aKnhrMdcpKWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="271999472"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Apr 2020 01:15:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B23A5F20; Thu, 16 Apr 2020 11:15:53 +0300 (EEST)
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
Subject: [PATCH v9 14/20] usb: typec: mux: Convert the Intel PMC Mux driver to use new SCU IPC API
Date:   Thu, 16 Apr 2020 11:15:46 +0300
Message-Id: <20200416081552.68083-15-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Convert the driver to use the new SCU IPC API. This allows us to get rid
of the duplicate PMC IPC implementation which is now covered in SCU IPC
driver.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/usb/typec/mux/Kconfig         |  2 +-
 drivers/usb/typec/mux/intel_pmc_mux.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index 77eb97b2aa86..a4dbd11f8ee2 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -11,7 +11,7 @@ config TYPEC_MUX_PI3USB30532
 
 config TYPEC_MUX_INTEL_PMC
 	tristate "Intel PMC mux control"
-	depends on INTEL_PMC_IPC
+	depends on INTEL_SCU_IPC
 	select USB_ROLE_SWITCH
 	help
 	  Driver for USB muxes controlled by Intel PMC FW. Intel PMC FW can
diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index f5c5e0aef66f..fce255e28a00 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -15,7 +15,7 @@
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_tbt.h>
 
-#include <asm/intel_pmc_ipc.h>
+#include <asm/intel_scu_ipc.h>
 
 #define PMC_USBC_CMD		0xa7
 
@@ -96,6 +96,7 @@ struct pmc_usb_port {
 struct pmc_usb {
 	u8 num_ports;
 	struct device *dev;
+	struct intel_scu_ipc_dev *ipc;
 	struct pmc_usb_port *port;
 };
 
@@ -107,9 +108,8 @@ static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
 	 * Error bit will always be 0 with the USBC command.
 	 * Status can be checked from the response message.
 	 */
-	intel_pmc_ipc_command(PMC_USBC_CMD, 0, msg, len,
-			      (void *)response, 1);
-
+	intel_scu_ipc_dev_command(port->pmc->ipc, PMC_USBC_CMD, 0, msg, len,
+				  response, sizeof(response));
 	if (response[2]) {
 		if (response[2] & BIT(1))
 			return -EIO;
@@ -370,6 +370,10 @@ static int pmc_usb_probe(struct platform_device *pdev)
 	if (!pmc->port)
 		return -ENOMEM;
 
+	pmc->ipc = devm_intel_scu_ipc_dev_get(&pdev->dev);
+	if (!pmc->ipc)
+		return -ENODEV;
+
 	pmc->dev = &pdev->dev;
 
 	/*
-- 
2.25.1

