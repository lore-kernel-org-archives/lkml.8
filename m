Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63AAC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFFAD20855
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgHNPAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:00:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:43547 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgHNPAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:00:03 -0400
IronPort-SDR: EwJ/yCgjs1P30tJsC/te3gUP7jOHl84nhYXTLmJXbQ2+OYSKKgMJhs8uQLEsWSXPYw7+/QS8Yg
 pabUaM4EhGAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="218749411"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="218749411"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 08:00:02 -0700
IronPort-SDR: qXLncTL+D12Da8n3XKmSgtAdaPW+F4mm7X8HbRAVha/MH5m61Kq6NkIXTcWjj/wR0oET+VJHtL
 gnPZUYFqSqfw==
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="470609116"
Received: from ideak-desk.fi.intel.com ([10.237.68.141])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 07:59:59 -0700
Date:   Fri, 14 Aug 2020 17:59:56 +0300
From:   Imre Deak <imre.deak@intel.com>
To:     Sam McNally <sammc@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/dp_mst: Add ddc i2c device links for DP MST
 connectors
Message-ID: <20200814145956.GA12962@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20200729161510.1.Iaa9c3d7c4332cf8717653f3d3ae6f2b955aa3fc6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729161510.1.Iaa9c3d7c4332cf8717653f3d3ae6f2b955aa3fc6@changeid>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 04:15:28PM +1000, Sam McNally wrote:
> As of commit d8bd15b37d32 ("drm/dp_mst: Fix the DDC I2C device
> registration of an MST port"), DP MST DDC I2C devices are consistently
> parented to the underlying DRM device, making it challenging to
> associate the ddc i2c device with its connector from userspace.

I can't see how was it less challenging before the commit. There is no
guarantee for a CSN message which was the only way for the i2c device to
get reparented to the connector.

> Given the need for further refactoring before the i2c devices can be
> parented to their connectors, in the meantime follow the pattern of
> commit e1a29c6c5955 ("drm: Add ddc link in sysfs created by
> drm_connector"), creating sysfs ddc links to the associated i2c device
> for MST DP connectors.
> 
> If the connector is created and registered before the i2c device, create
> the link when registering the i2c device; otherwise, create the link
> during late connector registration.
> 
> Signed-off-by: Sam McNally <sammc@chromium.org>
> ---
> 
>  drivers/gpu/drm/drm_dp_mst_topology.c | 29 +++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 1ac874e4e7a1..73a2299c2faa 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2161,11 +2161,23 @@ static void build_mst_prop_path(const struct drm_dp_mst_branch *mstb,
>  int drm_dp_mst_connector_late_register(struct drm_connector *connector,
>  				       struct drm_dp_mst_port *port)
>  {
> +	int ret;
>  	DRM_DEBUG_KMS("registering %s remote bus for %s\n",
>  		      port->aux.name, connector->kdev->kobj.name);
>  
>  	port->aux.dev = connector->kdev;
> -	return drm_dp_aux_register_devnode(&port->aux);
> +	ret = drm_dp_aux_register_devnode(&port->aux);
> +	if (ret)
> +		return ret;
> +
> +	if (port->pdt != DP_PEER_DEVICE_NONE &&
> +	    drm_dp_mst_is_end_device(port->pdt, port->mcs)) {

How can we get here when drm_dp_mst_is_end_device(port) is not true?
AFAICS that's only case where we should create a connector and an i2c
device. (IOW we don't create them for branch ports.)

> +		ret = sysfs_create_link(&port->connector->kdev->kobj,
> +					&port->aux.ddc.dev.kobj, "ddc");
> +		if (ret)
> +			drm_dp_aux_unregister_devnode(&port->aux);
> +	}
> +	return ret;
>  }
>  EXPORT_SYMBOL(drm_dp_mst_connector_late_register);
>  
> @@ -5490,6 +5502,7 @@ static int drm_dp_mst_register_i2c_bus(struct drm_dp_mst_port *port)
>  {
>  	struct drm_dp_aux *aux = &port->aux;
>  	struct device *parent_dev = port->mgr->dev->dev;
> +	int ret;
>  
>  	aux->ddc.algo = &drm_dp_mst_i2c_algo;
>  	aux->ddc.algo_data = aux;
> @@ -5504,7 +5517,17 @@ static int drm_dp_mst_register_i2c_bus(struct drm_dp_mst_port *port)
>  	strlcpy(aux->ddc.name, aux->name ? aux->name : dev_name(parent_dev),
>  		sizeof(aux->ddc.name));
>  
> -	return i2c_add_adapter(&aux->ddc);
> +	ret = i2c_add_adapter(&aux->ddc);
> +	if (ret)
> +		return ret;
> +
> +	if (port->connector && port->connector->kdev) {
> +		ret = sysfs_create_link(&port->connector->kdev->kobj,
> +					&port->aux.ddc.dev.kobj, "ddc");
> +		if (ret)
> +			i2c_del_adapter(&port->aux.ddc);
> +	}
> +	return ret;
>  }
>  
>  /**
> @@ -5513,6 +5536,8 @@ static int drm_dp_mst_register_i2c_bus(struct drm_dp_mst_port *port)
>   */
>  static void drm_dp_mst_unregister_i2c_bus(struct drm_dp_mst_port *port)
>  {
> +	if (port->connector && port->connector->kdev)
> +		sysfs_remove_link(&port->connector->kdev->kobj, "ddc");
>  	i2c_del_adapter(&port->aux.ddc);
>  }
>  
> -- 
> 2.28.0.rc0.142.g3c755180ce-goog
> 
