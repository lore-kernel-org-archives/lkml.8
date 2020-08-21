Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E93C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C15F20735
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Nqw6EIht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgHUT1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgHUT1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:27:53 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD192C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:27:52 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g13so2818923ioo.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1myCzRi4esv568zxCC1VxTn8QF6yFvp0MAEFFS3ZsY=;
        b=Nqw6EIhtcjnVch1RyTLTHNW2VJ+2Ni8LGHFdwEAVuaMrE3JKuA2kXp1SYMO6P5fP31
         zTaWstPauLAEGevPcKswhs9bXoz7uuq3p3BxNSQOy/A+N5xX9D5/4ACBcSUgt/dFgzZP
         oqSOH9yWQygCmVq8TKj1VnX75vDcKFIcTUleB3UsGfhDk1zTnAjxue1gFhvyJC+k/QNF
         m4s5LIjkoJkk4TERUp5MboKpnnXHw8mqj8+hxaKVt2RA+3xXOLQRXMJ9GezgTip4LEdc
         /73NUqlokP2apQlEH+RwioHtYHWnyDesZDHTeMxrBUUf74esIKP5eJA0hZh1Cct1hvzr
         p0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1myCzRi4esv568zxCC1VxTn8QF6yFvp0MAEFFS3ZsY=;
        b=onexXvtMf/JI9hfmRuE0wN3mbP8Q5dCh63WA2g3AG/qftOQVu9/aBu46S7v98B745R
         PS7ym4Msp1WU3O2RZlhTLSLJWtWwN5BqPfOQ9FzKsQzRcSi3q+LMrlg0SVLLiTYn/Z2p
         wymTjcogSiLcGFqNOc9nvVhIcyILRF0ighB8g5vUxl2cLHhrutEIos4j+KwIFG9GpdeN
         7WkJYlHO79GJKFxpJgFhQB58qsQJGOs8obLdH79S4/zm/9zLCv74zM02CxGxdi2DrVi4
         mcFsywsBSJZEbJqFdZA5J+7RKl/GE2bSSYJNLwleboAZ438hdKBqWOHwGFlX8rp51fBW
         XCGA==
X-Gm-Message-State: AOAM530UGFX03Yv5McVsFf2DoSkPiowhU44qx7NqLBOK5gNEg5sICYKG
        t/NoyaTZtR4PDyzQ3P1S1I8cTEGPzFr4xYOtDgtTpQ==
X-Google-Smtp-Source: ABdhPJyPRbjjzFgClBBrSDVUAWdB1QiLVFzBazaPFxEmZV6a+K0eIC0a5hyTfRBnCQ8C/pCpXS8TPG/SWd1SnE/J3jA=
X-Received: by 2002:a05:6602:1589:: with SMTP id e9mr3455471iow.85.1598038071643;
 Fri, 21 Aug 2020 12:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200820183012.288794-1-lyude@redhat.com> <20200820183012.288794-14-lyude@redhat.com>
In-Reply-To: <20200820183012.288794-14-lyude@redhat.com>
From:   Sean Paul <sean@poorly.run>
Date:   Fri, 21 Aug 2020 15:27:15 -0400
Message-ID: <CAMavQKL75YiiTn9woovnfUzTosYUQeBhTsJs6Ne0HxBQ4Ap6NA@mail.gmail.com>
Subject: Re: [Intel-gfx] [RFC v2 13/20] drm/i915/dp: Extract drm_dp_downstream_read_info()
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Wambui Karuga <wambui.karugax@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 2:31 PM Lyude Paul <lyude@redhat.com> wrote:
>
> We're going to be doing the same probing process in nouveau for
> determining downstream DP port capabilities, so let's deduplicate the
> work by moving i915's code for handling this into a shared helper:
> drm_dp_downstream_read_info().
>
> Note that when we do this, we also do make some functional changes while
> we're at it:
> * We always clear the downstream port info before trying to read it,
>   just to make things easier for the caller
> * We skip reading downstream port info if the DPCD indicates that we
>   don't support downstream port info
> * We only read as many bytes as needed for the reported number of
>   downstream ports, no sense in reading the whole thing every time
>
> v2:
> * Fixup logic for calculating the downstream port length to account for
>   the fact that downstream port caps can be either 1 byte or 4 bytes
>   long. We can actually skip fixing the max_clock/max_bpc helpers here
>   since they all check for DP_DETAILED_CAP_INFO_AVAILABLE anyway.
> * Fix ret code check for drm_dp_dpcd_read
>

