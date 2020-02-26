Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3505CC4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F295A24653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7btSr02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgBZScC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:32:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40001 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgBZScB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:32:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id t24so75354pgj.7;
        Wed, 26 Feb 2020 10:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q3qhiKBb/iu+MS/z1QmAW+S36stKOD7iEfRY96CLFjc=;
        b=t7btSr02u4Hz2Z/p5E3FRcFD5IFExMLCKZL19u1I/dwRFSvuXD142qb7ba6bDgww45
         VE7W1thPz3qkWChoQxF23XdiS/Omc8rbKkIRPhcn3HCtsjlCrL60LOrj/VSOf7Ia0VKL
         SCjZFd4/DhqMRTpHUUg+OV2SGHE3ZnR0OnfVAyiB7hoNIyfhc0jcNTI0bz4d/L0FAg1V
         LHQ8Evwex49FkNtxLSs5WKaifui7ar+Uo9OB1GseHOVels/hf48kMppA7pYYm8znwp72
         uCZ9fCvUirJW6RB3sfxxEgElkfdrDRiIC36jtjG6XgkJePhivBdc6rUTztLjZStlfxc8
         JAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q3qhiKBb/iu+MS/z1QmAW+S36stKOD7iEfRY96CLFjc=;
        b=mCm0J71wjBnXoXN0FqaBPB00aRadrGE3R/jYlbK0cts02wMciZAIsDB1PkDyUeNfRy
         raHZF0ahLHzxtjqmBHF7xBih0k2RjR9+ok4iGDYDSXnGbFP/LONo2gRbhzKTknDVsr7l
         LE4Ere93Kf1G+MLW2w+Wrp2LnnaTc3QSYWzBV2sAjCwG/LWsQ0SvCqgwcBtaWr5ZuMbN
         7Llqr/rFDl0F07xfGcVaJ6TPe6zzrJyHfQrQzZVJaaGY33iGNzJfKix4EOi3FYa2i2gc
         FfkY8FRl1sc8Wu5rTKzk5BWnwXg8affVEIQc0+x4nRBwPsP7aRKeFDaJ13FjOUCzHtuX
         FWCQ==
X-Gm-Message-State: APjAAAW4Vu1ILzkMF9H5pi+9UVGgt9pDzHs7GAARoH6KihkpjqDKt7J5
        P0r0JPuwXjcFzqcmIOoOukk=
X-Google-Smtp-Source: APXvYqytw9Txxq1Ki+QW6u4/TVPNLMFknl13r94SV99qpjFyaoOmkIVP9YoRQ9z2aZQtemUqMd3krQ==
X-Received: by 2002:a63:1d18:: with SMTP id d24mr151492pgd.189.1582741919996;
        Wed, 26 Feb 2020 10:31:59 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u12sm3676301pfm.165.2020.02.26.10.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Feb 2020 10:31:59 -0800 (PST)
Date:   Wed, 26 Feb 2020 10:31:57 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        pumahsu@google.com
Subject: Re: [PATCH v3] usb: typec: Add sysfs node to show cc orientation
Message-ID: <20200226183157.GA16309@roeck-us.net>
References: <20200226182517.49214-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226182517.49214-1-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 10:25:17AM -0800, Badhri Jagan Sridharan wrote:
> Export Type-C orientation information when available.
> - "normal": CC1 orientation
> - "reverse": CC2 orientation
> - "unknown": Orientation cannot be determined.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Version history:
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
>  drivers/usb/typec/class.c                   | 27 +++++++++++++++++++++
>  drivers/usb/typec/tcpm/tcpm.c               |  1 +
>  include/linux/usb/typec.h                   |  1 +
>  4 files changed, 38 insertions(+)
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
> index 12be5bb6d32ca..2524f1571e425 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1244,6 +1244,26 @@ static ssize_t usb_power_delivery_revision_show(struct device *dev,
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
> +	case TYPEC_ORIENTATION_NONE:
> +		return sprintf(buf, "%s\n", "unknown");
> +	case TYPEC_ORIENTATION_NORMAL:
> +		return sprintf(buf, "%s\n", "normal");
> +	case TYPEC_ORIENTATION_REVERSE:
> +		return sprintf(buf, "%s\n", "reverse");
> +	default:
> +		return sprintf(buf, "%s\n", "unknown");

TYPEC_ORIENTATION_NONE and default can be handled in a single case statement.

> +	}
> +}
> +static DEVICE_ATTR_RO(orientation);
> +
>  static struct attribute *typec_attrs[] = {
>  	&dev_attr_data_role.attr,
>  	&dev_attr_power_operation_mode.attr,
> @@ -1254,6 +1274,7 @@ static struct attribute *typec_attrs[] = {
>  	&dev_attr_usb_typec_revision.attr,
>  	&dev_attr_vconn_source.attr,
>  	&dev_attr_port_type.attr,
> +	&dev_attr_orientation.attr,
>  	NULL,
>  };
>  
> @@ -1283,6 +1304,10 @@ static umode_t typec_attr_is_visible(struct kobject *kobj,
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
> @@ -1493,6 +1518,8 @@ int typec_set_orientation(struct typec_port *port,
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
