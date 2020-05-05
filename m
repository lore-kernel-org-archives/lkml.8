Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2086EC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1922206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XkL6QWqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgEEVbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 17:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728934AbgEEVbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 17:31:10 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9907AC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 14:31:10 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w6so259793ilg.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 14:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSMJEcrrPFJfW4nZlz3cVr6Bp3kHuUwEUpc8owgGBkw=;
        b=XkL6QWqocAbZq6PynW+0ownlXnERTI9K4TzRK9ayYRZEfq05NqnqEoRtq43yaEBF8u
         mk+RPINjGHu2zBUfsEJ1b4J7orTvVuSqYC5F73tH+T6AMsOPG+F4tf5ZiqGlGRqjMk16
         xJ9WDpzBucRjGmEPcHb2KGTPfP0Ye8+cTGWVId53CNTKUISzGf9R/aCPlzj5u2rEoly7
         HCeAm7ktJ/QtW+A/H2YlXDgAw9khSLIJWF5Sym8TIbZ8/WDG01EMrYbznI6sB4+WQ7Lz
         TQXUwwTeHtyAujAh8tQe5D/ABvS3ezRA+chxEXXYh2+kxKsRobIfsXvOMyYQ2QNxefvj
         nVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSMJEcrrPFJfW4nZlz3cVr6Bp3kHuUwEUpc8owgGBkw=;
        b=AODJuYiJvEGY7zt2GUh2iUSe1UD+GyreNvwwkUvYEUUuGkz6Pe6OlB9krm286ny2az
         PB6NgYmgNEO+BRS4HW9ZIqbZiroG46SdP4mwnrUa5BsxtJYz0d+hoc+ml/jn4FAcUnoz
         0QhktGI6iBd7IndJtdYMCHoDshg3yIkDY34cfrOxVFFzGI85/E1rSCqXklDRs1lvxPAi
         vR6mmuzU7Nc4XNlRHQGE4ZlCQmFw3fdQa9VKuaY/zey8Sc5YU0fZQ+m3WQTjxaERz/vg
         qn8n153ckBkH2vTkOldviA1jjw9YwimMoiYZLR81WgB3/UTngc181AWqI8FpIY2twWz3
         Jphg==
X-Gm-Message-State: AGi0PuYLxSxUxzlHpucep31+l5jUBtFehKGOdXwRuMpBWmKcVFV5vjTv
        VOisuGSCW4M3T2Mn72WEdgG9j+QEajB70eu9ZZVrQQ==
X-Google-Smtp-Source: APiQypLwkXGrlAgrUz/kxxhM46NKzEIghVNHFoLU+E1NvkKPDJ+YmpE7I9/ObNR9CchyQ+SiVmnnOI/GsKEkxppnsto=
X-Received: by 2002:a92:740e:: with SMTP id p14mr5701264ilc.57.1588714269787;
 Tue, 05 May 2020 14:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200504215830.31394-1-mathieu.poirier@linaro.org>
 <20200504215830.31394-3-mathieu.poirier@linaro.org> <976bfec3-17bc-1f52-d235-77b34321404c@st.com>
