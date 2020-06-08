Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E9CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD1320760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ufPtGrEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgFHKhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:37:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:59291 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729280AbgFHKhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:37:36 -0400
IronPort-SDR: vfdto/nZ3izPumJWcYk4nZETNg1kIsEhJrqYmqraKP+Qq19DekS8p9TI+5FKuUbj2yC0y1ZvR0
 nDo5/w4tQdpQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 03:37:33 -0700
IronPort-SDR: SdICpjyn66NeOygcbfWSz3T5d9SOAP20VjsGmwBQetIXAaZ8F1gmawuyioOc0u/U1RehKs9wNJ
 YPxqzBblVokg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="274175659"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2020 03:37:33 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 8 Jun 2020 03:37:28 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 8 Jun 2020 03:37:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 8 Jun 2020 03:37:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEGAKqIXnkZoaLBXckN/KXps/dEy6YgTW0x288521S0E1Ns5LgyvWR1G7nuI2HKBRXPXzHppziuPRNH1WNancO2MmSM8nszyBVjp4/ELnXLgXlCEnAA3nH7Fr0E3u24G2XwpwNpycj656HoNLo2FWHeztL8zkXDO4Gsauu5LxG9PKyysF7rO/vN9mmb7KjpWm/aaO3+1QcnYhPbpnp0E5/O6lGi6cBGfTpBJbIEX7YI0emvBD5xfPPsZarrgo2zktN+hBECrLCgWRIslyPx46Ec0kNHAqtODo5BdHWBprMhgkJSa/PiCzikZ8PbXtxWdFlync5cHODN0a1hArTJVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zf76xk7nGizlCRTmbi7TswgipcgFcHsx51uVMG+V0Js=;
 b=DC7rw5LGmAF14LeS8cbhBGt7ocx4bPj9W5ZF/IJ1KLKNmiub7hp7yG3Ke9Q69D5LOc4WXQNVGvo/m7P/cIfc898dGNayDOvquyv/rJwd1q9MZ0I6fY+UjFPcwjOo2Y8aDUT7hqBEWKuHrxcMJnv8hANdcdC4VxzO72uIFLIlchatr/VPVNH8pVsjhiFnCZLm6uy/mmO6oL76kmNRqlOTLAg1GkJzy6Rve3VL2EonkcyRpTJefS9apyFGvuvYcuBLkMJgxYaZDUvv2/7NplYBW8rzIM3yT8fbX91oPFkkjL3Lsrl7C81WDOqQt6oJpI3ZYk3C1fvWyazacWfBaddNiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zf76xk7nGizlCRTmbi7TswgipcgFcHsx51uVMG+V0Js=;
 b=ufPtGrENKSgPxRcmTjYZWA4JkvTmn+tbe0gUwvm6cLLyD6HH7W5wdrcLhJQ+ua+kHzTz5HY0p+7kg+dJulQ44tZ3Pmu034LkRKAsZnWy+kzr6fNHN6HNRUfQdp/6IAA8Gn55CA/DFbtTMfV0zR4T0C/Zwc5NTKeEcmu1sAj+X5w=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB3243.namprd11.prod.outlook.com (2603:10b6:5:e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Mon, 8 Jun 2020 10:37:26 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::b0cf:aaa:bc78:e0cc]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::b0cf:aaa:bc78:e0cc%4]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 10:37:25 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>
