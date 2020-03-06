Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23E8C3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A248E2070A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocXty+wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCFDfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:35:52 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38694 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgCFDfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:35:52 -0500
Received: by mail-lf1-f68.google.com with SMTP id x22so714498lff.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 19:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ql3XQZSHAFVJhV4jpmhJbcc5iMOUhyMAEyck+GDMAQU=;
        b=ocXty+wai9fTVsC4CX6z3BibnVwOowVIPWh4X00X3U2Qxu7lpawKX/RpiJabae20PN
         Pb2TtNtokHEVUDIQbj8UaOzXQv7+yp8JpJ7UEiphFuiT4IMbxBw5qN3nSFY/EHyPmueQ
         PVPzPsvzH+xOdzcbKrquvduvzW7iSbCzymmMCkV6v4uXadZ7LGy4XPpk3UapMF1F5lp4
         UrEA7XVZE+PJyZoV6NzkSHJrQ2rDmfiWtBpOU8vULHdCgypWelFvSqfH8LxXlj38xuAp
         wmYNxxMi2DpfFZfIj/wBvfoMRgzxq+w+2aqPhE5RJCDZ+bu3/k1EseeWfXCiz2axvuyN
         tT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ql3XQZSHAFVJhV4jpmhJbcc5iMOUhyMAEyck+GDMAQU=;
        b=FlIcnc4VUNULB0l+g4pt0RaFpYRXAj2ORbwFonEIb0+AxEo2Hxm6ajYvY6aPrCnZCV
         Bi+yv65XMIEtgleI+nHwWoVCUhPnfeVSuL2f11N19wuINB9c2r17/oshkOCHUgoYU3MK
         T47GOu7IKNm9MoWgqgTnDhQpAFP1pqnxiKWnaWksPsYSTKYvqF6lx7vKt0Slb6L8WuOv
         2FK9Lt0+qZSeNNhJUITGh9ygWZ63ESC2sK/jigjBneU06d+PTv30rJmXrSZMi0gKbDB1
         HQLtrfBfWT+XHJeqowQL8nXu9isAUmYWhSvCk/GdeN0U+OlJ9qDlJau3bx0R/B9oyWCH
         BtoQ==
X-Gm-Message-State: ANhLgQ0NtUSyB7EEdTxwd3t3jDqhJYxon0Tw9akBaQKCOGYoYpu8w4TJ
        tggwPr1u3iCCJ6Rd/pVJ6rwTpOsx6xMf5rSkQbBqYA==
X-Google-Smtp-Source: ADFU+vvi6yOpwqeSa5WiAkefLdhNiT++h6IyU927KGouaDipt2TpXAAAfPnOXKJCXukXNonz4mvXxvId9nspbSfMd5M=
X-Received: by 2002:a19:2314:: with SMTP id j20mr601707lfj.40.1583465747764;
 Thu, 05 Mar 2020 19:35:47 -0800 (PST)
MIME-Version: 1.0
References: <20200305012338.219746-1-rajatja@google.com> <20200305012338.219746-4-rajatja@google.com>
 <87k13znmrc.fsf@intel.com>
In-Reply-To: <87k13znmrc.fsf@intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 5 Mar 2020 19:35:10 -0800
Message-ID: <CACK8Z6ERZpZaSXsxrk_yGrRAtrgwytb5TEpyt1sX+V40U7m0sQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] drm/i915: Add support for integrated privacy screens
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mat King <mathewk@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        Sean Paul <seanpaul@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Nitin Joshi1 <njoshi1@lenovo.com>,
        Sugumaran Lacshiminarayanan <slacshiminar@lenovo.com>,
        Tomoki Maruichi <maruichit@lenovo.com>,
        Guenter Roeck <groeck@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

Thank you for the comments. Please see my responses inline.

