Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E62EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09082207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EO1eXWop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgERHTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgERHTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:19:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B00C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:19:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k22so3858726pls.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WVFh+4Ha9mZOApYSDiuWex3T25j+GoBxtN60ulbtsJY=;
        b=EO1eXWopSKln5Y4ycat+BsK/qIxFlor917ewDjfkp0ZwYOKdTQTgDMIKCFxGMLWSsw
         Q4vgCZqAEAqyATZYPGCOhsVTVCboJf31wk6T6xE1CUeYIx1ivBIXh5Q6pT8vbQzuXJGQ
         YNjqUHCpgl2KqZ4EpBrpwp6sQFN9gspTtU9P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WVFh+4Ha9mZOApYSDiuWex3T25j+GoBxtN60ulbtsJY=;
        b=QF1W1uFI/H02Yrzd+i47XAY0l2cb+hMSDuVra1wde+hbsNicckL0SnGviOHga3mAnO
         h/S6vDFmC0mFPSL1nK8bvW8aG35Z1GeJ5QiWVH4uGdTbn5A/NKmjUFbm8UcKRA0POFw0
         jkpIl54gw8J+NKxn8r8ia5p7SAcXfpEzwUr07N4Uu945ODjhrJW9CTJtNoO4tib/OSCG
         YVlpaLJ+rmLby+YyXHLxBtYdAQzuCzITjXT57tC+Z3+G8snDdLGf+Pcwj3Spt2Mr+RQB
         I9MyhzW3kwtuPMikbS9Bwl8E1564Qev1fiE2JuPeTf+yoJeMnhjJBujJLKvW+yysSDSd
         9LKA==
X-Gm-Message-State: AOAM530WPkqtDs5OTrXbwjuLrDSSyDp36oSEzGSUOnZfe9CrvprPIH3x
        yVH83YrzUSUEr8KfNxoJ+SCk7A==
X-Google-Smtp-Source: ABdhPJyFGtTRe44FWgxSKAHAHklgP7aWM6M0xi6BixzJQd/xkpLbbYJ3Txl6vF9ylrc7pP3B3sbchg==
X-Received: by 2002:a17:90a:a102:: with SMTP id s2mr13907294pjp.94.1589786373189;
        Mon, 18 May 2020 00:19:33 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id x2sm3105831pfc.106.2020.05.18.00.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 00:19:32 -0700 (PDT)
Date:   Mon, 18 May 2020 00:19:32 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com,
        twawrzynczak@chromium.org, Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] platform/chrome: typec: Register Type C switches
Message-ID: <20200518071932.GA162029@google.com>
References: <20200422222242.241699-1-pmalani@chromium.org>
 <20200422222242.241699-2-pmalani@chromium.org>
 <542cfe8f-04a5-8dbb-b498-90254bb4c54e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542cfe8f-04a5-8dbb-b498-90254bb4c54e@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Thu, Apr 30, 2020 at 12:25:10AM +0200, Enric Balletbo i Serra wrote:
> Hi Prashant,
> 
> Following my previous comments ...
> 
> On 23/4/20 0:22, Prashant Malani wrote:
> > Register Type C mux and switch handles, when provided via firmware
> > bindings. These will allow the cros-ec-typec driver, and also alternate
> > mode drivers to configure connected Muxes correctly, according to PD
> > information retrieved from the Chrome OS EC.
> > 
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 47 +++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> > 
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index eda57db26f8d..324ead297c4d 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -14,6 +14,8 @@
> >  #include <linux/platform_data/cros_usbpd_notify.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/usb/typec.h>
> > +#include <linux/usb/typec_mux.h>
> > +#include <linux/usb/role.h>
> >  
> >  #define DRV_NAME "cros-ec-typec"
> >  
> > @@ -25,6 +27,9 @@ struct cros_typec_port {
> >  	struct typec_partner *partner;
> >  	/* Port partner PD identity info. */
> >  	struct usb_pd_identity p_identity;
> > +	struct typec_switch *ori_sw;
> > +	struct typec_mux *mux;
> > +	struct usb_role_switch *role_sw;
> >  };
> >  
> >  /* Platform-specific data for the Chrome OS EC Type C controller. */
> > @@ -84,6 +89,40 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
> >  	return 0;
> >  }
> >  
> > +static int cros_typec_get_switch_handles(struct cros_typec_port *port,
> > +					 struct fwnode_handle *fwnode,
> > +					 struct device *dev)
> > +{
> > +	port->mux = fwnode_typec_mux_get(fwnode, NULL);
> > +	if (IS_ERR(port->mux)) {
> > +		dev_info(dev, "Mux handle not found.\n");
> 
> Be quiet also here, dev_dbg at most, as you're ignoring the error anyway at the end.
> 

Done.
> > +		goto mux_err;
> > +	}
> > +
> > +	port->ori_sw = fwnode_typec_switch_get(fwnode);
> > +	if (IS_ERR(port->ori_sw)) {
> > +		dev_info(dev, "Orientation switch handle not found.\n");
> 
> Same here
> 
Done.
> > +		goto ori_sw_err;
> > +	}
> > +
> > +	port->role_sw = fwnode_usb_role_switch_get(fwnode);
> > +	if (IS_ERR(port->role_sw)) {
> > +		dev_info(dev, "USB role switch handle not found.\n");
> 
> And here.
> 

Done.

Thanks for the review. I've uploaded a new version of the patches.

Best regards,

-Prashant
> > +		goto role_sw_err;
> > +	}
> > +
> > +	return 0;
> > +
> > +role_sw_err:
> > +	usb_role_switch_put(port->role_sw);
> > +ori_sw_err:
> > +	typec_switch_put(port->ori_sw);
> > +mux_err:
> > +	typec_mux_put(port->mux);
> > +
> > +	return -ENODEV;
> > +}
> > +
> >  static void cros_unregister_ports(struct cros_typec_data *typec)
> >  {
> >  	int i;
> > @@ -91,6 +130,9 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
> >  	for (i = 0; i < typec->num_ports; i++) {
> >  		if (!typec->ports[i])
> >  			continue;
> > +		usb_role_switch_put(typec->ports[i]->role_sw);
> > +		typec_switch_put(typec->ports[i]->ori_sw);
> > +		typec_mux_put(typec->ports[i]->mux);
> >  		typec_unregister_port(typec->ports[i]->port);
> >  	}
> >  }
> > @@ -153,6 +195,11 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
> >  			ret = PTR_ERR(cros_port->port);
> >  			goto unregister_ports;
> >  		}
> > +
> > +		ret = cros_typec_get_switch_handles(cros_port, fwnode, dev);
> > +		if (ret)
> > +			dev_info(dev, "No switch control for port %d\n",
> > +				 port_num);
> >  	}
> >  
> >  	return 0;
> > 