Subject: RE: [PATCH v3 2/2] phy: intel: Add Keem Bay eMMC PHY support
Thread-Topic: [PATCH v3 2/2] phy: intel: Add Keem Bay eMMC PHY support
Thread-Index: AQHWPW0sjYAQ0wPt5kOikMPhhrn48KjOfn8AgAAFLdA=
Date:   Mon, 8 Jun 2020 10:37:25 +0000
Message-ID: <DM6PR11MB3721F0D18434843D1B074623DD850@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20200608081501.29558-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200608081501.29558-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200608100754.GD2428291@smile.fi.intel.com>
In-Reply-To: <20200608100754.GD2428291@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 250fd440-7eb5-4c85-a346-08d80b97ef82
x-ms-traffictypediagnostic: DM6PR11MB3243:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3243002463935DE02B75D534DD850@DM6PR11MB3243.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aYsWK81Xwf50XbJyKQ8IYV+vl8ATNY70uPhy+UnX43o7jClEouJ6iJSnCfGiphWO3jyVB/7c8kg/wD2uyh0mNBmQXhqiSZOQ2mOjR1ZmrsVoeDXNXsf4LxAv0idTzXBqjtn+QIj4rw1nEXkheY0uGlc9LzcU9mx+U/WmzGo7DEgjnzs2YkthRDtW5/T46Axd2WAeSQXh2BWDvTZ5e6ypdHxWJbzrbQ6Lz2WAu41RYcpVCxRxwpn52+f6pFLcHmX1AdyvbTRFIkdZIL0JI3CaZ6o5nNKjjpsGrF9xsxWg6895+FNM8jfT8AOmIE9cobWITCqbRyo5FuVvyiRm/qCy/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(136003)(376002)(346002)(396003)(9686003)(5660300002)(66446008)(64756008)(55016002)(66556008)(66476007)(66946007)(86362001)(26005)(83380400001)(76116006)(52536014)(186003)(2906002)(4326008)(71200400001)(8676002)(53546011)(54906003)(8936002)(33656002)(478600001)(7696005)(6506007)(6862004)(6636002)(316002)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LWz7xl8pu8k+Jz8VYdUwavxpi4J78DiT9F9NP4/6R/XFuBtybdhSGMcX0pxZ9rMfkV+UWU8/xoIPRsXu1PK47mo/TfVQz7PAYa8JudWwxAk+o3HmCmrb9DaFV88IRBNGHtG0pMJoeYYd0G7IGQagCrpMVCwYK/gU7gjwus3wP2sFKEQBboSh8yG4ixH3xHpgyK2Il2s2TYeilI1I+keyYjah0R/GRd0bgLjEW2RJkgIzvKvI7d8bf8H+ICvQXa5GUl/H2e+BiuCakoUnPWYoSyXmwv+8YjZyCP/zKJaccnGaejJw35wRB4D0R8nQTis14m+NNrzcXbcPvraJqXSwVhmzRGFJ1TUuzzcdqLMo7My/w7//7NHW2AxXbQ/3Aw+4w4pKK5R/rol/l9H7DJ1NsHP1b7X7hdbwK6AxCCX5HTYWPvmp7Gjt3kYJyLRpFTZI+Q7CK18JJr6h889hwv55nA/yWsMhLwuOzWZSXObevWm5PSMKTdvjILWzCqKFnDPf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 250fd440-7eb5-4c85-a346-08d80b97ef82
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 10:37:25.8219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edN3Rb9wpDJMa+7Fav1TJImhBW9JMMNT+SsuE/3xla1gvHkxbA5108JZsx/6RuCsco8oPpZNF6AhYf+ICYXGH3NVYI7+LtLNlSe/KTRcKb1y078pxshnOzBnsXNFU/e9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3243
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shevchenko, Andriy <andriy.shevchenko@intel.com>
> Sent: Monday, June 8, 2020 6:08 PM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: kishon@ti.com; vkoul@kernel.org; robh+dt@kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; Hunter, Adrian
> <adrian.hunter@intel.com>
> Subject: Re: [PATCH v3 2/2] phy: intel: Add Keem Bay eMMC PHY support
>=20
> On Mon, Jun 08, 2020 at 04:15:01PM +0800, Wan Ahmad Zainie wrote:
> > Add support for eMMC PHY on Intel Keem Bay SoC.
>=20
> I think I commented on something already.

I don't recall any. May be on other similar patches.
I will wait for few days before sending next revision, if it is okay with y=
ou.

>=20
> ...
>=20
> > +	if (ret) {
> > +		dev_err(&phy->dev, "dllrdy failed, ret=3D%d\n", ret);
>=20
> > +		return ret;
> > +	}
> > +
> > +	return 0;
>=20
> return ret;

I will change in next revision.

>=20
> ...
>=20
> > +	if (IS_ERR(priv->emmcclk)) {
> > +		dev_err(&phy->dev, "ERROR: getting emmcclk\n");
>=20
> > +		return PTR_ERR(priv->emmcclk);
> > +	}
> > +
> > +	return 0;
>=20
> return PTR_ERR_OR_ZERO(...);

To clarify, I should replace the block above with,
return PTR_ERR_OR_ZERO(priv->emmcclk);

>=20
> ...
>=20
> > +	priv->syscfg =3D devm_regmap_init_mmio(dev, base,
> > +					     &keembay_regmap_config);
>=20
> One line.

I will change in next revision.

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

