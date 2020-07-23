Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2D4C433F1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB442065E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ieH0zm9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgGWGPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgGWGPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 02:15:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5B0C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 23:15:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k127so5291492ybk.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 23:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=60X5QyUGvefVkOt5YmbiXTqoEj97sTvbbbAurgF+8OI=;
        b=ieH0zm9Dlxe+drGn50xBWvX7XcttuvMz4P1RkBxTaBbIEgeIHE0Yzse96zR80u4VhK
         U+lqKtpq8jU9PYTtbJ4MEG5U4Tt1XdOTeD18qGl3XQ25qd3j7oMFiLB6KIo60SB8o/1i
         SZNDDuSrtFuDieMpfgvmzcIzXa8UbXFPWonAh3X3X9RUJEIX3KddDzJaG6s9wBGhORYn
         oUpSZ4sEQsILdUxWfYddUhKDdUigrDb341L74na0e3d8E/eO+XRvt+LS0LyYlFXkGVQj
         xDWzj7KCpHH8KDzxgh3PXbi4NXQmuX2y2uRKFiQRDOvcji3mcTdz+rysQK4m3vTKmKyr
         wLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=60X5QyUGvefVkOt5YmbiXTqoEj97sTvbbbAurgF+8OI=;
        b=r9xaxxBPxZh4ZKwVnvwHmOAJPPbIosZ/vS1bjbJZ9ssLak7+uifsuh9ZxuZ8YSBexr
         WL/mUAod1H8ryUfXrDywUCXfG+ulA6lzOLqBAM9kDfCAHtHfMOHP6aIM6E/MHjXWiJu3
         PUn/ODzHzKGssT0Dk8io10Lpcc09ldp11179QTnp8PIXSyG2Bsj2Wdhl0bikWkf42CfY
         /QkhCkiGUWNndMV5TfXRgUZXAesM+wUcOg6J9n7AgY/JHJSDV7pDDElstKm4oRSsL/pP
         c59h52IBm3+/DMjz2hHUs4+gzSsgcM/u0JtMCQrqlu3KFX9eQ3NQUEMpW8q2r1qQl+HB
         3cCg==
X-Gm-Message-State: AOAM530Th75Bs9FC6lvJWKhfsPLYwUGoafRhJIZSer8rT5mI2FxBXlbs
        pSNYLY7mCOTfJeqiE+h2rvJAdmH5gLE=
X-Google-Smtp-Source: ABdhPJwvGK3fQ+Uf04ovB/ElzdZiRE/YWJhbmMXzMRJobrKPWnUiZfjo5/40263G4KW1hzdhwfZibPbeTmo=
X-Received: by 2002:a25:c483:: with SMTP id u125mr4566730ybf.194.1595484930405;
 Wed, 22 Jul 2020 23:15:30 -0700 (PDT)
