Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70874C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4402072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgDGGkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:40:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:38260 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgDGGkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:40:10 -0400
IronPort-SDR: jIpmVSpgu6111lUugJjIWRFMcipDLQ/TWo+c0LDl7+fYTiw6jN50MuYBQegl+RTcrfnwrHMh9M
 Ika4p2y50pKQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 23:40:10 -0700
IronPort-SDR: i4PRgE8ZRe2DLJdUwFjQBQ0GuvfnsLNttg/JS+fksyonvkFwCotbJR7m676bfJaOoDNA6wliJ9
 p7Pzye2D159Q==
X-IronPort-AV: E=Sophos;i="5.72,353,1580803200"; 
   d="scan'208";a="424640672"
Received: from vogtstef-mobl3.ger.corp.intel.com (HELO localhost) ([10.249.40.153])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 23:40:05 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/i915/dp_mst: Cast intel_connector->port as drm_dp_mst_port
In-Reply-To: <20200406200646.1263435-1-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200406200646.1263435-1-lyude@redhat.com>
Date:   Tue, 07 Apr 2020 09:40:02 +0300
Message-ID: <87eeszlry5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Apr 2020, Lyude Paul <lyude@redhat.com> wrote:
> The only reason for having this cast as void * before was because we
> originally needed to use drm_dp_mst_get_port_validated() and friends in
> order to (attempt to) safely access MST ports. However, we've since
> improved how reference counting works with ports and mstbs such that we
> can now rely on drm_dp_mst_port structs remaining in memory for as long
> as the driver needs. This means we don't really need to cast this as
> void* anymore, and can just access the struct directly.

To/from void* does not need a cast in C anyway. ;)

Acked-by: Jani Nikula <jani.nikula@intel.com>

>
> We'll also need this for the next commit, so that we can remove
> drm_dp_mst_port_has_audio().
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Sean Paul <sean@poorly.run>
> ---
>  drivers/gpu/drm/i915/display/intel_display_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
> index 5a0adf14ebef..0ddc98afe252 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> @@ -438,7 +438,7 @@ struct intel_connector {
>  	   state of connector->polled in case hotplug storm detection changes it */
>  	u8 polled;
>  
> -	void *port; /* store this opaque as its illegal to dereference it */
> +	struct drm_dp_mst_port *port;
>  
>  	struct intel_dp *mst_port;

-- 
Jani Nikula, Intel Open Source Graphics Center
