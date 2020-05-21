Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCB9C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DE720738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uh99QRB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgEUH2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgEUH2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:28:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47E2C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 00:28:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so5641714wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 00:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=o+08iBejWeMXouE7dRTwcQNY02K1AUg6MpBRJkd3keM=;
        b=uh99QRB/hV9x8P9A0GOsV1F6gjy28FAD97WZaUOjXWO5wg64whO0XvzMWpe+IEdH+g
         h6Z06JlvT87AsikM5ICVNcVpS0UdKTatXjgudcwxC1eJKJm1YRnJv6ZaqLBjhOn6c1cn
         2h1bw0a+ZQno7ZWNxGzfgCUa5aS8IflpUCSHEbjJupIIpikcLwMudjscu/sO8pdTgxH6
         uGLykNZmgpjRAX+mx8kaTseKhuOWxuc+pIcQtCyWmebYTqcN5erodJv+r+X1yfxftu5J
         vd+NA+w4DDpHw7y+oiFiIWxPlJVBwX2iv5d4FwfVUNIdyOiiocn1E7QP3uk96ScLuoVJ
         NzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o+08iBejWeMXouE7dRTwcQNY02K1AUg6MpBRJkd3keM=;
        b=iYtVGbIWYoT8GE2VTwmhY2eWtHdmi2h3w5ikJRy3ceeK1bhMdoeo3I10FSyowulEoK
         jkGKgG+YMStdFZlj3hLq/F0/PI13VtbU6tB6HZKfHA8c8SRqrKEs1W7bFjxYj54zAJbj
         K+br9YdQNnpV1UkbxhFNoeLqXPtKul+pGXkkxgwKhz/wfVUmJa1wkB7OEUnJDok0JlHZ
         JVFEjIZgWSTxC+ncVnLvzQqVs7xJ5vfOVjin5DoCnoRFf5kCyBX729Aa+/YJT2c1DAfM
         7Q27COyfFRcIkfTT5NSRM4rz76Ql6Mfqks8Llr1LD1HDo56mS5AFIIE5iQrEnMsIeVa5
         oqfw==
X-Gm-Message-State: AOAM530SYvtUjUJrMSZO16hZoXqARUzTKvVb0Eir3sP+C4HrQVEXVre3
        NrOPvy9y2MjdIOgI2zwpA6GMcw==
X-Google-Smtp-Source: ABdhPJxSWV4oe4HpUF4uMcSxzWvWUB2BkfZ2zdutN4GnG94myCM6Cy/yJvgXYRc5BN5SLtOrQAghYQ==
X-Received: by 2002:adf:9264:: with SMTP id 91mr7228185wrj.362.1590046079284;
        Thu, 21 May 2020 00:27:59 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id l19sm5859256wmj.14.2020.05.21.00.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 00:27:58 -0700 (PDT)
Date:   Thu, 21 May 2020 08:27:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: ene-kb3930: Add driver for ENE KB3930
 Embedded Controller
Message-ID: <20200521072757.GM271301@dell>
References: <20200520185955.2144252-1-lkundrak@v3.sk>
 <20200520185955.2144252-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200520185955.2144252-3-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020, Lubomir Rintel wrote:

> This driver provides access to the EC RAM of said embedded controller
> attached to the I2C bus as well as optionally supporting its slightly weird
> power-off/restart protocol.
> 
> A particular implementation of the EC firmware can be identified by a
> model byte. If this driver identifies the Dell Ariel platform, it
> registers the appropriate cells.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v2:
> - Sort the includes
> - s/EC_MODEL_ID/EC_MODEL/
> - Add a couple of clarifying comments
> - Use #defines for values used in poweroff routine
> - Remove priority from a restart notifier block
> - s/priv/ddata/
> - s/ec_ram/ram_regmap/ for the regmap name
> - Fix the error handling when getting off gpios was not successful
> - Remove a useless dev_info at the end of probe()
> - Use i2c probe_new() callback, drop i2c_device_id
> - Modify the logic in checking the model ID
> 
>  drivers/mfd/Kconfig      |  10 ++
>  drivers/mfd/Makefile     |   1 +
>  drivers/mfd/ene-kb3930.c | 215 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 226 insertions(+)
>  create mode 100644 drivers/mfd/ene-kb3930.c

Really starting to take shape.

Just a couple of nits, then we're good to go.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 0a59249198d3..dae18a2beab5 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -398,6 +398,16 @@ config MFD_DLN2
>  	  etc. must be enabled in order to use the functionality of
>  	  the device.
>  
> +config MFD_ENE_KB3930
> +	tristate "ENE KB3930 Embedded Controller support"
> +	depends on I2C
> +	depends on MACH_MMP3_DT || COMPILE_TEST
> +	select MFD_CORE
> +	help
> +	  This adds support for accessing the registers on ENE KB3930, Embedded
> +	  Controller. Additional drivers such as LEDS_ARIEL must be enabled in
> +	  order to use the functionality of the device.

Can you mention/describe all of the sub-devices please?

[...]

> +struct kb3930 *global_kb3930;

Can we call this kb3930_power_off please.

[...]

> +static int kb3930_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct device_node *np = dev->of_node;
> +	struct kb3930 *ddata;
> +	unsigned int model;
> +	int ret;
> +
> +	if (global_kb3930)
> +		return -EEXIST;

This should not happen.  If .probe() is called twice, either
-EDEFER_PROBE was returned or a new device was registered.

[...]

> +	/* These are the cells valid for model == 'J' only. */
> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> +				   ariel_ec_cells,
> +				   ARRAY_SIZE(ariel_ec_cells),
> +				   NULL, 0, NULL);
> +	if (ret < 0)

if (ret)

> +		return ret;

[...]

> +static struct i2c_driver kb3930_driver = {
> +	.probe_new = kb3930_probe,
> +	.remove = kb3930_remove,
> +	.driver = {
> +		.name = "ene-kb3930",
> +		.of_match_table = of_match_ptr(kb3930_dt_ids),
> +	},
> +};
> +

Remove this line please.

> +module_i2c_driver(kb3930_driver);
> +
> +MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");
> +MODULE_DESCRIPTION("ENE KB3930 Embedded Controller Driver");
> +MODULE_LICENSE("Dual BSD/GPL");

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
