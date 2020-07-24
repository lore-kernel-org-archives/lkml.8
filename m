Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE17C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE212063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR6m7Z6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGXPvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:51:09 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D342C0619D3;
        Fri, 24 Jul 2020 08:51:09 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 1so5366965pfn.9;
        Fri, 24 Jul 2020 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jNEo31toiJB9dfZ8OqYOee5qAU0hngLVfQj3HH0QAIA=;
        b=oR6m7Z6ACWAu5T9SJP8AMeyyu0j7VSO3xHhbzB+mte53kzEYp5Vupri+paNIMn+h5y
         9uaZrD/cPkgvDfwq4HTesyYg21dJ7NQQwZ17odWRSh3rz71cs9gx/tMQ6+SlVarfFBv8
         QYoof3pQuvQRtrHhDGN8VUUQRoMbKQM2vXAk86CRi5lQRvqtNMwq0KOqr7iuG1gsiy+/
         mUaslIt50I5UOmPT1AWvTD3NLDwHj4qUbn9JBawe9hJjcrQ2JSPgFpqV2VgGxsuOAGyE
         90FicKH4zadRDPetCVPVNcuANlZkKsb//Ev86AwCU/Eh6XblsIOWY1W0NYfxfKyhQLvG
         Nm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jNEo31toiJB9dfZ8OqYOee5qAU0hngLVfQj3HH0QAIA=;
        b=NlbtltgsYpfkXOd3lC5B9Bk1V/sNotNt861kLMuP97uJtXmp9eolVF0E0M5yBhZilr
         b09P/G5Y9YpDYaRx8MZHGx3ReDC5WN/5QJKbMOnV/LgebZJUX/7IxmMoAlYRIwT4xOyX
         lmWiSn4eLwPj6QkiAmsyPLRdGsVCqKqHlzgyLlK0Rop5+R6teGyNEOljJdflFIotxFQ6
         n8qpF6RXnB3J1Gl4O6V1AwGTJoRhaPJdKeudwlyAuKVSGMMPcyysDiBzfwPFDc9x8Mn2
         X5xkR9EqYgTnaqbcHCiRhFwN7HaEvN5Zg/S3i8uSx3XIvtlciN+IcpGKkOR89x+eJ54p
         S6ow==
X-Gm-Message-State: AOAM533y5KDpc3yjLcH1ZBHplJjfRgHAISkggyOUvZSamWEdA50cQ/YJ
        6htsXqV+eblr/G3gsZtfG6L6if/9
X-Google-Smtp-Source: ABdhPJwX3lYXm6ndO+ushBvpE1HOaUstYlvIshu6IUkDEoajroyPj9lwQR3L+PWLlYVFJ+Lws1neHQ==
X-Received: by 2002:a65:6448:: with SMTP id s8mr8142407pgv.405.1595605868596;
        Fri, 24 Jul 2020 08:51:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g10sm6795765pfr.164.2020.07.24.08.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 08:51:07 -0700 (PDT)