Thanks for sorting this out!

Reviewed-by: Sean Paul <sean@poorly.run>

> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_dp_helper.c         | 46 +++++++++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_dp.c | 14 ++------
>  include/drm/drm_dp_helper.h             |  3 ++
>  3 files changed, 51 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 4c21cf69dad5a..4f845995f1f66 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -423,6 +423,52 @@ bool drm_dp_send_real_edid_checksum(struct drm_dp_aux *aux,
>  }
>  EXPORT_SYMBOL(drm_dp_send_real_edid_checksum);
>
> +static u8 drm_dp_downstream_port_count(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
> +{
> +       u8 port_count = dpcd[DP_DOWN_STREAM_PORT_COUNT] & DP_PORT_COUNT_MASK;
> +
> +       if (dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DETAILED_CAP_INFO_AVAILABLE && port_count > 4)
> +               port_count = 4;
> +
> +       return port_count;
> +}
> +
> +/**
> + * drm_dp_downstream_read_info() - read DPCD downstream port info if available
> + * @aux: DisplayPort AUX channel
> + * @dpcd: A cached copy of the port's DPCD
> + * @downstream_ports: buffer to store the downstream port info in
> + *
> + * Returns: 0 if either the downstream port info was read successfully or
> + * there was no downstream info to read, or a negative error code otherwise.
> + */
> +int drm_dp_downstream_read_info(struct drm_dp_aux *aux,
> +                               const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> +                               u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS])
> +{
> +       int ret;
> +       u8 len;
> +
> +       memset(downstream_ports, 0, DP_MAX_DOWNSTREAM_PORTS);
> +
> +       /* No downstream info to read */
> +       if (!drm_dp_is_branch(dpcd) ||
> +           dpcd[DP_DPCD_REV] < DP_DPCD_REV_10 ||
> +           !(dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DWN_STRM_PORT_PRESENT))
> +               return 0;
> +
> +       len = drm_dp_downstream_port_count(dpcd);
> +       if (dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DETAILED_CAP_INFO_AVAILABLE)
> +               len *= 4;
> +
> +       ret = drm_dp_dpcd_read(aux, DP_DOWNSTREAM_PORT_0, downstream_ports, len);
> +       if (ret < 0)
> +               return ret;
> +
> +       return ret == len ? 0 : -EIO;
> +}
> +EXPORT_SYMBOL(drm_dp_downstream_read_info);
> +
>  /**
>   * drm_dp_downstream_max_clock() - extract branch device max
>   *                                 pixel rate for legacy VGA
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 1e29d3a012856..984e49194ca31 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -4685,18 +4685,8 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
>                         return false;
>         }
>
> -       if (!drm_dp_is_branch(intel_dp->dpcd))
> -               return true; /* native DP sink */
> -
> -       if (intel_dp->dpcd[DP_DPCD_REV] == 0x10)
> -               return true; /* no per-port downstream info */
> -
> -       if (drm_dp_dpcd_read(&intel_dp->aux, DP_DOWNSTREAM_PORT_0,
> -                            intel_dp->downstream_ports,
> -                            DP_MAX_DOWNSTREAM_PORTS) < 0)
> -               return false; /* downstream port status fetch failed */
> -
> -       return true;
> +       return drm_dp_downstream_read_info(&intel_dp->aux, intel_dp->dpcd,
> +                                          intel_dp->downstream_ports) == 0;
>  }
>
>  static bool
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index 5c28199248626..1349f16564ace 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -1613,6 +1613,9 @@ int drm_dp_dpcd_read_link_status(struct drm_dp_aux *aux,
>  bool drm_dp_send_real_edid_checksum(struct drm_dp_aux *aux,
>                                     u8 real_edid_checksum);
>
> +int drm_dp_downstream_read_info(struct drm_dp_aux *aux,
> +                               const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> +                               u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS]);
>  int drm_dp_downstream_max_clock(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
>                                 const u8 port_cap[4]);
>  int drm_dp_downstream_max_bpc(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> --
> 2.26.2
>
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
