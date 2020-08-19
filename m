Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944C1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEA8207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Vgif463L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgHSPQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbgHSPQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:16:00 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3ACC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:15:59 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 2so21862618qkf.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s64SZVe7q9SvLIi8k1Cji0BZ0MflkhzrqfKJ2a3sRpg=;
        b=Vgif463L2ffkT4NOJY+9PBmSSrRy9LCbqF+LNimo+7nBOn6WBPAYE3UgRiCrDzfyNV
         eVlFvMRApjqgxTNePMfMNHdYG9rjw2XMSgvPkG/tMVVqzNdTpkXMclH/ihWBe69q/TEL
         U0ZsuYSdq78NWI9RS4/ZUW9dhxrY5XdF65i5UxnZL0dL4a2LPp0+ovR/Qn6gg1wRxJz4
         eYPaC8qf6WA0gC6MAIYCkFxmd4ijGKm/jsY+xB16giCBh2k66Fhxbu0o2DUxPN9BLjgf
         4RozUtuW4wVqQiohX2o/CXwWDpOf1i1wFaIwT1vAZTbxaG1NmR+SYcpzURASENbtEmqs
         XR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s64SZVe7q9SvLIi8k1Cji0BZ0MflkhzrqfKJ2a3sRpg=;
        b=UPnmdSXJRqr5hz6S/X5TcRd40vWLyXsoryzo4agG7nwcEmka+H+e40IFWDTzH1OFd9
         QDtc49KufuLiCiAvh+g+JbyJJkry7GxJPST+vsSo4/pxvAubB77TtftqDaImEhplUWbd
         djQLTpPe/m0wb7Z15vTdaSVHuCcT/4g7IZI7WB8mrj0JqV983b/7WIW8U1WwiadC4O/U
         LuCoG32V6dg7HCPJ8Khlevcu/QpbufNMisT4rhVWlyCNy1fpVkkepCZCu250fPLo9/ON
         0HEVgdgZMrX8flqHiZ+vr/5lCKGo8kFiegiL87cKYY6R1atcvB+cJ7UB6d0Xu0CTLBDn
         ZJJg==
X-Gm-Message-State: AOAM530NWygdqgZEOp0yTwW2sWU4avNRgwBAc4z3xWjnxRckpmvYY8iI
        3134vScnuPS1zYa+zMpc8hs/og==
X-Google-Smtp-Source: ABdhPJyhydHGXzZYDXTO3g4OpZt3nkuQBZ0wa69OQW6jpGvDpmsGIKkpgaTLTCym7+el9w11N2VezQ==
X-Received: by 2002:a37:9ccf:: with SMTP id f198mr22392707qke.168.1597850159056;
        Wed, 19 Aug 2020 08:15:59 -0700 (PDT)
Received: from localhost (mobile-166-177-185-175.mycingular.net. [166.177.185.175])
        by smtp.gmail.com with ESMTPSA id u21sm22277690qkk.1.2020.08.19.08.15.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 08:15:58 -0700 (PDT)
Date:   Wed, 19 Aug 2020 11:15:53 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [RFC 13/20] drm/i915/dp: Extract drm_dp_downstream_read_info()
Message-ID: <20200819151547.GB46474@art_vandelay>
References: <20200811200457.134743-1-lyude@redhat.com>
 <20200811200457.134743-14-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811200457.134743-14-lyude@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 04:04:50PM -0400, Lyude Paul wrote:
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
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_dp_helper.c         | 32 +++++++++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_dp.c | 14 ++---------
>  include/drm/drm_dp_helper.h             |  3 +++
>  3 files changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 4c21cf69dad5a..9703b33599c3b 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -423,6 +423,38 @@ bool drm_dp_send_real_edid_checksum(struct drm_dp_aux *aux,
>  }
>  EXPORT_SYMBOL(drm_dp_send_real_edid_checksum);
>  
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
> +				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> +				u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS])
> +{
> +	int ret;
> +	u8 len;
> +
> +	memset(downstream_ports, 0, DP_MAX_DOWNSTREAM_PORTS);
> +
> +	/* No downstream info to read */
> +	if (!drm_dp_is_branch(dpcd) ||
> +	    dpcd[DP_DPCD_REV] < DP_DPCD_REV_10 ||
> +	    !(dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DWN_STRM_PORT_PRESENT))
> +		return 0;
> +
> +	len = (dpcd[DP_DOWN_STREAM_PORT_COUNT] & DP_PORT_COUNT_MASK) * 4;

I'm having a hard time rationalizing DP_MAX_DOWNSTREAM_PORTS being 16, but only
having 4 ports worth of data in the DP_DOWNSTREAM_PORT_* registers. Do you know
what's supposed to happen if dpcd[DP_DOWN_STREAM_PORT_COUNT] is > 4?

Sean

> +	ret = drm_dp_dpcd_read(aux, DP_DOWNSTREAM_PORT_0, downstream_ports,
> +			       len);
> +
> +	return ret == len ? 0 : -EIO;
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
>  			return false;
>  	}
>  
> -	if (!drm_dp_is_branch(intel_dp->dpcd))
> -		return true; /* native DP sink */
> -
> -	if (intel_dp->dpcd[DP_DPCD_REV] == 0x10)
> -		return true; /* no per-port downstream info */
> -
> -	if (drm_dp_dpcd_read(&intel_dp->aux, DP_DOWNSTREAM_PORT_0,
> -			     intel_dp->downstream_ports,
> -			     DP_MAX_DOWNSTREAM_PORTS) < 0)
> -		return false; /* downstream port status fetch failed */
> -
> -	return true;
> +	return drm_dp_downstream_read_info(&intel_dp->aux, intel_dp->dpcd,
> +					   intel_dp->downstream_ports) == 0;
>  }
>  
>  static bool
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index 5c28199248626..1349f16564ace 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -1613,6 +1613,9 @@ int drm_dp_dpcd_read_link_status(struct drm_dp_aux *aux,
>  bool drm_dp_send_real_edid_checksum(struct drm_dp_aux *aux,
>  				    u8 real_edid_checksum);
>  
> +int drm_dp_downstream_read_info(struct drm_dp_aux *aux,
> +				const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> +				u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS]);
>  int drm_dp_downstream_max_clock(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
>  				const u8 port_cap[4]);
>  int drm_dp_downstream_max_bpc(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
> -- 
> 2.26.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
