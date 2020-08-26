Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51E7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D59B20707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="YqWKwZSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgHZFaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 01:30:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:18927 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgHZFaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 01:30:01 -0400
IronPort-SDR: Dsw3i0RW9HYDh+ovZx7os/VWltDL0Yh5NLleosFXPNe9fPUDtkztyBVh+UP54jSa5mk7f8OSn6
 UXF0vpfZPs6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="174285133"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="174285133"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 22:30:00 -0700
IronPort-SDR: Jt2ceYFI/7Fsqa0r21yQ11clU5rXr3FG7Zwl/2FEIN9mWUYDx4x70MzXzwbPNV00UBQZcs/azF
 vBPTNoV6LBCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="281703751"
Received: from orsmsx603-2.jf.intel.com (HELO ORSMSX603.amr.corp.intel.com) ([10.22.229.83])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2020 22:30:00 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Aug 2020 22:29:59 -0700
Received: from orsmsx105.amr.corp.intel.com (10.22.225.132) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 25 Aug 2020 22:29:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 25 Aug 2020 22:29:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 25 Aug 2020 22:29:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1JVr7PctWDPT2gw9ujtp4UVtdpnnve2BCR2qUX5Wpi/DnLFcJQlJFMgskKRt8Bkr55jLFTc0N/JBwjT6Kq9KuoHRDBYgAtnTJ8iGfhTs1BySeU+RsQeTImLtPEuPEGfND9/T6jcBETwx4pVCrDfUmnp/y+olgU+6lX5U2OIzIQxPjK1vh1t1L3zJ+XW3BOc7QP9PyUIzSB3gD/SPvnHQjNW6iH1AYBMqR6ptO8ea6BaqEE+D2o+0TdoFJR3+v+xWYus5qJD2Y0NnoBC9n1vjxwN0helZYSmTX27XPFBTKEGMbIxtndugBPIcZtVZhTuNMHuhy5AnBVandUItICtGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6OYQo2EVedvCCcJnWa62h3FlE+DzERw6dzpAdXS+bE=;
 b=PCtslae1r9sICIA+CHj+hRpDaabojsPTVTT2Tw+zFXjBm63uoJj9SBDGH4lur1/TGYaWYdhz27WViipkh6l0NB3NW3dtzNbOktBrsKKRDh5/nRtypIM8Wx1+B6sHTXeMoqaZ13/jtsPWYbsYdhQE4beHh+6LfT82QRgaBE66Y631RH/s6xb0T90FAPZy1jpCDs4J5LG7SGpFCYiHtIaTBR90Ei+yntRLPpxQRb8+XDsrComGz1d+D2mjuIR45zFXRg+oi3NE4Hjl/NROrABZK2m92giit1ckrSICgrKawa3Z8NCQQs+16HVLffsS7dH9EM8NA0xiqZiQJkbgKbwSzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6OYQo2EVedvCCcJnWa62h3FlE+DzERw6dzpAdXS+bE=;
 b=YqWKwZSteFODW7Fvaj4TtJmSpFYQglgDc+aSwKj3CavmII9fU4QZFaFEkkXPHOsMHwZk+vijvgshBYAa+FTYwMwEzTx55eNpqf8yARaFmDqWdN2ea5IW5w7wvXgsF+xQ3PIsM/9mepjaIBXyZB8Pz4n6N2EH2WrA33mMM/fwvzc=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1389.namprd11.prod.outlook.com (2603:10b6:300:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 05:29:57 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::6dfe:feb8:25f1:ac9c]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::6dfe:feb8:25f1:ac9c%7]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 05:29:57 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Serialize IOMMU GCMD register
 modifications
Thread-Topic: [PATCH 1/1] iommu/vt-d: Serialize IOMMU GCMD register
 modifications
