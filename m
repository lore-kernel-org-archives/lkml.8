Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A4DC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F04524656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgAVT5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:57:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:45239 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgAVT5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:57:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 11:57:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="275707040"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 22 Jan 2020 11:57:29 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 22 Jan 2020 21:57:29 +0200
Date:   Wed, 22 Jan 2020 21:57:29 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/dp_mst: Mention max_payloads in
 proposed_vcpis/payloads docs
Message-ID: <20200122195729.GI13686@intel.com>
References: <20200122194321.14953-1-lyude@redhat.com>
 <20200122194321.14953-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200122194321.14953-2-lyude@redhat.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 02:43:21PM -0500, Lyude Paul wrote:
> Mention that the size of these two structs is determined by
> max_payloads. Suggested by Ville Syrjälä.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>  include/drm/drm_dp_mst_helper.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index bcb39da9adb4..5483f888712a 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -635,11 +635,13 @@ struct drm_dp_mst_topology_mgr {
>  	struct mutex payload_lock;
>  	/**
>  	 * @proposed_vcpis: Array of pointers for the new VCPI allocation. The
> -	 * VCPI structure itself is &drm_dp_mst_port.vcpi.
> +	 * VCPI structure itself is &drm_dp_mst_port.vcpi, and the size of
> +	 * this array is determined by @max_payloads.
>  	 */
>  	struct drm_dp_vcpi **proposed_vcpis;
>  	/**
> -	 * @payloads: Array of payloads.
> +	 * @payloads: Array of payloads. The size of this array is determined
> +	 * by @max_payloads.
>  	 */

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

>  	struct drm_dp_payload *payloads;
>  	/**
> -- 
> 2.24.1

-- 
Ville Syrjälä
Intel
