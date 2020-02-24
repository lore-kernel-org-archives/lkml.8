Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCD0C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E7E20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgBXMO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:14:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:3635 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbgBXMO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:14:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 04:14:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="349909458"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2020 04:14:24 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 8/9] usb: typec: Add definitions for Thunderbolt 3 Alternate Mode
Date:   Mon, 24 Feb 2020 15:14:05 +0300
Message-Id: <20200224121406.2419-9-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224121406.2419-1-heikki.krogerus@linux.intel.com>
References: <20200224121406.2419-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds separate header file for the Thunderbolt 3
Alternate Mode (aka. TBT). The header supplies definitions for
all the Thunderbolt specific VDOs (Vendor Defined Objects)
that are described in the USB Type-C Connector specification
v2.0, as well as definition for the Thunderbolt 3 Standard
ID (SID).

There is also a new connector state value for the
Thunderbolt 3 Alternate Mode that can be used with the mux
drivers.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 include/linux/usb/typec_tbt.h | 53 +++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 include/linux/usb/typec_tbt.h

diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
new file mode 100644
index 000000000000..47c2d501ddce
--- /dev/null
+++ b/include/linux/usb/typec_tbt.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __USB_TYPEC_TBT_H
+#define __USB_TYPEC_TBT_H
+
+#include <linux/usb/typec_altmode.h>
+
+#define USB_TYPEC_VENDOR_INTEL		0x8087
+/* Alias for convenience */
+#define USB_TYPEC_TBT_SID		USB_TYPEC_VENDOR_INTEL
+
+/* Connector state for Thunderbolt3 */
+#define TYPEC_TBT_MODE			TYPEC_STATE_MODAL
+
+/**
+ * struct typec_thunderbolt_data - Thundebolt3 Alt Mode specific data
+ * @device_mode: Device Discover Mode VDO
+ * @cable_mode: Cable Discover Mode VDO
+ * @enter_vdo: Enter Mode VDO
+ */
+struct typec_thunderbolt_data {
+	u32 device_mode;
+	u32 cable_mode;
+	u32 enter_vdo;
+};
+
+/* TBT3 Device Discover Mode VDO bits */
+#define TBT_MODE			BIT(0)
+#define TBT_ADAPTER(_vdo_)		(((_vdo_) & BIT(16)) >> 16)
+#define   TBT_ADAPTER_LEGACY		0
+#define   TBT_ADAPTER_TBT3		1
+#define TBT_INTEL_SPECIFIC_B0		BIT(26)
+#define TBT_VENDOR_SPECIFIC_B0		BIT(30)
+#define TBT_VENDOR_SPECIFIC_B1		BIT(31)
+
+#define TBT_SET_ADAPTER(a)		(((a) & 1) << 16)
+
+/* TBT3 Cable Discover Mode VDO bits */
+#define TBT_CABLE_SPEED(_vdo_)		(((_vdo_) & GENMASK(18, 16)) >> 16)
+#define   TBT_CABLE_USB3_GEN1		1
+#define   TBT_CABLE_USB3_PASSIVE	2
+#define   TBT_CABLE_10_AND_20GBPS	3
+#define TBT_CABLE_ROUNDED		BIT(19)
+#define TBT_CABLE_OPTICAL		BIT(21)
+#define TBT_CABLE_RETIMER		BIT(22)
+#define TBT_CABLE_LINK_TRAINING		BIT(23)
+
+#define TBT_SET_CABLE_SPEED(_s_)	(((_s_) & GENMASK(2, 0)) << 16)
+
+/* TBT3 Device Enter Mode VDO bits */
+#define TBT_ENTER_MODE_CABLE_SPEED(s)	TBT_SET_CABLE_SPEED(s)
+#define TBT_ENTER_MODE_ACTIVE_CABLE	BIT(24)
+
+#endif /* __USB_TYPEC_TBT_H */
-- 
2.25.0

