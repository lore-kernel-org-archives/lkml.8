Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C25C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 21:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D567C2051A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 21:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eeqVu/8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgCOVid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 17:38:33 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39201 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgCOVid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 17:38:33 -0400
Received: by mail-pj1-f67.google.com with SMTP id d8so7428396pje.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hSNRixESbKlO8oPao94ubOUzSLK+fl4y42xUuCdTQaM=;
        b=eeqVu/8yiwNq62Bfci4wRac5WK9yB6+yLkP0ZhrXRSvoCmI5jWh6n48o30B9E6t0dn
         MZnCNQpfcyKnJZNIj6y0o8OOCCdrl+I7x9Tsc22B66Gn8rBbdv7dXBv3pCUedgi2N02R
         tUrY6Aj0VJ0jPUtGGCJT/Y9mNMSVapjgVINtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hSNRixESbKlO8oPao94ubOUzSLK+fl4y42xUuCdTQaM=;
        b=GS/Alb10qs9hCkRDC8DbJbhOnn3EXzigFLGVzHrOMuy8VyB0Wc+zO/63nSivkjsKGG
         Orr+9/U4s24CtMFiSdLSNBeow8bdatnODisVFN5GMnqdmj1aaWCnlTogzY2/1Jj0wKmP
         49ttqjC97oJwGsv9XrE/+71cEey4Jw1XjzKNORx6NiVNwrb7CPIDcClGp8QZ10hJoevg
         TktdZSCutml3pk5cx1+hzKxIUGWKG4YaQLOrvZRmWO6hXOcGC7XJl102RVbEJEN/X5VJ
         7j8HDyHYoGxOvgN4SbkOW+LXLPVyNTDsl/SREA1JW/JIceGkpJBE2uvwMxTFVS4OuoS7
         pnuA==
X-Gm-Message-State: ANhLgQ1o63nY/RDbVIi1g9yMS0io6/6n4EOJCSj7xNBs4KmYGcOod8gj
        rNL5Keatg9Rqv2LKwNO24htpjiMYxNM=
X-Google-Smtp-Source: ADFU+vvRanTMnVVbqRek1/+JH1hZX9CSzqjLjwJvOvFXbcayM3tbyA9cKI1lxKlUge1ymy2/s1207g==
X-Received: by 2002:a17:902:6a84:: with SMTP id n4mr23423011plk.294.1584308309497;
        Sun, 15 Mar 2020 14:38:29 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id c190sm18286473pga.35.2020.03.15.14.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 14:38:28 -0700 (PDT)
Date:   Sun, 15 Mar 2020 14:38:27 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, furquan@chromium.org,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 2/3] platform/chrome: notify: Amend ACPI driver to plat
Message-ID: <20200315213827.GA185829@google.com>
References: <20200312100809.21153-1-pmalani@chromium.org>
 <20200312100809.21153-3-pmalani@chromium.org>
 <5f873d6f-5d30-758f-48e4-513b86b39378@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f873d6f-5d30-758f-48e4-513b86b39378@collabora.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thanks a lot for reviewing the patch, kindly see inline:

