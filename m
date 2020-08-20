Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69738C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B3C2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgHTPiP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:38:15 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:55874 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgHTPiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:38:12 -0400
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 90ED367A6F4;
        Thu, 20 Aug 2020 17:38:09 +0200 (CEST)
Received: from sntmail10s.snt-is.com (10.203.32.183) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 20 Aug
 2020 17:38:09 +0200
Received: from sntmail10s.snt-is.com ([fe80::ad9b:dbfd:621d:166f]) by
 sntmail10s.snt-is.com ([fe80::ad9b:dbfd:621d:166f%6]) with mapi id
 15.01.1913.007; Thu, 20 Aug 2020 17:38:09 +0200
From:   Michael Brunner <Michael.Brunner@kontron.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: Add ACPI support to Kontron PLD driver
Thread-Topic: [PATCH] mfd: Add ACPI support to Kontron PLD driver
Thread-Index: AQHWcLfnyQQDC2IYfEqK/svjxogCEak/IGiAgAHsbAA=
Date:   Thu, 20 Aug 2020 15:38:09 +0000
Message-ID: <b327cf1abd283e0e4f0a7332e1e4cc164d053023.camel@kontron.com>
References: <1e5ff295eacd5cb9eb2d888e1b0175fea62cf2ae.camel@kontron.com>
         <20200819101539.GE4354@dell>
In-Reply-To: <20200819101539.GE4354@dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <8593C5076A328C41A2A0AB801C44E9DF@snt-world.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 90ED367A6F4.AE3F8
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: michael.brunner@kontron.com
X-SnT-MailScanner-To: lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, mibru@gmx.de, sameo@linux.intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for taking the time to review the patch!
Additional comments below, patch v2 will follow.

On Wed, 2020-08-19 at 11:15 +0100, Lee Jones wrote:
> On Wed, 12 Aug 2020, Michael Brunner wrote:
... 
> > +#ifdef CONFIG_ACPI
> 
> Not keen on #ifdefery if at all avoidable.
> 
> Can you use if (IS_ENABLED(CONFIG_ACPI)) at the call-site instead?
> 
> The compiler should take care of the rest, no?

Unfortunately acpi_dev_get_resources is not defined when compiling with
CONFIG_ACPI disabled, therefore #ifdef seems to be the only choice.

> > +static const struct acpi_device_id kempld_acpi_table[] = {
> > +	{ "KEM0001", (kernel_ulong_t)&kempld_platform_data_generic },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(acpi, kempld_acpi_table);
>
> I'd prefer if this was moved down to just above where it's used
> i.e. where we usually place the of_device_id tables.

No problem, will update this.

...
> > +	INIT_LIST_HEAD(&resource_list);
> > +	ret = acpi_dev_get_resources(acpi_dev, &resource_list, NULL,
> > NULL);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	count = ret;
> 
>   	if (count == 0) {
> 		ret = platform_device_add_resources(pdev, pdata-
> >ioresource, 1);
> 		goto out;
> 	}
> 
> Then drop the next check and pull the indented code back:

Agreed, looks better.

> > +	if (count > 0) {
> > +		resources = devm_kcalloc(&acpi_dev->dev, count,
> > +					  sizeof(struct resource),
> > GFP_KERNEL);
> 
> sizeof(*resources) is preferred.

Ok

...
> >  static int kempld_probe(struct platform_device *pdev)
> >  {
> > -	const struct kempld_platform_data *pdata =
> > -		dev_get_platdata(&pdev->dev);
> > +	const struct kempld_platform_data *pdata;
> >  	struct device *dev = &pdev->dev;
> >  	struct kempld_device_data *pld;
> >  	struct resource *ioport;
> > +	int ret;
> > +
> > +	if (kempld_pdev == NULL) {
> 
> Comment please.  What does !kempld_pdev actually imply?

If kempld_pdev is not defined, this means no platform device has been
created using the DMI id table and we are currently probing the ACPI
based platform device.
Will add a comment to the code.

> > +		ret = kempld_get_acpi_data(pdev);
> > +		if (ret < 0)
> > +			return ret;
> 
> Is 'ret > 0' valid?
> 
> If not, then just 'if (ret)'.

Ok

> > +		kempld_acpi_mode = true;
> > +	} else if (kempld_pdev != pdev) {
> > +		dev_notice(dev, "platform device exists - not using
> > ACPI\n");
> 
> Why dev_notice() and not dev_err()?
> 
> Is that what 'kempld_pdev != pdev' means?
> 
> Could you explain this to me in more depth please?

kempld_pdev is the DMI based platform device created in kempld_init
(through force_device_id or dmi_check_system). pdev is the one passed
by the probe function. (kempdl_pdev != pdev) means pdev is the device
created using the ACPI table. As there is only one physical device and
the DMI based version should have priority, the probe is aborted at
this point. As it is not an error condition, only a notice is created
to indicate that ACPI is not used for probing the device.

> > ...
> > @@ -809,12 +887,19 @@ static int __init kempld_init(void)
> >  					break;
> >  		if (id->matches[0].slot == DMI_NONE)
> >  			return -ENODEV;
> > -	} else {
> > -		if (!dmi_check_system(kempld_dmi_table))
> > -			return -ENODEV;
> >  	}
> >  
> > -	return platform_driver_register(&kempld_driver);
> > +	ret = platform_driver_register(&kempld_driver);
> > +	if (ret)
> > +		return ret;
>
> Is it guaranteed that the child device has probed at this point?

To my understanding, with synchronous probing it should. According to
the definition of the probe_type enum this is still the default for all
drivers.
I guess it would make sense to enforce this for the case the default is
changed in the future.
Added this to v2:
	.probe_type = PROBE_FORCE_SYNCHRONOUS,

Only exception, to my knowledge, is if drivers_autoprobe is disabled
for platform drivers during kempld_init. As DMI has priority, the
driver will later only allow to manually bind the DMI platform device,
if ACPI and DMI are both supported on a platform.

> > +	if (!kempld_pdev && !kempld_acpi_mode)
> 
> Again, comment please.  What has gone on to get to this point?

At this point it is checked if the kempld_pdev has been already created
(force_device_id parameter) and if the ACPI based probe has been
already successfull. If not, the DMI table is searched for a matching
device ID. Doing this at this point should prevent unnecessarily
checking the DMI table.

> > +		if (!dmi_check_system(kempld_dmi_table)) {
> > +			platform_driver_unregister(&kempld_driver);
> > +			return -ENODEV;
> > +		}

While writing the above comments I noticed that unregistering the
driver at this point prevents manually binding the driver to a device
if drivers_autoprobe is set to 0. This only made sense as long as DMI
based detection was the only method supported. Therefore I removed it
in v2.

  Michael
