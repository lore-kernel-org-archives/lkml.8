Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065DFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0E6206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="uKFtMr2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbgF3JQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729866AbgF3JQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:16:40 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30FCC061755;
        Tue, 30 Jun 2020 02:16:40 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8121C22FA7;
        Tue, 30 Jun 2020 11:16:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1593508597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5lu8xIsMoWKOl6aI/xDpiccbPJVfNnp92aKT5SSRCo=;
        b=uKFtMr2b6G7FqzNpm3+nrKll+73nDG5Z/w3RrCBogOtLiqmdLfkPvVm/askffBgazljsDl
        6lF56rkr3JEQ0dl/0nqZi7+AwKNTCOyJTaMC2IZ2w1OsLzn/NGY79k+JREWrzrEKQduGoN
        ZXWx4oendgXnuVajvZxwNaF3oKcWGTw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Jun 2020 11:16:33 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] mfd: Add I2C based System Configuaration (SYSCON)
 access
In-Reply-To: <20200622075145.1464020-1-lee.jones@linaro.org>
References: <20200622075145.1464020-1-lee.jones@linaro.org>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <e436fd60bf0ebb6d72a76034d0fc35de@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

I'm just trying to use this for my sl28 driver. Some remarks, see below.

Am 2020-06-22 09:51, schrieb Lee Jones:
> The existing SYSCON implementation only supports MMIO (memory mapped)
> accesses, facilitated by Regmap.  This extends support for registers
> held behind I2C busses.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> Changelog:
> 
> v3 => v4
>   - Add ability to provide a non-default Regmap configuration
> 
> v2 => v3
>   - Change 'is CONFIG' present check to include loadable modules
>     - s/#ifdef CONFIG_MFD_SYSCON_I2C/#if 
> IS_ENABLED(CONFIG_MFD_SYSCON_I2C)/
> 
> v1 => v2
>   - Remove legacy references to OF
>   - Allow building as a module (fixes h8300 0-day issue)
> 
> drivers/mfd/Kconfig            |   7 +++
>  drivers/mfd/Makefile           |   1 +
>  drivers/mfd/syscon-i2c.c       | 104 +++++++++++++++++++++++++++++++++
>  include/linux/mfd/syscon-i2c.h |  36 ++++++++++++
>  4 files changed, 148 insertions(+)
>  create mode 100644 drivers/mfd/syscon-i2c.c
>  create mode 100644 include/linux/mfd/syscon-i2c.h
> 

[..]

> +static struct regmap *syscon_i2c_get_regmap(struct i2c_client *client,
> +					    struct regmap_config *regmap_config)
> +{
> +	struct device *dev = &client->dev;
> +	struct syscon *entry, *syscon = NULL;
> +
> +	spin_lock(&syscon_i2c_list_slock);
> +
> +	list_for_each_entry(entry, &syscon_i2c_list, list)
> +		if (entry->dev == dev) {
> +			syscon = entry;
> +			break;
> +		}
> +
> +	spin_unlock(&syscon_i2c_list_slock);
> +
> +	if (!syscon)
> +		syscon = syscon_i2c_register(client, regmap_config);
> +
> +	if (IS_ERR(syscon))
> +		return ERR_CAST(syscon);
> +
> +	return syscon->regmap;
> +}
> +
> +struct regmap *syscon_i2c_to_regmap_config(struct i2c_client *client,
> +					   struct regmap_config *regmap_config)
> +{
> +	return syscon_i2c_get_regmap(client, regmap_config);
> +}
> +EXPORT_SYMBOL_GPL(syscon_i2c_to_regmap_config);
> +
> +struct regmap *syscon_i2c_to_regmap(struct i2c_client *client)
> +{
> +	return syscon_i2c_get_regmap(client, &syscon_i2c_regmap_config);
> +}
> +EXPORT_SYMBOL_GPL(syscon_i2c_to_regmap);

What do you think about

struct regmap *syscon_i2c_to_regmap(struct device *dev)
{
	struct i2c_client *client = i2c_verify_client(dev);

	if (!client)
		return ERR_PTR(-EINVAL);

	return syscon_i2c_get_regmap(client, &syscon_i2c_regmap_config);
}

Or even move it to syscon_i2c_get_regmap().

This way, (a) a driver doesn't have to use "#include <linux/i2c.h>" just
to call to_i2c_client() (or i2c_verify_client()) and (b) you won't do it
all over again in all sub drivers.

So you could just do a
   regmap = syscon_i2c_to_regmap(pdev->dev.parent);

I've also noticed that the mmio syscon uses device_node as parameter. 
What
was the reason to divert from that? Just curious.

-michael
