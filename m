Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E24AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A75720658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PF6mkhMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgG2T4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2T4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:56:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA446C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:56:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so14954898pgh.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0fQJyxSo67FNDkQUHPEwSov+BV9vc4P7IT8L2WCXawk=;
        b=PF6mkhMgyNDdKeKg8S5n0OeArNreeNAn3SiT/koYTKrgeeVmmrEij9zrtnkKbKS0p3
         iCzpz4nKoqBDd03LtQBdFBojHeTZmvG/vPzrupA/zu6v7S0GyOjj9xZarCw/+C8SWDLq
         w3vhtzPbnWlrVz0Pgdwf71oCdNkryx/80wSn9neZ1sOTo8A6/IAvGD3gFN3OIZ1xxNHh
         m4Hp9OFWjIFvQhJ+PfQKRKApykKpQs6SdU6gC9TwZn8qkSqoQTUT5utMAUAA/svLpnq3
         3SZEaNRcDKipdloTX1LyAskAu1Sqz84wGAL5semXdw4MNrFewWm9uR8DORKyhShuMGS3
         J2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0fQJyxSo67FNDkQUHPEwSov+BV9vc4P7IT8L2WCXawk=;
        b=JxVfyYsNVvKVtUc+47nxibwvYjFBq/k5EC9sBUv/x5VHvV6ZB4UmOnsBy/FnkjuYTq
         oALICkveTW4AFBw4hsQswaXjLlP2sgd+88GRqUku/fF2EMShx0+3YFNEF2vIVBiyeG+z
         5RB7hA5sq3j0I/g9Lslzh58KhTL1WHs4tBiuBojfDW/jrHpBi9wW8Y6SMEtJrb1Nd/7R
         c/50XXxt7lWv1x9cb6eGMZ4cqm15R7cnEgUJQdcknujxy6KZI/SKLAlexMUAHFOIsUiP
         bCV8DkeUc1k3BdFXBSYk5ur3vG+0tFxIEJYSO3Tnh+3dK/CMBMFX3ycgeLaxtzncIOZr
         LNQQ==
X-Gm-Message-State: AOAM530kOZfM/CYECCqq+DThwySqylLHWu131U0YEuqe/+l/z7VsUDh8
        Sj/gHqFTMbMvvefetE4SfjzeSQ==
X-Google-Smtp-Source: ABdhPJzJWA63HSRBWZCjo1qibJ94dr3BiDL4cTARe2mDhL7b1giCmDEqw8PIFDBIDcqCFpdasjrWYw==
X-Received: by 2002:a63:5412:: with SMTP id i18mr31714489pgb.63.1596052579980;
        Wed, 29 Jul 2020 12:56:19 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y10sm2784192pfp.130.2020.07.29.12.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 12:56:19 -0700 (PDT)
Date:   Wed, 29 Jul 2020 13:56:17 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org
Subject: Re: [RFC PATCH 02/14] coresight: Introduce device access abstraction
Message-ID: <20200729195617.GB3073178@xps15>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-3-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722172040.1299289-3-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 06:20:28PM +0100, Suzuki K Poulose wrote:
> We are about to introduce support for sysreg access to ETMv4.4+
> component. Since there are generic routines that access the
> registers (e.g, CS_LOCK/UNLOCK , claim/disclaim operations, timeout)
> and in order to preserve the logic of these operations at a single place
> we introduce an abstraction layer for the accesses to a given device.
> This will also be helpful in consolidating the sysfs.attribute helpers,
> that we define per driver.

Please drop the last sentence, it doesn't add to the current patch.

> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c  |   1 +
>  drivers/hwtracing/coresight/coresight-cti.c   |   1 +
>  drivers/hwtracing/coresight/coresight-etb10.c |   1 +
>  drivers/hwtracing/coresight/coresight-etm3x.c |   1 +
>  drivers/hwtracing/coresight/coresight-etm4x.c |   1 +
>  .../hwtracing/coresight/coresight-funnel.c    |   1 +
>  .../coresight/coresight-replicator.c          |   1 +
>  drivers/hwtracing/coresight/coresight-stm.c   |   1 +
>  drivers/hwtracing/coresight/coresight-tmc.c   |   1 +
>  drivers/hwtracing/coresight/coresight-tpiu.c  |   1 +
>  drivers/hwtracing/coresight/coresight.c       |  49 ++++++
>  include/linux/coresight.h                     | 156 ++++++++++++++++++
>  12 files changed, 215 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 1801804a7762..6299ff7b8a14 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -551,6 +551,7 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>  	dev->platform_data = pdata;
>  
>  	drvdata->base = base;
> +	catu_desc.access.base = base;
>  	catu_desc.pdata = pdata;
>  	catu_desc.dev = dev;
>  	catu_desc.groups = catu_groups;
> diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
> index 3ccc703dc940..c810ea3ba155 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.c
> +++ b/drivers/hwtracing/coresight/coresight-cti.c
> @@ -865,6 +865,7 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>  		return PTR_ERR(base);
>  
>  	drvdata->base = base;
> +	cti_desc.access.base = base;
>  
>  	dev_set_drvdata(dev, drvdata);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 03e3f2590191..0f2735e15119 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -755,6 +755,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>  		return PTR_ERR(base);
>  
>  	drvdata->base = base;
> +	desc.access.base = base;
>  
>  	spin_lock_init(&drvdata->spinlock);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index bf22dcfd3327..7ddcb7fcb2d6 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -805,6 +805,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  		return PTR_ERR(base);
>  
>  	drvdata->base = base;
> +	desc.access.base = base;
>  
>  	spin_lock_init(&drvdata->spinlock);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index cb83fb77ded6..7bb74c659c4f 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1501,6 +1501,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  		return PTR_ERR(base);
>  
>  	drvdata->base = base;
> +	desc.access.base = base;
>  
>  	spin_lock_init(&drvdata->spinlock);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 900690a9f7f0..67fc3e3b77d8 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -242,6 +242,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
>  		}
>  		drvdata->base = base;
>  		desc.groups = coresight_funnel_groups;
> +		desc.access.base = base;
>  	}
>  
>  	dev_set_drvdata(dev, drvdata);
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 78acf29c49ca..65704ada20a5 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -254,6 +254,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  		}
>  		drvdata->base = base;
>  		desc.groups = replicator_groups;
> +		desc.access.base = base;
>  	}
>  
>  	if (fwnode_property_present(dev_fwnode(dev),
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 673d2f56ed1e..c8509cc78512 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -881,6 +881,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  	drvdata->base = base;
> +	desc.access.base = base;
>  
>  	ret = stm_get_stimulus_area(dev, &ch_res);
>  	if (ret)
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 7040d583bed9..b49795ad6861 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -458,6 +458,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  	}
>  
>  	drvdata->base = base;
> +	desc.access.base = base;
>  
>  	spin_lock_init(&drvdata->spinlock);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index f8583e4032a6..7ef7649f48ad 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -149,6 +149,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  		return PTR_ERR(base);
>  
>  	drvdata->base = base;
> +	desc.access.base = base;
>  
>  	/* Disable tpiu to support older devices */
>  	tpiu_disable_hw(drvdata);
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index e9c90f2de34a..38e9c03ab754 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -1387,6 +1387,54 @@ static int __init coresight_init(void)
>  }
>  postcore_initcall(coresight_init);
>  
> +u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset)
> +{
> +	return csdev_access_relaxed_read32(&csdev->access, offset);
> +}
> +
> +u32 coresight_read32(struct coresight_device *csdev, u32 offset)
> +{
> +	return csdev_access_read32(&csdev->access, offset);
> +}
> +
> +void coresight_relaxed_write32(struct coresight_device *csdev,
> +			       u32 val,
> +			       u32 offset)
> +{
> +

Extra line

> +	csdev_access_relaxed_write32(&csdev->access, val, offset);
> +}
> +
> +
> +void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset)
> +{
> +	csdev_access_write32(&csdev->access, val, offset);
> +}
> +
> +u64 coresight_relaxed_read64(struct coresight_device *csdev, u32 offset)
> +{
> +	return csdev_access_relaxed_read64(&csdev->access, offset);
> +}
> +
> +u64 coresight_read64(struct coresight_device *csdev, u32 offset)
> +{
> +	return csdev_access_read64(&csdev->access, offset);
> +}
> +
> +void coresight_relaxed_write64(struct coresight_device *csdev,
> +			       u64 val,
> +			       u32 offset)
> +{
> +

Extra line

> +	csdev_access_relaxed_write64(&csdev->access, val, offset);
> +}
> +
> +
> +void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset)
> +{
> +	csdev_access_write64(&csdev->access, val, offset);
> +}
> +
>  /*
>   * coresight_release_platform_data: Release references to the devices connected
>   * to the output port of this device.
> @@ -1451,6 +1499,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>  	csdev->type = desc->type;
>  	csdev->subtype = desc->subtype;
>  	csdev->ops = desc->ops;
> +	csdev->access = desc->access;
>  	csdev->orphan = false;
>  
>  	csdev->dev.type = &coresight_dev_type[desc->type];
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 58fffdecdbfd..81ac708689f8 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -7,6 +7,7 @@
>  #define _LINUX_CORESIGHT_H
>  
>  #include <linux/device.h>
> +#include <linux/io.h>
>  #include <linux/perf_event.h>
>  #include <linux/sched.h>
>  
> @@ -114,6 +115,32 @@ struct coresight_platform_data {
>  	struct coresight_connection *conns;
>  };
>  
> +/**
> + * struct csdev_access - Abstraction of a CoreSight device access.
> + *
> + * @no_iomem	: True if the device doesn't have iomem access.
> + * @base	: When no_iomem == false, base address of the component
> + * @read	: Read from the given "offset" of the given instance.
> + * @write	: Write "val" to the given "offset".
> + */
> +struct csdev_access {
> +	bool no_iomem;

I find the no_iomen to be difficult to understand, especially when prefixed with
'!'.  Using "has_iomem" would be a lot more intuitive and would avoid extra 
mental gymnastics.

> +	union {
> +		void __iomem *base;
> +		struct {
> +			u64 (*read)(struct csdev_access *csa,
> +				    u32 offset,
> +				    bool relaxed,
> +				    bool _64bit);
> +			void (*write)(struct csdev_access *csa,
> +				      u64 val,
> +				      u32 offset,
> +				      bool relaxed,
> +				      bool _64bit);
> +		};
> +	};
> +};
> +
>  /**
>   * struct coresight_desc - description of a component required from drivers
>   * @type:	as defined by @coresight_dev_type.
> @@ -134,6 +161,7 @@ struct coresight_desc {
>  	struct device *dev;
>  	const struct attribute_group **groups;
>  	const char *name;
> +	struct csdev_access access;

No documentation

>  };
>  
>  /**
> @@ -186,6 +214,7 @@ struct coresight_sysfs_link {
>   * @def_sink:	cached reference to default sink found for this device.
>   * @ect_dev:	Associated cross trigger device. Not part of the trace data
>   *		path or connections.
> + * @csa:	Device i/o access abstraction for this device.
>   * @nr_links:   number of sysfs links created to other components from this
>   *		device. These will appear in the "connections" group.
>   * @has_conns_grp: Have added a "connections" group for sysfs links.
> @@ -205,6 +234,7 @@ struct coresight_device {
>  	struct coresight_device *def_sink;
>  	/* cross trigger handling */
>  	struct coresight_device *ect_dev;
> +	struct csdev_access access;

