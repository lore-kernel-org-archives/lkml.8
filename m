Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A029CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DF020760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ntVD9CTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgGAMuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgGAMuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:50:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C58C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:50:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so22268742wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=umVXKB3u4eCN/DDIxe4SvglUcm9Aqdv6e9Fe2HRUbqw=;
        b=ntVD9CTnA6wzmjjpVC8fo8e+KbOtimvbEsLk/S8NmMz73X9nxUt09ylULKAWbQNQK8
         YqnbrkdlGxUJ+nbSgFsFv5+uKq5zibXtopLvTYaRDfrrgAxrvbp96w8sQu2AnhgtBytw
         s8Fumt5ZvZxbavN1EhFBTBkiAOYkoyeqvIM/DOfccxaWt8XdFaOL0/pW9tBVMp0FL78w
         eyYmzbHFoJxORYhbBLTa1exl9vVk8YS1rqPp8cQvWLQ0ItmmViWbaL3jHSHULIxdBNFe
         LieJ/04kiy0waOyconKwOXgNxB184qOQvFAhJ3B8Xq1DEcCM5i/WUDTwYbtxhQc2QwJ4
         7ccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=umVXKB3u4eCN/DDIxe4SvglUcm9Aqdv6e9Fe2HRUbqw=;
        b=dK/0zxKZKwm8qqVMKV0YtKT3VmFOO9by6wfAXjNPwbtBgbOEaTCGd07NEsdqRKJKfD
         JcQAsXSwgv2JkAav888UsaSUlRTYMbSjSHknRZA4rwZu6oCvWZguTUH0wWQPr4D1BnGw
         Ckuzs9NEPyY2TpsutpMqwXIviZH1CUlYKamw1v+R0pdAz2rtA8hRsKkQjQb7n9u3Hh/g
         +1NQLT2Gh7aTnpxdxTzxD2xXlsRsw+x0kEaXsavXr7DTknb+3iKo62zRuk7d19chVtvo
         3hGjA2ey8FSNX/LF7WlZiI6h2zTxZwwRqZDH7n27qaIEXT6t9avAZcgkVARkIbOS22mK
         hrLQ==
X-Gm-Message-State: AOAM5326XyofPwLa9I6dwwHqhX2i8FGKGvJsaYDzS6Ybnd232RBYTO25
        CFkXOhiMogNEHwl4/Wit6XaB3w==
X-Google-Smtp-Source: ABdhPJw9vr7DD+ZqgT9Wb/7wovS1zE13rleRvTjwdcSyUJTDPHT0fRAncLVTBws+HvWSOHQBYNOO4g==
X-Received: by 2002:a1c:f314:: with SMTP id q20mr26604222wmq.18.1593607807032;
        Wed, 01 Jul 2020 05:50:07 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id w14sm7203282wrt.55.2020.07.01.05.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 05:50:05 -0700 (PDT)
Subject: Re: [RFC PATCH v5 2/6] interconnect: Add generic interconnect driver
 for Exynos SoCs
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>, cw00.choi@samsung.com,
        krzk@kernel.org
Cc:     a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
References: <20200529163200.18031-1-s.nawrocki@samsung.com>
 <CGME20200529163223eucas1p2f663280abb499b4114b2f2930b43a4e5@eucas1p2.samsung.com>
 <20200529163200.18031-3-s.nawrocki@samsung.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <f7f76798-4ee7-6e4a-fa3e-1acb0af76c2e@linaro.org>
Date:   Wed, 1 Jul 2020 15:50:03 +0300
MIME-Version: 1.0
In-Reply-To: <20200529163200.18031-3-s.nawrocki@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

Thanks for the patch and apologies for the delayed reply.

On 5/29/20 19:31, Sylwester Nawrocki wrote:
> This patch adds a generic interconnect driver for Exynos SoCs in order
> to provide interconnect functionality for each "samsung,exynos-bus"
> compatible device.
> 
> The SoC topology is a graph (or more specifically, a tree) and its
> edges are specified using the 'samsung,interconnect-parent' in the
> DT. Due to unspecified relative probing order, -EPROBE_DEFER may be
> propagated to ensure that the parent is probed before its children.
> 
> Each bus is now an interconnect provider and an interconnect node as
> well (cf. Documentation/interconnect/interconnect.rst), i.e. every bus
> registers itself as a node. Node IDs are not hardcoded but rather
> assigned dynamically at runtime. This approach allows for using this
> driver with various Exynos SoCs.
> 
> Frequencies requested via the interconnect API for a given node are
> propagated to devfreq using dev_pm_qos_update_request(). Please note
> that it is not an error when CONFIG_INTERCONNECT is 'n', in which
> case all interconnect API functions are no-op.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> Changes for v5:
>  - adjust to renamed exynos,interconnect-parent-node property,
>  - use automatically generated platform device id as the interconect
>    node id instead of a now unavailable devfreq->id field,
>  - add icc_ prefix to some variables to make the code more self-commenting,
>  - use icc_nodes_remove() instead of icc_node_del() + icc_node_destroy(),
>  - adjust to exynos,interconnect-parent-node property rename to
>    samsung,interconnect-parent,
>  - converted to a separate platform driver in drivers/i.nterconnect.
> ---
>  drivers/interconnect/Kconfig         |   1 +
>  drivers/interconnect/Makefile        |   1 +
>  drivers/interconnect/exynos/Kconfig  |   6 ++
>  drivers/interconnect/exynos/Makefile |   4 +
>  drivers/interconnect/exynos/exynos.c | 185 +++++++++++++++++++++++++++++++++++
>  5 files changed, 197 insertions(+)
>  create mode 100644 drivers/interconnect/exynos/Kconfig
>  create mode 100644 drivers/interconnect/exynos/Makefile
>  create mode 100644 drivers/interconnect/exynos/exynos.c
[..]
> +static struct icc_node *exynos_icc_get_parent(struct device_node *np)
> +{
> +	struct of_phandle_args args;
> +	int num, ret;
> +
> +	num = of_count_phandle_with_args(np, "samsung,interconnect-parent",
> +					"#interconnect-cells");
> +	if (num != 1)
> +		return NULL; /* parent nodes are optional */
> +
> +	ret = of_parse_phandle_with_args(np, "samsung,interconnect-parent",
> +					"#interconnect-cells", 0, &args);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	of_node_put(args.np);
> +
> +	return of_icc_get_from_provider(&args);
> +}
> +
> +

