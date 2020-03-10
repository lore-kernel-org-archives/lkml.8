Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245C1C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D757424649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYkXsyTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgCJATP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:19:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35416 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgCJATP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:19:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id g4so3018363lfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 17:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rVfuufYR5ZjD8N921scghWy2a5E/d3WC1eICtD+kCSo=;
        b=jYkXsyTol7/Te5zaFnIIT9MH3c5/vTL9e6P+d71kAHbmC7u/IWgydvOm0ljJ4bzuta
         1cv9q6SMbdJHsm4HvAb9wLjVbzWDX/pcusOpawpECXMgZDo6KVKQUjZN67TLynjYJ7v/
         HseGG8s8RFv4d+byNUuhsjgYaB5rTd8fmFI0LwQaBplBzX29/obTULn3KML7HazVyn4d
         9OObCBi4ZvgOZHiCAUdlVuaxV9VOr3OaExhu5YH5dygBGPa2lU9G/BL6zs8ESdKEBtAH
         ghc6igKd8lBaGSDHUpc3BUPPOSF8MGpMKRrHCBaTdyghypLxLEKMRP4uzQgWUKlc89Y3
         v5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rVfuufYR5ZjD8N921scghWy2a5E/d3WC1eICtD+kCSo=;
        b=Obf0k1GtPVC7yhygymBlJg7C/m4wabVrR8h+kFTk4EGdrcnsYXSOIrxou3v+tDf9PC
         JYcwf+TRCINzf6sZA1PUkfCAMkXnHm4vyC/+oPbj2Kd2jnyP/IO5uPXBCQKIriTfpLMy
         KFN53a0E20KXTiV/NVWF8bjifHdJd1cQrcGj4PNqgWmjI4lgdw20n8+ljjZ3hqk93SB1
         Epa53ZaaIzBaF7YAz5eIQDVqPdKIy8nOAqQWuc1U0BJx2ril9Eg5ESk0hWJwRtr5GA7z
         2dkVdqXJxQvHJcu+dMcQpZRjTaw59MRpgMXRwjDqw6nEmkQ3Pty/k5rgPW7bEnjYMn5D
         YiuQ==
X-Gm-Message-State: ANhLgQ1bj/eGXeaHdtnZ23/bZl3cZIpA/vaG8CKh7v3Ebr13dNaEJrTb
        8jiztgo+x7Y9UstU0XkSvLudjjMIkE+w3RC6hjLQ/g==
X-Google-Smtp-Source: ADFU+vsIUYcochFoo+re+fV3CkUvmh5JVBkSEUz7CR0na3eOVhN96RdKOQNAxN0HLOPmoQLirUehLRtvJRZE/1vW4XM=
X-Received: by 2002:a19:a415:: with SMTP id q21mr8517319lfc.21.1583799550232;
 Mon, 09 Mar 2020 17:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200310000617.20662-1-rajatja@google.com> <20200310000617.20662-5-rajatja@google.com>
In-Reply-To: <20200310000617.20662-5-rajatja@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 9 Mar 2020 17:18:32 -0700
Message-ID: <CACK8Z6FsN2WNF8z0OrKv-1sPPwJFeJVYf8taHMZn0QpwLj+t=Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] drm/i915: Add support for integrated privacy screen
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        Mark Pearson <mpearson@lenovo.com>,
        Nitin Joshi1 <njoshi1@lenovo.com>,
        Sugumaran Lacshiminarayanan <slacshiminar@lenovo.com>,
        Tomoki Maruichi <maruichit@lenovo.com>
Cc:     Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

I have 1 question / need 1 help about this patch:

