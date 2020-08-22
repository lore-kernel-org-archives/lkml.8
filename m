Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C18C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A620B207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W8f//rSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHVJ4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 05:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgHVJ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 05:56:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F853C061575
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 02:56:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r11so2276400pfl.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 02:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l7aXGPl3X/xYs2Q5GHfUvsQEQDqjScmIL2WkfrO0/J8=;
        b=W8f//rSHBcdDDAsG8jkW4n1pEPAn1sCr5nT9WKxAhYBi0vghHRt9UfcuHgFpsACI5U
         C+z3wyhYGlhD9oeb4NKk28esSNgGE1m8J27cZUHtOD3HjttEpDu2TeIDuaAkeGDJOIXe
         miAifO1v8Sg8eQJdQKLA6W26EUxo1pVleApV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l7aXGPl3X/xYs2Q5GHfUvsQEQDqjScmIL2WkfrO0/J8=;
        b=j2PJ7tINE5TOeLXfQASm1mSaHZfwtgp8ifRQpJRg6MyQRix/npr2hZ2ScA0buN/2AF
         Y6bpOpv+5FbvYuMT3yLypeol0Qgr4z4gfSHrsQ4WFhyy4oa9MJup8P5SyZ7xcGNvs7/F
         P5NFpQn4zn2P9aygKsEXxHBZGzF8VcsNWDUW+/yaghEPLScoF1+TPAeGxrhI2MaPB5aZ
         zzt6x5AoJXr7FqFKawujSArDTj1LyOsNPiqkO1apJdetHyEBkQrQrKKhnSvvSPU7jTSm
         bOffIZuS5g5GrFu0wE1rJ54NSeNjlReOSO/TN8U+hpClRINKDhWb5mpaml/zxZJ0yepB
         J8wA==
X-Gm-Message-State: AOAM53125cyK4I+kp7lFS4nt4XJ5GeMbBLKSkIGc0v32uipsK3pGNsma
        ETbvOi5OF9wT1zhY0+Ou6VEuTQ==
X-Google-Smtp-Source: ABdhPJypEzdvrBsNRY5wsHrDoJm1bHtjRZ4Qj+zqHGfH90ZVYoUQxjdEVGi8eLw5I6wC8PvJhUxBGA==
X-Received: by 2002:aa7:8a08:: with SMTP id m8mr5770969pfa.135.1598090193532;
        Sat, 22 Aug 2020 02:56:33 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id e23sm4240486pgb.79.2020.08.22.02.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 02:56:32 -0700 (PDT)
Date:   Sat, 22 Aug 2020 02:56:31 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Rajmohan Mani <rajmohan.mani@intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jithu Joseph <jithu.joseph@intel.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, bleung@chromium.org
Subject: Re: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
 (IOM) driver
Message-ID: <20200822095631.GB2553024@google.com>
References: <20200822040508.23510-1-rajmohan.mani@intel.com>
 <20200822040508.23510-2-rajmohan.mani@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822040508.23510-2-rajmohan.mani@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajmohan,

On Fri, Aug 21, 2020 at 09:05:06PM -0700, Rajmohan Mani wrote:
> Input Output Manager (IOM) is part of the Tiger Lake SoC that
> configures the Type-C Sub System (TCSS). IOM is a micro controller
> that handles Type-C topology, configuration and PM functions of
> various Type-C devices connected on the platform.
> 
> This driver helps read relevant information such as Type-C port
> status (whether a device is connected to a Type-C port or not) and
> the activity type on the Type-C ports (such as USB, Display Port,
> Thunderbolt), for consumption by other drivers.
> 
> Currently intel_iom_port_status() API is exported by this driver,
> that has information about the Type-C port status and port activity
> type.
> 
> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> ---

Perhaps include a version log of changes since v1?
> diff --git a/drivers/platform/x86/intel_iom.c b/drivers/platform/x86/intel_iom.c
> new file mode 100644
> index 000000000000..cda7716410c6
> --- /dev/null
> +++ b/drivers/platform/x86/intel_iom.c
> +int intel_iom_port_status(u8 port, u32 *status)
> +{
> +	void __iomem *reg;
> +
> +	if (!iom || !iom->dev || !iom->regbar)

Do we need to check for !iom->dev and !iom->regbar? Is there a valid
situation where iom != NULL but iom->dev and/or iom->regbar == NULL?
Sounds like it shouldn't, but I may be missing something.

> +		return -ENODEV;
> +
> +	if (!status || (port > IOM_MAX_PORTS - 1))

I think parentheses around "port > IOM_MAX_PORT - 1" aren't required.
> +		return -EINVAL;
> +
> +	reg = iom->regbar + IOM_PORT_STATUS_OFFSET + IOM_REG_LEN * port;
> +
> +	*status = ioread32(reg);

Perhaps just inline reg within the parentheses?
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(intel_iom_port_status);
> +
> +static int intel_iom_probe(struct platform_device *pdev)
> +{
> +	void __iomem *addr;
> +
> +	/* only one IOM device is supported */

Minor nit: s/only/Only
> +	if (iom)
> +		return -EBUSY;
> +
> +	iom = devm_kzalloc(&pdev->dev, sizeof(*iom), GFP_KERNEL);
> +	if (!iom)
> +		return -ENOMEM;
> +
> +	addr = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(addr))
> +		return PTR_ERR(addr);
> +
> +	iom->regbar = addr;
> +	iom->dev = &pdev->dev;
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id intel_iom_acpi_ids[] = {
> +	{ "INTC1072" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, intel_iom_acpi_ids);
> +
> +static struct platform_driver intel_iom_driver = {
> +	.probe = intel_iom_probe,

nit: I generally see ".probe" listed below ".driver".
> +	.driver = {
> +		.name = "intel_iom",
> +		.acpi_match_table = intel_iom_acpi_ids,
> +	},
> +};
> +
> +module_platform_driver_probe(intel_iom_driver, intel_iom_probe);
> +
> +MODULE_AUTHOR("Rajmohan Mani <rajmohan.mani@intel.com>");
> +MODULE_DESCRIPTION("Intel IOM driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/platform_data/x86/intel_iom.h b/include/linux/platform_data/x86/intel_iom.h
> new file mode 100644
> index 000000000000..e4c9a305e7a9
> --- /dev/null
> +++ b/include/linux/platform_data/x86/intel_iom.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _PLATFORM_DATA_X86_INTEL_IOM_H_
> +#define _PLATFORM_DATA_X86_INTEL_IOM_H_
> +
> +
> +#define IOM_MAX_PORTS					4
> +/* Register length in bytes */
> +#define IOM_REG_LEN					4

Do these two #define's need to be in the header, instead of directly in
intel_iom.c ?

> +
> +#ifdef CONFIG_ACPI
> +
> +int intel_iom_port_status(u8 port, u32 *status);
> +
> +#else
> +
> +int intel_iom_port_status(struct intel_iom *iom, u8 port, u32 *status)

Should the function signature be the same as the #ifdef case?

Best regards,

-Prashant