Nit: multiple blank lines

[..]
> +static struct icc_node *exynos_generic_icc_xlate(struct of_phandle_args *spec,
> +						 void *data)
> +{
> +	struct exynos_icc_priv *priv = data;
> +
> +	if (spec->np != priv->dev->parent->of_node)
> +		return ERR_PTR(-EINVAL);
> +
> +	return priv->node;
> +}
> +
> +static int exynos_generic_icc_remove(struct platform_device *pdev)
> +{
> +	struct exynos_icc_priv *priv = platform_get_drvdata(pdev);
> +	struct icc_node *parent_node, *node = priv->node;
> +
> +	parent_node = exynos_icc_get_parent(priv->dev->parent->of_node);
> +	if (parent_node && !IS_ERR(parent_node))

Nit: !IS_ERR_OR_NULL?

> +		icc_link_destroy(node, parent_node);
> +
> +	icc_nodes_remove(&priv->provider);
> +	icc_provider_del(&priv->provider);
> +
> +	return 0;
> +}
> +
> +static int exynos_generic_icc_probe(struct platform_device *pdev)
> +{
> +	struct device *bus_dev = pdev->dev.parent;
> +	struct exynos_icc_priv *priv;
> +	struct icc_provider *provider;
> +	struct icc_node *icc_node, *icc_parent_node;
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, priv);
> +
> +	provider = &priv->provider;
> +
> +	provider->set = exynos_generic_icc_set;
> +	provider->aggregate = icc_std_aggregate;
> +	provider->xlate = exynos_generic_icc_xlate;
> +	provider->dev = bus_dev;
> +	provider->inter_set = true;
> +	provider->data = priv;
> +
> +	ret = icc_provider_add(provider);

Nit: Maybe it would be better to move this after the node is created. The
idea is to create the nodes first and add the provider when the topology is
populated. It's fine either way here, but i am planning to change this in
some of the existing provider drivers.

> +	if (ret < 0)
> +		return ret;
> +
> +	icc_node = icc_node_create(pdev->id);
> +	if (IS_ERR(icc_node)) {
> +		ret = PTR_ERR(icc_node);
> +		goto err_prov_del;
> +	}
> +
> +	priv->node = icc_node;
> +	icc_node->name = bus_dev->of_node->name;
> +	icc_node->data = priv;
> +	icc_node_add(icc_node, provider);
> +
> +	icc_parent_node = exynos_icc_get_parent(bus_dev->of_node);
> +	if (IS_ERR(icc_parent_node)) {
> +		ret = PTR_ERR(icc_parent_node);
> +		goto err_node_del;
> +	}
> +	if (icc_parent_node) {
> +		ret = icc_link_create(icc_node, icc_parent_node->id);
> +		if (ret < 0)
> +			goto err_node_del;
> +	}
> +
> +	/*
> +	 * Register a PM QoS request for the bus device for which also devfreq
> +	 * functionality is registered.
> +	 */
> +	ret = dev_pm_qos_add_request(bus_dev, &priv->qos_req,
> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
> +	if (ret < 0)
> +		goto err_link_destroy;
> +
> +	return 0;
> +
> +err_link_destroy:
> +	if (icc_parent_node)
> +		icc_link_destroy(icc_node, icc_parent_node);
> +err_node_del:
> +	icc_nodes_remove(provider);
> +err_prov_del:
> +	icc_provider_del(provider);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver exynos_generic_icc_driver = {
> +	.driver = {
> +		.name = "exynos-generic-icc",
> +	},
> +	.probe = exynos_generic_icc_probe,
> +	.remove = exynos_generic_icc_remove,
> +};
> +module_platform_driver(exynos_generic_icc_driver);
> +
> +MODULE_DESCRIPTION("Exynos generic interconnect driver");
> +MODULE_AUTHOR("Artur Świgoń <a.swigon@samsung.com>");
> +MODULE_AUTHOR("Sylwester Nawrocki <s.nawrocki@samsung.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:exynos-generic-icc");

All looks good to me, but it seems that the patch-set is not on
Rob's radar currently, so please re-send and CC the DT mailing list.

Thanks,
Georgi
