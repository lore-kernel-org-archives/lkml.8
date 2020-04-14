Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46621C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0EE206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406886AbgDNHuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:50:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:17948 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406749AbgDNHt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:49:58 -0400
IronPort-SDR: tXDxMzFXh/jO1Ke0h8FGVxbwN/9jMN9L79ct7gVDKmYfiWu8k/yuk+5jGSpNhbnFgOOzXO0fBn
 dqVboFMFGLbg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 00:49:58 -0700
IronPort-SDR: hS3mSn/A5l5NAVio87rjivuq44fsUFgmrpSbM2Dj7MJEO3BSNfbi1ioWOmlI6Hsmf+P5ANekPn
 q6UkQakli8Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="363304781"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Apr 2020 00:49:56 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Apr 2020 10:49:35 +0300
Date:   Tue, 14 Apr 2020 10:49:35 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v3 1/3] platform/chrome: typec: Use notifier for updates
Message-ID: <20200414074935.GA2828150@kuha.fi.intel.com>
References: <20200410002316.202107-1-pmalani@chromium.org>
 <20200410002316.202107-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410002316.202107-2-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 05:23:15PM -0700, Prashant Malani wrote:
> Register a listener for the cros-usbpd-notifier, and update port state
> when a notification comes in.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v3:
> - Fixed ordering issue in Kconfig dependency.
> 
> Changes in v2:
> - Added Kconfig dependency to CROS_USBPD_NOTIFY.
> - Fixed spacing error.
> - Removed superfluous devm_warn() call.
> 
>  drivers/platform/chrome/Kconfig         |  1 +
>  drivers/platform/chrome/cros_ec_typec.c | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 03ea5129ed0c3..a484ab2c91ff0 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -217,6 +217,7 @@ config CROS_EC_SYSFS
>  config CROS_EC_TYPEC
>  	tristate "ChromeOS EC Type-C Connector Control"
>  	depends on MFD_CROS_EC_DEV && TYPEC
> +	depends on CROS_USBPD_NOTIFY
>  	default MFD_CROS_EC_DEV
>  	help
>  	  If you say Y here, you get support for accessing Type C connector
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 874269c070739..d444dd7422a2a 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -11,6 +11,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_data/cros_usbpd_notify.h>
>  #include <linux/platform_device.h>
>  #include <linux/usb/typec.h>
>  
> @@ -26,6 +27,7 @@ struct cros_typec_data {
>  	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
>  	/* Initial capabilities for each port. */
>  	struct typec_capability *caps[EC_USB_PD_MAX_PORTS];
> +	struct notifier_block nb;
>  };
>  
>  static int cros_typec_parse_port_props(struct typec_capability *cap,
> @@ -272,6 +274,22 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
>  	return 0;
>  }
>  
> +static int cros_ec_typec_event(struct notifier_block *nb,
> +			       unsigned long host_event, void *_notify)
> +{
> +	struct cros_typec_data *typec = container_of(nb, struct cros_typec_data,
> +						     nb);
> +	int ret, i;
> +
> +	for (i = 0; i < typec->num_ports; i++) {
> +		ret = cros_typec_port_update(typec, i);
> +		if (ret < 0)
> +			dev_warn(typec->dev, "Update failed for port: %d\n", i);
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id cros_typec_acpi_id[] = {
>  	{ "GOOG0014", 0 },
> @@ -332,6 +350,11 @@ static int cros_typec_probe(struct platform_device *pdev)
>  			goto unregister_ports;
>  	}
>  
> +	typec->nb.notifier_call = cros_ec_typec_event;
> +	ret = cros_usbpd_register_notify(&typec->nb);
> +	if (ret < 0)
> +		goto unregister_ports;
> +
>  	return 0;
>  
>  unregister_ports:
> -- 
> 2.26.0.110.g2183baf09c-goog

thanks,

-- 
heikki
