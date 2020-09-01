Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5970C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2A52083E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rwoP/KzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgIADAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgIAC76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:59:58 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B7FC06136D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:57 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id i2so7594191qki.19
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NvJ2VnbEYAYNeySI2UMz3nNsuBDzU+DibpijFkeFTwU=;
        b=rwoP/KzKMTUtfPUdUc5xfgfKCr+yJX1fhhyjbK/Qu4I+MfJ8w7db/YozhmwGZQ5f6H
         L136ua3tFoFxfUbiWrFqCwJxRMqiZUa2kqSjZPKhfCb4bapTiIigfIZmXX2InxDexVj3
         aYO1dYhptbQxzVBdZUtv5Wn0PmkHgy0MqyPO4XcE1RhoUof3v+sNTXIOBiPKYeMGASNh
         orpb9LnrKJFL87+4ef1fb9pAA/jvNlc64vqhJYBclKH3C8kXLPFKs+hofMZkO1kFxEbh
         PiE1QcRCaDVrdGFV1PhrJikQozhDv4pWnyTpOqeoYHJ639Q79jH9R4rmSBWDvlwK3Vfy
         0ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NvJ2VnbEYAYNeySI2UMz3nNsuBDzU+DibpijFkeFTwU=;
        b=A0aCIxk11kXSvHpBiC8iEVxaMXKVC8HMUk3CndzpdG3FJu09dW8zVO+17/oJXemYBi
         tyyAp3gdYqw1z/as8LorBgXwRQg8hLYERCQaG8lb1s2mEMXehqgw3AByoLR9XU0H93xT
         EZSR8hhOmYZ5/ImaRoXQFCmtr/ycSD8l8xyJXQJZL4Y2kaVjOeRUA8IpjujSHi+d8Gjp
         /1iaVOIjUw3VnosrcJcBWt04ZMK1EZqNK2qAE/qQ7qSZOspgxAOZfIOpbw9Fi8jeo8hm
         9F17JK1+LbIZ/negIJV4kK0f0ZhZpE8HhO+PxkqGSTHNOBAFDTDTZZiJV0GCnBUZ2am/
         8XcA==
X-Gm-Message-State: AOAM532DLRxXVx9+BlWICx1C4ZXCoi7FAiYserhw/UislYdV8GqcN5Ez
        KY2zQGDLdpzV5Bbyz0AhSrCQJPujJdY=
X-Google-Smtp-Source: ABdhPJxSporgvmLh9JheFlcNPScXLScZEU1MaP/rF9Bjioud2QC52nSdQni9PtIlbiLeYYowS1Ol3sUXok8=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a0c:b2d4:: with SMTP id d20mr1399687qvf.1.1598929196808;
 Mon, 31 Aug 2020 19:59:56 -0700 (PDT)
Date:   Mon, 31 Aug 2020 19:59:26 -0700
In-Reply-To: <20200901025927.3596190-1-badhri@google.com>
Message-Id: <20200901025927.3596190-14-badhri@google.com>
Mime-Version: 1.0
References: <20200901025927.3596190-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v6 13/14] usb: typec: tcpci: Implement Auto discharge
 disconnect callbacks
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement callbacks for enabling/disabling
POWER_CONTROL.AutoDischargeDisconnect.

TCPCI spec allows TCPC hardware to autonomously discharge the vbus
capacitance upon disconnect. The expectation is that the TCPM enables
AutoDischargeDisconnect while entering SNK/SRC_ATTACHED states. Hardware
then automously discharges vbus when the vbus falls below a certain
threshold i.e. VBUS_SINK_DISCONNECT_THRESHOLD.

Apart from enabling the vbus discharge circuit, AutoDischargeDisconnect
is also used a flag to move TCPCI based TCPC implementations into
Attached.Snk/Attached.Src state as mentioned in
Figure 4-15. TCPC State Diagram before a Connection of the
USB Type-C Port Controller Interface Specification.
In such TCPC implementations, setting AutoDischargeDisconnect would
prevent TCPC into entering "Connection_Invalid" state as well.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.
---
 drivers/usb/typec/tcpm/tcpci.c | 33 +++++++++++++++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpci.h | 22 ++++++++++++++++++++--
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index f9f0af64da5f..4ca64e8c8fe8 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -268,6 +268,33 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
 				enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
 }
 
