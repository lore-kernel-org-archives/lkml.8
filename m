Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D80C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E27A2065E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPVQGwIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgGXCF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 22:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgGXCF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 22:05:57 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52BCC0619E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 19:05:56 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id t18so4648176plo.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 19:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=5aq7lvgbPI0yY0ktvMY4HSJk6lzevca6F80kF3dvzrE=;
        b=jPVQGwIg0GiX4KtlyMpzJwDgm/r7Xdmu0P2fnQiNpQyVh7Tj1QJCMf3mBwwEq8UQhN
         2ZhgheD7xAwJwEkp1xdB51RpbgMeUfpgtr1iOgC7rqiJWNbJ6JENcJ4zpaURAnJWLcCO
         EccFaSIqQFAC/lrut0Er0SzepwM9+UY3ucU3GM4f2Ja3CJbeeJtS2pyd8zZjX2VQGf73
         r+PEKNJWcIvqVi6To8CqJpbbQc3r4jZZsNRzKDhJ46zjI1VAcwrVE3oivJ952B88PEht
         NmR6LQyP1+nFZnYrY3vdwk+HoJYrMH8lFiTbFi0a5Ff59WydC2I/e2oJHEyq/nFbCbdu
         u8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=5aq7lvgbPI0yY0ktvMY4HSJk6lzevca6F80kF3dvzrE=;
        b=B6CRHiSTpQLLyz7Ofr2a7Zjub9imgPzAGcxT/Jw5SjwkS+NbnNukMGY3/ePa8/MHNZ
         bVm49hi9qvK2RGs98h0U7hPSUyXEkziZRrar9pMNyurX22Iqvlt7IanSxWWKaA1NoByQ
         DMiKkK3taWjcEH0bNFUygx32EgZIG6lp0Tx8cmOr9KRa8A2thsV7KNtOCh76YCKj8X9Y
         TSiW5brs86K2eBqtY26mJU4CpMLw4CSOH4veeMby5r4ES1dvxwEFRwvNRsQ3ZKDR4qhP
         icSioS2eLDnvLzB0Muz8dXWqKAtDh9KwAE6rcSi5L2qA5SdoTlIL2HkbD+v8d54+aKhs
         7IIQ==
X-Gm-Message-State: AOAM531SFIQQlIwXyROkliE1Sg96BVoskJzfOuhH3SYOs0lHWa2/wywc
        0MEUZrOY32JUj7zQah8Wn2CWZxN4/Ys=
X-Google-Smtp-Source: ABdhPJx0GFKrM7N8cz9nMm4kBTbS4cxBB0lCJYzrs8BnwiLomuLfU/NmtUZkYyePvFGlfl/or9P/NjcMnvk=
X-Received: by 2002:a17:90a:bd8b:: with SMTP id z11mr1440845pjr.0.1595556355812;
 Thu, 23 Jul 2020 19:05:55 -0700 (PDT)
Date:   Thu, 23 Jul 2020 19:05:51 -0700
Message-Id: <20200724020551.2737376-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v2] usb: typec: tcpm: Migrate workqueue to RT priority for
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

