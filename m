Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7EAC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74279208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCXXFP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:05:15 -0400
Received: from mail-oln040092253093.outbound.protection.outlook.com ([40.92.253.93]:32448
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbgCXXFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 19:05:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhqZUqf9+ViUpamxqPqPZroUzKclyR31XC4LFLH2I/z9/Dt2OxY2mHbzJ3qvWeumQuojafQLM5b5ekXfkbgUC64UOUEu+61YcCHnaazvnza+f7kPC9HnbJnFNSintmh5Wat3x46pFHc1RAy2JPa+zRV6nOrm4SqwTuVldNAwGGdLWXI8sZdEihFI4G4CGPAP3v9mSa12c+Ybc2REQ7c5X7EZcitgphOYm/uIMAWaE1F13tN83jd9s5xNI5YEiFxstd0+13XauOrgxKHq3BlHQUuaevNBYKKYPDziAun308WmoEWwkQ9JLyMLDLOmpEYRU1rbyKnuIXkFMRC+alL59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg38HIpnr0+pqwe77pS9TbisE45hNcmn2LcbZmRzg1k=;
 b=HKPg5koSxKTXE1NfOvG9csRw+e+UbntMk6FJK2UW44LEeniHxWbhu8gmvwYlLlfSu0V+aXMPqeaY7IJ4w9hTwlN7n4xyR9r57zRYJJNbToB4iDXjMXIzBHSbC6Pzp2LRJ3Xu+xsTM/kjGQ6bqZRE9w93EX1TPsffL8DNPb2U/ZtUOiF6Ie1CItbp9AHlMUfg2PQ5bZv1go7NHJHZuwHpkqMqzzU9FASTbIa/I+hwqRm2f4RiLwc4NdneI+N4PURV6OKTAEiODy//PxjUBZ75q4LtQDvJcQk9wF248lCdUUbxpVOoMQ9Cnwaxgy/omIAyJl6Pvzpvu0dWNFVCUC8XMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT052.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::33) by
 HK2APC01HT138.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::466)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.17; Tue, 24 Mar
 2020 23:05:08 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.53) by
 HK2APC01FT052.mail.protection.outlook.com (10.152.248.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.17 via Frontend Transport; Tue, 24 Mar 2020 23:05:08 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::1ddc:43b7:a639:8184]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::1ddc:43b7:a639:8184%9]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 23:05:08 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by SYBPR01CA0125.ausprd01.prod.outlook.com (2603:10c6:10:5::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.17 via Frontend Transport; Tue, 24 Mar 2020 23:05:05 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] nvmem: core: use is_bin_visible for permissions
Thread-Topic: [PATCH 3/3] nvmem: core: use is_bin_visible for permissions
Thread-Index: AQHWAf/vktu3KaBaqESPDuw2qu8YI6hYXUiA
Date:   Tue, 24 Mar 2020 23:05:07 +0000
Message-ID: <PSXP216MB04380BBC9B7488DEC47ACB6A80F10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <20200324171600.15606-1-srinivas.kandagatla@linaro.org>
 <20200324171600.15606-4-srinivas.kandagatla@linaro.org>
In-Reply-To: <20200324171600.15606-4-srinivas.kandagatla@linaro.org>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0125.ausprd01.prod.outlook.com
 (2603:10c6:10:5::17) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:6D93BEE9EF95FDD75F1AAE980FBC42F91DA2DF375118E2842B804CC9D483F8D5;UpperCasedChecksum:9FFDE8ED225BCF8A9DE0A9A0C2E79CB141D839E70EA6D5F473FC9E358022B600;SizeAsReceived:7857;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [bsQOyyMCmwJRRSICar1jsaAigu5GB39yeea4vnN6y522H3gx7oRm4cvYxyC9CQYq]
x-microsoft-original-message-id: <20200324230459.GA2372@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 10ef63d0-f433-4f44-2bd0-08d7d047cb6a
x-ms-traffictypediagnostic: HK2APC01HT138:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0NhCOWAcPlYcJjtCRpLlILKmVmfePvfjep5OQCuFZLx40+NbH3IU/av7IQ1lArSfOLR5GNALogwX3ul57N+KZMVSomJnhGwL0PhRWJ8YJr1oty9jHyB884AxUgEKvxY1Kl4yn01CgcxyLKSPqylDbhCDJ4LIEfUsfEMBhsz44fxrNGT7KuzVPH8QXAJywh08
x-ms-exchange-antispam-messagedata: PXy851lvXXJkh1bcFI0adP2X5sIEy426EQWh+I1jBO/HsPGJBwmdmPFNyADp+O3/brbu0AgnHR0mNlMbnUcYr7d/Tqfp+aQmk0015O8XfylZAZiSnvXxfI+kGtOXcTPJV2CR4MxjbaGqM/W7bwpHASWzsEqCD+eee4SqMD7lX5/yGXxXS/bgF8V8fsHdod/z7lX4SEdiicWg1JsjunA1kA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4858EECB40EBC4428222026CFE25EAD5@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ef63d0-f433-4f44-2bd0-08d7d047cb6a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 23:05:08.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:16:00PM +0000, Srinivas Kandagatla wrote:
> By using is_bin_visible callback to set permissions will remove a large list
> of attribute groups. These group permissions can be dynamically derived in
> the callback.
> 
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/nvmem-sysfs.c | 74 +++++++++----------------------------
>  1 file changed, 18 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
> index 8759c4470012..1ff1801048f6 100644
> --- a/drivers/nvmem/nvmem-sysfs.c
> +++ b/drivers/nvmem/nvmem-sysfs.c
> @@ -103,6 +103,17 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
>  
>  	return count;
>  }
> +static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
> +					 struct bin_attribute *attr, int i)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct nvmem_device *nvmem = to_nvmem_device(dev);
> +
> +	if (nvmem->root_only)
> +		return nvmem->read_only ? 0400 : 0600;
> +
> +	return nvmem->read_only ? 0444 : 0644;
> +}
Looks like I did a pretty good job as I arrived at a similar result 
independently. Even added root_only to nvmem_device. You beat me to it. 
:)

>  const struct attribute_group **nvmem_sysfs_get_groups(
>  					struct nvmem_device *nvmem,
>  					const struct nvmem_config *config)
>  {
> -	if (config->root_only)
> -		return nvmem->read_only ?
> -			nvmem_ro_root_dev_groups :
> -			nvmem_rw_root_dev_groups;
> -
> -	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
> +	return nvmem_dev_groups;
>  }
I was wondering if we can export nvmem_dev_group instead of this 
nvmem_sysfs_get_groups() to fetch it.

Also, we need some logic in nvmem_register() to abort if bad combination 
is given (i.e. root_only set but no reg_read), as returning 0 in 
is_bin_visible callback does not abort. I can do that in my patch if you 
want.

Regards,
Nicholas
>  
>  /*
> -- 
> 2.21.0
> 
