Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10520C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0ED206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbgGaMac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:30:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:13693 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732980AbgGaMac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:30:32 -0400
IronPort-SDR: rv+gDe4Z8wprVoJaefQZ26Dhs/LskvsI3FLoaymyFYfagwPTGHl49Yqm2oM7QtGqg3+IZUUXq0
 4tBcZ6QoHWEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="213298871"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="213298871"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 05:30:31 -0700
IronPort-SDR: /dTyqMK3NiE9IjeBlvljtrZwG3p+vILIzUV4WQhUIfDake06T9fNZUX21uH2NPC91tLeFBQwvT
 e5JdOCws/EPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="395295016"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 31 Jul 2020 05:30:28 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 31 Jul 2020 15:30:27 +0300
Date:   Fri, 31 Jul 2020 15:30:27 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5] usb: typec: tcpm: Migrate workqueue to RT priority
 for processing events
Message-ID: <20200731123027.GP883641@kuha.fi.intel.com>
References: <20200731065830.3744049-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200731065830.3744049-1-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 11:58:30PM -0700, Badhri Jagan Sridharan wrote:
> "tReceiverResponse 15 ms Section 6.6.2
> The receiver of a Message requiring a response Shall respond
> within tReceiverResponse in order to ensure that the
> sender’s SenderResponseTimer does not expire."
> 
> When the cpu complex is busy running other lower priority
> work items, TCPM's work queue sometimes does not get scheduled
> on time to meet the above requirement from the spec.
> Moving to kthread_work apis to run with real time priority.
> Just lower than the default threaded irq priority,
> MAX_USER_RT_PRIO/2 + 1. (Higher number implies lower priority).
> 
> Further, as observed in 1ff688209e2e, moving to hrtimers to
> overcome scheduling latency while scheduling the delayed work.
> 
> TCPM has three work streams:
> 1. tcpm_state_machine
> 2. vdm_state_machine
> 3. event_work
> 
> tcpm_state_machine and vdm_state_machine both schedule work in
> future i.e. delayed. Hence each of them have a corresponding
> hrtimer, tcpm_state_machine_timer & vdm_state_machine_timer.
> 
> When work is queued right away kthread_queue_work is used.
> Else, the relevant timer is programmed and made to queue
> the kthread_work upon timer expiry.
> 
> kthread_create_worker only creates one kthread worker thread,
> hence single threadedness of workqueue is retained.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v1:(Guenter's suggestions)
> - Remove redundant call to hrtimer_cancel while calling
>   hrtimer_start.
> 
> Changes since v2:(Greg KH's suggestions)
> - Rebase usb-next TOT.
>   633198cd2945b7 (HEAD -> usb-next-1) usb: typec: tcpm: Migrate workqueue to RT priority for processing events
>   fa56dd9152ef95 (origin/usb-next) Merge tag 'usb-serial-5.9-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next
>   25252919a1050e xhci: dbgtty: Make some functions static
>   b0e02550346e67 xhci: dbc: Make function xhci_dbc_ring_alloc() static
>   ca6377900974c3 Revert "usb: dwc2: override PHY input signals with usb role switch support"
>   09df709cb5aeb2 Revert "usb: dwc2: don't use ID/Vbus detection if usb-role-switch on STM32MP15 SoCs"
>   17a82716587e9d USB: iowarrior: fix up report size handling for some devices
>   e98ba8cc3f8a89 Merge tag 'usb-for-v5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
>   c97793089b11f7 Merge 5.8-rc7 into usb-next
>   92ed301919932f (tag: v5.8-rc7, origin/usb-linus, origin/main) Linux 5.8-rc7
> 
> - Added reviewed-by tags.
> 
> Changes since v3:(Greg KH's suggestions)
> - Rebase usb-next TOT
>   Resolve merge conflict with "usb: typec: tcpm: Move mod_delayed_work(&port->vdm_state_machine) call into tcpm_queue_vdm()"
> 
>   b8f151122648b0 (HEAD -> usb-next-1) usb: typec: tcpm: Migrate workqueue to RT priority for processing events
>   ab4dc051d7b39c (origin/usb-testing, origin/usb-next) usb: mtu3: simplify mtu3_req_complete()
>   f1e51e99ed498d usb: mtu3: clear dual mode of u3port when disable device
>   54402373c45e44 usb: mtu3: use MTU3_EP_WEDGE flag
>   bf77804b1cbdeb usb: mtu3: remove useless member @busy in mtu3_ep struct
>   ba428976a8827f usb: mtu3: remove repeated error log
>   dc4c1aa7eae99d usb: mtu3: add ->udc_set_speed()
>   1258450ef38af7 usb: mtu3: introduce a funtion to check maximum speed
> 
> Changes since v4:
>  - Constantify and fix sched_param (Heikki & Guenter suggestion)
>  - Change applied so added Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>  - Move to ERR_CAST when wq fails to setup
> ---
> 
> drivers/usb/typec/tcpm/tcpm.c | 136 +++++++++++++++++++++++-----------
>  1 file changed, 92 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3ef37202ee3757..d1fc8abaedbc7e 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -8,8 +8,10 @@
>  #include <linux/completion.h>
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
> +#include <linux/hrtimer.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> +#include <linux/kthread.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/power_supply.h>
> @@ -28,7 +30,8 @@
>  #include <linux/usb/role.h>
>  #include <linux/usb/tcpm.h>
>  #include <linux/usb/typec_altmode.h>
> -#include <linux/workqueue.h>
> +
> +#include <uapi/linux/sched/types.h>
>  
>  #define FOREACH_STATE(S)			\
>  	S(INVALID_STATE),			\
> @@ -203,7 +206,7 @@ struct tcpm_port {
>  	struct device *dev;
>  
>  	struct mutex lock;		/* tcpm state machine lock */
> -	struct workqueue_struct *wq;
> +	struct kthread_worker *wq;
>  
>  	struct typec_capability typec_caps;
>  	struct typec_port *typec_port;
> @@ -247,15 +250,17 @@ struct tcpm_port {
>  	enum tcpm_state prev_state;
>  	enum tcpm_state state;
>  	enum tcpm_state delayed_state;
> -	unsigned long delayed_runtime;
> +	ktime_t delayed_runtime;
>  	unsigned long delay_ms;
>  
>  	spinlock_t pd_event_lock;
>  	u32 pd_events;
>  
> -	struct work_struct event_work;
> -	struct delayed_work state_machine;
> -	struct delayed_work vdm_state_machine;
> +	struct kthread_work event_work;
> +	struct hrtimer state_machine_timer;
> +	struct kthread_work state_machine;
> +	struct hrtimer vdm_state_machine_timer;
> +	struct kthread_work vdm_state_machine;
>  	bool state_machine_running;
>  
>  	struct completion tx_complete;
> @@ -340,7 +345,7 @@ struct tcpm_port {
>  };
>  
>  struct pd_rx_event {
> -	struct work_struct work;
> +	struct kthread_work work;
>  	struct tcpm_port *port;
>  	struct pd_message msg;
>  };
> @@ -914,6 +919,27 @@ static int tcpm_pd_send_sink_caps(struct tcpm_port *port)
>  	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
>  }
>  
> +static void mod_tcpm_delayed_work(struct tcpm_port *port, unsigned int delay_ms)
> +{
> +	if (delay_ms) {
> +		hrtimer_start(&port->state_machine_timer, ms_to_ktime(delay_ms), HRTIMER_MODE_REL);
> +	} else {
> +		hrtimer_cancel(&port->state_machine_timer);
> +		kthread_queue_work(port->wq, &port->state_machine);
> +	}
> +}
> +
> +static void mod_vdm_delayed_work(struct tcpm_port *port, unsigned int delay_ms)
> +{
> +	if (delay_ms) {
> +		hrtimer_start(&port->vdm_state_machine_timer, ms_to_ktime(delay_ms),
> +			      HRTIMER_MODE_REL);
> +	} else {
> +		hrtimer_cancel(&port->vdm_state_machine_timer);
> +		kthread_queue_work(port->wq, &port->vdm_state_machine);
> +	}
> +}
> +
>  static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
>  			   unsigned int delay_ms)
>  {
> @@ -922,9 +948,8 @@ static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
>  			 tcpm_states[port->state], tcpm_states[state],
>  			 delay_ms);
>  		port->delayed_state = state;
> -		mod_delayed_work(port->wq, &port->state_machine,
> -				 msecs_to_jiffies(delay_ms));
> -		port->delayed_runtime = jiffies + msecs_to_jiffies(delay_ms);
> +		mod_tcpm_delayed_work(port, delay_ms);
> +		port->delayed_runtime = ktime_add(ktime_get(), ms_to_ktime(delay_ms));
>  		port->delay_ms = delay_ms;
>  	} else {
>  		tcpm_log(port, "state change %s -> %s",
> @@ -939,7 +964,7 @@ static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
>  		 * machine.
>  		 */
>  		if (!port->state_machine_running)
> -			mod_delayed_work(port->wq, &port->state_machine, 0);
> +			mod_tcpm_delayed_work(port, 0);
>  	}
>  }
>  
> @@ -960,7 +985,7 @@ static void tcpm_queue_message(struct tcpm_port *port,
>  			       enum pd_msg_request message)
>  {
>  	port->queued_message = message;
> -	mod_delayed_work(port->wq, &port->state_machine, 0);
> +	mod_tcpm_delayed_work(port, 0);
>  }
>  
>  /*
> @@ -981,7 +1006,7 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
>  	port->vdm_retries = 0;
>  	port->vdm_state = VDM_STATE_READY;
>  
> -	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> +	mod_vdm_delayed_work(port, 0);
>  }
>  
>  static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
> @@ -1244,8 +1269,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  			port->vdm_state = VDM_STATE_WAIT_RSP_BUSY;
>  			port->vdo_retry = (p[0] & ~VDO_CMDT_MASK) |
>  				CMDT_INIT;
> -			mod_delayed_work(port->wq, &port->vdm_state_machine,
> -					 msecs_to_jiffies(PD_T_VDM_BUSY));
> +			mod_vdm_delayed_work(port, PD_T_VDM_BUSY);
>  			return;
>  		}
>  		port->vdm_state = VDM_STATE_DONE;
> @@ -1390,8 +1414,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  			port->vdm_retries = 0;
>  			port->vdm_state = VDM_STATE_BUSY;
>  			timeout = vdm_ready_timeout(port->vdo_data[0]);
> -			mod_delayed_work(port->wq, &port->vdm_state_machine,
> -					 timeout);
> +			mod_vdm_delayed_work(port, timeout);
>  		}
>  		break;
>  	case VDM_STATE_WAIT_RSP_BUSY:
> @@ -1420,10 +1443,9 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  	}
>  }
>  
> -static void vdm_state_machine_work(struct work_struct *work)
> +static void vdm_state_machine_work(struct kthread_work *work)
>  {
> -	struct tcpm_port *port = container_of(work, struct tcpm_port,
> -					      vdm_state_machine.work);
> +	struct tcpm_port *port = container_of(work, struct tcpm_port, vdm_state_machine);
>  	enum vdm_states prev_state;
>  
>  	mutex_lock(&port->lock);
> @@ -1591,6 +1613,7 @@ static int tcpm_altmode_vdm(struct typec_altmode *altmode,
>  	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
>  
>  	tcpm_queue_vdm_unlocked(port, header, data, count - 1);
> +
>  	return 0;
>  }
>  
> @@ -2005,7 +2028,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
>  	}
>  }
>  
> -static void tcpm_pd_rx_handler(struct work_struct *work)
> +static void tcpm_pd_rx_handler(struct kthread_work *work)
>  {
>  	struct pd_rx_event *event = container_of(work,
>  						 struct pd_rx_event, work);
> @@ -2067,10 +2090,10 @@ void tcpm_pd_receive(struct tcpm_port *port, const struct pd_message *msg)
>  	if (!event)
>  		return;
>  
> -	INIT_WORK(&event->work, tcpm_pd_rx_handler);
> +	kthread_init_work(&event->work, tcpm_pd_rx_handler);
>  	event->port = port;
>  	memcpy(&event->msg, msg, sizeof(*msg));
> -	queue_work(port->wq, &event->work);
> +	kthread_queue_work(port->wq, &event->work);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_pd_receive);
>  
> @@ -2123,9 +2146,9 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
>  	} while (port->queued_message != PD_MSG_NONE);
>  
>  	if (port->delayed_state != INVALID_STATE) {
> -		if (time_is_after_jiffies(port->delayed_runtime)) {
> -			mod_delayed_work(port->wq, &port->state_machine,
> -					 port->delayed_runtime - jiffies);
> +		if (ktime_after(port->delayed_runtime, ktime_get())) {
> +			mod_tcpm_delayed_work(port, ktime_to_ms(ktime_sub(port->delayed_runtime,
> +									  ktime_get())));
>  			return true;
>  		}
>  		port->delayed_state = INVALID_STATE;
> @@ -3258,10 +3281,9 @@ static void run_state_machine(struct tcpm_port *port)
>  	case SNK_DISCOVERY_DEBOUNCE_DONE:
>  		if (!tcpm_port_is_disconnected(port) &&
>  		    tcpm_port_is_sink(port) &&
> -		    time_is_after_jiffies(port->delayed_runtime)) {
> +		    ktime_after(port->delayed_runtime, ktime_get())) {
>  			tcpm_set_state(port, SNK_DISCOVERY,
> -				       jiffies_to_msecs(port->delayed_runtime -
> -							jiffies));
> +				       ktime_to_ms(ktime_sub(port->delayed_runtime, ktime_get())));
>  			break;
>  		}
>  		tcpm_set_state(port, unattached_state(port), 0);
> @@ -3656,10 +3678,9 @@ static void run_state_machine(struct tcpm_port *port)
>  	}
>  }
>  
> -static void tcpm_state_machine_work(struct work_struct *work)
> +static void tcpm_state_machine_work(struct kthread_work *work)
>  {
> -	struct tcpm_port *port = container_of(work, struct tcpm_port,
> -					      state_machine.work);
> +	struct tcpm_port *port = container_of(work, struct tcpm_port, state_machine);
>  	enum tcpm_state prev_state;
>  
>  	mutex_lock(&port->lock);
> @@ -4019,7 +4040,7 @@ static void _tcpm_pd_hard_reset(struct tcpm_port *port)
>  		       0);
>  }
>  
> -static void tcpm_pd_event_handler(struct work_struct *work)
> +static void tcpm_pd_event_handler(struct kthread_work *work)
>  {
>  	struct tcpm_port *port = container_of(work, struct tcpm_port,
>  					      event_work);
> @@ -4060,7 +4081,7 @@ void tcpm_cc_change(struct tcpm_port *port)
>  	spin_lock(&port->pd_event_lock);
>  	port->pd_events |= TCPM_CC_EVENT;
>  	spin_unlock(&port->pd_event_lock);
> -	queue_work(port->wq, &port->event_work);
> +	kthread_queue_work(port->wq, &port->event_work);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_cc_change);
>  
> @@ -4069,7 +4090,7 @@ void tcpm_vbus_change(struct tcpm_port *port)
>  	spin_lock(&port->pd_event_lock);
>  	port->pd_events |= TCPM_VBUS_EVENT;
>  	spin_unlock(&port->pd_event_lock);
> -	queue_work(port->wq, &port->event_work);
> +	kthread_queue_work(port->wq, &port->event_work);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_vbus_change);
>  
> @@ -4078,7 +4099,7 @@ void tcpm_pd_hard_reset(struct tcpm_port *port)
>  	spin_lock(&port->pd_event_lock);
>  	port->pd_events = TCPM_RESET_EVENT;
>  	spin_unlock(&port->pd_event_lock);
> -	queue_work(port->wq, &port->event_work);
> +	kthread_queue_work(port->wq, &port->event_work);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_pd_hard_reset);
>  
> @@ -4786,6 +4807,27 @@ static int devm_tcpm_psy_register(struct tcpm_port *port)
>  	return PTR_ERR_OR_ZERO(port->psy);
>  }
>  
> +static enum hrtimer_restart state_machine_timer_handler(struct hrtimer *timer)
> +{
> +	struct tcpm_port *port = container_of(timer, struct tcpm_port, state_machine_timer);
> +
> +	kthread_queue_work(port->wq, &port->state_machine);
> +	return HRTIMER_NORESTART;
> +}
> +
> +static enum hrtimer_restart vdm_state_machine_timer_handler(struct hrtimer *timer)
> +{
> +	struct tcpm_port *port = container_of(timer, struct tcpm_port, vdm_state_machine_timer);
> +
> +	kthread_queue_work(port->wq, &port->vdm_state_machine);
> +	return HRTIMER_NORESTART;
> +}
> +
> +/* Priority just lower than default irq thread priority */
> +static const struct sched_param param = {
> +	.sched_priority = (MAX_USER_RT_PRIO / 2) + 1,
> +};
> +
>  struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  {
>  	struct tcpm_port *port;
> @@ -4807,12 +4849,18 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	mutex_init(&port->lock);
>  	mutex_init(&port->swap_lock);
>  
> -	port->wq = create_singlethread_workqueue(dev_name(dev));
> -	if (!port->wq)
> -		return ERR_PTR(-ENOMEM);
> -	INIT_DELAYED_WORK(&port->state_machine, tcpm_state_machine_work);
> -	INIT_DELAYED_WORK(&port->vdm_state_machine, vdm_state_machine_work);
> -	INIT_WORK(&port->event_work, tcpm_pd_event_handler);
> +	port->wq = kthread_create_worker(0, dev_name(dev));
> +	if (IS_ERR(port->wq))
> +		return ERR_CAST(port->wq);
> +	sched_setscheduler(port->wq->task, SCHED_FIFO, &param);
> +
> +	kthread_init_work(&port->state_machine, tcpm_state_machine_work);
> +	kthread_init_work(&port->vdm_state_machine, vdm_state_machine_work);
> +	kthread_init_work(&port->event_work, tcpm_pd_event_handler);
> +	hrtimer_init(&port->state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	port->state_machine_timer.function = state_machine_timer_handler;
> +	hrtimer_init(&port->vdm_state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	port->vdm_state_machine_timer.function = vdm_state_machine_timer_handler;
>  
>  	spin_lock_init(&port->pd_event_lock);
>  
> @@ -4864,7 +4912,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	usb_role_switch_put(port->role_sw);
>  out_destroy_wq:
>  	tcpm_debugfs_exit(port);
> -	destroy_workqueue(port->wq);
> +	kthread_destroy_worker(port->wq);
>  	return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_register_port);
> @@ -4879,7 +4927,7 @@ void tcpm_unregister_port(struct tcpm_port *port)
>  	typec_unregister_port(port->typec_port);
>  	usb_role_switch_put(port->role_sw);
>  	tcpm_debugfs_exit(port);
> -	destroy_workqueue(port->wq);
> +	kthread_destroy_worker(port->wq);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_unregister_port);
>  

thanks,

-- 
heikki
