Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA55C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8916206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9xD5cJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgHEASp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgHEASp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:18:45 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAB3C061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 17:18:44 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t7so18177923otp.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 17:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43Pq8pDWhTm0heuRgBcXTsBR1SFOi7oBIrM5Z7Up+h8=;
        b=r9xD5cJq1eoTMyJw9G6QcNMvhSV50I9vQEL9CUrAYwhuXVGU1xEJVkBCUB8/FT7hzY
         PdNgSkc97Su94ZC5lXv7o4ANTxrg39C7B6BK2hD4O5fBbFA69KL4yhBQKkQO1Tus2BC8
         vSuHwH3speWoaRkIK2wLDgOXQOD3UhvYP4Tcju29OOVK0IrD58Xg6MQ1c3rlre8YvK9r
         3RVuDPNCAorhxTOQ/0MTFbE9FGRqonrxl1e7QgshG0H3ojF7aFB+MuQ8r3PT3V8pfRpv
         JxpFy2Pp6R8DvN9n3anKQ+BFJjn/I6Al6bll9lqYu837UkB1lcMQHPOK4V2K5NZmsNW6
         ZgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43Pq8pDWhTm0heuRgBcXTsBR1SFOi7oBIrM5Z7Up+h8=;
        b=mwJUrv8p4Qkl2qoYJ58Bq3nuQKxczUp124zKhWLnow+5dx/WGKbB6TPx/oGFSLWgul
         /4O1Yv2jaIH5OHfeqptGMauzpoTvz53ArS4IvrZyhbbVE93hWTdjffvv4XnhyOacjRz1
         VxuM6wMuOOsXKHe8WU0rABxuvLwH1Nb2smMX5haJzeSOrNA7kRQKy3zx1Ndg8l8S/mJY
         r/93dWnzb6malWJ9p9zRxgOISrD2H8pxcQlnbIdvW7DxBU606vnF6enH0WeaFrRyRCaa
         hp2T7X22Gnxtj9RCvP8SR0ebojWW9iohO+dMfC9ZK+bI1OTqCEg86nLjiBYEZzV5kdm/
         dv5w==
X-Gm-Message-State: AOAM530gv4my091TfldGQI+84aYwVAwKQjV+qeetUvVANdo5aTjq9YSw
        2dim60tvGvHZ6pn7XEeqz+oSkST653A95Eyxb4Fc5g==
X-Google-Smtp-Source: ABdhPJz/2ZY8cektLBUUlO9CRnMzgFWGE1VXaLk/gmnLx4qTwdqL+i2V99JxmTCkHyW/2vu6lwdzzJURWpMpMmokkhs=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr531944otr.89.1596586723603;
 Tue, 04 Aug 2020 17:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200804065111.3889122-1-badhri@google.com> <28df079b-835d-9005-b711-df386e2b308b@roeck-us.net>
In-Reply-To: <28df079b-835d-9005-b711-df386e2b308b@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Tue, 4 Aug 2020 17:18:07 -0700
Message-ID: <CAPTae5JJ6sRshFxqWroQPSctJogbS_bQcnCCDBXFgxL5B6N6mQ@mail.gmail.com>
Subject: Re: [PATCH v1] tcpm: Honour pSnkStdby requirement during negotiation
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, --validate@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Your concern is very valid ! I was myself pondering at the
significance and meaning of
current_limit,  supply_voltage. I will pen down what I understood from
reading the code.
If it makes sense, I will add the documentation to the change as well.
In TOT code i.e. without the patch in discussion, current_limit and
supply_voltage gets
in three places.
1. tcpm_set_current_limit --------------> Actual current_limit
/voltage requested to be set
                                                             in the hardware.
2. tcpm_pd_build_request --------------> current_limit /voltage
requested to the port partner.
                                                              Not yet
accepted by port partner
3. case PD_CTRL_ACCEPT:  ----------> PPS path: new
current_limit/voltage to be set in hw &
                                                               already
