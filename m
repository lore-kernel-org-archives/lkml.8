Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8A1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D8D2206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cf0C6xOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgGGAvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 20:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGGAvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 20:51:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF42C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 17:51:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q4so12153212lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 17:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uG2rJVdt+pTUmgw/PAAj9HwYQV5+/KXvM1JeMgzrio=;
        b=Cf0C6xOOznCEjJX8u/YQv9iqieSZaGPDFpYDrgILONHLWZ189XF02aZDAF/mTTAtts
         I709EitTR3Nuu41PsWGATRYywyeI+JnnrloLWi1cwDrRqekAkO30dAAV9xkPpBGB5CqS
         bQteAwLhk0bKCfEKAHl2Qfsieuen9iAvLT8YX8EfcxFrTBNBwlNmnp19V4PhLgCEublA
         KibtTiISj6mVgBQZZKkVr3Oa5etsyHsVqOLuX6nOl65T3+r05rUuZ9F7apoVh9M6mGgg
         SjpUyJXzRuyY6qQd3hjwXvtNGu4q11P3sXsEkYTTtDhZ0++uyzadKVj6vFeJrg6n2a/r
         wNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uG2rJVdt+pTUmgw/PAAj9HwYQV5+/KXvM1JeMgzrio=;
        b=AbID38CJbEvMuDzm6pXXiy+1UjjP0V5S6angxLYK1SnNYnJHC3L3+YBubz3vxD6N0b
         pA9ylnRAWAB335o0ZWZVDiXKZ13OP2Vj4qi7+j+WZDgAqHbrV5DEHbRtLQPpgNGqIQeU
         tLmZeN6oZkwAvf0qP+xgvup+ZGFernqJRZmreGta7k6UB0UI6tKG4vaTCCL3et3sOftO
         uO9MfCOYUVg0oM3fH7lWKAbv++CFo9Po7p42SoaT8BR12Af1nrC3OoNwYbUHwT8UiuhF
         5sKwmTvocGde951xTGo4qTe+QVwEoGPhgRbGc7y/uP+QHx3S0RgsoXtXQ4Wz+qOeKUde
         hP8A==
X-Gm-Message-State: AOAM5327eS8Sjx2+3MfQguhd7tvi7GtP2Tqc0X1bKVJCS6ibgSBaqQIO
        VijMwuwMEESppSGcTQ290wa/zJBDiEIV09igAYHZQw==
X-Google-Smtp-Source: ABdhPJzEUaUJ6KVc0xdSKTqvuoINWY+y0q6obo7OoOGmfwNOy18nJEOc+j4Ii5jmpqagjhd+cYZXlObJgFTE5t7tRNU=
X-Received: by 2002:a2e:161a:: with SMTP id w26mr28828472ljd.216.1594083082311;
 Mon, 06 Jul 2020 17:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200312185629.141280-1-rajatja@google.com> <20200312185629.141280-6-rajatja@google.com>
 <76d1a721-5f7b-1e86-b8ee-183bffb78ff1@redhat.com>
In-Reply-To: <76d1a721-5f7b-1e86-b8ee-183bffb78ff1@redhat.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 6 Jul 2020 17:50:45 -0700
Message-ID: <CACK8Z6Hd8WqEKi9MQdyoW0bMpjGiOsUrzYTm0HRaXscRWYS4aA@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v9 5/5] drm/i915: Enable support for
 integrated privacy screen
To:     Hans de Goede <hdegoede@redhat.com>
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

Hello Hans,

