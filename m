Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5181C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 03:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7813120719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 03:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgCXDZi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 23:25:38 -0400
Received: from mail-oln040092254033.outbound.protection.outlook.com ([40.92.254.33]:35680
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727050AbgCXDZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 23:25:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhInaXWYRcu3ctHlB+qMioQpxFTYoXqWdFzueGF4zmEJe/gMpTkgGw9WVsSPFkJ/ydMeNOC7FuYSFzOm76Qj9ARe2nNPaydSwp3aegcDEG5AhS762SnTL5IGlh3IonNBY9VPXC6cGpkieAXJ4ZFVbeqRM6V+uxafiUOt4OACPGn85laES5P74oFCVCJw97muqq+PaWrBvxR7VWpy4ERgzI0ZntgT8fEwoyt1F2ExYKdAf1rb/TvRx7/icfni48DLewfd8rdrZ+LFoCi27gkzuyJdinR1Nldk+rnOQkgcP8h4qjkhPq3hxYvjcHD6QqLYZshCbW2z14fvWMTqz+kWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cDLe9Givxo2puIVTH0ORjYMkyoucVj9WTRR1ZAljPc=;
 b=dsBx9DDzdUHwJanxFZldHoz0sE1TLMx6x5EgOVfBDseDaSmI6cRT9AwZqwJG5bf+nNEWoziJLUs4fYyRFV2db7mVdiMqG9Sr0dGvAfhj6RRILn+vvptEWlqopsxxJS9xMGrJj0b8zWEl2wpEIGy/iH2yt/5Dohyj7iSOl/3rBEB7MdiXsbD5qMj1r+0HBZbnhKmbx8hVra1xTPV4Y3wwNQz9CV3+HntzjE3TiX1VfPfQTyw/xpwPNTucd/MkXrQC9NPlc9r65CdMia4zCidqcFXK6zQk57L9qcd9oDlk8ITXVSpyLUp63nJrl3auPNP5Wk8sUjXChXQvqvbNAaQ+/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT050.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::37) by
 HK2APC01HT084.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::357)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Tue, 24 Mar
 2020 03:25:31 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.58) by
 HK2APC01FT050.mail.protection.outlook.com (10.152.249.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 24 Mar 2020 03:25:31 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::1ddc:43b7:a639:8184]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::1ddc:43b7:a639:8184%9]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 03:25:31 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by ME1PR01CA0085.ausprd01.prod.outlook.com (2603:10c6:200:18::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 03:25:28 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] nvmem: Add support for write-only instances
Thread-Topic: [PATCH 5/5] nvmem: Add support for write-only instances
Thread-Index: AQHWASPKeVmn6yF+NkittHqcSfj/BahWiaSAgACLxoA=
Date:   Tue, 24 Mar 2020 03:25:31 +0000
Message-ID: <PSXP216MB04388FD469630B8F353A375A80F10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
 <20200323150007.7487-6-srinivas.kandagatla@linaro.org>
 <20200323190505.GB632476@kroah.com>
In-Reply-To: <20200323190505.GB632476@kroah.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME1PR01CA0085.ausprd01.prod.outlook.com
 (2603:10c6:200:18::18) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:FB318DF5D39536E06C4977D4D61F2F92DC048C072E4F8C128C0E686CCDBC6F8E;UpperCasedChecksum:F7A20CA6EE79C7F6815DFD613629E151154D1A4E795A78D70CFB0702E751C7BE;SizeAsReceived:7859;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [DqyDVYlLDjSnYm8Zz/jO25A5jPoVC+vh1TVE3tqfNFMVVoIByppFKjnRDM82AqeH]