On Mon, Mar 9, 2020 at 5:06 PM Rajat Jain <rajatja@google.com> wrote:
>
> Add support for an ACPI based integrated privacy screen that is
> available on some systems.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v7: * Move the privacy-screen property back into drm core.
>     * Do the actual HW EPS toggling at commit time.
>     * Provide a sample ACPI node for reference in comments.
> v6: Always initialize prop in intel_attach_privacy_screen_property()
> v5: fix a cosmetic checkpatch warning
> v4: Fix a typo in intel_privacy_screen.h
> v3: * Change license to GPL-2.0 OR MIT
>     * Move privacy screen enum from UAPI to intel_display_types.h
>     * Rename parameter name and some other minor changes.
> v2: Formed by splitting the original patch into multiple patches.
>     - All code has been moved into i915 now.
>     - Privacy screen is a i915 property
>     - Have a local state variable to store the prvacy screen. Don't read
>       it from hardware.
>
>  drivers/gpu/drm/i915/Makefile                 |   3 +-
>  drivers/gpu/drm/i915/display/intel_atomic.c   |   1 +
>  drivers/gpu/drm/i915/display/intel_dp.c       |  30 ++-
>  .../drm/i915/display/intel_privacy_screen.c   | 175 ++++++++++++++++++
>  .../drm/i915/display/intel_privacy_screen.h   |  27 +++
>  5 files changed, 234 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.c
>  create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.h
>
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefil=
e
> index 9f887a86e555d..da42389107f9c 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -209,7 +209,8 @@ i915-y +=3D \
>         display/intel_vga.o
>  i915-$(CONFIG_ACPI) +=3D \
>         display/intel_acpi.o \
> -       display/intel_opregion.o
> +       display/intel_opregion.o \
> +       display/intel_privacy_screen.o
>  i915-$(CONFIG_DRM_FBDEV_EMULATION) +=3D \
>         display/intel_fbdev.o
>
> diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/dr=
m/i915/display/intel_atomic.c
> index d043057d2fa03..fc6264b4a7f73 100644
> --- a/drivers/gpu/drm/i915/display/intel_atomic.c
> +++ b/drivers/gpu/drm/i915/display/intel_atomic.c
> @@ -150,6 +150,7 @@ int intel_digital_connector_atomic_check(struct drm_c=
onnector *conn,
>             new_conn_state->base.picture_aspect_ratio !=3D old_conn_state=
->base.picture_aspect_ratio ||
>             new_conn_state->base.content_type !=3D old_conn_state->base.c=
ontent_type ||
>             new_conn_state->base.scaling_mode !=3D old_conn_state->base.s=
caling_mode ||
> +           new_conn_state->base.privacy_screen_status !=3D old_conn_stat=
e->base.privacy_screen_status ||
>             !blob_equal(new_conn_state->base.hdr_output_metadata,
>                         old_conn_state->base.hdr_output_metadata))
>                 crtc_state->mode_changed =3D true;
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 41c623b029464..a39b0c420b50a 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -62,6 +62,7 @@
>  #include "intel_lspcon.h"
>  #include "intel_lvds.h"
>  #include "intel_panel.h"
> +#include "intel_privacy_screen.h"
>  #include "intel_psr.h"
>  #include "intel_sideband.h"
>  #include "intel_tc.h"
> @@ -5886,6 +5887,12 @@ intel_dp_connector_register(struct drm_connector *=
connector)
>                 dev_priv->acpi_scan_done =3D true;
>         }
>
> +       /* Check for integrated Privacy screen support */
> +       if (intel_privacy_screen_present(to_intel_connector(connector)))
> +               drm_connector_attach_privacy_screen_property(connector);
> +       else
> +               drm_connector_destroy_privacy_screen_property(connector);
> +
>         DRM_DEBUG_KMS("registering %s bus for %s\n",
>                       intel_dp->aux.name, connector->kdev->kobj.name);
>
> @@ -6881,9 +6888,30 @@ intel_dp_add_properties(struct intel_dp *intel_dp,=
 struct drm_connector *connect
>                 drm_connector_attach_scaling_mode_property(connector, all=
owed_scalers);
>
>                 connector->state->scaling_mode =3D DRM_MODE_SCALE_ASPECT;
> +
> +               drm_connector_create_privacy_screen_property(connector);
>         }
>  }
>
> +static void intel_dp_update_privacy_screen(struct intel_encoder *encoder=
,
> +                               const struct intel_crtc_state *crtc_state=
,
> +                               const struct drm_connector_state *conn_st=
ate)
> +{
> +       struct drm_connector *connector =3D conn_state->connector;
> +
> +       if (connector->privacy_screen_property)
> +               intel_privacy_screen_set_val(to_intel_connector(connector=
),
> +                                            conn_state->privacy_screen_s=
tatus);
> +}
> +
> +static void intel_dp_update_pipe(struct intel_encoder *encoder,
> +                                const struct intel_crtc_state *crtc_stat=
e,
> +                                const struct drm_connector_state *conn_s=
tate)
> +{
> +       intel_dp_update_privacy_screen(encoder, crtc_state, conn_state);
> +       intel_panel_update_backlight(encoder, crtc_state, conn_state);
> +}
> +
>  static void intel_dp_init_panel_power_timestamps(struct intel_dp *intel_=
dp)
>  {
>         intel_dp->panel_power_off_time =3D ktime_get_boottime();
> @@ -7825,7 +7853,7 @@ bool intel_dp_init(struct drm_i915_private *dev_pri=
v,
>         intel_encoder->compute_config =3D intel_dp_compute_config;
>         intel_encoder->get_hw_state =3D intel_dp_get_hw_state;
>         intel_encoder->get_config =3D intel_dp_get_config;
> -       intel_encoder->update_pipe =3D intel_panel_update_backlight;
> +       intel_encoder->update_pipe =3D intel_dp_update_pipe;

For my testing purposes, I'm testing this using the proptest userspace util=
ity
in our distribution (I think from
https://github.com/CPFL/drm/blob/master/tests/proptest/proptest.c). I
notice that when I change the value of the property from userspace,
even though the drm_connector_state->privacy_screen_status gets
updated and reflects the change, the encoder->update_pipe() is not
getting called. Just wanted to ask if this is expected since you seem
to have implied that this update_pipe() might *not* get called if there *is=
* a
full modeset? (What is the hook that gets called for a full modeset
where i915 driver should commit this property change to the hardware?)

Thanks a lot for all your help,

Best Regards,

Rajat

>         intel_encoder->suspend =3D intel_dp_encoder_suspend;
>         if (IS_CHERRYVIEW(dev_priv)) {
>                 intel_encoder->pre_pll_enable =3D chv_dp_pre_pll_enable;
> diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.c b/driver=
s/gpu/drm/i915/display/intel_privacy_screen.c
> new file mode 100644
> index 0000000000000..6ff61ddf4c0a4
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Intel ACPI privacy screen code
> + *
> + * Copyright =C2=A9 2020 Google Inc.
> + *
> + * This code can help detect and control an integrated EPS (electronic
> + * privacy screen) via ACPI functions. It expects an ACPI node for the
> + * drm connector device with the following elements:
> + *
> + * UUID should be "c7033113-8720-4ceb-9090-9d52b3e52d73"
> + *
> + * _ADR =3D ACPI address per Spec (also see intel_acpi_device_id_update(=
))
> + * https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.p=
df
> + * Pages 1119 - 1123.
> + *
> + * _DSM method that will perform the following functions according to
> + * Local1 argument passed to it:
> + *  - Local1 =3D 0 (EPS capabilities): Report EPS presence and capabilit=
ies.
> + *  - Local1 =3D 1 (EPS State)  :  _DSM returns 1 if EPS is enabled, 0 o=
therwise.
> + *  - Local1 =3D 2 (EPS Enable) :  _DSM enables EPS
> + *  - Local1 =3D 3 (EPS Disable):  _DSM disables EPS
> + *
> + * Here is a sample ACPI node:
> + *
> + *  Scope (\_SB.PCI0.GFX0) // Intel graphics device (PCI device)
> + *  {
> + *      Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
> + *      {
> + *          Return (Package (0x01)
> + *          {
> + *              0x80010400
> + *          })
> + *      }
> + *
> + *      Device (LCD)
> + *      {
> + *          Name (_ADR, 0x80010400)  // _ADR: Address
> + *          Name (_STA, 0x0F)  // _STA: Status
> + *
> + *          Method (EPSP, 0, NotSerialized) // EPS Present
> + *          {
> + *              Return (0x01)
> + *          }
> + *
> + *          Method (EPSS, 0, NotSerialized) // EPS State
> + *          {
> + *              Local0 =3D \_SB.PCI0.GRXS (0xCD)
> + *              Return (Local0)
> + *          }
> + *
> + *          Method (EPSE, 0, NotSerialized) // EPS Enable
> + *          {
> + *              \_SB.PCI0.STXS (0xCD)
> + *          }
> + *
> + *          Method (EPSD, 0, NotSerialized) // EPS Disable
> + *          {
> + *              \_SB.PCI0.CTXS (0xCD)
> + *          }
> + *
> + *          Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Metho=
d
> + *          {
> + *              ToBuffer (Arg0, Local0)
> + *              If ((Local0 =3D=3D ToUUID ("c7033113-8720-4ceb-9090-9d52=
b3e52d73")))
> + *              {
> + *                  ToInteger (Arg2, Local1)
> + *                  If ((Local1 =3D=3D Zero))
> + *                  {
> + *                      Local2 =3D EPSP ()
> + *                      If ((Local2 =3D=3D One))
> + *                      {
> + *                          Return (Buffer (One)
> + *                          {
> + *                               0x0F
> + *                          })
> + *                      }
> + *                  }
> + *
> + *                  If ((Local1 =3D=3D One))
> + *                  {
> + *                      Return (EPSS ())
> + *                  }
> + *
> + *                  If ((Local1 =3D=3D 0x02))
> + *                  {
> + *                      EPSE ()
> + *                  }
> + *
> + *                  If ((Local1 =3D=3D 0x03))
> + *                  {
> + *                      EPSD ()
> + *                  }
> + *
> + *                  Return (Buffer (One)
> + *                  {
> + *                       0x00
> + *                  })
> + *              }
> + *
> + *              Return (Buffer (One)
> + *              {
> + *                   0x00
> + *              })
> + *          }
> + *      }
> + *  }
> + */
> +
> +#include <linux/acpi.h>
> +
> +#include "intel_privacy_screen.h"
> +
> +#define CONNECTOR_DSM_REVID 1
> +
> +#define CONNECTOR_DSM_FN_PRIVACY_ENABLE                2
> +#define CONNECTOR_DSM_FN_PRIVACY_DISABLE       3
> +
> +static const guid_t drm_conn_dsm_guid =3D
> +       GUID_INIT(0xC7033113, 0x8720, 0x4CEB,
> +                 0x90, 0x90, 0x9D, 0x52, 0xB3, 0xE5, 0x2D, 0x73);
> +
> +/* Makes _DSM call to set privacy screen status */
> +static void acpi_privacy_screen_call_dsm(struct intel_connector *connect=
or,
> +                                        u64 func)
> +{
> +       union acpi_object *obj;
> +       acpi_handle acpi_handle =3D connector->acpi_handle;
> +
> +       if (!acpi_handle)
> +               return;
> +
> +       obj =3D acpi_evaluate_dsm(acpi_handle, &drm_conn_dsm_guid,
> +                               CONNECTOR_DSM_REVID, func, NULL);
> +       if (!obj) {
> +               drm_err(connector->base.dev,
> +                       "failed to evaluate _DSM for fn %llx\n", func);
> +               return;
> +       }
> +
> +       ACPI_FREE(obj);
> +}
> +
> +void intel_privacy_screen_set_val(struct intel_connector *connector,
> +                                 enum drm_privacy_screen_status val)
> +{
> +       if (val =3D=3D PRIVACY_SCREEN_DISABLED)
> +               acpi_privacy_screen_call_dsm(connector,
> +                                            CONNECTOR_DSM_FN_PRIVACY_DIS=
ABLE);
> +       else if (val =3D=3D PRIVACY_SCREEN_ENABLED)
> +               acpi_privacy_screen_call_dsm(connector,
> +                                            CONNECTOR_DSM_FN_PRIVACY_ENA=
BLE);
> +       else
> +               drm_err(connector->base.dev,
> +                       "Cannot set privacy screen to invalid val %u\n", =
val);
> +}
> +
> +bool intel_privacy_screen_present(struct intel_connector *connector)
> +{
> +       acpi_handle handle =3D connector->acpi_handle;
> +
> +       if (!handle)
> +               return false;
> +
> +       if (!acpi_check_dsm(handle, &drm_conn_dsm_guid,
> +                           CONNECTOR_DSM_REVID,
> +                           1 << CONNECTOR_DSM_FN_PRIVACY_ENABLE |
> +                           1 << CONNECTOR_DSM_FN_PRIVACY_DISABLE)) {
> +               drm_dbg_kms(connector->base.dev,
> +                           "ACPI node but no privacy scrn\n");
> +               return false;
> +       }
> +       drm_info(connector->base.dev, "supports privacy screen\n");
> +       return true;
> +}
> diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.h b/driver=
s/gpu/drm/i915/display/intel_privacy_screen.h
> new file mode 100644
> index 0000000000000..f8d2e246ea0bd
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright =C2=A9 2019 Google Inc.
> + */
> +
> +#ifndef __DRM_PRIVACY_SCREEN_H__
> +#define __DRM_PRIVACY_SCREEN_H__
> +
> +#include "intel_display_types.h"
> +
> +#ifdef CONFIG_ACPI
> +bool intel_privacy_screen_present(struct intel_connector *connector);
> +void intel_privacy_screen_set_val(struct intel_connector *connector,
> +                                 enum drm_privacy_screen_status val);
> +#else
> +static bool intel_privacy_screen_present(struct intel_connector *connect=
or)
> +{
> +       return false;
> +}
> +
> +static void
> +intel_privacy_screen_set_val(struct intel_connector *connector,
> +                            enum drm_privacy_screen_status val)
> +{ }
> +#endif /* CONFIG_ACPI */
> +
> +#endif /* __DRM_PRIVACY_SCREEN_H__ */
> --
> 2.25.1.481.gfbce0eb801-goog
>
