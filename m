Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E72CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10877206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593604909;
	bh=QKcT0eftuynQwl8bQ8Sy2DfoL4gw7pFgfGufIC0v47k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QuwUTIt+wH0KXJl/J709vuqZfqIG0+6RhrzgBO/d/Yt6q4hjIiPBI90q9RHPQ5OdK
	 P833dBFjwYm3zBL+RAqJZARp1DWJj/ByjWp+ns1X0rGm352WHyuuLnL9PwrtOjoeNw
	 lTYaorRX+EKh4eQlM9oXr9CIRnzSkzUHb1m35Oks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgGAMBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730103AbgGAMBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:01:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FDCF206B6;
        Wed,  1 Jul 2020 12:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593604905;
        bh=QKcT0eftuynQwl8bQ8Sy2DfoL4gw7pFgfGufIC0v47k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUbTEgBYXPpk93oGdn1jAtGSgdTJW4t8pdSCJEJHGiCeBuprLp3JlhGpwjK4ahAej
         QKPH1RQqgpEnwbdx5ns39hQfkIjKXI++KDRonv1WFbpxkvmJ+c0LAE/OAgkclHew7s
         pDzDkr/ux5VdvCg3I9IIBLwPkUCDaGWvNj+vSE7o=
Date:   Wed, 1 Jul 2020 14:01:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:USB TYPEC CLASS" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: Add num_altmodes partner attribute
Message-ID: <20200701120131.GC2184169@kroah.com>
References: <20200701003149.3101219-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701003149.3101219-1-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 
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
> +
>  static struct attribute *typec_partner_attrs[] = {
>  	&dev_attr_accessory_mode.attr,
>  	&dev_attr_supports_usb_power_delivery.attr,
> +	&dev_attr_num_altmodes.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(typec_partner);
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

Who is calling this?  We need a user before we can add a newly exported
function.

thanks,

greg k-h
