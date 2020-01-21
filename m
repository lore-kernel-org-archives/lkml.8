Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4C9C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7C62465A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgAUQER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:04:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:18424 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729613AbgAUQEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:04:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 08:01:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="374630194"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 21 Jan 2020 08:01:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 13C2BF50; Tue, 21 Jan 2020 18:01:16 +0200 (EET)
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
Subject: [PATCH v4 30/38] platform/x86: intel_pmc_ipc: Drop intel_pmc_ipc_command()
Date:   Tue, 21 Jan 2020 19:01:06 +0300
Message-Id: <20200121160114.60007-31-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
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
index 4d9c9fd082ad..6970ca2eab77 100644
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
2.24.1

