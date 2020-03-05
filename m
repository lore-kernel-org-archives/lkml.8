Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40219C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198532073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgCENLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:11:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:64782 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgCENLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 08:11:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 05:11:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="259178067"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 05 Mar 2020 05:11:19 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 05 Mar 2020 15:11:19 +0200
Date:   Thu, 5 Mar 2020 15:11:19 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Sean Paul <seanpaul@google.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>
Subject: Re: [PATCH 2/3] drm/dp_mst: Don't show connectors as connected
 before probing available PBN
Message-ID: <20200305131119.GJ13686@intel.com>
References: <20200304223614.312023-1-lyude@redhat.com>
 <20200304223614.312023-3-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200304223614.312023-3-lyude@redhat.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 05:36:12PM -0500, Lyude Paul wrote:
> It's next to impossible for us to do connector probing on topologies
> without occasionally racing with userspace, since creating a connector
> itself causes a hotplug event which we have to send before probing the
> available PBN of a connector. Even if we didn't have this hotplug event
> sent, there's still always a chance that userspace started probing
> connectors before we finished probing the topology.
> 
> This can be a problem when validating a new MST state since the
> connector will be shown as connected briefly, but without any available
> PBN - causing any atomic state which would enable said connector to fail
> with -ENOSPC. So, let's simply workaround this by telling userspace new
> MST connectors are disconnected until we've finished probing their PBN.
> Since we always send a hotplug event at the end of the link address
> probing process, userspace will still know to reprobe the connector when
> we're ready.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: cd82d82cbc04 ("drm/dp_mst: Add branch bandwidth validation to MST atomic check")
> Cc: Mikita Lipski <mikita.lipski@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Sean Paul <seanpaul@google.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 207eef08d12c..7b0ff0cff954 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -4033,6 +4033,19 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
>  			ret = connector_status_connected;
>  		break;
>  	}
> +
> +	/* We don't want to tell userspace the port is actually plugged into
> +	 * anything until we've finished probing it's available_pbn, otherwise

"its"

Why is the connector even registered before we've finished the probe?

> +	 * userspace will see racy atomic check failures
> +	 *
> +	 * Since we always send a hotplug at the end of probing topology
> +	 * state, we can just let userspace reprobe this connector later.
> +	 */
> +	if (ret == connector_status_connected && !port->available_pbn) {
> +		DRM_DEBUG_KMS("[CONNECTOR:%d:%s] not ready yet (PBN not probed)\n",
> +			      connector->base.id, connector->name);
> +		ret = connector_status_disconnected;
> +	}
>  out:
>  	drm_dp_mst_topology_put_port(port);
>  	return ret;
> -- 
> 2.24.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
