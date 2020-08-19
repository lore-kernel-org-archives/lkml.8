Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC993C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE41A206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjBhoaDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgHSKPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgHSKPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:15:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3738C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 03:15:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c80so1519061wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 03:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oFOOe8AbMftjSSKMyDnJGY8WphQpRl0qFy3NPH2cXmE=;
        b=CjBhoaDP8fwW+NfQ49Aem10c6ojgGH0Sa4Rfpjgn2rXJcb51cpCT7w8ZsFbHW3A257
         SKt0RjPAFrYKRNT+icfiirgF8/YWhrvab1M8ALE1ILfA4rQeYSM2fmpFhBxB+HN8WJ6x
         LhXJC7qCZu47vkt+DR1K5+PdI1/lX3xvabvJR8vn0Y51C5EZoKAFqRxzpDltOsC9Kn/F
         hX/3GeelIP7GMxHSm2LabFTKbGGhHOBHBZ9E/ak2gq5EoGDLnZ1N2q1Kq7xmGbt0KyXt
         IYy6aqBgBsNOkcrgERuq/qvPEMtImqk/S+7KkIIxJQvj5m4b0CixTxbqcgjLPjGKLUDq
         TNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oFOOe8AbMftjSSKMyDnJGY8WphQpRl0qFy3NPH2cXmE=;
        b=Wc+PBKzSEZgoMFJI4hUB66CTgh//UflmvxeHW+O2tpKHYVv5sOU3DgZp25zdSWkNNr
         u2g/GUBiwWU1ObEg2RT9OlAwzdhxGh2gIKnydTp8/8c4590EmVadKcxdKly/3lt36X83
         yyVVqWe2viV8iFhMWXcHyKwJlKjlywTFP6aU6fgOKKB/vu6TsAWrnccbg0ft0YZXkiEC
         6+51TXXCHd3t7gN88kSjZ4NeAXHNzKG2iqj8VssQ9YnA50X6RNCQ2lI1L4ihQzQDuqUm
         s3lv1vmwN2bZIochixlmhCdHmvcwpFsF+0Vs/s16WMwa/D0c2z/XdXtvI6HbdAckl3IX
         Kogw==
X-Gm-Message-State: AOAM531mhnTGr85MT9qYE0IJPWM8/S7OczJ0tu7nTwQ4damnSV5GHTLq
        37apwBrkKt08nt0Jr/gMx6uQisZPAxI0Vw==
X-Google-Smtp-Source: ABdhPJzAabCCW/b3n7IPbwKE3CGnT8QAQd4GmLnPyBdF3/zvQLPJfFrW+b6QTJEagrgBkgHeAr841A==
X-Received: by 2002:a1c:6007:: with SMTP id u7mr4352281wmb.32.1597832141806;
        Wed, 19 Aug 2020 03:15:41 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y142sm5142849wmd.3.2020.08.19.03.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 03:15:41 -0700 (PDT)
Date:   Wed, 19 Aug 2020 11:15:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Brunner <Michael.Brunner@kontron.com>
Cc:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "dvhart@linux.intel.com" <dvhart@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>
Subject: Re: [PATCH] mfd: Add ACPI support to Kontron PLD driver
Message-ID: <20200819101539.GE4354@dell>
References: <1e5ff295eacd5cb9eb2d888e1b0175fea62cf2ae.camel@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e5ff295eacd5cb9eb2d888e1b0175fea62cf2ae.camel@kontron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020, Michael Brunner wrote:

