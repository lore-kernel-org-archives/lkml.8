Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7AFC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9C2206F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441341AbgDPIUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:20:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:39055 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441243AbgDPIQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:16:50 -0400
IronPort-SDR: lisuba7/PlP4OZgvJpv95RmHDI3brsOza3v36bqGTN9xfxRYbULdx1F/Y+v61uJ743G0ykCOc5
 2lDPM7deCwTA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:16:04 -0700
IronPort-SDR: pNIhhX+2kXofHD0cQd+qDD60kK5aUa2cxkh04M5MmZV4fa0hPUh9tkk3A6ghgzIKyW52lk66dR
 1GLJKbfG3SVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="288816865"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 16 Apr 2020 01:15:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A7283EED; Thu, 16 Apr 2020 11:15:53 +0300 (EEST)
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
Subject: [PATCH v9 13/20] platform/x86: intel_telemetry: Convert to use new SCU IPC API
Date:   Thu, 16 Apr 2020 11:15:45 +0300
Message-Id: <20200416081552.68083-14-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Intel Apollo Lake telemetry driver to use the new SCU IPC
API. This allows us to get rid of the duplicate PMC IPC implementation
which is now covered in SCU IPC driver.

Also move telemetry specific IPC message constant to the telemetry
driver where it belongs.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel_pmc_ipc.h          |  1 -
 arch/x86/include/asm/intel_telemetry.h        |  3 +
 drivers/platform/x86/intel_telemetry_pltdrv.c | 95 +++++++++----------
 3 files changed, 49 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
index b438a488f613..ddc964b9c78c 100644
--- a/arch/x86/include/asm/intel_pmc_ipc.h
+++ b/arch/x86/include/asm/intel_pmc_ipc.h
@@ -8,7 +8,6 @@
 #define PMC_IPC_PHY_CONFIG		0xEE
 #define PMC_IPC_NORTHPEAK_CTRL		0xED
 #define PMC_IPC_PM_DEBUG		0xEC
-#define PMC_IPC_PMC_TELEMTRY		0xEB
 #define PMC_IPC_PMC_FW_MSG_CTRL		0xEA
 
 /* IPC return code */
diff --git a/arch/x86/include/asm/intel_telemetry.h b/arch/x86/include/asm/intel_telemetry.h
index 2f77e31a1283..274aaf0dae48 100644
--- a/arch/x86/include/asm/intel_telemetry.h
+++ b/arch/x86/include/asm/intel_telemetry.h
@@ -10,6 +10,8 @@
 #define TELEM_MAX_EVENTS_SRAM		28
 #define TELEM_MAX_OS_ALLOCATED_EVENTS	20
 
