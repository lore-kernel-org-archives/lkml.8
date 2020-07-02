Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0644CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD24020884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="duCk5Q1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgGBMB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:01:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58775 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGBMB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:01:28 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200702120125euoutp02676642925b53cae9c85731caa844da57~d7ce-0Rvn2843028430euoutp02I
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 12:01:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200702120125euoutp02676642925b53cae9c85731caa844da57~d7ce-0Rvn2843028430euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593691285;
        bh=zlBTL+vItBW5znU937oIcdOspM1TVlnDIJWDwGQe8ok=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=duCk5Q1PSF5ZI5rftlC2mMU4HNf51tVuv29NAgAUhkbglNXECth3XEoBumqyGJnTV
         nwH4aZzRn1l5J0DnouI8v1PAXnRX9rZUr9pYoWUkXJu6kOG+QUejH23ucYMnjrr26a
         BZy0+LdA+ooGxD6ouG4tLl5muA9ebiCdwgkvub3c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200702120125eucas1p136fe3baab7a39b578b508ace55efd6f7~d7ceyIKx_1848518485eucas1p1l;
        Thu,  2 Jul 2020 12:01:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 31.61.05997.49CCDFE5; Thu,  2
        Jul 2020 13:01:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200702120124eucas1p2521bdea93c8cbf667c43c05ccc80963c~d7ceQobQb3109331093eucas1p2a;
        Thu,  2 Jul 2020 12:01:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200702120124eusmtrp21b52e6bf8e68b9bc5dd71f33a22fd23a~d7ceP4ntZ0646706467eusmtrp21;
        Thu,  2 Jul 2020 12:01:24 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-b7-5efdcc9415be
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0E.16.06314.49CCDFE5; Thu,  2
        Jul 2020 13:01:24 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200702120123eusmtip2a30276cd9943b203554eb51f325c33d4~d7cc5brc22772227722eusmtip2o;
        Thu,  2 Jul 2020 12:01:23 +0000 (GMT)
Subject: Re: [RFC PATCH v5 2/6] interconnect: Add generic interconnect
 driver for Exynos SoCs
To:     Georgi Djakov <georgi.djakov@linaro.org>, cw00.choi@samsung.com,
        krzk@kernel.org
Cc:     a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <1c277836-efdf-f7b8-aa62-7369349fe21f@samsung.com>
Date:   Thu, 2 Jul 2020 14:01:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f7f76798-4ee7-6e4a-fa3e-1acb0af76c2e@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHeXa3u7vR7Do1T0sKloRJaabU1UJK+rAgKkiCAl+W3lRyU3ad
        ph/KkNJp6jTMV1JMywamLl+nlUk5xJrai5aas7RCI9RcoJnZrlfJb///Ob/nnPOHh8CkFoGM
        iFEn0Bq1MlaOi/nN3YuWvQUvl0P3Ga2Ist65jqiGojoBNWT7JqDe/prBqcLHRpzKt+r5VF9f
        vZAyTgwKqDemMpwq6nvCo2qffxRSI9dq7PbWFH5EojAadLhidLADV1izzDzFo6qripxGA1LM
        G7efxs+LD0fSsTGJtMY7MFwcPdyygsVn+11ebO8UpqJcz0wkIoD0g6WedGEmEhNSsgbBu9Tc
        NWNDUDregTgzj2Cu/ja2/mRCN7JG3UfQ09yNcWYOQdHD10KWciLDoOBB26p2Js9Cus4kYCGM
        rORBbeGSgG3gpA9kv8hBrJaQgZBTPb26gk+6Q+tAOs5qFzLEXq/AOcYReoon+awW2XnD97LV
        ORjpCsOT5TxO74C0ptLVi4D8LARLxQf7AsJujsHCYiIXwQmmzY1CTrvBShv7luXTENxs57IB
        qUdgNVcgjjoEo5bfODsII3dDncmbKx+Fzq+1PG6+A7z/4cjd4AD5zYUYV5ZAxg0pR7vDkqGQ
        x2kZZE2u8PVIXrIhWcmGNCUb0pT831uB+AbkSmsZVRTN7FfTSV6MUsVo1VFeEXEqI7L/st6/
        ZlsrMv250IVIAsk3SfTm5VCpQJnIJKu6EBCY3FkS9Ko3VCqJVCan0Jq4MI02lma60DaCL3eV
        +FZOhUjJKGUCfYmm42nNepdHiGSp6ODFodQTVMDIsy3VX+56dJETQeK+CP2AS3TTcSOj3+PR
        o4k+E5x7Jb545F5H0WzGWKYpb2a57lSeNTM5WBdbTKmrjf6jkTZPlX//zzBRVcPOWXO555iL
        bJdWnXQg3C2M2vzJgokmW04uP1UlbVUrvRdizun6Zb4UL2Y8JeC0Vs5nopU+npiGUf4Ds9MW
        P2EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xe7pTzvyNM+i/L2dxf14ro8XGGetZ
        La5/ec5qceXrezaL6Xs3sVlMuj+BxeL8+Q3sFpseX2O1uLxrDpvFjPP7mCzWHrnLbnG7cQWQ
        O/klmwOvx6ZVnWwed67tYfO4332cyWPzknqPvi2rGD0+b5ILYIvSsynKLy1JVcjILy6xVYo2
        tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7i1/T9zQa9Jxc/dB9gbGPu1uhg5
        OSQETCQed95m72Lk4hASWMoocWNuA1sXIwdQQkpifosSRI2wxJ9rXWwQNe8ZJXq617GAJIQF
        4iWOTjnADGKLCIRJnO58zQpiMwssYpJ40aQMYgsJfGWU2LfVG8RmEzCU6D3axwhi8wrYSfQt
        fQXWyyKgIrHjYjsbiC0qECvx7d4WNogaQYmTM5+A7eIEql/1eg7UfHWJP/MuMUPY4hK3nsxn
        grDlJZq3zmaewCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZg
        3G479nPzDsZLG4MPMQpwMCrx8E44/jdOiDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFF
        pTmpxYcYTYGem8gsJZqcD0wpeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg
        +pg4OKUaGFuXfmNs3P1D977f8RiLzxPc+hhntV39m7hDOEiZP+XCDMNPBieteNaU+0Uv1mqz
        uS5/qEnYkMuz73X16732O+WXb1jocf7TlrIitzBDyTxJZeePG+I21n7Wavrnp7NRYnmp/cVF
        EeWCHDcNWMRVNA7tc/yzetNvncSznTdNrqmLzb3LqnJbSYmlOCPRUIu5qDgRAM5qUEvxAgAA
