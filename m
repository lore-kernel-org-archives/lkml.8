Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC04C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B0120672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbgF3OW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:22:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:53658 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgF3OW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:22:59 -0400
IronPort-SDR: CvfHlA+0aDqLdUK9ChXLaQ2yxJphb9dOycWDFLhmo8GEyLeoll6VNSxi8Y0w4DAJ0MBaJ9QReZ
 B9GVjt5rqJ4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="144419247"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="144419247"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 07:22:58 -0700
IronPort-SDR: UigXKErjXKs6WPtNtfQFDGrTuG5eYxjya2rRfq29NkseFbmn3DtX2yLAT01AfBdZ9uCNyPJs5S
 zFeu9PVdnCSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="386709114"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Jun 2020 07:22:55 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 30 Jun 2020 17:22:54 +0300
Date:   Tue, 30 Jun 2020 17:22:54 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Use workqueue for
 port update
Message-ID: <20200630142254.GD856968@kuha.fi.intel.com>
References: <20200629211329.2185342-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629211329.2185342-1-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 02:13:27PM -0700, Prashant Malani wrote:
> Use a work queue to call the port update routines, instead of doing it
> directly in the PD notifier callback. This will prevent other drivers
> with PD notifier callbacks from being blocked on the port update routine
> completing.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v4:
> - Removed extra newline.
> - Moved both variable declarations into one line.
> 
> Changes in v3:
> - Use new 100 character line length limit.
> 
> Changes in v2:
> - No changes.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 0c041b79cbba..69c4118e280c 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -58,6 +58,7 @@ struct cros_typec_data {
>  	/* Array of ports, indexed by port number. */
>  	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
>  	struct notifier_block nb;
> +	struct work_struct port_work;
>  };
>  
>  static int cros_typec_parse_port_props(struct typec_capability *cap,
> @@ -619,18 +620,24 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
>  	return 0;
>  }
>  
> -static int cros_ec_typec_event(struct notifier_block *nb,
> -			       unsigned long host_event, void *_notify)
> +static void cros_typec_port_work(struct work_struct *work)
>  {
> -	struct cros_typec_data *typec = container_of(nb, struct cros_typec_data,
> -						     nb);
> -	int ret, i;
> +	struct cros_typec_data *typec = container_of(work, struct cros_typec_data, port_work);
> +	int i, ret;
>  
>  	for (i = 0; i < typec->num_ports; i++) {
>  		ret = cros_typec_port_update(typec, i);
>  		if (ret < 0)
>  			dev_warn(typec->dev, "Update failed for port: %d\n", i);
>  	}
> +}
> +
> +static int cros_ec_typec_event(struct notifier_block *nb,
> +			       unsigned long host_event, void *_notify)
> +{
> +	struct cros_typec_data *typec = container_of(nb, struct cros_typec_data, nb);
> +
> +	schedule_work(&typec->port_work);
>  
>  	return NOTIFY_OK;
>  }
> @@ -689,6 +696,12 @@ static int cros_typec_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> +	INIT_WORK(&typec->port_work, cros_typec_port_work);
> +
> +	/*
> +	 * Safe to call port update here, since we haven't registered the
> +	 * PD notifier yet.
> +	 */
>  	for (i = 0; i < typec->num_ports; i++) {
>  		ret = cros_typec_port_update(typec, i);
>  		if (ret < 0)
> -- 
> 2.27.0.212.ge8ba1cc988-goog

thanks,

-- 
heikki