On Thu, Mar 5, 2020 at 2:02 AM Jani Nikula <jani.nikula@linux.intel.com> wr=
ote:
>
> On Wed, 04 Mar 2020, Rajat Jain <rajatja@google.com> wrote:
> > Certain laptops now come with panels that have integrated privacy
> > screens on them. This patch adds support for such panels by adding
> > a privacy-screen property to the intel_connector for the panel, that
> > the userspace can then use to control and check the status.
> >
> > Identifying the presence of privacy screen, and controlling it, is done
> > via ACPI _DSM methods.
> >
> > Currently, this is done only for the Intel display ports. But in future=
,
> > this can be done for any other ports if the hardware becomes available
> > (e.g. external monitors supporting integrated privacy screens?).
>
> I think you should add the property at the drm core level in
> drm_connector.c, not in i915, to ensure we have the same property across
> drivers. Even if, for now, you leave the acpi implementation part in
> i915.

OK, will do. In order to do that I may need to introduce driver level
hooks that i915 driver can populate and drm core can call (or may be
some functions to add privacy screen property that drm core exports
and i915 driver will call).

>
> More comments inline.
>
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v6: Always initialize prop in intel_attach_privacy_screen_property()
> > v5: fix a cosmetic checkpatch warning
> > v4: Fix a typo in intel_privacy_screen.h
> > v3: * Change license to GPL-2.0 OR MIT
> >     * Move privacy screen enum from UAPI to intel_display_types.h
> >     * Rename parameter name and some other minor changes.
> > v2: Formed by splitting the original patch into multiple patches.
> >     - All code has been moved into i915 now.
> >     - Privacy screen is a i915 property
> >     - Have a local state variable to store the prvacy screen. Don't rea=
d
> >       it from hardware.
> >
> >  drivers/gpu/drm/i915/Makefile                 |  3 +-
> >  drivers/gpu/drm/i915/display/intel_atomic.c   | 13 +++-
> >  .../gpu/drm/i915/display/intel_connector.c    | 35 +++++++++
> >  .../gpu/drm/i915/display/intel_connector.h    |  1 +
> >  .../drm/i915/display/intel_display_types.h    | 18 +++++
> >  drivers/gpu/drm/i915/display/intel_dp.c       |  6 ++
> >  .../drm/i915/display/intel_privacy_screen.c   | 72 +++++++++++++++++++
> >  .../drm/i915/display/intel_privacy_screen.h   | 27 +++++++
> >  8 files changed, 171 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.c
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.h
> >
> > diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makef=
ile
> > index 991a8c537d123..825951b4cd006 100644
> > --- a/drivers/gpu/drm/i915/Makefile
> > +++ b/drivers/gpu/drm/i915/Makefile
> > @@ -208,7 +208,8 @@ i915-y +=3D \
> >       display/intel_vga.o
> >  i915-$(CONFIG_ACPI) +=3D \
> >       display/intel_acpi.o \
> > -     display/intel_opregion.o
> > +     display/intel_opregion.o \
> > +     display/intel_privacy_screen.o
> >  i915-$(CONFIG_DRM_FBDEV_EMULATION) +=3D \
> >       display/intel_fbdev.o
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/=
drm/i915/display/intel_atomic.c
> > index d043057d2fa03..4ed537c877777 100644
> > --- a/drivers/gpu/drm/i915/display/intel_atomic.c
> > +++ b/drivers/gpu/drm/i915/display/intel_atomic.c
> > @@ -40,6 +40,7 @@
> >  #include "intel_global_state.h"
> >  #include "intel_hdcp.h"
> >  #include "intel_psr.h"
> > +#include "intel_privacy_screen.h"
> >  #include "intel_sprite.h"
> >
> >  /**
> > @@ -60,11 +61,14 @@ int intel_digital_connector_atomic_get_property(str=
uct drm_connector *connector,
> >       struct drm_i915_private *dev_priv =3D to_i915(dev);
> >       struct intel_digital_connector_state *intel_conn_state =3D
> >               to_intel_digital_connector_state(state);
> > +     struct intel_connector *intel_connector =3D to_intel_connector(co=
nnector);
> >
> >       if (property =3D=3D dev_priv->force_audio_property)
> >               *val =3D intel_conn_state->force_audio;
> >       else if (property =3D=3D dev_priv->broadcast_rgb_property)
> >               *val =3D intel_conn_state->broadcast_rgb;
> > +     else if (property =3D=3D intel_connector->privacy_screen_property=
)
> > +             *val =3D intel_conn_state->privacy_screen_status;
> >       else {
> >               drm_dbg_atomic(&dev_priv->drm,
> >                              "Unknown property [PROP:%d:%s]\n",
> > @@ -93,15 +97,18 @@ int intel_digital_connector_atomic_set_property(str=
uct drm_connector *connector,
> >       struct drm_i915_private *dev_priv =3D to_i915(dev);
> >       struct intel_digital_connector_state *intel_conn_state =3D
> >               to_intel_digital_connector_state(state);
> > +     struct intel_connector *intel_connector =3D to_intel_connector(co=
nnector);
> >
> >       if (property =3D=3D dev_priv->force_audio_property) {
> >               intel_conn_state->force_audio =3D val;
> >               return 0;
> > -     }
> > -
> > -     if (property =3D=3D dev_priv->broadcast_rgb_property) {
> > +     } else if (property =3D=3D dev_priv->broadcast_rgb_property) {
> >               intel_conn_state->broadcast_rgb =3D val;
> >               return 0;
> > +     } else if (property =3D=3D intel_connector->privacy_screen_proper=
ty) {
> > +             intel_privacy_screen_set_val(intel_connector, val);
>
> I think this part should only change the connector state. The driver
> would then do the magic at commit stage according to the property value.

Can you please point me to some code reference as to where in code
does the "commit stage" apply the changes?

>
> > +             intel_conn_state->privacy_screen_status =3D val;
> > +             return 0;
> >       }
> >
> >       drm_dbg_atomic(&dev_priv->drm, "Unknown property [PROP:%d:%s]\n",
> > diff --git a/drivers/gpu/drm/i915/display/intel_connector.c b/drivers/g=
pu/drm/i915/display/intel_connector.c
> > index 903e49659f561..55f80219cb269 100644
> > --- a/drivers/gpu/drm/i915/display/intel_connector.c
> > +++ b/drivers/gpu/drm/i915/display/intel_connector.c
> > @@ -297,3 +297,38 @@ intel_attach_colorspace_property(struct drm_connec=
tor *connector)
> >       drm_object_attach_property(&connector->base,
> >                                  connector->colorspace_property, 0);
> >  }
> > +
> > +static const struct drm_prop_enum_list privacy_screen_enum[] =3D {
> > +     { PRIVACY_SCREEN_DISABLED, "Disabled" },
> > +     { PRIVACY_SCREEN_ENABLED, "Enabled" },
> > +};
> > +
> > +/**
> > + * intel_attach_privacy_screen_property -
> > + *     create and attach the connecter's privacy-screen property. *
> > + * @connector: connector for which to init the privacy-screen property
> > + *
> > + * This function creates and attaches the "privacy-screen" property to=
 the
> > + * connector. Initial state of privacy-screen is set to disabled.
> > + */
> > +void
> > +intel_attach_privacy_screen_property(struct drm_connector *connector)
> > +{
> > +     struct intel_connector *intel_connector =3D to_intel_connector(co=
nnector);
> > +     struct drm_property *prop =3D intel_connector->privacy_screen_pro=
perty;
> > +
> > +     if (!prop) {
> > +             prop =3D drm_property_create_enum(connector->dev,
> > +                                             DRM_MODE_PROP_ENUM,
> > +                                             "privacy-screen",
> > +                                             privacy_screen_enum,
> > +                                         ARRAY_SIZE(privacy_screen_enu=
m));
> > +             if (!prop)
> > +                     return;
> > +
> > +             intel_connector->privacy_screen_property =3D prop;
> > +     }
> > +
> > +     drm_object_attach_property(&connector->base, prop,
> > +                                PRIVACY_SCREEN_DISABLED);
> > +}
>
> This looks about right, except IMO should be part of drm_connector and
> moved to drm_connector.c.

