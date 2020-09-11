Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688CAC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208AA221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="JO7eUKac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgIKQOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:14:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:25746 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgIKQN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:13:56 -0400
IronPort-SDR: FwiQLiYMw7/XkPXWt+6JphnagshmbKVmuCJMf8gx6g1El4YPgRg5tiBVm7IcTmyljOwIYgGz4t
 gpi2SiCavQ7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="146521329"
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="146521329"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 09:13:47 -0700
IronPort-SDR: fDZFo34+QTAufCsTTXmHM3Qur6BNvvGG9KpHgM/XthEQFsF/7ygGbuLHceVrGPEZa08vMaKk3Z
 juBgGRUaZg6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="300972254"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 11 Sep 2020 09:13:45 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Sep 2020 09:13:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Sep 2020 09:13:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 11 Sep 2020 09:13:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 11 Sep 2020 09:13:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnLmgB9RkCQH8zO4LpPrbA1oIqL9jl6itS52nyosXYXvuyLsE89qXxmxPK2q/3vJOFFuAlu2ivsegvWOeZfSBkGShMw89zWZa28vztHTkRVxjJeMDG2fKnU92TkaZh3g8zGVP0UsBPLVoSNoRi+6T65GNmQGfdKH0TumQL7YQGPTV/aLmZZxPsKDjciNsNzjFf+Ldh/6jaCqjMk3oB6DFVie/xxss6N5VqEzhH7c1lDXg1nBoEPIUmJ4pNj56kZqrJUrdv1yLwm0zC2Czr5Kb6cA+7AgZnq13LcjcT8/SgX/DGPdF93BEQZ19w6oYYP+ztqK7ir95Aat9iIrq/X1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njFXpvsGPu32xVW0bpW0hU+dTRVPTRISf2+ikKcmlZo=;
 b=Rda9Y9ck3/YhW1OoIf/R3smLYUnCMqWuSgzmZU8BRZgzfo8dYAXwJ+G3Ul49K7i+9il+nWlZRK/x/HPPlc9R51lmcp16Vm15z7UauHj6B9+CcEavgGIMF35Tvx+und9DMhyA0pn4S9BewliqekFB8WlDGmh08UAtiOyntUG2A/7Ytv9D5ONbs9AYesZW3g+CCzKh5AJSqJDKsL3MTerQWau+wqcUMc9C9H70T4sBMijqjS0QtKC4XhVlel+wgcQH9SLKRHRddUZrezFFx1CjFTpQ1LpsUWThvIYNnjungj08BSgnIieZDXp6ec4v4DPsuy7ZIYxgRuxaB2e4Lnw1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njFXpvsGPu32xVW0bpW0hU+dTRVPTRISf2+ikKcmlZo=;
 b=JO7eUKacyNJenFCTB030IJYdkY1p+bzYxSZ6eXwlLCy5cOl4Mg/gYmf3RVOnvsB8dtUP4w00s6gmWZ3PqYVY/Gcz3i/0EbnCLK9XPI+VnqWxWjS3g/xPsK3OFIPi2+c0cGCftVafsAZfn0vcz1ir6sYA8GsKLT4Vl1Rg32s5+xc=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2569.namprd11.prod.outlook.com (2603:10b6:5:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 16:13:26 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d%5]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 16:13:26 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: RE: [PATCH] memory: dfl-emif: add the DFL EMIF private feature driver
Thread-Topic: [PATCH] memory: dfl-emif: add the DFL EMIF private feature
 driver
Thread-Index: AQHWhbqF2xjLLseiT0KPSG8jIEWIfqljmV9Q
Date:   Fri, 11 Sep 2020 16:13:26 +0000
Message-ID: <DM6PR11MB381909141CCF28886F9B86DC85240@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1599553645-26928-1-git-send-email-yilun.xu@intel.com>
 <1599553645-26928-2-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1599553645-26928-2-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85b64750-780b-49de-9c96-08d8566d9d93
