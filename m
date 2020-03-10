Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E8CC10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04EA24649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgCJCpN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:45:13 -0400
Received: from mail-oln040092253018.outbound.protection.outlook.com ([40.92.253.18]:18016
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbgCJCpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 22:45:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNz0IplQQIk7FaRvA8DCVJ40/qIy1OuxeHFFA6coG2W7EKucbwI0OPY4mtU5tkKXo5j47tENFGqdmK9HwGY0YGoNAdo14Tk9+1xVHc3ZcWkzhNBnAY+1CFMgzIkAQkrxclfg15U885YiviXa3c6lRqFR5fx7DnsHXS1QrH5XAndekI/M6dpoO/Dras99knhkGTdI+Yda+fUXr2U6uWdXFPbrsyB54pyZQ9ggbi407CdDyWIytX0sR1XwvWdkkakLcSUCTPzcKSJGmuMlySqrN/nKLtIfozgVC4nb1FEVp0DMZyurQl9hM68jo+bQ2ba4GLhhH+SygNKgLDUwodE9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au1IQESq49iNmCCOkt4Qrb7HWUsfHZEM2+28XUXYKdw=;
 b=V3NerVOkJvu8deQpIEjL72/AeOmrUUCh86glRvdXzFtlfX98HwV/dhtDmnjbNsP+8rbc0erBzlormsnehOCxgmHwcv6f9lbf4cUOCU7wilNWVYHCkPlCErE6mSH3rX865wJuUJGd/slPE711N5u/izqayYcnOT8b/6CfpquUOGpOt1P3CLkzwwcwS2z/av9F7lIf4KyktHJJ5x+e/s9MkDo/DD1vWeSIgbzG5OxMeS+d9jyxnf5Dq3aXir9P56MUsOR1w3dyEJwem3lhVgSPWdQl4QS+KGidTyXF4SEGRyqSzyt7rwOC3qyOQf1huywJVIPBoweiUbv3vbX2KYnuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT023.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::37) by
 PU1APC01HT069.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::303)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11; Tue, 10 Mar
 2020 02:45:07 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.52) by
 PU1APC01FT023.mail.protection.outlook.com (10.152.253.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Tue, 10 Mar 2020 02:45:07 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 02:45:07 +0000
Received: from nicholas-dell-linux (49.196.154.16) by MEXPR01CA0119.ausprd01.prod.outlook.com (2603:10c6:200:2c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend Transport; Tue, 10 Mar 2020 02:45:05 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 2/2] nvmem: Add support for write-only instances
Thread-Topic: [PATCH v3 2/2] nvmem: Add support for write-only instances
Thread-Index: AQHV9jsxJuscDJGSJEm8fhjJto18yKhBH08A
Date:   Tue, 10 Mar 2020 02:45:07 +0000
Message-ID: <PSXP216MB043852487CF7522F5A1AE1D180FF0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438614877E3559E155F12AF80FE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB0438EF52E2F4E58264ADBB8A80FE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0438EF52E2F4E58264ADBB8A80FE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEXPR01CA0119.ausprd01.prod.outlook.com
 (2603:10c6:200:2c::28) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:2342CF532B5E65145EA60A32EE304CBFA9F61C330F094FE5A2869971293F6138;UpperCasedChecksum:5EF0A4DEBCF0910AF8072C940AFD04A16150AFB1306CA4B2672637A13EB12E92;SizeAsReceived:7821;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [7OuH9acCp0lBfOMegsx95FglAhseuPDF]
x-microsoft-original-message-id: <20200310024458.GA1927@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: b20c7109-ddef-4b7c-e92a-08d7c49d0ac2
x-ms-traffictypediagnostic: PU1APC01HT069:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G3Qna3eCu5umNfcNB6CWBmjfK87oRDv0Qab/TjnLBbyPARGIFV/G1cMeFHbtxcpNTBaFv5AvFd1xS6W7ICvxQMHwQgfjJIFACmJLwz+fiZXjpYZg7TgXiZSrp6udNConqrm+pvdNgLaIIGJLCSbGeQVD85z1ZGiEkoOqB4HafcktbjTYwftaSn1Ry+544QbC
x-ms-exchange-antispam-messagedata: NaIT8Nub5bUiOiDjkLLU4vIhNDJNKva02r4dg98k1XAEI+XM5u5VQKR8pKMQG0J3/A3QexuApf1Lfuy918KcEYosBVe/v18+TWHOFNJhI7Xg//YQ9TYdxvfr63AwP1DVHui3Y7IFrtwX1cKkIqA3iQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92D4BA7F2A48344486BBFEE7A681F364@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b20c7109-ddef-4b7c-e92a-08d7c49d0ac2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 02:45:07.3306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 05:50:17PM +0000, Nicholas Johnson wrote:
> There is at least one real-world use-case for write-only nvmem
> instances. Refer to 03cd45d2e219 ("thunderbolt: Prevent crash if
> non-active NVMem file is read").
> 
> Add support for write-only nvmem instances by adding attrs for 0200.
> 
> Change nvmem_register() to abort if NULL group is returned from
> nvmem_sysfs_get_groups().
Sorry, this is the comment to remove which only applies to patch 1/2.
Disregard the past message. I will try to get more sleep.

> 
> Return NULL from nvmem_sysfs_get_groups() in invalid cases.
Keep this one.

Cheers

> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---
>  drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
>  1 file changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
> index 9e0c429cd..846112786 100644
> --- a/drivers/nvmem/nvmem-sysfs.c
> +++ b/drivers/nvmem/nvmem-sysfs.c
> @@ -196,16 +196,49 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
>  	NULL,
>  };
>  
> +/* write only permission, root only */
> +static struct bin_attribute bin_attr_wo_root_nvmem = {
> +	.attr	= {
> +		.name	= "nvmem",
> +		.mode	= 0200,
> +	},
> +	.write	= bin_attr_nvmem_write,
> +};
> +
> +static struct bin_attribute *nvmem_bin_wo_root_attributes[] = {
> +	&bin_attr_wo_root_nvmem,
> +	NULL,
> +};
> +
> +static const struct attribute_group nvmem_bin_wo_root_group = {
> +	.bin_attrs	= nvmem_bin_wo_root_attributes,
> +	.attrs		= nvmem_attrs,
> +};
> +
> +static const struct attribute_group *nvmem_wo_root_dev_groups[] = {
> +	&nvmem_bin_wo_root_group,
> +	NULL,
> +};
> +
>  const struct attribute_group **nvmem_sysfs_get_groups(
>  					struct nvmem_device *nvmem,
>  					const struct nvmem_config *config)
>  {
> -	if (config->root_only)
> -		return nvmem->read_only ?
> -			nvmem_ro_root_dev_groups :
> -			nvmem_rw_root_dev_groups;
> +	/* Read-only */
> +	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only))
> +		return config->root_only ?
> +			nvmem_ro_root_dev_groups : nvmem_ro_dev_groups;
> +
> +	/* Read-write */
> +	if (nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
> +		return config->root_only ?
> +			nvmem_rw_root_dev_groups : nvmem_rw_dev_groups;
>  
> -	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
> +	/* Write-only, do not honour request for global writable entry */
> +	if (!nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
> +		return config->root_only ? nvmem_wo_root_dev_groups : NULL;
> +
> +	return NULL;
>  }
>  
>  /*
> @@ -224,17 +257,24 @@ int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
>  	if (!config->base_dev)
>  		return -EINVAL;
>  
> -	if (nvmem->read_only) {
> +	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only)) {
>  		if (config->root_only)
>  			nvmem->eeprom = bin_attr_ro_root_nvmem;
>  		else
>  			nvmem->eeprom = bin_attr_ro_nvmem;
> -	} else {
> +	} else if (!nvmem->reg_read && nvmem->reg_write && !nvmem->read_only) {
> +		if (config->root_only)
> +			nvmem->eeprom = bin_attr_wo_root_nvmem;
> +		else
> +			return -EPERM;
> +	} else if (nvmem->reg_read && nvmem->reg_write && !nvmem->read_only) {
>  		if (config->root_only)
>  			nvmem->eeprom = bin_attr_rw_root_nvmem;
>  		else
>  			nvmem->eeprom = bin_attr_rw_nvmem;
> -	}
> +	} else
> +		return -EPERM;
> +
>  	nvmem->eeprom.attr.name = "eeprom";
>  	nvmem->eeprom.size = nvmem->size;
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> -- 
> 2.25.1
> 
