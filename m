Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAF0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2AD92076C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dna/yREk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgHDGvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHDGvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:51:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F59C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 23:51:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a127so51645929ybb.14
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 23:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FSn0X9txtKoQYA9DDBm/TO9jK+tdQqRTqSZpQdd5Ml4=;
        b=Dna/yREk3cyTVvUixmOwHNzLzss9Xb/YXSDPPn5wjN8wqh3NdXgot0KLWDrWddXxs3
         ucb48/3B9Elvdb+3mq128JC7yFVseh+bSxA6hsB+pfjKGIA1bQhFByFEhlDbYX+K1hOy
         41zRsi4EI/ZxUkpCwkuzX9Eu9S5Wb0wM1ob0G3gx7puHPmSe9OsKYlPnAqJUSIXwTWad
         qXOkK7TB21RcS/2rVT9+rPqYKTjN/uSW1dq9cBURU8cOZiUc16v8JYlphJfsJIfA0fRG
         mWeu6QoAZqftH7yAgYU+3LJnGrvn7TtCpfvA2EwPylMpLlPLdJvQ32g9EtL2RiEkC5Ia
         rkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FSn0X9txtKoQYA9DDBm/TO9jK+tdQqRTqSZpQdd5Ml4=;
        b=ljRj1S7gjmDNZgiCtDsyl3/EEo/Vk4grEnJaD8jl4zaeQCI0vgbO1vLwFyR16BC8Rb
         8+WP5c4HUgV65T8zBSMWRpMcZWrJXCzmKW/OKvJfoShkB//cdiTrWSD31XReHr1pyEB6
         0YaVHh8Ji/08ycAUWp5LghQQo9uSNDMLjl2SQvkz/oHc3gzX04QZpFVE/3jYW72GbqjF
         Zw59IZBXfFea2DOlkOgvviCI0kkXBMeC9qDxjv07eqgNwoGZkPuuEvRMs0CAGLbVUi9k
         RrSFcrxwtr/25PQVL9YESmLUyVmVK6rlfnIS+i0kIPyhvviMSRDbLeF3pNr5ZfcWkAW1
         HUUg==
X-Gm-Message-State: AOAM530Wi2tcDPLBjz8lMGmNhfp9vdlFmUE42xTUgwKUOyg48WvlOS7s
        DQr81Scfi5ZaeIbMDwSGqB8bhaFBL9I=
X-Google-Smtp-Source: ABdhPJzrUEVRFntZBSMuOP9/fgtY4WEGp8tfgYmreIk29r0/hg+uimY8JwWIDrbX/PLwbOO9M39oZ2xKHbc=
X-Received: by 2002:a25:45c3:: with SMTP id s186mr33353743yba.251.1596523874872;
 Mon, 03 Aug 2020 23:51:14 -0700 (PDT)
Date:   Mon,  3 Aug 2020 23:51:11 -0700
Message-Id: <20200804065111.3889122-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v1] tcpm: Honour pSnkStdby requirement during negotiation
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        --validate@google.com, Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From PD Spec:
The Sink Shall transition to Sink Standby before a positive or
negative voltage transition of VBUS. During Sink Standby
the Sink Shall reduce its power draw to pSnkStdby. This allows
the Source to manage the voltage transition as well as
supply sufficient operating current to the Sink to maintain PD
operation during the transition. The Sink Shall
complete this transition to Sink Standby within tSnkStdby
after evaluating the Accept Message from the Source. The
transition when returning to Sink operation from Sink Standby
Shall be completed within tSnkNewPower. The
pSnkStdby requirement Shall only apply if the Sink power draw
is higher than this level.

The above requirement needs to be met to prevent hard resets
from port partner.

Introducing psnkstdby_after_accept flag to accommodate systems
where the input current limit loops are not fast enough to meet
tSnkStby(15 msec).

When not set, port requests PD_P_SNK_STDBY upon entering SNK_DISCOVERY and
the actual currrent limit after RX of PD_CTRL_PSRDY for PD link,
SNK_READY for non-pd link.