Will do.

>
> > diff --git a/drivers/gpu/drm/i915/display/intel_connector.h b/drivers/g=
pu/drm/i915/display/intel_connector.h
> > index 93a7375c8196d..61005f37a3385 100644
> > --- a/drivers/gpu/drm/i915/display/intel_connector.h
> > +++ b/drivers/gpu/drm/i915/display/intel_connector.h
> > @@ -31,5 +31,6 @@ void intel_attach_force_audio_property(struct drm_con=
nector *connector);
> >  void intel_attach_broadcast_rgb_property(struct drm_connector *connect=
or);
> >  void intel_attach_aspect_ratio_property(struct drm_connector *connecto=
r);
> >  void intel_attach_colorspace_property(struct drm_connector *connector)=
;
> > +void intel_attach_privacy_screen_property(struct drm_connector *connec=
tor);
> >
> >  #endif /* __INTEL_CONNECTOR_H__ */
> > diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drive=
rs/gpu/drm/i915/display/intel_display_types.h
> > index d70612cc1ba2a..de20effb3e073 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> > +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> > @@ -442,6 +442,23 @@ struct intel_connector {
> >       struct work_struct modeset_retry_work;
> >
> >       struct intel_hdcp hdcp;
> > +
> > +     /* Optional "privacy-screen" property for the connector panel */
> > +     struct drm_property *privacy_screen_property;
> > +};
> > +
> > +/**
> > + * enum intel_privacy_screen_status - privacy_screen status
> > + *
> > + * This enum is used to track and control the state of the integrated =
privacy
> > + * screen present on some display panels, via the "privacy-screen" pro=
perty.
> > + *
> > + * @PRIVACY_SCREEN_DISABLED: The privacy-screen on the panel is disabl=
ed
> > + * @PRIVACY_SCREEN_ENABLED:  The privacy-screen on the panel is enable=
d
> > + **/
> > +enum intel_privacy_screen_status {
> > +     PRIVACY_SCREEN_DISABLED =3D 0,
> > +     PRIVACY_SCREEN_ENABLED =3D 1,
> >  };
> >
> >  struct intel_digital_connector_state {
> > @@ -449,6 +466,7 @@ struct intel_digital_connector_state {
> >
> >       enum hdmi_force_audio force_audio;
> >       int broadcast_rgb;
> > +     enum intel_privacy_screen_status privacy_screen_status;
> >  };
> >
> >  #define to_intel_digital_connector_state(x) container_of(x, struct int=
el_digital_connector_state, base)
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/=
i915/display/intel_dp.c
> > index 171821113d362..ff76c799364d0 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -62,6 +62,7 @@
> >  #include "intel_lspcon.h"
> >  #include "intel_lvds.h"
> >  #include "intel_panel.h"
> > +#include "intel_privacy_screen.h"
> >  #include "intel_psr.h"
> >  #include "intel_sideband.h"
> >  #include "intel_tc.h"
> > @@ -6841,6 +6842,7 @@ intel_dp_add_properties(struct intel_dp *intel_dp=
, struct drm_connector *connect
> >  {
> >       struct drm_i915_private *dev_priv =3D to_i915(connector->dev);
> >       enum port port =3D dp_to_dig_port(intel_dp)->base.port;
> > +     struct intel_connector *intel_connector =3D to_intel_connector(co=
nnector);
> >
> >       if (!IS_G4X(dev_priv) && port !=3D PORT_A)
> >               intel_attach_force_audio_property(connector);
> > @@ -6871,6 +6873,10 @@ intel_dp_add_properties(struct intel_dp *intel_d=
p, struct drm_connector *connect
> >
> >               /* Lookup the ACPI node corresponding to the connector */
> >               intel_acpi_device_id_update(dev_priv);
> > +
> > +             /* Check for integrated Privacy screen support */
> > +             if (intel_privacy_screen_present(intel_connector))
> > +                     intel_attach_privacy_screen_property(connector);
>
> As said in reply to patch 2, we need to figure this part out.

Yup, responded in patch 2 reply.

>
> >       }
> >  }
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.c b/driv=
ers/gpu/drm/i915/display/intel_privacy_screen.c
> > new file mode 100644
> > index 0000000000000..c8a5b64f94fb7
> > --- /dev/null
> > +++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.c
> > @@ -0,0 +1,72 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > +/*
> > + * Intel ACPI privacy screen code
> > + *
> > + * Copyright =C2=A9 2019 Google Inc.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +
> > +#include "intel_privacy_screen.h"
> > +
> > +#define CONNECTOR_DSM_REVID 1
> > +
> > +#define CONNECTOR_DSM_FN_PRIVACY_ENABLE              2
> > +#define CONNECTOR_DSM_FN_PRIVACY_DISABLE             3
> > +
> > +static const guid_t drm_conn_dsm_guid =3D
> > +     GUID_INIT(0xC7033113, 0x8720, 0x4CEB,
> > +               0x90, 0x90, 0x9D, 0x52, 0xB3, 0xE5, 0x2D, 0x73);
> > +
> > +/* Makes _DSM call to set privacy screen status */
> > +static void acpi_privacy_screen_call_dsm(acpi_handle conn_handle, u64 =
func)
> > +{
> > +     union acpi_object *obj;
> > +
> > +     obj =3D acpi_evaluate_dsm(conn_handle, &drm_conn_dsm_guid,
> > +                             CONNECTOR_DSM_REVID, func, NULL);
> > +     if (!obj) {
> > +             DRM_DEBUG_DRIVER("failed to evaluate _DSM for fn %llx\n",=
 func);
> > +             return;
> > +     }
> > +
> > +     ACPI_FREE(obj);
> > +}
> > +
> > +void intel_privacy_screen_set_val(struct intel_connector *connector,
> > +                               enum intel_privacy_screen_status val)
> > +{
> > +     acpi_handle acpi_handle =3D connector->acpi_handle;
> > +
> > +     if (!acpi_handle)
> > +             return;
> > +
> > +     if (val =3D=3D PRIVACY_SCREEN_DISABLED)
> > +             acpi_privacy_screen_call_dsm(acpi_handle,
> > +                                          CONNECTOR_DSM_FN_PRIVACY_DIS=
ABLE);
> > +     else if (val =3D=3D PRIVACY_SCREEN_ENABLED)
> > +             acpi_privacy_screen_call_dsm(acpi_handle,
> > +                                          CONNECTOR_DSM_FN_PRIVACY_ENA=
BLE);
> > +     else
> > +             DRM_WARN("%s: Cannot set privacy screen to invalid val %u=
\n",
> > +                      dev_name(connector->base.dev->dev), val);
> > +}
> > +
> > +bool intel_privacy_screen_present(struct intel_connector *connector)
> > +{
> > +     acpi_handle handle =3D connector->acpi_handle;
> > +
> > +     if (!handle)
> > +             return false;
> > +
> > +     if (!acpi_check_dsm(handle, &drm_conn_dsm_guid,
> > +                         CONNECTOR_DSM_REVID,
> > +                         1 << CONNECTOR_DSM_FN_PRIVACY_ENABLE |
> > +                         1 << CONNECTOR_DSM_FN_PRIVACY_DISABLE)) {
> > +             DRM_WARN("%s: Odd, connector ACPI node but no privacy scr=
n?\n",
> > +                      dev_name(connector->base.dev->dev));
> > +             return false;
> > +     }
> > +     DRM_DEV_INFO(connector->base.dev->dev, "supports privacy screen\n=
");
> > +     return true;
> > +}
>
> I don't have much to say about the ACPI parts, except please use the new
> drm_dbg_kms and drm_info helpers for logging.

Will do.

Thanks,

Rajat

>
> BR,
> Jani.
>
>
> > diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.h b/driv=
ers/gpu/drm/i915/display/intel_privacy_screen.h
> > new file mode 100644
> > index 0000000000000..74013a7885c70
> > --- /dev/null
> > +++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.h
> > @@ -0,0 +1,27 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> > +/*
> > + * Copyright =C2=A9 2019 Google Inc.
> > + */
> > +
> > +#ifndef __DRM_PRIVACY_SCREEN_H__
> > +#define __DRM_PRIVACY_SCREEN_H__
> > +
> > +#include "intel_display_types.h"
> > +
> > +#ifdef CONFIG_ACPI
> > +bool intel_privacy_screen_present(struct intel_connector *connector);
> > +void intel_privacy_screen_set_val(struct intel_connector *connector,
> > +                               enum intel_privacy_screen_status val);
> > +#else
> > +static bool intel_privacy_screen_present(struct intel_connector *conne=
ctor)
> > +{
> > +     return false;
> > +}
> > +
> > +static void
> > +intel_privacy_screen_set_val(struct intel_connector *connector,
> > +                          enum intel_privacy_screen_status val)
> > +{ }
> > +#endif /* CONFIG_ACPI */
> > +
> > +#endif /* __DRM_PRIVACY_SCREEN_H__ */
>
> --
> Jani Nikula, Intel Open Source Graphics Center