Thread-Index: AQHWe1XHGEAHwUhH/kWUEasne4rewalJ3GZw
Date:   Wed, 26 Aug 2020 05:29:57 +0000
Message-ID: <MWHPR11MB16457C6EC72943EF615AF2538C540@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200826025825.2322-1-baolu.lu@linux.intel.com>
In-Reply-To: <20200826025825.2322-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e44e79ff-8c62-4b31-1015-08d849811224
x-ms-traffictypediagnostic: MWHPR11MB1389:
x-microsoft-antispam-prvs: <MWHPR11MB138915B1EBB9445010AFCCF18C540@MWHPR11MB1389.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LFRCjHHKjUBDGp7Kv9fzq7IxEEWkheaKbRNDKzffEzFoD5hl76tgw8njUQfZGEYM3JIWOyXzIeUzcKyuLDw6sZfp+lYM2qSVXVcDMuEzs+Ce4jvao+7nxmOaxlDOLlv4YEyE0hEXg3p6Y7/FJEeBTrPoKC+woGs6fic9fD3ywPI7n2kFUKGyeY9D1ogzQ/9a6wHW1fV//2JGwTU7SBtA0DdVUpO8I8yNSOPBdCU7DgCu2csjLv9fr50h3mWWa1rmyGPAlS3iNRBGmtE8LqnaftEujZkGOqjGA5h4P1oi9PtAphV22zqAOxUQhGjOAGnJPiV8TxOngJnmlw+Bsra5KmGQQkq63n975cG4tZ5DjpePrTrKT+leGVt050XUoGSwJa/8Q1aFmXUREL6+Gttung==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(8936002)(966005)(316002)(6506007)(4326008)(110136005)(8676002)(478600001)(186003)(2906002)(7696005)(26005)(9686003)(54906003)(86362001)(76116006)(66946007)(5660300002)(33656002)(66476007)(83380400001)(64756008)(52536014)(55016002)(66446008)(71200400001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6jKwItuvLysNOETd4DYC8u1dB7sIQz8Bmc3HwEtu2jUm4b0Pz8jUrFW9XBlTboRKGcXImOOx/mclRndZFg+cBhqKdAdwy2jSyeQsVqem/10URo5AZYgBzaE99flKG0faWyRaRbFSA1+fH8KusZcw97R96HMEhaj70PqsQg+i2DEK4kBaLoD8o3+CkZzAlsFIHglZKK++Z5qv/JB62m70B0yWlso34U4fGUdLzxowxPZMuvfegwYa91ZCvYSIKvNRiZujCsfTd68o5Ujvu0ry6MgQOiIr0J3cdIuRzNoNdc3xlBdupXzsNaFtPP1FgmTI+stNQ9B/ZT06s+3QO7XMb/eQSiUuzi1aAZ1UMx9dA6ayzWvy8fdIBQIJysaAe2d9I7wLC6rLwTWnKEHZshuhYDLkODgP9aoqS+zFE9VNf+nzW1auTZnvwuCMX8eo1p3CfK8nPVen24nwnkyuYrS4JNvaKfIu9cjWH+2ShMVl8MS37JLhD0CJJ4DhroYWspxHy5AaUWvinl5t3RqXe+5A5O3tPdIyly2YA1WG0zP+P6FEJRksoHYusxUmoCYc0SlerRxbk0LZ2Ks1aPMvnC3mPc1dI6Tbq9rtP5vJ+DnOmakHuDLCF9lTJIuOXensnuZyZmGnS4DZHRkgq6DlByQQjA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44e79ff-8c62-4b31-1015-08d849811224
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 05:29:57.4278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6Wi2EWqDROb45LfTBjYPuw5pI+6mEWUxyuO5MZDgHugXfr7le59P+S9JkyNIWoEAawKvObCjqg6O71Ca1CMDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1389
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu
> Sent: Wednesday, August 26, 2020 10:58 AM
>=20
> The VT-d spec requires (10.4.4 Global Command Register, GCMD_REG
> General
> Description) that:
>=20
> If multiple control fields in this register need to be modified, software
> must serialize the modifications through multiple writes to this register=
.
>=20
> However, in irq_remapping.c, modifications of IRE and CFI are done in one
> write. We need to do two separate writes with STS checking after each.
>=20
> Fixes: af8d102f999a4 ("x86/intel/irq_remapping: Clean up x2apic opt-out
> security warning mess")
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/irq_remapping.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/irq_remapping.c
> b/drivers/iommu/intel/irq_remapping.c
> index 9564d23d094f..19d7e18876fe 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -507,12 +507,16 @@ static void iommu_enable_irq_remapping(struct
> intel_iommu *iommu)
>=20
>  	/* Enable interrupt-remapping */
>  	iommu->gcmd |=3D DMA_GCMD_IRE;
> -	iommu->gcmd &=3D ~DMA_GCMD_CFI;  /* Block compatibility-format
> MSIs */
>  	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
> -
>  	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
>  		      readl, (sts & DMA_GSTS_IRES), sts);
>=20
> +	/* Block compatibility-format MSIs */
> +	iommu->gcmd &=3D ~DMA_GCMD_CFI;
> +	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
> +	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
> +		      readl, !(sts & DMA_GSTS_CFIS), sts);
> +

Better do it only when CFI is actually enabled (by checking sts).

>  	/*
>  	 * With CFI clear in the Global Command register, we should be
>  	 * protected from dangerous (i.e. compatibility) interrupts
> --
> 2.17.1
>=20
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
