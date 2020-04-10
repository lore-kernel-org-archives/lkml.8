Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367C5C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1E6206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WBsMK3Fs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgDJATo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:19:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39615 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDJATo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:19:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id k18so113089pll.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9EUTXaTUFB2pWncSBsioY1lTjQ1L+vkFFp1XdzebrEE=;
        b=WBsMK3Fs+YeWI0v+GMljiRFHhYyDe2y6EYqBOigpCv9UcFH9xnTc+O85NIB+Zq80Jb
         Tg9ctXmxuHklwYjAWiW7AhDYvAzabQRT6EbsgujqYj+MgSKkymlicrulyUHntZu0sHfj
         VKq//ztR51c94C3oLHkWk5zzGVI3ReSIJZO3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9EUTXaTUFB2pWncSBsioY1lTjQ1L+vkFFp1XdzebrEE=;
        b=rCfVugC1r37ZpUSFSM89rqh2c30cVRm7e1qP6+Foi+LsCh52AoAJQ4HCkHkvmz+l24
         4wep6lzEcvkserFR126V3uICvEjzaJo1JFyGQxVi+wFDAcUX37D+iHcN7ijTMcdT6giV
         sYjxXF4Kg5iEdi9WpT3KEIB28/Gdv1+RuNrirQdFhGgnQNIgQcaPNXUbXN2H2R5VXh3y
         fp4pkPZK5+HQkfzRj9IEj69u0bhI7DAkPUve2/zG2+qPLgnT9VjuUyUVngP1JV+21Lxt
         DmWPU35Vhn/oAI1M8WqH8SSX86jOm0JiMC5A6VT+wzRQKHDQiSZ+cS+IY3Onu530n/Zk
         F9aA==
X-Gm-Message-State: AGi0PubzcjoOxEzbhxwo7RVh12Pwv8PrWTlF8xAvQnC7jQCJz5Y787Yo
        MBge3fNy6nmNSfgAxrTUfFHjgHHNz24=
X-Google-Smtp-Source: APiQypJY0XteGDUhfRpFCDE5eggkPb6GDv/n1eI884lV66vBslOvlsbQ559aKTROo0YLlsxpPC6u6g==
X-Received: by 2002:a17:902:b284:: with SMTP id u4mr2034225plr.97.1586477983712;
        Thu, 09 Apr 2020 17:19:43 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id f15sm233349pfd.215.2020.04.09.17.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 17:19:43 -0700 (PDT)
Date:   Thu, 9 Apr 2020 17:19:42 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 1/3] platform/chrome: typec: Use notifier for updates
Message-ID: <20200410001942.GA201188@google.com>
References: <20200410000819.198668-1-pmalani@chromium.org>
 <20200410000819.198668-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410000819.198668-2-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Thu, Apr 09, 2020 at 05:08:19PM -0700, Prashant Malani wrote:
> Register a listener for the cros-usbpd-notifier, and update port state
> when a notification comes in.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
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
> index 03ea5129ed0c3..67fc9c567ae6c 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -218,6 +218,7 @@ config CROS_EC_TYPEC
>  	tristate "ChromeOS EC Type-C Connector Control"
>  	depends on MFD_CROS_EC_DEV && TYPEC
>  	default MFD_CROS_EC_DEV
> +	depends on CROS_USBPD_NOTIFY

Woops, looks like I got the ordering wrong here. My apologies, I will
send a new version of the series out.
>  	help
>  	  If you say Y here, you get support for accessing Type C connector
>  	  information from the Chrome OS EC.
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
> 