x-microsoft-original-message-id: <20200324032521.GA2062@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: ea1abfde-588d-42eb-2c0d-08d7cfa30140
x-ms-traffictypediagnostic: HK2APC01HT084:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qNFTQWZQTJO2VSxGIGXl4Uaure7eY48KCK+P/rRAw9TslSMIsEBs83SgRnW50NHLlvb2wkgVirSAgDfe+uMgPq1pldaBPL+289fQcZklph87Sk8hH5OghG0KT92/gosl7IlqdYOxx3rPz2rygiMpLypxjEgS9oN6alrBZlsIUsCHv0iDziq7ta0YntyQ8BUh
x-ms-exchange-antispam-messagedata: 7f4VUTLcvFk1bvGW52a4KKa/z2cBBxt+lRldaKKi1UDipP2FNEAJgUzDJGB6tf5rfer+6i2SKcg4LY2TFt0Gqb/UUqZ9LnggwKOZPYlShwT8hyfbEB5OePA8FojzYv0YS+DADKwKbiSVrMMpi+rPtBTnCfGvlQFculIYvOcxaTK0snOMxTMX6RsSuIIKReCNstpNcnflxRmeUFOxLsHIhA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1EAC5CD6D2177146A191C9A04F5F3A87@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1abfde-588d-42eb-2c0d-08d7cfa30140
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 03:25:31.7590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 08:05:05PM +0100, Greg KH wrote:
> On Mon, Mar 23, 2020 at 03:00:07PM +0000, Srinivas Kandagatla wrote:
> > From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > 
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
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >  drivers/nvmem/core.c        | 10 +++++--
> >  drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
> >  2 files changed, 56 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 77d890d3623d..ddc7be5149d5 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -381,6 +381,14 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> >  	nvmem->type = config->type;
> >  	nvmem->reg_read = config->reg_read;
> >  	nvmem->reg_write = config->reg_write;
> > +	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> > +	if (!nvmem->dev.groups) {
> > +		ida_simple_remove(&nvmem_ida, nvmem->id);
> > +		gpiod_put(nvmem->wp_gpio);
> > +		kfree(nvmem);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> >  	if (!config->no_of_node)
> >  		nvmem->dev.of_node = config->dev->of_node;
> >  
> > @@ -395,8 +403,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> >  	nvmem->read_only = device_property_present(config->dev, "read-only") ||
> >  			   config->read_only || !nvmem->reg_write;
> >  
> > -	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> > -
> >  	device_initialize(&nvmem->dev);
> >  
> >  	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> > diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
> > index 8759c4470012..9728da948988 100644
> > --- a/drivers/nvmem/nvmem-sysfs.c
> > +++ b/drivers/nvmem/nvmem-sysfs.c
> > @@ -202,16 +202,49 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
> >  	NULL,
> >  };
> >  
> > +/* write only permission, root only */
> > +static struct bin_attribute bin_attr_wo_root_nvmem = {
> > +	.attr	= {
> > +		.name	= "nvmem",
> > +		.mode	= 0200,
> > +	},
> > +	.write	= bin_attr_nvmem_write,
> > +};
> 
> You are adding a new sysfs file without a Documentation/ABI/ new entry
> as well?
It is the same existing sysfs file, but adding the ability for that 
existing sysfs file to have write-only (0200) permissions if the driver 
requires it. The perms / groups for the nvmem that is getting registered 
in nvmem_register() in drivers/nvmem/core.c are chosen by 
nvmem_sysfs_get_groups() in drivers/nvmem/nvmem-sysfs.c, and this new 
0200 will get selected if reg_read is NULL and reg_write is provided 
(and nvmem->read_only override is not set).

> 
> 
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
> >  const struct attribute_group **nvmem_sysfs_get_groups(
> >  					struct nvmem_device *nvmem,
> >  					const struct nvmem_config *config)
> >  {
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
> 
> 
> What is this supposed to be doing, I am totally lost.
This nvmem_sysfs_get_groups() is called by nvmem_register() when the 
nvmem is registered by a driver. This returns the filesystem perms for 
the nvmem based on the inputs (or NULL to abort). There are four things 
we care about in the function arguments:

1. nvmem->reg_read which is a function pointer used when reading from 
the nvmem

2. nvmem->reg_write which is a function pointer used when writing to the 
nvmem

3. nvmem->read_only which overrides if nvmem is read only

4. config->root_only which indicates if world perms are used

We use these to decide which perms to return. We can determine whether 
read-only or write-only or read-write by whether the reg_read and 
reg_write are provided, using nvmem->read_only as an override (sometimes 
from dtb, both reg_read and reg_write are provided but it can override 
to read only with this flag).

Once that is decided, we use config->root_only to determine if 
world-accessible. We return the appropriate group, or NULL if 
world-writable requested.

Before this patch, we could not return NULL (always had to return a 
group, no matter what). This had to be fixed, hence the changes to the 
caller (nvmem_register() function in drivers/nvmem/core.c) to check for 
NULL group and abort. Before this patch, any (unsupported) request for 
write-only was interpreted as read-write, instead of returning an error 
and failing cleanly. As of this patch, the above 0200 which I am 
introducing is returned.

Please let me know if I have failed to clarify this for you and I will 
try again. :)
> 
> greg k-h

Kind regards,
Nicholas Johnson
