Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A9BC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F25208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgCESL5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:11:57 -0500
Received: from mail-oln040092255109.outbound.protection.outlook.com ([40.92.255.109]:35264
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbgCESL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:11:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNKK2QXi3brlnVrxS1Q6WwHbW0O9fWmzMSannmnI8OZ62zuU+eBAvThavX8pc3Up+Hf2UnxLMf+32DbvkiF+X4yYQle0WWu4C9S98rCY0yPNm/bo+TfOeagCtmHXCb5wppeneHu1tZFstFIFyrRanZymFcJyPSK1NKs4tFHMf3dpY8Dq91TIMCpqi1g3N9Qh9ashl60xFNbLG7EYPGPDV3kwMVpq0JWv+HHZ2LItvLXwHBCFepe9i7T+3TLDfVkqai4sbRfm+OwPSLP/qLPx9yhtEHqKX5Yf8SDmD8jHd5H+09m71PW5SBjPAxgenuRlbfLQfWUtJ+hk7AwZFe9j4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvkeE8oV5psjzX+t5+eRfdCpjWU6A0rDKs1YsGV8Rz0=;
 b=hBgGRPfav23CAOQeu42vFh1HcDJFg3eP/Hj5j3na73S4096pmkHpFUCLR6w8f8tv/aKeJX3xA3AdMLQi7ZfTBNFb1homu1Qutel27eCLDr+XR1BpxH2rB0iw67foIIZSM3Kndm70MlOSd48jo/Nw21vLVql0LRzKooCo/K+WFjHRpDfWKkCh/iKZYMIhnm2IlgMhwZrfkRzDjrAVZVwi5k1dnx2IB05UZ4EQ5D4/P/sPamfSfUwAXRLj8OhNqI6MkJkyLeGoiE0pOl22z4A5TRR2B0WPWsHBpD6TR1CrgwVCt7VUFHdmAhdfkxFLJ9ADbIBKARFNRDSVvzgoFlODyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT062.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::3b) by
 PU1APC01HT096.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::311)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11; Thu, 5 Mar
 2020 18:11:45 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.51) by
 PU1APC01FT062.mail.protection.outlook.com (10.152.253.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Thu, 5 Mar 2020 18:11:45 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 18:11:45 +0000
Received: from nicholas-dell-linux (2001:44b8:605b:17:9373:6593:56ae:2c6d) by ME4P282CA0011.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:90::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Thu, 5 Mar 2020 18:11:43 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 1/3] nvmem: Add support for write-only instances
Thread-Topic: [PATCH v2 1/3] nvmem: Add support for write-only instances
Thread-Index: AQHV8KkxXdrLTxYhU0iNsiLC1KLat6g6PpSAgAATH4A=
Date:   Thu, 5 Mar 2020 18:11:45 +0000
Message-ID: <PSXP216MB04383EBB7FFBAEA7D9ABCAEE80E20@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438930B1FC30EF79F15FD1780E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <b934ddde-702a-1731-034d-1682a9df23e2@linaro.org>
In-Reply-To: <b934ddde-702a-1731-034d-1682a9df23e2@linaro.org>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME4P282CA0011.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:90::21) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:4564178196FD58FB8CD942714C0EBBEDD952C999100F40A2508EC89F8527BE10;UpperCasedChecksum:4253889EC157680DF83DF4BB29CDE3173CD78B3865ED05E0EFCF0022107D8F45;SizeAsReceived:7860;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Lo6S6a3wSOaAqaLL4160NdQbyE+egtvrK1JMQWKqyViYqUG9Cx37YSv8iSV5zgcV]
x-microsoft-original-message-id: <20200305181137.GA1683@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 8dbd234b-f246-4236-1750-08d7c130a9cf
x-ms-traffictypediagnostic: PU1APC01HT096:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7rqS5Q7MYL43QrbV4TkfxEeg7yizK32MuGAm7DPr0TztMEZxpd7wif8/ZvFEMnfWdzM+Uh6TKhDR9lvwd+5QrFCwxCvTlLcSUR574KZzciRg0SHShu3O3RHvOfQ7zY0AaDySOhIAnY4iULi8lJP1BngqRRorbg+acpzJk0llgrDDizOW6nuPPMYXjvQr4AsUvNNlfCUHeTTpKEDMZFNhiO7PBcEACOcNwvjzKqlbwtM=
x-ms-exchange-antispam-messagedata: nOSYNI6mBFKThK5A9Gr3tLex/EXaFYMWjUIujzhuHex9Fx6SZe/EVVZ+Xm9SfVfdSdMbtFDy4ETsgL6luTfJh8aHq77DbHPaKCBXHbPnttogEVSLLptAn9I0QYRPmoNRHs7lRHXAJd8KO/jdo1QwLJVBsr1rEbOi+gxel2gqgJVySm9graI9eXtv6G0WaXKt1lxIC2uneHcQ6+VuyRhPLg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <027F41D670F16440916F786C84F5CB9D@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbd234b-f246-4236-1750-08d7c130a9cf
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 18:11:45.2904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 05:03:11PM +0000, Srinivas Kandagatla wrote:
> 
> On 02/03/2020 15:42, Nicholas Johnson wrote:
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
> 
> > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > ---
> >   drivers/nvmem/core.c        |  2 ++
> >   drivers/nvmem/nvmem-sysfs.c | 53 ++++++++++++++++++++++++++++++++-----
> >   2 files changed, 48 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index ef326f243..27bd4c4e3 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -388,6 +388,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> >   			   config->read_only || !nvmem->reg_write;
> >   	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> > +	if (!nvmem->dev.groups)
> > +		return NULL;
> Returning here will be leaking in this function.
Oops, I had thought about that but missed it. Will kfree(nvmem) in next 
revision of this patch. I will probably break this change off into 
another commit to make each commit smaller and do one thing.

