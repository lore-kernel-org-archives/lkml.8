Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B77C3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AA120732
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KS9q4m3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgCFD1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:27:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39117 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCFD1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:27:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id f10so648275ljn.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 19:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHB8pqib2S8EX6dGxoGL3fsksSX+3LObQT7Yk94+vMs=;
        b=KS9q4m3biU+vs0SPnuKzkrDkK7BlMsalOQoqam2tJwCtGKLOWhHrQ/fppZdbmlkTB9
         G4oapdgJaFU6Mg+nQECTi13PwddA5si+9yZAX/07DcFt+HMv2DOccMF51x6T1d2hL7+i
         YcsPaujIpywMuktjBgVQMNtOEJXlbhHIkRoFvLg0QHYONzSszDmvIw0b5PNK4TBqRQmi
         Y6EmvuEVxRx27JbUr4KY7Z3+6W3ujdJYtu+1Wf0hk8KurorfjK0lS4hwXPKet0zYDcg5
         8WEVgvZuyHepmeDGKJ741Ey4oEYOkybOv1IZqntIjhONOBzWbV+SUc+2BsV1rPgBhry2
         DwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHB8pqib2S8EX6dGxoGL3fsksSX+3LObQT7Yk94+vMs=;
        b=kg8QvZSa0E89xc4Hs/qzg1Matv6LO4NZM9DBRNYWxtGnfyoCSwpEBQygUb3N8OQQK9
         4BnkD0TLlD7ACvLjTGt2/3bX+0RkKCGsVcCTyKYVhEx16Oxwd9zTXD09oV1o0Oores8D
         94WUeFC68jNJnpMwQ15/T6hIgEVMAJPwutdWfZ48u3iOCw4nBzU5oZjfSDCmBz/s2eeF
         dH/TPwFYi8bkSOYvrKDgt3o3fN0rRsPfK9qE+DbzRa5TpQaBmdZRodDbLgdfnFYa+ehh
         jI+CN+0TaT8FnfqgA4/AQvOUR/mluoKW8XJfVMGQJF9lWkpzhh5hM74PWI3Dvf448eLJ
         DdEA==
X-Gm-Message-State: ANhLgQ0F5Gs6dSoTo4aQEjN+Yk5xvxUHpZ1/Xqy3rW83rt2mkpEkxOMN
        J9TVVmZMr9pwITPTAd43eijuzVyGJbTJXFxScvjNFQ==
X-Google-Smtp-Source: ADFU+vuoQVr56RR0ECd3iys8NXTFKB5BD4fVGqtSSx6+qrBc+FXqTlY19nI2H9lM9bE8nj3mL9NaX/msRXSYVkaasgY=
X-Received: by 2002:a2e:8745:: with SMTP id q5mr701967ljj.120.1583465270159;
 Thu, 05 Mar 2020 19:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20200305012338.219746-1-rajatja@google.com> <20200305012338.219746-3-rajatja@google.com>
 <87o8tbnnqa.fsf@intel.com>