Documentation and field don't match.

>  	/* sysfs links between components */
>  	int nr_links;
>  	bool has_conns_grp;
> @@ -324,6 +354,79 @@ struct coresight_ops {
>  	const struct coresight_ops_ect *ect_ops;
>  };
>  
> +static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
> +					      u32 offset)
> +{
> +	if (likely(!csa->no_iomem))
> +		return readl_relaxed(csa->base + offset);
> +	return csa->read(csa, offset, true, false);
> +}
> +
> +static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
> +					   u32 offset)
> +{
> +	if (likely(!csa->no_iomem))
> +		return readq_relaxed(csa->base + offset);
> +	return csa->read(csa, offset, true, true);
> +}
> +
> +static inline u32 csdev_access_read32(struct csdev_access *csa, u32 offset)
> +{
> +	if (likely(!csa->no_iomem))
> +		return readl(csa->base + offset);
> +	return csa->read(csa, offset, false, false);
> +}
> +
> +static inline u64 csdev_access_read64(struct csdev_access *csa, u32 offset)
> +{
> +	if (likely(!csa->no_iomem))
> +		return readq(csa->base + offset);
> +	return csa->read(csa, offset, false, true);
> +}
> +

All of the above don't have a new line after the if() condition while the ones
below do.  Please pick a heurisitic and stick with it throughout. 

