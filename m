Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA2EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B45207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733169AbgFPP4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:56:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:36618 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733164AbgFPP4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:56:32 -0400
IronPort-SDR: Swfuvu0CwdhyXwW3L+Ptum7HCy5GezzeO+vZRcy3lAc/aTr9mXA5IwBXeETwBejQ8JGHoTht9o
 ksWOORR8Wulw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 08:56:32 -0700
IronPort-SDR: FvxslkR+QjmwBIjRagfdSr8+gm/P/RidpUuKLVrDNrMJy4D6Lufrzac7Y/i1FispkIt/j0dwN3
 rR8rAQGxXLGg==
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="449888107"
Received: from pperycz-mobl.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.213.235.69])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 08:56:28 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Paul Murphy <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/7] mailbox: keembay-scmi-mailbox: Add support for Keem Bay mailbox
Date:   Tue, 16 Jun 2020 16:56:08 +0100
Message-Id: <20200616155613.121242-3-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
References: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Murphy <paul.j.murphy@intel.com>

Keem Bay SoC has a ARM trusted firmware-based secure monitor which acts
as the SCP for the purposes of power management over SCMI.

This driver implements the transport layer for SCMI to function.

Doclink: http://infocenter.arm.com/help/topic/com.arm.doc.den0056b/DEN0056B_System_Control_and_Management_Interface_v2_0.pdf

Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Paul Murphy <paul.j.murphy@intel.com>
---
 MAINTAINERS                            |   6 +
 drivers/mailbox/Kconfig                |   9 ++
 drivers/mailbox/Makefile               |   2 +
 drivers/mailbox/keembay-scmi-mailbox.c | 203 +++++++++++++++++++++++++
 4 files changed, 220 insertions(+)
 create mode 100644 drivers/mailbox/keembay-scmi-mailbox.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ddad1d70f5f..4887e004cd26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9330,6 +9330,12 @@ F:	include/linux/crash_dump.h
 F:	include/uapi/linux/vmcore.h
 F:	kernel/crash_*.c
 
+KEEMBAY SCMI MAILBOX DRIVER
+M:	Paul Murphy <paul.j.murphy@intel.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mailbox/intel,keembay-scmi-mailbox.yaml
+F:	drivers/mailbox/keembay-scmi-mailbox.c
+
 KEENE FM RADIO TRANSMITTER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05b1009e2820..064d4c4794a2 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -16,6 +16,15 @@ config ARM_MHU
 	  The controller has 3 mailbox channels, the last of which can be
 	  used in Secure mode only.
 
