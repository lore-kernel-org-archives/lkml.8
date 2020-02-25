Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0287CC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C8E21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbgBYPa2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:30:28 -0500
Received: from mail-oln040092255074.outbound.protection.outlook.com ([40.92.255.74]:6106
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728096AbgBYPa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:30:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKMtGrs0Kj3wT4POfO+7Om82H5wQTMVneqG1PYiCSli0NXzBgHAZktsPkdI7z1HcLNTeHi8hachQ752mwIiThl0x5i5H+w1XU4Bjd2024bcRTR03mUFJKUGBPFqK0pvmb+sN7mYPThTWo3tlzHK3kTpyBTjbpfgXvYkqXsC9ydyjCa/8wJBNkKAA2rxC5UHr+HT86eVNV3+6IsSePfwp2m0KpUzV0wmRBwpjiNYDto2kYPuyiBdlEIoihXriyjU6ggqoR8ptecWX8N96HBzwHwnXFKceGmrP7+sAvfqsvrxDhG/yAV/nuqpwftRKxc6ADFrWT2hFwL0KZuPIy445eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbetxyjj3mY3eKAovE3l5ROnTNVugCTFXPn5xFNMJOk=;
 b=DYTWmUT4h0uOPBF3DYUtYVFQMKIJcoc0hQnc+uJ1mqr4OVHNLNVFkn1HcwhxEvf8C17eFmkMiTKofTe5NB01s0EO7s/ufmcTIwRpxNmj4kn/jH5MUhKEv4jcSauxxM0GuGRweyF4CcVgj9Webi79OSKE0GtBE9KsP5D68LjJ+zLLWeG8lNuz/JF/tFSNM7EQrfeBKY8p+QfXMxe8uVEkCEb2dtin4zaaQj8j+CwCVZok4Ns7+1BzuTBae9p6ZRkpCsyjdvH9hRspZ1LOc4wDkXPy5j6y1MyMVVDkEXIQ+Jg3jD6zMbY9FAPBUu/P8Y6ZEdC4lCCk2Q3ZyNwG+p/JhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT047.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::33) by
 HK2APC01HT090.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::336)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Tue, 25 Feb
 2020 15:30:23 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.60) by
 HK2APC01FT047.mail.protection.outlook.com (10.152.249.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 15:30:23 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2772.012; Tue, 25 Feb 2020
 15:30:23 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by ME2PR01CA0021.ausprd01.prod.outlook.com (2603:10c6:201:15::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 15:30:21 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 1/3] nvmem: Add support for write-only instances
Thread-Topic: [PATCH v1 1/3] nvmem: Add support for write-only instances
Thread-Index: AQHV6znL/WLrUn36h0+sGzQwuak0Iqgr3jKAgAAsTQA=
Date:   Tue, 25 Feb 2020 15:30:22 +0000
Message-ID: <PSXP216MB0438D95E25CA8BA02A40735480ED0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB043899D4B8F693E1E5C3ECCE80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB043820B6E11AE4E78374C7F980EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200225125141.GA2667@lahna.fi.intel.com>
In-Reply-To: <20200225125141.GA2667@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0021.ausprd01.prod.outlook.com
 (2603:10c6:201:15::33) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:C59EFD6DB136B09213920D6013E19660BED763EA644BF16552A83CA3812C76ED;UpperCasedChecksum:F135F770F5956EA42747955C267099BEF0761A27CB55E73243A62DC4EA2FB614;SizeAsReceived:7970;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [AcXy1yn3LYMM0vKfJrJohyOLYw7FdiFDOaLliUuFKb1gdbARAGkdcbnITPCpRyom]
x-microsoft-original-message-id: <20200225153014.GB1740@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 97b02648-f0cb-4b05-3181-08d7ba07a0f7
x-ms-traffictypediagnostic: HK2APC01HT090:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c0fiF4FETjhSkkKr2r+AcQB0E1/gEz7kEDGZpybQXM63R+XhumgwhvwHVjTm548CJk25FMBaAcPvX5l2D0IxwZbjCNslfywp+vaxwI7aQVZtaUGDXC62HgRW9/cfjhSDD2CYLEcTgBStCQN9ZGQ2sMxDURd+Oira++GuuVhH1z3PMcRr9byiX+MddJ2qHY8r
x-ms-exchange-antispam-messagedata: e/h5bxTd2ZivIBon3eOzsRy2iYnhTtenG6+jRRhxgVUrv6bZcQQwQldBl++VRlJLUCSntyyaiHHYp+8oge2d9f7ynVgnHf37RHBKrP7eMdA2hOHNQRLn4Rj2FBRW/hORNbC2hLKGXFPryhXiFbULgOM3X5fin2zmjnaw+Dox2EXILURBMBD6y9AsaB7tyXySLMXHOggeXSAcWZ3+yO5AYg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BCAC11AC74B2D3429076FC483D4DA596@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b02648-f0cb-4b05-3181-08d7ba07a0f7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 15:30:23.0383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 02:51:41PM +0200, Mika Westerberg wrote:
> On Mon, Feb 24, 2020 at 05:42:33PM +0000, Nicholas Johnson wrote:
> > Mika Westerberg requires write-only nvmem for the Thunderbolt driver.
> > Refer to 03cd45d2e219 ("thunderbolt: Prevent crash if non-active NVMem
> > file is read"). Hence, there is at least one real-world use for
> > write-only nvmem instances.
> 
> Well, I don't require anything ;-) It is the thunderbolt driver that has
> one nvmem device that is write-only and it may take advantage of this.
Sorry, I will re-word it to be more accurate. I need to work on saying 
what I actually mean.

> 
> > Add support for write-only nvmem instances by changing the nvmem attrs
> > to 0222 if the .reg_read callback is not populated.
> > 
> > Add a WARN_ON in case a driver populates neither .reg_read nor
> > .reg_write because this behaviour should clearly never occur.
> > 
> > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > ---
> >  drivers/nvmem/nvmem-sysfs.c | 77 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 70 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
> > index 9e0c429cd..be3b94f0b 100644
> > --- a/drivers/nvmem/nvmem-sysfs.c
> > +++ b/drivers/nvmem/nvmem-sysfs.c
> > @@ -147,6 +147,30 @@ static const struct attribute_group *nvmem_ro_dev_groups[] = {
> >  	NULL,
> >  };
> >  
> > +/* write only permission */
> > +static struct bin_attribute bin_attr_wo_nvmem = {
> > +	.attr	= {
> > +		.name	= "nvmem",
> > +		.mode	= 0222,
> 
> I would say no sysfs attribute should ever be writable by the world.
I cannot think of an argument against this, nor can I rule out one 
existing. But I would be inclined to agree.

> 
> Actually I think maybe we make this one only writeable by root, in other
> words it would always require ->root_only to be set.
There is a world-accessible rw entry already, which would, if anything, 
be even more dangerous than a world writable entry. However, there could 
be a hypothetical use case. I agree it is unlikely to be required, but 
who knows?

Based on your statement that no sysfs should ever be world-writable, 
should I be trying to remove the world-accessible rw as well?
> 
> > +	},
> > +	.write	= bin_attr_nvmem_write,
> > +};
> > +
> > +static struct bin_attribute *nvmem_bin_wo_attributes[] = {
> > +	&bin_attr_wo_nvmem,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group nvmem_bin_wo_group = {
> > +	.bin_attrs	= nvmem_bin_wo_attributes,
> > +	.attrs		= nvmem_attrs,
> > +};
> > +
> > +static const struct attribute_group *nvmem_wo_dev_groups[] = {
> > +	&nvmem_bin_wo_group,
> > +	NULL,
> > +};
> > +
> >  /* default read/write permissions, root only */
> >  static struct bin_attribute bin_attr_rw_root_nvmem = {
> >  	.attr	= {
> > @@ -196,16 +220,50 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
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
> > -
> > -	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
> > +	/*
> > +	 * If neither reg_read nor reg_write are provided, we cannot use this
> > +	 * nvmem entry, as any operation will cause kernel mode NULL reference.
> > +	 */
> > +	WARN_ON(!nvmem->reg_read && !nvmem->reg_write);
> 
> This should also be documented in kernel-doc of struct nvmem_config.
Roger.

> 
> > +
> > +	if (nvmem->reg_read && nvmem->reg_write)
> > +		return config->root_only ?
> > +			nvmem_rw_root_dev_groups : nvmem_rw_dev_groups;
> > +
> > +	if (nvmem->reg_read && !nvmem->reg_write)
> > +		return config->root_only ?
> > +			nvmem_ro_root_dev_groups : nvmem_ro_dev_groups;
> > +
> > +	return config->root_only ?
> > +		nvmem_wo_root_dev_groups : nvmem_wo_dev_groups;
> >  }
> >  
> >  /*
> > @@ -224,11 +282,16 @@ int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
> >  	if (!config->base_dev)
> >  		return -EINVAL;
> >  
> > -	if (nvmem->read_only) {
> > +	if (nvmem->reg_read && !nvmem->reg_write) {
> >  		if (config->root_only)
> >  			nvmem->eeprom = bin_attr_ro_root_nvmem;
> >  		else
> >  			nvmem->eeprom = bin_attr_ro_nvmem;
> > +	} else if (!nvmem->reg_read && nvmem->reg_write) {
> > +		if (config->root_only)
> > +			nvmem->eeprom = bin_attr_wo_root_nvmem;
> > +		else
> > +			nvmem->eeprom = bin_attr_wo_nvmem;
> >  	} else {
> >  		if (config->root_only)
> >  			nvmem->eeprom = bin_attr_rw_root_nvmem;
> > -- 
> > 2.25.1
