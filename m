Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACECC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F55D207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g38oVsOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgGBMdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbgGBMdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:33:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BACCC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 05:33:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so16786608wrl.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 05:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8r83gH898PSuF+3k/nX9SGZb7y5r6JHgwbQtbPhVhfc=;
        b=g38oVsOBLl7GCV4+L1jThVfkuNR5gnJRRs4Vfxc/2P1qoRnZ/0XTJWj62dDHpM0+hU
         nr7WM09dIkfkDyka0hWklMFumFrKZ1aC/OvozVFTtUmFgnbdnZXiHIDrg4BlCaOMzMDg
         7279OhovMiB4eKvOu/Sc6hUvTTO4SzgGsX2qfUOMLcUBcRPv020SNbV6NtxLtGHdknIr
         XnIzoFN8YeR+QyBmYFWuZbJGCudHQrPWqK5tyfggnWYUqKsguBUMPHbMY3tNgiNcpn2m
         vJ13D3GS7HG5MZNG7TNg9ApbYZYro6hVjxWAtUDw4kpR/2vMjKgtZXxOs/GE1WrY8RnI
         wETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8r83gH898PSuF+3k/nX9SGZb7y5r6JHgwbQtbPhVhfc=;
        b=b8AyZln9IMmxMpOs9UE2zYQHOuk4ElLzxk+rMs9077HhIg+rY6hNFPCPfCwwWQWhbc
         11VJY8IOkLCWbCfizvij+ZYjOPakAs4JMPlgSDir1UCPEg6VQZtWRAPKN4zAQI9y70j+
         fcUpkHiLX+rfZ2mH4dFQMsba3qpA28X9VQdVr7DrNeWzoXjQp0W7DaHhipHLwIhkAGyn
         1MEY+VhsznJElGq5YXgEaVQ/ZSW3lpL4HYhCaoHUxWOUfNMPJRJ3S1vydpseRwwk5J67
         Mm11RBrvIAUDFhoye0cdYUpX2YmseJS8bcZVSYd5n7uhWp5mdkNxHxOPwMIHspUUAts8
         56TQ==
X-Gm-Message-State: AOAM532ZnrZN3XO1nw5RvigbsageOMWOIaEVmyhwocPvLUiIn90DX7Yu
        JtztAFqlGhRZS32/jHofWTLxbBpe79U=
X-Google-Smtp-Source: ABdhPJxRatxZLBU1KtIC/SxfvSCfJY8PGytTvrf+Uokei8HJbir6162nyVqkeWVDb1VxbzGPO/QjgQ==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr30776516wre.369.1593693217672;
        Thu, 02 Jul 2020 05:33:37 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id n125sm10900179wme.30.2020.07.02.05.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 05:33:37 -0700 (PDT)
Subject: Re: [RFC PATCH v5 2/6] interconnect: Add generic interconnect driver
 for Exynos SoCs
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     cw00.choi@samsung.com, krzk@kernel.org, a.swigon@samsung.com,
        myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
References: <20200529163200.18031-1-s.nawrocki@samsung.com>
 <CGME20200529163223eucas1p2f663280abb499b4114b2f2930b43a4e5@eucas1p2.samsung.com>
 <20200529163200.18031-3-s.nawrocki@samsung.com>
 <f7f76798-4ee7-6e4a-fa3e-1acb0af76c2e@linaro.org>
 <1c277836-efdf-f7b8-aa62-7369349fe21f@samsung.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <d3a45a91-d223-d3a2-a9fb-adadca98c80d@linaro.org>
Date:   Thu, 2 Jul 2020 15:33:35 +0300
MIME-Version: 1.0
In-Reply-To: <1c277836-efdf-f7b8-aa62-7369349fe21f@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

