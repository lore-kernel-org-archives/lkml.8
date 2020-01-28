Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A8CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2247E2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2DfUPHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgA1U5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:57:47 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38994 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgA1U5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 15:57:47 -0500
Received: by mail-qk1-f196.google.com with SMTP id w15so13143638qkf.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 12:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EY9ACjvufHnHwIVl89fVknfxB/h80Uwv65UAlyiDjBs=;
        b=L2DfUPHmpUcyE043gQ91C9u21jA1/8wZDlbSMUlXl/qchWUxxTR37xnEpx6VAsH41a
         1aMQCysViUc5tUCWRICpLnnqqPIB3wVh3bSzq+Med/T05LiwII2UQwTeGcuFHAIfCx47
         YdMNfroS46WxdKvHIPvbH7G0qmJbAHxNAz6IAwKX4riCITxWdkA5w0gNPv+IRCq7ChhR
         xoZSeP+wlSFIVyFdBON1aCW6VNXL8zmM3fcJiMGwfkIW6WPMElrtJZadz/EWQdiECbdl
         HhbR1HaqPsMd3wMU2f/t4mbXBUnLs0kszMg+Fc5Dho1Bv6qXjoCL32QGZfBfMqRy2mqp
         cX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EY9ACjvufHnHwIVl89fVknfxB/h80Uwv65UAlyiDjBs=;
        b=YW2XtttYgDYrMuKHvCzAN5GKS/ssnHkHJFQE1R/Xq4ubdl4wAHhCTZUo82v3F/N74z
         50jxpHZ17lsHupV8A5zjfL1TkrORZ5K/kQqzqSY54SKoncQO7cTQIHD7ggI8D9QjpKVM
         Rxvvtl43wfmA5UxqXo/G0nSnQ720w9P9nQi8wqphy6vWKbmnG+VXIecgMOherUI3lsVO
         qir0U2wq3FYpMy9FY6JdcpQrZkhD+VKhVc7RIiPd9sH7wn/D3t0GGAlDyailDXw8N1s1
         ORyK2jkadqVy3+FqMifGceLAz9yWh9a142qH+W7DVT0KdyDRdzGYwChIN5tU8bTp3Un5
         yD0Q==
X-Gm-Message-State: APjAAAURF2mvLBMSm2B2OC0lF/1aSvuqRXzTHtSUSfwT7OCMWF1s0qza
        ea5WCciZK/sSKmVCNHkyNOlpENNN3t149yYiCOLjnCMF
X-Google-Smtp-Source: APXvYqw2aPNUH8E/Kl9vONYjRcB+wvDRfiCwHYGM7cSx+XqW8avpCIr2D+lrn5mfrWx/qtkGglvuV8ERc4a8NsqEtXw=
X-Received: by 2002:a05:620a:b18:: with SMTP id t24mr24059987qkg.341.1580245065636;
 Tue, 28 Jan 2020 12:57:45 -0800 (PST)
MIME-Version: 1.0
References: <20200125012105.59903-1-pmalani@chromium.org> <20200125012105.59903-2-pmalani@chromium.org>
 <feb0ef4d-0f03-9bbc-807e-c385c03ffa71@collabora.com> <CACeCKae4O+MKx3COh=u=28tk21rb4BrzFZgYpnc=tRkigqSP5Q@mail.gmail.com>
 <CAFqH_51agDMFV0xBU_63176TYq0Es0FkCBzBZFoyoCUjwHMSxg@mail.gmail.com> <CACeCKadjmqbaZgOZRnugNOYjusW-jJ0FfF_FN2r+Dg=AJOb9TQ@mail.gmail.com>