Subject: Re: [PATCH v2] usb: typec: tcpm: Migrate workqueue to RT priority for
 processing events
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200724020551.2737376-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <8ffed9f9-426c-7da2-47b7-4ca8fa8e8caf@roeck-us.net>
Date:   Fri, 24 Jul 2020 08:51:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724020551.2737376-1-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/20 7:05 PM, Badhri Jagan Sridharan wrote:
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> ---
> 
> Changes since v1:(Guenter's suggestions)
> - Remove redundant call to hrtimer_cancel while calling
>   hrtimer_start.
> 
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 140 ++++++++++++++++++++++------------
>  1 file changed, 92 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index ff1cbd2147ca8a..fa9002944dc766 100644
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
> @@ -906,6 +911,27 @@ static int tcpm_pd_send_sink_caps(struct tcpm_port *port)
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
> @@ -914,9 +940,8 @@ static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
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
> @@ -931,7 +956,7 @@ static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
>  		 * machine.
>  		 */
>  		if (!port->state_machine_running)
> -			mod_delayed_work(port->wq, &port->state_machine, 0);
> +			mod_tcpm_delayed_work(port, 0);
>  	}
>  }
>  
> @@ -952,7 +977,7 @@ static void tcpm_queue_message(struct tcpm_port *port,
>  			       enum pd_msg_request message)
>  {
>  	port->queued_message = message;
> -	mod_delayed_work(port->wq, &port->state_machine, 0);
> +	mod_tcpm_delayed_work(port, 0);
>  }
>  
>  /*
> @@ -1238,8 +1263,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  			port->vdm_state = VDM_STATE_WAIT_RSP_BUSY;
>  			port->vdo_retry = (p0 & ~VDO_CMDT_MASK) |
>  				CMDT_INIT;
> -			mod_delayed_work(port->wq, &port->vdm_state_machine,
> -					 msecs_to_jiffies(PD_T_VDM_BUSY));
> +			mod_vdm_delayed_work(port, PD_T_VDM_BUSY);
>  			return;
>  		}
>  		port->vdm_state = VDM_STATE_DONE;
> @@ -1250,7 +1274,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  
>  	if (rlen > 0) {
>  		tcpm_queue_vdm(port, response[0], &response[1], rlen - 1);
> -		mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> +		mod_vdm_delayed_work(port, 0);
>  	}
>  }
>  
> @@ -1267,7 +1291,7 @@ static void tcpm_send_vdm(struct tcpm_port *port, u32 vid, int cmd,
>  			1 : (PD_VDO_CMD(cmd) <= CMD_ATTENTION), cmd);
>  	tcpm_queue_vdm(port, header, data, count);
>  
> -	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> +	mod_vdm_delayed_work(port, 0);
>  }
>  
>  static unsigned int vdm_ready_timeout(u32 vdm_hdr)
> @@ -1334,8 +1358,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  			port->vdm_retries = 0;
>  			port->vdm_state = VDM_STATE_BUSY;
>  			timeout = vdm_ready_timeout(port->vdo_data[0]);
> -			mod_delayed_work(port->wq, &port->vdm_state_machine,
> -					 timeout);
> +			mod_vdm_delayed_work(port, timeout);
>  		}
>  		break;
>  	case VDM_STATE_WAIT_RSP_BUSY:
> @@ -1364,10 +1387,9 @@ static void vdm_run_state_machine(struct tcpm_port *port)
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
> @@ -1515,7 +1537,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
>  	header |= VDO_OPOS(altmode->mode);
>  
>  	tcpm_queue_vdm(port, header, vdo, vdo ? 1 : 0);
> -	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> +	mod_vdm_delayed_work(port, 0);
>  	mutex_unlock(&port->lock);
>  
>  	return 0;
> @@ -1531,7 +1553,7 @@ static int tcpm_altmode_exit(struct typec_altmode *altmode)
>  	header |= VDO_OPOS(altmode->mode);
>  
>  	tcpm_queue_vdm(port, header, NULL, 0);
> -	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> +	mod_vdm_delayed_work(port, 0);
>  	mutex_unlock(&port->lock);
>  
>  	return 0;
> @@ -1544,7 +1566,7 @@ static int tcpm_altmode_vdm(struct typec_altmode *altmode,
>  
>  	mutex_lock(&port->lock);
>  	tcpm_queue_vdm(port, header, data, count - 1);
> -	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> +	mod_vdm_delayed_work(port, 0);
>  	mutex_unlock(&port->lock);
>  
>  	return 0;
> @@ -1961,7 +1983,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
>  	}
>  }
>  
> -static void tcpm_pd_rx_handler(struct work_struct *work)
> +static void tcpm_pd_rx_handler(struct kthread_work *work)
>  {
>  	struct pd_rx_event *event = container_of(work,
>  						 struct pd_rx_event, work);
> @@ -2023,10 +2045,10 @@ void tcpm_pd_receive(struct tcpm_port *port, const struct pd_message *msg)
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
> @@ -2079,9 +2101,9 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
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
> @@ -3214,10 +3236,9 @@ static void run_state_machine(struct tcpm_port *port)
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
> @@ -3612,10 +3633,9 @@ static void run_state_machine(struct tcpm_port *port)
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
> @@ -3975,7 +3995,7 @@ static void _tcpm_pd_hard_reset(struct tcpm_port *port)
>  		       0);
>  }
>  
> -static void tcpm_pd_event_handler(struct work_struct *work)
> +static void tcpm_pd_event_handler(struct kthread_work *work)
>  {
>  	struct tcpm_port *port = container_of(work, struct tcpm_port,
>  					      event_work);
> @@ -4016,7 +4036,7 @@ void tcpm_cc_change(struct tcpm_port *port)
>  	spin_lock(&port->pd_event_lock);
>  	port->pd_events |= TCPM_CC_EVENT;
>  	spin_unlock(&port->pd_event_lock);
> -	queue_work(port->wq, &port->event_work);
> +	kthread_queue_work(port->wq, &port->event_work);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_cc_change);
>  
> @@ -4025,7 +4045,7 @@ void tcpm_vbus_change(struct tcpm_port *port)
>  	spin_lock(&port->pd_event_lock);
>  	port->pd_events |= TCPM_VBUS_EVENT;
>  	spin_unlock(&port->pd_event_lock);
> -	queue_work(port->wq, &port->event_work);
> +	kthread_queue_work(port->wq, &port->event_work);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_vbus_change);
>  
> @@ -4034,7 +4054,7 @@ void tcpm_pd_hard_reset(struct tcpm_port *port)
>  	spin_lock(&port->pd_event_lock);
>  	port->pd_events = TCPM_RESET_EVENT;
>  	spin_unlock(&port->pd_event_lock);
> -	queue_work(port->wq, &port->event_work);
> +	kthread_queue_work(port->wq, &port->event_work);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_pd_hard_reset);
>  
> @@ -4742,10 +4762,28 @@ static int devm_tcpm_psy_register(struct tcpm_port *port)
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
> @@ -4763,12 +4801,18 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
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
> @@ -4820,7 +4864,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	usb_role_switch_put(port->role_sw);
>  out_destroy_wq:
>  	tcpm_debugfs_exit(port);
> -	destroy_workqueue(port->wq);
> +	kthread_destroy_worker(port->wq);
>  	return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_register_port);
> @@ -4835,7 +4879,7 @@ void tcpm_unregister_port(struct tcpm_port *port)
>  	typec_unregister_port(port->typec_port);
>  	usb_role_switch_put(port->role_sw);
>  	tcpm_debugfs_exit(port);
> -	destroy_workqueue(port->wq);
> +	kthread_destroy_worker(port->wq);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_unregister_port);
>  
> 

