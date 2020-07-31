Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA89C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB20320829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skAPgd7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbgGaG6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731459AbgGaG6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 02:58:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C1BC061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 23:58:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e135so37137984ybf.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 23:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=/0Q6XFNNX59gIOGxvSdDXEc54czs1Xha4qqlJtedwg0=;
        b=skAPgd7Ks9cQrItck70x1Mh3jZKSED1uzmOoOCMV950oVeqv65KHEP1nBrhICyhbUQ
         AJrWFq40yvGgl9Fn3roDlHCHgNu5DMawKJ8t464S581okN1Hh/JuXrV0FHTrdIqWK2s5
         6xVzPSI/eMbS1e9Pz5ENsd3l2tQJ7+yrBWEOCAq4XIEjj/6rIp2VSr1eMJOw0Wuq7jF2
         z5/gQh6d0UuVPg7wZcaL8+Vv5ts646yytGB2I2nLn8sxgkpbwMY0PuASBYyBoQW5EeQj
         WxgchSEhN52B/TFoPM8HcTS2WYxWMZ26lmQbHXtKpMqJSPA7lciGrdfn+8SxBkHidBWL
         5G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=/0Q6XFNNX59gIOGxvSdDXEc54czs1Xha4qqlJtedwg0=;
        b=uA+jjypk7mvuiqgZTBihFiyY6ef2hmwzobSq3w/s/BzDCINs9jFjK/7I1/aojTigY1
         cg7hS5Kd8vleFIafJ/beSYC9g4S0Wi7pm6bED6lIyTdMH7wCKsObu1kEZCzU8PMCrx5s
         FVSaTDo+FbjDct/CxOCOVl24zwnfht2kNdHDRtX6AtnEfVSxn8Y/wnNRsICXHS97CU3C
         6wgPnAwqCEHBCnsLXVmkdRp+WEwj73wwRmMEi5nEtS5Ja4xxkQ/hDq+rszR6WDYihug3
         VLv++FeFaMLZKPo9ioNMxvPpya+uMxo4U68+q+lMd/9Carbd2I/09hPSHChoxpDxvEXd
         pytw==
X-Gm-Message-State: AOAM532V7H+cFMdIfhYqEGFfn7KHahSDwbbM1hU65IsTccPom+gS90D5
        pU4tUz7R24PdW2z8cuARFyOSk4D9c5A=
X-Google-Smtp-Source: ABdhPJzr5EeyJsHwPuwByshyxF1qIj2q9ZVndbihsZ5jBZZLv+YiVg5ok784Bdt2SCpJYtLz9p4XaXxZDtc=
X-Received: by 2002:a25:d946:: with SMTP id q67mr3676470ybg.517.1596178714762;
 Thu, 30 Jul 2020 23:58:34 -0700 (PDT)
Date:   Thu, 30 Jul 2020 23:58:30 -0700
Message-Id: <20200731065830.3744049-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v5] usb: typec: tcpm: Migrate workqueue to RT priority for
 processing events
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"tReceiverResponse 15 ms Section 6.6.2
The receiver of a Message requiring a response Shall respond
within tReceiverResponse in order to ensure that the
sender=E2=80=99s SenderResponseTimer does not expire."

When the cpu complex is busy running other lower priority
work items, TCPM's work queue sometimes does not get scheduled
on time to meet the above requirement from the spec.
Moving to kthread_work apis to run with real time priority.
Just lower than the default threaded irq priority,
MAX_USER_RT_PRIO/2 + 1. (Higher number implies lower priority).

Further, as observed in 1ff688209e2e, moving to hrtimers to
overcome scheduling latency while scheduling the delayed work.

TCPM has three work streams:
1. tcpm_state_machine
2. vdm_state_machine
3. event_work

tcpm_state_machine and vdm_state_machine both schedule work in
future i.e. delayed. Hence each of them have a corresponding
hrtimer, tcpm_state_machine_timer & vdm_state_machine_timer.

When work is queued right away kthread_queue_work is used.
Else, the relevant timer is programmed and made to queue
the kthread_work upon timer expiry.