x-ms-traffictypediagnostic: DM6PR11MB2569:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB256944FF169B32CF45A6EDE985240@DM6PR11MB2569.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HolveIfOUaEqzeDvj5X94YxAbb7sacVD89xPz1Lb72M9WHmvZlbtA/76VWfbz2ITV33oD1bCrcJb+pZCymdiWk4ZRy2H4kM3abfwerkIC97P58c7pxiIbN0LhkcqUFomPWHxL19qNZft0/8fH6sewtBiqSpX0jT3rs/ZO0O7cZMfJBfQnTLI0Hryp9WZxcRWCHmmiEtZ/iHFQ2wlWQLGUOltDugKXis6Rzbf1aqnKLxM9a6kDNGpRX/4a7r3Ubxbj4UTA2USKgTuRbMSO9YfS0l6sljlXf8VersLFmjE5VW7UmB2DxbJwt7IQbSX/KxlJJNFbSfJOnZCjZR1nr0uwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(66476007)(52536014)(66556008)(76116006)(478600001)(66946007)(64756008)(110136005)(186003)(7696005)(5660300002)(66446008)(6506007)(26005)(54906003)(316002)(83380400001)(86362001)(33656002)(8676002)(9686003)(55016002)(4326008)(8936002)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: C8Ekwu8H3G9iCGQJSPlcD1b0uJWIYE0vfIyEbVF43KT0OHYTppgsTY3Dt94jNlQq0Bg9JWhfC4ntnOE6PVyTFjro4FsqU27OoEgPWVq7QWGlwIeC+NvC2ky71VPiAq8Hect0cT1PB23mfp+igZ6v2YqFdkChVRnYXHgqWO6fA39DMVUscYqhOi8lU67Qhg0pfaPhKomKD0328ZwWyTQhnR02OI92/hddRxVVTi2z2hrgKj8/b2203ehuxBAZdod/QK2d9PmXbu9/hKV8BeFikt0V+Cn+5WAgzhLIHGCcGUKTQyRXE6CZfyWG/zJsXYfPIxKQHxv6eE6cW81gsVWD2FHamdmMCx2H1a/v7e5n6NCVeVGjUXDveSol/3h3FxBu1jdzhaKxEu4gTV2L3Xjq7sZqmHJW0lbjcw3ZT7ipoGw2JtBJfr+7sje4/9iv2PVJpcBOA/pnc6X1dR+VkJ1T11Z1nwF0gr69+ly2PZPFa4h/xwEv51MH1Vqmdg6xcUdUpXsumxxCxuXetxuUDwOfEyOuxIXrRQIr4mWfLIYAT2EKt/pO0wNdc6I1LSifRT8UA2Pbm0QG6IxANSE3WOUeSaEV7+IQW7Cw4680oByZrLcqConHp+1MgP+H7VQo34R1IDDsZHEAAGfiZN7A/fqm+Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b64750-780b-49de-9c96-08d8566d9d93
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 16:13:26.6896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13T870VOU6zRWUo5FSxrHnMGtUc0S906Nt8gaFTB1nPnjN28nPJZr/dLpSTLfMThkwMw7+qECrMHRZ4R4e+rnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2569
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] memory: dfl-emif: add the DFL EMIF private feature drive=
r
>=20
> This driver is for the EMIF private feature implemented under FPGA
> Device Feature List (DFL) framework. It is used to expose memory
> interface status information as well as memory clearing control.
>=20
> The purpose of memory clearing block is to zero out all private memory
> when FPGA is to be reprogrammed. This gives users a reliable method to
> prevent potential data leakage.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
>  drivers/memory/Kconfig                             |   9 +
>  drivers/memory/Makefile                            |   2 +
>  drivers/memory/dfl-emif.c                          | 211 +++++++++++++++=
++++++
>  4 files changed, 247 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
>  create mode 100644 drivers/memory/dfl-emif.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> new file mode 100644
> index 0000000..33d557e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> @@ -0,0 +1,25 @@
> +What:		/sys/bus/dfl/devices/dfl_dev.X/infX_cal_fail
> +Date:		Sep 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It indicates if the calibration is failed on thi=
s
> +		memory interface. "1" for calibration failure, "0" for OK.
> +		Format: %u
> +
> +What:		/sys/bus/dfl/devices/dfl_dev.X/infX_init_done
> +Date:		Sep 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It indicates if the initialization is complete o=
n
> +		this memory interface. "1" for initialization complete, "0"
> +		for not yet.
> +		Format: %u
> +
> +What:		/sys/bus/dfl/devices/dfl_dev.X/infX_clear
> +Date:		Sep 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Write-only. Writing "1" to this file will zero out all memo=
ry
> +		data in this memory interface. Writing other values are
> +		invalid.
> +		Format: %u
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 8072204..fb0858f 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -215,6 +215,15 @@ config STM32_FMC2_EBI
>  	  devices (like SRAM, ethernet adapters, FPGAs, LCD displays, ...) on
>  	  SOCs containing the FMC2 External Bus Interface.
>=20
> +config FPGA_DFL_EMIF
> +	tristate "DFL EMIF private feature support"

Yilun,

I see you are submitting several different DFL device driver now, then do y=
ou
think if it's better to have some unified style of the naming?