On 7/2/20 15:01, Sylwester Nawrocki wrote:
> Hi Georgi,
> 
> On 01.07.2020 14:50, Georgi Djakov wrote:
>> Thanks for the patch and apologies for the delayed reply.
> 
> Thanks, no problem. It's actually just in time as I put that patchset
> aside for a while and was just about to post an update.
>  
>> On 5/29/20 19:31, Sylwester Nawrocki wrote:
>>> This patch adds a generic interconnect driver for Exynos SoCs in order
>>> to provide interconnect functionality for each "samsung,exynos-bus"
>>> compatible device.
>>>
>>> The SoC topology is a graph (or more specifically, a tree) and its
>>> edges are specified using the 'samsung,interconnect-parent' in the
>>> DT. Due to unspecified relative probing order, -EPROBE_DEFER may be
>>> propagated to ensure that the parent is probed before its children.
>>>
>>> Each bus is now an interconnect provider and an interconnect node as
>>> well (cf. Documentation/interconnect/interconnect.rst), i.e. every bus
>>> registers itself as a node. Node IDs are not hardcoded but rather
>>> assigned dynamically at runtime. This approach allows for using this
>>> driver with various Exynos SoCs.
>>>
>>> Frequencies requested via the interconnect API for a given node are
>>> propagated to devfreq using dev_pm_qos_update_request(). Please note
>>> that it is not an error when CONFIG_INTERCONNECT is 'n', in which
>>> case all interconnect API functions are no-op.
>>>
>>> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
>>> +static struct icc_node *exynos_icc_get_parent(struct device_node *np)
>>> +{
>>> +	struct of_phandle_args args;
>>> +	int num, ret;
>>> +
>>> +	num = of_count_phandle_with_args(np, "samsung,interconnect-parent",
>>> +					"#interconnect-cells");
>>> +	if (num != 1)
>>> +		return NULL; /* parent nodes are optional */
>>> +
>>> +	ret = of_parse_phandle_with_args(np, "samsung,interconnect-parent",
>>> +					"#interconnect-cells", 0, &args);
>>> +	if (ret < 0)
>>> +		return ERR_PTR(ret);
>>> +
>>> +	of_node_put(args.np);
>>> +
>>> +	return of_icc_get_from_provider(&args);
>>> +}
>>> +
>>> +
>>
>> Nit: multiple blank lines
> 
> Fixed.
> 
>> [..]
>>> +static struct icc_node *exynos_generic_icc_xlate(struct of_phandle_args *spec,
>>> +						 void *data)
>>> +{
>>> +	struct exynos_icc_priv *priv = data;
>>> +
>>> +	if (spec->np != priv->dev->parent->of_node)
>>> +		return ERR_PTR(-EINVAL);
>>> +
>>> +	return priv->node;
>>> +}
>>> +
>>> +static int exynos_generic_icc_remove(struct platform_device *pdev)
>>> +{
>>> +	struct exynos_icc_priv *priv = platform_get_drvdata(pdev);
>>> +	struct icc_node *parent_node, *node = priv->node;
>>> +
>>> +	parent_node = exynos_icc_get_parent(priv->dev->parent->of_node);
>>> +	if (parent_node && !IS_ERR(parent_node))
>>
>> Nit: !IS_ERR_OR_NULL?
> 
> It was left on purpose that way but I changed it now to IS_ERR_OR_NULL.

Well, i have no strong opinion on that, it's up to you.

>>> +		icc_link_destroy(node, parent_node);
>>> +
>>> +	icc_nodes_remove(&priv->provider);
>>> +	icc_provider_del(&priv->provider);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int exynos_generic_icc_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *bus_dev = pdev->dev.parent;
>>> +	struct exynos_icc_priv *priv;
>>> +	struct icc_provider *provider;
>>> +	struct icc_node *icc_node, *icc_parent_node;
>>> +	int ret;
>>> +
>>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	priv->dev = &pdev->dev;
>>> +	platform_set_drvdata(pdev, priv);
>>> +
>>> +	provider = &priv->provider;
>>> +
>>> +	provider->set = exynos_generic_icc_set;
>>> +	provider->aggregate = icc_std_aggregate;
>>> +	provider->xlate = exynos_generic_icc_xlate;
>>> +	provider->dev = bus_dev;
>>> +	provider->inter_set = true;
>>> +	provider->data = priv;
>>> +
>>> +	ret = icc_provider_add(provider);
>>
>> Nit: Maybe it would be better to move this after the node is created. The
>> idea is to create the nodes first and add the provider when the topology is
>> populated. It's fine either way here, but i am planning to change this in
>> some of the existing provider drivers.
> 
> OK, it makes the clean up path a bit less straightforward. And still we need 
> to register the provider before calling icc_node_add().
> I made a change as below.
> 
> --------------8<------------------
> @@ -124,14 +123,14 @@ static int exynos_generic_icc_probe(struct platform_device *pdev)
>  	provider->inter_set = true;
>  	provider->data = priv;
>  
> +	icc_node = icc_node_create(pdev->id);
> +	if (IS_ERR(icc_node))
> +		return PTR_ERR(icc_node);
> +
>  	ret = icc_provider_add(provider);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		icc_node_destroy(icc_node->id);
>  		return ret;
> -
> -	icc_node = icc_node_create(pdev->id);
> -	if (IS_ERR(icc_node)) {
> -		ret = PTR_ERR(icc_node);
> -		goto err_prov_del;
>  	}
>  
>  	priv->node = icc_node;
> @@ -171,9 +170,7 @@ static int exynos_generic_icc_probe(struct platform_device *pdev)
>  		icc_link_destroy(icc_node, icc_parent_node);
>  err_node_del:
>  	icc_nodes_remove(provider);
> -err_prov_del:
>  	icc_provider_del(provider);
> -
>  	return ret;
>  }
> --------------8<------------------

