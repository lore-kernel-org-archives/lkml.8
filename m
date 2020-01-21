Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026AAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55E024654
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgAUQCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:02:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:46956 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729440AbgAUQBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:01:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 08:01:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="399707119"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 21 Jan 2020 08:01:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id F3DF6D49; Tue, 21 Jan 2020 18:01:15 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Brown <broonie@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 28/38] mfd: intel_soc_pmic_mrfld: Convert to use new SCU IPC API
Date:   Tue, 21 Jan 2020 19:01:04 +0300
Message-Id: <20200121160114.60007-29-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the Intel Merrifield PMIC driver over the new SCU IPC API
where the SCU IPC instance is passed to the functions.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_mrfld.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_mrfld.c b/drivers/mfd/intel_soc_pmic_mrfld.c
index 26a1551c5faf..bd94c989d232 100644
--- a/drivers/mfd/intel_soc_pmic_mrfld.c
+++ b/drivers/mfd/intel_soc_pmic_mrfld.c
@@ -74,10 +74,11 @@ static const struct mfd_cell bcove_dev[] = {
 static int bcove_ipc_byte_reg_read(void *context, unsigned int reg,
 				    unsigned int *val)
 {
+	struct intel_soc_pmic *pmic = context;
 	u8 ipc_out;
 	int ret;
 
-	ret = intel_scu_ipc_ioread8(reg, &ipc_out);
+	ret = intel_scu_ipc_dev_ioread8(pmic->scu, reg, &ipc_out);
 	if (ret)
 		return ret;
 
@@ -88,10 +89,11 @@ static int bcove_ipc_byte_reg_read(void *context, unsigned int reg,
 static int bcove_ipc_byte_reg_write(void *context, unsigned int reg,
 				     unsigned int val)
 {
+	struct intel_soc_pmic *pmic = context;
 	u8 ipc_in = val;
 	int ret;
 
-	ret = intel_scu_ipc_iowrite8(reg, ipc_in);
+	ret = intel_scu_ipc_dev_iowrite8(pmic->scu, reg, ipc_in);
 	if (ret)
 		return ret;
 
@@ -117,6 +119,10 @@ static int bcove_probe(struct platform_device *pdev)
 	if (!pmic)
 		return -ENOMEM;
 
+	pmic->scu = devm_intel_scu_ipc_dev_get(dev);
+	if (!pmic->scu)
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, pmic);
 	pmic->dev = &pdev->dev;
 
-- 
2.24.1

