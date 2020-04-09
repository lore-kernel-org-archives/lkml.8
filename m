Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEC5C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFCD20730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ks+HwLLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgDIWjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:39:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41106 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgDIWjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 18:39:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id b8so201986pfp.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 15:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VafVIttK4BQaNnVH9DUs0wyPcW9Q+K+8pZ94hsjXorY=;
        b=ks+HwLLDksBEOvVvqN/JGC0kYT1YA3ZyODv7fd5LcRQkkuCxeD/U4NzuevuVxgJHc0
         N5Bpx7PYe2ea8hQXAZJUBCWzfmRs7/8n4XbU7v/nxBhZXmVzM/zBEsQKYM0j/LSOxFXb
         /58Uv7YkttG9qPg91DkELUonTxslLhWtlIM58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VafVIttK4BQaNnVH9DUs0wyPcW9Q+K+8pZ94hsjXorY=;
        b=LfxyIpF528FnxnPDIRN1B0UF3gcEEBFh/te18sIG/o0HIsXUeZG4lrNBFlfipYoV65
         m1qMdqxPUciIzN3enRl7jNiQiuQMp9FEeHnMPJHNxuk3Oe7NHynFRlGIRj1jNEsoZ5iv
         pgZyx/lCBOF1Br46HV1nI+sSjtXe999DszFopgWyOt+/K4h3ft9VgGjylkJrt7B/xRmZ
         ncKXZ/aoia/vkGflzPOt6Byj6xnT8DjYXchPfcoKCbpX6g+qlzVKoRW4ogA/se3305Pb
         onimIfofHuf1+IyWMCJTewWRyCIgrYzMwf+eDlgM0gemY32qSg2i4y8I0gerYB1jEM66
         Ok8g==
X-Gm-Message-State: AGi0PuZoVcq0siaeZZr23QrtIO3Kiy60HfKQurxbRa2Kn/jlv+jtmeyQ
        BfPPdu2YCqcNERvG36ysqfuP4ZGSLxo=
X-Google-Smtp-Source: APiQypJ5RNA/tsP/dhUFjAOHB8REdm0Pn79S8FKQSwN87WJZXsGMFAdBEb6WbpfS6Ja1icGakzD98A==
X-Received: by 2002:a63:ff59:: with SMTP id s25mr1608578pgk.159.1586471955396;
        Thu, 09 Apr 2020 15:39:15 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id o15sm171016pjp.41.2020.04.09.15.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 15:39:14 -0700 (PDT)
Date:   Thu, 9 Apr 2020 15:39:13 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/3] platform/chrome: typec: Use notifier for updates
Message-ID: <20200409223913.GA15090@google.com>
References: <20200407010940.155490-1-pmalani@chromium.org>
 <20200407010940.155490-2-pmalani@chromium.org>
 <12997222-5df5-1e16-3eb1-1e26252315f8@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12997222-5df5-1e16-3eb1-1e26252315f8@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thanks for the reviews, as always. Kindly see inline:

On Thu, Apr 09, 2020 at 11:01:42PM +0200, Enric Balletbo i Serra wrote:
> Hi Prashant,
> 
> Thank you for the patch.
> 
> On 7/4/20 3:09, Prashant Malani wrote:
> > Register a listener for the cros-usbpd-notifier, and update port state
> > when a notification comes in.
> > 
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 874269c070739..cf7c2652a1d6d 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/of.h>
> >  #include <linux/platform_data/cros_ec_commands.h>
> >  #include <linux/platform_data/cros_ec_proto.h>
> > +#include <linux/platform_data/cros_usbpd_notify.h>
> 
> I think you need to add a kconfig dependency/selection in order to don't have
> build problems.

Thanks, will make the change.
> 
> >  #include <linux/platform_device.h>
> >  #include <linux/usb/typec.h>
> >  
> > @@ -26,6 +27,7 @@ struct cros_typec_data {
> >  	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
> >  	/* Initial capabilities for each port. */
> >  	struct typec_capability *caps[EC_USB_PD_MAX_PORTS];
> > +	struct notifier_block nb;
> >  };
> >  
> >  static int cros_typec_parse_port_props(struct typec_capability *cap,
> > @@ -272,6 +274,22 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
> >  	return 0;
> >  }
> >  
> > +static int cros_ec_typec_event(struct notifier_block *nb,
> > +			       unsigned long host_event, void *_notify)
> > +{
> > +	struct cros_typec_data *typec = container_of(nb, struct cros_typec_data,
> > +						     nb);
> > +	int ret, i;
> > +
> > +	for (i = 0; i < typec->num_ports; i++) {
> > +		ret = cros_typec_port_update(typec, i);
> > +		if (ret < 0)
> > +			dev_warn(typec->dev, "Update failed for port:%d\n", i);
> 
> nit: space between : and %d
> 
Done.
> > +	}
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> >  #ifdef CONFIG_ACPI
> >  static const struct acpi_device_id cros_typec_acpi_id[] = {
> >  	{ "GOOG0014", 0 },
> > @@ -332,6 +350,13 @@ static int cros_typec_probe(struct platform_device *pdev)
> >  			goto unregister_ports;
> >  	}
> >  
> > +	typec->nb.notifier_call = cros_ec_typec_event;
> > +	ret = cros_usbpd_register_notify(&typec->nb);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to register notifier\n");
> 
> Currently cros_usbpd_register_notfity calls blocking_notifier_chain_register
> that always return zero. Is fine to check the error but the print is unneded. If
> probe fails will report the error.
> 
Done.

> > +		goto unregister_ports;
> > +	}
> > +
> >  	return 0;
> >  
> >  unregister_ports:
> > 

Best regards,

-Prashant
