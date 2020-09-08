Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A584C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5F521D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="fbf0AvO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgIHIrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:47:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:29892 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729662AbgIHIri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:47:38 -0400
IronPort-SDR: /ORe5YLbKLaCDWJrWzZ1xCbcKkLWHMaQ2pnLysh++upYaDaPu9IzBhI4I8YgUi9dnlmTJNj1c3
 XFUM/S+LVK3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="242910828"
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="242910828"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 01:47:38 -0700
IronPort-SDR: vE09PPBJDzahLqkit5OAflGGoMblk9vNYynS/5AcPR2kcmyPDsKs60G1JWpaInOgpf7lP3vKsD
 6qea05l238zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="317119238"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 08 Sep 2020 01:47:37 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Sep 2020 01:47:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 8 Sep 2020 01:47:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 8 Sep 2020 01:47:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g64UXxc3WxKkQCV9ix2S9GRjgaMY/p9lLp+dQGw6KR4Xa91yjJIDYeNoh0hK6Il1gmY88ejZFIkiEIO18kDWxkNqiDidzQhxb+8GmMVGY9j1kuDBPs7Ru7X6Icpwk7YXqi/aUhM7TpBVOwBairXO61KVkiMHA6RLBj1avbMdHvbWx91hnriwi4vKl5nslqyYQ/ghgLD4bPyFtK2A24gSa8QQOlWk5Nr9gdDlCmGJ8Zx9HuGhHigNpIDz8pI1SWGtxdAP9xFp9O90OEi2+ramlTFQiFIXYOcXXJiUqFAMfMhoJSRCO4DhCKMkjc0qs86JcHDSWYrM/zUxQS3MIxZD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cwvz12wsEJ5pPOAVkqyZ/83eTDtaSXYPqjq9KwPpAyw=;
 b=S8D2Qvbc/Mqh9rq81NVFGNblW7G7EKby1vvYcBIjsLDSR1SS1i/pV8qfaeqvdTYXR5W9AVn76Hz2gdMw5GzjQ+7LjQelKXLR3rWALg/qNJr8bSPV3lTkRk3gVv7u4Cf8QGPvDUHTrU8YAExKLcO19e5fIvQdMZM4ee5ElGGHHCq9IYW4B++rVNwUMfSuZ9PWLJuuN1xrL0xKyBEVYXPXHmakhgqyTPg1RJxnnHv9VDiYz+I3DYbM4vHQFWJ/6/pM4lMfGetVfGFoD8cCKjeVPZxXzUoFuh6u6A8TXXKi4bFSRYt0ao1eknwiutbMb/2Ymb9cN9Ljyk9vfI1xKHg2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cwvz12wsEJ5pPOAVkqyZ/83eTDtaSXYPqjq9KwPpAyw=;
 b=fbf0AvO3S1PbbSdqwtMKw53gvRLfQ3Dy3/Jlhh1uKQo+LgkZGa2I06IhmrkSU1e3sn84ZxaA3cmM9rPib6CTiuSzM2gR7pXeHSoEr/X0tp5wq0KCnpmd7D5jg7Khhnvl80Z8aZXWb+vtsj8lzPC75502U84TOGptDLrP3ZSXGw4=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB3548.namprd11.prod.outlook.com (2603:10b6:5:143::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 8 Sep
 2020 08:47:30 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::7883:72bf:ad85:5166]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::7883:72bf:ad85:5166%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 08:47:30 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "vadivel.muruganx.ramuthevar@linux.intel.com" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "eswara.kota@linux.intel.com" <eswara.kota@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH v8 1/3] phy: intel: Rename phy-intel to phy-intel-lgm