> +	depends on FPGA_DFL && HAS_IOMEM
> +	help
> +	  This driver is for the EMIF private feature implemented under
> +	  FPGA Device Feature List (DFL) framework. It is used to expose
> +	  memory interface status information as well as memory clearing
> +	  control.
> +
>  source "drivers/memory/samsung/Kconfig"
>  source "drivers/memory/tegra/Kconfig"
>=20
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index e71cf7b..0afbf39 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -39,3 +39,5 @@ $(obj)/ti-emif-asm-offsets.h: $(obj)/emif-asm-offsets.s
> FORCE
>=20
>  targets +=3D emif-asm-offsets.s
>  clean-files +=3D ti-emif-asm-offsets.h
> +
> +obj-$(CONFIG_FPGA_DFL_EMIF)	+=3D dfl-emif.o
> diff --git a/drivers/memory/dfl-emif.c b/drivers/memory/dfl-emif.c
> new file mode 100644
> index 0000000..442137f
> --- /dev/null
> +++ b/drivers/memory/dfl-emif.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for DFL EMIF private feature
> + *
> + * Copyright (C) 2020 Intel Corporation, Inc.
> + *
> + */
> +#include <linux/bitfield.h>
> +#include <linux/errno.h>
> +#include <linux/fpga/dfl-bus.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spinlock.h>
> +#include <linux/stddef.h>
> +#include <linux/types.h>
> +
> +#define EMIF_STAT			0x8
> +#define EMIF_STAT_INIT_DONE_SFT		0
> +#define EMIF_STAT_CALC_FAIL_SFT		8
> +#define EMIF_STAT_CLEAR_BUSY_SFT	16
> +#define EMIF_CTRL			0x10
> +#define EMIF_CTRL_CLEAR_EN_SFT		0
> +#define EMIF_CTRL_CLEAR_EN_MSK		GENMASK_ULL(3, 0)
> +
> +#define EMIF_POLL_INVL			10000 /* us */
> +#define EMIF_POLL_TIMEOUT		5000000 /* us */
> +
> +struct dfl_emif {
> +	struct device *dev;
> +	void __iomem *base;
> +	spinlock_t lock;	/* Serialises access to EMIF_CTRL reg */
> +};
> +
> +struct emif_attr {
> +	struct device_attribute attr;
> +	u32 shift;
> +	u32 index;
> +};
> +
> +#define to_emif_attr(dev_attr) \
> +	container_of(dev_attr, struct emif_attr, attr)
> +
> +static ssize_t emif_state_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct emif_attr *eattr =3D to_emif_attr(attr);
> +	struct dfl_emif *de =3D dev_get_drvdata(dev);
> +	u64 val;
> +
> +	val =3D readq(de->base + EMIF_STAT);
> +
> +	return sprintf(buf, "%u\n",
> +		       !!(val & BIT_ULL(eattr->shift + eattr->index)));
> +}
> +
> +static ssize_t emif_clear_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct emif_attr *eattr =3D to_emif_attr(attr);
> +	struct dfl_emif *de =3D dev_get_drvdata(dev);
> +	u64 clear_busy_msk, clear_en_msk, val;
> +	void __iomem *base =3D de->base;
> +
> +	if (!sysfs_streq(buf, "1"))
> +		return -EINVAL;
> +
> +	clear_busy_msk =3D BIT_ULL(EMIF_STAT_CLEAR_BUSY_SFT + eattr-
> >index);
> +	clear_en_msk =3D BIT_ULL(EMIF_CTRL_CLEAR_EN_SFT + eattr->index);
> +
> +	spin_lock(&de->lock);
> +	/* The CLEAR_EN field is WO, but other fields are RW */
> +	val =3D readq(base + EMIF_CTRL);
> +	val &=3D ~EMIF_CTRL_CLEAR_EN_MSK;
> +	val |=3D clear_en_msk;
> +	writeq(val, base + EMIF_CTRL);
> +	spin_unlock(&de->lock);

Should this lock protect below status polling? Is it possible another clear
happening right after this spin unlock and cause a different value to=20
EMIF_CTRL before below status polling?

Thanks
Hao

