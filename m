Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D93FC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E2520675
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgBKN0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:26:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:35201 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbgBKN0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:26:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 05:26:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="405937279"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 Feb 2020 05:26:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E6203262; Tue, 11 Feb 2020 15:26:03 +0200 (EET)
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
Subject: [PATCH v5 02/18] platform/x86: intel_scu_ipc: Log more information if SCU IPC command fails
Date:   Tue, 11 Feb 2020 16:25:47 +0300
Message-Id: <20200211132603.73509-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
References: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
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
---
 drivers/platform/x86/intel_scu_ipc.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 19c2cc41fb05..1fc52b63d984 100644
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
@@ -339,8 +337,12 @@ int intel_scu_ipc_simple_command(int cmd, int sub)
 		return -ENODEV;
 	}
 	scu = ipcdev;
-	ipc_command(scu, sub << 12 | cmd);
+	cmdval = sub << 12 | cmd;
+	ipc_command(scu, cmdval);
 	err = intel_scu_ipc_check_status(scu);
+	if (err)
+		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval,
+			err);
 	mutex_unlock(&ipclock);
 	return err;
 }
@@ -362,6 +364,7 @@ int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
 			  u32 *out, int outlen)
 {
 	struct intel_scu_ipc_dev *scu;
+	u32 cmdval;
 	int i, err;
 
 	mutex_lock(&ipclock);
@@ -374,10 +377,13 @@ int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
 	for (i = 0; i < inlen; i++)
 		ipc_data_writel(scu, *in++, 4 * i);
 
-	ipc_command(scu, (inlen << 16) | (sub << 12) | cmd);
+	cmdval = (inlen << 16) | (sub << 12) | cmd;
+	ipc_command(scu, cmdval);
 	err = intel_scu_ipc_check_status(scu);
-
-	if (!err) {
+	if (err) {
+		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval,
+			err);
+	} else {
 		for (i = 0; i < outlen; i++)
 			*out++ = ipc_data_readl(scu, 4 * i);
 	}
-- 
2.25.0