> 
> >   	device_initialize(&nvmem->dev);
> > diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
> > index 9e0c429cd..00d3259ea 100644
> > --- a/drivers/nvmem/nvmem-sysfs.c
> > +++ b/drivers/nvmem/nvmem-sysfs.c
> > @@ -196,16 +196,50 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
> >   	NULL,
> >   };
> > +/* write only permission, root only */
> > +static struct bin_attribute bin_attr_wo_root_nvmem = {
> 
> TBH, you would not need this patch once 2/3 patch is applied.
> Unless there is a strong reason for you to have write only file.
This was the whole reason. The Thunderbolt NULL dereference was because 
write-only was needed but not available. Mika Westerberg thought that by 
not providing reg_read, the nvmem would become write-only. I discovered 
the NULL dereference and that is why I am here - to provide the 
sought-after write-only support. So yes, there is a reason to have 
write-only.

> 
> If for any reasons you would want to add Write only file then it should be
> added for both with root and user privileges.
Mika just advised me that we should not have world-writable files, so it 
sounds like this needs some discussion between us. I am happy to provide 
this if that is desired, as the world-writable will presumably only be 
used if there is a driver that asks for it and has a good reason to use 
it, so it should not be unsafe.

Part of me agrees that there should be no need for world-writable (I 
cannot think of a use-case) but the other part knows that something 
could come along, and that we should cover all bases. Just like we did 
not see the need for write-only.

> 
> >   const struct attribute_group **nvmem_sysfs_get_groups(
> >   					struct nvmem_device *nvmem,
> >   					const struct nvmem_config *config)
> >   {
> > -	if (config->root_only)
> > -		return nvmem->read_only ?
> > -			nvmem_ro_root_dev_groups :
> > -			nvmem_rw_root_dev_groups;
> > -
> > -	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
> > +	/* Read-only */
> > +	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only))
> > +		return config->root_only ?
> > +			nvmem_ro_root_dev_groups : nvmem_ro_dev_groups;
> > +
> > +	/* Read-write */
> > +	if (nvmem->reg_read && nvmem->reg_write)
> 
> read_only flag will override this assumption!
If reg_read != NULL and read_only set then we have already returned. 
Setting read_only and having reg_read == NULL is clearly broken 
behaviour. How about I explicitly check for reg_read == NULL and 
read_only set, and return NULL?

> 
> > +		return config->root_only ?
> > +			nvmem_rw_root_dev_groups : nvmem_rw_dev_groups;
> > +
> > +	/* Write-only, do not honour request for global writable entry */
> > +	if (!nvmem->reg_read && nvmem->reg_write)
> > +		return config->root_only ? nvmem_wo_root_dev_groups : NULL;
> > +
> > +	/* Neither reg_read nor reg_write are provided, abort */
> This should not be the case anymore after this check in place
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/commit/?h=for-next&id=f8f782f63bace8b08362e466747e648ca57b6c06
Nice. I can change the comment, but all code paths need a return value. 
I do not know if the compiler is smart enough to figure out that the 
final return statement is unreachable. So I will still be returning NULL 
at the end to avoid warnings.

> 
> thanks,
> srini
Thanks for reviewing.
Kind regards,
Nicholas

> 
> > +	return NULL;
> >   }
> >   /*
> > @@ -224,11 +258,16 @@ int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
> >   	if (!config->base_dev)
> >   		return -EINVAL;
> > -	if (nvmem->read_only) {
> > +	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only)) {
> >   		if (config->root_only)
> >   			nvmem->eeprom = bin_attr_ro_root_nvmem;
> >   		else
> >   			nvmem->eeprom = bin_attr_ro_nvmem;
> > +	} else if (!nvmem->reg_read && nvmem->reg_write) {
> > +		if (config->root_only)
> > +			nvmem->eeprom = bin_attr_wo_root_nvmem;
> > +		else
> > +			return -EPERM;
> >   	} else {
> >   		if (config->root_only)
> >   			nvmem->eeprom = bin_attr_rw_root_nvmem;
> > 