On Mon, Jul 6, 2020 at 5:51 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 3/12/20 7:56 PM, Rajat Jain wrote:
> > Add support for an ACPI based integrated privacy screen that is
> > available on some systems.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
>
> So as discussed a while ago I'm working on adding support for the
> privacy-screen on Lenovo Thinkpads, introducing a small new
> subsystem / helper-class as intermediary for when the privacy-screen
> is controlled by e.g. some random drivers/platform/x86 driver rather
> then directly by the GPU driver.
>
> I'm almost ready to send out v1. I was working on hooking things
> up in the i915 code and I was wondering what you were doing when
> the property is actually changed and we need to commit the new
> privacy-screen state to the hardware.
>
> This made me look at this patch, some comments inline:
>
> > ---
> > v9: same as v8
> > v8: - separate the APCI privacy screen into a separate patch.
> >      - Don't destroy the property if there is no privacy screen (because
> >        drm core doesn't like destroying property in late_register()).
> >      - The setting change needs to be committed in ->update_pipe() for
> >        ddi.c as well as dp.c and both of them call intel_dp_add_properties()
> > v7: Look for ACPI node in ->late_register() hook.
> >      Do the scan only once per drm_device (instead of 1 per drm_connector)
> > v6: Addressed minor comments from Jani at
> >      https://lkml.org/lkml/2020/1/24/1143
> >       - local variable renamed.
> >       - used drm_dbg_kms()
> >       - used acpi_device_handle()
> >       - Used opaque type acpi_handle instead of void*
> > v5: same as v4
> > v4: Same as v3
> > v3: fold the code into existing acpi_device_id_update() function
> > v2: formed by splitting the original patch into ACPI lookup, and privacy
> >      screen property. Also move it into i915 now that I found existing code
> >      in i915 that can be re-used.
> >
> >   drivers/gpu/drm/i915/display/intel_atomic.c |  2 ++
> >   drivers/gpu/drm/i915/display/intel_ddi.c    |  1 +
> >   drivers/gpu/drm/i915/display/intel_dp.c     | 34 ++++++++++++++++++++-
> >   drivers/gpu/drm/i915/display/intel_dp.h     |  5 +++
> >   4 files changed, 41 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/drm/i915/display/intel_atomic.c
> > index d043057d2fa03..9898d8980e7ce 100644
> > --- a/drivers/gpu/drm/i915/display/intel_atomic.c
> > +++ b/drivers/gpu/drm/i915/display/intel_atomic.c
> > @@ -150,6 +150,8 @@ int intel_digital_connector_atomic_check(struct drm_connector *conn,
> >           new_conn_state->base.picture_aspect_ratio != old_conn_state->base.picture_aspect_ratio ||
> >           new_conn_state->base.content_type != old_conn_state->base.content_type ||
> >           new_conn_state->base.scaling_mode != old_conn_state->base.scaling_mode ||
> > +         new_conn_state->base.privacy_screen_status !=
> > +             old_conn_state->base.privacy_screen_status ||
> >           !blob_equal(new_conn_state->base.hdr_output_metadata,
> >                       old_conn_state->base.hdr_output_metadata))
> >               crtc_state->mode_changed = true;
>
> Right I was planning on doing this to.
>
> > diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
> > index 73d0f4648c06a..69a5423216dc5 100644
> > --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> > +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> > @@ -3708,6 +3708,7 @@ static void intel_ddi_update_pipe(struct intel_encoder *encoder,
> >       if (!intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI))
> >               intel_ddi_update_pipe_dp(encoder, crtc_state, conn_state);
> >
> > +     intel_dp_update_privacy_screen(encoder, crtc_state, conn_state);
> >       intel_hdcp_update_pipe(encoder, crtc_state, conn_state);
> >   }
> >
>
> And this too.
>
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> > index 3ddc424b028c1..5f33ebb466135 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -62,6 +62,7 @@
> >   #include "intel_lspcon.h"
> >   #include "intel_lvds.h"
> >   #include "intel_panel.h"
> > +#include "intel_privacy_screen.h"
> >   #include "intel_psr.h"
> >   #include "intel_sideband.h"
> >   #include "intel_tc.h"
> > @@ -5886,6 +5887,10 @@ intel_dp_connector_register(struct drm_connector *connector)
> >               dev_priv->acpi_scan_done = true;
> >       }
> >
> > +     /* Check for integrated Privacy screen support */
> > +     if (intel_privacy_screen_present(to_intel_connector(connector)))
> > +             drm_connector_attach_privacy_screen_property(connector);
> > +
> >       DRM_DEBUG_KMS("registering %s bus for %s\n",
> >                     intel_dp->aux.name, connector->kdev->kobj.name);
> >
> > @@ -6883,6 +6888,33 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
> >               connector->state->scaling_mode = DRM_MODE_SCALE_ASPECT;
> >
> >       }
> > +
> > +     /*
> > +      * Created here, but depending on result of probing for privacy-screen
> > +      * in intel_dp_connector_register(), gets attached in that function.
> > +      * Need to create here because the drm core doesn't like creating
> > +      * properties during ->late_register().
> > +      */
> > +     drm_connector_create_privacy_screen_property(connector);
> > +}
> > +
> > +void
> > +intel_dp_update_privacy_screen(struct intel_encoder *encoder,
> > +                            const struct intel_crtc_state *crtc_state,
> > +                            const struct drm_connector_state *conn_state)
> > +{
> > +     struct drm_connector *connector = conn_state->connector;
> > +
> > +     intel_privacy_screen_set_val(to_intel_connector(connector),
> > +                                  conn_state->privacy_screen_status);
> > +}
> > +
> > +static void intel_dp_update_pipe(struct intel_encoder *encoder,
> > +                              const struct intel_crtc_state *crtc_state,
> > +                              const struct drm_connector_state *conn_state)
> > +{
> > +     intel_dp_update_privacy_screen(encoder, crtc_state, conn_state);
> > +     intel_panel_update_backlight(encoder, crtc_state, conn_state);
> >   }
> >
> >   static void intel_dp_init_panel_power_timestamps(struct intel_dp *intel_dp)
> > @@ -7826,7 +7858,7 @@ bool intel_dp_init(struct drm_i915_private *dev_priv,
> >       intel_encoder->compute_config = intel_dp_compute_config;
> >       intel_encoder->get_hw_state = intel_dp_get_hw_state;
> >       intel_encoder->get_config = intel_dp_get_config;
> > -     intel_encoder->update_pipe = intel_panel_update_backlight;
> > +     intel_encoder->update_pipe = intel_dp_update_pipe;
> >       intel_encoder->suspend = intel_dp_encoder_suspend;
> >       if (IS_CHERRYVIEW(dev_priv)) {
> >               intel_encoder->pre_pll_enable = chv_dp_pre_pll_enable;
>
> And this too.
>
> One problem here is that AFAICT the update_pipe callback is only called on
> fast modesets. So if the privacy_screen state is changed as part of a
> full modeset, then the change will be ignored.

I'm actually new to the drm / i915, so I did what I thought was right
at the time and was working on my setup. But, yeah, that might be a
possible issue it seems.

>
> Even if we ignore that for now, this means that we end up calling
> intel_privacy_screen_set_val(), or my equivalent of that for
> each fast modeset.
>
> In patch 4/5 intel_privacy_screen_set_val() is defined like this:
>
> +void intel_privacy_screen_set_val(struct intel_connector *connector,
> +                                 enum drm_privacy_screen_status val)
> +{
> +       struct drm_device *drm = connector->base.dev;
> +
> +       if (val == PRIVACY_SCREEN_DISABLED) {
> +               drm_dbg_kms(drm, "%s: disabling privacy-screen\n",
> +                           CONN_NAME(connector));
> +               acpi_privacy_screen_call_dsm(connector,
> +                                            CONNECTOR_DSM_FN_PRIVACY_DISABLE);
> +       } else {
> +               drm_dbg_kms(drm, "%s: enabling privacy-screen\n",
> +                           CONN_NAME(connector));
> +               acpi_privacy_screen_call_dsm(connector,
> +                                            CONNECTOR_DSM_FN_PRIVACY_ENABLE);
> +       }
> +}
> +
>
> There are 2 problems with this:
>
> 1. It makes the call even if there is no privacy-screen, and then
> acpi_privacy_screen_call_dsm() will log an error (if the connector has an
> associated handle but not the DSM).
>
> 2. It makes this call on any modeset, even if the property did non change
> (and even if there is no privacy-screen) and AFAIK these ACPI calls are somewhat
> expensive to make.

Ack to both these problems.

>
> 1. Should be easy to fix, fixing 2. is trickier. We really need access
> to the new and old connector_state here to only make the ACPI calls when
> necessary. But ATM all callbacks only ever get passed the new-state and
> these callbacks are all called after drm_atomic_helper_swap_state() at
> which point there is no way to get the old_state from the new_state.
>
> I've chosen to instead do this to update the privacy-screen change:
>
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -15501,6 +15503,9 @@ static void intel_atomic_commit_tail(struct intel_atomic_state *state)
>                         intel_color_load_luts(new_crtc_state);
>         }
>
> +       for_each_new_connector_in_state(&state->base, connector, new_connector_state, i)
> +               drm_connector_update_privacy_screen(connector, &state->base);
> +
>         /*
>          * Now that the vblank has passed, we can go ahead and program the
>          * optimal watermarks on platforms that need two-step watermark
>
> With drm_connector_update_privacy_screen() looking like this:
>
> +void drm_connector_update_privacy_screen(struct drm_connector *connector,
> +                                        struct drm_atomic_state *state)
> +{
> +       struct drm_connector_state *new_connector_state, *old_connector_state;
> +       int ret;
> +
> +       if (!connector->privacy_screen)
> +               return;
> +
> +       new_connector_state = drm_atomic_get_new_connector_state(state, connector);
> +       old_connector_state = drm_atomic_get_old_connector_state(state, connector);
> +
> +       if (new_connector_state->privacy_screen_sw_state ==
> +           old_connector_state->privacy_screen_sw_state)
> +               return;
> +
> +       ret = drm_privacy_screen_set_sw_state(connector->privacy_screen,
> +                               new_connector_state->privacy_screen_sw_state);
> +       if (ret)
> +               drm_err(connector->dev, "Error updating privacy-screen sw_state\n");
> +}
>
> Which avoids all the problems described above.

Ack. This looks like a better way since it takes care of these
problems. Please feel free to use my patches as you see fit (I didn't
see much activity on them since last many months so I have moved on to
something else now).

Thanks & Best Regards,

Rajat

>
> REgards,
>
> Hans
>
>
>
>
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915/display/intel_dp.h
> > index 0c7be8ed1423a..e4594e27ce5a8 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.h
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.h
> > @@ -123,4 +123,9 @@ static inline unsigned int intel_dp_unused_lane_mask(int lane_count)
> >
> >   u32 intel_dp_mode_to_fec_clock(u32 mode_clock);
> >
> > +void
> > +intel_dp_update_privacy_screen(struct intel_encoder *encoder,
> > +                            const struct intel_crtc_state *crtc_state,
> > +                            const struct drm_connector_state *conn_state);
> > +
> >   #endif /* __INTEL_DP_H__ */
> >
>
