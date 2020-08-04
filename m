Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C50C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E6552086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpE99CFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgHDQ7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:59:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBCDC06174A;
        Tue,  4 Aug 2020 09:58:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id c6so2605750pje.1;
        Tue, 04 Aug 2020 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s7tJRMGtBgVpiZsq41tG0aW9vObPT36tj7uvOHxXjQo=;
        b=NpE99CFYrlsfu3hq1z5SEouS3shamUUKRRZ3H/ppmfQlD47u/Ou7BRWPCsHwtiQzSb
         cDkesdm+qte8ZQgtGpRxzKx/6VgcJ/q54ptLsr6EkU3IPRm5TZdb09fe+V8+kKqH9Yrs
         Z2JnShlGMxo2zk36EZGRiD4ZnFzTjMfXUstZwdLxJGOwU9sFFruh3T6Kc1GX72hJj55M
         yuZcg6TFzRW2Uev4tWs1wizcSosD1OYz5f+AQAeY4e4elKKZK4IKOW7hkVOWlLwEmSSv
         Xnmp8nBDLhkxxJ7r5q6xDVOU2A0tSi4q+nN5Fbv5BuVUG7yDYG5Z8oZvUkqxbX5I7n6s
         n43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=s7tJRMGtBgVpiZsq41tG0aW9vObPT36tj7uvOHxXjQo=;
        b=QeqA7fUB7X+lnkI1uHF4Qfi2hfmrDeK5h4Xea3GpBH9mL62JoJii6/cCIfv2f78aL9
         rLrmFTdWXl7BKQkH+G7B4xlzAAlUNY718+THXxe6lhJouZ1GneHDKXJUAMOk4wTUuHcf
         Xl5UbeuHUXK62lPUwiFxKAGqbV0dG4Y4WnlqFNh5Vk+SgGB2E+DQRq4EJUCCHkZovzOa
         MTBOCawkdyIW1T9XiuZVkNEwgVZwatibSuS1dkxR+mj6qZhyp+tbqEYvzdxY8aPYHeIo
         R1MklNrVhGEPDnr5twHXHEDcRWe1FjhiBvNN/qQDAjHEhSSW5jiiCU39hYhnQNoj3eXT
         EPfw==
X-Gm-Message-State: AOAM531cnE8P57ggOwulJL+hbUNvyl7+gwr6+31sM9rh8O3qhA5psdZe
        bhsjGwZo99xjIuBKnys3xF8=
X-Google-Smtp-Source: ABdhPJx69JRXImT/2HIoJpgCuMTZ1rH4z4ZqaIpL9xs2sdug9VLVMSCOWhQIwdGVg0eBC/GBbrMaZw==
X-Received: by 2002:a17:90a:6589:: with SMTP id k9mr5096511pjj.165.1596560339086;
        Tue, 04 Aug 2020 09:58:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 8sm3307605pjx.14.2020.08.04.09.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 09:58:58 -0700 (PDT)
