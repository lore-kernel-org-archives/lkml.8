Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF079C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A2F20BED
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eUfPJdng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIADAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgIAC7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:59:49 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD4AC06136D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:48 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id c4so6805162qvq.15
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=XZMQMgFHJ7ghAbHjfZOo4eA1XMBmQaVmnM6yQ3r5wJU=;
        b=eUfPJdngbzCkWiwt6tbwbsbbjr29amCo4uqyWiAES7EHMEIzDLfgmCmDFz8hooNPCX
         u0kwX7qS6CxTlccyIB9qGSdrFVfknP9pUUMw1nyiGgjSuxLYWdc/vJ0Awe0lQaHe1KYV
         UQW+c9jFHso1fEJq7JdlMeOdTGPaH4DRUnTnDyihvhKPQmgfUfgNcx+87LM3tWjLsGoa
         E/wYu0wdqfTzCyD4oQfw1wSmB8FQrJpDiKMYwfDwfRPq1lnyWb+Iod0y8/yuovqvJIKN
         9Afr2FJdE1i4b2BFHphmslSKETsDHICJgW5RNjtFHIkZiQMa1XfUYRfar5oYUcSo/dUh
         ShHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XZMQMgFHJ7ghAbHjfZOo4eA1XMBmQaVmnM6yQ3r5wJU=;
        b=FQlOpyt69JFFB5VDB4lOymqq9uu3D/k5fQ2bB6NGM7062c7yCJwyN+QOuXS7pkgRZp
         6kANzLqEtWlMA223IXKB6YeXDCjROyK3L1SPr1HFktd/bFsyxdL1Z607Q3bxUk9kcyyS
         hMkMAJcgL/uVv0hgXOSidvcc8pDTvz03iK+hQWbtI3mkESgTWhL/+FWnu3K1jg3uOrxd
         ycYM78ABID1OXylUgG/Dgqqr7jIt3sPwv+TQ/9FAPedAvBmoo+W71IcGPZZGm+iXi/zI
         t4eDTuRjOl7do/VKYl7SJEK0f5GfFkd5S8n61J36GlctLyNVrJmwzZIHbg6VhqwQoDWS
         9fWg==
X-Gm-Message-State: AOAM531TwAUovvxqMFQORN6susynALK0kdYdzQZ8WIUdjggQri8bUQNo
        0xtp4sYQASNzdsqCJbY3jd8Mi8wse24=
X-Google-Smtp-Source: ABdhPJxMVITUQVcSLXCvxPXg1HFJd9k6LzLrDX5KWvRHoNgETEYyBuwYNcR41WQp6Q8K/GOPX8Q+Ns48Jpc=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a0c:f2c1:: with SMTP id c1mr2026233qvm.222.1598929188060;
 Mon, 31 Aug 2020 19:59:48 -0700 (PDT)
Date:   Mon, 31 Aug 2020 19:59:22 -0700
In-Reply-To: <20200901025927.3596190-1-badhri@google.com>
Message-Id: <20200901025927.3596190-10-badhri@google.com>
Mime-Version: 1.0
References: <20200901025927.3596190-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v6 09/14] usb: typec: tcpm: Add support for Sink Fast Role SWAP(FRS)
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

PD 3.0 spec defines a new mechanism for power role swap called
Fast role swap. This change enables TCPM to support FRS when
acting as sink.

Once the explicit contract is negotiated, sink port is
expected to query the source port for sink caps to
determine whether the source is FRS capable.
Bits 23 & 24 of fixed pdo of the sink caps from the source, when
set, indicates the current needed by the source when fast role
swap is in progress(Implicit contract phasae). 0 indicates that
the source does not support Fast Role Swap.

Upon receiving the FRS signal from the source,
TCPC(TCPM_FRS_EVENT) informs TCPM to start the Fast role swap sequence.

1. TCPM sends FRS PD message: FR_SWAP_SEND
2. If response is not received within the expiry of
   SenderResponseTimer, Error recovery is triggered.:
   FR_SWAP_SEND_TIMEOUT
3. Upon receipt of the accept message, TCPM waits for
   PSSourceOffTimer for PS_READY message from the partner:
   FR_SWAP_SNK_SRC_NEW_SINK_READY.

