Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E32C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D827207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCNHUCaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgH1Ot5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgH1Otp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:49:45 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E79C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:49:45 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id t189so298545vka.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcqUUPdr/umD2pWC4NsvVbmxb5fCA12Uxq69aXRfr0o=;
        b=wCNHUCaw7Le0VGnSa8RivY7ZMCA0au8zTO2M/ds9hsm3vRcIn+K7hH3J7DBnolJ7JA
         PQbFVEPm6MGnt52tcIGmbqwLVASwQ8l3OL1QFZz8S7XIBhj1a89khlX2dZCGaF5kMsqy
         +xFFAoXerlNOzQAMzCTV1IAQdikvVjY69ULl+RUQKfrYWAU4XzFnrvh2deIPPlVyezXJ
         dzqOntNCMIBYKpGNA5nsb71XMvKG4aeu9cggP1/iQrT2XvEscjeFT9O3KqZ1Zq9Uhb/m
         nacNtbMVtgr+Tx1m1FbuMosKavVETXgnSs9N3nEsMK0rhjXiXVV+kYq3QL9bokAx3WOj
         j+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcqUUPdr/umD2pWC4NsvVbmxb5fCA12Uxq69aXRfr0o=;
        b=AO1mL85hXRBfXDI9/XGmjPiE2OFfKpT6K18X0Ufik5z4VXzeRWiiIFASWn1xhdyUz1
         laztgOBqL8d/Bxw3fxJyhbVJkE8U8YzaC5RKHtEWXSoYc4Ljpr4BsVhhqfZlLgR/Co8J
         l80Ne76A7aZlVJXeXF82co2j1uwoK1XHY0OYPsyQHzzWvtUWxWUkrwNLTDBnJg+UYg5b
         7UQmSHk0KNe5lEO/XxrANQrDRXo43JzZVsbXem4Tj8mzbToalnpZZL+ouhpjAls2tJh/
         ZyxIk4e30CMJFbQxxSwOM/9xt2Ig77kUy8COs0AymKbLr3PGofiVnz1AfQ7FzA/vZv2s
         ammg==
X-Gm-Message-State: AOAM5315RG94SFNwLJp98o963zgaqZX4T50kK1b2epg0SpNlxY8cDwTC
        GJorgjotahECKyk0hKUa+xE9K1O/i4rxQl6av+tOfQ==
X-Google-Smtp-Source: ABdhPJziKZmHuzDoUCZdZNu39nIz/3TJOOrx0fiZZDSDps6xosGzRKxSkYsFgAeBfIQLhZxo+dIA+bIT+SRCJvXS5dA=
X-Received: by 2002:a1f:2cd0:: with SMTP id s199mr1319049vks.25.1598626184206;
 Fri, 28 Aug 2020 07:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200825042210.300632-1-badhri@google.com> <20200825042210.300632-3-badhri@google.com>
 <20200828131214.GH174928@kuha.fi.intel.com>
In-Reply-To: <20200828131214.GH174928@kuha.fi.intel.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Fri, 28 Aug 2020 07:49:08 -0700
Message-ID: <CAPTae5K=RFN4kX-QzEY2Y8iDbqAaEeS-KjTR5XHfdRZ40Lu5-w@mail.gmail.com>
Subject: Re: [PATCH 02/14 v2] usb: typec: tcpci: Add support when hidden tx
 registers are inaccessible
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 6:12 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Looks like you forgot v1 somewhere :-)


Dumb me :P Yeah I was doing the patch numbers manually causing the confusion.
Greg was complaining as well.
These are all v1. I will re-upload everything as v2. Just noticed that
I can use the -v option.

