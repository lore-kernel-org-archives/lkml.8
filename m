Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8198AC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1992083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LXMvrDdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbgGaGRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731152AbgGaGRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 02:17:31 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F172FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 23:17:30 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id l84so13306325oig.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 23:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66o0OMFmlbFpLFWMFNrEoa+yOxFl93bjoU+tv4t23Nw=;
        b=LXMvrDdAbnjAMTPQL1+TXLcIQnzZOiALJbcpVyb7IcoGbbKn9CBDz8kVcjt8yEHnAt
         2SQCS2Ark4lH/yVr4iq32vXSkGmu7qCx3nUbiJiZS/oUQaN/lZNBZzDF+RzgNwE7QuaO
         RFN92Q6982qO2rilh0mZ56KXTQJnv5hp+r+vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66o0OMFmlbFpLFWMFNrEoa+yOxFl93bjoU+tv4t23Nw=;
        b=Hr3Bua8V98bcaSYz1+s9dlixI9i6LSVarnPOf0CftnEUj/HjZG3T6TLncjDSfMkPi4
         ruqIISLwajLMYCeaDDTKSAofjMn2wUP2Ob5yggwuUrgn6rxh/kUzdSbw7EyuQixEJPvb
         +8V/pLEBxszl/ZlpNzRUOo0v6ep6N/mwB4H1LJGTNz0woUebg90y/kljVTAbPfgy6MLZ
         vViPC4lJNeoKGIjPBp7xZ1c2jv3VPk6AOUmzykBP2SrHUPqADVu+G0xdPtOgpSh+MHVF
         seiSwNVYJJ9Sx3/LmjV5L6lA2+OOPzObD6oWg5Z4azGbvpe2Y4XmbI/f4Rlyp7Gwh3lf
         3KAw==
X-Gm-Message-State: AOAM530wrocIlL4quiTY4hXkcgRPJluV3fsMzloGUehDHsWF5hWnJCGU
        ZjQ0kMg49XexLg7e1xguPczjWNKC8Hf2v0auDeiL4g==
X-Google-Smtp-Source: ABdhPJx8PtLtmc2rRopFwO3W50YwSFnbvzJo3D8EAy1O84zrWGMG2bTe22gAmCbwKmvyJGKwez3Mv2EURO6CGn36T60=
X-Received: by 2002:aca:ab87:: with SMTP id u129mr1861262oie.128.1596176250399;
 Thu, 30 Jul 2020 23:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200703094506.22527-1-andy.yan@rock-chips.com> <3359f775-ba70-c116-e9b9-29b9ba692400@rock-chips.com>
In-Reply-To: <3359f775-ba70-c116-e9b9-29b9ba692400@rock-chips.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 31 Jul 2020 08:17:19 +0200
Message-ID: <CAKMK7uFLPOkv_WkBbcJicqEWP9FFqHJ=0xt+SHwgghTSTuXgbg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/connector: Add of_drm_find_connector
To:     Andy Yan <andy.yan@rock-chips.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 4:33 AM Andy Yan <andy.yan@rock-chips.com> wrote:
>
> ping
>
> On 7/3/20 5:45 PM, Andy Yan wrote:
> > Add a function to look up a connector by
> > device tree node, like what of_drm_find_bridge/panel
> > does.
> >
> > Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> > Reported-by: kernel test robot <lkp@intel.com>

I'm pretty sure the answer is "no", but without a user for this it's
impossible to tell I guess. Always send out the patches using new
stuff together with the new stuff.
-Daniel

> >
> > ---
> >
> > Changes in v2:
> > - Add function declaration
> >
> >   drivers/gpu/drm/drm_connector.c | 33 +++++++++++++++++++++++++++++++++
> >   include/drm/drm_connector.h     | 14 ++++++++++++++
> >   2 files changed, 47 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > index d877ddc6dc57..516376cd1868 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -743,6 +743,39 @@ void drm_connector_list_iter_end(struct drm_connector_list_iter *iter)
> >   }
> >   EXPORT_SYMBOL(drm_connector_list_iter_end);
> >
> > +#ifdef CONFIG_OF
> > +/**
> > + * of_drm_find_connector - look up a connector using a device tree node
> > + * @np: device tree node of the connector
> > + *
> > + *
> > + * Return: A pointer to the connector which match the specified device tree
> > + * node or NULL if no panel matching the device tree node can be found, or
> > + * -ENODEV: the device is not available (status != "okay" or "ok")
> > + */
> > +struct drm_connector *of_drm_find_connector(struct drm_device *dev, const struct device_node *np)
> > +{
> > +     struct drm_connector *connector;
> > +     struct drm_connector_list_iter conn_iter;
> > +
> > +     if (!of_device_is_available(np))
> > +             return ERR_PTR(-ENODEV);
> > +
> > +     drm_connector_list_iter_begin(dev, &conn_iter);
> > +     drm_for_each_connector_iter(connector, &conn_iter) {
> > +             if (connector->of_node == np) {
> > +                     drm_connector_list_iter_end(&conn_iter);
> > +                     return connector;
> > +             }
> > +     }
> > +     drm_connector_list_iter_end(&conn_iter);
> > +
> > +     return NULL;
> > +}
> > +EXPORT_SYMBOL(of_drm_find_connector);
> > +#endif
> > +
> > +
> >   static const struct drm_prop_enum_list drm_subpixel_enum_list[] = {
> >       { SubPixelUnknown, "Unknown" },
> >       { SubPixelHorizontalRGB, "Horizontal RGB" },
> > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > index fd543d1db9b2..d249e0498375 100644
> > --- a/include/drm/drm_connector.h
> > +++ b/include/drm/drm_connector.h
> > @@ -1129,6 +1129,9 @@ struct drm_connector {
> >       /** @attr: sysfs attributes */
> >       struct device_attribute *attr;
> >
> > +     /** @of_node: device tree node */
> > +     struct device_node *of_node;
> > +
> >       /**
> >        * @head:
> >        *
> > @@ -1647,6 +1650,17 @@ void drm_connector_list_iter_end(struct drm_connector_list_iter *iter);
> >   bool drm_connector_has_possible_encoder(struct drm_connector *connector,
> >                                       struct drm_encoder *encoder);
> >
> > +#if defined(CONFIG_OF)
> > +struct drm_connector *
> > +of_drm_find_connector(struct drm_device *dev, const struct device_node *np);
> > +#else
> > +static inline struct drm_connector *
> > +of_drm_find_connector(struct drm_device *dev, const struct device_node *np)
> > +{
> > +     return ERR_PTR(-ENODEV);
> > +}
> > +#endif
> > +
> >   /**
> >    * drm_for_each_connector_iter - connector_list iterator macro
> >    * @connector: &struct drm_connector pointer used as cursor
>
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
