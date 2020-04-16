Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C5CC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B8F206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441379AbgDPI1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:27:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:23576 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440881AbgDPIQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:16:38 -0400
IronPort-SDR: 8ANFgpdH5BTQ48ZE+Wmx5aXUguayGdOkZbbm/h37LhKo8IX9PSa8K3Dr5bAZEE3rDZtNx9eqqJ
 7H7AnKnJfPTA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:15:59 -0700
IronPort-SDR: HeqOZtHZHt7ASB2zzLpML2efNhEasCcduKN0SFYlvV0/icBHTkWqM4nOe3IFnSm0h/R7d+O8wm
 0r3tdD7h/xYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="244334020"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 16 Apr 2020 01:15:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 276D449F; Thu, 16 Apr 2020 11:15:53 +0300 (EEST)
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
Subject: [PATCH v9 02/20] platform/x86: intel_scu_ipc: Log more information if SCU IPC command fails
Date:   Thu, 16 Apr 2020 11:15:34 +0300
Message-Id: <20200416081552.68083-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we only log an error if the command times out which makes it
hard to figure out the failing command. This changes the driver to log
command and subcommand with the error code which should make debugging
easier. This also allows us to simplify the callers as they don't need
to log these errors themselves.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 584e33c37708..e8ea250aeda3 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -147,7 +147,6 @@ static inline int busy_loop(struct intel_scu_ipc_dev *scu)
 		usleep_range(50, 100);
 	} while (time_before(jiffies, end));
 
-	dev_err(&scu->dev, "IPC timed out");
 	return -ETIMEDOUT;
 }
 
@@ -156,10 +155,8 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
 {
 	int status;
 
-	if (!wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT)) {
-		dev_err(&scu->dev, "IPC timed out\n");
+	if (!wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT))
 		return -ETIMEDOUT;
-	}
 
 	status = ipc_read_status(scu);
 	if (status & IPC_STATUS_ERR)
@@ -331,6 +328,7 @@ EXPORT_SYMBOL(intel_scu_ipc_update_register);
 int intel_scu_ipc_simple_command(int cmd, int sub)
 {
 	struct intel_scu_ipc_dev *scu;
+	u32 cmdval;
 	int err;
 
 	mutex_lock(&ipclock);
@@ -339,9 +337,12 @@ int intel_scu_ipc_simple_command(int cmd, int sub)
 		return -ENODEV;
 	}
 	scu = ipcdev;
-	ipc_command(scu, sub << 12 | cmd);
+	cmdval = sub << 12 | cmd;
+	ipc_command(scu, cmdval);
 	err = intel_scu_ipc_check_status(scu);
 	mutex_unlock(&ipclock);
+	if (err)
+		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
 	return err;
 }
 EXPORT_SYMBOL(intel_scu_ipc_simple_command);
@@ -362,6 +363,7 @@ int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
 			  u32 *out, int outlen)
 {
 	struct intel_scu_ipc_dev *scu;
+	u32 cmdval;
 	int i, err;
 
 	mutex_lock(&ipclock);
@@ -374,7 +376,8 @@ int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
 	for (i = 0; i < inlen; i++)
 		ipc_data_writel(scu, *in++, 4 * i);
 
-	ipc_command(scu, (inlen << 16) | (sub << 12) | cmd);
+	cmdval = (inlen << 16) | (sub << 12) | cmd;
+	ipc_command(scu, cmdval);
 	err = intel_scu_ipc_check_status(scu);
 
 	if (!err) {
@@ -383,6 +386,8 @@ int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
 	}
 
 	mutex_unlock(&ipclock);
+	if (err)
+		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
 	return err;
 }
 EXPORT_SYMBOL(intel_scu_ipc_command);
-- 
2.25.1