Subject: Re: [PATCH v1] tcpm: Honour pSnkStdby requirement during negotiation
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        --validate@google.com
References: <20200804065111.3889122-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <28df079b-835d-9005-b711-df386e2b308b@roeck-us.net>
Date:   Tue, 4 Aug 2020 09:58:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804065111.3889122-1-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/20 11:51 PM, Badhri Jagan Sridharan wrote:
>>From PD Spec:
> The Sink Shall transition to Sink Standby before a positive or
> negative voltage transition of VBUS. During Sink Standby
> the Sink Shall reduce its power draw to pSnkStdby. This allows
> the Source to manage the voltage transition as well as
> supply sufficient operating current to the Sink to maintain PD
> operation during the transition. The Sink Shall
> complete this transition to Sink Standby within tSnkStdby
> after evaluating the Accept Message from the Source. The
> transition when returning to Sink operation from Sink Standby
> Shall be completed within tSnkNewPower. The
> pSnkStdby requirement Shall only apply if the Sink power draw
> is higher than this level.
> 
> The above requirement needs to be met to prevent hard resets
> from port partner.
> 
> Introducing psnkstdby_after_accept flag to accommodate systems
> where the input current limit loops are not fast enough to meet
> tSnkStby(15 msec).
> 
> When not set, port requests PD_P_SNK_STDBY upon entering SNK_DISCOVERY and
> the actual currrent limit after RX of PD_CTRL_PSRDY for PD link,
> SNK_READY for non-pd link.
> 
> When set, port requests CC advertisement based current limit during
> SNK_DISCOVERY, current gets limited to PD_P_SNK_STDBY during
> SNK_TRANSITION_SINK, PD based current limit gets set after RX of
> PD_CTRL_PSRDY. However, in this case it has to be made sure that the
> tSnkStdby (15 msec) is met.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 52 +++++++++++++++++++++++++++--------
>  include/linux/usb/pd.h        |  5 +++-
>  2 files changed, 44 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3ef37202ee37..e46da41940b9 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -293,9 +293,12 @@ struct tcpm_port {
>  	unsigned int operating_snk_mw;
>  	bool update_sink_caps;
>  
> -	/* Requested current / voltage */
> +	/* Set current / voltage */
>  	u32 current_limit;
>  	u32 supply_voltage;
> +	/* current / voltage requested to partner */
> +	u32 req_current_limit;
> +	u32 req_supply_voltage;

I don't see a clear delineation where, when, and why supply_voltage vs. req_supply_voltage
and current_limit vs. req_current_limit is used. Maybe someone else does and can give a
Reviewed-by: tag, but for my part I'll have to spend some time trying to understand
what each variable and its use now means. Overall this suggests that the code may now be
a bit fragile. If those two sets of variables are now indeed needed, I think it would help
to have a detailed explanation for each use. This would help reducing the probability
of errors if the code has to be touched again in the future.

>  
>  	/* Used to export TA voltage and current */
>  	struct power_supply *psy;
> @@ -323,13 +326,27 @@ struct tcpm_port {
>  	struct pd_mode_data mode_data;
>  	struct typec_altmode *partner_altmode[ALTMODE_DISCOVERY_MAX];
>  	struct typec_altmode *port_altmode[ALTMODE_DISCOVERY_MAX];
> -
>  	/* Deadline in jiffies to exit src_try_wait state */
>  	unsigned long max_wait;
>  
>  	/* port belongs to a self powered device */
>  	bool self_powered;
>  
> +	/*
> +	 * Honour psnkstdby after accept is received.
> +	 * However, in this case it has to be made sure that the tSnkStdby (15
> +	 * msec) is met.
> +	 *
> +	 * When not set, port requests PD_P_SNK_STDBY_5V upon entering SNK_DISCOVERY and
> +	 * the actual currrent limit after RX of PD_CTRL_PSRDY for PD link,
> +	 * SNK_READY for non-pd link.
> +	 *
> +	 * When set, port requests CC advertisement based current limit during
> +	 * SNK_DISCOVERY, current gets limited to PD_P_SNK_STDBY_5V during SNK_TRANSITION_SINK,
> +	 * PD based current limit gets set after RX of PD_CTRL_PSRDY.
> +	 */
> +	bool psnkstdby_after_accept;
> +
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *dentry;
>  	struct mutex logbuffer_lock;	/* log buffer access lock */
> @@ -1787,9 +1804,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  		switch (port->state) {
>  		case SNK_TRANSITION_SINK:
>  			if (port->vbus_present) {
> -				tcpm_set_current_limit(port,
> -						       port->current_limit,
> -						       port->supply_voltage);
> +				tcpm_set_current_limit(port, port->req_current_limit,
> +						       port->req_supply_voltage);
>  				port->explicit_contract = true;
>  				tcpm_set_state(port, SNK_READY, 0);
>  			} else {
> @@ -1861,8 +1877,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  			break;
>  		case SNK_NEGOTIATE_PPS_CAPABILITIES:
>  			port->pps_data.active = true;
> -			port->supply_voltage = port->pps_data.out_volt;
> -			port->current_limit = port->pps_data.op_curr;
> +			port->req_supply_voltage = port->pps_data.out_volt;
> +			port->req_current_limit = port->pps_data.op_curr;
>  			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
>  			break;
>  		case SOFT_RESET_SEND:
> @@ -2463,8 +2479,8 @@ static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
>  			 flags & RDO_CAP_MISMATCH ? " [mismatch]" : "");
>  	}
>  
> -	port->current_limit = ma;
> -	port->supply_voltage = mv;
> +	port->req_current_limit = ma;
> +	port->req_supply_voltage = mv;
>  
>  	return 0;
>  }
> @@ -3235,9 +3251,11 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case SNK_DISCOVERY:
>  		if (port->vbus_present) {
> -			tcpm_set_current_limit(port,
> -					       tcpm_get_current_limit(port),
> -					       5000);
> +			if (port->psnkstdby_after_accept || tcpm_get_current_limit(port) <=
> +			    PD_P_SNK_STDBY_5V)
> +				tcpm_set_current_limit(port, tcpm_get_current_limit(port), 5000);
> +			else
> +				tcpm_set_current_limit(port, PD_P_SNK_STDBY_5V, 5000);
>  			tcpm_set_charge(port, true);
>  			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
>  			break;
> @@ -3318,6 +3336,10 @@ static void run_state_machine(struct tcpm_port *port)
>  		}
>  		break;
>  	case SNK_TRANSITION_SINK:
> +		if (port->psnkstdby_after_accept)
> +			tcpm_set_current_limit(port, tcpm_get_current_limit(port) >
> +					       PD_P_SNK_STDBY_5V ? PD_P_SNK_STDBY_5V :
> +					       tcpm_get_current_limit(port), 5000);
>  	case SNK_TRANSITION_SINK_VBUS:
>  		tcpm_set_state(port, hard_reset_state(port),
>  			       PD_T_PS_TRANSITION);
> @@ -3331,6 +3353,10 @@ static void run_state_machine(struct tcpm_port *port)
>  			port->pwr_opmode = TYPEC_PWR_MODE_PD;
>  		}
>  
> +		/* Set current limit for NON-PD link when psnkstdby_after_accept is not set*/
> +		if (!port->pd_capable && !port->psnkstdby_after_accept)
> +			tcpm_set_current_limit(port, tcpm_get_current_limit(port), 5000);
> +
>  		tcpm_swap_complete(port, 0);
>  		tcpm_typec_connect(port);
>  		tcpm_check_send_discover(port);
> @@ -4513,6 +4539,8 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  	port->typec_caps.type = ret;
>  	port->port_type = port->typec_caps.type;
>  
> +	port->psnkstdby_after_accept = fwnode_property_read_bool(fwnode, "psnkstdby-after-accept");
> +

I think this will need to be documented.

Guenter

>  	if (port->port_type == TYPEC_PORT_SNK)
>  		goto sink;
>  
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index b6c233e79bd4..6bd70f77045e 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -483,5 +483,8 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
>  #define PD_N_HARD_RESET_COUNT	2
>  
> -#define PD_T_BIST_CONT_MODE	50 /* 30 - 60 ms */
> +#define PD_T_BIST_CONT_MODE	50	/* 30 - 60 ms */
> +
> +#define PD_P_SNK_STDBY_5V	500	/* 2500 mw - 500mA @ 5V */
> +
>  #endif /* __LINUX_USB_PD_H */
> 