TCPC is expected to autonomously turn on vbus once the FRS
signal is received and vbus voltage falls below vsafe5v within
tSrcFrSwap. This is different from traditional power role swap
where the vbus sourcing is turned on by TCPM.

4. By this time, TCPC most likely would have started to
   source vbus, TCPM waits for tSrcFrSwap to see  if the
   lower level TCPC driver signals TCPM_SOURCING_VBUS event:
   FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED.
5. When TCPC signals sourcing vbus, TCPM sends PS_READY msg and
   changes the CC pin from Rd to Rp. This is the end of fast
   role swap sequence and TCPM initiates the sequnce to negotiate
   explicit contract by transitioning into SRC_STARTUP after
   SwapSrcStart.

The code is written based on the sequence described in "Figure 8-107:
Dual-role Port in Sink to Source Fast Role Swap State Diagram" of
USB Power Delivery Specification Revision 3.0, Version 1.2.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.
- Rebased on top of usb-next and resolved conflicts due to the below
  changes:
  3ed8e1c2ac99 usb: typec: tcpm: Migrate workqueue to RT priority for processing events
  6bbe2a90a0bb usb: typec: tcpm: During PR_SWAP, source caps should be sent only after tSwapSourceStart
- enable_frs sequence is now run as part of the same kthread that runs
  the state machines.
- Fixed the implicit fallthrough warning in the switch case for
  FR_SWAP_CANCEL case.
---
 drivers/usb/typec/tcpm/tcpm.c | 217 +++++++++++++++++++++++++++++++++-
 include/linux/usb/pd.h        |  19 +--
 include/linux/usb/tcpm.h      |   8 +-
 include/linux/usb/typec.h     |  13 ++
 4 files changed, 245 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 92806547f485..083e7af107b2 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -106,6 +106,13 @@
 	S(VCONN_SWAP_TURN_ON_VCONN),		\
 	S(VCONN_SWAP_TURN_OFF_VCONN),		\
 						\
+	S(FR_SWAP_SEND),			\
+	S(FR_SWAP_SEND_TIMEOUT),		\
+	S(FR_SWAP_SNK_SRC_TRANSITION_TO_OFF),			\
+	S(FR_SWAP_SNK_SRC_NEW_SINK_READY),		\
+	S(FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED),	\
+	S(FR_SWAP_CANCEL),			\
+						\
 	S(SNK_TRY),				\
 	S(SNK_TRY_WAIT),			\
 	S(SNK_TRY_WAIT_DEBOUNCE),               \
@@ -127,6 +134,9 @@
 	S(GET_PPS_STATUS_SEND),			\
 	S(GET_PPS_STATUS_SEND_TIMEOUT),		\
 						\
+	S(GET_SINK_CAP),			\
+	S(GET_SINK_CAP_TIMEOUT),		\
+						\
 	S(ERROR_RECOVERY),			\
 	S(PORT_RESET),				\
 	S(PORT_RESET_WAIT_OFF)
