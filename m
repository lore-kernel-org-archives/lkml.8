Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B0AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A15E2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSgR+Kar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgHKSpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKSpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:45:10 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A978CC06174A;
        Tue, 11 Aug 2020 11:45:09 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f193so8085823pfa.12;
        Tue, 11 Aug 2020 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ysg6ArT/BdSqmf7uvpJsHiv9LSdfSfwOFM5PbYO/rU8=;
        b=LSgR+KarMWtq0AS6v813KDDwXoZWtv0h74cggUKP1aDJIch6LWIDOcAsvpZY0NA5pE
         UyO3bnasoHoCF8CzcU3BwNEAxOGcNbG/O0ltBd5nNdsX2uZzwr3hic0KNGQlaEYpvRuY
         o7CCuPSTPV+BL614RlP8enhbb/uoHQq/MRKc175DmSl2WDhJwfM9t/LjaYuFWauz7res
         pZzfqJnCmQMZRETAeuoche16GDpT8Owybd6ik9jUgH3uVWvvsoR/jUlh2qpNoonkrbzK
         hcE85zub0KXajl67s+rPDp55DrPkyXp+DWA8mizecCYRmliAiYe7/pAMVLHe9Qm6wUXp
         swrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ysg6ArT/BdSqmf7uvpJsHiv9LSdfSfwOFM5PbYO/rU8=;
        b=Yb8f/KANkGRxfAIdjd1O1obxY8dhrGYbeBCViGwpCTXRkpNuGgzTlMLdfIcmzJ5kXa
         PYSv0ZRCs5/0a5XGc1BAUNAySoTrrvCqksFhdZU+EwgzeoQ4FK8xJncXUCMdMUJW3wBs
         NNvQfQywlgbp2NV3KFnzCXwx2UshVsJd2ELFVvFraLQKTRArilGjnJ+4MryAFgYS8Str
         qKOsqkJZBpk/gLajW69iFDHTKq5yrJsNz+ZJA46w3d3leNQpIYjcPrfLtex2ceemaiJQ
         mC6zaRGjKRQhIPvxyJYq/xAIgny2ztTjPT3TUQUnxZkaSQAacYQOcrHW7vKxPCCW25W8
         cGMw==
X-Gm-Message-State: AOAM533zvlhAWk6qWS/vZqyVYSGlFVc9YzyhyACthfEP/BHrPdtqnFAH
        MegLjge3Cw5e8fakVKiwIpo=
X-Google-Smtp-Source: ABdhPJyuW5P0qZ0pma2ZXlZZCwMXqoM94Oz94lKBCcP42JtpKXvVuHlL8WKRVOKRTnW6J+TY/z2RBQ==
X-Received: by 2002:a63:3484:: with SMTP id b126mr1786309pga.297.1597171509154;
        Tue, 11 Aug 2020 11:45:09 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y72sm27623620pfg.58.2020.08.11.11.45.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Aug 2020 11:45:08 -0700 (PDT)
Date:   Tue, 11 Aug 2020 11:45:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] usb: typec: tcpm: Fix TDA 2.2.1.1 and TDA 2.2.1.2
 failures
Message-ID: <20200811184507.GB86545@roeck-us.net>
References: <20200811011126.130297-1-badhri@google.com>
 <ef32ea96-16c8-772b-2c80-8df43ee8f668@roeck-us.net>
 <CAPTae5Lhty3rJymi-4gANjUoz79_LujdjddS9oT=vpOxTSecdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTae5Lhty3rJymi-4gANjUoz79_LujdjddS9oT=vpOxTSecdQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:24:07AM -0700, Badhri Jagan Sridharan wrote:
