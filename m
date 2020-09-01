Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD4BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8A520C56
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="S71SHRoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgIADAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgIAC7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:59:55 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15DCC0612EC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:54 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id m16so1864125pgl.16
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MZQQ4Zf8Z4ChYhQKrfN01ef+EDmqL+HdTnOMVDdSh1Y=;
        b=S71SHRojB5D7G1UnFewk2/SIBuZncVw4S184qExyigKgLud4Ekb0MFtRRAXPpPTKpg
         meCKBXvzrnlMCRjyFY01rEZaLVteF07BWcIjIWe9jG5+CqH/BtpOlPpMaqcagDntAdvz
         XAgjL3kYguYI3/7Ehjm7VBJQsM4dfaFfRfEHdlikGCCd8IhImVv4RYyToKoDLTUtDFo0
         bte0VlipYaZQN+PMdWT3CHQQ4qhSircuFpyVzsq9mHYOUHklN626z2z/G6EPORcbiTjo
         HKiWMjbK90c4XJ5AqJ6J4TEDV4zP8nweF3z4g49lpw/8jxM94gQfwX02Hoam3wl4p0yr
         4Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MZQQ4Zf8Z4ChYhQKrfN01ef+EDmqL+HdTnOMVDdSh1Y=;
        b=JQyN4evTIvGIPVXYUsqc0H8wG1DcgMtcK0V5baC4VNUNssDEL9kv+gkRt4FuMWeDf3
         g/SXL4665n62DhH7j2ENfpZQdHew+VfGbZata2u7KhDdFC7hPakcTl37RR60+3BUOXZU
         LXCjx4HmKhhE8IrZAJC9RG95EuqfTezaB6EUHIhWUQbOUkmnlQ1Ba7YiZ8i/64+IDXnN
         dg9PbdZ/mTvGsdu1vVKoT58GLPQ6yXOTi3pR261hZRIofOZrUSDJpAdydpeGHQrNUeQs
         HJnq6zI8cdG95ejN8gGPW+xXk1CcAxIXJLpJ7pFxjzb9JSH6qvTE9dbKDNlXOFoLDlgc
         7bFg==
X-Gm-Message-State: AOAM531ciolr1Nc+da2EFkU06Kbyzum94cBNKGD+HNiOdxohWFvuPtiX
        ZGbAgzwWOQ65toaXLPtNGsUug/fYwzg=
X-Google-Smtp-Source: ABdhPJwN1y/QjqVwz6gm1xhRh3AXsi0ah9RglVoOReok6/bp8v/RqB5563iJrsmkcIorSMlhJL7/j6AYCF8=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a17:902:a70d:b029:cf:85ab:8d50 with SMTP id
 w13-20020a170902a70db02900cf85ab8d50mr288026plq.3.1598929194145; Mon, 31 Aug
 2020 19:59:54 -0700 (PDT)
Date:   Mon, 31 Aug 2020 19:59:25 -0700
In-Reply-To: <20200901025927.3596190-1-badhri@google.com>
Message-Id: <20200901025927.3596190-13-badhri@google.com>
Mime-Version: 1.0
References: <20200901025927.3596190-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v6 12/14] usb: typec: tcpm: Implement enabling Auto Discharge
 disconnect support
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
 drivers/usb/typec/tcpm/tcpm.c | 74 +++++++++++++++++++++++++++++++++--
 include/linux/usb/tcpm.h      | 16 ++++++++
 2 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 083e7af107b2..7aca769727d8 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1694,6 +1694,25 @@ static void tcpm_handle_alert(struct tcpm_port *port, const __le32 *payload,
 	}
 }
 
