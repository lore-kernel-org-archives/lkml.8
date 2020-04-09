Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB35BC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9C520784
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CKDvhkRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgDIWjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:39:53 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37030 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgDIWjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 18:39:52 -0400
Received: by mail-pj1-f68.google.com with SMTP id z9so85863pjd.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 15:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZTo7fS1c7JQ1zQDsXBTPOd0MLir4S/2kq1Rxdb9T17I=;
        b=CKDvhkRW4iToE6vDmGng0pWEgA8m50IAtxxfNfuHGkgIa0heusRrvOwqiUjak0hJ27
         BhxYEnz/ONm42zHJAYBpiYqpaa9i2ibg0Flo6Uo1IL6NA1B/4qeAaFaqVw7oFbq3IQMc
         MMh3pgV89tMgKypTtmDSX+Ww7E9+tPwP9GZXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZTo7fS1c7JQ1zQDsXBTPOd0MLir4S/2kq1Rxdb9T17I=;
        b=bGzHcXcMtlzjzED4mKgbWRhrjtEz4ZGrbq6A8w5zt4sPPdex2TK1qH/UxmzMYtaz7Y
         6igviYKo779xjpPfE8Cj5ITlee9ZrxsSCWe6Lld0iryz3s03ws/G0qoq5GGku405HHpB
         qa0zDaQ4NRA0qpHb0O94ve1AZYyrDsbjNcgECw5t5sqVRUTniqKMnn+hWxoPOI7KytE0
         HAs1U8GO0zQeKdXYJcUBEbFADs6t9ZiKd02t/iRz5mWmvPNZtKl/KeTqkqcctVLScQFQ
         DwhDspn0em2EPzkA4+uhc6P8QB/BVK9+Pc8czWTjSZ1c/h8ScjzHNjleuAgQDG8OLBfJ
         of8w==
X-Gm-Message-State: AGi0PuYl/4rIUv8m2MzUJEiIY1PjZO1EiUWJDqeEIjq5Un8ltSUc+lLI
        pej/NyEEZnGqKeR3TyUz6k9aQA==
X-Google-Smtp-Source: APiQypKQ2e6DPmgkd+9ST6ieh71A/LLPEDyWKTqai/bP0Q3IW2CR0jzIUXJOOhM2IvdPjH20N2ZgUA==
X-Received: by 2002:a17:902:7405:: with SMTP id g5mr1799912pll.118.1586471991855;
        Thu, 09 Apr 2020 15:39:51 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id z7sm135514pfz.24.2020.04.09.15.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 15:39:51 -0700 (PDT)
Date:   Thu, 9 Apr 2020 15:39:50 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 2/3] platform/chrome: typec: Add struct for port data
Message-ID: <20200409223950.GB15090@google.com>
References: <20200407010940.155490-1-pmalani@chromium.org>
 <20200407010940.155490-3-pmalani@chromium.org>
 <e124df15-396b-8599-23ad-153196f6787f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e124df15-396b-8599-23ad-153196f6787f@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Enric,