@@ -175,6 +185,8 @@ enum adev_actions {
 #define TCPM_CC_EVENT		BIT(0)
 #define TCPM_VBUS_EVENT		BIT(1)
 #define TCPM_RESET_EVENT	BIT(2)
+#define TCPM_FRS_EVENT		BIT(3)
+#define TCPM_SOURCING_VBUS	BIT(4)
 
 #define LOG_BUFFER_ENTRIES	1024
 #define LOG_BUFFER_ENTRY_SIZE	128
@@ -184,6 +196,8 @@ enum adev_actions {
 #define SVID_DISCOVERY_MAX	16
 #define ALTMODE_DISCOVERY_MAX	(SVID_DISCOVERY_MAX * MODE_DISCOVERY_MAX)
 
+#define GET_SINK_CAP_RETRY_MS	100
+
 struct pd_mode_data {
 	int svid_index;		/* current SVID index		*/
 	int nsvids;
@@ -261,6 +275,8 @@ struct tcpm_port {
 	struct kthread_work state_machine;
 	struct hrtimer vdm_state_machine_timer;
 	struct kthread_work vdm_state_machine;
+	struct hrtimer enable_frs_timer;
+	struct kthread_work enable_frs;
 	bool state_machine_running;
 
 	struct completion tx_complete;
@@ -335,6 +351,12 @@ struct tcpm_port {
 	/* port belongs to a self powered device */
 	bool self_powered;
 
+	/* FRS */
+	enum frs_typec_current frs_current;
+
+	/* Sink caps have been queried */
+	bool sink_cap_done;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	struct mutex logbuffer_lock;	/* log buffer access lock */
@@ -940,6 +962,16 @@ static void mod_vdm_delayed_work(struct tcpm_port *port, unsigned int delay_ms)
 	}
 }
 
+static void mod_enable_frs_delayed_work(struct tcpm_port *port, unsigned int delay_ms)
+{
+	if (delay_ms) {
+		hrtimer_start(&port->enable_frs_timer, ms_to_ktime(delay_ms), HRTIMER_MODE_REL);
+	} else {
+		hrtimer_cancel(&port->enable_frs_timer);
+		kthread_queue_work(port->wq, &port->enable_frs);
+	}
+}
+
 static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
 			   unsigned int delay_ms)
 {
@@ -1669,6 +1701,9 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 	unsigned int cnt = pd_header_cnt_le(msg->header);
 	unsigned int rev = pd_header_rev_le(msg->header);
 	unsigned int i;
+	enum frs_typec_current frs_current;
+	bool frs_enable;
+	int ret;
 
 	switch (type) {
 	case PD_DATA_SOURCE_CAP:
@@ -1738,7 +1773,21 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 		/* We don't do anything with this at the moment... */
 		for (i = 0; i < cnt; i++)
 			port->sink_caps[i] = le32_to_cpu(msg->payload[i]);
+
+		frs_current = (port->sink_caps[0] & PDO_FIXED_FRS_CURR_MASK) >>
+			PDO_FIXED_FRS_CURR_SHIFT;
+		frs_enable = frs_current && (frs_current <= port->typec_caps.frs_current);
+		tcpm_log(port,
+			 "Port partner FRS capable partner_frs_current:%u port_frs_current:%u enable:%c",
+			 frs_current, port->typec_caps.frs_current, frs_enable ? 'y' : 'n');
+		if (frs_enable) {
+			ret  = port->tcpc->enable_frs(port->tcpc, true);
+			tcpm_log(port, "Enable FRS %s, ret:%d\n", ret ? "fail" : "success", ret);
+		}
+
 		port->nr_sink_caps = cnt;
+		port->sink_cap_done = true;
+		tcpm_set_state(port, SNK_READY, 0);
 		break;
 	case PD_DATA_VENDOR_DEF:
 		tcpm_handle_vdm_request(port, msg->payload, cnt);
@@ -1833,6 +1882,9 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		case VCONN_SWAP_WAIT_FOR_VCONN:
 			tcpm_set_state(port, VCONN_SWAP_TURN_OFF_VCONN, 0);
 			break;
+		case FR_SWAP_SNK_SRC_TRANSITION_TO_OFF:
+			tcpm_set_state(port, FR_SWAP_SNK_SRC_NEW_SINK_READY, 0);
+			break;
 		default:
 			break;
 		}
@@ -1872,6 +1924,13 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 					     -EAGAIN : -EOPNOTSUPP);
 			tcpm_set_state(port, VCONN_SWAP_CANCEL, 0);
 			break;
+		case FR_SWAP_SEND:
+			tcpm_set_state(port, FR_SWAP_CANCEL, 0);
+			break;
+		case GET_SINK_CAP:
+			port->sink_cap_done = true;
+			tcpm_set_state(port, ready_state(port), 0);
+			break;
 		default:
 			break;
 		}
@@ -1906,6 +1965,9 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		case VCONN_SWAP_SEND:
 			tcpm_set_state(port, VCONN_SWAP_START, 0);
 			break;
+		case FR_SWAP_SEND:
+			tcpm_set_state(port, FR_SWAP_SNK_SRC_TRANSITION_TO_OFF, 0);
+			break;
 		default:
 			break;
 		}
@@ -2806,6 +2868,10 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	port->try_src_count = 0;
 	port->try_snk_count = 0;
 	port->usb_type = POWER_SUPPLY_USB_TYPE_C;
