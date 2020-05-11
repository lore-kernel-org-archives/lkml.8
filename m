Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31D1C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D56120708
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgUZaG/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgEKLc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729683AbgEKLc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:32:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C914BC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:32:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so17676788wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=hx/NnDSo++3FZI9VGmHGnIt8ynAjxRFFML/MCoNWlZE=;
        b=TgUZaG/KN3pHdKVVeepKX9HRyDuzaZ9VZGa91IlmvbAixyi1rttGXJbb9KEChRyPlc
         plo00VZwE/3OjZDQnzSrnwueos7n0ppvi3+qB11GLR9fQ3zZbcWFFr04nnBAwdt4sIb7
         iHZsz1CO2WOgoVjf/9TxeTpS9tBKTKXxisYFj7C4+CTM45YhYi3BoaNNsMHQNGTXfnWe
         bL9bWr5nxUsHTKAf3SLpEquDnDl+cIf+/u868R4915QEqWmqqAMyc+Q5Ft4gkT3LIJ62
         Dy9FKjSKaLiYG2y4VckZZx3CQJ/b+Rj8wYAyua/1O3LXVPooVL1T0hz/eKZAJw81soE4
         /x7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=hx/NnDSo++3FZI9VGmHGnIt8ynAjxRFFML/MCoNWlZE=;
        b=DdtlvTh07USrA3zYx9eqgdJhdvevkHrEop/YgX+c4mBpqG002lJE5CNbZt8JMYewDK
         8epkL26IjfaA9SieAEnUc/10/BjlNysP7uzFGAR0CBwZhxG+ZSoYoiYeN6v+ntdyo3nz
         Eis6/NUQPr9QDi6aaDVTE8bfcISpQhX/4/I9G+aegymudHutyepDGT+z4BwK0FAbn/Qv
         1OuGjA/S8jd5XkL/D9oWTTtyG1N1BqKFLsWS8uhMHjNcZKg5rzC9tC8xpTy0vB1nskxf
         jKPd8U7zWA/BXcTJmahFzGzPLZZNAAnWGIeXNwavxmNtV7xTxQ6xQiogNJDRfANMfWOo
         f5HQ==
X-Gm-Message-State: AGi0PuajlS3x5WVIj5XtFZr2MWzlBasEGfhB3adpOKJLvqlv6hF27BfC
        af/qknk+rnGzzTtxpQT0P3QL3YDV
X-Google-Smtp-Source: APiQypJ/uTLDp5GdDUKA2DrybY4GMXcChltDShFcbvPzk2ZD3HGu5JAHad7J/F0M0SUN+a2GLP+meQ==
X-Received: by 2002:a1c:2b46:: with SMTP id r67mr32735507wmr.160.1589196774067;
        Mon, 11 May 2020 04:32:54 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u12sm27830595wmu.25.2020.05.11.04.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:32:53 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 08/11] habanalabs: add hwmgr module for gaudi
Date:   Mon, 11 May 2020 14:32:29 +0300
Message-Id: <20200511113232.5771-9-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511113232.5771-1-oded.gabbay@gmail.com>
References: <20200511113232.5771-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwmgr module is responsible for messages sent to GAUDI F/W that are
not common to all habanalabs ASICs.

In GAUDI, we provide the user a simplified mode of controlling the ASIC
clock frequency. Instead of three different clocks, we present a single
clock property that the user can configure via sysfs.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../ABI/testing/sysfs-driver-habanalabs       |  17 +++
 drivers/misc/habanalabs/gaudi/Makefile        |   2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         |   6 +-
 drivers/misc/habanalabs/gaudi/gaudiP.h        |   5 +
 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c   | 117 ++++++++++++++++++
 5 files changed, 143 insertions(+), 4 deletions(-)
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c

diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
index 782df74042ed..1a14bf9b22ba 100644
--- a/Documentation/ABI/testing/sysfs-driver-habanalabs
+++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
@@ -10,6 +10,23 @@ KernelVersion:  5.1
 Contact:        oded.gabbay@gmail.com
 Description:    Version of the application running on the device's CPU
 
+What:           /sys/class/habanalabs/hl<n>/clk_max_freq_mhz
+Date:           Jun 2019
+KernelVersion:  not yet upstreamed
+Contact:        oded.gabbay@gmail.com
+Description:    Allows the user to set the maximum clock frequency, in MHz.
+                The device clock might be set to lower value than the maximum.
+                The user should read the clk_cur_freq_mhz to see the actual
+                frequency value of the device clock. This property is valid
+                only for the Gaudi ASIC family
+
+What:           /sys/class/habanalabs/hl<n>/clk_cur_freq_mhz
+Date:           Jun 2019
+KernelVersion:  not yet upstreamed
+Contact:        oded.gabbay@gmail.com
+Description:    Displays the current frequency, in MHz, of the device clock.
+                This property is valid only for the Gaudi ASIC family
+
 What:           /sys/class/habanalabs/hl<n>/cpld_ver
 Date:           Jan 2019
 KernelVersion:  5.1