+static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool enable)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(dev);
+	int ret;
+
+	ret = regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
+				 enable ? TCPC_POWER_CTRL_AUTO_DISCHARGE : 0);
+	return ret;
+}
+
+static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum typec_role port_role,
+						   enum typec_pwr_opmode mode, bool pps_active,
+						   u32 requested_vbus_voltage)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(dev);
+	int (*set_auto_vbus_threshold)(struct tcpci *tcpci, struct tcpci_data *data,
+				       enum typec_role port_role, enum typec_pwr_opmode mode,
+				       bool pps_active, u32 requested_vbus_voltage);
+
+	set_auto_vbus_threshold = tcpci->data->set_auto_vbus_discharge_threshold;
+	if (set_auto_vbus_threshold)
+		return set_auto_vbus_threshold(tcpci, tcpci->data, port_role, mode, pps_active,
+					       requested_vbus_voltage);
+
+	return 0;
+}
+
 static int tcpci_enable_frs(struct tcpc_dev *dev, bool enable)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(dev);
@@ -629,6 +656,12 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.set_bist_data = tcpci_set_bist_data;
 	tcpci->tcpc.enable_frs = tcpci_enable_frs;
 
+	if (tcpci->data->auto_discharge_disconnect) {
+		tcpci->tcpc.enable_auto_vbus_discharge = tcpci_enable_auto_vbus_discharge;
+		tcpci->tcpc.set_auto_vbus_discharge_threshold =
+			tcpci_set_auto_vbus_discharge_threshold;
+	}
+
 	err = tcpci_parse_config(tcpci);
 	if (err < 0)
 		return ERR_PTR(err);
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index 5ef07a56d67a..6a0aea34e544 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -8,6 +8,8 @@
 #ifndef __LINUX_USB_TCPCI_H
 #define __LINUX_USB_TCPCI_H
 
+#include <linux/usb/typec.h>
+
 #define TCPC_VENDOR_ID			0x0
 #define TCPC_PRODUCT_ID			0x2
 #define TCPC_BCD_DEV			0x4
@@ -67,6 +69,7 @@
 
 #define TCPC_POWER_CTRL			0x1c
 #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
+#define TCPC_POWER_CTRL_AUTO_DISCHARGE	BIT(4)
 #define TCPC_FAST_ROLE_SWAP_EN		BIT(7)
 
 #define TCPC_CC_STATUS			0x1d
@@ -133,6 +136,8 @@
 
 #define TCPC_VBUS_VOLTAGE			0x70
 #define TCPC_VBUS_SINK_DISCONNECT_THRESH	0x72
+#define TCPC_VBUS_SINK_DISCONNECT_THRESH_LSB	25
+#define TCPC_VBUS_SINK_DISCONNECT_THRESH_MAX	1023
 #define TCPC_VBUS_STOP_DISCHARGE_THRESH		0x74
 #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG		0x76
 #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG		0x78
@@ -140,20 +145,33 @@
 /* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRITE_BYTE_COUNT */
 #define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
 
+struct tcpci;
+
 /*
- * @TX_BUF_BYTE_x_hidden
+ * @TX_BUF_BYTE_x_hidden:
  *		optional; Set when TX_BUF_BYTE_x can only be accessed through I2C_WRITE_BYTE_COUNT.
+ * @auto_discharge_disconnect:
+ *		Optional; Enables TCPC to autonously discharge vbus on disconnect.
+ * @set_auto_vbus_discharge_threshold:
+ *		Mandatory when @auto_discharge_disconnect is sets. Allows
+ *		programming the voltage threshold of vbus below which TCPC
+ *		enables the vbus discharge circuit.
  */
-struct tcpci;
 struct tcpci_data {
 	struct regmap *regmap;
 	unsigned char TX_BUF_BYTE_x_hidden:1;
+	unsigned char auto_discharge_disconnect:1;
+
 	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
 	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
 			 bool enable);
 	int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data *data,
 				  enum typec_cc_status cc);
 	int (*set_vbus)(struct tcpci *tcpci, struct tcpci_data *data, bool source, bool sink);
+	int (*set_auto_vbus_discharge_threshold)(struct tcpci *tcpci, struct tcpci_data *data,
+						 enum typec_role port_role,
+						 enum typec_pwr_opmode mode, bool pps_active,
+						 u32 requested_vbus_voltage);
 };
 
 struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
-- 
2.28.0.402.g5ffc5be6b7-goog