On Fri, Mar 13, 2020 at 01:42:26PM +0100, Enric Balletbo i Serra wrote:
> Hi Prashant,
> 
> On 12/3/20 11:08, Prashant Malani wrote:
> > Convert the ACPI driver into the equivalent platform driver, with the
> > same ACPI match table as before. This allows the device driver to access
> > the parent platform EC device and its cros_ec_device struct, which will
> > be required to communicate with the EC to pull PD Host event information
> > from it.
> > 
> > Also change the ACPI driver name to "cros-usbpd-notify-acpi" so that
> > there is no confusion between it and the "regular" platform driver on
> > platforms that have both CONFIG_ACPI and CONFIG_OF enabled.
> > 
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_usbpd_notify.c | 82 ++++++++++++++++++---
> >  1 file changed, 70 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
> > index edcb346024b07..d2dbf7017e29c 100644
> > --- a/drivers/platform/chrome/cros_usbpd_notify.c
> > +++ b/drivers/platform/chrome/cros_usbpd_notify.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/platform_device.h>
> >  
> >  #define DRV_NAME "cros-usbpd-notify"
> > +#define DRV_NAME_PLAT_ACPI "cros-usbpd-notify-acpi"
> >  #define ACPI_DRV_NAME "GOOG0003"
> >  
> >  static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
> > @@ -54,14 +55,72 @@ EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
> >  
> >  #ifdef CONFIG_ACPI
> >  
> > -static int cros_usbpd_notify_add_acpi(struct acpi_device *adev)
> > +static void cros_usbpd_notify_acpi(acpi_handle device, u32 event, void *data)
> >  {
> > +	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
> > +}
> > +
> > +static int cros_usbpd_notify_probe_acpi(struct platform_device *pdev)
> > +{
> > +	struct cros_usbpd_notify_data *pdnotify;
> > +	struct device *dev = &pdev->dev;
> > +	struct acpi_device *adev;
> > +	struct cros_ec_device *ec_dev;
> > +	acpi_status status;
> > +
> > +	adev = ACPI_COMPANION(dev);
> > +	if (!adev) {
> 
> I still missing some bits of the ACPI devices but is this possible?
> 
> The ACPI probe only will be called if there is a match so an ACPI device, I guess.
> 
Ack. Will remove this check. I was following cros_ec_lpc.c but that is a
common driver.

> > +		dev_err(dev, "No ACPI device found.\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	pdnotify = devm_kzalloc(dev, sizeof(*pdnotify), GFP_KERNEL);
> > +	if (!pdnotify)
> > +		return -ENOMEM;
> > +
> > +	/* Get the EC device pointer needed to talk to the EC. */
> > +	ec_dev = dev_get_drvdata(dev->parent);
> > +	if (!ec_dev) {
> > +		/*
> > +		 * We continue even for older devices which don't have the
> > +		 * correct device heirarchy, namely, GOOG0003 is a child
> > +		 * of GOOG0004.
> > +		 */
> > +		dev_warn(dev, "Couldn't get Chrome EC device pointer.\n");
> 
> I'm not sure this is correctly handled, see below ...
> 
> 
> > +	}
> > +
> > +	pdnotify->dev = dev;
> > +	pdnotify->ec = ec_dev;
> 
> If !ec_dev you'll assign a NULL pointer to pdnotify->ec. On the cases that
> GOOG0003 is not a child of GOOG0004 I suspect you will get a NULL dereference
> later in some other part of the code?
> 

I think there is a comment about this in the Patch 3/3 review, so will
also address it there. Basically, cros_usbpd_notify_plat() will not have
a NULL ec_dev, because the platform_probe() only happens for a cros MFD,
which will be a child of the parent EC device always.

> > +
> > +	status = acpi_install_notify_handler(adev->handle,
> > +					     ACPI_ALL_NOTIFY,
> > +					     cros_usbpd_notify_acpi,
> > +					     pdnotify);
> > +	if (ACPI_FAILURE(status)) {
> > +		dev_warn(dev, "Failed to register notify handler %08x\n",
> > +			 status);
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_info(dev, "Chrome EC PD notify device registered.\n");
> > +
> 
> This is only noise to the kernel log, remove it.

Done.
> 
> >  	return 0;
> >  }
> >  
> > -static void cros_usbpd_notify_acpi(struct acpi_device *adev, u32 event)
> > +static int cros_usbpd_notify_remove_acpi(struct platform_device *pdev)
> >  {
> > -	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
> > +	struct device *dev = &pdev->dev;
> > +	struct acpi_device *adev = ACPI_COMPANION(dev);
> > +
> > +	if (!adev) {
> > +		dev_err(dev, "No ACPI device found.\n");
> 
> Is this possible?
> 
Ack. For ACPI probe not possible. Will remove it.
> > +		return -ENODEV;
> > +	}
> > +
> > +	acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
> > +				   cros_usbpd_notify_acpi);
> > +
> > +	return 0;
> >  }
> >  
> >  static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
> > @@ -70,14 +129,13 @@ static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
> >  };
> >  MODULE_DEVICE_TABLE(acpi, cros_usbpd_notify_acpi_device_ids);
> >  
> > -static struct acpi_driver cros_usbpd_notify_acpi_driver = {
> > -	.name = DRV_NAME,
> > -	.class = DRV_NAME,
> > -	.ids = cros_usbpd_notify_acpi_device_ids,
> > -	.ops = {
> > -		.add = cros_usbpd_notify_add_acpi,
> > -		.notify = cros_usbpd_notify_acpi,
> > +static struct platform_driver cros_usbpd_notify_acpi_driver = {
> 
> Nice, so it is converted to a platform_driver, now. This makes me think again if
> we could just use a single platform_driver and register the acpi notifier in the
> ACPI match case and use the non-acpi notifier on the OF case.
> 
I'd like that as well. But, I'm hesitant to make the change now, since I
don't have a platform which has CONFIG_OF and CONFIG_ACPI on which to
test the common platform driver with (which is what you use IIRC).

Would something as follows work (pseudo code to follow):

static int cros_usbpd_notify_probe_plat(struct platform_device *pdev)
{
	struct device *dev = &pdev->dev;
	struct acpi_device *adev = ACPI_COMPANION(dev);

	/* "Non-ACPI case"
	if (dev->parent->of_node) {
		/* Do non-ACPI case probe work here */

	} else if (adev) {
		/* Do ACPI case probe work here */
	} else {
		return -EINVAL;
	}
}

and similarly for remove ?

If so, I can change Patch 2/2 to do this :)

Best regards,

-Prashant

> > +	.driver = {
> > +		.name = DRV_NAME_PLAT_ACPI,
> > +		.acpi_match_table = cros_usbpd_notify_acpi_device_ids,
> >  	},
> > +	.probe = cros_usbpd_notify_probe_acpi,
> > +	.remove = cros_usbpd_notify_remove_acpi,
> >  };
> >  
> >  #endif /* CONFIG_ACPI */
> > @@ -159,7 +217,7 @@ static int __init cros_usbpd_notify_init(void)
> >  		return ret;
> >  
> >  #ifdef CONFIG_ACPI
> > -	acpi_bus_register_driver(&cros_usbpd_notify_acpi_driver);
> > +	platform_driver_register(&cros_usbpd_notify_acpi_driver);
> >  #endif
> >  	return 0;
> >  }
> > @@ -167,7 +225,7 @@ static int __init cros_usbpd_notify_init(void)
> >  static void __exit cros_usbpd_notify_exit(void)
> >  {
> >  #ifdef CONFIG_ACPI
> > -	acpi_bus_unregister_driver(&cros_usbpd_notify_acpi_driver);
> > +	platform_driver_unregister(&cros_usbpd_notify_acpi_driver);
> >  #endif
> >  	platform_driver_unregister(&cros_usbpd_notify_plat_driver);
> >  }
> > 
