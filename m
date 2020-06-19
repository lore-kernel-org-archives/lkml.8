Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE2EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB52920789
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="I3ttIARo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgFSDRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:17:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:4910 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgFSDRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:17:23 -0400
IronPort-SDR: 3cWC1uCusRUXw+XdPVKwwK/lZ4vR0uxrpvSu1U4RVPlVznA70xgFK7RmJ50de0gz9x5YprnaEf
 RVmlh9Onv60w==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="227515639"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="227515639"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 20:17:21 -0700
IronPort-SDR: J2czDg35i0GI4gFKX7GVOI+12EcRtinAoSfRc6lnFbjPfImQwhvN4O9I6+Pug46hM1L8pRRXsQ
 aaEBLuB3ILhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="262196110"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jun 2020 20:17:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jun 2020 20:17:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 18 Jun 2020 20:17:14 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 18 Jun 2020 20:17:14 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 18 Jun 2020 20:17:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icTp0fTjlNnBGhUOu8MQ2jiNqAyw8+O+bIlwwPJBzOwkcBCYi3m4xUdhMN4PKE+mVdOhyX6+EC3SVlGnsL96mwU6/uq74YNjyWZquq1Cklh1swTqBMnNlDW1GLfpMltW6BUC9Zg4vI/hrL2yo74yjqrbpO0+nTJqyhjCNj6gqgrbysXf9uoPjGmV3UnKu/P2BMI5FSIa7VRFEAeJ3fm+0oVOrKIrHRVy3HbhgAuujbEihxE5J1E++v9mBcz7Cwfs/eLjgCkPVhZSsdo0tmEwcJzTLEew9IyrBa2lEzGeBqDiljrzuw2fVTm+JaQtSQGGYVdPlUUDejg8o0RF4XjV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jhBAuhZFwNVVq4J3JznZGaPGoUC2zfjFY+nraAv/wo=;
 b=JAYYkt4vqHcbFNYyN8GzbkzMYJk1tWwKqaFXTGV2Kj0HzHg7yL0xMYvATcf1PKKmksiwu3DZ8WhLFei5k2uoFSOwDoSYcJYF6BYMq8nu9fDxYC5kg1qBMW2PL5FRpp3FxMtllz3GfuWdf+m3W0OXKnu7+syBjK8UpmqVoKuHY7DSmvDP834AsSc1kSJVDwShPj3AWQI158D5w63EiMYLEpcsbrFgJDOOAA0MKlWHKLXnhmmPJiPpRM1MVAZpB1fAzJF4ZEo8thOItWful/7ADLc5KtDwWGHVK6Udt2Ay0PuV/NOmCnc5uHwfL7pzQ5fB5OHHbO3r96jG42xpDn7UbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jhBAuhZFwNVVq4J3JznZGaPGoUC2zfjFY+nraAv/wo=;
 b=I3ttIARoQNzBfnbKv1b7Cm1imMJS+V84NUNXoUtwM348lbvHq3S74QNbKKK4NKF0LCkxHosLlf9f9TdiFw/aYklsa4pkGxIuy+onvmkDsUVzb2x9iO2+IvIVKrct3TWsSSngKoHI64EN2F58RmpgrvbEp0YJwbWuek8mfOzhmH0=
