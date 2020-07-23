Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404EBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0150F206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtixqJuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgGWPk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGWPk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:40:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45009C0619E2;
        Thu, 23 Jul 2020 08:40:57 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s189so3288190pgc.13;
        Thu, 23 Jul 2020 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sy1PvqlTFPJCmCUXbxySCproaSZ4dRfzVK1tWoQQ9eE=;
        b=LtixqJuKyraCylWWF/sWV//ALkv3Ttxoc/lHRMOXZnS0Sqi+Az0gmNnY1SZmTxy8MT
         mp/OQiGdk7QH/Xj1YS5LfnpVBh8qTLaQmSTfJwaw4YclSMExJF4RhLYwVcrktsT8sBv7
         8HXhiTcB0M1H7n7Jx6L1zUbRIW1+/bnzIXiOcg6KQbHxoahZgNDFM8AlEFAKdUdRKZhb
         t5ILb5mfQqRK0rq/onOUIgBz1BqgPbHB5VUJjLy/rZl1R/gh64y8NzQxLOBfgrV5wC69
         xHgy5ZJ3BkGvipwoushGRUfVwywXIaObmoX8Xlmdx5h9UdswqJHbzyt4StwJqLdQdgNw
         VYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sy1PvqlTFPJCmCUXbxySCproaSZ4dRfzVK1tWoQQ9eE=;
        b=Sa1HRj5sgf9r90APfPCGBMiCemg1F7fopJ1eH0K12ztoLjh/YxR0yMMXjgolDFkiIS
         iMXoXFavfOaaG4f3o5f7u7dvYDlv94Ca89Y6MBO0IjMZ8nLGdH17SXlZtvHRT6f8v4m1
         9l0WQZvXxc8YZkvJAcWg6HaCEb+I1wR6jDc3MolFtl0kX4oHo2uuQeUxCQlfsA4/1/Tr
         /mxF9uBbKjrZCzJojLS+aqTRX6BJwMhof1uo/YAfwtnrkLfM1n4IlVMMd+oU8PednCK5
         +Q3ttmgXVFa/LBS52ZQkiaihPp1EeXRdCHu5kWTTXF7dPC4Iff0D8qmQ8fMdXbO7H/Ek
         cmPA==
X-Gm-Message-State: AOAM530iX2QJXCvIqvPg9lwsafIiFhfV1B/4oyE/peDf0WovuBzZ/GAw
        RwWAlLhufbB4kG+oSQT3N6vlI4ie
X-Google-Smtp-Source: ABdhPJxQYxipNIpMnP8qEfQuVddugodc6hYeGPMCAERQ7sR/q/AsVIBff3xu2kFYye9hGF1r6DpGsw==
X-Received: by 2002:a63:5220:: with SMTP id g32mr4559082pgb.78.1595518856584;
        Thu, 23 Jul 2020 08:40:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f131sm3491961pgc.14.2020.07.23.08.40.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jul 2020 08:40:51 -0700 (PDT)
Date:   Thu, 23 Jul 2020 08:40:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Migrate workqueue to RT priority for
 processing events
