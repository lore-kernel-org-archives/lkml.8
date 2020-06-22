Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8EDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF27206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="CgUUM8Y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbgFVS6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:58:17 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:28556 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729605AbgFVS6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:58:14 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MIoSj5022733;
        Mon, 22 Jun 2020 14:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=smtpout1;
 bh=mbwotjRWtSOvl44DzN3YwKh0qNCAiAFYlom+lnO1gq0=;
 b=CgUUM8Y2v5/J0PHjCsSz5M9ZVtHbHv70h1U+6EPBSlXnxdXbQtMs1SjbRPXDNQAGAsp4
 tI1TA8y4WCxag0j/VeRHQzAspp/2mKDX0LG/e7TakbNcGcw/K+G/slYfEjBC06MII7WE
 6QK24qUL3f/tlfVQThYGWab33y3CwoV2vuK6KVaWk0JbN6BUxi5SVbkxjefOU0GIibdB
 Xvwb7xbNy3Q3L5MCfFKwfKYlbCluBhP5xUXOe/VrW+l9yV/f2Yr4cjpGwiVo07FLQOEv
 jv8z9jEYQhwKorQqlmlTQyMStwYztjS/cV98oE/Ny+7hrqb+8P7Ptk1+Jqnxvsqvneaa Og== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 31sd15nyud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 14:58:11 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MIspVs064442;
        Mon, 22 Jun 2020 14:58:10 -0400
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com [143.166.148.206])
        by mx0a-00154901.pphosted.com with ESMTP id 31tqd12cnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 14:58:10 -0400
X-LoopCount0: from 10.173.37.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1454816471"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v2 2/2] thunderbolt: Add support for authenticate on disconnect
Date:   Mon, 22 Jun 2020 13:57:58 -0500
Message-Id: <20200622185758.28145-3-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622185758.28145-1-mario.limonciello@dell.com>
References: <20200622185758.28145-1-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_11:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220126
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some external devices can support completing thunderbolt authentication
when they are unplugged. For this to work though, the link controller must
remain operational.

The only device known to support this right now is the Dell WD19TB, so add
a quirk for this.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 .../ABI/testing/sysfs-bus-thunderbolt         | 13 ++++++
 drivers/thunderbolt/Makefile                  |  2 +-
 drivers/thunderbolt/eeprom.c                  |  1 +
 drivers/thunderbolt/lc.c                      | 14 +++++++
 drivers/thunderbolt/quirks.c                  | 36 +++++++++++++++++
 drivers/thunderbolt/switch.c                  | 40 +++++++++++++++++--
 drivers/thunderbolt/tb.h                      |  7 ++++
 drivers/thunderbolt/tb_regs.h                 |  1 +
 8 files changed, 109 insertions(+), 5 deletions(-)
 create mode 100644 drivers/thunderbolt/quirks.c

diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
index 7d0500b4d58a..dd565c378b40 100644
--- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
+++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
@@ -276,3 +276,16 @@ Date:		Oct 2020
 KernelVersion:	v5.9
 Contact:	Mika Westerberg <mika.westerberg@linux.intel.com>
 Description:	Retimer vendor identifier read from the hardware.
+
+What:		/sys/bus/thunderbolt/devices/.../nvm_authenticate_on_disconnect
+Date:		Oct 2020
+KernelVersion:	v5.9
+Contact:	Mario Limonciello <mario.limonciello@dell.com>
+Description:	For supported devices, automatically authenticate the new Thunderbolt
+		image when the device is disconnected from the host system.
+
+		This file will accept writing values "1" or "2"
+		- Writing "1" will flush the image to the storage
+		area and prepare the device for authentication on disconnect.
+		- Writing "2" will run some basic validation on the image
+		and flush it to the storage area.
diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
index cf7e1b42f4ad..4ab5bfad7bfd 100644
--- a/drivers/thunderbolt/Makefile
+++ b/drivers/thunderbolt/Makefile
@@ -2,6 +2,6 @@
 obj-${CONFIG_USB4} := thunderbolt.o
 thunderbolt-objs := nhi.o nhi_ops.o ctl.o tb.o switch.o cap.o path.o tunnel.o eeprom.o
 thunderbolt-objs += domain.o dma_port.o icm.o property.o xdomain.o lc.o tmu.o usb4.o