+static int tcpm_set_auto_vbus_discharge_threshold(struct tcpm_port *port, enum typec_role port_role,
+						  enum typec_pwr_opmode mode, bool pps_active,
+						  u32 requested_vbus_voltage)
+{
+	int ret;
+
+	if (!port->tcpc->set_auto_vbus_discharge_threshold)
+		return 0;
+
+	ret = port->tcpc->set_auto_vbus_discharge_threshold(port->tcpc, port_role, mode, pps_active,
+							    requested_vbus_voltage);
+	tcpm_log_force(port,
+		       "set_auto_vbus_discharge_threshold pwr_role:%s mode:%d pps_active:%c vbus:%u ret:%d",
+		       port_role == TYPEC_SINK ? "sink" : "source", mode, pps_active ? 'y' : 'n',
+		       requested_vbus_voltage, ret);
+
+	return ret;
+}
+
 static void tcpm_pd_data_request(struct tcpm_port *port,
 				 const struct pd_message *msg)
 {
@@ -1863,6 +1882,10 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 						       port->current_limit,
 						       port->supply_voltage);
 				port->explicit_contract = true;
+				tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SINK,
+								       TYPEC_PWR_MODE_PD,
+								       port->pps_data.active,
+								       port->supply_voltage);
 				tcpm_set_state(port, SNK_READY, 0);
 			} else {
 				/*
@@ -2777,8 +2800,14 @@ static int tcpm_src_attach(struct tcpm_port *port)
 	if (ret < 0)
 		return ret;
 
-	ret = tcpm_set_roles(port, true, TYPEC_SOURCE,
-			     tcpm_data_role_for_source(port));
+	if (port->tcpc->enable_auto_vbus_discharge) {
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SOURCE, TYPEC_PWR_MODE_USB,
+						       false, VSAFE5V);
+		ret = port->tcpc->enable_auto_vbus_discharge(port->tcpc, true);
+		tcpm_log_force(port, "enable vbus discharge ret:%d", ret);
+	}
+
+	ret = tcpm_set_roles(port, true, TYPEC_SOURCE, tcpm_data_role_for_sink(port));
 	if (ret < 0)
 		return ret;
 
@@ -2845,6 +2874,12 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
 
 static void tcpm_reset_port(struct tcpm_port *port)
 {
+	int ret;
+
+	if (port->tcpc->enable_auto_vbus_discharge) {
+		ret = port->tcpc->enable_auto_vbus_discharge(port->tcpc, false);
+		tcpm_log_force(port, "Disable vbus discharge ret:%d", ret);
+	}
 	tcpm_unregister_altmodes(port);
 	tcpm_typec_disconnect(port);
 	port->attached = false;
@@ -2909,8 +2944,14 @@ static int tcpm_snk_attach(struct tcpm_port *port)
 	if (ret < 0)
 		return ret;
 
-	ret = tcpm_set_roles(port, true, TYPEC_SINK,
-			     tcpm_data_role_for_sink(port));
+	if (port->tcpc->enable_auto_vbus_discharge) {
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SINK, TYPEC_PWR_MODE_USB, false,
+						       VSAFE5V);
+		ret = port->tcpc->enable_auto_vbus_discharge(port->tcpc, true);
+		tcpm_log_force(port, "enable vbus discharge ret:%d", ret);
+	}
+
+	ret = tcpm_set_roles(port, true, TYPEC_SINK, tcpm_data_role_for_sink(port));
 	if (ret < 0)
 		return ret;
 
@@ -3470,6 +3511,8 @@ static void run_state_machine(struct tcpm_port *port)
 		 * drive VBUS to vSafe0V as shown in Figure 7-9.
 		 */
 		tcpm_set_vconn(port, false);
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SOURCE, TYPEC_PWR_MODE_USB,
+						       false, 0);
 		tcpm_set_vbus(port, false);
 		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
 			       tcpm_data_role_for_source(port));
@@ -3491,9 +3534,13 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_vbus(port, true);
 		port->tcpc->set_pd_rx(port->tcpc, true);
 		tcpm_set_attached_state(port, true);
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SOURCE, TYPEC_PWR_MODE_USB,
+						       false, VSAFE5V);
 		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
 		break;
 	case SNK_HARD_RESET_SINK_OFF:
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SINK, TYPEC_PWR_MODE_USB, false,
+						       0);
 		memset(&port->pps_data, 0, sizeof(port->pps_data));
 		tcpm_set_vconn(port, false);
 		if (port->pd_capable)
