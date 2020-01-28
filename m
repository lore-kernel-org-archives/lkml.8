Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B0CC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B04214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmQiAm0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgA1BeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 20:34:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40061 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgA1BeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:34:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18so12970302ljo.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 17:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CZ6VRC4n+webnekF6XsgmhozN7eOuS4xDI3dL9S54Ik=;
        b=NmQiAm0o9qeD+GC6S/d8E8DprIKGwPd3YaIpBbzd5i+p3SoTwlk1o9n6JcULQG0/7Z
         dC2nozCNY0iwFOCnwCMNObnlCjfjPiDSR0Lmdnlr3zoNFSYsdtpCN3OA8/YyjBWM/TU5
         GqnsJrkwOVVIBGDBKxNtVj6T9WlyrlTZbXKrBtAJWsxFhUHD8tF7TUtBYrnPme4182wC
         TRcFKY8UmS7GRRFPAyYvxCTFZmJ2ymi+or2VRZXzdQJqwz62UGqoE8EdQnlzq8CN7o+5
         2/gw5U1qIsJRmquwvgjH/6zqo4//8wncnNMUvOpKygLbOT8DGIc57zCe6D4XY7vVkgyQ
         zFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CZ6VRC4n+webnekF6XsgmhozN7eOuS4xDI3dL9S54Ik=;
        b=WFXlHj24llqflR89mSUB5wENluzEzxILtWAuxh2kNjFWlztbWBff5FEmZtjGtCjk4j
         sg+VG3I3xRW1iEum2J89fNykd9InOAR/i7d69AJH3Frmp2SL/5czOesKi7pWzCtnE++o
         0IPT6HD/ofnps7E4aiLCC7RyOOn5OO9sIhxTkUAK36ZXcenoiqJa8fAVuUD1D2VMnEfJ
         9ubI2z3ueMfuqxjIYFDsrt1va2dO5uDEuFhTVxKxtjrgM1BeTZSKDhQpJvALIzGXRFJB
         HjGFbf/Ur7bbtDoIeVDCsWf9UklEv5JgCbkh5ugI5+Q3oXg1SQuJ5h8qsQirZY13IAQ2
         GNrw==
X-Gm-Message-State: APjAAAXrfgxa43xrvMWkUV2cnUAGKn5kyqqkQomVISFur4cTDDh+J+vh
        0H1EVVLQxfcvQwBHWH7X0RIv1H8SO4TyD2ZhITvUhw==
X-Google-Smtp-Source: APXvYqzWBONm+D9ZnU0yO5tE1NoVbMMPzDq7cxFFoJ2VPgEvjqKy5elTSWia8H3/97WIWDoUx+onLrYJEsL1/TlvRIg=
X-Received: by 2002:a2e:90f:: with SMTP id 15mr7705927ljj.120.1580175236590;
 Mon, 27 Jan 2020 17:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20191220200353.252399-3-rajatja@google.com> <20200125001118.GA4358@roeck-us.net>
In-Reply-To: <20200125001118.GA4358@roeck-us.net>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 27 Jan 2020 17:33:19 -0800
Message-ID: <CACK8Z6F=cjR38k6XNc8asyqOQOogeu=k_Ndjc2H=aLs_iT96oA@mail.gmail.com>
Subject: Re: [v5,3/3] drm/i915: Add support for integrated privacy screens
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
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
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 4:11 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Dec 20, 2019 at 12:03:53PM -0800, Rajat Jain wrote:
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
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
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
> > index 90dcf09f52cc..f7067c8f0407 100644
> > --- a/drivers/gpu/drm/i915/Makefile
> > +++ b/drivers/gpu/drm/i915/Makefile
> > @@ -197,7 +197,8 @@ i915-y +=3D \
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
> > index c2875b10adf9..c73b81c4c3f6 100644
> > --- a/drivers/gpu/drm/i915/display/intel_atomic.c
> > +++ b/drivers/gpu/drm/i915/display/intel_atomic.c
> > @@ -37,6 +37,7 @@
> >  #include "intel_atomic.h"
> >  #include "intel_display_types.h"
> >  #include "intel_hdcp.h"
> > +#include "intel_privacy_screen.h"
> >  #include "intel_sprite.h"
> >
> >  /**
> > @@ -57,11 +58,14 @@ int intel_digital_connector_atomic_get_property(str=
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
> >               DRM_DEBUG_ATOMIC("Unknown property [PROP:%d:%s]\n",
> >                                property->base.id, property->name);
> > @@ -89,15 +93,18 @@ int intel_digital_connector_atomic_set_property(str=
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
> > +             intel_conn_state->privacy_screen_status =3D val;
> > +             return 0;
> >       }
> >
> >       DRM_DEBUG_ATOMIC("Unknown property [PROP:%d:%s]\n",
> > diff --git a/drivers/gpu/drm/i915/display/intel_connector.c b/drivers/g=
pu/drm/i915/display/intel_connector.c
> > index 1133c4e97bb4..f3e041c737de 100644
> > --- a/drivers/gpu/drm/i915/display/intel_connector.c
> > +++ b/drivers/gpu/drm/i915/display/intel_connector.c
> > @@ -296,3 +296,38 @@ intel_attach_colorspace_property(struct drm_connec=
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
> > +     struct drm_property *prop;
> > +
> > +     if (!intel_connector->privacy_screen_property) {
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
>
> If intel_connector->privacy_screen_property is not NULL, prop
> will be undefined, causing all kinds of fun.

Thank you for catching this. I will fix this in my next iteration.

Thanks,

Rajat

>
> I would expect this to happen whenever this function is called
> for the second time.
>
> Guenter
>
> > +}
> > diff --git a/drivers/gpu/drm/i915/display/intel_connector.h b/drivers/g=
pu/drm/i915/display/intel_connector.h
> > index 93a7375c8196..61005f37a338 100644
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
> > index 0a4a04116091..a0addd2c5376 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> > +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> > @@ -433,6 +433,23 @@ struct intel_connector {
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
> > @@ -440,6 +457,7 @@ struct intel_digital_connector_state {
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
> > index 93cece8e2516..d5376d667929 100644
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
> > @@ -6596,6 +6597,7 @@ intel_dp_add_properties(struct intel_dp *intel_dp=
, struct drm_connector *connect
> >  {
> >       struct drm_i915_private *dev_priv =3D to_i915(connector->dev);
> >       enum port port =3D dp_to_dig_port(intel_dp)->base.port;
> > +     struct intel_connector *intel_connector =3D to_intel_connector(co=
nnector);
> >
> >       if (!IS_G4X(dev_priv) && port !=3D PORT_A)
> >               intel_attach_force_audio_property(connector);
> > @@ -6626,6 +6628,10 @@ intel_dp_add_properties(struct intel_dp *intel_d=
p, struct drm_connector *connect
> >
> >               /* Lookup the ACPI node corresponding to the connector */
> >               intel_acpi_device_id_update(dev_priv);
> > +
> > +             /* Check for integrated Privacy screen support */
> > +             if (intel_privacy_screen_present(intel_connector))
> > +                     intel_attach_privacy_screen_property(connector);
> >       }
> >  }
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.c b/driv=
ers/gpu/drm/i915/display/intel_privacy_screen.c
> > new file mode 100644
> > index 000000000000..c8a5b64f94fb
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
> > diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.h b/driv=
ers/gpu/drm/i915/display/intel_privacy_screen.h
> > new file mode 100644
> > index 000000000000..74013a7885c7
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