-thunderbolt-objs += nvm.o retimer.o
+thunderbolt-objs += nvm.o retimer.o quirks.o
 
 obj-${CONFIG_USB4_KUNIT_TEST} += test.o
diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index b451a5aa90b5..3ebca44ab3fa 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -599,6 +599,7 @@ int tb_drom_read(struct tb_switch *sw)
 		sw->uid = header->uid;
 	sw->vendor = header->vendor_id;
 	sw->device = header->model_id;
+	tb_check_quirks(sw);
 
 	crc = tb_crc32(sw->drom + TB_DROM_DATA_START, header->data_len);
 	if (crc != header->data_crc32) {
diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
index bd44d50246d2..828b4655d6a1 100644
--- a/drivers/thunderbolt/lc.c
+++ b/drivers/thunderbolt/lc.c
@@ -366,3 +366,17 @@ int tb_lc_dp_sink_dealloc(struct tb_switch *sw, struct tb_port *in)
 	tb_port_dbg(in, "sink %d de-allocated\n", sink);
 	return 0;
 }
+
+/**
+ * tb_lc_force_power() - Forces LC to be powered on
+ * @sw: thunderbolt switch
+ *
+ * This is useful to let authentication cycle pass even without
+ * a Thunderbolt link present.
+ */
+int tb_lc_force_power(struct tb_switch *sw)
+{
+	u32 in = 0xffff;
+
+	return tb_sw_write(sw, &in, TB_CFG_SWITCH, TB_LC_POWER, 1);
+}
diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
new file mode 100644
index 000000000000..e8eace99bfcb
--- /dev/null
+++ b/drivers/thunderbolt/quirks.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Thunderbolt driver - quirks
+ *
+ * Copyright (c) 2020 Mario Limonciello <mario.limonciello@dell.com>
+ */
+
+#include "tb.h"
+
+static void quirk_force_power_link(struct tb_switch *sw)
+{
+	sw->quirks |= QUIRK_FORCE_POWER_LINK_CONTROLLER;
+}
+
+struct tb_quirk {
+	u16 vendor;
+	u16 device;
+	void (*hook)(struct tb_switch *sw);
+};
+
+static struct tb_quirk tb_quirks[] = {
+	/* Dell WD19TB supports self-authentication on unplug */
+	{ 0x00d4, 0xb070, quirk_force_power_link },
+};
+
+void tb_check_quirks(struct tb_switch *sw)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tb_quirks); i++) {
+		const struct tb_quirk *q = &tb_quirks[i];
+
+		if (sw->device == q->device && sw->vendor == q->vendor)
+			q->hook(sw);
+	}
+}
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index bbfbfebeee7f..712395f518b8 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1493,8 +1493,8 @@ static ssize_t nvm_authenticate_show(struct device *dev,
 	return sprintf(buf, "%#x\n", status);
 }
 
-static ssize_t nvm_authenticate_store(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t nvm_authenticate_sysfs(struct device *dev, const char *buf,
+				      bool disconnect)
 {
 	struct tb_switch *sw = tb_to_switch(dev);
 	int val;
@@ -1532,8 +1532,12 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 				goto exit_unlock;
 		}
 		if (val == WRITE_AND_AUTHENTICATE) {
-			sw->nvm->authenticating = true;
-			ret = nvm_authenticate(sw);
+			if (disconnect) {
+				ret = tb_lc_force_power(sw);
+			} else {
+				sw->nvm->authenticating = true;
+				ret = nvm_authenticate(sw);
+			}
 		}
 	}
 