In-Reply-To: <CACeCKadjmqbaZgOZRnugNOYjusW-jJ0FfF_FN2r+Dg=AJOb9TQ@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 28 Jan 2020 21:57:34 +0100
Message-ID: <CAFqH_51Uofhu0nmTQ-vYZHqtX+Vt83S2jhybMsngu=QN2EO6iw@mail.gmail.com>
Subject: Re: [PATCH 1/4] platform/chrome: Add EC command msg wrapper
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missatge de Prashant Malani <pmalani@chromium.org> del dia dt., 28 de
gen. 2020 a les 20:29:
>
> Hi Enric,
>
> On Mon, Jan 27, 2020 at 12:36 PM Enric Balletbo Serra
> <eballetbo@gmail.com> wrote:
> >
> > Hi Prashant,
> >
> > Missatge de Prashant Malani <pmalani@chromium.org> del dia dl., 27 de
> > gen. 2020 a les 18:13:
> > >
> > > Hi Enric,
> > >
> > > On Mon, Jan 27, 2020 at 7:29 AM Enric Balletbo i Serra
> > > <enric.balletbo@collabora.com> wrote:
> > > >
> > > > Hi Prashant,
> > > >
> > > > Many thanks for this patch.
> > > >
> > > > On 25/1/20 2:21, Prashant Malani wrote:
> > > > > Many callers of cros_ec_cmd_xfer_status() use a similar set up of
> > > > > allocating and filling a message buffer and then copying any received
> > > > > data to a target buffer.
> > > > >
> > > >
> > > > cros_ec_cmd_xfer_status is already a wrapper, I dislike the idea of having three
> > > > ways to do the same (cros_ec_cmd_xfer, cros_ec_cmd_xfer_status and this new
> > > > one). I like the idea of have a wrapper that embeds the message allocation but
> > > > we should not confuse users with different calls that does the same.
> > > Yes, my intention was to eventually replace all the xfer_status()
> > > call-sites to use the new wrapper, and then get rid of xfer_status
> > > completely.
> > > >
> > > > So, I am for a change like this but I'd like to have all the users calling the
> > > > same wrapper (unless there is a good reason to not use it). A proposed roadmap
> > > > (to be discussed) for this would be.
> > > >
> > > > 1. Replace all the remaining "cros_ec_cmd_xfer" calls with
> > > > "cros_ec_cmd_xfer_status".
> > > > 2. Modify cros_ec_cmd_xfer_status to embed the message allocation.
> > >
> > > How about the following alteration the the roadmap:
> > > - Introducing the new wrapper.
> > > - Replacing all remaining cros_ec_cmd_xfer/cros_ec_cmd_xfer_status to
> > > use the new wrapper.
> > > - Deleting cros_ec_cmd_xfer and cros_ec_cmd_xfer_status ?
> > > My thinking is that this would mean fewer changes at the call-sites
> > > compared to the original roadmap (in the original roadmap, one would
> > > first have to modify calls to use cros_ec_cmd_xfer_status(), and then
> > > modify them again when cros_ec_cmd_xfer_status() itself is modified to
> > > include message allocation).
> > >
> >
> > Sounds like we have a plan, looks good to me.
> >
> Great. Can we use the current series as a starting point for this ?

I'd prefer have all the replacements in the same series.

