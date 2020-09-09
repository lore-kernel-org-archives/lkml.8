Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762FFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2889821D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FB387YjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgIIHEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgIIHAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:00:09 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F232DC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 00:00:07 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id b79so1192593wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 00:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0T1xsgL8KLicvdVgVXLl7s0tEv0E1jWAmUmJuZvE6M=;
        b=FB387YjF0O6z0PHyDFeCCLcy3kWqNJt7oO3U0OstfwqkQ+XYxn9kG2V06bZcnD+89I
         U94+cHwlpttdMWHUaX2aou0JDOPG1WrblqY9S5Qv1sR9dLlfPmNacb83UByeOv5age4o
         4XIiU8aSpcOZSzga3NNYCiEptWUcr7L8htrO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0T1xsgL8KLicvdVgVXLl7s0tEv0E1jWAmUmJuZvE6M=;
        b=DDUgeYOXg5vQ7S6ieg+PVMEQ8n+DNXvUdfSL7YiDVivEXXe55O+RBv4ob59Qb2tu5Z
         X0ByfhRap1oWUp8I8lz8QZpBimu5BoXJ5HI4kvGrAJLrixmP51eZ3f9cwfCChdZG2AHM
         wz58p8Z8vItoFbMyRkN3s9A4CpppMfhsWOOmIwtoN0V4yq37um+qUdqeUwNufXE8V2sC
         OgV0GRc9zImedN8OT7TbzhvdrDZyuQUT6TUrOcvkDPIDwKwBiPPF+G/Xttl10jhc0nd8
         9T3Es68J5kMJKxe3UqG38P/wdYNDh5/WnKov/lcvnEQojj76ZF2aFF+ibCkIMuVCBNoe
         0p5g==
X-Gm-Message-State: AOAM5310xeJSKYX41B3HNk58FTxbTq8q6Vq0FWJ+7/EhN32FZSGlEFyr
        PR10qWDxAStPZbWDD+uBxl6YehbVf75La3P+3SrHvA==
X-Google-Smtp-Source: ABdhPJwinfaFAdsCsDojdsyX6Fk+9P/lQi6aByGWz4YFFegaUm9jLw/oMWdy1Oa5TFgKOyNI7g30Nt2iV7pNUjidmsA=
X-Received: by 2002:a1c:99c7:: with SMTP id b190mr1997587wme.44.1599634806373;
 Wed, 09 Sep 2020 00:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200901162133.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
 <20200901162133.4.I900b1b80709b7632a47d0ddb4cd375b4a3616c9e@changeid> <2f1e64e4-bb37-0cfb-6b3b-3f51fd5faca3@xs4all.nl>
In-Reply-To: <2f1e64e4-bb37-0cfb-6b3b-3f51fd5faca3@xs4all.nl>
From:   Sam McNally <sammc@chromium.org>
Date:   Wed, 9 Sep 2020 16:59:29 +1000
Message-ID: <CAJqEsoB6V6LWoY-whLGV74tamxppObPtNqWYMUyqtwAgnjrhPQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm_dp_cec: add plumbing in preparation for MST support
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        David Francis <David.Francis@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Leo Li <sunpeng.li@amd.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        dri-devel@lists.freedesktop.org,
        Manasi Navare <manasi.d.navare@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Sep 2020 at 18:41, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 01/09/2020 08:22, Sam McNally wrote:
