Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A7AC10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 01:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880AB24649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 01:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCJBK3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 21:10:29 -0400
Received: from mail-oln040092253032.outbound.protection.outlook.com ([40.92.253.32]:47680
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbgCJBK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 21:10:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U94eAOAoauswfmyKpkXzmblZVfyWYuW+RT5s2KZ7k9B25K1hY1Pcfi4RXIACUOGwToNopSZKKfu9YcxEx/I0WNKpWHFbf1/sK5gK9RL/K1EHv+2pJdhgi33sqXIk5WXWdntnB7hlp4YBO/GMcQn0kSu+i9d2UiVQQnCWS9FcY0/Br7Bop+D7zsE56rDpmE4rTvsH5Sc668GB/CEYhzOfB1qwze4PBWQl36uGVQYAbn62LRXT5Mt6nzcZLgHcJ+i5njVbt1elo+Ntm7ZYGOhGmNkqJ1+B0sJ4LtuTraRNKWiElM2F0XK2JKDjM51UJvmfG29QXYjrQzKwe/xgKpEGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBYfntADUxw41Qc6CzWTB/HGT5tN86qbIZGPHhItfD0=;
 b=Dl5BX5t5fGSyM56Gzr1W1Z6TipygaYnh2yzP9bUY0DjGuCO6z45T+rbQQ6rePlaWJ8/7erdynTzDxRVe+LCUuKDjI+LyRaLGbR2KY712pLBAeZ9l1cBP/+a01UUO5QDba1b/fsp+vn8xmUY+NQo+W/eqbgE0uBBSAwqls6uXacl5ryAwQSvEVjeViwRElQZ7WD76eYkF0UYEV7LW9zpmh3U5GUQ/eJ8w37y+Qt5FQ4cBgCLWEG11rLaQTaX1liqdDdpLJ4nmgV/CLq26w/G0Q7oKY9SS9ZwhNHeqx5iG/4NOkw4oJTmMkq+4NV+0+2sYh1YActWHsMdiGVkDzvfxwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT060.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::37) by
 HK2APC01HT078.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::332)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11; Tue, 10 Mar
 2020 01:10:24 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.57) by
 HK2APC01FT060.mail.protection.outlook.com (10.152.249.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Tue, 10 Mar 2020 01:10:24 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 01:10:24 +0000
Received: from nicholas-dell-linux (49.196.154.16) by ME1PR01CA0130.ausprd01.prod.outlook.com (2603:10c6:200:1b::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend Transport; Tue, 10 Mar 2020 01:10:21 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 2/2] nvmem: Add support for write-only instances
Thread-Topic: [PATCH v3 2/2] nvmem: Add support for write-only instances
Thread-Index: AQHV9jsxJuscDJGSJEm8fhjJto18yKhBBNgA
Date:   Tue, 10 Mar 2020 01:10:24 +0000
Message-ID: <PSXP216MB04388474C638D9EAC994ECEA80FF0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438614877E3559E155F12AF80FE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB0438EF52E2F4E58264ADBB8A80FE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0438EF52E2F4E58264ADBB8A80FE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME1PR01CA0130.ausprd01.prod.outlook.com
 (2603:10c6:200:1b::15) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:9088E1F1033EEEB6F52C934E61C9B536DCA1B292D62601BD613604A9ECD64EF9;UpperCasedChecksum:96BDA764C951C57580F899DB3E987838782C1E0515DD9AADE27770F848C95567;SizeAsReceived:7811;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [VMV59lluRA9JDK4pIqgP0/i9zgA2N/xv]
x-microsoft-original-message-id: <20200310011014.GA2103@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 7c73045c-d0b3-4ead-1117-08d7c48fcf4e
x-ms-traffictypediagnostic: HK2APC01HT078:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NFpQE5j4Zpv+SqoKJxmb/GnTwojt7H22NVXz1BKYuYe7CiZmzjv9LjXDE5DbQwYb92HKLJd7Ibzi8OGJe+za2aggPXmf2MthYjX4Vgci1WB0DxNmCjSngCfBwTTVGTJk7LF3HqFHRibwizPi51eUH4njzAmm2Pwbj8fuO2uPgRVnozW8xTTjPplbAPmNROXn
x-ms-exchange-antispam-messagedata: EQ3flCzuyu9a7GJcz45n3fGSo/Jq7rI5/qbG8Ghca4mhaytCGCheo3yI4Hd3xVPPx4Pv9LNx/bfadbKbmsPIFOc9BhhkuYdZuBXqv4Pg6MTo9VC5tjGJ7f3i59BrvbidCEx88C/sxHBsp04wcLlFhQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D9AE6678071B5B4384EEB405A5E1395B@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c73045c-d0b3-4ead-1117-08d7c48fcf4e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 01:10:24.2317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT078
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
> 
> Return NULL from nvmem_sysfs_get_groups() in invalid cases.
Oops, late night. Please drop the above line if you accept this. This 
above line applies to patch 1/2 now.

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