+	port->nr_sink_caps = 0;
+	port->sink_cap_done = false;
+	if (port->tcpc->enable_frs)
+		port->tcpc->enable_frs(port->tcpc, false);
 
 	power_supply_changed(port->psy);
 }
@@ -3356,10 +3422,9 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_swap_complete(port, 0);
 		tcpm_typec_connect(port);
 		tcpm_check_send_discover(port);
+		mod_enable_frs_delayed_work(port, 0);
 		tcpm_pps_complete(port, port->pps_status);
-
 		power_supply_changed(port->psy);
-
 		break;
 
 	/* Accessory states */
@@ -3383,9 +3448,13 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, HARD_RESET_START, 0);
 		break;
 	case HARD_RESET_START:
+		port->sink_cap_done = false;
+		if (port->tcpc->enable_frs)
+			port->tcpc->enable_frs(port->tcpc, false);
 		port->hard_reset_count++;
 		port->tcpc->set_pd_rx(port->tcpc, false);
 		tcpm_unregister_altmodes(port);
+		port->nr_sink_caps = 0;
 		port->send_discover = true;
 		if (port->pwr_role == TYPEC_SOURCE)
 			tcpm_set_state(port, SRC_HARD_RESET_VBUS_OFF,
@@ -3517,6 +3586,35 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 
+	case FR_SWAP_SEND:
+		if (tcpm_pd_send_control(port, PD_CTRL_FR_SWAP)) {
+			tcpm_set_state(port, ERROR_RECOVERY, 0);
+			break;
+		}
+		tcpm_set_state_cond(port, FR_SWAP_SEND_TIMEOUT, PD_T_SENDER_RESPONSE);
+		break;
+	case FR_SWAP_SEND_TIMEOUT:
+		tcpm_set_state(port, ERROR_RECOVERY, 0);
+		break;
+	case FR_SWAP_SNK_SRC_TRANSITION_TO_OFF:
+		tcpm_set_state(port, ERROR_RECOVERY, PD_T_PS_SOURCE_OFF);
+		break;
+	case FR_SWAP_SNK_SRC_NEW_SINK_READY:
+		if (port->vbus_source)
+			tcpm_set_state(port, FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED, 0);
+		else
+			tcpm_set_state(port, ERROR_RECOVERY, PD_T_RECEIVER_RESPONSE);
+		break;
+	case FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED:
+		tcpm_set_pwr_role(port, TYPEC_SOURCE);
+		if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY)) {
+			tcpm_set_state(port, ERROR_RECOVERY, 0);
+			break;
+		}
+		tcpm_set_cc(port, tcpm_rp_cc(port));
+		tcpm_set_state(port, SRC_STARTUP, PD_T_SWAP_SRC_START);
+		break;
+
 	/* PR_Swap states */
 	case PR_SWAP_ACCEPT:
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
@@ -3640,6 +3738,12 @@ static void run_state_machine(struct tcpm_port *port)
 		else
 			tcpm_set_state(port, SNK_READY, 0);
 		break;