Received: from BN8PR11MB3714.namprd11.prod.outlook.com (2603:10b6:408:90::17)
 by BN8PR11MB3650.namprd11.prod.outlook.com (2603:10b6:408:8f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 03:17:12 +0000
Received: from BN8PR11MB3714.namprd11.prod.outlook.com
 ([fe80::c462:edcc:5bf9:d9d5]) by BN8PR11MB3714.namprd11.prod.outlook.com
 ([fe80::c462:edcc:5bf9:d9d5%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 03:17:11 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>
Subject: RE: [RESEND v5 2/2] phy: intel: Add Keem Bay eMMC PHY support
Thread-Topic: [RESEND v5 2/2] phy: intel: Add Keem Bay eMMC PHY support
Thread-Index: AQHWRDbBVsPZ7u2QR0WoLoLVFp01IKjc1xCAgAJuGcA=
Date:   Fri, 19 Jun 2020 03:17:11 +0000
Message-ID: <BN8PR11MB37143C5A4C98BF28C521B838DD980@BN8PR11MB3714.namprd11.prod.outlook.com>
References: <20200616233252.15619-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200616233252.15619-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200617140107.GF2428291@smile.fi.intel.com>
In-Reply-To: <20200617140107.GF2428291@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad352e88-b771-4e93-c0c9-08d813ff41ad
x-ms-traffictypediagnostic: BN8PR11MB3650:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR11MB36509555C81B34466EFE8A88DD980@BN8PR11MB3650.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KSOh7GnUFLKNgTx8IF+lbXDIc+PYp+yTInjZA80bnG1p66QHypyBe/idJxSGLqsrvtyddBHnQ8kDLGeV0KRG48kJ1iOO6Dh+YSl3gtgxNATOzeGAU00Tjw+DTbyV8o6TifIknpzznkNXdzS9crZn+X+1r8Eqbqk91qkRPumlCmbhvXjNlDM2SMZ8kzQTGc7UQ2DKZwvz73/utlQHDYH/zbFotu/rd2c8d6eqgGQ15eLj59NwfdoqG8ZIBc75ZUQf7lH5pMV3Fc6YkezEsZtl/H72OzWCg8EOSRr6OyYymMdOgxwS3C7gVbp7z2OadpG/X4x7HZqr4PY493WnhW1olA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3714.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(8676002)(5660300002)(2906002)(71200400001)(52536014)(8936002)(478600001)(6636002)(4326008)(55016002)(9686003)(316002)(107886003)(54906003)(6862004)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(7696005)(186003)(33656002)(26005)(53546011)(6506007)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: D0HSCvUPm2YF082ZW79A9kD9w9yd9+pl6y4Fd/ryKxF1GJpNnizRZceiotb3wEq30SBApeN6xOi9eOMwlel2nX1sS0ZL4IxzAdGtKAriAjXQCfkLlrsDylZIhF74LjRmqyC5Z5PsxxL71sSNOXs33UFeNuX7cjPFoO1l0iZs/4eaMd5PQgQwS6GPNVUvslsP5YyN29x9tiqoDLXI3Porg58JqApyZg/kPVGT2qj1sPY1l/o268lB8IJ3/DxgTxiZAUeosskrEiq3zhbXBUuzd9xp10IgrrJ8j4bPZsudrnGE4ziAB0uSluYtVVUhv0b7ZeLhOoQPgi1qy38kMUiIRPOSo+EXwDZ39bRoR6WXtQTrkiN7t7tGDV44hjS5GSEBhFij6UnM2Bl4cAEpw2R/drh3/YWhKKYSyVVPdIeF+3Y0Ae2yIaVefi4Bdm2CDENjynuFXH01KSHGJ8fRCAS1Kn7kgZM1X9UZEAorUcCDq0MgwuJRxeznqZh4Edma00Aq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ad352e88-b771-4e93-c0c9-08d813ff41ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 03:17:11.1609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHtdBZveAlbw4z34onecPlRW45Hz9+ZEe/By4TXMyid3S9cTWU3Q7Mv7llb442+idWOpe5REMbhfVAoGu5IRJkdoEWTQKX8W5I0mhMC/nVIW+RCCWZZYo5Pq/wZUwVXh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3650
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shevchenko, Andriy <andriy.shevchenko@intel.com>
> Sent: Wednesday, June 17, 2020 10:01 PM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: kishon@ti.com; vkoul@kernel.org; robh+dt@kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; Hunter, Adrian
> <adrian.hunter@intel.com>
> Subject: Re: [RESEND v5 2/2] phy: intel: Add Keem Bay eMMC PHY support
>=20
> On Wed, Jun 17, 2020 at 07:32:52AM +0800, Wan Ahmad Zainie wrote:
> > Add support for eMMC PHY on Intel Keem Bay SoC.
>=20
> ...
>=20
> > +	ret =3D regmap_read_poll_timeout(priv->syscfg, PHY_STAT,
> > +				       dllrdy, IS_DLLRDY(dllrdy),
> > +				       0, 50 * USEC_PER_MSEC);
> > +	if (ret) {
> > +		dev_err(&phy->dev, "dllrdy failed, ret=3D%d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	return ret;
> > +}
>=20
> This has no changes.
>=20
> Are you sure the version is correct?

Ah. Sorry Andy. I misunderstood your earlier review comment.
You mean return inside the last if(...) should be discarded.

Kishon, should I send another version, or is it acceptable?

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