+config KEEMBAY_SCMI_MBOX
+	tristate "Keem Bay SoC SCMI Mailbox"
+	depends on HAVE_ARM_SMCCC
+	help
+	  An implementation of a mailbox implemented using 'smc' calls to the
+	  ARM secure world monitor. This enables communication with an 'SCP'
+	  running in the secure world on Keem Bay SoCs.
+	  Say Y here if you want to build the Keem Bay SoC SCMI Mailbox.
+
 config IMX_MBOX
 	tristate "i.MX Mailbox"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 60d224b723a1..7aba6edc8d44 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -54,3 +54,5 @@ obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
 obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
 
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
+
+obj-$(CONFIG_KEEMBAY_SCMI_MBOX)	+= keembay-scmi-mailbox.o
diff --git a/drivers/mailbox/keembay-scmi-mailbox.c b/drivers/mailbox/keembay-scmi-mailbox.c
new file mode 100644
index 000000000000..6f13b21f4f80
--- /dev/null
+++ b/drivers/mailbox/keembay-scmi-mailbox.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Keem Bay SCMI mailbox driver.
+ *
+ * Copyright (c) 2019-2020 Intel Corporation.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+/* Function id of SiP service */
+#define KMB_SIP_SVC_SCMI 0xFF19
+
+/*
+ * Number of channels this mailbox supports: 1 channel,
+ * between AP and SCP.
+ */
+#define NUM_CHANNELS 1
+
+/* How long to wait before triggering the mailbox receive event */
+#define NOTIFY_WAIT_TIME_NS 50
+
+/**
+ * struct keembay_scmi_mbox
+ * @mbox:	Mailbox controller struct
+ * @dev:	Platform device
+ * @shmem_res:	Resource describing memory region shared between secure and
+ *		non-secure world
+ * @notify_hrt:	Timer to asynchronously trigger a mbox received data event
+ */
+struct keembay_scmi_mbox {
+	struct mbox_controller mbox;
+	struct device *dev;
+	struct resource shmem_res;
+	struct hrtimer notify_hrt;
+};
+
+static int keembay_scmi_request(u32 base_address)
+{
+	struct arm_smccc_res res;
+	u64 function_id;
+	u16 function_number = KMB_SIP_SVC_SCMI;
+
+	function_id = ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32,
+					 ARM_SMCCC_OWNER_SIP, function_number);
+
+	arm_smccc_smc(function_id, base_address, 0, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static enum hrtimer_restart keembay_scmi_async_notify(struct hrtimer *hrtimer)
+{
+	struct keembay_scmi_mbox *mbox =
+		container_of(hrtimer, struct keembay_scmi_mbox, notify_hrt);
+	struct mbox_chan *chan = &mbox->mbox.chans[0];
+
+	mbox_chan_received_data(chan, NULL);
+
+	return HRTIMER_NORESTART;
+}
+
+static int keembay_scmi_mailbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct keembay_scmi_mbox *mbox = chan->con_priv;
+	struct device *dev = mbox->dev;
+	int rc;
+
+	/*
+	 * Handle case where timer is still on and a new message arrives.
+	 * We only have one timer, if it were to happen that a second
+	 * request came in and we failed to respond as expected to the
+	 * first, the caller's state machine may end up in an unexpected
+	 * state.
+	 */
+	if (hrtimer_active(&mbox->notify_hrt)) {
+		dev_warn(dev, "Mailbox was busy when request arrived.\n");
+		return -EBUSY;
+	}
+
+	rc = keembay_scmi_request((u32)mbox->shmem_res.start);
+	if (rc < 0) {
+		dev_warn(dev, "Failed to send message to SCP: %d\n", rc);
+		return rc;
+	}
+
+	/*
+	 * If there is an asynchronous interrupt pending, trigger it
+	 * via timer. We will know that, because secure world will
+	 * respond with > 0 return value.
+	 */
+	if (rc) {
+		hrtimer_start(&mbox->notify_hrt,
+			      ns_to_ktime(NOTIFY_WAIT_TIME_NS),
+			      HRTIMER_MODE_REL);
+	}
+
+	return 0;
+}
+
+static bool keembay_scmi_mailbox_last_tx_done(struct mbox_chan *chan)
+{
+	return true;
+}
+
+static int keembay_scmi_mailbox_startup(struct mbox_chan *chan)
+{
+	struct keembay_scmi_mbox *mbox = chan->con_priv;
+
+	hrtimer_init(&mbox->notify_hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	mbox->notify_hrt.function = keembay_scmi_async_notify;
+
+	return 0;
+}
+
+static const struct mbox_chan_ops scmi_mbox_ops = {
+	.startup = keembay_scmi_mailbox_startup,
+	.send_data = keembay_scmi_mailbox_send_data,
+	.last_tx_done = keembay_scmi_mailbox_last_tx_done,
+};
+
+static int keembay_scmi_get_shmem_res(struct device *dev, struct resource *res)
+{
+	struct device_node *node;
+	int rc;
+
+	node = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (!node) {
+		dev_err(dev, "Couldn't find region.\n");
+		return -EINVAL;
+	}
+
+	rc = of_address_to_resource(node, 0, res);
+	of_node_put(node);
+	if (rc)
+		dev_err(dev, "Couldn't resolve region.\n");
+
+	return rc;
+}
+
+static int keembay_scmi_mailbox_probe(struct platform_device *pdev)
+{
+	struct keembay_scmi_mbox *scmi_mbox;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	scmi_mbox = devm_kzalloc(dev, sizeof(*scmi_mbox), GFP_KERNEL);
+	if (!scmi_mbox)
+		return -ENOMEM;
+
+	ret = keembay_scmi_get_shmem_res(dev, &scmi_mbox->shmem_res);
+	if (ret) {
+		dev_err(dev, "Failed to get SCMI shared region resource.\n");
+		return ret;
+	}
+
+	scmi_mbox->mbox.dev = dev;
+	scmi_mbox->mbox.txdone_poll = true;
+	scmi_mbox->mbox.txpoll_period = 5;
+	scmi_mbox->mbox.ops = &scmi_mbox_ops;
+	scmi_mbox->mbox.num_chans = NUM_CHANNELS;
+	scmi_mbox->mbox.chans = devm_kcalloc(dev, scmi_mbox->mbox.num_chans,
+					     sizeof(*scmi_mbox->mbox.chans),
+					     GFP_KERNEL);
+	if (!scmi_mbox->mbox.chans)
+		return -ENOMEM;
+	scmi_mbox->mbox.chans[0].con_priv = scmi_mbox;
+
+	ret = devm_mbox_controller_register(dev, &scmi_mbox->mbox);
+	if (ret)
+		return ret;
+
+	scmi_mbox->dev = dev;
+
+	platform_set_drvdata(pdev, scmi_mbox);
+
+	return 0;
+}
+
+static const struct of_device_id keembay_scmi_mailbox_of_match[] = {
+	{
+		.compatible = "intel,keembay-scmi-mailbox",
+	},
+	{}
+};
+
+static struct platform_driver keembay_scmi_mailbox_driver = {
+	.driver = {
+			.name = "keembay-scmi-mailbox",
+			.of_match_table = keembay_scmi_mailbox_of_match,
+		},
+	.probe = keembay_scmi_mailbox_probe,
+};
+module_platform_driver(keembay_scmi_mailbox_driver);
+
+MODULE_DESCRIPTION("Keem Bay SCMI mailbox driver");
+MODULE_AUTHOR("Paul Murphy <paul.j.murphy@intel.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.26.2

