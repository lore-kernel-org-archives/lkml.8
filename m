Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2010C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B35552054F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1VXgH0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgHLBjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 21:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgHLBjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:39:36 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109F9C06174A;
        Tue, 11 Aug 2020 18:39:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 2so324426pjx.5;
        Tue, 11 Aug 2020 18:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wCpdTikHMIG2mAVozwmNq1fm15f/reL2wBsMHhYOQZU=;
        b=U1VXgH0JX+yv1psGzF00P0ZVpsrOWI/xdLQmBLgIOONDaWc/2w+Iz03tIskxdK2j8J
         i/X1AX6j65BfMSCwtuQYgdvuXdSVS+OS4YYaOxDJPp6w7pOJFE743yLW3FfoO0OXcDm8
         N6aW6tXrKN0qXHxicIJlJ3Z0eysT73bFcgOyeC5p2GmJSnuQtcabOly10PV1fDviX0Sx
         tFFmTuOdAeiuSBFrDM98MOfVgfG1VikrdiEIuMg6WhOi/pgZHxnbdvw88fh5zSDRTZy2
         tmAeZouX8fkpKKh0cLVrh5rnEpeeNb+8XDti2t9LnoZVP2x34B9/rSvL0OBzDnkBrdQ4
         ZdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wCpdTikHMIG2mAVozwmNq1fm15f/reL2wBsMHhYOQZU=;
        b=d8TyGHg6bBB5ssX42S6CFwzVc6mYmXwL9XNADJ+hChuoGghvB5Fwy1adXP44XP7MqS
         kl+u39BkOJrBjckziP4GnPK7Bm8Dbn5kVPKzFt0WcYfGSh1tp/EbYspjZY0jveFYsnWm
         IO8Qg+6jOP6BM9L0A3lCYoEizfetKvD3zT4IrgnFMEEmq1bUSL26DW00PbR1F6iWp3d4
         KBDP6ND1bAaGu02TlvNyeXofi5KdfmTIkN1oRCwg3NH2WYUXfpRl970mwfBwn8Bzo7yn
         Kft96jCBxU/dqborcb8INsOkKdznJ523GRnIjqR7LFA3HSzDrnOjCbqZEvbjuZVuPHjt
         JFAQ==
X-Gm-Message-State: AOAM530BNA4VnnEKi0CxPbqI3lOipCGpWw1trX5xeXyGnbeUtgQLNPh1
        CC7roXfQ8bGM4NPsX9nWYtuZ8j27
X-Google-Smtp-Source: ABdhPJzoQJB/t3CyAadNMD1+hsJVysMqhthSzsaOKvLFW4ZTa4tYdfpvx3xqTayHR9ohuRjnE6om0g==
X-Received: by 2002:a17:902:9a01:: with SMTP id v1mr3192398plp.15.1597196375454;
        Tue, 11 Aug 2020 18:39:35 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j13sm342226pfa.149.2020.08.11.18.39.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Aug 2020 18:39:34 -0700 (PDT)
Date:   Tue, 11 Aug 2020 18:39:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm: Fix TDA 2.2.1.1 and TDA 2.2.1.2
 failures
Message-ID: <20200812013933.GA116439@roeck-us.net>
References: <20200811200228.433264-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811200228.433264-1-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 01:02:28PM -0700, Badhri Jagan Sridharan wrote:
> From the spec:
> "7.1.5 Response to Hard Resets
> Hard Reset Signaling indicates a communication failure has occurred and
> the Source Shall stop driving VCONN, Shall remove Rp from the VCONN pin
> and Shall drive VBUS to vSafe0V as shown in Figure 7-9. The USB connection
> May reset during a Hard Reset since the VBUS voltage will be less than
> vSafe5V for an extended period of time. After establishing the vSafe0V
> voltage condition on VBUS, the Source Shall wait tSrcRecover before
> re-applying VCONN and restoring VBUS to vSafe5V. A Source Shall conform
> to the VCONN timing as specified in [USB Type-C 1.3]."
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
> Changes since V1 (Guenter's suggestion):
> - Bound SRC_HARD_RESET_VBUS_ON to accommodate tcpc drivers which doesn't
>   update the vbus status.
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3ef37202ee37..a48e3f90d196 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3372,13 +3372,31 @@ static void run_state_machine(struct tcpm_port *port)
>  			tcpm_set_state(port, SNK_HARD_RESET_SINK_OFF, 0);
>  		break;
>  	case SRC_HARD_RESET_VBUS_OFF:
> -		tcpm_set_vconn(port, true);
> +		/*
> +		 * 7.1.5 Response to Hard Resets
> +		 * Hard Reset Signaling indicates a communication failure has occurred and the
> +		 * Source Shall stop driving VCONN, Shall remove Rp from the VCONN pin and Shall
> +		 * drive VBUS to vSafe0V as shown in Figure 7-9.
> +		 */
> +		tcpm_set_vconn(port, false);
>  		tcpm_set_vbus(port, false);
>  		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
>  			       tcpm_data_role_for_source(port));
> -		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
> +		/*
> +		 * If tcpc fails to notify vbus off, TCPM will wait for PD_T_SAFE_0V +
> +		 * PD_T_SRC_RECOVER before turning vbus back on.
> +		 * From Table 7-12 Sequence Description for a Source Initiated Hard Reset:
> +		 * 4. Policy Engine waits tPSHardReset after sending Hard Reset Signaling and then
> +		 * tells the Device Policy Manager to instruct the power supply to perform a
> +		 * Hard Reset. The transition to vSafe0V Shall occur within tSafe0V (t2).
> +		 * 5. After tSrcRecover the Source applies power to VBUS in an attempt to
> +		 * re-establish communication with the Sink and resume USB Default Operation.
> +		 * The transition to vSafe5V Shall occur within tSrcTurnOn(t4).
> +		 */
> +		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SAFE_0V + PD_T_SRC_RECOVER);
>  		break;
>  	case SRC_HARD_RESET_VBUS_ON:
> +		tcpm_set_vconn(port, true);
>  		tcpm_set_vbus(port, true);
>  		port->tcpc->set_pd_rx(port->tcpc, true);
>  		tcpm_set_attached_state(port, true);
> @@ -3944,7 +3962,11 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
>  		tcpm_set_state(port, SNK_HARD_RESET_WAIT_VBUS, 0);
>  		break;
>  	case SRC_HARD_RESET_VBUS_OFF:
> -		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, 0);
> +		/*
> +		 * After establishing the vSafe0V voltage condition on VBUS, the Source Shall wait
> +		 * tSrcRecover before re-applying VCONN and restoring VBUS to vSafe5V.
> +		 */
> +		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
>  		break;
>  	case HARD_RESET_SEND:
>  		break;
