Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665C1C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB4820692
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgDIVBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:01:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41980 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDIVBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:01:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 079EF290E5E
Subject: Re: [PATCH 1/3] platform/chrome: typec: Use notifier for updates
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200407010940.155490-1-pmalani@chromium.org>
 <20200407010940.155490-2-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <12997222-5df5-1e16-3eb1-1e26252315f8@collabora.com>
Date:   Thu, 9 Apr 2020 23:01:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200407010940.155490-2-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for the patch.

On 7/4/20 3:09, Prashant Malani wrote:
> Register a listener for the cros-usbpd-notifier, and update port state
> when a notification comes in.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 874269c070739..cf7c2652a1d6d 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -11,6 +11,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_data/cros_usbpd_notify.h>

I think you need to add a kconfig dependency/selection in order to don't have
build problems.

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
> +			dev_warn(typec->dev, "Update failed for port:%d\n", i);

nit: space between : and %d

> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id cros_typec_acpi_id[] = {
>  	{ "GOOG0014", 0 },
> @@ -332,6 +350,13 @@ static int cros_typec_probe(struct platform_device *pdev)
>  			goto unregister_ports;
>  	}
>  
> +	typec->nb.notifier_call = cros_ec_typec_event;
> +	ret = cros_usbpd_register_notify(&typec->nb);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register notifier\n");

Currently cros_usbpd_register_notfity calls blocking_notifier_chain_register
that always return zero. Is fine to check the error but the print is unneded. If
probe fails will report the error.

> +		goto unregister_ports;
> +	}
> +
>  	return 0;
>  
>  unregister_ports:
> 
