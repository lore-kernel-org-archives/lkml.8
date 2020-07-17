Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23832C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E630320684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORqsOkDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgGQTrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:47:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35331 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728484AbgGQTrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595015240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4mFCelJ/6dsAogWIziPk4FEC8WeTthDDs0diEXNPwU8=;
        b=ORqsOkDno4grll4QiME9Llt6ZvfuUKp6XapodPZ45MIfPpoPPmtqBWM8Sw2aaHK4zwsZQK
        7t7fNtg4F0DSHIX8n/Unb/MgNK8xqtnbxqmkO2p48aX3C63FQcWOxrh4KUBy5sSeo+wzrA
        gGNKXDumMnU2tmM0BiRS8xGfSD4qoHw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-2rJY2dwvNuiDHYArrXdyGw-1; Fri, 17 Jul 2020 15:47:17 -0400
X-MC-Unique: 2rJY2dwvNuiDHYArrXdyGw-1
Received: by mail-qv1-f72.google.com with SMTP id j6so6185359qvl.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 12:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4mFCelJ/6dsAogWIziPk4FEC8WeTthDDs0diEXNPwU8=;
        b=lclHDs7WWNPluHSQ+GVae7u80yJTCM+NxYrbS/TvusXb0Q/bY++MLCsP9dN+6X88ji
         TYDlV8t5ehOftahecWNuEt01Lf/o8CAp6ThIX50hI2IZzD+YIdthtdSxL98yKLaLZVzU
         vpXwbpAdGdBf7nHkTdP726ohBj4ZQ4o2D8rSrBMEYmrMzlX8XE99kCDrVXVrwjAaw/SY
         JduiwlPJB5fDLTeRa92ZKY+bqAts5EpBV/sVzskD1aF8lTOJkUdwuzxrUXjp/uVKAR1R
         Vrllr0fy5+acEAWdE/MIkKr/PpS8+tN4/Vo2/QJpFBTmUo0U3BtzMCg8md9ql9Em/ZMT
         ZHRg==
X-Gm-Message-State: AOAM532U1yLtnwvtPWpX7HpyL8AiIIpTFzahPRP+d9cLCJJBSYnPrfc9
        C3X/3jUTkcA6LkG4pXq8i0LM7jP95zui1CU9Pwd9DAdfMHz9ESqg/NCkHxwRWZjQjQQ0Ydpa/Pf
        HOs/x152nzQbm4UFu8L7sK75F
X-Received: by 2002:a0c:a9db:: with SMTP id c27mr10685388qvb.204.1595015237240;
        Fri, 17 Jul 2020 12:47:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQsRG4JdMBaGC1cyze4Hb1h4vse74BifNfeCAEoIUc9tEQtfbOAKOF+8ZWv7K95rQoQbjUOw==
X-Received: by 2002:a0c:a9db:: with SMTP id c27mr10685344qvb.204.1595015236787;
        Fri, 17 Jul 2020 12:47:16 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c80sm2959308qkg.72.2020.07.17.12.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 12:47:16 -0700 (PDT)
Subject: Re: [PATCH 2/2] fpga: dfl: create a dfl bus type to support DFL
 devices
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <1594791498-14495-3-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0776e674-d94d-da97-342a-b043c5dc24f3@redhat.com>
Date:   Fri, 17 Jul 2020 12:47:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1594791498-14495-3-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More small stuff.

Refactoring for feature_id conflict covered in other email.

Tom