Thread-Topic: [PATCH v8 1/3] phy: intel: Rename phy-intel to phy-intel-lgm
Thread-Index: AQHWgBqEjgxb/tv0dEi6tzrcohnkZKlTbo0AgAsKcnA=
Date:   Tue, 8 Sep 2020 08:47:30 +0000
Message-ID: <DM6PR11MB372169AD9B77DF5237763364DD290@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20200901044201.20978-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200901044201.20978-2-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200901081040.GN1891694@smile.fi.intel.com>
In-Reply-To: <20200901081040.GN1891694@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [14.1.225.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18e78e0f-8fc8-4d8c-c298-08d853d3d242
x-ms-traffictypediagnostic: DM6PR11MB3548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB35480C09B0C71F815B1DA37EDD290@DM6PR11MB3548.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5fzOw8ZT+roP+nR+kU7npObFRMKrk0n6oxoVDGHtkaKdAJ5U7SRgGwgSSuWI/QgNNUVS9R0vk/jrZtXvbP2tKuF/UytOzYGwwNCf01IoFNJTFE1fLt0MPu7j2ruvJNuxiwFfBh5Kbjuua31+HloPvdtAQGoQKbuMKp4yHvwCHBkNswGZX8lWYMxeKqwnjCpMGlRD0tK5ZcsDcIII6/UNf/Cvc9gSsyczLPZ6bxqA114kyf+syuFOU1nzQjDgvzqry6UoG1Lx63rgLrf1b6Q/sJRkMSMULeua0pc3NVbKyyAIQEIjNj8gPl59Xaz3tncH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(4326008)(66556008)(64756008)(6916009)(33656002)(71200400001)(7696005)(186003)(52536014)(478600001)(76116006)(86362001)(66946007)(8936002)(66446008)(66476007)(54906003)(53546011)(2906002)(8676002)(55016002)(83380400001)(26005)(6506007)(5660300002)(316002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LvzV8tkJgsW3yTPOAq9F3XmA43W16EzT4d7YqzqTT98uh8x0gxy/l+7SkwWYfgyGLXCBkkY8ot5fjlpRw2DdOdBS5uetFaJWJpATs4xQcr31r0qaoKbeklVJHPg+EaQwD9GD61oWy0w4Y/D/dz5F7cqYNFQzYrBiTCSpibaFQWyo1d5UPYmL5JRKlhulqtCJjUK6LQMwqV+0DSRc0gw6dgXtVgk7Snv0Q0lyHs+Gq2tsvmYhpzo01YFNmBtltGfOJEEyA09ZgKhsEKxW2hRyFgz12zKQrXXfyKpTKex7cXl1fgN9ORWuh865v4yPc1vSSzA4Njo0XpbAnssgSE7c6njPUjmQBLY8vqk+ILiTCWckgSDr+fnJGMKzUw3fdQxged2m2D9EzuKf0Af9bug3d/E2cfuTVtuqYf/T6mGQuBOeBJlPudgWKlfF2EtlVFLMGcYDbZH2SmzjfB43Nxk3Tt3IlsImFZUc8X5RccJqoO8B+qFdo9jeqlhkvRdKVjA0F2SbpwfY3jb/VJs2oGdsFAidHuZq1EItOTd3lUkRRJQz3rinmTAuRI72RtICtcIzQ6qr2Eg6QTwJTMbvhwJWfUtZN+NNm1UmxG6BFjSKD62kNc4oy+qtThn/oG5PH52p7B6IIIZrQFoqMwXCQt0EzA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3721.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e78e0f-8fc8-4d8c-c298-08d853d3d242
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 08:47:30.1761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujPaZ8ICficM6xH/pfnjKBxtYmn5D275fIjsGZXyB6lwoxMO+vFbS9gUCrYmgKdSI3E4cwF7BL5OaifQhXJA+O48MgDAKqHHQ7KEm312rsxdqHPOLNhB8TPjjjH3zDhE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3548
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Tuesday, September 1, 2020 4:11 PM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: kishon@ti.com; vkoul@kernel.org; robh+dt@kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> vadivel.muruganx.ramuthevar@linux.intel.com;
> eswara.kota@linux.intel.com; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH v8 1/3] phy: intel: Rename phy-intel to phy-intel-lgm
>=20
> On Tue, Sep 01, 2020 at 12:41:59PM +0800, Wan Ahmad Zainie wrote:
> > Rename phy-intel-{combo,emmc}.c to phy-intel-lgm-{combo,emmc}.c to
> > make drivers/phy/intel directory more generic for future use.
> >
> > Signed-off-by: Wan Ahmad Zainie
> > <wan.ahmad.zainie.wan.mohamad@intel.com>
>=20
> > Reviewed-by: Ramuthevar Vadivel Murugan
> > <vadivel.muruganx.ramuthevar@linux.intel.com>
>=20
> This shall be one line.

I will fix this in v9.

>=20
> > ---
> >  drivers/phy/intel/Kconfig                              | 10 +++++-----
> >  drivers/phy/intel/Makefile                             |  4 ++--
> >  .../intel/{phy-intel-combo.c =3D> phy-intel-lgm-combo.c} |  0
> >  .../intel/{phy-intel-emmc.c =3D> phy-intel-lgm-emmc.c}   |  0
> >  4 files changed, 7 insertions(+), 7 deletions(-)  rename
> > drivers/phy/intel/{phy-intel-combo.c =3D> phy-intel-lgm-combo.c} (100%)
> > rename drivers/phy/intel/{phy-intel-emmc.c =3D> phy-intel-lgm-emmc.c}
> > (100%)
> >
> > diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
> > index 7b47682a4e0e..db8586c3eed8 100644
> > --- a/drivers/phy/intel/Kconfig
> > +++ b/drivers/phy/intel/Kconfig
> > @@ -1,9 +1,9 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  #
> > -# Phy drivers for Intel Lightning Mountain(LGM) platform
> > +# Phy drivers for Intel platforms
> >  #
> > -config PHY_INTEL_COMBO
> > -	bool "Intel ComboPHY driver"
> > +config PHY_INTEL_LGM_COMBO
> > +	bool "Intel Lightning Mountain ComboPHY driver"
> >  	depends on X86 || COMPILE_TEST
> >  	depends on OF && HAS_IOMEM
> >  	select MFD_SYSCON
> > @@ -16,8 +16,8 @@ config PHY_INTEL_COMBO
> >  	  chipsets which provides PHYs for various controllers, EMAC,
> >  	  SATA and PCIe.
> >
> > -config PHY_INTEL_EMMC
> > -	tristate "Intel EMMC PHY driver"
> > +config PHY_INTEL_LGM_EMMC
> > +	tristate "Intel Lightning Mountain EMMC PHY driver"
> >  	depends on X86 || COMPILE_TEST
> >  	select GENERIC_PHY
> >  	help
> > diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile
> > index 233d530dadde..662385d0a366 100644
> > --- a/drivers/phy/intel/Makefile
> > +++ b/drivers/phy/intel/Makefile
> > @@ -1,3 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -obj-$(CONFIG_PHY_INTEL_COMBO)		+=3D phy-intel-combo.o
> > -obj-$(CONFIG_PHY_INTEL_EMMC)            +=3D phy-intel-emmc.o
> > +obj-$(CONFIG_PHY_INTEL_LGM_COMBO)	+=3D phy-intel-lgm-combo.o
> > +obj-$(CONFIG_PHY_INTEL_LGM_EMMC)	+=3D phy-intel-lgm-emmc.o
> > diff --git a/drivers/phy/intel/phy-intel-combo.c
> > b/drivers/phy/intel/phy-intel-lgm-combo.c
> > similarity index 100%
> > rename from drivers/phy/intel/phy-intel-combo.c
> > rename to drivers/phy/intel/phy-intel-lgm-combo.c
> > diff --git a/drivers/phy/intel/phy-intel-emmc.c
> > b/drivers/phy/intel/phy-intel-lgm-emmc.c
> > similarity index 100%
> > rename from drivers/phy/intel/phy-intel-emmc.c
> > rename to drivers/phy/intel/phy-intel-lgm-emmc.c
> > --
> > 2.17.1
> >
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