> +
> +	if (readq_poll_timeout(base + EMIF_STAT, val,
> +			       !(val & clear_busy_msk),
> +			       EMIF_POLL_INVL, EMIF_POLL_TIMEOUT)) {
> +		dev_err(de->dev, "timeout, fail to clear\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return count;
> +}
> +
> +#define emif_state_attr(_name, _shift, _index)
> 	\
> +	struct emif_attr emif_attr_##inf##_index##_##_name =3D
> 	\
> +		{ .attr =3D __ATTR(inf##_index##_##_name, 0444,
> 	\
> +				 emif_state_show, NULL),		\
> +		  .shift =3D (_shift), .index =3D (_index) }
> +
> +#define emif_clear_attr(_index)
> 	\
> +	struct emif_attr emif_attr_##inf##_index##_clear =3D		\
> +		{ .attr =3D __ATTR(inf##_index##_clear, 0200,		\
> +				 NULL, emif_clear_store),		\
> +		  .index =3D (_index) }
> +
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 0);
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 1);
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 2);
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 3);
> +
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 0);
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 1);
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 2);
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 3);
> +
> +emif_clear_attr(0);
> +emif_clear_attr(1);
> +emif_clear_attr(2);
> +emif_clear_attr(3);
> +
> +static struct attribute *dfl_emif_attrs[] =3D {
> +	&emif_attr_inf0_init_done.attr.attr,
> +	&emif_attr_inf0_cal_fail.attr.attr,
> +	&emif_attr_inf0_clear.attr.attr,
> +
> +	&emif_attr_inf1_init_done.attr.attr,
> +	&emif_attr_inf1_cal_fail.attr.attr,
> +	&emif_attr_inf1_clear.attr.attr,
> +
> +	&emif_attr_inf2_init_done.attr.attr,
> +	&emif_attr_inf2_cal_fail.attr.attr,
> +	&emif_attr_inf2_clear.attr.attr,
> +
> +	&emif_attr_inf3_init_done.attr.attr,
> +	&emif_attr_inf3_cal_fail.attr.attr,
> +	&emif_attr_inf3_clear.attr.attr,
> +
> +	NULL,
> +};
> +
> +static umode_t dfl_emif_visible(struct kobject *kobj,
> +				struct attribute *attr, int n)
> +{
> +	struct dfl_emif *de =3D dev_get_drvdata(kobj_to_dev(kobj));
> +	struct emif_attr *eattr =3D container_of(attr, struct emif_attr,
> +					       attr.attr);
> +	u64 val;
> +
> +	/*
> +	 * This device supports upto 4 memory interfaces, but not all
> +	 * interfaces are used on different platforms. The read out value of
> +	 * CLEAN_EN field (which is a bitmap) could tell how many interfaces
> +	 * are available.
> +	 */
> +	val =3D FIELD_GET(EMIF_CTRL_CLEAR_EN_MSK, readq(de->base +
> EMIF_CTRL));
> +
> +	return (val & BIT_ULL(eattr->index)) ? attr->mode : 0;
> +}
> +
> +static const struct attribute_group dfl_emif_group =3D {
> +	.is_visible =3D dfl_emif_visible,
> +	.attrs =3D dfl_emif_attrs,
> +};
> +
> +static const struct attribute_group *dfl_emif_groups[] =3D {
> +	&dfl_emif_group,
> +	NULL,
> +};
> +
> +static int dfl_emif_probe(struct dfl_device *dfl_dev)
> +{
> +	struct device *dev =3D &dfl_dev->dev;
> +	struct dfl_emif *de;
> +
> +	de =3D devm_kzalloc(dev, sizeof(*de), GFP_KERNEL);
> +	if (!de)
> +		return -ENOMEM;
> +
> +	de->base =3D devm_ioremap_resource(&dfl_dev->dev, &dfl_dev-
> >mmio_res);
> +	if (IS_ERR(de->base)) {
> +		dev_err(dev, "get mem resource fail!\n");
> +		return PTR_ERR(de->base);
> +	}
> +
> +	de->dev =3D dev;
> +	spin_lock_init(&de->lock);
> +	dev_set_drvdata(dev, de);
> +
> +	return 0;
> +}
> +
> +#define FME_FEATURE_ID_EMIF	0x9
> +
> +static const struct dfl_device_id dfl_emif_ids[] =3D {
> +	{ FME_ID, FME_FEATURE_ID_EMIF },
> +	{ }
> +};
> +
> +static struct dfl_driver dfl_emif_driver =3D {
> +	.drv	=3D {
> +		.name       =3D "dfl-emif",
> +		.dev_groups =3D dfl_emif_groups,
> +	},
> +	.id_table =3D dfl_emif_ids,
> +	.probe   =3D dfl_emif_probe,
> +};
> +
> +module_dfl_driver(dfl_emif_driver);
> +
> +MODULE_DEVICE_TABLE(dfl, dfl_emif_ids);
> +MODULE_DESCRIPTION("DFL EMIF driver");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4

