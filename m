Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A804C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DF62072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKIhrwLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgBZUfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:35:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41348 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgBZUfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:35:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id j9so351982pfa.8;
        Wed, 26 Feb 2020 12:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sXy/Dy54+x/cuPHlCKBH+H63/0QgwY0z0fgoHrfbmHM=;
        b=NKIhrwLeWMLzKkwQjFXmhl9Pl1ECNscgPzIhr/4LxF+wb3+M0ME+HixBMQ/ob181e4
         Ri3KdeJqeN1q2It1qQX1m08kb7pXub8y+1msOXZY1wcQDPvsr44NPL72JGprSl7Ov5d2
         RHb55lqFZCjNkEtsn9MYr3PJQHMdIrPFJ4Lvmaz8gFyz6GHzajEmMNa6xxQQSTT2gxFR
         +T12MhFETzy+8eEW9IiQq3pJxfLIjZ53d819Y9VSu/KR5bBcDDABuNC5RhtbMaUnJt6H
         mPiwNPKleXH6n4tENJTxMOvEVGmt6fa+amFq7iMedf5P6I+7x6sItsGk19hn0PVm3vyS
         mE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sXy/Dy54+x/cuPHlCKBH+H63/0QgwY0z0fgoHrfbmHM=;
        b=Z02SW1S9aPJyGyKLp5HLaMOWB44ZIPa5lYxUIDdhUOVVoSeXZeQu7MRwSzCLGJvvkS
         xZMzCSm8ac334lbMwI1qc5T+tKVjvHhyoFCBt9Swb6MWRGTUQEMEjpOCC5mge0a+oiju
         kzrGRsSM7D/V0X5CFgxEPw5Ta/+8ch+Y3Ngt1OhvorGQJjr2SzoGH00xAcEuwXfuP4Tb
         Kl1XhwFdfOviDD6ZPsh/sQXAUe4YRfB5HM5pjiGGKeMP1NehDbUAo/I18VV2VOgZXnn2
         0bqYgDD9D2EwgyyWnA840GBfzJFZYPrU9xqNWrrmDIINjSddf3YihT0qknL8ayBV5/2j
         vpDw==
X-Gm-Message-State: APjAAAVfvy1oS7E8eRbUXETqGSD741T1V2oC/rArVG53+7fLcdbYwynQ
        7qgdA6erXJTS0iDJLyuztQ0=
X-Google-Smtp-Source: APXvYqzjOoh/k598bwTAcVlNb06E8wlkdNXh430DZFqeDQEZrnvfOPJa07Q7ybfpuDrikYnq8zOZVA==
X-Received: by 2002:a62:5343:: with SMTP id h64mr434878pfb.171.1582749339254;
        Wed, 26 Feb 2020 12:35:39 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u12sm3847351pfm.165.2020.02.26.12.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Feb 2020 12:35:38 -0800 (PST)
