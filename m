Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2053AC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E3220787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441095AbgDPISR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:18:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:51567 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441252AbgDPIRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:17:04 -0400
IronPort-SDR: 1pm9C2PAsrye+tldQlfx8T45hfj0JPnEH9i8jnDE0DQLGYdnYBPUTb3Tc8tarE9qG1dWXjCfCK
 EtFwL1AO4teg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:16:06 -0700
IronPort-SDR: nOi04+Ugix0xWM0yeylSVBNzMkSMIQ43p0f/oJg0Jt2sF2XFpCDVIBLglZN8JfF/PR2jZBro6D
 QWq+3PVo2oLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="454241136"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Apr 2020 01:16:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BD0B5EB1; Thu, 16 Apr 2020 11:15:53 +0300 (EEST)
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
Subject: [PATCH v9 15/20] platform/x86: intel_pmc_ipc: Drop intel_pmc_ipc_command()
Date:   Thu, 16 Apr 2020 11:15:47 +0300
Message-Id: <20200416081552.68083-16-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all callers have been converted over to the SCU IPC API we can
drop intel_pmc_ipc_command().

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel_pmc_ipc.h |  8 --------
 drivers/platform/x86/intel_pmc_ipc.c | 20 --------------------
 2 files changed, 28 deletions(-)

diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
index ddc964b9c78c..22848df5faaf 100644
--- a/arch/x86/include/asm/intel_pmc_ipc.h
+++ b/arch/x86/include/asm/intel_pmc_ipc.h
@@ -27,19 +27,11 @@
 
 #if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
 
-int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
-		u32 *out, u32 outlen);
 int intel_pmc_s0ix_counter_read(u64 *data);
 int intel_pmc_gcr_read64(u32 offset, u64 *data);
 
 #else
 
-static inline int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
-		u32 *out, u32 outlen)
-{
-	return -EINVAL;
-}
-
 static inline int intel_pmc_s0ix_counter_read(u64 *data)
 {
 	return -EINVAL;
diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 0558eadc2a14..e4110df24490 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -194,26 +194,6 @@ static int update_no_reboot_bit(void *priv, bool set)
 				    PMC_CFG_NO_REBOOT_MASK, value);
 }
 
-/**
- * intel_pmc_ipc_command() -  IPC command with input/output data
- * @cmd:	IPC command code.
- * @sub:	IPC command sub type.
- * @in:		input data of this IPC command.
- * @inlen:	input data length in bytes.
- * @out:	output data of this IPC command.
- * @outlen:	output data length in dwords.
- *
- * Send an IPC command to PMC with input/output data.
- *
- * Return:	an IPC error code or 0 on success.
- */
-int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
-			  u32 *out, u32 outlen)
-{
-	return intel_scu_ipc_dev_command(NULL, cmd, sub, in, inlen, out, outlen);
-}
-EXPORT_SYMBOL_GPL(intel_pmc_ipc_command);
-
 static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct intel_pmc_ipc_dev *pmc = &ipcdev;
-- 
2.25.1