>
>
> On Mon, Aug 24, 2020 at 09:21:58PM -0700, Badhri Jagan Sridharan wrote:
> > TCPCI spec forbids direct access of TX_BUF_BYTE_x register.
> > The existing version of tcpci driver assumes that those registers
> > are directly addressible. Add support for tcpci chips which do
> > not support direct access to TX_BUF_BYTE_x registers. TX_BUF_BYTE_x
> > can only be accessed by I2C_WRITE_BYTE_COUNT.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpci.c | 49 +++++++++++++++++++++++++---------
> >  drivers/usb/typec/tcpm/tcpci.h |  8 ++++++
> >  2 files changed, 44 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> > index f57d91fd0e09..90d348caa6a8 100644
> > --- a/drivers/usb/typec/tcpm/tcpci.c
> > +++ b/drivers/usb/typec/tcpm/tcpci.c
> > @@ -320,8 +320,7 @@ static int tcpci_set_vbus(struct tcpc_dev *tcpc, bool source, bool sink)
> >       return 0;
> >  }
> >
> > -static int tcpci_pd_transmit(struct tcpc_dev *tcpc,
> > -                          enum tcpm_transmit_type type,
> > +static int tcpci_pd_transmit(struct tcpc_dev *tcpc, enum tcpm_transmit_type type,
> >                            const struct pd_message *msg)
>
> That does not look like a relevant change.
>
> >  {
> >       struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> > @@ -330,23 +329,47 @@ static int tcpci_pd_transmit(struct tcpc_dev *tcpc,
> >       int ret;
> >
> >       cnt = msg ? pd_header_cnt(header) * 4 : 0;
> > -     ret = regmap_write(tcpci->regmap, TCPC_TX_BYTE_CNT, cnt + 2);
> > -     if (ret < 0)
> > -             return ret;
> > +     /**
> > +      * TCPCI spec forbids direct access of TCPC_TX_DATA.
> > +      * But, since some of the chipsets offer this capability,
> > +      * it's fair to support both.
> > +      */
> > +     if (!tcpci->data->TX_BUF_BYTE_x_hidden) {
>
> Couldn't check if the flag is set first?

Yes will do !

>
>         if (tcpci->data->TX_BUF_BYTE_x_hidden) {
>                 ...
>
> > +             ret = regmap_write(tcpci->regmap, TCPC_TX_BYTE_CNT, cnt + 2);
> > +             if (ret < 0)
> > +                     return ret;
> >
> > -     ret = tcpci_write16(tcpci, TCPC_TX_HDR, header);
> > -     if (ret < 0)
> > -             return ret;
> > +             ret = tcpci_write16(tcpci, TCPC_TX_HDR, header);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             if (cnt > 0) {
> > +                     ret = regmap_raw_write(tcpci->regmap, TCPC_TX_DATA, &msg->payload, cnt);
> > +                     if (ret < 0)
> > +                             return ret;
> > +             }
> > +     } else {
> > +             u8 buf[TCPC_TRANSMIT_BUFFER_MAX_LEN] = {0,};
> > +             u8 pos = 0;
> > +
> > +             /* Payload + header + TCPC_TX_BYTE_CNT */
> > +             buf[pos++] = cnt + 2;
> > +
> > +             if (msg)
> > +                     memcpy(&buf[pos], &msg->header, sizeof(msg->header));
> > +
> > +             pos += sizeof(header);
> > +
> > +             if (cnt > 0)
> > +                     memcpy(&buf[pos], msg->payload, cnt);
> >
> > -     if (cnt > 0) {
> > -             ret = regmap_raw_write(tcpci->regmap, TCPC_TX_DATA,
> > -                                    &msg->payload, cnt);
> > +             pos += cnt;
> > +             ret = regmap_raw_write(tcpci->regmap, TCPC_TX_BYTE_CNT, buf, pos);
> >               if (ret < 0)
> >                       return ret;
> >       }
> >
> > -     reg = (PD_RETRY_COUNT << TCPC_TRANSMIT_RETRY_SHIFT) |
> > -             (type << TCPC_TRANSMIT_TYPE_SHIFT);
> > +     reg = (PD_RETRY_COUNT << TCPC_TRANSMIT_RETRY_SHIFT) | (type << TCPC_TRANSMIT_TYPE_SHIFT);
> >       ret = regmap_write(tcpci->regmap, TCPC_TRANSMIT, reg);
> >       if (ret < 0)
> >               return ret;
> > diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> > index fd26ca35814c..cf9d8b63adcb 100644
> > --- a/drivers/usb/typec/tcpm/tcpci.h
> > +++ b/drivers/usb/typec/tcpm/tcpci.h
> > @@ -128,9 +128,17 @@
> >  #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG               0x76
> >  #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG               0x78
> >
> > +/* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRITE_BYTE_COUNT */
> > +#define TCPC_TRANSMIT_BUFFER_MAX_LEN         31
> > +
> > +/*
> > + * @TX_BUF_BYTE_x_hidden
> > + *           optional; Set when TX_BUF_BYTE_x can only be accessed through I2C_WRITE_BYTE_COUNT.
> > + */
> >  struct tcpci;
> >  struct tcpci_data {
> >       struct regmap *regmap;
> > +     unsigned char TX_BUF_BYTE_x_hidden:1;
> >       int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
> >       int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
> >                        bool enable);
> > --
> > 2.28.0.297.g1956fa8f8d-goog
>
> thanks,
>
> --
> heikki