X-CMS-MailID: 20200702120124eucas1p2521bdea93c8cbf667c43c05ccc80963c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529163223eucas1p2f663280abb499b4114b2f2930b43a4e5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529163223eucas1p2f663280abb499b4114b2f2930b43a4e5
References: <20200529163200.18031-1-s.nawrocki@samsung.com>
        <CGME20200529163223eucas1p2f663280abb499b4114b2f2930b43a4e5@eucas1p2.samsung.com>
        <20200529163200.18031-3-s.nawrocki@samsung.com>
        <f7f76798-4ee7-6e4a-fa3e-1acb0af76c2e@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

On 01.07.2020 14:50, Georgi Djakov wrote:
> Thanks for the patch and apologies for the delayed reply.

Thanks, no problem. It's actually just in time as I put that patchset
aside for a while and was just about to post an update.
 
> On 5/29/20 19:31, Sylwester Nawrocki wrote:
>> This patch adds a generic interconnect driver for Exynos SoCs in order
>> to provide interconnect functionality for each "samsung,exynos-bus"
>> compatible device.
>>
>> The SoC topology is a graph (or more specifically, a tree) and its
>> edges are specified using the 'samsung,interconnect-parent' in the
>> DT. Due to unspecified relative probing order, -EPROBE_DEFER may be
>> propagated to ensure that the parent is probed before its children.
>>
>> Each bus is now an interconnect provider and an interconnect node as
>> well (cf. Documentation/interconnect/interconnect.rst), i.e. every bus
>> registers itself as a node. Node IDs are not hardcoded but rather
>> assigned dynamically at runtime. This approach allows for using this
>> driver with various Exynos SoCs.
>>
>> Frequencies requested via the interconnect API for a given node are
>> propagated to devfreq using dev_pm_qos_update_request(). Please note
>> that it is not an error when CONFIG_INTERCONNECT is 'n', in which
>> case all interconnect API functions are no-op.
>>
>> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

>> +static struct icc_node *exynos_icc_get_parent(struct device_node *np)
>> +{
>> +	struct of_phandle_args args;
>> +	int num, ret;
>> +
>> +	num = of_count_phandle_with_args(np, "samsung,interconnect-parent",
>> +					"#interconnect-cells");
>> +	if (num != 1)
>> +		return NULL; /* parent nodes are optional */
>> +
>> +	ret = of_parse_phandle_with_args(np, "samsung,interconnect-parent",
>> +					"#interconnect-cells", 0, &args);
>> +	if (ret < 0)
>> +		return ERR_PTR(ret);
>> +
>> +	of_node_put(args.np);
>> +
>> +	return of_icc_get_from_provider(&args);
>> +}
>> +
>> +
> 
> Nit: multiple blank lines

Fixed.

