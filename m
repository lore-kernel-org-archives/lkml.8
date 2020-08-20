Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C900DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85546207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R0Ilo9pb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHTC1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgHTC1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 22:27:48 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294C6C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 19:27:46 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p18so497404ilm.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 19:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1iRO5PUEwoxn+BQDVff7Q0S8DqLabJs/zvwZKudU08=;
        b=R0Ilo9pbEwV1QcELP/G0YHafJ62sW9RW+n0w4aAnjroypno1+q7aUWPEZLH3nVkOg0
         xANF+WKw1jpfmzx/hivpmyxc/LJDY8Y2PaEyWSBzlcCwJupAqPwL2eOykaublqH24k+z
         p0ExxkF/14tS8NEohByRUhzseRbMqB5ucSmEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1iRO5PUEwoxn+BQDVff7Q0S8DqLabJs/zvwZKudU08=;
        b=FprlRnhGfXNpd37W3DPJs2HwYGLgUUmhLTZk7pITPQdWkjQ8WsNXhrE9H1A0Zern0g
         BFPh+5sw4wECyTPbL0Hmk4c6qv/e2cUi2WUGmZuG7chulvoRj9jhd3Ap6Ev2gJEdb3lF
         1C7+iCy4EJRJgDn5TfB37uKODD8IOJxf1JvRI0LHZs8AOmRLsrTTcTve1DuHD66deKEA
         ZMQJ3WnIm0rfDNGxSHv7WFefD5+g+lT0wWomqeevnIZL9Mu09nZZNJGeLyZxmbmpnK3M
         30mU4VMAfo7S3f4NSkJLOQSn+RfoRoR5J2Rfk2YbOP8zLBwbE6XTrJmpCZm+g/N9dCsU
         cUOw==
X-Gm-Message-State: AOAM532+8lhfiSERgjDVefAjHsjwpJHa1ZYSQdz5UXVVWlcnLUEk6LEt
        455XywEdeJBsOODs6LAqY1IPUkNv7q9NweS8juZOaA==
X-Google-Smtp-Source: ABdhPJxv7K/m2IZrGcCWyjSvDQaMV8kZsnsd/h081uSL046DJj5W3lKLzWNjXHh4FXImnh1IPHtNpwfKP6pb7szuRM0=
X-Received: by 2002:a92:d086:: with SMTP id h6mr831618ilh.205.1597890462056;
 Wed, 19 Aug 2020 19:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200729161510.1.Iaa9c3d7c4332cf8717653f3d3ae6f2b955aa3fc6@changeid>
 <20200814145956.GA12962@ideak-desk.fi.intel.com>
In-Reply-To: <20200814145956.GA12962@ideak-desk.fi.intel.com>
From:   Sam McNally <sammc@chromium.org>
Date:   Thu, 20 Aug 2020 12:27:03 +1000
Message-ID: <CAJqEsoCAR-3NNL+pD4QeUWioq-uLdEdZwNrPVkzjULM39KiayA@mail.gmail.com>
Subject: Re: [PATCH] drm/dp_mst: Add ddc i2c device links for DP MST connectors
To:     imre.deak@intel.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback.

