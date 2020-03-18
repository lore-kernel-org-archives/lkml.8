Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5391C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593602076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgCRMmM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:42:12 -0400
Received: from mail-oln040092255105.outbound.protection.outlook.com ([40.92.255.105]:3217
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726722AbgCRMmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:42:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdjDWkRIu3oUKSXHbqCHxcVEh05teIuGD+fu3OY2gBEtz0R8kNRvYo5oq++vQFfgVfE2PUkomLnmQKgn73d/mjBkWbNbDzRwhSrWKMs0ed3wJjcL/LfYsLozrRvjPZ8JhkFDM5yspC5bxUkhlY8/32gV8RmMqvaolVFJOab2g8EmsuPLhDDCry/M9vMagetEGWWW6TqGph66aX/yd+e+SxOB+q0DiqIHAYV2LkvCbg6oK4W+A5+JizuwwTEaekec2FU+EYMrr5ZswhDqtrFBIveoxG5gAQENWsmDpyjRTeYz+iqDU7g9UxJ8xkn7Znm+0qcfFH4BoiPp4/WyhpYnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx2Ifmv9cYSI9ltgTSscbQQH/9Z5WCq5vB+ZFx9cCFc=;
 b=RcSlSmA41dm+8x3JWP4ZrsbwJunti504pqH/p72OKwZEAnToUmTK66EoDZ/CWCyQYpJYPgOUWUuslasBV6nurmlAb6sZwBsosP+4r+icvULHvPz+U8VV6ddC0hnQixAT7Wsc3Er10f0jNETL8FvMR2H/aMdPjK5BUyf8uO50iO2MymIEwGK1jZ3Gz1x5Ma80teDExARO+bMLdZYMuY8GKWuYRBVyn3xrKVJgxDD5ur0EKfLGZMOfPrCptw5OUdOYI0kKzBw2HGIvHy82bP/1DlTD8RvTZV3eNE2uk06Bm4IlBIFEBLJRRP2QOH/AC1VsMw+CT4K8vxKIdpc2iBLl/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT015.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::3c) by
 SG2APC01HT194.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::434)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Wed, 18 Mar
 2020 12:42:05 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.56) by
 SG2APC01FT015.mail.protection.outlook.com (10.152.250.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Wed, 18 Mar 2020 12:42:05 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 12:42:05 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by ME2PR01CA0201.ausprd01.prod.outlook.com (2603:10c6:220:34::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.17 via Frontend Transport; Wed, 18 Mar 2020 12:42:03 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 1/1] nvmem: Add support for write-only instances
Thread-Topic: [PATCH v4 1/1] nvmem: Add support for write-only instances
Thread-Index: AQHV+/eT1ILhhjOOiEKwHZ5sJhGkRqhM2r8AgAE5dgCAAAMqgIAANeqA
Date:   Wed, 18 Mar 2020 12:42:05 +0000
Message-ID: <PSXP216MB0438E1317C0B99EAE7AB13A180F70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438A934627303A4A0E2D96280F60@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <74d0c4a6-a056-ad45-529e-97b117d4e60b@linaro.org>
 <PSXP216MB0438983CAE5B3086B562BFBA80F70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <f31c6774-198a-32e4-6818-e13d5ff16c85@linaro.org>
In-Reply-To: <f31c6774-198a-32e4-6818-e13d5ff16c85@linaro.org>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0201.ausprd01.prod.outlook.com
 (2603:10c6:220:34::21) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:C24857D7350F1F7FAD36A107812984D40986530C3A794C60DCBB571A1CD4B736;UpperCasedChecksum:4F17FADE4F5BFF9F19C5BFB137F63796898DC24F31390A3DB1DDDE7576653520;SizeAsReceived:8034;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [fEU/2icc9c4N6azdwfDveKtVUqibOiwe/0tDPFooKnMSl7cflcojtzT9wTZhO1OB]
x-microsoft-original-message-id: <20200318124157.GA3894@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 79b6396c-aa65-46e7-1f4c-08d7cb39c32f
x-ms-traffictypediagnostic: SG2APC01HT194:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9+wxldc5BM2hrAswBpp9s7pXWtdn/s1Y19evyypZdGfdQ1ZtEVpOKa6ZRcE1WFbbHC4U+dLgORk/RndkqPX4fdtoBC3F3FHbiWcvmr8KDeagZ3ngrqqpibYjJ6UPIfsDkGhbn5QJTS8927T2Ho3OkNU+6okN3U0S8nthnyU6/mOJcYmbPoGsOUcFTYVtkstQRi3eqUsM6ySqCFwMNPrYIP7H3vp4g9czb5YPZncNsVs=
x-ms-exchange-antispam-messagedata: JiPqvNSn58y6jO+8GZjIIJg2REZsF38myOsZ+9f2CeIAmvyB2QmTaX556SwcVHC7clcKmy48LvVPdQ8QAiy6lriJcp5UqQbSUd4gcMN/9hCNgSeCW8QLzwgM8A5eWyS2tYtegTMA2FRJxtOuO2jK8zqcdRQDR/jCkvC+ihRLlRXp2Fu/JS/O8MiWzyJhgpzeAxv2qDiGYlKBl1B62JSRcw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D9E34256295DAB4EAA226CF7845C2FA4@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b6396c-aa65-46e7-1f4c-08d7cb39c32f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 12:42:05.4849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 09:28:59AM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 18/03/2020 09:17, Nicholas Johnson wrote:
> > On Tue, Mar 17, 2020 at 02:35:44PM +0000, Srinivas Kandagatla wrote:
> > > 
> > > 
> > > On 17/03/2020 01:01, Nicholas Johnson wrote:
> > > > There is at least one real-world use-case for write-only nvmem
> > > > instances. Refer to 03cd45d2e219 ("thunderbolt: Prevent crash if
> > > > non-active NVMem file is read").
> > > > 
> > > > Add support for write-only nvmem instances by adding attrs for 0200.
> > > > 
> > > > Change nvmem_register() to abort if NULL group is returned from
> > > > nvmem_sysfs_get_groups().
> > > > 
> > > > Return NULL from nvmem_sysfs_get_groups() in invalid cases.
> > > > 
> > > > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > > > ---
> > > >    drivers/nvmem/core.c        |  9 ++++--
> > > >    drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
> > > >    2 files changed, 54 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > > > index ef326f243..95ea9a3b2 100644
> > > > --- a/drivers/nvmem/core.c
> > > > +++ b/drivers/nvmem/core.c
> > > > @@ -373,6 +373,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> > > >    	nvmem->type = config->type;
> > > >    	nvmem->reg_read = config->reg_read;
> > > >    	nvmem->reg_write = config->reg_write;
> > > > +	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> > > > +	if (!nvmem->dev.groups) {
> > > > +		kfree(nvmem);
> > > > +		return ERR_PTR(-EINVAL);
> > > 
> > > When I meant leaking here, not just memory but other resources like idr and
> > > gpio.
> > > 
> > > You should do something like this:
> > > 
> > > if (!nvmem->dev.groups) {
> > > 	ida_simple_remove(&nvmem_ida, nvmem->id);
> > > 	gpiod_put(nvmem->wp_gpio);
> > > 	kfree(nvmem);
> > > 	return ERR_PTR(-EINVAL);
> > > }
> > Thanks. I am guessing these are called indirectly when there are other
> > failures (goto err_*). We have ida_simple_remove() in nvmem_release()
> > but I cannot find gpiod_put anywhere in drivers/nvmem.
> Because you are returning here before device intialize, you would need to do
> the cleanup.
Disregard, I just noticed this issue has been fixed in 8daa31303194 
"nvmem: release the write-protect pin".

However, I found that we leak memory if returning after doing 
dev_set_name(). I worked around it by returning before it is even done. 
But for future reference, how would one free the name?
> 
> Latest changes are available in linux-next or
> https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/tree/drivers/nvmem/core.c?h=for-next
> 
> 
> Please rebase your patches on top of this branch, so its easy for me to
> apply without conflicts.
Done; there were no conflicts, anyway. Sending soon.

> 
> --srini
> > 
> > > 
> > > > +	}
> > > > +
> > > >    	if (!config->no_of_node)
> > > >    		nvmem->dev.of_node = config->dev->of_node;
> > > > @@ -387,8 +393,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> > > >    	nvmem->read_only = device_property_present(config->dev, "read-only") ||
> > > >    			   config->read_only || !nvmem->reg_write;
> > > > -	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> > > > -
> > > >    	device_initialize(&nvmem->dev);
> > > >    	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> > > > @@ -430,7 +434,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> > > >    	device_del(&nvmem->dev);
> > > >    err_put_device:
> > > >    	put_device(&nvmem->dev);
> > > > -
> > > unnecessary cleanup here!
> > Sorry, I let this mistake slip, despite checking my work.
> > 
> > > 
> > > Other than that every thing looks good to me!
> > > 
> > > 
> > > --srini
> > 
> > Cheers,
> > Nicholas
> > > 
> > > >    	return ERR_PTR(rval);
> > > >    }
> > > >    EXPORT_SYMBOL_GPL(nvmem_register);
> > > > diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
> > > > index 9e0c429cd..4ceac8680 100644
> > > > --- a/drivers/nvmem/nvmem-sysfs.c
> > > > +++ b/drivers/nvmem/nvmem-sysfs.c
> > > > @@ -196,16 +196,49 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
> > > >    	NULL,
> > > >    };
> > > > +/* write only permission, root only */
> > > > +static struct bin_attribute bin_attr_wo_root_nvmem = {
> > > > +	.attr	= {
> > > > +		.name	= "nvmem",
> > > > +		.mode	= 0200,
> > > > +	},
> > > > +	.write	= bin_attr_nvmem_write,
> > > > +};
> > > > +
> > > > +static struct bin_attribute *nvmem_bin_wo_root_attributes[] = {
> > > > +	&bin_attr_wo_root_nvmem,
> > > > +	NULL,
> > > > +};
> > > > +
> > > > +static const struct attribute_group nvmem_bin_wo_root_group = {
> > > > +	.bin_attrs	= nvmem_bin_wo_root_attributes,
> > > > +	.attrs		= nvmem_attrs,
> > > > +};
> > > > +
> > > > +static const struct attribute_group *nvmem_wo_root_dev_groups[] = {
> > > > +	&nvmem_bin_wo_root_group,
> > > > +	NULL,
> > > > +};
> > > > +
> > > >    const struct attribute_group **nvmem_sysfs_get_groups(
> > > >    					struct nvmem_device *nvmem,
> > > >    					const struct nvmem_config *config)
> > > >    {
> > > > -	if (config->root_only)
> > > > -		return nvmem->read_only ?
> > > > -			nvmem_ro_root_dev_groups :
> > > > -			nvmem_rw_root_dev_groups;
> > > > +	/* Read-only */
> > > > +	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only))
> > > > +		return config->root_only ?
> > > > +			nvmem_ro_root_dev_groups : nvmem_ro_dev_groups;
> > > > +
> > > > +	/* Read-write */
> > > > +	if (nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
> > > > +		return config->root_only ?
> > > > +			nvmem_rw_root_dev_groups : nvmem_rw_dev_groups;
> > > > +
> > > > +	/* Write-only, do not honour request for global writable entry */
> > > > +	if (!nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
> > > > +		return config->root_only ? nvmem_wo_root_dev_groups : NULL;
> > > > -	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
> > > > +	return NULL;
> > > >    }
> > > >    /*
> > > > @@ -224,17 +257,24 @@ int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
> > > >    	if (!config->base_dev)
> > > >    		return -EINVAL;
> > > > -	if (nvmem->read_only) {
> > > > +	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only)) {
> > > >    		if (config->root_only)
> > > >    			nvmem->eeprom = bin_attr_ro_root_nvmem;
> > > >    		else
> > > >    			nvmem->eeprom = bin_attr_ro_nvmem;
> > > > -	} else {
> > > > +	} else if (!nvmem->reg_read && nvmem->reg_write && !nvmem->read_only) {
> > > > +		if (config->root_only)
> > > > +			nvmem->eeprom = bin_attr_wo_root_nvmem;
> > > > +		else
> > > > +			return -EINVAL;
> > > > +	} else if (nvmem->reg_read && nvmem->reg_write && !nvmem->read_only) {
> > > >    		if (config->root_only)
> > > >    			nvmem->eeprom = bin_attr_rw_root_nvmem;
> > > >    		else
> > > >    			nvmem->eeprom = bin_attr_rw_nvmem;
> > > > -	}
> > > > +	} else
> > > > +		return -EINVAL;
> > > > +
> > > >    	nvmem->eeprom.attr.name = "eeprom";
> > > >    	nvmem->eeprom.size = nvmem->size;
> > > >    #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > > 