In-Reply-To: <976bfec3-17bc-1f52-d235-77b34321404c@st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 5 May 2020 15:30:58 -0600
Message-ID: <CANLsYkxirXKy49PsHzypq1kNs=Z9cZAhG07bjBFo1Sj9cL75NA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] rpmsg: core: Add support to retrieve name extension
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 at 02:07, Arnaud POULIQUEN <arnaud.pouliquen@st.com> wrote:
>
> Hi Mathieu,
>
>
>
> On 5/4/20 11:58 PM, Mathieu Poirier wrote:
> > After adding support for rpmsg device name extension, this patch
> > provides a function that returns the extension portion of an rpmsg
> > device name.  That way users of the name extension functionality don't
> > have to write the same boiler plate code to extract the information.
> I do not test it yet,but LGTM.
> I plan to use these patches for the rpmsg_tty.
> Please find few remarks below.
>
> >
> > Suggested-by: Suman Anna <s-anna@ti.com>;
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/rpmsg/rpmsg_core.c | 92 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/rpmsg.h      | 13 ++++++
> >  2 files changed, 105 insertions(+)
> >
> > diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> > index 5e01e8dede6b..dae87c0cb73d 100644
> > --- a/drivers/rpmsg/rpmsg_core.c
> > +++ b/drivers/rpmsg/rpmsg_core.c
> > @@ -439,6 +439,98 @@ static int rpmsg_dev_match(struct device *dev, struct device_driver *drv)
> >       return of_driver_match_device(dev, drv);
> >  }
> >
> > +/**
> > + * rpmsg_device_get_name_extension() - get the name extension of a rpmsg device
> > + * @rpdev: the rpmsg device to work with
> > + * @skip: how many characters in the extension should be skipped over
> > + *
> > + * With function rpmsg_id_match() allowing for extension of the base driver name
> > + * in order to differentiate services, this function returns the extension part
> > + * of an rpmsg device name.  As such and with the following rpmsg driver device
> > + * id table and rpmsg device names:
> > + *
> > + * static struct rpmsg_device_id rpmsg_driver_sample_id_table[] = {
> > + *      { .name = "rpmsg-client-sample" },
> > + *      { },
> > + * }
> > + *
> > + * rpdev1->id.name == "rpmsg-client-sample";
> > + * rpdev2->id.name == "rpmsg-client-sample_instance0";
> > + *
> > + * Calling rpmsg_device_get_name_extension() will yields the following:
> > + *
> > + * rpmsg_device_get_name_extension(rpdev1, 0) == NULL;
> > + * rpmsg_device_get_name_extension(rpdev2, 0) == "_instance0";
> > + * rpmsg_device_get_name_extension(rpdev2, 1) == "instance0";
> > + *
> > + *
> > + * Note: The name extension should be free'd using kfree_const().
> > + *
> > + * Return: the name extension if found, NULL if not found and an error
> > + * code otherwise.
> > + */
> > +const char *rpmsg_device_get_name_extension(struct rpmsg_device *rpdev,
> > +                                         unsigned int skip)
> > +{
> > +     const char *drv_name, *dev_name, *extension;
> > +     const struct rpmsg_device_id *ids;
> > +     struct device *dev = &rpdev->dev;
> > +     struct rpmsg_driver *rpdrv;
> > +     bool match = false;
> > +     unsigned int i;
> > +
> > +     if (!dev->driver)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     rpdrv = to_rpmsg_driver(dev->driver);
> > +
> > +     /*
> > +      * No point in going further if the device and the driver don't
> > +      * have a name or a table to work with.
> > +      */
> > +     if (!rpdev->id.name[0] || !rpdrv->id_table)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     ids = rpdrv->id_table;
> > +     dev_name = rpdev->id.name;
> > +
> > +     /*
> > +      * See if any name in the driver's table match the beginning
> > +      * of the rpmsg device's name.
> > +      */
> > +     for (i = 0; ids[i].name[0]; i++) {
> > +             drv_name = ids[i].name;
> > +             if (strncmp(drv_name,
> > +                         dev_name, strlen(drv_name)) == 0) {
> > +                     match = true;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     if (!match)
> > +             return NULL;
> here i would return an error to differentiate unmatch and name without extension.

That's a fair point.

> > +
> > +      /* No name extension to return if device and driver are the same */
> > +     if (strlen(dev_name) == strlen(drv_name))
> > +             return NULL;
> > +
> > +     /*
> > +      * Make sure we were not requested to skip past the end
> > +      * of the device name.
> > +      */
> > +     if (strlen(drv_name) + skip >= strlen(dev_name))
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     /*
> > +      * Move past the base name published by the driver and
> > +      * skip any extra characters if needed.
> > +      */
> > +     extension = dev_name + strlen(drv_name) + skip;
> > +
> > +     return kstrdup_const(extension, GFP_KERNEL);
> what about just returning the extension pointer?
> rpdev->id.name should be valid until device is unregistered.

I grappled with that...  I didn't know all the scenarios people would
use this for and where the returned string would end up so I decided
to play it safe.  Does anyone else have an opinion on this?  Am I too
cautious?

>
> Regards
> Arnaud
>
> > +}
> > +EXPORT_SYMBOL(rpmsg_device_get_name_extension);
> > +
> >  static int rpmsg_uevent(struct device *dev, struct kobj_uevent_env *env)
> >  {
> >       struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> > diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> > index 9fe156d1c018..9537b95ad30a 100644
> > --- a/include/linux/rpmsg.h
> > +++ b/include/linux/rpmsg.h
> > @@ -135,6 +135,9 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
> >  __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
> >                       poll_table *wait);
> >
> > +const char *rpmsg_device_get_name_extension(struct rpmsg_device *dev,
> > +                                         unsigned int skip);
> > +
> >  #else
> >
> >  static inline int register_rpmsg_device(struct rpmsg_device *dev)
> > @@ -242,6 +245,16 @@ static inline __poll_t rpmsg_poll(struct rpmsg_endpoint *ept,
> >       return 0;
> >  }
> >
> > +static inline
> > +const char *rpmsg_device_get_name_extension(struct rpmsg_device *dev,
> > +                                         unsigned int skip)
> > +{
> > +     /* This shouldn't be possible */
> > +     WARN_ON(1);
> > +
> > +     return NULL;
> > +}
> > +
> >  #endif /* IS_ENABLED(CONFIG_RPMSG) */
> >
> >  /* use a macro to avoid include chaining to get THIS_MODULE */
> >