> [..]
>> +static struct icc_node *exynos_generic_icc_xlate(struct of_phandle_args *spec,
>> +						 void *data)
>> +{
>> +	struct exynos_icc_priv *priv = data;
>> +
>> +	if (spec->np != priv->dev->parent->of_node)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	return priv->node;
>> +}
>> +
>> +static int exynos_generic_icc_remove(struct platform_device *pdev)
>> +{
>> +	struct exynos_icc_priv *priv = platform_get_drvdata(pdev);
>> +	struct icc_node *parent_node, *node = priv->node;
>> +
>> +	parent_node = exynos_icc_get_parent(priv->dev->parent->of_node);
>> +	if (parent_node && !IS_ERR(parent_node))
> 
> Nit: !IS_ERR_OR_NULL?

It was left on purpose that way but I changed it now to IS_ERR_OR_NULL.

>> +		icc_link_destroy(node, parent_node);
>> +
>> +	icc_nodes_remove(&priv->provider);
>> +	icc_provider_del(&priv->provider);
>> +
>> +	return 0;
>> +}
>> +
>> +static int exynos_generic_icc_probe(struct platform_device *pdev)
>> +{
>> +	struct device *bus_dev = pdev->dev.parent;
>> +	struct exynos_icc_priv *priv;
>> +	struct icc_provider *provider;
>> +	struct icc_node *icc_node, *icc_parent_node;
>> +	int ret;
>> +
>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->dev = &pdev->dev;
>> +	platform_set_drvdata(pdev, priv);
>> +
>> +	provider = &priv->provider;
>> +
>> +	provider->set = exynos_generic_icc_set;
>> +	provider->aggregate = icc_std_aggregate;
>> +	provider->xlate = exynos_generic_icc_xlate;
>> +	provider->dev = bus_dev;
>> +	provider->inter_set = true;
>> +	provider->data = priv;
>> +
>> +	ret = icc_provider_add(provider);
> 
> Nit: Maybe it would be better to move this after the node is created. The
> idea is to create the nodes first and add the provider when the topology is
> populated. It's fine either way here, but i am planning to change this in
> some of the existing provider drivers.

OK, it makes the clean up path a bit less straightforward. And still we need 
to register the provider before calling icc_node_add().
I made a change as below.

--------------8<------------------
@@ -124,14 +123,14 @@ static int exynos_generic_icc_probe(struct platform_device *pdev)
 	provider->inter_set = true;
 	provider->data = priv;
 
+	icc_node = icc_node_create(pdev->id);
+	if (IS_ERR(icc_node))
+		return PTR_ERR(icc_node);
+
 	ret = icc_provider_add(provider);
-	if (ret < 0)
+	if (ret < 0) {
+		icc_node_destroy(icc_node->id);
 		return ret;
-
-	icc_node = icc_node_create(pdev->id);
-	if (IS_ERR(icc_node)) {
-		ret = PTR_ERR(icc_node);
-		goto err_prov_del;
 	}
 
 	priv->node = icc_node;
@@ -171,9 +170,7 @@ static int exynos_generic_icc_probe(struct platform_device *pdev)
 		icc_link_destroy(icc_node, icc_parent_node);
 err_node_del:
 	icc_nodes_remove(provider);
-err_prov_del:
 	icc_provider_del(provider);
-
 	return ret;
 }
--------------8<------------------


>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	icc_node = icc_node_create(pdev->id);
>> +	if (IS_ERR(icc_node)) {
>> +		ret = PTR_ERR(icc_node);
>> +		goto err_prov_del;
>> +	}
>> +
>> +	priv->node = icc_node;
>> +	icc_node->name = bus_dev->of_node->name;
>> +	icc_node->data = priv;
>> +	icc_node_add(icc_node, provider);
>> +
>> +	icc_parent_node = exynos_icc_get_parent(bus_dev->of_node);
>> +	if (IS_ERR(icc_parent_node)) {
>> +		ret = PTR_ERR(icc_parent_node);
>> +		goto err_node_del;
>> +	}
>> +	if (icc_parent_node) {
>> +		ret = icc_link_create(icc_node, icc_parent_node->id);
>> +		if (ret < 0)
>> +			goto err_node_del;
>> +	}
>> +
>> +	/*
>> +	 * Register a PM QoS request for the bus device for which also devfreq
>> +	 * functionality is registered.
>> +	 */
>> +	ret = dev_pm_qos_add_request(bus_dev, &priv->qos_req,
>> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
>> +	if (ret < 0)
>> +		goto err_link_destroy;
>> +
>> +	return 0;
>> +
>> +err_link_destroy:
>> +	if (icc_parent_node)
>> +		icc_link_destroy(icc_node, icc_parent_node);
>> +err_node_del:
>> +	icc_nodes_remove(provider);
>> +err_prov_del:
>> +	icc_provider_del(provider);
>> +
>> +	return ret;
>> +}

> All looks good to me, but it seems that the patch-set is not on
> Rob's radar currently, so please re-send and CC the DT mailing list.

Thanks, indeed I missed some mailing list when posting. I will make sure
Rob and DT ML list is on Cc, especially that I have added new "bus-width" 
property in v6.

-- 
Regards,
Sylwester
