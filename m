Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9553AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BAD2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHQZsD6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgFZVuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZVuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:50:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA1CC03E979;
        Fri, 26 Jun 2020 14:50:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q90so4719102pjh.3;
        Fri, 26 Jun 2020 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4DZwt1VPO3k8czAD7nyorc0HNDJJMxg9ril+if+5pK0=;
        b=cHQZsD6pEtRwSwPwupBud2k3ndXApzq6tAmt5g0GUEA0aMpkyUvOuFx+/Cdp8oUh1E
         Zs0Q/W4ptabDgbM40LNxNhQLZzNvU/41ULpNlUO0Gi/FpK1fSpCKYrQrQ8WqHdrvR6G9
         sBxsF9gg605a82s/mqjfdosUVI7kPnjjeVrWD0JulpC7AEyseijQBl4/313HhiyqzAjK
         /XgpDskcL2mjVbOr2pBjQC6WAHxfniTcav9iIqAQeDUFaVBgD7ElaMhApn4Rxn5blGTk
         Is131LNBYlS6hU+4S7Us2etEvmP0T5hOSg/bpmS8nREYQlDf5Xbfn1FbtO/ac9ktL+NT
         WO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4DZwt1VPO3k8czAD7nyorc0HNDJJMxg9ril+if+5pK0=;
        b=qTACYlVrKGqA14vQp1f02c6PnX0YCCmjOGuFgLilgW8ky+pWSXVZy4sI+e39tRlCXH
         lyPrqozNWj7X8nUOrvBt4tnriltXaoBETP2tmxK1LcZQ4IdRQsSU5c/0QgfxGEW6n3+5
         HLERXsSf13a0G1ne6l86Aild8nsuAxmOjyHHhg9hmAU5UqGExdA+1frCkGSeIU86fu88
         3DZX3Ooo3rF0gQaCvSoLFpFA5H+bi56Tu94ASc8qNe05PTRvqFn7RShUv5T+E+606jXI
         l4FDe4o9CkooXfXZX8VvZPZYbjBZuRQPdYP9QgJfzWW6WM3C4gWLfI5RTCSwOtS+3p+J
         0VDA==
X-Gm-Message-State: AOAM532GQw6pAyKnaho/urOtSHCLMKpFr4Oqs8Sb77K3Jr9QdKgZpZ57
        iPl9FI9AY9eF01A/yM8niE9aPf6P
X-Google-Smtp-Source: ABdhPJzGYjsBYBs4fQJE6UZe+ztNnpi70WAHSMP5qK4FF8HbgVjs1iWiBngMD1HauDf7Wz76k1aXHg==
X-Received: by 2002:a17:902:ab8e:: with SMTP id f14mr4460846plr.80.1593208205134;
        Fri, 26 Jun 2020 14:50:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q6sm1740821pfg.76.2020.06.26.14.50.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jun 2020 14:50:04 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:50:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 5/5] hwmon: pmbus: use more devres helpers
Message-ID: <20200626215003.GA254814@roeck-us.net>
References: <20200626165535.7662-1-brgl@bgdev.pl>
 <20200626165535.7662-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626165535.7662-6-brgl@bgdev.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 06:55:35PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Shrink pmbus code by using devm_hwmon_device_register_with_groups()
> and devm_krealloc() instead of their non-managed variants.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index a420877ba533..af74504647b8 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -1022,9 +1022,9 @@ static int pmbus_add_attribute(struct pmbus_data *data, struct attribute *attr)
>  {
>  	if (data->num_attributes >= data->max_attributes - 1) {
>  		int new_max_attrs = data->max_attributes + PMBUS_ATTR_ALLOC_SIZE;
> -		void *new_attrs = krealloc(data->group.attrs,
> -					   new_max_attrs * sizeof(void *),
> -					   GFP_KERNEL);
> +		void *new_attrs = devm_krealloc(data->dev, data->group.attrs,
> +						new_max_attrs * sizeof(void *),
> +						GFP_KERNEL);
>  		if (!new_attrs)
>  			return -ENOMEM;
>  		data->group.attrs = new_attrs;
> @@ -2538,7 +2538,7 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
>  
>  	ret = pmbus_find_attributes(client, data);
>  	if (ret)
> -		goto out_kfree;
> +		return ret;
>  
>  	/*
>  	 * If there are no attributes, something is wrong.
> @@ -2546,35 +2546,27 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
>  	 */
>  	if (!data->num_attributes) {
>  		dev_err(dev, "No attributes found\n");
> -		ret = -ENODEV;
> -		goto out_kfree;
> +		return -ENODEV;
>  	}
>  
>  	data->groups[0] = &data->group;
>  	memcpy(data->groups + 1, info->groups, sizeof(void *) * groups_num);
> -	data->hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
> -							    data, data->groups);
> +	data->hwmon_dev = devm_hwmon_device_register_with_groups(dev,
> +					client->name, data, data->groups);
>  	if (IS_ERR(data->hwmon_dev)) {
> -		ret = PTR_ERR(data->hwmon_dev);
>  		dev_err(dev, "Failed to register hwmon device\n");
> -		goto out_kfree;
> +		return PTR_ERR(data->hwmon_dev);
>  	}
>  
>  	ret = pmbus_regulator_register(data);
>  	if (ret)
> -		goto out_unregister;
> +		return ret;
>  
>  	ret = pmbus_init_debugfs(client, data);
>  	if (ret)
>  		dev_warn(dev, "Failed to register debugfs\n");
>  
>  	return 0;
> -
> -out_unregister:
> -	hwmon_device_unregister(data->hwmon_dev);
> -out_kfree:
> -	kfree(data->group.attrs);
> -	return ret;
>  }
>  EXPORT_SYMBOL_GPL(pmbus_do_probe);
>  
> @@ -2585,7 +2577,6 @@ int pmbus_do_remove(struct i2c_client *client)
>  	debugfs_remove_recursive(data->debugfs);
>  
>  	hwmon_device_unregister(data->hwmon_dev);

This is now wrong.

> -	kfree(data->group.attrs);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pmbus_do_remove);
> -- 
> 2.26.1
> 
