Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156E8C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD66E24650
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="vgSELXD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgBYHaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:30:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41054 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYHaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:30:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id v4so525074wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 23:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EQMT6lDKStyiOUIYBwkRHyQecoL65OHS2/xGbDrARdU=;
        b=vgSELXD8DgGTQSv5a9IRoU2vtK9mb9ywLlrNtNTfRByEKonxyGGQfz/bGiGZIVWhSg
         BzzgxbqaG//TC38gDoGSIy5avusNbIPE6sjoLz84rZF2c2wFoHfBQ3iwVQrMI5PauN8B
         EAyxHujlLgelVEI1uF2NJcG412aR9yLyioUc3bc4J9XUPxsxMjPPgwc5OcIaWUqLI2Q7
         93jeIzpMQ8sP011Rr83RsF8dVv7vVtfmAIMXl3AGtQRoUT8SByWxj0tGM9EvZUu+4B82
         QpmP/9+h9DlZJurP/vlC3xHOf1o+C66VkrjeuC0eaU2/2gJuU+gCwyy0uf8Rvnn/L0fp
         ZjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQMT6lDKStyiOUIYBwkRHyQecoL65OHS2/xGbDrARdU=;
        b=mlj5UB2wRpUgUAjdHXmcgNromN/9HiZ6hX+zvWZZQltyZeu1i6ClPKS9hbQx9lT+7j
         jCWfh/Ai2eV2Gl5+BayVvqKEWnYRc9s/jIz9rqH5HN8GI+iq8Sm5lXS1Vn0sA6j+D2kH
         KpR581oV7JuSmgtocEe5Lwy9AUp2axosaYZSZmsz4ABQRv+Kj2UlTzPQh3cuyi3PKthC
         G2xpJYDWr0dkh9WOHHZpprVrCq5Gl0wHfIJFNTuVqa8dBonDaz63HUlTiIuNQc4cy2p9
         AP1gvRDUdKUQu9jxL3AO4z5FZaQeQrIur0S1g9+dyWwUAkZ9OmifkGm0U+Shas9KZGBy
         fvsg==
X-Gm-Message-State: APjAAAUGQOb2fAM3LhbrHUAsAFU+2U0evyVlBbaZ8Fw+vBf+msNSxWnK
        n3ytqlprfT1p7L2+MAIk+3HbHT7obHAcm9h82TE35w==
X-Google-Smtp-Source: APXvYqxwdub7/sbabb0IU0ArscIZ++rPosDp5bcpc1f1YhP3DV42pWo8sOtcmqMfJnBEAUHeeC6p36vrruaZ75Dn9nA=
X-Received: by 2002:adf:fc12:: with SMTP id i18mr12634989wrr.354.1582615821594;
 Mon, 24 Feb 2020 23:30:21 -0800 (PST)
MIME-Version: 1.0
References: <20200225070545.4482-1-pankaj.laxminarayan.bharadiya@intel.com> <20200225070545.4482-6-pankaj.laxminarayan.bharadiya@intel.com>
In-Reply-To: <20200225070545.4482-6-pankaj.laxminarayan.bharadiya@intel.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Tue, 25 Feb 2020 07:29:44 +0000
Message-ID: <CAPj87rPHFCntSOCx=92HitNxRBkXx3xSft0krkFLzdM2FrDSRw@mail.gmail.com>
Subject: Re: [Intel-gfx] [RFC][PATCH 5/5] drm/i915/display: Add
 Nearest-neighbor based integer scaling support
To:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        tzimmermann@suse.de, Maxime Ripard <mripard@kernel.org>,
        mihail.atanassov@arm.com,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 25 Feb 2020 at 07:17, Pankaj Bharadiya
<pankaj.laxminarayan.bharadiya@intel.com> wrote:
> @@ -415,18 +415,26 @@ skl_program_scaler(struct intel_plane *plane,
>         u16 y_vphase, uv_rgb_vphase;
>         int hscale, vscale;
>         const struct drm_plane_state *state = &plane_state->uapi;
> +       u32 src_w = drm_rect_width(&plane_state->uapi.src) >> 16;
> +       u32 src_h = drm_rect_height(&plane_state->uapi.src) >> 16;
>         u32 scaling_filter = PS_FILTER_MEDIUM;
> +       struct drm_rect dst;
>
>         if (state->scaling_filter == DRM_SCALING_FILTER_NEAREST_NEIGHBOR) {
>                 scaling_filter = PS_FILTER_PROGRAMMED;
> +               skl_setup_nearest_neighbor_filter(dev_priv, pipe, scaler_id);
> +
> +               /* Make the scaling window size to integer multiple of source
> +                * TODO: Should userspace take desision to round scaling window
> +                * to integer multiple?
> +                */
> +               crtc_w = rounddown(crtc_w, src_w);
> +               crtc_h = rounddown(crtc_h, src_h);

The kernel should absolutely not be changing the co-ordinates that
userspace requested.

Cheers,
Daniel
