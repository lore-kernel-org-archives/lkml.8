Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C43C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EDD21739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VdNGGxK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgA1Wou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:44:50 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33723 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgA1Wou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:44:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so11708102qto.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 14:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRR38murihY//Uv8kBvAKrvgS/INySylAxlYuYLORVo=;
        b=VdNGGxK/Iz/A8IEmUkkj4mlPEU9wiJksm+IG/Z/oGiunEFpNyEQwRn85tbAqVxDINO
         hkMamsZPBObTqGjx8mhLYDY7zASiM7xZw4hC7UXyzofC2Ga1PExjkmAcxTEi+Ra7owI5
         /93TaKm3izhBWBFV+S8dY7385npuLlfFiPQqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRR38murihY//Uv8kBvAKrvgS/INySylAxlYuYLORVo=;
        b=nEYVMYEtl4T9bmSXqJ4Y0yYPIwflltP3tVJW+UhwHT7pxwDg14mRAHXuw/hy+Eccpt
         XEGXKxqO6asJOv63wdkGljiNZYN5hNLfoufupZsN7nftj+VsnA7UD+v/aXem5zk6mWjM
         eDv6495PzGoDIilsdQo+Nq4ePVhBxrrJgBtWuqEu5gUFC7ITr6ayFHSzhz1wWWHADa0L
         LV5U03FWX6W+EnQ307gWIUGX1b9BWjFZnIz4YFi04jQY0dsTFxdq8K5GtX26fir8gQ/v
         MFQqGwWOFddxodn8ZXrJfKPwmxIp8GhoSc3DIlErQI0ZKl0h3Ny1/bTFY3QtSWsa3sIZ
         +eWw==
X-Gm-Message-State: APjAAAXEbd1z8jUV5rZfYSy/ILG9ge9tMpgw8TWbn/1eTnnyl9jqXr7a
        kRHf3H8IYO+kI3BMMusOSNvSv6rte/NjGy3Yi7EFtPpO
X-Google-Smtp-Source: APXvYqyMPvta2ptKUi5aGEzwTtYYa7eYrFNCpQDq27B4W513i8eaFa+/KE5+zQIyIEGXIJEsD2wDtz7Q0Wy3jRngrFA=
X-Received: by 2002:ac8:1e90:: with SMTP id c16mr23911332qtm.265.1580251489057;
 Tue, 28 Jan 2020 14:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20200125012105.59903-1-pmalani@chromium.org> <20200125012105.59903-2-pmalani@chromium.org>
 <feb0ef4d-0f03-9bbc-807e-c385c03ffa71@collabora.com> <CACeCKae4O+MKx3COh=u=28tk21rb4BrzFZgYpnc=tRkigqSP5Q@mail.gmail.com>
 <CAFqH_51agDMFV0xBU_63176TYq0Es0FkCBzBZFoyoCUjwHMSxg@mail.gmail.com>
 <CACeCKadjmqbaZgOZRnugNOYjusW-jJ0FfF_FN2r+Dg=AJOb9TQ@mail.gmail.com> <CAFqH_51Uofhu0nmTQ-vYZHqtX+Vt83S2jhybMsngu=QN2EO6iw@mail.gmail.com>
In-Reply-To: <CAFqH_51Uofhu0nmTQ-vYZHqtX+Vt83S2jhybMsngu=QN2EO6iw@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 28 Jan 2020 14:44:37 -0800
Message-ID: <CACeCKad79TqyJJv=qweHUNmQWww21UrEuk3CgZyzTkWYdj8-rA@mail.gmail.com>
Subject: Re: [PATCH 1/4] platform/chrome: Add EC command msg wrapper
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(responding again, since previous response was in richtext)


