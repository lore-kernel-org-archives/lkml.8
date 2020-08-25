Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78DAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B142072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="iiGIlPDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgHYEXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgHYEW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:22:59 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5AFC061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:58 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id k32so6887909pgm.15
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MSjuJlqwZbeT/5gqoAJ2R9KeJjOh0ok3YdAVNY4kQaQ=;
        b=iiGIlPDOuad/QAjayZvFuF9m6tB9LjCXcmIMy8uLi85cby6M0mje5/RE6FryMc5jzU
         87st0DVi/rwSFdumypv1bjZ0JYLvyFksJxFRNcHzHvf+e346hdcQbVySpRqhFcxI8haY
         gbsCaQmSxvd99S0w6IZUjp6qfkQ3SPhtcxkcYZE+DTnPyymDT8aodQrGhmfMSnVg8bi3
         IDuZr2O5DkdTDn615ZI/QDSQOxU2ijLydeA5tmwhEq9sS2V4ZJrJlLuU8v192ha3J62P
         Hzq2Vb9L9PB7Yi65Xwt2tSfmEx3vGH0WaCRwfZh7GXhq0IHD6/Lewyn428Pgp+tO7T7g
         IvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MSjuJlqwZbeT/5gqoAJ2R9KeJjOh0ok3YdAVNY4kQaQ=;
        b=J8fk5xJTdugYkpIYdlocqrCTEqj5fQLz2p89sbI1Wuk1bPN8G/7k2c5gOejM/E5Co+
         woObuSUjtH2Q13L0M/Fx7Bn/iH5/i6ED4b5DSUNAgEqstSEXWpVZo32mtpTRecaNPGW+
         NrvOxYD9J7/foHQX6Lg1PA4NqAWaa/ChBi1UvvT37cbDufNHKChkigFi+b8kboCVEpuT
         Mzd3hTrH6hdwphBjPAZffb1DgxCrqwBjESFzPVMh3iZ2B8ZX9XOlqCMAtsKqfGTY7jMC
         B5Xrkw5FUDz9u7tNRr17uSdumXW4T7+YjQFhde3v943Hv5t8OXzSGOYQud5/EwgXsbgb
         8nnA==
X-Gm-Message-State: AOAM532qp5R4uKO/FV/Ml2SpUt4PAr2LiMTbDZFU/ZHPz5tbtGAF3045
        tTZVq/lR8zWOXOyj8XTmN8GXLZAaIXU=
X-Google-Smtp-Source: ABdhPJzBTyW+pz3D1TsoZ/ckSs2GKW2XpSlJoOPGekFFwT/3u4C/xG6pxz48LFAsil4v0+HC4sTHI9Hsi7E=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a05:6a00:22cc:: with SMTP id
 f12mr6383025pfj.42.1598329377892; Mon, 24 Aug 2020 21:22:57 -0700 (PDT)
Date:   Mon, 24 Aug 2020 21:22:09 -0700
In-Reply-To: <20200825042210.300632-1-badhri@google.com>
Message-Id: <20200825042210.300632-14-badhri@google.com>
Mime-Version: 1.0
References: <20200825042210.300632-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 13/14 v1] usb: typec: tcpci: Implement Auto discharge
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
 drivers/usb/typec/tcpm/tcpci.c | 33 +++++++++++++++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpci.h | 22 ++++++++++++++++++++--
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 13d2e1c2ff20..e876f13ddf31 100644
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
@@ -628,6 +655,12 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
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
2.28.0.297.g1956fa8f8d-goog

