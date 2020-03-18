Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D822C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87EA2076F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgCRJR4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:17:56 -0400
Received: from mail-oln040092254066.outbound.protection.outlook.com ([40.92.254.66]:60454
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbgCRJR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:17:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMQOQakdgbTh959suQf4vGzi68ZQN5H/P2LfhaRi2qrWIyyKQ/onyKwl9aime3jbqHVGpUWCg89tHQaGiDppKju9op8hwouJDkzNSGVw4x/jbHJzf+oxGLKnULYXi4PbZurTCf0bdnz8CfQTg89DHKt1mdLW747SUE7HX3NF+Ln/jADyuL+gl3UBdbIY0Mp6HR5XSb6U2tp6F9KSrFdOB37UtlAHXfs2Hp03EdIDHtIXHWb74xDyAoDDOIXYyW9VMCNyt8LIFS5ITK7Am9lQ5RCsrJ93grYmjeTbEPl5kFW4J8Xedhtvid6aXYMqSikILq/kyzPV5S38UP6oKjIW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxYoyyRXldqf6vugSGZwJn2RORYJyxK/TFA3sDsotD8=;
 b=RpMimY0Dl1c0irRALlx3SggPsh7ZeOFf29dxqI0MHLvkvAs9L2sba8iZjxDmLKeu4tE18irT8Zz+cpP/KOrOc2CBCiqfJFuGYBnIy+0lgFuUAkxUvKDFL7HjrC/ipPtyV9k2aMwXVBo+GDlLrWL47QkPIIxhM3QimSSmpBv0xTgwlDG9cxFvpUHPj4vlF3xLIBFAPrsS1KSkToL62hQRBfXxsH4CbJNKhjLDX9aH/5yNetKz82cPBotJjNkz9FBlepP+fTbqHHBxZy6nklujSkR68lmEfnRZueEpKjteMfHnjXi0wkV/6xzxyCXtrBQoZeJSXlSCNyRcUXIKaXHUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT015.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::38) by
 HK2APC01HT005.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::90)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Wed, 18 Mar
 2020 09:17:49 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.59) by
 HK2APC01FT015.mail.protection.outlook.com (10.152.248.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Wed, 18 Mar 2020 09:17:49 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 09:17:49 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by ME2PR01CA0060.ausprd01.prod.outlook.com (2603:10c6:201:2b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.17 via Frontend Transport; Wed, 18 Mar 2020 09:17:47 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 1/1] nvmem: Add support for write-only instances
Thread-Topic: [PATCH v4 1/1] nvmem: Add support for write-only instances
Thread-Index: AQHV+/eT1ILhhjOOiEKwHZ5sJhGkRqhM2r8AgAE5dgA=
Date:   Wed, 18 Mar 2020 09:17:48 +0000
Message-ID: <PSXP216MB0438983CAE5B3086B562BFBA80F70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438A934627303A4A0E2D96280F60@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <74d0c4a6-a056-ad45-529e-97b117d4e60b@linaro.org>
In-Reply-To: <74d0c4a6-a056-ad45-529e-97b117d4e60b@linaro.org>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0060.ausprd01.prod.outlook.com
 (2603:10c6:201:2b::24) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:067923ADE26BF5831D02F48BA7E7ADAAB497DE2DEB1EB39BA886C19CD3CD7773;UpperCasedChecksum:4AD84A3DA129512CEB21033D9D5653C5970C8FF195C5F42750826B9323646217;SizeAsReceived:7877;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [iQ0zf9gnwg8gRo3wInaCFMIxAqKYQkGC9py6bUtheN67qTt+Nrwrr4M2vEqBl+aq]
x-microsoft-original-message-id: <20200318091740.GA2023@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 21e55a78-bc03-4fa4-7d2b-08d7cb1d39e3
x-ms-traffictypediagnostic: HK2APC01HT005:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JjdtdSE/ku1NL28+Oh45Sr9aSoo5Qr815ljng/7uBLaqwgSmtMbrh/5JVgPeJtJ634hkgUdlPWyFSCmdOnxA5POKOL8ofDehm47ovJ9h9RPWrvxu0X29EK163TPbdb2g+0hBCqkZNv8L26kPr14Cmkeyl8IeHNl2e48OxzniSToUkrA6dGB5dVBAbtAZ/JsD
x-ms-exchange-antispam-messagedata: 7tnJqGgDyxjloOKFj3XKdn8RxxB/E8DsZJkMpTZZT0gMGvEyFB5t0XliNdZtXdSbWqAtEykVsuhx6HwIjZWmBXpcreoGo51u+0RNBviAr1bElEfRokIC5cs0UGrBIqNnC+9ukmfGw4kBNaQkp/477/Xlhyn1bgwyY1d/JcWYAYsgSx8qTBeX7qk8+3aEh44CVafdXzWvpgGStvGY2skOFw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8248EA9B432A2B48AB2AC9CE60209203@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e55a78-bc03-4fa4-7d2b-08d7cb1d39e3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 09:17:49.0510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 02:35:44PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 17/03/2020 01:01, Nicholas Johnson wrote:
> > There is at least one real-world use-case for write-only nvmem
> > instances. Refer to 03cd45d2e219 ("thunderbolt: Prevent crash if
> > non-active NVMem file is read").
> > 
> > Add support for write-only nvmem instances by adding attrs for 0200.
> > 
> > Change nvmem_register() to abort if NULL group is returned from
> > nvmem_sysfs_get_groups().
> > 
> > Return NULL from nvmem_sysfs_get_groups() in invalid cases.
> > 
> > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > ---
> >   drivers/nvmem/core.c        |  9 ++++--
> >   drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
> >   2 files changed, 54 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index ef326f243..95ea9a3b2 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -373,6 +373,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> >   	nvmem->type = config->type;
> >   	nvmem->reg_read = config->reg_read;
> >   	nvmem->reg_write = config->reg_write;
> > +	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> > +	if (!nvmem->dev.groups) {
> > +		kfree(nvmem);
> > +		return ERR_PTR(-EINVAL);
> 
> When I meant leaking here, not just memory but other resources like idr and
> gpio.
> 
> You should do something like this:
> 
> if (!nvmem->dev.groups) {
> 	ida_simple_remove(&nvmem_ida, nvmem->id);
> 	gpiod_put(nvmem->wp_gpio);
> 	kfree(nvmem);
> 	return ERR_PTR(-EINVAL);
> }
Thanks. I am guessing these are called indirectly when there are other 
failures (goto err_*). We have ida_simple_remove() in nvmem_release() 
but I cannot find gpiod_put anywhere in drivers/nvmem.

> 
> > +	}
> > +
> >   	if (!config->no_of_node)
> >   		nvmem->dev.of_node = config->dev->of_node;
> > @@ -387,8 +393,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> >   	nvmem->read_only = device_property_present(config->dev, "read-only") ||
> >   			   config->read_only || !nvmem->reg_write;
> > -	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> > -
> >   	device_initialize(&nvmem->dev);
> >   	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> > @@ -430,7 +434,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> >   	device_del(&nvmem->dev);
> >   err_put_device:
> >   	put_device(&nvmem->dev);
> > -
> unnecessary cleanup here!
Sorry, I let this mistake slip, despite checking my work.

> 
> Other than that every thing looks good to me!
> 
> 
> --srini

Cheers,
Nicholas
> 
> >   	return ERR_PTR(rval);
> >   }
> >   EXPORT_SYMBOL_GPL(nvmem_register);
> > diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
> > index 9e0c429cd..4ceac8680 100644
> > --- a/drivers/nvmem/nvmem-sysfs.c
> > +++ b/drivers/nvmem/nvmem-sysfs.c
> > @@ -196,16 +196,49 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
> >   	NULL,
> >   };
> > +/* write only permission, root only */
> > +static struct bin_attribute bin_attr_wo_root_nvmem = {
> > +	.attr	= {
> > +		.name	= "nvmem",
> > +		.mode	= 0200,
> > +	},
> > +	.write	= bin_attr_nvmem_write,
> > +};
> > +
> > +static struct bin_attribute *nvmem_bin_wo_root_attributes[] = {
> > +	&bin_attr_wo_root_nvmem,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group nvmem_bin_wo_root_group = {
> > +	.bin_attrs	= nvmem_bin_wo_root_attributes,
> > +	.attrs		= nvmem_attrs,
> > +};
> > +
> > +static const struct attribute_group *nvmem_wo_root_dev_groups[] = {
> > +	&nvmem_bin_wo_root_group,
> > +	NULL,
> > +};
> > +
> >   const struct attribute_group **nvmem_sysfs_get_groups(
> >   					struct nvmem_device *nvmem,
> >   					const struct nvmem_config *config)
> >   {
> > -	if (config->root_only)
> > -		return nvmem->read_only ?
> > -			nvmem_ro_root_dev_groups :
> > -			nvmem_rw_root_dev_groups;
> > +	/* Read-only */
> > +	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only))
> > +		return config->root_only ?
> > +			nvmem_ro_root_dev_groups : nvmem_ro_dev_groups;
> > +
> > +	/* Read-write */
> > +	if (nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
> > +		return config->root_only ?
> > +			nvmem_rw_root_dev_groups : nvmem_rw_dev_groups;
> > +
> > +	/* Write-only, do not honour request for global writable entry */
> > +	if (!nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
> > +		return config->root_only ? nvmem_wo_root_dev_groups : NULL;
> > -	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
> > +	return NULL;
> >   }
> >   /*
> > @@ -224,17 +257,24 @@ int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
> >   	if (!config->base_dev)
> >   		return -EINVAL;
> > -	if (nvmem->read_only) {
> > +	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only)) {
> >   		if (config->root_only)
> >   			nvmem->eeprom = bin_attr_ro_root_nvmem;
> >   		else
> >   			nvmem->eeprom = bin_attr_ro_nvmem;
> > -	} else {
> > +	} else if (!nvmem->reg_read && nvmem->reg_write && !nvmem->read_only) {
> > +		if (config->root_only)
> > +			nvmem->eeprom = bin_attr_wo_root_nvmem;
> > +		else
> > +			return -EINVAL;
> > +	} else if (nvmem->reg_read && nvmem->reg_write && !nvmem->read_only) {
> >   		if (config->root_only)
> >   			nvmem->eeprom = bin_attr_rw_root_nvmem;
> >   		else
> >   			nvmem->eeprom = bin_attr_rw_nvmem;
> > -	}
> > +	} else
> > +		return -EINVAL;
> > +
> >   	nvmem->eeprom.attr.name = "eeprom";
> >   	nvmem->eeprom.size = nvmem->size;
> >   #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > 