On Thu, Apr 09, 2020 at 11:19:51PM +0200, Enric Balletbo i Serra wrote:
> Hi Prashant,
> 
> Thank you for the patch.
> 
> On 7/4/20 3:09, Prashant Malani wrote:
> > Add a separate struct for storing port data, including Type C connector
> > class struct pointers and caps.
> > 
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 49 ++++++++++++++++---------
> >  1 file changed, 32 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index cf7c2652a1d6d..1955e1dfebc6d 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -17,6 +17,13 @@
> >  
> >  #define DRV_NAME "cros-ec-typec"
> >  
> > +/* Per port data. */
> > +struct cros_typec_port {
> > +	struct typec_port *port;
> > +	/* Initial capabilities for the port. */
> > +	struct typec_capability caps;
> > +};
> > +
> >  /* Platform-specific data for the Chrome OS EC Type C controller. */
> >  struct cros_typec_data {
> >  	struct device *dev;
> > @@ -24,9 +31,7 @@ struct cros_typec_data {
> >  	int num_ports;
> >  	unsigned int cmd_ver;
> >  	/* Array of ports, indexed by port number. */
> > -	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
> > -	/* Initial capabilities for each port. */
> > -	struct typec_capability *caps[EC_USB_PD_MAX_PORTS];
> > +	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
> >  	struct notifier_block nb;
> >  };
> >  
> > @@ -76,14 +81,26 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
> >  	return 0;
> >  }
> >  
> > +static void cros_unregister_ports(struct cros_typec_data *typec)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < typec->num_ports; i++) {
> > +		if (!typec->ports[i])
> > +			continue;
> > +		typec_unregister_port(typec->ports[i]->port);
> > +		devm_kfree(typec->dev, typec->ports[i]);
> 
> This is not needed, the allocated memory is device managed, so will be freed on
> removal or error.
> 
Got it. Will make the change.
> > +	}
> > +}
> > +
> >  static int cros_typec_init_ports(struct cros_typec_data *typec)
> >  {
> >  	struct device *dev = typec->dev;
> >  	struct typec_capability *cap;
> >  	struct fwnode_handle *fwnode;
> > +	struct cros_typec_port *cros_port;
> >  	const char *port_prop;
> >  	int ret;
> > -	int i;
> >  	int nports;
> >  	u32 port_num = 0;
> >  
> > @@ -115,22 +132,23 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
> >  
> >  		dev_dbg(dev, "Registering port %d\n", port_num);
> >  
> > -		cap = devm_kzalloc(dev, sizeof(*cap), GFP_KERNEL);
> > -		if (!cap) {
> > +		cros_port = devm_kzalloc(dev, sizeof(*cros_port), GFP_KERNEL);
> > +		if (!cros_port) {
> >  			ret = -ENOMEM;
> >  			goto unregister_ports;
> >  		}
> >  
> > -		typec->caps[port_num] = cap;
> > +		typec->ports[port_num] = cros_port;
> > +		cap = &cros_port->caps;
> >  
> >  		ret = cros_typec_parse_port_props(cap, fwnode, dev);
> >  		if (ret < 0)
> >  			goto unregister_ports;
> >  
> > -		typec->ports[port_num] = typec_register_port(dev, cap);
> > -		if (IS_ERR(typec->ports[port_num])) {
> > +		cros_port->port = typec_register_port(dev, cap);
> > +		if (IS_ERR(cros_port->port)) {
> >  			dev_err(dev, "Failed to register port %d\n", port_num);
> > -			ret = PTR_ERR(typec->ports[port_num]);
> > +			ret = PTR_ERR(cros_port->port);
> >  			goto unregister_ports;
> >  		}
> >  	}
> > @@ -138,8 +156,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
> >  	return 0;
> >  
> >  unregister_ports:
> > -	for (i = 0; i < typec->num_ports; i++)
> > -		typec_unregister_port(typec->ports[i]);
> > +	cros_unregister_ports(typec);
> >  	return ret;
> >  }
> >  
> > @@ -177,7 +194,7 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
> >  static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
> >  		int port_num, struct ec_response_usb_pd_control *resp)
> >  {
> > -	struct typec_port *port = typec->ports[port_num];
> > +	struct typec_port *port = typec->ports[port_num]->port;
> >  	enum typec_orientation polarity;
> >  
> >  	if (!resp->enabled)
> > @@ -194,7 +211,7 @@ static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
> >  static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
> >  		int port_num, struct ec_response_usb_pd_control_v1 *resp)
> >  {
> > -	struct typec_port *port = typec->ports[port_num];
> > +	struct typec_port *port = typec->ports[port_num]->port;
> >  	enum typec_orientation polarity;
> >  
> >  	if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
> > @@ -360,9 +377,7 @@ static int cros_typec_probe(struct platform_device *pdev)
> >  	return 0;
> >  
> >  unregister_ports:
> > -	for (i = 0; i < typec->num_ports; i++)
> > -		if (typec->ports[i])
> > -			typec_unregister_port(typec->ports[i]);
> > +	cros_unregister_ports(typec);
> >  	return ret;
> >  }
> >  
> > 