diff --git a/drivers/misc/habanalabs/gaudi/Makefile b/drivers/misc/habanalabs/gaudi/Makefile
index b30b523881a0..a7b5be449de3 100644
--- a/drivers/misc/habanalabs/gaudi/Makefile
+++ b/drivers/misc/habanalabs/gaudi/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 subdir-ccflags-y += -I$(src)
 
-HL_GAUDI_FILES := gaudi/gaudi.o
\ No newline at end of file
+HL_GAUDI_FILES := gaudi/gaudi.o gaudi/gaudi_hwmgr.o
\ No newline at end of file
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 4da01a12bdde..624c1f907e79 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7374,9 +7374,9 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.debugfs_write32 = gaudi_debugfs_write32,
 	.debugfs_read64 = gaudi_debugfs_read64,
 	.debugfs_write64 = gaudi_debugfs_write64,
-	.add_device_attr = NULL,
+	.add_device_attr = gaudi_add_device_attr,
 	.handle_eqe = gaudi_handle_eqe,
-	.set_pll_profile = NULL,
+	.set_pll_profile = gaudi_set_pll_profile,
 	.get_events_stat = gaudi_get_events_stat,
 	.read_pte = gaudi_read_pte,
 	.write_pte = gaudi_write_pte,
@@ -7400,7 +7400,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.rreg = hl_rreg,
 	.wreg = hl_wreg,
 	.halt_coresight = NULL,
-	.get_clk_rate = NULL,
+	.get_clk_rate = gaudi_get_clk_rate,
 	.get_queue_id_for_cq = gaudi_get_queue_id_for_cq,
 	.read_device_fw_version = gaudi_read_device_fw_version,
 	.load_firmware_to_device = gaudi_load_firmware_to_device,
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 4fe66b8e1968..f48f4647fbed 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -248,4 +248,9 @@ struct gaudi_device {
 	u8				ext_queue_idx;
 };
 
+void gaudi_add_device_attr(struct hl_device *hdev,
+			struct attribute_group *dev_attr_grp);
+void gaudi_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
+int gaudi_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
+
 #endif /* GAUDIP_H_ */
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c b/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c
new file mode 100644
index 000000000000..9fa7a50e5bac
--- /dev/null
+++ b/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "gaudiP.h"
+#include "include/gaudi/gaudi_fw_if.h"
+
+void gaudi_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq)
+{
+	struct gaudi_device *gaudi = hdev->asic_specific;
+
+	if (freq == PLL_LAST)
+		hl_set_frequency(hdev, MME_PLL, gaudi->max_freq_value);
+}
+
+int gaudi_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
+{
+	long value;
+
+	if (hl_device_disabled_or_in_reset(hdev))
+		return -ENODEV;
+
+	value = hl_get_frequency(hdev, MME_PLL, false);
+
+	if (value < 0) {
+		dev_err(hdev->dev, "Failed to retrieve device max clock %ld\n",
+			value);
+		return value;
+	}
+
+	*max_clk = (value / 1000 / 1000);
+
+	value = hl_get_frequency(hdev, MME_PLL, true);
+
+	if (value < 0) {
+		dev_err(hdev->dev,
+			"Failed to retrieve device current clock %ld\n",
+			value);
+		return value;
+	}
+
+	*cur_clk = (value / 1000 / 1000);
+
+	return 0;
+}
+
+static ssize_t clk_max_freq_mhz_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	long value;
+
+	if (hl_device_disabled_or_in_reset(hdev))
+		return -ENODEV;
+
+	value = hl_get_frequency(hdev, MME_PLL, false);
+
+	gaudi->max_freq_value = value;
+
+	return sprintf(buf, "%lu\n", (value / 1000 / 1000));
+}
+
+static ssize_t clk_max_freq_mhz_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	int rc;
+	u64 value;
+
+	if (hl_device_disabled_or_in_reset(hdev)) {
+		count = -ENODEV;
+		goto fail;
+	}
+
+	rc = kstrtoull(buf, 0, &value);
+
+	gaudi->max_freq_value = value * 1000 * 1000;
+
+	hl_set_frequency(hdev, MME_PLL, gaudi->max_freq_value);
+
+fail:
+	return count;
+}
+
+static ssize_t clk_cur_freq_mhz_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long value;
+
+	if (hl_device_disabled_or_in_reset(hdev))
+		return -ENODEV;
+
+	value = hl_get_frequency(hdev, MME_PLL, true);
+
+	return sprintf(buf, "%lu\n", (value / 1000 / 1000));
+}
+
+static DEVICE_ATTR_RW(clk_max_freq_mhz);
+static DEVICE_ATTR_RO(clk_cur_freq_mhz);
+
+static struct attribute *gaudi_dev_attrs[] = {
+	&dev_attr_clk_max_freq_mhz.attr,
+	&dev_attr_clk_cur_freq_mhz.attr,
+	NULL,
+};
+
+void gaudi_add_device_attr(struct hl_device *hdev,
+			struct attribute_group *dev_attr_grp)
+{
+	dev_attr_grp->attrs = gaudi_dev_attrs;
+}
-- 
2.17.1