+	case FR_SWAP_CANCEL:
+		if (port->pwr_role == TYPEC_SOURCE)
+			tcpm_set_state(port, SRC_READY, 0);
+		else
+			tcpm_set_state(port, SNK_READY, 0);
+		break;
 
 	case BIST_RX:
 		switch (BDO_MODE_MASK(port->bist_request)) {
@@ -3674,6 +3778,14 @@ static void run_state_machine(struct tcpm_port *port)
 	case GET_PPS_STATUS_SEND_TIMEOUT:
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
+	case GET_SINK_CAP:
+		tcpm_pd_send_control(port, PD_CTRL_GET_SINK_CAP);
+		tcpm_set_state(port, GET_SINK_CAP_TIMEOUT, PD_T_SENDER_RESPONSE);
+		break;
+	case GET_SINK_CAP_TIMEOUT:
+		port->sink_cap_done = true;
+		tcpm_set_state(port, ready_state(port), 0);
+		break;
 	case ERROR_RECOVERY:
 		tcpm_swap_complete(port, -EPROTO);
 		tcpm_pps_complete(port, -EPROTO);
@@ -3889,6 +4001,13 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 		 * Ignore it.
 		 */
 		break;
+	case FR_SWAP_SEND:
+	case FR_SWAP_SEND_TIMEOUT:
+	case FR_SWAP_SNK_SRC_TRANSITION_TO_OFF:
+	case FR_SWAP_SNK_SRC_NEW_SINK_READY:
+	case FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED:
+		/* Do nothing, CC change expected */
+		break;
 
 	case PORT_RESET:
 	case PORT_RESET_WAIT_OFF:
@@ -3959,6 +4078,9 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
 	case SRC_TRY_DEBOUNCE:
 		/* Do nothing, waiting for sink detection */
 		break;
+	case FR_SWAP_SNK_SRC_NEW_SINK_READY:
+		tcpm_set_state(port, FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED, 0);
+		break;
 
 	case PORT_RESET:
 	case PORT_RESET_WAIT_OFF:
@@ -4038,6 +4160,14 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
 		 */
 		break;
 
+	case FR_SWAP_SEND:
+	case FR_SWAP_SEND_TIMEOUT:
+	case FR_SWAP_SNK_SRC_TRANSITION_TO_OFF:
+	case FR_SWAP_SNK_SRC_NEW_SINK_READY:
+	case FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED:
+		/* Do nothing, vbus drop expected */
+		break;
+
 	default:
 		if (port->pwr_role == TYPEC_SINK &&
 		    port->attached)
@@ -4092,6 +4222,25 @@ static void tcpm_pd_event_handler(struct kthread_work *work)
 			if (port->tcpc->get_cc(port->tcpc, &cc1, &cc2) == 0)
 				_tcpm_cc_change(port, cc1, cc2);
 		}
+		if (events & TCPM_FRS_EVENT) {
+			if (port->state == SNK_READY)
+				tcpm_set_state(port, FR_SWAP_SEND, 0);
+			else
+				tcpm_log(port, "Discarding FRS_SIGNAL! Not in sink ready");
+		}
+		if (events & TCPM_SOURCING_VBUS) {
+			tcpm_log(port, "sourcing vbus");
+			/*
+			 * In fast role swap case TCPC autonomously sources vbus. Set vbus_source
+			 * true as TCPM wouldn't have called tcpm_set_vbus.
+			 *
+			 * When vbus is sourced on the command on TCPM i.e. TCPM called
+			 * tcpm_set_vbus to source vbus, vbus_source would already be true.
+			 */
+			port->vbus_source = true;
+			_tcpm_pd_vbus_on(port);
+		}
+
 		spin_lock(&port->pd_event_lock);
 	}
 	spin_unlock(&port->pd_event_lock);
@@ -4125,6 +4274,50 @@ void tcpm_pd_hard_reset(struct tcpm_port *port)
 }
 EXPORT_SYMBOL_GPL(tcpm_pd_hard_reset);
 