+#include <asm/intel_scu_ipc.h>
+
 enum telemetry_unit {
 	TELEM_PSS = 0,
 	TELEM_IOSS,
@@ -51,6 +53,7 @@ struct telemetry_plt_config {
 	struct telemetry_unit_config ioss_config;
 	struct mutex telem_trace_lock;
 	struct mutex telem_lock;
+	struct intel_scu_ipc_dev *scu;
 	bool telem_in_use;
 };
 
diff --git a/drivers/platform/x86/intel_telemetry_pltdrv.c b/drivers/platform/x86/intel_telemetry_pltdrv.c
index 987a24e3344e..e45303f99303 100644
--- a/drivers/platform/x86/intel_telemetry_pltdrv.c
+++ b/drivers/platform/x86/intel_telemetry_pltdrv.c
@@ -15,7 +15,6 @@
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
-#include <asm/intel_pmc_ipc.h>
 #include <asm/intel_punit_ipc.h>
 #include <asm/intel_telemetry.h>
 
@@ -35,6 +34,7 @@
 #define TELEM_SSRAM_STARTTIME_OFFSET	8
 #define TELEM_SSRAM_EVTLOG_OFFSET	16
 
+#define IOSS_TELEM			0xeb
 #define IOSS_TELEM_EVENT_READ		0x0
 #define IOSS_TELEM_EVENT_WRITE		0x1
 #define IOSS_TELEM_INFO_READ		0x2
@@ -42,9 +42,6 @@
 #define IOSS_TELEM_TRACE_CTL_WRITE	0x6
 #define IOSS_TELEM_EVENT_CTL_READ	0x7
 #define IOSS_TELEM_EVENT_CTL_WRITE	0x8
-#define IOSS_TELEM_EVT_CTRL_WRITE_SIZE	0x4
-#define IOSS_TELEM_READ_WORD		0x1
-#define IOSS_TELEM_WRITE_FOURBYTES	0x4
 #define IOSS_TELEM_EVT_WRITE_SIZE	0x3
 
 #define TELEM_INFO_SRAMEVTS_MASK	0xFF00
@@ -250,17 +247,14 @@ static int telemetry_check_evtid(enum telemetry_unit telem_unit,
 static inline int telemetry_plt_config_ioss_event(u32 evt_id, int index)
 {
 	u32 write_buf;
-	int ret;
 
 	write_buf = evt_id | TELEM_EVENT_ENABLE;
 	write_buf <<= BITS_PER_BYTE;
 	write_buf |= index;
 
-	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-				    IOSS_TELEM_EVENT_WRITE, (u8 *)&write_buf,
-				    IOSS_TELEM_EVT_WRITE_SIZE, NULL, 0);
-
-	return ret;
+	return intel_scu_ipc_dev_command(telm_conf->scu, IOSS_TELEM,
+					 IOSS_TELEM_EVENT_WRITE, &write_buf,
+					 IOSS_TELEM_EVT_WRITE_SIZE, NULL, 0);
 }
 
 static inline int telemetry_plt_config_pss_event(u32 evt_id, int index)
@@ -278,6 +272,7 @@ static inline int telemetry_plt_config_pss_event(u32 evt_id, int index)
 static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
 					 enum telemetry_action action)
 {
+	struct intel_scu_ipc_dev *scu = telm_conf->scu;
 	u8 num_ioss_evts, ioss_period;
 	int ret, index, idx;
 	u32 *ioss_evtmap;
@@ -288,9 +283,9 @@ static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
 	ioss_evtmap = evtconfig.evtmap;
 
 	/* Get telemetry EVENT CTL */
-	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
+	ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
 				    IOSS_TELEM_EVENT_CTL_READ, NULL, 0,
-				    &telem_ctrl, IOSS_TELEM_READ_WORD);
+				    &telem_ctrl, sizeof(telem_ctrl));
 	if (ret) {
 		pr_err("IOSS TELEM_CTRL Read Failed\n");
 		return ret;
@@ -299,11 +294,9 @@ static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
 	/* Disable Telemetry */
 	TELEM_DISABLE(telem_ctrl);
 
-	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-				    IOSS_TELEM_EVENT_CTL_WRITE,
-				    (u8 *)&telem_ctrl,
-				    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
-				    NULL, 0);
+	ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
+				    IOSS_TELEM_EVENT_CTL_WRITE, &telem_ctrl,
+				    sizeof(telem_ctrl), NULL, 0);
 	if (ret) {
 		pr_err("IOSS TELEM_CTRL Event Disable Write Failed\n");
 		return ret;
@@ -315,10 +308,9 @@ static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
 		/* Clear All Events */
 		TELEM_CLEAR_EVENTS(telem_ctrl);
 
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
+		ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
 					    IOSS_TELEM_EVENT_CTL_WRITE,
-					    (u8 *)&telem_ctrl,
-					    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
+					    &telem_ctrl, sizeof(telem_ctrl),
 					    NULL, 0);
 		if (ret) {
 			pr_err("IOSS TELEM_CTRL Event Disable Write Failed\n");
@@ -344,10 +336,9 @@ static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
 		/* Clear All Events */
 		TELEM_CLEAR_EVENTS(telem_ctrl);
 
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
+		ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
 					    IOSS_TELEM_EVENT_CTL_WRITE,
-					    (u8 *)&telem_ctrl,
-					    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
+					    &telem_ctrl, sizeof(telem_ctrl),
 					    NULL, 0);
 		if (ret) {
 			pr_err("IOSS TELEM_CTRL Event Disable Write Failed\n");
@@ -396,10 +387,9 @@ static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
 	TELEM_ENABLE_PERIODIC(telem_ctrl);
 	telem_ctrl |= ioss_period;
 
-	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
+	ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
 				    IOSS_TELEM_EVENT_CTL_WRITE,
-				    (u8 *)&telem_ctrl,
-				    IOSS_TELEM_EVT_CTRL_WRITE_SIZE, NULL, 0);
+				    &telem_ctrl, sizeof(telem_ctrl), NULL, 0);
 	if (ret) {
 		pr_err("IOSS TELEM_CTRL Event Enable Write Failed\n");
 		return ret;
@@ -586,8 +576,9 @@ static int telemetry_setup(struct platform_device *pdev)
 	u32 read_buf, events, event_regs;
 	int ret;
 
-	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY, IOSS_TELEM_INFO_READ,
-				    NULL, 0, &read_buf, IOSS_TELEM_READ_WORD);
+	ret = intel_scu_ipc_dev_command(telm_conf->scu, IOSS_TELEM,
+					IOSS_TELEM_INFO_READ, NULL, 0,
+					&read_buf, sizeof(read_buf));
 	if (ret) {
 		dev_err(&pdev->dev, "IOSS TELEM_INFO Read Failed\n");
 		return ret;
@@ -681,6 +672,8 @@ static int telemetry_plt_set_sampling_period(u8 pss_period, u8 ioss_period)
 
 	mutex_lock(&(telm_conf->telem_lock));
 	if (ioss_period) {
+		struct intel_scu_ipc_dev *scu = telm_conf->scu;
+
 		if (TELEM_SAMPLE_PERIOD_INVALID(ioss_period)) {
 			pr_err("IOSS Sampling Period Out of Range\n");
 			ret = -EINVAL;
@@ -688,9 +681,9 @@ static int telemetry_plt_set_sampling_period(u8 pss_period, u8 ioss_period)
 		}
 
 		/* Get telemetry EVENT CTL */
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
+		ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
 					    IOSS_TELEM_EVENT_CTL_READ, NULL, 0,
-					    &telem_ctrl, IOSS_TELEM_READ_WORD);
+					    &telem_ctrl, sizeof(telem_ctrl));
 		if (ret) {
 			pr_err("IOSS TELEM_CTRL Read Failed\n");
 			goto out;
@@ -699,11 +692,10 @@ static int telemetry_plt_set_sampling_period(u8 pss_period, u8 ioss_period)
 		/* Disable Telemetry */
 		TELEM_DISABLE(telem_ctrl);
 
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-					    IOSS_TELEM_EVENT_CTL_WRITE,
-					    (u8 *)&telem_ctrl,
-					    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
-					    NULL, 0);
+		ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
+						IOSS_TELEM_EVENT_CTL_WRITE,
+						&telem_ctrl, sizeof(telem_ctrl),
+						NULL, 0);
 		if (ret) {
 			pr_err("IOSS TELEM_CTRL Event Disable Write Failed\n");
 			goto out;
@@ -715,11 +707,10 @@ static int telemetry_plt_set_sampling_period(u8 pss_period, u8 ioss_period)
 		TELEM_ENABLE_PERIODIC(telem_ctrl);
 		telem_ctrl |= ioss_period;
 
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-					    IOSS_TELEM_EVENT_CTL_WRITE,
-					    (u8 *)&telem_ctrl,
-					    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
-					    NULL, 0);
+		ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
+						IOSS_TELEM_EVENT_CTL_WRITE,
+						&telem_ctrl, sizeof(telem_ctrl),
+						NULL, 0);
 		if (ret) {
 			pr_err("IOSS TELEM_CTRL Event Enable Write Failed\n");
 			goto out;
@@ -1014,9 +1005,9 @@ static int telemetry_plt_get_trace_verbosity(enum telemetry_unit telem_unit,
 		break;
 
 	case TELEM_IOSS:
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-				IOSS_TELEM_TRACE_CTL_READ, NULL, 0, &temp,
-				IOSS_TELEM_READ_WORD);
+		ret = intel_scu_ipc_dev_command(telm_conf->scu,
+				IOSS_TELEM, IOSS_TELEM_TRACE_CTL_READ,
+				NULL, 0, &temp, sizeof(temp));
 		if (ret) {
 			pr_err("IOSS TRACE_CTL Read Failed\n");
 			goto out;
@@ -1068,9 +1059,9 @@ static int telemetry_plt_set_trace_verbosity(enum telemetry_unit telem_unit,
 		break;
 
 	case TELEM_IOSS:
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-				IOSS_TELEM_TRACE_CTL_READ, NULL, 0, &temp,
-				IOSS_TELEM_READ_WORD);
+		ret = intel_scu_ipc_dev_command(telm_conf->scu, IOSS_TELEM,
+						IOSS_TELEM_TRACE_CTL_READ,
+						NULL, 0, &temp, sizeof(temp));
 		if (ret) {
 			pr_err("IOSS TRACE_CTL Read Failed\n");
 			goto out;
@@ -1079,9 +1070,9 @@ static int telemetry_plt_set_trace_verbosity(enum telemetry_unit telem_unit,
 		TELEM_CLEAR_VERBOSITY_BITS(temp);
 		TELEM_SET_VERBOSITY_BITS(temp, verbosity);
 
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-				IOSS_TELEM_TRACE_CTL_WRITE, (u8 *)&temp,
-				IOSS_TELEM_WRITE_FOURBYTES, NULL, 0);
+		ret = intel_scu_ipc_dev_command(telm_conf->scu, IOSS_TELEM,
+						IOSS_TELEM_TRACE_CTL_WRITE,
+						&temp, sizeof(temp), NULL, 0);
 		if (ret) {
 			pr_err("IOSS TRACE_CTL Verbosity Set Failed\n");
 			goto out;
@@ -1136,6 +1127,12 @@ static int telemetry_pltdrv_probe(struct platform_device *pdev)
 
 	telm_conf->ioss_config.regmap = mem;
 
+	telm_conf->scu = devm_intel_scu_ipc_dev_get(&pdev->dev);
+	if (!telm_conf->scu) {
+		ret = -EPROBE_DEFER;
+		goto out;
+	}
+
 	mutex_init(&telm_conf->telem_lock);
 	mutex_init(&telm_conf->telem_trace_lock);
 
-- 
2.25.1