@@ -3536,6 +3583,8 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_charge(port, true);
 		}
 		tcpm_set_attached_state(port, true);
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SINK, TYPEC_PWR_MODE_USB, false,
+						       VSAFE5V);
 		tcpm_set_state(port, SNK_STARTUP, 0);
 		break;
 
@@ -3637,6 +3686,12 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, PR_SWAP_SNK_SRC_SINK_OFF, 0);
 		break;
 	case PR_SWAP_SRC_SNK_TRANSITION_OFF:
+		/*
+		 * Prevent vbus discharge circuit from turning on during PR_SWAP
+		 * as this is not a disconnect.
+		 */
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SOURCE, TYPEC_PWR_MODE_USB,
+						       port->pps_data.active, 0);
 		tcpm_set_vbus(port, false);
 		port->explicit_contract = false;
 		/* allow time for Vbus discharge, must be < tSrcSwapStdby */
@@ -3665,9 +3720,18 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state_cond(port, SNK_UNATTACHED, PD_T_PS_SOURCE_ON);
 		break;
 	case PR_SWAP_SRC_SNK_SINK_ON:
+		/* Set the vbus disconnect threshold for implicit contract */
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SINK, TYPEC_PWR_MODE_USB, false,
+						       VSAFE5V);
 		tcpm_set_state(port, SNK_STARTUP, 0);
 		break;
 	case PR_SWAP_SNK_SRC_SINK_OFF:
+		/*
+		 * Prevent vbus discharge circuit from turning on during PR_SWAP
+		 * as this is not a disconnect.
+		 */
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SINK, TYPEC_PWR_MODE_USB,
+						       port->pps_data.active, 0);
 		tcpm_set_charge(port, false);
 		tcpm_set_state(port, hard_reset_state(port),
 			       PD_T_PS_SOURCE_OFF);
@@ -3693,6 +3757,8 @@ static void run_state_machine(struct tcpm_port *port)
 		 */
 		tcpm_set_pwr_role(port, TYPEC_SOURCE);
 		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SOURCE, TYPEC_PWR_MODE_USB,
+						       false, VSAFE5V);
 		tcpm_set_state(port, SRC_STARTUP, PD_T_SWAP_SRC_START);
 		break;
 
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 09762d26fa0c..a1707def51c3 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -83,6 +83,18 @@ enum tcpm_transmit_type {
  *		Optional; Called to enable/disable PD 3.0 fast role swap.
  *		Enabling frs is accessory dependent as not all PD3.0
  *		accessories support fast role swap.
+ * @enable_auto_vbus_discharge:
+ *		Optional; TCPCI spec based TCPC implementations can optionally
+ *		support hardware to autonomously dischrge vbus upon disconnecting
+ *		as sink or source. TCPM signals TCPC to enable the mechanism upon
+ *		entering connected state and signals disabling upon disconnect.
+ * @set_auto_vbus_discharge_threshold:
+ *		Mandatory when enable_auto_vbus_discharge is implemented. TCPM
+ *		calls this function to allow lower levels drivers to program the
+ *		vbus threshold voltage below which the vbus discharge circuit
+ *		will be turned on. requested_vbus_voltage is set to 0 when vbus
+ *		is going to disappear knowingly i.e. during PR_SWAP and
+ *		HARD_RESET etc.
  */
 struct tcpc_dev {
 	struct fwnode_handle *fwnode;
@@ -109,6 +121,10 @@ struct tcpc_dev {
 			   const struct pd_message *msg);
 	int (*set_bist_data)(struct tcpc_dev *dev, bool on);
 	int (*enable_frs)(struct tcpc_dev *dev, bool enable);
+	int (*enable_auto_vbus_discharge)(struct tcpc_dev *dev, bool enable);
+	int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, enum typec_role port_role,
+						 enum typec_pwr_opmode mode, bool pps_active,
+						 u32 requested_vbus_voltage);
 };
 
 struct tcpm_port;
-- 
2.28.0.402.g5ffc5be6b7-goog