+void tcpm_sink_frs(struct tcpm_port *port)
+{
+	spin_lock(&port->pd_event_lock);
+	port->pd_events = TCPM_FRS_EVENT;
+	spin_unlock(&port->pd_event_lock);
+	kthread_queue_work(port->wq, &port->event_work);
+}
+EXPORT_SYMBOL_GPL(tcpm_sink_frs);
+
+void tcpm_sourcing_vbus(struct tcpm_port *port)
+{
+	spin_lock(&port->pd_event_lock);
+	port->pd_events = TCPM_SOURCING_VBUS;
+	spin_unlock(&port->pd_event_lock);
+	kthread_queue_work(port->wq, &port->event_work);
+}
+EXPORT_SYMBOL_GPL(tcpm_sourcing_vbus);
+
+static void tcpm_enable_frs_work(struct kthread_work *work)
+{
+	struct tcpm_port *port = container_of(work, struct tcpm_port, enable_frs);
+
+	mutex_lock(&port->lock);
+	/* Not FRS capable */
+	if (!port->connected || port->port_type != TYPEC_PORT_DRP ||
+	    port->pwr_opmode != TYPEC_PWR_MODE_PD ||
+	    !port->tcpc->enable_frs ||
+	    /* Sink caps queried */
+	    port->sink_cap_done || port->negotiated_rev < PD_REV30)
+		goto unlock;
+
+	/* Send when the state machine is idle */
+	if (port->state != SNK_READY || port->vdm_state != VDM_STATE_DONE || port->send_discover)
+		goto resched;
+
+	tcpm_set_state(port, GET_SINK_CAP, 0);
+	port->sink_cap_done = true;
+
+resched:
+	mod_enable_frs_delayed_work(port, GET_SINK_CAP_RETRY_MS);
+unlock:
+	mutex_unlock(&port->lock);
+}
+
 static int tcpm_dr_set(struct typec_port *p, enum typec_data_role data)
 {
 	struct tcpm_port *port = typec_get_drvdata(p);
@@ -4532,7 +4725,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 {
 	const char *cap_str;
 	int ret;
-	u32 mw;
+	u32 mw, frs_current;
 
 	if (!fwnode)
 		return -EINVAL;
@@ -4601,6 +4794,13 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 
 	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
 
+	/* FRS can only be supported byb DRP ports */
+	if (port->port_type == TYPEC_PORT_DRP) {
+		ret = fwnode_property_read_u32(fwnode, "frs-typec-current", &frs_current);
+		if (ret >= 0 && frs_current <= FRS_5V_3A)
+			port->typec_caps.frs_current = frs_current;
+	}
+
 	return 0;
 }
 
@@ -4845,6 +5045,14 @@ static enum hrtimer_restart vdm_state_machine_timer_handler(struct hrtimer *time
 	return HRTIMER_NORESTART;
 }
 
+static enum hrtimer_restart enable_frs_timer_handler(struct hrtimer *timer)
+{
+	struct tcpm_port *port = container_of(timer, struct tcpm_port, enable_frs_timer);
+
+	kthread_queue_work(port->wq, &port->enable_frs);
+	return HRTIMER_NORESTART;
+}
+
 struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 {
 	struct tcpm_port *port;
@@ -4874,10 +5082,13 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	kthread_init_work(&port->state_machine, tcpm_state_machine_work);
 	kthread_init_work(&port->vdm_state_machine, vdm_state_machine_work);
 	kthread_init_work(&port->event_work, tcpm_pd_event_handler);
+	kthread_init_work(&port->enable_frs, tcpm_enable_frs_work);
 	hrtimer_init(&port->state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	port->state_machine_timer.function = state_machine_timer_handler;
 	hrtimer_init(&port->vdm_state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	port->vdm_state_machine_timer.function = vdm_state_machine_timer_handler;
+	hrtimer_init(&port->enable_frs_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	port->enable_frs_timer.function = enable_frs_timer_handler;
 
 	spin_lock_init(&port->pd_event_lock);
 
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index f842e4589bd2..3a805e2ecbc9 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -219,14 +219,16 @@ enum pd_pdo_type {
 #define PDO_CURR_MASK		0x3ff
 #define PDO_PWR_MASK		0x3ff
 
-#define PDO_FIXED_DUAL_ROLE	BIT(29)	/* Power role swap supported */
-#define PDO_FIXED_SUSPEND	BIT(28) /* USB Suspend supported (Source) */
-#define PDO_FIXED_HIGHER_CAP	BIT(28) /* Requires more than vSafe5V (Sink) */
-#define PDO_FIXED_EXTPOWER	BIT(27) /* Externally powered */
-#define PDO_FIXED_USB_COMM	BIT(26) /* USB communications capable */
-#define PDO_FIXED_DATA_SWAP	BIT(25) /* Data role swap supported */
-#define PDO_FIXED_VOLT_SHIFT	10	/* 50mV units */
-#define PDO_FIXED_CURR_SHIFT	0	/* 10mA units */
+#define PDO_FIXED_DUAL_ROLE		BIT(29)	/* Power role swap supported */
+#define PDO_FIXED_SUSPEND		BIT(28) /* USB Suspend supported (Source) */
+#define PDO_FIXED_HIGHER_CAP		BIT(28) /* Requires more than vSafe5V (Sink) */
+#define PDO_FIXED_EXTPOWER		BIT(27) /* Externally powered */
+#define PDO_FIXED_USB_COMM		BIT(26) /* USB communications capable */
+#define PDO_FIXED_DATA_SWAP		BIT(25) /* Data role swap supported */
+#define PDO_FIXED_FRS_CURR_MASK		(BIT(24) | BIT(23)) /* FR_Swap Current (Sink) */
+#define PDO_FIXED_FRS_CURR_SHIFT	23
+#define PDO_FIXED_VOLT_SHIFT		10	/* 50mV units */
+#define PDO_FIXED_CURR_SHIFT		0	/* 10mA units */
 
 #define PDO_FIXED_VOLT(mv)	((((mv) / 50) & PDO_VOLT_MASK) << PDO_FIXED_VOLT_SHIFT)
 #define PDO_FIXED_CURR(ma)	((((ma) / 10) & PDO_CURR_MASK) << PDO_FIXED_CURR_SHIFT)
@@ -454,6 +456,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_T_DB_DETECT		10000	/* 10 - 15 seconds */
 #define PD_T_SEND_SOURCE_CAP	150	/* 100 - 200 ms */
 #define PD_T_SENDER_RESPONSE	60	/* 24 - 30 ms, relaxed */
+#define PD_T_RECEIVER_RESPONSE	15	/* 15ms max */
 #define PD_T_SOURCE_ACTIVITY	45
 #define PD_T_SINK_ACTIVITY	135
 #define PD_T_SINK_WAIT_CAP	240
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 89f58760cf48..09762d26fa0c 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -78,8 +78,11 @@ enum tcpm_transmit_type {
  *		automatically if a connection is established.
  * @try_role:	Optional; called to set a preferred role
  * @pd_transmit:Called to transmit PD message
- * @mux:	Pointer to multiplexer data
  * @set_bist_data: Turn on/off bist data mode for compliance testing
+ * @enable_frs:
+ *		Optional; Called to enable/disable PD 3.0 fast role swap.
+ *		Enabling frs is accessory dependent as not all PD3.0
+ *		accessories support fast role swap.
  */
 struct tcpc_dev {
 	struct fwnode_handle *fwnode;
@@ -105,6 +108,7 @@ struct tcpc_dev {
 	int (*pd_transmit)(struct tcpc_dev *dev, enum tcpm_transmit_type type,
 			   const struct pd_message *msg);
 	int (*set_bist_data)(struct tcpc_dev *dev, bool on);
+	int (*enable_frs)(struct tcpc_dev *dev, bool enable);
 };
 
 struct tcpm_port;
@@ -114,6 +118,8 @@ void tcpm_unregister_port(struct tcpm_port *port);
 
 void tcpm_vbus_change(struct tcpm_port *port);
 void tcpm_cc_change(struct tcpm_port *port);
+void tcpm_sink_frs(struct tcpm_port *port);
+void tcpm_sourcing_vbus(struct tcpm_port *port);
 void tcpm_pd_receive(struct tcpm_port *port,
 		     const struct pd_message *msg);
 void tcpm_pd_transmit_complete(struct tcpm_port *port,
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 9cb1bec94b71..2ec7451a14ab 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -204,6 +204,18 @@ struct typec_operations {
 			     enum typec_port_type type);
 };
 
+/*
+ * Initial current capability of the new source when vSafe5V is applied during PD3.0 Fast Role Swap.
+ * Based on "Table 6-14 Fixed Supply PDO - Sink" of "USB Power Delivery Specification Revision 3.0,
+ * Version 1.2"
+ */
+enum frs_typec_current {
+	FRS_NOT_SUPPORTED,
+	FRS_DEFAULT_POWER,
+	FRS_5V_1P5A,
+	FRS_5V_3A,
+};
+
 /*
  * struct typec_capability - USB Type-C Port Capabilities
  * @type: Supported power role of the port
@@ -226,6 +238,7 @@ struct typec_capability {
 	int			prefer_role;
 	enum typec_accessory	accessory[TYPEC_MAX_ACCESSORY];
 	unsigned int		orientation_aware:1;
+	enum frs_typec_current	frs_current;
 
 	struct fwnode_handle	*fwnode;
 	void			*driver_data;
-- 
2.28.0.402.g5ffc5be6b7-goog