Date:   Wed, 22 Jul 2020 23:15:24 -0700
Message-Id: <20200723061524.1930372-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH] usb: typec: tcpm: Migrate workqueue to RT priority for
 processing events
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
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
---
 drivers/usb/typec/tcpm/tcpm.c | 138 ++++++++++++++++++++++------------
 1 file changed, 90 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index ff1cbd2147ca8a..0dcab6f08f8587 100644
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
@@ -195,7 +198,7 @@ struct tcpm_port {
 	struct device *dev;
=20
 	struct mutex lock;		/* tcpm state machine lock */
-	struct workqueue_struct *wq;
+	struct kthread_worker *wq;
=20
 	struct typec_capability typec_caps;
 	struct typec_port *typec_port;
@@ -239,15 +242,17 @@ struct tcpm_port {
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
@@ -332,7 +337,7 @@ struct tcpm_port {
 };
=20
 struct pd_rx_event {
-	struct work_struct work;
+	struct kthread_work work;
 	struct tcpm_port *port;
 	struct pd_message msg;
 };
@@ -906,6 +911,25 @@ static int tcpm_pd_send_sink_caps(struct tcpm_port *po=
rt)
 	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
 }
=20
+static void mod_tcpm_delayed_work(struct tcpm_port *port, unsigned int del=
ay_ms)
+{
+	hrtimer_cancel(&port->state_machine_timer);
+	if (delay_ms)
+		hrtimer_start(&port->state_machine_timer, ms_to_ktime(delay_ms), HRTIMER=
_MODE_REL);
+	else
+		kthread_queue_work(port->wq, &port->state_machine);
+}
+
+static void mod_vdm_delayed_work(struct tcpm_port *port, unsigned int dela=
y_ms)
+{
+	hrtimer_cancel(&port->vdm_state_machine_timer);
+	if (delay_ms)
+		hrtimer_start(&port->vdm_state_machine_timer, ms_to_ktime(delay_ms),
+			      HRTIMER_MODE_REL);
+	else
+		kthread_queue_work(port->wq, &port->vdm_state_machine);
+}
+
 static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
 			   unsigned int delay_ms)
 {
@@ -914,9 +938,8 @@ static void tcpm_set_state(struct tcpm_port *port, enum=
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
@@ -931,7 +954,7 @@ static void tcpm_set_state(struct tcpm_port *port, enum=
 tcpm_state state,
 		 * machine.
 		 */
 		if (!port->state_machine_running)
-			mod_delayed_work(port->wq, &port->state_machine, 0);
+			mod_tcpm_delayed_work(port, 0);
 	}
 }
=20
@@ -952,7 +975,7 @@ static void tcpm_queue_message(struct tcpm_port *port,
 			       enum pd_msg_request message)
 {
 	port->queued_message =3D message;
-	mod_delayed_work(port->wq, &port->state_machine, 0);
+	mod_tcpm_delayed_work(port, 0);
 }
=20
 /*
@@ -1238,8 +1261,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port =
*port,
 			port->vdm_state =3D VDM_STATE_WAIT_RSP_BUSY;
 			port->vdo_retry =3D (p0 & ~VDO_CMDT_MASK) |
 				CMDT_INIT;
-			mod_delayed_work(port->wq, &port->vdm_state_machine,
-					 msecs_to_jiffies(PD_T_VDM_BUSY));
+			mod_vdm_delayed_work(port, PD_T_VDM_BUSY);
 			return;
 		}
 		port->vdm_state =3D VDM_STATE_DONE;
@@ -1250,7 +1272,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port =
*port,
=20
 	if (rlen > 0) {
 		tcpm_queue_vdm(port, response[0], &response[1], rlen - 1);
-		mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+		mod_vdm_delayed_work(port, 0);
 	}
 }
=20
@@ -1267,7 +1289,7 @@ static void tcpm_send_vdm(struct tcpm_port *port, u32=
 vid, int cmd,
 			1 : (PD_VDO_CMD(cmd) <=3D CMD_ATTENTION), cmd);
 	tcpm_queue_vdm(port, header, data, count);
=20
-	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mod_vdm_delayed_work(port, 0);
 }
=20
 static unsigned int vdm_ready_timeout(u32 vdm_hdr)
@@ -1334,8 +1356,7 @@ static void vdm_run_state_machine(struct tcpm_port *p=
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
@@ -1364,10 +1385,9 @@ static void vdm_run_state_machine(struct tcpm_port *=
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
@@ -1515,7 +1535,7 @@ static int tcpm_altmode_enter(struct typec_altmode *a=
ltmode, u32 *vdo)
 	header |=3D VDO_OPOS(altmode->mode);
=20
 	tcpm_queue_vdm(port, header, vdo, vdo ? 1 : 0);
-	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mod_vdm_delayed_work(port, 0);
 	mutex_unlock(&port->lock);
=20
 	return 0;
@@ -1531,7 +1551,7 @@ static int tcpm_altmode_exit(struct typec_altmode *al=
tmode)
 	header |=3D VDO_OPOS(altmode->mode);
=20
 	tcpm_queue_vdm(port, header, NULL, 0);
-	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mod_vdm_delayed_work(port, 0);
 	mutex_unlock(&port->lock);
=20
 	return 0;
@@ -1544,7 +1564,7 @@ static int tcpm_altmode_vdm(struct typec_altmode *alt=
mode,
=20
 	mutex_lock(&port->lock);
 	tcpm_queue_vdm(port, header, data, count - 1);
-	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mod_vdm_delayed_work(port, 0);
 	mutex_unlock(&port->lock);
=20
 	return 0;
@@ -1961,7 +1981,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port =
*port,
 	}
 }
=20
-static void tcpm_pd_rx_handler(struct work_struct *work)
+static void tcpm_pd_rx_handler(struct kthread_work *work)
 {
 	struct pd_rx_event *event =3D container_of(work,
 						 struct pd_rx_event, work);
@@ -2023,10 +2043,10 @@ void tcpm_pd_receive(struct tcpm_port *port, const =
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
@@ -2079,9 +2099,9 @@ static bool tcpm_send_queued_message(struct tcpm_port=
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
@@ -3214,10 +3234,9 @@ static void run_state_machine(struct tcpm_port *port=
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
@@ -3612,10 +3631,9 @@ static void run_state_machine(struct tcpm_port *port=
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
@@ -3975,7 +3993,7 @@ static void _tcpm_pd_hard_reset(struct tcpm_port *por=
t)
 		       0);
 }
=20
-static void tcpm_pd_event_handler(struct work_struct *work)
+static void tcpm_pd_event_handler(struct kthread_work *work)
 {
 	struct tcpm_port *port =3D container_of(work, struct tcpm_port,
 					      event_work);
@@ -4016,7 +4034,7 @@ void tcpm_cc_change(struct tcpm_port *port)
 	spin_lock(&port->pd_event_lock);
 	port->pd_events |=3D TCPM_CC_EVENT;
 	spin_unlock(&port->pd_event_lock);
-	queue_work(port->wq, &port->event_work);
+	kthread_queue_work(port->wq, &port->event_work);
 }
 EXPORT_SYMBOL_GPL(tcpm_cc_change);
=20
@@ -4025,7 +4043,7 @@ void tcpm_vbus_change(struct tcpm_port *port)
 	spin_lock(&port->pd_event_lock);
 	port->pd_events |=3D TCPM_VBUS_EVENT;
 	spin_unlock(&port->pd_event_lock);
-	queue_work(port->wq, &port->event_work);
+	kthread_queue_work(port->wq, &port->event_work);
 }
 EXPORT_SYMBOL_GPL(tcpm_vbus_change);
=20
@@ -4034,7 +4052,7 @@ void tcpm_pd_hard_reset(struct tcpm_port *port)
 	spin_lock(&port->pd_event_lock);
 	port->pd_events =3D TCPM_RESET_EVENT;
 	spin_unlock(&port->pd_event_lock);
-	queue_work(port->wq, &port->event_work);
+	kthread_queue_work(port->wq, &port->event_work);
 }
 EXPORT_SYMBOL_GPL(tcpm_pd_hard_reset);
=20
@@ -4742,10 +4760,28 @@ static int devm_tcpm_psy_register(struct tcpm_port =
*port)
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
 struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *=
tcpc)
 {
 	struct tcpm_port *port;
 	int err;
+	/* Priority just lower than default irq thread priority */
+	struct sched_param param =3D {.sched_priority =3D (MAX_USER_RT_PRIO / 2) =
+ 1,};
=20
 	if (!dev || !tcpc ||
 	    !tcpc->get_vbus || !tcpc->set_cc || !tcpc->get_cc ||
@@ -4763,12 +4799,18 @@ struct tcpm_port *tcpm_register_port(struct device =
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
+		return (struct tcpm_port *)port->wq;
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
@@ -4820,7 +4862,7 @@ struct tcpm_port *tcpm_register_port(struct device *d=
ev, struct tcpc_dev *tcpc)
 	usb_role_switch_put(port->role_sw);
 out_destroy_wq:
 	tcpm_debugfs_exit(port);
-	destroy_workqueue(port->wq);
+	kthread_destroy_worker(port->wq);
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(tcpm_register_port);
@@ -4835,7 +4877,7 @@ void tcpm_unregister_port(struct tcpm_port *port)
 	typec_unregister_port(port->typec_port);
 	usb_role_switch_put(port->role_sw);
 	tcpm_debugfs_exit(port);
-	destroy_workqueue(port->wq);
+	kthread_destroy_worker(port->wq);
 }
 EXPORT_SYMBOL_GPL(tcpm_unregister_port);
=20
--=20
2.28.0.rc0.105.gf9edc3c819-goog