On Sat, 15 Aug 2020 at 01:00, Imre Deak <imre.deak@intel.com> wrote:
>
> On Wed, Jul 29, 2020 at 04:15:28PM +1000, Sam McNally wrote:
> > As of commit d8bd15b37d32 ("drm/dp_mst: Fix the DDC I2C device
> > registration of an MST port"), DP MST DDC I2C devices are consistently
> > parented to the underlying DRM device, making it challenging to
> > associate the ddc i2c device with its connector from userspace.
>
> I can't see how was it less challenging before the commit. There is no
> guarantee for a CSN message which was the only way for the i2c device to
> get reparented to the connector.
>

Yes, that's true - the state before and after are both unable to
support ddc reliable i2c device discovery, and consistency is better.
The challenging part certainly is an ongoing affair - I wasn't
intending to blame it on that commit, though it has come out that way,
unfortunately. Looking at it now, that paragraph doesn't need to
reference any commits in particular; I'll rewrite it for the next
version.

> > Given the need for further refactoring before the i2c devices can be
> > parented to their connectors, in the meantime follow the pattern of
> > commit e1a29c6c5955 ("drm: Add ddc link in sysfs created by
> > drm_connector"), creating sysfs ddc links to the associated i2c device
> > for MST DP connectors.
> >
> > If the connector is created and registered before the i2c device, create
> > the link when registering the i2c device; otherwise, create the link
> > during late connector registration.
> >
> > Signed-off-by: Sam McNally <sammc@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 29 +++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 1ac874e4e7a1..73a2299c2faa 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -2161,11 +2161,23 @@ static void build_mst_prop_path(const struct drm_dp_mst_branch *mstb,
> >  int drm_dp_mst_connector_late_register(struct drm_connector *connector,
> >                                      struct drm_dp_mst_port *port)
> >  {
> > +     int ret;
> >       DRM_DEBUG_KMS("registering %s remote bus for %s\n",
> >                     port->aux.name, connector->kdev->kobj.name);
> >
> >       port->aux.dev = connector->kdev;
> > -     return drm_dp_aux_register_devnode(&port->aux);
> > +     ret = drm_dp_aux_register_devnode(&port->aux);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (port->pdt != DP_PEER_DEVICE_NONE &&
> > +         drm_dp_mst_is_end_device(port->pdt, port->mcs)) {
>
> How can we get here when drm_dp_mst_is_end_device(port) is not true?
> AFAICS that's only case where we should create a connector and an i2c
> device. (IOW we don't create them for branch ports.)
>

I'm not sure what you mean. Wouldn't this condition be checked during
the registration of any MST connector? This follows the pattern used
in drm_dp_mst_port_add_connector() [0], which seems like it's invoked
in the same cases as drm_dp_mst_connector_late_register(), modulo
early outs for errors.

[0] https://cgit.freedesktop.org/drm-tip/tree/drivers/gpu/drm/drm_dp_mst_topology.c?id=1939e049a8ec6cef03a098f7cc99cb0bbcff21c6#n2188



> > +             ret = sysfs_create_link(&port->connector->kdev->kobj,
> > +                                     &port->aux.ddc.dev.kobj, "ddc");
> > +             if (ret)
> > +                     drm_dp_aux_unregister_devnode(&port->aux);
> > +     }
> > +     return ret;
> >  }
> >  EXPORT_SYMBOL(drm_dp_mst_connector_late_register);
> >
> > @@ -5490,6 +5502,7 @@ static int drm_dp_mst_register_i2c_bus(struct drm_dp_mst_port *port)
> >  {
> >       struct drm_dp_aux *aux = &port->aux;
> >       struct device *parent_dev = port->mgr->dev->dev;
> > +     int ret;
> >
> >       aux->ddc.algo = &drm_dp_mst_i2c_algo;
> >       aux->ddc.algo_data = aux;
> > @@ -5504,7 +5517,17 @@ static int drm_dp_mst_register_i2c_bus(struct drm_dp_mst_port *port)
> >       strlcpy(aux->ddc.name, aux->name ? aux->name : dev_name(parent_dev),
> >               sizeof(aux->ddc.name));
> >
> > -     return i2c_add_adapter(&aux->ddc);
> > +     ret = i2c_add_adapter(&aux->ddc);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (port->connector && port->connector->kdev) {
> > +             ret = sysfs_create_link(&port->connector->kdev->kobj,
> > +                                     &port->aux.ddc.dev.kobj, "ddc");
> > +             if (ret)
> > +                     i2c_del_adapter(&port->aux.ddc);
> > +     }
> > +     return ret;
> >  }
> >
> >  /**
> > @@ -5513,6 +5536,8 @@ static int drm_dp_mst_register_i2c_bus(struct drm_dp_mst_port *port)
> >   */
> >  static void drm_dp_mst_unregister_i2c_bus(struct drm_dp_mst_port *port)
> >  {
> > +     if (port->connector && port->connector->kdev)
> > +             sysfs_remove_link(&port->connector->kdev->kobj, "ddc");
> >       i2c_del_adapter(&port->aux.ddc);
> >  }
> >
> > --
> > 2.28.0.rc0.142.g3c755180ce-goog
> >