> > From: Hans Verkuil <hans.verkuil@cisco.com>
> >
> > Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> > [sammc@chromium.org:
> >  - rebased
> >  - removed polling-related changes
> >  - moved the calls to drm_dp_cec_(un)set_edid() into the next patch
> > ]
> > Signed-off-by: Sam McNally <sammc@chromium.org>
> > ---
> >
> >  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  2 +-
> >  drivers/gpu/drm/drm_dp_cec.c                  | 22 ++++++++++---------
> >  drivers/gpu/drm/i915/display/intel_dp.c       |  2 +-
> >  drivers/gpu/drm/nouveau/nouveau_connector.c   |  2 +-
> >  include/drm/drm_dp_helper.h                   |  6 +++--
> >  5 files changed, 19 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > index 461fa4da0a34..6e7075893ec9 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > @@ -419,7 +419,7 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
> >
> >       drm_dp_aux_init(&aconnector->dm_dp_aux.aux);
> >       drm_dp_cec_register_connector(&aconnector->dm_dp_aux.aux,
> > -                                   &aconnector->base);
> > +                                   &aconnector->base, false);
> >
> >       if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_eDP)
> >               return;
> > diff --git a/drivers/gpu/drm/drm_dp_cec.c b/drivers/gpu/drm/drm_dp_cec.c
> > index 3ab2609f9ec7..04ab7b88055c 100644
> > --- a/drivers/gpu/drm/drm_dp_cec.c
> > +++ b/drivers/gpu/drm/drm_dp_cec.c
> > @@ -14,6 +14,7 @@
> >  #include <drm/drm_connector.h>
> >  #include <drm/drm_device.h>
> >  #include <drm/drm_dp_helper.h>
> > +#include <drm/drm_dp_mst_helper.h>
> >
> >  /*
> >   * Unfortunately it turns out that we have a chicken-and-egg situation
> > @@ -338,8 +339,6 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
> >       if (aux->cec.adap) {
> >               if (aux->cec.adap->capabilities == cec_caps &&
> >                   aux->cec.adap->available_log_addrs == num_las) {
> > -                     /* Unchanged, so just set the phys addr */
> > -                     cec_s_phys_addr_from_edid(aux->cec.adap, edid);
> >                       goto unlock;
> >               }
> >               /*
> > @@ -364,15 +363,16 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
> >       if (cec_register_adapter(aux->cec.adap, connector->dev->dev)) {
> >               cec_delete_adapter(aux->cec.adap);
> >               aux->cec.adap = NULL;
> > -     } else {
> > -             /*
> > -              * Update the phys addr for the new CEC adapter. When called
> > -              * from drm_dp_cec_register_connector() edid == NULL, so in
> > -              * that case the phys addr is just invalidated.
> > -              */
> > -             cec_s_phys_addr_from_edid(aux->cec.adap, edid);
> >       }
> >  unlock:
> > +     /*
> > +      * Update the phys addr for the new CEC adapter. When called
> > +      * from drm_dp_cec_register_connector() edid == NULL, so in
> > +      * that case the phys addr is just invalidated.
> > +      */
>
> The comment is no longer in sync with the code: if EDID == NULL, then
> nothing is done due to the edid check in the 'if' below.
>
> > +     if (aux->cec.adap && edid) {
>
> I think this should just be: if (aux->cec.adap)
>
> Also, the {} aren't necessary here.
>
> > +             cec_s_phys_addr_from_edid(aux->cec.adap, edid);
> > +     }
> >       mutex_unlock(&aux->cec.lock);
> >  }
> >  EXPORT_SYMBOL(drm_dp_cec_set_edid);
>
> Frankly, the changes to this function should be dropped completely, from
> what I can see they are not necessary. It was done in my original patch
> because of the way I handled mst, but you did it differently (and I think
> better), so these changes are no longer needed.
>
> I know I am actually commenting on my old patch, but that patch was from a
> work-in-progress git branch and was never meant as a 'proper' patch.
>
> However, what complicates matters is that after digging a bit more I discovered
> that commit 732300154980 ("drm: Do not call drm_dp_cec_set_edid() while registering
> DP connectors") changed drm_dp_cec_register_connector() so that it no longer
> calls drm_dp_cec_set_edid(), but the comments there and in this function were
> not updated. It would be nice if you can add a patch fixing these outdated
> comments.
>
> Regardless of that change in commit 732300154980, the edid pointer can still be
> NULL and the existing behavior should be kept (i.e. create a CEC device, but with
> an invalid physical address since there is no EDID for some reason).
>
> Regards,
>
>         Hans
>

Thanks. Leaving drm_dp_cec_set_edid() unchanged combined with Lyude's
suggestion to use aux->is_remote removes the need for this patch
entirely.

> > @@ -418,6 +418,7 @@ EXPORT_SYMBOL(drm_dp_cec_unset_edid);
> >   * drm_dp_cec_register_connector() - register a new connector
> >   * @aux: DisplayPort AUX channel
> >   * @connector: drm connector
> > + * @is_mst: set to true if this is an MST branch
> >   *
> >   * A new connector was registered with associated CEC adapter name and
> >   * CEC adapter parent device. After registering the name and parent
> > @@ -425,12 +426,13 @@ EXPORT_SYMBOL(drm_dp_cec_unset_edid);
> >   * CEC and to register a CEC adapter if that is the case.
> >   */
> >  void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
> > -                                struct drm_connector *connector)
> > +                                struct drm_connector *connector, bool is_mst)
> >  {
> >       WARN_ON(aux->cec.adap);
> >       if (WARN_ON(!aux->transfer))
> >               return;
> >       aux->cec.connector = connector;
> > +     aux->cec.is_mst = is_mst;
> >       INIT_DELAYED_WORK(&aux->cec.unregister_work,
> >                         drm_dp_cec_unregister_work);
> >  }
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> > index 82b9de274f65..744cb55572f9 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -6261,7 +6261,7 @@ intel_dp_connector_register(struct drm_connector *connector)
> >       intel_dp->aux.dev = connector->kdev;
> >       ret = drm_dp_aux_register(&intel_dp->aux);
> >       if (!ret)
> > -             drm_dp_cec_register_connector(&intel_dp->aux, connector);
> > +             drm_dp_cec_register_connector(&intel_dp->aux, connector, false);
> >       return ret;
> >  }
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> > index 49dd0cbc332f..671a70e95cd1 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> > @@ -1414,7 +1414,7 @@ nouveau_connector_create(struct drm_device *dev,
> >       switch (type) {
> >       case DRM_MODE_CONNECTOR_DisplayPort:
> >       case DRM_MODE_CONNECTOR_eDP:
> > -             drm_dp_cec_register_connector(&nv_connector->aux, connector);
> > +             drm_dp_cec_register_connector(&nv_connector->aux, connector, false);
> >               break;
> >       }
> >
> > diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> > index 85513eeb2196..12bca1b9512b 100644
> > --- a/include/drm/drm_dp_helper.h
> > +++ b/include/drm/drm_dp_helper.h
> > @@ -1495,12 +1495,14 @@ struct drm_connector;
> >   * @lock: mutex protecting this struct
> >   * @adap: the CEC adapter for CEC-Tunneling-over-AUX support.
> >   * @connector: the connector this CEC adapter is associated with
> > + * @is_mst: this is an MST branch
> >   * @unregister_work: unregister the CEC adapter
> >   */
> >  struct drm_dp_aux_cec {
> >       struct mutex lock;
> >       struct cec_adapter *adap;
> >       struct drm_connector *connector;
> > +     bool is_mst;
> >       struct delayed_work unregister_work;
> >  };
> >
> > @@ -1746,7 +1748,7 @@ drm_dp_has_quirk(const struct drm_dp_desc *desc, u32 edid_quirks,
> >  #ifdef CONFIG_DRM_DP_CEC
> >  void drm_dp_cec_irq(struct drm_dp_aux *aux);
> >  void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
> > -                                struct drm_connector *connector);
> > +                                struct drm_connector *connector, bool is_mst);
> >  void drm_dp_cec_unregister_connector(struct drm_dp_aux *aux);
> >  void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid);
> >  void drm_dp_cec_unset_edid(struct drm_dp_aux *aux);
> > @@ -1757,7 +1759,7 @@ static inline void drm_dp_cec_irq(struct drm_dp_aux *aux)
> >
> >  static inline void
> >  drm_dp_cec_register_connector(struct drm_dp_aux *aux,
> > -                           struct drm_connector *connector)
> > +                           struct drm_connector *connector, bool is_mst)
> >  {
> >  }
> >
> >
>