In-Reply-To: <87o8tbnnqa.fsf@intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 5 Mar 2020 19:27:13 -0800
Message-ID: <CACK8Z6HRB9q1KeborGr7V-0Qp0AApHV6gBTkc6xD5NokH8gr0w@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] drm/i915: Lookup and attach ACPI device node for connectors
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
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 1:41 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Wed, 04 Mar 2020, Rajat Jain <rajatja@google.com> wrote:
> > Lookup and attach ACPI nodes for intel connectors. The lookup is done
> > in compliance with ACPI Spec 6.3
> > https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> > (Ref: Pages 1119 - 1123).
> >
> > This can be useful for any connector specific platform properties. (This
> > will be used for privacy screen in next patch).
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v6: Addressed minor comments from Jani at
> >     https://lkml.org/lkml/2020/1/24/1143
> >      - local variable renamed.
> >      - used drm_dbg_kms()
> >      - used acpi_device_handle()
> >      - Used opaque type acpi_handle instead of void*
> > v5: same as v4
> > v4: Same as v3
> > v3: fold the code into existing acpi_device_id_update() function
> > v2: formed by splitting the original patch into ACPI lookup, and privacy
> >     screen property. Also move it into i915 now that I found existing code
> >     in i915 that can be re-used.
> >
> >  drivers/gpu/drm/i915/display/intel_acpi.c     | 24 +++++++++++++++++++
> >  .../drm/i915/display/intel_display_types.h    |  5 ++++
> >  drivers/gpu/drm/i915/display/intel_dp.c       |  3 +++
> >  3 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> > index 3e6831cca4ac1..870c1ad98df92 100644
> > --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> > +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> > @@ -222,11 +222,22 @@ static u32 acpi_display_type(struct intel_connector *connector)
> >       return display_type;
> >  }
> >
> > +/*
> > + * Ref: ACPI Spec 6.3
> > + * https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> > + * Pages 1119 - 1123 describe, what I believe, a standard way of
> > + * identifying / addressing "display panels" in the ACPI. It provides
> > + * a way for the ACPI to define devices for the display panels attached
> > + * to the system. It thus provides a way for the BIOS to export any panel
> > + * specific properties to the system via ACPI (like device trees).
> > + */
> >  void intel_acpi_device_id_update(struct drm_i915_private *dev_priv)
> >  {
> >       struct drm_device *dev = &dev_priv->drm;
> >       struct intel_connector *connector;
> >       struct drm_connector_list_iter conn_iter;
> > +     struct acpi_device *conn_dev;
> > +     u64 conn_addr;
> >       u8 display_index[16] = {};
> >
> >       /* Populate the ACPI IDs for all connectors for a given drm_device */
> > @@ -242,6 +253,19 @@ void intel_acpi_device_id_update(struct drm_i915_private *dev_priv)
> >               device_id |= display_index[type]++ << ACPI_DISPLAY_INDEX_SHIFT;
> >
> >               connector->acpi_device_id = device_id;
> > +
> > +             /* Build the _ADR to look for */
> > +             conn_addr = device_id | ACPI_DEVICE_ID_SCHEME |
> > +                             ACPI_BIOS_CAN_DETECT;
> > +
> > +             drm_dbg_kms(dev, "Checking connector ACPI node at _ADR=%llX\n",
> > +                         conn_addr);
> > +
> > +             /* Look up the connector device, under the PCI device */
> > +             conn_dev = acpi_find_child_device(
> > +                                     ACPI_COMPANION(&dev->pdev->dev),
> > +                                     conn_addr, false);
> > +             connector->acpi_handle = acpi_device_handle(conn_dev);
> >       }
> >       drm_connector_list_iter_end(&conn_iter);
> >  }
> > diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
> > index 5e00e611f077f..d70612cc1ba2a 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> > +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> > @@ -411,9 +411,14 @@ struct intel_connector {
> >        */
> >       struct intel_encoder *encoder;
> >
> > +#ifdef CONFIG_ACPI
> >       /* ACPI device id for ACPI and driver cooperation */
> >       u32 acpi_device_id;
> >
> > +     /* ACPI handle corresponding to this connector display, if found */
> > +     acpi_handle acpi_handle;
> > +#endif
> > +
> >       /* Reads out the current hw, returning true if the connector is enabled
> >        * and active (i.e. dpms ON state). */
> >       bool (*get_hw_state)(struct intel_connector *);
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> > index 0a417cd2af2bc..171821113d362 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -44,6 +44,7 @@
> >  #include "i915_debugfs.h"
> >  #include "i915_drv.h"
> >  #include "i915_trace.h"
> > +#include "intel_acpi.h"
> >  #include "intel_atomic.h"
> >  #include "intel_audio.h"
> >  #include "intel_connector.h"
> > @@ -6868,6 +6869,8 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
> >
> >               connector->state->scaling_mode = DRM_MODE_SCALE_ASPECT;
> >
> > +             /* Lookup the ACPI node corresponding to the connector */
> > +             intel_acpi_device_id_update(dev_priv);
>
> I find this part problematic.
>
> Normally, we call the function at probe via i915_driver_register() ->
> intel_opregion_register() -> intel_opregion_resume() ->
> intel_didl_outputs() -> intel_acpi_device_id_update(). It gets called
> *once* at probe, after we have all the outputs (and thus connectors)
> figured out.
>
> This in turn calls it for every DP connector, before we even have all
> connectors registered. But it also re-iterates the previously handled
> connectors again and again.
>
> The problem, of course, is that you'll need connector->acpi_handle to
> figure out whether the feature is present and whether the property is
> needed. Figuring out acpi_handle also requires
> connector->acpi_device_id.
>
> It's a bit of a catch-22.
>
> I think the options are:
>
> 1) See if we can postpone creating and attaching properties to connector
> ->late_register hook. (I didn't have the time to look into it yet, at
> all.)

Apparently not. The drm core doesn't like to add properties in
late_register() callback. I just tried it and get this warning:

[    1.223163] WARNING: CPU: 2 PID: 1 at
drivers/gpu/drm/drm_mode_object.c:45 __drm_mode_object_add+0xab/0xaf
....
<snip>
.....
[    1.223540] Call Trace:
[    1.223540]  drm_property_create+0xcc/0x155
[    1.223540]  drm_property_create_enum+0x26/0x79
[    1.223540]  intel_attach_privacy_screen_property+0x3a/0x5d
[    1.223540]  intel_dp_connector_register+0x6a/0xa8
[    1.223540]  drm_connector_register+0x61/0xaa
[    1.223540]  drm_connector_register_all+0x46/0x8b
[    1.223540]  drm_modeset_register_all+0x3e/0x67
[    1.223540]  drm_dev_register+0x124/0x187
[    1.223540]  i915_driver_probe+0xa18/0xda0
[    1.223540]  i915_pci_probe+0x145/0x168

>
> 2) Provide a way to populate connector->acpi_device_id and
> connector->acpi_handle on a per-connector basis. At least the device id
> remains constant for the lifetime of the drm_device

Are you confirming that the connector->acpi_device_id remains constant
for the lifetime of the drm_device, as calculated in
intel_acpi_device_id_update()?  Even in the face of external displays
(monitors) being connected and disconnected during the lifetime of the
system? If so, then I think we can have a solution.

> (why do we keep
> updating it at every resume?!) but can we be sure ->acpi_handle does
> too? (I don't really know my way around ACPI.)

I don't understand why this was being updated on every resume in that
case (this existed even before my patchset). I believe we do not need
it. Yes, the ->acpi_handle will not change if the ->acpi_device_id
does not change. I believe the way forward should then be to populate
connector->acpi_device_id and connector->acpi_handle ONE TIME at the
time of connector init (and not update it on every resume). Does this
sound ok?

I can write the code up and send as my next patch iteration.

Thanks,

Rajat

>



> >       }
> >  }
>
> --
> Jani Nikula, Intel Open Source Graphics Center