> Recent Kontron COMe modules identify the PLD device using the hardware
> id KEM0001 in the ACPI table.
> This patch adds support for probing the device using the HID and also
> retrieving the resources.
> 
> As this is not available for all products, the DMI based detection still
> needs to be around for older systems. It is executed if no matching ACPI
> HID is found during registering the platform driver or no specific
> device id is forced.
> If a device is detected using ACPI and no resource information is
> available, the default io resource is used.
> 
> Forcing a device id with the force_device_id parameter and therefore
> manually generating a platform device takes precedence over ACPI during
> probing.
> 
> Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> ---
>  drivers/mfd/kempld-core.c | 97 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 91 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
> index f48e21d8b97c..408cad1958d9 100644
> --- a/drivers/mfd/kempld-core.c
> +++ b/drivers/mfd/kempld-core.c
> @@ -13,6 +13,7 @@
>  #include <linux/dmi.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> +#include <linux/acpi.h>
>  
>  #define MAX_ID_LEN 4
>  static char force_device_id[MAX_ID_LEN + 1] = "";
> @@ -132,6 +133,7 @@ static const struct kempld_platform_data kempld_platform_data_generic = {
>  };
>  
>  static struct platform_device *kempld_pdev;
> +static bool kempld_acpi_mode;
>  
>  static int kempld_create_platform_device(const struct dmi_system_id *id)
>  {
> @@ -434,13 +436,87 @@ static int kempld_detect_device(struct kempld_device_data *pld)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_ACPI

Not keen on #ifdefery if at all avoidable.

Can you use if (IS_ENABLED(CONFIG_ACPI)) at the call-site instead?

The compiler should take care of the rest, no?

> +static const struct acpi_device_id kempld_acpi_table[] = {
> +	{ "KEM0001", (kernel_ulong_t)&kempld_platform_data_generic },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, kempld_acpi_table);

I'd prefer if this was moved down to just above where it's used
i.e. where we usually place the of_device_id tables.

> +static int kempld_get_acpi_data(struct platform_device *pdev)
> +{
> +	struct list_head resource_list;
> +	struct resource *resources;
> +	struct resource_entry *rentry;
> +	struct device *dev = &pdev->dev;
> +	struct acpi_device *acpi_dev = ACPI_COMPANION(dev);
> +	const struct kempld_platform_data *pdata;
> +	int ret;
> +	int count;
> +
> +	pdata = acpi_device_get_match_data(dev);
> +	ret = platform_device_add_data(pdev, pdata,
> +				       sizeof(struct kempld_platform_data));
> +	if (ret)
> +		return ret;
> +
> +	INIT_LIST_HEAD(&resource_list);
> +	ret = acpi_dev_get_resources(acpi_dev, &resource_list, NULL, NULL);
> +	if (ret < 0)
> +		goto out;
> +
> +	count = ret;

  	if (count == 0) {
		ret = platform_device_add_resources(pdev, pdata->ioresource, 1);
		goto out;
	}

Then drop the next check and pull the indented code back:

> +	if (count > 0) {
> +		resources = devm_kcalloc(&acpi_dev->dev, count,
> +					  sizeof(struct resource), GFP_KERNEL);

sizeof(*resources) is preferred.

> +		if (!resources) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		count = 0;
> +		list_for_each_entry(rentry, &resource_list, node) {
> +			memcpy(&resources[count], rentry->res,
> +			       sizeof(*resources));
> +			count++;
> +		}
> +
> +		ret = platform_device_add_resources(pdev, resources, count);
> +		if (ret)
> +			goto out;
> +	} else
> +		ret = platform_device_add_resources(pdev, pdata->ioresource, 1);
> +
> +out:
> +	acpi_dev_free_resource_list(&resource_list);
> +
> +	return ret;
> +}
> +#else
> +static int kempld_get_acpi_data(struct platform_device *pdev)
> +{
> +	return -ENODEV;
> +}
> +#endif /* CONFIG_ACPI */
> +
>  static int kempld_probe(struct platform_device *pdev)
>  {
> -	const struct kempld_platform_data *pdata =
> -		dev_get_platdata(&pdev->dev);
> +	const struct kempld_platform_data *pdata;
>  	struct device *dev = &pdev->dev;
>  	struct kempld_device_data *pld;
>  	struct resource *ioport;
> +	int ret;
> +
> +	if (kempld_pdev == NULL) {

Comment please.  What does !kempld_pdev actually imply?

> +		ret = kempld_get_acpi_data(pdev);
> +		if (ret < 0)
> +			return ret;

Is 'ret > 0' valid?

If not, then just 'if (ret)'.

> +		kempld_acpi_mode = true;
> +	} else if (kempld_pdev != pdev) {

> +		dev_notice(dev, "platform device exists - not using ACPI\n");

Why dev_notice() and not dev_err()?

Is that what 'kempld_pdev != pdev' means?

Could you explain this to me in more depth please?

> +		return -ENODEV;
> +	}
> +	pdata = dev_get_platdata(dev);
>  
>  	pld = devm_kzalloc(dev, sizeof(*pld), GFP_KERNEL);
>  	if (!pld)
> @@ -482,6 +558,7 @@ static int kempld_remove(struct platform_device *pdev)
>  static struct platform_driver kempld_driver = {
>  	.driver		= {
>  		.name	= "kempld",
> +		.acpi_match_table = ACPI_PTR(kempld_acpi_table),
>  	},
>  	.probe		= kempld_probe,
>  	.remove		= kempld_remove,
> @@ -800,6 +877,7 @@ MODULE_DEVICE_TABLE(dmi, kempld_dmi_table);
>  static int __init kempld_init(void)
>  {
>  	const struct dmi_system_id *id;
> +	int ret;
>  
>  	if (force_device_id[0]) {
>  		for (id = kempld_dmi_table;
> @@ -809,12 +887,19 @@ static int __init kempld_init(void)
>  					break;
>  		if (id->matches[0].slot == DMI_NONE)
>  			return -ENODEV;
> -	} else {
> -		if (!dmi_check_system(kempld_dmi_table))
> -			return -ENODEV;
>  	}
>  
> -	return platform_driver_register(&kempld_driver);
> +	ret = platform_driver_register(&kempld_driver);
> +	if (ret)
> +		return ret;

Is it guaranteed that the child device has probed at this point?

> +	if (!kempld_pdev && !kempld_acpi_mode)

Again, comment please.  What has gone on to get to this point?

> +		if (!dmi_check_system(kempld_dmi_table)) {
> +			platform_driver_unregister(&kempld_driver);
> +			return -ENODEV;
> +		}
> +
> +	return 0;
>  }
>  
>  static void __exit kempld_exit(void)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