kthread_create_worker only creates one kthread worker thread,
hence single threadedness of workqueue is retained.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since v1:(Guenter's suggestions)
- Remove redundant call to hrtimer_cancel while calling
  hrtimer_start.

Changes since v2:(Greg KH's suggestions)
- Rebase usb-next TOT.
  633198cd2945b7 (HEAD -> usb-next-1) usb: typec: tcpm: Migrate workqueue t=
o RT priority for processing events
  fa56dd9152ef95 (origin/usb-next) Merge tag 'usb-serial-5.9-rc1' of https:=
//git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next
  25252919a1050e xhci: dbgtty: Make some functions static
  b0e02550346e67 xhci: dbc: Make function xhci_dbc_ring_alloc() static
  ca6377900974c3 Revert "usb: dwc2: override PHY input signals with usb rol=
e switch support"
  09df709cb5aeb2 Revert "usb: dwc2: don't use ID/Vbus detection if usb-role=
-switch on STM32MP15 SoCs"
  17a82716587e9d USB: iowarrior: fix up report size handling for some devic=
es
  e98ba8cc3f8a89 Merge tag 'usb-for-v5.9' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/balbi/usb into usb-next
  c97793089b11f7 Merge 5.8-rc7 into usb-next
  92ed301919932f (tag: v5.8-rc7, origin/usb-linus, origin/main) Linux 5.8-r=
c7

- Added reviewed-by tags.

Changes since v3:(Greg KH's suggestions)
- Rebase usb-next TOT
  Resolve merge conflict with "usb: typec: tcpm: Move mod_delayed_work(&por=
t->vdm_state_machine) call into tcpm_queue_vdm()"

  b8f151122648b0 (HEAD -> usb-next-1) usb: typec: tcpm: Migrate workqueue t=
o RT priority for processing events
  ab4dc051d7b39c (origin/usb-testing, origin/usb-next) usb: mtu3: simplify =
mtu3_req_complete()
  f1e51e99ed498d usb: mtu3: clear dual mode of u3port when disable device
  54402373c45e44 usb: mtu3: use MTU3_EP_WEDGE flag
  bf77804b1cbdeb usb: mtu3: remove useless member @busy in mtu3_ep struct
  ba428976a8827f usb: mtu3: remove repeated error log
  dc4c1aa7eae99d usb: mtu3: add ->udc_set_speed()
  1258450ef38af7 usb: mtu3: introduce a funtion to check maximum speed

Changes since v4:
 - Constantify and fix sched_param (Heikki & Guenter suggestion)
 - Change applied so added Reviewed-by: Guenter Roeck <linux@roeck-us.net>
 - Move to ERR_CAST when wq fails to setup
---

drivers/usb/typec/tcpm/tcpm.c | 136 +++++++++++++++++++++++-----------
 1 file changed, 92 insertions(+), 44 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3ef37202ee3757..d1fc8abaedbc7e 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -8,8 +8,10 @@
 #include <linux/completion.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/hrtimer.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/power_supply.h>
@@ -28,7 +30,8 @@
 #include <linux/usb/role.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec_altmode.h>
-#include <linux/workqueue.h>
+
+#include <uapi/linux/sched/types.h>
=20
 #define FOREACH_STATE(S)			\
 	S(INVALID_STATE),			\
@@ -203,7 +206,7 @@ struct tcpm_port {
 	struct device *dev;
=20
 	struct mutex lock;		/* tcpm state machine lock */
-	struct workqueue_struct *wq;
+	struct kthread_worker *wq;
=20
 	struct typec_capability typec_caps;
 	struct typec_port *typec_port;
@@ -247,15 +250,17 @@ struct tcpm_port {
 	enum tcpm_state prev_state;
 	enum tcpm_state state;
 	enum tcpm_state delayed_state;
-	unsigned long delayed_runtime;
+	ktime_t delayed_runtime;
 	unsigned long delay_ms;
=20
 	spinlock_t pd_event_lock;
 	u32 pd_events;
=20
-	struct work_struct event_work;
-	struct delayed_work state_machine;
-	struct delayed_work vdm_state_machine;
+	struct kthread_work event_work;
+	struct hrtimer state_machine_timer;
+	struct kthread_work state_machine;
+	struct hrtimer vdm_state_machine_timer;
+	struct kthread_work vdm_state_machine;
 	bool state_machine_running;
=20
 	struct completion tx_complete;
@@ -340,7 +345,7 @@ struct tcpm_port {
 };
=20
 struct pd_rx_event {
-	struct work_struct work;
+	struct kthread_work work;
 	struct tcpm_port *port;
 	struct pd_message msg;
 };
@@ -914,6 +919,27 @@ static int tcpm_pd_send_sink_caps(struct tcpm_port *po=
rt)
 	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
 }
=20
+static void mod_tcpm_delayed_work(struct tcpm_port *port, unsigned int del=
ay_ms)
+{
+	if (delay_ms) {
+		hrtimer_start(&port->state_machine_timer, ms_to_ktime(delay_ms), HRTIMER=
_MODE_REL);
+	} else {
+		hrtimer_cancel(&port->state_machine_timer);
+		kthread_queue_work(port->wq, &port->state_machine);
+	}
+}
+
+static void mod_vdm_delayed_work(struct tcpm_port *port, unsigned int dela=
y_ms)
+{
+	if (delay_ms) {
+		hrtimer_start(&port->vdm_state_machine_timer, ms_to_ktime(delay_ms),
+			      HRTIMER_MODE_REL);
+	} else {
+		hrtimer_cancel(&port->vdm_state_machine_timer);
+		kthread_queue_work(port->wq, &port->vdm_state_machine);
+	}
+}
+
 static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
 			   unsigned int delay_ms)
 {
@@ -922,9 +948,8 @@ static void tcpm_set_state(struct tcpm_port *port, enum=
 tcpm_state state,
 			 tcpm_states[port->state], tcpm_states[state],
 			 delay_ms);
 		port->delayed_state =3D state;
-		mod_delayed_work(port->wq, &port->state_machine,
-				 msecs_to_jiffies(delay_ms));
-		port->delayed_runtime =3D jiffies + msecs_to_jiffies(delay_ms);
+		mod_tcpm_delayed_work(port, delay_ms);
+		port->delayed_runtime =3D ktime_add(ktime_get(), ms_to_ktime(delay_ms));
 		port->delay_ms =3D delay_ms;
 	} else {
 		tcpm_log(port, "state change %s -> %s",
@@ -939,7 +964,7 @@ static void tcpm_set_state(struct tcpm_port *port, enum=
 tcpm_state state,
 		 * machine.
 		 */
 		if (!port->state_machine_running)
-			mod_delayed_work(port->wq, &port->state_machine, 0);
+			mod_tcpm_delayed_work(port, 0);
 	}
 }
=20
@@ -960,7 +985,7 @@ static void tcpm_queue_message(struct tcpm_port *port,
 			       enum pd_msg_request message)
 {
 	port->queued_message =3D message;
-	mod_delayed_work(port->wq, &port->state_machine, 0);
+	mod_tcpm_delayed_work(port, 0);
 }
=20
 /*
@@ -981,7 +1006,7 @@ static void tcpm_queue_vdm(struct tcpm_port *port, con=
st u32 header,
 	port->vdm_retries =3D 0;
 	port->vdm_state =3D VDM_STATE_READY;
=20
-	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mod_vdm_delayed_work(port, 0);
 }
=20
 static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 head=
er,
@@ -1244,8 +1269,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port =
*port,
 			port->vdm_state =3D VDM_STATE_WAIT_RSP_BUSY;
 			port->vdo_retry =3D (p[0] & ~VDO_CMDT_MASK) |
 				CMDT_INIT;
-			mod_delayed_work(port->wq, &port->vdm_state_machine,
-					 msecs_to_jiffies(PD_T_VDM_BUSY));
+			mod_vdm_delayed_work(port, PD_T_VDM_BUSY);
 			return;
 		}
 		port->vdm_state =3D VDM_STATE_DONE;
@@ -1390,8 +1414,7 @@ static void vdm_run_state_machine(struct tcpm_port *p=
ort)
 			port->vdm_retries =3D 0;
 			port->vdm_state =3D VDM_STATE_BUSY;
 			timeout =3D vdm_ready_timeout(port->vdo_data[0]);
-			mod_delayed_work(port->wq, &port->vdm_state_machine,
-					 timeout);
+			mod_vdm_delayed_work(port, timeout);
 		}
 		break;
 	case VDM_STATE_WAIT_RSP_BUSY:
@@ -1420,10 +1443,9 @@ static void vdm_run_state_machine(struct tcpm_port *=
port)
 	}
 }
=20
-static void vdm_state_machine_work(struct work_struct *work)
+static void vdm_state_machine_work(struct kthread_work *work)
 {
-	struct tcpm_port *port =3D container_of(work, struct tcpm_port,
-					      vdm_state_machine.work);
+	struct tcpm_port *port =3D container_of(work, struct tcpm_port, vdm_state=
_machine);
 	enum vdm_states prev_state;
=20
 	mutex_lock(&port->lock);
@@ -1591,6 +1613,7 @@ static int tcpm_altmode_vdm(struct typec_altmode *alt=
mode,
 	struct tcpm_port *port =3D typec_altmode_get_drvdata(altmode);
=20
 	tcpm_queue_vdm_unlocked(port, header, data, count - 1);
+
 	return 0;
 }
=20
@@ -2005,7 +2028,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port =
*port,
 	}
 }
=20
-static void tcpm_pd_rx_handler(struct work_struct *work)
+static void tcpm_pd_rx_handler(struct kthread_work *work)
 {
 	struct pd_rx_event *event =3D container_of(work,
 						 struct pd_rx_event, work);
@@ -2067,10 +2090,10 @@ void tcpm_pd_receive(struct tcpm_port *port, const =
struct pd_message *msg)
 	if (!event)
 		return;
=20
-	INIT_WORK(&event->work, tcpm_pd_rx_handler);
+	kthread_init_work(&event->work, tcpm_pd_rx_handler);
 	event->port =3D port;
 	memcpy(&event->msg, msg, sizeof(*msg));
-	queue_work(port->wq, &event->work);
+	kthread_queue_work(port->wq, &event->work);
 }
 EXPORT_SYMBOL_GPL(tcpm_pd_receive);
=20
@@ -2123,9 +2146,9 @@ static bool tcpm_send_queued_message(struct tcpm_port=
 *port)
 	} while (port->queued_message !=3D PD_MSG_NONE);
=20
 	if (port->delayed_state !=3D INVALID_STATE) {
-		if (time_is_after_jiffies(port->delayed_runtime)) {
-			mod_delayed_work(port->wq, &port->state_machine,
-					 port->delayed_runtime - jiffies);
+		if (ktime_after(port->delayed_runtime, ktime_get())) {
+			mod_tcpm_delayed_work(port, ktime_to_ms(ktime_sub(port->delayed_runtime=
,
+									  ktime_get())));
 			return true;
 		}
 		port->delayed_state =3D INVALID_STATE;
@@ -3258,10 +3281,9 @@ static void run_state_machine(struct tcpm_port *port=
)
 	case SNK_DISCOVERY_DEBOUNCE_DONE:
 		if (!tcpm_port_is_disconnected(port) &&
 		    tcpm_port_is_sink(port) &&
-		    time_is_after_jiffies(port->delayed_runtime)) {
+		    ktime_after(port->delayed_runtime, ktime_get())) {
 			tcpm_set_state(port, SNK_DISCOVERY,
-				       jiffies_to_msecs(port->delayed_runtime -
-							jiffies));
+				       ktime_to_ms(ktime_sub(port->delayed_runtime, ktime_get())));
 			break;
 		}
 		tcpm_set_state(port, unattached_state(port), 0);
@@ -3656,10 +3678,9 @@ static void run_state_machine(struct tcpm_port *port=
)
 	}
 }
=20
-static void tcpm_state_machine_work(struct work_struct *work)
+static void tcpm_state_machine_work(struct kthread_work *work)
 {
-	struct tcpm_port *port =3D container_of(work, struct tcpm_port,
-					      state_machine.work);
+	struct tcpm_port *port =3D container_of(work, struct tcpm_port, state_mac=
hine);
 	enum tcpm_state prev_state;
=20
 	mutex_lock(&port->lock);
@@ -4019,7 +4040,7 @@ static void _tcpm_pd_hard_reset(struct tcpm_port *por=
t)
 		       0);
 }
=20
-static void tcpm_pd_event_handler(struct work_struct *work)
+static void tcpm_pd_event_handler(struct kthread_work *work)
 {
 	struct tcpm_port *port =3D container_of(work, struct tcpm_port,
 					      event_work);
@@ -4060,7 +4081,7 @@ void tcpm_cc_change(struct tcpm_port *port)
 	spin_lock(&port->pd_event_lock);
 	port->pd_events |=3D TCPM_CC_EVENT;
 	spin_unlock(&port->pd_event_lock);
-	queue_work(port->wq, &port->event_work);
+	kthread_queue_work(port->wq, &port->event_work);
 }
 EXPORT_SYMBOL_GPL(tcpm_cc_change);
=20
@@ -4069,7 +4090,7 @@ void tcpm_vbus_change(struct tcpm_port *port)
 	spin_lock(&port->pd_event_lock);
 	port->pd_events |=3D TCPM_VBUS_EVENT;
 	spin_unlock(&port->pd_event_lock);
-	queue_work(port->wq, &port->event_work);
+	kthread_queue_work(port->wq, &port->event_work);
 }
 EXPORT_SYMBOL_GPL(tcpm_vbus_change);
=20
@@ -4078,7 +4099,7 @@ void tcpm_pd_hard_reset(struct tcpm_port *port)
 	spin_lock(&port->pd_event_lock);
 	port->pd_events =3D TCPM_RESET_EVENT;
 	spin_unlock(&port->pd_event_lock);
-	queue_work(port->wq, &port->event_work);
+	kthread_queue_work(port->wq, &port->event_work);
 }
 EXPORT_SYMBOL_GPL(tcpm_pd_hard_reset);
=20
@@ -4786,6 +4807,27 @@ static int devm_tcpm_psy_register(struct tcpm_port *=
port)
 	return PTR_ERR_OR_ZERO(port->psy);
 }
=20
+static enum hrtimer_restart state_machine_timer_handler(struct hrtimer *ti=
mer)
+{
+	struct tcpm_port *port =3D container_of(timer, struct tcpm_port, state_ma=
chine_timer);
+
+	kthread_queue_work(port->wq, &port->state_machine);
+	return HRTIMER_NORESTART;
+}
+
+static enum hrtimer_restart vdm_state_machine_timer_handler(struct hrtimer=
 *timer)
+{
+	struct tcpm_port *port =3D container_of(timer, struct tcpm_port, vdm_stat=
e_machine_timer);
+
+	kthread_queue_work(port->wq, &port->vdm_state_machine);
+	return HRTIMER_NORESTART;
+}
+
+/* Priority just lower than default irq thread priority */
+static const struct sched_param param =3D {
+	.sched_priority =3D (MAX_USER_RT_PRIO / 2) + 1,
+};
+
 struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *=
tcpc)
 {
 	struct tcpm_port *port;
@@ -4807,12 +4849,18 @@ struct tcpm_port *tcpm_register_port(struct device =
*dev, struct tcpc_dev *tcpc)
 	mutex_init(&port->lock);
 	mutex_init(&port->swap_lock);
=20
-	port->wq =3D create_singlethread_workqueue(dev_name(dev));
-	if (!port->wq)
-		return ERR_PTR(-ENOMEM);
-	INIT_DELAYED_WORK(&port->state_machine, tcpm_state_machine_work);
-	INIT_DELAYED_WORK(&port->vdm_state_machine, vdm_state_machine_work);
-	INIT_WORK(&port->event_work, tcpm_pd_event_handler);
+	port->wq =3D kthread_create_worker(0, dev_name(dev));
+	if (IS_ERR(port->wq))
+		return ERR_CAST(port->wq);
+	sched_setscheduler(port->wq->task, SCHED_FIFO, &param);
+
+	kthread_init_work(&port->state_machine, tcpm_state_machine_work);
+	kthread_init_work(&port->vdm_state_machine, vdm_state_machine_work);
+	kthread_init_work(&port->event_work, tcpm_pd_event_handler);
+	hrtimer_init(&port->state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MODE_RE=
L);
+	port->state_machine_timer.function =3D state_machine_timer_handler;
+	hrtimer_init(&port->vdm_state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MOD=
E_REL);
+	port->vdm_state_machine_timer.function =3D vdm_state_machine_timer_handle=
r;
=20
 	spin_lock_init(&port->pd_event_lock);
=20
@@ -4864,7 +4912,7 @@ struct tcpm_port *tcpm_register_port(struct device *d=
ev, struct tcpc_dev *tcpc)
 	usb_role_switch_put(port->role_sw);
 out_destroy_wq:
 	tcpm_debugfs_exit(port);
-	destroy_workqueue(port->wq);
+	kthread_destroy_worker(port->wq);
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(tcpm_register_port);
@@ -4879,7 +4927,7 @@ void tcpm_unregister_port(struct tcpm_port *port)
 	typec_unregister_port(port->typec_port);
 	usb_role_switch_put(port->role_sw);
 	tcpm_debugfs_exit(port);
-	destroy_workqueue(port->wq);
+	kthread_destroy_worker(port->wq);
 }
 EXPORT_SYMBOL_GPL(tcpm_unregister_port);
=20
--=20
2.28.0.163.g6104cc2f0b6-goog