Changes since v1:(Guenter's suggestions)
- Remove redundant call to hrtimer_cancel while calling
  hrtimer_start.

---
 drivers/usb/typec/tcpm/tcpm.c | 140 ++++++++++++++++++++++------------
 1 file changed, 92 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index ff1cbd2147ca8a..fa9002944dc766 100644
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
@@ -906,6 +911,27 @@ static int tcpm_pd_send_sink_caps(struct tcpm_port *po=
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
@@ -914,9 +940,8 @@ static void tcpm_set_state(struct tcpm_port *port, enum=
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
@@ -931,7 +956,7 @@ static void tcpm_set_state(struct tcpm_port *port, enum=
 tcpm_state state,
 		 * machine.
 		 */
 		if (!port->state_machine_running)
-			mod_delayed_work(port->wq, &port->state_machine, 0);
+			mod_tcpm_delayed_work(port, 0);
 	}
 }
=20
@@ -952,7 +977,7 @@ static void tcpm_queue_message(struct tcpm_port *port,
 			       enum pd_msg_request message)
 {
 	port->queued_message =3D message;
-	mod_delayed_work(port->wq, &port->state_machine, 0);
+	mod_tcpm_delayed_work(port, 0);
 }
=20
 /*
@@ -1238,8 +1263,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port =
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
@@ -1250,7 +1274,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port =
*port,
=20
 	if (rlen > 0) {
 		tcpm_queue_vdm(port, response[0], &response[1], rlen - 1);
-		mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+		mod_vdm_delayed_work(port, 0);
 	}
 }
=20
@@ -1267,7 +1291,7 @@ static void tcpm_send_vdm(struct tcpm_port *port, u32=
 vid, int cmd,
 			1 : (PD_VDO_CMD(cmd) <=3D CMD_ATTENTION), cmd);
 	tcpm_queue_vdm(port, header, data, count);
=20
-	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mod_vdm_delayed_work(port, 0);
 }
=20
 static unsigned int vdm_ready_timeout(u32 vdm_hdr)
@@ -1334,8 +1358,7 @@ static void vdm_run_state_machine(struct tcpm_port *p=
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
@@ -1364,10 +1387,9 @@ static void vdm_run_state_machine(struct tcpm_port *=
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
@@ -1515,7 +1537,7 @@ static int tcpm_altmode_enter(struct typec_altmode *a=
ltmode, u32 *vdo)
 	header |=3D VDO_OPOS(altmode->mode);
=20
 	tcpm_queue_vdm(port, header, vdo, vdo ? 1 : 0);
-	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mod_vdm_delayed_work(port, 0);
 	mutex_unlock(&port->lock);
=20
 	return 0;
@@ -1531,7 +1553,7 @@ static int tcpm_altmode_exit(struct typec_altmode *al=
tmode)
 	header |=3D VDO_OPOS(altmode->mode);
=20
 	tcpm_queue_vdm(port, header, NULL, 0);
-	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mod_vdm_delayed_work(port, 0);
 	mutex_unlock(&port->lock);
=20
 	return 0;
@@ -1544,7 +1566,7 @@ static int tcpm_altmode_vdm(struct typec_altmode *alt=
mode,
=20
 	mutex_lock(&port->lock);
 	tcpm_queue_vdm(port, header, data, count - 1);
-	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mod_vdm_delayed_work(port, 0);
 	mutex_unlock(&port->lock);
=20
 	return 0;
@@ -1961,7 +1983,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port =
*port,
 	}
 }
=20
-static void tcpm_pd_rx_handler(struct work_struct *work)
+static void tcpm_pd_rx_handler(struct kthread_work *work)
 {
 	struct pd_rx_event *event =3D container_of(work,
 						 struct pd_rx_event, work);
@@ -2023,10 +2045,10 @@ void tcpm_pd_receive(struct tcpm_port *port, const =
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
@@ -2079,9 +2101,9 @@ static bool tcpm_send_queued_message(struct tcpm_port=
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
@@ -3214,10 +3236,9 @@ static void run_state_machine(struct tcpm_port *port=
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
@@ -3612,10 +3633,9 @@ static void run_state_machine(struct tcpm_port *port=
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
@@ -3975,7 +3995,7 @@ static void _tcpm_pd_hard_reset(struct tcpm_port *por=
t)
 		       0);
 }
=20
-static void tcpm_pd_event_handler(struct work_struct *work)
+static void tcpm_pd_event_handler(struct kthread_work *work)
 {
 	struct tcpm_port *port =3D container_of(work, struct tcpm_port,
 					      event_work);
@@ -4016,7 +4036,7 @@ void tcpm_cc_change(struct tcpm_port *port)
 	spin_lock(&port->pd_event_lock);
 	port->pd_events |=3D TCPM_CC_EVENT;
 	spin_unlock(&port->pd_event_lock);
-	queue_work(port->wq, &port->event_work);
+	kthread_queue_work(port->wq, &port->event_work);
 }
 EXPORT_SYMBOL_GPL(tcpm_cc_change);
=20
@@ -4025,7 +4045,7 @@ void tcpm_vbus_change(struct tcpm_port *port)
 	spin_lock(&port->pd_event_lock);
 	port->pd_events |=3D TCPM_VBUS_EVENT;
 	spin_unlock(&port->pd_event_lock);
-	queue_work(port->wq, &port->event_work);
+	kthread_queue_work(port->wq, &port->event_work);
 }
 EXPORT_SYMBOL_GPL(tcpm_vbus_change);
=20
@@ -4034,7 +4054,7 @@ void tcpm_pd_hard_reset(struct tcpm_port *port)
 	spin_lock(&port->pd_event_lock);
 	port->pd_events =3D TCPM_RESET_EVENT;
 	spin_unlock(&port->pd_event_lock);
-	queue_work(port->wq, &port->event_work);
+	kthread_queue_work(port->wq, &port->event_work);
 }
 EXPORT_SYMBOL_GPL(tcpm_pd_hard_reset);
=20
@@ -4742,10 +4762,28 @@ static int devm_tcpm_psy_register(struct tcpm_port =
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
@@ -4763,12 +4801,18 @@ struct tcpm_port *tcpm_register_port(struct device =
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
@@ -4820,7 +4864,7 @@ struct tcpm_port *tcpm_register_port(struct device *d=
ev, struct tcpc_dev *tcpc)
 	usb_role_switch_put(port->role_sw);
 out_destroy_wq:
 	tcpm_debugfs_exit(port);
-	destroy_workqueue(port->wq);
+	kthread_destroy_worker(port->wq);
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(tcpm_register_port);
@@ -4835,7 +4879,7 @@ void tcpm_unregister_port(struct tcpm_port *port)
 	typec_unregister_port(port->typec_port);
 	usb_role_switch_put(port->role_sw);
 	tcpm_debugfs_exit(port);
-	destroy_workqueue(port->wq);
+	kthread_destroy_worker(port->wq);
 }
 EXPORT_SYMBOL_GPL(tcpm_unregister_port);
=20
--=20
2.28.0.rc0.142.g3c755180ce-goog