When set, port requests CC advertisement based current limit during
SNK_DISCOVERY, current gets limited to PD_P_SNK_STDBY during
SNK_TRANSITION_SINK, PD based current limit gets set after RX of
PD_CTRL_PSRDY. However, in this case it has to be made sure that the
tSnkStdby (15 msec) is met.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 52 +++++++++++++++++++++++++++--------
 include/linux/usb/pd.h        |  5 +++-
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3ef37202ee37..e46da41940b9 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -293,9 +293,12 @@ struct tcpm_port {
 	unsigned int operating_snk_mw;
 	bool update_sink_caps;
 
-	/* Requested current / voltage */
+	/* Set current / voltage */
 	u32 current_limit;
 	u32 supply_voltage;
+	/* current / voltage requested to partner */
+	u32 req_current_limit;
+	u32 req_supply_voltage;
 
 	/* Used to export TA voltage and current */
 	struct power_supply *psy;
@@ -323,13 +326,27 @@ struct tcpm_port {
 	struct pd_mode_data mode_data;
 	struct typec_altmode *partner_altmode[ALTMODE_DISCOVERY_MAX];
 	struct typec_altmode *port_altmode[ALTMODE_DISCOVERY_MAX];
-
 	/* Deadline in jiffies to exit src_try_wait state */
 	unsigned long max_wait;
 
 	/* port belongs to a self powered device */
 	bool self_powered;
 
+	/*
+	 * Honour psnkstdby after accept is received.
+	 * However, in this case it has to be made sure that the tSnkStdby (15
+	 * msec) is met.
+	 *
+	 * When not set, port requests PD_P_SNK_STDBY_5V upon entering SNK_DISCOVERY and
+	 * the actual currrent limit after RX of PD_CTRL_PSRDY for PD link,
+	 * SNK_READY for non-pd link.
+	 *
+	 * When set, port requests CC advertisement based current limit during
+	 * SNK_DISCOVERY, current gets limited to PD_P_SNK_STDBY_5V during SNK_TRANSITION_SINK,
+	 * PD based current limit gets set after RX of PD_CTRL_PSRDY.
+	 */
+	bool psnkstdby_after_accept;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	struct mutex logbuffer_lock;	/* log buffer access lock */
@@ -1787,9 +1804,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		switch (port->state) {
 		case SNK_TRANSITION_SINK:
 			if (port->vbus_present) {
-				tcpm_set_current_limit(port,
-						       port->current_limit,
-						       port->supply_voltage);
+				tcpm_set_current_limit(port, port->req_current_limit,
+						       port->req_supply_voltage);
 				port->explicit_contract = true;
 				tcpm_set_state(port, SNK_READY, 0);
 			} else {
@@ -1861,8 +1877,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			break;
 		case SNK_NEGOTIATE_PPS_CAPABILITIES:
 			port->pps_data.active = true;
-			port->supply_voltage = port->pps_data.out_volt;
-			port->current_limit = port->pps_data.op_curr;
+			port->req_supply_voltage = port->pps_data.out_volt;
+			port->req_current_limit = port->pps_data.op_curr;
 			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
 			break;
 		case SOFT_RESET_SEND:
@@ -2463,8 +2479,8 @@ static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
 			 flags & RDO_CAP_MISMATCH ? " [mismatch]" : "");
 	}
 
-	port->current_limit = ma;
-	port->supply_voltage = mv;
+	port->req_current_limit = ma;
+	port->req_supply_voltage = mv;
 
 	return 0;
 }
@@ -3235,9 +3251,11 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SNK_DISCOVERY:
 		if (port->vbus_present) {
-			tcpm_set_current_limit(port,
-					       tcpm_get_current_limit(port),
-					       5000);
+			if (port->psnkstdby_after_accept || tcpm_get_current_limit(port) <=
+			    PD_P_SNK_STDBY_5V)
+				tcpm_set_current_limit(port, tcpm_get_current_limit(port), 5000);
+			else
+				tcpm_set_current_limit(port, PD_P_SNK_STDBY_5V, 5000);
 			tcpm_set_charge(port, true);
 			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
 			break;
@@ -3318,6 +3336,10 @@ static void run_state_machine(struct tcpm_port *port)
 		}
 		break;
 	case SNK_TRANSITION_SINK:
+		if (port->psnkstdby_after_accept)
+			tcpm_set_current_limit(port, tcpm_get_current_limit(port) >
+					       PD_P_SNK_STDBY_5V ? PD_P_SNK_STDBY_5V :
+					       tcpm_get_current_limit(port), 5000);
 	case SNK_TRANSITION_SINK_VBUS:
 		tcpm_set_state(port, hard_reset_state(port),
 			       PD_T_PS_TRANSITION);
@@ -3331,6 +3353,10 @@ static void run_state_machine(struct tcpm_port *port)
 			port->pwr_opmode = TYPEC_PWR_MODE_PD;
 		}
 
+		/* Set current limit for NON-PD link when psnkstdby_after_accept is not set*/
+		if (!port->pd_capable && !port->psnkstdby_after_accept)
+			tcpm_set_current_limit(port, tcpm_get_current_limit(port), 5000);
+
 		tcpm_swap_complete(port, 0);
 		tcpm_typec_connect(port);
 		tcpm_check_send_discover(port);
@@ -4513,6 +4539,8 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 	port->typec_caps.type = ret;
 	port->port_type = port->typec_caps.type;
 
+	port->psnkstdby_after_accept = fwnode_property_read_bool(fwnode, "psnkstdby-after-accept");
+
 	if (port->port_type == TYPEC_PORT_SNK)
 		goto sink;
 
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index b6c233e79bd4..6bd70f77045e 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -483,5 +483,8 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
 #define PD_N_HARD_RESET_COUNT	2
 
-#define PD_T_BIST_CONT_MODE	50 /* 30 - 60 ms */
+#define PD_T_BIST_CONT_MODE	50	/* 30 - 60 ms */
+
+#define PD_P_SNK_STDBY_5V	500	/* 2500 mw - 500mA @ 5V */
+
 #endif /* __LINUX_USB_PD_H */
-- 
2.28.0.163.g6104cc2f0b6-goog