accepted by the port partner.
                switch (port->state) {
                case SNK_NEGOTIATE_CAPABILITIES:
                        port->pps_data.active = false;
                        tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
                        break;
                case SNK_NEGOTIATE_PPS_CAPABILITIES:
                        port->pps_data.active = true;
                        port->supply_voltage = port->pps_data.out_volt;
                        port->current_limit = port->pps_data.op_curr;
                        tcpm_set_state(port, SNK_TRANSITION_SINK, 0);

PPS path safely differentiates between new current_limit &
supply_voltage requested
to the port-partner and current_limit & supply_voltage  requested to
be set in the
hardware by caching the new requested values to partner in
port->pps_data.op_curr/_volt (in tcpm_pd_select_pps_apdo) and updates
port->supply_voltage, port->current_limit only when the port-partner responds
with an accept packet (as pointed in the above code stub).

However, when NOT IN PPS, TCPM code updates  port->current_limit &
port->supply_voltage directly in tcpm_pd_build_request where the partner can
still REJECT the request and port->current_limit & port->supply_voltage
might go out of sync. So, there is already a need to introduce new variables to
cache the requested values to port partners.

Now coming to addressing  pSnkStdby, Once the partner accepts the new request,
PD spec wants the sink to limit the power consumption to pSnkStdby (2.5W) till
source sends the PS_RDY. i.e. while TCPM waits in SNK_TRANSITION_SINK,
the sink's power consumption has to be limited to 2.5W. Sink can enforce or draw
new partner accepted current & voltage at the hardware level only
after PS_RDY is received from the port-partner.

With the patch that I am submitting, I am hoping to cleanly
differentiate between the
current limit/voltage requested to be set in hardware(
tcpm_set_current_limit) Vs
the current limit/voltage requested to the port partner.

 current_limit, supply_voltage -> Requested to be set in hardware.
 req_current_limit, req_supply_voltage -> Newly requested value to the
port partner.

Perhaps doing the following alleviates current_limit/supply_voltage ambiguity:
1. renaming current_limit, supply_voltage to hw_current_limit, hw_supply_voltage
2. making a comment saying hw_current_limit, hw_supply_voltage should only
be set in tcpm_set_current_limit.
3. Instead of calling requested values to port-partner as
req_current_limit/req_supply_voltage, maybe partner_req_current_limit,
partner_req_supply_voltage is a better name.
4. Adding a comment to state significance of hw_current_limit,
hw_supply_voltage,
partner_req_current_limit, partner_req_supply_voltage in tcpm struct.

Let me know if it makes sense I will update the patch (may be even
split if it makes
sense) and resend.

Thanks,
Badhri




On Tue, Aug 4, 2020 at 9:59 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 8/3/20 11:51 PM, Badhri Jagan Sridharan wrote:
> >>From PD Spec:
> > The Sink Shall transition to Sink Standby before a positive or
> > negative voltage transition of VBUS. During Sink Standby
> > the Sink Shall reduce its power draw to pSnkStdby. This allows
> > the Source to manage the voltage transition as well as
> > supply sufficient operating current to the Sink to maintain PD
> > operation during the transition. The Sink Shall
> > complete this transition to Sink Standby within tSnkStdby
> > after evaluating the Accept Message from the Source. The
> > transition when returning to Sink operation from Sink Standby
> > Shall be completed within tSnkNewPower. The
> > pSnkStdby requirement Shall only apply if the Sink power draw
> > is higher than this level.
> >
> > The above requirement needs to be met to prevent hard resets
> > from port partner.
> >
> > Introducing psnkstdby_after_accept flag to accommodate systems
> > where the input current limit loops are not fast enough to meet
> > tSnkStby(15 msec).
> >
> > When not set, port requests PD_P_SNK_STDBY upon entering SNK_DISCOVERY and
> > the actual currrent limit after RX of PD_CTRL_PSRDY for PD link,
> > SNK_READY for non-pd link.
> >
> > When set, port requests CC advertisement based current limit during
> > SNK_DISCOVERY, current gets limited to PD_P_SNK_STDBY during
> > SNK_TRANSITION_SINK, PD based current limit gets set after RX of
> > PD_CTRL_PSRDY. However, in this case it has to be made sure that the
> > tSnkStdby (15 msec) is met.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 52 +++++++++++++++++++++++++++--------
> >  include/linux/usb/pd.h        |  5 +++-
> >  2 files changed, 44 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 3ef37202ee37..e46da41940b9 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -293,9 +293,12 @@ struct tcpm_port {
> >       unsigned int operating_snk_mw;
> >       bool update_sink_caps;
> >
> > -     /* Requested current / voltage */
> > +     /* Set current / voltage */
> >       u32 current_limit;
> >       u32 supply_voltage;
> > +     /* current / voltage requested to partner */
> > +     u32 req_current_limit;
> > +     u32 req_supply_voltage;
>
> I don't see a clear delineation where, when, and why supply_voltage vs. req_supply_voltage
> and current_limit vs. req_current_limit is used. Maybe someone else does and can give a
> Reviewed-by: tag, but for my part I'll have to spend some time trying to understand
> what each variable and its use now means. Overall this suggests that the code may now be
> a bit fragile. If those two sets of variables are now indeed needed, I think it would help
> to have a detailed explanation for each use. This would help reducing the probability
> of errors if the code has to be touched again in the future.
>
> >
> >       /* Used to export TA voltage and current */
> >       struct power_supply *psy;
> > @@ -323,13 +326,27 @@ struct tcpm_port {
> >       struct pd_mode_data mode_data;
> >       struct typec_altmode *partner_altmode[ALTMODE_DISCOVERY_MAX];
> >       struct typec_altmode *port_altmode[ALTMODE_DISCOVERY_MAX];
> > -
> >       /* Deadline in jiffies to exit src_try_wait state */
> >       unsigned long max_wait;
> >
> >       /* port belongs to a self powered device */
> >       bool self_powered;
> >
> > +     /*
> > +      * Honour psnkstdby after accept is received.
> > +      * However, in this case it has to be made sure that the tSnkStdby (15
> > +      * msec) is met.
> > +      *
> > +      * When not set, port requests PD_P_SNK_STDBY_5V upon entering SNK_DISCOVERY and
> > +      * the actual currrent limit after RX of PD_CTRL_PSRDY for PD link,
> > +      * SNK_READY for non-pd link.
> > +      *
> > +      * When set, port requests CC advertisement based current limit during
> > +      * SNK_DISCOVERY, current gets limited to PD_P_SNK_STDBY_5V during SNK_TRANSITION_SINK,
> > +      * PD based current limit gets set after RX of PD_CTRL_PSRDY.
> > +      */
> > +     bool psnkstdby_after_accept;
> > +
> >  #ifdef CONFIG_DEBUG_FS
> >       struct dentry *dentry;
> >       struct mutex logbuffer_lock;    /* log buffer access lock */
> > @@ -1787,9 +1804,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> >               switch (port->state) {
> >               case SNK_TRANSITION_SINK:
> >                       if (port->vbus_present) {
> > -                             tcpm_set_current_limit(port,
> > -                                                    port->current_limit,
> > -                                                    port->supply_voltage);
> > +                             tcpm_set_current_limit(port, port->req_current_limit,
> > +                                                    port->req_supply_voltage);
> >                               port->explicit_contract = true;
> >                               tcpm_set_state(port, SNK_READY, 0);
> >                       } else {
> > @@ -1861,8 +1877,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> >                       break;
> >               case SNK_NEGOTIATE_PPS_CAPABILITIES:
> >                       port->pps_data.active = true;
> > -                     port->supply_voltage = port->pps_data.out_volt;
> > -                     port->current_limit = port->pps_data.op_curr;
> > +                     port->req_supply_voltage = port->pps_data.out_volt;
> > +                     port->req_current_limit = port->pps_data.op_curr;
> >                       tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
> >                       break;
> >               case SOFT_RESET_SEND:
> > @@ -2463,8 +2479,8 @@ static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
> >                        flags & RDO_CAP_MISMATCH ? " [mismatch]" : "");
> >       }
> >
> > -     port->current_limit = ma;
> > -     port->supply_voltage = mv;
> > +     port->req_current_limit = ma;
> > +     port->req_supply_voltage = mv;
> >
> >       return 0;
> >  }
> > @@ -3235,9 +3251,11 @@ static void run_state_machine(struct tcpm_port *port)
> >               break;
> >       case SNK_DISCOVERY:
> >               if (port->vbus_present) {
> > -                     tcpm_set_current_limit(port,
> > -                                            tcpm_get_current_limit(port),
> > -                                            5000);
> > +                     if (port->psnkstdby_after_accept || tcpm_get_current_limit(port) <=
> > +                         PD_P_SNK_STDBY_5V)
> > +                             tcpm_set_current_limit(port, tcpm_get_current_limit(port), 5000);
> > +                     else
> > +                             tcpm_set_current_limit(port, PD_P_SNK_STDBY_5V, 5000);
> >                       tcpm_set_charge(port, true);
> >                       tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
> >                       break;
> > @@ -3318,6 +3336,10 @@ static void run_state_machine(struct tcpm_port *port)
> >               }
> >               break;
> >       case SNK_TRANSITION_SINK:
> > +             if (port->psnkstdby_after_accept)
> > +                     tcpm_set_current_limit(port, tcpm_get_current_limit(port) >
> > +                                            PD_P_SNK_STDBY_5V ? PD_P_SNK_STDBY_5V :
> > +                                            tcpm_get_current_limit(port), 5000);
> >       case SNK_TRANSITION_SINK_VBUS:
> >               tcpm_set_state(port, hard_reset_state(port),
> >                              PD_T_PS_TRANSITION);
> > @@ -3331,6 +3353,10 @@ static void run_state_machine(struct tcpm_port *port)
> >                       port->pwr_opmode = TYPEC_PWR_MODE_PD;
> >               }
> >
> > +             /* Set current limit for NON-PD link when psnkstdby_after_accept is not set*/
> > +             if (!port->pd_capable && !port->psnkstdby_after_accept)
> > +                     tcpm_set_current_limit(port, tcpm_get_current_limit(port), 5000);
> > +
> >               tcpm_swap_complete(port, 0);
> >               tcpm_typec_connect(port);
> >               tcpm_check_send_discover(port);
> > @@ -4513,6 +4539,8 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
> >       port->typec_caps.type = ret;
> >       port->port_type = port->typec_caps.type;
> >
> > +     port->psnkstdby_after_accept = fwnode_property_read_bool(fwnode, "psnkstdby-after-accept");
> > +
>
> I think this will need to be documented.
>
> Guenter
>
> >       if (port->port_type == TYPEC_PORT_SNK)
> >               goto sink;
> >
> > diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> > index b6c233e79bd4..6bd70f77045e 100644
> > --- a/include/linux/usb/pd.h
> > +++ b/include/linux/usb/pd.h
> > @@ -483,5 +483,8 @@ static inline unsigned int rdo_max_power(u32 rdo)
> >  #define PD_N_CAPS_COUNT              (PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
> >  #define PD_N_HARD_RESET_COUNT        2
> >
> > -#define PD_T_BIST_CONT_MODE  50 /* 30 - 60 ms */
> > +#define PD_T_BIST_CONT_MODE  50      /* 30 - 60 ms */
> > +
> > +#define PD_P_SNK_STDBY_5V    500     /* 2500 mw - 500mA @ 5V */
> > +
> >  #endif /* __LINUX_USB_PD_H */
> >
>
