Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11018C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBF220775
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgGAIWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:22:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:16270 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgGAIWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:22:33 -0400
IronPort-SDR: uoHWjciRQc22/Cz7YqEBVodydEOWk0xyxsIzPgfctjmoXy/5pATslB7Wg3aQFomFPfqL8ovvC3
 apu1XfPOkxHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="126600356"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="126600356"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 01:22:33 -0700
IronPort-SDR: UxfLNcQYuiJvpdPz8HpFrlTDXY+jczgF1A1EGlKOj/NjPYco/JmGWlpIw2C70SdMWBPuDFPnf9
 w5cNCeaFB4aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="386943357"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 01 Jul 2020 01:22:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 01 Jul 2020 11:22:30 +0300
Date:   Wed, 1 Jul 2020 11:22:30 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB TYPEC CLASS" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: Add num_altmodes partner attribute
Message-ID: <20200701082230.GF856968@kuha.fi.intel.com>
References: <20200701003149.3101219-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701003149.3101219-1-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On Tue, Jun 30, 2020 at 05:31:48PM -0700, Prashant Malani wrote:
> Add a user-visible attribute for the number of alt modes available in a
> partner. This allows userspace to determine whether there are any
> remaining alt modes left to be registered by the kernel driver. It can
> begin implementing any policy state machine after all available alt
> modes have been registered with the connector class framework.
> 
> This value is set to "-1" initially, which is an invalid value,
> signifying that a valid number of alt modes haven't been set for the
> partner.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> ---
>  drivers/usb/typec/class.c | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/usb/typec.h |  1 +
>  2 files changed, 35 insertions(+)

You need to add documentation for the file. Add an entry for it to
Documentation/ABI/testing/sysfs-class-typec

> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index c9234748537a..680cbcfbd427 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -33,6 +33,7 @@ struct typec_partner {
>  	struct usb_pd_identity		*identity;
>  	enum typec_accessory		accessory;
>  	struct ida			mode_ids;
> +	int				num_altmodes;
>  };
>  
>  struct typec_port {
> @@ -532,9 +533,18 @@ static ssize_t supports_usb_power_delivery_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(supports_usb_power_delivery);
>  
> +static ssize_t num_altmodes_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct typec_partner *p = to_typec_partner(dev);
> +
> +	return sprintf(buf, "%d\n", p->num_altmodes);
> +}
> +static DEVICE_ATTR_RO(num_altmodes);

This is up to you, but please consider naming the file
"number_of_alternate_modes".

So now user space needs to understand that value -1 means "unknown",
right?

If so, then I think it would probable be better to just hide the file
until the actual number of alternate modes is known.

>  static struct attribute *typec_partner_attrs[] = {
>  	&dev_attr_accessory_mode.attr,
>  	&dev_attr_supports_usb_power_delivery.attr,
> +	&dev_attr_num_altmodes.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(typec_partner);

-ATTRIBUTE_GROUPS(typec_partner);

static umode_t typec_partner_attr_is_visible(struct kobject *kobj,
                                             struct attribute *attr, int n)
{
        struct typec_partner *partner = to_typec_partner(kobj_to_dev(kobj));

        if (attr == &dev_attr_num_altmodes.attr) {
                if (partner->num_altmodes < 0)
                        return 0;
        }

        return attr->mode;
}

static struct attribute_group typec_partner_group = {
        .is_visible = typec_partner_attr_is_visible,
        .attrs = typec_partner_attrs
};

static const struct attribute_group *typec_partner_groups[] = {
        &typec_partner_group,
        NULL
};

> @@ -570,6 +580,29 @@ int typec_partner_set_identity(struct typec_partner *partner)
>  }
>  EXPORT_SYMBOL_GPL(typec_partner_set_identity);
>  
> +/**
> + * typec_partner_set_num_altmodes - Update number of available altmodes
> + * @partner: The partner to be updated
> + * @num_alt_modes: The number of altmodes we want to specify as available
> + *
> + * This routine is used to report the number of alternate modes supported by the
> + * partner. This value is *not* enforced in alt mode registration routines.
> + *
> + * @partner.num_altmodes is set to -1 on partner registration, denoting that
> + * a valid value has not been set for it yet.
> + */
> +int typec_partner_set_num_altmodes(struct typec_partner *partner, int num_altmodes)
> +{
> +	if (num_altmodes < 0)
> +		return -EINVAL;
> +
> +	partner->num_altmodes = num_altmodes;
> +	sysfs_notify(&partner->dev.kobj, NULL, "num_altmodes");
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(typec_partner_set_num_altmodes);
> +
>  /**
>   * typec_partner_register_altmode - Register USB Type-C Partner Alternate Mode
>   * @partner: USB Type-C Partner that supports the alternate mode
> @@ -612,6 +645,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
>  	ida_init(&partner->mode_ids);
>  	partner->usb_pd = desc->usb_pd;
>  	partner->accessory = desc->accessory;
> +	partner->num_altmodes = -1;
>  
>  	if (desc->identity) {
>  		/*
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 5daa1c49761c..ab523caa23a4 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -112,6 +112,7 @@ struct typec_altmode_desc {
>  	enum typec_port_data	roles;
>  };
>  
> +int typec_partner_set_num_altmodes(struct typec_partner *partner, int num_altmodes);
>  struct typec_altmode
>  *typec_partner_register_altmode(struct typec_partner *partner,
>  				const struct typec_altmode_desc *desc);

thanks,

-- 
heikki