Message-ID: <20200723154049.GA3573@roeck-us.net>
References: <20200723061524.1930372-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723061524.1930372-1-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 11:15:24PM -0700, Badhri Jagan Sridharan wrote:
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
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 138 ++++++++++++++++++++++------------
>  1 file changed, 90 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index ff1cbd2147ca8a..0dcab6f08f8587 100644
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
> @@ -195,7 +198,7 @@ struct tcpm_port {
>  	struct device *dev;
>  
>  	struct mutex lock;		/* tcpm state machine lock */
> -	struct workqueue_struct *wq;
> +	struct kthread_worker *wq;
>  
>  	struct typec_capability typec_caps;
>  	struct typec_port *typec_port;
> @@ -239,15 +242,17 @@ struct tcpm_port {
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
> @@ -332,7 +337,7 @@ struct tcpm_port {
>  };
>  
>  struct pd_rx_event {
> -	struct work_struct work;
> +	struct kthread_work work;
>  	struct tcpm_port *port;
>  	struct pd_message msg;
>  };
> @@ -906,6 +911,25 @@ static int tcpm_pd_send_sink_caps(struct tcpm_port *port)
>  	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
>  }
>  
> +static void mod_tcpm_delayed_work(struct tcpm_port *port, unsigned int delay_ms)
> +{
> +	hrtimer_cancel(&port->state_machine_timer);
> +	if (delay_ms)
> +		hrtimer_start(&port->state_machine_timer, ms_to_ktime(delay_ms), HRTIMER_MODE_REL);
> +	else
> +		kthread_queue_work(port->wq, &port->state_machine);

If I understand correctly, hrtimer_start() restarts an already running timer.
With this in mind, would the following be more efficient ?

	if (delay_ms) {
		hrtimer_start(&port->state_machine_timer, ms_to_ktime(delay_ms), HRTIMER_MODE_REL);
	} else {
		hrtimer_cancel(&port->state_machine_timer);
		kthread_queue_work(port->wq, &port->state_machine);
	}

Thanks,
Guenter

> +}
> +
> +static void mod_vdm_delayed_work(struct tcpm_port *port, unsigned int delay_ms)
> +{
> +	hrtimer_cancel(&port->vdm_state_machine_timer);
> +	if (delay_ms)
> +		hrtimer_start(&port->vdm_state_machine_timer, ms_to_ktime(delay_ms),
> +			      HRTIMER_MODE_REL);
> +	else
> +		kthread_queue_work(port->wq, &port->vdm_state_machine);
> +}
> +
>  static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
>  			   unsigned int delay_ms)
>  {
> @@ -914,9 +938,8 @@ static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
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
> @@ -931,7 +954,7 @@ static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
>  		 * machine.
>  		 */
>  		if (!port->state_machine_running)
> -			mod_delayed_work(port->wq, &port->state_machine, 0);
> +			mod_tcpm_delayed_work(port, 0);
>  	}
>  }
>  
> @@ -952,7 +975,7 @@ static void tcpm_queue_message(struct tcpm_port *port,
>  			       enum pd_msg_request message)
>  {
>  	port->queued_message = message;
> -	mod_delayed_work(port->wq, &port->state_machine, 0);
> +	mod_tcpm_delayed_work(port, 0);
>  }
>  
>  /*
> @@ -1238,8 +1261,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  			port->vdm_state = VDM_STATE_WAIT_RSP_BUSY;
>  			port->vdo_retry = (p0 & ~VDO_CMDT_MASK) |
>  				CMDT_INIT;
> -			mod_delayed_work(port->wq, &port->vdm_state_machine,
> -					 msecs_to_jiffies(PD_T_VDM_BUSY));
> +			mod_vdm_delayed_work(port, PD_T_VDM_BUSY);
>  			return;
>  		}
>  		port->vdm_state = VDM_STATE_DONE;
> @@ -1250,7 +1272,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  
>  	if (rlen > 0) {
>  		tcpm_queue_vdm(port, response[0], &response[1], rlen - 1);
> -		mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> +		mod_vdm_delayed_work(port, 0);
>  	}
>  }
>  
> @@ -1267,7 +1289,7 @@ static void tcpm_send_vdm(struct tcpm_port *port, u32 vid, int cmd,
>  			1 : (PD_VDO_CMD(cmd) <= CMD_ATTENTION), cmd);
>  	tcpm_queue_vdm(port, header, data, count);
>  
> -	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> +	mod_vdm_delayed_work(port, 0);
>  }
>  
>  static unsigned int vdm_ready_timeout(u32 vdm_hdr)
> @@ -1334,8 +1356,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  			port->vdm_retries = 0;
>  			port->vdm_state = VDM_STATE_BUSY;
>  			timeout = vdm_ready_timeout(port->vdo_data[0]);
> -			mod_delayed_work(port->wq, &port->vdm_state_machine,
> -					 timeout);
> +			mod_vdm_delayed_work(port, timeout);
>  		}
>  		break;
>  	case VDM_STATE_WAIT_RSP_BUSY:
> @@ -1364,10 +1385,9 @@ static void vdm_run_state_machine(struct tcpm_port *port)
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
> @@ -1515,7 +1535,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
>  	header |= VDO_OPOS(altmode->mode);
>  
>  	tcpm_queue_vdm(port, header, vdo, vdo ? 1 : 0);
> -	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> +	mod_vdm_delayed_work(port, 0);
>  	mutex_unlock(&port->lock);
>  
>  	return 0;
> @@ -1531,7 +1551,7 @@ static int tcpm_altmode_exit(struct typec_altmode *altmode)
>  	header |= VDO_OPOS(altmode->mode);
>  
>  	tcpm_queue_vdm(port, header, NULL, 0);
> -	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> +	mod_vdm_delayed_work(port, 0);
>  	mutex_unlock(&port->lock);
>  
>  	return 0;
> @@ -1544,7 +1564,7 @@ static int tcpm_altmode_vdm(struct typec_altmode *altmode,
>  
>  	mutex_lock(&port->lock);
>  	tcpm_queue_vdm(port, header, data, count - 1);
> -	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> +	mod_vdm_delayed_work(port, 0);
>  	mutex_unlock(&port->lock);
>  
>  	return 0;
> @@ -1961,7 +1981,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
>  	}
>  }
>  
> -static void tcpm_pd_rx_handler(struct work_struct *work)
> +static void tcpm_pd_rx_handler(struct kthread_work *work)
>  {
>  	struct pd_rx_event *event = container_of(work,
>  						 struct pd_rx_event, work);
> @@ -2023,10 +2043,10 @@ void tcpm_pd_receive(struct tcpm_port *port, const struct pd_message *msg)
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
> @@ -2079,9 +2099,9 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
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
> @@ -3214,10 +3234,9 @@ static void run_state_machine(struct tcpm_port *port)
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
> @@ -3612,10 +3631,9 @@ static void run_state_machine(struct tcpm_port *port)
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
> @@ -3975,7 +3993,7 @@ static void _tcpm_pd_hard_reset(struct tcpm_port *port)
>  		       0);
>  }
>  
> -static void tcpm_pd_event_handler(struct work_struct *work)
> +static void tcpm_pd_event_handler(struct kthread_work *work)
>  {
>  	struct tcpm_port *port = container_of(work, struct tcpm_port,
>  					      event_work);
> @@ -4016,7 +4034,7 @@ void tcpm_cc_change(struct tcpm_port *port)
>  	spin_lock(&port->pd_event_lock);
>  	port->pd_events |= TCPM_CC_EVENT;
>  	spin_unlock(&port->pd_event_lock);
> -	queue_work(port->wq, &port->event_work);
> +	kthread_queue_work(port->wq, &port->event_work);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_cc_change);
>  
> @@ -4025,7 +4043,7 @@ void tcpm_vbus_change(struct tcpm_port *port)
>  	spin_lock(&port->pd_event_lock);
>  	port->pd_events |= TCPM_VBUS_EVENT;
>  	spin_unlock(&port->pd_event_lock);
> -	queue_work(port->wq, &port->event_work);
> +	kthread_queue_work(port->wq, &port->event_work);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_vbus_change);
>  
> @@ -4034,7 +4052,7 @@ void tcpm_pd_hard_reset(struct tcpm_port *port)
>  	spin_lock(&port->pd_event_lock);
>  	port->pd_events = TCPM_RESET_EVENT;
>  	spin_unlock(&port->pd_event_lock);
> -	queue_work(port->wq, &port->event_work);
> +	kthread_queue_work(port->wq, &port->event_work);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_pd_hard_reset);
>  
> @@ -4742,10 +4760,28 @@ static int devm_tcpm_psy_register(struct tcpm_port *port)
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
>  struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  {
>  	struct tcpm_port *port;
>  	int err;
> +	/* Priority just lower than default irq thread priority */
> +	struct sched_param param = {.sched_priority = (MAX_USER_RT_PRIO / 2) + 1,};
>  
>  	if (!dev || !tcpc ||
>  	    !tcpc->get_vbus || !tcpc->set_cc || !tcpc->get_cc ||
> @@ -4763,12 +4799,18 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
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
> +		return (struct tcpm_port *)port->wq;
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
> @@ -4820,7 +4862,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	usb_role_switch_put(port->role_sw);
>  out_destroy_wq:
>  	tcpm_debugfs_exit(port);
> -	destroy_workqueue(port->wq);
> +	kthread_destroy_worker(port->wq);
>  	return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_register_port);
> @@ -4835,7 +4877,7 @@ void tcpm_unregister_port(struct tcpm_port *port)
>  	typec_unregister_port(port->typec_port);
>  	usb_role_switch_put(port->role_sw);
>  	tcpm_debugfs_exit(port);
> -	destroy_workqueue(port->wq);
> +	kthread_destroy_worker(port->wq);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_unregister_port);
>  
> -- 
> 2.28.0.rc0.105.gf9edc3c819-goog
> 
