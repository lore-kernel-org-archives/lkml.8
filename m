Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441ADC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F9E206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgCEWqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:46:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:5036 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgCEWpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674647"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:52 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 19/27] tools/power/x86/intel-speed-select: Kernel interface error handling
Date:   Thu,  5 Mar 2020 14:45:30 -0800
Message-Id: <20200305224538.490864-20-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Treat a case when mailbox/mmio command can't be handled by the kernel
drivers when the module is removed or send a command which no driver can
handle. In this case ENOTTY result is returned, so print error.

Also when the isst_if_mmio module is removed, we can't send CLOS message
messages via Mailbox on non SKX based platforms. When this module is
removed,  isst_platform_info.mmio_supported is set to 0. So it can't be
used as a condition to send via mailbox. Here replace check for Skylake
based platform to send via mailbox, other platforms can't use mailbox in
lieu of MMIO.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 48915470c572..2ab902c18bcc 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -95,6 +95,14 @@ int is_clx_n_platform(void)
 	return 0;
 }
 
+int is_skx_based_platform(void)
+{
+	if (cpu_model == 0x55)
+		return 1;
+
+	return 0;
+}
+
 static int update_cpu_model(void)
 {
 	unsigned int ebx, ecx, edx;
@@ -695,7 +703,11 @@ static int isst_send_mmio_command(unsigned int cpu, unsigned int reg, int write,
 	}
 
 	if (ioctl(fd, cmd, &io_regs) == -1) {
-		perror("ISST_IF_IO_CMD");
+		if (errno == ENOTTY) {
+			perror("ISST_IF_IO_COMMAND\n");
+			fprintf(stderr, "Check presence of kernel modules: isst_if_mmio\n");
+			exit(0);
+		}
 		fprintf(outf, "Error: mmio_cmd cpu:%d reg:%x read_write:%x\n",
 			cpu, reg, write);
 	} else {
@@ -724,7 +736,7 @@ int isst_send_mbox_command(unsigned int cpu, unsigned char command,
 		"mbox_send: cpu:%d command:%x sub_command:%x parameter:%x req_data:%x\n",
 		cpu, command, sub_command, parameter, req_data);
 
-	if (isst_platform_info.mmio_supported && command == CONFIG_CLOS &&
+	if (!is_skx_based_platform() && command == CONFIG_CLOS &&
 	    sub_command != CLOS_PM_QOS_CONFIG) {
 		unsigned int value;
 		int write = 0;
@@ -774,10 +786,14 @@ int isst_send_mbox_command(unsigned int cpu, unsigned char command,
 		err(-1, "%s open failed", pathname);
 
 	if (ioctl(fd, ISST_IF_MBOX_COMMAND, &mbox_cmds) == -1) {
-		perror("ISST_IF_MBOX_COMMAND");
-		fprintf(outf,
-			"Error: mbox_cmd cpu:%d command:%x sub_command:%x parameter:%x req_data:%x\n",
-			cpu, command, sub_command, parameter, req_data);
+		if (errno == ENOTTY) {
+			perror("ISST_IF_MBOX_COMMAND\n");
+			fprintf(stderr, "Check presence of kernel modules: isst_if_mbox_pci or isst_if_mbox_msr\n");
+			exit(0);
+		}
+		debug_printf(
+			"Error: mbox_cmd cpu:%d command:%x sub_command:%x parameter:%x req_data:%x errorno:%d\n",
+			cpu, command, sub_command, parameter, req_data, errno);
 		return -1;
 	} else {
 		*resp = mbox_cmds.mbox_cmd[0].resp_data;
-- 
2.24.1