Actually i need to post some patches first, so maybe keep it as is for now and
we will update it afterwards. Sorry for the confusion.

> 
> 
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	icc_node = icc_node_create(pdev->id);
>>> +	if (IS_ERR(icc_node)) {
>>> +		ret = PTR_ERR(icc_node);
>>> +		goto err_prov_del;
>>> +	}
>>> +
>>> +	priv->node = icc_node;
>>> +	icc_node->name = bus_dev->of_node->name;
>>> +	icc_node->data = priv;
>>> +	icc_node_add(icc_node, provider);
>>> +
>>> +	icc_parent_node = exynos_icc_get_parent(bus_dev->of_node);
>>> +	if (IS_ERR(icc_parent_node)) {
>>> +		ret = PTR_ERR(icc_parent_node);
>>> +		goto err_node_del;
>>> +	}
>>> +	if (icc_parent_node) {
>>> +		ret = icc_link_create(icc_node, icc_parent_node->id);
>>> +		if (ret < 0)
>>> +			goto err_node_del;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Register a PM QoS request for the bus device for which also devfreq
>>> +	 * functionality is registered.
>>> +	 */
>>> +	ret = dev_pm_qos_add_request(bus_dev, &priv->qos_req,
>>> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
>>> +	if (ret < 0)
>>> +		goto err_link_destroy;
>>> +
>>> +	return 0;
>>> +
>>> +err_link_destroy:
>>> +	if (icc_parent_node)
>>> +		icc_link_destroy(icc_node, icc_parent_node);
>>> +err_node_del:
>>> +	icc_nodes_remove(provider);
>>> +err_prov_del:
>>> +	icc_provider_del(provider);
>>> +
>>> +	return ret;
>>> +}
> 
>> All looks good to me, but it seems that the patch-set is not on
>> Rob's radar currently, so please re-send and CC the DT mailing list.
> 
> Thanks, indeed I missed some mailing list when posting. I will make sure
> Rob and DT ML list is on Cc, especially that I have added new "bus-width" 
> property in v6.

Ok, good. I have been thinking about bus-width and we might want to make it
even a generic DT property if there are multiple platforms which want to
use it - maybe if the bus-width is the same across the whole interconnect
provider. But as most of the existing drivers have different bus-widths, i
haven't done it yet, but let's see and start a discussion.

Thanks,
Georgi