On Tue, Jan 28, 2020 at 12:57 PM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>
> Missatge de Prashant Malani <pmalani@chromium.org> del dia dt., 28 de
> gen. 2020 a les 20:29:
> >
> > Hi Enric,
> >
> > On Mon, Jan 27, 2020 at 12:36 PM Enric Balletbo Serra
> > <eballetbo@gmail.com> wrote:
> > >
> > > Hi Prashant,
> > >
> > > Missatge de Prashant Malani <pmalani@chromium.org> del dia dl., 27 de
> > > gen. 2020 a les 18:13:
> > > >
> > > > Hi Enric,
> > > >
> > > > On Mon, Jan 27, 2020 at 7:29 AM Enric Balletbo i Serra
> > > > <enric.balletbo@collabora.com> wrote:
> > > > >
> > > > > Hi Prashant,
> > > > >
> > > > > Many thanks for this patch.
> > > > >
> > > > > On 25/1/20 2:21, Prashant Malani wrote:
> > > > > > Many callers of cros_ec_cmd_xfer_status() use a similar set up of
> > > > > > allocating and filling a message buffer and then copying any received
> > > > > > data to a target buffer.
> > > > > >
> > > > >
> > > > > cros_ec_cmd_xfer_status is already a wrapper, I dislike the idea of having three
> > > > > ways to do the same (cros_ec_cmd_xfer, cros_ec_cmd_xfer_status and this new
> > > > > one). I like the idea of have a wrapper that embeds the message allocation but
> > > > > we should not confuse users with different calls that does the same.
> > > > Yes, my intention was to eventually replace all the xfer_status()
> > > > call-sites to use the new wrapper, and then get rid of xfer_status
> > > > completely.
> > > > >
> > > > > So, I am for a change like this but I'd like to have all the users calling the
> > > > > same wrapper (unless there is a good reason to not use it). A proposed roadmap
> > > > > (to be discussed) for this would be.
> > > > >
> > > > > 1. Replace all the remaining "cros_ec_cmd_xfer" calls with
> > > > > "cros_ec_cmd_xfer_status".
> > > > > 2. Modify cros_ec_cmd_xfer_status to embed the message allocation.
> > > >
> > > > How about the following alteration the the roadmap:
> > > > - Introducing the new wrapper.
> > > > - Replacing all remaining cros_ec_cmd_xfer/cros_ec_cmd_xfer_status to
> > > > use the new wrapper.
> > > > - Deleting cros_ec_cmd_xfer and cros_ec_cmd_xfer_status ?
> > > > My thinking is that this would mean fewer changes at the call-sites
> > > > compared to the original roadmap (in the original roadmap, one would
> > > > first have to modify calls to use cros_ec_cmd_xfer_status(), and then
> > > > modify them again when cros_ec_cmd_xfer_status() itself is modified to
> > > > include message allocation).
> > > >
> > >
> > > Sounds like we have a plan, looks good to me.
> > >
> > Great. Can we use the current series as a starting point for this ?
>
> I'd prefer have all the replacements in the same series.
Thanks for the clarification. I will begin work on this.
>
> > I've identified some of the other places which use
> > cros_ec_cmd_xfer_status() so can submit subsequent series to convert
> > those.
> > > Cheers,
> > >  Enric
> > >
> > > > That said I don't have any strong preference, so either would work.
> > > >
> > > > Best regards,
> > > > >
> > > > > Thanks,
> > > > >  Enric
> > > > >
> > > > >
> > > > > > Create a utility function that performs this setup so that callers can
> > > > > > use this function instead.
> > > > > >
> > > > > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > > > > ---
> > > > > >  drivers/platform/chrome/cros_ec_proto.c     | 53 +++++++++++++++++++++
> > > > > >  include/linux/platform_data/cros_ec_proto.h |  5 ++
> > > > > >  2 files changed, 58 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > > > > > index da1b1c4504333..8ef3b7d27d260 100644
> > > > > > --- a/drivers/platform/chrome/cros_ec_proto.c
> > > > > > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > > > > > @@ -5,6 +5,7 @@
> > > > > >
> > > > > >  #include <linux/delay.h>
> > > > > >  #include <linux/device.h>
> > > > > > +#include <linux/mfd/cros_ec.h>
> > > > > >  #include <linux/module.h>
> > > > > >  #include <linux/platform_data/cros_ec_commands.h>
> > > > > >  #include <linux/platform_data/cros_ec_proto.h>
> > > > > > @@ -570,6 +571,58 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> > > > > >  }
> > > > > >  EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
> > > > > >
> > > > > > +/**
> > > > > > + * cros_ec_send_cmd_msg() - Utility function to send commands to ChromeOS EC.
> > > > > > + * @ec: EC device struct.
> > > > > > + * @version: Command version number (often 0).
> > > > > > + * @command: Command ID including offset.
> > > > > > + * @outdata: Data to be sent to the EC.
> > > > > > + * @outsize: Size of the &outdata buffer.
> > > > > > + * @indata: Data to be received from the EC.
> > > > > > + * @insize: Size of the &indata buffer.
> > > > > > + *
> > > > > > + * This function is a wrapper around &cros_ec_cmd_xfer_status, and performs
> > > > > > + * some of the common work involved with sending a command to the EC. This
> > > > > > + * includes allocating and filling up a &struct cros_ec_command message buffer,
> > > > > > + * and copying the received data to another buffer.
> > > > > > + *
> > > > > > + * Return: The number of bytes transferred on success or negative error code.
> > > > > > + */
> > > > > > +int cros_ec_send_cmd_msg(struct cros_ec_device *ec, unsigned int version,
> > > > > > +                      unsigned int command, void *outdata,
> > > > > > +                      unsigned int outsize, void *indata,
> > > > > > +                      unsigned int insize)
> > > > > > +{
> > > > > > +     struct cros_ec_command *msg;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> > > > > > +     if (!msg)
> > > > > > +             return -ENOMEM;
> > > > > > +
> > > > > > +     msg->version = version;
> > > > > > +     msg->command = command;
> > > > > > +     msg->outsize = outsize;
> > > > > > +     msg->insize = insize;
> > > > > > +
> > > > > > +     if (outdata && outsize > 0)
> > > > > > +             memcpy(msg->data, outdata, outsize);
> > > > > > +
> > > > > > +     ret = cros_ec_cmd_xfer_status(ec, msg);
> > > > > > +     if (ret < 0) {
> > > > > > +             dev_warn(ec->dev, "Command failed: %d\n", msg->result);
> > > > > > +             goto cleanup;
> > > > > > +     }
> > > > > > +
> > > > > > +     if (insize)
> > > > > > +             memcpy(indata, msg->data, insize);
> > > > > > +
> > > > > > +cleanup:
> > > > > > +     kfree(msg);
> > > > > > +     return ret;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL(cros_ec_send_cmd_msg);
> > > > > > +
> > > > > >  static int get_next_event_xfer(struct cros_ec_device *ec_dev,
> > > > > >                              struct cros_ec_command *msg,
> > > > > >                              struct ec_response_get_next_event_v1 *event,
> > > > > > diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> > > > > > index 30098a5515231..166ce26bdd79e 100644
> > > > > > --- a/include/linux/platform_data/cros_ec_proto.h
> > > > > > +++ b/include/linux/platform_data/cros_ec_proto.h
> > > > > > @@ -201,6 +201,11 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
> > > > > >  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> > > > > >                           struct cros_ec_command *msg);
> > > > > >
> > > > > > +int cros_ec_send_cmd_msg(struct cros_ec_device *ec_dev, unsigned int version,
> > > > > > +                      unsigned int command, void *outdata,
> > > > > > +                      unsigned int outsize, void *indata,
> > > > > > +                      unsigned int insize);
> > > > > > +
> > > > > >  int cros_ec_register(struct cros_ec_device *ec_dev);
> > > > > >
> > > > > >  int cros_ec_unregister(struct cros_ec_device *ec_dev);
> > > > > >