@@ -1543,12 +1547,35 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 	pm_runtime_mark_last_busy(&sw->dev);
 	pm_runtime_put_autosuspend(&sw->dev);
 
+	return ret;
+}
+
+static ssize_t nvm_authenticate_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	int ret = nvm_authenticate_sysfs(dev, buf, false);
 	if (ret)
 		return ret;
 	return count;
 }
 static DEVICE_ATTR_RW(nvm_authenticate);
 
+static ssize_t nvm_authenticate_on_disconnect_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return nvm_authenticate_show(dev, attr, buf);
+}
+
+static ssize_t nvm_authenticate_on_disconnect_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	int ret;
+
+	ret = nvm_authenticate_sysfs(dev, buf, true);
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_RW(nvm_authenticate_on_disconnect);
+
 static ssize_t nvm_version_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -1606,6 +1633,7 @@ static struct attribute *switch_attrs[] = {
 	&dev_attr_generation.attr,
 	&dev_attr_key.attr,
 	&dev_attr_nvm_authenticate.attr,
+	&dev_attr_nvm_authenticate_on_disconnect.attr,
 	&dev_attr_nvm_version.attr,
 	&dev_attr_rx_speed.attr,
 	&dev_attr_rx_lanes.attr,
@@ -1660,6 +1688,10 @@ static umode_t switch_attr_is_visible(struct kobject *kobj,
 		if (tb_route(sw))
 			return attr->mode;
 		return 0;
+	} else if (attr == &dev_attr_nvm_authenticate_on_disconnect.attr) {
+		if (sw->quirks & QUIRK_FORCE_POWER_LINK_CONTROLLER)
+			return attr->mode;
+		return 0;
 	}
 
 	return sw->safe_mode ? 0 : attr->mode;
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 43a8ca2eb3d8..07e1cfc3a096 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -133,6 +133,7 @@ struct tb_switch_tmu {
  * @depth: Depth in the chain this switch is connected (ICM only)
  * @rpm_complete: Completion used to wait for runtime resume to
  *		  complete (ICM only)
+ * @quirks: Quirks used for this Thunderbolt switch
  *
  * When the switch is being added or removed to the domain (other
  * switches) you need to have domain lock held.
@@ -171,6 +172,7 @@ struct tb_switch {
 	u8 link;
 	u8 depth;
 	struct completion rpm_complete;
+	unsigned long quirks;
 };
 
 /**
@@ -849,6 +851,7 @@ bool tb_lc_lane_bonding_possible(struct tb_switch *sw);
 bool tb_lc_dp_sink_query(struct tb_switch *sw, struct tb_port *in);
 int tb_lc_dp_sink_alloc(struct tb_switch *sw, struct tb_port *in);
 int tb_lc_dp_sink_dealloc(struct tb_switch *sw, struct tb_port *in);
+int tb_lc_force_power(struct tb_switch *sw);
 
 static inline int tb_route_length(u64 route)
 {
@@ -941,4 +944,8 @@ int usb4_usb3_port_allocate_bandwidth(struct tb_port *port, int *upstream_bw,
 				      int *downstream_bw);
 int usb4_usb3_port_release_bandwidth(struct tb_port *port, int *upstream_bw,
 				     int *downstream_bw);
+
+/* keep link controller awake during update */
+#define QUIRK_FORCE_POWER_LINK_CONTROLLER       (1<<1)
+void tb_check_quirks(struct tb_switch *sw);
 #endif
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 2ac6af8e0c13..fd4fc144d17f 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -409,6 +409,7 @@ struct tb_regs_hop {
 #define TB_LC_SNK_ALLOCATION_SNK1_SHIFT	4
 #define TB_LC_SNK_ALLOCATION_SNK1_MASK	GENMASK(7, 4)
 #define TB_LC_SNK_ALLOCATION_SNK1_CM	0x1
+#define TB_LC_POWER			0x740
 
 /* Link controller registers */
 #define TB_LC_PORT_ATTR			0x8d
-- 
2.25.1