> On Mon, Aug 10, 2020 at 6:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 8/10/20 6:11 PM, Badhri Jagan Sridharan wrote:
> > >>From the spec:
> > > "7.1.5 Response to Hard Resets
> > > Hard Reset Signaling indicates a communication failure has occurred and
> > > the Source Shall stop driving VCONN, Shall remove Rp from the VCONN pin
> > > and Shall drive VBUS to vSafe0V as shown in Figure 7-9. The USB connection
> > > May reset during a Hard Reset since the VBUS voltage will be less than
> > > vSafe5V for an extended period of time. After establishing the vSafe0V
> > > voltage condition on VBUS, the Source Shall wait tSrcRecover before
> > > re-applying VCONN and restoring VBUS to vSafe5V. A Source Shall conform
> > > to the VCONN timing as specified in [USB Type-C 1.3]."
> > >
> > > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > > ---
> > >  drivers/usb/typec/tcpm/tcpm.c | 16 +++++++++++++---
> > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > > index 3ef37202ee37..e41c4e5d3c71 100644
> > > --- a/drivers/usb/typec/tcpm/tcpm.c
> > > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > @@ -3372,13 +3372,19 @@ static void run_state_machine(struct tcpm_port *port)
> > >                       tcpm_set_state(port, SNK_HARD_RESET_SINK_OFF, 0);
> > >               break;
> > >       case SRC_HARD_RESET_VBUS_OFF:
> > > -             tcpm_set_vconn(port, true);
> > > +             /*
> > > +              * 7.1.5 Response to Hard Resets
> > > +              * Hard Reset Signaling indicates a communication failure has occurred and the
> > > +              * Source Shall stop driving VCONN, Shall remove Rp from the VCONN pin and Shall
> > > +              * drive VBUS to vSafe0V as shown in Figure 7-9.
> > > +              */
> > > +             tcpm_set_vconn(port, false);
> > >               tcpm_set_vbus(port, false);
> > >               tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
> > >                              tcpm_data_role_for_source(port));
> > > -             tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
> >
> > I am a bit concerned about this. If I understand correctly, it means that
> > we won't turn VBUS back on unless a SRC_HARD_RESET_VBUS_OFF PD event is received.
> > Is that correct ? What happens if that event is never received ?
> >
> > Thanks,
> > Guenter
> 
> The term PD event is a little ambiguous to me. Trying to summarize the workflow.
> Lower level tcpc driver would have to call tcpm_vbus_change which
> would in-turn trigger TCPM_VBUS_EVENT
> and queries port->tcpc->get_vbus to get the vbus status. It is not
> really a PD protocol driven event hence the
> confusion.
> 
> "What happens if that event is never received ?"
> Yeah TCPM would be in SRC_HARD_RESET_VBUS_OFF till the tcpc calls the
> tcpm_vbus_change.
> Do you suspect that existing tcpc would not have the capability to
> monitor vbus status while sourcing and call tcpm_vbus_change?
> 
That, or the driver might be buggy, or the hardware does't signal a status
update, or the update gets lost. I think we should have some backup,
to trigger if the event is not received in a reasonable amout of time.
I don't know if the specification has some kind of maximum limit. If
not, we should still have something.

Thanks,
Guenter

> Thanks,
> Badhri
> 
> 
> > >               break;
> > >       case SRC_HARD_RESET_VBUS_ON:
> > > +             tcpm_set_vconn(port, true);
> > >               tcpm_set_vbus(port, true);
> > >               port->tcpc->set_pd_rx(port->tcpc, true);
> > >               tcpm_set_attached_state(port, true);
> > > @@ -3944,7 +3950,11 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
> > >               tcpm_set_state(port, SNK_HARD_RESET_WAIT_VBUS, 0);
> > >               break;
> > >       case SRC_HARD_RESET_VBUS_OFF:
> > > -             tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, 0);
> > > +             /*
> > > +              * After establishing the vSafe0V voltage condition on VBUS, the Source Shall wait
> > > +              * tSrcRecover before re-applying VCONN and restoring VBUS to vSafe5V.
> > > +              */
> > > +             tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
> > >               break;
> > >       case HARD_RESET_SEND:
> > >               break;
> > >
> >