On 7/14/20 10:38 PM, Xu Yilun wrote:
> A new bus type "dfl" is introduced for private features which are not
> initialized by DFL feature drivers (dfl-fme & dfl-afu drivers). So these
> private features could be handled by separate driver modules.
>
> DFL framework will create DFL devices on enumeration. DFL drivers could
> be registered on this bus to match these DFL devices. They are matched by
> dfl type & feature_id.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
>  drivers/fpga/dfl.c                      | 248 ++++++++++++++++++++++++++++++--
>  drivers/fpga/dfl.h                      |  85 +++++++++++
>  3 files changed, 340 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl b/Documentation/ABI/testing/sysfs-bus-dfl
> new file mode 100644
> index 0000000..cd00abc
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-dfl
> @@ -0,0 +1,15 @@
> +What:		/sys/bus/dfl/devices/.../type
> +Date:		March 2020
> +KernelVersion:	5.7
5.8
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns type of DFL FIU of the device. Now DFL
> +		supports 2 FIU types, 0 for FME, 1 for PORT.
> +		Format: 0x%x
> +
> +What:		/sys/bus/dfl/devices/.../feature_id
> +Date:		March 2020
> +KernelVersion:	5.7
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns feature identifier local to its DFL FIU
> +		type.
> +		Format: 0x%llx
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 7dc6411..93f9d6d 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -30,12 +30,6 @@ static DEFINE_MUTEX(dfl_id_mutex);
>   * index to dfl_chardevs table. If no chardev support just set devt_type
>   * as one invalid index (DFL_FPGA_DEVT_MAX).
>   */
> -enum dfl_id_type {
> -	FME_ID,		/* fme id allocation and mapping */
> -	PORT_ID,	/* port id allocation and mapping */
> -	DFL_ID_MAX,
> -};
> -
>  enum dfl_fpga_devt_type {
>  	DFL_FPGA_DEVT_FME,
>  	DFL_FPGA_DEVT_PORT,
> @@ -255,6 +249,228 @@ static bool is_header_feature(struct dfl_feature *feature)
>  	return feature->id == FEATURE_ID_FIU_HEADER;
>  }
>  
> +static const struct dfl_device_id *
> +dfl_match_one_device(const struct dfl_device_id *id,
> +		     struct dfl_device *dfl_dev)
> +{
> +	if (id->type == dfl_dev->type &&
> +	    id->feature_id == dfl_dev->feature_id)
> +		return id;
> +
> +	return NULL;
> +}
> +
> +static int dfl_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct dfl_device *dfl_dev = to_dfl_dev(dev);
> +	struct dfl_driver *dfl_drv = to_dfl_drv(drv);
> +	const struct dfl_device_id *id_entry = dfl_drv->id_table;
Null check ?
> +
> +	while (id_entry->feature_id) {
Null check or document table has a sentinel.
> +		if (dfl_match_one_device(id_entry, dfl_dev)) {
> +			dfl_dev->id_entry = id_entry;
> +			return 1;
> +		}
> +		id_entry++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dfl_bus_probe(struct device *dev)
> +{
> +	struct dfl_device *dfl_dev = to_dfl_dev(dev);
> +	struct dfl_driver *dfl_drv = to_dfl_drv(dev->driver);
> +
> +	return dfl_drv->probe(dfl_dev);
> +}
> +
> +static int dfl_bus_remove(struct device *dev)
> +{
> +	struct dfl_device *dfl_dev = to_dfl_dev(dev);
> +	struct dfl_driver *dfl_drv = to_dfl_drv(dev->driver);
> +
> +	if (dfl_drv->remove)
> +		dfl_drv->remove(dfl_dev);
return dfl_drv->remove()
> +
> +	return 0;
> +}
> +
> +static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct dfl_device *dfl_dev = to_dfl_dev(dev);
> +
> +	if (add_uevent_var(env, "MODALIAS=dfl:%08x:%016llx",
> +			   dfl_dev->type, dfl_dev->feature_id))
> +		return -ENOMEM;

can simplify, change to

return add_uevent_var(...)

> +
> +	return 0;
> +}
> +
> +/* show dfl info fields */
> +#define dfl_info_attr(field, format_string)				\
> +static ssize_t								\
> +field##_show(struct device *dev, struct device_attribute *attr,		\
> +	     char *buf)							\
> +{									\
> +	struct dfl_device *dfl_dev = to_dfl_dev(dev);			\
> +									\
> +	return sprintf(buf, format_string, dfl_dev->field);		\
> +}									\
> +static DEVICE_ATTR_RO(field)
> +
> +dfl_info_attr(type, "0x%x\n");
> +dfl_info_attr(feature_id, "0x%llx\n");
> +
> +static struct attribute *dfl_dev_attrs[] = {
> +	&dev_attr_type.attr,
> +	&dev_attr_feature_id.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(dfl_dev);
> +
> +static struct bus_type dfl_bus_type = {
> +	.name		= "dfl",
> +	.match		= dfl_bus_match,
> +	.probe		= dfl_bus_probe,
> +	.remove		= dfl_bus_remove,
> +	.uevent		= dfl_bus_uevent,
> +	.dev_groups	= dfl_dev_groups,
> +};
> +
> +static void release_dfl_dev(struct device *dev)
> +{
> +	struct dfl_device *dfl_dev = to_dfl_dev(dev);
> +
> +	release_resource(&dfl_dev->mmio_res);
Where is request_resource, shouldn't it be in dfl_dev_add ?
> +	kfree(dfl_dev->irqs);
> +	kfree(dfl_dev);
> +}
> +
> +static struct dfl_device *
> +dfl_dev_add(struct dfl_feature_platform_data *pdata,
> +	    struct dfl_feature *feature)
> +{
> +	struct platform_device *pdev = pdata->dev;
> +	struct dfl_device *dfl_dev;
> +	int i, ret;
> +
> +	dfl_dev = kzalloc(sizeof(*dfl_dev), GFP_KERNEL);
> +	if (!dfl_dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dfl_dev->cdev = pdata->dfl_cdev;
> +
> +	dfl_dev->mmio_res.parent = &pdev->resource[feature->resource_index];
> +	dfl_dev->mmio_res.flags = IORESOURCE_MEM;
> +	dfl_dev->mmio_res.start =
> +		pdev->resource[feature->resource_index].start;
> +	dfl_dev->mmio_res.end = pdev->resource[feature->resource_index].end;
> +
> +	/* then add irq resource */
> +	if (feature->nr_irqs) {
> +		dfl_dev->irqs = kcalloc(feature->nr_irqs,
> +					sizeof(*dfl_dev->irqs), GFP_KERNEL);
> +		if (!dfl_dev->irqs) {
> +			ret = -ENOMEM;
> +			goto free_dfl_dev;
> +		}
> +
> +		for (i = 0; i < feature->nr_irqs; i++)
> +			dfl_dev->irqs[i] = feature->irq_ctx[i].irq;
> +
> +		dfl_dev->num_irqs = feature->nr_irqs;
> +	}
> +
> +	dfl_dev->type = feature_dev_id_type(pdev);
> +	dfl_dev->feature_id = (unsigned long long)feature->id;
> +
> +	dfl_dev->dev.parent  = &pdev->dev;
> +	dfl_dev->dev.bus     = &dfl_bus_type;
> +	dfl_dev->dev.release = release_dfl_dev;
> +	dev_set_name(&dfl_dev->dev, "%s.%d", dev_name(&pdev->dev),
> +		     feature->index);
this can fail
> +
> +	dfl_dev->mmio_res.name = dev_name(&dfl_dev->dev);
> +	ret = insert_resource(dfl_dev->mmio_res.parent, &dfl_dev->mmio_res);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s failed to claim resource: %pR\n",
> +			dev_name(&dfl_dev->dev), &dfl_dev->mmio_res);
> +		goto free_irqs;
> +	}
> +
> +	ret = device_register(&dfl_dev->dev);
> +	if (ret) {
> +		put_device(&dfl_dev->dev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	dev_info(&pdev->dev, "add dfl_dev: %s\n",
> +		 dev_name(&dfl_dev->dev));
> +	return dfl_dev;
> +
> +free_irqs:
> +	kfree(dfl_dev->irqs);
> +free_dfl_dev:
> +	kfree(dfl_dev);
> +	return ERR_PTR(ret);
> +}
> +
> +static void dfl_devs_uinit(struct dfl_feature_platform_data *pdata)
> +{
> +	struct dfl_device *dfl_dev;
> +	struct dfl_feature *feature;
> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> +		if (!feature->ioaddr && feature->priv) {
> +			dfl_dev = feature->priv;
> +			device_unregister(&dfl_dev->dev);
> +			feature->priv = NULL;
> +		}
> +	}
> +}
> +
> +static int dfl_devs_init(struct platform_device *pdev)
> +{
> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct dfl_feature *feature;
> +	struct dfl_device *dfl_dev;
> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> +		if (feature->ioaddr || feature->priv)
> +			continue;
> +
> +		dfl_dev = dfl_dev_add(pdata, feature);
> +		if (IS_ERR(dfl_dev)) {
> +			dfl_devs_uinit(pdata);
> +			return PTR_ERR(dfl_dev);
What happens to dfl_dev's that were successful. Need a clean up ?
> +		}
> +
> +		feature->priv = dfl_dev;
> +	}
> +
> +	return 0;
> +}
> +
> +int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner)
> +{
> +	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
> +		return -EINVAL;
> +
> +	dfl_drv->drv.owner = owner;
> +	dfl_drv->drv.bus = &dfl_bus_type;
> +
> +	return driver_register(&dfl_drv->drv);
> +}
> +EXPORT_SYMBOL(__dfl_driver_register);
> +
> +void dfl_driver_unregister(struct dfl_driver *dfl_drv)
> +{
> +	driver_unregister(&dfl_drv->drv);
> +}
> +EXPORT_SYMBOL(dfl_driver_unregister);
> +
>  /**
>   * dfl_fpga_dev_feature_uinit - uinit for sub features of dfl feature device
>   * @pdev: feature device.
> @@ -264,12 +480,15 @@ void dfl_fpga_dev_feature_uinit(struct platform_device *pdev)
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	struct dfl_feature *feature;
>  
> -	dfl_fpga_dev_for_each_feature(pdata, feature)
> +	dfl_devs_uinit(pdata);
> +
> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
>  		if (feature->ops) {
>  			if (feature->ops->uinit)
>  				feature->ops->uinit(pdev, feature);
>  			feature->ops = NULL;
>  		}
> +	}
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_uinit);
>  
> @@ -348,6 +567,10 @@ int dfl_fpga_dev_feature_init(struct platform_device *pdev,
>  		drv++;
>  	}
>  
> +	ret = dfl_devs_init(pdev);
> +	if (ret)
> +		goto exit;
> +
>  	return 0;
>  exit:
>  	dfl_fpga_dev_feature_uinit(pdev);
> @@ -553,6 +776,8 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  		struct dfl_feature_irq_ctx *ctx;
>  		unsigned int i;
>  
> +		feature->index = index;
> +
>  		/* save resource information for each feature */
>  		feature->dev = fdev;
>  		feature->id = finfo->fid;
> @@ -1295,11 +1520,17 @@ static int __init dfl_fpga_init(void)
>  {
>  	int ret;
>  
> +	ret = bus_register(&dfl_bus_type);
> +	if (ret)
> +		return ret;
> +
>  	dfl_ids_init();
>  
>  	ret = dfl_chardev_init();
> -	if (ret)
> +	if (ret) {
>  		dfl_ids_destroy();
> +		bus_unregister(&dfl_bus_type);
> +	}
>  
>  	return ret;
>  }
> @@ -1637,6 +1868,7 @@ static void __exit dfl_fpga_exit(void)
>  {
>  	dfl_chardev_uinit();
>  	dfl_ids_destroy();
> +	bus_unregister(&dfl_bus_type);
>  }
>  
>  module_init(dfl_fpga_init);
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index f605c28..d00aa1c 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -229,6 +229,10 @@ struct dfl_feature_irq_ctx {
>   *
>   * @dev: ptr to pdev of the feature device which has the sub feature.
>   * @id: sub feature id.
> + * @index: unique identifier for an sub feature within the feature device.
> + *	   It is possible that multiply sub features with same feature id are
> + *	   listed in one feature device. So an incremental index (start from 0)
> + *	   is needed to identify each sub feature.
>   * @resource_index: each sub feature has one mmio resource for its registers.
>   *		    this index is used to find its mmio resource from the
>   *		    feature dev (platform device)'s reources.
> @@ -241,6 +245,7 @@ struct dfl_feature_irq_ctx {
>  struct dfl_feature {
>  	struct platform_device *dev;
>  	u64 id;
> +	int index;
>  	int resource_index;
>  	void __iomem *ioaddr;
>  	struct dfl_feature_irq_ctx *irq_ctx;
> @@ -515,4 +520,84 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
>  			       struct dfl_feature *feature,
>  			       unsigned long arg);
>  
> +/**
> + * enum dfl_id_type - define the DFL FIU types
> + */
> +enum dfl_id_type {
> +	FME_ID,
> +	PORT_ID,
> +	DFL_ID_MAX,
> +};
> +
> +/**
> + * struct dfl_device_id -  dfl device identifier
> + * @type: Type of DFL FIU of the device. See enum dfl_id_type.
> + * @feature_id: 64 bits feature identifier local to its DFL FIU type.
> + * @driver_data: Driver specific data
> + */
> +struct dfl_device_id {
> +	unsigned int type;
> +	unsigned long long feature_id;
> +	unsigned long driver_data;
> +};
> +
> +/**
> + * struct dfl_device - represent an dfl device on dfl bus
> + *
> + * @dev: Generic device interface.
> + * @type: Type of DFL FIU of the device. See enum dfl_id_type.
> + * @feature_id: 64 bits feature identifier local to its DFL FIU type.
> + * @mmio_res: MMIO resource of this dfl device.
> + * @irqs: List of Linux IRQ numbers of this dfl device.
> + * @num_irqs: number of IRQs supported by this dfl device.
> + * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
> + * @id_entry: matched id entry in dfl driver's id table.
> + */
> +struct dfl_device {
> +	struct device dev;
> +	unsigned int type;
> +	unsigned long long feature_id;
> +	struct resource mmio_res;
> +	int *irqs;
> +	unsigned int num_irqs;
> +	struct dfl_fpga_cdev *cdev;
> +	const struct dfl_device_id *id_entry;
> +};
> +
> +/**
> + * struct dfl_driver - represent an dfl device driver
> + *
> + * @drv: Driver model structure.
> + * @id_table: Pointer to table of device IDs the driver is interested in.
> + * @probe: Callback for device binding.
> + * @remove: Callback for device unbinding.
> + */
> +struct dfl_driver {
> +	struct device_driver drv;
> +	const struct dfl_device_id *id_table;
> +
> +	int (*probe)(struct dfl_device *dfl_dev);
> +	int (*remove)(struct dfl_device *dfl_dev);
> +};
> +
> +#define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
> +#define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
> +
> +/*
> + * use a macro to avoid include chaining to get THIS_MODULE
> + */
> +#define dfl_driver_register(drv) \
> +	__dfl_driver_register(drv, THIS_MODULE)
> +int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner);
> +void dfl_driver_unregister(struct dfl_driver *dfl_drv);
> +
> +/* module_dfl_driver() - Helper macro for drivers that don't do
> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces module_init() and module_exit()
> + */
> +#define module_dfl_driver(__dfl_driver) \
> +	module_driver(__dfl_driver, dfl_driver_register, \
> +		      dfl_driver_unregister)
> +
>  #endif /* __FPGA_DFL_H */