Date:   Wed, 26 Feb 2020 12:35:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        pumahsu@google.com
Subject: Re: [PATCH v4] usb: typec: Add sysfs node to show cc orientation
Message-ID: <20200226203537.GA26758@roeck-us.net>
References: <20200226195758.150477-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226195758.150477-1-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 11:57:58AM -0800, Badhri Jagan Sridharan wrote:
> Export Type-C orientation information when available.
> - "normal": CC1 orientation
> - "reverse": CC2 orientation
> - "unknown": Orientation cannot be determined.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Version history:
> V4:
> - Greg's suggestion of Minor refractor to handle
>   TYPEC_ORIENTATION_NONE and default in the same case.
> V3:
> - Heikki's suggestion to us .is_visible callback.
>   unsigned int orientation_aware:1 has been introduced to
>   make support of this attribute optional for drivers such
>   as UCSI
> - Guenter's suggestion to rename to "orientation".
> - Heikki's suggestion to stick with string values instead
>   of exposing it as integer values.
> ---
>  Documentation/ABI/testing/sysfs-class-typec |  9 +++++++
>  drivers/usb/typec/class.c                   | 26 +++++++++++++++++++++
>  drivers/usb/typec/tcpm/tcpm.c               |  1 +
>  include/linux/usb/typec.h                   |  1 +
>  4 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index 0c2eb26fdc06b..b834671522d6f 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -108,6 +108,15 @@ Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  Description:
>  		Revision number of the supported USB Type-C specification.
>  
> +What:		/sys/class/typec/<port>/orientation
> +Date:		February 2020
> +Contact:	Badhri Jagan Sridharan <badhri@google.com>
> +Description:
> +		Indicates the active orientation of the Type-C connector.
> +		Valid values:
> +		- "normal": CC1 orientation
> +		- "reverse": CC2 orientation
> +		- "unknown": Orientation cannot be determined.
>  
>  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
>  
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 12be5bb6d32ca..bf97c31d0bba1 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1244,6 +1244,25 @@ static ssize_t usb_power_delivery_revision_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(usb_power_delivery_revision);
>  
> +static ssize_t orientation_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct typec_port *p = to_typec_port(dev);
> +	enum typec_orientation orientation = typec_get_orientation(p);
> +
> +	switch (orientation) {
> +	case TYPEC_ORIENTATION_NORMAL:
> +		return sprintf(buf, "%s\n", "normal");
> +	case TYPEC_ORIENTATION_REVERSE:
> +		return sprintf(buf, "%s\n", "reverse");
> +	case TYPEC_ORIENTATION_NONE:
> +	default:
> +		return sprintf(buf, "%s\n", "unknown");
> +	}
> +}
> +static DEVICE_ATTR_RO(orientation);
> +
>  static struct attribute *typec_attrs[] = {
>  	&dev_attr_data_role.attr,
>  	&dev_attr_power_operation_mode.attr,
> @@ -1254,6 +1273,7 @@ static struct attribute *typec_attrs[] = {
>  	&dev_attr_usb_typec_revision.attr,
>  	&dev_attr_vconn_source.attr,
>  	&dev_attr_port_type.attr,
> +	&dev_attr_orientation.attr,
>  	NULL,
>  };
>  
> @@ -1283,6 +1303,10 @@ static umode_t typec_attr_is_visible(struct kobject *kobj,
>  			return 0;
>  		if (port->cap->type != TYPEC_PORT_DRP)
>  			return 0444;
> +	} else if (attr == &dev_attr_orientation.attr) {
> +		if (port->cap->orientation_aware)
> +			return 0444;
> +		return 0;
>  	}
>  
>  	return attr->mode;
> @@ -1493,6 +1517,8 @@ int typec_set_orientation(struct typec_port *port,
>  	}
>  
>  	port->orientation = orientation;
> +	sysfs_notify(&port->dev.kobj, NULL, "orientation");
> +	kobject_uevent(&port->dev.kobj, KOBJ_CHANGE);
>  
>  	return 0;
>  }
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 78077c234ef27..bc0032a6b9a14 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4742,6 +4742,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	port->typec_caps.pd_revision = 0x0300;	/* USB-PD spec release 3.0 */
>  	port->typec_caps.driver_data = port;
>  	port->typec_caps.ops = &tcpm_ops;
> +	port->typec_caps.orientation_aware = 1;
>  
>  	port->partner_desc.identity = &port->partner_ident;
>  	port->port_type = port->typec_caps.type;
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 44d28387ced48..b00a2642a9cd6 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -211,6 +211,7 @@ struct typec_capability {
>  	u16			pd_revision; /* 0300H = "3.0" */
>  	int			prefer_role;
>  	enum typec_accessory	accessory[TYPEC_MAX_ACCESSORY];
> +	unsigned int		orientation_aware:1;
>  
>  	struct fwnode_handle	*fwnode;
>  	void			*driver_data;
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