> I've identified some of the other places which use
> cros_ec_cmd_xfer_status() so can submit subsequent series to convert
> those.
> > Cheers,
> >  Enric
> >
> > > That said I don't have any strong preference, so either would work.
> > >
> > > Best regards,
> > > >
> > > > Thanks,
> > > >  Enric
> > > >
> > > >
> > > > > Create a utility function that performs this setup so that callers can
> > > > > use this function instead.
> > > > >
> > > > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > > > ---
> > > > >  drivers/platform/chrome/cros_ec_proto.c     | 53 +++++++++++++++++++++
> > > > >  include/linux/platform_data/cros_ec_proto.h |  5 ++
> > > > >  2 files changed, 58 insertions(+)
> > > > >
> > > > > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > > > > index da1b1c4504333..8ef3b7d27d260 100644
> > > > > --- a/drivers/platform/chrome/cros_ec_proto.c
> > > > > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > > > > @@ -5,6 +5,7 @@
> > > > >
> > > > >  #include <linux/delay.h>
> > > > >  #include <linux/device.h>
> > > > > +#include <linux/mfd/cros_ec.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/platform_data/cros_ec_commands.h>
> > > > >  #include <linux/platform_data/cros_ec_proto.h>
> > > > > @@ -570,6 +571,58 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> > > > >  }
> > > > >  EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
> > > > >
> > > > > +/**
> > > > > + * cros_ec_send_cmd_msg() - Utility function to send commands to ChromeOS EC.
> > > > > + * @ec: EC device struct.
> > > > > + * @version: Command version number (often 0).
> > > > > + * @command: Command ID including offset.
> > > > > + * @outdata: Data to be sent to the EC.
> > > > > + * @outsize: Size of the &outdata buffer.
> > > > > + * @indata: Data to be received from the EC.
> > > > > + * @insize: Size of the &indata buffer.
> > > > > + *
> > > > > + * This function is a wrapper around &cros_ec_cmd_xfer_status, and performs
> > > > > + * some of the common work involved with sending a command to the EC. This
> > > > > + * includes allocating and filling up a &struct cros_ec_command message buffer,
> > > > > + * and copying the received data to another buffer.
> > > > > + *
> > > > > + * Return: The number of bytes transferred on success or negative error code.
> > > > > + */
> > > > > +int cros_ec_send_cmd_msg(struct cros_ec_device *ec, unsigned int version,
> > > > > +                      unsigned int command, void *outdata,
> > > > > +                      unsigned int outsize, void *indata,
> > > > > +                      unsigned int insize)
> > > > > +{
> > > > > +     struct cros_ec_command *msg;
> > > > > +     int ret;
> > > > > +
> > > > > +     msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> > > > > +     if (!msg)
> > > > > +             return -ENOMEM;
> > > > > +
> > > > > +     msg->version = version;
> > > > > +     msg->command = command;
> > > > > +     msg->outsize = outsize;
> > > > > +     msg->insize = insize;
> > > > > +
> > > > > +     if (outdata && outsize > 0)
> > > > > +             memcpy(msg->data, outdata, outsize);
> > > > > +
> > > > > +     ret = cros_ec_cmd_xfer_status(ec, msg);
> > > > > +     if (ret < 0) {
> > > > > +             dev_warn(ec->dev, "Command failed: %d\n", msg->result);
> > > > > +             goto cleanup;
> > > > > +     }
> > > > > +
> > > > > +     if (insize)
> > > > > +             memcpy(indata, msg->data, insize);
> > > > > +
> > > > > +cleanup:
> > > > > +     kfree(msg);
> > > > > +     return ret;
> > > > > +}
> > > > > +EXPORT_SYMBOL(cros_ec_send_cmd_msg);
> > > > > +
> > > > >  static int get_next_event_xfer(struct cros_ec_device *ec_dev,
> > > > >                              struct cros_ec_command *msg,
> > > > >                              struct ec_response_get_next_event_v1 *event,
> > > > > diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> > > > > index 30098a5515231..166ce26bdd79e 100644
> > > > > --- a/include/linux/platform_data/cros_ec_proto.h
> > > > > +++ b/include/linux/platform_data/cros_ec_proto.h
> > > > > @@ -201,6 +201,11 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
> > > > >  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> > > > >                           struct cros_ec_command *msg);
> > > > >
> > > > > +int cros_ec_send_cmd_msg(struct cros_ec_device *ec_dev, unsigned int version,
> > > > > +                      unsigned int command, void *outdata,
> > > > > +                      unsigned int outsize, void *indata,
> > > > > +                      unsigned int insize);
> > > > > +
> > > > >  int cros_ec_register(struct cros_ec_device *ec_dev);
> > > > >
> > > > >  int cros_ec_unregister(struct cros_ec_device *ec_dev);
> > > > >
