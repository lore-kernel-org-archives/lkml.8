Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED125C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27922064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i8ZRofNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633583AbgDNWoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729629AbgDNWof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:44:35 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAC9C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:44:35 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 20so7218719qkl.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxbRJvmK1dkdxzV18+LiaeJoEhBZWZkg4rYjC5U9q7Q=;
        b=i8ZRofNb0pliu9K5po+RsooXTlGUkyUrzdWtEDbDym464SK3t3VyKXfOVyJPh8PA9a
         QPlcMWCCigXKVqSj4nS28c3RYDG1w6l3+EvXL4a6y7INZSoaElou5J0ns6idFLJ7OtqU
         COpt9E5ByXYI0XbfMuAHjsWJ0B790YIDieJhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxbRJvmK1dkdxzV18+LiaeJoEhBZWZkg4rYjC5U9q7Q=;
        b=OwmHNwPUKWIYP5GCWu8JXVOKCLupIlz1JOa9T7X7Mk+oCppl0nH8rgn02HF7PWbQZ7
         x+f0w5xU4lgmRy6KHrteT6GdaYOolGu00BDIWutyx+S9+jYh/FUlcZ0uYOy0cZS0QzF7
         sTFY9VRkthrSsiqwpjW/FINzlyCIkR0JUCwsoS49U8vef902cdrURHJtPJPJYjgniVuW
         Nqt3JxOzLIipfkr3YBAq5d9PHGJV/p1FqHPUWjxnS3v5yNUaitT6v8NAUz4Lu0sVBGi0
         bdVSGfWh2B5lqkbAbQDGQ//kREgPirfY8BJEuQsdUuRSfamIdaFF/Yd45eNPdz81V/Zm
         Rlvg==
X-Gm-Message-State: AGi0PuY/t+S98rMSZWW1fkq5y5+2WiEjfOZjrysWBIie49BuLnJr0b4w
        4Hkvr6S4w+jPbES8SEGtjmViIRNngOIWwISl4nY+kw==
X-Google-Smtp-Source: APiQypIO9M6eY1XkDQABdfZWLLUaFtLMTyZqyqFgQIRu3jCijK+G/Jw3FoTGzL8VdT0UxnILM05WyLaYW/tjfAgtX/c=
X-Received: by 2002:ae9:dd02:: with SMTP id r2mr21859004qkf.180.1586904271480;
 Tue, 14 Apr 2020 15:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200410002316.202107-1-pmalani@chromium.org> <20200410002316.202107-4-pmalani@chromium.org>
 <025802e6-207c-305a-8146-3c07a3f36bb4@collabora.com>
In-Reply-To: <025802e6-207c-305a-8146-3c07a3f36bb4@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 14 Apr 2020 15:44:19 -0700
Message-ID: <CACeCKadwCYeLN5jrJMsqwoD_iHFWLTdrBHTWOQTqQEWnW1Xa+Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] platform/chrome: typec: Register port partner
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jon Flatley <jflat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review Enric,

On Tue, Apr 14, 2020 at 7:08 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> Thank you for your patch.
>
> On 10/4/20 2:23, Prashant Malani wrote:
> > Register (and unregister) the port partner when a connect (and
> > disconnect) is detected.
> >
> > Co-developed-by: Jon Flatley <jflat@chromium.org>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >
> > Changes in v3:
> > - No changes.
> >
> > Changes in v2:
> > - Fixed error pointer return value.
> >
> >  drivers/platform/chrome/cros_ec_typec.c | 48 +++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 56ded09a60ffb..304e0b20f279b 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -22,6 +22,9 @@ struct cros_typec_port {
> >       struct typec_port *port;
> >       /* Initial capabilities for the port. */
> >       struct typec_capability caps;
> > +     struct typec_partner *partner;
> > +     /* Port partner PD identity info. */
> > +     struct usb_pd_identity p_identity;
> >  };
> >
> >  /* Platform-specific data for the Chrome OS EC Type C controller. */
> > @@ -190,6 +193,30 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
> >       return ret;
> >  }
> >
> > +static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
> > +                               bool pd_en)
> > +{
> > +     struct cros_typec_port *port = typec->ports[port_num];
> > +     struct typec_partner_desc p_desc = {
> > +             .usb_pd = pd_en,
> > +     };
> > +     int ret = 0;
> > +
> > +     /*
> > +      * Fill an initial PD identity, which will then be updated with info
> > +      * from the EC.
> > +      */
> > +     p_desc.identity = &port->p_identity;
> > +
> > +     port->partner = typec_register_partner(port->port, &p_desc);
> > +     if (IS_ERR_OR_NULL(port->partner)) {
> > +             ret = PTR_ERR(port->partner);
>
> If you're checking for IS_ERR_OR_NULL that means that port->partner can be NULL,
> so PTR_ERR(NULL) is 0 returning something that you don't really want.
>
> But looking at the typec_register_partner, NULL is not an option as returns a
> handle to the partner on success or ERR_PTR on failure. So, the code should just do:
>
> if (IS_ERR(port->partner))
>     return PTR_ERR(port->partner);
Will update the patch to do this on the next version, thanks.
>
> And AFAICS you don't need to set port->partner to NULL.
>
> Can you double check this?
I think we will need it, since we check for it in
cros_typec_set_port_params_v1() to avoid double registration of a
partner:

+       /* Register/remove partners when a connect/disconnect occurs. */
+       if (resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED) {
+               if (typec->ports[port_num]->partner)
+                       return;

So if it is not set to NULL on error earlier, the registration won't
take place here (in case another PD notification comes in while the
PD_CTRL_RESP_ENABLED_CONNECTED bit is still set). Kindly correct me if
this understanding is incorrect.

Best regards,

-Prashant

>
> Thanks,
>  Enric
>
> > +             port->partner = NULL;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >  static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
> >               int port_num, struct ec_response_usb_pd_control *resp)
> >  {
> > @@ -212,6 +239,8 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
> >  {
> >       struct typec_port *port = typec->ports[port_num]->port;
> >       enum typec_orientation polarity;
> > +     bool pd_en;
> > +     int ret;
> >
> >       if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
> >               polarity = TYPEC_ORIENTATION_NONE;
> > @@ -226,6 +255,25 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
> >                       TYPEC_SOURCE : TYPEC_SINK);
> >       typec_set_vconn_role(port, resp->role & PD_CTRL_RESP_ROLE_VCONN ?
> >                       TYPEC_SOURCE : TYPEC_SINK);
> > +
> > +     /* Register/remove partners when a connect/disconnect occurs. */
> > +     if (resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED) {
> > +             if (typec->ports[port_num]->partner)
> > +                     return;
> > +
> > +             pd_en = resp->enabled & PD_CTRL_RESP_ENABLED_PD_CAPABLE;
> > +             ret = cros_typec_add_partner(typec, port_num, pd_en);
> > +             if (!ret)
> > +                     dev_warn(typec->dev,
> > +                              "Failed to register partner on port: %d\n",
> > +                              port_num);
> > +     } else {
> > +             if (!typec->ports[port_num]->partner)
> > +                     return;
> > +
> > +             typec_unregister_partner(typec->ports[port_num]->partner);
> > +             typec->ports[port_num]->partner = NULL;
> > +     }
> >  }
> >
> >  static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
> >