> +static inline void csdev_access_relaxed_write32(struct csdev_access *csa,
> +						u32 val,
> +						u32 offset)
> +{
> +	if (likely(!csa->no_iomem))
> +		return writel_relaxed(val, csa->base + offset);
> +
> +	return csa->write(csa, val, offset, true, false);
> +}
> +
> +static inline void csdev_access_relaxed_write64(struct csdev_access *csa,
> +					     u64 val,
> +					     u32 offset)
> +{
> +	if (likely(!csa->no_iomem))
> +		return writeq_relaxed(val, csa->base + offset);
> +
> +	return csa->write(csa, val, offset, true, true);
> +}
> +
> +static inline void csdev_access_write32(struct csdev_access *csa, u32 val, u32 offset)
> +{
> +	if (likely(!csa->no_iomem))
> +		return writel(val, csa->base + offset);
> +
> +	return csa->write(csa, val, offset, false, false);
> +}
> +
> +static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 offset)
> +{
> +	if (likely(!csa->no_iomem))
> +		return writeq(val, csa->base + offset);
> +
> +	return csa->write(csa, val, offset, false, true);
> +}
> +
> +
> +u64 coresight_relaxed_read64(struct coresight_device *csdev, u32 offset);
> +u64 coresight_read64(struct coresight_device *csdev, u32 offset);
> +void coresight_relaxed_write64(struct coresight_device *csdev,
> +			       u64 val, u32 offset);
> +void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset);
> +
>  #ifdef CONFIG_CORESIGHT
>  extern struct coresight_device *
>  coresight_register(struct coresight_desc *desc);
> @@ -342,6 +445,14 @@ extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
>  					 struct device *dev);
>  
>  extern bool coresight_loses_context_with_cpu(struct device *dev);
> +
> +u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset);
> +u32 coresight_read32(struct coresight_device *csdev, u32 offset);
> +void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset);
> +void coresight_relaxed_write32(struct coresight_device *csdev,
> +			       u32 val,
> +			       u32 offset);
> +

Why are the 64 bit version outside of the #ifdef and the 32 bit within?

>  #else
>  static inline struct coresight_device *
>  coresight_register(struct coresight_desc *desc) { return NULL; }
> @@ -368,6 +479,51 @@ static inline bool coresight_loses_context_with_cpu(struct device *dev)
>  {
>  	return false;
>  }
> +
> +static inline u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset)
> +{
> +	WARN_ON_ONCE(1);
> +	return 0;
> +}
> +
> +static inline u32 coresight_read32(struct coresight_device *csdev, u32 offset)
> +{
> +	WARN_ON_ONCE(1);
> +	return 0;
> +}
> +
> +static void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset)
> +{
> +}
> +
> +static void coresight_relaxed_write32(struct coresight_device *csdev,
> +				      u32 val, u32 offset);
> +{
> +}
> +
> +static inline u64 coresight_relaxed_read64(struct coresight_device *csdev,
> +					   u32 offset)
> +{
> +	WARN_ON_ONCE(1);
> +	return 0;
> +}
> +
> +static inline u64 coresight_read64(struct coresight_device *csdev, u32 offset)
> +{
> +	WARN_ON_ONCE(1);

Not sure about the motivation behind using WARN_ON_ONCE(), and only in the read
functions.  I would simply return 0 here.  After all if CONFIG_CORESIGHT is not
defined they won't make it very far.

> +	return 0;
> +}
> +
> +static inline void coresight_relaxed_write64(struct coresight_device *csdev,
> +					     u64 val,
> +					     u32 offset)
> +{
> +}
> +
> +static inline void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset)
> +{
> +}
> +
>  #endif

I will likely come back to this patch once I have reviewed the rest of the set.

>  
>  extern int coresight_get_cpu(struct device *dev);
> -- 
> 2.24.1
> 
